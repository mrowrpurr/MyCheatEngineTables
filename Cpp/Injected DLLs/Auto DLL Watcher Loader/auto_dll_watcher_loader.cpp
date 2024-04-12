#include <_Log_.h>
_LogToFile_("C:/Temp/AutoDLLWatcherLoader.log");

//

#include <efsw/efsw.hpp>
#include <filesystem>
#include <memory>

using namespace std;

constexpr auto AUTO_INJECT_DLLS_ENV_VAR = "AUTO_INJECT_DLLS_FOLDER";

class MyFileWatcher : public efsw::FileWatchListener {
    unique_ptr<efsw::FileWatcher> _watcher;

public:
    MyFileWatcher(const filesystem::path& directory) {
        _watcher = make_unique<efsw::FileWatcher>();
        _watcher->addWatch(directory.string(), this, true);
    }

    void watch() { _watcher->watch(); }

    void handleFileAction(
        efsw::WatchID watchid, const std::string& dir, const std::string& filename, efsw::Action action,
        std::string oldFilename = ""
    ) override {
        if (action == efsw::Actions::Add && filename.substr(filename.find_last_of(".") + 1) == "dll") {
            _Log_("New DLL added. Dir: {} Filename: {}", dir, filename);
        }
    }
};

unique_ptr<MyFileWatcher> fileSystemWatcher;

void startWatchingForDLLs() {
    auto autoInjectDLLsFolder = getenv(AUTO_INJECT_DLLS_ENV_VAR);
    if (!autoInjectDLLsFolder) {
        _Log_("Environment variable '{}' not set.", AUTO_INJECT_DLLS_ENV_VAR);
        return;
    }

    fileSystemWatcher = make_unique<MyFileWatcher>(autoInjectDLLsFolder);
    fileSystemWatcher->watch();
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            _Log_("DLL_PROCESS_ATTACH");
            startWatchingForDLLs();
            break;
        case DLL_THREAD_ATTACH:
            _Log_("DLL_THREAD_ATTACH");
            break;
        case DLL_THREAD_DETACH:
            _Log_("DLL_THREAD_DETACH");
            break;
        case DLL_PROCESS_DETACH:
            _Log_("DLL_PROCESS_DETACH");
            break;
    }
    return TRUE;
}