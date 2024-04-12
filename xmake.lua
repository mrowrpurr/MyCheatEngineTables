add_rules("mode.debug", "mode.release")

set_languages("c++20")

add_repositories("MrowrLib https://github.com/MrowrLib/Packages.git")
add_repositories("ModdingFramework https://github.com/ModdingFramework/Packages.git")

add_defines("_CRT_SECURE_NO_WARNINGS")

includes("Cpp/**/xmake.lua")
