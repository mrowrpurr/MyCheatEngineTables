import { getAddress } from "../Common/Common"

const VAR_ENTITY_LIST_PTR = "Entity List Pointer"

export function getEntityListAddress() {
    print("Getting entity list address!!!!!????????")
    return getAddress(VAR_ENTITY_LIST_PTR)
}
