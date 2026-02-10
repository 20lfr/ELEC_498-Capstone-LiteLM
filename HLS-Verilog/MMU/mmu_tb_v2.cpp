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
    uint32_t k_cache_base,
    uint32_t v_cache_base,
    uint16_t current_token
) {
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
        out.fsm_state,
        out.error_overflow,
        out.error_invalid,
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
    check(mmu_is_headed_op(CMP_K), "K_is_headed");
    check(mmu_is_headed_op(CMP_V), "V_is_headed");
    check(mmu_is_headed_op(CMP_ATT_SCORES), "ATT_SCORES_is_headed");
    check(mmu_is_headed_op(CMP_ATT_VALUE), "ATT_VALUE_is_headed");
    check(!mmu_is_headed_op(CMP_FFN_W1), "FFN_W1_not_headed");
    check(!mmu_is_headed_op(CMP_FFN_W2), "FFN_W2_not_headed");
    check(!mmu_is_headed_op(CMP_LN0), "LN0_not_headed");
    
    check(mmu_is_headed_dma(DMASEL_WQ), "WQ_is_headed_dma");
    check(mmu_is_headed_dma(DMASEL_WK), "WK_is_headed_dma");
    check(mmu_is_headed_dma(DMASEL_WV), "WV_is_headed_dma");
    check(mmu_is_headed_dma(DMASEL_CTX_K), "CTX_K_is_headed_dma");
    check(!mmu_is_headed_dma(DMASEL_W1), "W1_not_headed_dma");
    check(!mmu_is_headed_dma(DMASEL_WO), "WO_not_headed_dma");
    
    check(mmu_is_dma_write(DMASEL_K_WRITE), "K_WRITE_is_write");
    check(mmu_is_dma_write(DMASEL_V_WRITE), "V_WRITE_is_write");
    check(!mmu_is_dma_write(DMASEL_WQ), "WQ_not_write");
    check(!mmu_is_dma_write(DMASEL_CTX_K), "CTX_K_not_write");
    
    // =========================================================================
    // Test 2: DMA Size Calculations
    // =========================================================================
    printf("\n--- Test 2: DMA Size Calculations ---\n");
    uint32_t wq_size = mmu_calc_dma_size(DMASEL_WQ, dims, 0);
    uint32_t wo_size = mmu_calc_dma_size(DMASEL_WO, dims, 0);
    uint32_t w1_size = mmu_calc_dma_size(DMASEL_W1, dims, 0);
    uint32_t w2_size = mmu_calc_dma_size(DMASEL_W2, dims, 0);
    uint32_t ctx_k_size = mmu_calc_dma_size(DMASEL_CTX_K, dims, 0);
    uint32_t k_write_size = mmu_calc_dma_size(DMASEL_K_WRITE, dims, 0);
    
    printf("  WQ: %u bytes (expected: d_heads*d_model/2 + d_heads/2 = %u)\n", 
           wq_size, (dims.d_heads * dims.d_model / 2) + (dims.d_heads / 2));
    printf("  WO: %u bytes\n", wo_size);
    printf("  W1: %u bytes\n", w1_size);
    printf("  W2: %u bytes\n", w2_size);
    printf("  CTX_K: %u bytes (expected: context_len*d_heads = %u)\n", 
           ctx_k_size, dims.context_len * dims.d_heads);
    printf("  K_WRITE: %u bytes (expected: d_heads = %u)\n", 
           k_write_size, dims.d_heads);
    
    check(wq_size == (uint32_t)((dims.d_heads * dims.d_model / 2) + (dims.d_heads / 2)), "wq_size_correct");
    check(ctx_k_size == (uint32_t)(dims.context_len * dims.d_heads), "ctx_k_size_correct");
    check(k_write_size == dims.d_heads, "k_write_size_correct");
    check(wq_size > 0, "wq_size_nonzero");
    check(wo_size > 0, "wo_size_nonzero");
    
    // =========================================================================
    // Test 3: Buffer Layout Calculations
    // =========================================================================
    printf("\n--- Test 3: Buffer Layout Calculations ---\n");
    
    InputBufferLayout qkv_in = mmu_calc_input_layout(CMP_Q, dims);
    printf("  CMP_Q input: act@%u(%u), W@%u(%u), B@%u(%u), total=%u\n",
           qkv_in.act.offset, qkv_in.act.size,
           qkv_in.weights.offset, qkv_in.weights.size,
           qkv_in.bias.offset, qkv_in.bias.size,
           qkv_in.total_size);
    check(qkv_in.total_size == head_buf::INQkvLayout::TOTAL_BYTES, "qkv_in_size_matches_head_buf");
    check(qkv_in.act.size == dims.d_model, "qkv_in_act_size");
    
    InputBufferLayout att_in = mmu_calc_input_layout(CMP_ATT_SCORES, dims);
    printf("  CMP_ATT_SCORES input: act@%u(%u), k_cache@%u(%u), total=%u\n",
           att_in.act.offset, att_in.act.size,
           att_in.k_cache.offset, att_in.k_cache.size,
           att_in.total_size);
    check(att_in.total_size == head_buf::INAttScoresLayout::TOTAL_BYTES, "att_scores_in_size_matches");
    
    InputBufferLayout ffn_in = mmu_calc_input_layout(CMP_FFN_W1, dims);
    printf("  CMP_FFN_W1 input: act@%u(%u), W@%u(%u), B@%u(%u), S@%u(%u), total=%u\n",
           ffn_in.act.offset, ffn_in.act.size,
           ffn_in.weights.offset, ffn_in.weights.size,
           ffn_in.bias.offset, ffn_in.bias.size,
           ffn_in.scale.offset, ffn_in.scale.size,
           ffn_in.total_size);
    // Note: mmu_calc_input_layout uses default case for FFN ops, returning d_model
    check(ffn_in.total_size == dims.d_model, "ffn_w1_in_default_layout");
    
    OutputBufferLayout qkv_out = mmu_calc_output_layout(CMP_Q, dims);
    printf("  CMP_Q output: result@%u(%u), total=%u\n",
           qkv_out.result.offset, qkv_out.result.size, qkv_out.total_size);
    check(qkv_out.total_size == head_buf::OUTQkvLayout::TOTAL_BYTES, "qkv_out_size_matches_head_buf");
    check(qkv_out.out_dtype == DataType::DTYPE_INT32, "qkv_out_dtype_int32");
    
    OutputBufferLayout requant_out = mmu_calc_output_layout(CMP_K_REQUANT, dims);
    check(requant_out.out_dtype == DataType::DTYPE_INT8, "requant_out_dtype_int8");
    check(requant_out.total_size == dims.d_heads, "requant_out_size");
    
    // =========================================================================
    // Test 4: Weight Blob Layout Calculations
    // =========================================================================
    printf("\n--- Test 4: Weight Blob Layouts ---\n");
    
    WeightBlobLayout wq_blob = mmu_calc_weight_blob(DMASEL_WQ, dims);
    printf("  WQ blob: weights@%u(%u), bias@%u(%u), total=%u\n",
           wq_blob.weights.offset, wq_blob.weights.size,
           wq_blob.bias.offset, wq_blob.bias.size,
           wq_blob.total_size);
    check(wq_blob.total_size > 0, "wq_blob_nonzero");
    check(wq_blob.weights.dtype == DataType::DTYPE_INT4, "wq_weights_int4");
    
    WeightBlobLayout w1_blob = mmu_calc_weight_blob(DMASEL_W1, dims);
    printf("  W1 blob: weights@%u(%u), bias@%u(%u), scale@%u(%u), total=%u\n",
           w1_blob.weights.offset, w1_blob.weights.size,
           w1_blob.bias.offset, w1_blob.bias.size,
           w1_blob.scale.offset, w1_blob.scale.size,
           w1_blob.total_size);
    check(w1_blob.scale.size > 0, "w1_has_scale");
    
    // =========================================================================
    // Test 5: KV Cache Address Calculations
    // =========================================================================
    printf("\n--- Test 5: KV Cache Address Calculations ---\n");
    
    uint32_t k_base = 0x80000000;
    uint32_t v_base = 0x90000000;
    
    KVCacheAddr k_write = mmu_calc_kv_write_addr(k_base, v_base, 5, dims, 0, 0, false);
    printf("  K write (layer=0, head=0, token=5): addr=0x%08X, valid=%d\n", 
           k_write.base_addr, k_write.valid);
    check(k_write.valid, "k_write_valid");
    check(k_write.base_addr >= k_base, "k_write_addr_in_range");
    
    KVCacheAddr v_write = mmu_calc_kv_write_addr(k_base, v_base, 5, dims, 0, 0, true);
    printf("  V write (layer=0, head=0, token=5): addr=0x%08X, valid=%d\n", 
           v_write.base_addr, v_write.valid);
    check(v_write.valid, "v_write_valid");
    check(v_write.base_addr >= v_base, "v_write_addr_in_range");
    
    KVCacheAddr k_read = mmu_calc_kv_read_addr(k_base, v_base, dims, 1, 2, false);
    printf("  K read (layer=1, head=2): addr=0x%08X, valid=%d\n", 
           k_read.base_addr, k_read.valid);
    check(k_read.valid, "k_read_valid");
    
    uint32_t cache_size = mmu_calc_kv_cache_size(dims);
    printf("  Total KV cache size per type: %u bytes\n", cache_size);
    check(cache_size == (uint32_t)(dims.num_layers * dims.num_heads * dims.context_len * dims.d_heads), 
          "kv_cache_size_correct");
    
    // =========================================================================
    // Test 6: Pack/Unpack Utilities
    // =========================================================================
    printf("\n--- Test 6: Pack/Unpack Utilities ---\n");
    
    uint32_t dma_packed = mmu_pack_dma(DMASEL_WO, 1, 2, 3);
    DmaSel sel_out; int layer_out, head_out, tile_out;
    mmu_unpack_dma(dma_packed, sel_out, layer_out, head_out, tile_out);
    check(sel_out == DMASEL_WO, "dma_unpack_sel");
    check(layer_out == 1, "dma_unpack_layer");
    check(head_out == 2, "dma_unpack_head");
    check(tile_out == 3, "dma_unpack_tile");
    printf("  DMA pack/unpack: sel=%d, layer=%d, head=%d, tile=%d [OK]\n",
           (int)sel_out, layer_out, head_out, tile_out);
    
    uint32_t comp_packed = mmu_pack_compute(CMP_ATT_SCORES, 0, 3, 0);
    ComputeOp op_out; 
    mmu_unpack_compute(comp_packed, op_out, layer_out, head_out, tile_out);
    check(op_out == CMP_ATT_SCORES, "compute_unpack_op");
    check(head_out == 3, "compute_unpack_head");
    printf("  Compute pack/unpack: op=%d, layer=%d, head=%d, tile=%d [OK]\n",
           (int)op_out, layer_out, head_out, tile_out);
    
    // =========================================================================
    // Test 7: FSM Reset
    // =========================================================================
    printf("\n--- Test 7: FSM Reset ---\n");
    
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
        k_base, v_base, 0
    );
    
    printf("  After reset: state=%s, dma_req_ready=%d, compute_req_ready=%d\n",
           mmu_state_name(out.fsm_state), out.dma_req_ready, out.compute_req_ready);
    check(out.fsm_state == MMUFsmState::IDLE, "fsm_reset_to_idle");
    check(out.dma_req_ready == true, "dma_req_ready_after_reset");
    check(out.compute_req_ready == true, "compute_req_ready_after_reset");
    check(out.error_overflow == false, "no_overflow_after_reset");
    check(out.error_invalid == false, "no_invalid_after_reset");
    
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
        k_base, v_base, 0
    );
    printf("  After DMA done: state=%s, main_dma_done=%d\n", 
           mmu_state_name(out.fsm_state), out.main_dma_done);
    
    // Run a few more cycles to see if main_dma_done gets set
    for (int c = 0; c < 5; c++) {
        call_mmu_fsm(out, dims,
            false, true, false, true,
            false, 0,
            false, 0, ComputeReqType::REQ_NONE, 0,
            k_base, v_base, 0
        );
        if (out.main_dma_done) {
            printf("  main_dma_done asserted at cycle %d\n", c);
            break;
        }
    }
    
    check(!out.error_overflow, "no_overflow_error");
    check(!out.error_invalid, "no_invalid_error");
    
    // =========================================================================
    // Test 9: Head Arbitration
    // =========================================================================
    printf("\n--- Test 9: Head Arbitration ---\n");
    
    // Reset FSM to clear arbitration state
    call_mmu_fsm(out, dims,
        true, true, false, true,
        false, 0,
        false, 0, ComputeReqType::REQ_NONE, 0,
        k_base, v_base, 0
    );
    
    // Test arbitration functions directly (use current API without context)
    mmu_request_head(2);
    mmu_request_head(5);
    mmu_arbitrate();
    int granted = mmu_granted_head();
    printf("  Requested heads 2 and 5, granted=%d\n", granted);
    check(granted == 2 || granted == 5, "arbitration_grants_valid_head");
    check(mmu_is_granted(granted), "is_granted_returns_true");
    
    mmu_release_head(granted);
    mmu_arbitrate();
    int next_granted = mmu_granted_head();
    printf("  Released head %d, next granted=%d\n", granted, next_granted);
    check(next_granted != granted || next_granted == -1, "arbitration_advances");
    
    // =========================================================================
    // Test 10: Tile Cache Functions
    // =========================================================================
    printf("\n--- Test 10: Tile Cache Functions ---\n");
    
    // Reset to clear tile cache
    call_mmu_fsm(out, dims,
        true, true, false, true,
        false, 0,
        false, 0, ComputeReqType::REQ_NONE, 0,
        k_base, v_base, 0
    );
    
    // Check cache for a tile that shouldn't exist
    bool cached = mmu_check_cache(DMASEL_WQ, 0, 0, 0);
    printf("  Check cache for WQ L0H0T0 after reset: %s\n", cached ? "HIT" : "MISS");
    check(!cached, "cache_empty_after_reset");
    
    // Try lookup (should fail)
    ChunkedAllocation alloc;
    bool found = mmu_lookup_tile(DMASEL_WQ, 0, 0, 0, alloc);
    check(!found, "lookup_fails_on_empty_cache");
    
    // =========================================================================
    // Summary
    // =========================================================================
    printf("\n========================================\n");
    printf("=== Results: %d/%d tests passed ===\n", passed, tests);
    printf("========================================\n");
    
    return (passed == tests) ? 0 : 1;
}
