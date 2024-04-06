local ____lualib = require("lualib_bundle")
local __TS__NumberToString = ____lualib.__TS__NumberToString
local __TS__StringPadStart = ____lualib.__TS__StringPadStart
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
function ____exports.hex(int)
    return __TS__NumberToString(int, 16)
end
function ____exports.getAddress(addressString)
    local address = getAddressList().getMemoryRecordByDescription(addressString)
    if address == nil then
        print("Address not found: " .. addressString)
    end
    return address and address.CurrentAddress
end
--- Return padded hex string of address
-- 
-- @param address
-- @param padding
-- @returns
function ____exports.getAddressString(address, padding)
    if padding == nil then
        padding = 8
    end
    return __TS__StringPadStart(
        string.upper(__TS__NumberToString(address, 16)),
        padding,
        "0"
    )
end
--- `readFloat` but returns undefined for non-simple floats (e.g. NaN, Infinity)
-- 
-- @param address
-- @returns
function ____exports.readSimpleFloat(address)
    local floatString = tostring(readFloat(address))
    if __TS__StringIncludes(floatString, "e") then
        return nil
    end
    if __TS__StringIncludes(floatString, "nan") then
        return nil
    end
    return floatString
end
--- Get a debug string for a value. If the value is a pointer, it will recursively print the value at the address.
-- 
-- @param value
-- @param pointerDepth
-- @returns
function ____exports.getValueDebugString(value, pointerDepth)
    if pointerDepth == nil then
        pointerDepth = 2
    end
    local valueAtAddress = readPointer(value)
    if valueAtAddress == nil or valueAtAddress == 0 then
        return tostring(value)
    end
    local floatAtAddress = ____exports.readSimpleFloat(value)
    if getAddressSafe(valueAtAddress) == nil then
        return floatAtAddress or tostring(valueAtAddress)
    end
    local pointerDebugString = ""
    if pointerDepth > 0 and valueAtAddress ~= 0 then
        pointerDebugString = "\t --> \t " .. ____exports.getValueDebugString(valueAtAddress, pointerDepth - 1)
    end
    local rttiClassName = getRTTIClassName(value)
    if rttiClassName ~= nil then
        return (((____exports.getAddressString(valueAtAddress) .. " (") .. rttiClassName) .. ")") .. pointerDebugString
    end
    return ____exports.getAddressString(valueAtAddress) .. pointerDebugString
end
--- Given a caption, find the form with that caption (else return undefined)
-- 
-- @param captionText
-- @returns CheatEngine.Form | undefined
function ____exports.findFormFromCaption(captionText)
    local formCount = getFormCount()
    do
        local i = 0
        while i < formCount do
            local form = getForm(i)
            if form.caption == captionText then
                return form
            end
            i = i + 1
        end
    end
    return nil
end
return ____exports
