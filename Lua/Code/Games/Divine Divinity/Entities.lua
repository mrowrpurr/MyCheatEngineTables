--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local _____40common = require("Code.common")
local getAddress = _____40common.getAddress
local VAR_ENTITY_LIST_PTR = "Entity List Pointer"
function ____exports.getEntityListAddress()
    return getAddress(VAR_ENTITY_LIST_PTR)
end
local ENTITY_TYPE_NAMES = {[103] = "Orc Warrior", [65] = "Crossbow Orc", [99] = "Troll"}
function ____exports.getEntityTypeName(entityId)
    return ENTITY_TYPE_NAMES[entityId] or ("Entity " .. tostring(entityId)) .. " (unknown)"
end
return ____exports
