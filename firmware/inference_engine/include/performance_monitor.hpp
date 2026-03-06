// performance_monitor.hpp
// Performance tracking and metrics

#ifndef PERFORMANCE_MONITOR_HPP
#define PERFORMANCE_MONITOR_HPP

#include <chrono>
#include <cstdint>
#include <string>

class PerformanceMonitor {
private:
    std::chrono::high_resolution_clock::time_point start_time;
    std::chrono::high_resolution_clock::time_point last_token_time;

    uint32_t tokens_generated;
    uint32_t total_inference_ms;
    uint32_t num_inferences;

public:
    PerformanceMonitor()
        : tokens_generated(0), total_inference_ms(0), num_inferences(0) {}

    void startGeneration() {
        start_time = std::chrono::high_resolution_clock::now();
        last_token_time = start_time;
        tokens_generated = 0;
    }

    void recordToken() {
        auto now = std::chrono::high_resolution_clock::now();
        last_token_time = now;
        tokens_generated++;
    }

    void endGeneration() {
        auto now = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(
                            now - start_time)
                            .count();

        total_inference_ms += duration;
        num_inferences++;
    }

    double getTokensPerSecond() const {
        auto now = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(
                            now - start_time)
                            .count();

        if (duration == 0)
            return 0.0;
        return (tokens_generated * 1000.0) / duration;
    }

    double getAverageLatency() const {
        if (tokens_generated == 0)
            return 0.0;

        auto now = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(
                            now - start_time)
                            .count();

        return static_cast<double>(duration) / tokens_generated;
    }

    double getAverageInferenceTime() const {
        if (num_inferences == 0)
            return 0.0;
        return static_cast<double>(total_inference_ms) / num_inferences;
    }

    uint32_t getTokensGenerated() const { return tokens_generated; }
    uint32_t getTotalInferences() const { return num_inferences; }

    std::string getDetailedStats() const {
        char buf[256];
        snprintf(buf, sizeof(buf),
                 "Tokens: %u | TPS: %.2f | Latency: %.2f ms | Avg Inference: "
                 "%.2f ms",
                 tokens_generated, getTokensPerSecond(), getAverageLatency(),
                 getAverageInferenceTime());
        return std::string(buf);
    }

    void reset() {
        tokens_generated = 0;
        total_inference_ms = 0;
        num_inferences = 0;
    }
};

#endif // PERFORMANCE_MONITOR_HPP
