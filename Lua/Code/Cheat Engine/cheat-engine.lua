local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SetDescriptor = ____lualib.__TS__SetDescriptor
local __TS__New = ____lualib.__TS__New
local ____exports = {}
____exports.Registers = __TS__Class()
local Registers = ____exports.Registers
Registers.name = "Registers"
function Registers.prototype.____constructor(self)
end
__TS__SetDescriptor(
    Registers.prototype,
    "eax",
    {get = function(self)
        return EAX == nil and 0 or EAX
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "ebx",
    {get = function(self)
        return EBX == nil and 0 or EBX
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "ecx",
    {get = function(self)
        return ECX == nil and 0 or ECX
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "edx",
    {get = function(self)
        return EDX == nil and 0 or EDX
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "esi",
    {get = function(self)
        return ESI == nil and 0 or ESI
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "edi",
    {get = function(self)
        return EDI == nil and 0 or EDI
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "ebp",
    {get = function(self)
        return EBP == nil and 0 or EBP
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "esp",
    {get = function(self)
        return ESP == nil and 0 or ESP
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "eip",
    {get = function(self)
        return EIP == nil and 0 or EIP
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "fp0",
    {get = function(self)
        return byteTableToExtended(FP0)
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "fp1",
    {get = function(self)
        return byteTableToExtended(FP1)
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "fp2",
    {get = function(self)
        return byteTableToExtended(FP2)
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "fp3",
    {get = function(self)
        return byteTableToExtended(FP3)
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "fp4",
    {get = function(self)
        return byteTableToExtended(FP4)
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "fp5",
    {get = function(self)
        return byteTableToExtended(FP5)
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "fp6",
    {get = function(self)
        return byteTableToExtended(FP6)
    end},
    true
)
__TS__SetDescriptor(
    Registers.prototype,
    "fp7",
    {get = function(self)
        return byteTableToExtended(FP7)
    end},
    true
)
____exports.Debugger = __TS__Class()
local Debugger = ____exports.Debugger
Debugger.name = "Debugger"
function Debugger.prototype.____constructor(self)
end
function Debugger.prototype.isDebugging(self)
    return debug_isDebugging()
end
function Debugger.prototype.hasRegisters(self)
    return EAX ~= nil
end
function Debugger.prototype.getRegisters(self, includeFloats)
    if includeFloats == nil then
        includeFloats = true
    end
    if includeFloats then
        debug_getContext(true)
    end
    return self:hasRegisters() and __TS__New(____exports.Registers) or nil
end
function ____exports.getDebugger()
    return __TS__New(____exports.Debugger)
end
function ____exports.clearLogWindow()
    getLuaEngine().MenuItem5.doClick()
end
function ____exports.showLogWindow()
    getLuaEngine().show()
end
return ____exports
