#include <_Log_.h>
#include <windows.h>

#include <string_view>

class NamedPipeServer {
private:
    HANDLE             pipe;
    const std::wstring pipeName;

public:
    NamedPipeServer(std::wstring_view name) : pipeName{L"\\\\.\\pipe\\" + std::wstring{name}} {
        _Log_("Creating named pipe...");
        pipe = CreateNamedPipeW(
            pipeName.c_str(), PIPE_ACCESS_OUTBOUND, PIPE_TYPE_BYTE | PIPE_READMODE_BYTE | PIPE_WAIT,
            1,       // Only one instance
            1024,    // Out buffer size
            1024,    // In buffer size
            0,       // Default timeout
            nullptr  // Default security attributes
        );

        if (pipe == INVALID_HANDLE_VALUE) _Log_("Failed to create pipe.");
        else _Log_("Pipe created successfully.");
    }

    ~NamedPipeServer() {
        _Log_("Destroying named pipe...");
        shutdown();
        CloseHandle(pipe);
        _Log_("Pipe destroyed successfully.");
    }

    void waitForClient() {
        _Log_("Waiting for client connection...");
        if (!ConnectNamedPipe(pipe, nullptr)) _Log_("Failed to connect named pipe.");
        else _Log_("Client connected.");
    }

    void sendMessage(std::string_view message) {
        DWORD written;
        if (!WriteFile(pipe, message.data(), static_cast<DWORD>(message.size()), &written, nullptr))
            _Log_("Failed to send message.");
        else _Log_("Message sent successfully.");
    }

    void shutdown() {
        if (pipe != INVALID_HANDLE_VALUE) {
            DisconnectNamedPipe(pipe);
            _Log_("Pipe disconnected successfully.");
        } else _Log_("Pipe is already disconnected.");
    }
};
