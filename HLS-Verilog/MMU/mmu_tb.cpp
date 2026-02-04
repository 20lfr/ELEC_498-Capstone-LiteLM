#include <cstdio>
#include "mmu_v2.hpp"

static int tests = 0, passed = 0;

static void check(bool cond, const char* name) {
    tests++;
    if (cond) { passed++; printf("[PASS] %s\n", name); }
    else { printf("[FAIL] %s\n", name); }
}

int main() {
    printf("=== MMU V2 Tests (using top_params.hpp) ===\n\n");
    
    ModelDims dims;
    MMUContext ctx;
    mmu_init(ctx, dims);
    
    printf("ModelDims from top_params.hpp:\n");
    printf("  D_MODEL=%d, D_FFN=%d, D_HEADS=%d, NUM_HEADS=%d\n",
           dims.d_model, dims.d_ffn, dims.d_heads, dims.num_heads);
    printf("  CONTEXT_LEN=%d, NUM_LAYERS=%d\n\n", dims.context_len, dims.num_layers);
    
    // Test 1: Initialization
    check(ctx.fsm_state == MMUFsmState::IDLE, "init_idle");
    check(ctx.dma_count == 0, "init_dma_queue_empty");
    check(ctx.compute_count == 0, "init_compute_queue_empty");
    
    // Test 2: DMA queue
    uint32_t req = mmu_pack_dma(DMASEL_WQ, 0, 0, 0);
    check(mmu_push_dma_request(ctx, req), "push_dma");
    check(ctx.dma_count == 1, "dma_count_1");
    
    // Test 3: Compute queue
    uint32_t cop = mmu_pack_compute(CMP_Q, 0, 0, 0);
    check(mmu_request_input_buffer(ctx, cop, 0), "push_compute");
    check(ctx.compute_count == 1, "compute_count_1");
    
    // Test 4: Head arbitration
    mmu_request_head(ctx, 2);
    mmu_request_head(ctx, 5);
    mmu_arbitrate(ctx);
    check(mmu_granted_head(ctx) == 2, "arbitrate_head_2");
    mmu_release_head(ctx, 2);
    mmu_arbitrate(ctx);
    check(mmu_granted_head(ctx) == 5, "arbitrate_head_5");
    
    // Test 5: Utility functions
    check(mmu_is_headed_op(CMP_Q), "Q_is_headed");
    check(mmu_is_headed_op(CMP_ATT_SCORES), "ATT_SCORES_is_headed");
    check(!mmu_is_headed_op(CMP_FFN_W1), "FFN_W1_not_headed");
    check(mmu_is_headed_dma(DMASEL_WQ), "WQ_is_headed");
    check(!mmu_is_headed_dma(DMASEL_W1), "W1_not_headed");
    check(mmu_is_dma_write(DMASEL_K_WRITE), "K_WRITE_is_write");
    check(!mmu_is_dma_write(DMASEL_WQ), "WQ_not_write");
    
    // Test 6: Buffer layouts using head_buf/compute_buf from top_params.hpp
    printf("\nInput buffer layouts:\n");
    InputBufferLayout qkv_in = mmu_calc_input_layout(CMP_Q, dims);
    printf("  CMP_Q: act@%u(%u), W@%u(%u), B@%u(%u), total=%u\n",
           qkv_in.act.offset, qkv_in.act.size,
           qkv_in.weights.offset, qkv_in.weights.size,
           qkv_in.bias.offset, qkv_in.bias.size,
           qkv_in.total_size);
    check(qkv_in.total_size == head_buf::QKV_IN_BYTES, "qkv_in_size");
    
    InputBufferLayout ffn_in = mmu_calc_input_layout(CMP_FFN_W1, dims);
    printf("  CMP_FFN_W1: act@%u(%u), W@%u(%u), B@%u(%u), S@%u(%u), total=%u\n",
           ffn_in.act.offset, ffn_in.act.size,
           ffn_in.weights.offset, ffn_in.weights.size,
           ffn_in.bias.offset, ffn_in.bias.size,
           ffn_in.scale.offset, ffn_in.scale.size,
           ffn_in.total_size);
    check(ffn_in.total_size == compute_buf::FFN_W1_IN_BYTES, "ffn_w1_in_size");
    
    printf("\nOutput buffer layouts:\n");
    OutputBufferLayout qkv_out = mmu_calc_output_layout(CMP_Q, dims);
    printf("  CMP_Q: result@%u(%u), total=%u\n",
           qkv_out.result.offset, qkv_out.result.size, qkv_out.total_size);
    check(qkv_out.total_size == head_buf::QKV_OUT_BYTES, "qkv_out_size");
    
    // Test 7: DMA sizes
    printf("\nDMA sizes:\n");
    printf("  WQ: %u bytes\n", mmu_calc_dma_size(DMASEL_WQ, dims, 0));
    printf("  WO: %u bytes\n", mmu_calc_dma_size(DMASEL_WO, dims, 0));
    printf("  W1: %u bytes\n", mmu_calc_dma_size(DMASEL_W1, dims, 0));
    printf("  CTX_K: %u bytes\n", mmu_calc_dma_size(DMASEL_CTX_K, dims, 0));
    
    // Test 8: FSM basic cycle
    printf("\nFSM cycle test:\n");
    mmu_reset(ctx);
    mmu_set_kv_cache_bases(ctx, 0x80000000, 0x90000000);
    mmu_push_dma_request(ctx, mmu_pack_dma(DMASEL_WO, 0, 0, 0));
    
    bool dma_start, dma_is_write, buffer_valid, transfer_done;
    uint32_t dma_addr, dma_len;
    uint8_t uram_bank;
    uint32_t uram_offset;
    
    for (int c = 0; c < 8; c++) {
        bool dma_done_pulse = (c == 4);
        mmu_fsm(ctx, true, dma_done_pulse, dma_start, dma_addr, dma_len, dma_is_write,
                uram_bank, uram_offset, true, buffer_valid, transfer_done);
        printf("  cycle %d: state=%s, dma_start=%d\n", c, mmu_state_name(ctx.fsm_state), dma_start);
        if (ctx.main_dma_done) {
            printf("  -> main_dma_done!\n");
            break;
        }
    }
    check(ctx.main_dma_done, "fsm_dma_done");
    
    printf("\n=== Results: %d/%d passed ===\n", passed, tests);
    return (passed == tests) ? 0 : 1;
}
