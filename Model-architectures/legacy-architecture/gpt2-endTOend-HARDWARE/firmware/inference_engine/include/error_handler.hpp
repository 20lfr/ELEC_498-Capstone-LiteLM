// error_handler.hpp
// Error codes and handling

#ifndef ERROR_HANDLER_HPP
#define ERROR_HANDLER_HPP

#include <string>
#include <cstdint>

enum class ErrorCode {
    NONE = 0,
    
    // Hardware errors
    HARDWARE_TIMEOUT = 1,
    HARDWARE_FAULT = 2,
    REGISTER_ACCESS_FAILED = 3,
    INTERRUPT_ERROR = 4,
    
    // Memory errors
    MEMORY_ALLOCATION_FAILED = 10,
    DDR_ACCESS_FAILED = 11,
    WEIGHT_LOAD_FAILED = 12,
    
    // Token errors
    INVALID_TOKEN = 20,
    TOKENIZATION_FAILED = 21,
    DETOKENIZATION_FAILED = 22,
    
    // Generation errors
    MAX_LENGTH_EXCEEDED = 30,
    GENERATION_ABORTED = 31,
    
    // Configuration errors
    INVALID_CONFIG = 40,
    FILE_NOT_FOUND = 41,
    
    // System errors
    INITIALIZATION_FAILED = 50,
    DEVICE_NOT_FOUND = 51,
    UIO_OPEN_FAILED = 52,
    MMAP_FAILED = 53,
    CONFIG_ERROR = 54
};

class ErrorHandler {
private:
    ErrorCode last_error;
    std::string last_error_msg;
    
public:
    ErrorHandler() : last_error(ErrorCode::NONE), last_error_msg("") {}
    
    void setError(ErrorCode code, const std::string& msg = "") {
        last_error = code;
        last_error_msg = msg;
    }
    
    void clearError() {
        last_error = ErrorCode::NONE;
        last_error_msg = "";
    }
    
    ErrorCode getLastError() const {
        return last_error;
    }
    
    std::string getLastErrorMessage() const {
        if (last_error_msg.empty()) {
            return errorCodeToString(last_error);
        }
        return last_error_msg;
    }
    
    bool hasError() const {
        return last_error != ErrorCode::NONE;
    }
    
    static std::string errorCodeToString(ErrorCode code) {
        switch(code) {
            case ErrorCode::NONE: return "No error";
            case ErrorCode::HARDWARE_TIMEOUT: return "Hardware timeout";
            case ErrorCode::HARDWARE_FAULT: return "Hardware fault";
            case ErrorCode::REGISTER_ACCESS_FAILED: return "Register access failed";
            case ErrorCode::INTERRUPT_ERROR: return "Interrupt error";
            case ErrorCode::MEMORY_ALLOCATION_FAILED: return "Memory allocation failed";
            case ErrorCode::DDR_ACCESS_FAILED: return "DDR access failed";
            case ErrorCode::WEIGHT_LOAD_FAILED: return "Weight load failed";
            case ErrorCode::INVALID_TOKEN: return "Invalid token";
            case ErrorCode::TOKENIZATION_FAILED: return "Tokenization failed";
            case ErrorCode::DETOKENIZATION_FAILED: return "Detokenization failed";
            case ErrorCode::MAX_LENGTH_EXCEEDED: return "Maximum length exceeded";
            case ErrorCode::GENERATION_ABORTED: return "Generation aborted";
            case ErrorCode::INVALID_CONFIG: return "Invalid configuration";
            case ErrorCode::FILE_NOT_FOUND: return "File not found";
            case ErrorCode::INITIALIZATION_FAILED: return "Initialization failed";
            case ErrorCode::DEVICE_NOT_FOUND: return "Device not found";
            case ErrorCode::UIO_OPEN_FAILED: return "UIO device open failed";
            case ErrorCode::MMAP_FAILED: return "Memory mapping failed";
            case ErrorCode::CONFIG_ERROR: return "Configuration error";
            default: return "Unknown error";
        }
    }
};

#endif // ERROR_HANDLER_HPP
