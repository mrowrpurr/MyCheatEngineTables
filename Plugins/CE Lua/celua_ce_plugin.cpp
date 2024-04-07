#include <_Log_.h>
#include <cepluginsdk.h>

#include <memory>
#include <sol/sol.hpp>
#include <string>
#include <vector>

_LogToFile_("C:/Temp/CEPlugin_CELua.log");

using namespace std;

const string PLUGIN_NAME = "CE Lua";

unique_ptr<sol::state_view> ceLuaState = nullptr;

void call_this_function() {
    _Log_("CALLED LUA FUNCTION!");
    auto print = ceLuaState->get<sol::function>("print");
    print("Hello from C++!");
}

extern "C" BOOL __declspec(dllexport) CEPlugin_GetVersion(PPluginVersion pluginVersion, int sizeofpluginversion) {
    _Log_("CEPlugin_GetVersion!");

    vector<char> pluginName(PLUGIN_NAME.begin(), PLUGIN_NAME.end());
    pluginName.push_back('\0');

    pluginVersion->version    = CESDK_VERSION;
    pluginVersion->pluginname = pluginName.data();

    return TRUE;
}

extern "C" BOOL __declspec(dllexport) CEPlugin_InitializePlugin(PExportedFunctions exportedFunctions, int pluginId) {
    _Log_("CEPlugin_InitializePlugin!");

    ceLuaState = make_unique<sol::state_view>(exportedFunctions->GetLuaState());
    ceLuaState->set_function("ceLuaFunction", call_this_function);

    return TRUE;
}

extern "C" BOOL __declspec(dllexport) CEPlugin_DisablePlugin() {
    _Log_("CEPlugin_DisablePlugin!");
    return TRUE;
}
