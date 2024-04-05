local ____lualib = require("lualib_bundle")
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__NumberToString = ____lualib.__TS__NumberToString
local __TS__StringPadStart = ____lualib.__TS__StringPadStart
local ____exports = {}
local _____40cheat_2Dengine = require("Code.Cheat Engine.cheat-engine")
local clearLogWindow = _____40cheat_2Dengine.clearLogWindow
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
function ____exports.getValueDebugString(value, pointerDepth)
    return "TODO"
end
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
function ____exports.printRegister(registerName, registerValue)
    local valueAtAddress = readPointer(registerValue)
    if valueAtAddress == nil then
        print((registerName .. ": ") .. tostring(registerValue))
        return
    end
    print((((registerName .. ": ") .. ____exports.getAddressString(registerValue)) .. " -> ") .. ____exports.getAddressString(valueAtAddress))
end
function ____exports.printRegisters()
    if EAX == nil then
        return
    end
    ____exports.printRegister("EAX", EAX)
    ____exports.printRegister("EBX", EBX)
    ____exports.printRegister("ECX", ECX)
    ____exports.printRegister("EDX", EDX)
    ____exports.printRegister("ESI", ESI)
    ____exports.printRegister("EDI", EDI)
    ____exports.printRegister("EBP", EBP)
    ____exports.printRegister("ESP", ESP)
    ____exports.printRegister("EIP", EIP)
end
function ____exports.enable()
    clearLogWindow()
    ____exports.printRegisters()
end
function ____exports.disable()
end
return ____exports
