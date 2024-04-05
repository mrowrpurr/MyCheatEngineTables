import { clearLogWindow } from "@cheat-engine"

export function getAddressString(address: number, padding: number = 8) {
    return address.toString(16).toUpperCase().padStart(padding, "0")
}

export function readSimpleFloat(address: number) {
    const floatString = readFloat(address).toString()
    if (floatString.includes("e")) return undefined
    if (floatString.includes("nan")) return undefined
    return floatString
}

export function getValueDebugString(value: number, pointerDepth: number = 2) {
    const valueAtAddress = readPointer(value)
    if (valueAtAddress === undefined || valueAtAddress === 0) return value.toString()

    const floatAtAddress = readSimpleFloat(value)

    if (getAddressSafe(valueAtAddress) === undefined) {
        return floatAtAddress ?? valueAtAddress.toString()
    }

    let pointerDebugString = ""
    if (pointerDepth > 0 && valueAtAddress !== 0) {
        pointerDebugString = `\t\t ${getValueDebugString(valueAtAddress, pointerDepth - 1)}`
    }

    const rttiClassName = getRTTIClassName(value)
    if (rttiClassName !== undefined) {
        return `-> ${getAddressString(valueAtAddress)} (${rttiClassName})${pointerDebugString}`
    }

    return `-> ${getAddressString(valueAtAddress)}${pointerDebugString}`
}

export function printRegister(registerName: string, registerValue: number) {
    print(
        `${registerName}\t ${getAddressString(registerValue)}\t ${getValueDebugString(
            registerValue
        )}`
    )
}

export function printRegisters() {
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

    // TODO Floats etc?
}

export function enable() {
    clearLogWindow()
    printRegisters()
}

export function disable() {}
