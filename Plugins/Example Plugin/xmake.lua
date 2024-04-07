add_requires("_Log_", "spdlog")

target("Example CE Plugin")
  set_kind("shared")
  add_files("*.cpp")
  add_includedirs("../Cheat Engine Resources/include")
  add_linkdirs("../Cheat Engine Resources/lib")
  add_packages("_Log_", "spdlog")
