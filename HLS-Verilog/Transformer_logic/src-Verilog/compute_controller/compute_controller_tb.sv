`timescale 1ns/1ps

module compute_controller_tb;

  // Parameters
    localparam int NUM_HEADS       = 4;
    localparam int NUM_LAYERS      = 2;
    localparam int NUM_WO_TILES    = 4;
    localparam int NUM_W1_TILES    = 4;
    localparam int NUM_W2_TILES    = 4;
    localparam int NUM_LOGIT_TILES = 2;

    localparam int D_MODEL = 16; // Number of heads processed in parallel
    localparam int D_FFN   = 22; // Feed-Forward hidden layer size
    localparam int D_HEADS = D_MODEL / NUM_HEADS; // Number of heads processed in parallel
    localparam int D_TILE_WO  = D_MODEL / NUM_WO_TILES; // Tile size for WO
    localparam int D_TILE_W1  = D_MODEL / NUM_W1_TILES; // Tile size for W1
    localparam int D_TILE_W2  = D_FFN   / NUM_W2_TILES;
    localparam int CONTEXT_LENGTH = 16; // Context window length
    localparam int VECTOR_MAX = (D_MODEL > D_FFN) ? D_MODEL : D_FFN;
    localparam int ACCUM_MAX = (D_TILE_WO > D_TILE_W1)
                               ? ((D_TILE_WO > D_TILE_W2) ? D_TILE_WO : D_TILE_W2)
                               : ((D_TILE_W1 > D_TILE_W2) ? D_TILE_W1 : D_TILE_W2);
    localparam int MATRIX_MAX = VECTOR_MAX * ACCUM_MAX;
    localparam int DBG_VECTOR_AW = (VECTOR_MAX > 1) ? $clog2(VECTOR_MAX) : 1;
    localparam int DBG_ACCUM_AW = (ACCUM_MAX > 1) ? $clog2(ACCUM_MAX) : 1;
    localparam int DBG_MATRIX_AW = (MATRIX_MAX > 1) ? $clog2(MATRIX_MAX) : 1;

    // Match compute_buf sizes from top_params.hpp for D_MODEL=16/D_FFN=22.
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

    localparam int CLK_PERIOD = 10; // in nanoseconds
    localparam int MAX_CYCLES = 8000;


    // localparam logic [7:0] CMP_NONE        = 8'h00;
    // localparam logic [7:0] CMP_Q           = 8'h01;
    // localparam logic [7:0] CMP_K           = 8'h02;
    // localparam logic [7:0] CMP_K_REQUANT   = 8'h03;
    // localparam logic [7:0] CMP_V           = 8'h04;
    // localparam logic [7:0] CMP_V_REQUANT   = 8'h05;
    // localparam logic [7:0] CMP_REQUANT_Q   = 8'h06;
    // localparam logic [7:0] CMP_ATT_SCORES  = 8'h07;
    // localparam logic [7:0] CMP_VALUE_SCALE = 8'h08;
    // localparam logic [7:0] CMP_SOFTMAX     = 8'h09;
    // localparam logic [7:0] CMP_ATT_VALUE   = 8'h0A;
    // localparam logic [7:0] CMP_HEAD_REQUANT = 8'h0B;
    // localparam logic [7:0] CMP_RESV_0C      = 8'h0C;
    // localparam logic [7:0] CMP_CONCAT      = 8'h0D;


    // Align opcodes with top_params.hpp ComputeOp enum.
    localparam logic [7:0] CMP_OUT_PROJ    = 8'h0F;
    localparam logic [7:0] CMP_REQUANT1    = 8'h0F;
    localparam logic [7:0] CMP_RESID0      = 8'h10;
    localparam logic [7:0] CMP_LN0         = 8'h11;
    localparam logic [7:0] CMP_REQUANT3    = 8'h12;
    localparam logic [7:0] CMP_FFN_W1      = 8'h13;
    localparam logic [7:0] CMP_FFN_ACT     = 8'h14;
    localparam logic [7:0] CMP_FFN_W2      = 8'h15;
    localparam logic [7:0] CMP_REQUANT4    = 8'h16;
    localparam logic [7:0] CMP_RESID1      = 8'h17;
    localparam logic [7:0] CMP_LN1         = 8'h18;
    localparam logic [7:0] CMP_DEQUANT     = 8'h19;
    localparam logic [7:0] CMP_LOGITS      = 8'h1A;
    localparam logic [7:0] CMP_LN0_SUM     = 8'h1B;
    localparam logic [7:0] CMP_LN0_SUMSQ   = 8'h1C;
    localparam logic [7:0] CMP_LN0_MEAN    = 8'h1D;
    localparam logic [7:0] CMP_LN0_EYY     = 8'h1E;
    localparam logic [7:0] CMP_LN0_VAR     = 8'h1F;
    localparam logic [7:0] CMP_LN0_VAR_EPS = 8'h20;
    localparam logic [7:0] CMP_LN0_INV_STD = 8'h21;
    localparam logic [7:0] CMP_LN0_NORM    = 8'h22;
    localparam logic [7:0] CMP_LN0_SCALE   = 8'h23;
    localparam logic [7:0] CMP_LN0_SHIFT   = 8'h24;
    localparam logic [7:0] CMP_LN1_SUM     = 8'h25;
    localparam logic [7:0] CMP_LN1_SUMSQ   = 8'h26;
    localparam logic [7:0] CMP_LN1_MEAN    = 8'h27;
    localparam logic [7:0] CMP_LN1_EYY     = 8'h28;
    localparam logic [7:0] CMP_LN1_VAR     = 8'h29;
    localparam logic [7:0] CMP_LN1_VAR_EPS = 8'h2A;
    localparam logic [7:0] CMP_LN1_INV_STD = 8'h2B;
    localparam logic [7:0] CMP_LN1_NORM    = 8'h2C;
    localparam logic [7:0] CMP_LN1_SCALE   = 8'h2D;
    localparam logic [7:0] CMP_LN1_SHIFT   = 8'h2E;



    // Signals
    logic ap_clk = 1'b0;
    logic ap_rst = 1'b1;
    always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

    logic [31:0]OUT_PROJ_counter = 0;
    logic done_seen = 1'b0;
    typedef enum logic [1:0] {
        SETUP           =   2'b00,
        OUT_PROJ_SEND  = 2'b01,
        OUTPROJ_WAIT   = 2'b10,
        DONE            = 2'b11
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
    int pending_tile;
    int mem_done_hold;

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
    logic dbg_mac_start;
    logic dbg_mac_start_ap_vld;
    logic dbg_mac_ready;
    logic dbg_mac_ready_ap_vld;
    logic dbg_mac_complete;
    logic dbg_mac_complete_ap_vld;
    logic [7:0] dbg_state_lat;
    logic [31:0] dbg_req_instruction_lat;
    logic [7:0] dbg_req_op_lat;
    logic [7:0] dbg_req_layer_lat;
    logic [7:0] dbg_req_head_lat;
    logic [7:0] dbg_req_tile_lat;
    logic dbg_mac_start_lat;
    logic dbg_mac_ready_lat;
    logic dbg_mac_complete_lat;
    logic [DBG_VECTOR_AW-1:0] dbg_vectorA_address0;
    logic dbg_vectorA_ce0;
    logic dbg_vectorA_we0;
    logic [15:0] dbg_vectorA_d0;
    logic [DBG_VECTOR_AW-1:0] dbg_vectorA_address1;
    logic dbg_vectorA_ce1;
    logic dbg_vectorA_we1;
    logic [15:0] dbg_vectorA_d1;
    logic [DBG_MATRIX_AW-1:0] dbg_matrixB_address0;
    logic dbg_matrixB_ce0;
    logic dbg_matrixB_we0;
    logic [3:0] dbg_matrixB_d0;
    logic [DBG_MATRIX_AW-1:0] dbg_matrixB_address1;
    logic dbg_matrixB_ce1;
    logic dbg_matrixB_we1;
    logic [3:0] dbg_matrixB_d1;
    logic [DBG_ACCUM_AW-1:0] dbg_bias_address0;
    logic dbg_bias_ce0;
    logic dbg_bias_we0;
    logic [3:0] dbg_bias_d0;
    logic [DBG_ACCUM_AW-1:0] dbg_bias_address1;
    logic dbg_bias_ce1;
    logic dbg_bias_we1;
    logic [3:0] dbg_bias_d1;
    logic [DBG_ACCUM_AW-1:0] dbg_out_address0;
    logic dbg_out_ce0;
    logic dbg_out_we0;
    logic [31:0] dbg_out_d0;
    logic [DBG_ACCUM_AW-1:0] dbg_out_address1;
    logic dbg_out_ce1;
    logic dbg_out_we1;
    logic [31:0] dbg_out_d1;

    // Simple memory model for OUT_PROJ inputs/outputs.
    logic [7:0] full_valueA [0:D_MODEL-1];
    logic [3:0] full_weights [0:D_MODEL*D_MODEL-1];
    logic [31:0] full_bias [0:D_MODEL-1];
    logic [31:0] full_accum [0:D_MODEL-1];
    logic [7:0] in_buf_mem [0:IN_BUF_BYTES-1];
    logic [7:0] out_buf_mem [0:OUT_BUF_BYTES-1];


    // Responses we need:
    /*
      FSM sending:
        1. Send Compute Request
        2. Wait for Compute Done
      Memory Controller Sending:
        1. Respond to mem_read requests (ie provide data for reads)
        2. Respond to mem_write requests (ie write data to memory)
          (1 and 2 recieve mem_op along side these signals. Memory Manager must respond with proper data from request) 
    */

    // Assumptions:
    /*
      FSM:
        1. Sends ONLY the compute_start and compute_instruction signals to start a compute operation
        2. Waits for compute_done signal to indicate operation is complete
        3. See's MAC as a BBOX, and does not interact with the memory controller directly within this stage
      Memory Controller:
        1. Knows the size and type of data base ONLY on the memory operation (mem_op)
        2. Does not know what operations are used for, but must obey the requests from the compute controller
    */

    // Iniitializing memory
    initial begin : init_mem
      int i;
      int t;
      int j;

      for (i = 0; i < D_MODEL; i = i + 1) begin
        full_valueA[i] = 8'h7f;
        full_bias[i] = 32'd7;
        full_accum[i] = 32'd0;
      end

      for (t = 0; t < D_MODEL; t = t + 1) begin
        for (j = 0; j < D_MODEL; j = j + 1) begin
          full_weights[t * D_MODEL + j] = 4'h7;
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

    function automatic logic [31:0] read_i32_from_out_buf(input int byte_addr);
      read_i32_from_out_buf = {out_buf_mem[byte_addr + 3],
                               out_buf_mem[byte_addr + 2],
                               out_buf_mem[byte_addr + 1],
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
        dbg_mac_start_lat <= 1'b0;
        dbg_mac_ready_lat <= 1'b0;
        dbg_mac_complete_lat <= 1'b0;
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
        if (dbg_mac_start_ap_vld) begin
          dbg_mac_start_lat <= dbg_mac_start;
        end
        if (dbg_mac_ready_ap_vld) begin
          dbg_mac_ready_lat <= dbg_mac_ready;
        end
        if (dbg_mac_complete_ap_vld) begin
          dbg_mac_complete_lat <= dbg_mac_complete;
        end
      end
    end

    always_ff @(posedge ap_clk) begin : MEM_controller_respond
    
      if (ap_rst) begin
        mem_transfer_done <= 0;
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
              for (j = 0; j < IN_BUF_BYTES; j = j + 1) begin
                in_buf_mem[j] = 8'd0;
              end

              case (mem_op[7:0])
                CMP_OUT_PROJ: begin
                  for (j = 0; j < D_MODEL; j = j + 1) begin
                    in_buf_mem[OUT_PROJ_ACT_OFFSET + j] = full_valueA[j];
                  end
                  if ((pending_tile >= 0) && (pending_tile < NUM_WO_TILES)) begin
                    out_base = pending_tile * D_TILE_WO;
                    for (t = 0; t < D_TILE_WO; t = t + 1) begin
                      for (j = 0; j < D_MODEL; j = j + 1) begin
                        write_i4_to_in_buf(
                          (OUT_PROJ_W_OFFSET * 2) + (t * D_MODEL) + j,
                          full_weights[(out_base + t) * D_MODEL + j]);
                      end
                    end
                    for (t = 0; t < D_TILE_WO; t = t + 1) begin
                      write_i32_to_in_buf(
                        OUT_PROJ_B_OFFSET + (t * 4),
                        full_bias[out_base + t]);
                    end
                  end
                end
                default: begin
                end
              endcase
            end else if (mem_pending == MEM_WRITE) begin
              int out_base;
              int t;
              if ((pending_tile >= 0) && (pending_tile < NUM_WO_TILES)) begin
                out_base = pending_tile * D_TILE_WO;
                for (t = 0; t < D_TILE_WO; t = t + 1) begin
                  full_accum[out_base + t] <= read_i32_from_out_buf(t * 4);
                end
              end
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
            pending_tile <= mem_op[31:24];
          end else if (mem_write_request) begin
            mem_busy <= 1'b1;
            mem_timer <= MEM_LAT - 1;
            mem_pending <= MEM_WRITE;
            pending_tile <= mem_op[31:24];
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
              // Initialize signals
              OUT_PROJ_counter <= 0;
              done_seen <= 1'b0;
              compute_start <= 1'b0;
              if (reset_hold_ctr >= (RESET_HOLD_CYCLES - 1)) begin
                  ap_rst <= 1'b0;
                  ap_start <= 1'b1;
                  reset <= 1'b0;
                  compute_state <= OUT_PROJ_SEND;
              end else begin
                  ap_rst <= 1'b1;
                  ap_start <= 1'b0;
                  reset <= 1'b1;
                  reset_hold_ctr <= reset_hold_ctr + 1;
              end
          end
          OUT_PROJ_SEND: begin
              // Initialize signals for OUT_PROJ send
              reset <= 0;
              if (compute_ready) begin
                  compute_start <= 1;
                  // Instruction format: [31:24]=tile [23:16]=head [15:8]=layer [7:0]=op
                  // Match HLS TB defaults: layer=1, head=-1 (0xFF), tile=counter.
                  compute_instruction <= {OUT_PROJ_counter[7:0], 8'hFF, 8'h01, CMP_OUT_PROJ};
                  compute_state <= OUTPROJ_WAIT;
              end
          end
          OUTPROJ_WAIT: begin
            if (OUT_PROJ_counter == NUM_WO_TILES) begin
              compute_state <= DONE;
            end
            if (done_seen && OUT_PROJ_counter < NUM_WO_TILES) begin
              OUT_PROJ_counter <= OUT_PROJ_counter + 1;
              compute_state <= OUT_PROJ_SEND;
              done_seen <= 1'b0;
            end
          end
          DONE: begin
              // Finish simulation
              $finish;
          end
      endcase
    end

    initial begin : stimulus
      int cycles = 0;
      // Default inputs to the DUT.
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

      for(cycles = 0; cycles < MAX_CYCLES; cycles++) begin
        @(posedge ap_clk);
        

        if (compute_state == DONE) begin
          $display("Testbench completed after %0d cycles.", cycles);
          $finish;
        end

        if (error_ap_vld && error) begin
          $display("ERROR: compute_controller asserted error at cycle %0d (instr=0x%08x).", cycles, dbg_req_instruction_lat);
          $finish;
        end

        $display("cycle=%0d state=%0d req_instr=0x%08x req_op=0x%02x req_layer=%0d req_head=%0d req_tile=%0d mac_start=%0d mac_ready=%0d mac_complete=%0d",
                 cycles,
                 dbg_state_lat,
                 dbg_req_instruction_lat,
                 dbg_req_op_lat,
                 dbg_req_layer_lat,
                 $signed(dbg_req_head_lat),
                 $signed(dbg_req_tile_lat),
                 dbg_mac_start_lat,
                 dbg_mac_ready_lat,
                 dbg_mac_complete_lat);
      end
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
        .dbg_mac_start(dbg_mac_start),
        .dbg_mac_start_ap_vld(dbg_mac_start_ap_vld),
        .dbg_mac_ready(dbg_mac_ready),
        .dbg_mac_ready_ap_vld(dbg_mac_ready_ap_vld),
        .dbg_mac_complete(dbg_mac_complete),
        .dbg_mac_complete_ap_vld(dbg_mac_complete_ap_vld),
        .error(error),
        .error_ap_vld(error_ap_vld)
    );


endmodule
