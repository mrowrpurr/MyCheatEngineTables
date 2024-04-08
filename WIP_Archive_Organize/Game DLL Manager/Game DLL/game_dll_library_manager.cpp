#include <_Log_.h>
_LogToFile_("C:/Temp/CEPlugin_GameDLLManager_InjectedDLL.log");
//

#include <NamedPipes/Client.h>
#include <windows.h>

#include <memory>
#include <string>
#include <string_view>
#include <thread>
#include <unordered_map>

using namespace std;

constexpr auto NAMED_PIPE = L"GameDLLManager";

unique_ptr<NamedPipeClient>    _namedPipeClient = nullptr;
unordered_map<HMODULE, string> _loadedDllModules;

void loadDll(string_view dllPath) { _Log_("Loading DLL: {}", dllPath); }

void unloadDll(string_view dllPath) { _Log_("Unloading DLL: {}", dllPath); }

void callDllFunction(string_view dllPath, string_view functionName) {
    _Log_("Calling function '{}' in DLL: {}", functionName, dllPath);
}

void onAttach() {
    _namedPipeClient = make_unique<NamedPipeClient>(NAMED_PIPE);
    _Log_("Client connecting to server...");
    thread{[&] { _namedPipeClient->listenForMessages(); }}.detach();
    _Log_("Client listening for messages.");
}

void onDetach() {
    _Log_("Client shutting down...");
    _namedPipeClient->shutdown();
    _Log_("Client shut down successfully.");
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            // A process is loading the DLL.
            _Log_("DLL_PROCESS_ATTACH");
            onAttach();
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
            onDetach();
            break;
    }
    return TRUE;
}