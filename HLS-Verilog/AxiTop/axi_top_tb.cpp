#include "axi_top.hpp"
#include <cstdio>
#include <cstring>

// Memory Sizes
constexpr int DDR0_SIZE = Phi3Mini2K::d_ffn*Phi3Mini2K::d_model/4;
constexpr int DDR1_SIZE = 2*Phi3Mini2K::num_layers * Phi3Mini2K::num_heads * Phi3Mini2K::context_len * Phi3Mini2K::head_dim;
int32_t ddr_weights[DDR0_SIZE];
int32_t ddr_kvcache[DDR1_SIZE];

// Global TB Signals
ControlMemSpace ctrl_mem = {};
StatusMemSpace  status_mem = {};
bool irq_out = false;
axis_stream_t input_token;
axis_stream_t output_logit;

// Helper to run one cycle with a specific command
void run_cmd(uint32_t cmd_bit, uint32_t expected_status, const char* name) {
    ctrl_mem.control = PLRegBits::CTRL_RESETN_BIT | PLRegBits::CTRL_START_BIT | cmd_bit;
    
    printf("[CMD] %-15s (0x%X)... ", name, cmd_bit);
    
    // Run DUT
    axi_top(ctrl_mem, status_mem, irq_out, input_token, output_logit, ddr_weights, ddr_kvcache);

    // Check Status
    if (status_mem.status & (PLRegBits::STAT_BUSY_BIT | expected_status)) printf("BUSY %s ", name);
    if (status_mem.irq_status & PLRegBits::IRQ_ERROR_BIT) printf("IRQ_ERR: 0x%X ", status_mem.error_code);
    if (status_mem.irq_status & PLRegBits::IRQ_AXI_DONE_BIT) printf("IRQ_AXI_DONE ");
    
    // Cleanup Cycle (Clear Command, Wait for Idle)
    ctrl_mem.control = PLRegBits::CTRL_RESETN_BIT | PLRegBits::CTRL_START_BIT; // Keep Enable, Clear Command
    axi_top(ctrl_mem, status_mem, irq_out, input_token, output_logit, ddr_weights, ddr_kvcache);
    
    if (status_mem.irq_status & PLRegBits::IRQ_INFER_DONE_BIT) printf("IRQ_INFER_DONE");
    printf("\n");
}

int main() {
    printf("=== Simple AXI Top Testbench ===\n");

    for(int i=0; i<DDR0_SIZE; i++) {
        ddr_weights[i] = i;
    }
    for(int i=0; i<DDR1_SIZE; i++) {
        ddr_kvcache[i] = 0;
    }
    
    // Set V-Cache offset to prevent overlap with K-Cache
    ctrl_mem.v_cache_offset = 0x10000;

    ctrl_mem.layer_stride = 100; // valid non-zero
    ctrl_mem.wq_head_stride = 100;
    ctrl_mem.wk_head_stride = 100; 
    ctrl_mem.wv_head_stride = 100;
    ctrl_mem.k_cache_stride = 100;
    ctrl_mem.v_cache_stride = 100;
    ctrl_mem.wo_tile_stride = 100;
    ctrl_mem.w1_tile_stride = 100;
    ctrl_mem.w2_tile_stride = 100;

    printf("\n--- Reset ---\n");
    ctrl_mem.control = 0; // Reset active low
    axi_top(ctrl_mem, status_mem, irq_out, input_token, output_logit, ddr_weights, ddr_kvcache);
    printf("Reset Status: 0x%X (Expected 0x1)\n", status_mem.status);

    printf("\n--- State Sequence ---\n");
    
    run_cmd(PLRegBits::CTRL_INCR_MATRIX_BIT, PLRegBits::STAT_INCR_MATRIX_BIT, "INCR_MATRIX");
    run_cmd(PLRegBits::CTRL_INCR_LAYER_BIT,  PLRegBits::STAT_INCR_LAYER_BIT,  "INCR_LAYER");
    run_cmd(PLRegBits::CTRL_INCR_HEAD_BIT,   PLRegBits::STAT_INCR_HEAD_BIT,   "INCR_HEAD");
    
    // WEIGHTS
    // Note: In C-sim, burst_read happens instantly. 
    run_cmd(PLRegBits::CTRL_WEIGHTS_GET_BIT, PLRegBits::STAT_WEIGHTS_GET_BIT, "WEIGHTS_GET");
    run_cmd(PLRegBits::CTRL_KCACHE_GET_BIT,  PLRegBits::STAT_KCACHE_GET_BIT,  "KCACHE_GET");
    run_cmd(PLRegBits::CTRL_VCACHE_GET_BIT,  PLRegBits::STAT_VCACHE_GET_BIT,  "VCACHE_GET");
    
    // STREAM IN
    // Pre-fill stream for C-sim
    for (int i=0; i<Phi3Mini2K::d_model/NUM_BYTES_PER_STREAM; i++) {
        axis_pkt_t pkt;
        pkt.data = 0xAA;
        pkt.last = (i == Phi3Mini2K::d_model/NUM_BYTES_PER_STREAM-1) ? 1 : 0;
        input_token.write(pkt);
    }
    
    run_cmd(PLRegBits::CTRL_STREAM_IN_BIT,  PLRegBits::STAT_STREAM_IN_BIT,  "STREAM_IN");

    // COMPUTE
    run_cmd(PLRegBits::CTRL_COMPUTE_BIT,     PLRegBits::STAT_COMPUTE_BIT,     "COMPUTE");

    // KV CACHE Write Back
    run_cmd(PLRegBits::CTRL_KCACHE_SEND_BIT, PLRegBits::STAT_KCACHE_SEND_BIT, "KCACHE_SEND");
    run_cmd(PLRegBits::CTRL_VCACHE_SEND_BIT, PLRegBits::STAT_VCACHE_SEND_BIT, "VCACHE_SEND");

    printf("\n=== Checking KV Cache Output ===\n");
    int kv_nonzero = 0;
    // Check first few hundred entries or until non-zero count is sufficient
    for (int i = 0; i < DDR1_SIZE; i++) {
        if (ddr_kvcache[i] != 0) {
            // Print only first few entries of each "cluster" to avoid spam
            if (kv_nonzero < 48) { 
                printf("  ddr_kvcache[%d] = 0x%X\n", i, ddr_kvcache[i]);
            } else if (kv_nonzero == 48) {
                printf("  ... (more non-zero entries exist)\n");
            }
            kv_nonzero++;
        }
    }
    if (kv_nonzero == 0) {
        printf("  KV Cache is empty (All 0s)\n");
        return 1;
    }

    // STREAM OUT
    run_cmd(PLRegBits::CTRL_STREAM_OUT_BIT, PLRegBits::STAT_STREAM_OUT_BIT, "STREAM_OUT");
    
    // Check output
    printf("Reading Stream Out (%d packets)...\n", Phi3Mini2K::d_model/NUM_BYTES_PER_STREAM);
    int valid_pkts = 0;
    while (!output_logit.empty()) {
        axis_pkt_t out_pkt = output_logit.read();
        valid_pkts++;
        // Print first few and last few
        if (valid_pkts <= 3 || valid_pkts >= Phi3Mini2K::d_model/NUM_BYTES_PER_STREAM-3) {
            printf("  Pkt[%d]: 0x%X (Last=%d)\n", valid_pkts-1, (unsigned int)out_pkt.data, (int)out_pkt.last);
        }
    }
    
    if (valid_pkts == Phi3Mini2K::d_model/NUM_BYTES_PER_STREAM) {
        printf("Stream Out: SUCCESS (%d packets received)\n", Phi3Mini2K::d_model/NUM_BYTES_PER_STREAM);
    } else {
        printf("Stream Out: ERROR (Received %d packets, expected %d)\n", valid_pkts, Phi3Mini2K::d_model/NUM_BYTES_PER_STREAM);
        return 1;
    }

    printf("\n=== Test Complete ===\n");
    if (status_mem.error_code != PLRegBits::ERR_NONE_BIT) return 1;
    return 0;
}
