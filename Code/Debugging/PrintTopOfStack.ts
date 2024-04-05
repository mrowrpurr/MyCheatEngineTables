import { clearLogWindow } from "@cheat-engine"

export function printStackOffset(offset: number) {
    if (ESP === undefined) return false

    const offsetString = offset.toString(16).toUpperCase().padStart(3, "0")
    const address = ESP + offset
    const addressString = address.toString(16).toUpperCase().padStart(8, "0")
    const isSafe = getAddressSafe(address) !== undefined
    const asInteger = isSafe ? readInteger(address) : undefined
    let asFloat = isSafe ? readFloat(address) : undefined
    if (asFloat?.toString().includes("e")) asFloat = undefined
    if (asFloat?.toString().includes("nan")) asFloat = undefined
    if (asInteger === 0) asFloat = undefined
    const asPointer = asInteger && getAddressSafe(asInteger) ? readPointer(asInteger) : undefined
    const pointerAddressString =
        asPointer === undefined ? undefined : asPointer.toString(16).toUpperCase().padStart(8, "0")

    let output = `0x${offsetString}`
    if (asInteger !== undefined) {
        if (asPointer !== undefined) {
            output += ` \t\t-> ${pointerAddressString}`
        } else {
            output += ` \t${asInteger}`
            if (asFloat !== undefined) output += ` \t(${asFloat})`
        }
    }

    print(output)

    return asInteger !== undefined
}

export function printTopOfStack(items: number = 30) {
    if (ESP === undefined) return
    print(`Top of stack: ESP = ${ESP.toString(16).toUpperCase().padStart(8, "0")}`)
    for (let i = 0; i < items; i++) if (!printStackOffset(i * 0x4)) break
}

export function enable() {
    clearLogWindow()
    printTopOfStack()
}

export function disable() {}
