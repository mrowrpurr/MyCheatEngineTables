import { getAddress } from "../Common/Common"

const VAR_ENTITY_LIST_PTR = "Entity List Pointer"

export function getEntityListAddress() {
    return getAddress(VAR_ENTITY_LIST_PTR)
}
