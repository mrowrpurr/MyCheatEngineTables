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
}

export class Debugger {
    isDebugging() {
        return debug_isDebugging()
    }

    hasRegisters() {
        return EAX !== undefined
    }

    getRegisters() {
        return this.hasRegisters() ? new Registers() : undefined
    }
}

export function getDebugger(): Debugger {
    return new Debugger()
}

export function clearLogWindow() {
    getLuaEngine().MenuItem5.doClick()
}

export function showLogWindow() {
    getLuaEngine().show()
}
