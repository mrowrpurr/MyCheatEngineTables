local ____lualib = require("lualib_bundle")
local __TS__NumberToString = ____lualib.__TS__NumberToString
local __TS__StringPadStart = ____lualib.__TS__StringPadStart
local ____exports = {}
local _____40cheat_2Dengine = require("Code.Cheat Engine.cheat-engine")
local clearLogWindow = _____40cheat_2Dengine.clearLogWindow
local _____40common = require("Code.common")
local getAddressString = _____40common.getAddressString
local getValueDebugString = _____40common.getValueDebugString
local function printStackOffset(offset)
    if ESP == nil then
        return false
    end
    local address = ESP + offset
    if getAddressSafe(address) == nil then
        return false
    end
    local pointerValue = readPointer(address)
    if pointerValue == nil then
        return false
    end
    local addressString = getAddressString(address)
    local offsetString = getAddressString(offset, 3)
    local valueString = getValueDebugString(address)
    print((((addressString .. "   0x") .. offsetString) .. ": \t ") .. valueString)
    return true
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
            if not printStackOffset(i * 4) then
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
