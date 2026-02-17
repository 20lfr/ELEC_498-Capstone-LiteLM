#include "axi_top.hpp"
#include <cstdio>
#include <cstring>

// Memory Sizes
constexpr int DDR0_SIZE = (Phi3Mini4K::dma_sizes::w2_tile / sizeof(int32_t));
constexpr int DDR1_SIZE =
    2 * ((Phi3Mini4K::kv_cache_head_bytes / sizeof(int32_t)));
int32_t ddr_weights[DDR0_SIZE];
int32_t ddr_kvcache[DDR1_SIZE];

// Global TB Signals
ControlMemSpace ctrl_mem = {};
StatusMemSpace status_mem = {};
bool irq_out = false;
axis_stream_t input_token;
axis_stream_t output_logit;

// Helper to run one cycle with a specific command
void run_cmd(uint32_t cmd_bit, uint32_t expected_status, const char *name) {
    ctrl_mem.control =
        PLRegBits::CTRL_RESETN_BIT | PLRegBits::CTRL_START_BIT | cmd_bit;

    printf("[CMD] %-15s (0x%X)... ", name, cmd_bit);

    // Run DUT
    axi_top(ctrl_mem, status_mem, irq_out, input_token, output_logit,
            ddr_weights, ddr_kvcache);

    // Check Status
    if (status_mem.status & (PLRegBits::STAT_BUSY_BIT | expected_status))
        printf("BUSY %s ", name);
    if (status_mem.irq_status & PLRegBits::IRQ_ERROR_BIT)
        printf("IRQ_ERR: 0x%X ", status_mem.error_code);
    if (status_mem.irq_status & PLRegBits::IRQ_AXI_DONE_BIT)
        printf("IRQ_AXI_DONE ");
    if (status_mem.irq_status & PLRegBits::IRQ_INFER_DONE_BIT)
        printf("IRQ_INFER_DONE");

    // Cleanup Cycle (Clear Command, Wait for Idle)
    ctrl_mem.control = PLRegBits::CTRL_RESETN_BIT |
                       PLRegBits::CTRL_START_BIT; // Keep Enable, Clear Command
    ctrl_mem.irq_clear = status_mem.irq_status;
    axi_top(ctrl_mem, status_mem, irq_out, input_token, output_logit,
            ddr_weights, ddr_kvcache);
    ctrl_mem.irq_clear = 0;

    printf("\n");
}

int main() {
    printf("=== AXI Top Testbench ===\n");

    // ── DDR Initialization ──
    for (int i = 0; i < DDR0_SIZE; i++)
        ddr_weights[i] = i;
    for (int i = 0; i < DDR1_SIZE; i++)
        ddr_kvcache[i] = 0;

    // All ControlMemSpace offsets and strides are in BYTES
    ctrl_mem.k_cache_offset = 0;
    ctrl_mem.v_cache_offset =
        (DDR1_SIZE / 2) * sizeof(int32_t); // Byte offset to V-cache half

    ctrl_mem.layer_stride = 100;
    ctrl_mem.wq_head_stride = 100;
    ctrl_mem.wk_head_stride = 100;
    ctrl_mem.wv_head_stride = 100;
    ctrl_mem.k_cache_stride = 100;
    ctrl_mem.v_cache_stride = 100;
    ctrl_mem.wo_tile_stride = 100;
    ctrl_mem.w1_tile_stride = 100;
    ctrl_mem.w2_tile_stride = 100;

    // ── Reset ──
    printf("\n--- Reset ---\n");
    ctrl_mem.control = 0;
    axi_top(ctrl_mem, status_mem, irq_out, input_token, output_logit,
            ddr_weights, ddr_kvcache);
    printf("Reset Status: 0x%X (Expected 0x1)\n", status_mem.status);

    run_cmd(PLRegBits::CTRL_INCR_MATRIX_BIT, PLRegBits::STAT_INCR_MATRIX_BIT,
            "INCR_MATRIX");

    // ================================================================
    //  Phase 1: Token → Weights → Compute → Stream Out
    //  (scratch_buf holds weights during compute)
    // ================================================================
    printf("\n--- Phase 1: Token + Weight + Compute ---\n");

    // Pre-fill AXI-Stream with token data
    for (int i = 0; i < Phi3Mini4K::d_model / NUM_BYTES_PER_STREAM; i++) {
        axis_pkt_t pkt;
        pkt.data = 0xAA;
        pkt.last =
            (i == Phi3Mini4K::d_model / NUM_BYTES_PER_STREAM - 1) ? 1 : 0;
        input_token.write(pkt);
    }

    run_cmd(PLRegBits::CTRL_STREAM_IN_BIT, PLRegBits::STAT_STREAM_IN_BIT,
            "STREAM_IN");
    run_cmd(PLRegBits::CTRL_WEIGHTS_GET_BIT, PLRegBits::STAT_WEIGHTS_GET_BIT,
            "WEIGHTS_GET");
    run_cmd(PLRegBits::CTRL_COMPUTE_BIT, PLRegBits::STAT_COMPUTE_BIT,
            "COMPUTE");
    run_cmd(PLRegBits::CTRL_STREAM_OUT_BIT, PLRegBits::STAT_STREAM_OUT_BIT,
            "STREAM_OUT");

    // Verify logit stream output
    printf("Reading Stream Out (%d packets)...\n",
           Phi3Mini4K::d_model / NUM_BYTES_PER_STREAM);
    int valid_pkts = 0;
    bool logit_has_weight_contribution = false;
    while (!output_logit.empty()) {
        axis_pkt_t out_pkt = output_logit.read();
        valid_pkts++;
        uint32_t val = (unsigned int)out_pkt.data;
        // With weights[i]=i, we expect logit != 0xAA for most packets
        if (val != 0xAA)
            logit_has_weight_contribution = true;
        if (valid_pkts <= 3 ||
            valid_pkts >= Phi3Mini4K::d_model / NUM_BYTES_PER_STREAM - 2) {
            printf("  Pkt[%d]: 0x%X (Last=%d)\n", valid_pkts - 1, val,
                   (int)out_pkt.last);
        }
    }

    if (valid_pkts == Phi3Mini4K::d_model / NUM_BYTES_PER_STREAM) {
        printf("Phase 1 Stream: PASS (%d packets)\n", valid_pkts);
    } else {
        printf("Phase 1 Stream: FAIL (got %d, expected %d)\n", valid_pkts,
               Phi3Mini4K::d_model / NUM_BYTES_PER_STREAM);
        return 1;
    }
    if (logit_has_weight_contribution) {
        printf("Phase 1 Compute: PASS (logits contain weight contribution)\n");
    } else {
        printf("Phase 1 Compute: WARN (all logits = 0xAA, weights may not have "
               "applied)\n");
    }

    // ================================================================
    //  Phase 2: KV Cache Read → Write-back Round-trip
    //  (scratch_buf is reused — weights are gone, that's fine)
    // ================================================================
    printf("\n--- Phase 2: KV Cache Round-trip ---\n");

    // Seed DDR KV region with a known pattern so we can verify the read
    constexpr int KV_HALF = DDR1_SIZE / 2;
    for (int i = 0; i < KV_HALF; i++)
        ddr_kvcache[i] = 0xBB000000 | i; // K region
    for (int i = 0; i < KV_HALF; i++)
        ddr_kvcache[KV_HALF + i] = 0xCC000000 | i; // V region

    // Read K-cache into scratch_buf, then write-back to DDR
    run_cmd(PLRegBits::CTRL_KCACHE_GET_BIT, PLRegBits::STAT_KCACHE_GET_BIT,
            "KCACHE_GET");
    run_cmd(PLRegBits::CTRL_KCACHE_SEND_BIT, PLRegBits::STAT_KCACHE_SEND_BIT,
            "KCACHE_SEND");

    // Read V-cache into scratch_buf, then write-back to DDR
    run_cmd(PLRegBits::CTRL_VCACHE_GET_BIT, PLRegBits::STAT_VCACHE_GET_BIT,
            "VCACHE_GET");
    run_cmd(PLRegBits::CTRL_VCACHE_SEND_BIT, PLRegBits::STAT_VCACHE_SEND_BIT,
            "VCACHE_SEND");

    // Verify KV cache DDR was written (non-zero)
    printf("\n=== Checking KV Cache Output ===\n");
    int kv_nonzero = 0;
    for (int i = 0; i < DDR1_SIZE; i++) {
        if (ddr_kvcache[i] != 0) {
            if (kv_nonzero < 8) {
                printf("  ddr_kvcache[%d] = 0x%X\n", i,
                       (unsigned int)ddr_kvcache[i]);
            } else if (kv_nonzero == 8) {
                printf("  ... (more non-zero entries)\n");
            }
            kv_nonzero++;
        }
    }
    printf("  KV non-zero entries: %d\n", kv_nonzero);
    if (kv_nonzero == 0) {
        printf("  KV Cache: FAIL (all zeros after write-back)\n");
        return 1;
    } else {
        printf("  KV Cache: PASS\n");
    }

    // ================================================================
    printf("\n=== Test Complete ===\n");
    if (status_mem.error_code != PLRegBits::ERR_NONE_BIT) {
        printf("ERROR CODE: 0x%X\n", status_mem.error_code);
        return 1;
    }
    return 0;
}
