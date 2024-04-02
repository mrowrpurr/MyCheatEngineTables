dofile("Divine Divinity/Common.lua")
dofile("Divine Divinity/EntityList.lua")

VAR_FIRST_CNPC_OFFSET = "Variable: First CNpc Offset"

function getFirstCNpcOffset()
  return getAddy(VAR_FIRST_CNPC_OFFSET)
end

function printEntityInfo(entityAddress)
  print("Printing entity located at " .. hex(entityAddress))
end

function Print_CNpc_Info_Enable()
  local entityListAddress = getEntityListAddress()
  local firstOffset = getFirstCNpcOffset()
  local offsetDistance = 0x4

  local currentEntityPointerAddress = entityListAddress + firstOffset
  print("First CNpc entity pointer address: " .. hex(currentEntityPointerAddress))

  local currentEntityAddress = readPointer(currentEntityPointerAddress)
  print("First CNpc entity address: " .. hex(currentEntityAddress))

  local entityCount = 0

  while entityCount < 10 and currentEntityPointerAddress > 0 and currentEntityAddress > 0 do
    printEntityInfo(currentEntityAddress)
    currentEntityPointerAddress = currentEntityPointerAddress + offsetDistance
    currentEntityAddress = readPointer(currentEntityPointerAddress)
    entityCount = entityCount + 1
  end

  print("Total CNpc entities: " .. entityCount)
end

function Print_CNpc_Info_Disable()
end
