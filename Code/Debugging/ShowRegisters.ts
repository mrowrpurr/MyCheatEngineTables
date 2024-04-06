import { getDebugger } from "@cheat-engine"
import { getAddressString, getValueDebugString } from "@common"
import { TextOutput } from "Code/Forms/TextOutput"

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
    print("Showing registers... ?")
    if (EAX === undefined) return
    print("Yes, there ARE some registers...")

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

    print("SHOW!")
    textOutput?.show()
}

export function enable() {
    print("enable()")
    if (textOutput === undefined) {
        print("!!!! Creating text output! Because it's UNDEFINED!")
        textOutput = new TextOutput("Registers")
        print("Text output created")
        print("Setting onClose")
        textOutput.onClose(() => print("Text output closed"))
        // textOutput.onClose(() => (textOutput = undefined))
        print("Text output created")
        _G
    }
    print("Showing registers...")
    // textOutput.show()
    textOutput.clear()
    showRegisters()
}

export function disable() {}
