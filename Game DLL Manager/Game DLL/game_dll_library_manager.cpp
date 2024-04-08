#include <_Log_.h>
#include <windows.h>

_LogToFile_("C:/Temp/CEPlugin_GameDLLManager_InjectedDLL.log");

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            // A process is loading the DLL.
            _Log_("DLL_PROCESS_ATTACH");
            break;
        case DLL_THREAD_ATTACH:
            // A process is creating a new thread.
            _Log_("DLL_THREAD_ATTACH");
            break;
        case DLL_THREAD_DETACH:
            // A thread exits normally.
            _Log_("DLL_THREAD_DETACH");
            break;
        case DLL_PROCESS_DETACH:
            // A process unloads the DLL.
            _Log_("DLL_PROCESS_DETACH");
            break;
    }
    return TRUE;
}