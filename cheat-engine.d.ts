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

        /** @noSelf **/
        show(): void

        /** @noSelf **/
        hide(): void
    }
}

declare function getAddressList(): CheatEngine.AddressList
declare function getLuaEngine(): CheatEngine.Form

declare function readPointer(address: number): number
declare function writePointer(address: number, value: number): void

declare function readInteger(address: number): number
declare function writeInteger(address: number, value: number): void

declare function readSmallInteger(address: number): number
declare function writeSmallInteger(address: number, value: number): void
