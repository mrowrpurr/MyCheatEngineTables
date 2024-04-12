#include <_Log_.h>
_LogToFile_("C:/Temp/Fallout1_Misc_Hacks.log");

//
#include <windows.h>

using MoveNPC_Maybe = int(__fastcall*)(int, int);

constexpr auto CHARACTER_ID = 18000;

constexpr auto MODULE_BASE = 0x400000;

namespace Offsets {
    namespace Functions {
        constexpr auto MoveNPCMaybe = 0x7F69C;
    }
}

auto GetAddress(uint32_t offset) { return MODULE_BASE + offset; }

template <typename T>
T GetFunction(uint32_t offset) {
    return reinterpret_cast<T>(GetAddress(offset));
}

void HackThePlanet() {
    _Log_("Hack the Planet!");

    auto fn = GetFunction<MoveNPC_Maybe>(Offsets::Functions::MoveNPCMaybe);

    _Log_("Calling function ...");
    fn(CHARACTER_ID, 18490);
    _Log_("Function called!");
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            _Log_("DLL_PROCESS_ATTACH");
            HackThePlanet();
            break;
        case DLL_THREAD_ATTACH:
            // _Log_("DLL_THREAD_ATTACH");
            break;
        case DLL_THREAD_DETACH:
            // _Log_("DLL_THREAD_DETACH");
            break;
        case DLL_PROCESS_DETACH:
            _Log_("DLL_PROCESS_DETACH");
            break;
    }
    return TRUE;
}