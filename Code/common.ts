export function hex(int: number) {
    return int.toString(16)
}

export function getAddress(addressString: string) {
    const address = getAddressList().getMemoryRecordByDescription(addressString)
    if (address === undefined) print(`Address not found: ${addressString}`)
    return address?.CurrentAddress
}

/**
 * Return padded hex string of address
 * @param address
 * @param padding
 * @returns
 */
export function getAddressString(address: number, padding: number = 8) {
    return address.toString(16).toUpperCase().padStart(padding, "0")
}

/**
 * `readFloat` but returns undefined for non-simple floats (e.g. NaN, Infinity)
 * @param address
 * @returns
 */
export function readSimpleFloat(address: number) {
    const floatString = readFloat(address).toString()
    if (floatString.includes("e")) return undefined
    if (floatString.includes("nan")) return undefined
    return floatString
}

/**
 * Get a debug string for a value. If the value is a pointer, it will recursively print the value at the address.
 * @param value
 * @param pointerDepth
 * @returns
 */
export function getValueDebugString(value: number, pointerDepth: number = 2) {
    const valueAtAddress = readPointer(value)
    if (valueAtAddress === undefined || valueAtAddress === 0) return value.toString()

    const floatAtAddress = readSimpleFloat(value)

    if (getAddressSafe(valueAtAddress) === undefined)
        return floatAtAddress ?? valueAtAddress.toString()

    let pointerDebugString = ""
    if (pointerDepth > 0 && valueAtAddress !== 0)
        pointerDebugString = `\t --> \t ${getValueDebugString(valueAtAddress, pointerDepth - 1)}`

    const rttiClassName = getRTTIClassName(value)
    if (rttiClassName !== undefined)
        return `${getAddressString(valueAtAddress)} (${rttiClassName})${pointerDebugString}`

    return `${getAddressString(valueAtAddress)}${pointerDebugString}`
}
