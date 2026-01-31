#include "mmu.hpp"
#include <cstdio>
#include <cassert>

void print_test(const char* name, bool passed) {
    printf("[%s] %s\n", passed ? "PASS" : "FAIL", name);
}

void test_instruction_decoding() {
    printf("\n=== Test 1: Instruction Decoding ===\n");
    
    uint32_t mem_packed = 0x02010001;
    MemoryRequest mem_req = mmu_decode_memory_request(mem_packed);
    
    assert(mem_req.request == 1);
    assert(mem_req.layer == 0);
    assert(mem_req.head == 1);
    assert(mem_req.tile == 2);
    assert(mem_req.get_dma_sel() == DmaSel::DMASEL_WQ);
    assert(mem_req.pack() == mem_packed);
    print_test("Memory request decode/encode", true);
    
    uint32_t compute_packed = 0x03020103;
    ComputeRequest comp_req = mmu_decode_compute_request(compute_packed);
    
    assert(comp_req.op == 3);
    assert(comp_req.layer == 1);
    assert(comp_req.head == 2);
    assert(comp_req.tile == 3);
    assert(comp_req.get_compute_op() == ComputeOp::CMP_Q);
    assert(comp_req.pack() == compute_packed);
    print_test("Compute request decode/encode", true);
}

void test_size_calculation() {
    printf("\n=== Test 2: Size Calculation (Production Config) ===\n");
    
    ModelDims dims; 
    
    uint16_t wq_size = mmu_calc_dma_size(DmaSel::DMASEL_WQ, dims, -1);
    assert(wq_size == 65568);
    print_test("DMASEL_WQ size calculation", true);
    
    uint16_t k_write_size = mmu_calc_dma_size(DmaSel::DMASEL_K_WRITE, dims, -1);
    assert(k_write_size == 64);
    print_test("DMASEL_K_WRITE size calculation", true);
    
    uint16_t ctx_k_size = mmu_calc_dma_size(DmaSel::DMASEL_CTX_K, dims, -1);
    assert(ctx_k_size == 131072);
    print_test("DMASEL_CTX_K size calculation", true);
    
    uint16_t wo_size = mmu_calc_dma_size(DmaSel::DMASEL_WO, dims, -1);
    assert(wo_size == 65792);
    print_test("DMASEL_WO size calculation", true);
    
    uint16_t w1_size = mmu_calc_dma_size(DmaSel::DMASEL_W1, dims, -1);
    assert(w1_size == 65792);
    print_test("DMASEL_W1 size calculation", true);
    
    uint16_t w2_size = mmu_calc_dma_size(DmaSel::DMASEL_W2, dims, -1);
    assert(w2_size == 176384);
    print_test("DMASEL_W2 size calculation", true);
    
    uint16_t cmp_q_in = mmu_calc_input_buffer_size(ComputeOp::CMP_Q, dims);
    assert(cmp_q_in == 68640);
    print_test("CMP_Q input buffer size", true);
    
    uint16_t cmp_att_in = mmu_calc_input_buffer_size(ComputeOp::CMP_ATT_SCORES, dims);
    assert(cmp_att_in == 131136);
    print_test("CMP_ATT_SCORES input buffer size", true);
    
    uint16_t cmp_ln_in = mmu_calc_input_buffer_size(ComputeOp::CMP_LN0, dims);
    assert(cmp_ln_in == 10308);
    print_test("CMP_LN0 input buffer size", true);
    
    uint16_t cmp_q_out = mmu_calc_output_buffer_size(ComputeOp::CMP_Q, dims);
    assert(cmp_q_out == 256);
    print_test("CMP_Q output buffer size", true);
    
    uint16_t cmp_att_out = mmu_calc_output_buffer_size(ComputeOp::CMP_ATT_SCORES, dims);
    assert(cmp_att_out == 8192);
    print_test("CMP_ATT_SCORES output buffer size", true);
    
    uint16_t cmp_ln_out = mmu_calc_output_buffer_size(ComputeOp::CMP_LN0, dims);
    assert(cmp_ln_out == 8192);
    print_test("CMP_LN0 output buffer size", true);
    
    printf("Size calculation tests: PASSED\n");
}

void test_buffer_layouts() {
    printf("\n=== Test 3: Buffer Layouts ===\n");
    
    ModelDims dims;
    
    // Test CMP_Q input layout
    BufferLayout q_in_layout = mmu_calc_input_layout(ComputeOp::CMP_Q, dims);
    assert(q_in_layout.num_regions == 3);
    assert(q_in_layout.regions[0].offset == 0);    // ACT @0
    assert(q_in_layout.regions[0].size == 8);      // D_MODEL
    assert(q_in_layout.regions[1].offset == 8);    // W @8
    assert(q_in_layout.regions[1].size == 8);      // D_HEADS×D_MODEL×0.5
    assert(q_in_layout.regions[2].offset == 16);   // B @16
    assert(q_in_layout.regions[2].size == 1);      // D_HEADS×0.5
    assert(q_in_layout.total_size == 17);
    print_test("CMP_Q input layout", true);
    
    // Test CMP_ATT_SCORES input layout
    BufferLayout att_in_layout = mmu_calc_input_layout(ComputeOp::CMP_ATT_SCORES, dims);
    assert(att_in_layout.num_regions == 2);
    assert(att_in_layout.regions[0].offset == 0);  // Q @0
    assert(att_in_layout.regions[0].size == 2);    // D_HEADS
    assert(att_in_layout.regions[1].offset == 2);  // K_CACHE @2
    assert(att_in_layout.regions[1].size == 32);   // CONTEXT×D_HEADS
    print_test("CMP_ATT_SCORES input layout", true);
    
    // Test CMP_FFN_W1 input layout
    BufferLayout w1_in_layout = mmu_calc_input_layout(ComputeOp::CMP_FFN_W1, dims);
    assert(w1_in_layout.num_regions == 4);  // X, W, B, S
    print_test("CMP_FFN_W1 input layout", true);
    
    printf("Buffer layout tests: PASSED\n");
}

void test_weight_blob_parsing() {
    printf("\n=== Test 4: Weight Blob Parsing ===\n");
    
    ModelDims dims;
    
    WeightBlob wq_blob = mmu_parse_weight_blob(DmaSel::DMASEL_WQ, dims);
    assert(wq_blob.weights.offset == 0);
    assert(wq_blob.weights.size == 8);     // D_HEADS×D_MODEL×0.5
    assert(wq_blob.biases.offset == 8);
    assert(wq_blob.biases.size == 1);      // D_HEADS×0.5
    assert(wq_blob.total_size == 9);
    print_test("WQ blob structure", true);
    
    WeightBlob w1_blob = mmu_parse_weight_blob(DmaSel::DMASEL_W1, dims);
    assert(w1_blob.weights.size == 8);     // D_TILE_W1×D_MODEL×0.5
    assert(w1_blob.biases.size == 8);      // D_TILE_W1×4
    assert(w1_blob.scales.size == 4);      // D_TILE_W1×2
    assert(w1_blob.total_size == 20);
    print_test("W1 blob structure (with scales)", true);
    
    printf("Weight blob parsing tests: PASSED\n");
}

void test_kv_cache_addressing() {
    printf("\n=== Test 5: K/V Cache Addressing ===\n");
    
    MMUState state;
    ModelDims dims;
    mmu_init(state, dims);
    
    // Set K/V cache base addresses
    state.k_cache_base = 0x10000000;
    state.v_cache_base = 0x20000000;
    state.current_token = 5;  // 5th token
    
    // Test K write address for layer 0, head 1
    KVCacheAddr k_write = mmu_calc_kv_write_addr(state, 0, 1, false);
    assert(k_write.valid);
    assert(k_write.head == 1);
    assert(k_write.token_offset == 5);
    // base + layer_offset(0) + token_offset(5×2) + head_offset(1×2) = 0x10000000 + 12
    uint32_t expected_k = 0x10000000 + 12;
    assert(k_write.base_addr == expected_k);
    print_test("K cache write addressing", true);
    
    // Test V write address for layer 1, head 2
    KVCacheAddr v_write = mmu_calc_kv_write_addr(state, 1, 2, true);
    assert(v_write.valid);
    // base + layer_offset(1×32) + token_offset(5×2) + head_offset(2×2) = 0x20000000 + 46
    uint32_t expected_v = 0x20000000 + 46;
    assert(v_write.base_addr == expected_v);
    print_test("V cache write addressing", true);
    
    // Test K read address (full cache for layer/head)
    KVCacheAddr k_read = mmu_calc_kv_read_addr(state, 0, 1, false);
    assert(k_read.valid);
    assert(k_read.token_offset == 0);  // Reading all tokens
    print_test("K cache read addressing", true);
    
    printf("K/V cache addressing tests: PASSED\n");
}

void test_tile_management() {
    printf("\n=== Test 6: Tile Management ===\n");
    
    MMUState state;
    ModelDims dims;
    mmu_init(state, dims);
    
    bool cached = mmu_check_cache(state, DmaSel::DMASEL_WQ, 0, 1, -1);
    assert(!cached);
    print_test("Cache miss detection", true);
    
    MMUAllocation alloc = mmu_allocate(state, DmaSel::DMASEL_WQ, 0, 1, -1);
    assert(alloc.success);
    assert(alloc.uram_bank == 0);  // First allocation goes to bank 0
    assert(alloc.uram_offset == 0);
    assert(alloc.size == 9);
    print_test("Tile allocation", true);
    
    mmu_commit(state, DmaSel::DMASEL_WQ, 0, 1, -1, alloc.uram_bank, 
               alloc.uram_offset, alloc.size);
    
    cached = mmu_check_cache(state, DmaSel::DMASEL_WQ, 0, 1, -1);
    assert(cached);
    print_test("Cache hit detection", true);
    
    MMULookup lookup = mmu_lookup(state, DmaSel::DMASEL_WQ, 0, 1, -1);
    assert(lookup.found);
    assert(lookup.uram_bank == 0);
    assert(lookup.uram_offset == 0);
    assert(lookup.size == 9);
    print_test("Tile lookup", true);
    
    MMUAllocation alloc2 = mmu_allocate(state, DmaSel::DMASEL_WK, 0, 2, -1);
    assert(alloc2.success);
    assert(alloc2.uram_bank == 1);
    assert(alloc2.uram_offset == 0);
    print_test("Ping-pong bank allocation", true);
    
    printf("Tile management tests: PASSED\n");
}

void test_completion_tracking() {
    printf("\n=== Test 7: Completion Tracking ===\n");
    
    MMUState state;
    ModelDims dims;
    mmu_init(state, dims);
    
    mmu_set_head_dma_done(state, 2);
    assert(mmu_get_head_dma_done(state, 2));
    assert(!mmu_get_head_dma_done(state, 1));
    print_test("Head DMA done set/get", true);
    
    mmu_clear_head_dma_done(state, 2);
    assert(!mmu_get_head_dma_done(state, 2));
    print_test("Head DMA done clear", true);
    
    mmu_set_head_compute_done(state, 3);
    assert(mmu_get_head_compute_done(state, 3));
    print_test("Head compute done set/get", true);
    
    mmu_set_main_dma_done(state);
    assert(mmu_get_main_dma_done(state));
    mmu_clear_main_dma_done(state);
    assert(!mmu_get_main_dma_done(state));
    print_test("Main DMA done set/clear", true);
    
    printf("Completion tracking tests: PASSED\n");
}

void test_utilities() {
    printf("\n=== Test 8: Utilities ===\n");
    
    assert(mmu_is_headed_op(ComputeOp::CMP_Q));
    assert(mmu_is_headed_op(ComputeOp::CMP_ATT_SCORES));
    assert(!mmu_is_headed_op(ComputeOp::CMP_LN0));
    assert(!mmu_is_headed_op(ComputeOp::CMP_CONCAT));
    print_test("is_headed_op detection", true);
    
    assert(mmu_is_dma_write(DmaSel::DMASEL_K_WRITE));
    assert(mmu_is_dma_write(DmaSel::DMASEL_V_WRITE));
    assert(!mmu_is_dma_write(DmaSel::DMASEL_WQ));
    print_test("is_dma_write detection", true);
    
    const char* op_name = mmu_op_name(ComputeOp::CMP_ATT_SCORES);
    assert(strcmp(op_name, "ATT_SCO") == 0);
    const char* dma_name = mmu_dma_name(DmaSel::DMASEL_CTX_K);
    assert(strcmp(dma_name, "CTX_K") == 0);
    print_test("Name conversion functions", true);
    
    printf("Utility tests: PASSED\n");
}

void test_integration() {
    printf("\n=== Test 9: Integration - Full Flow ===\n");
    
    MMUState state;
    ModelDims dims;
    mmu_init(state, dims);
    mmu_set_kv_cache_bases(state, 0x40000000, 0x50000000);
    
    // Simulate FSM issuing memory request for head 1, layer 0: load WQ
    uint32_t mem_req_packed = 0x00000101;  // tile=0, head=1, layer=0, req=DMASEL_WQ
    MemoryRequest mem_req = mmu_decode_memory_request(mem_req_packed);
    
    printf("  FSM Request: %s for layer=%d, head=%d\n",
           mmu_dma_name(mem_req.get_dma_sel()), mem_req.layer, mem_req.head);
    
    if (!mmu_check_cache(state, mem_req.get_dma_sel(), mem_req.layer, 
                         mem_req.head, mem_req.tile)) {
        printf("  Cache miss - allocating URAM space\n");
        
        // Allocate URAM
        MMUAllocation alloc = mmu_allocate(state, mem_req.get_dma_sel(),
                                          mem_req.layer, mem_req.head, mem_req.tile);
        assert(alloc.success);
        printf("  Allocated: bank=%d, offset=0x%x, size=%d\n",
               alloc.uram_bank, alloc.uram_offset, alloc.size);
        
        printf("  [DMA transfer: DDR → URAM bank %d]\n", alloc.uram_bank);
        
        mmu_commit(state, mem_req.get_dma_sel(), mem_req.layer, mem_req.head,
                   mem_req.tile, alloc.uram_bank, alloc.uram_offset, alloc.size);
        
        mmu_set_head_dma_done(state, mem_req.head);
    }
    
    uint32_t comp_req_packed = 0x00000103;  // tile=0, head=1, layer=0, op=CMP_Q
    ComputeRequest comp_req = mmu_decode_compute_request(comp_req_packed);
    
    printf("  CCU Request: %s for head=%d\n",
           mmu_op_name(comp_req.get_compute_op()), comp_req.head);
    
    MMULookup lookup = mmu_lookup(state, DmaSel::DMASEL_WQ, comp_req.layer,
                                 comp_req.head, comp_req.tile);
    assert(lookup.found);
    printf("  Tile found at: bank=%d, offset=0x%x, size=%d\n",
           lookup.uram_bank, lookup.uram_offset, lookup.size);
    
    BufferLayout in_layout = mmu_calc_input_layout(comp_req.get_compute_op(), dims);
    printf("  Input buffer layout: %d regions, total=%d bytes\n",
           in_layout.num_regions, in_layout.total_size);
    
    printf("  [Transfer: URAM → Compute Input Buffer]\n");
    
    printf("  [Compute: %s]\n", mmu_op_name(comp_req.get_compute_op()));
    
    BufferLayout out_layout = mmu_calc_output_layout(comp_req.get_compute_op(), dims);
    printf("  Output buffer: %d bytes\n", out_layout.total_size);
    
    mmu_set_head_compute_done(state, comp_req.head);
    printf("  Computation complete\n");
    
    print_test("Full integration flow", true);
    printf("Integration test: PASSED\n");
}

int main() {
    printf("╔══════════════════════════════════════════════════════════════╗\n");
    printf("║           FULL MMU COMPREHENSIVE TEST SUITE                 ║\n");
    printf("╚══════════════════════════════════════════════════════════════╝\n");
    
    test_instruction_decoding();
    test_size_calculation();
    test_buffer_layouts();
    test_weight_blob_parsing();
    test_kv_cache_addressing();
    test_tile_management();
    test_completion_tracking();
    test_utilities();
    test_integration();
    
    printf("\n╔══════════════════════════════════════════════════════════════╗\n");
    printf("║                   ALL TESTS PASSED ✓                         ║\n");
    printf("╚══════════════════════════════════════════════════════════════╝\n");
    
    return 0;
}
