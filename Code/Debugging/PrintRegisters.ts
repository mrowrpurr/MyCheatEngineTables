import { clearLogWindow, getDebugger } from "@cheat-engine"
import { getAddressString, getValueDebugString } from "@common"

function printRegister(registerName: string, registerValue: number) {
    print(
        `${registerName}\t ${getAddressString(registerValue)}\t ${getValueDebugString(
            registerValue
        )}`
    )
}

function printFloatRegister(registerName: string, registerValue: number) {
    const floatString = registerValue.toString()
    if (floatString.includes("nan")) return print(registerName)
    print(`${registerName}: ${floatString}`)
}

function printRegisters(includeFloats: boolean = true) {
    if (EAX === undefined) return

    printRegister("EAX", EAX)
    printRegister("EBX", EBX!)
    printRegister("ECX", ECX!)
    printRegister("EDX", EDX!)
    printRegister("ESI", ESI!)
    printRegister("EDI", EDI!)
    printRegister("EBP", EBP!)
    printRegister("ESP", ESP!)
    printRegister("EIP", EIP!)

    if (includeFloats) {
        print("")
        const registers = getDebugger().getRegisters()!
        printFloatRegister("FP0", registers.fp0)
        printFloatRegister("FP1", registers.fp1)
        printFloatRegister("FP2", registers.fp2)
        printFloatRegister("FP3", registers.fp3)
        printFloatRegister("FP4", registers.fp4)
        printFloatRegister("FP5", registers.fp5)
        printFloatRegister("FP6", registers.fp6)
        printFloatRegister("FP7", registers.fp7)
    }
}

export function enable() {
    clearLogWindow()
    printRegisters()
}

export function disable() {}
