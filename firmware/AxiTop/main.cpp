/**
 * Linux userspace test for axi_top using HLS-generated UIO driver
 * NOTE: AXI-Stream DMA is NOT available from Linux userspace without custom setup
 * This test only exercises the AXI-Lite control/status interface
 */

#include <stdio.h>
#include <string.h>
#include "xaxi_top.h"

#define CTRL_RESETN_BIT     (1 << 0)
#define CTRL_START_BIT      (1 << 1)
#define IRQ_INFER_DONE_BIT  (1 << 0)
#define IRQ_ERROR_BIT       (1 << 1)

int main() {
    printf("=== AXI Top Linux Test (AXI-Lite Only) ===\n\n");
    
    XAxi_top ip;
    
    // Initialize via UIO - device name from /sys/class/uio/uioX/name
    int status = XAxi_top_Initialize(&ip, "axi_top");
    if (status != XST_SUCCESS) {
        printf("Error: Could not initialize axi_top (check /sys/class/uio)\n");
        return -1;
    }
    printf("[INIT] axi_top IP initialized via UIO\n");

    // Prepare control data (maps to ControlMemSpace struct)
    XAxi_top_Ctrl_mem ctrl = {0};
    ctrl.word_0 = CTRL_RESETN_BIT;  // control register
//    ctrl.word_0 = CTRL_RESETN_BIT | CTRL_START_BIT;  // control register will cause timeout
    ctrl.word_1 = IRQ_INFER_DONE_BIT | IRQ_ERROR_BIT; // irq_mask
    ctrl.word_2 = 0x100;   // dma_layer_len
    ctrl.word_3 = 0x100;   // dma_head_len
    ctrl.word_4 = 0x100;   // dma_tile_len
    ctrl.word_5 = 0x1000;  // layer_stride
    ctrl.word_6 = 0x100;   // wq_head_stride
    ctrl.word_7 = 0x100;   // wk_head_stride
    ctrl.word_8 = 0x100;   // wv_head_stride
    ctrl.word_9 = 0x00;   // k_cache_stride
    ctrl.word_10 = 0x400;  // v_cache_stride
    ctrl.word_11 = 0x100;  // wo_tile_stride
    ctrl.word_12 = 0x300;  // w1_tile_stride
    ctrl.word_13 = 0x800;  // w2_tile_stride
    // Base addresses (64-bit, split into word pairs)
    ctrl.word_14 = 0x10000000; ctrl.word_15 = 0;  // wq_base_addr
    ctrl.word_16 = 0x20000000; ctrl.word_17 = 0;  // wk_base_addr
    ctrl.word_18 = 0x30000000; ctrl.word_19 = 0;  // wv_base_addr
    ctrl.word_20 = 0x60000000; ctrl.word_21 = 0;  // wo_base_addr
    ctrl.word_22 = 0x70000000; ctrl.word_23 = 0;  // w1_base_addr
    ctrl.word_24 = 0x80000000; ctrl.word_25 = 0;  // w2_base_addr
    ctrl.word_26 = 0x40000000; ctrl.word_27 = 0;  // k_cache_addr
    ctrl.word_28 = 0x50000000; ctrl.word_29 = 0;  // v_cache_addr
    
    printf("[CONFIG] Writing control registers...\n");
    XAxi_top_Set_ctrl_mem(&ip, ctrl);

    printf("[RUN] Starting IP...\n");
    XAxi_top_Start(&ip);

    printf("[RUN] Waiting for completion...\n");
    // NOTE: Without DMA feeding the streams, this will hang!
    // For real testing, you need DMA setup first
    int timeout = 1000000;
    while (!XAxi_top_IsDone(&ip) && --timeout > 0);
    
    if (timeout == 0) {
        printf("[RUN] TIMEOUT - IP did not complete (streams not connected?)\n");
    } else {
        printf("[RUN] IP completed.\n");
    }

    XAxi_top_Status_mem status_mem = XAxi_top_Get_status_mem(&ip);
    printf("\n[STATUS]\n");
    printf("  word_0 (status):     0x%08X\n", status_mem.word_0);
    printf("  word_1 (irq_status): 0x%08X\n", status_mem.word_1);
    printf("  word_2 (error_code): 0x%08X\n", status_mem.word_2);
    printf("  word_3:              0x%08X\n", status_mem.word_3);

    XAxi_top_Release(&ip);
    printf("\n=== TEST COMPLETE ===\n");
    return 0;
}