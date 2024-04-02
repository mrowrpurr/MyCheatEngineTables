dofile("Divine Divinity/Common.lua")

VAR_ENTITY_LIST_PTR = "Variable: Entity List Pointer"

function getEntityListAddress()
  return getAddy(VAR_ENTITY_LIST_PTR)
end

-- function readEntityPointer(offset)
--   if offset then
--     return readPointer(getEntityListAddress() + offset)
--   else
--     return nil
--   end
-- end
