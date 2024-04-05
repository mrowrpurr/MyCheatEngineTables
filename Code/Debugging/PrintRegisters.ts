import { clearLogWindow } from "@cheat-engine"

export function readSimpleFloat(address: number) {
    const floatString = readFloat(address).toString()
    if (floatString.includes("e")) return undefined
    if (floatString.includes("nan")) return undefined
    return floatString
}

export function getValueDebugString(value: number, pointerDepth: 2) {
    return "TODO"
    // const valueAtAddress = readPointer(value)
    // if (valueAtAddress === undefined) return value.toString()

    // const floatAtAddress = readFloat(value)

    // if (getAddressSafe(valueAtAddress) === undefined) return value.toString()
}

// export function __getPrettyAddressValueString(address: number) {
//     const isSafe = getAddressSafe(address) !== undefined
//     const asInteger = isSafe ? readInteger(address) : undefined
//     let asFloat = isSafe ? readFloat(address) : undefined
//     if (asFloat?.toString().includes("e")) asFloat = undefined
//     if (asFloat?.toString().includes("nan")) asFloat = undefined
//     if (asInteger === 0) asFloat = undefined
//     const asPointer = asInteger && getAddressSafe(asInteger) ? readPointer(asInteger) : undefined
//     const pointerAddressString =
//         asPointer === undefined ? undefined : asPointer.toString(16).toUpperCase().padStart(8, "0")
//     const rttiClassName = asPointer && asInteger ? getRTTIClassName(asInteger) : undefined

//     let output = ""
//     if (asInteger !== undefined) {
//         if (asPointer !== undefined) {
//             output += ` \t\t-> ${pointerAddressString}`
//             if (rttiClassName !== undefined) output += ` \t(${rttiClassName})`
//         } else {
//             output += ` \t${asInteger}`
//             if (asFloat !== undefined) output += ` \t(${asFloat})`
//         }
//     }
//     return output
// }

export function getAddressString(address: number, padding: number = 8) {
    return address.toString(16).toUpperCase().padStart(padding, "0")
}

export function printRegister(registerName: string, registerValue: number) {
    const valueAtAddress = readPointer(registerValue)
    if (valueAtAddress === undefined) {
        // This is a simple integer (it does not point to safe memory)
        print(`${registerName}: ${registerValue}`)
        return
    }

    print(
        `${registerName}: ${getAddressString(registerValue)} -> ${getAddressString(valueAtAddress)}`
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
