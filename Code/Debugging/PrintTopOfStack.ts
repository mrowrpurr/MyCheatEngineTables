import { getDebugger } from "@cheat-engine"

export function enable() {
    const debug = getDebugger()
    if (debug.isDebugging()) {
        print("Is Debugging!")
    }
}

export function disable() {}
