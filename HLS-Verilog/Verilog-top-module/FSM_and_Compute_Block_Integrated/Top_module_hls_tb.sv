`timescale 1ns/1ps

// Enhanced testbench for transformer_top RTL matching C++ testbench functionality
module transformer_top_tb;
  localparam int CLK_PERIOD = 10;
  localparam int MAX_CYCLES = 30000;
  localparam int COMP_LAT = 3;
  localparam int COMP_LAT_MIN = 1;
  localparam int COMP_LAT_MAX = 4;
  localparam int DMA_LAT  = 3;
  localparam int DMA_LAT_MIN  = 1;
  localparam int DMA_LAT_MAX  = 4;
  localparam int AXIS_BEATS = 3;
  localparam int NUM_HEADS       = 4;
  localparam int NUM_LAYERS      = 2;
  localparam int NUM_WO_TILES    = 4;
  localparam int NUM_W1_TILES    = 4;
  localparam int NUM_W2_TILES    = 4;
  localparam int NUM_LOGIT_TILES = 2;
  localparam int D_MODEL = 16;
  localparam int D_FFN   = 22;
  localparam int D_HEADS = D_MODEL / NUM_HEADS;
  localparam int D_TILE_WO  = D_MODEL / NUM_WO_TILES;
  localparam int D_TILE_W1  = D_MODEL / NUM_W1_TILES;
  localparam int D_TILE_W2  = D_FFN   / NUM_W2_TILES;
  localparam int CONTEXT_LENGTH = 16;
  localparam int IN_BUF_BYTES = 129;
  localparam int OUT_BUF_BYTES = 64;
  localparam int IN_BUF_ADDR_W = 8;
  localparam int OUT_BUF_ADDR_W = 6;
  localparam int OUT_PROJ_ACT_BYTES = D_MODEL;
  localparam int OUT_PROJ_W_NIBBLES = D_MODEL * D_TILE_WO;
  localparam int OUT_PROJ_W_BYTES = (OUT_PROJ_W_NIBBLES + 1) / 2;
  localparam int OUT_PROJ_B_BYTES = D_TILE_WO * 4;
  localparam int OUT_PROJ_ACT_OFFSET = 0;
  localparam int OUT_PROJ_W_OFFSET = OUT_PROJ_ACT_OFFSET + OUT_PROJ_ACT_BYTES;
  localparam int OUT_PROJ_B_OFFSET = OUT_PROJ_W_OFFSET + OUT_PROJ_W_BYTES;
  localparam int REQUANT_X_OFFSET = 0;
  localparam int REQUANT_M_OFFSET = REQUANT_X_OFFSET + (D_MODEL * 4);
  localparam int REQUANT_N_OFFSET = REQUANT_M_OFFSET + 4;
  localparam int REQUANT_Z_OFFSET = REQUANT_N_OFFSET + 4;
  localparam int RESID_X_OFFSET = 0;
  localparam int RESID_R_OFFSET = RESID_X_OFFSET + D_MODEL;
  localparam int LN_X_OFFSET = 0;
  localparam int LN_GAMMA_OFFSET = LN_X_OFFSET + D_MODEL;
  localparam int LN_EPS_OFFSET = LN_GAMMA_OFFSET + (D_MODEL * 4);
  localparam int FFN_W1_X_OFFSET = 0;
  localparam int FFN_W1_W_NIBBLES = D_MODEL * D_TILE_W1;
  localparam int FFN_W1_W_BYTES = (FFN_W1_W_NIBBLES + 1) / 2;
  localparam int FFN_W1_B_BYTES = D_TILE_W1 * 4;
  localparam int FFN_W1_S_BYTES = D_TILE_W1 * 2;
  localparam int FFN_W1_W_OFFSET = FFN_W1_X_OFFSET + D_MODEL;
  localparam int FFN_W1_B_OFFSET = FFN_W1_W_OFFSET + FFN_W1_W_BYTES;
  localparam int FFN_W1_S_OFFSET = FFN_W1_B_OFFSET + FFN_W1_B_BYTES;
  localparam int FFN_ACT_X_OFFSET = 0;
  localparam int FFN_W2_X_OFFSET = 0;
  localparam int FFN_W2_W_NIBBLES = D_FFN * D_TILE_W2;
  localparam int FFN_W2_W_BYTES = (FFN_W2_W_NIBBLES + 1) / 2;
  localparam int FFN_W2_B_BYTES = D_TILE_W2 * 4;
  localparam int FFN_W2_S_BYTES = D_TILE_W2 * 2;
  localparam int FFN_W2_W_OFFSET = FFN_W2_X_OFFSET + (D_FFN * 2);
  localparam int FFN_W2_B_OFFSET = FFN_W2_W_OFFSET + FFN_W2_W_BYTES;
  localparam int FFN_W2_S_OFFSET = FFN_W2_B_OFFSET + FFN_W2_B_BYTES;
  localparam int MEM_LAT = 8;

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
  logic [0:0] wl_ready;
  logic [0:0] mem_transfer_done;
  logic [0:0] mem_read_request;
  logic       mem_read_request_ap_vld;
  logic [0:0] mem_write_request;
  logic       mem_write_request_ap_vld;
  logic [31:0] mem_op;
  logic       mem_op_ap_vld;
  logic [IN_BUF_ADDR_W-1:0] in_buf_address0;
  logic in_buf_ce0;
  logic [7:0] in_buf_q0;
  logic [IN_BUF_ADDR_W-1:0] in_buf_address1;
  logic in_buf_ce1;
  logic [7:0] in_buf_q1;
  logic [OUT_BUF_ADDR_W-1:0] out_buf_address0;
  logic out_buf_ce0;
  logic out_buf_we0;
  logic [7:0] out_buf_d0;
  logic [OUT_BUF_ADDR_W-1:0] out_buf_address1;
  logic out_buf_ce1;
  logic out_buf_we1;
  logic [7:0] out_buf_d1;
  logic [0:0] wl_start_i;
  logic [0:0] wl_start_o;
  logic       wl_start_o_ap_vld;
  logic [31:0] wl_instruction;
  logic        wl_instruction_ap_vld;
  logic [0:0] stream_ready;
  logic [0:0] stream_done;

  // DUT outputs
  logic ap_done;
  logic ap_idle;
  logic ap_ready;
  logic [31:0] dbg_state;
  logic dbg_state_ap_vld;
  logic [0:0] dbg_compute_start;
  logic       dbg_compute_start_ap_vld;
  logic [31:0] dbg_compute_instruction;
  logic        dbg_compute_instruction_ap_vld;
  logic [0:0]  dbg_compute_ready;
  logic        dbg_compute_ready_ap_vld;
  logic [0:0]  dbg_compute_done;
  logic        dbg_compute_done_ap_vld;
  logic [31:0] dbg_compute_state;
  logic        dbg_compute_state_ap_vld;
  logic [31:0] dbg_req_instruction;
  logic        dbg_req_instruction_ap_vld;
  logic [7:0]  dbg_req_op;
  logic        dbg_req_op_ap_vld;
  logic [7:0]  dbg_req_layer;
  logic        dbg_req_layer_ap_vld;
  logic [7:0]  dbg_req_head;
  logic        dbg_req_head_ap_vld;
  logic [7:0]  dbg_req_tile;
  logic        dbg_req_tile_ap_vld;
  logic [0:0]  dbg_mac_start;
  logic        dbg_mac_start_ap_vld;
  logic [0:0]  dbg_mac_ready;
  logic        dbg_mac_ready_ap_vld;
  logic [0:0]  dbg_mac_complete;
  logic        dbg_mac_complete_ap_vld;
  logic [0:0]  dbg_ctrl_reset_asserted;
  logic        dbg_ctrl_reset_asserted_ap_vld;
  logic [0:0] axis_in_ready;
  logic axis_in_ready_ap_vld;
  logic [0:0] stream_start;
  logic stream_start_ap_vld;
  logic ctrl_data_out_ap_vld;
  logic [1055:0] dbg_ctrl_mem;
  logic        dbg_ctrl_mem_ap_vld;
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
  logic [0:0]  dbg_done;
  logic        dbg_done_ap_vld;
  logic [0:0]  dbg_error;
  logic        dbg_error_ap_vld;

  // Testbench state variables
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
  // Compute controller ops (match compute_controller_tb.sv)
  localparam int CMP_LN0        = 8'h01;
  localparam int CMP_REQUANT1   = 8'h02;
  localparam int CMP_OUT_PROJ   = 8'h0F;
  localparam int CMP_RESID0     = 8'h10;
  localparam int CMP_REQUANT2   = 8'h11;
  localparam int CMP_FFN_W1     = 8'h12;
  localparam int CMP_FFN_ACT    = 8'h13;
  localparam int CMP_FFN_W2     = 8'h14;
  localparam int CMP_REQUANT3   = 8'h15;
  localparam int CMP_RESID1     = 8'h16;
  localparam int CMP_LN1        = 8'h17;
  localparam int CMP_REQUANT4   = 8'h18;
  localparam int CMP_FINAL_NORM = 8'h19;
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
    logic        v_writeback_dma_done;
    logic        v_dma_done;
    logic        k_writeback_dma_done;
    logic        k_dma_done;
    logic        q_dma_done;
    logic        head_requant_compute_done;
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
    logic        head_requant_started;
    logic        att_value_started;
    logic        softmax_started;
    logic        val_scale_started;
    logic        att_scores_started;
    logic        requant_q_started;
    logic        v_writeback_started;
    logic        v_requant_started;
    logic        v_started;
    logic        k_writeback_started;
    logic        k_requant_started;
    logic        k_started;
    logic        q_started;
    logic        start_head;
    logic        dma_done;
    logic [31:0] wl_instruction;
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
  logic [6:0] head_dma_done_ctr[0:HEADS_TOTAL-1];
  logic       head_dma_done    [0:HEADS_TOTAL-1];
  logic       head_wl_stall    [0:HEADS_TOTAL-1];
  // Debug latches
  logic [0:0] dbg_compute_ready_lat;
  logic [0:0] dbg_compute_done_lat;

  // Compute controller memory model
  logic [7:0] in_buf_mem [0:IN_BUF_BYTES-1];
  logic [7:0] out_buf_mem [0:OUT_BUF_BYTES-1];
  typedef enum logic [1:0] { MEM_NONE=2'b00, MEM_READ=2'b01, MEM_WRITE=2'b10 } mem_pending_t;
  mem_pending_t mem_pending;
  logic mem_busy;
  int mem_timer;
  int mem_done_hold;
  int pending_tile;

  // Input data sets (mirrors compute_controller_tb.sv)
  logic [7:0]  full_valueA [0:D_MODEL-1];
  logic [3:0]  full_weights [0:D_MODEL*D_MODEL-1];
  logic [31:0] full_bias [0:D_MODEL-1];
  logic [31:0] rq1_x [0:D_MODEL-1];
  logic [31:0] rq2_x [0:D_MODEL-1];
  logic [31:0] rq3_x [0:D_MODEL-1];
  logic [31:0] rq4_x [0:D_MODEL-1];
  logic [31:0] rq1_M, rq1_N, rq1_Z;
  logic [31:0] rq2_M, rq2_N, rq2_Z;
  logic [31:0] rq3_M, rq3_N, rq3_Z;
  logic [31:0] rq4_M, rq4_N, rq4_Z;
  logic [31:0] full_accum [0:D_MODEL-1];
  logic [7:0]  rq1_out [0:D_MODEL-1];
  logic [7:0]  rq2_out [0:D_MODEL-1];
  logic [7:0]  rq3_out [0:D_MODEL-1];
  logic [7:0]  rq4_out [0:D_MODEL-1];
  logic [7:0]  resid0_out [0:D_MODEL-1];
  logic [7:0]  resid1_out [0:D_MODEL-1];
  logic [31:0] ln0_out [0:D_MODEL-1];
  logic [31:0] ln1_out [0:D_MODEL-1];
  logic [31:0] final_norm_out [0:D_MODEL-1];
  logic [7:0] resid0_x [0:D_MODEL-1];
  logic [7:0] resid0_r [0:D_MODEL-1];
  logic [7:0] resid1_x [0:D_MODEL-1];
  logic [7:0] resid1_r [0:D_MODEL-1];
  logic [7:0] ln0_x [0:D_MODEL-1];
  logic [7:0] ln1_x [0:D_MODEL-1];
  logic [7:0] final_norm_x [0:D_MODEL-1];
  logic [31:0] ln0_gamma [0:D_MODEL-1];
  logic [31:0] ln1_gamma [0:D_MODEL-1];
  logic [31:0] final_norm_gamma [0:D_MODEL-1];
  logic [31:0] ln0_eps;
  logic [31:0] ln1_eps;
  logic [31:0] final_norm_eps;
  logic [7:0] ffn1_x [0:D_MODEL-1];
  logic [3:0] ffn1_w [0:(D_MODEL*D_MODEL)-1];
  logic [31:0] ffn1_b [0:D_MODEL-1];
  logic [15:0] ffn1_s [0:D_MODEL-1];
  logic [15:0] ffn1_out [0:D_MODEL-1];
  logic [15:0] ffn_act_in [0:D_FFN-1];
  logic [15:0] ffn_act_out [0:D_FFN-1];
  logic [15:0] ffn2_x [0:D_FFN-1];
  logic [3:0] ffn2_w [0:(D_FFN*D_FFN)-1];
  logic [31:0] ffn2_b [0:D_FFN-1];
  logic [15:0] ffn2_s [0:D_FFN-1];
  logic [31:0] ffn2_out [0:(NUM_W2_TILES * D_TILE_W2)-1];
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
      8'd12: return "CONCAT";
      default: return "UNK";
    endcase
  endfunction

  function automatic int rand_comp_lat();
    rand_comp_lat = $urandom_range(COMP_LAT_MIN, COMP_LAT_MAX);
  endfunction

  function automatic int rand_dma_lat();
    rand_dma_lat = $urandom_range(DMA_LAT_MIN, DMA_LAT_MAX);
  endfunction

  // Initialize memory-backed input datasets for compute controller
  initial begin : init_mem
    int i;
    int t;
    int j;

    for (i = 0; i < D_MODEL; i = i + 1) begin
      full_valueA[i] = 8'h7f;
      full_bias[i] = 32'd7;
      full_accum[i] = 32'd0;
      rq1_x[i] = (i * 3) - 20;
      rq2_x[i] = (i * 2) + 5;
      rq3_x[i] = 100 - (i * 4);
      rq4_x[i] = (i * 5) - 11;
      rq1_out[i] = 8'd0;
      rq2_out[i] = 8'd0;
      rq3_out[i] = 8'd0;
      rq4_out[i] = 8'd0;
      resid0_x[i] = i;
      resid0_r[i] = i * 2;
      resid1_x[i] = -i;
      resid1_r[i] = i + 1;
      resid0_out[i] = 8'd0;
      resid1_out[i] = 8'd0;
      ln0_x[i] = i + 1;
      ln1_x[i] = i + 2;
      final_norm_x[i] = i + 3;
      ln0_gamma[i] = 32'd1;
      ln1_gamma[i] = 32'd2;
      final_norm_gamma[i] = 32'd3;
      ln0_out[i] = 32'd0;
      ln1_out[i] = 32'd0;
      final_norm_out[i] = 32'd0;
      ffn1_x[i] = i + 3;
      ffn1_b[i] = 32'd7;
      ffn1_s[i] = 16'h4000;
      ffn1_out[i] = 16'd0;
    end

    rq1_M = 32'd1; rq1_N = 32'd0; rq1_Z = 32'd0;
    rq2_M = 32'd2; rq2_N = 32'd1; rq2_Z = 32'd0;
    rq3_M = 32'd1; rq3_N = 32'd2; rq3_Z = 32'd0;
    rq4_M = 32'd3; rq4_N = 32'd1; rq4_Z = 32'd0;
    ln0_eps = 32'd1;
    ln1_eps = 32'd2;
    final_norm_eps = 32'd3;

    for (t = 0; t < D_MODEL; t = t + 1) begin
      for (j = 0; j < D_MODEL; j = j + 1) begin
        full_weights[t * D_MODEL + j] = 4'h7;
        ffn1_w[t * D_MODEL + j] = 4'h1;
      end
    end

    for (t = 0; t < D_FFN; t = t + 1) begin
      ffn_act_in[t] = (t * 3) - 20;
      ffn_act_out[t] = 16'd0;
      ffn2_x[t] = (t * 2) + 1;
      ffn2_b[t] = 32'd5;
      ffn2_s[t] = 16'h4000;
    end
    for (t = 0; t < (D_FFN * D_FFN); t = t + 1) begin
      ffn2_w[t] = 4'h1;
    end
    for (t = 0; t < (NUM_W2_TILES * D_TILE_W2); t = t + 1) begin
      ffn2_out[t] = 32'd0;
    end

    for (i = 0; i < IN_BUF_BYTES; i = i + 1) begin
      in_buf_mem[i] = 8'd0;
    end

    for (i = 0; i < OUT_BUF_BYTES; i = i + 1) begin
      out_buf_mem[i] = 8'd0;
    end
  end

  task automatic write_i4_to_in_buf(input int nibble_idx, input logic [3:0] value);
    int byte_addr;
    begin
      byte_addr = nibble_idx / 2;
      if ((nibble_idx % 2) != 0) begin
        in_buf_mem[byte_addr] = {value, in_buf_mem[byte_addr][3:0]};
      end else begin
        in_buf_mem[byte_addr] = {in_buf_mem[byte_addr][7:4], value};
      end
    end
  endtask

  task automatic write_i32_to_in_buf(input int byte_addr, input logic [31:0] value);
    begin
      in_buf_mem[byte_addr + 0] = value[7:0];
      in_buf_mem[byte_addr + 1] = value[15:8];
      in_buf_mem[byte_addr + 2] = value[23:16];
      in_buf_mem[byte_addr + 3] = value[31:24];
    end
  endtask

  task automatic write_i16_to_in_buf(input int byte_addr, input logic [15:0] value);
    begin
      in_buf_mem[byte_addr + 0] = value[7:0];
      in_buf_mem[byte_addr + 1] = value[15:8];
    end
  endtask

  function automatic logic [31:0] read_i32_from_out_buf(input int byte_addr);
    read_i32_from_out_buf = {out_buf_mem[byte_addr + 3],
                             out_buf_mem[byte_addr + 2],
                             out_buf_mem[byte_addr + 1],
                             out_buf_mem[byte_addr + 0]};
  endfunction

  function automatic logic [15:0] read_i16_from_out_buf(input int byte_addr);
    read_i16_from_out_buf = {out_buf_mem[byte_addr + 1],
                             out_buf_mem[byte_addr + 0]};
  endfunction

  // Capture ctrl_data_out only when the DUT marks it valid.
  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      ctrl_data_out_shadow <= 32'd0;
    end else if (ctrl_data_out_ap_vld) begin
      ctrl_data_out_shadow <= ctrl_data_out;
    end
  end

  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      dbg_compute_ready_lat <= 1'b0;
      dbg_compute_done_lat  <= 1'b0;
    end else begin
      if (dbg_compute_ready_ap_vld) begin
        dbg_compute_ready_lat <= dbg_compute_ready;
      end
      if (dbg_compute_done_ap_vld) begin
        dbg_compute_done_lat <= dbg_compute_done;
      end
    end
  end

  // Simple BRAM model for compute controller buffers
  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      in_buf_q0 <= '0;
      in_buf_q1 <= '0;
    end else begin
      if (in_buf_ce0) begin
        in_buf_q0 <= in_buf_mem[in_buf_address0];
      end
      if (in_buf_ce1) begin
        in_buf_q1 <= in_buf_mem[in_buf_address1];
      end
      if (out_buf_ce0 && out_buf_we0) begin
        out_buf_mem[out_buf_address0] <= out_buf_d0;
      end
      if (out_buf_ce1 && out_buf_we1) begin
        out_buf_mem[out_buf_address1] <= out_buf_d1;
      end
    end
  end

  // Memory controller respond (mirrors compute_controller_tb.sv)
  always_ff @(posedge ap_clk) begin : MEM_controller_respond
    if (ap_rst) begin
      mem_transfer_done <= 1'b0;
      mem_busy <= 1'b0;
      mem_timer <= 0;
      mem_pending <= MEM_NONE;
      pending_tile <= 0;
      mem_done_hold <= 0;
    end else begin
      mem_transfer_done <= (mem_done_hold != 0);
      if (mem_done_hold != 0) begin
        mem_done_hold <= mem_done_hold - 1;
      end

      if (mem_busy) begin
        if (mem_timer == 0) begin
          mem_transfer_done <= 1'b1;
          mem_done_hold <= 2;
          mem_busy <= 1'b0;
          if (mem_pending == MEM_READ) begin
            int out_base;
            int t;
            int j;
            int layer_off;
            layer_off = mem_op[15:8] * 2;
            for (j = 0; j < IN_BUF_BYTES; j = j + 1) begin
              in_buf_mem[j] = 8'd0;
            end

            case (mem_op[7:0])
              CMP_OUT_PROJ: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[OUT_PROJ_ACT_OFFSET + j] = full_valueA[j] + layer_off;
                end
                if ((pending_tile >= 0) && (pending_tile < NUM_WO_TILES)) begin
                  out_base = pending_tile * D_TILE_WO;
                  for (t = 0; t < D_TILE_WO; t = t + 1) begin
                    for (j = 0; j < D_MODEL; j = j + 1) begin
                      write_i4_to_in_buf(
                        (OUT_PROJ_W_OFFSET * 2) + (t * D_MODEL) + j,
                        full_weights[(out_base + t) * D_MODEL + j] + layer_off);
                    end
                  end
                  for (t = 0; t < D_TILE_WO; t = t + 1) begin
                    write_i32_to_in_buf(
                      OUT_PROJ_B_OFFSET + (t * 4),
                      full_bias[out_base + t] + layer_off);
                  end
                end
              end
              CMP_REQUANT1: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  write_i32_to_in_buf(REQUANT_X_OFFSET + (j * 4), rq1_x[j] + layer_off);
                end
                write_i32_to_in_buf(REQUANT_M_OFFSET, rq1_M + layer_off);
                write_i32_to_in_buf(REQUANT_N_OFFSET, rq1_N + layer_off);
                write_i32_to_in_buf(REQUANT_Z_OFFSET, rq1_Z + layer_off);
              end
              CMP_REQUANT2: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  write_i32_to_in_buf(REQUANT_X_OFFSET + (j * 4), rq2_x[j] + layer_off);
                end
                write_i32_to_in_buf(REQUANT_M_OFFSET, rq2_M + layer_off);
                write_i32_to_in_buf(REQUANT_N_OFFSET, rq2_N + layer_off);
                write_i32_to_in_buf(REQUANT_Z_OFFSET, rq2_Z + layer_off);
              end
              CMP_REQUANT3: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  write_i32_to_in_buf(REQUANT_X_OFFSET + (j * 4), rq3_x[j] + layer_off);
                end
                write_i32_to_in_buf(REQUANT_M_OFFSET, rq3_M + layer_off);
                write_i32_to_in_buf(REQUANT_N_OFFSET, rq3_N + layer_off);
                write_i32_to_in_buf(REQUANT_Z_OFFSET, rq3_Z + layer_off);
              end
              CMP_REQUANT4: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  write_i32_to_in_buf(REQUANT_X_OFFSET + (j * 4), rq4_x[j] + layer_off);
                end
                write_i32_to_in_buf(REQUANT_M_OFFSET, rq4_M + layer_off);
                write_i32_to_in_buf(REQUANT_N_OFFSET, rq4_N + layer_off);
                write_i32_to_in_buf(REQUANT_Z_OFFSET, rq4_Z + layer_off);
              end
              CMP_RESID0: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[RESID_X_OFFSET + j] = resid0_x[j] + layer_off;
                  in_buf_mem[RESID_R_OFFSET + j] = resid0_r[j] + layer_off;
                end
              end
              CMP_RESID1: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[RESID_X_OFFSET + j] = resid1_x[j] + layer_off;
                  in_buf_mem[RESID_R_OFFSET + j] = resid1_r[j] + layer_off;
                end
              end
              CMP_LN0: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[LN_X_OFFSET + j] = ln0_x[j] + layer_off;
                  write_i32_to_in_buf(LN_GAMMA_OFFSET + (j * 4), ln0_gamma[j] + layer_off);
                end
                write_i32_to_in_buf(LN_EPS_OFFSET, ln0_eps + layer_off);
              end
              CMP_LN1: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[LN_X_OFFSET + j] = ln1_x[j] + layer_off;
                  write_i32_to_in_buf(LN_GAMMA_OFFSET + (j * 4), ln1_gamma[j] + layer_off);
                end
                write_i32_to_in_buf(LN_EPS_OFFSET, ln1_eps + layer_off);
              end
              CMP_FINAL_NORM: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[LN_X_OFFSET + j] = final_norm_x[j];
                  write_i32_to_in_buf(LN_GAMMA_OFFSET + (j * 4), final_norm_gamma[j]);
                end
                write_i32_to_in_buf(LN_EPS_OFFSET, final_norm_eps);
              end
              CMP_FFN_W1: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[FFN_W1_X_OFFSET + j] = ffn1_x[j] + layer_off;
                end
                if ((pending_tile >= 0) && (pending_tile < NUM_W1_TILES)) begin
                  out_base = pending_tile * D_TILE_W1;
                  for (t = 0; t < D_TILE_W1; t = t + 1) begin
                    for (j = 0; j < D_MODEL; j = j + 1) begin
                      write_i4_to_in_buf(
                        (FFN_W1_W_OFFSET * 2) + (t * D_MODEL) + j,
                        ffn1_w[(out_base + t) * D_MODEL + j] + layer_off);
                    end
                  end
                  for (t = 0; t < D_TILE_W1; t = t + 1) begin
                    write_i32_to_in_buf(
                      FFN_W1_B_OFFSET + (t * 4),
                      ffn1_b[out_base + t] + layer_off);
                    write_i16_to_in_buf(
                      FFN_W1_S_OFFSET + (t * 2),
                      ffn1_s[out_base + t] + layer_off);
                  end
                end
              end
              CMP_FFN_ACT: begin
                for (j = 0; j < D_FFN; j = j + 1) begin
                  write_i16_to_in_buf(FFN_ACT_X_OFFSET + (j * 2), ffn_act_in[j] + layer_off);
                end
              end
              CMP_FFN_W2: begin
                for (j = 0; j < D_FFN; j = j + 1) begin
                  write_i16_to_in_buf(FFN_W2_X_OFFSET + (j * 2), ffn2_x[j] + layer_off);
                end
                if ((pending_tile >= 0) && (pending_tile < NUM_W2_TILES)) begin
                  out_base = pending_tile * D_TILE_W2;
                  for (t = 0; t < D_TILE_W2; t = t + 1) begin
                    for (j = 0; j < D_FFN; j = j + 1) begin
                      write_i4_to_in_buf(
                        (FFN_W2_W_OFFSET * 2) + (t * D_FFN) + j,
                        ffn2_w[(out_base + t) * D_FFN + j] + layer_off);
                    end
                  end
                  for (t = 0; t < D_TILE_W2; t = t + 1) begin
                    write_i32_to_in_buf(
                      FFN_W2_B_OFFSET + (t * 4),
                      ffn2_b[out_base + t] + layer_off);
                    write_i16_to_in_buf(
                      FFN_W2_S_OFFSET + (t * 2),
                      ffn2_s[out_base + t] + layer_off);
                  end
                end
              end
              default: begin
              end
            endcase
          end else if (mem_pending == MEM_WRITE) begin
            int out_base;
            int t;
            case (mem_op[7:0])
              CMP_OUT_PROJ: begin
                if ((pending_tile >= 0) && (pending_tile < NUM_WO_TILES)) begin
                  out_base = pending_tile * D_TILE_WO;
                  for (t = 0; t < D_TILE_WO; t = t + 1) begin
                    full_accum[out_base + t] <= read_i32_from_out_buf(t * 4);
                  end
                end
              end
              CMP_REQUANT1: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  rq1_out[t] <= out_buf_mem[t];
                end
              end
              CMP_REQUANT2: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  rq2_out[t] <= out_buf_mem[t];
                end
              end
              CMP_REQUANT3: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  rq3_out[t] <= out_buf_mem[t];
                end
              end
              CMP_REQUANT4: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  rq4_out[t] <= out_buf_mem[t];
                end
              end
              CMP_RESID0: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  resid0_out[t] <= out_buf_mem[t];
                end
              end
              CMP_RESID1: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  resid1_out[t] <= out_buf_mem[t];
                end
              end
              CMP_LN0: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  ln0_out[t] <= read_i32_from_out_buf(t * 4);
                end
              end
              CMP_LN1: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  ln1_out[t] <= read_i32_from_out_buf(t * 4);
                end
              end
              CMP_FINAL_NORM: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  final_norm_out[t] <= read_i32_from_out_buf(t * 4);
                end
              end
              CMP_FFN_W1: begin
                if ((pending_tile >= 0) && (pending_tile < NUM_W1_TILES)) begin
                  out_base = pending_tile * D_TILE_W1;
                  for (t = 0; t < D_TILE_W1; t = t + 1) begin
                    ffn1_out[out_base + t] <= read_i16_from_out_buf(t * 2);
                  end
                end
              end
              CMP_FFN_ACT: begin
                for (t = 0; t < D_FFN; t = t + 1) begin
                  ffn_act_out[t] <= read_i16_from_out_buf(t * 2);
                end
              end
              CMP_FFN_W2: begin
                if ((pending_tile >= 0) && (pending_tile < NUM_W2_TILES)) begin
                  out_base = pending_tile * D_TILE_W2;
                  for (t = 0; t < D_TILE_W2; t = t + 1) begin
                    ffn2_out[out_base + t] <= read_i32_from_out_buf(t * 4);
                  end
                end
              end
              default: begin
              end
            endcase
          end
          mem_pending <= MEM_NONE;
        end else begin
          mem_timer <= mem_timer - 1;
        end
      end else begin
        if (mem_read_request && mem_read_request_ap_vld) begin
          mem_busy <= 1'b1;
          mem_timer <= MEM_LAT - 1;
          mem_pending <= MEM_READ;
          pending_tile <= mem_op[31:24];
        end else if (mem_write_request && mem_write_request_ap_vld) begin
          mem_busy <= 1'b1;
          mem_timer <= MEM_LAT - 1;
          mem_pending <= MEM_WRITE;
          pending_tile <= mem_op[31:24];
        end
      end
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

  // DMA model: honor DUT wl_start_o and return dma_done after a small latency
  always_ff @(posedge ap_clk) begin : dma_model
    int dma_lat_var;
    if (ap_rst) begin
      dma_busy  <= 1'b0;
      dma_timer <= 0;
      dma_done  <= 1'b0;
      dma_done_hold <= 1'b0;
      dma_done_ctr  <= 0;
      wl_ready <= 1'b0;
    end else begin
      dma_done <= 1'b0;
      wl_ready <= (!dma_busy) && !(wl_start_o && wl_start_o_ap_vld);
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
      if (wl_start_o && wl_start_o_ap_vld && wl_instruction_ap_vld && !dma_busy) begin
        dma_busy  <= 1'b1;
        dma_lat_var = rand_dma_lat();
        dma_timer <= (dma_lat_var > 0) ? dma_lat_var - 1 : 0;
        wl_ready <= 1'b0;
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
    t0.wl_ready      = !head_dma_inflight[0] && !head_wl_stall[0] && !head_ctx_ref_0_struct.wl_start;
    t1.wl_ready      = !head_dma_inflight[1] && !head_wl_stall[1] && !head_ctx_ref_1_struct.wl_start;
    t2.wl_ready      = !head_dma_inflight[2] && !head_wl_stall[2] && !head_ctx_ref_2_struct.wl_start;
    t3.wl_ready      = !head_dma_inflight[3] && !head_wl_stall[3] && !head_ctx_ref_3_struct.wl_start;
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
            wl_instruction: 32'd0,
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
            k_writeback_started: 1'b0,
            v_requant_started: 1'b0,
            v_writeback_started: 1'b0,
            requant_q_started: 1'b0,
            head_requant_started: 1'b0,
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
            head_requant_compute_done: 1'b0,
            q_dma_done: 1'b0,
            k_dma_done: 1'b0,
            k_writeback_dma_done: 1'b0,
            v_dma_done: 1'b0,
            v_writeback_dma_done: 1'b0,
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
          head_wl_stall[hh] <= 1'b0;
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
          if (hh == 0) begin
            compute_start_now = head_ctx_ref_0_struct.compute_start;
            dma_start_now     = head_ctx_ref_0_struct.wl_start;
          end else if (hh == 1) begin
            compute_start_now = head_ctx_ref_1_struct.compute_start;
            dma_start_now     = head_ctx_ref_1_struct.wl_start;
          end else if (hh == 2) begin
            compute_start_now = head_ctx_ref_2_struct.compute_start;
            dma_start_now     = head_ctx_ref_2_struct.wl_start;
          end else if (hh == 3) begin
            compute_start_now = head_ctx_ref_3_struct.compute_start;
            dma_start_now     = head_ctx_ref_3_struct.wl_start;
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
            head_wl_stall[hh] <= 1'b1;
          end else if (head_dma_inflight[hh]) begin
            if (head_dma_ctr[hh] == 0) begin
              head_dma_inflight[hh] <= 1'b0;
              head_dma_done_hold[hh] <= 1'b1;
            head_dma_done_ctr[hh] <= 7'd100;
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
          if (head_dma_done[hh]) begin
            head_wl_stall[hh] <= 1'b0;
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
    wl_start_i = 1'b0;
    start_pulsed = 1'b0;
    pending_start_clear = 1'b0;
    reset_low_written = 1'b0;
    reset_released = 1'b0;
    seen_done = 1'b0;
    post_done_cycles = 0;
    seen_idle_after = 1'b0;
    seen_concat = 1'b0;
    idle_after_done = 0;
    irq_inference_done = 0;
    seen_irq_done = 1'b0;
    irq_interupt_flagged = 1'b0;
    interupt_data = 32'd0;

    // Print header
    $display("%-8s %-6s %-6s %-8s | %-12s | %-6s %-6s %-8s | %-8s %-8s | %-8s %-8s %-8s %-10s",
             "Cycle", "Start", "Reset", "Busy", "State",
             "AXIS_v", "AXIS_r", "AXIS_last",
             "WLStart", "DMA_Done",
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
      
      if (wl_start_o && wl_start_o_ap_vld && (dbg_state == 32'd6)) begin
        seen_concat <= 1'b1;
      end

      // Print state
      $display("%-8d %-6s %-6s %-8s | %-12s | %-6s %-6s %-8s | %-8s %-8s | %-8s %-8s %-8s 0x%08h",
               cycle,
               (ctrl_shadow_control[1]) ? "1" : "-",
               (ctrl_shadow_control[0]) ? "1" : "-",
               "-" ,
               state_name(dbg_state),
               axis_in_valid ? "1" : "-",
               axis_in_ready ? "1" : "-",
               axis_in_last ? "1" : "-",
               wl_start_o ? "1" : "-",
               dma_done ? "1" : "-",
               dbg_compute_start ? "1" : "-",
               dbg_compute_ready_lat ? "1" : "-",
               dbg_compute_done_lat ? "1" : "-",
               dbg_compute_instruction);
      
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
      $display("ERROR: CONCAT DMA request never issued");
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
      32'd3:  return "S_LAYER_NORM_0";
      32'd4:  return "S_REQUANT1";
      32'd5:  return "S_ATTENTION_HEADS";
      32'd6:  return "S_HEAD_CONCAT";
      32'd7:  return "S_OUT_PROJECTION";
      32'd8:  return "S_REQUANT2";
      32'd9:  return "S_RES_ADD_1";
      32'd10: return "S_LAYER_NORM_1";
      32'd11: return "S_REQUANT3";
      32'd12: return "S_FFN";
      32'd13: return "S_REQUANT4";
      32'd14: return "S_RES_ADD_2";
      32'd15: return "S_LOOP_CHECK";
      32'd16: return "S_FINAL_NORM";
      32'd17: return "S_STREAM_OUT";
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
      8'd11: return "HEAD_RQ";
      8'd12: return "RESV";
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
      8'd25: return "FINAL_NORM";
      8'd26: return "DEQUANT";
      8'd27: return "LOGITS";
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
    .wl_ready(wl_ready),
    .wl_start_i(wl_start_i),
    .wl_start_o(wl_start_o),
    .wl_start_o_ap_vld(wl_start_o_ap_vld),
    .wl_instruction(wl_instruction),
    .wl_instruction_ap_vld(wl_instruction_ap_vld),
    .mem_transfer_done(mem_transfer_done),
    .mem_read_request(mem_read_request),
    .mem_read_request_ap_vld(mem_read_request_ap_vld),
    .mem_write_request(mem_write_request),
    .mem_write_request_ap_vld(mem_write_request_ap_vld),
    .mem_op(mem_op),
    .mem_op_ap_vld(mem_op_ap_vld),
    .in_buf_address0(in_buf_address0),
    .in_buf_ce0(in_buf_ce0),
    .in_buf_q0(in_buf_q0),
    .in_buf_address1(in_buf_address1),
    .in_buf_ce1(in_buf_ce1),
    .in_buf_q1(in_buf_q1),
    .out_buf_address0(out_buf_address0),
    .out_buf_ce0(out_buf_ce0),
    .out_buf_we0(out_buf_we0),
    .out_buf_d0(out_buf_d0),
    .out_buf_address1(out_buf_address1),
    .out_buf_ce1(out_buf_ce1),
    .out_buf_we1(out_buf_we1),
    .out_buf_d1(out_buf_d1),
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
    .dbg_compute_start(dbg_compute_start),
    .dbg_compute_start_ap_vld(dbg_compute_start_ap_vld),
    .dbg_compute_instruction(dbg_compute_instruction),
    .dbg_compute_instruction_ap_vld(dbg_compute_instruction_ap_vld),
    .dbg_compute_ready(dbg_compute_ready),
    .dbg_compute_ready_ap_vld(dbg_compute_ready_ap_vld),
    .dbg_compute_done(dbg_compute_done),
    .dbg_compute_done_ap_vld(dbg_compute_done_ap_vld),
    .dbg_compute_state(dbg_compute_state),
    .dbg_compute_state_ap_vld(dbg_compute_state_ap_vld),
    .dbg_req_instruction(dbg_req_instruction),
    .dbg_req_instruction_ap_vld(dbg_req_instruction_ap_vld),
    .dbg_req_op(dbg_req_op),
    .dbg_req_op_ap_vld(dbg_req_op_ap_vld),
    .dbg_req_layer(dbg_req_layer),
    .dbg_req_layer_ap_vld(dbg_req_layer_ap_vld),
    .dbg_req_head(dbg_req_head),
    .dbg_req_head_ap_vld(dbg_req_head_ap_vld),
    .dbg_req_tile(dbg_req_tile),
    .dbg_req_tile_ap_vld(dbg_req_tile_ap_vld),
    .dbg_mac_start(dbg_mac_start),
    .dbg_mac_start_ap_vld(dbg_mac_start_ap_vld),
    .dbg_mac_ready(dbg_mac_ready),
    .dbg_mac_ready_ap_vld(dbg_mac_ready_ap_vld),
    .dbg_mac_complete(dbg_mac_complete),
    .dbg_mac_complete_ap_vld(dbg_mac_complete_ap_vld),
    .dbg_ctrl_reset_asserted(dbg_ctrl_reset_asserted),
    .dbg_ctrl_reset_asserted_ap_vld(dbg_ctrl_reset_asserted_ap_vld),
    .dbg_ctrl_mem(dbg_ctrl_mem),
    .dbg_ctrl_mem_ap_vld(dbg_ctrl_mem_ap_vld),
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
    .dbg_done(dbg_done),
    .dbg_done_ap_vld(dbg_done_ap_vld),
    .dbg_error(dbg_error),
    .dbg_error_ap_vld(dbg_error_ap_vld)
  );

endmodule
