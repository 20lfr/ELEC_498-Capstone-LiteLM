#include "compute_controller.hpp"

// Alias local to this TU for clarity.
using uint4_t = ap_uint<4>;

namespace {

constexpr int MAX_VALUEA = D_MODEL;
constexpr int MAX_VALUEB = D_MODEL * D_HEADS;

// Simple controller state machine.
enum class ComputeState : uint8_t { IDLE = 0, EXECUTE, DONE };

// Captured request from the scheduler.
struct PendingRequest {
    ComputeOp op    = ComputeOp::CMP_NONE;
    uint32_t addrA  = 0;
    uint32_t addrB  = 0;
    int32_t  sizeA  = 0;
    uint32_t sizeB  = 0;
    bool bramA      = false;
    bool bramB      = false;
    bool uramA      = false;
    bool uramB      = false;
};

} // namespace

// ---------------------------------------------------------------------------
// Compute kernels
// ---------------------------------------------------------------------------
void MAC_QKV(
    const uint8_t valueA[D_MODEL],
    const uint4_t valueB[D_MODEL * D_HEADS],
    volatile int32_t accum_out[D_HEADS]
) {
#pragma HLS INLINE off
    for (int h = 0; h < D_HEADS; ++h) {
#pragma HLS UNROLL
        int32_t acc = 0;
        for (int i = 0; i < D_MODEL; ++i) {
#pragma HLS UNROLL
            const uint4_t w = valueB[h * D_MODEL + i];
            acc += static_cast<int32_t>(valueA[i]) * static_cast<int32_t>(w);
        }
        accum_out[h] = acc;
    }
}


// ---------------------------------------------------------------------------
// Top-level compute controller
// ---------------------------------------------------------------------------
void compute_controller(
    bool        reset,               // [INPUT] Reset signal

    // FSM communication signals
    bool        compute_start,       // [INPUT] Start signal for compute
    ComputeOp   compute_op,          // [INPUT] Compute operation to perform
    bool        &compute_ready,      // [OUTPUT] Compute engine ready for new operation
    bool        &compute_done,       // [OUTPUT] Compute operation finished

    // Data location INPUT signals
    uint32_t    internal_addr_valueA,// [INPUT] The location in memory to read from for compute input A
    uint32_t    internal_addr_valueB,// [INPUT] The location in memory to read from for compute input B
    bool        BRAM_en_A,           // [INPUT] Read enable for BRAM A (value A is located in BRAM)
    bool        BRAM_en_B,           // [INPUT] Read enable for BRAM B (value B is located in BRAM)
    bool        URAM_en_A,           // [INPUT] Read enable for URAM A (value A is located in URAM)
    bool        URAM_en_B,           // [INPUT] Read enable for URAM B (value B is located in URAM)
    uint32_t    sizeA,               // [INPUT] Number of elements to fetch for operand A
    uint32_t    sizeB,               // [INPUT] Number of elements to fetch for operand B

    // QKV buffers
    uint8_t     QKV_vectorA[D_MODEL],            // [INPUT] Backing storage for operand A (BRAM/URAM simulated)
    uint4_t     QKV_matrixB[D_MODEL * D_HEADS], // [INPUT] Backing storage for operand B (BRAM/URAM simulated)




    // UNUSED FOR NOW, BUT RESERVED FOR FUTURE OPS:
    // QK^T buffers
    uint8_t     K_cache_vectorA[D_HEADS],            
    uint8_t     K_cache_matrixB[CONTEXT_LENGTH * D_HEADS],
    
    // Value Scaling and Clamping buffers
    uint8_t     scaling_vectorA[CONTEXT_LENGTH],
    uint16_t    clamping_valueA,
    
    // Head Concat buffers
    uint8_t     head_concat_buffer[NUM_HEADS * D_MODEL],

    // WO buffers
    uint8_t     WO_vectorA[D_MODEL],
    uint4_t     WO_matrixB[D_MODEL * D_TILE_WO],
    
    // W1 Buffers
    uint8_t     W1_vectorA[D_MODEL],
    uint4_t     W1_matrixB[D_MODEL * D_TILE_W1],

    // W2 Buffers
    uint8_t     W2_vectorA[D_FFN],
    uint4_t     W2_matrixB[D_FFN * D_TILE_W2],




    bool        &error               // [OUTPUT] Error flag on invalid request
) {
#pragma HLS INLINE off
    static ComputeState state = ComputeState::IDLE;
    static PendingRequest req;
    static volatile int32_t qkv_accum[D_HEADS]; // Output buffer for MAC_QKV

    // Outputs based on current state (before any transition).
    const bool busy = (state != ComputeState::IDLE);
    compute_ready = !busy;
    compute_done  = (state == ComputeState::DONE);

    if (reset) {
        state = ComputeState::IDLE;
        error = false;
        compute_ready = true;
        compute_done  = false;
        return;
    }

    ComputeState next_state = state;

    switch (state) {
        case ComputeState::IDLE:
            if (compute_start) {
                req.op    = compute_op;
                req.addrA = internal_addr_valueA;
                req.addrB = internal_addr_valueB;
                req.sizeA = sizeA;
                req.sizeB = sizeB;
                req.bramA = BRAM_en_A;
                req.bramB = BRAM_en_B;
                req.uramA = URAM_en_A;
                req.uramB = URAM_en_B;
                error     = false; // Clear stale errors on a new request.
                next_state = ComputeState::EXECUTE;
            }
            break;

        case ComputeState::EXECUTE:
            if (req.op == ComputeOp::CMP_Q || req.op == ComputeOp::CMP_K || req.op == ComputeOp::CMP_V) {
                // Testbench supplies operands directly; no copying required here.
                MAC_QKV(QKV_vectorA, QKV_matrixB, qkv_accum);
            } else {
                error = true;
            }
            next_state = ComputeState::DONE;
            break;

        case ComputeState::DONE:
            // One-cycle done pulse; fall back to idle.
            next_state = ComputeState::IDLE;
            break;
    }

    state = next_state;
}
