#include "top.hpp"
#include "MMU/mmu_luka.hpp"

// Temporary top-level wrapper that calls only the mem interface and scheduler (so no inputs rn)
void transformer_top(
    // ------------------------------------------------------------
    // AXI4-STREAM INPUT (INGRESS: PS → PL)
    // ------------------------------------------------------------
    bool axis_in_valid,                 // [INPUT]  s_axis_in_tvalid
    bool axis_in_last,                  // [INPUT]  s_axis_in_tlast
    bool &axis_in_ready,                // [OUTPUT] s_axis_in_tready
    bool &axis_in_start,                // [OUTPUT] Pulse to commit stream-in payload into MMU

    // ------------------------------------------------------------
    // AXI4-STREAM OUTPUT (EGRESS: PL → PS)
    // ------------------------------------------------------------
    bool stream_ready,                  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,                 // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,                   // [INPUT]  Stream-out finished entire sequence
    const uint8_t stream_in_buf[STREAM_IN_BUF_BYTES], // [INPUT] Constructed stream-in payload buffer
    uint8_t stream_out_buf[STREAM_OUT_BUF_BYTES],     // [OUTPUT] MMU-produced stream-out payload buffer

    // ------------------------------------------------------------
    // AXI4-LITE INTERFACING (PL <-> PS)
    // ------------------------------------------------------------
    ControlMemSpace ctrl_mem,           // [INPUT]   Control memory interface
    StatusMemSpace &status_mem,         // [OUTPUT] Status memory interface

    // ------------------------------------------------------------
    // INTERUPT INTERFACING (PL → PS)
    // ------------------------------------------------------------
    bool            &irq_ps,
    bool            dma_ready,
    bool            dma_done,
    const uint8_t   dma_rx_buf[TOP_DMA_BUF_BYTES],
    uint8_t         dma_tx_buf[TOP_DMA_BUF_BYTES],
    bool            &dma_start,
    uint32_t        &dma_addr,
    uint32_t        &dma_len,
    bool            &dma_is_write,


    /*
        TEMPORARY INPUT/OUPUTS BELOW FOR DEBUGGING PURPOSES!!!!!!!!!!!!!
    */

    // ------------------------------------------------------------
    // DEBUG MIRRORS
    // ------------------------------------------------------------
    SchedState      &dbg_state,
    HeadCtx         (&dbg_head_ctx_ref)[NUM_HEADS],
    ComputeHeadCtx  (&dbg_head_compute_ctx)[HEADS_PARALLEL],
    // ------------------------------------------------------------
    // DEBUG OUTPUTS
    // ------------------------------------------------------------
    ControlMemSpace &dbg_ctrl_mem,
    uint32_t &control_reg,
    uint32_t &irq_status_reg,
    uint32_t &irq_mask_reg,
    uint32_t &irq_clear_reg,
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
    int      &dbg_head_group_idx,
    bool     &dbg_wl_ready,
    uint32_t &dbg_wl_instruction,
    bool     &dbg_wl_start,
    bool     &dbg_wl_accept,
    bool     &dbg_dma_done,
    bool     &dbg_mem_transfer_done,
    bool     &dbg_mem_read_request,
    bool     &dbg_mem_write_request,
    uint32_t &dbg_mem_op,
    uint8_t  dbg_in_buf[compute_buf::IN_BUF_BYTES],
    uint8_t  dbg_out_buf[compute_buf::OUT_BUF_BYTES],
    uint8_t  dbg_head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES],
    uint8_t  dbg_head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES],

    bool &dbg_error,
    uint32_t &dbg_error_code,
    bool &dbg_done
) {
#pragma HLS INLINE off   
#pragma HLS INTERFACE s_axilite port=ctrl_mem bundle=control
#pragma HLS INTERFACE s_axilite port=status_mem bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS INTERFACE ap_none port=irq_ps
#pragma HLS ARRAY_PARTITION variable=dbg_head_in_buf complete dim=1
#pragma HLS ARRAY_PARTITION variable=dbg_head_out_buf complete dim=1

    bool done                   = false;    // Scheduler done flag
    bool scheduler_error        = false;
    bool compute_error          = false;


    static ControlMemInterface ctrl_mem_interface;
    StatusMemSpace &active_status_mem = ctrl_mem_interface.get_mutable_status();

    static bool             compute_ready                  = false;
    static bool             compute_done                   = false;
    static bool             compute_start                  = false;
    static uint32_t         compute_instruction            = 0;
    static SchedState       state_local                    = S_IDLE;
    static HeadCtx          head_ctx_local[NUM_HEADS];
    static ComputeHeadCtx   head_compute_ctx_local[HEADS_PARALLEL];
#pragma HLS ARRAY_PARTITION variable=head_compute_ctx_local complete dim=1

    // Headed compute controller lanes (parallel heads) 
    static int              head_group_idx;

    // MMU-owned compute buffers (main + headed lanes)
    static uint8_t          mmu_in_buf[compute_buf::IN_BUF_BYTES];
    static uint8_t          mmu_out_buf[compute_buf::OUT_BUF_BYTES];
    static uint8_t          mmu_head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES];
    static uint8_t          mmu_head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES];

    // MMU external DMA/status interface state
    static Status           mmu_status;
    static bool             mmu_req_ready_wire            = true;
    static bool             mmu_main_dma_done_wire        = false;
    static bool             mmu_main_mem_transfer_done_wire = false;
    static uint32_t         mmu_dma_instruction           = 0;
    static bool             wl_ready_local                = false;
    static uint32_t         wl_instruction_local          = 0;
    static bool             wl_start_local                = false;
    static bool             wl_accept_local               = false;
    static bool             mem_transfer_done_local       = false;
    static bool             mem_read_request_local        = false;
    static bool             mem_write_request_local       = false;
    static uint32_t         mem_op_local                  = 0;
    static bool             scheduler_wl_start            = false;
    static bool             scheduler_wl_accept           = false;
    static uint32_t         scheduler_wl_instruction      = 0;
    static bool             scheduler_axis_in_start       = false;
    static bool             main_mem_read_request         = false;
    static bool             main_mem_write_request        = false;
    static uint32_t         main_mem_op                   = 0;

    // Active-low reset derived from control register.
    const bool reset_n = (ctrl_mem.control & CTRL_RESETN_BIT) != 0u;
    const bool reset = !reset_n;

    // Clear all internal state when reset is asserted.
    if (reset) {
        compute_ready = true;
        compute_done = false;
        compute_start = false;
        compute_instruction = 0;
        state_local = S_IDLE;
        head_group_idx = 0;
        mmu_req_ready_wire = true;
        mmu_main_dma_done_wire = false;
        mmu_main_mem_transfer_done_wire = false;
        mmu_dma_instruction = 0;
        mmu_status = Status();
        wl_accept_local = false;
        scheduler_wl_start = false;
        scheduler_wl_accept = false;
        scheduler_wl_instruction = 0;
        scheduler_axis_in_start = false;
        main_mem_read_request = false;
        main_mem_write_request = false;
        main_mem_op = 0;

        for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
            head_ctx_local[i] = HeadCtx();
        }
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
            head_compute_ctx_local[lane] = ComputeHeadCtx();
        }
        for (int i = 0; i < compute_buf::IN_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
            mmu_in_buf[i] = 0;
        }
        for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
            mmu_out_buf[i] = 0;
        }
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
            for (int i = 0; i < head_buf::IN_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
                mmu_head_in_buf[lane][i] = 0;
            }
            for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
#pragma HLS PIPELINE II=1
                mmu_head_out_buf[lane][i] = 0;
            }
        }
    }

    // SCHEDULER FSM~~~~~~~~~~~~~~~~~~~~~~~
    scheduler_hls(
        ctrl_mem,
        active_status_mem,
        axis_in_valid,
        axis_in_last,
        axis_in_ready,
        scheduler_axis_in_start,
        mmu_main_dma_done_wire,
        mmu_req_ready_wire,
        scheduler_wl_accept,
        scheduler_wl_instruction,
        scheduler_wl_start,
        compute_ready,
        compute_done,
        head_ctx_local,
        head_group_idx,
        compute_start,
        compute_instruction,
        stream_ready,
        stream_start,
        stream_done,
        done,
        scheduler_error,
        state_local
    );
    axis_in_start = scheduler_axis_in_start;

    compute_controller(
        ctrl_mem,               
        compute_start,       
        compute_instruction,      
        compute_ready,
        compute_done,

        mmu_main_mem_transfer_done_wire,
        main_mem_read_request,
        main_mem_write_request,
        main_mem_op,
        mmu_in_buf,
        mmu_out_buf,

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
        compute_error               
    );

    // Mirror headed compute contexts for debug visibility and MMU handshake (head scheduler only looks at head_ctx fields, so this is safe to do in-place).
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const int idx = head_group_idx * HEADS_PARALLEL + lane;
        if (idx >= 0 && idx < NUM_HEADS) {
            head_compute_ctx_local[lane].compute_start = head_ctx_local[idx].compute_start;
            head_compute_ctx_local[lane].compute_instruction = head_ctx_local[idx].compute_op;
        } else {
            head_compute_ctx_local[lane].compute_start = false;
            head_compute_ctx_local[lane].compute_instruction = 0;
            head_compute_ctx_local[lane].mem_transfer_done = false;
        }
    }
    bool head_error_any = false;
    drive_headed_compute_controller(
        head_compute_ctx_local,
        reset_n,
        mmu_head_in_buf,
        mmu_head_out_buf,
        head_error_any
    );

    // Mirror headed compute contexts back to main scheduler context for debug visibility (main scheduler has full view of all heads, so it takes priority in this mirror).
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const int idx = head_group_idx * HEADS_PARALLEL + lane;
        if (idx >= 0 && idx < NUM_HEADS) {
            head_ctx_local[idx].compute_ready = head_compute_ctx_local[lane].compute_ready;
            head_ctx_local[idx].compute_done  = head_compute_ctx_local[lane].compute_done;
        }
    }

    // Main-scheduler DMA instruction mirror.
    mmu_dma_instruction = scheduler_wl_instruction;

    mmu_fsm(
        reset_n,
        ctrl_mem,
        dma_ready,
        dma_done,
        dma_rx_buf,
        dma_tx_buf,
        dma_start,
        dma_addr,
        dma_len,
        dma_is_write,
        axis_in_ready,
        scheduler_axis_in_start,
        stream_start,
        stream_in_buf,
        stream_out_buf,
        scheduler_wl_start,
        scheduler_wl_instruction,
        mmu_req_ready_wire,
        scheduler_wl_accept,
        mmu_main_dma_done_wire,
        main_mem_read_request,
        main_mem_write_request,
        main_mem_op,
        mmu_main_mem_transfer_done_wire,
        head_ctx_local,
        head_compute_ctx_local,
        mmu_in_buf,
        mmu_out_buf,
        mmu_head_in_buf,
        mmu_head_out_buf,
        mmu_status
    );

    compute_error = compute_error || head_error_any;
    
    ctrl_mem_interface.check_errors(ctrl_mem,
                                    scheduler_error,
                                    compute_error,
                                    mmu_status.invalid,
                                    mmu_status.overflow,
                                    mmu_status.error_code);
    ctrl_mem_interface.check_control(ctrl_mem, done);
    irq_ps = ctrl_mem_interface.compute_irq(ctrl_mem.irq_mask);

    // Update status memory
    status_mem = active_status_mem;

    // Debug outputs
    {
        wl_ready_local = mmu_req_ready_wire;
        wl_start_local = scheduler_wl_start;
        wl_accept_local = scheduler_wl_accept;
        wl_instruction_local = scheduler_wl_instruction;
        mem_transfer_done_local = mmu_main_mem_transfer_done_wire;
        mem_read_request_local = main_mem_read_request;
        mem_write_request_local = main_mem_write_request;
        mem_op_local = main_mem_op;

        dbg_done = done;
        dbg_compute_start = compute_start;
        dbg_compute_instruction = compute_instruction;
        dbg_compute_ready = compute_ready;
        dbg_compute_done = compute_done;
        dbg_state = state_local;
        dbg_ctrl_mem = ctrl_mem;
        dbg_ctrl_reset_asserted = reset;
        dbg_head_group_idx = head_group_idx;
        dbg_wl_ready = wl_ready_local;
        dbg_wl_instruction = wl_instruction_local;
        dbg_wl_start = wl_start_local;
        dbg_wl_accept = wl_accept_local;
        dbg_dma_done = mmu_main_dma_done_wire;
        dbg_mem_transfer_done = mem_transfer_done_local;
        dbg_mem_read_request = mem_read_request_local;
        dbg_mem_write_request = mem_write_request_local;
        dbg_mem_op = mem_op_local;
        for (int i = 0; i < compute_buf::IN_BUF_BYTES; ++i) {
    #pragma HLS PIPELINE II=1
            dbg_in_buf[i] = mmu_in_buf[i];
        }
        for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
    #pragma HLS PIPELINE II=1
            dbg_out_buf[i] = mmu_out_buf[i];
        }
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
    #pragma HLS UNROLL
            dbg_head_compute_ctx[lane] = head_compute_ctx_local[lane];
            for (int i = 0; i < head_buf::IN_BUF_BYTES; ++i) {
    #pragma HLS PIPELINE II=1
                dbg_head_in_buf[lane][i] = mmu_head_in_buf[lane][i];
            }
            for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
    #pragma HLS PIPELINE II=1
                dbg_head_out_buf[lane][i] = mmu_head_out_buf[lane][i];
            }
        }
        for (int i = 0; i < NUM_HEADS; ++i) {
    #pragma HLS UNROLL
            dbg_head_ctx_ref[i] = head_ctx_local[i];
        }
        control_reg   = ctrl_mem.control;
        irq_mask_reg   = ctrl_mem.irq_mask;
        irq_clear_reg  = ctrl_mem.irq_clear;
        irq_status_reg = active_status_mem.irq_status;
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
        dbg_error_code = active_status_mem.error_code | mmu_status.error_code;
        dbg_error =
            scheduler_error ||
            compute_error ||
            mmu_status.invalid ||
            mmu_status.overflow ||
            ((active_status_mem.status & STATUS_ERROR) != 0u) ||
            (active_status_mem.error_code != ERR_NONE);
    }


}
