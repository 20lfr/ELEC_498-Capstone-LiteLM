`timescale 1ns/1ps

// Enhanced testbench for transformer_top RTL matching C++ testbench functionality
module transformer_top_tb;
  localparam int CLK_PERIOD = 10;
  localparam int MAX_CYCLES = 8000;
  localparam int COMP_LAT = 3;
  localparam int COMP_LAT_MIN = 1;
  localparam int COMP_LAT_MAX = 4;
  localparam int DMA_LAT  = 3;
  localparam int DMA_LAT_MIN  = 1;
  localparam int DMA_LAT_MAX  = 4;
  localparam int AXIS_BEATS = 3;

  // Clock / reset
  logic ap_clk = 1'b0;
  logic ap_rst = 1'b1;
  always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

  // DUT inputs
  logic ap_start;
  logic [31:0] ctrl_addr;
  logic [31:0] ctrl_data_in;
  logic [31:0] ctrl_data_out;
  logic [0:0]  ctrl_read_en;
  logic [0:0]  ctrl_write_en;
  logic [0:0]  ctrl_chip_en;
  logic [0:0]  ctrl_resetn_in;

  logic [0:0] axis_in_valid;
  logic [0:0] axis_in_last;
  logic [0:0] dma_done;
  logic [31:0] dma_address;
  logic        dma_address_ap_vld;
  logic [0:0]  memory_request;
  logic        memory_request_ap_vld;
  logic [0:0] compute_ready;
  logic [0:0] compute_done;
  logic [0:0] compute_start_i;
  logic [0:0] stream_ready;
  logic [0:0] stream_done;

  // DUT outputs
  logic ap_done;
  logic ap_idle;
  logic ap_ready;
  logic [31:0] dbg_state;
  logic dbg_state_ap_vld;
  logic [0:0] axis_in_ready;
  logic axis_in_ready_ap_vld;
  logic [0:0] compute_start_o;
  logic compute_start_o_ap_vld;
  logic [31:0] compute_op;
  logic compute_op_ap_vld;
  logic [0:0] stream_start;
  logic stream_start_ap_vld;
  logic ctrl_data_out_ap_vld;
  logic [1055:0] dbg_ctrl_mem;
  logic [31:0] control_reg;
  logic        control_reg_ap_vld;
  logic [31:0] irq_status_reg;
  logic        irq_status_reg_ap_vld;
  logic [31:0] irq_enable_reg;
  logic        irq_enable_reg_ap_vld;
  logic [31:0] wq_base_addr;
  logic        wq_base_addr_ap_vld;
  logic [31:0] wk_base_addr;
  logic        wk_base_addr_ap_vld;
  logic [31:0] wv_base_addr;
  logic        wv_base_addr_ap_vld;
  logic [31:0] wq_head_stride;
  logic        wq_head_stride_ap_vld;
  logic [31:0] wk_head_stride;
  logic        wk_head_stride_ap_vld;
  logic [31:0] wv_head_stride;
  logic        wv_head_stride_ap_vld;
  logic [31:0] wo_base_addr;
  logic        wo_base_addr_ap_vld;
  logic [31:0] w1_base_addr;
  logic        w1_base_addr_ap_vld;
  logic [31:0] w2_base_addr;
  logic        w2_base_addr_ap_vld;
  logic [31:0] wo_tile_stride;
  logic        wo_tile_stride_ap_vld;
  logic [31:0] w1_tile_stride;
  logic        w1_tile_stride_ap_vld;
  logic [31:0] w2_tile_stride;
  logic        w2_tile_stride_ap_vld;
  logic [0:0] irq_ps;
  logic irq_ps_ap_vld;
  logic [0:0] dbg_wl_ready;
  logic        dbg_wl_ready_ap_vld;
  logic [0:0] dbg_wl_start;
  logic        dbg_wl_start_ap_vld;
  logic [7:0]  dbg_wl_addr_sel;
  logic        dbg_wl_addr_sel_ap_vld;
  logic [31:0] dbg_wl_layer;
  logic        dbg_wl_layer_ap_vld;
  logic [31:0] dbg_wl_head;
  logic        dbg_wl_head_ap_vld;
  logic [31:0] dbg_wl_tile;
  logic        dbg_wl_tile_ap_vld;
  logic [0:0]  dbg_done;
  logic        dbg_done_ap_vld;
  logic [0:0]  dbg_error;
  logic        dbg_error_ap_vld;

  // Testbench state variables
  logic comp_busy;
  int comp_timer;
  logic dma_busy;
  int dma_timer;
  logic stream_busy;
  logic start_pulsed;
  logic pending_start_clear;
  logic reset_released;
  logic reset_low_written;
  logic seen_done;
  int post_done_cycles;
  logic seen_idle_after;
  logic seen_attn;
  logic seen_concat;
  int axis_sent;
  logic axis_feed_done;
  logic axis_drive;
  logic [31:0] ctrl_shadow_control;
  int ctrl_gap_cycles;
  logic assign_base_addresses;
  int base_assign_step;
  typedef enum logic [2:0] {
    CTRL_RESET_MEM,
    CTRL_ASSERT_RESET,
    CTRL_DEASSERT_RESET,
    CTRL_PROGRAM_BASES,
    CTRL_ASSERT_START,
    CTRL_CLEAR_START,
    CTRL_DONE
  } ctrl_init_stage_t;
  ctrl_init_stage_t ctrl_stage;
  int idle_after_done;
  logic axis_last_stretch_active;
  int axis_last_stretch_ctr;
  logic seen_irq_done;
  logic irq_interupt_flagged;
  logic [31:0] interupt_data;
  logic [31:0] ctrl_data_out_shadow;
  // Head compute model
  localparam int HEADS_TOTAL = 4;
  localparam int HEADS_PAR   = 1;
  // ComputeOp encodings (must match Scheduler_FSM.hpp)
  localparam int CMP_ATT_SCORES = 7;
  localparam int CMP_CONCAT     = 13;
  // LayerNorm fine-grain ops (for readability in logs)
  localparam int CMP_LN0_SUM      = 27;
  localparam int CMP_LN0_SUMSQ    = 28;
  localparam int CMP_LN0_MEAN     = 29;
  localparam int CMP_LN0_EYY      = 30;
  localparam int CMP_LN0_VAR      = 31;
  localparam int CMP_LN0_VAR_EPS  = 32;
  localparam int CMP_LN0_INV_STD  = 33;
  localparam int CMP_LN0_NORM     = 34;
  localparam int CMP_LN0_SCALE    = 35;
  localparam int CMP_LN0_SHIFT    = 36;
  localparam int CMP_LN1_SUM      = 37;
  localparam int CMP_LN1_SUMSQ    = 38;
  localparam int CMP_LN1_MEAN     = 39;
  localparam int CMP_LN1_EYY      = 40;
  localparam int CMP_LN1_VAR      = 41;
  localparam int CMP_LN1_VAR_EPS  = 42;
  localparam int CMP_LN1_INV_STD  = 43;
  localparam int CMP_LN1_NORM     = 44;
  localparam int CMP_LN1_SCALE    = 45;
  localparam int CMP_LN1_SHIFT    = 46;
  typedef struct packed {
    // Reverse order of HeadCtx so LSBs align with C layout
    logic        att_value_dma_done;
    logic        att_scores_dma_done;
    logic        v_dma_done;
    logic        k_dma_done;
    logic        q_dma_done;
    logic        requant2_compute_done;
    logic        att_value_compute_done;
    logic        softmax_compute_done;
    logic        val_scale_compute_done;
    logic        att_scores_compute_done;
    logic        requant_q_compute_done;
    logic        v_requant_compute_done;
    logic        v_compute_done;
    logic        k_requant_compute_done;
    logic        k_compute_done;
    logic        q_compute_done;
    logic        requant2_started;
    logic        att_value_started;
    logic        softmax_started;
    logic        val_scale_started;
    logic        att_scores_started;
    logic        requant_q_started;
    logic        v_requant_started;
    logic        v_started;
    logic        k_requant_started;
    logic        k_started;
    logic        q_started;
    logic        start_head;
    logic        memory_request;
    logic [31:0] dma_address;
    logic        dma_done;
    logic [31:0] wl_head;
    logic [31:0] wl_layer;
    logic [7:0]  wl_addr_sel;
    logic        wl_start;
    logic        wl_ready;
    logic [7:0]  last_wl_addr;
    logic [31:0] last_compute_op;
    logic [31:0] compute_op;
    logic        compute_start;
    logic        compute_done;
    logic        compute_ready;
    logic [7:0]  phase;
    logic [31:0] head_idx;
    logic [31:0] layer_stamp;
  } head_ctx_t;
  localparam int HEAD_CTX_W = $bits(head_ctx_t);
  // Head context interfaces (4 lanes)
  logic [HEAD_CTX_W-1:0] head_ctx_ref_0_i, head_ctx_ref_0_o;
  logic        head_ctx_ref_0_o_ap_vld;
  logic [HEAD_CTX_W-1:0] head_ctx_ref_1_i, head_ctx_ref_1_o;
  logic        head_ctx_ref_1_o_ap_vld;
  logic [HEAD_CTX_W-1:0] head_ctx_ref_2_i, head_ctx_ref_2_o;
  logic        head_ctx_ref_2_o_ap_vld;
  logic [HEAD_CTX_W-1:0] head_ctx_ref_3_i, head_ctx_ref_3_o;
  logic        head_ctx_ref_3_o_ap_vld;
  // Debug visibility
  logic [7:0] head_phase_dbg   [0:HEADS_TOTAL-1];
  logic [31:0] head_op_dbg      [0:HEADS_TOTAL-1];
  logic [31:0] head_last_op_dbg      [0:HEADS_TOTAL-1];

  head_ctx_t head_ctx_shadow   [0:HEADS_TOTAL-1];
  logic [3:0] head_busy_ctr    [0:HEADS_TOTAL-1];
  logic       head_inflight    [0:HEADS_TOTAL-1];
  logic       head_done_hold   [0:HEADS_TOTAL-1];
  logic [2:0] head_done_ctr    [0:HEADS_TOTAL-1];
  logic       head_compute_ready [0:HEADS_TOTAL-1];
  logic       head_compute_done  [0:HEADS_TOTAL-1];
  logic [3:0] head_dma_ctr     [0:HEADS_TOTAL-1];
  logic       head_dma_inflight[0:HEADS_TOTAL-1];
  logic       head_dma_done_hold[0:HEADS_TOTAL-1];
  logic [2:0] head_dma_done_ctr[0:HEADS_TOTAL-1];
  logic       head_wl_ready    [0:HEADS_TOTAL-1];
  logic       head_dma_done    [0:HEADS_TOTAL-1];
  // Main compute done hold
  logic       comp_done_hold;
  logic [2:0] comp_done_ctr;
  // DMA done hold
  logic       dma_done_hold;
  logic [2:0] dma_done_ctr;
  // Stream done hold
  logic       stream_done_hold;
  logic [2:0] stream_done_ctr;

  logic       irq_inference_done;
  

  // Helper to decode DMA select
  function string dma_name(input [7:0] sel);
    case (sel)
      8'd0:  return "NONE";
      8'd1:  return "WQ";
      8'd2:  return "WK";
      8'd3:  return "WV";
      8'd4:  return "CTX_K";
      8'd5:  return "CTX_V";
      8'd6:  return "K_WR";
      8'd7:  return "V_WR";
      8'd8:  return "WO";
      8'd9:  return "W1";
      8'd10: return "W2";
      8'd11: return "WLOGIT";
      default: return "UNK";
    endcase
  endfunction

  function automatic int rand_comp_lat();
    rand_comp_lat = $urandom_range(COMP_LAT_MIN, COMP_LAT_MAX);
  endfunction

  function automatic int rand_dma_lat();
    rand_dma_lat = $urandom_range(DMA_LAT_MIN, DMA_LAT_MAX);
  endfunction

  // Capture ctrl_data_out only when the DUT marks it valid.
  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      ctrl_data_out_shadow <= 32'd0;
    end else if (ctrl_data_out_ap_vld) begin
      ctrl_data_out_shadow <= ctrl_data_out;
    end
  end

  // Compute model with latency
  always_ff @(posedge ap_clk) begin : compute_model
    int comp_lat_var;
    logic is_ln_op;
    if (ap_rst) begin
      comp_busy    <= 1'b0;
      comp_timer   <= 0;
      compute_done <= 1'b0;
      comp_done_hold <= 1'b0;
      comp_done_ctr <= 0;
      compute_ready<= 1'b0;
    end else begin
      compute_done <= 1'b0;
      if (comp_busy) begin
        if (comp_timer == 0) begin
          comp_done_hold <= 1'b1;
          comp_done_ctr  <= 3'd2;
          comp_busy <= 1'b0;
        end else begin
          comp_timer <= comp_timer - 1;
        end
      end
      // Hold compute_done for a few cycles
      if (comp_done_hold) begin
        compute_done <= 1'b1;
        if (comp_done_ctr == 0) begin
          comp_done_hold <= 1'b0;
        end else begin
          comp_done_ctr <= comp_done_ctr - 1;
        end
      end

      if (compute_start_o && compute_start_o_ap_vld && !comp_busy) begin
        comp_busy <= 1'b1;
        // LayerNorm ops run shorter (6 cycles), others ~24 cycles
        is_ln_op = (compute_op[7:0] >= CMP_LN0_SUM) && (compute_op[7:0] <= CMP_LN1_SHIFT);
        comp_lat_var = is_ln_op ? 25 : 27;
        comp_timer <= (comp_lat_var > 0) ? comp_lat_var - 1 : 0;
        if (compute_op[7:0] == CMP_ATT_SCORES) seen_attn <= 1'b1;
        if (compute_op[7:0] == CMP_CONCAT)     seen_concat <= 1'b1;
      end

      compute_ready <= !comp_busy && !compute_done;
    end
  end

  // Stream model
  always_ff @(posedge ap_clk) begin : stream_model
    if (ap_rst) begin
      stream_busy  <= 1'b0;
      stream_done  <= 1'b0;
      stream_done_hold <= 1'b0;
      stream_done_ctr  <= 0;
      stream_ready <= 1'b0;
    end else begin
      stream_done <= 1'b0;
      if (stream_busy) begin
        stream_busy <= 1'b0;
        stream_done_hold <= 1'b1;
        stream_done_ctr  <= 3'd4; // hold done high for a few extra cycles
      end
      if (stream_done_hold) begin
        stream_done <= 1'b1;
        if (stream_done_ctr == 0) begin
          stream_done_hold <= 1'b0;
        end else begin
          stream_done_ctr <= stream_done_ctr - 1;
        end
      end
      if (stream_start && stream_start_ap_vld && !stream_busy) begin
        stream_busy <= 1'b1;
      end
      stream_ready <= !stream_busy;
    end
  end

  // DMA model: honor DUT memory_request and return dma_done after a small latency
  always_ff @(posedge ap_clk) begin : dma_model
    int dma_lat_var;
    if (ap_rst) begin
      dma_busy  <= 1'b0;
      dma_timer <= 0;
      dma_done  <= 1'b0;
      dma_done_hold <= 1'b0;
      dma_done_ctr  <= 0;
    end else begin
      dma_done <= 1'b0;
      if (dma_busy) begin
        if (dma_timer == 0) begin
          dma_busy <= 1'b0;
          dma_done_hold <= 1'b1;
          dma_done_ctr  <= 3'd4; // hold done high for a few extra cycles
        end else begin
          dma_timer <= dma_timer - 1;
        end
      end
      if (dma_done_hold) begin
        dma_done <= 1'b1;
        if (dma_done_ctr == 0) begin
          dma_done_hold <= 1'b0;
        end else begin
          dma_done_ctr <= dma_done_ctr - 1;
        end
      end
      if (memory_request && memory_request_ap_vld && !dma_busy) begin
        dma_busy  <= 1'b1;
        dma_lat_var = rand_dma_lat();
        dma_timer <= (dma_lat_var > 0) ? dma_lat_var - 1 : 0;
      end
    end
  end

  // AXIS ingress driver
  always_ff @(posedge ap_clk) begin : axis_driver
    if (ap_rst) begin
      axis_sent      <= 0;
      axis_feed_done <= 1'b0;
      axis_drive     <= 1'b0;
      axis_in_valid  <= 1'b0;
      axis_in_last   <= 1'b0;
      axis_last_stretch_active <= 1'b0;
      axis_last_stretch_ctr    <= 0;
    end else begin
      // If stretching TLAST, hold valid/last high for 3 cycles total
      if (axis_last_stretch_active) begin
        axis_in_valid <= 1'b1;
        axis_in_last  <= 1'b1;
        if (axis_last_stretch_ctr > 0) begin
          axis_last_stretch_ctr <= axis_last_stretch_ctr - 1;
        end else begin
          axis_last_stretch_active <= 1'b0;
          axis_in_valid <= 1'b0;
          axis_in_last  <= 1'b0;
          axis_feed_done <= 1'b1;
          axis_drive     <= 1'b0;
        end
      end else if (!axis_feed_done && (axis_drive || (ctrl_shadow_control[0] && start_pulsed))) begin
        axis_drive <= 1'b1;
        if (!axis_in_valid && axis_in_ready) begin
          axis_in_valid <= 1'b1;
          axis_in_last  <= (axis_sent == AXIS_BEATS - 1);
          if (axis_sent == AXIS_BEATS - 1) begin
            axis_last_stretch_active <= 1'b1;
            axis_last_stretch_ctr    <= 2; // current cycle + 2 more
          end
        end
      end else begin
        axis_in_valid <= 1'b0;
        axis_in_last  <= 1'b0;
      end

      // Only advance beat count when not in stretch mode
      if (axis_in_valid && axis_in_ready && !axis_last_stretch_active) begin
        axis_sent <= axis_sent + 1;
        axis_in_valid <= 1'b0;
        axis_in_last  <= 1'b0;
        if (axis_sent >= AXIS_BEATS - 1) begin
          axis_feed_done <= 1'b1;
          axis_drive     <= 1'b0;
        end
      end
    end
  end

  // Per-head compute model (separate from main compute)
  // Per-head external handshakes derived from simple latency models
  always_comb begin
    for (int h = 0; h < HEADS_TOTAL; h++) begin
      head_compute_ready[h] = !head_inflight[h];
      head_compute_done[h]  = (head_inflight[h] && (head_busy_ctr[h] == 0)) || head_done_hold[h];
      head_dma_done[h]      = (head_dma_inflight[h] && (head_dma_ctr[h] == 0)) || head_dma_done_hold[h];
    end
  end

  // Pack head_ctx_ref_i with current shadow + computed ready/done + DMA handshakes
  always_comb begin
    head_ctx_t t0, t1, t2, t3;
    t0 = head_ctx_shadow[0];
    t1 = head_ctx_shadow[1];
    t2 = head_ctx_shadow[2];
    t3 = head_ctx_shadow[3];
    t0.compute_ready = head_compute_ready[0];
    t1.compute_ready = head_compute_ready[1];
    t2.compute_ready = head_compute_ready[2];
    t3.compute_ready = head_compute_ready[3];
    t0.compute_done  = head_compute_done[0];
    t1.compute_done  = head_compute_done[1];
    t2.compute_done  = head_compute_done[2];
    t3.compute_done  = head_compute_done[3];
    t0.dma_done      = head_dma_done[0];
    t1.dma_done      = head_dma_done[1];
    t2.dma_done      = head_dma_done[2];
    t3.dma_done      = head_dma_done[3];
    head_ctx_ref_0_i = t0;
    head_ctx_ref_1_i = t1;
    head_ctx_ref_2_i = t2;
    head_ctx_ref_3_i = t3;
  end

  always_ff @(posedge ap_clk) begin : irq_driver
    if (irq_ps && (ctrl_data_out[2])) begin
      irq_inference_done <= 1'b1;
    end
  end

  head_ctx_t head_ctx_ref_0_struct;
  head_ctx_t head_ctx_ref_1_struct;
  head_ctx_t head_ctx_ref_2_struct;
  head_ctx_t head_ctx_ref_3_struct;
  assign head_ctx_ref_0_struct = head_ctx_ref_0_o;
  assign head_ctx_ref_1_struct = head_ctx_ref_1_o;
  assign head_ctx_ref_2_struct = head_ctx_ref_2_o;
  assign head_ctx_ref_3_struct = head_ctx_ref_3_o;

  // Capture DUT head_ctx outputs and drive per-head compute/DMA latencies
  generate
    genvar hh;
    for (hh = 0; hh < HEADS_TOTAL; hh++) begin : HEAD_COMPUTE
      always_ff @(posedge ap_clk) begin
        int comp_lat_h;
        int dma_lat_h;
        logic compute_start_now;
        logic dma_start_now;
        logic is_ln_head_op;
        if (ap_rst) begin
          head_ctx_shadow[hh] <= '{
            layer_stamp: 32'd0,
            head_idx: hh,
            phase: 8'd0,
            compute_ready: 1'b0,
            compute_done: 1'b0,
            compute_start: 1'b0,
            last_wl_addr: 8'd0,
            last_compute_op: 32'd0,
            compute_op: 32'd0,
            wl_ready: 1'b0,
            wl_start: 1'b0,
            wl_addr_sel: 8'd0,
            wl_layer: 32'd0,
            wl_head: 32'(hh),
            dma_done: 1'b0,
            start_head: 1'b0,
            q_started: 1'b0,
            k_started: 1'b0,
            v_started: 1'b0,
            att_scores_started: 1'b0,
            val_scale_started: 1'b0,
            softmax_started: 1'b0,
            att_value_started: 1'b0,
            k_requant_started: 1'b0,
            v_requant_started: 1'b0,
            requant_q_started: 1'b0,
            requant2_started: 1'b0,
            memory_request: 1'b0,
            dma_address: 32'd0,
            q_compute_done: 1'b0,
            k_compute_done: 1'b0,
            v_compute_done: 1'b0,
            att_scores_compute_done: 1'b0,
            val_scale_compute_done: 1'b0,
            softmax_compute_done: 1'b0,
            att_value_compute_done: 1'b0,
            k_requant_compute_done: 1'b0,
            v_requant_compute_done: 1'b0,
            requant_q_compute_done: 1'b0,
            requant2_compute_done: 1'b0,
            q_dma_done: 1'b0,
            k_dma_done: 1'b0,
            v_dma_done: 1'b0,
            att_scores_dma_done: 1'b0,
            att_value_dma_done: 1'b0
          };
          head_busy_ctr[hh] <= 0;
          head_inflight[hh] <= 1'b0;
          head_done_hold[hh] <= 1'b0;
          head_done_ctr[hh] <= 0;
          head_dma_ctr[hh] <= 0;
          head_dma_inflight[hh] <= 1'b0;
          head_dma_done_hold[hh] <= 1'b0;
          head_dma_done_ctr[hh] <= 0;
        end else begin
          if (hh == 0 && head_ctx_ref_0_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_0_struct;
          if (hh == 1 && head_ctx_ref_1_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_1_struct;
          if (hh == 2 && head_ctx_ref_2_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_2_struct;
          if (hh == 3 && head_ctx_ref_3_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_3_struct;

          head_phase_dbg[hh] <= head_ctx_shadow[hh].phase;
          head_op_dbg[hh]    <= head_ctx_shadow[hh].compute_op;
          head_last_op_dbg[hh] <= head_ctx_shadow[hh].last_compute_op;


          compute_start_now = 1'b0;
          dma_start_now     = 1'b0;
          if (hh == 0 && head_ctx_ref_0_o_ap_vld) begin
            compute_start_now = head_ctx_ref_0_struct.compute_start;
            dma_start_now     = head_ctx_ref_0_struct.memory_request;
          end else if (hh == 1 && head_ctx_ref_1_o_ap_vld) begin
            compute_start_now = head_ctx_ref_1_struct.compute_start;
            dma_start_now     = head_ctx_ref_1_struct.memory_request;
          end else if (hh == 2 && head_ctx_ref_2_o_ap_vld) begin
            compute_start_now = head_ctx_ref_2_struct.compute_start;
            dma_start_now     = head_ctx_ref_2_struct.memory_request;
          end else if (hh == 3 && head_ctx_ref_3_o_ap_vld) begin
            compute_start_now = head_ctx_ref_3_struct.compute_start;
            dma_start_now     = head_ctx_ref_3_struct.memory_request;
          end
          // detect compute_start and run latency model
          if (compute_start_now && !head_inflight[hh] && !head_done_hold[hh]) begin
            head_inflight[hh] <= 1'b1;
            is_ln_head_op = (head_ctx_shadow[hh].compute_op[7:0] >= CMP_LN0_SUM) &&
                            (head_ctx_shadow[hh].compute_op[7:0] <= CMP_LN1_SHIFT);
            comp_lat_h = is_ln_head_op ? 6 : 24;
            head_busy_ctr[hh] <= (comp_lat_h > 0) ? comp_lat_h - 1 : 0;
            head_done_hold[hh] <= 1'b0;
          end else if (head_inflight[hh]) begin
            if (head_busy_ctr[hh] == 0) begin
              head_inflight[hh] <= 1'b0;
              head_done_hold[hh] <= 1'b1;
              head_done_ctr[hh] <= 3'd6;
            end else begin
              head_busy_ctr[hh] <= head_busy_ctr[hh] - 1;
            end
          end else if (head_done_hold[hh]) begin
            if (head_done_ctr[hh] > 1) begin
              head_done_ctr[hh] <= head_done_ctr[hh] - 1;
            end else begin
              head_done_hold[hh] <= 1'b0;
            end
          end

          // Per-head DMA latency model
          if (dma_start_now && !head_dma_inflight[hh] && !head_dma_done_hold[hh]) begin
            head_dma_inflight[hh] <= 1'b1;
            dma_lat_h = rand_dma_lat();
            head_dma_ctr[hh] <= (dma_lat_h > 0) ? dma_lat_h - 1 : 0;
            head_dma_done_hold[hh] <= 1'b0;
          end else if (head_dma_inflight[hh]) begin
            if (head_dma_ctr[hh] == 0) begin
              head_dma_inflight[hh] <= 1'b0;
              head_dma_done_hold[hh] <= 1'b1;
              head_dma_done_ctr[hh] <= 3'd6;
            end else begin
              head_dma_ctr[hh] <= head_dma_ctr[hh] - 1;
            end
          end else if (head_dma_done_hold[hh]) begin
            if (head_dma_done_ctr[hh] > 1) begin
              head_dma_done_ctr[hh] <= head_dma_done_ctr[hh] - 1;
            end else begin
              head_dma_done_hold[hh] <= 1'b0;
            end
          end
        end
      end
    end
  endgenerate

  // Main stimulus and control
  initial begin : stimulus
    int cycle;
    
    // Initialize
    ap_start = 1'b0;
    ctrl_shadow_control = 32'd0;
    ctrl_addr = 32'd0;
    ctrl_data_in = 32'd0;
    ctrl_read_en = 1'b0;
    ctrl_write_en = 1'b0;
    ctrl_chip_en = 1'b0;
    ctrl_resetn_in = 1'b0;
    dbg_ctrl_mem = '0;
    ctrl_gap_cycles = 0;
    assign_base_addresses = 1'b0;
    base_assign_step = 0;
    ctrl_stage = CTRL_RESET_MEM;
    compute_start_i = 1'b0;
    start_pulsed = 1'b0;
    pending_start_clear = 1'b0;
    reset_low_written = 1'b0;
    reset_released = 1'b0;
    seen_done = 1'b0;
    post_done_cycles = 0;
    seen_idle_after = 1'b0;
    seen_attn = 1'b0;
    seen_concat = 1'b0;
    idle_after_done = 0;
    irq_inference_done = 0;
    seen_irq_done = 1'b0;
    irq_interupt_flagged = 1'b0;
    interupt_data = 32'd0;

    // Print header
    $display("%-8s %-6s %-6s %-8s | %-12s | %-6s %-6s %-8s | %-7s %-8s %-10s | %-8s %-8s %-8s %-10s",
             "Cycle", "Start", "Reset", "Busy", "State",
             "AXIS_v", "AXIS_r", "AXIS_last",
             "MemReq", "DMA_Done", "DMA_Addr",
             "CmpStrt", "CmpRdy", "CmpDone", "CmpOp");

    // Release reset at cycle 2
    repeat(2) @(posedge ap_clk);
    ap_rst = 1'b0;
    ap_start = 1'b1; // Hold high continuously to mirror C++ model calling every cycle
    
    @(posedge ap_clk);

    // Main test loop
    for (cycle = 0; cycle < MAX_CYCLES; cycle++) begin
      @(posedge ap_clk);

      if (ctrl_gap_cycles > 0) begin
        ctrl_gap_cycles <= ctrl_gap_cycles - 1;
      end else begin
        // Default idle control transaction (none)
        ctrl_addr     <= 32'd0;
        ctrl_data_in  <= 32'd0;
        ctrl_read_en  <= 1'b0;
        ctrl_write_en <= 1'b0;
        ctrl_chip_en  <= 1'b0;

        case (ctrl_stage)
          CTRL_RESET_MEM: begin
            ctrl_addr      <= 32'd0; // MEMORY_RESET
            ctrl_data_in   <= 32'd0; // assert memory reset
            ctrl_write_en  <= 1'b0;
            ctrl_chip_en   <= 1'b0;
            ctrl_resetn_in <= 1'b0;
            ctrl_stage <= CTRL_ASSERT_RESET;
            ctrl_gap_cycles <= 10;
          end

          CTRL_ASSERT_RESET: begin
            ctrl_addr      <= 32'd0; // CONTROL
            ctrl_data_in   <= 32'd0; // reset low, start low
            ctrl_write_en  <= 1'b1;
            ctrl_chip_en   <= 1'b1;
            ctrl_resetn_in <= 1'b1;
            ctrl_shadow_control <= 32'd0;
            ctrl_stage <= CTRL_DEASSERT_RESET;
            ctrl_gap_cycles <= 3;
          end
          CTRL_DEASSERT_RESET: begin
            ctrl_addr      <= 32'd0; // CONTROL
            ctrl_data_in   <= 32'd1; // RESETN high, START low
            ctrl_write_en  <= 1'b1;
            ctrl_chip_en   <= 1'b1;
            ctrl_resetn_in <= 1'b1;
            ctrl_shadow_control <= 32'd1;
            ctrl_stage <= CTRL_PROGRAM_BASES;
            ctrl_gap_cycles <= 3;
          end
          CTRL_PROGRAM_BASES: begin
            // Program base addresses and strides, one write per cycle
            ctrl_resetn_in <= 1'b1;
            ctrl_write_en  <= 1'b1;
            ctrl_chip_en   <= 1'b1;
            case (base_assign_step)
              0: begin ctrl_addr <= 32'h20; ctrl_data_in <= 32'h0000_1000; end // LAYER_STRIDE
              1: begin ctrl_addr <= 32'h24; ctrl_data_in <= 32'h0000_0100; end // WQ_HEAD_STRIDE
              2: begin ctrl_addr <= 32'h28; ctrl_data_in <= 32'h0000_0100; end // WK_HEAD_STRIDE
              3: begin ctrl_addr <= 32'h2C; ctrl_data_in <= 32'h0000_0100; end // WV_HEAD_STRIDE
              4: begin ctrl_addr <= 32'h30; ctrl_data_in <= 32'h0000_0400; end // K_CACHE_STRIDE
              5: begin ctrl_addr <= 32'h34; ctrl_data_in <= 32'h0000_0400; end // V_CACHE_STRIDE
              6: begin ctrl_addr <= 32'h38; ctrl_data_in <= 32'h0000_0100; end // WO_TILE_STRIDE
              7: begin ctrl_addr <= 32'h3C; ctrl_data_in <= 32'h0000_0300; end // W1_TILE_STRIDE
              8: begin ctrl_addr <= 32'h40; ctrl_data_in <= 32'h0000_0800; end // W2_TILE_STRIDE
              9: begin ctrl_addr <= 32'h44; ctrl_data_in <= 32'h1000_0000; end // WQ_BASE_ADDR
              10: begin ctrl_addr <= 32'h48; ctrl_data_in <= 32'h2000_0000; end // WK_BASE_ADDR
              11: begin ctrl_addr <= 32'h4C; ctrl_data_in <= 32'h3000_0000; end // WV_BASE_ADDR
              12: begin ctrl_addr <= 32'h5C; ctrl_data_in <= 32'h4000_0000; end // K_CACHE_ADDR
              13: begin ctrl_addr <= 32'h60; ctrl_data_in <= 32'h5000_0000; end // V_CACHE_ADDR
              14: begin ctrl_addr <= 32'h50; ctrl_data_in <= 32'h6000_0000; end // WO_BASE_ADDR
              15: begin ctrl_addr <= 32'h54; ctrl_data_in <= 32'h7000_0000; end // W1_BASE_ADDR
              16: begin ctrl_addr <= 32'h58; ctrl_data_in <= 32'h8000_0000; end // W2_BASE_ADDR
              default: begin end
            endcase
            if (base_assign_step >= 16) begin
              assign_base_addresses <= 1'b1;
              ctrl_stage <= CTRL_ASSERT_START;
            end else begin
              base_assign_step <= base_assign_step + 1;
            end
            ctrl_gap_cycles <= 10;
          end
          CTRL_ASSERT_START: begin
            ctrl_addr      <= 32'd0; // CONTROL
            ctrl_data_in   <= 32'd3; // RESETN | START
            ctrl_write_en  <= 1'b1;
            ctrl_chip_en   <= 1'b1;
            ctrl_resetn_in <= 1'b1;
            ctrl_shadow_control <= 32'd3;
            reset_released <= 1'b1;
            start_pulsed   <= 1'b1;
            pending_start_clear <= 1'b1;
            ctrl_stage <= CTRL_CLEAR_START;
            ctrl_gap_cycles <= 3;
          end
          CTRL_CLEAR_START: begin
            ctrl_addr      <= 32'd0; // CONTROL
            ctrl_data_in   <= 32'd1; // keep reset high, clear start
            ctrl_write_en  <= 1'b1;
            ctrl_chip_en   <= 1'b1;
            ctrl_resetn_in <= 1'b1;
            ctrl_shadow_control <= 32'd1;
            pending_start_clear <= 1'b0;
            ctrl_stage <= CTRL_DONE;
            ctrl_gap_cycles <= 3;
          end
          default: begin
            if (seen_irq_done) begin
              ctrl_addr     <= 32'd12; // IRQ_STATUS offset, write clear
              ctrl_data_in  <= 32'd1;  // IRQ_CLEAR_BIT
              ctrl_write_en <= 1'b1;
              ctrl_chip_en  <= 1'b1;
              ctrl_resetn_in<= 1'b1;
              ctrl_gap_cycles <= 1;
              seen_irq_done <= 1'b0;
            end else if (irq_ps) begin
              ctrl_addr     <= 32'd12; // IRQ_STATUS offset
              ctrl_read_en  <= 1'b1;
              ctrl_chip_en  <= 1'b1;
              ctrl_resetn_in<= 1'b1;
              ctrl_gap_cycles <= 1;
              irq_interupt_flagged <= 1'b1;
              interupt_data <= ctrl_data_out;
            end else begin
              ctrl_addr     <= 32'd8; // STATUS offset
              ctrl_read_en  <= 1'b1;
              ctrl_chip_en  <= 1'b1;
              ctrl_resetn_in<= 1'b1;
              ctrl_gap_cycles <= 1;
            end
          end
        endcase
      end
      
      // Print state
      $display("%-8d %-6s %-6s %-8s | %-12s | %-6s %-6s %-8s | %-7s %-8s %-10h | %-8s %-8s %-8s 0x%08h",
               cycle,
               (ctrl_shadow_control[1]) ? "1" : "-",
               (ctrl_shadow_control[0]) ? "1" : "-",
               "-" ,
               state_name(dbg_state),
               axis_in_valid ? "1" : "-",
               axis_in_ready ? "1" : "-",
               axis_in_last ? "1" : "-",
               memory_request ? "1" : "-",
               dma_done ? "1" : "-",
               dma_address,
               compute_start_o ? "1" : "-",
               compute_ready ? "1" : "-",
               compute_done ? "1" : "-",
               compute_op);
      
      // Track done signal
      // if (ap_done) begin
      //   seen_done <= 1'b1;
      // end
      if (irq_inference_done) begin
        seen_done <= 1'b1;
      end
      
      if (seen_done) begin
        post_done_cycles <= post_done_cycles + 1;
        if (post_done_cycles >= 4) begin
          seen_idle_after <= 1'b1;
        end
      end

      // After ap_done, wait for ap_idle to stay high for 4 cycles
      if (seen_done) begin
        if (ap_idle) begin
          idle_after_done <= idle_after_done + 1;
        end else begin
          idle_after_done <= 0;
        end
      end
      
      // Exit once we've seen ap_done and ap_idle held for 4 cycles
      if (seen_done && seen_idle_after) begin
        break;
      end
    end

    // Check results
    if (!seen_done) begin
      $display("ERROR: DONE never asserted");
      $finish(1);
    end
    if (!seen_idle_after) begin
      $display("ERROR: FSM did not return to IDLE after DONE");
      $finish(1);
    end
    if (!seen_concat) begin
      $display("ERROR: CONCAT compute op never issued");
      $finish(1);
    end

    $display("\nPASS: DONE observed and FSM returned to IDLE after %0d post-done cycles. Layer=%0d",
             post_done_cycles, 32'd0);
    $finish(0);
  end

  // Helper function to convert state to string
  function string state_name(input [31:0] st);
    case (st)
      32'd0:  return "S_IDLE";
      32'd1:  return "S_STREAM_IN";
      32'd2:  return "S_LAYER_COUNT";
      32'd3:  return "S_ATT_HEADS";
      32'd4:  return "S_HEAD_CONCAT";
      32'd5:  return "S_OUT_PROJ";
      32'd6:  return "S_REQUANT1";
      32'd7:  return "S_RES_ADD_1";
      32'd8:  return "S_LN_1";
      32'd9:  return "S_REQUANT2";
      32'd10: return "S_FFN";
      32'd11: return "S_REQUANT3";
      32'd12: return "S_RES_ADD_2";
      32'd13: return "S_LN_2";
      32'd14: return "S_REQUANT4";
      32'd15: return "S_LOOP_CHECK";
      32'd16: return "S_STREAM_OUT";
      default: return "UNKNOWN";
    endcase
  endfunction

  function string op_name(input [7:0] op);
    case (op)
      8'd0:  return "NONE";
      8'd1:  return "Q";
      8'd2:  return "K";
      8'd3:  return "K_RQ";
      8'd4:  return "V";
      8'd5:  return "V_RQ";
      8'd6:  return "RQ_Q";
      8'd7:  return "ATT_SCO";
      8'd8:  return "VAL_SCL";
      8'd9:  return "SOFTMAX";
      8'd10: return "ATT_VAL";
      8'd11: return "RQ2";
      8'd12: return "HEAD_RQ";
      8'd13: return "CONCAT";
      8'd14: return "OUT_PROJ";
      8'd15: return "RQ1";
      8'd16: return "RESID0";
      8'd17: return "LN0";
      8'd18: return "RQ3";
      8'd19: return "FFN_W1";
      8'd20: return "FFN_ACT";
      8'd21: return "FFN_W2";
      8'd22: return "RQ4";
      8'd23: return "RESID1";
      8'd24: return "LN1";
      8'd25: return "DEQUANT";
      8'd26: return "LOGITS";
      8'd27: return "LN0_SUM";
      8'd28: return "LN0_Q";
      8'd29: return "LN0_MEAN";
      8'd30: return "LN0_EYY";
      8'd31: return "LN0_VAR";
      8'd32: return "LN0_VEPS";
      8'd33: return "LN0_INV";
      8'd34: return "LN0_NORM";
      8'd35: return "LN0_SCL";
      8'd36: return "LN0_SHF";
      8'd37: return "LN1_SUM";
      8'd38: return "LN1_Q";
      8'd39: return "LN1_MEAN";
      8'd40: return "LN1_EYY";
      8'd41: return "LN1_VAR";
      8'd42: return "LN1_VEPS";
      8'd43: return "LN1_INV";
      8'd44: return "LN1_NORM";
      8'd45: return "LN1_SCL";
      8'd46: return "LN1_SHF";
      default: return "UNK";
    endcase
  endfunction

  // DUT instantiation
  transformer_top dut (
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .ap_ready(ap_ready),
    .axis_in_valid(axis_in_valid),
    .axis_in_last(axis_in_last),
    .axis_in_ready(axis_in_ready),
    .axis_in_ready_ap_vld(axis_in_ready_ap_vld),
    .dma_done(dma_done),
    .dma_address(dma_address),
    .dma_address_ap_vld(dma_address_ap_vld),
    .memory_request(memory_request),
    .memory_request_ap_vld(memory_request_ap_vld),
    .compute_ready(compute_ready),
    .compute_done(compute_done),
    .head_ctx_ref_0_i(head_ctx_ref_0_i),
    .head_ctx_ref_0_o(head_ctx_ref_0_o),
    .head_ctx_ref_0_o_ap_vld(head_ctx_ref_0_o_ap_vld),
    .head_ctx_ref_1_i(head_ctx_ref_1_i),
    .head_ctx_ref_1_o(head_ctx_ref_1_o),
    .head_ctx_ref_1_o_ap_vld(head_ctx_ref_1_o_ap_vld),
    .head_ctx_ref_2_i(head_ctx_ref_2_i),
    .head_ctx_ref_2_o(head_ctx_ref_2_o),
    .head_ctx_ref_2_o_ap_vld(head_ctx_ref_2_o_ap_vld),
    .head_ctx_ref_3_i(head_ctx_ref_3_i),
    .head_ctx_ref_3_o(head_ctx_ref_3_o),
    .head_ctx_ref_3_o_ap_vld(head_ctx_ref_3_o_ap_vld),
    .compute_start_i(compute_start_i),
    .compute_start_o(compute_start_o),
    .compute_start_o_ap_vld(compute_start_o_ap_vld),
    .compute_op(compute_op),
    .compute_op_ap_vld(compute_op_ap_vld),
    .stream_ready(stream_ready),
    .stream_start(stream_start),
    .stream_start_ap_vld(stream_start_ap_vld),
    .stream_done(stream_done),
    .ctrl_addr(ctrl_addr),
    .ctrl_data_in(ctrl_data_in),
    .ctrl_data_out(ctrl_data_out),
    .ctrl_data_out_ap_vld(ctrl_data_out_ap_vld),
    .ctrl_read_en(ctrl_read_en),
    .ctrl_write_en(ctrl_write_en),
    .ctrl_chip_en(ctrl_chip_en),
    .ctrl_resetn_in(ctrl_resetn_in),
    .dbg_state(dbg_state),
    .dbg_state_ap_vld(dbg_state_ap_vld),
    .dbg_ctrl_mem(dbg_ctrl_mem),
    .irq_ps(irq_ps),
    .irq_ps_ap_vld(irq_ps_ap_vld),
    .control_reg(control_reg),
    .control_reg_ap_vld(control_reg_ap_vld),
    .irq_status_reg(irq_status_reg),
    .irq_status_reg_ap_vld(irq_status_reg_ap_vld),
    .irq_enable_reg(irq_enable_reg),
    .irq_enable_reg_ap_vld(irq_enable_reg_ap_vld),
    .wq_base_addr(wq_base_addr),
    .wq_base_addr_ap_vld(wq_base_addr_ap_vld),
    .wk_base_addr(wk_base_addr),
    .wk_base_addr_ap_vld(wk_base_addr_ap_vld),
    .wv_base_addr(wv_base_addr),
    .wv_base_addr_ap_vld(wv_base_addr_ap_vld),
    .wq_head_stride(wq_head_stride),
    .wq_head_stride_ap_vld(wq_head_stride_ap_vld),
    .wk_head_stride(wk_head_stride),
    .wk_head_stride_ap_vld(wk_head_stride_ap_vld),
    .wv_head_stride(wv_head_stride),
    .wv_head_stride_ap_vld(wv_head_stride_ap_vld),
    .wo_base_addr(wo_base_addr),
    .wo_base_addr_ap_vld(wo_base_addr_ap_vld),
    .w1_base_addr(w1_base_addr),
    .w1_base_addr_ap_vld(w1_base_addr_ap_vld),
    .w2_base_addr(w2_base_addr),
    .w2_base_addr_ap_vld(w2_base_addr_ap_vld),
    .wo_tile_stride(wo_tile_stride),
    .wo_tile_stride_ap_vld(wo_tile_stride_ap_vld),
    .w1_tile_stride(w1_tile_stride),
    .w1_tile_stride_ap_vld(w1_tile_stride_ap_vld),
    .w2_tile_stride(w2_tile_stride),
    .w2_tile_stride_ap_vld(w2_tile_stride_ap_vld),
    .dbg_wl_ready(dbg_wl_ready),
    .dbg_wl_ready_ap_vld(dbg_wl_ready_ap_vld),
    .dbg_wl_start(dbg_wl_start),
    .dbg_wl_start_ap_vld(dbg_wl_start_ap_vld),
    .dbg_wl_addr_sel(dbg_wl_addr_sel),
    .dbg_wl_addr_sel_ap_vld(dbg_wl_addr_sel_ap_vld),
    .dbg_wl_layer(dbg_wl_layer),
    .dbg_wl_layer_ap_vld(dbg_wl_layer_ap_vld),
    .dbg_wl_head(dbg_wl_head),
    .dbg_wl_head_ap_vld(dbg_wl_head_ap_vld),
    .dbg_wl_tile(dbg_wl_tile),
    .dbg_wl_tile_ap_vld(dbg_wl_tile_ap_vld),
    .dbg_done(dbg_done),
    .dbg_done_ap_vld(dbg_done_ap_vld),
    .dbg_error(dbg_error),
    .dbg_error_ap_vld(dbg_error_ap_vld)
  );

endmodule
