import { getAddress } from "../Common/Common"

const VAR_ENTITY_LIST_PTR = "Entity List Pointer"

export function getEntityListAddress() {
    return getAddress(VAR_ENTITY_LIST_PTR)
}

const ENTITY_TYPE_NAMES: { [key: number]: string } = {
    103: "Orc Warrior",
    65: "Crossbow Orc",
    99: "Troll"
}

export function getEntityTypeName(entityId: number) {
    return ENTITY_TYPE_NAMES[entityId] || `Entity ${entityId} (unknown)`
}
