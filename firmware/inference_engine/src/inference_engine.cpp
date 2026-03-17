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
#include <cmath>
#include <cstring>
#include <fstream>
#include <iostream>
#include <memory>
#include <mutex>
#include <sstream>
#include <thread>
#include <unistd.h>
#include <vector>

Logger *g_logger = nullptr;
std::atomic<EngineStatus> g_engine_status(EngineStatus::IDLE);
std::mutex g_console_mutex;
Queue<Task, 100> g_task_queue;
Queue<Command, 10> g_command_queue;

// Firmware-local mirror of MatMulMode opcodes (shared with PL INSTR[3:0]).
// Keep numeric values aligned with HLS `ComputeOp` in top_params.hpp.
enum class ComputeOp : uint8_t {
    CMP_NONE       = 0,
    CMP_Q          = 1,
    CMP_K          = 2,
    CMP_V          = 3,
    CMP_ATT_SCORES = 4,
    CMP_ATT_VALUE  = 5,
    CMP_OUT_PROJ   = 6,
    CMP_FFN_W1     = 7,
    CMP_FFN_W2     = 8,
    CMP_LOGITS     = 9,
};

static inline uint32_t pack_instr32(ComputeOp op, uint32_t layer, uint32_t head) {
    // MatMulMode PS->PL instruction format (must match HLS):
    //   [3:0]=op, [11:4]=layer (8-bit), [19:12]=head (8-bit), [31:20]=reserved
    const uint32_t op4 = static_cast<uint32_t>(op) & 0xFu;
    const uint32_t layer8 = layer & 0xFFu;
    const uint32_t head8 = head & 0xFFu;
    return op4 | (layer8 << 4) | (head8 << 12);
}

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

        pl->beginConfig();

        pl->writeReg64(RegBus::ADDR, AddrReg::WEIGHTS_BASE_LO,
                       pl->getDDRBaseAddr(DmaBufType::BUF0));
        pl->writeReg64(RegBus::ADDR, AddrReg::KV_CACHE_BASE_LO,
                       pl->getDDRBaseAddr(DmaBufType::BUF1));

        pl->writeReg(PLReg::WQ_OFFSET, mem.wq_offset);
        pl->writeReg(PLReg::WK_OFFSET, mem.wk_offset);
        pl->writeReg(PLReg::WV_OFFSET, mem.wv_offset);
        pl->writeReg(PLReg::WO_OFFSET, mem.wo_offset);
        pl->writeReg(PLReg::W1_OFFSET, mem.w1_offset);
        pl->writeReg(PLReg::W2_OFFSET, mem.w2_offset);
        pl->writeReg(PLReg::K_CACHE_OFFSET, mem.k_cache_offset);
        pl->writeReg(PLReg::V_CACHE_OFFSET, mem.v_cache_offset);

        pl->writeReg(PLReg::WQ_BIAS_OFFSET, mem.wq_bias_offset);
        pl->writeReg(PLReg::WK_BIAS_OFFSET, mem.wk_bias_offset);
        pl->writeReg(PLReg::WV_BIAS_OFFSET, mem.wv_bias_offset);
        pl->writeReg(PLReg::WO_BIAS_OFFSET, mem.wo_bias_offset);
        pl->writeReg(PLReg::W1_BIAS_OFFSET, mem.w1_bias_offset);
        pl->writeReg(PLReg::W2_BIAS_OFFSET, mem.w2_bias_offset);
        pl->writeReg(PLReg::LN0_GAMMA_OFFSET, mem.ln0_gamma_offset);
        pl->writeReg(PLReg::LN1_GAMMA_OFFSET, mem.ln1_gamma_offset);
        pl->writeReg(PLReg::FINAL_NORM_GAMMA_OFFSET,
                     mem.final_norm_gamma_offset);

        // P0 FIX: beta offsets (were commented out)
        pl->writeReg(PLReg::LN0_BETA_OFFSET, mem.ln0_beta_offset);
        pl->writeReg(PLReg::LN1_BETA_OFFSET, mem.ln1_beta_offset);
        pl->writeReg(PLReg::FINAL_NORM_BETA_OFFSET,
                     mem.final_norm_beta_offset);

        pl->writeReg(PLReg::LN0_EPS_OFFSET, mem.ln0_eps_offset);
        pl->writeReg(PLReg::LN1_EPS_OFFSET, mem.ln1_eps_offset);
        pl->writeReg(PLReg::FINAL_NORM_EPS_OFFSET, mem.final_norm_eps_offset);
        pl->writeReg(PLReg::WLOGIT_OFFSET, mem.wlogit_offset);

        pl->writeReg(PLReg::TOKEN_POSITION, 0);

	        // Instruction is written per op invocation; keep cleared during init.
	        pl->writeReg(PLReg::INSTR, 0);
	        // PLReg::COMPUTE_INSTRUCTION is legacy/unused in MatMulMode.

	        pl->endConfig();
        if (err->hasError()) {
            LOG_ERROR("Config error, register dump:\n" + pl->dumpCtrlMem());
        }
        return !err->hasError();
    }
};

// =============================================================================
// InferenceExecutor — handles executeToken(), executeForwardHybrid()
// =============================================================================
class InferenceExecutor {
    PLInterface *pl;
    Tokenizer *tok;
    PerformanceMonitor *perf;
    ErrorHandler *err;
    ModelConfig model_cfg;

    uint32_t input_offset;
    uint32_t output_offset;
    uint32_t timeout_ms;
    bool debug_mode;

    // int8 embedding tables (original, used by executeToken)
    std::vector<int8_t> embedding_table;
    std::vector<int8_t> pos_embedding_table;

    // ── Matmul mode data ──

    // Float embeddings for precise addition
    std::vector<float> embed_float;
    std::vector<float> pos_float;
    bool use_float_embed = false;

    // Per-channel weight scales [layer][channel]
    std::vector<std::vector<double>> wq_scale;  // [12][768]
    std::vector<std::vector<double>> wk_scale;
    std::vector<std::vector<double>> wv_scale;
    std::vector<std::vector<double>> wo_scale;
    std::vector<std::vector<double>> w1_scale;  // [12][3072]
    std::vector<std::vector<double>> w2_scale;  // [12][768]
    std::vector<double> logit_scale;             // [50257]

    // Float biases (decoded from Q16.16)
    std::vector<std::vector<double>> bq_f, bk_f, bv_f, bo_f;
    std::vector<std::vector<double>> b1_f, b2_f;

    // Raw Q16.16 biases (needed for dequant subtraction)
    std::vector<std::vector<int32_t>> bq_raw, bk_raw, bv_raw, bo_raw;
    std::vector<std::vector<int32_t>> b1_raw, b2_raw;

    // Float LayerNorm parameters
    std::vector<std::vector<double>> ln1_w_f, ln1_b_f;
    std::vector<std::vector<double>> ln2_w_f, ln2_b_f;
    std::vector<double> fln_w_f, fln_b_f;

    // PS-side float KV cache
    std::vector<std::vector<double>> kv_k;  // [12][ctx * 768]
    std::vector<std::vector<double>> kv_v;

    // int8 logit weights for PS-side logit projection
    std::vector<int8_t> wlogit_i8;

    // Memory layout reference for DDR reads
    MemoryLayout mem_layout;

    bool matmul_mode_ready = false;

    // ── PS-side float helpers ──

    static void ps_layernorm(const double *x, const double *gamma,
                             const double *beta, double *out, int n) {
        double mean = 0;
        for (int i = 0; i < n; i++) mean += x[i];
        mean /= n;
        double var = 0;
        for (int i = 0; i < n; i++) {
            double d = x[i] - mean;
            var += d * d;
        }
        var /= n;
        double inv = 1.0 / sqrt(var + 1e-5);
        for (int i = 0; i < n; i++)
            out[i] = gamma[i] * (x[i] - mean) * inv + beta[i];
    }

    static void ps_gelu(double *x, int n) {
        const double c = sqrt(2.0 / M_PI);
        for (int i = 0; i < n; i++)
            x[i] = 0.5 * x[i] *
                   (1.0 + tanh(c * (x[i] + 0.044715 * x[i] * x[i] * x[i])));
    }

    static void ps_quantize_act(const double *x, int8_t *out, double &scale,
                                int n) {
        double amax = 0;
        for (int i = 0; i < n; i++) {
            double a = fabs(x[i]);
            if (a > amax) amax = a;
        }
        if (amax < 1e-10) amax = 1e-10;
        scale = amax / 127.0;
        for (int i = 0; i < n; i++) {
            int v = (int)round(x[i] / scale);
            out[i] = (int8_t)(v < -127 ? -127 : (v > 127 ? 127 : v));
        }
    }

    static void ps_dequant(const int32_t *acc_with_bias, double act_scale,
                           const double *w_scales, const double *bias_float,
                           const int32_t *bias_q16, double *out, int n) {
        for (int i = 0; i < n; i++) {
            int64_t mac_raw =
                (int64_t)acc_with_bias[i] - (int64_t)bias_q16[i];
            out[i] = (double)mac_raw * act_scale * w_scales[i] +
                     bias_float[i];
        }
    }

public:
    InferenceExecutor(PLInterface *p, Tokenizer *t, PerformanceMonitor *pf,
                      ErrorHandler *e, const ModelConfig &m_cfg,
                      uint32_t in_off, uint32_t out_off, uint32_t tmo_ms,
                      bool debug = false)
        : pl(p), tok(t), perf(pf), err(e), model_cfg(m_cfg),
          input_offset(in_off), output_offset(out_off), timeout_ms(tmo_ms),
          debug_mode(debug) {}

    void setMemoryLayout(const MemoryLayout &mem) { mem_layout = mem; }

    // ── Original methods (unchanged) ──

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
            err->setError(ErrorCode::FILE_NOT_FOUND,
                          "Embedding file too small: " +
                              std::to_string(file_size) + " bytes, expected " +
                              std::to_string(expected));
            return false;
        }
        embedding_table.resize(expected);
        f.read(reinterpret_cast<char *>(embedding_table.data()), expected);
        LOG_INFO("Loaded embedding table: " +
                 std::to_string(model_cfg.vocab_size) + " x " +
                 std::to_string(model_cfg.hidden_size) + " bytes");
        return true;
    }

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

        uint32_t ctrl_bits = CTRL_RESETN_BIT | CTRL_START_BIT;
        if (debug_mode) ctrl_bits |= CTRL_DEBUG_MODE_BIT;

        pl->writeReg(PLReg::TOKEN_POSITION, token_position);
        pl->writeReg(PLReg::CONTROL, ctrl_bits);
        usleep(10);
        pl->writeReg(PLReg::CONTROL,
                     pl->readReg(PLReg::CONTROL) & ~CTRL_START_BIT);

        if (!pl->streamWaitSend(timeout_ms)) {
            logPLStatus("streamWaitSend failed"); pl->clearIRQ(); return false;
        }
        if (!pl->waitDone(timeout_ms)) {
            logPLStatus("waitDone failed"); pl->clearIRQ(); return false;
        }

        std::vector<uint8_t> recv_buf(model_cfg.stream_out_size, 0);
        if (!pl->streamWaitRecv(output_offset, recv_buf.data(),
                                model_cfg.stream_out_size, timeout_ms)) {
            logPLStatus("streamWaitRecv failed"); pl->clearIRQ(); return false;
        }

        out_token = static_cast<uint32_t>(recv_buf[0]) |
                    (static_cast<uint32_t>(recv_buf[1]) << 8) |
                    (static_cast<uint32_t>(recv_buf[2]) << 16) |
                    (static_cast<uint32_t>(recv_buf[3]) << 24);

        pl->clearIRQ();
        perf->recordToken();
        perf->endGeneration();
        return true;
    }

    bool getEmbedding(uint32_t token_id, uint32_t token_position, int8_t *out) {
        return lookupEmbedding(token_id, token_position, out);
    }

    // ── Matmul mode methods ──

    bool loadFloatEmbeddings(const std::string &tok_path,
                             const std::string &pos_path) {
        const uint32_t H = model_cfg.hidden_size;
        std::ifstream ft(tok_path, std::ios::binary);
        std::ifstream fp(pos_path, std::ios::binary);
        if (!ft || !fp) {
            LOG_WARN("Float embedding files not found, using int8 addition");
            return false;
        }
        embed_float.resize((size_t)model_cfg.vocab_size * H);
        ft.read(reinterpret_cast<char *>(embed_float.data()),
                embed_float.size() * sizeof(float));
        pos_float.resize((size_t)model_cfg.context_length * H);
        fp.read(reinterpret_cast<char *>(pos_float.data()),
                pos_float.size() * sizeof(float));
        use_float_embed = true;
        LOG_INFO("Loaded float embeddings for matmul mode");
        return true;
    }

    bool loadMatmulModeParams(const std::string &model_dir) {
        const uint32_t H = model_cfg.hidden_size;
        const uint32_t FF = model_cfg.intermediate_size;
        const uint32_t V = model_cfg.vocab_size;
        const uint32_t NL = model_cfg.num_layers;
        const MemoryLayout &mem = mem_layout;

        // ── Load per-channel weight scales from quant_scales.json ──
        std::string json_path = model_dir + "/quant_scales.json";
        std::ifstream jf(json_path);
        if (!jf) {
            LOG_ERROR("Cannot open " + json_path);
            return false;
        }
        std::string json_str((std::istreambuf_iterator<char>(jf)),
                              std::istreambuf_iterator<char>());

        auto parse_array = [&](const std::string &key,
                               std::vector<double> &out) -> bool {
            std::string search = "\"" + key + "\"";
            size_t pos = json_str.find(search);
            if (pos == std::string::npos) return false;
            size_t start = json_str.find('[', pos);
            size_t end = json_str.find(']', start);
            if (start == std::string::npos || end == std::string::npos)
                return false;
            std::string arr = json_str.substr(start + 1, end - start - 1);
            out.clear();
            size_t p = 0;
            while (p < arr.size()) {
                while (p < arr.size() && (arr[p] == ' ' || arr[p] == ',')) p++;
                if (p >= arr.size()) break;
                size_t e = p;
                while (e < arr.size() && arr[e] != ',' && arr[e] != ' ') e++;
                out.push_back(atof(arr.substr(p, e - p).c_str()));
                p = e;
            }
            return true;
        };

        wq_scale.resize(NL); wk_scale.resize(NL); wv_scale.resize(NL);
        wo_scale.resize(NL); w1_scale.resize(NL); w2_scale.resize(NL);
        bq_f.resize(NL); bk_f.resize(NL); bv_f.resize(NL); bo_f.resize(NL);
        b1_f.resize(NL); b2_f.resize(NL);
        bq_raw.resize(NL); bk_raw.resize(NL); bv_raw.resize(NL); bo_raw.resize(NL);
        b1_raw.resize(NL); b2_raw.resize(NL);
        ln1_w_f.resize(NL); ln1_b_f.resize(NL);
        ln2_w_f.resize(NL); ln2_b_f.resize(NL);
        kv_k.resize(NL); kv_v.resize(NL);

        for (uint32_t ly = 0; ly < NL; ly++) {
            std::string pfx = "layer" + std::to_string(ly) + ".";
            parse_array(pfx + "wq", wq_scale[ly]);
            parse_array(pfx + "wk", wk_scale[ly]);
            parse_array(pfx + "wv", wv_scale[ly]);
            parse_array(pfx + "wo", wo_scale[ly]);
            parse_array(pfx + "w1", w1_scale[ly]);
            parse_array(pfx + "w2", w2_scale[ly]);
            kv_k[ly].resize((size_t)model_cfg.context_length * H, 0.0);
            kv_v[ly].resize((size_t)model_cfg.context_length * H, 0.0);
        }
        parse_array("lm_head", logit_scale);

        // ── Read biases and LN params from DDR (Q16.16 -> float) ──
        auto read_q16 = [&](uint32_t offset, uint32_t count,
                            std::vector<double> &fout,
                            std::vector<int32_t> &raw) -> bool {
            raw.resize(count); fout.resize(count);
            if (!pl->readDDR(DmaBufType::BUF0, offset, raw.data(),
                             count * sizeof(int32_t)))
                return false;
            for (uint32_t i = 0; i < count; i++)
                fout[i] = (double)raw[i] / 65536.0;
            return true;
        };
        auto read_q16_f = [&](uint32_t offset, uint32_t count,
                              std::vector<double> &fout) -> bool {
            std::vector<int32_t> raw(count); fout.resize(count);
            if (!pl->readDDR(DmaBufType::BUF0, offset, raw.data(),
                             count * sizeof(int32_t)))
                return false;
            for (uint32_t i = 0; i < count; i++)
                fout[i] = (double)raw[i] / 65536.0;
            return true;
        };

        for (uint32_t ly = 0; ly < NL; ly++) {
            uint32_t b4 = H * 4, b41 = FF * 4, g4 = H * 4;
            read_q16(mem.wq_bias_offset + ly*b4, H, bq_f[ly], bq_raw[ly]);
            read_q16(mem.wk_bias_offset + ly*b4, H, bk_f[ly], bk_raw[ly]);
            read_q16(mem.wv_bias_offset + ly*b4, H, bv_f[ly], bv_raw[ly]);
            read_q16(mem.wo_bias_offset + ly*b4, H, bo_f[ly], bo_raw[ly]);
            read_q16(mem.w1_bias_offset + ly*b41, FF, b1_f[ly], b1_raw[ly]);
            read_q16(mem.w2_bias_offset + ly*b4, H, b2_f[ly], b2_raw[ly]);
            read_q16_f(mem.ln0_gamma_offset + ly*g4, H, ln1_w_f[ly]);
            read_q16_f(mem.ln0_beta_offset + ly*g4, H, ln1_b_f[ly]);
            read_q16_f(mem.ln1_gamma_offset + ly*g4, H, ln2_w_f[ly]);
            read_q16_f(mem.ln1_beta_offset + ly*g4, H, ln2_b_f[ly]);
        }
        read_q16_f(mem.final_norm_gamma_offset, H, fln_w_f);
        read_q16_f(mem.final_norm_beta_offset, H, fln_b_f);

        // ── Load int8 logit weights ──
        wlogit_i8.resize((size_t)V * H);
        if (!pl->readDDR(DmaBufType::BUF0, mem.wlogit_offset,
                         wlogit_i8.data(), (size_t)V * H)) {
            LOG_ERROR("Failed to read logit weights from DDR");
            return false;
        }

        matmul_mode_ready = true;
        LOG_INFO("Matmul mode params loaded: " + std::to_string(NL) +
                 " layers, " + std::to_string(H) + " hidden");
        return true;
    }

    bool executeMatmul(ComputeOp op, uint32_t layer, uint32_t head,
                       uint32_t token_position, const int8_t *act_i8,
                       uint32_t act_len, int32_t *acc_out,
                       uint32_t out_len) {
        uint32_t tile_end = 0;
        uint32_t tile_out_elems = 0;
        switch (op) {
        case ComputeOp::CMP_Q:
        case ComputeOp::CMP_K:
        case ComputeOp::CMP_V:
            tile_end = NUM_QKV_HEAD_TILES;
            tile_out_elems = D_HEAD_TILE_QKV;
            break;
        case ComputeOp::CMP_ATT_SCORES:
            tile_end = NUM_ATT_CTX_BLOCKS;
            tile_out_elems = ATT_CTX_BLOCK;
            break;
        case ComputeOp::CMP_ATT_VALUE:
            tile_end = NUM_ATT_VALUE_HEAD_TILES * NUM_ATT_CTX_BLOCKS;
            tile_out_elems = D_HEAD_TILE_ATT_VALUE;
            break;
        case ComputeOp::CMP_OUT_PROJ:
            tile_end = NUM_WO_TILES;
            tile_out_elems = D_TILE_WO;
            break;
        case ComputeOp::CMP_FFN_W1:
            tile_end = NUM_W1_TILES;
            tile_out_elems = D_TILE_W1;
            break;
        case ComputeOp::CMP_FFN_W2:
            tile_end = NUM_W2_TILES;
            tile_out_elems = D_TILE_W2;
            break;
        case ComputeOp::CMP_LOGITS:
            tile_end = NUM_LOGIT_TILES;
            tile_out_elems = D_TILE_LOGIT;
            break;
        default:
            LOG_ERROR("executeMatmul: invalid op");
            return false;
        }

        const uint32_t expected_total = tile_end * tile_out_elems;
        if (out_len > expected_total) {
            LOG_ERROR("executeMatmul: out_len exceeds op tile output");
            return false;
        }
        if (act_len > static_cast<uint32_t>(STREAM_IN_BUF_BYTES)) {
            LOG_ERROR("executeMatmul: act_len exceeds STREAM_IN_BUF_BYTES");
            return false;
        }

        std::vector<uint8_t> send_buf(STREAM_IN_BUF_BYTES, 0);
        memcpy(send_buf.data(), act_i8, act_len);

        pl->writeReg(PLReg::INSTR, pack_instr32(op, layer, head));
        pl->writeReg(PLReg::TOKEN_POSITION, token_position);

        // Arm first receive before starting (backpressure-safe).
        if (!pl->streamInitRecv(output_offset,
                                static_cast<size_t>(STREAM_OUT_BUF_BYTES))) {
            LOG_ERROR("matmul recv init failed");
            return false;
        }
        if (!pl->streamInitSend(input_offset, send_buf.data(),
                                static_cast<size_t>(STREAM_IN_BUF_BYTES))) {
            LOG_ERROR("matmul send init failed");
            return false;
        }

        uint32_t ctrl = CTRL_RESETN_BIT | CTRL_START_BIT;
        if (debug_mode)
            ctrl |= CTRL_DEBUG_MODE_BIT;
        pl->writeReg(PLReg::CONTROL, ctrl);
        usleep(10);
        pl->writeReg(PLReg::CONTROL, ctrl & ~CTRL_START_BIT);

        if (!pl->streamWaitSend(timeout_ms)) {
            LOG_ERROR("matmul send timeout");
            pl->clearIRQ();
            return false;
        }

        std::vector<uint8_t> recv_tile(STREAM_OUT_BUF_BYTES, 0);
        for (uint32_t t = 0; t < tile_end; t++) {
            if (!pl->streamWaitRecv(
                    output_offset + t * STREAM_OUT_BUF_BYTES,
                    recv_tile.data(), static_cast<size_t>(STREAM_OUT_BUF_BYTES),
                    timeout_ms)) {
                LOG_ERROR("matmul recv timeout");
                pl->clearIRQ();
                return false;
            }

            const uint32_t base = t * tile_out_elems;
            if (base < out_len) {
                const uint32_t remaining = out_len - base;
                const uint32_t copy_elems =
                    (remaining < tile_out_elems) ? remaining : tile_out_elems;
                memcpy(&acc_out[base], recv_tile.data(),
                       copy_elems * sizeof(int32_t));
            }

            if (t + 1 < tile_end) {
                if (!pl->streamInitRecv(
                        output_offset + (t + 1) * STREAM_OUT_BUF_BYTES,
                        static_cast<size_t>(STREAM_OUT_BUF_BYTES))) {
                    LOG_ERROR("matmul recv init failed (next tile)");
                    pl->clearIRQ();
                    return false;
                }
            }
        }

        if (!pl->waitDone(timeout_ms)) {
            LOG_ERROR("matmul done timeout (op=" +
                      std::to_string(static_cast<uint32_t>(op)) +
                      " layer=" + std::to_string(layer) +
                      " head=" + std::to_string(head) + ")");
            pl->clearIRQ();
            return false;
        }

        pl->clearIRQ();
        return true;
    }

    bool executeForwardHybrid(uint32_t token_id, uint32_t token_position,
                              uint32_t &out_token) {
        if (!matmul_mode_ready) {
            LOG_ERROR("Matmul mode not initialized");
            return false;
        }

        perf->startGeneration();

        const uint32_t H = model_cfg.hidden_size;
        const uint32_t FF = model_cfg.intermediate_size;
        const uint32_t V = model_cfg.vocab_size;
        const uint32_t NL_count = model_cfg.num_layers;
        const uint32_t NH_count = model_cfg.num_heads;
        const uint32_t DH_size = model_cfg.head_dim;

        std::vector<double> x(H), h(H), h2(H);
        std::vector<double> q(H), k(H), v(H), o(H);
        std::vector<double> fc1(FF), fc2(H);
        std::vector<double> attn_out(H);
        std::vector<int8_t> act_i8_h(H), act_i8_ff(FF);
        std::vector<int32_t> acc_h(H), acc_ff(FF), acc_head(DH_size);
        double act_scale;

        // ── Float embedding ──
        if (use_float_embed) {
            size_t tok_off = (size_t)token_id * H;
            size_t pos_off = (size_t)token_position * H;
            for (uint32_t i = 0; i < H; i++)
                x[i] = (double)embed_float[tok_off + i] +
                       (double)pos_float[pos_off + i];
        } else {
            size_t tok_off = (size_t)token_id * H;
            size_t pos_off = (size_t)token_position * H;
            for (uint32_t i = 0; i < H; i++) {
                int sum = (int)embedding_table[tok_off + i] +
                          (int)pos_embedding_table[pos_off + i];
                x[i] = (double)(sum < -128 ? -128 : (sum > 127 ? 127 : sum));
            }
        }

        // ── Layer loop ──
        for (uint32_t ly = 0; ly < NL_count; ly++) {

            ps_layernorm(x.data(), ln1_w_f[ly].data(), ln1_b_f[ly].data(),
                         h.data(), H);
            ps_quantize_act(h.data(), act_i8_h.data(), act_scale, H);

            // PL: Q/K/V projections are per-head in MatMulMode.
            for (uint32_t head = 0; head < NH_count; head++) {
                const uint32_t off = head * DH_size;

                if (!executeMatmul(ComputeOp::CMP_Q, ly, head, token_position,
                                   act_i8_h.data(), H, acc_head.data(),
                                   DH_size))
                    return false;
                ps_dequant(acc_head.data(), act_scale,
                           wq_scale[ly].data() + off, bq_f[ly].data() + off,
                           bq_raw[ly].data() + off, q.data() + off, DH_size);

                if (!executeMatmul(ComputeOp::CMP_K, ly, head, token_position,
                                   act_i8_h.data(), H, acc_head.data(),
                                   DH_size))
                    return false;
                ps_dequant(acc_head.data(), act_scale,
                           wk_scale[ly].data() + off, bk_f[ly].data() + off,
                           bk_raw[ly].data() + off, k.data() + off, DH_size);

                if (!executeMatmul(ComputeOp::CMP_V, ly, head, token_position,
                                   act_i8_h.data(), H, acc_head.data(),
                                   DH_size))
                    return false;
                ps_dequant(acc_head.data(), act_scale,
                           wv_scale[ly].data() + off, bv_f[ly].data() + off,
                           bv_raw[ly].data() + off, v.data() + off, DH_size);
            }

            // PS: KV cache
            size_t kv_off = (size_t)token_position * H;
            memcpy(&kv_k[ly][kv_off], k.data(), H * sizeof(double));
            memcpy(&kv_v[ly][kv_off], v.data(), H * sizeof(double));

            // PS: Float multi-head attention
            std::fill(attn_out.begin(), attn_out.end(), 0.0);
            for (uint32_t head = 0; head < NH_count; head++) {
                double *qh = &q[head * DH_size];
                std::vector<double> scores(token_position + 1);
                double max_score = -1e30;
                for (uint32_t t = 0; t <= token_position; t++) {
                    double s = 0;
                    double *kt = &kv_k[ly][t * H + head * DH_size];
                    for (uint32_t d = 0; d < DH_size; d++) s += qh[d] * kt[d];
                    scores[t] = s / 8.0;
                    if (scores[t] > max_score) max_score = scores[t];
                }
                double sum_exp = 0;
                for (uint32_t t = 0; t <= token_position; t++) {
                    scores[t] = exp(scores[t] - max_score);
                    sum_exp += scores[t];
                }
                for (uint32_t t = 0; t <= token_position; t++)
                    scores[t] /= (sum_exp + 1e-10);
                for (uint32_t d = 0; d < DH_size; d++) {
                    double a = 0;
                    for (uint32_t t = 0; t <= token_position; t++)
                        a += scores[t] * kv_v[ly][t * H + head * DH_size + d];
                    attn_out[head * DH_size + d] = a;
                }
            }

            // PS: Quantize attention output
            ps_quantize_act(attn_out.data(), act_i8_h.data(), act_scale, H);

            // PL: O projection
            if (!executeMatmul(ComputeOp::CMP_OUT_PROJ, ly, 0, token_position,
                               act_i8_h.data(), H, acc_h.data(), H))
                return false;
            ps_dequant(acc_h.data(), act_scale, wo_scale[ly].data(),
                       bo_f[ly].data(), bo_raw[ly].data(), o.data(), H);

            // PS: Float residual 1
            for (uint32_t i = 0; i < H; i++) x[i] += o[i];

            // PS: Float LayerNorm 1
            ps_layernorm(x.data(), ln2_w_f[ly].data(), ln2_b_f[ly].data(),
                         h2.data(), H);
            ps_quantize_act(h2.data(), act_i8_h.data(), act_scale, H);

            // PL: FFN W1
            if (!executeMatmul(ComputeOp::CMP_FFN_W1, ly, 0, token_position,
                               act_i8_h.data(), H, acc_ff.data(), FF))
                return false;
            ps_dequant(acc_ff.data(), act_scale, w1_scale[ly].data(),
                       b1_f[ly].data(), b1_raw[ly].data(), fc1.data(), FF);

            // PS: Float GELU
            ps_gelu(fc1.data(), FF);
            ps_quantize_act(fc1.data(), act_i8_ff.data(), act_scale, FF);

            // PL: FFN W2
            if (!executeMatmul(ComputeOp::CMP_FFN_W2, ly, 0, token_position,
                               act_i8_ff.data(), FF, acc_h.data(), H))
                return false;
            ps_dequant(acc_h.data(), act_scale, w2_scale[ly].data(),
                       b2_f[ly].data(), b2_raw[ly].data(), fc2.data(), H);

            // PS: Float residual 2
            for (uint32_t i = 0; i < H; i++) x[i] += fc2[i];

            LOG_DEBUG("Layer " + std::to_string(ly) + " complete");
        }

        // PS: Float final LayerNorm
        ps_layernorm(x.data(), fln_w_f.data(), fln_b_f.data(), h.data(), H);
        ps_quantize_act(h.data(), act_i8_h.data(), act_scale, H);

        // PS: Logit projection on ARM
        double best_logit = -1e30;
        out_token = 0;
        for (uint32_t i = 0; i < V; i++) {
            int32_t acc = 0;
            const int8_t *row = &wlogit_i8[i * H];
            for (uint32_t j = 0; j < H; j++)
                acc += (int32_t)row[j] * (int32_t)act_i8_h[j];
            double logit = (double)acc * act_scale * logit_scale[i];
            if (logit > best_logit) {
                best_logit = logit;
                out_token = i;
            }
        }

        perf->recordToken();
        perf->endGeneration();
        return true;
    }

    void resetKVCache() {
        for (size_t ly = 0; ly < kv_k.size(); ly++) {
            std::fill(kv_k[ly].begin(), kv_k[ly].end(), 0.0);
            std::fill(kv_v[ly].begin(), kv_v[ly].end(), 0.0);
        }
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
        size_t tok_offset =
            static_cast<size_t>(token_id) * model_cfg.hidden_size;
        memcpy(out, &embedding_table[tok_offset], model_cfg.hidden_size);

        if (!pos_embedding_table.empty() &&
            token_position < model_cfg.context_length) {
            size_t pos_offset =
                static_cast<size_t>(token_position) * model_cfg.hidden_size;
            for (uint32_t i = 0; i < model_cfg.hidden_size; i++) {
                int sum = static_cast<int>(out[i]) +
                          static_cast<int>(pos_embedding_table[pos_offset + i]);
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
        if (debug_hw_override) config.hardware.debug_mode = true;
        if (mock_override) config.hardware.mock_mode = true;
        if (!config.validate()) {
            LOG_ERROR("Invalid configuration");
            return false;
        }

        pl = std::unique_ptr<PLInterface>(
            new PLInterface(g_logger, &err, config.hardware.mock_mode));
        if (!pl->init(config.hardware.uio_device,
                      config.hardware.stream_reg_base_addr)) {
            LOG_FATAL("PL init failed " + err.getLastErrorMessage());
            return false;
        }

        if (!pl->initDMA(
                config.hardware.dmabuf0_name, config.hardware.dmabuf0_size,
                config.hardware.dmabuf1_name, config.hardware.dmabuf1_size)) {
            LOG_FATAL("DDR init failed" + err.getLastErrorMessage());
            return false;
        }

        tokenizer = std::unique_ptr<Tokenizer>(new Tokenizer());
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

        loader->setWeightsFile(config.model.weights_file);
        if (!loader->loadAllWeights(config.model, config.memory.weights_size)) {
            LOG_FATAL("Weight load failed " + err.getLastErrorMessage());
            return false;
        }

        exec = std::unique_ptr<InferenceExecutor>(new InferenceExecutor(
            pl.get(), tokenizer.get(), perf.get(), &err, config.model,
            config.memory.input_offset, config.memory.output_offset,
            config.hardware.timeout_ms, config.hardware.debug_mode));

        // Load int8 embedding tables (used by autonomous mode)
        if (!config.model.embeddings_file.empty()) {
            if (!exec->loadEmbeddingTable(config.model.embeddings_file)) {
                LOG_WARN("Embedding load failed" + err.getLastErrorMessage());
            }
        }
        if (!config.model.pos_embeddings_file.empty()) {
            if (!exec->loadPositionEmbeddings(
                    config.model.pos_embeddings_file)) {
                LOG_WARN("Position embedding load failed" +
                         err.getLastErrorMessage());
            }
        }

        // ── Load matmul mode resources ──
        exec->setMemoryLayout(config.memory);

        // Float embeddings (falls back to int8 if files not found)
        exec->loadFloatEmbeddings(
            config.model.embed_float_file,
            config.model.pos_float_file);

        // Load weight scales, biases, LN params for matmul mode
        if (!exec->loadMatmulModeParams(config.model.model_dir)) {
            LOG_WARN("Matmul mode params not loaded, hybrid mode unavailable");
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
            if (thread.joinable()) thread.join();
        }
    }

    bool submitTask(const Task &t) { return g_task_queue.push(t); }
    bool submitCommand(const Command &c) { return g_command_queue.push(c); }
    std::string getPerfStats() const { return perf->getDetailedStats(); }
    std::string getRegStats() const { return pl->getRegStats(); }
    std::string dumpPLRegs() const { return pl->dumpCtrlMem(); }
    std::string dumpConfig() const { return config.toString(); }

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

        uint32_t input_token = tokens[0];
        uint32_t out_token = 0;

        print("=== DEBUG: single-token inference ===\n");
        print("Input token: " + std::to_string(input_token) + " text=\"" +
              tokenizer->decodeToken(input_token) + "\"\n");

        std::vector<int8_t> embed_buf(config.model.hidden_size);
        int32_t expected_sum = 0;
        if (exec->getEmbedding(input_token, 0, embed_buf.data())) {
            for (uint32_t i = 0; i < config.model.hidden_size; i++)
                expected_sum += static_cast<int32_t>(embed_buf[i]);
            print("CPU embedding sum (int8): " + std::to_string(expected_sum) +
                  "\n");
        }

        print("Registers BEFORE:\n" + pl->getRegStats() + "\n");
        bool ok = exec->executeToken(input_token, 0, out_token);
        print("Registers AFTER:\n" + pl->getRegStats() + "\n");

        if (!ok) {
            print("executeToken FAILED: " + err.getLastErrorMessage() + "\n");
        } else {
            print("HW returned: " + std::to_string(out_token) + "\n");
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

        // Reset PS-side KV cache before new generation
        exec->resetKVCache();

        // ── Prefill ──
        for (size_t i = 0; i + 1 < tokens.size() && !state.cancel; i++) {
            uint32_t discard = 0;
            if (!exec->executeForwardHybrid(tokens[i],
                                            static_cast<uint32_t>(i),
                                            discard)) {
                LOG_ERROR("Prefill failed at token " + std::to_string(i));
                break;
            }
            LOG_DEBUG("Prefill [" + std::to_string(i) + "/" +
                      std::to_string(tokens.size()) +
                      "] token=" + std::to_string(tokens[i]));
        }

        if (state.cancel) {
            state.status = EngineStatus::IDLE;
            g_engine_status = EngineStatus::IDLE;
            return;
        }

        LOG_DEBUG("Entering Decode phase: max_tokens=" +
                  std::to_string(state.maxTokens));

        // ── Decode ──
        uint32_t next_input = tokens.back();

        for (uint32_t i = 0; i < state.maxTokens && !state.cancel; i++) {
            uint32_t out_token = 0;
            const uint32_t token_position =
                static_cast<uint32_t>(tokens.size() - 1) + i;
            if (!exec->executeForwardHybrid(next_input, token_position,
                                            out_token))
                break;

            std::string decoded = tokenizer->decodeToken(out_token);

            LOG_DEBUG("Decode [" + std::to_string(i) + "/" +
                      std::to_string(state.maxTokens) +
                      "] next_input=" + std::to_string(next_input) +
                      " out_token=" + std::to_string(out_token) +
                      " out_decode=\"" + decoded + "\"");

            if (!decoded.empty()) print(decoded);
            if (out_token == tokenizer->getEOSTokenId()) break;
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
        if (arg == "--debug") lvl = LogLevel::DEBUG;
        if (arg == "--debug-hw") debug_hw = true;
        if (arg == "--mock") mock_hw = true;
    }

    g_logger = new Logger(lvl, "inference.log");

    std::string cfg_file = "config.yaml";
    for (int i = 1; i < argc - 1; i++)
        if (std::string(argv[i]) == "--config") cfg_file = argv[i + 1];

    InferenceEngine engine;

    if (debug_hw) LOG_INFO("Hardware debug mode enabled via --debug-hw");
    if (mock_hw) LOG_INFO("Hardware mock mode enabled via --mock");

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
        if (input.empty()) { std::cout << "> "; continue; }
        if (input == "/quit") {
            engine.submitCommand(Command(CommandType::SHUTDOWN)); break;
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
