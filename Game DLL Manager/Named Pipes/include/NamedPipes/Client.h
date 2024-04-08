#include <_Log_.h>
#include <windows.h>

#include <string_view>

class NamedPipeClient {
private:
    HANDLE             pipe;
    const std::wstring pipeName;

public:
    NamedPipeClient(std::wstring_view name) : pipeName{L"\\\\.\\pipe\\" + std::wstring{name}} {
        _Log_("Connecting to named pipe...");
        pipe = CreateFileW(
            pipeName.c_str(), GENERIC_READ,
            0,        // No sharing
            nullptr,  // Default security attributes
            OPEN_EXISTING,
            0,       // Default attributes
            nullptr  // No template file
        );

        if (pipe == INVALID_HANDLE_VALUE) _Log_("Failed to connect to pipe. Ensure that the server is running.");
        else _Log_("Connected to pipe successfully.");
    }

    ~NamedPipeClient() {
        _Log_("Destroying named pipe client...");
        CloseHandle(pipe);
        _Log_("Pipe client destroyed successfully.");
    }

    void listenForMessages() {
        char  buffer[1024];
        DWORD read;
        while (true) {
            bool success = ReadFile(pipe, buffer, sizeof(buffer), &read, nullptr);
            if (!success || read == 0) break;
            _Log_("Received message: {}", std::string{buffer, read});
        }
        _Log_("Server closed the connection.");
    }
};
