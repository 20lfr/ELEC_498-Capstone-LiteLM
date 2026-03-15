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
#include <unistd.h>
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
    ErrorHandler *err;
    std::string weights_file;
    static constexpr size_t kWeightLoadChunkBytes = 32 * 1024 * 1024;

public:
    WeightLoader(PLInterface *p, ErrorHandler *e) : pl(p), err(e) {}
    void setWeightsFile(const std::string &f) { weights_file = f; }

    bool loadAllWeights(const ModelConfig &model_cfg, size_t max_bytes = 0) {
        LOG_INFO("Loading weights from " + weights_file);
        std::ifstream f(weights_file, std::ios::binary);
        if (!f) {
            err->setError(ErrorCode::FILE_NOT_FOUND, weights_file);
            return false;
        }
        f.seekg(0, std::ios::end);
        const std::streamoff file_size_off = f.tellg();
        if (file_size_off < 0) {
            err->setError(ErrorCode::FILE_NOT_FOUND,
                          "Failed to determine weight file size");
            return false;
        }
        const size_t file_size = static_cast<size_t>(file_size_off);
        f.seekg(0, std::ios::beg);

        // Only load what the FPGA will actually read
        size_t load_size = file_size;
        if (max_bytes > 0 && max_bytes < load_size)
            load_size = max_bytes;

        LOG_INFO("Loading " + std::to_string(load_size / 1024) + " KB of " +
                 std::to_string(file_size / 1024 / 1024) + " MB total");

        std::vector<uint8_t> chunk(kWeightLoadChunkBytes);
        size_t ddr_offset = 0;

        while (f && ddr_offset < load_size) {
            size_t remaining = load_size - ddr_offset;
            size_t to_read =
                (remaining < chunk.size()) ? remaining : chunk.size();

            f.read(reinterpret_cast<char *>(chunk.data()),
                   static_cast<std::streamsize>(to_read));
            const std::streamsize bytes_read = f.gcount();

            if (bytes_read < 0) {
                err->setError(ErrorCode::FILE_NOT_FOUND,
                              "Error while reading weights file");
                return false;
            }
            if (bytes_read == 0) {
                break;
            }

            if (!pl->writeDDR(DmaBufType::BUF0,
                              static_cast<uint32_t>(ddr_offset), chunk.data(),
                              static_cast<size_t>(bytes_read))) {
                err->setError(ErrorCode::HARDWARE_FAULT,
                              "Staged DDR write failed at offset " +
                                  std::to_string(ddr_offset));
                return false;
            }

            ddr_offset += static_cast<size_t>(bytes_read);
        }

        if (ddr_offset < load_size && !f.eof() && f.fail()) {
            err->setError(ErrorCode::FILE_NOT_FOUND,
                          "Failed before finishing staged weights read");
            return false;
        }

        LOG_INFO("Loaded " + std::to_string(ddr_offset) + " bytes into BUF0");
        return true;
    }

    bool configureAddresses(const ModelConfig &model_cfg,
                            const MemoryLayout &mem) {
        if (!model_cfg.validate()) {
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

        // 64-bit DDR base addresses (on control_r bus)
        pl->writeReg64(RegBus::ADDR, AddrReg::WEIGHTS_BASE_LO,
                       pl->getDDRBaseAddr(DmaBufType::BUF0));
        pl->writeReg64(RegBus::ADDR, AddrReg::KV_CACHE_BASE_LO,
                       pl->getDDRBaseAddr(DmaBufType::BUF1));

        // Words 3-10: Weights / KV-cache offsets
        pl->writeReg(PLReg::WQ_OFFSET, mem.wq_offset);
        pl->writeReg(PLReg::WK_OFFSET, mem.wk_offset);
        pl->writeReg(PLReg::WV_OFFSET, mem.wv_offset);
        pl->writeReg(PLReg::WO_OFFSET, mem.wo_offset);
        pl->writeReg(PLReg::W1_OFFSET, mem.w1_offset);
        pl->writeReg(PLReg::W2_OFFSET, mem.w2_offset);
        pl->writeReg(PLReg::K_CACHE_OFFSET, mem.k_cache_offset);
        pl->writeReg(PLReg::V_CACHE_OFFSET, mem.v_cache_offset);

        // Words 11-20: Bias and parameter offsets
        pl->writeReg(PLReg::WO_BIAS_OFFSET, mem.wo_bias_offset);
        pl->writeReg(PLReg::W1_BIAS_OFFSET, mem.w1_bias_offset);
        pl->writeReg(PLReg::W2_BIAS_OFFSET, mem.w2_bias_offset);
        pl->writeReg(PLReg::LN0_GAMMA_OFFSET, mem.ln0_gamma_offset);
        pl->writeReg(PLReg::LN1_GAMMA_OFFSET, mem.ln1_gamma_offset);
        pl->writeReg(PLReg::FINAL_NORM_GAMMA_OFFSET,
                     mem.final_norm_gamma_offset);
        pl->writeReg(PLReg::LN0_EPS_OFFSET, mem.ln0_eps_offset);
        pl->writeReg(PLReg::LN1_EPS_OFFSET, mem.ln1_eps_offset);
        pl->writeReg(PLReg::FINAL_NORM_EPS_OFFSET, mem.final_norm_eps_offset);
        pl->writeReg(PLReg::WLOGIT_OFFSET, mem.wlogit_offset);

        // Word 21: GPT-2 extensions
        pl->writeReg(PLReg::TOKEN_POSITION, 0);

        // endConfig: clears IRQ clear, enables IRQs, checks for config errors
        pl->endConfig();
        if (err->hasError()) {
            LOG_ERROR("Config error, register dump:\n" + pl->dumpCtrlMem());
        }
        return !err->hasError();
    }
};

// =============================================================================
// InferenceExecutor — handles executeToken(), readDDR()
// =============================================================================
class InferenceExecutor {
    PLInterface *pl;
    Tokenizer *tok;
    PerformanceMonitor *perf;
    ErrorHandler *err;
    ModelConfig model_cfg;

    uint32_t input_offset;  // DMA buffer offset for stream in staging
    uint32_t output_offset; // DMA buffer offset for stream out staging
    uint32_t timeout_ms;
    bool debug_mode;

    // Embedding table: vocab_size x hidden_size, held in process memory
    std::vector<int8_t> embedding_table;

    // Position embedding table: context_length x hidden_size (GPT-2 learned
    // positions)
    std::vector<int8_t> pos_embedding_table;

public:
    InferenceExecutor(PLInterface *p, Tokenizer *t, PerformanceMonitor *pf,
                      ErrorHandler *e, const ModelConfig &m_cfg,
                      uint32_t in_off, uint32_t out_off, uint32_t tmo_ms,
                      bool debug = false)
        : pl(p), tok(t), perf(pf), err(e), model_cfg(m_cfg),
          input_offset(in_off), output_offset(out_off), timeout_ms(tmo_ms),
          debug_mode(debug) {}

    /** Load embedding table from file into process memory. */
    bool loadEmbeddingTable(const std::string &path) {
        size_t expected =
            static_cast<size_t>(model_cfg.vocab_size) * model_cfg.hidden_size;

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

        LOG_INFO(
            "Loaded embedding table: " + std::to_string(model_cfg.vocab_size) +
            " x " + std::to_string(model_cfg.hidden_size) + " bytes");
        return true;
    }

    /** Load position embedding table from file into process memory (GPT-2). */
    bool loadPositionEmbeddings(const std::string &path) {
        size_t expected = static_cast<size_t>(model_cfg.context_length) *
                          model_cfg.hidden_size;

        std::ifstream f(path, std::ios::binary);
        if (!f) {
            err->setError(ErrorCode::FILE_NOT_FOUND,
                          "Cannot open position embedding file: " + path);
            return false;
        }

        f.seekg(0, std::ios::end);
        size_t file_size = f.tellg();
        f.seekg(0);

        if (file_size < expected) {
            err->setError(ErrorCode::FILE_NOT_FOUND,
                          "Position embedding file too small: " +
                              std::to_string(file_size) + " bytes, expected " +
                              std::to_string(expected));
            return false;
        }

        pos_embedding_table.resize(expected);
        f.read(reinterpret_cast<char *>(pos_embedding_table.data()), expected);

        LOG_INFO("Loaded position embeddings: " +
                 std::to_string(model_cfg.context_length) + " x " +
                 std::to_string(model_cfg.hidden_size) + " bytes");
        return true;
    }

    /** Execute one forward pass through the PL for a single token.
     *  Returns the argmax token ID computed by the FPGA. */
    bool executeToken(uint32_t token_id, uint32_t token_position,
                      uint32_t &out_token) {
        perf->startGeneration();

        LOG_DEBUG("executeToken: token_id=" + std::to_string(token_id) +
                  " pos=" + std::to_string(token_position));

        std::vector<int8_t> send_buf(model_cfg.stream_in_size);
        if (!lookupEmbedding(token_id, token_position, send_buf.data()))
            return false;

        if (!pl->streamInitRecv(output_offset, model_cfg.stream_out_size)) {
            logPLStatus("streamInitRecv failed");
            return false;
        }

        if (!pl->streamInitSend(input_offset, send_buf.data(),
                                model_cfg.stream_in_size)) {
            logPLStatus("streamInitSend failed");
            return false;
        }

        // Build CONTROL word: RESETN | START, optionally | DEBUG_MODE
        uint32_t ctrl_bits = CTRL_RESETN_BIT | CTRL_START_BIT;
        if (debug_mode)
            ctrl_bits |= CTRL_DEBUG_MODE_BIT;

        LOG_DEBUG("Pulsing START (CTRL=0x" + ([&] {
                      char b[16];
                      snprintf(b, sizeof(b), "%08X", ctrl_bits);
                      return std::string(b);
                  })() +
                  ")");

        pl->writeReg(PLReg::TOKEN_POSITION, token_position);
        pl->writeReg(PLReg::CONTROL, ctrl_bits);

        usleep(10);
        // Clear START bit
        pl->writeReg(PLReg::CONTROL,
                     pl->readReg(PLReg::CONTROL) & ~CTRL_START_BIT);

        if (!pl->streamWaitSend(timeout_ms)) {
            logPLStatus("streamWaitSend failed");
            pl->clearIRQ();
            return false;
        }

        if (!pl->waitDone(timeout_ms)) {
            logPLStatus("waitDone failed");
            pl->clearIRQ();
            return false;
        }

        std::vector<uint8_t> recv_buf(model_cfg.stream_out_size, 0);
        if (!pl->streamWaitRecv(output_offset, recv_buf.data(),
                                model_cfg.stream_out_size, timeout_ms)) {
            logPLStatus("streamWaitRecv failed");
            pl->clearIRQ();
            return false;
        }

        // Decode little-endian int32 (matches testbench stream out decode)
        // Assume stream_out_size >= 4 for GPT-2
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

    /** Get embedding data for a token ID + position into caller buffer. */
    bool getEmbedding(uint32_t token_id, uint32_t token_position, int8_t *out) {
        return lookupEmbedding(token_id, token_position, out);
    }

private:
    bool lookupEmbedding(uint32_t token_id, uint32_t token_position,
                         int8_t *out) {
        if (embedding_table.empty()) {
            LOG_WARN("No embedding table loaded, using test pattern");
            for (uint32_t i = 0; i < model_cfg.hidden_size; i++)
                out[i] = static_cast<int8_t>(i & 0xFF);
            return true;
        }
        if (token_id >= model_cfg.vocab_size) {
            LOG_ERROR("Token ID " + std::to_string(token_id) +
                      " out of range (" + std::to_string(model_cfg.vocab_size) +
                      ")");
            err->setError(ErrorCode::INVALID_TOKEN, "Token out of range");
            return false;
        }

        // Look up token embedding
        size_t tok_offset =
            static_cast<size_t>(token_id) * model_cfg.hidden_size;
        memcpy(out, &embedding_table[tok_offset], model_cfg.hidden_size);

        // Add position embedding (GPT-2 learned positional encoding)
        if (!pos_embedding_table.empty() &&
            token_position < model_cfg.context_length) {
            size_t pos_offset =
                static_cast<size_t>(token_position) * model_cfg.hidden_size;
            for (uint32_t i = 0; i < model_cfg.hidden_size; i++) {
                int sum = static_cast<int>(out[i]) +
                          static_cast<int>(pos_embedding_table[pos_offset + i]);
                // Clamp to int8 range
                out[i] = static_cast<int8_t>(
                    sum < -128 ? -128 : (sum > 127 ? 127 : sum));
            }
        } else if (pos_embedding_table.empty()) {
            LOG_WARN("No position embeddings loaded, skipping pos addition");
        } else if (token_position >= model_cfg.context_length) {
            LOG_ERROR("Token position " + std::to_string(token_position) +
                      " exceeds context length " +
                      std::to_string(model_cfg.context_length));
        }

        return true;
    }

    /** Log error context + raw register dump for diagnostics. */
    void logPLStatus(const char *context) {
        LOG_ERROR("[" + std::string(context) + "] " +
                  err->getLastErrorMessage() +
                  " | regs: " + pl->getRegStats(true));
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

    bool initialize(const std::string &cfg_file, bool debug_hw_override = false,
                    bool mock_override = false) {
        config.loadFromFile(cfg_file);
        if (debug_hw_override)
            config.hardware.debug_mode = true;
        if (mock_override)
            config.hardware.mock_mode = true;
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
            LOG_FATAL("PL init failed " + err.getLastErrorMessage());
            return false;
        }

        // initDMA() allocates the contiguous DMA buffer via u-dma-buf.
        if (!pl->initDMA(
                config.hardware.dmabuf0_name, config.hardware.dmabuf0_size,
                config.hardware.dmabuf1_name, config.hardware.dmabuf1_size)) {
            LOG_FATAL("DDR init failed" + err.getLastErrorMessage());
            return false;
        }

        tokenizer = std::unique_ptr<Tokenizer>(new Tokenizer);
        if (!tokenizer->loadVocabulary(config.model.tokenizer_vocab)) {
            LOG_FATAL("Tokenizer vocab load failed " +
                      err.getLastErrorMessage());
            return false;
        }

        perf = std::unique_ptr<PerformanceMonitor>(new PerformanceMonitor);

        loader =
            std::unique_ptr<WeightLoader>(new WeightLoader(pl.get(), &err));

        if (!loader->configureAddresses(config.model, config.memory)) {
            LOG_FATAL("Config failed " + err.getLastErrorMessage());
            return false;
        }

        // Load binary weights into DDR — cap at what the FPGA actually needs
        loader->setWeightsFile(config.model.weights_file);
        if (!loader->loadAllWeights(config.model, config.memory.weights_size)) {
            LOG_FATAL("Weight load failed " + err.getLastErrorMessage());
            return false;
        }

        exec = std::unique_ptr<InferenceExecutor>(new InferenceExecutor(
            pl.get(), tokenizer.get(), perf.get(), &err, config.model,
            config.memory.input_offset, config.memory.output_offset,
            config.hardware.timeout_ms, config.hardware.debug_mode));

        // Load embedding table from file into process memory
        if (!config.model.embeddings_file.empty()) {
            if (!exec->loadEmbeddingTable(config.model.embeddings_file)) {
                LOG_WARN("Embedding load failed, using test patterns");
            }
        } else {
            LOG_WARN("No embeddings_file configured, using test patterns");
        }

        // Load position embeddings (GPT-2 learned positional encoding)
        if (!config.model.pos_embeddings_file.empty()) {
            if (!exec->loadPositionEmbeddings(
                    config.model.pos_embeddings_file)) {
                LOG_WARN("Position embedding load failed, positions will be "
                         "ignored");
            }
        } else {
            LOG_WARN("No pos_embeddings_file configured, no position encoding");
        }

        LOG_INFO("Initialized" + std::string(config.hardware.debug_mode
                                                 ? " [HW DEBUG MODE]"
                                                 : ""));
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
    std::string dumpPLRegs() const { return pl->dumpCtrlMem(); }

    std::string dumpConfig() const {
        auto hex32 = [](uint32_t val) {
            char b[16];
            snprintf(b, sizeof(b), "0x%08X", val);
            return std::string(b);
        };

        std::string s = "--- System Config ---\n";
        s += "Weights: " + config.model.weights_file + "\n";
        s += "Vocab:   " + config.model.tokenizer_vocab + "\n";
        s += "Model:   Ctx=" + std::to_string(config.model.context_length) +
             ", Hid=" + std::to_string(config.model.hidden_size) +
             ", Layers=" + std::to_string(config.model.num_layers) + "\n";

        s += "--- Memory Layout (Offsets) ---\n";
        s += "WQ: " + hex32(config.memory.wq_offset) +
             "  WK: " + hex32(config.memory.wk_offset) +
             "  WV: " + hex32(config.memory.wv_offset) +
             "  WO: " + hex32(config.memory.wo_offset) + "\n";
        s += "W1: " + hex32(config.memory.w1_offset) +
             "  W2: " + hex32(config.memory.w2_offset) +
             "  WL: " + hex32(config.memory.wlogit_offset) + "\n";
        s += "B_WO: " + hex32(config.memory.wo_bias_offset) +
             "  B_W1: " + hex32(config.memory.w1_bias_offset) +
             "  B_W2: " + hex32(config.memory.w2_bias_offset) + "\n";
        s += "LN0_G: " + hex32(config.memory.ln0_gamma_offset) +
             "  LN0_B: " + hex32(config.memory.ln0_beta_offset) +
             "  LN1_G: " + hex32(config.memory.ln1_gamma_offset) + "\n";
        s += "LN1_B: " + hex32(config.memory.ln1_beta_offset) +
             "  FN_G:  " + hex32(config.memory.final_norm_gamma_offset) +
             "  FN_B:  " + hex32(config.memory.final_norm_beta_offset) + "\n";
        s += "LN0_E: " + hex32(config.memory.ln0_eps_offset) +
             "  LN1_E: " + hex32(config.memory.ln1_eps_offset) +
             "  FN_E:  " + hex32(config.memory.final_norm_eps_offset) + "\n";
        s += "--- KV Cache / Streams ---\n";
        s += "K : " + hex32(config.memory.k_cache_offset) +
             "  V : " + hex32(config.memory.v_cache_offset) + "\n";
        s += "In: " + hex32(config.memory.input_offset) +
             "  Out:" + hex32(config.memory.output_offset) + "\n";
        return s;
    }

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
                if (g_task_queue.pop(task)) {
                    if (config.hardware.debug_mode)
                        processTaskDebug(task);
                    else
                        processTask(task);
                } else {
                    std::this_thread::sleep_for(std::chrono::milliseconds(10));
                }
            }
        }
    }

    void processTaskDebug(const Task &task) {
        state.status = EngineStatus::GENERATING;
        state.taskId = task.id;
        state.cancel = false;
        g_engine_status = EngineStatus::GENERATING;

        std::vector<uint32_t> tokens;
        if (task.prompt.size() > 4 &&
            task.prompt.substr(task.prompt.size() - 4) == ".bin") {
            tokens = loadPreTokenized(task.prompt);
        } else {
            tokens = tokenizer->encode(task.prompt);
        }

        if (tokens.empty()) {
            print("[empty prompt]\n");
            state.status = EngineStatus::IDLE;
            g_engine_status = EngineStatus::IDLE;
            return;
        }

        // Debug mode: single token in → single token out
        uint32_t input_token = tokens[0];
        uint32_t out_token = 0;

        print("=== DEBUG: single-token inference ===\n");
        print("Input token: " + std::to_string(input_token) + " text=\"" +
              tokenizer->decodeToken(input_token) + "\"\n");

        // Compute expected sum of int8 embedding on CPU side
        std::vector<int8_t> embed_buf(config.model.hidden_size);
        int32_t expected_sum = 0;
        if (exec->getEmbedding(input_token, 0, embed_buf.data())) {
            for (uint32_t i = 0; i < config.model.hidden_size; i++)
                expected_sum += static_cast<int32_t>(embed_buf[i]);
            print("CPU embedding sum (int8): " + std::to_string(expected_sum) +
                  "\n");
        } else {
            print("WARNING: could not look up embedding\n");
        }

        print("Registers BEFORE:\n" + pl->getRegStats() + "\n");

        bool ok = exec->executeToken(input_token, 0, out_token);

        print("Registers AFTER:\n" + pl->getRegStats() + "\n");

        if (!ok) {
            print("executeToken FAILED: " + err.getLastErrorMessage() + "\n");
        } else {
            int32_t hw_sum = static_cast<int32_t>(out_token);
            print("HW returned: " + std::to_string(hw_sum) + " (0x" + ([&] {
                      char b[16];
                      snprintf(b, sizeof(b), "%08X", out_token);
                      return std::string(b);
                  })() +
                  ")\n");
            if (hw_sum == expected_sum) {
                print("PASS: HW sum matches CPU sum\n");
            } else {
                print("FAIL: expected " + std::to_string(expected_sum) +
                      " got " + std::to_string(hw_sum) + "\n");
            }
        }

        print("=== DEBUG END ===\n");
        state.status = EngineStatus::IDLE;
        g_engine_status = EngineStatus::IDLE;
    }

    void processTask(const Task &task) {
        state.status = EngineStatus::GENERATING;
        state.taskId = task.id;
        state.cancel = false;
        g_engine_status = EngineStatus::GENERATING;

        std::vector<uint32_t> tokens;
        if (task.prompt.size() > 4 &&
            task.prompt.substr(task.prompt.size() - 4) == ".bin") {
            tokens = loadPreTokenized(task.prompt);
        } else {
            tokens = tokenizer->encode(task.prompt);
        }

        if (tokens.empty()) {
            print("[empty prompt]\n");
            state.status = EngineStatus::IDLE;
            g_engine_status = EngineStatus::IDLE;
            return;
        }

        LOG_DEBUG("Entering Prefill phase: prompt_len=" +
                  std::to_string(tokens.size()));

        // ── Prefill: feed prompt tokens to populate KV cache ──
        for (size_t i = 0; i + 1 < tokens.size() && !state.cancel; i++) {
            uint32_t discard = 0;
            if (!exec->executeToken(tokens[i], static_cast<uint32_t>(i),
                                    discard)) {
                LOG_ERROR("Prefill failed at token " + std::to_string(i));
                break;
            }
            LOG_DEBUG("Prefill [" + std::to_string(i) + "/" +
                      std::to_string(tokens.size()) +
                      "] token=" + std::to_string(tokens[i]) +
                      " discard_token_idx=" + std::to_string(discard));
        }

        if (state.cancel) {
            state.status = EngineStatus::IDLE;
            g_engine_status = EngineStatus::IDLE;
            return;
        }

        LOG_DEBUG("Entering Decode phase: max_tokens=" +
                  std::to_string(state.maxTokens));

        // ── Decode: generate from the last prompt token onward ──
        uint32_t next_input = tokens.back();

        for (uint32_t i = 0; i < state.maxTokens && !state.cancel; i++) {
            uint32_t out_token = 0;
            const uint32_t token_position =
                static_cast<uint32_t>(tokens.size() - 1) + i;
            if (!exec->executeToken(next_input, token_position, out_token))
                break;

            LOG_DEBUG("Decode [" + std::to_string(i) + "/" +
                      std::to_string(state.maxTokens) +
                      "] next_input=" + std::to_string(next_input) +
                      " out_token=" + std::to_string(out_token));

            std::string decoded = tokenizer->decodeToken(out_token);
            if (!decoded.empty())
                print(decoded);

            if (out_token == tokenizer->getEOSTokenId())
                break;

            next_input = out_token;
        }

        print("\n");
        state.status = EngineStatus::IDLE;
        g_engine_status = EngineStatus::IDLE;
    }

    std::vector<uint32_t> loadPreTokenized(const std::string &path) {
        std::vector<uint32_t> ids;
        std::ifstream f(path, std::ios::binary);
        if (!f) {
            LOG_ERROR("Cannot open token file: " + path);
            return ids;
        }
        uint32_t count = 0;
        f.read(reinterpret_cast<char *>(&count), sizeof(count));
        ids.resize(count);
        f.read(reinterpret_cast<char *>(ids.data()), count * sizeof(uint32_t));
        LOG_INFO("Loaded " + std::to_string(count) + " tokens from " + path);
        return ids;
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

    LogLevel lvl = LogLevel::INFO;
    bool debug_hw = false;
    bool mock_hw = false;

    for (int i = 1; i < argc; i++) {
        std::string arg(argv[i]);
        if (arg == "--debug")
            lvl = LogLevel::DEBUG;
        if (arg == "--debug-hw")
            debug_hw = true;
        if (arg == "--mock")
            mock_hw = true;
    }

    g_logger = new Logger(lvl, "inference.log");

    std::string cfg_file = "config.yaml";
    for (int i = 1; i < argc - 1; i++)
        if (std::string(argv[i]) == "--config")
            cfg_file = argv[i + 1];

    InferenceEngine engine;

    if (debug_hw) {
        LOG_INFO("Hardware debug mode enabled via --debug-hw");
    }
    if (mock_hw) {
        LOG_INFO("Hardware mock mode enabled via --mock");
    }

    if (!engine.initialize(cfg_file, debug_hw, mock_hw)) {
        LOG_FATAL("Init failed");
        delete g_logger;
        return 1;
    }

    engine.start();
    std::cout << "Commands: /quit /stop /reset /stats_perf /stats_reg "
                 "/reg_dump /config_dump\n> ";

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
        } else if (input == "/reg_dump") {
            std::cout << engine.dumpPLRegs() << "\n";
        } else if (input == "/config_dump") {
            std::cout << engine.dumpConfig() << "\n";
        } else {
            engine.submitTask(Task(taskId++, TaskType::GENERATE, input));
        }
        std::cout << "> ";
    }

    engine.shutdown();
    delete g_logger;
    return 0;
}
