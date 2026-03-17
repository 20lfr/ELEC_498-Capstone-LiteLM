// matmul_mode_tb.cpp
// Testbench for the MatMul-only instruction-driven accelerator.
//
// Exercises every matmul operation in the transformer forward-pass order:
//   Q -> K -> V -> ATT_SCORES -> ATT_VALUE -> OUT_PROJ -> W1 -> W2  (per layer)
//   LOGITS (after all layers)
//
// For each invocation:
//   1. Encodes a 32-bit INSTR and writes ctrl_mem.instr
//   2. Streams the appropriate activation via AXIS
//   3. Runs until IRQ_INFER_DONE_BIT / S_IDLE
//   4. Drains one STREAM_OUT burst per internal tile (each burst is
//      STREAM_OUT_BUF_BYTES = 256 bytes of raw int32 accumulators)
//
// Results are written to matmul_results.bin for comparison with verify_matmul.py.
//
// Run via Vitis HLS C-sim:
//   cd /home/luka/Scripting/vitis_simulations/Top_Module_MATMUL_ARCH
//   vitis-run --mode hls --csim --config hls_config.cfg --work_dir transformer_top
//
// Model size is controlled by FULL_MODEL_TEST in shared_params.hpp:
//   Undefined (default): uses test_data/ files from gen_ddr_image.py
//                        (small params: D_MODEL=16, 4 layers, 4 heads)
//   Defined:             uses ../model/ files (full GPT-2: D_MODEL=768, 12 layers)
//
// Quick mode: compile with -DTB_QUICK_MODE (layer=0, head=0 only).

#include <cstdio>
#include <cstdarg>
#include <cstdint>
#include <cstdlib>
#include <cerrno>
#include <cstring>
#include <fstream>
#include <string>
#include <ctime>
#include <vector>
#include <csignal>
#include <sys/stat.h>
#include <sys/types.h>
#if !defined(_WIN32)
#include <execinfo.h>
#include <unistd.h>
#endif

#include "tb_paths.hpp"
#include "tb_model_bin_loader.hpp"
#include "top_no_debug.hpp"

#ifndef MATMUL_MODE_TB_BASENAME
#define MATMUL_MODE_TB_BASENAME "matmul_mode_tb"
#endif

#ifndef MATMUL_MODE_TB_LOG_SUBDIR
// Keep this stable because downstream tooling expects this folder.
#define MATMUL_MODE_TB_LOG_SUBDIR "Top_Module_MATMUL_ARCH"
#endif

static bool ensure_dir_recursive(const char *dir) {
    char path[512];
    std::snprintf(path, sizeof(path), "%s", dir);
    const size_t n = std::strlen(path);
    if (n == 0) {
        return false;
    }
    if (path[n - 1] == '/') {
        path[n - 1] = '\0';
    }

    for (char *p = path + 1; *p != '\0'; ++p) {
        if (*p == '/') {
            *p = '\0';
            if (::mkdir(path, 0777) != 0 && errno != EEXIST) {
                return false;
            }
            *p = '/';
        }
    }
    return (::mkdir(path, 0777) == 0 || errno == EEXIST);
}

static void install_tb_crash_handlers() {
#if !defined(_WIN32)
    static bool installed = false;
    if (installed) {
        return;
    }
    installed = true;

    auto handler = +[](int signum) {
        const char *name = "UNKNOWN";
        switch (signum) {
            case SIGSEGV: name = "SIGSEGV"; break;
            case SIGABRT: name = "SIGABRT"; break;
            case SIGFPE:  name = "SIGFPE"; break;
            case SIGILL:  name = "SIGILL"; break;
            case SIGBUS:  name = "SIGBUS"; break;
            default: break;
        }

        ::dprintf(2, "\n[FATAL] Testbench crashed: signal %d (%s)\n", signum, name);
        void *frames[64];
        const int n = ::backtrace(frames, static_cast<int>(sizeof(frames) / sizeof(frames[0])));
        ::backtrace_symbols_fd(frames, n, 2);
        ::dprintf(2, "[FATAL] End backtrace\n");
        ::_exit(128 + signum);
    };

    std::signal(SIGSEGV, handler);
    std::signal(SIGABRT, handler);
    std::signal(SIGFPE, handler);
    std::signal(SIGILL, handler);
    std::signal(SIGBUS, handler);
#endif
}

static bool init_tb_logs() {
    // Match existing MatMul-mode TB convention: logs live under:
    //   <repo>/Model-architectures/gpt2-MatMulMode/logs/Top_Module_MATMUL_ARCH
    //
    // Prefer a repo-root derived path (works even if __FILE__ is relative),
    // with a local fallback for toolchains that rewrite __FILE__.
    std::string log_root;
    {
        const std::string repo_root = tb_paths::infer_repo_root_from_file(__FILE__);
        if (!repo_root.empty()) {
            log_root = repo_root + "/Model-architectures/gpt2-MatMulMode/logs";
        } else {
            log_root = tb_paths::dirname_of(__FILE__) + "/../logs";
        }
    }
    char log_dir[512];
    std::snprintf(log_dir, sizeof(log_dir), "%s/%s", log_root.c_str(), MATMUL_MODE_TB_LOG_SUBDIR);

    if (!ensure_dir_recursive(log_dir)) {
        std::fprintf(stderr, "ERROR: Failed to create log dir '%s': %s\n",
                     log_dir, std::strerror(errno));
        return false;
    }

    char stdout_path[512];
    char stderr_path[512];
    char timestamp[32];
    {
        const std::time_t now = std::time(nullptr);
        std::tm tm_now{};
#if defined(_WIN32)
        localtime_s(&tm_now, &now);
#else
        localtime_r(&now, &tm_now);
#endif
        std::strftime(timestamp, sizeof(timestamp), "%Y%m%d_%H%M%S", &tm_now);
    }

    std::snprintf(stdout_path, sizeof(stdout_path), "%s/%s_stdout_%s.log",
                  log_dir, MATMUL_MODE_TB_BASENAME, timestamp);
    std::snprintf(stderr_path, sizeof(stderr_path), "%s/%s_stderr_%s.log",
                  log_dir, MATMUL_MODE_TB_BASENAME, timestamp);

    if (std::freopen(stdout_path, "w", stdout) == nullptr) {
        std::fprintf(stderr, "ERROR: Failed to open stdout log '%s': %s\n",
                     stdout_path, std::strerror(errno));
        return false;
    }
    if (std::freopen(stderr_path, "w", stderr) == nullptr) {
        std::fprintf(stdout, "ERROR: Failed to open stderr log '%s': %s\n",
                     stderr_path, std::strerror(errno));
        return false;
    }

    std::setvbuf(stdout, nullptr, _IONBF, 0);
    std::setvbuf(stderr, nullptr, _IONBF, 0);
    install_tb_crash_handlers();

    std::printf("[LOG] %s stdout: %s\n", MATMUL_MODE_TB_BASENAME, stdout_path);
    std::fprintf(stderr, "[LOG] %s stderr: %s\n", MATMUL_MODE_TB_BASENAME, stderr_path);
    return true;
}

// ---------------------------------------------------------------------------
// Tee logger: writes to both stdout/stderr and the csim log file
// ---------------------------------------------------------------------------
static FILE *g_log_fp = nullptr;

static void tprintf(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt); vprintf(fmt, ap); va_end(ap);
    if (g_log_fp) { va_start(ap, fmt); vfprintf(g_log_fp, fmt, ap); va_end(ap); fflush(g_log_fp); }
}

static void tprintf_err(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt); vfprintf(stderr, fmt, ap); va_end(ap);
    if (g_log_fp) { va_start(ap, fmt); vfprintf(g_log_fp, fmt, ap); va_end(ap); fflush(g_log_fp); }
}

// ---------------------------------------------------------------------------
// Constants from shared_params / top_params (mirrored here for clarity)
// ---------------------------------------------------------------------------
static constexpr uint64_t TB_DDR_IMAGE_WORDS = static_cast<uint64_t>(WEIGHTS_SIZE) / AXI_GMEM_WORD_BYTES;
static constexpr uint64_t TB_KV_IMAGE_WORDS  = static_cast<uint64_t>(KV_SIZE)      / AXI_GMEM_WORD_BYTES;

// Max simulation cycles per invocation (should be more than enough for C-sim)
static constexpr int MAX_CYCLES_PER_TILE = 20000;

// ---------------------------------------------------------------------------
// Output record format written to matmul_results.bin
// Binary, one record per invocation:
//   uint8  op
//   uint8  layer
//   uint8  head
//   uint16 tile        (little-endian)
//   uint8  n_int32s    (number of valid int32 outputs)
//   int32  out[n_int32s]  (little-endian)
// ---------------------------------------------------------------------------
static void write_result_record(std::ofstream &out,
                                uint8_t op, uint8_t layer, uint8_t head, uint16_t tile,
                                const int32_t *vals, uint8_t n)
{
    out.write(reinterpret_cast<const char *>(&op),    1);
    out.write(reinterpret_cast<const char *>(&layer), 1);
    out.write(reinterpret_cast<const char *>(&head),  1);
    out.write(reinterpret_cast<const char *>(&tile),  2);  // little-endian on x86
    out.write(reinterpret_cast<const char *>(&n),     1);
    out.write(reinterpret_cast<const char *>(vals),   n * 4);
}

// ---------------------------------------------------------------------------
// Valid output int32 count per op (per tile for LOGITS, per tile slice for others)
// ---------------------------------------------------------------------------
static inline int valid_n_out(uint8_t op)
{
    switch (op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V:          return D_HEAD_TILE_QKV;          // 4
        case CMP_ATT_SCORES: return ATT_CTX_BLOCK;             // 64
        case CMP_ATT_VALUE:  return D_HEAD_TILE_ATT_VALUE;     // 4
        case CMP_OUT_PROJ:   return D_TILE_WO;                 // 16
        case CMP_FFN_W1:     return D_TILE_W1;                 // 16
        case CMP_FFN_W2:     return D_TILE_W2;                 // 8
        case CMP_LOGITS:     return D_TILE_LOGIT;              // 16
        default:             return 0;
    }
}

// Returns true if the op uses per-tile streaming (LOGITS only).
static inline bool op_is_per_tile_stream(uint8_t op) { return op == CMP_LOGITS; }

// ---------------------------------------------------------------------------
// Tile count per op (scheduler internally iterates tiles; PS does not specify tile)
// ---------------------------------------------------------------------------
static inline int tile_end_for_op(uint8_t op)
{
    switch (op) {
        case CMP_Q:
        case CMP_K:
        case CMP_V:          return NUM_QKV_HEAD_TILES;
        case CMP_ATT_SCORES: return NUM_ATT_CTX_BLOCKS;
        case CMP_ATT_VALUE:  return NUM_ATT_VALUE_HEAD_TILES; // d_tile only (no ctx chunking)
        case CMP_OUT_PROJ:   return NUM_WO_TILES;
        case CMP_FFN_W1:     return NUM_W1_TILES;
        case CMP_FFN_W2:     return NUM_W2_TILES;
        case CMP_LOGITS:     return NUM_LOGIT_TILES;
        default:             return 0;
    }
}

static inline uint16_t tile_for_burst(uint8_t op, int burst_idx)
{
    (void)op;
    // Tile is always the burst index. For ATT_VALUE this is d_tile_idx.
    return static_cast<uint16_t>(burst_idx);
}

// ---------------------------------------------------------------------------
// Activation byte count per op (bytes actually meaningful in the stream)
// (Stream is always padded to STREAM_IN_BUF_BYTES, and TLAST is always sent
// on the final beat to satisfy the MMU's STREAM_IN_BUF_BYTES requirement.)
// ---------------------------------------------------------------------------
static inline int act_len_for_op(uint8_t op)
{
    switch (op) {
        case CMP_ATT_SCORES: return D_HEADS;          // 64
        case CMP_ATT_VALUE:  return CONTEXT_LENGTH * 2; // int16[CONTEXT_LENGTH]
        case CMP_FFN_W2:     return D_FFN;            // 3072 (= STREAM_IN_BUF_BYTES)
        default:             return D_MODEL;           // 768
    }
}

// ---------------------------------------------------------------------------
// Helper: fill an axi_gmem_word array with repeating byte data
// ---------------------------------------------------------------------------
static void fill_axi_mem_bytes(axi_gmem_word_t *mem, uint64_t word_count,
                               const uint8_t *pattern, size_t pattern_len)
{
    const uint64_t total_bytes = word_count * AXI_GMEM_WORD_BYTES;
    for (uint64_t b = 0; b < total_bytes; ++b) {
        const uint8_t val = pattern[b % pattern_len];
        const uint64_t widx = b / AXI_GMEM_WORD_BYTES;
        const uint64_t bidx = b % AXI_GMEM_WORD_BYTES;
        axi_gmem_word_t w = mem[widx];
        w.range(static_cast<int>((bidx + 1) * 8 - 1), static_cast<int>(bidx * 8)) = val;
        mem[widx] = w;
    }
}

static void zero_axi_mem(axi_gmem_word_t *mem, uint64_t word_count)
{
    for (uint64_t i = 0; i < word_count; ++i) {
        mem[i] = axi_gmem_word_t(0);
    }
}

// ---------------------------------------------------------------------------
// Source directory helper (mirrors top_no_debug_tb.cpp)
// ---------------------------------------------------------------------------
static std::string tb_source_dir()
{
    std::string path(__FILE__);
    const std::string::size_type slash = path.find_last_of("/\\");
    return (slash == std::string::npos) ? "." : path.substr(0, slash);
}

// ---------------------------------------------------------------------------
// DDR load (same as existing TB)
// ---------------------------------------------------------------------------
static bool load_shared_ddr_image(axi_gmem_word_t *ddr_mem, uint64_t word_count)
{
    const std::string image_path =
        tb_model_bin_loader::default_generated_ddr_image_path(tb_source_dir());
    return tb_model_bin_loader::load_prebuilt_ddr_image(image_path, ddr_mem, word_count);
}

// ---------------------------------------------------------------------------
// Build default ctrl_mem with all weight offsets (identical to old TB)
// ---------------------------------------------------------------------------
static ControlMemSpace make_default_ctrl_mem()
{
    ControlMemSpace ctrl_mem{};
    ctrl_mem.control           = CTRL_RESETN_BIT;
    ctrl_mem.instr             = 0;
    ctrl_mem.irq_mask          = IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT;
    ctrl_mem.irq_clear         = 0;
    ctrl_mem.wq_offset         = WQ_OFF;
    ctrl_mem.wk_offset         = WK_OFF;
    ctrl_mem.wv_offset         = WV_OFF;
    ctrl_mem.wo_offset         = WO_OFF;
    ctrl_mem.w1_offset         = W1_OFF;
    ctrl_mem.w2_offset         = W2_OFF;
    ctrl_mem.k_cache_offset    = K_CACHE_OFF;
    ctrl_mem.v_cache_offset    = V_CACHE_OFF;
    ctrl_mem.wq_bias_offset    = WQ_BIAS_OFF;
    ctrl_mem.wk_bias_offset    = WK_BIAS_OFF;
    ctrl_mem.wv_bias_offset    = WV_BIAS_OFF;
    ctrl_mem.wo_bias_offset    = WO_BIAS_OFF;
    ctrl_mem.w1_bias_offset    = W1_BIAS_OFF;
    ctrl_mem.w2_bias_offset    = W2_BIAS_OFF;
    ctrl_mem.ln0_gamma_offset  = LN0_GAMMA_OFF;
    ctrl_mem.ln1_gamma_offset  = LN1_GAMMA_OFF;
    ctrl_mem.final_norm_gamma_offset = FINAL_NORM_GAMMA_OFF;
    ctrl_mem.ln0_beta_offset   = LN0_BETA_OFF;
    ctrl_mem.ln1_beta_offset   = LN1_BETA_OFF;
    ctrl_mem.final_norm_beta_offset  = FINAL_NORM_BETA_OFF;
    ctrl_mem.ln0_eps_offset    = LN0_EPS_OFF;
    ctrl_mem.ln1_eps_offset    = LN1_EPS_OFF;
    ctrl_mem.final_norm_eps_offset   = FINAL_NORM_EPS_OFF;
    ctrl_mem.wlogit_offset     = WLOGIT_OFF;
    ctrl_mem.token_position    = 0;
    return ctrl_mem;
}

// ---------------------------------------------------------------------------
// run_one_matmul
//
// Runs a single tiled matmul invocation end-to-end through transformer_top.
// Streams `act_len` activation bytes (padded to STREAM_IN_BUF_BYTES with zeros,
// TLAST on the last meaningful byte so the scheduler sees token_complete).
// Returns valid int32 outputs decoded from the stream-out payload.
//
// NOTE: Both s_axis and m_axis are PERSISTENT between calls — caller must ensure
// they are empty on entry (drain any leftover beats if needed).
// ---------------------------------------------------------------------------
struct MatmulInvocationResult {
    bool     ok;
    uint8_t  op;
    uint8_t  layer;
    uint8_t  head;
    int      tiles_expected;
    int      tiles_seen;
    int32_t  first_out0;
};

static MatmulInvocationResult run_one_matmul(
    hls::stream<axis8_t>  &s_axis,
    hls::stream<axis8_t>  &m_axis,
    axi_gmem_word_t       *ddr_mem,
    axi_gmem_word_t       *kv_cache,
    std::ofstream         &out_file,
    ControlMemSpace        ctrl_mem,   // passed by value (will mutate locally)
    uint8_t op, uint8_t layer, uint8_t head,
    const uint8_t *act,   // activation bytes (act_len meaningful, rest is zero)
    int act_len)
{
    MatmulInvocationResult result{};
    result.op    = op;
    result.layer = layer;
    result.head  = head;
    result.tiles_expected = tile_end_for_op(op);
    result.tiles_seen = 0;
    result.first_out0 = 0;

    const int n_out = valid_n_out(op);

    // Encode instruction (tiling is managed on-chip; PS only supplies op/layer/head):
    //   [3:0]=op, [11:4]=layer (8-bit), [19:12]=head (8-bit)
    ctrl_mem.instr = (static_cast<uint32_t>(head)  << PS_INSTR_HEAD_SHIFT)
                   | (static_cast<uint32_t>(layer) << PS_INSTR_LAYER_SHIFT)
                   | (static_cast<uint32_t>(op)    << PS_INSTR_OP_SHIFT);

    StatusMemSpace status_mem{};
    bool irq_ps = false;
    SchedState dbg_state = S_IDLE;

    // -- Phase 1: Assert reset (4 cycles) ------------------------------------
    ctrl_mem.control = 0u;
    for (int i = 0; i < 4; ++i) {
        transformer_top(s_axis, m_axis, ddr_mem, kv_cache, ctrl_mem, status_mem, irq_ps, dbg_state);
    }

    // -- Phase 2: Release reset + start (1 cycle) ----------------------------
    ctrl_mem.control = CTRL_RESETN_BIT | CTRL_START_BIT;
    transformer_top(s_axis, m_axis, ddr_mem, kv_cache, ctrl_mem, status_mem, irq_ps, dbg_state);

    // -- Phase 3: Clear start -------------------------------------------------
    ctrl_mem.control = CTRL_RESETN_BIT;

    // Pre-load AXIS stream: meaningful bytes up to act_len, then zero-pad up to
    // STREAM_IN_BUF_BYTES. TLAST is asserted on the final beat (MMU requires
    // STREAM_IN_BUF_BYTES bytes per token).
    for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
        axis8_t beat{};
        beat.data = (i < act_len) ? static_cast<ap_uint<8>>(act[i]) : ap_uint<8>(0);
        beat.keep = 1;
        beat.strb = 1;
        beat.last = (i == (STREAM_IN_BUF_BYTES - 1)) ? ap_uint<1>(1) : ap_uint<1>(0);
        s_axis.write(beat);
    }

    // -- Main cycle loop ------------------------------------------------------
    // Non-LOGITS: single TLAST per invocation carries the full activation.
    // LOGITS: one TLAST per tile (per-tile streaming, unchanged).
    const bool per_tile_stream = op_is_per_tile_stream(op);
    uint8_t burst_buf[FULL_OUT_BUF_BYTES] = {};
    int     burst_count     = 0;
    bool    done_seen       = false;
    int     idle_cycles     = 0;
    bool    ok              = false;
    bool    error_seen      = false;

    const int max_cycles = (result.tiles_expected > 0)
                           ? (MAX_CYCLES_PER_TILE * result.tiles_expected)
                           : MAX_CYCLES_PER_TILE;
    for (int cycle = 0; cycle < max_cycles; ++cycle) {
        transformer_top(s_axis, m_axis, ddr_mem, kv_cache, ctrl_mem, status_mem, irq_ps, dbg_state);

        // Drain stream-out
        axis8_t beat_out{};
        while (m_axis.read_nb(beat_out)) {
            if (burst_count < FULL_OUT_BUF_BYTES) {
                burst_buf[burst_count++] = static_cast<uint8_t>(beat_out.data);
            }
            if (beat_out.last != 0) {
                if (per_tile_stream) {
                    // LOGITS: one tile per TLAST — same as before.
                    if (result.tiles_seen >= result.tiles_expected) {
                        std::fprintf(stderr,
                            "  ERROR extra burst on (op=%u L=%u H=%u): tiles_seen=%d tiles_expected=%d\n",
                            op, layer, head, result.tiles_seen, result.tiles_expected);
                        error_seen = true;
                        break;
                    }
                    int32_t decoded[ATT_CTX_BLOCK] = {};
                    for (int i = 0; i < n_out && i < ATT_CTX_BLOCK; ++i) {
                        const int b = i * 4;
                        decoded[i] = static_cast<int32_t>(
                            static_cast<uint32_t>(burst_buf[b + 0])
                          | (static_cast<uint32_t>(burst_buf[b + 1]) << 8)
                          | (static_cast<uint32_t>(burst_buf[b + 2]) << 16)
                          | (static_cast<uint32_t>(burst_buf[b + 3]) << 24));
                    }
                    const uint16_t tile = tile_for_burst(op, result.tiles_seen);
                    write_result_record(out_file, op, layer, head, tile,
                                        decoded, static_cast<uint8_t>(n_out));
                    if (result.tiles_seen == 0) {
                        result.first_out0 = decoded[0];
                    }
                    result.tiles_seen++;
                    burst_count = 0;
                    // Stream-out logging
                    tprintf("  [STREAM OUT] op=%u L=%u H=%u tile=%u n=%d:", op, layer, head, tile, n_out);
                    for (int _i = 0; _i < n_out && _i < 8; ++_i) tprintf(" %d", decoded[_i]);
                    if (n_out > 8) tprintf(" ...");
                    tprintf("\n");
                } else {
                    // Non-LOGITS: single TLAST carries all tiles concatenated.
                    // Slice burst_buf into per-tile chunks and write per-tile records.
                    const int tile_bytes = n_out * 4;
                    for (int t = 0; t < result.tiles_expected; ++t) {
                        int32_t decoded[ATT_CTX_BLOCK] = {};
                        for (int i = 0; i < n_out && i < ATT_CTX_BLOCK; ++i) {
                            const int b = t * tile_bytes + i * 4;
                            decoded[i] = static_cast<int32_t>(
                                static_cast<uint32_t>(burst_buf[b + 0])
                              | (static_cast<uint32_t>(burst_buf[b + 1]) << 8)
                              | (static_cast<uint32_t>(burst_buf[b + 2]) << 16)
                              | (static_cast<uint32_t>(burst_buf[b + 3]) << 24));
                        }
                        write_result_record(out_file, op, layer, head,
                                            static_cast<uint16_t>(t),
                                            decoded, static_cast<uint8_t>(n_out));
                        if (t == 0) {
                            result.first_out0 = decoded[0];
                        }
                        result.tiles_seen++;
                        // Stream-out logging
                        tprintf("  [STREAM OUT] op=%u L=%u H=%u tile=%d/%d n=%d:", op, layer, head, t, result.tiles_expected, n_out);
                        for (int _i = 0; _i < n_out && _i < 8; ++_i) tprintf(" %d", decoded[_i]);
                        if (n_out > 8) tprintf(" ...");
                        tprintf("\n");
                    }
                    burst_count = 0;
                }
            }
        }
        if (error_seen) {
            break;
        }

        // Clear IRQ_INFER_DONE_BIT after latching it
        if (status_mem.irq_status & IRQ_INFER_DONE_BIT) {
            done_seen = true;
            ctrl_mem.irq_clear = IRQ_INFER_DONE_BIT;
        } else {
            ctrl_mem.irq_clear = 0;
        }

        // Error check
        if (status_mem.error_code != ERR_NONE) {
            const uint32_t ec = status_mem.error_code;
            std::fprintf(stderr,
                "  ERROR on (op=%u L=%u H=%u tile_idx=%d/%d): error_code=0x%08X cycle=%d\n",
                op, layer, head, result.tiles_seen, result.tiles_expected, ec, cycle);
            // Decode each set bit
            struct { uint32_t mask; const char *name; } errbits[] = {
                { ERR_DMA_ALIGNMENT,                          "ERR_DMA_ALIGNMENT"                          },
                { ERR_DMA_ZERO_LEN,                           "ERR_DMA_ZERO_LEN"                           },
                { ERR_DMA_ZERO_STRIDE,                        "ERR_DMA_ZERO_STRIDE"                        },
                { ERR_SCHEDULER_ERROR,                        "ERR_SCHEDULER_ERROR"                        },
                { ERR_COMPUTE_ERROR,                          "ERR_COMPUTE_ERROR"                          },
                { ERR_MMU_INVALID,                            "ERR_MMU_INVALID"                            },
                { ERR_MMU_OVERFLOW,                           "ERR_MMU_OVERFLOW"                           },
                { ERR_MMU_UNSUPPORTED_REQ_DMA,                "ERR_MMU_UNSUPPORTED_REQ_DMA"                },
                { ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED,  "ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_HEADED"  },
                { ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED, "ERR_MMU_UNSUPPORTED_REQ_COMPUTE_OP_NON_HEADED" },
                { ERR_MMU_BAD_DMA_PLAN,                       "ERR_MMU_BAD_DMA_PLAN"                       },
                { ERR_MMU_BAD_DMA_ADDR,                       "ERR_MMU_BAD_DMA_ADDR"                       },
                { ERR_MMU_REGION_ACCESS,                      "ERR_MMU_REGION_ACCESS"                      },
                { ERR_MMU_CONCAT_SOURCE,                      "ERR_MMU_CONCAT_SOURCE"                      },
                { ERR_MMU_WRITEBACK_SRC,                      "ERR_MMU_WRITEBACK_SRC"                      },
                { ERR_MMU_QUEUE_OVERFLOW,                     "ERR_MMU_QUEUE_OVERFLOW"                     },
                { ERR_MMU_REGION_OVERFLOW,                    "ERR_MMU_REGION_OVERFLOW"                    },
                { ERR_MMU_STREAM_OUTPUT_MISSING,              "ERR_MMU_STREAM_OUTPUT_MISSING"              },
                { ERR_MMU_MISSING_REGION_FULL_READ,           "ERR_MMU_MISSING_REGION_FULL_READ"           },
                { ERR_MMU_MISSING_REGION_PARTIAL_READ,        "ERR_MMU_MISSING_REGION_PARTIAL_READ"        },
                { ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP,   "ERR_MMU_MISSING_REGION_COMPUTE_READ_PREP"   },
                { ERR_MMU_REGION_OVERFLOW_STREAM_IN,          "ERR_MMU_REGION_OVERFLOW_STREAM_IN"          },
                { ERR_MMU_REGION_OVERFLOW_DMA_CONCAT,         "ERR_MMU_REGION_OVERFLOW_DMA_CONCAT"         },
                { ERR_MMU_REGION_OVERFLOW_DMA_STORE,          "ERR_MMU_REGION_OVERFLOW_DMA_STORE"          },
                { ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE,      "ERR_MMU_REGION_OVERFLOW_COMPUTE_WRITE"      },
                { ERR_MMU_REGION_TABLE_FULL,                  "ERR_MMU_REGION_TABLE_FULL"                  },
                { ERR_MMU_URAM_CHUNK_ALLOC_FAIL,              "ERR_MMU_URAM_CHUNK_ALLOC_FAIL"              },
                { ERR_MMU_REGION_TOO_LARGE,                   "ERR_MMU_REGION_TOO_LARGE"                   },
                { ERR_TOKEN_MAX,                              "ERR_TOKEN_MAX"                              },
            };
            for (const auto &b : errbits) {
                if (ec & b.mask) {
                    std::fprintf(stderr, "    [bit] %s\n", b.name);
                }
            }
            error_seen = true;
            break;
        }

        // Done: IRQ seen AND back to IDLE for 4+ cycles
        if (done_seen && status_mem.status == static_cast<uint32_t>(S_IDLE)) {
            idle_cycles++;
        } else if (done_seen) {
            idle_cycles = 0;
        }
        if (done_seen && (result.tiles_seen == result.tiles_expected) && idle_cycles >= 4) {
            ok = true;
            break;
        }
    }

    if (!ok && !error_seen) {
        std::fprintf(stderr,
            "  TIMEOUT on (op=%u L=%u H=%u): done=%d tiles=%d/%d idle=%d\n",
            op, layer, head, done_seen, result.tiles_seen, result.tiles_expected, idle_cycles);
    }

    result.ok = ok && !error_seen;

    return result;
}

// ---------------------------------------------------------------------------
// main
// ---------------------------------------------------------------------------
int main()
{
    if (!init_tb_logs()) {
        return 1;
    }

    std::printf("=== MatMul Mode Testbench ===\n");
#ifdef TB_QUICK_MODE
    std::printf("  [QUICK MODE: layer=0, head=0 only]\n");
#endif

    tprintf("=== MatMul Mode Testbench ===\n");
#ifdef TB_QUICK_MODE
    tprintf("  [QUICK MODE: layer=0, head=0 only]\n");
#endif

    // --- Load DDR image (weights) -------------------------------------------
    std::vector<axi_gmem_word_t> ddr_mem(static_cast<size_t>(TB_DDR_IMAGE_WORDS));
    std::vector<axi_gmem_word_t> kv_cache(static_cast<size_t>(TB_KV_IMAGE_WORDS));

    if (!load_shared_ddr_image(ddr_mem.data(), TB_DDR_IMAGE_WORDS)) {
        tprintf_err("ERROR: Failed to load DDR image\n");
        return 1;
    }
    tprintf("DDR image loaded (%llu words)\n",
            static_cast<unsigned long long>(TB_DDR_IMAGE_WORDS));

    // --- Load stream_in.bin (first token as activation) ---------------------
    uint8_t stream_in_token[STREAM_IN_BUF_BYTES] = {};
    {
#ifdef FULL_MODEL_TEST
        const std::string path = tb_source_dir() + "/../model/stream_in.bin";
#else
        const std::string path = tb_source_dir() + "/test_data/stream_in.bin";
#endif
        std::ifstream f(path, std::ios::binary);
        if (!f.is_open()) {
            tprintf_err("ERROR: Cannot open %s\n", path.c_str());
            return 1;
        }
        f.read(reinterpret_cast<char *>(stream_in_token), STREAM_IN_BUF_BYTES);
        const auto read_bytes = f.gcount();
        if (read_bytes < D_MODEL) {
            tprintf_err("ERROR: stream_in.bin too short (%ld bytes)\n",
                        static_cast<long>(read_bytes));
            return 1;
        }
        tprintf("stream_in.bin loaded (%ld bytes)\n", static_cast<long>(read_bytes));
    }

    // --- Populate kv_cache with repeating stream_in[0:D_HEADS] pattern ------
    // This gives ATT_SCORES/ATT_VALUE meaningful (non-zero) and reproducible data.
    // Python verify_matmul.py uses the same fill to extract expected K/V tiles.
    zero_axi_mem(kv_cache.data(), TB_KV_IMAGE_WORDS);
    fill_axi_mem_bytes(kv_cache.data(), TB_KV_IMAGE_WORDS,
                       stream_in_token, static_cast<size_t>(D_HEADS));
    tprintf("KV cache filled with repeating stream_in[0:%d] pattern\n", D_HEADS);

    // --- Open output file ---------------------------------------------------
    const std::string out_path = tb_source_dir() + "/matmul_results.bin";
    std::ofstream out_file(out_path, std::ios::binary);
    if (!out_file.is_open()) {
        tprintf_err("ERROR: Cannot open output file %s\n", out_path.c_str());
        return 1;
    }
    tprintf("Writing results to: %s\n\n", out_path.c_str());

    // --- Build ctrl_mem template --------------------------------------------
    const ControlMemSpace ctrl_template = make_default_ctrl_mem();

    // --- Dump ctrl_mem for verification ------------------------------------
    tprintf("\n=== ControlMemSpace (before matmuls) ===\n");
    tprintf("  wq_offset        = 0x%08X\n", ctrl_template.wq_offset);
    tprintf("  wk_offset        = 0x%08X\n", ctrl_template.wk_offset);
    tprintf("  wv_offset        = 0x%08X\n", ctrl_template.wv_offset);
    tprintf("  wo_offset        = 0x%08X\n", ctrl_template.wo_offset);
    tprintf("  w1_offset        = 0x%08X\n", ctrl_template.w1_offset);
    tprintf("  w2_offset        = 0x%08X\n", ctrl_template.w2_offset);
    tprintf("  wlogit_offset    = 0x%08X\n", ctrl_template.wlogit_offset);
    tprintf("  k_cache_offset   = 0x%08X\n", ctrl_template.k_cache_offset);
    tprintf("  v_cache_offset   = 0x%08X\n", ctrl_template.v_cache_offset);
    tprintf("  wq_bias_offset   = 0x%08X\n", ctrl_template.wq_bias_offset);
    tprintf("  wk_bias_offset   = 0x%08X\n", ctrl_template.wk_bias_offset);
    tprintf("  wv_bias_offset   = 0x%08X\n", ctrl_template.wv_bias_offset);
    tprintf("  wo_bias_offset   = 0x%08X\n", ctrl_template.wo_bias_offset);
    tprintf("  w1_bias_offset   = 0x%08X\n", ctrl_template.w1_bias_offset);
    tprintf("  w2_bias_offset   = 0x%08X\n", ctrl_template.w2_bias_offset);
    tprintf("=========================================\n\n");

    // --- AXIS streams (persistent across invocations) ----------------------
    hls::stream<axis8_t> s_axis("s_axis_in");
    hls::stream<axis8_t> m_axis("m_axis_out");

    // --- Iteration limits --------------------------------------------------
    // Default sweep is intentionally small for fast bring-up:
    //   layer=0, head=0..2.
#ifdef TB_QUICK_MODE
    const int max_layer   = 1;
    const int max_head    = 1;
#else
    constexpr int TB_LIMIT = 3;
    const int max_layer    = 1; // layer 0 only
    const int max_head     = (NUM_HEADS < TB_LIMIT) ? NUM_HEADS : TB_LIMIT;
#endif

    int total = 0;
    int passed = 0;
    int failed = 0;

    // Activation slices (zero-padded to STREAM_IN_BUF_BYTES)
    // D_MODEL bytes from stream_in (for Q/K/V/OUT_PROJ/W1/LOGITS)
    const uint8_t *act_model = stream_in_token;     // first D_MODEL bytes
    // D_HEADS bytes from stream_in (for ATT_SCORES)
    const uint8_t *act_heads = stream_in_token;     // first D_HEADS bytes
    // int16[CONTEXT_LENGTH] softmax weights (for ATT_VALUE)
    uint8_t act_ctx_i16[static_cast<size_t>(CONTEXT_LENGTH) * 2] = {};
    for (int t = 0; t < CONTEXT_LENGTH; ++t) {
        const int16_t w = static_cast<int16_t>(static_cast<int8_t>(stream_in_token[t]));
        act_ctx_i16[t * 2 + 0] = static_cast<uint8_t>(static_cast<uint16_t>(w) & 0xFFu);
        act_ctx_i16[t * 2 + 1] = static_cast<uint8_t>((static_cast<uint16_t>(w) >> 8) & 0xFFu);
    }
    // D_FFN bytes = full STREAM_IN_BUF_BYTES (for W2)
    const uint8_t *act_ffn   = stream_in_token;     // full D_FFN bytes

    auto run = [&](uint8_t op, int layer, int head) -> bool {
        const int act_len = act_len_for_op(op);
        const uint8_t *act = (op == CMP_FFN_W2)      ? act_ffn
                           : (op == CMP_ATT_SCORES)  ? act_heads
                           : (op == CMP_ATT_VALUE)   ? act_ctx_i16
                           : act_model;

        MatmulInvocationResult r = run_one_matmul(
            s_axis, m_axis,
            ddr_mem.data(), kv_cache.data(),
            out_file,
            ctrl_template,
            op, static_cast<uint8_t>(layer), static_cast<uint8_t>(head),
            act, act_len);

        total  += r.tiles_expected;
        if (r.ok) { passed += r.tiles_expected; }
        else      { failed += r.tiles_expected; }

        static int report_every = 100;
        if (total % report_every == 0 || !r.ok) {
            const char *op_name = (op == CMP_Q)          ? "Q"
                                : (op == CMP_K)          ? "K"
                                : (op == CMP_V)          ? "V"
                                : (op == CMP_ATT_SCORES) ? "ATT_SCORES"
                                : (op == CMP_ATT_VALUE)  ? "ATT_VALUE"
                                : (op == CMP_OUT_PROJ)   ? "OUT_PROJ"
                                : (op == CMP_FFN_W1)     ? "W1"
                                : (op == CMP_FFN_W2)     ? "W2"
                                : (op == CMP_LOGITS)     ? "LOGITS"
                                : "?";
            tprintf("[%5d] %-10s L=%2d H=%2d  tiles=%d/%d  %s  out0=%d\n",
                    total, op_name, layer, head,
                    r.tiles_seen, r.tiles_expected,
                    r.ok ? "PASS" : "FAIL",
                    r.ok ? r.first_out0 : 0);
        }
        return r.ok;
    };

    // =========================================================================
    // Main loop: per layer → Q/K/V → ATT_SCORES → ATT_VALUE → OUT_PROJ → W1 → W2
    // =========================================================================
    for (int layer = 0; layer < max_layer; ++layer) {
        tprintf("\n--- Layer %d ---\n", layer);

        // Q, K, V: per-head (scheduler internally iterates tiles)
        for (int head = 0; head < max_head; ++head) {
            run(CMP_Q, layer, head);
            run(CMP_K, layer, head);
            run(CMP_V, layer, head);
        }

        // ATT_SCORES: per-head (scheduler internally iterates ctx blocks)
        for (int head = 0; head < max_head; ++head) {
            run(CMP_ATT_SCORES, layer, head);
        }

        // ATT_VALUE: per-head (scheduler internally iterates d_tile only)
        for (int head = 0; head < max_head; ++head) {
            run(CMP_ATT_VALUE, layer, head);
        }

        // OUT_PROJ (head ignored)
        run(CMP_OUT_PROJ, layer, 0);

        // W1 (head ignored)
        run(CMP_FFN_W1, layer, 0);

        // W2 (head ignored)
        run(CMP_FFN_W2, layer, 0);
    }

    // LOGITS (all tiles, layer index irrelevant — use 0)
    tprintf("\n--- LOGITS ---\n");
    run(CMP_LOGITS, 0, 0);

    out_file.close();

    tprintf("\n=== Results ===\n");
    tprintf("  Total:  %d\n", total);
    tprintf("  Passed: %d\n", passed);
    tprintf("  Failed: %d\n", failed);
    tprintf("  Output: %s\n", out_path.c_str());

    if (g_log_fp) { std::fclose(g_log_fp); g_log_fp = nullptr; }
    return (failed == 0) ? 0 : 1;
}
