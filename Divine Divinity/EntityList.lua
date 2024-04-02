dofile("Divine Divinity/Common.lua")

VAR_ENTITY_LIST_PTR = "Variable: Entity List Pointer"

function getEntityListAddress()
  return getAddy(VAR_ENTITY_LIST_PTR)
end

function getEntityPointer(offset)
  local address = getEntityListAddress() + offset
  print("Reading Entity Pointer: " .. hex(address))
  return readPointer(address)
end
