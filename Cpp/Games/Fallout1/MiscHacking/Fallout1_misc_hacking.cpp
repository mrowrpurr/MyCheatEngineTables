#include <_Log_.h>
_LogToFile_("C:/Temp/Fallout1_Misc_Hacks.log");

//
#include <windows.h>

constexpr auto MODULE_BASE = 0x400000;

namespace Identifiers {
    constexpr auto CHARACTER_ID = 18000;

    namespace SkillIndexes {
        constexpr uint32_t SmallGuns = 0;
        constexpr uint32_t BigGuns   = 1;
    }
}

namespace Pointers {
    constexpr auto PlayerCharacter = 0x105734;
}

namespace Functions {
    using GetStatNumber_Maybe = uint32_t(__fastcall*)(uint32_t, uint32_t);
    using MoveNPC_Maybe       = int(__fastcall*)(int ptr, int tile);
    using IncreaseSkill_Maybe = int(__fastcall*)(uintptr_t critterPtr, uint32_t skillIndex);

    namespace Offsets {
        constexpr auto MoveNPC_Maybe       = 0x7F69C;
        constexpr auto GetStatNumber_Maybe = 0x98898;
        constexpr auto IncreaseSkill_Maybe = 0x989f4;
    }
}

auto GetAddress(uint32_t offset) { return MODULE_BASE + offset; }

template <typename T>
T GetFunction(uint32_t offset) {
    return reinterpret_cast<T>(GetAddress(offset));
}

uintptr_t GetPointer(uint32_t offset) { return *reinterpret_cast<uintptr_t*>(GetAddress(offset)); }

namespace DoStuff {
    void LevelUp() {
        using levelUp       = void(__fastcall*)(void);
        auto levelUpAddress = 0x42c0ac;
        auto function       = reinterpret_cast<levelUp>(GetAddress(levelUpAddress));
        function();
    }

    void IncCharacterStat() {
        // 000DFE30	 000DFE04

        // uintptr_t unkArgument1 = 0x000DFE30;
        uintptr_t playerCharacter = GetPointer(Pointers::PlayerCharacter);
        uint32_t  skillIndex      = 1;
        auto      function = GetFunction<Functions::IncreaseSkill_Maybe>(Functions::Offsets::IncreaseSkill_Maybe);
        function(playerCharacter, skillIndex);
    }
}

void DoSomething() {
    // DoStuff::LevelUp();
    DoStuff::IncCharacterStat();
}

void HackThePlanet() {
    _Log_("Hack the Planet!");
    _Log_("====================");
    _Log_("Timestamp: {}", __TIMESTAMP__);
    _Log_("====================");

    _Log_("Doing the thing...");
    DoSomething();
    _Log_("Did the thing!");
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            _Log_("DLL_PROCESS_ATTACH");
            HackThePlanet();
            break;
        case DLL_THREAD_ATTACH:
            // _Log_("DLL_THREAD_ATTACH");
            break;
        case DLL_THREAD_DETACH:
            // _Log_("DLL_THREAD_DETACH");
            break;
        case DLL_PROCESS_DETACH:
            _Log_("DLL_PROCESS_DETACH");
            break;
    }
    return TRUE;
}