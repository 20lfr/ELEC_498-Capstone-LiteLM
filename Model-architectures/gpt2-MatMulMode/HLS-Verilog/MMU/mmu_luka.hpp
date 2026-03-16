#pragma once

#include <cstdint>
#include "../top_params.hpp"

constexpr int URAM_BANKS_TOTAL = 64;
#ifndef MMU_RESERVED_URAM_BANKS
#define MMU_RESERVED_URAM_BANKS 40
#endif
constexpr int URAM_BANKS = URAM_BANKS_TOTAL - MMU_RESERVED_URAM_BANKS;
static_assert(MMU_RESERVED_URAM_BANKS >= 0 && MMU_RESERVED_URAM_BANKS < URAM_BANKS_TOTAL,
              "MMU_RESERVED_URAM_BANKS must be in [0, URAM_BANKS_TOTAL)");
static_assert(URAM_BANKS > 0, "MMU must have at least one URAM bank");
// constexpr uint32_t URAM_BANK_BYTES = 36864; // 288Kb / 8

constexpr uint32_t URAM_BANK_BYTES = 32768; // 288Kb / 8


constexpr uint32_t URAM_BANK_WORD_BYTES = AXI_GMEM_WORD_BYTES;
static_assert((URAM_BANK_BYTES % URAM_BANK_WORD_BYTES) == 0,
              "URAM_BANK_BYTES must be word-aligned");
constexpr uint32_t URAM_BANK_WORDS = URAM_BANK_BYTES / URAM_BANK_WORD_BYTES;

// FAST_SYNTH profile:
//   0 -> full-capacity MMU sizing (default)
//   1 -> reduced MMU bookkeeping/buffer sizing for faster HLS synth iterations
#ifndef FAST_SYNTH
#define FAST_SYNTH 0
#endif

#if FAST_SYNTH
constexpr int MAX_CHUNKS = 4;
constexpr int MAX_REGIONS = 16;
constexpr int DMA_QUEUE_DEPTH = 4;
constexpr int COMPUTE_QUEUE_DEPTH = 4;
constexpr int DMA_BUF_BYTES = 8192;
#else
constexpr int MAX_CHUNKS = URAM_BANKS / 2; // one chunk per bank is the physical maximum
constexpr int MAX_REGIONS = 256 / 2;
constexpr int DMA_QUEUE_DEPTH = 16;
constexpr int COMPUTE_QUEUE_DEPTH = 16;
constexpr int DMA_BUF_BYTES = 65536 / 2;
#endif
constexpr int DMA_BUF_WORDS = DMA_BUF_BYTES / AXI_GMEM_WORD_BYTES;
static_assert((DMA_BUF_BYTES % AXI_GMEM_WORD_BYTES) == 0, "DMA_BUF_BYTES must be word-aligned");

enum class ComputeReqType : uint8_t {
    NONE = 0,
    READ = 1,
    WRITE = 2
};

enum class State : uint8_t {
    IDLE = 0,
    DMA_POP,
    DMA_PREP,
    DMA_ISSUE,
    DMA_WAIT,
    DMA_STORE,
    DMA_INTERNAL_CONCAT,
    DMA_WRITEBACK_PREP,
    DMA_WRITEBACK_ISSUE,
    DMA_WRITEBACK_WAIT,
    COMPUTE_POP,
    COMPUTE_READ_PREP,
    COMPUTE_READ_DONE,
    COMPUTE_WRITE_PREP,
    COMPUTE_WRITE_DONE,
    GC_SCAN
};

enum class Tag : uint8_t {
    NONE = 0,

    // DMA-resident model/cache objects
    WQ_W, WQ_B,
    WK_W, WK_B,
    WV_W, WV_B,
    WO_W, WO_B,
    W1_W, W1_B,
    W2_W, W2_B,
    LOGITS_W,
    CTX_K,
    CTX_V,
    LN0_GAMMA,
    LN0_BETA,
    LN0_EPS,
    LN1_GAMMA,
    LN1_BETA,
    LN1_EPS,
    FINAL_NORM_GAMMA,
    FINAL_NORM_BETA,
    FINAL_NORM_EPS,

    // Main compute outputs
    STREAM_IN_TOKEN,
    LN0_OUT,
    REQUANT_POST_LN0_OUT,
    CONCAT_OUT,
    OUT_PROJ_PACKED,
    REQUANT_POST_OUTPROJ_OUT,
    RESID1_OUT,
    LN1_OUT,
    REQUANT_POST_LN1_OUT,
    FFN_W1_PACKED,
    FFN_ACT_OUT,
    FFN_W2_PACKED,
    REQUANT_POST_FFN_OUT,
    RESID2_OUT,
    FINAL_NORM_OUT,
    LOGITS_PACKED,
    ARGMAX_OUT,

    // Headed compute outputs
    Q_OUT,
    K_OUT,
    V_OUT,
    ATT_SCORES_OUT,
    VALUE_SCALE_OUT,
    SOFTMAX_OUT,
    ATT_VALUE_OUT,
    HEAD_REQUANT_PACKED
};

struct Chunk {
    uint8_t bank = 0;
    uint32_t offset = 0;
    uint32_t size = 0;
};

struct Region {
    bool valid = false;
    bool used = false;
    Tag tag = Tag::NONE;
    int16_t layer = -1;
    int16_t head = -1;
    int16_t tile = -1;

    uint32_t total_bytes = 0;
    uint16_t expected_parts = 0;
    uint16_t written_parts = 0;
    uint32_t part_bytes = 0;
    uint32_t part_mask = 0;

    uint8_t retain_count = 0;
    uint8_t num_chunks = 0;
    Chunk chunks[MAX_CHUNKS];
};

struct Status {
    State state = State::IDLE;
    bool overflow = false;
    bool invalid = false;
    uint32_t error_code = ERR_NONE;
    uint32_t error_subcode = MMU_ERR_SUBCODE_NONE;
    uint16_t region_count = 0;
};

void mmu_fsm(
    // ------------------------------------------------------------
    // Control / configuration
    // ------------------------------------------------------------
    bool reset_n,                       // [INPUT] Active-low reset
    ControlMemSpace ctrl_mem,           // [INPUT] Control memory snapshot
    uint16_t token_pos,                 // [INPUT] Current token position for KV cache slotting

    // ------------------------------------------------------------
    // External DMA control/payload
    // ------------------------------------------------------------
    bool dma_ready,                     // [INPUT] External DMA can accept new command
    bool dma_done,                      // [INPUT] External DMA transfer complete pulse
    const uint32_t dma_rx_buf[DMA_BUF_WORDS], // [INPUT] DMA read payload words (DDR -> MMU)
    uint32_t dma_tx_buf[DMA_BUF_WORDS],       // [OUTPUT] DMA write payload words (MMU -> DDR)
    bool &dma_start,                    // [OUTPUT] Start DMA transfer
    uint64_t &dma_addr,                 // [OUTPUT] DMA address
    uint32_t &dma_len,                  // [OUTPUT] DMA length in bytes
    bool &dma_is_write,                 // [OUTPUT] DMA direction (1 = write to DDR)
    bool &dma_use_kv_cache,             // [OUTPUT] Select KV-cache AXI interface

    // ------------------------------------------------------------
    // Stream ingress/egress buffers (beat capture on AXIS valid/ready)
    // ------------------------------------------------------------
    bool axis_in_valid,                 // [INPUT] AXIS ingress valid
    bool axis_in_last,                  // [INPUT] AXIS ingress TLAST
    bool axis_in_ready,                 // [INPUT] Scheduler AXIS ingress ready flag
    bool stream_start,                  // [INPUT] Scheduler pulse: begin stream-out payload
    const uint8_t stream_in_buf[STREAM_IN_BUF_BYTES], // [INPUT] Constructed stream-in payload
    uint8_t stream_out_buf[STREAM_OUT_BUF_BYTES],     // [OUTPUT] Stream-out payload produced by MMU

    // ------------------------------------------------------------
    // Main scheduler DMA requests
    // ------------------------------------------------------------
    bool mmu_dma_req_start,             // [INPUT] Main scheduler DMA request valid
    uint64_t mmu_dma_instruction,       // [INPUT] Packed DMA request [sel|layer|head|tile]
    bool &mmu_req_ready,                // [OUTPUT] MMU ready for new DMA request
    bool &main_wl_accept,               // [OUTPUT] Main scheduler wl request accepted/captured
    bool &main_dma_done,                // [OUTPUT] Main scheduler DMA completion pulse

    // ------------------------------------------------------------
    // Main compute requests
    // ------------------------------------------------------------
    bool mem_read_request,              // [INPUT] Main compute read request
    bool mem_write_request,             // [INPUT] Main compute write request
    uint64_t mem_op,                    // [INPUT] Packed compute op [op|layer|head|tile]
    bool &mem_transfer_done,            // [OUTPUT] Main compute transfer completion pulse

    // ------------------------------------------------------------
    // BRAM compute buffers (MMU owns transfer in/out)
    // ------------------------------------------------------------
    uint8_t in_buf[compute_buf::IN_BUF_BYTES], // [OUTPUT] MMU fills for main compute READ
    const uint8_t out_buf[compute_buf::OUT_BUF_BYTES], // [INPUT] MMU consumes for main compute WRITE

    // ------------------------------------------------------------
    // Status
    // ------------------------------------------------------------
    Status &status                      // [OUTPUT] MMU state/error summary
);

const char *state_name(State s);
