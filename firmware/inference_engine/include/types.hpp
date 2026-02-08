// types.hpp - Core types
#ifndef TYPES_HPP
#define TYPES_HPP

#include <string>
#include <vector>
#include <cstdint>

enum class TaskType { GENERATE };

struct Task {
    int id = 0;
    TaskType type = TaskType::GENERATE;
    std::string prompt;
    std::vector<uint32_t> prompt_tokens;
    uint32_t max_tokens = 0;
    
    Task() = default;
    Task(int i, TaskType t, const std::string& p) : id(i), type(t), prompt(p) {}
};

enum class CommandType {
    STOP_CURRENT,
    RESET,
    SHUTDOWN,
    SET_TEMPERATURE,
    SET_MAX_TOKENS
};

struct Command {
    CommandType type;
    float float_value = 0;
    uint32_t uint_value = 0;
    
    Command() : type(CommandType::SHUTDOWN) {}
    Command(CommandType t) : type(t) {}
    
    static Command Shutdown() { return Command(CommandType::SHUTDOWN); }
    static Command Stop() { return Command(CommandType::STOP_CURRENT); }
    static Command Reset() { return Command(CommandType::RESET); }
    static Command SetTemperature(float t) { Command c(CommandType::SET_TEMPERATURE); c.float_value = t; return c; }
    static Command SetMaxTokens(uint32_t n) { Command c(CommandType::SET_MAX_TOKENS); c.uint_value = n; return c; }
};

enum class EngineStatus {
    IDLE,
    LOADING_WEIGHTS,
    GENERATING,
    SHUTTING_DOWN
};

struct EngineState {
    EngineStatus status = EngineStatus::IDLE;
    int currentTaskId = -1;
    bool cancelCurrent = false;
    bool resetRequested = false;
    uint32_t tokensGenerated = 0;
    uint32_t maxTokens = 512;
    float currentTemperature = 0.7f;
    
    void reset() {
        status = EngineStatus::IDLE;
        currentTaskId = -1;
        cancelCurrent = false;
        resetRequested = false;
        tokensGenerated = 0;
    }
};

#endif
