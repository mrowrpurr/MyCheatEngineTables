import { clearLogWindow, showLogWindow } from "@cheat-engine"
import { getAddress, hex } from "@common"
import { getEntityListAddress, getEntityTypeName } from "./Entities"

const VAR_FIRST_CNPC_OFFSET = "First CNpc Offset"

function printCNpc(npcNumber: number, npcAddress: number, npcOffset: number) {
    const possibleIdentifier1 = readInteger(npcAddress + 0x1c)
    // const possibleIdentifier2 = readInteger(npcAddress + 0x20)
    // const possibleIdentifier3 = readSmallInteger(npcAddress + 0x80)
    const entityTypeName = getEntityTypeName(possibleIdentifier1)
    print(`${entityTypeName} - #${npcNumber} @ ${hex(npcAddress)} [${hex(npcOffset)}]`)
    printMonsterStats(npcNumber, npcAddress)
    print("")
}

function printMonsterStats(npcNumber: number, npcAddress: number) {
    const monsterStatsAddress = npcAddress + 0x2c
    const monsterStats = readPointer(monsterStatsAddress)
    writeInteger(monsterStats + 0x4, npcNumber)
    const hp = readInteger(monsterStats + 0x4)
    print(`> HP: ${hp}`)
    const level = readInteger(monsterStats + 0x1c)
    print(`> Level: ${level}`)
}

function getCNpcPointer(pointerAddress: number) {
    return pointerAddress !== undefined ? readPointer(pointerAddress) : 0
}

function printCNPCs(entityListAddress: number) {
    const firstNpcOffset = getAddress(VAR_FIRST_CNPC_OFFSET)
    if (!firstNpcOffset) {
        print("First CNpc offset not found")
        return
    }
    const maxLookupMisses = 10
    let npcLookupMisses = 0
    let npcNumber = 0
    let currentNpcOffset = firstNpcOffset
    let npcPointerAddress = entityListAddress + currentNpcOffset
    let npcPointer = getCNpcPointer(npcPointerAddress)
    while (npcPointer > 0 && npcNumber < 100) {
        npcNumber++
        printCNpc(npcNumber, npcPointer, currentNpcOffset)
        currentNpcOffset += 0x04
        npcPointerAddress = entityListAddress + currentNpcOffset
        npcPointer = getCNpcPointer(npcPointerAddress)
        while (npcPointer === 0 && npcLookupMisses < maxLookupMisses) {
            npcNumber++
            npcLookupMisses++
            npcPointerAddress += 0x04
            npcPointer = getCNpcPointer(npcPointerAddress)
        }
    }
    print(`Found ${npcNumber} CNpcs`)
}

export function enable() {
    clearLogWindow()
    showLogWindow()
    const entityList = getEntityListAddress()
    if (!entityList) {
        print("Entity list not found")
        return
    }
    print(`Entity list found at ${hex(entityList)}`)
    printCNPCs(entityList)
}

export function disable() {}
