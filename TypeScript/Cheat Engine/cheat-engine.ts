export class Registers {
    get eax() {
        return EAX === undefined ? 0 : EAX
    }
    get ebx() {
        return EBX === undefined ? 0 : EBX
    }
    get ecx() {
        return ECX === undefined ? 0 : ECX
    }
    get edx() {
        return EDX === undefined ? 0 : EDX
    }
    get esi() {
        return ESI === undefined ? 0 : ESI
    }
    get edi() {
        return EDI === undefined ? 0 : EDI
    }
    get ebp() {
        return EBP === undefined ? 0 : EBP
    }
    get esp() {
        return ESP === undefined ? 0 : ESP
    }
    get eip() {
        return EIP === undefined ? 0 : EIP
    }
    get fp0(): number {
        return byteTableToExtended(FP0)
    }
    get fp1(): number {
        return byteTableToExtended(FP1)
    }
    get fp2(): number {
        return byteTableToExtended(FP2)
    }
    get fp3(): number {
        return byteTableToExtended(FP3)
    }
    get fp4(): number {
        return byteTableToExtended(FP4)
    }
    get fp5(): number {
        return byteTableToExtended(FP5)
    }
    get fp6(): number {
        return byteTableToExtended(FP6)
    }
    get fp7(): number {
        return byteTableToExtended(FP7)
    }
}

export class Debugger {
    isDebugging() {
        return debug_isDebugging()
    }

    hasRegisters() {
        return EAX !== undefined
    }

    getRegisters(includeFloats: boolean = true) {
        if (includeFloats) debug_getContext(true)
        return this.hasRegisters() ? new Registers() : undefined
    }
}

export function getDebugger(): Debugger {
    return new Debugger()
}

export function clearLogWindow() {
    // getLuaEngine().MenuItem5.doClick()
    print("TODO: re-implement clearLogWindow() without using MenuItem5")
}

export function showLogWindow() {
    getLuaEngine().show()
}
