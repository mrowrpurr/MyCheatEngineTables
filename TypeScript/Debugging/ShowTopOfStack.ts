import { findFormFromCaption, getAddressString, getValueDebugString } from "@common"
import { TextOutput } from "Forms/TextOutput"

const FORM_CAPTION = "Stack (ESP)"

export let timerEnabled = false
export let textOutput: TextOutput | undefined = undefined

function appendText(text: string) {
    if (textOutput === undefined) return
    textOutput.appendLine(text)
}

function showStackOffset(offset: number) {
    if (ESP === undefined) return false

    const address = ESP + offset

    if (getAddressSafe(address) === undefined) return false

    const pointerValue = readPointer(address)
    if (pointerValue === undefined) return false

    const addressString = getAddressString(address)
    const offsetString = getAddressString(offset, 3)
    const valueString = getValueDebugString(address)

    appendText(`${addressString}   0x${offsetString}: \t ${valueString}`)

    return true
}

export function showTopOfStack(items: number = 30) {
    if (textOutput === undefined) return
    textOutput.clear()

    if (ESP === undefined) return

    appendText(`Top of stack: ESP = ${ESP.toString(16).toUpperCase().padStart(8, "0")}`)
    for (let i = 0; i < items; i++) if (!showStackOffset(i * 0x4)) break
}

function setupTextOutput() {
    const existingForm = findFormFromCaption(FORM_CAPTION)
    if (existingForm) {
        textOutput = new TextOutput(existingForm)
        return
    }

    textOutput = new TextOutput()
    textOutput.title = FORM_CAPTION
    const timer = createTimer(textOutput.form)
    timer.interval = 1000
    timer.onTimer = () => {
        if (timerEnabled) showTopOfStack()
    }
    timer.enabled = true
}

export function enable() {
    timerEnabled = !timerEnabled
    setupTextOutput()
    showTopOfStack()
    if (textOutput) textOutput.show()
}

export function disable() {}
