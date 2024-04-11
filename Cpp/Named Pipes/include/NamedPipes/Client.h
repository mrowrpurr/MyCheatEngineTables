#include <_Log_.h>
#include <windows.h>

#include <functional>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>

struct CommandTextMessage {
    std::string command;
    std::string text;
};

constexpr auto MESSAGE_COMMAND_SEPARATOR = '|';

class NamedPipeClient {
private:
    static constexpr auto                                                            bufferSize = 4096;
    HANDLE                                                                           pipe;
    const std::wstring                                                               pipeName;
    bool                                                                             isConnected;
    std::unordered_map<std::string, std::function<void(const std::string& message)>> messageHandlers;

    std::optional<CommandTextMessage> ExtractCommandAndMessage(const std::string& message) {
        auto pos = message.find(MESSAGE_COMMAND_SEPARATOR);
        if (pos == std::string::npos) return std::nullopt;
        return CommandTextMessage{message.substr(0, pos), message.substr(pos + 1)};
    }

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

    void addMessageHandler(std::string_view command, std::function<void(const std::string& message)> handler) {
        messageHandlers.emplace(command, handler);
    }

    void listenForMessages() {
        if (!isConnected) {
            _Log_("Not connected to any pipe.");
            return;
        }

        char  buffer[bufferSize];
        DWORD read;
        while (isConnected) {
            bool success = ReadFile(pipe, buffer, sizeof(buffer), &read, nullptr);
            if (!success || read == 0) {
                if (GetLastError() == ERROR_BROKEN_PIPE) _Log_("Server closed the connection.");
                break;
            }

            auto text = std::string{buffer, read};
            _Log_("Received message: {}", text);

            auto commandText = ExtractCommandAndMessage(std::string{buffer, read});
            if (commandText.has_value()) {
                if (auto handler = messageHandlers.find(commandText->command); handler != messageHandlers.end()) {
                    _Log_("Handling command [{}] with message {}", commandText->command, commandText->text);
                    handler->second(text);
                } else {
                    _Log_("No handler found for message: {}", text);
                }
            } else {
                _Log_("Invalid message without command: {}", std::string{buffer, read});
            }
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
