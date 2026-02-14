#pragma once

#include <cstdint>
#include "../top_params.hpp"

constexpr int URAM_BANKS = 64;
constexpr uint32_t URAM_BANK_BYTES = 36864; // 288Kb / 8
constexpr int MAX_CHUNKS = 8;
constexpr int MAX_REGIONS = 256;
constexpr int DMA_QUEUE_DEPTH = 16;
constexpr int COMPUTE_QUEUE_DEPTH = 16;
constexpr int DMA_BUF_BYTES = 65536;

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
    CTX_K,
    CTX_V,

    // Main compute outputs
    LN0_OUT,
    REQUANT1_OUT,
    CONCAT_OUT,
    OUT_PROJ_PACKED,
    REQUANT2_OUT,
    RESID0_OUT,
    LN1_OUT,
    REQUANT3_OUT,
    FFN_W1_PACKED,
    FFN_ACT_OUT,
    FFN_W2_PACKED,
    REQUANT4_OUT,
    RESID1_OUT,
    FINAL_NORM_OUT,

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
    uint16_t region_count = 0;
};

void mmu_fsm(
    // ------------------------------------------------------------
    // Control / configuration
    // ------------------------------------------------------------
    bool reset_n,                       // [INPUT] Active-low reset
    ControlMemSpace ctrl_mem,           // [INPUT] Control memory snapshot

    // ------------------------------------------------------------
    // External DMA control/payload
    // ------------------------------------------------------------
    bool dma_ready,                     // [INPUT] External DMA can accept new command
    bool dma_done,                      // [INPUT] External DMA transfer complete pulse
    const uint8_t dma_rx_buf[DMA_BUF_BYTES], // [INPUT] DMA read payload (DDR -> MMU)
    uint8_t dma_tx_buf[DMA_BUF_BYTES],       // [OUTPUT] DMA write payload (MMU -> DDR)
    bool &dma_start,                    // [OUTPUT] Start DMA transfer
    uint32_t &dma_addr,                 // [OUTPUT] DMA address
    uint32_t &dma_len,                  // [OUTPUT] DMA length in bytes
    bool &dma_is_write,                 // [OUTPUT] DMA direction (1 = write to DDR)

    // ------------------------------------------------------------
    // Main scheduler DMA requests
    // ------------------------------------------------------------
    bool mmu_dma_req_start,             // [INPUT] Main scheduler DMA request valid
    uint32_t mmu_dma_instruction,       // [INPUT] Packed DMA request [sel|layer|head|tile]
    bool &mmu_req_ready,                // [OUTPUT] MMU ready for new DMA request
    bool &main_dma_done,                // [OUTPUT] Main scheduler DMA completion pulse

    // ------------------------------------------------------------
    // Main compute requests
    // ------------------------------------------------------------
    bool mem_read_request,              // [INPUT] Main compute read request
    bool mem_write_request,             // [INPUT] Main compute write request
    uint32_t mem_op,                    // [INPUT] Packed compute op [op|layer|head|tile]
    bool &mem_transfer_done,            // [OUTPUT] Main compute transfer completion pulse

    // ------------------------------------------------------------
    // Head scheduler + headed compute contexts
    // ------------------------------------------------------------
    HeadCtx (&head_ctx)[NUM_HEADS],                 // [BOTH] Per-head scheduler handshake
    ComputeHeadCtx (&head_compute_ctx)[HEADS_PARALLEL], // [BOTH] Headed compute handshake

    // ------------------------------------------------------------
    // BRAM compute buffers (MMU owns transfer in/out)
    // ------------------------------------------------------------
    uint8_t in_buf[compute_buf::IN_BUF_BYTES], // [OUTPUT] MMU fills for main compute READ
    const uint8_t out_buf[compute_buf::OUT_BUF_BYTES], // [INPUT] MMU consumes for main compute WRITE
    uint8_t head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES], // [OUTPUT] MMU fills for headed READ
    const uint8_t head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES], // [INPUT] MMU consumes for headed WRITE

    // ------------------------------------------------------------
    // Status
    // ------------------------------------------------------------
    Status &status                      // [OUTPUT] MMU state/error summary
);

const char *state_name(State s);
