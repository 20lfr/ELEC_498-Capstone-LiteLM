#include "top.hpp"

// Temporary top-level wrapper that calls only the mem interface and scheduler (so no inputs rn)
void transformer_top(
    // ------------------------------------------------------------
    // AXI4-STREAM INPUT (INGRESS: PS → PL)
    // ------------------------------------------------------------
    bool axis_in_valid,                 // [INPUT]  s_axis_in_tvalid
    bool axis_in_last,                  // [INPUT]  s_axis_in_tlast
    bool &axis_in_ready,                // [OUTPUT] s_axis_in_tready

    // ------------------------------------------------------------
    // WEIGHT LOADER (AXI4-FULL MASTER via DMA)
    // ------------------------------------------------------------
    bool        dma_done,                   // [INPUT]  DMA transfer completed (single-cycle pulse)
    uint32_t    &dma_address,               // [OUTPUT] Address of completed DMA transfer
    bool        &memory_request,            // [OUTPUT] Request a DMA transfer

    // ------------------------------------------------------------
    // COMPUTE CORE (MAC ARRAY + PIPELINE)
    // ------------------------------------------------------------
    bool compute_ready,                 // [INPUT]  Compute engine idle / ready for next op
    bool compute_done,                  // [INPUT]  Compute operation finished (one-shot)
    bool &compute_start,                // [OUTPUT] Trigger compute engine
    uint32_t &compute_op,               // [OUTPUT] Packed op|layer|head|tile for compute
    HeadCtx (&head_ctx_ref)[NUM_HEADS], // [BOTH]   Per-head context (in/out) - includes DMA signals, head records and compute signals
    
    // ------------------------------------------------------------
    // AXI4-STREAM OUTPUT (EGRESS: PL → PS)
    // ------------------------------------------------------------
    bool stream_ready,                  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,                 // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,                   // [INPUT]  Stream-out finished entire sequence     

    // ------------------------------------------------------------
    // AXI4-LITE INTERFACING (PL <-> PS)
    // ------------------------------------------------------------
    ControlReg ctrl_addr,      // [INPUT]  AXI-lite address
    uint32_t   ctrl_data_in,   // [INPUT]  AXI-lite write data
    uint32_t   &ctrl_data_out, // [OUTPUT] AXI-lite read data
    bool       ctrl_read_en,   // [INPUT]  AXI-lite read strobe
    bool       ctrl_write_en,  // [INPUT]  AXI-lite write strobe
    bool       ctrl_chip_en,   // [INPUT]  AXI-lite chip enable
    bool       ctrl_resetn_in, // [INPUT]  AXI-lite active-low reset <- for clearing control mem ONLY

    // ------------------------------------------------------------
    // INTERUPT INTERFACING (PL → PS)
    // ------------------------------------------------------------
    bool        &irq_ps,

    // ------------------------------------------------------------
    // DEBUG OUTPUTS
    // ------------------------------------------------------------
    SchedState  &dbg_state,
    ControlMemSpace &dbg_ctrl_mem,
    uint32_t &control_reg,
    uint32_t &irq_status_reg,
    uint32_t &irq_enable_reg,
    uint32_t &wq_base_addr,
    uint32_t &wk_base_addr,
    uint32_t &wv_base_addr,
    uint32_t &wo_base_addr,
    uint32_t &w1_base_addr,
    uint32_t &w2_base_addr,
    uint32_t &wq_head_stride,
    uint32_t &wk_head_stride,
    uint32_t &wv_head_stride,
    uint32_t &wo_tile_stride,
    uint32_t &w1_tile_stride,
    uint32_t &w2_tile_stride,


    bool &dbg_wl_ready,
    bool &dbg_wl_start,
    DmaSel &dbg_wl_addr_sel,
    int &dbg_wl_layer,
    int &dbg_wl_head,
    int &dbg_wl_tile,
    bool &dbg_done,
    bool &dbg_error
) {
#pragma HLS INLINE off

    // WEIGHT LOADER handshake state (persist across calls)
    // static bool wl_start        = false;
    // static DmaSel wl_addr_sel   = DmaSel::DMASEL_NONE;
    // static int wl_layer         = 0;
    // static int wl_head          = 0;
    // static int wl_tile          = 0;
    // bool wl_ready;

    bool done               = false;    // Scheduler done flag
    bool error              = false;    // Scheduler error flag
    static ControlMemSpace ctrl_mem; 


    // Debugging mirrors
    control_reg   = ctrl_mem.control;
    irq_status_reg   = ctrl_mem.irq_status;
    irq_enable_reg   = ctrl_mem.irq_enable;
    wq_base_addr   = ctrl_mem.wq_base_addr;
    wk_base_addr   = ctrl_mem.wk_base_addr;
    wv_base_addr   = ctrl_mem.wv_base_addr;
    wo_base_addr   = ctrl_mem.wo_base_addr;
    w1_base_addr   = ctrl_mem.w1_base_addr;
    w2_base_addr   = ctrl_mem.w2_base_addr;
    wq_head_stride   = ctrl_mem.wq_head_stride;
    wk_head_stride   = ctrl_mem.wk_head_stride;
    wv_head_stride   = ctrl_mem.wv_head_stride;
    wo_tile_stride   = ctrl_mem.wo_tile_stride;
    w1_tile_stride   = ctrl_mem.w1_tile_stride;
    w2_tile_stride   = ctrl_mem.w2_tile_stride;

    // Clear handshake state on external resetn deassert.
    if (ctrl_mem.control & !CTRL_RESETN_BIT) {
        // wl_start      = false;
        // wl_addr_sel   = DmaSel::DMASEL_NONE;
        // wl_layer      = 0;
        // wl_head       = 0;
        // wl_tile       = 0;
        // wl_ready      = false;
        memory_request= false;
        done          = false;
        error         = false;
    }


    // Control Memory Address Space~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ControlMemInterface(
        ctrl_mem,       // AXI-Lite mapped control memory
        ctrl_addr,      // byte address for control/IRQ registers
        ctrl_data_in,   // data from PS-side writes
        ctrl_data_out,  // data returned on PS-side reads
        ctrl_read_en,   // read strobe
        ctrl_write_en,  // write strobe
        ctrl_chip_en,   // chip enable gate
        ctrl_resetn_in  // active-low reset
    );
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // SCHEDULER FSM~~~~~~~~~~~~~~~~~~~~~~~
    scheduler_hls(
        ctrl_mem,
        axis_in_valid,
        axis_in_last,
        axis_in_ready,
        memory_request,
        dma_address,
        dma_done,
        compute_ready,
        compute_done,
        head_ctx_ref,
        compute_start,
        compute_op,
        stream_ready,
        stream_start,
        stream_done,
        done,
        error,
        dbg_state,

        // Debug signal OUTPUT
        dbg_wl_ready,
        dbg_wl_start,
        dbg_wl_addr_sel,
        dbg_wl_layer,
        dbg_wl_head,
        dbg_wl_tile
    );

    

    // IRQ WIZARD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    irq_ps = irq_wizard(ctrl_mem, done, error);
    // dbg_ctrl_mem = ctrl_mem;
    // dbg_wl_ready = wl_ready;
    // dbg_wl_start = wl_start;
    // dbg_wl_addr_sel = wl_addr_sel;
    // dbg_wl_layer = wl_layer;
    // dbg_wl_head = wl_head;
    // dbg_wl_tile = wl_tile;
    dbg_done = done;
    dbg_error = error;

}
