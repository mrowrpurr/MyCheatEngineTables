export function clear() {
    getLuaEngine().MenuItem5.doClick()
}

export function hex(int: number) {
    return int.toString(16)
}

export function getAddress(addressString: string) {
    const address = getAddressList().getMemoryRecordByDescription(addressString)
    if (address === undefined) print(`Address not found: ${addressString}`)
    return address?.CurrentAddress
}
