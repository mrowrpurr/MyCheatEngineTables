# `Game DLL Library` : `Game DLL`

## Communication with Cheat Engine

- Communicates over named pipe (_provided by `CE Plugin`_)
  - Commands:
    - `Stop`
    - `LoadDLL("Path/to/DLL.dll")`
    - `UnloadDLL("Path/to/DLL.dll")`
    - `CallFunction("FunctionName", ...)`

## Communication with loaded libraries

- Initializes each loaded library with a pointer to the library manager's API
