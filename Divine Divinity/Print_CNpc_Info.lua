dofile("Divine Divinity/Common.lua")
dofile("Divine Divinity/EntityList.lua")

VAR_FIRST_CNPC_OFFSET = "Variable: First CNpc Offset"

function getFirstCNpcOffset()
  return getAddy(VAR_FIRST_CNPC_OFFSET)
end

function printMonsterStatsForEntity(entityIndex, entityAddress)
  local monsterStatsAddress = entityAddress + 0x2c
  local monsterStats = readPointer(monsterStatsAddress)
  writeInteger(monsterStats + 0x4, entityIndex)
  local hp = readInteger(monsterStats + 0x4)
  print("> HP: " .. hp)
  local level = readInteger(monsterStats + 0x1c)
  print("> Level: " .. level)
end

function printEntityInfo(entityIndex, entityAddress)
  print("PRINT ENTITY @ " .. hex(entityAddress))
  local possibleIdentifier1 = readInteger(entityAddress + 0x1c)
  print("> ID1: " .. possibleIdentifier1)
  local possibleIdentifier2 = readInteger(entityAddress + 0x20)
  print("> ID2: " .. possibleIdentifier2)
  local possibleIdentifier3 = readInteger(entityAddress + 0x80)
  print("> ID3: " .. possibleIdentifier3)
  printMonsterStatsForEntity(entityIndex, entityAddress)
  print("")
end

function Print_CNpc_Info_Enable()
  local entityListAddress = getEntityListAddress()
  local firstOffset = getFirstCNpcOffset()
  local offsetDistance = 0x4
  local currentEntityPointerAddress = entityListAddress + firstOffset
  local currentEntityAddress = readPointer(currentEntityPointerAddress)
  local entityCount = 0

  while entityCount < 10 and currentEntityPointerAddress > 0 and currentEntityAddress > 0 do
    entityCount = entityCount + 1
    printEntityInfo(entityCount, currentEntityAddress)
    currentEntityPointerAddress = currentEntityPointerAddress + offsetDistance
    currentEntityAddress = readPointer(currentEntityPointerAddress)
  end

  print("Total CNpc entities: " .. entityCount)
end

function Print_CNpc_Info_Disable()
end
