import { clearLogWindow } from "@cheat-engine"

export function printAddress(address: number) {
    const addressString = address.toString(16).toUpperCase().padStart(8, "0")
    const isSafe = getAddressSafe(address) !== undefined
    const asInteger = isSafe ? readInteger(address) : undefined
    let asFloat = isSafe ? readFloat(address) : undefined
    if (asFloat?.toString().includes("e")) asFloat = undefined
    const asPointer = asInteger && getAddressSafe(asInteger) ? readPointer(asInteger) : undefined
    const pointerAddressString =
        asPointer === undefined ? undefined : asPointer.toString(16).toUpperCase().padStart(8, "0")

    // TODO: don't show float if it has an E in it

    let output = `${addressString}`
    if (asInteger !== undefined) {
        if (asPointer !== undefined) {
            output += ` \t* ${pointerAddressString}`
            output += ` \t[${asInteger}]`
            if (asFloat !== undefined) output += ` \t(${asFloat})`
        } else {
            output += `: \t${asInteger}`
            if (asFloat !== undefined) output += ` \t(${asFloat})`
        }
    }

    print(output)

    return asInteger !== undefined
}

export function printTopOfStack(items: number = 10) {
    if (ESP === undefined) return
    print(`Top of stack: ESP = ${ESP.toString(16).toUpperCase().padStart(8, "0")}`)
    for (let i = 0; i < items; i++) if (!printAddress(ESP + i * 0x4)) break
}

export function enable() {
    clearLogWindow()
    printTopOfStack()
}

export function disable() {}
