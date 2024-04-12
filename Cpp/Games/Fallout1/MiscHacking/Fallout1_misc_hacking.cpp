#include <_Log_.h>
_LogToFile_("C:/Temp/Fallout1_Misc_Hacks.log");

//
#include <windows.h>

void HackThePlanet() { _Log_("Hack the Planet!"); }

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            _Log_("DLL_PROCESS_ATTACH");
            HackThePlanet();
            break;
        case DLL_THREAD_ATTACH:
            _Log_("DLL_THREAD_ATTACH");
            break;
        case DLL_THREAD_DETACH:
            _Log_("DLL_THREAD_DETACH");
            break;
        case DLL_PROCESS_DETACH:
            _Log_("DLL_PROCESS_DETACH");
            break;
    }
    return TRUE;
}