export function hex(int: number) {
    return int.toString(16)
}

export function getAddress(addressString: string) {
    print(`Getting address: ${addressString}!!!!!`)
    const addressList = getAddressList()
    if (addressList === undefined) {
        print("Address list not found !!!! CHANGED agai9n AGAIN !!!")
        return
    }
    print("Address list found.!!!!!!???")
    const address = addressList.getMemoryRecordByDescription(addressString)
    if (address === undefined) print(`Address not found: ${addressString}`)
    return address?.CurrentAddress
}
