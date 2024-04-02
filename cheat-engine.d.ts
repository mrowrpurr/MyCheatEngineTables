declare namespace CheatEngine {
    export interface MemoryRecord {
        CurrentAddress: number
    }

    export interface AddressList {
        /** @noSelf **/
        getMemoryRecordByDescription(addressString: string): MemoryRecord | undefined
    }
}

declare function getAddressList(): CheatEngine.AddressList
