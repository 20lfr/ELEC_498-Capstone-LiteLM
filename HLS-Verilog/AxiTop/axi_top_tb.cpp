#include "axi_top.hpp"
#include <cstdio>
#include <cstdlib>

/**
 * Simple testbench for axi_top
 * 
 * Tests:
 * - AXI4-Lite: Control/Status registers
 * - AXI4-Stream: Token input and logit output (8-bit)
 */

int main() {
    printf("=== AXI Top Testbench ===\n\n");
    printf("D_MODEL = %d\n", D_MODEL);
    
    axis_stream_t input_token;
    axis_stream_t output_logit;

    printf("\n[INIT] Preparing input stream (PS -> PL)...\n");
    for (int i = -8; i < D_MODEL/2; i++) {
        axis_pkt_t pkt;
        pkt.data = (int8_t)i;  // input: -8, -7, -6, ...
        pkt.last = (i == D_MODEL/2 - 1) ? 1 : 0;
        input_token.write(pkt);
        printf("  input_token[%d] = %d%s\n", i, (int)pkt.data, pkt.last ? " (LAST)" : "");
    }

    ControlMemSpace ctrl_mem = {};
    StatusMemSpace status_mem = {};
    bool irq_out = false;

    ctrl_mem.control = CTRL_RESETN_BIT | CTRL_START_BIT;
    ctrl_mem.irq_mask = IRQ_INFER_DONE_BIT | IRQ_ERROR_BIT;
    
    ctrl_mem.dma_layer_len = 0x100;
    ctrl_mem.dma_head_len = 0x100;
    ctrl_mem.dma_tile_len = 0x100;
    ctrl_mem.layer_stride = 0x1000;
    ctrl_mem.wq_head_stride = 0x100;
    ctrl_mem.wk_head_stride = 0x100;
    ctrl_mem.wv_head_stride = 0x100;
    ctrl_mem.k_cache_stride = 0x400;
    ctrl_mem.v_cache_stride = 0x400;
    ctrl_mem.wo_tile_stride = 0x100;
    ctrl_mem.w1_tile_stride = 0x300;
    ctrl_mem.w2_tile_stride = 0x800;
    // 64-byte aligned addresses
    ctrl_mem.wq_base_addr = 0x10000000ull;
    ctrl_mem.wk_base_addr = 0x20000000ull;
    ctrl_mem.wv_base_addr = 0x30000000ull;
    ctrl_mem.wo_base_addr = 0x60000000ull;
    ctrl_mem.w1_base_addr = 0x70000000ull;
    ctrl_mem.w2_base_addr = 0x80000000ull;
    ctrl_mem.k_cache_addr = 0x40000000ull;
    ctrl_mem.v_cache_addr = 0x50000000ull;

    printf("\n[RUN] Calling axi_top...\n");
    
    axi_top(
        ctrl_mem,
        status_mem,
        irq_out,
        input_token,
        output_logit
    );

    printf("[RUN] Complete.\n");

    printf("\n[CHECK] Verifying outputs...\n");

    // Check output stream - 8-bit per transfer
    printf("\n  Output Stream (PL -> PS):\n");
    int errors = 0;
    for (int i = -8; i < D_MODEL/2; i++) {
        if (output_logit.empty()) {
            printf("  ERROR: output_logit empty at index %d\n", i);
            errors++;
            break;
        }
        axis_pkt_t pkt = output_logit.read();
        int8_t expected = (int8_t)(i + 1);  // input + 1
        int8_t actual = pkt.data;
        
        if (actual != expected) {
            printf("  ERROR: output_logit[%d] = %d, expected %d\n", i, (int)actual, (int)expected);
            errors++;
        } else {
            printf("    output_logit[%d] = %d (OK)%s\n", i, (int)actual, pkt.last ? " (LAST)" : "");
        }
    }

    printf("\n  Control/Status:\n");
    printf("    status_mem.status     = 0x%X\n", status_mem.status);
    printf("    status_mem.irq_status = 0x%X\n", status_mem.irq_status);
    printf("    status_mem.error_code = 0x%X\n", status_mem.error_code);
    printf("    irq_out = %s\n", irq_out ? "ASSERTED" : "not asserted");

    if (!(status_mem.irq_status & IRQ_INFER_DONE_BIT)) {
        printf("  WARNING: IRQ_INFER_DONE_BIT not set\n");
    }

    printf("\n=== TEST %s ===\n", errors == 0 ? "PASSED" : "FAILED");
    printf("Errors: %d\n", errors);

    return errors;
}
