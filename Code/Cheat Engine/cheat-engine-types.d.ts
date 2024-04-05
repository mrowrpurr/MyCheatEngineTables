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

    export interface Menu {
        Items: MenuItem[][]
    }

    export interface Form {
        Menu: Menu

        MenuItem5: MenuItem

        /** @noSelf **/
        show(): void

        /** @noSelf **/
        hide(): void
    }

    export interface MemoryView extends Form {
        Search1: MenuItem
        Tools4: MenuItem
        Tools5: MenuItem
        Tools6: MenuItem
        Tools7: MenuItem
    }
}

declare enum VirtualKeyCode {
    VK_LBUTTON = 1,
    VK_RBUTTON = 2,
    VK_XBUTTON1,
    VK_XBUTTON2,
    VK_CANCEL = 3,
    VK_MBUTTON = 4,
    VK_BACK = 8,
    VK_TAB = 9,
    VK_CLEAR = 12,
    VK_RETURN = 13,
    VK_SHIFT = 16,
    VK_CONTROL = 17,
    VK_MENU = 18,
    VK_PAUSE = 19,
    VK_CAPITAL = 20,
    VK_ESCAPE = 27,
    VK_SPACE = 32,
    VK_PRIOR = 33,
    VK_NEXT = 34,
    VK_END = 35,
    VK_HOME = 36,
    VK_LEFT = 37,
    VK_UP = 38,
    VK_RIGHT = 39,
    VK_DOWN = 40,
    VK_SELECT = 41,
    VK_PRINT = 42,
    VK_EXECUTE = 43,
    VK_SNAPSHOT = 44,
    VK_INSERT = 45,
    VK_DELETE = 46,
    VK_HELP = 47,
    VK_0 = 48,
    VK_1 = 49,
    VK_2 = 50,
    VK_3 = 51,
    VK_4 = 52,
    VK_5 = 53,
    VK_6 = 54,
    VK_7 = 55,
    VK_8 = 56,
    VK_9 = 57,
    VK_A = 65,
    VK_B = 66,
    VK_C = 67,
    VK_D = 68,
    VK_E = 69,
    VK_F = 70,
    VK_G = 71,
    VK_H = 72,
    VK_I = 73,
    VK_J = 74,
    VK_K = 75,
    VK_L = 76,
    VK_M = 77,
    VK_N = 78,
    VK_O = 79,
    VK_P = 80,
    VK_Q = 81,
    VK_R = 82,
    VK_S = 83,
    VK_T = 84,
    VK_U = 85,
    VK_V = 86,
    VK_W = 87,
    VK_X = 88,
    VK_Y = 89,
    VK_Z = 90,
    VK_LWIN = 91,
    VK_RWIN = 92,
    VK_APPS = 93,
    VK_NUMPAD0 = 96,
    VK_NUMPAD1 = 97,
    VK_NUMPAD2 = 98,
    VK_NUMPAD3 = 99,
    VK_NUMPAD4 = 100,
    VK_NUMPAD5 = 101,
    VK_NUMPAD6 = 102,
    VK_NUMPAD7 = 103,
    VK_NUMPAD8 = 104,
    VK_NUMPAD9 = 105,
    VK_MULTIPLY = 106,
    VK_ADD = 107,
    VK_SEPARATOR = 108,
    VK_SUBTRACT = 109,
    VK_DECIMAL = 110,
    VK_DIVIDE = 111,
    VK_F1 = 112,
    VK_F2 = 113,
    VK_F3 = 114,
    VK_F4 = 115,
    VK_F5 = 116,
    VK_F6 = 117,
    VK_F7 = 118,
    VK_F8 = 119,
    VK_F9 = 120,
    VK_F10 = 121,
    VK_F11 = 122,
    VK_F12 = 123,
    VK_F13 = 124,
    VK_F14 = 125,
    VK_F15 = 126,
    VK_F16 = 127,
    VK_F17 = 128,
    VK_F18 = 129,
    VK_F19 = 130,
    VK_F20 = 131,
    VK_F21 = 132,
    VK_F22 = 133,
    VK_F23 = 134,
    VK_F24 = 135,
    VK_NUMLOCK = 144,
    VK_SCROLL = 145,
    VK_LSHIFT = 160,
    VK_LCONTROL = 162,
    VK_LMENU = 164,
    VK_RSHIFT = 161,
    VK_RCONTROL = 163,
    VK_RMENU = 165
}

declare function getAddressList(): CheatEngine.AddressList

declare function getLuaEngine(): CheatEngine.Form
declare function getMemoryViewForm(): CheatEngine.MemoryView
declare function getMainForm(): CheatEngine.Form

declare function getAddressSafe(address: number): number | undefined

declare function readPointer(address: number): number
declare function writePointer(address: number, value: number): void

declare function readInteger(address: number): number
declare function writeInteger(address: number, value: number): void

declare function readSmallInteger(address: number): number
declare function writeSmallInteger(address: number, value: number): void

declare function readFloat(address: number): number
declare function writeFloat(address: number, value: number): void

declare function getRTTIClassName(address: number): string | undefined

declare function debug_isDebugging(): boolean
declare function debug_getContext(includeFloats: boolean): void

declare function doKeyPress(key: VirtualKeyCode): void
declare function keyDown(key: VirtualKeyCode): void
declare function keyUp(key: VirtualKeyCode): void

declare function readFromClipboard(): string
declare function writeToClipboard(value: string): void

declare const EAX: number | undefined
declare const EBX: number | undefined
declare const ECX: number | undefined
declare const EDX: number | undefined
declare const ESI: number | undefined
declare const EDI: number | undefined
declare const ESP: number | undefined
declare const EBP: number | undefined
declare const EIP: number | undefined

declare const FP0: unknown
declare const FP1: unknown
declare const FP2: unknown
declare const FP3: unknown
declare const FP4: unknown
declare const FP5: unknown
declare const FP6: unknown
declare const FP7: unknown

declare function byteTableToExtended(byteTable: unknown): number

declare function sleep(milliseconds: number): void
