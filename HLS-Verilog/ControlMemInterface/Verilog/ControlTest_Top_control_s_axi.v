// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
`timescale 1ns/1ps
module ControlTest_Top_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 8,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire                          interrupt,
    output wire [1215:0]                 config_in,
    input  wire [127:0]                  status_out,
    input  wire                          status_out_ap_vld,
    output wire [31:0]                   irq_clear_in,
    output wire                          ap_start,
    input  wire                          ap_done,
    input  wire                          ap_ready,
    input  wire                          ap_idle
);
//------------------------Address Info-------------------
// Protocol Used: ap_ctrl_hs
//
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0 - ap_done (Read/TOW)
//        bit 1 - ap_ready (Read/TOW)
//        others - reserved
// 0x10 : Data signal of config_in
//        bit 31~0 - config_in[31:0] (Read/Write)
// 0x14 : Data signal of config_in
//        bit 31~0 - config_in[63:32] (Read/Write)
// 0x18 : Data signal of config_in
//        bit 31~0 - config_in[95:64] (Read/Write)
// 0x1c : Data signal of config_in
//        bit 31~0 - config_in[127:96] (Read/Write)
// 0x20 : Data signal of config_in
//        bit 31~0 - config_in[159:128] (Read/Write)
// 0x24 : Data signal of config_in
//        bit 31~0 - config_in[191:160] (Read/Write)
// 0x28 : Data signal of config_in
//        bit 31~0 - config_in[223:192] (Read/Write)
// 0x2c : Data signal of config_in
//        bit 31~0 - config_in[255:224] (Read/Write)
// 0x30 : Data signal of config_in
//        bit 31~0 - config_in[287:256] (Read/Write)
// 0x34 : Data signal of config_in
//        bit 31~0 - config_in[319:288] (Read/Write)
// 0x38 : Data signal of config_in
//        bit 31~0 - config_in[351:320] (Read/Write)
// 0x3c : Data signal of config_in
//        bit 31~0 - config_in[383:352] (Read/Write)
// 0x40 : Data signal of config_in
//        bit 31~0 - config_in[415:384] (Read/Write)
// 0x44 : Data signal of config_in
//        bit 31~0 - config_in[447:416] (Read/Write)
// 0x48 : Data signal of config_in
//        bit 31~0 - config_in[479:448] (Read/Write)
// 0x4c : Data signal of config_in
//        bit 31~0 - config_in[511:480] (Read/Write)
// 0x50 : Data signal of config_in
//        bit 31~0 - config_in[543:512] (Read/Write)
// 0x54 : Data signal of config_in
//        bit 31~0 - config_in[575:544] (Read/Write)
// 0x58 : Data signal of config_in
//        bit 31~0 - config_in[607:576] (Read/Write)
// 0x5c : Data signal of config_in
//        bit 31~0 - config_in[639:608] (Read/Write)
// 0x60 : Data signal of config_in
//        bit 31~0 - config_in[671:640] (Read/Write)
// 0x64 : Data signal of config_in
//        bit 31~0 - config_in[703:672] (Read/Write)
// 0x68 : Data signal of config_in
//        bit 31~0 - config_in[735:704] (Read/Write)
// 0x6c : Data signal of config_in
//        bit 31~0 - config_in[767:736] (Read/Write)
// 0x70 : Data signal of config_in
//        bit 31~0 - config_in[799:768] (Read/Write)
// 0x74 : Data signal of config_in
//        bit 31~0 - config_in[831:800] (Read/Write)
// 0x78 : Data signal of config_in
//        bit 31~0 - config_in[863:832] (Read/Write)
// 0x7c : Data signal of config_in
//        bit 31~0 - config_in[895:864] (Read/Write)
// 0x80 : Data signal of config_in
//        bit 31~0 - config_in[927:896] (Read/Write)
// 0x84 : Data signal of config_in
//        bit 31~0 - config_in[959:928] (Read/Write)
// 0x88 : Data signal of config_in
//        bit 31~0 - config_in[991:960] (Read/Write)
// 0x8c : Data signal of config_in
//        bit 31~0 - config_in[1023:992] (Read/Write)
// 0x90 : Data signal of config_in
//        bit 31~0 - config_in[1055:1024] (Read/Write)
// 0x94 : Data signal of config_in
//        bit 31~0 - config_in[1087:1056] (Read/Write)
// 0x98 : Data signal of config_in
//        bit 31~0 - config_in[1119:1088] (Read/Write)
// 0x9c : Data signal of config_in
//        bit 31~0 - config_in[1151:1120] (Read/Write)
// 0xa0 : Data signal of config_in
//        bit 31~0 - config_in[1183:1152] (Read/Write)
// 0xa4 : Data signal of config_in
//        bit 31~0 - config_in[1215:1184] (Read/Write)
// 0xa8 : reserved
// 0xac : Data signal of status_out
//        bit 31~0 - status_out[31:0] (Read)
// 0xb0 : Data signal of status_out
//        bit 31~0 - status_out[63:32] (Read)
// 0xb4 : Data signal of status_out
//        bit 31~0 - status_out[95:64] (Read)
// 0xb8 : Data signal of status_out
//        bit 31~0 - status_out[127:96] (Read)
// 0xbc : Control signal of status_out
//        bit 0  - status_out_ap_vld (Read/COR)
//        others - reserved
// 0xd4 : Data signal of irq_clear_in
//        bit 31~0 - irq_clear_in[31:0] (Read/Write)
// 0xd8 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_AP_CTRL             = 8'h00,
    ADDR_GIE                 = 8'h04,
    ADDR_IER                 = 8'h08,
    ADDR_ISR                 = 8'h0c,
    ADDR_CONFIG_IN_DATA_0    = 8'h10,
    ADDR_CONFIG_IN_DATA_1    = 8'h14,
    ADDR_CONFIG_IN_DATA_2    = 8'h18,
    ADDR_CONFIG_IN_DATA_3    = 8'h1c,
    ADDR_CONFIG_IN_DATA_4    = 8'h20,
    ADDR_CONFIG_IN_DATA_5    = 8'h24,
    ADDR_CONFIG_IN_DATA_6    = 8'h28,
    ADDR_CONFIG_IN_DATA_7    = 8'h2c,
    ADDR_CONFIG_IN_DATA_8    = 8'h30,
    ADDR_CONFIG_IN_DATA_9    = 8'h34,
    ADDR_CONFIG_IN_DATA_10   = 8'h38,
    ADDR_CONFIG_IN_DATA_11   = 8'h3c,
    ADDR_CONFIG_IN_DATA_12   = 8'h40,
    ADDR_CONFIG_IN_DATA_13   = 8'h44,
    ADDR_CONFIG_IN_DATA_14   = 8'h48,
    ADDR_CONFIG_IN_DATA_15   = 8'h4c,
    ADDR_CONFIG_IN_DATA_16   = 8'h50,
    ADDR_CONFIG_IN_DATA_17   = 8'h54,
    ADDR_CONFIG_IN_DATA_18   = 8'h58,
    ADDR_CONFIG_IN_DATA_19   = 8'h5c,
    ADDR_CONFIG_IN_DATA_20   = 8'h60,
    ADDR_CONFIG_IN_DATA_21   = 8'h64,
    ADDR_CONFIG_IN_DATA_22   = 8'h68,
    ADDR_CONFIG_IN_DATA_23   = 8'h6c,
    ADDR_CONFIG_IN_DATA_24   = 8'h70,
    ADDR_CONFIG_IN_DATA_25   = 8'h74,
    ADDR_CONFIG_IN_DATA_26   = 8'h78,
    ADDR_CONFIG_IN_DATA_27   = 8'h7c,
    ADDR_CONFIG_IN_DATA_28   = 8'h80,
    ADDR_CONFIG_IN_DATA_29   = 8'h84,
    ADDR_CONFIG_IN_DATA_30   = 8'h88,
    ADDR_CONFIG_IN_DATA_31   = 8'h8c,
    ADDR_CONFIG_IN_DATA_32   = 8'h90,
    ADDR_CONFIG_IN_DATA_33   = 8'h94,
    ADDR_CONFIG_IN_DATA_34   = 8'h98,
    ADDR_CONFIG_IN_DATA_35   = 8'h9c,
    ADDR_CONFIG_IN_DATA_36   = 8'ha0,
    ADDR_CONFIG_IN_DATA_37   = 8'ha4,
    ADDR_CONFIG_IN_CTRL      = 8'ha8,
    ADDR_STATUS_OUT_DATA_0   = 8'hac,
    ADDR_STATUS_OUT_DATA_1   = 8'hb0,
    ADDR_STATUS_OUT_DATA_2   = 8'hb4,
    ADDR_STATUS_OUT_DATA_3   = 8'hb8,
    ADDR_STATUS_OUT_CTRL     = 8'hbc,
    ADDR_IRQ_CLEAR_IN_DATA_0 = 8'hd4,
    ADDR_IRQ_CLEAR_IN_CTRL   = 8'hd8,
    WRIDLE                   = 2'd0,
    WRDATA                   = 2'd1,
    WRRESP                   = 2'd2,
    WRRESET                  = 2'd3,
    RDIDLE                   = 2'd0,
    RDDATA                   = 2'd1,
    RDRESET                  = 2'd2,
    ADDR_BITS                = 8;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg                           int_ap_idle = 1'b0;
    reg                           int_ap_ready = 1'b0;
    wire                          task_ap_ready;
    reg                           int_ap_done = 1'b0;
    wire                          task_ap_done;
    reg                           int_task_ap_done = 1'b0;
    reg                           int_ap_start = 1'b0;
    reg                           int_interrupt = 1'b0;
    reg                           int_auto_restart = 1'b0;
    reg                           auto_restart_status = 1'b0;
    wire                          auto_restart_done;
    reg                           int_gie = 1'b0;
    reg  [1:0]                    int_ier = 2'b0;
    reg  [1:0]                    int_isr = 2'b0;
    reg  [1215:0]                 int_config_in = 'b0;
    reg                           int_status_out_ap_vld;
    reg  [127:0]                  int_status_out = 'b0;
    reg  [31:0]                   int_irq_clear_in = 'b0;

//------------------------Instantiation------------------


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BVALID  = (wstate == WRRESP);
assign BRESP   = 2'b00;  // OKAY
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY & BVALID)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= {AWADDR[ADDR_BITS-1:2], {2{1'b0}}};
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
            case (raddr)
                ADDR_AP_CTRL: begin
                    rdata[0] <= int_ap_start;
                    rdata[1] <= int_task_ap_done;
                    rdata[2] <= int_ap_idle;
                    rdata[3] <= int_ap_ready;
                    rdata[7] <= int_auto_restart;
                    rdata[9] <= int_interrupt;
                end
                ADDR_GIE: begin
                    rdata <= int_gie;
                end
                ADDR_IER: begin
                    rdata <= int_ier;
                end
                ADDR_ISR: begin
                    rdata <= int_isr;
                end
                ADDR_CONFIG_IN_DATA_0: begin
                    rdata <= int_config_in[31:0];
                end
                ADDR_CONFIG_IN_DATA_1: begin
                    rdata <= int_config_in[63:32];
                end
                ADDR_CONFIG_IN_DATA_2: begin
                    rdata <= int_config_in[95:64];
                end
                ADDR_CONFIG_IN_DATA_3: begin
                    rdata <= int_config_in[127:96];
                end
                ADDR_CONFIG_IN_DATA_4: begin
                    rdata <= int_config_in[159:128];
                end
                ADDR_CONFIG_IN_DATA_5: begin
                    rdata <= int_config_in[191:160];
                end
                ADDR_CONFIG_IN_DATA_6: begin
                    rdata <= int_config_in[223:192];
                end
                ADDR_CONFIG_IN_DATA_7: begin
                    rdata <= int_config_in[255:224];
                end
                ADDR_CONFIG_IN_DATA_8: begin
                    rdata <= int_config_in[287:256];
                end
                ADDR_CONFIG_IN_DATA_9: begin
                    rdata <= int_config_in[319:288];
                end
                ADDR_CONFIG_IN_DATA_10: begin
                    rdata <= int_config_in[351:320];
                end
                ADDR_CONFIG_IN_DATA_11: begin
                    rdata <= int_config_in[383:352];
                end
                ADDR_CONFIG_IN_DATA_12: begin
                    rdata <= int_config_in[415:384];
                end
                ADDR_CONFIG_IN_DATA_13: begin
                    rdata <= int_config_in[447:416];
                end
                ADDR_CONFIG_IN_DATA_14: begin
                    rdata <= int_config_in[479:448];
                end
                ADDR_CONFIG_IN_DATA_15: begin
                    rdata <= int_config_in[511:480];
                end
                ADDR_CONFIG_IN_DATA_16: begin
                    rdata <= int_config_in[543:512];
                end
                ADDR_CONFIG_IN_DATA_17: begin
                    rdata <= int_config_in[575:544];
                end
                ADDR_CONFIG_IN_DATA_18: begin
                    rdata <= int_config_in[607:576];
                end
                ADDR_CONFIG_IN_DATA_19: begin
                    rdata <= int_config_in[639:608];
                end
                ADDR_CONFIG_IN_DATA_20: begin
                    rdata <= int_config_in[671:640];
                end
                ADDR_CONFIG_IN_DATA_21: begin
                    rdata <= int_config_in[703:672];
                end
                ADDR_CONFIG_IN_DATA_22: begin
                    rdata <= int_config_in[735:704];
                end
                ADDR_CONFIG_IN_DATA_23: begin
                    rdata <= int_config_in[767:736];
                end
                ADDR_CONFIG_IN_DATA_24: begin
                    rdata <= int_config_in[799:768];
                end
                ADDR_CONFIG_IN_DATA_25: begin
                    rdata <= int_config_in[831:800];
                end
                ADDR_CONFIG_IN_DATA_26: begin
                    rdata <= int_config_in[863:832];
                end
                ADDR_CONFIG_IN_DATA_27: begin
                    rdata <= int_config_in[895:864];
                end
                ADDR_CONFIG_IN_DATA_28: begin
                    rdata <= int_config_in[927:896];
                end
                ADDR_CONFIG_IN_DATA_29: begin
                    rdata <= int_config_in[959:928];
                end
                ADDR_CONFIG_IN_DATA_30: begin
                    rdata <= int_config_in[991:960];
                end
                ADDR_CONFIG_IN_DATA_31: begin
                    rdata <= int_config_in[1023:992];
                end
                ADDR_CONFIG_IN_DATA_32: begin
                    rdata <= int_config_in[1055:1024];
                end
                ADDR_CONFIG_IN_DATA_33: begin
                    rdata <= int_config_in[1087:1056];
                end
                ADDR_CONFIG_IN_DATA_34: begin
                    rdata <= int_config_in[1119:1088];
                end
                ADDR_CONFIG_IN_DATA_35: begin
                    rdata <= int_config_in[1151:1120];
                end
                ADDR_CONFIG_IN_DATA_36: begin
                    rdata <= int_config_in[1183:1152];
                end
                ADDR_CONFIG_IN_DATA_37: begin
                    rdata <= int_config_in[1215:1184];
                end
                ADDR_STATUS_OUT_DATA_0: begin
                    rdata <= int_status_out[31:0];
                end
                ADDR_STATUS_OUT_DATA_1: begin
                    rdata <= int_status_out[63:32];
                end
                ADDR_STATUS_OUT_DATA_2: begin
                    rdata <= int_status_out[95:64];
                end
                ADDR_STATUS_OUT_DATA_3: begin
                    rdata <= int_status_out[127:96];
                end
                ADDR_STATUS_OUT_CTRL: begin
                    rdata[0] <= int_status_out_ap_vld;
                end
                ADDR_IRQ_CLEAR_IN_DATA_0: begin
                    rdata <= int_irq_clear_in[31:0];
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign interrupt         = int_interrupt;
assign ap_start          = int_ap_start;
assign task_ap_done      = (ap_done && !auto_restart_status) || auto_restart_done;
assign task_ap_ready     = ap_ready && !int_auto_restart;
assign auto_restart_done = auto_restart_status && (ap_idle && !int_ap_idle);
assign config_in         = int_config_in;
assign irq_clear_in      = int_irq_clear_in;
// int_interrupt
always @(posedge ACLK) begin
    if (ARESET)
        int_interrupt <= 1'b0;
    else if (ACLK_EN) begin
        if (int_gie && (|int_isr))
            int_interrupt <= 1'b1;
        else
            int_interrupt <= 1'b0;
    end
end

// int_ap_start
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_start <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0] && WDATA[0])
            int_ap_start <= 1'b1;
        else if (ap_ready)
            int_ap_start <= int_auto_restart; // clear on handshake/auto restart
    end
end

// int_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_done <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_done <= ap_done;
    end
end

// int_task_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_task_ap_done <= 1'b0;
    else if (ACLK_EN) begin
        if (task_ap_done)
            int_task_ap_done <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_task_ap_done <= 1'b0; // clear on read
    end
end

// int_ap_idle
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_idle <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_idle <= ap_idle;
    end
end

// int_ap_ready
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_ready <= 1'b0;
    else if (ACLK_EN) begin
        if (task_ap_ready)
            int_ap_ready <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_ap_ready <= 1'b0;
    end
end

// int_auto_restart
always @(posedge ACLK) begin
    if (ARESET)
        int_auto_restart <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0])
            int_auto_restart <= WDATA[7];
    end
end

// auto_restart_status
always @(posedge ACLK) begin
    if (ARESET)
        auto_restart_status <= 1'b0;
    else if (ACLK_EN) begin
        if (int_auto_restart)
            auto_restart_status <= 1'b1;
        else if (ap_idle)
            auto_restart_status <= 1'b0;
    end
end

// int_gie
always @(posedge ACLK) begin
    if (ARESET)
        int_gie <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_GIE && WSTRB[0])
            int_gie <= WDATA[0];
    end
end

// int_ier
always @(posedge ACLK) begin
    if (ARESET)
        int_ier <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_IER && WSTRB[0])
            int_ier <= WDATA[1:0];
    end
end

// int_isr[0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[0] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[0] & ap_done)
            int_isr[0] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[0] <= int_isr[0] ^ WDATA[0]; // toggle on write
    end
end

// int_isr[1]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[1] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[1] & ap_ready)
            int_isr[1] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[1] <= int_isr[1] ^ WDATA[1]; // toggle on write
    end
end

// int_config_in[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_0)
            int_config_in[31:0] <= (WDATA[31:0] & wmask) | (int_config_in[31:0] & ~wmask);
    end
end

// int_config_in[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_1)
            int_config_in[63:32] <= (WDATA[31:0] & wmask) | (int_config_in[63:32] & ~wmask);
    end
end

// int_config_in[95:64]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[95:64] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_2)
            int_config_in[95:64] <= (WDATA[31:0] & wmask) | (int_config_in[95:64] & ~wmask);
    end
end

// int_config_in[127:96]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[127:96] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_3)
            int_config_in[127:96] <= (WDATA[31:0] & wmask) | (int_config_in[127:96] & ~wmask);
    end
end

// int_config_in[159:128]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[159:128] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_4)
            int_config_in[159:128] <= (WDATA[31:0] & wmask) | (int_config_in[159:128] & ~wmask);
    end
end

// int_config_in[191:160]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[191:160] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_5)
            int_config_in[191:160] <= (WDATA[31:0] & wmask) | (int_config_in[191:160] & ~wmask);
    end
end

// int_config_in[223:192]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[223:192] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_6)
            int_config_in[223:192] <= (WDATA[31:0] & wmask) | (int_config_in[223:192] & ~wmask);
    end
end

// int_config_in[255:224]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[255:224] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_7)
            int_config_in[255:224] <= (WDATA[31:0] & wmask) | (int_config_in[255:224] & ~wmask);
    end
end

// int_config_in[287:256]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[287:256] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_8)
            int_config_in[287:256] <= (WDATA[31:0] & wmask) | (int_config_in[287:256] & ~wmask);
    end
end

// int_config_in[319:288]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[319:288] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_9)
            int_config_in[319:288] <= (WDATA[31:0] & wmask) | (int_config_in[319:288] & ~wmask);
    end
end

// int_config_in[351:320]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[351:320] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_10)
            int_config_in[351:320] <= (WDATA[31:0] & wmask) | (int_config_in[351:320] & ~wmask);
    end
end

// int_config_in[383:352]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[383:352] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_11)
            int_config_in[383:352] <= (WDATA[31:0] & wmask) | (int_config_in[383:352] & ~wmask);
    end
end

// int_config_in[415:384]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[415:384] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_12)
            int_config_in[415:384] <= (WDATA[31:0] & wmask) | (int_config_in[415:384] & ~wmask);
    end
end

// int_config_in[447:416]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[447:416] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_13)
            int_config_in[447:416] <= (WDATA[31:0] & wmask) | (int_config_in[447:416] & ~wmask);
    end
end

// int_config_in[479:448]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[479:448] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_14)
            int_config_in[479:448] <= (WDATA[31:0] & wmask) | (int_config_in[479:448] & ~wmask);
    end
end

// int_config_in[511:480]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[511:480] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_15)
            int_config_in[511:480] <= (WDATA[31:0] & wmask) | (int_config_in[511:480] & ~wmask);
    end
end

// int_config_in[543:512]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[543:512] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_16)
            int_config_in[543:512] <= (WDATA[31:0] & wmask) | (int_config_in[543:512] & ~wmask);
    end
end

// int_config_in[575:544]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[575:544] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_17)
            int_config_in[575:544] <= (WDATA[31:0] & wmask) | (int_config_in[575:544] & ~wmask);
    end
end

// int_config_in[607:576]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[607:576] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_18)
            int_config_in[607:576] <= (WDATA[31:0] & wmask) | (int_config_in[607:576] & ~wmask);
    end
end

// int_config_in[639:608]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[639:608] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_19)
            int_config_in[639:608] <= (WDATA[31:0] & wmask) | (int_config_in[639:608] & ~wmask);
    end
end

// int_config_in[671:640]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[671:640] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_20)
            int_config_in[671:640] <= (WDATA[31:0] & wmask) | (int_config_in[671:640] & ~wmask);
    end
end

// int_config_in[703:672]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[703:672] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_21)
            int_config_in[703:672] <= (WDATA[31:0] & wmask) | (int_config_in[703:672] & ~wmask);
    end
end

// int_config_in[735:704]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[735:704] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_22)
            int_config_in[735:704] <= (WDATA[31:0] & wmask) | (int_config_in[735:704] & ~wmask);
    end
end

// int_config_in[767:736]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[767:736] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_23)
            int_config_in[767:736] <= (WDATA[31:0] & wmask) | (int_config_in[767:736] & ~wmask);
    end
end

// int_config_in[799:768]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[799:768] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_24)
            int_config_in[799:768] <= (WDATA[31:0] & wmask) | (int_config_in[799:768] & ~wmask);
    end
end

// int_config_in[831:800]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[831:800] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_25)
            int_config_in[831:800] <= (WDATA[31:0] & wmask) | (int_config_in[831:800] & ~wmask);
    end
end

// int_config_in[863:832]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[863:832] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_26)
            int_config_in[863:832] <= (WDATA[31:0] & wmask) | (int_config_in[863:832] & ~wmask);
    end
end

// int_config_in[895:864]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[895:864] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_27)
            int_config_in[895:864] <= (WDATA[31:0] & wmask) | (int_config_in[895:864] & ~wmask);
    end
end

// int_config_in[927:896]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[927:896] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_28)
            int_config_in[927:896] <= (WDATA[31:0] & wmask) | (int_config_in[927:896] & ~wmask);
    end
end

// int_config_in[959:928]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[959:928] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_29)
            int_config_in[959:928] <= (WDATA[31:0] & wmask) | (int_config_in[959:928] & ~wmask);
    end
end

// int_config_in[991:960]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[991:960] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_30)
            int_config_in[991:960] <= (WDATA[31:0] & wmask) | (int_config_in[991:960] & ~wmask);
    end
end

// int_config_in[1023:992]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[1023:992] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_31)
            int_config_in[1023:992] <= (WDATA[31:0] & wmask) | (int_config_in[1023:992] & ~wmask);
    end
end

// int_config_in[1055:1024]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[1055:1024] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_32)
            int_config_in[1055:1024] <= (WDATA[31:0] & wmask) | (int_config_in[1055:1024] & ~wmask);
    end
end

// int_config_in[1087:1056]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[1087:1056] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_33)
            int_config_in[1087:1056] <= (WDATA[31:0] & wmask) | (int_config_in[1087:1056] & ~wmask);
    end
end

// int_config_in[1119:1088]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[1119:1088] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_34)
            int_config_in[1119:1088] <= (WDATA[31:0] & wmask) | (int_config_in[1119:1088] & ~wmask);
    end
end

// int_config_in[1151:1120]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[1151:1120] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_35)
            int_config_in[1151:1120] <= (WDATA[31:0] & wmask) | (int_config_in[1151:1120] & ~wmask);
    end
end

// int_config_in[1183:1152]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[1183:1152] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_36)
            int_config_in[1183:1152] <= (WDATA[31:0] & wmask) | (int_config_in[1183:1152] & ~wmask);
    end
end

// int_config_in[1215:1184]
always @(posedge ACLK) begin
    if (ARESET)
        int_config_in[1215:1184] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CONFIG_IN_DATA_37)
            int_config_in[1215:1184] <= (WDATA[31:0] & wmask) | (int_config_in[1215:1184] & ~wmask);
    end
end

// int_status_out
always @(posedge ACLK) begin
    if (ARESET)
        int_status_out <= 0;
    else if (ACLK_EN) begin
        if (status_out_ap_vld)
            int_status_out <= status_out;
    end
end

// int_status_out_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_status_out_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (status_out_ap_vld)
            int_status_out_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_STATUS_OUT_CTRL)
            int_status_out_ap_vld <= 1'b0; // clear on read
    end
end

// int_irq_clear_in[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_irq_clear_in[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_IRQ_CLEAR_IN_DATA_0)
            int_irq_clear_in[31:0] <= (WDATA[31:0] & wmask) | (int_irq_clear_in[31:0] & ~wmask);
    end
end

//synthesis translate_off
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (int_gie & ~int_isr[0] & int_ier[0] & ap_done)
            $display ("// Interrupt Monitor : interrupt for ap_done detected @ \"%0t\"", $time);
        if (int_gie & ~int_isr[1] & int_ier[1] & ap_ready)
            $display ("// Interrupt Monitor : interrupt for ap_ready detected @ \"%0t\"", $time);
    end
end
//synthesis translate_on

//------------------------Memory logic-------------------

endmodule
