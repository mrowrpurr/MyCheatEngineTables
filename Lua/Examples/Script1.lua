local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local Script1 = __TS__Class()
Script1.name = "Script1"
function Script1.prototype.____constructor(self)
    print("Hello! I'm Script1 constructor")
end
function Script1.prototype.enable(self)
    print("Hello! I'm Script1 enable")
end
function Script1.prototype.disable(self)
    print("Hello! I'm Script1 disable")
end
local script = __TS__New(Script1)
function ____exports.enable(self)
    script:enable()
end
function ____exports.disable(self)
    script:disable()
end
return ____exports
