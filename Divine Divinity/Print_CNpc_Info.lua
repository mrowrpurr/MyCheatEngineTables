dofile("Divine Divinity/Common.lua")
dofile("Divine Divinity/EntityList.lua")

VAR_FIRST_CNPC_OFFSET = "Variable: First CNpc Offset"

function getFirstCNpcOffset()
  return getAddy(VAR_FIRST_CNPC_OFFSET)
end

function Print_CNpc_Info_Enable()
  local entityListAddress = getEntityListAddress()
  print("Entity List Pointer: " .. hex(entityListAddress))

  local offset = getFirstCNpcOffset()
  print("First CNpc Offset: " .. hex(offset))

  local firstEntityPointer = getEntityPointer(getFirstCNpcOffset())
  print("First CNpc Pointer: " .. hex(firstEntityPointer))
end

function Print_CNpc_Info_Disable()
end
