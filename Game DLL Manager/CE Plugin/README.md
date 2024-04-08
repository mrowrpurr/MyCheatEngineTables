# `Game DLL Library` : `CE Plugin`

- Provides Lua functions for the following:
  - `GameLibraryManager_Start()`
    - Sets up a named pipe (_for now, always the same name_)
  - `GameLibraryManager_Stop() `
  - `GameLibraryManager_LoadDLL("Path/to/DLL.dll") `
  - `GameLibraryManager_UnloadDLL("Path/to/DLL.dll") `
  - `GameLibraryManager_CallFunction("FunctionName", ...)`
