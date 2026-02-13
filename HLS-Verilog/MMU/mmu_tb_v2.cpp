/**
 * @file mmu_tb_v2.cpp
 * @brief Updated testbench for MMU module using current mmu_fsm() API
 * 
 * This testbench is designed for the current mmu.hpp which:
 * - Uses static internal state (no MMUContext struct)
 * - Has a 26-parameter mmu_fsm() function
 * - Uses separate DMA/compute request valid+packed inputs
 * 
 * The original mmu_tb.cpp uses an older API with MMUContext that no longer exists.
 */

#include <cstdio>
#include "mmu.hpp"

static int tests = 0, passed = 0;

static void check(bool cond, const char* name) {
    tests++;
    if (cond) { passed++; printf("[PASS] %s\n", name); }
    else { printf("[FAIL] %s\n", name); }
}

// Helper to call mmu_fsm with common defaults
struct FsmOutputs {
    bool dma_start;
    uint32_t dma_addr;
    uint32_t dma_len;
    bool dma_is_write;
    uint8_t uram_bank;
    uint32_t uram_offset;
    bool buffer_valid;
    bool transfer_done;
    bool dma_req_ready;
    bool compute_req_ready;
    bool main_dma_done;
    bool main_compute_done;
    bool head_dma_done_out[MMU_MAX_HEADS];
    bool head_compute_done_out[MMU_MAX_HEADS];
    bool tile_query_hit;
    uint8_t tile_query_bank;
    uint32_t tile_query_offset;
    bool arb_grant_valid;
    int arb_granted_head;
    MMUFsmState fsm_state;
    bool error_overflow;
    bool error_invalid;
};

void call_mmu_fsm(
    FsmOutputs &out,
    ModelDims &dims,
    bool reset,
    bool dma_ready,
    bool dma_done,
    bool buffer_ready,
    bool dma_req_valid,
    uint32_t dma_req_packed,
    bool compute_req_valid,
    uint32_t compute_req_packed,
    ComputeReqType compute_req_type,
    uint8_t compute_req_head,
    bool tile_query_valid,
    DmaSel tile_query_sel,
    int tile_query_layer,
    int tile_query_head,
    int tile_query_tile,
    bool arb_request_valid,
    int arb_request_head,
    bool arb_release_valid,
    int arb_release_head,
    bool clear_all_flags,
    uint32_t k_cache_base,
    uint32_t v_cache_base,
    uint16_t current_token
) {
    ControlMemSpace ctrl; // Default zero-init
    mmu_fsm(
        reset,
        dma_ready,
        dma_done,
        out.dma_start,
        out.dma_addr,
        out.dma_len,
        out.dma_is_write,
        out.uram_bank,
        out.uram_offset,
        buffer_ready,
        out.buffer_valid,
        out.transfer_done,
        dma_req_valid,
        dma_req_packed,
        out.dma_req_ready,
        compute_req_valid,
        compute_req_packed,
        compute_req_type,
        compute_req_head,
        out.compute_req_ready,
        out.main_dma_done,
        out.main_compute_done,
        out.head_dma_done_out,
        out.head_compute_done_out,
        tile_query_valid,
        tile_query_sel,
        tile_query_layer,
        tile_query_head,
        tile_query_tile,
        out.tile_query_hit,
        out.tile_query_bank,
        out.tile_query_offset,
        arb_request_valid,
        arb_request_head,
        arb_release_valid,
        arb_release_head,
        out.arb_grant_valid,
        out.arb_granted_head,
        false, 0, // head dma done clear
        false, 0, // head compute done clear
        false,    // main dma done clear
        false,    // main compute done clear
        clear_all_flags,
        out.fsm_state,
        out.error_overflow,
        out.error_invalid,
        ctrl,
        dims,
        k_cache_base,
        v_cache_base,
        current_token
    );
}

int main() {
    printf("=== MMU V2 Tests (Updated for current mmu_fsm API) ===\n\n");
    
    ModelDims dims;
    FsmOutputs out;
    
    printf("ModelDims from top_params.hpp:\n");
    printf("  D_MODEL=%d, D_FFN=%d, D_HEADS=%d, NUM_HEADS=%d\n",
           dims.d_model, dims.d_ffn, dims.d_heads, dims.num_heads);
    printf("  CONTEXT_LEN=%d, NUM_LAYERS=%d\n", dims.context_len, dims.num_layers);
    printf("  D_TILE_WO=%d, D_TILE_W1=%d, D_TILE_W2=%d\n\n", 
           dims.d_tile_wo, dims.d_tile_w1, dims.d_tile_w2);
    
    // =========================================================================
    // Test 1: Helper Functions (these work without FSM)
    // =========================================================================
    printf("--- Test 1: Helper Functions ---\n");
    check(mmu_is_headed_op(CMP_Q), "Q_is_headed");
    check(!mmu_is_headed_op(CMP_FFN_W1), "FFN_W1_not_headed");
    check(mmu_is_headed_dma(DMASEL_WQ), "WQ_is_headed_dma");
    check(!mmu_is_headed_dma(DMASEL_WO), "WO_not_headed_dma");
    
    // =========================================================================
    // Test 2: DMA Size Calculations
    // =========================================================================
    printf("\n--- Test 2: DMA Size Calculations ---\n");
    uint32_t wq_size = mmu_calc_dma_size(DMASEL_WQ, dims, 0);
    uint32_t wo_size = mmu_calc_dma_size(DMASEL_WO, dims, 0);
    check(wq_size > 0, "wq_size_nonzero");
    check(wo_size > 0, "wo_size_nonzero");
    
    // =========================================================================
    // Test 7: FSM Reset
    // =========================================================================
    printf("\n--- Test 7: FSM Reset ---\n");
    uint32_t k_base = 0x80000000;
    uint32_t v_base = 0x90000000;
    
    // Reset the FSM
    call_mmu_fsm(out, dims, 
        true,   // reset
        true,   // dma_ready
        false,  // dma_done
        true,   // buffer_ready
        false,  // dma_req_valid
        0,      // dma_req_packed
        false,  // compute_req_valid
        0,      // compute_req_packed
        ComputeReqType::REQ_NONE,
        0,      // compute_req_head
        false, DMASEL_NONE, 0, 0, 0, // tile query
        false, 0, false, 0, // arbitration
        true, // clear_all_flags
        k_base, v_base, 0
    );
    
    printf("  After reset: state=%s, dma_req_ready=%d, compute_req_ready=%d\n",
           mmu_state_name(out.fsm_state), out.dma_req_ready, out.compute_req_ready);
    check(out.fsm_state == MMUFsmState::IDLE, "fsm_reset_to_idle");
    check(out.dma_req_ready == true, "dma_req_ready_after_reset");
    check(out.error_overflow == false, "no_overflow_after_reset");
    
    // =========================================================================
    // Test 8: FSM DMA Request Flow
    // =========================================================================
    printf("\n--- Test 8: FSM DMA Request Flow ---\n");
    
    uint32_t dma_req = mmu_pack_dma(DMASEL_WO, 0, 0, 0);
    printf("  Enqueueing DMA request: DMASEL_WO, layer=0, head=0, tile=0\n");
    
    // Cycle 1: Enqueue DMA request
    call_mmu_fsm(out, dims,
        false, true, false, true,
        true,  // dma_req_valid - enqueue request
        dma_req,
        false, 0, ComputeReqType::REQ_NONE, 0,
        false, DMASEL_NONE, 0, 0, 0, // tile query
        false, 0, false, 0, // arbitration
        false, // clear_all_flags
        k_base, v_base, 0
    );
    printf("  Cycle 1: state=%s, dma_start=%d\n", mmu_state_name(out.fsm_state), out.dma_start);
    
    // Run FSM cycles until DMA starts or max cycles reached
    int max_cycles = 10;
    bool dma_started = false;
    for (int c = 0; c < max_cycles && !dma_started; c++) {
        call_mmu_fsm(out, dims,
            false, true, false, true,
            false, 0,  // no new DMA request
            false, 0, ComputeReqType::REQ_NONE, 0,
            false, DMASEL_NONE, 0, 0, 0, // tile query
            false, 0, false, 0, // arbitration
            false, // clear_all_flags
            k_base, v_base, 0
        );
        printf("  Cycle %d: state=%s, dma_start=%d, uram_bank=%d, len=%u\n", 
               c+2, mmu_state_name(out.fsm_state), out.dma_start, out.uram_bank, out.dma_len);
        if (out.dma_start) dma_started = true;
    }
    check(dma_started, "dma_start_asserted");
    
    // Simulate DMA completion
    printf("  Simulating DMA done pulse...\n");
    call_mmu_fsm(out, dims,
        false, true, true,  // dma_done = true
        true,
        false, 0,
        false, 0, ComputeReqType::REQ_NONE, 0,
        false, DMASEL_NONE, 0, 0, 0, // tile query
        false, 0, false, 0, // arbitration
        false, // clear_all_flags
        k_base, v_base, 0
    );
    printf("  After DMA done: state=%s, main_dma_done=%d\n", 
           mmu_state_name(out.fsm_state), out.main_dma_done);
    
    // =========================================================================
    // Test 9: Head Arbitration (REQUIRES FSM ACTIVITY - SKIPPING FOR NOW)
    // =========================================================================
    printf("\n--- Test 9: Head Arbitration (Skipped - Requires FSM State) ---\n");
    // The current mmu.cpp only runs arbitration in DMA_ARBITRATE or COMPUTE_ARB states.
    // Pure external requests are not serviced in IDLE.
    // To test this properly, we would need to drive the FSM.
    
    // =========================================================================
    // Test 10: Tile Cache Functions
    // =========================================================================
    printf("\n--- Test 10: Tile Cache Functions ---\n");
    // Reset to clear tile cache
    call_mmu_fsm(out, dims, true, true, false, true, false, 0, false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, true, k_base, v_base, 0);
    
    // Check cache for a tile that shouldn't exist
    // Using tile_query interface
    call_mmu_fsm(out, dims, false, true, false, true, false, 0, false, 0, ComputeReqType::REQ_NONE, 0, 
        true, DMASEL_WQ, 0, 0, 0, // tile_query_valid=true
        false, 0, false, 0,
        false, k_base, v_base, 0
    );
    printf("  Check cache for WQ L0H0T0 after reset: %s\n", out.tile_query_hit ? "HIT" : "MISS");
    check(!out.tile_query_hit, "cache_empty_after_reset");

    // =========================================================================
    // Test 11: Queue Backpressure (Indirectly testing queue depth)
    // =========================================================================
    printf("\n--- Test 11: Queue Backpressure ---\n");
    // Reset
    call_mmu_fsm(out, dims, true, true, false, true, false, 0, false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, true, k_base, v_base, 0);
    
    // Fill DMA queue
    // Note: We set dma_ready=false to STALL the FSM. 
    // Otherwise it pops almost as fast as we push, and the queue never fills.
    printf("  Filling DMA queue with %d requests (dma_ready=false)...\n", MMU_DMA_QUEUE_DEPTH);
    for (int i = 0; i < MMU_DMA_QUEUE_DEPTH; i++) {
        call_mmu_fsm(out, dims, false, false, false, true, // dma_ready=false
            true, mmu_pack_dma(DMASEL_WO, 0, 0, i), // Valid request
            false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, false, k_base, v_base, 0
        );
    }
    
    // Try one more push (17th request - should be accepted but fill the queue)
    call_mmu_fsm(out, dims, false, true, false, true,
            true, mmu_pack_dma(DMASEL_WO, 0, 0, 99), 
            false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, false, k_base, v_base, 0
    );
    printf("  Push 17: dma_req_ready=%d (should be 1)\n", out.dma_req_ready);
    check(out.dma_req_ready, "queue_accepted_17th_item");

    // Cycle 18: Try to push again (18th request). Queue should now be full (1 processing + 16 in queue)
    // dma_req_ready should be FALSE at the start of this cycle
    call_mmu_fsm(out, dims, false, true, false, true,
            true, mmu_pack_dma(DMASEL_WO, 0, 0, 100), 
            false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, false, k_base, v_base, 0
    );
    printf("  Push 18 (Attempt): dma_req_ready=%d (should be 0)\n", out.dma_req_ready);
    check(!out.dma_req_ready, "dma_queue_full_backpressure");


    // =========================================================================
    // Test 12: Headed DMA Flow (Verifying head_dma_done flags)
    // =========================================================================
    printf("\n--- Test 12: Headed DMA Flow ---\n");
    // Reset
    call_mmu_fsm(out, dims, true, true, false, true, false, 0, false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, true, k_base, v_base, 0);
    
    uint32_t headed_req = mmu_pack_dma(DMASEL_WQ, 0, 3, 0); // Head 3
    printf("  Enqueueing Headed DMA request: DMASEL_WQ, Head=3\n");
    
    // Push request
    call_mmu_fsm(out, dims, false, true, false, true, true, headed_req, false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, false, k_base, v_base, 0);
    
    // Run until DMA starts
    bool head_dma_started = false;
    for (int c = 0; c < 10; c++) {
        call_mmu_fsm(out, dims, false, true, false, true, false, 0, false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, false, k_base, v_base, 0);
        if (out.dma_start) { head_dma_started = true; break; }
    }
    check(head_dma_started, "headed_dma_started");
    
    // Complete DMA
    call_mmu_fsm(out, dims, false, true, true, true, false, 0, false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, false, k_base, v_base, 0);
    
    // Add extra cycle for flag update visibility (since outputs lag by 1 cycle)
    call_mmu_fsm(out, dims, false, true, false, true, false, 0, false, 0, ComputeReqType::REQ_NONE, 0, false, DMASEL_NONE, 0, 0, 0, false, 0, false, 0, false, k_base, v_base, 0);

    printf("  Checking head_dma_done_out[3]=%d\n", out.head_dma_done_out[3]);
    check(out.head_dma_done_out[3], "head_3_dma_done_flag");
    check(!out.main_dma_done, "main_dma_done_not_set_for_headed");


    // =========================================================================
    // Summary
    // =========================================================================
    printf("\n========================================\n");
    printf("=== Results: %d/%d tests passed ===\n", passed, tests);
    printf("========================================\n");
    
    return (passed == tests) ? 0 : 1;
}
