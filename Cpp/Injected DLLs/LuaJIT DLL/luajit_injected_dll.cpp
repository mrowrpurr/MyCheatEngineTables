#include <_Log_.h>
_LogToFile_("C:/Temp/CEPlugin_LuaJIT_DLL.log");

#include <NamedPipes/Client.h>
#include <windows.h>

#include <memory>
#include <sol/sol.hpp>
#include <string>
#include <string_view>
#include <thread>
#include <unordered_map>

using namespace std;

constexpr auto NAMED_PIPE = L"GameDLLManager";

unique_ptr<NamedPipeClient>    _namedPipeClient = nullptr;
unique_ptr<sol::state>         _luaState        = nullptr;
unordered_map<HMODULE, string> _loadedDllModules;

void runLua(std::string_view luaScript) {
    _Log_("Running Lua script: {}", luaScript);
    try {
        _luaState->script(luaScript.data());
    } catch (const sol::error& e) {
        _Log_("Lua error: {}", e.what());
    }
}

void setupNewLuaState() {
    _luaState = make_unique<sol::state>();
    _luaState->open_libraries(
        sol::lib::base, sol::lib::package, sol::lib::string, sol::lib::table, sol::lib::ffi, sol::lib::os, sol::lib::io,
        sol::lib::jit, sol::lib::utf8, sol::lib::coroutine, sol::lib::count, sol::lib::bit32, sol::lib::debug
    );
}

void onAttach() {
    setupNewLuaState();
    _namedPipeClient = make_unique<NamedPipeClient>(NAMED_PIPE);
    _namedPipeClient->addMessageHandler("lua", runLua);
    _Log_("Client connecting to server...");
    thread{[&] { _namedPipeClient->listenForMessages(); }}.detach();
    _Log_("Client listening for messages.");
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            _Log_("DLL_PROCESS_ATTACH");
            _Log_("Client connecting to server...");
            onAttach();
            _Log_("Client listening for messages.");
            break;
        case DLL_THREAD_ATTACH:
            _Log_("DLL_THREAD_ATTACH");
            break;
        case DLL_THREAD_DETACH:
            _Log_("DLL_THREAD_DETACH");
            break;
        case DLL_PROCESS_DETACH:
            _Log_("DLL_PROCESS_DETACH");
            _Log_("Client shutting down...");
            _namedPipeClient->shutdown();
            _Log_("Client shut down successfully.");
            break;
    }
    return TRUE;
}