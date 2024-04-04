const ALL_SCRIPTS_PREFIX = "Code/"

export function reloadScript(fullPackageName: string) {
    _G["package"]["loaded"][fullPackageName] = undefined
}

export function reloadScripts(...prefixes: string[]) {
    for (const key in _G["package"]["loaded"])
        if (prefixes.some((prefix) => key.startsWith(prefix))) reloadScript(key)
}

export function reloadAllScripts() {
    reloadScripts(ALL_SCRIPTS_PREFIX)
}

export function hex(int: number) {
    return int.toString(16)
}

export function getAddress(addressString: string) {
    const address = getAddressList().getMemoryRecordByDescription(addressString)
    if (address === undefined) print(`Address not found: ${addressString}`)
    return address?.CurrentAddress
}
