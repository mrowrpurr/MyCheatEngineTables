#include <_Log_.h>
_LogToFile_("C:/Temp/CEPlugin_GameDLLManager_ExampleLibrary1.log");

#include <windows.h>

extern "C" __declspec(dllexport) void enable() {
    //
}

extern "C" __declspec(dllexport) void disable() {
    //
}

// WON'T NEED THIS LATER:
BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            // A process is loading the DLL.
            _Log_("DLL_PROCESS_ATTACH");

            // Run client.listenForMessages() in a separate thread
            // to avoid blocking the main thread.
            _Log_("Client connecting to server...");
            thread{[&] { _namedPipeClient->listenForMessages(); }}.detach();
            _Log_("Client listening for messages.");

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

            _Log_("Client shutting down...");
            _namedPipeClient->shutdown();
            _Log_("Client shut down successfully.");

            break;
    }
    return TRUE;
}
