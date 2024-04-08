#include <_Log_.h>
#include <windows.h>

#include <string_view>

class NamedPipeClient {
private:
    HANDLE             pipe;
    const std::wstring pipeName;
    bool               isConnected;

public:
    NamedPipeClient(std::wstring_view name) : pipeName{L"\\\\.\\pipe\\" + std::wstring{name}}, isConnected(false) {
        _Log_("Connecting to named pipe...");
        pipe = CreateFileW(
            pipeName.c_str(), GENERIC_READ,
            0,        // No sharing
            nullptr,  // Default security attributes
            OPEN_EXISTING,
            0,       // Default attributes
            nullptr  // No template file
        );

        if (pipe == INVALID_HANDLE_VALUE) {
            _Log_("Failed to connect to pipe. Ensure that the server is running.");
            isConnected = false;
        } else {
            _Log_("Connected to pipe successfully.");
            isConnected = true;
        }
    }

    ~NamedPipeClient() { shutdown(); }

    void listenForMessages() {
        if (!isConnected) {
            _Log_("Not connected to any pipe.");
            return;
        }

        char  buffer[1024];
        DWORD read;
        while (isConnected) {
            bool success = ReadFile(pipe, buffer, sizeof(buffer), &read, nullptr);
            if (!success || read == 0) {
                if (GetLastError() == ERROR_BROKEN_PIPE) {
                    _Log_("Server closed the connection.");
                }
                break;
            }
            _Log_("Received message: {}", std::string{buffer, read});
        }
    }

    void shutdown() {
        if (pipe != INVALID_HANDLE_VALUE) {
            _Log_("Shutting down the client...");
            CloseHandle(pipe);
            pipe        = INVALID_HANDLE_VALUE;
            isConnected = false;
            _Log_("Client shutdown successfully.");
        }
    }
};
