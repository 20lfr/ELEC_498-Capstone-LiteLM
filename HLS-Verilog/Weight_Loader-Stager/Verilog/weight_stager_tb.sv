`timescale 1ns/1ps

module weight_stager_tb;
  // Clock and reset
  logic ap_clk = 0;
  logic ap_rst = 1;
  always #5 ap_clk = ~ap_clk; // 100 MHz

  // DUT inputs
  logic ap_start;
  logic [0:0] wl_start;
  logic [7:0] wl_addr_sel;
  logic [31:0] wl_layer;
  logic [31:0] wl_head;
  logic [31:0] wl_tile;
  logic [1055:0] ctrl_mem;

  // DUT outputs
  logic ap_done;
  logic ap_idle;
  logic ap_ready;
  logic [0:0] wl_ready;
  logic wl_ready_ap_vld;
  logic [0:0] memory_request;
  logic memory_request_ap_vld;
  logic [0:0] error;
  logic error_ap_vld;
  logic [31:0] ap_return;
  integer req_idx;
  integer cyc;
  logic [31:0] exp;
  localparam int NUM_REQ = 8;

  typedef struct packed {
    int cycle;
    logic [7:0] sel;
    int layer;
    int head;
    int tile;
    logic [31:0] expected;
  } stim_t;

  // Coverage of all weight/cache selections with expected addresses.
  stim_t requests[] = '{
    '{2,  8'd1, 1, 2, 0, 32'h1000_1200}, // WQ: base 0x1000_0000 + 0x1000 + 2*0x0100
    '{4,  8'd2, 1, 3, 0, 32'h2000_1600}, // WK: base 0x2000_0000 + 0x1000 + 3*0x0200
    '{6,  8'd3, 2, 1, 0, 32'h3000_2300}, // WV: base 0x3000_0000 + 2*0x1000 + 1*0x0300
    '{8,  8'd4, 0, 4, 0, 32'h4000_1000}, // K cache: base 0x4000_0000 + 4*0x0400
    '{10, 8'd5, 2, 5, 0, 32'h5000_3900}, // V cache: base 0x5000_0000 + 2*0x1000 + 5*0x0500
    '{12, 8'd8, 1, 0, 2, 32'h6000_1C00}, // WO: base 0x6000_0000 + 1*0x1000 + 2*0x0600
    '{14, 8'd9, 3, 0, 1, 32'h7000_3700}, // W1: base 0x7000_0000 + 3*0x1000 + 1*0x0700
    '{16, 8'd10,1, 0, 3, 32'h8000_2800}  // W2: base 0x8000_0000 + 1*0x1000 + 3*0x0800
  };

  initial begin
    // Initialize control memory fields we care about.
    ctrl_mem = '0;
    ctrl_mem[287:256] = 32'h0000_1000; // layer_stride
    ctrl_mem[319:288] = 32'h0000_0100; // wq_head_stride
    ctrl_mem[351:320] = 32'h0000_0200; // wk_head_stride
    ctrl_mem[383:352] = 32'h0000_0300; // wv_head_stride
    ctrl_mem[415:384] = 32'h0000_0400; // k_cache_stride
    ctrl_mem[447:416] = 32'h0000_0500; // v_cache_stride
    ctrl_mem[479:448] = 32'h0000_0600; // wo_tile_stride
    ctrl_mem[511:480] = 32'h0000_0700; // w1_tile_stride
    ctrl_mem[543:512] = 32'h0000_0800; // w2_tile_stride
    ctrl_mem[575:544] = 32'h1000_0000; // wq_base_addr
    ctrl_mem[607:576] = 32'h2000_0000; // wk_base_addr
    ctrl_mem[639:608] = 32'h3000_0000; // wv_base_addr
    ctrl_mem[671:640] = 32'h6000_0000; // wo_base_addr
    ctrl_mem[703:672] = 32'h7000_0000; // w1_base_addr
    ctrl_mem[735:704] = 32'h8000_0000; // w2_base_addr
    ctrl_mem[767:736] = 32'h4000_0000; // k_cache_addr
    ctrl_mem[799:768] = 32'h5000_0000; // v_cache_addr

    // Drive reset for a few cycles
    ap_start   = 0;
    wl_start   = 0;
    wl_addr_sel= 0;
    wl_layer   = 0;
    wl_head    = 0;
    wl_tile    = 0;
    repeat (4) @(posedge ap_clk);
    ap_rst = 0;
    ap_start = 1'b1; // hold high (single-state kernel)

    $display("Cycle | start addr_sel layer head tile | ready mem_req err ap_return (expected)");
    for (cyc = 0; cyc < 24; cyc++) begin
      // Default inputs
      wl_start    = 0;
      wl_addr_sel = 0;
      wl_layer    = 0;
      wl_head     = 0;
      wl_tile     = 0;
      exp = 32'hXXXX_XXXX;

      // Issue pulses per schedule (manual, no arrays)
      case (cyc)
        0: begin wl_start = 1; wl_addr_sel = 8'd1;  wl_layer = 1; wl_head = 2; wl_tile = 0; exp = 32'h1000_1200; end // WQ
        2: begin wl_start = 1; wl_addr_sel = 8'd2;  wl_layer = 1; wl_head = 3; wl_tile = 0; exp = 32'h2000_1600; end // WK
        4: begin wl_start = 1; wl_addr_sel = 8'd3;  wl_layer = 2; wl_head = 1; wl_tile = 0; exp = 32'h3000_2300; end // WV
        6: begin wl_start = 1; wl_addr_sel = 8'd4;  wl_layer = 0; wl_head = 4; wl_tile = 0; exp = 32'h4000_1000; end // K cache
        8: begin wl_start = 1; wl_addr_sel = 8'd5;  wl_layer = 2; wl_head = 5; wl_tile = 0; exp = 32'h5000_3900; end // V cache
        10:begin wl_start = 1; wl_addr_sel = 8'd8;  wl_layer = 1; wl_head = 0; wl_tile = 2; exp = 32'h6000_1C00; end // WO
        12:begin wl_start = 1; wl_addr_sel = 8'd9;  wl_layer = 3; wl_head = 0; wl_tile = 1; exp = 32'h7000_3700; end // W1
        14:begin wl_start = 1; wl_addr_sel = 8'd10; wl_layer = 1; wl_head = 0; wl_tile = 3; exp = 32'h8000_2800; end // W2
        default: ; 
      endcase

      @(posedge ap_clk);
      $display("%5d |   %0d     %0d   %4d %4d %4d |   %0d      %0d    %0d  0x%08X (0x%08X)",
               cyc, wl_start, wl_addr_sel, wl_layer, wl_head, wl_tile,
               wl_ready, memory_request, error, ap_return, exp);
    end

    $finish;
  end

  weight_stager dut (
      .ap_clk(ap_clk),
      .ap_rst(ap_rst),
      .ap_start(ap_start),
      .ap_done(ap_done),
      .ap_idle(ap_idle),
      .ap_ready(ap_ready),
      .wl_start(wl_start),
      .wl_addr_sel(wl_addr_sel),
      .wl_layer(wl_layer),
      .wl_head(wl_head),
      .wl_tile(wl_tile),
      .ctrl_mem(ctrl_mem),
      .wl_ready(wl_ready),
      .wl_ready_ap_vld(wl_ready_ap_vld),
      .memory_request(memory_request),
      .memory_request_ap_vld(memory_request_ap_vld),
      .error(error),
      .error_ap_vld(error_ap_vld),
      .ap_return(ap_return)
  );

endmodule
