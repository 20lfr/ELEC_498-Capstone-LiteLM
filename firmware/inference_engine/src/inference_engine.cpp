// inference_engine.cpp - Corrected for HLS interface
#include "config.hpp"
#include "error_handler.hpp"
#include "logger.hpp"
#include "performance_monitor.hpp"
#include "pl_interface.hpp"
#include "queue.hpp"
#include "tokenizer.hpp"
#include "types.hpp"

#include <atomic>
#include <chrono>
#include <fstream>
#include <iostream>
#include <memory>
#include <mutex>
#include <thread>
#include <vector>

Logger *g_logger = nullptr;
std::atomic<EngineStatus> g_engine_status(EngineStatus::IDLE);
std::mutex g_console_mutex;
Queue<Task, 100> g_task_queue;
Queue<Command, 10> g_command_queue;

// =============================================================================
// WeightLoader - Corrected register configuration
// =============================================================================
class WeightLoader {
    PLInterface *pl;
    Logger *logger;
    ErrorHandler *err;
    std::string weights_file;

public:
    WeightLoader(PLInterface *p, Logger *l, ErrorHandler *e)
        : pl(p), logger(l), err(e) {}
    void setWeightsFile(const std::string &f) { weights_file = f; }

    bool loadAllWeights(const ModelConfig &cfg) {
        LOG_INFO("Loading weights from " + weights_file);
        std::ifstream f(weights_file, std::ios::binary);
        if (!f) {
            err->setError(ErrorCode::FILE_NOT_FOUND, weights_file);
            return false;
        }
        f.seekg(0, std::ios::end);
        size_t sz = f.tellg();
        f.seekg(0);
        std::vector<uint8_t> data(sz);
        f.read(reinterpret_cast<char *>(data.data()), sz);
        return pl->writeDDR(0, data.data(), data.size());
    }

    bool configureAddresses(const ModelConfig &cfg, const MemoryLayout &mem) {
        if (!cfg.validate()) {
            err->setError(ErrorCode::CONFIG_ERROR,
                          "Invalid config (zero DMA/stride)");
            return false;
        }
        if (!mem.isAligned()) {
            err->setError(ErrorCode::CONFIG_ERROR,
                          "Addresses not 64-byte aligned");
            return false;
        }

        pl->beginConfig();

        // Strides (required non-zero)
        pl->writeReg(PLReg::LAYER_STRIDE, cfg.layer_stride);
        pl->writeReg(PLReg::WQ_HEAD_STRIDE, cfg.wq_head_stride);
        pl->writeReg(PLReg::WK_HEAD_STRIDE, cfg.wk_head_stride);
        pl->writeReg(PLReg::WV_HEAD_STRIDE, cfg.wv_head_stride);
        pl->writeReg(PLReg::K_CACHE_STRIDE, cfg.k_cache_stride);
        pl->writeReg(PLReg::V_CACHE_STRIDE, cfg.v_cache_stride);
        pl->writeReg(PLReg::WO_TILE_STRIDE, cfg.wo_tile_stride);
        pl->writeReg(PLReg::W1_TILE_STRIDE, cfg.w1_tile_stride);
        pl->writeReg(PLReg::W2_TILE_STRIDE, cfg.w2_tile_stride);

        // 64-bit base addresses
        pl->writeReg64(RegBus::ADDR, AddrReg::WEIGHTS_BASE_LO,
                       pl->getDDRBaseAddr());

        pl->writeReg(PLReg::WQ_OFFSET, mem.wq_offset);
        pl->writeReg(PLReg::WK_OFFSET, mem.wk_offset);
        pl->writeReg(PLReg::WV_OFFSET, mem.wv_offset);
        pl->writeReg(PLReg::WO_OFFSET, mem.wo_offset);
        pl->writeReg(PLReg::W1_OFFSET, mem.w1_offset);
        pl->writeReg(PLReg::W2_OFFSET, mem.w2_offset);
        pl->writeReg(PLReg::K_CACHE_OFFSET, mem.k_cache_offset);
        pl->writeReg(PLReg::V_CACHE_OFFSET, mem.v_cache_offset);

        // Quantization
        pl->writeReg(PLReg::LOGIT_SCALE_QV, cfg.logit_scale_qv);
        pl->writeReg(PLReg::SCALE_Q,
                     *reinterpret_cast<const uint32_t *>(&cfg.scale_q));
        pl->writeReg(PLReg::ZERO_POINT_Q,
                     static_cast<uint32_t>(cfg.zero_point_q));
        pl->writeReg(PLReg::SCALE_K,
                     *reinterpret_cast<const uint32_t *>(&cfg.scale_k));
        pl->writeReg(PLReg::ZERO_POINT_K,
                     static_cast<uint32_t>(cfg.zero_point_k));
        pl->writeReg(PLReg::SCALE_V,
                     *reinterpret_cast<const uint32_t *>(&cfg.scale_v));
        pl->writeReg(PLReg::ZERO_POINT_V,
                     static_cast<uint32_t>(cfg.zero_point_v));

        pl->endConfig();
        return !err->hasError();
    }
};

// =============================================================================
// InferenceExecutor
// =============================================================================
class InferenceExecutor {
    PLInterface *pl;
    Tokenizer *tok;
    PerformanceMonitor *perf;
    Logger *logger;
    ErrorHandler *err;

public:
    InferenceExecutor(PLInterface *p, Tokenizer *t, PerformanceMonitor *pf,
                      Logger *l, ErrorHandler *e)
        : pl(p), tok(t), perf(pf), logger(l), err(e) {}

    bool executeToken(const std::vector<uint32_t> &in,
                      std::vector<uint32_t> &out, const GenerationConfig &cfg) {
        perf->startGeneration();

        // Write input
        pl->writeDDR(0x08000000, in.data(), in.size() * sizeof(uint32_t));

        if (!pl->start()) {
            err->setError(ErrorCode::HARDWARE_FAULT, "Start failed");
            return false;
        }

        if (!pl->waitDone(cfg.max_tokens * 100))
            return false;

        // Read output
        uint32_t token;
        pl->readDDR(0x09000000, &token, sizeof(token));
        out.push_back(token);

        pl->clearIRQ();
        perf->recordToken();
        perf->endGeneration();
        return true;
    }
};

// =============================================================================
// InferenceEngine
// =============================================================================
class InferenceEngine {
    SystemConfig config;
    std::unique_ptr<PLInterface> pl;
    std::unique_ptr<Tokenizer> tokenizer;
    std::unique_ptr<PerformanceMonitor> perf;
    std::unique_ptr<WeightLoader> loader;
    std::unique_ptr<InferenceExecutor> exec;
    ErrorHandler err;
    std::thread thread;
    bool running = false;

    struct State {
        EngineStatus status = EngineStatus::IDLE;
        int taskId = -1;
        bool cancel = false;
        uint32_t tokens = 0;
        uint32_t maxTokens = 512;
        float temp = 0.7f;
        void reset() {
            status = EngineStatus::IDLE;
            taskId = -1;
            cancel = false;
            tokens = 0;
        }
    } state;

public:
    ~InferenceEngine() { shutdown(); }

    bool initialize(const std::string &cfg_file) {
        config.loadFromFile(cfg_file);
        if (!config.validate()) {
            LOG_ERROR("Invalid configuration");
            return false;
        }

        pl = std::unique_ptr<PLInterface>(
            new PLInterface(g_logger, &err, config.hardware.mock_mode));
        if (!pl->init(config.hardware.uio_device,
                      config.hardware.dmabuf_size)) {
            LOG_FATAL("PL init failed");
            return false;
        }

        if (!pl->initDMA(config.hardware.dmabuf_name,
                         config.hardware.dmabuf_size)) {
            LOG_FATAL("DDR init failed");
            return false;
        }

        tokenizer = std::unique_ptr<Tokenizer>(new Tokenizer);
        perf = std::unique_ptr<PerformanceMonitor>(new PerformanceMonitor);
        loader = std::unique_ptr<WeightLoader>(
            new WeightLoader(pl.get(), g_logger, &err));
        loader->setWeightsFile(config.model.weights_file);

        if (!loader->loadAllWeights(config.model)) {
            LOG_FATAL("Weight load failed");
            return false;
        }

        if (!loader->configureAddresses(config.model, config.memory)) {
            LOG_FATAL("Config failed");
            return false;
        }

        exec = std::unique_ptr<InferenceExecutor>(new InferenceExecutor(
            pl.get(), tokenizer.get(), perf.get(), g_logger, &err));
        LOG_INFO("Initialized");
        return true;
    }

    void start() {
        running = true;
        thread = std::thread(&InferenceEngine::loop, this);
    }

    void shutdown() {
        if (running) {
            running = false;
            g_command_queue.push(Command(CommandType::SHUTDOWN));
            if (thread.joinable())
                thread.join();
        }
    }

    bool submitTask(const Task &t) { return g_task_queue.push(t); }
    bool submitCommand(const Command &c) { return g_command_queue.push(c); }
    std::string getStats() const { return perf->getDetailedStats(); }

private:
    void loop() {
        while (running) {
            Command cmd;
            if (g_command_queue.pop(cmd)) {
                if (cmd.type == CommandType::SHUTDOWN) {
                    running = false;
                    break;
                }
                if (cmd.type == CommandType::STOP_CURRENT)
                    state.cancel = true;
                if (cmd.type == CommandType::RESET) {
                    pl->reset();
                    state.reset();
                }
                continue;
            }

            if (state.status == EngineStatus::IDLE) {
                Task task;
                if (g_task_queue.pop(task))
                    processTask(task);
                else
                    std::this_thread::sleep_for(std::chrono::milliseconds(10));
            }
        }
    }

    void processTask(const Task &task) {
        state.status = EngineStatus::GENERATING;
        state.taskId = task.id;
        state.cancel = false;
        g_engine_status = EngineStatus::GENERATING;

        auto tokens = tokenizer->encode(task.prompt);
        std::vector<uint32_t> out;

        for (uint32_t i = 0; i < state.maxTokens && !state.cancel; i++) {
            if (!exec->executeToken(tokens, out, config.generation))
                break;
            if (out.empty())
                break;
            uint32_t tok = out.back();
            if (tok == tokenizer->getEOSTokenId())
                break;
            tokens.push_back(tok);
        }

        state.status = EngineStatus::IDLE;
        g_engine_status = EngineStatus::IDLE;
    }

    void print(const std::string &s) {
        std::lock_guard<std::mutex> lk(g_console_mutex);
        std::cout << s << std::flush;
    }
};

// =============================================================================
// Main
// =============================================================================
int main(int argc, char *argv[]) {
    std::cout << "FPGA Transformer Inference Engine\n";

    LogLevel lvl = (argc > 1 && std::string(argv[1]) == "--debug")
                       ? LogLevel::DEBUG
                       : LogLevel::INFO;
    g_logger = new Logger(lvl, "inference.log");

    std::string cfg = "config.yaml";
    for (int i = 1; i < argc - 1; i++)
        if (std::string(argv[i]) == "--config")
            cfg = argv[i + 1];

    InferenceEngine engine;
    if (!engine.initialize(cfg)) {
        LOG_FATAL("Init failed");
        delete g_logger;
        return 1;
    }

    engine.start();
    std::cout << "Commands: /quit /stop /reset /stats\n> ";

    int taskId = 1;
    std::string input;
    while (std::getline(std::cin, input)) {
        if (input.empty()) {
            std::cout << "> ";
            continue;
        }
        if (input == "/quit") {
            engine.submitCommand(Command(CommandType::SHUTDOWN));
            break;
        }
        if (input == "/stop") {
            engine.submitCommand(Command(CommandType::STOP_CURRENT));
        } else if (input == "/reset") {
            engine.submitCommand(Command(CommandType::RESET));
        } else if (input == "/stats") {
            std::cout << engine.getStats() << "\n";
        } else {
            engine.submitTask(Task(taskId++, TaskType::GENERATE, input));
        }
        std::cout << "> ";
    }

    engine.shutdown();
    delete g_logger;
    return 0;
}
