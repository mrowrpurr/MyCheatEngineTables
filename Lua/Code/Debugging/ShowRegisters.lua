local ____lualib = require("lualib_bundle")
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local _____40cheat_2Dengine = require("Code.Cheat Engine.cheat-engine")
local getDebugger = _____40cheat_2Dengine.getDebugger
local _____40common = require("Code.common")
local getAddressString = _____40common.getAddressString
local getValueDebugString = _____40common.getValueDebugString
local ____TextOutput = require("Code.Forms.TextOutput")
local TextOutput = ____TextOutput.TextOutput
____exports.textOutput = nil
local function appendText(text)
    if ____exports.textOutput == nil then
        return
    end
    ____exports.textOutput:appendLine(text)
end
local function showRegister(registerName, registerValue)
    appendText((((registerName .. "\t ") .. getAddressString(registerValue)) .. "\t ") .. getValueDebugString(registerValue))
end
local function showFloatRegister(registerName, registerValue)
    local floatString = tostring(registerValue)
    if __TS__StringIncludes(floatString, "nan") then
        return appendText(registerName)
    end
    appendText((registerName .. ": ") .. floatString)
end
local function showRegisters(includeFloats)
    if includeFloats == nil then
        includeFloats = true
    end
    print("Showing registers... ?")
    if EAX == nil then
        return
    end
    print("Yes, there ARE some registers...")
    showRegister("EAX", EAX)
    showRegister("EBX", EBX)
    showRegister("ECX", ECX)
    showRegister("EDX", EDX)
    showRegister("ESI", ESI)
    showRegister("EDI", EDI)
    showRegister("EBP", EBP)
    showRegister("ESP", ESP)
    showRegister("EIP", EIP)
    if includeFloats then
        appendText("")
        local registers = getDebugger():getRegisters()
        showFloatRegister("FP0", registers.fp0)
        showFloatRegister("FP1", registers.fp1)
        showFloatRegister("FP2", registers.fp2)
        showFloatRegister("FP3", registers.fp3)
        showFloatRegister("FP4", registers.fp4)
        showFloatRegister("FP5", registers.fp5)
        showFloatRegister("FP6", registers.fp6)
        showFloatRegister("FP7", registers.fp7)
    end
    print("SHOW!")
    local ____opt_0 = ____exports.textOutput
    if ____opt_0 ~= nil then
        ____exports.textOutput:show()
    end
end
function ____exports.enable()
    print("enable()")
    if ____exports.textOutput == nil then
        print("!!!! Creating text output! Because it's UNDEFINED!")
        ____exports.textOutput = __TS__New(TextOutput, "Registers")
        print("Text output created")
        print("Setting onClose")
        ____exports.textOutput:onClose(function() return print("Text output closed") end)
        print("Text output created")
        local ____ = _G
    end
    print("Showing registers...")
    ____exports.textOutput:clear()
    showRegisters()
end
function ____exports.disable()
end
return ____exports
