local ____lualib = require("lualib_bundle")
local __TS__NumberToString = ____lualib.__TS__NumberToString
local __TS__StringPadStart = ____lualib.__TS__StringPadStart
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
local _____40cheat_2Dengine = require("Code.Cheat Engine.cheat-engine")
local clearLogWindow = _____40cheat_2Dengine.clearLogWindow
function ____exports.printAddress(address)
    local addressString = __TS__StringPadStart(
        string.upper(__TS__NumberToString(address, 16)),
        8,
        "0"
    )
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
    local asPointer = asInteger and getAddressSafe(asInteger) and readPointer(asInteger) or nil
    local ____temp_4
    if asPointer == nil then
        ____temp_4 = nil
    else
        ____temp_4 = __TS__StringPadStart(
            string.upper(__TS__NumberToString(asPointer, 16)),
            8,
            "0"
        )
    end
    local pointerAddressString = ____temp_4
    local output = addressString
    if asInteger ~= nil then
        if asPointer ~= nil then
            output = output .. " \t* " .. tostring(pointerAddressString)
            output = output .. (" \t[" .. tostring(asInteger)) .. "]"
            if asFloat ~= nil then
                output = output .. (" \t(" .. tostring(asFloat)) .. ")"
            end
        else
            output = output .. ": \t" .. tostring(asInteger)
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
        items = 10
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
            if not ____exports.printAddress(ESP + i * 4) then
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
