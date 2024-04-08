#include <CheatEngine/Plugin/SDK.h>

#include <string_view>
#include <vector>

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

CheatEnginePlugin_InitializePlugin { return 1; }
CheatEnginePlugin_DisablePlugin { return 1; }
