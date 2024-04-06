local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SetDescriptor = ____lualib.__TS__SetDescriptor
local ____exports = {}
local TEXT_OUTPUT_FORM_FILE = "Forms/TextOutput.FRM"
____exports.TextOutput = __TS__Class()
local TextOutput = ____exports.TextOutput
TextOutput.name = "TextOutput"
function TextOutput.prototype.____constructor(self, form)
    self._form = form and form or createFormFromFile(TEXT_OUTPUT_FORM_FILE)
end
function TextOutput.prototype.clear(self)
    self._form.memoContents.lines.clear()
end
function TextOutput.prototype.append(self, value)
    self._form.memoContents.append(value)
end
function TextOutput.prototype.appendLine(self, value)
    self._form.memoContents.append(value .. "\n")
end
function TextOutput.prototype.show(self)
    self._form.show()
end
function TextOutput.prototype.hide(self)
    self._form.hide()
end
__TS__SetDescriptor(
    TextOutput.prototype,
    "form",
    {get = function(self)
        return self._form
    end},
    true
)
__TS__SetDescriptor(
    TextOutput.prototype,
    "title",
    {set = function(self, value)
        self._form.caption = value
        self._form.lblTitle.caption = value
    end},
    true
)
__TS__SetDescriptor(
    TextOutput.prototype,
    "contents",
    {set = function(self, value)
        self._form.memoContents.lines.text = value
    end},
    true
)
return ____exports
