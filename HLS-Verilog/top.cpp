#include "top.hpp"
#include "MMU/mmu_luka.hpp"

// C-sim helper: access the local testbench DMA staging buffer as byte-addressable storage.
static inline uint8_t dma_buf_get_byte_u32(const uint32_t *buf, uint32_t byte_idx) {
    const uint32_t word = buf[byte_idx / static_cast<uint32_t>(sizeof(uint32_t))];
    const uint32_t shift = (byte_idx % static_cast<uint32_t>(sizeof(uint32_t))) << 3;
    return static_cast<uint8_t>((word >> shift) & 0xFFu);
}

// C-sim helper: write a single byte into the local testbench DMA staging buffer.
static inline void dma_buf_set_byte_u32(uint32_t *buf, uint32_t byte_idx, uint8_t value) {
    const uint32_t word_idx = byte_idx / static_cast<uint32_t>(sizeof(uint32_t));
    const uint32_t shift = (byte_idx % static_cast<uint32_t>(sizeof(uint32_t))) << 3;
    uint32_t word = buf[word_idx];
    word &= ~(0xFFu << shift);
    word |= (static_cast<uint32_t>(value) << shift);
    buf[word_idx] = word;
}

// Shared helper: extract one byte lane from an AXI-Full word.
static inline uint8_t gmem_get_byte(const axi_gmem_word_t &word, uint32_t lane) {
    const uint32_t hi = ((lane + 1u) * 8u) - 1u;
    const uint32_t lo = lane * 8u;
    return static_cast<uint8_t>(word.range(hi, lo));
}

// Shared helper: overwrite one byte lane inside an AXI-Full word.
static inline void gmem_set_byte(axi_gmem_word_t &word, uint32_t lane, uint8_t value) {
    const uint32_t hi = ((lane + 1u) * 8u) - 1u;
    const uint32_t lo = lane * 8u;
    word.range(hi, lo) = static_cast<ap_uint<8> >(value);
}

#ifndef __SYNTHESIS__
// C-sim helper: with offset-only addressing the MMU emits direct byte offsets
// into the compact shared DDR image, so no remap is required.
static inline uint64_t map_csim_ddr_addr(uint64_t byte_addr, const ControlMemSpace &ctrl_mem) {
    (void)ctrl_mem;
    return byte_addr;
}
#endif

// Top-level wrapper with debug mirrors enabled.
void transformer_top(
    // ------------------------------------------------------------
    // AXI4-STREAM INPUT/OUTPUT
    // ------------------------------------------------------------
    hls::stream<axis8_t> &s_axis_in,
    hls::stream<axis8_t> &m_axis_out,
    volatile axi_gmem_word_t *ddr_mem,

    // ------------------------------------------------------------
    // AXI4-LITE INTERFACING (PL <-> PS)
    // ------------------------------------------------------------
    ControlMemSpace ctrl_mem,           // [INPUT]   Control memory interface
    StatusMemSpace &status_mem,         // [OUTPUT] Status memory interface

    // ------------------------------------------------------------
    // INTERUPT INTERFACING (PL → PS)
    // ------------------------------------------------------------
    bool            &irq_ps,


    /*
        TEMPORARY INPUT/OUPUTS BELOW FOR DEBUGGING PURPOSES!!!!!!!!!!!!!
    */

    // ------------------------------------------------------------
    // DEBUG MIRRORS
    // ------------------------------------------------------------
    SchedState      &dbg_state,
    HeadCtx         (&dbg_head_ctx_ref)[HEADS_PARALLEL],
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
    uint8_t  dbg_stream_in_buf[STREAM_IN_BUF_BYTES],

    bool        &dbg_error,
    uint32_t    &dbg_error_code,
    bool        &dbg_done,
    bool        &dbg_axis_is_empty,
    bool        &dbg_axis_in_ready_wire,
    bool        &dbg_axis_in_last_wire,
    uint32_t    &dbg_stream_in_counter
) {
#pragma HLS INLINE off
#pragma HLS INTERFACE axis port=s_axis_in
#pragma HLS INTERFACE axis port=m_axis_out
#pragma HLS INTERFACE m_axi port=ddr_mem offset=slave bundle=gmem depth=TOP_DMA_BUF_WORDS
#pragma HLS INTERFACE s_axilite port=ddr_mem bundle=control
#pragma HLS INTERFACE s_axilite port=ctrl_mem bundle=control
#pragma HLS INTERFACE s_axilite port=status_mem bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS INTERFACE ap_none port=irq_ps
#pragma HLS ARRAY_PARTITION variable=dbg_head_ctx_ref complete dim=1
#pragma HLS ARRAY_PARTITION variable=dbg_head_compute_ctx complete dim=1
// #pragma HLS ARRAY_PARTITION variable=dbg_head_in_buf complete dim=1
#pragma HLS BIND_STORAGE variable=dbg_head_in_buf type=ram_t2p impl=bram
// #pragma HLS ARRAY_PARTITION variable=dbg_head_out_buf complete dim=1
#pragma HLS BIND_STORAGE variable=dbg_head_out_buf type=ram_t2p impl=bram

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
    static HeadCtx          head_ctx_local[HEADS_PARALLEL];
#pragma HLS ARRAY_PARTITION variable=head_ctx_local complete dim=1
#pragma HLS BIND_STORAGE variable=head_ctx_local type=ram_t2p impl=bram
    static ComputeHeadCtx   head_compute_ctx_local[HEADS_PARALLEL];
#pragma HLS ARRAY_PARTITION variable=head_compute_ctx_local complete dim=1
#pragma HLS BIND_STORAGE variable=head_compute_ctx_local type=ram_t2p impl=bram

    // Headed compute controller lanes (parallel heads)
    static int              head_group_idx;

    // MMU-owned compute buffers (main + headed lanes)
    static uint8_t          mmu_in_buf[compute_buf::IN_BUF_BYTES];
    #pragma HLS BIND_STORAGE variable=mmu_in_buf type=ram_t2p impl=bram
    static uint8_t          mmu_out_buf[compute_buf::OUT_BUF_BYTES];
    #pragma HLS BIND_STORAGE variable=mmu_out_buf type=ram_t2p impl=bram
    static uint8_t          mmu_head_in_buf[HEADS_PARALLEL][head_buf::IN_BUF_BYTES];
    #pragma HLS ARRAY_PARTITION variable=mmu_head_in_buf complete dim=1
    #pragma HLS BIND_STORAGE variable=mmu_head_in_buf type=ram_t2p impl=bram
    static uint8_t          mmu_head_out_buf[HEADS_PARALLEL][head_buf::OUT_BUF_BYTES];
    #pragma HLS ARRAY_PARTITION variable=mmu_head_out_buf complete dim=1
    #pragma HLS BIND_STORAGE variable=mmu_head_out_buf type=ram_t2p impl=bram
    static uint8_t          stream_in_buf_local[STREAM_IN_BUF_BYTES];
    #pragma HLS BIND_STORAGE variable=stream_in_buf_local type=ram_t2p impl=bram
    static uint8_t          stream_out_buf_local[STREAM_OUT_BUF_BYTES];
    #pragma HLS BIND_STORAGE variable=stream_out_buf_local type=ram_t2p impl=bram
    static uint32_t         dma_rx_buf_local[TOP_DMA_BUF_WORDS];
    #pragma HLS BIND_STORAGE variable=dma_rx_buf_local type=ram_t2p impl=bram
    static uint32_t         dma_tx_buf_local[TOP_DMA_BUF_WORDS];
    #pragma HLS BIND_STORAGE variable=dma_tx_buf_local type=ram_t2p impl=bram
    static bool             dma_ready_local                = true;
    static bool             dma_done_local                 = false;
    static bool             dma_busy_local                 = false;
    static int              dma_countdown_local            = 0;
    static uint64_t         dma_addr_latched_local         = 0;
    static uint32_t         dma_len_latched_local          = 0;
    static bool             dma_is_write_latched_local     = false;
    static bool             dma_start_local                = false;
    static uint64_t         dma_addr_local                 = 0;
    static uint32_t         dma_len_local                  = 0;
    static bool             dma_is_write_local             = false;
    static bool             stream_start_local             = false;
    static bool             stream_done_local              = false;
    static bool             stream_done_pulse_local        = false;
    static bool             stream_tx_active_local         = false;
    static uint16_t         stream_tx_index_local          = 0;
    static uint32_t         stream_in_counter              = 0;
    static bool             token_complete_local           = false;

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
    static bool             main_mem_read_request         = false;
    static bool             main_mem_write_request        = false;
    static uint32_t         main_mem_op                   = 0;
    static uint16_t         token_pos_current             = 0;
    static uint16_t         token_pos_next                = 0;
    static bool             debug_sum_done_local          = false;
    static int32_t          debug_sum_value_local         = 0;

    // Active-low reset derived from control register.
    const bool reset_n = (ctrl_mem.control & CTRL_RESETN_BIT) != 0u;
    const bool reset = !reset_n;
    const bool debug_mode_en = (ctrl_mem.control & CTRL_DEBUG_MODE_BIT) != 0u;

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
        main_mem_read_request = false;
        main_mem_write_request = false;
        main_mem_op = 0;
        token_pos_current = 0;
        token_pos_next = 0;
        debug_sum_done_local = false;
        debug_sum_value_local = 0;
        dma_done_local = false;
        dma_busy_local = false;
        dma_countdown_local = 0;
        dma_addr_latched_local = 0;
        dma_len_latched_local = 0;
        dma_is_write_latched_local = false;
        dma_start_local = false;
        dma_addr_local = 0;
        dma_len_local = 0;
        dma_is_write_local = false;
        stream_start_local = false;
        stream_done_local = false;
        stream_done_pulse_local = false;
        stream_tx_active_local = false;
        stream_tx_index_local = 0;
        stream_in_counter = 0;
        token_complete_local = false;

        for (int i = 0; i < HEADS_PARALLEL; ++i) {
// #pragma HLS UNROLL
            head_ctx_local[i] = HeadCtx();
        }
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
// #pragma HLS UNROLL
            head_compute_ctx_local[lane] = ComputeHeadCtx();
        }
        for (int i = 0; i < compute_buf::IN_BUF_BYTES; ++i) {
            mmu_in_buf[i] = 0;
        }
        for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
            mmu_out_buf[i] = 0;
        }
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
// #pragma HLS UNROLL
            for (int i = 0; i < head_buf::IN_BUF_BYTES; ++i) {
                mmu_head_in_buf[lane][i] = 0;
            }
            for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
                mmu_head_out_buf[lane][i] = 0;
            }
        }
        for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
            stream_in_buf_local[i] = 0;
        }
        for (int i = 0; i < STREAM_OUT_BUF_BYTES; ++i) {
            stream_out_buf_local[i] = 0;
        }
        for (int i = 0; i < TOP_DMA_BUF_WORDS; ++i) {
            dma_rx_buf_local[i] = 0;
            dma_tx_buf_local[i] = 0;
        }
    }

    if (state_local == S_IDLE) {
        token_complete_local = false;
        stream_in_counter = 0;
        debug_sum_done_local = false;
        debug_sum_value_local = 0;
    }

    const bool axis_buf_full = (stream_in_counter >= static_cast<uint32_t>(STREAM_IN_BUF_BYTES));
    const bool axis_in_ready_wire = (reset_n && (state_local == S_STREAM_IN) && !axis_buf_full && !token_complete_local);

    bool axis_in_valid = false;
    bool axis_in_last = false;
    bool axis_is_empty = s_axis_in.empty();
    if (axis_in_ready_wire && !axis_is_empty) {
        axis8_t beat = s_axis_in.read();
        axis_in_valid = true;
        axis_in_last = (beat.last != 0);

        if (stream_in_counter < static_cast<uint32_t>(STREAM_IN_BUF_BYTES)) {
            stream_in_buf_local[stream_in_counter] = static_cast<uint8_t>(beat.data);
            stream_in_counter++;
        }
        if (beat.last != 0) {
            token_complete_local = true;
            stream_in_counter = 0;
        }
    }

    const bool stream_ready_local = !stream_tx_active_local;
    stream_done_local = stream_done_pulse_local;
    stream_done_pulse_local = false;

    // SCHEDULER FSM
    scheduler_hls(
        ctrl_mem,
        active_status_mem,
        token_complete_local,
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
        debug_sum_done_local,
        stream_ready_local,
        stream_start_local,
        stream_done_local,
        done,
        scheduler_error,
        state_local
    );

    if (axis_in_valid && axis_in_last && axis_in_ready_wire) {
        const uint16_t token_pos_max = static_cast<uint16_t>(CONTEXT_LENGTH - 1);
        token_pos_current = (token_pos_next <= token_pos_max) ? token_pos_next : token_pos_max;
        if (token_pos_next < token_pos_max) {
            token_pos_next = static_cast<uint16_t>(token_pos_next + 1);
        } else {
            token_pos_next = token_pos_max;
        }
    }

    if (state_local == S_DEBUG) {
        if (!debug_sum_done_local) {
            int32_t debug_sum = 0;
            for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
                debug_sum += static_cast<int32_t>(static_cast<int8_t>(stream_in_buf_local[i]));
            }
            debug_sum_value_local = debug_sum;
            for (int i = 0; i < STREAM_OUT_BUF_BYTES; ++i) {
                stream_out_buf_local[i] = 0;
            }
            stream_out_buf_local[0] = static_cast<uint8_t>(debug_sum & 0xFF);
            if (STREAM_OUT_BUF_BYTES > 1) {
                stream_out_buf_local[1] = static_cast<uint8_t>((debug_sum >> 8) & 0xFF);
            }
            if (STREAM_OUT_BUF_BYTES > 2) {
                stream_out_buf_local[2] = static_cast<uint8_t>((debug_sum >> 16) & 0xFF);
            }
            if (STREAM_OUT_BUF_BYTES > 3) {
                stream_out_buf_local[3] = static_cast<uint8_t>((debug_sum >> 24) & 0xFF);
            }
            debug_sum_done_local = true;
        }
    } else if (!stream_tx_active_local) {
        debug_sum_done_local = false;
    }

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

    // Mirror headed compute contexts for debug visibility and MMU handshake.
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
// #pragma HLS UNROLL
        head_compute_ctx_local[lane].compute_start = head_ctx_local[lane].compute_start;
        head_compute_ctx_local[lane].compute_instruction = head_ctx_local[lane].compute_op;
    }

    bool head_error_any = false;
    drive_headed_compute_controller(
        head_compute_ctx_local,
        reset_n,
        token_pos_current,
        mmu_head_in_buf,
        mmu_head_out_buf,
        head_error_any
    );

    // Mirror headed compute contexts back to main scheduler context.
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
// #pragma HLS UNROLL
        head_ctx_local[lane].compute_ready = head_compute_ctx_local[lane].compute_ready;
        head_ctx_local[lane].compute_done  = head_compute_ctx_local[lane].compute_done;
    }

    // Main-scheduler DMA instruction mirror.
    mmu_dma_instruction = scheduler_wl_instruction;

    mmu_fsm(
        reset_n,
        ctrl_mem,
        token_pos_current,
        dma_ready_local,
        dma_done_local,
        dma_rx_buf_local,
        dma_tx_buf_local,
        dma_start_local,
        dma_addr_local,
        dma_len_local,
        dma_is_write_local,
        axis_in_valid,
        axis_in_last,
        axis_in_ready_wire,
        stream_start_local && !debug_mode_en,
        stream_in_buf_local,
        stream_out_buf_local,
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

    if (!dma_busy_local && dma_start_local && dma_ready_local) {
        dma_busy_local = true;
        dma_countdown_local = 1;
        dma_addr_latched_local = dma_addr_local;
        dma_len_latched_local = dma_len_local;
        dma_is_write_latched_local = dma_is_write_local;
    } else if (dma_busy_local) {
        if (dma_countdown_local > 0) {
            dma_countdown_local--;
        } else {
            const uint32_t bytes = dma_len_latched_local;
            if (!dma_is_write_latched_local) {
                const uint32_t rx_words = (bytes + 3u) >> 2;
                for (uint32_t i = 0; i < rx_words; ++i) {
// #pragma HLS PIPELINE II=1
                    dma_rx_buf_local[i] = 0;
                }
            }
            for (uint32_t i = 0; i < bytes; ++i) {
// #pragma HLS PIPELINE II=1
                const uint64_t byte_addr = dma_addr_latched_local + static_cast<uint64_t>(i);
#ifndef __SYNTHESIS__
                const uint64_t sim_byte_addr = map_csim_ddr_addr(byte_addr, ctrl_mem);
#else
                const uint64_t sim_byte_addr = byte_addr;
#endif
                const uint64_t word_idx_raw =
                    sim_byte_addr / static_cast<uint64_t>(AXI_GMEM_WORD_BYTES);
                const uint32_t lane =
                    static_cast<uint32_t>(sim_byte_addr % static_cast<uint64_t>(AXI_GMEM_WORD_BYTES));
                const uint64_t idx = word_idx_raw;
                axi_gmem_word_t beat = ddr_mem[idx];
                if (dma_is_write_latched_local) {
                    gmem_set_byte(beat, lane, dma_buf_get_byte_u32(dma_tx_buf_local, i));
                    ddr_mem[idx] = beat;
                } else {
                    dma_buf_set_byte_u32(dma_rx_buf_local, i, gmem_get_byte(beat, lane));
                }
            }
            dma_busy_local = false;
            dma_done_local = true;
        }
    } else {
        dma_done_local = false;
    }
    if (!stream_tx_active_local && stream_start_local) {
        stream_tx_active_local = true;
        stream_tx_index_local = 0;
    }
    if (stream_tx_active_local) {
        axis8_t out_beat{};
        out_beat.data = stream_out_buf_local[stream_tx_index_local];
        out_beat.last = (stream_tx_index_local == static_cast<uint16_t>(STREAM_OUT_BUF_BYTES - 1)) ? 1 : 0;
        out_beat.keep = 1;
        out_beat.strb = 1;
        if (m_axis_out.write_nb(out_beat)) {
            if (out_beat.last) {
                stream_tx_active_local = false;
                stream_done_pulse_local = true;
                stream_tx_index_local = 0;
            } else {
                stream_tx_index_local = static_cast<uint16_t>(stream_tx_index_local + 1);
            }
        }
    }

    compute_error = compute_error || head_error_any;
    ctrl_mem_interface.check_errors(ctrl_mem,
                                    scheduler_error,
                                    compute_error,
                                    mmu_status.invalid,
                                    mmu_status.overflow,
                                    mmu_status.error_code,
                                    mmu_status.error_subcode);
    ctrl_mem_interface.check_control(ctrl_mem, done);
    active_status_mem.token_index = static_cast<uint32_t>(token_pos_current);
    irq_ps = ctrl_mem_interface.compute_irq(ctrl_mem.irq_mask);

    // Scheduler_FSM now owns status_mem.status directly as the scheduler-state
    // channel. top keeps the debug mirror separately.
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
        for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
            dbg_stream_in_buf[i] = stream_in_buf_local[i];
        }
        for (int i = 0; i < compute_buf::IN_BUF_BYTES; ++i) {
    // #pragma HLS PIPELINE II=1
            dbg_in_buf[i] = mmu_in_buf[i];
        }
        for (int i = 0; i < compute_buf::OUT_BUF_BYTES; ++i) {
    // #pragma HLS PIPELINE II=1
            dbg_out_buf[i] = mmu_out_buf[i];
        }
        for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
    // #pragma HLS UNROLL
            dbg_head_compute_ctx[lane] = head_compute_ctx_local[lane];
            dbg_head_ctx_ref[lane] = head_ctx_local[lane];
            for (int i = 0; i < head_buf::IN_BUF_BYTES; ++i) {
    // #pragma HLS PIPELINE II=1
                dbg_head_in_buf[lane][i] = mmu_head_in_buf[lane][i];
            }
            for (int i = 0; i < head_buf::OUT_BUF_BYTES; ++i) {
    // #pragma HLS PIPELINE II=1
                dbg_head_out_buf[lane][i] = mmu_head_out_buf[lane][i];
            }
        }
        control_reg   = ctrl_mem.control;
        irq_mask_reg   = ctrl_mem.irq_mask;
        irq_clear_reg  = ctrl_mem.irq_clear;
        irq_status_reg = active_status_mem.irq_status;
        wq_base_addr   = ctrl_mem.wq_offset;
        wk_base_addr   = ctrl_mem.wk_offset;
        wv_base_addr   = ctrl_mem.wv_offset;
        wo_base_addr   = ctrl_mem.wo_offset;
        w1_base_addr   = ctrl_mem.w1_offset;
        w2_base_addr   = ctrl_mem.w2_offset;
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
            (active_status_mem.error_code != ERR_NONE);
        dbg_axis_is_empty = s_axis_in.empty();
        dbg_axis_in_ready_wire = axis_in_ready_wire;
        dbg_axis_in_last_wire = axis_in_last;
        dbg_stream_in_counter = stream_in_counter;
    }


}
