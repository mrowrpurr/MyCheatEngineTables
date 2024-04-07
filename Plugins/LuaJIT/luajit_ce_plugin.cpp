#include <Shared/Foo.h>
#include <_Log_.h>
#include <cepluginsdk_nolua.h>

#include <filesystem>
#include <sol/sol.hpp>
#include <string>
#include <vector>

_LogToFile_("C:/Temp/CEPlugin_LuaJIT.log");

const std::string PLUGIN_NAME = "LuaJIT";

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

    auto currentWorkingDirectory = std::filesystem::current_path();
    _Log_("Current working directory: {}", currentWorkingDirectory.string());

    // Make a Lua state
    // and run some code (e.g. 69 + 420) and get the result:
    sol::state state;
    auto       result = state.script("return 69 + 420;");
    _Log_("Lua: 69 + 420 = {}", result.get<int>());

    return TRUE;
}

extern "C" BOOL __declspec(dllexport) CEPlugin_DisablePlugin() {
    _Log_("CEPlugin_DisablePlugin!");

    return TRUE;
}

Foo foo{42};

extern "C" __declspec(dllexport) Foo* getFoo() { return &foo; }
