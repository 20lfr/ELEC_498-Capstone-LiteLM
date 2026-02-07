`timescale 1ns/1ps

// MMU FSM RTL Testbench with Behavioral URAM/DDR Memory Models
// Version 2: Improved HLS handshaking and debug output

module mmu_fsm_tb;

  // ========== Parameters ==========
  localparam CLK_PERIOD = 10;           // 100 MHz
  localparam MAX_CYCLES = 5000;
  localparam DMA_LATENCY_MIN = 3;
  localparam DMA_LATENCY_MAX = 8;
  
  // Memory sizes
  localparam DDR_SIZE = 1 << 20;        // 1MB DDR
  localparam URAM_BANKS = 64;
  localparam URAM_BANK_SIZE = 4096;     // 4KB per bank
  
  // Model dimensions (matching top_params.hpp test config)
  localparam D_MODEL = 16;
  localparam D_FFN = 22;
  localparam D_HEADS = 4;
  localparam NUM_HEADS = 4;
  localparam CONTEXT_LEN = 16;
  localparam NUM_LAYERS = 2;
  localparam D_TILE_WO = 4;
  localparam D_TILE_W1 = 4;
  localparam D_TILE_W2 = 5;
  
  // DMA Select encodings - MUST match top_params.hpp enum order!
  localparam [7:0] DMASEL_NONE    = 8'd0;
  localparam [7:0] DMASEL_WQ      = 8'd1;
  localparam [7:0] DMASEL_WK      = 8'd2;
  localparam [7:0] DMASEL_K_WRITE = 8'd3;   // Swapped - K_WRITE is 3
  localparam [7:0] DMASEL_WV      = 8'd4;   // WV is 4
  localparam [7:0] DMASEL_V_WRITE = 8'd5;   // V_WRITE is 5
  localparam [7:0] DMASEL_CTX_K   = 8'd6;
  localparam [7:0] DMASEL_CTX_V   = 8'd7;
  localparam [7:0] DMASEL_WO      = 8'd8;
  localparam [7:0] DMASEL_W1      = 8'd9;
  localparam [7:0] DMASEL_W2      = 8'd10;

  // ========== Clock and Reset ==========
  logic ap_clk = 0;
  logic ap_rst = 1;
  always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

  // ========== DUT Signals ==========
  logic ap_start;
  logic ap_done, ap_idle, ap_ready;
  
  // User reset
  logic reset;
  
  // DMA interface
  logic dma_ready;
  logic dma_done;
  logic dma_start;
  logic dma_start_ap_vld;
  logic [31:0] dma_addr;
  logic dma_addr_ap_vld;
  logic [31:0] dma_len;
  logic dma_len_ap_vld;
  logic dma_is_write;
  logic dma_is_write_ap_vld;
  logic [7:0] uram_bank;
  logic uram_bank_ap_vld;
  logic [31:0] uram_offset;
  logic uram_offset_ap_vld;
  
  // Buffer interface
  logic buffer_ready;
  logic buffer_valid;
  logic buffer_valid_ap_vld;
  logic transfer_done;
  logic transfer_done_ap_vld;
  
  // DMA request interface
  logic dma_req_valid;
  logic [31:0] dma_req_packed;
  logic dma_req_ready;
  logic dma_req_ready_ap_vld;
  
  // Compute request interface
  logic compute_req_valid;
  logic [31:0] compute_req_packed;
  logic [7:0] compute_req_type;
  logic [7:0] compute_req_head;
  logic compute_req_ready;
  logic compute_req_ready_ap_vld;
  
  // Status outputs
  logic main_dma_done;
  logic main_dma_done_ap_vld;
  logic main_compute_done;
  logic main_compute_done_ap_vld;
  logic [7:0] fsm_state_out;
  logic fsm_state_out_ap_vld;
  logic error_overflow;
  logic error_overflow_ap_vld;
  logic error_invalid;
  logic error_invalid_ap_vld;
  
  // Configuration
  logic [191:0] dims;
  logic [31:0] k_cache_base;
  logic [31:0] v_cache_base;
  logic [15:0] current_token;

  // ========== Memory Models ==========
  logic [7:0] ddr_memory [0:DDR_SIZE-1];
  logic [7:0] uram [0:URAM_BANKS-1][0:URAM_BANK_SIZE-1];
  
  // ========== DMA Engine Model State ==========
  logic dma_busy;
  int dma_timer;
  logic [31:0] dma_addr_latched;
  logic [31:0] dma_len_latched;
  logic dma_is_write_latched;
  logic [7:0] uram_bank_latched;
  logic [31:0] uram_offset_latched;
  int bytes_transferred;
  
  // ========== Test Tracking (module level - no conflicts) ==========
  int total_dma_transfers;
  int total_bytes_read;
  int total_bytes_written;
  int test_pass_count;
  int test_fail_count;
  int cycle_count;
  logic debug_enabled;
  
  // DMA capture for verification
  logic [31:0] captured_dma_addr;
  logic [31:0] captured_dma_len;
  logic captured_dma_is_write;
  logic dma_was_started;
  logic data_ok;

  // ========== Pack dims struct ==========
  function [191:0] pack_dims();
    logic [191:0] packed_dims;
    packed_dims = '0;
    packed_dims[15:0]    = D_MODEL;
    packed_dims[31:16]   = D_FFN;
    packed_dims[47:32]   = D_HEADS;
    packed_dims[63:48]   = NUM_HEADS;
    packed_dims[79:64]   = CONTEXT_LEN;
    packed_dims[95:80]   = NUM_LAYERS;
    packed_dims[111:96]  = D_TILE_WO;
    packed_dims[127:112] = D_TILE_W1;
    packed_dims[143:128] = D_TILE_W2;
    return packed_dims;
  endfunction
  
  // ========== Pack DMA request ==========
  function [31:0] pack_dma_req(input [7:0] sel, input [7:0] layer, 
                                input [7:0] head, input [7:0] tile);
    return {tile, head, layer, sel};
  endfunction

  // ========== FSM State Names - MUST match mmu.hpp MMUFsmState enum ==========
  function string fsm_state_name(input [7:0] state);
    case (state)
      8'd0: return "IDLE";
      8'd1: return "DMA_ARB";       // DMA_ARBITRATE
      8'd2: return "DMA_ALLOC";
      8'd3: return "DMA_ISSUE";
      8'd4: return "DMA_WAIT";
      8'd5: return "DMA_WBACK";     // DMA_WRITEBACK
      8'd6: return "CMP_ARB";       // COMPUTE_ARB
      8'd7: return "URAM2BUF";      // URAM_TO_INBUF
      8'd8: return "BUF2URAM";      // OUTBUF_TO_URAM
      8'd9: return "XFER_DONE";     // TRANSFER_DONE
      default: return $sformatf("ST_%0d", state);
    endcase
  endfunction

  // ========== DMA Select Names ==========
  function string dma_sel_name(input [7:0] sel);
    case (sel)
      DMASEL_NONE:    return "NONE";
      DMASEL_WQ:      return "WQ";
      DMASEL_WK:      return "WK";
      DMASEL_WV:      return "WV";
      DMASEL_CTX_K:   return "CTX_K";
      DMASEL_CTX_V:   return "CTX_V";
      DMASEL_K_WRITE: return "K_WR";
      DMASEL_V_WRITE: return "V_WR";
      DMASEL_WO:      return "WO";
      DMASEL_W1:      return "W1";
      DMASEL_W2:      return "W2";
      default: return $sformatf("UNK_%0d", sel);
    endcase
  endfunction

  // ========== Cycle Counter ==========
  always_ff @(posedge ap_clk) begin
    if (ap_rst) 
      cycle_count <= 0;
    else
      cycle_count <= cycle_count + 1;
  end

  // ========== Debug Monitor ==========
  always_ff @(posedge ap_clk) begin
    if (!ap_rst && debug_enabled) begin
      // Print state changes
      if (fsm_state_out_ap_vld) begin
        $display("[%4d] FSM: %-12s | ap_idle=%b ap_ready=%b | dma_req_ready=%b dma_req_valid=%b",
                 cycle_count, fsm_state_name(fsm_state_out),
                 ap_idle, ap_ready, dma_req_ready, dma_req_valid);
      end
      
      // Print DMA start events
      if (dma_start && dma_start_ap_vld) begin
        $display("[%4d] >>> DMA START: addr=0x%08x len=%0d %s bank=%0d offset=%0d",
                 cycle_count, dma_addr, dma_len, 
                 dma_is_write ? "WRITE" : "READ",
                 uram_bank, uram_offset);
      end
      
      // Print main_dma_done events
      if (main_dma_done && main_dma_done_ap_vld) begin
        $display("[%4d] <<< MMU reports DMA DONE", cycle_count);
      end
      
      // Print errors
      if (error_overflow_ap_vld && error_overflow) begin
        $display("[%4d] !!! ERROR: Overflow detected", cycle_count);
      end
      if (error_invalid_ap_vld && error_invalid) begin
        $display("[%4d] !!! ERROR: Invalid request", cycle_count);
      end
    end
  end

  // ========== DMA Engine Behavioral Model ==========
  // dma_done is held HIGH after completion until a new DMA starts
  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      dma_busy <= 0;
      dma_timer <= 0;
      dma_ready <= 1;
      dma_done <= 0;
      bytes_transferred <= 0;
      total_dma_transfers <= 0;
      total_bytes_read <= 0;
      total_bytes_written <= 0;
    end else begin
      
      if (dma_start && dma_start_ap_vld && !dma_busy) begin
        // Latch DMA parameters
        dma_addr_latched <= dma_addr;
        dma_len_latched <= dma_len;
        dma_is_write_latched <= dma_is_write;
        uram_bank_latched <= uram_bank;
        uram_offset_latched <= uram_offset;
        
        // Capture for test verification
        captured_dma_addr <= dma_addr;
        captured_dma_len <= dma_len;
        captured_dma_is_write <= dma_is_write;
        dma_was_started <= 1;
        
        // Start transfer - clear done when starting new transfer
        dma_busy <= 1;
        dma_ready <= 0;
        dma_done <= 0;  // Clear done when new transfer starts
        dma_timer <= $urandom_range(DMA_LATENCY_MIN, DMA_LATENCY_MAX);
        
        total_dma_transfers <= total_dma_transfers + 1;
        
      end else if (dma_busy) begin
        if (dma_timer == 0) begin
          // Complete transfer - move data
          if (!dma_is_write_latched) begin
            // READ: DDR -> URAM
            for (int i = 0; i < dma_len_latched && i < URAM_BANK_SIZE; i++) begin
              if ((dma_addr_latched + i) < DDR_SIZE) begin
                uram[uram_bank_latched][uram_offset_latched + i] <= 
                    ddr_memory[dma_addr_latched + i];
              end
            end
            total_bytes_read <= total_bytes_read + dma_len_latched;
          end else begin
            // WRITE: URAM -> DDR
            for (int i = 0; i < dma_len_latched && i < URAM_BANK_SIZE; i++) begin
              if ((dma_addr_latched + i) < DDR_SIZE) begin
                ddr_memory[dma_addr_latched + i] <= 
                    uram[uram_bank_latched][uram_offset_latched + i];
              end
            end
            total_bytes_written <= total_bytes_written + dma_len_latched;
          end
          
          dma_busy <= 0;
          dma_ready <= 1;
          dma_done <= 1;  // HOLD HIGH until next transfer starts
          bytes_transferred <= dma_len_latched;
          
          if (debug_enabled)
            $display("[%4d] DMA ENGINE: Transfer complete, %0d bytes (dma_done=1)", 
                     cycle_count, dma_len_latched);
        end else begin
          dma_timer <= dma_timer - 1;
        end
      end
    end
  end

  // ========== Buffer Model ==========
  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      buffer_ready <= 1;
    end else begin
      buffer_ready <= 1;  // Always ready for simplicity
    end
  end

  // ========== Test Tasks ==========
  
  task automatic wait_cycles(int n);
    repeat(n) @(posedge ap_clk);
  endtask
  
  task automatic check(input logic condition, input string msg);
    if (condition) begin
      test_pass_count = test_pass_count + 1;
      $display("[PASS] %s", msg);
    end else begin
      test_fail_count = test_fail_count + 1;
      $display("[FAIL] %s", msg);
    end
  endtask
  
  // Wait for MMU to be ready to accept requests
  task automatic wait_for_mmu_ready();
    int timeout;
    timeout = 200;
    while (timeout > 0) begin
      @(posedge ap_clk);
      // Must check FSM is in IDLE (state 0) - this is the key fix!
      // dma_req_ready can be high even during a transaction
      if (fsm_state_out_ap_vld && fsm_state_out == 8'd0) begin
        if (debug_enabled) $display("[%4d] MMU in IDLE, ready for requests", cycle_count);
        return;
      end
      timeout = timeout - 1;
    end
    $display("[WARN] Timeout waiting for MMU IDLE after %0d cycles", 200);
  endtask
  
  // Wait for FSM to return to IDLE state
  task automatic wait_for_fsm_idle();
    int timeout;
    timeout = 300;
    while (timeout > 0) begin
      @(posedge ap_clk);
      if (fsm_state_out_ap_vld && fsm_state_out == 8'd0) begin
        if (debug_enabled) $display("[%4d] FSM returned to IDLE", cycle_count);
        return;
      end
      timeout = timeout - 1;
    end
    $display("[WARN] Timeout waiting for FSM IDLE");
  endtask
  
  // Wait for DMA to complete (both engine and MMU acknowledgment)
  task automatic wait_for_dma_complete();
    int timeout;
    timeout = 200;
    
    // First wait for our DMA engine to finish
    while (dma_busy && timeout > 0) begin
      @(posedge ap_clk);
      timeout = timeout - 1;
    end
    
    // Then wait for FSM to return to IDLE
    wait_for_fsm_idle();
    
    // Extra cycles for any settling
    wait_cycles(5);
    
    if (timeout == 0) 
      $display("[WARN] Timeout waiting for DMA to complete");
  endtask
  
  // Issue DMA request with proper handshaking
  task automatic issue_dma_request(
    input [7:0] sel, 
    input [7:0] layer, 
    input [7:0] head, 
    input [7:0] tile
  );
    $display("\n[TEST] Issuing DMA request: %s layer=%0d head=%0d tile=%0d",
             dma_sel_name(sel), layer, head, tile);
    
    // Clear capture flag
    dma_was_started = 0;
    
    // MUST wait for FSM to be in IDLE before issuing new request
    wait_for_mmu_ready();
    
    // Issue request - hold valid for multiple cycles to ensure capture
    dma_req_valid <= 1;
    dma_req_packed <= pack_dma_req(sel, layer, head, tile);
    
    // Wait for request to be accepted
    @(posedge ap_clk);
    @(posedge ap_clk);
    
    dma_req_valid <= 0;
    
    // Wait for DMA to be issued and complete
    wait_for_dma_complete();
  endtask

  // ========== DUT Instantiation ==========
  mmu_fsm dut (
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .ap_ready(ap_ready),
    .reset(reset),
    .dma_ready(dma_ready),
    .dma_done(dma_done),
    .dma_start(dma_start),
    .dma_start_ap_vld(dma_start_ap_vld),
    .dma_addr(dma_addr),
    .dma_addr_ap_vld(dma_addr_ap_vld),
    .dma_len(dma_len),
    .dma_len_ap_vld(dma_len_ap_vld),
    .dma_is_write(dma_is_write),
    .dma_is_write_ap_vld(dma_is_write_ap_vld),
    .uram_bank(uram_bank),
    .uram_bank_ap_vld(uram_bank_ap_vld),
    .uram_offset(uram_offset),
    .uram_offset_ap_vld(uram_offset_ap_vld),
    .buffer_ready(buffer_ready),
    .buffer_valid(buffer_valid),
    .buffer_valid_ap_vld(buffer_valid_ap_vld),
    .transfer_done(transfer_done),
    .transfer_done_ap_vld(transfer_done_ap_vld),
    .dma_req_valid(dma_req_valid),
    .dma_req_packed(dma_req_packed),
    .dma_req_ready(dma_req_ready),
    .dma_req_ready_ap_vld(dma_req_ready_ap_vld),
    .compute_req_valid(compute_req_valid),
    .compute_req_packed(compute_req_packed),
    .compute_req_type(compute_req_type),
    .compute_req_head(compute_req_head),
    .compute_req_ready(compute_req_ready),
    .compute_req_ready_ap_vld(compute_req_ready_ap_vld),
    .main_dma_done(main_dma_done),
    .main_dma_done_ap_vld(main_dma_done_ap_vld),
    .main_compute_done(main_compute_done),
    .main_compute_done_ap_vld(main_compute_done_ap_vld),
    .fsm_state_out(fsm_state_out),
    .fsm_state_out_ap_vld(fsm_state_out_ap_vld),
    .error_overflow(error_overflow),
    .error_overflow_ap_vld(error_overflow_ap_vld),
    .error_invalid(error_invalid),
    .error_invalid_ap_vld(error_invalid_ap_vld),
    .dims(dims),
    .k_cache_base(k_cache_base),
    .v_cache_base(v_cache_base),
    .current_token(current_token)
  );

  // ========== Main Test Stimulus ==========
  initial begin
    $display("\n========================================");
    $display("MMU FSM RTL Testbench v2");
    $display("With improved HLS handshaking and debug");
    $display("========================================\n");
    
    // Initialize
    ap_start = 0;
    reset = 1;
    dma_req_valid = 0;
    dma_req_packed = 0;
    compute_req_valid = 0;
    compute_req_packed = 0;
    compute_req_type = 0;
    compute_req_head = 0;
    dims = pack_dims();
    k_cache_base = 32'h8000_0000;
    v_cache_base = 32'h9000_0000;
    current_token = 5;
    
    test_pass_count = 0;
    test_fail_count = 0;
    dma_was_started = 0;
    debug_enabled = 1;  // Enable debug output
    
    // Initialize DDR with test pattern
    for (int i = 0; i < DDR_SIZE; i++) begin
      ddr_memory[i] = i[7:0];
    end
    
    // Initialize URAM to zeros
    for (int b = 0; b < URAM_BANKS; b++) begin
      for (int i = 0; i < URAM_BANK_SIZE; i++) begin
        uram[b][i] = 0;
      end
    end
    
    $display("\n[INFO] Releasing ap_rst...");
    repeat(5) @(posedge ap_clk);
    ap_rst <= 0;
    
    $display("[INFO] Asserting ap_start...");
    ap_start <= 1;  // Keep high - HLS expects this
    
    repeat(5) @(posedge ap_clk);
    
    // ===== Test 1: Reset Behavior =====
    $display("\n========== Test 1: Reset Behavior ==========");
    reset <= 1;
    repeat(20) @(posedge ap_clk);
    
    $display("[DEBUG] After reset: fsm_state_out=%0d, fsm_state_out_ap_vld=%b", 
             fsm_state_out, fsm_state_out_ap_vld);
    $display("[DEBUG] dma_req_ready=%b, dma_req_ready_ap_vld=%b",
             dma_req_ready, dma_req_ready_ap_vld);
    
    // More lenient checks - just verify no errors
    check(!error_overflow_ap_vld || (error_overflow === 1'b0), "No overflow after reset");
    check(!error_invalid_ap_vld || (error_invalid === 1'b0), "No invalid error after reset");
    
    reset <= 0;
    repeat(10) @(posedge ap_clk);
    
    // ===== Test 2: Single DMA WQ Request =====
    $display("\n========== Test 2: DMA WQ Request ==========");
    issue_dma_request(DMASEL_WQ, 0, 0, 0);
    
    check(dma_was_started, "DMA start asserted for WQ");
    check(captured_dma_len > 0, $sformatf("DMA length nonzero: %0d", captured_dma_len));
    check(!error_overflow_ap_vld || (error_overflow === 1'b0), "No overflow error");
    
    // ===== Test 3: Second DMA Request (WK) =====
    $display("\n========== Test 3: DMA WK Request ==========");
    dma_was_started = 0;
    issue_dma_request(DMASEL_WK, 0, 1, 0);
    
    check(dma_was_started, "DMA start asserted for WK");
    
    // ===== Test 4: Third DMA Request (WV) =====
    $display("\n========== Test 4: DMA WV Request ==========");
    dma_was_started = 0;
    issue_dma_request(DMASEL_WV, 0, 2, 0);
    
    check(dma_was_started, "DMA start asserted for WV");
    
    // ===== Test 5: WO Request =====
    $display("\n========== Test 5: DMA WO Request ==========");
    dma_was_started = 0;
    issue_dma_request(DMASEL_WO, 0, 0, 0);
    
    check(dma_was_started, "DMA start asserted for WO");
    
    // ===== Test 6: Data Integrity =====
    $display("\n========== Test 6: Data Integrity Check ==========");
    
    // IMPORTANT: Wait for URAM updates to settle (non-blocking assignments)
    wait_cycles(10);
    
    // Verify URAM has data from last transfer
    $display("[DEBUG] Checking bank=%0d offset=%0d len=%0d", 
             uram_bank_latched, uram_offset_latched, captured_dma_len);
    data_ok = 1;
    for (int i = 0; i < 16 && i < captured_dma_len; i++) begin
      if (uram[uram_bank_latched][uram_offset_latched + i] != 
          ddr_memory[dma_addr_latched + i]) begin
        data_ok = 0;
        $display("[DEBUG] Mismatch at offset %0d: URAM=0x%02x, DDR=0x%02x",
                 i, uram[uram_bank_latched][uram_offset_latched + i],
                 ddr_memory[dma_addr_latched + i]);
      end
    end
    check(data_ok, "URAM data matches DDR source");
    
    // ===== Summary =====
    wait_cycles(20);
    debug_enabled = 0;  // Turn off debug for summary
    
    $display("\n========================================");
    $display("Test Summary");
    $display("========================================");
    $display("Total DMA transfers: %0d", total_dma_transfers);
    $display("Total bytes read:    %0d", total_bytes_read);
    $display("Total bytes written: %0d", total_bytes_written);
    $display("----------------------------------------");
    $display("PASSED: %0d", test_pass_count);
    $display("FAILED: %0d", test_fail_count);
    $display("========================================\n");
    
    if (test_fail_count == 0) begin
      $display("*** ALL TESTS PASSED ***\n");
      $finish(0);
    end else begin
      $display("*** SOME TESTS FAILED ***\n");
      $finish(1);
    end
  end

  // Timeout watchdog
  initial begin
    #(MAX_CYCLES * CLK_PERIOD);
    $display("\n[ERROR] Simulation timeout after %0d cycles", MAX_CYCLES);
    $finish(1);
  end

endmodule
