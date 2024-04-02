import { clear, getAddress, hex } from "../Common/Common"
import { getEntityListAddress } from "./EntityList"

const VAR_FIRST_CNPC_OFFSET = "First CNpc Offset"

function printCNPC(address: number) {
    print(`CNpc at ${hex(address)}`)
}

function getCNpcPointer(pointerAddress: number) {
    return pointerAddress ? readPointer(pointerAddress) : 0
}

function printCNPCs(entityListAddress: number) {
    const firstNpcOffset = getAddress(VAR_FIRST_CNPC_OFFSET)
    if (!firstNpcOffset) {
        print("First CNpc offset not found")
        return
    }

    let npcCount = 0
    let npcPointerAddress = entityListAddress + firstNpcOffset
    let npcPointer = getCNpcPointer(npcPointerAddress)
    while (npcPointer > 0 && npcCount < 10) {
        // TODO! REMOVE the 10 limit!!!!!!
        npcCount++ // TODO <--- use this to set HP of entities
        printCNPC(npcPointer)
        npcPointerAddress += 0x04
        npcPointer = getCNpcPointer(npcPointerAddress)
    }

    print(`Found ${npcCount} CNpcs`)
}

export function enable() {
    clear()
    const entityList = getEntityListAddress()
    if (!entityList) {
        print("Entity list not found")
        return
    }
    print(`Entity list found at ${hex(entityList)}`)
    printCNPCs(entityList)
}

export function disable() {}
