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
#include <cstring>
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
// WeightLoader — loads DDR image + programs config registers
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
                          "Invalid config (zero DMA length or stride)");
            return false;
        }
        if (!mem.isAligned()) {
            err->setError(ErrorCode::CONFIG_ERROR,
                          "Addresses not 64-byte aligned");
            return false;
        }

        // beginConfig: disables IRQs, sets IRQ clear high
        pl->beginConfig();

        // Strides
        pl->writeReg(PLReg::LAYER_STRIDE, cfg.layer_stride);
        pl->writeReg(PLReg::WQ_HEAD_STRIDE, cfg.wq_head_stride);
        pl->writeReg(PLReg::WK_HEAD_STRIDE, cfg.wk_head_stride);
        pl->writeReg(PLReg::WV_HEAD_STRIDE, cfg.wv_head_stride);
        pl->writeReg(PLReg::K_CACHE_STRIDE, cfg.k_cache_stride);
        pl->writeReg(PLReg::V_CACHE_STRIDE, cfg.v_cache_stride);
        pl->writeReg(PLReg::WO_TILE_STRIDE, cfg.wo_tile_stride);
        pl->writeReg(PLReg::W1_TILE_STRIDE, cfg.w1_tile_stride);
        pl->writeReg(PLReg::W2_TILE_STRIDE, cfg.w2_tile_stride);
        pl->writeReg(PLReg::WO_BIAS_TILE_STRIDE, cfg.wo_bias_tile_stride);
        pl->writeReg(PLReg::W1_BIAS_TILE_STRIDE, cfg.w1_bias_tile_stride);
        pl->writeReg(PLReg::W2_BIAS_TILE_STRIDE, cfg.w2_bias_tile_stride);
        pl->writeReg(PLReg::WLOGIT_TILE_STRIDE, cfg.wlogit_tile_stride);
        pl->writeReg(PLReg::LN0_GAMMA_STRIDE, cfg.ln0_gamma_stride);
        pl->writeReg(PLReg::LN1_GAMMA_STRIDE, cfg.ln1_gamma_stride);
        pl->writeReg(PLReg::FINAL_NORM_GAMMA_STRIDE,
                     cfg.final_norm_gamma_stride);
        pl->writeReg(PLReg::LN0_EPS_STRIDE, cfg.ln0_eps_stride);
        pl->writeReg(PLReg::LN1_EPS_STRIDE, cfg.ln1_eps_stride);
        pl->writeReg(PLReg::FINAL_NORM_EPS_STRIDE, cfg.final_norm_eps_stride);

        // 64-bit DDR base addresses (on control_r bus)
        pl->writeReg64(RegBus::ADDR, AddrReg::WEIGHTS_BASE_LO,
                       pl->getDDRBaseAddr());

        // Weight / KV-cache offsets
        pl->writeReg(PLReg::WQ_OFFSET, mem.wq_offset);
        pl->writeReg(PLReg::WK_OFFSET, mem.wk_offset);
        pl->writeReg(PLReg::WV_OFFSET, mem.wv_offset);
        pl->writeReg(PLReg::WO_OFFSET, mem.wo_offset);
        pl->writeReg(PLReg::W1_OFFSET, mem.w1_offset);
        pl->writeReg(PLReg::W2_OFFSET, mem.w2_offset);
        pl->writeReg(PLReg::K_CACHE_OFFSET, mem.k_cache_offset);
        pl->writeReg(PLReg::V_CACHE_OFFSET, mem.v_cache_offset);

        // endConfig: clears IRQ clear, enables IRQs, checks for config errors
        pl->endConfig();
        return !err->hasError();
    }
};

// =============================================================================
// InferenceExecutor — single start pulse, autonomous PL, stream argmax readback
// Uses only: start(), clearRegBits(), waitDone(), clearIRQ(),
//            streamInitSend/Recv(), streamWaitSend/Recv(), readDDR()
// =============================================================================
class InferenceExecutor {
    PLInterface *pl;
    Tokenizer *tok;
    PerformanceMonitor *perf;
    Logger *logger;
    ErrorHandler *err;

    uint32_t vocab_size;
    uint32_t input_offset;  // DMA buffer offset for stream in staging
    uint32_t output_offset; // DMA buffer offset for stream out staging
    uint32_t timeout_ms;

    // Embedding table: vocab_size x STREAM_IN_BUF_BYTES, held in process memory
    std::vector<uint8_t> embedding_table;

public:
    InferenceExecutor(PLInterface *p, Tokenizer *t, PerformanceMonitor *pf,
                      Logger *l, ErrorHandler *e, uint32_t vocab_sz,
                      uint32_t in_off, uint32_t out_off, uint32_t tmo_ms)
        : pl(p), tok(t), perf(pf), logger(l), err(e), vocab_size(vocab_sz),
          input_offset(in_off), output_offset(out_off), timeout_ms(tmo_ms) {}

    /** Load embedding table from file into process memory. */
    bool loadEmbeddingTable(const std::string &path) {
        size_t expected = static_cast<size_t>(vocab_size) * STREAM_IN_BUF_BYTES;

        std::ifstream f(path, std::ios::binary);
        if (!f) {
            err->setError(ErrorCode::FILE_NOT_FOUND,
                          "Cannot open embedding file: " + path);
            return false;
        }

        f.seekg(0, std::ios::end);
        size_t file_size = f.tellg();
        f.seekg(0);

        if (file_size < expected) {
            err->setError(
                ErrorCode::FILE_NOT_FOUND,
                "Embedding file too small: " + std::to_string(file_size) +
                    " bytes, expected " + std::to_string(expected));
            return false;
        }

        embedding_table.resize(expected);
        f.read(reinterpret_cast<char *>(embedding_table.data()), expected);

        LOG_INFO("Loaded embedding table into process memory: " +
                 std::to_string(vocab_size) + " x " +
                 std::to_string(STREAM_IN_BUF_BYTES) + " bytes");
        return true;
    }

    /** Execute one forward pass through the PL for a single token.
     *  Returns the argmax token ID computed by the FPGA. */
    bool executeToken(uint32_t token_id, uint32_t &out_token) {
        perf->startGeneration();

        uint8_t send_buf[STREAM_IN_BUF_BYTES];
        if (!lookupEmbedding(token_id, send_buf))
            return false;

        if (!pl->streamInitRecv(output_offset, STREAM_OUT_BUF_BYTES)) {
            err->setError(ErrorCode::HARDWARE_FAULT, "streamInitRecv failed");
            return false;
        }

        if (!pl->streamInitSend(input_offset, send_buf, STREAM_IN_BUF_BYTES)) {
            err->setError(ErrorCode::HARDWARE_FAULT, "streamInitSend failed");
            return false;
        }

        if (!pl->start()) {
            err->setError(ErrorCode::HARDWARE_FAULT, "Start failed");
            return false;
        }

        pl->writeReg(PLReg::CONTROL, CTRL_START_BIT | CTRL_RESETN_BIT);

        usleep(10);
        pl->clearRegBits(PLReg::CONTROL, CTRL_START_BIT);

        if (!pl->streamWaitSend(timeout_ms)) {
            LOG_ERROR("Stream send timeout: " + pl->streamStatusString());
            err->setError(ErrorCode::HARDWARE_TIMEOUT, "Stream in DMA timeout");
            return false;
        }

        if (!pl->waitDone(timeout_ms)) {
            logPLStatus("waitDone failed");
            return false;
        }

        // Check for PL error after completion
        if (pl->isError()) {
            logPLStatus("PL error after INFER_DONE");
            err->setError(ErrorCode::HARDWARE_FAULT,
                          "PL error: " + pl->getErrorCodeString());
            pl->clearIRQ();
            return false;
        }

        uint8_t recv_buf[STREAM_OUT_BUF_BYTES] = {};
        if (!pl->streamWaitRecv(output_offset, recv_buf, STREAM_OUT_BUF_BYTES,
                                timeout_ms)) {
            LOG_ERROR("Stream recv timeout: " + pl->streamStatusString());
            err->setError(ErrorCode::HARDWARE_TIMEOUT,
                          "Stream out DMA timeout");
            return false;
        }

        // Decode little-endian int32 (matches testbench stream out decode)
        out_token = static_cast<uint32_t>(recv_buf[0]) |
                    (static_cast<uint32_t>(recv_buf[1]) << 8) |
                    (static_cast<uint32_t>(recv_buf[2]) << 16) |
                    (static_cast<uint32_t>(recv_buf[3]) << 24);

        // 8. Clear IRQ so PL is ready for next token
        //    clearIRQ() pulses IRQ_CLEAR high then low.
        pl->clearIRQ();

        perf->recordToken();
        perf->endGeneration();
        return true;
    }

private:
    bool lookupEmbedding(uint32_t token_id, uint8_t *out) {
        if (embedding_table.empty()) {
            // Fallback: test pattern matching testbench stream_in behavior
            LOG_WARN("No embedding table loaded, using test pattern");
            for (int i = 0; i < STREAM_IN_BUF_BYTES; i++)
                out[i] = static_cast<uint8_t>(i & 0xFF);
            return true;
        }
        if (token_id >= vocab_size) {
            LOG_ERROR("Token ID " + std::to_string(token_id) +
                      " out of range (" + std::to_string(vocab_size) + ")");
            err->setError(ErrorCode::INVALID_TOKEN, "Token out of range");
            return false;
        }
        size_t offset = static_cast<size_t>(token_id) * STREAM_IN_BUF_BYTES;
        memcpy(out, &embedding_table[offset], STREAM_IN_BUF_BYTES);
        return true;
    }

    /** Dump all PL status registers to the log for diagnostics. */
    void logPLStatus(const char *context) {
        char buf[512];
        snprintf(buf, sizeof(buf), "[%s] %s %s", context,
                 pl->getRegStats(true).c_str(),
                 err->getLastErrorMessage().c_str());
        LOG_ERROR(std::string(buf));
    }
};

// =============================================================================
// InferenceEngine — task queue, command queue, background thread
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

        // init() opens UIO, maps registers, sets AP_AUTO_RESTART,
        // calls reset() which asserts/deasserts RESETN and resets streams.
        pl = std::unique_ptr<PLInterface>(
            new PLInterface(g_logger, &err, config.hardware.mock_mode));
        if (!pl->init(config.hardware.uio_device,
                      config.hardware.stream_reg_base_addr)) {
            LOG_FATAL("PL init failed");
            return false;
        }

        // initDMA() allocates the contiguous DMA buffer via u-dma-buf.
        if (!pl->initDMA(config.hardware.dmabuf_name,
                         config.hardware.dmabuf_size)) {
            LOG_FATAL("DDR init failed");
            return false;
        }

        tokenizer = std::unique_ptr<Tokenizer>(new Tokenizer);
        if (!tokenizer->loadVocabulary(config.model.tokenizer_vocab)) {
            LOG_FATAL("Tokenizer vocab load failed");
            return false;
        }

        perf = std::unique_ptr<PerformanceMonitor>(new PerformanceMonitor);

        loader = std::unique_ptr<WeightLoader>(
            new WeightLoader(pl.get(), g_logger, &err));
        loader->setWeightsFile(config.model.weights_file);

        // Load binary weights into DDR via writeDDR
        if (!loader->loadAllWeights(config.model)) {
            LOG_FATAL("Weight load failed");
            return false;
        }

        if (!loader->configureAddresses(config.model, config.memory)) {
            LOG_FATAL("Config failed");
            return false;
        }

        exec = std::unique_ptr<InferenceExecutor>(new InferenceExecutor(
            pl.get(), tokenizer.get(), perf.get(), g_logger, &err,
            config.model.vocab_size, config.memory.input_offset,
            config.memory.output_offset, config.hardware.timeout_ms));

        // Load embedding table from file into process memory
        if (!config.model.embeddings_file.empty()) {
            if (!exec->loadEmbeddingTable(config.model.embeddings_file)) {
                LOG_WARN("Embedding load failed, using test patterns");
            }
        } else {
            LOG_WARN("No embeddings_file configured, using test patterns");
        }

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
    std::string getPerfStats() const { return perf->getDetailedStats(); }
    std::string getRegStats() const { return pl->getRegStats(); }

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

        for (uint32_t i = 0; i < state.maxTokens && !state.cancel; i++) {
            uint32_t input_token = tokens.back();
            uint32_t out_token = 0;

            if (!exec->executeToken(input_token, out_token))
                break;

            // Stream decoded token to console as it's produced
            std::string decoded = tokenizer->decodeToken(out_token);
            if (!decoded.empty())
                print(decoded);

            if (out_token == tokenizer->getEOSTokenId())
                break;

            tokens.push_back(out_token);
        }

        print("\n");
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
    std::cout << "Commands: /quit /stop /reset /stats_perf /stats_reg\n> ";

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
        } else if (input == "/stats_perf") {
            std::cout << engine.getPerfStats() << "\n";
        } else if (input == "/stats_reg") {
            std::cout << engine.getRegStats() << "\n";
        } else {
            engine.submitTask(Task(taskId++, TaskType::GENERATE, input));
        }
        std::cout << "> ";
    }

    engine.shutdown();
    delete g_logger;
    return 0;
}
