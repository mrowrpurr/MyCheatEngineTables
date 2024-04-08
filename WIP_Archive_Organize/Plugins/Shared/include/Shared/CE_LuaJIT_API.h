#include <windows.h>

#include "Foo.h"

constexpr auto MODULE_TEXT_CE_LUAJIT = "CE Plugin - LuaJIT.dll";

HMODULE getLuaJITModule() { return GetModuleHandle(TEXT(MODULE_TEXT_CE_LUAJIT)); }

using getFooFn = Foo* (*)();

getFooFn fn_getFoo() {
    HMODULE hModule = getLuaJITModule();
    if (hModule == NULL) {
        return nullptr;
    }

    return (getFooFn)GetProcAddress(hModule, "getFoo");
}
