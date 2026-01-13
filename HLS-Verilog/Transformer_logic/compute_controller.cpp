#include "compute_controller.hpp"

namespace {

constexpr int MAX_VALUEA = D_MODEL;
constexpr int MAX_VALUEB = D_MODEL * D_HEADS;

// Simple controller state machine.
enum class ComputeState : uint8_t { IDLE = 0, WAIT_MEM, EXECUTE, MEM_WRITEBACK, DONE };

// Captured request from the scheduler.
struct PendingRequest {
    uint32_t instruction    = 0x00000000;
    ComputeOp op            = ComputeOp::CMP_NONE;
    uint8_t layer_idx       = 0;
    uint8_t head_idx        = 0;
    uint8_t tile_idx        = 0;
};

} // namespace

// ---------------------------------------------------------------------------
// Compute kernels
// ---------------------------------------------------------------------------
void OUT_PROJ(
    const int8_t valueA[D_MODEL],
    const int4_t valueB[D_MODEL * D_TILE_WO],
    int32_t out[D_TILE_WO]
) {
#pragma HLS INLINE off
    for (int t = 0; t < D_TILE_WO; ++t) {
#pragma HLS UNROLL
        int32_t acc = 0;
        for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
            const int4_t w = valueB[t * D_MODEL + i];
            acc += static_cast<int32_t>(valueA[i]) * static_cast<int32_t>(w);
        }
        out[t] = acc;
    }
}

// ---------------------------------------------------------------------------
// Top-level compute controller
// ---------------------------------------------------------------------------
void compute_controller(
    bool        reset,               // [INPUT] Reset signal

    // FSM communication signals
    bool        compute_start,       // [INPUT] Start signal for compute
    uint32_t    compute_instruction,          // [INPUT] Compute operation [7:0]=op [15:8]=layer [23:16]=head [31:24]=tile
    bool        &compute_ready,      // [OUTPUT] Compute engine ready for new operation
    bool        &compute_done,       // [OUTPUT] Compute operation finished

    // Memory manager handshake
    bool        mem_transfer_done,
    bool        &mem_read_request,        // [OUTPUT] Request memory manager
    bool        &mem_write_request,        // [OUTPUT] Request memory manager
    uint8_t     &mem_op,             // [OUTPUT] Opcode for memory manager

    // Data location INPUT signals from Memory Controller
    int8_t      OUT_PROJ_valueA[D_MODEL],                // [INPUT] Input activations for OUT_PROJ
    int4_t      OUT_PROJ_valueB[D_MODEL * D_TILE_WO],     // [INPUT] Weights for OUT_PROJ
    int32_t     OUT_PROJ_accum[D_TILE_WO],               // [OUTPUT] Output accumulators for OUT_PROJ


    bool        &error               // [OUTPUT] Error flag on invalid request
) {
#pragma HLS INLINE off
    static ComputeState state = ComputeState::IDLE;
    static PendingRequest req;

    // Outputs based on current state (before any transition).
    compute_ready = (state == ComputeState::IDLE);
    compute_done  = (state == ComputeState::DONE);
    mem_read_request   = false;
    mem_write_request  = false;
    mem_op        = 0;

    if (reset) {
        state = ComputeState::IDLE;
        error = false;
        compute_ready = true;
        compute_done  = false;
        mem_read_request   = false;
        mem_op        = 0;
        return;
    }

    ComputeState next_state = state;

    switch (state) {
        case ComputeState::IDLE:
            if (compute_start) {
                req.instruction    = compute_instruction;
                req.op            = static_cast<ComputeOp>(compute_instruction & 0xFFu);
                req.layer_idx     = (compute_instruction >> 8) & 0xFFu;
                req.head_idx      = (compute_instruction >> 16) & 0xFFu;
                req.tile_idx      = (compute_instruction >> 24) & 0xFFu;
                if (req.op == ComputeOp::CMP_OUT_PROJ) {
                    error = false; // Clear stale errors on a new request.
                    next_state = ComputeState::WAIT_MEM;
                } else {
                    error = true;
                    next_state = ComputeState::DONE;
                }
            }
            break;

        case ComputeState::WAIT_MEM:
            mem_read_request = true;
            mem_op = static_cast<uint8_t>(req.op);
            if (mem_transfer_done) {
                mem_read_request = false;
                mem_op = 0;
                next_state = ComputeState::EXECUTE;
            }
            break;

        case ComputeState::EXECUTE:
            if (req.op == ComputeOp::CMP_OUT_PROJ) {
                OUT_PROJ(OUT_PROJ_valueA, OUT_PROJ_valueB, OUT_PROJ_accum);
            } else {
                error = true;
            }
            next_state = ComputeState::MEM_WRITEBACK;
            break;
        case ComputeState::MEM_WRITEBACK:
            mem_write_request = true;
            mem_op = static_cast<uint8_t>(req.op);
            if (mem_transfer_done) {
                mem_write_request = false;
                mem_op = 0;
                next_state = ComputeState::DONE;
            }
            break;

        case ComputeState::DONE:
            // One-cycle done pulse; fall back to idle.
            next_state = ComputeState::IDLE;
            break;
    }

    state = next_state;
}
