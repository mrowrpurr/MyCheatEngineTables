import { hex } from "../Common/Common"
import { getEntityListAddress } from "./EntityList"

const VAR_FIRST_CNPC_OFFSET = "First CNpc Offset"

export function enable() {
    print("=======================================")
    print("ENABLE!>!>!>!>!>!>!")
    const entityList = getEntityListAddress()
    if (!entityList) {
        print("Entity list not found")
        return
    }
    print(`Entity list found at ${hex(entityList)}`)
}

export function disable() {}
