#include <_Log_.h>
#include <cepluginsdk.h>

#include <sol/sol.hpp>
#include <string>
#include <vector>

_LogToFile_("C:/Temp/CEPlugin_GameDLLManager_CEPlugin.log");

const std::string PLUGIN_NAME = "Game DLL Manager - CE Plugin";

namespace LuaFunctions {
    void GameLibraryManager_Start() { _Log_("GameLibraryManager_Start!"); }

    void GameLibraryManager_Stop() { _Log_("GameLibraryManager_Stop!"); }

    void GameLibraryManager_LoadDLL(const char* dllPath) { _Log_("GameLibraryManager_LoadDLL: {}", dllPath); }

    void GameLibraryManager_UnloadDLL(const char* dllPath) { _Log_("GameLibraryManager_UnloadDLL: {}", dllPath); }

    // TODO: params!
    void GameLibraryManager_CallFunction(const char* functionName) {
        _Log_("GameLibraryManager_CallFunction: {}", functionName);
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

PExportedFunctions exportedFunctions;

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
