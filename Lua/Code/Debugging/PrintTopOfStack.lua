local ____lualib = require("lualib_bundle")
local __TS__NumberToString = ____lualib.__TS__NumberToString
local __TS__StringPadStart = ____lualib.__TS__StringPadStart
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
local _____40cheat_2Dengine = require("Code.Cheat Engine.cheat-engine")
local clearLogWindow = _____40cheat_2Dengine.clearLogWindow
function ____exports.printStackOffset(offset)
    if ESP == nil then
        return false
    end
    local offsetString = __TS__StringPadStart(
        string.upper(__TS__NumberToString(offset, 16)),
        3,
        "0"
    )
    local address = ESP + offset
    local isSafe = getAddressSafe(address) ~= nil
    local asInteger = isSafe and readInteger(address) or nil
    local asFloat = isSafe and readFloat(address) or nil
    local ____opt_0 = asFloat
    if ____opt_0 ~= nil then
        local ____opt_1 = asFloat
        ____opt_0 = __TS__StringIncludes(
            ____opt_1 and tostring(asFloat),
            "e"
        )
    end
    if ____opt_0 then
        asFloat = nil
    end
    local ____opt_4 = asFloat
    if ____opt_4 ~= nil then
        local ____opt_5 = asFloat
        ____opt_4 = __TS__StringIncludes(
            ____opt_5 and tostring(asFloat),
            "nan"
        )
    end
    if ____opt_4 then
        asFloat = nil
    end
    if asInteger == 0 then
        asFloat = nil
    end
    local asPointer = asInteger and getAddressSafe(asInteger) and readPointer(asInteger) or nil
    local ____temp_8
    if asPointer == nil then
        ____temp_8 = nil
    else
        ____temp_8 = __TS__StringPadStart(
            string.upper(__TS__NumberToString(asPointer, 16)),
            8,
            "0"
        )
    end
    local pointerAddressString = ____temp_8
    local ____temp_9
    if asPointer and asInteger then
        ____temp_9 = getRTTIClassName(asInteger)
    else
        ____temp_9 = nil
    end
    local rttiClassName = ____temp_9
    local ____opt_10 = asInteger
    if ____opt_10 ~= nil then
        local ____opt_11 = asInteger
        if ____opt_11 ~= nil then
            local ____opt_12 = asInteger
            ____opt_11 = string.upper(____opt_12 and __TS__NumberToString(asInteger, 16))
        end
        ____opt_10 = __TS__StringPadStart(____opt_11, 8, "0")
    end
    local asIntegerAddressString = ____opt_10
    local output = "0x" .. offsetString
    if asInteger ~= nil then
        if asPointer ~= nil then
            output = output .. ((" \t" .. tostring(asIntegerAddressString)) .. " \t-> ") .. tostring(pointerAddressString)
            if rttiClassName ~= nil then
                output = output .. (" \t(" .. rttiClassName) .. ")"
            end
        else
            output = output .. " \t" .. tostring(asInteger)
            if asFloat ~= nil then
                output = output .. (" \t(" .. tostring(asFloat)) .. ")"
            end
        end
    end
    print(output)
    return asInteger ~= nil
end
function ____exports.printTopOfStack(items)
    if items == nil then
        items = 30
    end
    if ESP == nil then
        return
    end
    print("Top of stack: ESP = " .. __TS__StringPadStart(
        string.upper(__TS__NumberToString(ESP, 16)),
        8,
        "0"
    ))
    do
        local i = 0
        while i < items do
            if not ____exports.printStackOffset(i * 4) then
                break
            end
            i = i + 1
        end
    end
end
function ____exports.enable()
    clearLogWindow()
    ____exports.printTopOfStack()
end
function ____exports.disable()
end
return ____exports
