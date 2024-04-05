import { clearLogWindow } from "@cheat-engine"
import { getAddressString, getValueDebugString } from "@common"

function printStackOffset(offset: number) {
    if (ESP === undefined) return false

    const address = ESP + offset

    if (getAddressSafe(address) === undefined) return false

    const pointerValue = readPointer(address)
    if (pointerValue === undefined) return false

    const addressString = getAddressString(address)
    const offsetString = getAddressString(offset, 3)
    const valueString = getValueDebugString(address)

    print(`${addressString}   0x${offsetString}: \t ${valueString}`)

    return true
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
