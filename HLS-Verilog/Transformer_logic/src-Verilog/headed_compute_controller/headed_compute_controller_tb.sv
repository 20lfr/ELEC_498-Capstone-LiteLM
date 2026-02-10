`timescale 1ns/1ps

module headed_compute_controller_tb;

  // Parameters
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

  localparam int IN_BUF_ADDR_W  = (IN_BUF_BYTES > 1) ? $clog2(IN_BUF_BYTES) : 1;
  localparam int OUT_BUF_ADDR_W = (OUT_BUF_BYTES > 1) ? $clog2(OUT_BUF_BYTES) : 1;

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
  localparam logic [7:0] CMP_Q           = 8'h03;
  localparam logic [7:0] CMP_K           = 8'h04;
  localparam logic [7:0] CMP_K_REQUANT   = 8'h05;
  localparam logic [7:0] CMP_V           = 8'h06;
  localparam logic [7:0] CMP_V_REQUANT   = 8'h07;
  localparam logic [7:0] CMP_REQUANT_Q   = 8'h08;
  localparam logic [7:0] CMP_ATT_SCORES  = 8'h09;
  localparam logic [7:0] CMP_VALUE_SCALE = 8'h0A;
  localparam logic [7:0] CMP_SOFTMAX     = 8'h0B;
  localparam logic [7:0] CMP_ATT_VALUE   = 8'h0C;
  localparam logic [7:0] CMP_HEAD_REQUANT = 8'h0D;

  // Signals
  logic ap_clk = 1'b0;
  logic ap_rst = 1'b1;
  always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

  localparam int GAP_CYCLES = 20;
  localparam int OP_COUNT = 11;
  int op_index;
  int gap_ctr;
  logic done_seen = 1'b0;

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

  localparam int MEM_LAT = 2;
  typedef enum logic [1:0] {
    MEM_NONE  = 2'b00,
    MEM_READ  = 2'b01,
    MEM_WRITE = 2'b10
  } mem_pending_t;
  mem_pending_t mem_pending = MEM_NONE;
  logic mem_busy;
  int mem_timer;
  int mem_done_hold;

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

  // DUT Signals
  logic ap_start;
  logic ap_done;
  logic ap_idle;
  logic ap_ready;
  logic [0:0] reset;
  logic [0:0] compute_start;
  logic [31:0] compute_instruction;
  logic [0:0] compute_ready;
  logic compute_ready_ap_vld;
  logic [0:0] compute_done;
  logic compute_done_ap_vld;
  logic [0:0] mem_transfer_done;
  logic [0:0] mem_read_request;
  logic mem_read_request_ap_vld;
  logic [0:0] mem_write_request;
  logic mem_write_request_ap_vld;
  logic [31:0] mem_op;
  logic mem_op_ap_vld;
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
  logic [0:0] error;
  logic error_ap_vld;
  logic [7:0] dbg_state;
  logic dbg_state_ap_vld;
  logic [31:0] dbg_req_instruction;
  logic dbg_req_instruction_ap_vld;
  logic [7:0] dbg_req_op;
  logic dbg_req_op_ap_vld;
  logic [7:0] dbg_req_layer;
  logic dbg_req_layer_ap_vld;
  logic [7:0] dbg_req_head;
  logic dbg_req_head_ap_vld;
  logic [7:0] dbg_req_tile;
  logic dbg_req_tile_ap_vld;

  logic [7:0] dbg_state_lat;
  logic [31:0] dbg_req_instruction_lat;
  logic [7:0] dbg_req_op_lat;
  logic [7:0] dbg_req_layer_lat;
  logic [7:0] dbg_req_head_lat;
  logic [7:0] dbg_req_tile_lat;

  // Separate input memories per operation
  logic signed [7:0] q_act [0:D_MODEL-1];
  logic signed [7:0] k_act [0:D_MODEL-1];
  logic signed [7:0] v_act [0:D_MODEL-1];
  logic signed [3:0] wq [0:(D_MODEL*D_HEADS)-1];
  logic signed [3:0] wk [0:(D_MODEL*D_HEADS)-1];
  logic signed [3:0] wv [0:(D_MODEL*D_HEADS)-1];
  logic signed [3:0] bq [0:D_HEADS-1];
  logic signed [3:0] bk [0:D_HEADS-1];
  logic signed [3:0] bv [0:D_HEADS-1];

  logic signed [31:0] rq_k_x [0:D_HEADS-1];
  logic signed [31:0] rq_v_x [0:D_HEADS-1];
  logic signed [31:0] rq_q_x [0:D_HEADS-1];
  logic signed [31:0] rq_head_x [0:D_HEADS-1];
  logic signed [31:0] rq_k_M, rq_k_N, rq_k_Z;
  logic signed [31:0] rq_v_M, rq_v_N, rq_v_Z;
  logic signed [31:0] rq_q_M, rq_q_N, rq_q_Z;
  logic signed [31:0] rq_head_M, rq_head_N, rq_head_Z;

  logic signed [7:0] att_q [0:D_HEADS-1];
  logic signed [7:0] att_k_cache [0:(CONTEXT_LENGTH*D_HEADS)-1];

  logic signed [31:0] val_scale_in [0:CONTEXT_LENGTH-1];
  logic signed [15:0] softmax_in [0:CONTEXT_LENGTH-1];

  logic signed [7:0] att_weights [0:CONTEXT_LENGTH-1];
  logic signed [7:0] att_v_cache [0:(D_HEADS*CONTEXT_LENGTH)-1];

  // Output capture per operation
  logic signed [31:0] q_out [0:D_HEADS-1];
  logic signed [31:0] k_out [0:D_HEADS-1];
  logic signed [31:0] v_out [0:D_HEADS-1];

  logic signed [7:0] k_rq_out [0:D_HEADS-1];
  logic signed [7:0] v_rq_out [0:D_HEADS-1];
  logic signed [7:0] q_rq_out [0:D_HEADS-1];
  logic signed [7:0] head_rq_out [0:D_HEADS-1];

  logic signed [31:0] att_scores_out [0:CONTEXT_LENGTH-1];
  logic signed [15:0] val_scale_out [0:CONTEXT_LENGTH-1];
  logic signed [15:0] softmax_out [0:CONTEXT_LENGTH-1];
  logic signed [31:0] att_value_out [0:D_HEADS-1];

  logic [7:0] in_buf_mem [0:IN_BUF_BYTES-1];
  logic [7:0] out_buf_mem [0:OUT_BUF_BYTES-1];

  // Initialize memory contents
  initial begin : init_mem
    int i;
    int t;
    int h;
    int sign;
    int base;

    for (i = 0; i < D_MODEL; i = i + 1) begin
      q_act[i] = (i % 2) ? -$signed(i + 1) : $signed(i + 1);
      k_act[i] = (i % 2) ? $signed(i + 3) : -$signed(i + 2);
      v_act[i] = $signed((i % 3) - 4);
    end

    for (h = 0; h < D_HEADS; h = h + 1) begin
      for (i = 0; i < D_MODEL; i = i + 1) begin
        wq[h * D_MODEL + i] = (h == 0) ? 4'sd1 : 4'sd3;
        wk[h * D_MODEL + i] = (h == 0) ? -4'sd2 : 4'sd2;
        wv[h * D_MODEL + i] = (i % 2) ? -4'sd3 : 4'sd1;
      end
      bq[h] = (h == 0) ? 4'sd3 : -4'sd2;
      bk[h] = (h == 0) ? -4'sd1 : 4'sd2;
      bv[h] = (h % 2) ? -4'sd3 : 4'sd4;

      rq_q_x[h]    = 40 + (h * 5);
      rq_k_x[h]    = -30 - (h * 7);
      rq_v_x[h]    = 15 + (h * 11);
      rq_head_x[h] = (h % 2) ? (-20 - h) : (20 + h);

      att_q[h] = (h % 2) ? -6 : 5;
    end

    rq_q_M = 32'd3; rq_q_N = 32'd3; rq_q_Z = 32'd0;
    rq_k_M = 32'd3; rq_k_N = 32'd3; rq_k_Z = 32'd0;
    rq_v_M = 32'd3; rq_v_N = 32'd3; rq_v_Z = 32'd0;
    rq_head_M = 32'd3; rq_head_N = 32'd3; rq_head_Z = 32'd0;

    for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
      sign = (t % 2) ? -1 : 1;
      for (h = 0; h < D_HEADS; h = h + 1) begin
        att_k_cache[t * D_HEADS + h] = sign * (t + h + 1);
      end
      val_scale_in[t] = (t % 7) * 37 - 90;
      softmax_in[t] = -1200 + (t * 95);
      att_weights[t] = ((t % 5) - 2) * 15;
    end

    for (h = 0; h < D_HEADS; h = h + 1) begin
      for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
        base = (t % 4) - 1;
        att_v_cache[h * CONTEXT_LENGTH + t] = (h + 2) * base;
      end
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
    end
  end

  always_ff @(posedge ap_clk) begin : dbg_latch
    if (ap_rst) begin
      dbg_state_lat <= '0;
      dbg_req_instruction_lat <= '0;
      dbg_req_op_lat <= '0;
      dbg_req_layer_lat <= '0;
      dbg_req_head_lat <= '0;
      dbg_req_tile_lat <= '0;
    end else begin
      if (dbg_state_ap_vld) begin
        dbg_state_lat <= dbg_state;
      end
      if (dbg_req_instruction_ap_vld) begin
        dbg_req_instruction_lat <= dbg_req_instruction;
      end
      if (dbg_req_op_ap_vld) begin
        dbg_req_op_lat <= dbg_req_op;
      end
      if (dbg_req_layer_ap_vld) begin
        dbg_req_layer_lat <= dbg_req_layer;
      end
      if (dbg_req_head_ap_vld) begin
        dbg_req_head_lat <= dbg_req_head;
      end
      if (dbg_req_tile_ap_vld) begin
        dbg_req_tile_lat <= dbg_req_tile;
      end
    end
  end

  always_ff @(posedge ap_clk) begin : MEM_controller_respond
    if (ap_rst) begin
      mem_transfer_done <= 0;
      mem_busy <= 1'b0;
      mem_timer <= 0;
      mem_pending <= MEM_NONE;
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
            int t;
            int h;
            for (t = 0; t < IN_BUF_BYTES; t = t + 1) begin
              in_buf_mem[t] = 8'd0;
            end

            case (mem_op[7:0])
              CMP_Q: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  in_buf_mem[QKV_ACT_OFFSET + t] = q_act[t];
                end
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  for (t = 0; t < D_MODEL; t = t + 1) begin
                    write_i4_to_in_buf((QKV_W_OFFSET * 2) + (h * D_MODEL) + t,
                                       wq[(h * D_MODEL) + t]);
                  end
                  write_i4_to_in_buf((QKV_B_OFFSET * 2) + h, bq[h]);
                end
              end
              CMP_K: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  in_buf_mem[QKV_ACT_OFFSET + t] = k_act[t];
                end
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  for (t = 0; t < D_MODEL; t = t + 1) begin
                    write_i4_to_in_buf((QKV_W_OFFSET * 2) + (h * D_MODEL) + t,
                                       wk[(h * D_MODEL) + t]);
                  end
                  write_i4_to_in_buf((QKV_B_OFFSET * 2) + h, bk[h]);
                end
              end
              CMP_V: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  in_buf_mem[QKV_ACT_OFFSET + t] = v_act[t];
                end
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  for (t = 0; t < D_MODEL; t = t + 1) begin
                    write_i4_to_in_buf((QKV_W_OFFSET * 2) + (h * D_MODEL) + t,
                                       wv[(h * D_MODEL) + t]);
                  end
                  write_i4_to_in_buf((QKV_B_OFFSET * 2) + h, bv[h]);
                end
              end
              CMP_K_REQUANT: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  write_i32_to_in_buf(HEAD_RQ_X_OFFSET + (h * 4), rq_k_x[h]);
                end
                write_i32_to_in_buf(HEAD_RQ_M_OFFSET, rq_k_M);
                write_i32_to_in_buf(HEAD_RQ_N_OFFSET, rq_k_N);
                write_i32_to_in_buf(HEAD_RQ_Z_OFFSET, rq_k_Z);
              end
              CMP_V_REQUANT: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  write_i32_to_in_buf(HEAD_RQ_X_OFFSET + (h * 4), rq_v_x[h]);
                end
                write_i32_to_in_buf(HEAD_RQ_M_OFFSET, rq_v_M);
                write_i32_to_in_buf(HEAD_RQ_N_OFFSET, rq_v_N);
                write_i32_to_in_buf(HEAD_RQ_Z_OFFSET, rq_v_Z);
              end
              CMP_REQUANT_Q: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  write_i32_to_in_buf(HEAD_RQ_X_OFFSET + (h * 4), rq_q_x[h]);
                end
                write_i32_to_in_buf(HEAD_RQ_M_OFFSET, rq_q_M);
                write_i32_to_in_buf(HEAD_RQ_N_OFFSET, rq_q_N);
                write_i32_to_in_buf(HEAD_RQ_Z_OFFSET, rq_q_Z);
              end
              CMP_ATT_SCORES: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  in_buf_mem[ATT_SCORES_Q_OFFSET + h] = att_q[h];
                end
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  for (h = 0; h < D_HEADS; h = h + 1) begin
                    in_buf_mem[ATT_SCORES_KCACHE_OFFSET + (t * D_HEADS) + h] =
                      att_k_cache[(t * D_HEADS) + h];
                  end
                end
              end
              CMP_VALUE_SCALE: begin
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  write_i32_to_in_buf(VALUE_SCALE_X_OFFSET + (t * 4), val_scale_in[t]);
                end
              end
              CMP_SOFTMAX: begin
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  write_i16_to_in_buf(SOFTMAX_X_OFFSET + (t * 2), softmax_in[t]);
                end
              end
              CMP_ATT_VALUE: begin
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  in_buf_mem[ATT_VALUE_W_OFFSET + t] = att_weights[t];
                end
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                    in_buf_mem[ATT_VALUE_V_OFFSET + (h * CONTEXT_LENGTH) + t] =
                      att_v_cache[(h * CONTEXT_LENGTH) + t];
                  end
                end
              end
              CMP_HEAD_REQUANT: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  write_i32_to_in_buf(HEAD_RQ_X_OFFSET + (h * 4), rq_head_x[h]);
                end
                write_i32_to_in_buf(HEAD_RQ_M_OFFSET, rq_head_M);
                write_i32_to_in_buf(HEAD_RQ_N_OFFSET, rq_head_N);
                write_i32_to_in_buf(HEAD_RQ_Z_OFFSET, rq_head_Z);
              end
              default: begin
              end
            endcase
          end else if (mem_pending == MEM_WRITE) begin
            int t;
            int h;
            case (mem_op[7:0])
              CMP_Q: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  q_out[h] <= read_i32_from_out_buf(h * 4);
                end
              end
              CMP_K: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  k_out[h] <= read_i32_from_out_buf(h * 4);
                end
              end
              CMP_V: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  v_out[h] <= read_i32_from_out_buf(h * 4);
                end
              end
              CMP_K_REQUANT: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  k_rq_out[h] <= out_buf_mem[HEAD_RQ_X_OFFSET + h];
                end
              end
              CMP_V_REQUANT: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  v_rq_out[h] <= out_buf_mem[HEAD_RQ_X_OFFSET + h];
                end
              end
              CMP_REQUANT_Q: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  q_rq_out[h] <= out_buf_mem[HEAD_RQ_X_OFFSET + h];
                end
              end
              CMP_ATT_SCORES: begin
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  att_scores_out[t] <= read_i32_from_out_buf(t * 4);
                end
              end
              CMP_VALUE_SCALE: begin
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  val_scale_out[t] <= read_i16_from_out_buf(t * 2);
                end
              end
              CMP_SOFTMAX: begin
                for (t = 0; t < CONTEXT_LENGTH; t = t + 1) begin
                  softmax_out[t] <= read_i16_from_out_buf(t * 2);
                end
              end
              CMP_ATT_VALUE: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  att_value_out[h] <= read_i32_from_out_buf(h * 4);
                end
              end
              CMP_HEAD_REQUANT: begin
                for (h = 0; h < D_HEADS; h = h + 1) begin
                  head_rq_out[h] <= out_buf_mem[HEAD_RQ_X_OFFSET + h];
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
        if (mem_read_request) begin
          mem_busy <= 1'b1;
          mem_timer <= MEM_LAT - 1;
          mem_pending <= MEM_READ;
        end else if (mem_write_request) begin
          mem_busy <= 1'b1;
          mem_timer <= MEM_LAT - 1;
          mem_pending <= MEM_WRITE;
        end
      end
    end
  end

  always_ff @(posedge ap_clk) begin : TB_monitoring_compute_done
    if (compute_done_ap_vld && compute_done) begin
      done_seen <= 1'b1;
    end
    if (compute_start && !compute_ready) begin
      compute_start <= 1'b0;
    end
  end

  always_ff @(posedge ap_clk) begin : TB_FSM_controling_compute
    case (compute_state)
      SETUP: begin
        done_seen <= 1'b0;
        compute_start <= 1'b0;
        op_index <= 0;
        gap_ctr <= 0;
        if (reset_hold_ctr >= (RESET_HOLD_CYCLES - 1)) begin
          ap_rst <= 1'b0;
          ap_start <= 1'b1;
          reset <= 1'b1;
          compute_state <= OP_SEND;
        end else begin
          ap_rst <= 1'b1;
          ap_start <= 1'b0;
          reset <= 1'b0;
          reset_hold_ctr <= reset_hold_ctr + 1;
        end
      end
      OP_SEND: begin
        reset <= 1'b1;
        compute_start <= 1'b0;
        if (compute_ready) begin
          compute_start <= 1'b1;
          // Instruction format: [31:24]=tile [23:16]=head [15:8]=layer [7:0]=op
          compute_instruction <= {8'hFF, 8'h00, 8'h00, op_for_index(op_index)};
          compute_state <= OP_WAIT;
        end
      end
      OP_WAIT: begin
        compute_start <= 1'b0;
        if (done_seen) begin
          done_seen <= 1'b0;
          if ((op_index + 1) >= OP_COUNT) begin
            compute_state <= DONE;
          end else begin
            op_index <= op_index + 1;
            gap_ctr <= GAP_CYCLES;
            compute_state <= GAP_WAIT;
          end
        end
      end
      GAP_WAIT: begin
        compute_start <= 1'b0;
        if (gap_ctr == 0) begin
          compute_state <= OP_SEND;
        end else begin
          gap_ctr <= gap_ctr - 1;
        end
      end
      DONE: begin
        $finish;
      end
    endcase
  end

  initial begin : stimulus
    automatic int cycles = 0;
    ap_start = 1'b0;
    ap_rst = 1'b1;
    reset = 1'b0;
    compute_start = 1'b0;
    compute_instruction = 32'd0;
    mem_transfer_done = 1'b0;
    in_buf_q0 = 8'd0;
    in_buf_q1 = 8'd0;
    reset_hold_ctr = 0;

    $display("Default DUT inputs:");
    $display("  ap_clk=%0b ap_rst=%0b ap_start=%0b reset=%0b", ap_clk, ap_rst, ap_start, reset);
    $display("  compute_start=%0b compute_instruction=0x%08x mem_transfer_done=%0b",
             compute_start, compute_instruction, mem_transfer_done);
    $display("  in_buf_q0=0x%0h", in_buf_q0);

    @(posedge ap_clk);

    for (cycles = 0; cycles < MAX_CYCLES; cycles++) begin
      @(posedge ap_clk);

      if (compute_state == DONE) begin
        $display("Testbench completed after %0d cycles.", cycles);
        $finish;
      end

      if (error_ap_vld && error) begin
        $display("ERROR: headed_compute_controller asserted error at cycle %0d (instr=0x%08x).",
                 cycles, dbg_req_instruction_lat);
        $finish;
      end

      $display("cycle=%0d state=%0d req_instr=0x%08x req_op=0x%02x req_layer=%0d req_head=%0d req_tile=%0d",
               cycles,
               dbg_state_lat,
               dbg_req_instruction_lat,
               dbg_req_op_lat,
               dbg_req_layer_lat,
               $signed(dbg_req_head_lat),
               $signed(dbg_req_tile_lat));
    end
  end

  // DUT Instantiation
  headed_compute_controller dut (
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .ap_ready(ap_ready),
    .reset_n(reset),
    .compute_start(compute_start),
    .compute_instruction(compute_instruction),
    .compute_ready(compute_ready),
    .compute_ready_ap_vld(compute_ready_ap_vld),
    .compute_done(compute_done),
    .compute_done_ap_vld(compute_done_ap_vld),
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
    .dbg_state(dbg_state),
    .dbg_state_ap_vld(dbg_state_ap_vld),
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
    .error(error),
    .error_ap_vld(error_ap_vld)
  );

endmodule
