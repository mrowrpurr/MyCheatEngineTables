local ____lualib = require("lualib_bundle")
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
local _____40cheat_2Dengine = require("Code.Cheat Engine.cheat-engine")
local clearLogWindow = _____40cheat_2Dengine.clearLogWindow
local getDebugger = _____40cheat_2Dengine.getDebugger
local _____40common = require("Code.common")
local getAddressString = _____40common.getAddressString
local getValueDebugString = _____40common.getValueDebugString
local function printRegister(registerName, registerValue)
    print((((registerName .. "\t ") .. getAddressString(registerValue)) .. "\t ") .. getValueDebugString(registerValue))
end
local function printFloatRegister(registerName, registerValue)
    local floatString = tostring(registerValue)
    if __TS__StringIncludes(floatString, "nan") then
        return print(registerName)
    end
    print((registerName .. ": ") .. floatString)
end
local function printRegisters(includeFloats)
    if includeFloats == nil then
        includeFloats = true
    end
    if EAX == nil then
        return
    end
    printRegister("EAX", EAX)
    printRegister("EBX", EBX)
    printRegister("ECX", ECX)
    printRegister("EDX", EDX)
    printRegister("ESI", ESI)
    printRegister("EDI", EDI)
    printRegister("EBP", EBP)
    printRegister("ESP", ESP)
    printRegister("EIP", EIP)
    if includeFloats then
        print("")
        local registers = getDebugger():getRegisters()
        printFloatRegister("FP0", registers.fp0)
        printFloatRegister("FP1", registers.fp1)
        printFloatRegister("FP2", registers.fp2)
        printFloatRegister("FP3", registers.fp3)
        printFloatRegister("FP4", registers.fp4)
        printFloatRegister("FP5", registers.fp5)
        printFloatRegister("FP6", registers.fp6)
        printFloatRegister("FP7", registers.fp7)
    end
end
function ____exports.enable()
    clearLogWindow()
    printRegisters()
end
function ____exports.disable()
end
return ____exports
