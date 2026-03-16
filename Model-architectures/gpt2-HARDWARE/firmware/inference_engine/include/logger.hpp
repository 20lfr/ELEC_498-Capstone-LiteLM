// logger.hpp
// Logging system with levels

#ifndef LOGGER_HPP
#define LOGGER_HPP

#include <string>
#include <cstdio>
#include <ctime>
#include <mutex>

enum class LogLevel {
    DEBUG = 0,
    INFO = 1,
    WARN = 2,
    ERROR = 3,
    FATAL = 4
};

class Logger {
private:
    LogLevel current_level;
    FILE* log_file;
    std::mutex log_mutex;
    
    const char* levelToString(LogLevel level) {
        switch(level) {
            case LogLevel::DEBUG: return "DEBUG";
            case LogLevel::INFO:  return "INFO ";
            case LogLevel::WARN:  return "WARN ";
            case LogLevel::ERROR: return "ERROR";
            case LogLevel::FATAL: return "FATAL";
            default: return "?????";
        }
    }
    
    std::string getTimestamp() {
        time_t now = time(nullptr);
        char buf[32];
        strftime(buf, sizeof(buf), "%Y-%m-%d %H:%M:%S", localtime(&now));
        return std::string(buf);
    }
    
public:
    Logger(LogLevel level = LogLevel::INFO, const char* filename = nullptr) 
        : current_level(level), log_file(stdout) {
        if (filename) {
            log_file = fopen(filename, "a");
            if (!log_file) {
                log_file = stdout;
            }
        }
    }
    
    ~Logger() {
        if (log_file && log_file != stdout && log_file != stderr) {
            fclose(log_file);
        }
    }
    
    void setLevel(LogLevel level) {
        current_level = level;
    }
    
    LogLevel level() const { return current_level; }
    
    void log(LogLevel level, const std::string& msg) {
        if (level < current_level) return;
        
        std::lock_guard<std::mutex> lock(log_mutex);
        fprintf(log_file, "[%s] [%s] %s\n", 
                getTimestamp().c_str(),
                levelToString(level),
                msg.c_str());
        fflush(log_file);
    }
    
    void debug(const std::string& msg) { log(LogLevel::DEBUG, msg); }
    void info(const std::string& msg)  { log(LogLevel::INFO, msg); }
    void warn(const std::string& msg)  { log(LogLevel::WARN, msg); }
    void error(const std::string& msg) { log(LogLevel::ERROR, msg); }
    void fatal(const std::string& msg) { log(LogLevel::FATAL, msg); }
};

// Global logger instance
extern Logger* g_logger;

#define LOG_DEBUG(msg) if(g_logger) g_logger->debug(msg)
#define LOG_INFO(msg)  if(g_logger) g_logger->info(msg)
#define LOG_WARN(msg)  if(g_logger) g_logger->warn(msg)
#define LOG_ERROR(msg) if(g_logger) g_logger->error(msg)
#define LOG_FATAL(msg) if(g_logger) g_logger->fatal(msg)

#endif // LOGGER_HPP
