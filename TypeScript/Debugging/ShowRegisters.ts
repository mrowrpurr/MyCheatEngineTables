import { getDebugger } from "@cheat-engine"
import { findFormFromCaption, getAddressString, getValueDebugString } from "@common"
import { TextOutput } from "Forms/TextOutput"

const FORM_CAPTION = "Registers"

export let timerEnabled = false
export let textOutput: TextOutput | undefined = undefined

function appendText(text: string) {
    if (textOutput === undefined) return
    textOutput.appendLine(text)
}

function showRegister(registerName: string, registerValue: number) {
    appendText(
        `${registerName}\t ${getAddressString(registerValue)}\t ${getValueDebugString(
            registerValue
        )}`
    )
}

function showFloatRegister(registerName: string, registerValue: number) {
    const floatString = registerValue.toString()
    if (floatString.includes("nan")) return appendText(registerName)
    appendText(`${registerName}: ${floatString}`)
}

function showRegisters(includeFloats: boolean = true) {
    if (textOutput === undefined) return
    textOutput.clear()

    if (EAX === undefined) return

    showRegister("EAX", EAX)
    showRegister("EBX", EBX!)
    showRegister("ECX", ECX!)
    showRegister("EDX", EDX!)
    showRegister("ESI", ESI!)
    showRegister("EDI", EDI!)
    showRegister("EBP", EBP!)
    showRegister("ESP", ESP!)
    showRegister("EIP", EIP!)

    if (includeFloats) {
        appendText("")
        const registers = getDebugger().getRegisters()!
        showFloatRegister("FP0", registers.fp0)
        showFloatRegister("FP1", registers.fp1)
        showFloatRegister("FP2", registers.fp2)
        showFloatRegister("FP3", registers.fp3)
        showFloatRegister("FP4", registers.fp4)
        showFloatRegister("FP5", registers.fp5)
        showFloatRegister("FP6", registers.fp6)
        showFloatRegister("FP7", registers.fp7)
    }
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
        if (timerEnabled) showRegisters()
    }
    timer.enabled = true
    textOutput.show()
}

export function enable() {
    timerEnabled = !timerEnabled
    setupTextOutput()
    showRegisters()
    if (textOutput) textOutput.show()
}

export function disable() {}
