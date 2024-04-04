--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local printMonsterStats
local _____40cheat_2Dengine = require("Code.Cheat Engine.cheat-engine")
local clearLogWindow = _____40cheat_2Dengine.clearLogWindow
local showLogWindow = _____40cheat_2Dengine.showLogWindow
local _____40common = require("Code.common")
local getAddress = _____40common.getAddress
local hex = _____40common.hex
local ____Entities = require("Code.Games.Divine Divinity.Entities")
local getEntityListAddress = ____Entities.getEntityListAddress
local getEntityTypeName = ____Entities.getEntityTypeName
function printMonsterStats(npcNumber, npcAddress)
    local monsterStatsAddress = npcAddress + 44
    local monsterStats = readPointer(monsterStatsAddress)
    writeInteger(monsterStats + 4, npcNumber)
    local hp = readInteger(monsterStats + 4)
    print("> HP: " .. tostring(hp))
    local level = readInteger(monsterStats + 28)
    print("> Level: " .. tostring(level))
end
local VAR_FIRST_CNPC_OFFSET = "First CNpc Offset"
local function printCNpc(npcNumber, npcAddress, npcOffset)
    local possibleIdentifier1 = readInteger(npcAddress + 28)
    local entityTypeName = getEntityTypeName(possibleIdentifier1)
    print(((((((entityTypeName .. " - #") .. tostring(npcNumber)) .. " @ ") .. hex(npcAddress)) .. " [") .. hex(npcOffset)) .. "]")
    printMonsterStats(npcNumber, npcAddress)
    print("")
end
local function getCNpcPointer(pointerAddress)
    return pointerAddress ~= nil and readPointer(pointerAddress) or 0
end
local function printCNPCs(entityListAddress)
    local firstNpcOffset = getAddress(VAR_FIRST_CNPC_OFFSET)
    if not firstNpcOffset then
        print("First CNpc offset not found")
        return
    end
    local maxLookupMisses = 10
    local npcLookupMisses = 0
    local npcNumber = 0
    local currentNpcOffset = firstNpcOffset
    local npcPointerAddress = entityListAddress + currentNpcOffset
    local npcPointer = getCNpcPointer(npcPointerAddress)
    while npcPointer > 0 and npcNumber < 100 do
        npcNumber = npcNumber + 1
        printCNpc(npcNumber, npcPointer, currentNpcOffset)
        currentNpcOffset = currentNpcOffset + 4
        npcPointerAddress = entityListAddress + currentNpcOffset
        npcPointer = getCNpcPointer(npcPointerAddress)
        while npcPointer == 0 and npcLookupMisses < maxLookupMisses do
            npcNumber = npcNumber + 1
            npcLookupMisses = npcLookupMisses + 1
            npcPointerAddress = npcPointerAddress + 4
            npcPointer = getCNpcPointer(npcPointerAddress)
        end
    end
    print(("Found " .. tostring(npcNumber)) .. " CNpcs")
end
function ____exports.enable()
    clearLogWindow()
    showLogWindow()
    local entityList = getEntityListAddress()
    if not entityList then
        print("Entity list not found")
        return
    end
    print("Entity list found at " .. hex(entityList))
    printCNPCs(entityList)
end
function ____exports.disable()
end
return ____exports
