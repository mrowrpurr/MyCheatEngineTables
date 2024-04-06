local ____lualib = require("lualib_bundle")
local __TS__NumberToString = ____lualib.__TS__NumberToString
local __TS__StringPadStart = ____lualib.__TS__StringPadStart
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local _____40common = require("Code.common")
local findFormFromCaption = _____40common.findFormFromCaption
local getAddressString = _____40common.getAddressString
local getValueDebugString = _____40common.getValueDebugString
local ____TextOutput = require("Code.Forms.TextOutput")
local TextOutput = ____TextOutput.TextOutput
local FORM_CAPTION = "Stack (ESP)"
____exports.textOutput = nil
local function appendText(text)
    if ____exports.textOutput == nil then
        return
    end
    ____exports.textOutput:appendLine(text)
end
local function showStackOffset(offset)
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
    appendText((((addressString .. "   0x") .. offsetString) .. ": \t ") .. valueString)
    return true
end
function ____exports.showTopOfStack(items)
    if items == nil then
        items = 30
    end
    if ____exports.textOutput == nil then
        return
    end
    ____exports.textOutput:clear()
    if ESP == nil then
        return
    end
    appendText("Top of stack: ESP = " .. __TS__StringPadStart(
        string.upper(__TS__NumberToString(ESP, 16)),
        8,
        "0"
    ))
    do
        local i = 0
        while i < items do
            if not showStackOffset(i * 4) then
                break
            end
            i = i + 1
        end
    end
end
local function setupTextOutput()
    local existingForm = findFormFromCaption(FORM_CAPTION)
    if existingForm then
        ____exports.textOutput = __TS__New(TextOutput, existingForm)
        return
    end
    ____exports.textOutput = __TS__New(TextOutput)
    ____exports.textOutput.title = FORM_CAPTION
    local timer = createTimer(____exports.textOutput.form)
    timer.interval = 1000
    timer.onTimer = function()
        ____exports.showTopOfStack()
    end
    timer.enabled = true
end
function ____exports.enable()
    setupTextOutput()
    ____exports.showTopOfStack()
    if ____exports.textOutput then
        ____exports.textOutput:show()
    end
end
function ____exports.disable()
end
return ____exports
