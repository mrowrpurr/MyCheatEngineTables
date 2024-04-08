add_rules("mode.debug", "mode.release")

set_languages("c++20")

add_repositories("MrowrLib https://github.com/MrowrLib/Packages.git")

includes("Plugins")
includes("Game DLL Manager")
