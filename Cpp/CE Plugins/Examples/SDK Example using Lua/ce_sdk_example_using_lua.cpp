#include <_Log_.h>
_LogToFile_("C:/Temp/CEPlugins_Example_SDK_with_Lua.log");
//

#include <CheatEngine/SDK.h>

#include <sol/sol.hpp>
#include <string_view>
#include <vector>

void CallThisFunctionFromLua() { _Log_("Called function from Lua!"); }

auto StringToCharVector(std::string_view text) {
    std::vector<char> writable(text.begin(), text.end());
    writable.push_back('\0');
    return writable;
}

CheatEnginePlugin_GetVersion {
    auto pluginName = StringToCharVector("CE Plugin Example Without Lua");

    cePluginVersion->version    = 1;
    cePluginVersion->pluginname = pluginName.data();

    return 1;
}

CheatEnginePlugin_InitializePlugin {
    sol::state_view lua(ceExportedFunctions->GetLuaState());
    lua.set_function("CallThisFunctionFromLua", CallThisFunctionFromLua);

    return 1;
}

CheatEnginePlugin_DisablePlugin { return 1; }
