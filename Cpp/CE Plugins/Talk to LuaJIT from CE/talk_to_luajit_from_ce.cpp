#include <_Log_.h>
_LogToFile_("C:/Temp/CEPlugin_TalkToLuaJIT_from_CE.log");
//

#include <CheatEngine/Plugin.h>
#include <NamedPipes/Server.h>

#include <sol/sol.hpp>
#include <string_view>

CEPlugin("Talk to LuaJIT from CE");

using namespace std;

const string PLUGIN_NAME = "Game DLL Manager - CE Plugin";

constexpr auto NAMED_PIPE = L"GameDLLManager";

unique_ptr<NamedPipeServer> _namedPipeServer = nullptr;

void RunLuaJITScript(string_view luaScript) {
    _Log_("Running Lua script: {}", luaScript);
    try {
        _namedPipeServer->sendCommand("luaJIT", luaScript.data());
    } catch (const exception& e) {
        _Log_("Error: {}", e.what());
    }
}

void RegisterLuaFunctions() {
    sol::state_view ceLuaState(CE::CEFunctions()->GetLuaState());
    ceLuaState.set_function("luaJIT", RunLuaJITScript);
}

CEPlugin_OnInit { RegisterLuaFunctions(); }

CEPlugin_OnEnable { _namedPipeServer = make_unique<NamedPipeServer>(NAMED_PIPE); }

CEPlugin_OnDisable { _namedPipeServer->shutdown(); }
