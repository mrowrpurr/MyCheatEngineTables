export function hex(int: number) {
    return int.toString(16)
}

export function getAddress(addressString: string) {
    const address = getAddressList().getMemoryRecordByDescription(addressString)
    if (address === undefined) print(`Address not found: ${addressString}`)
    return address?.CurrentAddress
}

export function getAddressString(address: number, padding: number = 8) {
    return address.toString(16).toUpperCase().padStart(padding, "0")
}

export function readSimpleFloat(address: number) {
    const floatString = readFloat(address).toString()
    if (floatString.includes("e")) return undefined
    if (floatString.includes("nan")) return undefined
    return floatString
}
