#include <_Log_.h>
_LogToFile_("C:/Temp/CEPlugin_GameDLLManager_CEPlugin.log");
//

#include <NamedPipes/Server.h>
#include <cepluginsdk.h>

#include <sol/sol.hpp>
#include <string>
#include <vector>

using namespace std;

const string PLUGIN_NAME = "Game DLL Manager - CE Plugin";

constexpr auto NAMED_PIPE = L"GameDLLManager";

bool _dllWasInjected = false;

PExportedFunctions          exportedFunctions;
unique_ptr<NamedPipeServer> _namedPipeServer = nullptr;

namespace LuaFunctions {
    void GameLibraryManager_Start() {
        _Log_("GameLibraryManager_Start!");
        _namedPipeServer = make_unique<NamedPipeServer>(NAMED_PIPE);
    }

    void GameLibraryManager_Stop() {
        _Log_("GameLibraryManager_Stop!");
        _namedPipeServer->sendCommand("eject");
        _namedPipeServer->shutdown();
        _namedPipeServer.reset();
    }

    void GameLibraryManager_LoadDLL(const char* dllPath) {
        _Log_("GameLibraryManager_LoadDLL: {}", dllPath);
        if (_namedPipeServer == nullptr) {
            _Log_("Named pipe server is not initialized!");
            return;
        }
    }

    void GameLibraryManager_UnloadDLL(const char* dllPath) {
        _Log_("GameLibraryManager_UnloadDLL: {}", dllPath);
        if (_namedPipeServer == nullptr) {
            _Log_("Named pipe server is not initialized!");
            return;
        }
    }

    // TODO: params!
    void GameLibraryManager_CallFunction(const char* functionName) {
        _Log_("GameLibraryManager_CallFunction: {}", functionName);
        if (_namedPipeServer == nullptr) {
            _Log_("Named pipe server is not initialized!");
            return;
        }
        _Log_("Sending message to named pipe server");
        _namedPipeServer->sendMessage(functionName);
        _Log_("Message sent!");
    }

    void BindLuaFunctions(lua_State* state) {
        sol::state_view ceLuaState(state);
        ceLuaState.set_function("GameLibraryManager_Start", GameLibraryManager_Start);
        ceLuaState.set_function("GameLibraryManager_Stop", GameLibraryManager_Stop);
        ceLuaState.set_function("GameLibraryManager_LoadDLL", GameLibraryManager_LoadDLL);
        ceLuaState.set_function("GameLibraryManager_UnloadDLL", GameLibraryManager_UnloadDLL);
        ceLuaState.set_function("GameLibraryManager_CallFunction", GameLibraryManager_CallFunction);
    }

    void UnbindLuaFunctions(lua_State* state) {
        sol::state_view ceLuaState(state);
        ceLuaState.set_function("GameLibraryManager_Start", nullptr);
        ceLuaState.set_function("GameLibraryManager_Stop", nullptr);
        ceLuaState.set_function("GameLibraryManager_LoadDLL", nullptr);
        ceLuaState.set_function("GameLibraryManager_UnloadDLL", nullptr);
        ceLuaState.set_function("GameLibraryManager_CallFunction", nullptr);
    }
}

extern "C" BOOL __declspec(dllexport) CEPlugin_GetVersion(PPluginVersion pluginVersion, int sizeofpluginversion) {
    _Log_("CEPlugin_GetVersion!");

    std::vector<char> pluginName(PLUGIN_NAME.begin(), PLUGIN_NAME.end());
    pluginName.push_back('\0');

    pluginVersion->version    = CESDK_VERSION;
    pluginVersion->pluginname = pluginName.data();

    return TRUE;
}

extern "C" BOOL __declspec(dllexport) CEPlugin_InitializePlugin(PExportedFunctions exportedFunctions, int pluginId) {
    _Log_("CEPlugin_InitializePlugin!");
    LuaFunctions::BindLuaFunctions(exportedFunctions->GetLuaState());
    ::exportedFunctions = exportedFunctions;
    return TRUE;
}

extern "C" BOOL __declspec(dllexport) CEPlugin_DisablePlugin() {
    _Log_("CEPlugin_DisablePlugin!");
    // TODO: make this work :P
    // LuaFunctions::UnbindLuaFunctions(exportedFunctions->GetLuaState());
    return TRUE;
}
