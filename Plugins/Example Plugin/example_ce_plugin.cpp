#include <_Log_.h>
#include <cepluginsdk.h>

#include <sol/sol.hpp>
#include <string>
#include <vector>

_LogToFile_("C:/Temp/CEPlugin_HelloWorld.log");

const std::string PLUGIN_NAME = "Hello, plugin";

// Your C++ function
void call_this_function() {
    // Your function's implementation here
    _Log_("CALLED LUA FUNCTION!");
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

    sol::state_view state{exportedFunctions->GetLuaState()};
    state.set_function("callThisFunction", call_this_function);

    return TRUE;
}

extern "C" BOOL __declspec(dllexport) CEPlugin_DisablePlugin() {
    _Log_("CEPlugin_DisablePlugin!");

    return TRUE;
}
