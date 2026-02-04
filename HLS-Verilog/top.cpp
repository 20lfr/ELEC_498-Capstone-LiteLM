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
    // Memory Management System (WEIGHT LOADER via DMA)
    // ------------------------------------------------------------

    // FSM communication signals
    bool        dma_done,                   // [INPUT]  DMA transfer completed (single-cycle pulse)
    bool        wl_ready,                 // [INPUT]  Weight loader ready for a new request
    uint32_t    &wl_instruction,          // [OUTPUT] Packed dma op|layer|head|tile
    bool        &wl_start,                // [OUTPUT] Start weight load request

    // Compute Controller communication signals
    bool        mem_transfer_done,   // [INPUT] Memory manager transfer complete
    bool        &mem_read_request,   // [OUTPUT] Request memory manager read
    bool        &mem_write_request,  // [OUTPUT] Request memory manager write
    uint32_t    &mem_op,             // [OUTPUT] Opcode for memory manager
    const uint8_t in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t       out_buf[compute_buf::OUT_BUF_BYTES],

    // ------------------------------------------------------------
    // COMPUTE CORE (MAC ARRAY + PIPELINE)
    // ------------------------------------------------------------
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

    // Debug (compute controller)
    bool     &dbg_compute_start,
    uint32_t &dbg_compute_instruction,
    bool     &dbg_compute_ready,
    bool     &dbg_compute_done,
    ComputeState &dbg_compute_state,
    uint32_t &dbg_req_instruction,
    uint8_t  &dbg_req_op,
    uint8_t  &dbg_req_layer,
    uint8_t  &dbg_req_head,
    uint8_t  &dbg_req_tile,
    bool     &dbg_mac_start,
    bool     &dbg_mac_ready,
    bool     &dbg_mac_complete,
    bool     &dbg_ctrl_reset_asserted,

    bool &dbg_done,
    bool &dbg_error
) {
#pragma HLS INLINE off   

    bool done               = false;    // Scheduler done flag
    bool error              = false;    // Scheduler error flag
    static ControlMemSpace ctrl_mem; 
    static bool     compute_ready = false;
    static bool     compute_done = false;
    static bool     compute_start = false;
    static uint32_t compute_instruction = 0;
    // Debugging mirrors
    dbg_ctrl_mem = ctrl_mem;
    dbg_ctrl_reset_asserted = ((ctrl_mem.control & CTRL_RESETN_BIT) == 0u);
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
    if ((ctrl_mem.control & CTRL_RESETN_BIT) == 0u) {
        done          = false;
        error         = false;

        compute_ready = true;
        compute_done  = false;
        compute_start = false;
        compute_instruction = 0;
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
        dma_done,
        wl_ready,
        wl_instruction,
        wl_start,
        compute_ready,
        compute_done,
        head_ctx_ref,
        compute_start,
        compute_instruction,
        stream_ready,
        stream_start,
        stream_done,
        done,
        error,
        dbg_state
    );

    

    compute_controller(
        ctrl_mem,               
        compute_start,       
        compute_instruction,      
        compute_ready,
        compute_done,

        mem_transfer_done,   
        mem_read_request,   
        mem_write_request,  
        mem_op,    
        in_buf,
        out_buf,

        //DEBUG VISIBILITY
        dbg_compute_state,
        dbg_req_instruction,
        dbg_req_op,
        dbg_req_layer,
        dbg_req_head,
        dbg_req_tile,
        dbg_mac_start,
        dbg_mac_ready,
        dbg_mac_complete,
        error               
    );
    

    // IRQ WIZARD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    irq_ps = irq_wizard(ctrl_mem, done, error);
    dbg_done = done;
    dbg_error = error;

    dbg_compute_start = compute_start;
    dbg_compute_instruction = compute_instruction;
    dbg_compute_ready = compute_ready;
    dbg_compute_done = compute_done;

}
