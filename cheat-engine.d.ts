declare namespace CheatEngine {
    export interface MemoryRecord {
        CurrentAddress: number
    }

    export interface AddressList {
        /** @noSelf **/
        getMemoryRecordByDescription(addressString: string): MemoryRecord | undefined
    }

    export interface MenuItem {
        /** @noSelf **/
        doClick(): void
    }

    export interface Form {
        MenuItem5: MenuItem
    }
}

declare function getAddressList(): CheatEngine.AddressList
declare function getLuaEngine(): CheatEngine.Form
declare function readPointer(address: number): number
