`timescale 1ns/1ps

module compute_controller_tb;

  // Parameters
  localparam int NUM_HEADS       = 4;
  localparam int NUM_LAYERS      = 2;
  localparam int NUM_WO_TILES    = 4;
  localparam int NUM_W1_TILES    = 4;
  localparam int NUM_W2_TILES    = 4;
  localparam int NUM_LOGIT_TILES = 2;

  localparam int D_MODEL = 8;
  localparam int D_FFN   = 22;
  localparam int D_HEADS = D_MODEL / NUM_HEADS;
  localparam int D_TILE_WO  = D_MODEL / NUM_WO_TILES;
  localparam int D_TILE_W1  = D_MODEL / NUM_W1_TILES;
  localparam int D_TILE_W2  = D_FFN   / NUM_W2_TILES;
  localparam int CONTEXT_LENGTH = 16;

  localparam int CLK_PERIOD = 10;
  localparam int MAX_CYCLES = 8000;
  localparam int RESET_HOLD_CYCLES = 3;
  localparam int MEM_LAT = 2;

  // Compute op codes (match top_params.hpp)
  localparam int CMP_OUT_PROJ  = 14;
  localparam int CMP_REQUANT1  = 15;
  localparam int CMP_RESID0    = 16;
  localparam int CMP_LN0       = 17;
  localparam int CMP_REQUANT3  = 18;
  localparam int CMP_FFN_W1    = 19;
  localparam int CMP_FFN_ACT   = 20;
  localparam int CMP_FFN_W2    = 21;
  localparam int CMP_REQUANT4  = 22;
  localparam int CMP_RESID1    = 23;
  localparam int CMP_LN1       = 24;
  localparam int CMP_DEQUANT   = 25;
  localparam int CMP_LOGITS    = 26;
  localparam int CMP_REQUANT2  = 11;

  // Signals
  logic ap_clk = 1'b0;
  logic ap_rst = 1'b1;
  always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

  typedef enum logic [1:0] {
    MEM_NONE  = 2'b00,
    MEM_READ  = 2'b01,
    MEM_WRITE = 2'b10
  } mem_pending_t;

  mem_pending_t mem_pending = MEM_NONE;
  logic mem_busy;
  int mem_timer;
  int pending_tile;
  int pending_op;

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

  logic [2:0] int8_activation_address0;
  logic int8_activation_ce0;
  logic [7:0] int8_activation_q0;
  logic [2:0] int8_activation_address1;
  logic int8_activation_ce1;
  logic [7:0] int8_activation_q1;

  logic [3:0] OUT_PROJ_valueB_address0;
  logic OUT_PROJ_valueB_ce0;
  logic [3:0] OUT_PROJ_valueB_q0;
  logic [3:0] OUT_PROJ_valueB_address1;
  logic OUT_PROJ_valueB_ce1;
  logic [3:0] OUT_PROJ_valueB_q1;

  logic [0:0] OUT_PROJ_bias_address0;
  logic OUT_PROJ_bias_ce0;
  logic [31:0] OUT_PROJ_bias_q0;
  logic [0:0] OUT_PROJ_bias_address1;
  logic OUT_PROJ_bias_ce1;
  logic [31:0] OUT_PROJ_bias_q1;

  logic [0:0] OUT_PROJ_accum_address0;
  logic OUT_PROJ_accum_ce0;
  logic OUT_PROJ_accum_we0;
  logic [31:0] OUT_PROJ_accum_d0;
  logic [0:0] OUT_PROJ_accum_address1;
  logic OUT_PROJ_accum_ce1;
  logic OUT_PROJ_accum_we1;
  logic [31:0] OUT_PROJ_accum_d1;

  logic [3:0] FFN1_weights1_address0;
  logic FFN1_weights1_ce0;
  logic [3:0] FFN1_weights1_q0;
  logic [3:0] FFN1_weights1_address1;
  logic FFN1_weights1_ce1;
  logic [3:0] FFN1_weights1_q1;

  logic [0:0] FFN1_biases_address0;
  logic FFN1_biases_ce0;
  logic [3:0] FFN1_biases_q0;

  logic [0:0] FFN1_scale_address0;
  logic FFN1_scale_ce0;
  logic [15:0] FFN1_scale_q0;

  logic [0:0] FFN1_output_address0;
  logic FFN1_output_ce0;
  logic FFN1_output_we0;
  logic [15:0] FFN1_output_d0;

  logic [4:0] RELU_input_address0;
  logic RELU_input_ce0;
  logic [15:0] RELU_input_q0;

  logic [4:0] RELU_output_address0;
  logic RELU_output_ce0;
  logic RELU_output_we0;
  logic [15:0] RELU_output_d0;

  logic [4:0] FFN2_input_address0;
  logic FFN2_input_ce0;
  logic [15:0] FFN2_input_q0;
  logic [4:0] FFN2_input_address1;
  logic FFN2_input_ce1;
  logic [15:0] FFN2_input_q1;

  logic [6:0] FFN2_weights2_address0;
  logic FFN2_weights2_ce0;
  logic [3:0] FFN2_weights2_q0;
  logic [6:0] FFN2_weights2_address1;
  logic FFN2_weights2_ce1;
  logic [3:0] FFN2_weights2_q1;

  logic [2:0] FFN2_biases_address0;
  logic FFN2_biases_ce0;
  logic [3:0] FFN2_biases_q0;

  logic [2:0] FFN2_scale_address0;
  logic FFN2_scale_ce0;
  logic [15:0] FFN2_scale_q0;

  logic [2:0] FFN2_output_address0;
  logic FFN2_output_ce0;
  logic FFN2_output_we0;
  logic [31:0] FFN2_output_d0;

  logic [2:0] requant_activation_address0;
  logic requant_activation_ce0;
  logic [31:0] requant_activation_q0;
  logic [2:0] requant_activation_address1;
  logic requant_activation_ce1;
  logic [31:0] requant_activation_q1;

  logic [31:0] requant_scale;
  logic [31:0] requant_shift;
  logic [31:0] requant_zero_point;

  logic [2:0] requant_output_address0;
  logic requant_output_ce0;
  logic requant_output_we0;
  logic [7:0] requant_output_d0;
  logic [2:0] requant_output_address1;
  logic requant_output_ce1;
  logic requant_output_we1;
  logic [7:0] requant_output_d1;

  logic [2:0] layerNorm_gamma_address0;
  logic layerNorm_gamma_ce0;
  logic [31:0] layerNorm_gamma_q0;
  logic [2:0] layerNorm_gamma_address1;
  logic layerNorm_gamma_ce1;
  logic [31:0] layerNorm_gamma_q1;

  logic [2:0] layerNorm_beta_address0;
  logic layerNorm_beta_ce0;
  logic [31:0] layerNorm_beta_q0;
  logic [2:0] layerNorm_beta_address1;
  logic layerNorm_beta_ce1;
  logic [31:0] layerNorm_beta_q1;

  logic [31:0] layerNorm_epsilon;

  logic [2:0] layerNorm_out_address0;
  logic layerNorm_out_ce0;
  logic layerNorm_out_we0;
  logic [31:0] layerNorm_out_d0;
  logic [2:0] layerNorm_out_address1;
  logic layerNorm_out_ce1;
  logic layerNorm_out_we1;
  logic [31:0] layerNorm_out_d1;

  logic [2:0] residualAdd_residual_address0;
  logic residualAdd_residual_ce0;
  logic [7:0] residualAdd_residual_q0;
  logic [2:0] residualAdd_residual_address1;
  logic residualAdd_residual_ce1;
  logic [7:0] residualAdd_residual_q1;

  logic [2:0] residualAdd_output_address0;
  logic residualAdd_output_ce0;
  logic residualAdd_output_we0;
  logic [7:0] residualAdd_output_d0;
  logic [2:0] residualAdd_output_address1;
  logic residualAdd_output_ce1;
  logic residualAdd_output_we1;
  logic [7:0] residualAdd_output_d1;

  logic [0:0] error;
  logic error_ap_vld;

  // Memory arrays
  logic signed [7:0] int8_activation_mem [0:D_MODEL-1];
  logic signed [3:0] out_proj_weights_mem [0:D_MODEL*D_TILE_WO-1];
  logic signed [31:0] out_proj_bias_mem [0:D_TILE_WO-1];
  logic signed [31:0] out_proj_accum_mem [0:D_TILE_WO-1];

  logic signed [3:0] ffn1_weights_mem [0:D_MODEL*D_TILE_W1-1];
  logic signed [3:0] ffn1_biases_mem [0:D_TILE_W1-1];
  logic signed [15:0] ffn1_scale_mem [0:D_TILE_W1-1];
  logic signed [15:0] ffn1_output_mem [0:D_TILE_W1-1];

  logic signed [15:0] relu_input_mem [0:D_FFN-1];
  logic signed [15:0] relu_output_mem [0:D_FFN-1];

  logic signed [15:0] ffn2_input_mem [0:D_FFN-1];
  logic signed [3:0] ffn2_weights_mem [0:D_TILE_W2*D_FFN-1];
  logic signed [3:0] ffn2_biases_mem [0:D_TILE_W2-1];
  logic signed [15:0] ffn2_scale_mem [0:D_TILE_W2-1];
  logic signed [31:0] ffn2_output_mem [0:D_MODEL-1];

  logic signed [31:0] requant_activation_mem [0:D_MODEL-1];
  logic signed [7:0] requant_output_mem [0:D_MODEL-1];

  logic signed [31:0] layernorm_gamma_mem [0:D_MODEL-1];
  logic signed [31:0] layernorm_beta_mem [0:D_MODEL-1];
  logic signed [31:0] layernorm_out_mem [0:D_MODEL-1];

  logic signed [7:0] residual_mem [0:D_MODEL-1];
  logic signed [7:0] residual_out_mem [0:D_MODEL-1];

  int errors;

  function automatic logic signed [7:0] requant_ref(
      input logic signed [31:0] x,
      input logic signed [31:0] m,
      input int n,
      input logic signed [31:0] z_out
  );
      longint signed product;
      longint signed rounded;
      longint signed scaled;
      longint signed shifted;
      begin
          product = x * m;
          if (n == 0) begin
              scaled = product;
          end else begin
              rounded = 1;
              rounded = rounded <<< (n - 1);
              scaled = (product + rounded) >>> n;
          end
          shifted = scaled + z_out;
          if (shifted > 127)
              requant_ref = 8'sd127;
          else if (shifted < -128)
              requant_ref = -8'sd128;
          else
              requant_ref = shifted[7:0];
      end
  endfunction

  function automatic integer signed sum_int8;
      integer i;
      begin
          sum_int8 = 0;
          for (i = 0; i < D_MODEL; i = i + 1) begin
              sum_int8 += $signed(int8_activation_mem[i]);
          end
      end
  endfunction

  function automatic integer signed sum_int16_ffn2;
      integer i;
      begin
          sum_int16_ffn2 = 0;
          for (i = 0; i < D_FFN; i = i + 1) begin
              sum_int16_ffn2 += $signed(ffn2_input_mem[i]);
          end
      end
  endfunction

  task automatic load_out_proj_tile(input int tile);
      int t;
      int j;
      int out_idx;
      logic signed [3:0] w;
      begin
          for (t = 0; t < D_TILE_WO; t = t + 1) begin
              out_idx = tile * D_TILE_WO + t;
              w = (out_idx % 2 == 0) ? 4'sd1 : -4'sd1;
              for (j = 0; j < D_MODEL; j = j + 1) begin
                  out_proj_weights_mem[t * D_MODEL + j] = w;
              end
          end
      end
  endtask

  task automatic clear_outputs_for_op(input int op);
      int i;
      begin
          case (op)
              CMP_OUT_PROJ: begin
                  for (i = 0; i < D_TILE_WO; i = i + 1) begin
                      out_proj_accum_mem[i] = 32'h7f7f7f7f;
                  end
              end
              CMP_REQUANT1,
              CMP_REQUANT3,
              CMP_REQUANT4: begin
                  for (i = 0; i < D_MODEL; i = i + 1) begin
                      requant_output_mem[i] = 8'h7f;
                  end
              end
              CMP_RESID0,
              CMP_RESID1: begin
                  for (i = 0; i < D_MODEL; i = i + 1) begin
                      residual_out_mem[i] = 8'h7f;
                  end
              end
              CMP_LN0,
              CMP_LN1: begin
                  for (i = 0; i < D_MODEL; i = i + 1) begin
                      layernorm_out_mem[i] = 32'h0;
                  end
              end
              CMP_FFN_W1: begin
                  for (i = 0; i < D_TILE_W1; i = i + 1) begin
                      ffn1_output_mem[i] = 16'h7f7f;
                  end
              end
              CMP_FFN_ACT: begin
                  for (i = 0; i < D_FFN; i = i + 1) begin
                      relu_output_mem[i] = 16'h7f7f;
                  end
              end
              CMP_FFN_W2: begin
                  for (i = 0; i < D_MODEL; i = i + 1) begin
                      ffn2_output_mem[i] = 32'h7f7f7f7f;
                  end
              end
              default: begin
              end
          endcase
      end
  endtask

  task automatic check_out_proj(input int tile);
      int t;
      int out_idx;
      integer signed sum;
      integer signed expected;
      begin
          sum = sum_int8();
          for (t = 0; t < D_TILE_WO; t = t + 1) begin
              out_idx = tile * D_TILE_WO + t;
              expected = ((out_idx % 2 == 0) ? sum : -sum) + $signed(out_proj_bias_mem[t]);
              if ($signed(out_proj_accum_mem[t]) !== expected) begin
                  $display("ERROR: OUT_PROJ mismatch t=%0d got=%0d expected=%0d", t,
                           $signed(out_proj_accum_mem[t]), expected);
                  errors++;
              end
          end
      end
  endtask

  task automatic check_requant(input string name);
      int i;
      logic signed [7:0] expected;
      begin
          for (i = 0; i < D_MODEL; i = i + 1) begin
              expected = requant_ref(requant_activation_mem[i], requant_scale, requant_shift,
                                     requant_zero_point);
              if ($signed(requant_output_mem[i]) !== expected) begin
                  $display("ERROR: %s mismatch i=%0d got=%0d expected=%0d", name, i,
                           $signed(requant_output_mem[i]), expected);
                  errors++;
              end
          end
      end
  endtask

  task automatic check_residual(input string name);
      int i;
      logic signed [7:0] expected;
      begin
          for (i = 0; i < D_MODEL; i = i + 1) begin
              expected = $signed(int8_activation_mem[i]) + $signed(residual_mem[i]);
              if ($signed(residual_out_mem[i]) !== expected) begin
                  $display("ERROR: %s mismatch i=%0d got=%0d expected=%0d", name, i,
                           $signed(residual_out_mem[i]), expected);
                  errors++;
              end
          end
      end
  endtask

  task automatic check_layernorm(input string name);
      int i;
      logic signed [31:0] expected;
      begin
          for (i = 0; i < D_MODEL; i = i + 1) begin
              expected = layernorm_beta_mem[i];
              if ($signed(layernorm_out_mem[i]) !== expected) begin
                  $display("ERROR: %s mismatch i=%0d got=%0d expected=%0d", name, i,
                           $signed(layernorm_out_mem[i]), expected);
                  errors++;
              end
          end
      end
  endtask

  task automatic check_ffn_w1;
      int i;
      integer signed sum;
      integer signed expected;
      begin
          sum = sum_int8();
          expected = sum >>> 1;
          for (i = 0; i < D_TILE_W1; i = i + 1) begin
              if ($signed(ffn1_output_mem[i]) !== expected[15:0]) begin
                  $display("ERROR: FFN_W1 mismatch i=%0d got=%0d expected=%0d", i,
                           $signed(ffn1_output_mem[i]), expected);
                  errors++;
              end
          end
      end
  endtask

  task automatic check_relu;
      int i;
      logic signed [15:0] expected;
      begin
          for (i = 0; i < D_FFN; i = i + 1) begin
              expected = ($signed(relu_input_mem[i]) < 0) ? 16'sd0 : relu_input_mem[i];
              if ($signed(relu_output_mem[i]) !== expected) begin
                  $display("ERROR: FFN_ACT mismatch i=%0d got=%0d expected=%0d", i,
                           $signed(relu_output_mem[i]), expected);
                  errors++;
              end
          end
      end
  endtask

  task automatic check_ffn_w2;
      int i;
      integer signed sum;
      begin
          sum = sum_int16_ffn2();
          for (i = 0; i < D_TILE_W2; i = i + 1) begin
              if ($signed(ffn2_output_mem[i]) !== sum) begin
                  $display("ERROR: FFN_W2 mismatch i=%0d got=%0d expected=%0d", i,
                           $signed(ffn2_output_mem[i]), sum);
                  errors++;
              end
          end
      end
  endtask

  task automatic wait_ready;
      begin
          while (!(compute_ready && compute_ready_ap_vld)) begin
              @(posedge ap_clk);
          end
      end
  endtask

  task automatic issue_op(input int op, input int tile);
      begin
          wait_ready();
          compute_instruction <= {tile[7:0], 8'h00, 8'h01, op[7:0]};
          compute_start <= 1'b1;
          @(posedge ap_clk);
          compute_start <= 1'b0;
          compute_instruction <= 32'd0;
      end
  endtask

  task automatic wait_done(output bit saw_error);
      begin
          while (!(compute_done && compute_done_ap_vld)) begin
              @(posedge ap_clk);
          end
          saw_error = error;
      end
  endtask

  task automatic run_test(input int op, input int tile, input bit expect_error, input string name);
      bit saw_error;
      begin
          clear_outputs_for_op(op);
          if (op == CMP_OUT_PROJ) begin
              load_out_proj_tile(tile);
          end
          issue_op(op, tile);
          wait_done(saw_error);
          if (saw_error !== expect_error) begin
              $display("ERROR: %s error mismatch got=%0d expected=%0d", name, saw_error, expect_error);
              errors++;
              return;
          end
          if (expect_error) begin
              $display("Test passed: %s (expected error)", name);
              return;
          end
          case (op)
              CMP_OUT_PROJ:  check_out_proj(tile);
              CMP_REQUANT1:  check_requant("REQUANT1");
              CMP_REQUANT3:  check_requant("REQUANT3");
              CMP_REQUANT4:  check_requant("REQUANT4");
              CMP_RESID0:    check_residual("RESID0");
              CMP_RESID1:    check_residual("RESID1");
              CMP_LN0:       check_layernorm("LN0");
              CMP_LN1:       check_layernorm("LN1");
              CMP_FFN_W1:    check_ffn_w1();
              CMP_FFN_ACT:   check_relu();
              CMP_FFN_W2:    check_ffn_w2();
              default: begin
              end
          endcase
          $display("Test passed: %s", name);
      end
  endtask

  // Initialize memory
  initial begin : init_mem
      int i;
      errors = 0;

      for (i = 0; i < D_MODEL; i = i + 1) begin
          int8_activation_mem[i] = $signed((i % 16) - 8);
          requant_activation_mem[i] = i % 32;
          layernorm_gamma_mem[i] = 0;
          layernorm_beta_mem[i] = 5;
          residual_mem[i] = $signed((i % 4) - 2);
          residual_out_mem[i] = 0;
          ffn2_output_mem[i] = 0;
      end

      for (i = 0; i < D_TILE_WO; i = i + 1) begin
          out_proj_bias_mem[i] = i - 2;
          out_proj_accum_mem[i] = 0;
      end

      for (i = 0; i < D_MODEL * D_TILE_WO; i = i + 1) begin
          out_proj_weights_mem[i] = 0;
      end

      for (i = 0; i < D_MODEL * D_TILE_W1; i = i + 1) begin
          ffn1_weights_mem[i] = 4'sd1;
      end
      for (i = 0; i < D_TILE_W1; i = i + 1) begin
          ffn1_biases_mem[i] = 0;
          ffn1_scale_mem[i] = 16'sd16384;
          ffn1_output_mem[i] = 0;
      end

      for (i = 0; i < D_FFN; i = i + 1) begin
          relu_input_mem[i] = $signed((i % 8) - 4);
          relu_output_mem[i] = 0;
          ffn2_input_mem[i] = $signed((i % 8) - 3);
      end

      for (i = 0; i < D_TILE_W2 * D_FFN; i = i + 1) begin
          ffn2_weights_mem[i] = 4'sd1;
      end
      for (i = 0; i < D_TILE_W2; i = i + 1) begin
          ffn2_biases_mem[i] = 0;
          ffn2_scale_mem[i] = 16'sd1;
      end

      for (i = 0; i < D_MODEL; i = i + 1) begin
          requant_output_mem[i] = 0;
          layernorm_out_mem[i] = 0;
      end
  end

  // Memory model for reads/writes
  always_ff @(posedge ap_clk) begin : memory_model
      if (ap_rst) begin
          int8_activation_q0 <= '0;
          int8_activation_q1 <= '0;
          OUT_PROJ_valueB_q0 <= '0;
          OUT_PROJ_valueB_q1 <= '0;
          OUT_PROJ_bias_q0 <= '0;
          OUT_PROJ_bias_q1 <= '0;
          FFN1_weights1_q0 <= '0;
          FFN1_weights1_q1 <= '0;
          FFN1_biases_q0 <= '0;
          FFN1_scale_q0 <= '0;
          RELU_input_q0 <= '0;
          FFN2_input_q0 <= '0;
          FFN2_input_q1 <= '0;
          FFN2_weights2_q0 <= '0;
          FFN2_weights2_q1 <= '0;
          FFN2_biases_q0 <= '0;
          FFN2_scale_q0 <= '0;
          requant_activation_q0 <= '0;
          requant_activation_q1 <= '0;
          layerNorm_gamma_q0 <= '0;
          layerNorm_gamma_q1 <= '0;
          layerNorm_beta_q0 <= '0;
          layerNorm_beta_q1 <= '0;
          residualAdd_residual_q0 <= '0;
          residualAdd_residual_q1 <= '0;
      end else begin
          if (int8_activation_ce0) begin
              int8_activation_q0 <= int8_activation_mem[int8_activation_address0];
          end
          if (int8_activation_ce1) begin
              int8_activation_q1 <= int8_activation_mem[int8_activation_address1];
          end

          if (OUT_PROJ_valueB_ce0) begin
              OUT_PROJ_valueB_q0 <= out_proj_weights_mem[OUT_PROJ_valueB_address0];
          end
          if (OUT_PROJ_valueB_ce1) begin
              OUT_PROJ_valueB_q1 <= out_proj_weights_mem[OUT_PROJ_valueB_address1];
          end

          if (OUT_PROJ_bias_ce0) begin
              OUT_PROJ_bias_q0 <= out_proj_bias_mem[OUT_PROJ_bias_address0];
          end
          if (OUT_PROJ_bias_ce1) begin
              OUT_PROJ_bias_q1 <= out_proj_bias_mem[OUT_PROJ_bias_address1];
          end

          if (FFN1_weights1_ce0) begin
              FFN1_weights1_q0 <= ffn1_weights_mem[FFN1_weights1_address0];
          end
          if (FFN1_weights1_ce1) begin
              FFN1_weights1_q1 <= ffn1_weights_mem[FFN1_weights1_address1];
          end

          if (FFN1_biases_ce0) begin
              FFN1_biases_q0 <= ffn1_biases_mem[FFN1_biases_address0];
          end

          if (FFN1_scale_ce0) begin
              FFN1_scale_q0 <= ffn1_scale_mem[FFN1_scale_address0];
          end

          if (RELU_input_ce0) begin
              RELU_input_q0 <= relu_input_mem[RELU_input_address0];
          end

          if (FFN2_input_ce0) begin
              FFN2_input_q0 <= ffn2_input_mem[FFN2_input_address0];
          end
          if (FFN2_input_ce1) begin
              FFN2_input_q1 <= ffn2_input_mem[FFN2_input_address1];
          end

          if (FFN2_weights2_ce0) begin
              FFN2_weights2_q0 <= ffn2_weights_mem[FFN2_weights2_address0];
          end
          if (FFN2_weights2_ce1) begin
              FFN2_weights2_q1 <= ffn2_weights_mem[FFN2_weights2_address1];
          end

          if (FFN2_biases_ce0) begin
              FFN2_biases_q0 <= ffn2_biases_mem[FFN2_biases_address0];
          end

          if (FFN2_scale_ce0) begin
              FFN2_scale_q0 <= ffn2_scale_mem[FFN2_scale_address0];
          end

          if (requant_activation_ce0) begin
              requant_activation_q0 <= requant_activation_mem[requant_activation_address0];
          end
          if (requant_activation_ce1) begin
              requant_activation_q1 <= requant_activation_mem[requant_activation_address1];
          end

          if (layerNorm_gamma_ce0) begin
              layerNorm_gamma_q0 <= layernorm_gamma_mem[layerNorm_gamma_address0];
          end
          if (layerNorm_gamma_ce1) begin
              layerNorm_gamma_q1 <= layernorm_gamma_mem[layerNorm_gamma_address1];
          end

          if (layerNorm_beta_ce0) begin
              layerNorm_beta_q0 <= layernorm_beta_mem[layerNorm_beta_address0];
          end
          if (layerNorm_beta_ce1) begin
              layerNorm_beta_q1 <= layernorm_beta_mem[layerNorm_beta_address1];
          end

          if (residualAdd_residual_ce0) begin
              residualAdd_residual_q0 <= residual_mem[residualAdd_residual_address0];
          end
          if (residualAdd_residual_ce1) begin
              residualAdd_residual_q1 <= residual_mem[residualAdd_residual_address1];
          end

          if (OUT_PROJ_accum_ce0 && OUT_PROJ_accum_we0) begin
              out_proj_accum_mem[OUT_PROJ_accum_address0] <= OUT_PROJ_accum_d0;
          end
          if (OUT_PROJ_accum_ce1 && OUT_PROJ_accum_we1) begin
              out_proj_accum_mem[OUT_PROJ_accum_address1] <= OUT_PROJ_accum_d1;
          end

          if (FFN1_output_ce0 && FFN1_output_we0) begin
              ffn1_output_mem[FFN1_output_address0] <= FFN1_output_d0;
          end

          if (RELU_output_ce0 && RELU_output_we0) begin
              relu_output_mem[RELU_output_address0] <= RELU_output_d0;
          end

          if (FFN2_output_ce0 && FFN2_output_we0) begin
              ffn2_output_mem[FFN2_output_address0] <= FFN2_output_d0;
          end

          if (requant_output_ce0 && requant_output_we0) begin
              requant_output_mem[requant_output_address0] <= requant_output_d0;
          end
          if (requant_output_ce1 && requant_output_we1) begin
              requant_output_mem[requant_output_address1] <= requant_output_d1;
          end

          if (layerNorm_out_ce0 && layerNorm_out_we0) begin
              layernorm_out_mem[layerNorm_out_address0] <= layerNorm_out_d0;
          end
          if (layerNorm_out_ce1 && layerNorm_out_we1) begin
              layernorm_out_mem[layerNorm_out_address1] <= layerNorm_out_d1;
          end

          if (residualAdd_output_ce0 && residualAdd_output_we0) begin
              residual_out_mem[residualAdd_output_address0] <= residualAdd_output_d0;
          end
          if (residualAdd_output_ce1 && residualAdd_output_we1) begin
              residual_out_mem[residualAdd_output_address1] <= residualAdd_output_d1;
          end
      end
  end

  always_ff @(posedge ap_clk) begin : mem_controller
      if (ap_rst) begin
          mem_transfer_done <= 0;
          mem_busy <= 1'b0;
          mem_timer <= 0;
          mem_pending <= MEM_NONE;
          pending_tile <= 0;
          pending_op <= 0;
      end else begin
          mem_transfer_done <= 1'b0;

          if (mem_busy) begin
              if (mem_timer == 0) begin
                  mem_transfer_done <= 1'b1;
                  mem_busy <= 1'b0;
                  if (mem_pending == MEM_READ) begin
                      if (pending_op == CMP_OUT_PROJ) begin
                          load_out_proj_tile(pending_tile);
                      end
                  end
                  mem_pending <= MEM_NONE;
              end else begin
                  mem_timer <= mem_timer - 1;
              end
          end else begin
              if (mem_read_request && mem_read_request_ap_vld && mem_op_ap_vld) begin
                  mem_busy <= 1'b1;
                  mem_timer <= MEM_LAT - 1;
                  mem_pending <= MEM_READ;
                  pending_tile <= mem_op[31:24];
                  pending_op <= mem_op[7:0];
              end else if (mem_write_request && mem_write_request_ap_vld && mem_op_ap_vld) begin
                  mem_busy <= 1'b1;
                  mem_timer <= MEM_LAT - 1;
                  mem_pending <= MEM_WRITE;
                  pending_tile <= mem_op[31:24];
                  pending_op <= mem_op[7:0];
              end
          end
      end
  end

  initial begin : stimulus
      int cycles;
      ap_start = 1'b0;
      ap_rst = 1'b1;
      reset = 1'b1;
      compute_start = 1'b0;
      compute_instruction = 32'd0;
      mem_transfer_done = 1'b0;
      mem_busy = 1'b0;
      mem_timer = 0;
      mem_pending = MEM_NONE;
      pending_tile = 0;
      pending_op = 0;

      requant_scale = 32'd1;
      requant_shift = 32'd1;
      requant_zero_point = 32'd0;
      layerNorm_epsilon = 32'd1;

      for (cycles = 0; cycles < RESET_HOLD_CYCLES; cycles = cycles + 1) begin
          @(posedge ap_clk);
      end
      ap_rst = 1'b0;
      reset = 1'b0;
      ap_start = 1'b1;

      run_test(CMP_OUT_PROJ, 0, 0, "OUT_PROJ");
      run_test(CMP_REQUANT1, 0, 0, "REQUANT1");
      run_test(CMP_RESID0, 0, 0, "RESID0");
      run_test(CMP_LN0, 0, 0, "LN0");
      run_test(CMP_REQUANT3, 0, 0, "REQUANT3");
      run_test(CMP_FFN_W1, 0, 0, "FFN_W1");
      run_test(CMP_FFN_ACT, 0, 0, "FFN_ACT");
      run_test(CMP_FFN_W2, 0, 0, "FFN_W2");
      run_test(CMP_REQUANT4, 0, 0, "REQUANT4");
      run_test(CMP_RESID1, 0, 0, "RESID1");
      run_test(CMP_LN1, 0, 0, "LN1");
      run_test(CMP_DEQUANT, 0, 1, "DEQUANT");
      run_test(CMP_LOGITS, 0, 1, "LOGITS");
      run_test(CMP_REQUANT2, 0, 1, "REQUANT2");

      if (errors == 0) begin
          $display("compute_controller_tb: PASS");
      end else begin
          $display("compute_controller_tb: FAIL (%0d errors)", errors);
      end
      $finish;
  end

  // DUT Instantiation
  compute_controller dut (
      .ap_clk(ap_clk),
      .ap_rst(ap_rst),
      .ap_start(ap_start),
      .ap_done(ap_done),
      .ap_idle(ap_idle),
      .ap_ready(ap_ready),
      .reset(reset),
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
      .int8_activation_address0(int8_activation_address0),
      .int8_activation_ce0(int8_activation_ce0),
      .int8_activation_q0(int8_activation_q0),
      .int8_activation_address1(int8_activation_address1),
      .int8_activation_ce1(int8_activation_ce1),
      .int8_activation_q1(int8_activation_q1),
      .OUT_PROJ_valueB_address0(OUT_PROJ_valueB_address0),
      .OUT_PROJ_valueB_ce0(OUT_PROJ_valueB_ce0),
      .OUT_PROJ_valueB_q0(OUT_PROJ_valueB_q0),
      .OUT_PROJ_valueB_address1(OUT_PROJ_valueB_address1),
      .OUT_PROJ_valueB_ce1(OUT_PROJ_valueB_ce1),
      .OUT_PROJ_valueB_q1(OUT_PROJ_valueB_q1),
      .OUT_PROJ_bias_address0(OUT_PROJ_bias_address0),
      .OUT_PROJ_bias_ce0(OUT_PROJ_bias_ce0),
      .OUT_PROJ_bias_q0(OUT_PROJ_bias_q0),
      .OUT_PROJ_bias_address1(OUT_PROJ_bias_address1),
      .OUT_PROJ_bias_ce1(OUT_PROJ_bias_ce1),
      .OUT_PROJ_bias_q1(OUT_PROJ_bias_q1),
      .OUT_PROJ_accum_address0(OUT_PROJ_accum_address0),
      .OUT_PROJ_accum_ce0(OUT_PROJ_accum_ce0),
      .OUT_PROJ_accum_we0(OUT_PROJ_accum_we0),
      .OUT_PROJ_accum_d0(OUT_PROJ_accum_d0),
      .OUT_PROJ_accum_address1(OUT_PROJ_accum_address1),
      .OUT_PROJ_accum_ce1(OUT_PROJ_accum_ce1),
      .OUT_PROJ_accum_we1(OUT_PROJ_accum_we1),
      .OUT_PROJ_accum_d1(OUT_PROJ_accum_d1),
      .FFN1_weights1_address0(FFN1_weights1_address0),
      .FFN1_weights1_ce0(FFN1_weights1_ce0),
      .FFN1_weights1_q0(FFN1_weights1_q0),
      .FFN1_weights1_address1(FFN1_weights1_address1),
      .FFN1_weights1_ce1(FFN1_weights1_ce1),
      .FFN1_weights1_q1(FFN1_weights1_q1),
      .FFN1_biases_address0(FFN1_biases_address0),
      .FFN1_biases_ce0(FFN1_biases_ce0),
      .FFN1_biases_q0(FFN1_biases_q0),
      .FFN1_scale_address0(FFN1_scale_address0),
      .FFN1_scale_ce0(FFN1_scale_ce0),
      .FFN1_scale_q0(FFN1_scale_q0),
      .FFN1_output_address0(FFN1_output_address0),
      .FFN1_output_ce0(FFN1_output_ce0),
      .FFN1_output_we0(FFN1_output_we0),
      .FFN1_output_d0(FFN1_output_d0),
      .RELU_input_address0(RELU_input_address0),
      .RELU_input_ce0(RELU_input_ce0),
      .RELU_input_q0(RELU_input_q0),
      .RELU_output_address0(RELU_output_address0),
      .RELU_output_ce0(RELU_output_ce0),
      .RELU_output_we0(RELU_output_we0),
      .RELU_output_d0(RELU_output_d0),
      .FFN2_input_address0(FFN2_input_address0),
      .FFN2_input_ce0(FFN2_input_ce0),
      .FFN2_input_q0(FFN2_input_q0),
      .FFN2_input_address1(FFN2_input_address1),
      .FFN2_input_ce1(FFN2_input_ce1),
      .FFN2_input_q1(FFN2_input_q1),
      .FFN2_weights2_address0(FFN2_weights2_address0),
      .FFN2_weights2_ce0(FFN2_weights2_ce0),
      .FFN2_weights2_q0(FFN2_weights2_q0),
      .FFN2_weights2_address1(FFN2_weights2_address1),
      .FFN2_weights2_ce1(FFN2_weights2_ce1),
      .FFN2_weights2_q1(FFN2_weights2_q1),
      .FFN2_biases_address0(FFN2_biases_address0),
      .FFN2_biases_ce0(FFN2_biases_ce0),
      .FFN2_biases_q0(FFN2_biases_q0),
      .FFN2_scale_address0(FFN2_scale_address0),
      .FFN2_scale_ce0(FFN2_scale_ce0),
      .FFN2_scale_q0(FFN2_scale_q0),
      .FFN2_output_address0(FFN2_output_address0),
      .FFN2_output_ce0(FFN2_output_ce0),
      .FFN2_output_we0(FFN2_output_we0),
      .FFN2_output_d0(FFN2_output_d0),
      .requant_activation_address0(requant_activation_address0),
      .requant_activation_ce0(requant_activation_ce0),
      .requant_activation_q0(requant_activation_q0),
      .requant_activation_address1(requant_activation_address1),
      .requant_activation_ce1(requant_activation_ce1),
      .requant_activation_q1(requant_activation_q1),
      .requant_scale(requant_scale),
      .requant_shift(requant_shift),
      .requant_zero_point(requant_zero_point),
      .requant_output_address0(requant_output_address0),
      .requant_output_ce0(requant_output_ce0),
      .requant_output_we0(requant_output_we0),
      .requant_output_d0(requant_output_d0),
      .requant_output_address1(requant_output_address1),
      .requant_output_ce1(requant_output_ce1),
      .requant_output_we1(requant_output_we1),
      .requant_output_d1(requant_output_d1),
      .layerNorm_gamma_address0(layerNorm_gamma_address0),
      .layerNorm_gamma_ce0(layerNorm_gamma_ce0),
      .layerNorm_gamma_q0(layerNorm_gamma_q0),
      .layerNorm_gamma_address1(layerNorm_gamma_address1),
      .layerNorm_gamma_ce1(layerNorm_gamma_ce1),
      .layerNorm_gamma_q1(layerNorm_gamma_q1),
      .layerNorm_beta_address0(layerNorm_beta_address0),
      .layerNorm_beta_ce0(layerNorm_beta_ce0),
      .layerNorm_beta_q0(layerNorm_beta_q0),
      .layerNorm_beta_address1(layerNorm_beta_address1),
      .layerNorm_beta_ce1(layerNorm_beta_ce1),
      .layerNorm_beta_q1(layerNorm_beta_q1),
      .layerNorm_epsilon(layerNorm_epsilon),
      .layerNorm_out_address0(layerNorm_out_address0),
      .layerNorm_out_ce0(layerNorm_out_ce0),
      .layerNorm_out_we0(layerNorm_out_we0),
      .layerNorm_out_d0(layerNorm_out_d0),
      .layerNorm_out_address1(layerNorm_out_address1),
      .layerNorm_out_ce1(layerNorm_out_ce1),
      .layerNorm_out_we1(layerNorm_out_we1),
      .layerNorm_out_d1(layerNorm_out_d1),
      .residualAdd_residual_address0(residualAdd_residual_address0),
      .residualAdd_residual_ce0(residualAdd_residual_ce0),
      .residualAdd_residual_q0(residualAdd_residual_q0),
      .residualAdd_residual_address1(residualAdd_residual_address1),
      .residualAdd_residual_ce1(residualAdd_residual_ce1),
      .residualAdd_residual_q1(residualAdd_residual_q1),
      .residualAdd_output_address0(residualAdd_output_address0),
      .residualAdd_output_ce0(residualAdd_output_ce0),
      .residualAdd_output_we0(residualAdd_output_we0),
      .residualAdd_output_d0(residualAdd_output_d0),
      .residualAdd_output_address1(residualAdd_output_address1),
      .residualAdd_output_ce1(residualAdd_output_ce1),
      .residualAdd_output_we1(residualAdd_output_we1),
      .residualAdd_output_d1(residualAdd_output_d1),
      .error(error),
      .error_ap_vld(error_ap_vld)
  );

endmodule
