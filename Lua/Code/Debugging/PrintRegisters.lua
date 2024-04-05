local ____lualib = require("lualib_bundle")
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
local _____40cheat_2Dengine = require("Code.Cheat Engine.cheat-engine")
local clearLogWindow = _____40cheat_2Dengine.clearLogWindow
local getDebugger = _____40cheat_2Dengine.getDebugger
local _____40common = require("Code.common")
local getAddressString = _____40common.getAddressString
local readSimpleFloat = _____40common.readSimpleFloat
function ____exports.getValueDebugString(value, pointerDepth)
    if pointerDepth == nil then
        pointerDepth = 2
    end
    local valueAtAddress = readPointer(value)
    if valueAtAddress == nil or valueAtAddress == 0 then
        return tostring(value)
    end
    local floatAtAddress = readSimpleFloat(value)
    if getAddressSafe(valueAtAddress) == nil then
        return floatAtAddress or tostring(valueAtAddress)
    end
    local pointerDebugString = ""
    if pointerDepth > 0 and valueAtAddress ~= 0 then
        pointerDebugString = "\t\t " .. ____exports.getValueDebugString(valueAtAddress, pointerDepth - 1)
    end
    local rttiClassName = getRTTIClassName(value)
    if rttiClassName ~= nil then
        return (((("-> " .. getAddressString(valueAtAddress)) .. " (") .. rttiClassName) .. ")") .. pointerDebugString
    end
    return ("-> " .. getAddressString(valueAtAddress)) .. pointerDebugString
end
function ____exports.printRegister(registerName, registerValue)
    print((((registerName .. "\t ") .. getAddressString(registerValue)) .. "\t ") .. ____exports.getValueDebugString(registerValue))
end
function ____exports.printFloatRegister(registerName, registerValue)
    local floatString = tostring(registerValue)
    if __TS__StringIncludes(floatString, "nan") then
        return print(registerName)
    end
    print((registerName .. ": ") .. floatString)
end
function ____exports.printRegisters(includeFloats)
    if includeFloats == nil then
        includeFloats = true
    end
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
    if includeFloats then
        print("")
        local registers = getDebugger():getRegisters()
        ____exports.printFloatRegister("FP0", registers.fp0)
        ____exports.printFloatRegister("FP1", registers.fp1)
        ____exports.printFloatRegister("FP2", registers.fp2)
        ____exports.printFloatRegister("FP3", registers.fp3)
        ____exports.printFloatRegister("FP4", registers.fp4)
        ____exports.printFloatRegister("FP5", registers.fp5)
        ____exports.printFloatRegister("FP6", registers.fp6)
        ____exports.printFloatRegister("FP7", registers.fp7)
    end
end
function ____exports.enable()
    clearLogWindow()
    ____exports.printRegisters()
end
function ____exports.disable()
end
return ____exports
