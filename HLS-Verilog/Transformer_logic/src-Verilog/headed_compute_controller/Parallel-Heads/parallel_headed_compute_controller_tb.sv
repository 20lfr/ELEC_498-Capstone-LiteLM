`timescale 1ns/1ps

module parallel_headed_compute_controller_tb;

  // Parameters (match top_params.hpp)
  localparam int NUM_HEADS       = 4;
  localparam int NUM_LAYERS      = 2;
  localparam int NUM_WO_TILES    = 4;
  localparam int NUM_W1_TILES    = 4;
  localparam int NUM_W2_TILES    = 4;
  localparam int NUM_LOGIT_TILES = 2;

  localparam int D_MODEL = 16;
  localparam int D_FFN   = 22;
  localparam int D_HEADS = D_MODEL / NUM_HEADS;
  localparam int CONTEXT_LENGTH = 16;
  localparam int HEADS_PARALLEL = 2;
  localparam int HEAD_VECTOR_MAX = max2(D_MODEL, max2(D_HEADS, CONTEXT_LENGTH));
  localparam int HEAD_ACCUM_MAX  = max2(D_HEADS, CONTEXT_LENGTH);

  localparam int CLK_PERIOD = 10;
  localparam int MAX_CYCLES = 20000;

  function automatic int max2(input int a, input int b);
    max2 = (a > b) ? a : b;
  endfunction

  // QKV layout sizes (mirrors top_params.hpp)
  localparam int QKV_W_NIBBLES = D_MODEL * D_HEADS;
  localparam int QKV_W_BYTES   = (QKV_W_NIBBLES + 1) / 2;
  localparam int QKV_B_NIBBLES = D_HEADS;
  localparam int QKV_B_BYTES   = (QKV_B_NIBBLES + 1) / 2;
  localparam int QKV_IN_BYTES  = D_MODEL + QKV_W_BYTES + QKV_B_BYTES;
  localparam int QKV_OUT_BYTES = D_HEADS * 4;

  localparam int HEAD_REQUANT_IN_BYTES  = (D_HEADS * 4) + 12;
  localparam int HEAD_REQUANT_OUT_BYTES = D_HEADS;

  localparam int ATT_SCORES_IN_BYTES  = D_HEADS + (CONTEXT_LENGTH * D_HEADS);
  localparam int ATT_SCORES_OUT_BYTES = CONTEXT_LENGTH * 4;

  localparam int VALUE_SCALE_IN_BYTES  = CONTEXT_LENGTH * 4;
  localparam int VALUE_SCALE_OUT_BYTES = CONTEXT_LENGTH * 2;

  localparam int SOFTMAX_IN_BYTES  = CONTEXT_LENGTH * 2;
  localparam int SOFTMAX_OUT_BYTES = CONTEXT_LENGTH * 2;

  localparam int ATT_VALUE_IN_BYTES  = CONTEXT_LENGTH + (CONTEXT_LENGTH * D_HEADS);
  localparam int ATT_VALUE_OUT_BYTES = D_HEADS * 4;

  localparam int IN_BUF_BYTES = max2(QKV_IN_BYTES,
                           max2(HEAD_REQUANT_IN_BYTES,
                           max2(ATT_SCORES_IN_BYTES,
                           max2(VALUE_SCALE_IN_BYTES,
                           max2(SOFTMAX_IN_BYTES, ATT_VALUE_IN_BYTES)))));

  localparam int OUT_BUF_BYTES = max2(QKV_OUT_BYTES,
                            max2(HEAD_REQUANT_OUT_BYTES,
                            max2(ATT_SCORES_OUT_BYTES,
                            max2(VALUE_SCALE_OUT_BYTES,
                            max2(SOFTMAX_OUT_BYTES, ATT_VALUE_OUT_BYTES)))));

  localparam int IN_BUF_TOTAL  = IN_BUF_BYTES * HEADS_PARALLEL;
  localparam int OUT_BUF_TOTAL = OUT_BUF_BYTES * HEADS_PARALLEL;

  localparam int IN_BUF_ADDR_W  = (IN_BUF_TOTAL > 1) ? $clog2(IN_BUF_TOTAL) : 1;
  localparam int OUT_BUF_ADDR_W = (OUT_BUF_TOTAL > 1) ? $clog2(OUT_BUF_TOTAL) : 1;
  localparam int DBG_HEAD_VEC_ELEMS = HEADS_PARALLEL * HEAD_VECTOR_MAX;
  localparam int DBG_HEAD_OUT_ELEMS = HEADS_PARALLEL * HEAD_ACCUM_MAX;
  localparam int DBG_HEAD_VEC_ADDR_W = (DBG_HEAD_VEC_ELEMS > 1) ? $clog2(DBG_HEAD_VEC_ELEMS) : 1;
  localparam int DBG_HEAD_OUT_ADDR_W = (DBG_HEAD_OUT_ELEMS > 1) ? $clog2(DBG_HEAD_OUT_ELEMS) : 1;

  // Layout offsets (mirrors head_buf in top_params.hpp)
  localparam int QKV_ACT_OFFSET = 0;
  localparam int QKV_W_OFFSET   = QKV_ACT_OFFSET + D_MODEL;
  localparam int QKV_B_OFFSET   = QKV_W_OFFSET + QKV_W_BYTES;

  localparam int HEAD_RQ_X_OFFSET = 0;
  localparam int HEAD_RQ_M_OFFSET = HEAD_RQ_X_OFFSET + (D_HEADS * 4);
  localparam int HEAD_RQ_N_OFFSET = HEAD_RQ_M_OFFSET + 4;
  localparam int HEAD_RQ_Z_OFFSET = HEAD_RQ_N_OFFSET + 4;

  localparam int ATT_SCORES_Q_OFFSET      = 0;
  localparam int ATT_SCORES_KCACHE_OFFSET = ATT_SCORES_Q_OFFSET + D_HEADS;

  localparam int VALUE_SCALE_X_OFFSET = 0;
  localparam int SOFTMAX_X_OFFSET     = 0;

  localparam int ATT_VALUE_W_OFFSET   = 0;
  localparam int ATT_VALUE_V_OFFSET   = ATT_VALUE_W_OFFSET + CONTEXT_LENGTH;

  // Align opcodes with top_params.hpp ComputeOp enum.
  localparam logic [7:0] CMP_Q            = 8'h03;
  localparam logic [7:0] CMP_K            = 8'h04;
  localparam logic [7:0] CMP_K_REQUANT    = 8'h05;
  localparam logic [7:0] CMP_V            = 8'h06;
  localparam logic [7:0] CMP_V_REQUANT    = 8'h07;
  localparam logic [7:0] CMP_REQUANT_Q    = 8'h08;
  localparam logic [7:0] CMP_ATT_SCORES   = 8'h09;
  localparam logic [7:0] CMP_VALUE_SCALE  = 8'h0A;
  localparam logic [7:0] CMP_SOFTMAX      = 8'h0B;
  localparam logic [7:0] CMP_ATT_VALUE    = 8'h0C;
  localparam logic [7:0] CMP_HEAD_REQUANT = 8'h0D;

  // ComputeHeadCtx packed layout (LSB first)
  localparam int CTX_STATE_LSB = 0;
  localparam int CTX_STATE_MSB = 7;
  localparam int CTX_REQ_INSTR_LSB = 8;
  localparam int CTX_REQ_INSTR_MSB = 39;
  localparam int CTX_REQ_OP_LSB = 40;
  localparam int CTX_REQ_OP_MSB = 47;
  localparam int CTX_REQ_LAYER_LSB = 48;
  localparam int CTX_REQ_LAYER_MSB = 55;
  localparam int CTX_REQ_HEAD_LSB = 56;
  localparam int CTX_REQ_HEAD_MSB = 63;
  localparam int CTX_REQ_TILE_LSB = 64;
  localparam int CTX_REQ_TILE_MSB = 71;
  localparam int CTX_MAC_BUSY = 72;
  localparam int CTX_MAC_READY = 73;
  localparam int CTX_MAC_COMPLETE = 74;
  localparam int CTX_CLEAR_PENDING = 75;
  localparam int CTX_CAPTURE_PENDING = 76;
  localparam int CTX_MAC_START = 77;
  localparam int CTX_ERROR_LATCHED = 78;
  localparam int CTX_COMPUTE_START = 79;
  localparam int CTX_COMP_INSTR_LSB = 80;
  localparam int CTX_COMP_INSTR_MSB = 111;
  localparam int CTX_COMPUTE_READY = 112;
  localparam int CTX_COMPUTE_DONE = 113;
  localparam int CTX_MEM_TRANSFER_DONE = 114;
  localparam int CTX_MEM_READ_REQUEST = 115;
  localparam int CTX_MEM_WRITE_REQUEST = 116;
  localparam int CTX_MEM_OP_LSB = 117;
  localparam int CTX_MEM_OP_MSB = 148;

  typedef struct packed {
    logic [31:0] mem_op;
    logic        mem_write_request;
    logic        mem_read_request;
    logic        mem_transfer_done;
    logic        compute_done;
    logic        compute_ready;
    logic [31:0] comp_instruction;
    logic        compute_start;
    logic        error_latched;
    logic        mac_start;
    logic        capture_pending;
    logic        clear_pending;
    logic        mac_complete;
    logic        mac_ready;
    logic        mac_busy;
    logic [7:0]  req_tile;
    logic [7:0]  req_head;
    logic [7:0]  req_layer;
    logic [7:0]  req_op;
    logic [31:0] req_instruction;
    logic [7:0]  state;
  } ComputeHeadCtx_t;

  // Signals
  logic ap_clk = 1'b0;
  logic ap_rst = 1'b1;
  always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

  localparam int GAP_CYCLES = 20;
  localparam int OP_COUNT = 11;
  int op_index;
  int gap_ctr;

  typedef enum logic [2:0] {
    SETUP      = 3'b000,
    OP_SEND    = 3'b001,
    OP_WAIT    = 3'b010,
    GAP_WAIT   = 3'b011,
    DONE       = 3'b100
  } compute_state_t;
  compute_state_t compute_state = SETUP;

  localparam int RESET_HOLD_CYCLES = 3;
  int reset_hold_ctr;
  localparam int CTX_HOLD_CYCLES = 2;
  int ctx_hold_ctr;
  logic start_pending [0:HEADS_PARALLEL-1];

  localparam int MEM_LAT = 2;
  typedef enum logic [1:0] {
    MEM_NONE  = 2'b00,
    MEM_READ  = 2'b01,
    MEM_WRITE = 2'b10
  } mem_pending_t;
  mem_pending_t mem_pending [0:HEADS_PARALLEL-1];
  logic mem_busy [0:HEADS_PARALLEL-1];
  int mem_timer [0:HEADS_PARALLEL-1];
  int mem_done_hold [0:HEADS_PARALLEL-1];
  logic [31:0] mem_op_latched [0:HEADS_PARALLEL-1];
  logic mem_read_start [0:HEADS_PARALLEL-1];
  logic mem_read_active [0:HEADS_PARALLEL-1];
  int mem_read_idx [0:HEADS_PARALLEL-1];
  logic mem_read_done_pulse [0:HEADS_PARALLEL-1];

  function automatic logic [7:0] op_for_index(input int idx);
    case (idx)
      0:  op_for_index = CMP_Q;
      1:  op_for_index = CMP_K;
      2:  op_for_index = CMP_K_REQUANT;
      3:  op_for_index = CMP_V;
      4:  op_for_index = CMP_V_REQUANT;
      5:  op_for_index = CMP_REQUANT_Q;
      6:  op_for_index = CMP_ATT_SCORES;
      7:  op_for_index = CMP_VALUE_SCALE;
      8:  op_for_index = CMP_SOFTMAX;
      9:  op_for_index = CMP_ATT_VALUE;
      10: op_for_index = CMP_HEAD_REQUANT;
      default: op_for_index = CMP_Q;
    endcase
  endfunction

  function automatic logic [31:0] make_instruction(
    input logic [7:0] op,
    input logic [7:0] layer,
    input logic [7:0] head,
    input logic [7:0] tile
  );
    make_instruction = {tile, head, layer, op};
  endfunction

  // DUT Signals
  logic ap_start;
  logic ap_done;
  logic ap_idle;
  logic ap_ready;
  logic [0:0] reset;

  logic [148:0] ctx_i [0:HEADS_PARALLEL-1];
  wire [148:0]  ctx_o [0:HEADS_PARALLEL-1];
  wire ctx_o_ap_vld [0:HEADS_PARALLEL-1];
  ComputeHeadCtx_t ctx_i_s [0:HEADS_PARALLEL-1];
  ComputeHeadCtx_t ctx_o_s [0:HEADS_PARALLEL-1];
  ComputeHeadCtx_t ctx_shadow [0:HEADS_PARALLEL-1];
  logic ctx_seen [0:HEADS_PARALLEL-1];

  genvar gi;
  generate
    for (gi = 0; gi < HEADS_PARALLEL; gi = gi + 1) begin : ctx_cast
      assign ctx_o_s[gi] = ctx_o[gi];
    end
  endgenerate

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
  logic [DBG_HEAD_VEC_ADDR_W-1:0] dbg_head_vec_address0;
  logic dbg_head_vec_ce0;
  logic dbg_head_vec_we0;
  logic [7:0] dbg_head_vec_d0;
  logic [DBG_HEAD_OUT_ADDR_W-1:0] dbg_head_out_address0;
  logic dbg_head_out_ce0;
  logic dbg_head_out_we0;
  logic [31:0] dbg_head_out_d0;
  logic [0:0] error;
  logic error_ap_vld;

  // Per-head input datasets (flattened: head-major)
  localparam int QKV_W_ELEMS = D_MODEL * D_HEADS;
  localparam int QKV_B_ELEMS = D_HEADS;
  localparam int ATT_K_ELEMS = CONTEXT_LENGTH * D_HEADS;
  localparam int ATT_V_ELEMS = CONTEXT_LENGTH * D_HEADS;

  logic signed [7:0] q_act_all [0:(HEADS_PARALLEL*D_MODEL)-1];
  logic signed [7:0] k_act_all [0:(HEADS_PARALLEL*D_MODEL)-1];
  logic signed [7:0] v_act_all [0:(HEADS_PARALLEL*D_MODEL)-1];
  logic signed [3:0] wq_all [0:(HEADS_PARALLEL*QKV_W_ELEMS)-1];
  logic signed [3:0] wk_all [0:(HEADS_PARALLEL*QKV_W_ELEMS)-1];
  logic signed [3:0] wv_all [0:(HEADS_PARALLEL*QKV_W_ELEMS)-1];
  logic signed [3:0] bq_all [0:(HEADS_PARALLEL*QKV_B_ELEMS)-1];
  logic signed [3:0] bk_all [0:(HEADS_PARALLEL*QKV_B_ELEMS)-1];
  logic signed [3:0] bv_all [0:(HEADS_PARALLEL*QKV_B_ELEMS)-1];

  logic signed [31:0] rq_k_x_all [0:(HEADS_PARALLEL*D_HEADS)-1];
  logic signed [31:0] rq_v_x_all [0:(HEADS_PARALLEL*D_HEADS)-1];
  logic signed [31:0] rq_q_x_all [0:(HEADS_PARALLEL*D_HEADS)-1];
  logic signed [31:0] rq_head_x_all [0:(HEADS_PARALLEL*D_HEADS)-1];
  logic signed [31:0] rq_k_M [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_k_N [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_k_Z [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_v_M [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_v_N [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_v_Z [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_q_M [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_q_N [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_q_Z [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_head_M [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_head_N [0:HEADS_PARALLEL-1];
  logic signed [31:0] rq_head_Z [0:HEADS_PARALLEL-1];

  logic signed [7:0] att_q_all [0:(HEADS_PARALLEL*D_HEADS)-1];
  logic signed [7:0] att_k_cache_all [0:(HEADS_PARALLEL*ATT_K_ELEMS)-1];

  logic signed [31:0] val_scale_in_all [0:(HEADS_PARALLEL*CONTEXT_LENGTH)-1];
  logic signed [15:0] softmax_in_all [0:(HEADS_PARALLEL*CONTEXT_LENGTH)-1];

  logic signed [7:0] att_weights_all [0:(HEADS_PARALLEL*CONTEXT_LENGTH)-1];
  logic signed [7:0] att_v_cache_all [0:(HEADS_PARALLEL*ATT_V_ELEMS)-1];

  // Output capture per operation (per head lane)
  logic signed [31:0] q_out [0:HEADS_PARALLEL-1][0:D_HEADS-1];
  logic signed [31:0] k_out [0:HEADS_PARALLEL-1][0:D_HEADS-1];
  logic signed [31:0] v_out [0:HEADS_PARALLEL-1][0:D_HEADS-1];

  logic signed [7:0] k_rq_out [0:HEADS_PARALLEL-1][0:D_HEADS-1];
  logic signed [7:0] v_rq_out [0:HEADS_PARALLEL-1][0:D_HEADS-1];
  logic signed [7:0] q_rq_out [0:HEADS_PARALLEL-1][0:D_HEADS-1];
  logic signed [7:0] head_rq_out [0:HEADS_PARALLEL-1][0:D_HEADS-1];

  logic signed [31:0] att_scores_out [0:HEADS_PARALLEL-1][0:CONTEXT_LENGTH-1];
  logic signed [15:0] val_scale_out [0:HEADS_PARALLEL-1][0:CONTEXT_LENGTH-1];
  logic signed [15:0] softmax_out [0:HEADS_PARALLEL-1][0:CONTEXT_LENGTH-1];
  logic signed [31:0] att_value_out [0:HEADS_PARALLEL-1][0:D_HEADS-1];

  logic [7:0] in_buf_mem [0:IN_BUF_TOTAL-1];
  logic [7:0] out_buf_mem [0:OUT_BUF_TOTAL-1];
  logic [7:0] dbg_head_vec_mem [0:DBG_HEAD_VEC_ELEMS-1];
  logic [31:0] dbg_head_out_mem [0:DBG_HEAD_OUT_ELEMS-1];
  logic [7:0] in_buf_stage [0:HEADS_PARALLEL-1][0:IN_BUF_BYTES-1];

  function automatic int lane_base_in(input int lane);
    lane_base_in = lane * IN_BUF_BYTES;
  endfunction
  function automatic int lane_base_out(input int lane);
    lane_base_out = lane * OUT_BUF_BYTES;
  endfunction
  function automatic int lane_base_dbg_vec(input int lane);
    lane_base_dbg_vec = lane * HEAD_VECTOR_MAX;
  endfunction
  function automatic int lane_base_dbg_out(input int lane);
    lane_base_dbg_out = lane * HEAD_ACCUM_MAX;
  endfunction

  task automatic write_i4_to_in_buf(
    input int lane,
    input int nibble_idx,
    input logic [3:0] value
  );
    int byte_addr;
    int base;
    begin
      base = lane_base_in(lane);
      byte_addr = base + (nibble_idx / 2);
      if ((nibble_idx % 2) != 0) begin
        in_buf_mem[byte_addr] = {value, in_buf_mem[byte_addr][3:0]};
      end else begin
        in_buf_mem[byte_addr] = {in_buf_mem[byte_addr][7:4], value};
      end
    end
  endtask

  task automatic write_i4_to_stage(
    input int lane,
    input int nibble_idx,
    input logic [3:0] value
  );
    int byte_addr;
    begin
      byte_addr = nibble_idx / 2;
      if ((nibble_idx % 2) != 0) begin
        in_buf_stage[lane][byte_addr] = {value, in_buf_stage[lane][byte_addr][3:0]};
      end else begin
        in_buf_stage[lane][byte_addr] = {in_buf_stage[lane][byte_addr][7:4], value};
      end
    end
  endtask

  task automatic write_i32_to_in_buf(
    input int lane,
    input int byte_addr,
    input logic [31:0] value
  );
    int base;
    begin
      base = lane_base_in(lane);
      in_buf_mem[base + byte_addr + 0] = value[7:0];
      in_buf_mem[base + byte_addr + 1] = value[15:8];
      in_buf_mem[base + byte_addr + 2] = value[23:16];
      in_buf_mem[base + byte_addr + 3] = value[31:24];
    end
  endtask

  task automatic write_i32_to_stage(
    input int lane,
    input int byte_addr,
    input logic [31:0] value
  );
    begin
      in_buf_stage[lane][byte_addr + 0] = value[7:0];
      in_buf_stage[lane][byte_addr + 1] = value[15:8];
      in_buf_stage[lane][byte_addr + 2] = value[23:16];
      in_buf_stage[lane][byte_addr + 3] = value[31:24];
    end
  endtask

  task automatic write_i16_to_in_buf(
    input int lane,
    input int byte_addr,
    input logic [15:0] value
  );
    int base;
    begin
      base = lane_base_in(lane);
      in_buf_mem[base + byte_addr + 0] = value[7:0];
      in_buf_mem[base + byte_addr + 1] = value[15:8];
    end
  endtask

  task automatic write_i16_to_stage(
    input int lane,
    input int byte_addr,
    input logic [15:0] value
  );
    begin
      in_buf_stage[lane][byte_addr + 0] = value[7:0];
      in_buf_stage[lane][byte_addr + 1] = value[15:8];
    end
  endtask

  task automatic build_in_buf_image(
    input int lane,
    input logic [7:0] op
  );
    int t;
    int h;
    int base;
    int sign;
    begin
      for (t = 0; t < IN_BUF_BYTES; t = t + 1) begin
        in_buf_stage[lane][t] = 8'd0;
      end

      case (op)
        CMP_Q,
        CMP_K,
        CMP_V: begin
          for (t = 0; t < D_MODEL; t = t + 1) begin
            in_buf_stage[lane][QKV_ACT_OFFSET + t] =
              (op == CMP_Q) ? q_act_all[lane * D_MODEL + t] :
              (op == CMP_K) ? k_act_all[lane * D_MODEL + t] :
              v_act_all[lane * D_MODEL + t];
          end
          for (t = 0; t < (D_MODEL * D_HEADS); t = t + 1) begin
            write_i4_to_stage(lane, (QKV_W_OFFSET * 2) + t,
              (op == CMP_Q) ? wq_all[lane * QKV_W_ELEMS + t] :
              (op == CMP_K) ? wk_all[lane * QKV_W_ELEMS + t] :
              wv_all[lane * QKV_W_ELEMS + t]);
          end
          for (h = 0; h < D_HEADS; h = h + 1) begin
            write_i4_to_stage(lane, (QKV_B_OFFSET * 2) + h,
              (op == CMP_Q) ? bq_all[lane * D_HEADS + h] :
              (op == CMP_K) ? bk_all[lane * D_HEADS + h] :
              bv_all[lane * D_HEADS + h]);
          end
        end
        CMP_K_REQUANT,
        CMP_V_REQUANT,
        CMP_REQUANT_Q,
        CMP_HEAD_REQUANT: begin
          for (h = 0; h < D_HEADS; h = h + 1) begin
            write_i32_to_stage(lane, HEAD_RQ_X_OFFSET + (h * 4),
              (op == CMP_K_REQUANT) ? rq_k_x_all[lane * D_HEADS + h] :
              (op == CMP_V_REQUANT) ? rq_v_x_all[lane * D_HEADS + h] :
              (op == CMP_REQUANT_Q) ? rq_q_x_all[lane * D_HEADS + h] :
              rq_head_x_all[lane * D_HEADS + h]);
          end
          write_i32_to_stage(lane, HEAD_RQ_M_OFFSET,
            (op == CMP_K_REQUANT) ? rq_k_M[lane] :
            (op == CMP_V_REQUANT) ? rq_v_M[lane] :
            (op == CMP_REQUANT_Q) ? rq_q_M[lane] :
            rq_head_M[lane]);
          write_i32_to_stage(lane, HEAD_RQ_N_OFFSET,
            (op == CMP_K_REQUANT) ? rq_k_N[lane] :
            (op == CMP_V_REQUANT) ? rq_v_N[lane] :
            (op == CMP_REQUANT_Q) ? rq_q_N[lane] :
            rq_head_N[lane]);
          write_i32_to_stage(lane, HEAD_RQ_Z_OFFSET,
            (op == CMP_K_REQUANT) ? rq_k_Z[lane] :
            (op == CMP_V_REQUANT) ? rq_v_Z[lane] :
            (op == CMP_REQUANT_Q) ? rq_q_Z[lane] :
            rq_head_Z[lane]);
        end
        CMP_ATT_SCORES: begin
          for (h = 0; h < D_HEADS; h = h + 1) begin
            in_buf_stage[lane][ATT_SCORES_Q_OFFSET + h] =
              att_q_all[lane * D_HEADS + h];
          end
          for (t = 0; t < (CONTEXT_LENGTH * D_HEADS); t = t + 1) begin
            in_buf_stage[lane][ATT_SCORES_KCACHE_OFFSET + t] =
              att_k_cache_all[lane * ATT_K_ELEMS + t];
          end
        end
        CMP_VALUE_SCALE: begin
          for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
            write_i32_to_stage(lane, VALUE_SCALE_X_OFFSET + (t * 4),
              val_scale_in_all[lane * CONTEXT_LENGTH + t]);
          end
        end
        CMP_SOFTMAX: begin
          for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
            write_i16_to_stage(lane, SOFTMAX_X_OFFSET + (t * 2),
              softmax_in_all[lane * CONTEXT_LENGTH + t]);
          end
        end
        CMP_ATT_VALUE: begin
          for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
            in_buf_stage[lane][ATT_VALUE_W_OFFSET + t] =
              att_weights_all[lane * CONTEXT_LENGTH + t];
          end
          for (h = 0; h < D_HEADS; h = h + 1) begin
            for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
              in_buf_stage[lane][ATT_VALUE_V_OFFSET + (h * CONTEXT_LENGTH) + t] =
                att_v_cache_all[lane * ATT_V_ELEMS + (h * CONTEXT_LENGTH) + t];
            end
          end
        end
        default: begin end
      endcase
    end
  endtask

  function automatic logic [31:0] read_i32_from_out_buf(
    input int lane,
    input int byte_addr
  );
    int base;
    begin
      base = lane_base_out(lane);
      read_i32_from_out_buf = {out_buf_mem[base + byte_addr + 3],
                               out_buf_mem[base + byte_addr + 2],
                               out_buf_mem[base + byte_addr + 1],
                               out_buf_mem[base + byte_addr + 0]};
    end
  endfunction

  function automatic logic [15:0] read_i16_from_out_buf(
    input int lane,
    input int byte_addr
  );
    int base;
    begin
      base = lane_base_out(lane);
      read_i16_from_out_buf = {out_buf_mem[base + byte_addr + 1],
                               out_buf_mem[base + byte_addr + 0]};
    end
  endfunction

  task automatic dump_lane_buffers(input int lane);
    int i;
    int base_in;
    int base_out;
    begin
      base_in = lane_base_in(lane);
      base_out = lane_base_out(lane);

      $display("Lane %0d IN_BUF (bytes):", lane);
      for (i = 0; i < IN_BUF_BYTES; i = i + 16) begin
        $write("  %04x:", i);
        for (int j = 0; j < 16 && (i + j) < IN_BUF_BYTES; j = j + 1) begin
          $write(" %02x", in_buf_mem[base_in + i + j]);
        end
        $write("\n");
      end

      $display("Lane %0d OUT_BUF (bytes):", lane);
      for (i = 0; i < OUT_BUF_BYTES; i = i + 16) begin
        $write("  %04x:", i);
        for (int j = 0; j < 16 && (i + j) < OUT_BUF_BYTES; j = j + 1) begin
          $write(" %02x", out_buf_mem[base_out + i + j]);
        end
        $write("\n");
      end
    end
  endtask

  task automatic dump_lane_debug_mirrors(input int lane);
    int i;
    int base_vec;
    int base_out;
    begin
      base_vec = lane_base_dbg_vec(lane);
      base_out = lane_base_dbg_out(lane);

      $display("Lane %0d DBG_HEAD_VEC:", lane);
      for (i = 0; i < HEAD_VECTOR_MAX; i = i + 1) begin
        $write(" %0d", $signed(dbg_head_vec_mem[base_vec + i]));
      end
      $write("\n");

      $display("Lane %0d DBG_HEAD_OUT:", lane);
      for (i = 0; i < HEAD_ACCUM_MAX; i = i + 1) begin
        $write(" %0d", $signed(dbg_head_out_mem[base_out + i]));
      end
      $write("\n");
    end
  endtask

  // Initialize memory contents
  initial begin : init_mem
    int i;
    int t;
    int h;
    int head;
    int sign;
    int base;

    for (head = 0; head < HEADS_PARALLEL; head = head + 1) begin
      for (i = 0; i < D_MODEL; i = i + 1) begin
        q_act_all[head * D_MODEL + i] = (i % 2) ? -$signed(i + 1) : $signed(i + 1);
        k_act_all[head * D_MODEL + i] = (i % 2) ? $signed(i + 3) : -$signed(i + 2);
        v_act_all[head * D_MODEL + i] = $signed((i % 3) - 4);
      end

      for (h = 0; h < D_HEADS; h = h + 1) begin
        for (i = 0; i < D_MODEL; i = i + 1) begin
          wq_all[head * QKV_W_ELEMS + (h * D_MODEL) + i] = (h == 0) ? 4'sd1 : 4'sd3;
          wk_all[head * QKV_W_ELEMS + (h * D_MODEL) + i] = (h == 0) ? -4'sd2 : 4'sd2;
          wv_all[head * QKV_W_ELEMS + (h * D_MODEL) + i] = (i % 2) ? -4'sd3 : 4'sd1;
        end
        bq_all[head * D_HEADS + h] = (h == 0) ? 4'sd3 : -4'sd2;
        bk_all[head * D_HEADS + h] = (h == 0) ? -4'sd1 : 4'sd2;
        bv_all[head * D_HEADS + h] = (h % 2) ? -4'sd3 : 4'sd4;

        rq_q_x_all[head * D_HEADS + h]    = 40 + (h * 5);
        rq_k_x_all[head * D_HEADS + h]    = -30 - (h * 7);
        rq_v_x_all[head * D_HEADS + h]    = 15 + (h * 11);
        rq_head_x_all[head * D_HEADS + h] = (h % 2) ? (-20 - h) : (20 + h);

        att_q_all[head * D_HEADS + h] = (h % 2) ? -6 : 5;
      end

      rq_q_M[head] = 32'd3; rq_q_N[head] = 32'd3; rq_q_Z[head] = 32'd0;
      rq_k_M[head] = 32'd3; rq_k_N[head] = 32'd3; rq_k_Z[head] = 32'd0;
      rq_v_M[head] = 32'd3; rq_v_N[head] = 32'd3; rq_v_Z[head] = 32'd0;
      rq_head_M[head] = 32'd3; rq_head_N[head] = 32'd3; rq_head_Z[head] = 32'd0;

      for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
        sign = (t % 2) ? -1 : 1;
        for (h = 0; h < D_HEADS; h = h + 1) begin
          att_k_cache_all[head * ATT_K_ELEMS + (t * D_HEADS) + h] = sign * (t + h + 1);
        end
        val_scale_in_all[head * CONTEXT_LENGTH + t] = (t % 7) * 37 - 90;
        softmax_in_all[head * CONTEXT_LENGTH + t] = -1200 + (t * 95);
        att_weights_all[head * CONTEXT_LENGTH + t] = ((t % 5) - 2) * 15;
      end

      for (h = 0; h < D_HEADS; h = h + 1) begin
        for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
          base = (t % 4) - 1;
          att_v_cache_all[head * ATT_V_ELEMS + (h * CONTEXT_LENGTH) + t] = (h + 2) * base;
        end
      end
    end

    $display("Q_ACT:");
    for (head = 0; head < HEADS_PARALLEL; head = head + 1) begin
      $write("head %0d: ", head);
      for (i = 0; i < D_MODEL; i = i + 1) begin
        $write("%0d", q_act_all[head * D_MODEL + i]);
        if (i < D_MODEL - 1) $write(", ");
      end
      $write("\n");
    end

    $display("K_ACT:");
    for (head = 0; head < HEADS_PARALLEL; head = head + 1) begin
      $write("head %0d: ", head);
      for (i = 0; i < D_MODEL; i = i + 1) begin
        $write("%0d", k_act_all[head * D_MODEL + i]);
        if (i < D_MODEL - 1) $write(", ");
      end
      $write("\n");
    end

    $display("V_ACT:");
    for (head = 0; head < HEADS_PARALLEL; head = head + 1) begin
      $write("head %0d: ", head);
      for (i = 0; i < D_MODEL; i = i + 1) begin
        $write("%0d", v_act_all[head * D_MODEL + i]);
        if (i < D_MODEL - 1) $write(", ");
      end
      $write("\n");
    end

    for (i = 0; i < IN_BUF_TOTAL; i = i + 1) begin
      in_buf_mem[i] = 8'd0;
    end
    for (i = 0; i < OUT_BUF_TOTAL; i = i + 1) begin
      out_buf_mem[i] = 8'd0;
    end
    for (i = 0; i < DBG_HEAD_VEC_ELEMS; i = i + 1) begin
      dbg_head_vec_mem[i] = 8'd0;
    end
    for (i = 0; i < DBG_HEAD_OUT_ELEMS; i = i + 1) begin
      dbg_head_out_mem[i] = 32'd0;
    end
  end

  // Memory model
  always_ff @(posedge ap_clk) begin : buffer_mem_model
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
      if (dbg_head_vec_ce0 && dbg_head_vec_we0) begin
        dbg_head_vec_mem[dbg_head_vec_address0] <= dbg_head_vec_d0;
      end
      if (dbg_head_out_ce0 && dbg_head_out_we0) begin
        dbg_head_out_mem[dbg_head_out_address0] <= dbg_head_out_d0;
      end
    end
  end

  // Feed ctx_i from ctx_o, overriding input-only fields per lane.
  logic [7:0] curr_op;
  logic [7:0] tile_field;
  logic [7:0] layer_field;
  logic mem_transfer_done_lane [0:HEADS_PARALLEL-1];

  always_comb begin
    curr_op = op_for_index(op_index);
    tile_field = 8'hFF;   // -1 in signed
    layer_field = 8'h00;
    for (int lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
      if (ap_rst) begin
        ctx_i[lane] = '0;
        ctx_i_s[lane] = '0;
      end else begin
        ctx_i_s[lane] = ctx_shadow[lane];
        ctx_i_s[lane].compute_start = start_pending[lane];
        ctx_i_s[lane].comp_instruction =
          make_instruction(curr_op, layer_field, lane[7:0], tile_field);
        ctx_i_s[lane].mem_transfer_done = mem_transfer_done_lane[lane];
        ctx_i[lane] = ctx_i_s[lane];
      end
    end
  end

  // Latch ctx output when valid; hold last value otherwise.
  always_ff @(posedge ap_clk) begin : ctx_shadow_latch
    int lane;
    if (ap_rst) begin
      for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
        ctx_shadow[lane] <= '0;
        ctx_seen[lane] <= 1'b0;
      end
    end else begin
      for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
        if (ctx_o_ap_vld[lane] && (ctx_hold_ctr >= CTX_HOLD_CYCLES)) begin
          ctx_shadow[lane] <= ctx_o_s[lane];
          ctx_seen[lane] <= 1'b1;
        end
      end
    end
  end

  // Track memory handshakes per lane (writeback + request capture)
  always_ff @(posedge ap_clk) begin : mem_handshake
    int lane;
    int t;
    int h;
    if (ap_rst) begin
      for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
        mem_pending[lane] <= MEM_NONE;
        mem_busy[lane] <= 1'b0;
        mem_timer[lane] <= 0;
        mem_done_hold[lane] <= 0;
        mem_transfer_done_lane[lane] <= 1'b0;
        mem_op_latched[lane] <= 32'd0;
        mem_read_start[lane] <= 1'b0;
      end
    end else begin
      for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
        mem_transfer_done_lane[lane] <= 1'b0;
        mem_read_start[lane] <= 1'b0;
        if (mem_done_hold[lane] > 0) begin
          mem_transfer_done_lane[lane] <= 1'b1;
          mem_done_hold[lane] <= mem_done_hold[lane] - 1;
        end

        if (mem_read_done_pulse[lane]) begin
          mem_transfer_done_lane[lane] <= 1'b1;
          mem_done_hold[lane] <= 2;
          mem_busy[lane] <= 1'b0;
          mem_pending[lane] <= MEM_NONE;
        end else if (mem_busy[lane] && (mem_pending[lane] == MEM_WRITE)) begin
          if (mem_timer[lane] == 0) begin
            mem_transfer_done_lane[lane] <= 1'b1;
            mem_done_hold[lane] <= 2;
            mem_busy[lane] <= 1'b0;
            mem_pending[lane] <= MEM_NONE;
            case (mem_op_latched[lane][7:0])
              CMP_Q: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  q_out[lane][h] <= read_i32_from_out_buf(lane, h * 4);
                end
              end
              CMP_K: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  k_out[lane][h] <= read_i32_from_out_buf(lane, h * 4);
                end
              end
              CMP_V: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  v_out[lane][h] <= read_i32_from_out_buf(lane, h * 4);
                end
              end
              CMP_K_REQUANT: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  k_rq_out[lane][h] <= out_buf_mem[lane_base_out(lane) + HEAD_RQ_X_OFFSET + h];
                end
              end
              CMP_V_REQUANT: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  v_rq_out[lane][h] <= out_buf_mem[lane_base_out(lane) + HEAD_RQ_X_OFFSET + h];
                end
              end
              CMP_REQUANT_Q: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  q_rq_out[lane][h] <= out_buf_mem[lane_base_out(lane) + HEAD_RQ_X_OFFSET + h];
                end
              end
              CMP_ATT_SCORES: begin
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  att_scores_out[lane][t] <= read_i32_from_out_buf(lane, t * 4);
                end
              end
              CMP_VALUE_SCALE: begin
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  val_scale_out[lane][t] <= read_i16_from_out_buf(lane, t * 2);
                end
              end
              CMP_SOFTMAX: begin
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  softmax_out[lane][t] <= read_i16_from_out_buf(lane, t * 2);
                end
              end
              CMP_ATT_VALUE: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  att_value_out[lane][h] <= read_i32_from_out_buf(lane, h * 4);
                end
              end
              CMP_HEAD_REQUANT: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  head_rq_out[lane][h] <= out_buf_mem[lane_base_out(lane) + HEAD_RQ_X_OFFSET + h];
                end
              end
              default: begin end
            endcase

            $display("Lane %0d writeback op=0x%02x out[0]=0x%08x",
                     lane, mem_op_latched[lane][7:0],
                     read_i32_from_out_buf(lane, 0));
            dump_lane_buffers(lane);
            dump_lane_debug_mirrors(lane);
          end else begin
            mem_timer[lane] <= mem_timer[lane] - 1;
          end
        end else if (!mem_busy[lane]) begin
          if (ctx_shadow[lane].mem_read_request) begin
            mem_busy[lane] <= 1'b1;
            mem_pending[lane] <= MEM_READ;
            mem_op_latched[lane] <= ctx_shadow[lane].mem_op;
            mem_read_start[lane] <= 1'b1;
          end else if (ctx_shadow[lane].mem_write_request) begin
            mem_busy[lane] <= 1'b1;
            mem_timer[lane] <= MEM_LAT - 1;
            mem_pending[lane] <= MEM_WRITE;
            mem_op_latched[lane] <= ctx_shadow[lane].mem_op;
          end
        end
      end
    end
  end

  // Stream in_buf writes one byte per cycle after a read request.
  always_ff @(posedge ap_clk) begin : mem_read_loader
    int lane;
    if (ap_rst) begin
      for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
        mem_read_active[lane] <= 1'b0;
        mem_read_idx[lane] <= 0;
        mem_read_done_pulse[lane] <= 1'b0;
      end
    end else begin
      for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
        mem_read_done_pulse[lane] <= 1'b0;
        if (mem_read_start[lane] && !mem_read_active[lane]) begin
          build_in_buf_image(lane, mem_op_latched[lane][7:0]);
          mem_read_active[lane] <= 1'b1;
          mem_read_idx[lane] <= 0;
        end else if (mem_read_active[lane]) begin
          in_buf_mem[lane_base_in(lane) + mem_read_idx[lane]] <=
            in_buf_stage[lane][mem_read_idx[lane]];
          if (mem_read_idx[lane] == (IN_BUF_BYTES - 1)) begin
            mem_read_active[lane] <= 1'b0;
            mem_read_idx[lane] <= 0;
            mem_read_done_pulse[lane] <= 1'b1;
            dump_lane_buffers(lane);
            dump_lane_debug_mirrors(lane);
          end else begin
            mem_read_idx[lane] <= mem_read_idx[lane] + 1;
          end
        end
      end
    end
  end

  // Control FSM
  always_ff @(posedge ap_clk) begin : TB_FSM_control
    int lane;
    if (ap_rst) begin
      op_index <= 0;
      gap_ctr <= 0;
      compute_state <= SETUP;
      reset_hold_ctr <= 0;
      ctx_hold_ctr <= 0;
      for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
        start_pending[lane] <= 1'b0;
      end
    end else begin
      for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
        if (start_pending[lane] && (ctx_shadow[lane].state != 8'd0)) begin
          start_pending[lane] <= 1'b0;
        end
      end
      if (ctx_hold_ctr < CTX_HOLD_CYCLES) begin
        ctx_hold_ctr <= ctx_hold_ctr + 1;
      end
      case (compute_state)
        SETUP: begin
          if (reset_hold_ctr < RESET_HOLD_CYCLES) begin
            reset_hold_ctr <= reset_hold_ctr + 1;
          end else begin
            bit all_seen;
            all_seen = 1'b1;
            for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
              all_seen = all_seen && ctx_seen[lane];
            end
            if (all_seen) begin
              compute_state <= OP_SEND;
            end
          end
        end
        OP_SEND: begin
          bit all_ready;
          all_ready = 1'b1;
          for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
            all_ready = all_ready && ctx_shadow[lane].compute_ready;
          end
          if (all_ready) begin
            for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
              start_pending[lane] <= 1'b1;
            end
            compute_state <= OP_WAIT;
          end
        end
        OP_WAIT: begin
          bit all_done;
          all_done = 1'b1;
          for (lane = 0; lane < HEADS_PARALLEL; lane = lane + 1) begin
            all_done = all_done && ctx_shadow[lane].compute_done;
          end
          if (all_done) begin
            gap_ctr <= 0;
            compute_state <= GAP_WAIT;
          end
        end
        GAP_WAIT: begin
          if (gap_ctr < GAP_CYCLES) begin
            gap_ctr <= gap_ctr + 1;
          end else begin
            if (op_index < OP_COUNT-1) begin
              op_index <= op_index + 1;
              compute_state <= OP_SEND;
            end else begin
              compute_state <= DONE;
            end
          end
        end
        DONE: begin
          // hold
        end
        default: begin
          compute_state <= DONE;
        end
      endcase
    end
  end

  // Main testbench control and logging
  integer cycles;
  initial begin
    ap_start = 1'b1;
    reset = 1'b1;

    @(posedge ap_clk);
    for (cycles = 0; cycles < MAX_CYCLES; cycles = cycles + 1) begin
      @(posedge ap_clk);
      if (cycles == RESET_HOLD_CYCLES) begin
        ap_rst <= 1'b0;
        reset <= 1'b0;
      end

      if (compute_state == DONE) begin
        $display("Testbench completed after %0d cycles.", cycles);
        $finish;
      end

      if (error_ap_vld && error) begin
        $display("ERROR: drive_headed_compute_controller asserted error at cycle %0d.", cycles);
        $finish;
      end

      $display("cycle=%0d op=%0d state=%0d ctx0_state=%0d ctx1_state=%0d",
               cycles, op_index, compute_state,
               ctx_o[0][CTX_STATE_MSB:CTX_STATE_LSB],
               ctx_o[1][CTX_STATE_MSB:CTX_STATE_LSB]);
    end
  end

  // DUT Instantiation
  drive_headed_compute_controller dut (
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .ap_ready(ap_ready),
    .ctx_0_i(ctx_i[0]),
    .ctx_0_o(ctx_o[0]),
    .ctx_0_o_ap_vld(ctx_o_ap_vld[0]),
    .ctx_1_i(ctx_i[1]),
    .ctx_1_o(ctx_o[1]),
    .ctx_1_o_ap_vld(ctx_o_ap_vld[1]),
    .reset(reset),
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
    .dbg_head_vec_address0(dbg_head_vec_address0),
    .dbg_head_vec_ce0(dbg_head_vec_ce0),
    .dbg_head_vec_we0(dbg_head_vec_we0),
    .dbg_head_vec_d0(dbg_head_vec_d0),
    .dbg_head_out_address0(dbg_head_out_address0),
    .dbg_head_out_ce0(dbg_head_out_ce0),
    .dbg_head_out_we0(dbg_head_out_we0),
    .dbg_head_out_d0(dbg_head_out_d0),
    .error(error),
    .error_ap_vld(error_ap_vld)
  );

endmodule
