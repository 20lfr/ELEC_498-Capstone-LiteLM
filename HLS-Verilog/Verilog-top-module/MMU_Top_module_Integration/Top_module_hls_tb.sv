`timescale 1ns/1ps

module top_module_hls_tb;
  localparam int CLK_PERIOD_NS        = 10;
  localparam int MAX_CYCLES           = 5000000;
  localparam int CTRL_MEM_WORDS       = 68;
  localparam int DBG_CTRL_MEM_WORDS   = 67;
  localparam int STREAM_IN_BUF_BYTES  = 16;
  localparam int STREAM_OUT_BUF_BYTES = 64;
  localparam int TOP_DMA_BUF_WORDS    = 16384;
  localparam int KV_STORE_WORDS       = 131072;
  localparam int DMA_LATENCY_CYCLES   = 4;
  localparam int STREAM_LATENCY_CYCLES = 6;
  localparam int CTRL_START_HOLD_CYCLES = 24;
  localparam int RAM_REGION_WORDS      = 65536;
  localparam int TB_HEADS_PARALLEL     = 2;
  localparam int TB_NUM_HEADS          = 4;
  localparam int TB_D_MODEL            = 16;
  localparam int TB_D_FFN              = 24;
  localparam int TB_D_HEADS            = (TB_D_MODEL / TB_NUM_HEADS);
  localparam int TB_NUM_WO_TILES       = 4;
  localparam int TB_NUM_W1_TILES       = 8;
  localparam int TB_NUM_W2_TILES       = 4;
  localparam int TB_D_TILE_WO          = (TB_D_MODEL / TB_NUM_WO_TILES);
  localparam int TB_D_TILE_W1          = ((TB_D_FFN * 2) / TB_NUM_W1_TILES);
  localparam int TB_D_TILE_W2          = (TB_D_MODEL / TB_NUM_W2_TILES);
  localparam int TB_CONTEXT_LENGTH     = 16;
  localparam int DBG_MAIN_IN_BYTES     = 128;
  localparam int DBG_MAIN_OUT_BYTES    = 64;
  localparam int DBG_HEAD_IN_BYTES     = 128;
  localparam int DBG_HEAD_OUT_BYTES    = 64;
  localparam int DBG_SNAP_DEPTH        = 64;
  localparam int DBG_SNAP_QUIET_CYCLES = 2;

  localparam int OP_CMP_LN0         = 1;
  localparam int OP_CMP_Q           = 3;
  localparam int OP_CMP_K           = 4;
  localparam int OP_CMP_V           = 6;
  localparam int OP_CMP_ATT_SCORES  = 9;
  localparam int OP_CMP_VALUE_SCALE = 10;
  localparam int OP_CMP_SOFTMAX     = 11;
  localparam int OP_CMP_ATT_VALUE   = 12;
  localparam int OP_CMP_HEAD_REQUANT= 13;
  localparam int OP_CMP_OUT_PROJ    = 15;
  localparam int OP_CMP_RESID1      = 16;
  localparam int OP_CMP_FFN_W1      = 18;
  localparam int OP_CMP_FFN_ACT     = 19;
  localparam int OP_CMP_FFN_W2      = 20;
  localparam int OP_CMP_RESID2      = 22;
  localparam int OP_CMP_LN1         = 23;
  localparam int OP_CMP_FINAL_NORM  = 25;

  localparam logic [8:0] ADDR_AP_CTRL         = 9'h000;
  localparam logic [8:0] ADDR_CTRL_MEM_DATA_0 = 9'h01c;
  localparam logic [8:0] ADDR_STATUS_MEM_DATA_0 = 9'h130;
  localparam logic [8:0] ADDR_STATUS_MEM_DATA_1 = 9'h134;
  localparam logic [8:0] ADDR_STATUS_MEM_DATA_2 = 9'h138;

  localparam logic [31:0] CTRL_RESETN_BIT = 32'h0000_0001;
  localparam logic [31:0] CTRL_START_BIT  = 32'h0000_0002;

  // Reverse order of HeadCtx so LSBs align with C layout.
  typedef struct packed {
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
    logic        v_compute_done;
    logic        k_compute_done;
    logic        q_compute_done;
    logic        head_requant_started;
    logic        att_value_started;
    logic        softmax_started;
    logic        val_scale_started;
    logic        att_scores_started;
    logic        v_writeback_started;
    logic        v_started;
    logic        k_writeback_started;
    logic        k_started;
    logic        q_started;
    logic        start_head;
    logic        dma_done;
    logic [31:0] wl_instruction;
    logic        wl_start;
    logic        wl_ready;
    logic        wl_accept;
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

  typedef struct packed {
    logic [31:0] mem_op;
    logic        mem_write_request;
    logic        mem_read_request;
    logic        mem_transfer_done;
    logic        compute_done;
    logic        compute_ready;
    logic [31:0] compute_instruction;
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

  // Unpack raw HLS debug buses using explicit bit positions from C-struct field order.
  function automatic head_ctx_t unpack_head_ctx(input logic [208:0] raw);
    head_ctx_t s;
    begin
      s.layer_stamp               = raw[31:0];
      s.head_idx                  = raw[63:32];
      s.phase                     = raw[71:64];
      s.compute_ready             = raw[72];
      s.compute_done              = raw[73];
      s.compute_start             = raw[74];
      s.compute_op                = raw[106:75];
      s.last_compute_op           = raw[138:107];
      s.last_wl_addr              = raw[146:139];
      s.wl_ready                  = raw[147];
      s.wl_accept                 = raw[148];
      s.wl_start                  = raw[149];
      s.wl_instruction            = raw[181:150];
      s.dma_done                  = raw[182];
      s.start_head                = raw[183];
      s.q_started                 = raw[184];
      s.k_started                 = raw[185];
      s.k_writeback_started       = raw[186];
      s.v_started                 = raw[187];
      s.v_writeback_started       = raw[188];
      s.att_scores_started        = raw[189];
      s.val_scale_started         = raw[190];
      s.softmax_started           = raw[191];
      s.att_value_started         = raw[192];
      s.head_requant_started      = raw[193];
      s.q_compute_done            = raw[194];
      s.k_compute_done            = raw[195];
      s.v_compute_done            = raw[196];
      s.att_scores_compute_done   = raw[197];
      s.val_scale_compute_done    = raw[198];
      s.softmax_compute_done      = raw[199];
      s.att_value_compute_done    = raw[200];
      s.head_requant_compute_done = raw[201];
      s.q_dma_done                = raw[202];
      s.k_dma_done                = raw[203];
      s.k_writeback_dma_done      = raw[204];
      s.v_dma_done                = raw[205];
      s.v_writeback_dma_done      = raw[206];
      s.att_scores_dma_done       = raw[207];
      s.att_value_dma_done        = raw[208];
      unpack_head_ctx = s;
    end
  endfunction

  function automatic ComputeHeadCtx_t unpack_compute_head_ctx(input logic [148:0] raw);
    ComputeHeadCtx_t s;
    begin
      s.state            = raw[7:0];
      s.req_instruction  = raw[39:8];
      s.req_op           = raw[47:40];
      s.req_layer        = raw[55:48];
      s.req_head         = raw[63:56];
      s.req_tile         = raw[71:64];
      s.mac_busy         = raw[72];
      s.mac_ready        = raw[73];
      s.mac_complete     = raw[74];
      s.clear_pending    = raw[75];
      s.capture_pending  = raw[76];
      s.mac_start        = raw[77];
      s.error_latched    = raw[78];
      s.compute_start    = raw[79];
      s.compute_instruction = raw[111:80];
      s.compute_ready    = raw[112];
      s.compute_done     = raw[113];
      s.mem_transfer_done= raw[114];
      s.mem_read_request = raw[115];
      s.mem_write_request= raw[116];
      s.mem_op           = raw[148:117];
      unpack_compute_head_ctx = s;
    end
  endfunction

  function automatic logic [7:0] instr_op(input logic [31:0] instr);
    instr_op = instr[7:0];
  endfunction

  function automatic logic [7:0] instr_layer(input logic [31:0] instr);
    instr_layer = instr[15:8];
  endfunction

  function automatic logic [7:0] instr_head(input logic [31:0] instr);
    instr_head = instr[23:16];
  endfunction

  function automatic logic [7:0] instr_tile(input logic [31:0] instr);
    instr_tile = instr[31:24];
  endfunction

  typedef struct packed {
    logic [31:0] control;
    logic [31:0] irq_mask;
    logic [31:0] irq_clear;
    logic [31:0] dma_layer_len;
    logic [31:0] dma_head_len;
    logic [31:0] dma_tile_len;
    logic [31:0] layer_stride;
    logic [31:0] wq_head_stride;
    logic [31:0] wk_head_stride;
    logic [31:0] wv_head_stride;
    logic [31:0] k_cache_stride;
    logic [31:0] v_cache_stride;
    logic [31:0] wo_tile_stride;
    logic [31:0] w1_tile_stride;
    logic [31:0] w2_tile_stride;
    logic [31:0] wq_bias_head_stride;
    logic [31:0] wk_bias_head_stride;
    logic [31:0] wv_bias_head_stride;
    logic [31:0] wo_bias_tile_stride;
    logic [31:0] w1_bias_tile_stride;
    logic [31:0] w2_bias_tile_stride;
    logic [31:0] ln0_gamma_stride;
    logic [31:0] ln1_gamma_stride;
    logic [31:0] final_norm_gamma_stride;
    logic [31:0] ln0_eps_stride;
    logic [31:0] ln1_eps_stride;
    logic [31:0] final_norm_eps_stride;
    logic [63:0] wq_base_addr;
    logic [63:0] wk_base_addr;
    logic [63:0] wv_base_addr;
    logic [63:0] wo_base_addr;
    logic [63:0] w1_base_addr;
    logic [63:0] w2_base_addr;
    logic [63:0] k_cache_addr;
    logic [63:0] v_cache_addr;
    logic [63:0] wq_bias_base_addr;
    logic [63:0] wk_bias_base_addr;
    logic [63:0] wv_bias_base_addr;
    logic [63:0] wo_bias_base_addr;
    logic [63:0] w1_bias_base_addr;
    logic [63:0] w2_bias_base_addr;
    logic [63:0] ln0_gamma_base_addr;
    logic [63:0] ln1_gamma_base_addr;
    logic [63:0] final_norm_gamma_base_addr;
    logic [63:0] ln0_eps_base_addr;
    logic [63:0] ln1_eps_base_addr;
    logic [63:0] final_norm_eps_base_addr;
  } dbg_control_mem_t;

  logic ap_clk;
  logic ap_rst_n;

  // AXI4-Full (DDR model) interface
  logic         m_axi_gmem_AWVALID;
  logic         m_axi_gmem_AWREADY;
  logic [63:0]  m_axi_gmem_AWADDR;
  logic [0:0]   m_axi_gmem_AWID;
  logic [7:0]   m_axi_gmem_AWLEN;
  logic [2:0]   m_axi_gmem_AWSIZE;
  logic [1:0]   m_axi_gmem_AWBURST;
  logic [1:0]   m_axi_gmem_AWLOCK;
  logic [3:0]   m_axi_gmem_AWCACHE;
  logic [2:0]   m_axi_gmem_AWPROT;
  logic [3:0]   m_axi_gmem_AWQOS;
  logic [3:0]   m_axi_gmem_AWREGION;
  logic [0:0]   m_axi_gmem_AWUSER;

  logic         m_axi_gmem_WVALID;
  logic         m_axi_gmem_WREADY;
  logic [31:0]  m_axi_gmem_WDATA;
  logic [3:0]   m_axi_gmem_WSTRB;
  logic         m_axi_gmem_WLAST;
  logic [0:0]   m_axi_gmem_WID;
  logic [0:0]   m_axi_gmem_WUSER;

  logic         m_axi_gmem_ARVALID;
  logic         m_axi_gmem_ARREADY;
  logic [63:0]  m_axi_gmem_ARADDR;
  logic [0:0]   m_axi_gmem_ARID;
  logic [7:0]   m_axi_gmem_ARLEN;
  logic [2:0]   m_axi_gmem_ARSIZE;
  logic [1:0]   m_axi_gmem_ARBURST;
  logic [1:0]   m_axi_gmem_ARLOCK;
  logic [3:0]   m_axi_gmem_ARCACHE;
  logic [2:0]   m_axi_gmem_ARPROT;
  logic [3:0]   m_axi_gmem_ARQOS;
  logic [3:0]   m_axi_gmem_ARREGION;
  logic [0:0]   m_axi_gmem_ARUSER;

  logic         m_axi_gmem_RVALID;
  logic         m_axi_gmem_RREADY;
  logic [31:0]  m_axi_gmem_RDATA;
  logic         m_axi_gmem_RLAST;
  logic [0:0]   m_axi_gmem_RID;
  logic [0:0]   m_axi_gmem_RUSER;
  logic [1:0]   m_axi_gmem_RRESP;

  logic         m_axi_gmem_BVALID;
  logic         m_axi_gmem_BREADY;
  logic [1:0]   m_axi_gmem_BRESP;
  logic [0:0]   m_axi_gmem_BID;
  logic [0:0]   m_axi_gmem_BUSER;

  // AXI4-Stream ingress/egress
  logic [7:0] s_axis_in_TDATA;
  logic       s_axis_in_TVALID;
  logic       s_axis_in_TREADY;
  logic [0:0] s_axis_in_TKEEP;
  logic [0:0] s_axis_in_TSTRB;
  logic [0:0] s_axis_in_TLAST;

  logic [7:0] m_axis_out_TDATA;
  logic       m_axis_out_TVALID;
  logic       m_axis_out_TREADY;
  logic [0:0] m_axis_out_TKEEP;
  logic [0:0] m_axis_out_TSTRB;
  logic [0:0] m_axis_out_TLAST;

  logic [8:0]  s_axi_control_AWADDR;
  logic        s_axi_control_AWVALID;
  logic        s_axi_control_WVALID;
  logic [31:0] s_axi_control_WDATA;
  logic [3:0]  s_axi_control_WSTRB;
  logic [8:0]  s_axi_control_ARADDR;
  logic        s_axi_control_ARVALID;
  logic        s_axi_control_RREADY;
  logic        s_axi_control_BREADY;

  logic         s_axi_control_AWREADY;
  logic         s_axi_control_WREADY;
  logic         s_axi_control_ARREADY;
  logic         s_axi_control_RVALID;
  logic [31:0]  s_axi_control_RDATA;
  logic [1:0]   s_axi_control_RRESP;
  logic         s_axi_control_BVALID;
  logic [1:0]   s_axi_control_BRESP;

  logic [0:0] irq_ps;
  logic [31:0] dbg_state;
  logic       dbg_state_ap_vld;
  logic [2143:0] dbg_ctrl_mem;
  logic       dbg_ctrl_mem_ap_vld;
  logic [31:0] control_reg;
  logic       control_reg_ap_vld;
  logic [31:0] irq_status_reg;
  logic       irq_status_reg_ap_vld;
  logic [31:0] irq_mask_reg;
  logic       irq_mask_reg_ap_vld;
  logic [31:0] irq_clear_reg;
  logic       irq_clear_reg_ap_vld;
  logic [31:0] wq_base_addr;
  logic       wq_base_addr_ap_vld;
  logic [31:0] wk_base_addr;
  logic       wk_base_addr_ap_vld;
  logic [31:0] wv_base_addr;
  logic       wv_base_addr_ap_vld;
  logic [31:0] wo_base_addr;
  logic       wo_base_addr_ap_vld;
  logic [31:0] w1_base_addr;
  logic       w1_base_addr_ap_vld;
  logic [31:0] w2_base_addr;
  logic       w2_base_addr_ap_vld;
  logic [31:0] wq_head_stride;
  logic       wq_head_stride_ap_vld;
  logic [31:0] wk_head_stride;
  logic       wk_head_stride_ap_vld;
  logic [31:0] wv_head_stride;
  logic       wv_head_stride_ap_vld;
  logic [31:0] wo_tile_stride;
  logic       wo_tile_stride_ap_vld;
  logic [31:0] w1_tile_stride;
  logic       w1_tile_stride_ap_vld;
  logic [31:0] w2_tile_stride;
  logic       w2_tile_stride_ap_vld;
  logic [0:0] dbg_wl_ready;
  logic       dbg_wl_ready_ap_vld;
  logic [31:0] dbg_wl_instruction;
  logic       dbg_wl_instruction_ap_vld;
  logic [0:0] dbg_wl_start;
  logic       dbg_wl_start_ap_vld;
  logic [0:0] dbg_wl_accept;
  logic       dbg_wl_accept_ap_vld;
  logic [0:0] dbg_dma_done;
  logic       dbg_dma_done_ap_vld;
  logic [0:0] dbg_mem_transfer_done;
  logic       dbg_mem_transfer_done_ap_vld;
  logic [0:0] dbg_mem_read_request;
  logic       dbg_mem_read_request_ap_vld;
  logic [0:0] dbg_mem_write_request;
  logic       dbg_mem_write_request_ap_vld;
  logic [31:0] dbg_mem_op;
  logic       dbg_mem_op_ap_vld;
  logic [0:0] dbg_compute_start;
  logic       dbg_compute_start_ap_vld;
  logic [31:0] dbg_compute_instruction;
  logic       dbg_compute_instruction_ap_vld;
  logic [0:0] dbg_compute_ready;
  logic       dbg_compute_ready_ap_vld;
  logic [0:0] dbg_compute_done;
  logic       dbg_compute_done_ap_vld;
  logic [7:0] dbg_compute_state;
  logic       dbg_compute_state_ap_vld;
  logic [31:0] dbg_req_instruction;
  logic       dbg_req_instruction_ap_vld;
  logic [7:0] dbg_req_op;
  logic       dbg_req_op_ap_vld;
  logic [7:0] dbg_req_layer;
  logic       dbg_req_layer_ap_vld;
  logic [7:0] dbg_req_head;
  logic       dbg_req_head_ap_vld;
  logic [7:0] dbg_req_tile;
  logic       dbg_req_tile_ap_vld;
  logic [0:0] dbg_mac_start;
  logic       dbg_mac_start_ap_vld;
  logic [0:0] dbg_mac_ready;
  logic       dbg_mac_ready_ap_vld;
  logic [0:0] dbg_mac_complete;
  logic       dbg_mac_complete_ap_vld;
  logic [0:0] dbg_ctrl_reset_asserted;
  logic       dbg_ctrl_reset_asserted_ap_vld;
  logic [31:0] dbg_head_group_idx;
  logic       dbg_head_group_idx_ap_vld;
  logic [0:0] dbg_error;
  logic       dbg_error_ap_vld;
  logic [31:0] dbg_error_code;
  logic       dbg_error_code_ap_vld;
  logic [0:0] dbg_done;
  logic       dbg_done_ap_vld;
  logic [0:0] dbg_axis_is_empty;
  logic       dbg_axis_is_empty_ap_vld;
  logic [0:0] dbg_axis_in_ready_wire;
  logic       dbg_axis_in_ready_wire_ap_vld;
  logic [0:0] dbg_axis_in_last_wire;
  logic       dbg_axis_in_last_wire_ap_vld;
  logic [31:0] dbg_stream_in_counter;
  logic       dbg_stream_in_counter_ap_vld;

  logic [208:0] dbg_head_ctx_ref_0;
  logic         dbg_head_ctx_ref_0_ap_vld;
  logic [208:0] dbg_head_ctx_ref_1;
  logic         dbg_head_ctx_ref_1_ap_vld;
  logic [148:0] dbg_head_compute_ctx_0;
  logic         dbg_head_compute_ctx_0_ap_vld;
  logic [148:0] dbg_head_compute_ctx_1;
  logic         dbg_head_compute_ctx_1_ap_vld;

  wire [6:0] dbg_in_buf_address0;
  wire       dbg_in_buf_ce0;
  wire       dbg_in_buf_we0;
  wire [7:0] dbg_in_buf_d0;

  wire [5:0] dbg_out_buf_address0;
  wire       dbg_out_buf_ce0;
  wire       dbg_out_buf_we0;
  wire [7:0] dbg_out_buf_d0;

  wire [6:0] dbg_head_in_buf_0_address0;
  wire       dbg_head_in_buf_0_ce0;
  wire       dbg_head_in_buf_0_we0;
  wire [7:0] dbg_head_in_buf_0_d0;
  wire [6:0] dbg_head_in_buf_1_address0;
  wire       dbg_head_in_buf_1_ce0;
  wire       dbg_head_in_buf_1_we0;
  wire [7:0] dbg_head_in_buf_1_d0;

  wire [5:0] dbg_head_out_buf_0_address0;
  wire       dbg_head_out_buf_0_ce0;
  wire       dbg_head_out_buf_0_we0;
  wire [7:0] dbg_head_out_buf_0_d0;
  wire [5:0] dbg_head_out_buf_1_address0;
  wire       dbg_head_out_buf_1_ce0;
  wire       dbg_head_out_buf_1_we0;
  wire [7:0] dbg_head_out_buf_1_d0;
  wire [3:0] dbg_stream_in_buf_address0;
  wire       dbg_stream_in_buf_ce0;
  wire       dbg_stream_in_buf_we0;
  wire [7:0] dbg_stream_in_buf_d0;

  logic [7:0]  stream_in_mem [0:STREAM_IN_BUF_BYTES-1];
  logic [7:0]  stream_out_mem[0:STREAM_OUT_BUF_BYTES-1];
  logic [31:0] dma_rx_mem    [0:TOP_DMA_BUF_WORDS-1];
  logic [31:0] dma_tx_mem    [0:TOP_DMA_BUF_WORDS-1];
  logic [31:0] wq_ram        [0:RAM_REGION_WORDS-1];
  logic [31:0] wk_ram        [0:RAM_REGION_WORDS-1];
  logic [31:0] wv_ram        [0:RAM_REGION_WORDS-1];
  logic [31:0] wo_ram        [0:RAM_REGION_WORDS-1];
  logic [31:0] w1_ram        [0:RAM_REGION_WORDS-1];
  logic [31:0] w2_ram        [0:RAM_REGION_WORDS-1];
  logic [31:0] ln0_gamma_ram [0:RAM_REGION_WORDS-1];
  logic [31:0] ln1_gamma_ram [0:RAM_REGION_WORDS-1];
  logic [31:0] ln0_eps_ram   [0:RAM_REGION_WORDS-1];
  logic [31:0] ln1_eps_ram   [0:RAM_REGION_WORDS-1];
  logic [31:0] k_cache_store [0:KV_STORE_WORDS-1];
  logic [31:0] v_cache_store [0:KV_STORE_WORDS-1];
  // Per-head struct mirrors.
  head_ctx_t dbg_head_ctx_ref_0_struct;
  head_ctx_t dbg_head_ctx_ref_1_struct;
  ComputeHeadCtx_t dbg_head_compute_ctx_0_struct;
  ComputeHeadCtx_t dbg_head_compute_ctx_1_struct;
  logic [7:0] dbg_in_buf_mem [0:127];
  logic [7:0] dbg_out_buf_mem [0:63];
  logic [7:0] dbg_stream_in_buf_mem [0:STREAM_IN_BUF_BYTES-1];
  logic [7:0] dbg_head_in_buf_mem [0:255];
  logic [7:0] dbg_head_out_buf_mem [0:127];

  // --------------------------------------------------------------------------
  // Debug buffer snapshots (for easier full-buffer validation in waveform)
  // --------------------------------------------------------------------------
  logic [7:0] main_in_snap  [0:DBG_SNAP_DEPTH-1][0:DBG_MAIN_IN_BYTES-1];
  logic [7:0] main_out_snap [0:DBG_SNAP_DEPTH-1][0:DBG_MAIN_OUT_BYTES-1];
  logic       main_in_snap_valid  [0:DBG_SNAP_DEPTH-1];
  logic       main_out_snap_valid [0:DBG_SNAP_DEPTH-1];
  logic [31:0] main_in_snap_cycle [0:DBG_SNAP_DEPTH-1];
  logic [31:0] main_out_snap_cycle[0:DBG_SNAP_DEPTH-1];
  logic [31:0] main_in_snap_instr [0:DBG_SNAP_DEPTH-1];
  logic [31:0] main_out_snap_instr[0:DBG_SNAP_DEPTH-1];
  logic [7:0]  main_in_snap_op    [0:DBG_SNAP_DEPTH-1];
  logic [7:0]  main_out_snap_op   [0:DBG_SNAP_DEPTH-1];
  logic [7:0]  main_in_snap_layer [0:DBG_SNAP_DEPTH-1];
  logic [7:0]  main_out_snap_layer[0:DBG_SNAP_DEPTH-1];
  logic [7:0]  main_in_snap_head  [0:DBG_SNAP_DEPTH-1];
  logic [7:0]  main_out_snap_head [0:DBG_SNAP_DEPTH-1];
  logic [7:0]  main_in_snap_tile  [0:DBG_SNAP_DEPTH-1];
  logic [7:0]  main_out_snap_tile [0:DBG_SNAP_DEPTH-1];
  logic [$clog2(DBG_SNAP_DEPTH)-1:0] main_in_snap_wr_idx;
  logic [$clog2(DBG_SNAP_DEPTH)-1:0] main_out_snap_wr_idx;
  logic main_in_capture_pending;
  logic main_out_capture_pending;
  logic [3:0] main_in_quiet_ctr;
  logic [3:0] main_out_quiet_ctr;
  logic [31:0] main_in_pending_instr;
  logic [31:0] main_out_pending_instr;
  logic [31:0] main_active_instr;
  logic [7:0]  main_in_pending_op;
  logic [7:0]  main_out_pending_op;
  logic [7:0]  main_active_op;
  logic [7:0]  main_in_pending_layer;
  logic [7:0]  main_out_pending_layer;
  logic [7:0]  main_active_layer;
  logic [7:0]  main_in_pending_head;
  logic [7:0]  main_out_pending_head;
  logic [7:0]  main_active_head;
  logic [7:0]  main_in_pending_tile;
  logic [7:0]  main_out_pending_tile;
  logic [7:0]  main_active_tile;
  logic [31:0] main_last_seen_instr;
  logic dbg_compute_start_d;
  logic dbg_compute_done_d;

  logic [7:0] head_in_snap  [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1][0:DBG_HEAD_IN_BYTES-1];
  logic [7:0] head_out_snap [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1][0:DBG_HEAD_OUT_BYTES-1];
  logic       head_in_snap_valid  [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic       head_out_snap_valid [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [31:0] head_in_snap_cycle [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [31:0] head_out_snap_cycle[0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [31:0] head_in_snap_instr [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [31:0] head_out_snap_instr[0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [7:0]  head_in_snap_op    [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [7:0]  head_out_snap_op   [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [7:0]  head_in_snap_layer [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [7:0]  head_out_snap_layer[0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [7:0]  head_in_snap_head  [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [7:0]  head_out_snap_head [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [7:0]  head_in_snap_tile  [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [7:0]  head_out_snap_tile [0:TB_HEADS_PARALLEL-1][0:DBG_SNAP_DEPTH-1];
  logic [$clog2(DBG_SNAP_DEPTH)-1:0] head_in_snap_wr_idx  [0:TB_HEADS_PARALLEL-1];
  logic [$clog2(DBG_SNAP_DEPTH)-1:0] head_out_snap_wr_idx [0:TB_HEADS_PARALLEL-1];
  logic head_in_capture_pending [0:TB_HEADS_PARALLEL-1];
  logic head_out_capture_pending[0:TB_HEADS_PARALLEL-1];
  logic [3:0] head_in_quiet_ctr  [0:TB_HEADS_PARALLEL-1];
  logic [3:0] head_out_quiet_ctr [0:TB_HEADS_PARALLEL-1];
  logic [31:0] head_in_pending_instr [0:TB_HEADS_PARALLEL-1];
  logic [31:0] head_out_pending_instr[0:TB_HEADS_PARALLEL-1];
  logic [31:0] head_active_instr     [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_in_pending_op    [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_out_pending_op   [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_active_op        [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_in_pending_layer [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_out_pending_layer[0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_active_layer     [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_in_pending_head  [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_out_pending_head [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_active_head      [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_in_pending_tile  [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_out_pending_tile [0:TB_HEADS_PARALLEL-1];
  logic [7:0]  head_active_tile      [0:TB_HEADS_PARALLEL-1];
  logic [31:0] head_last_seen_instr  [0:TB_HEADS_PARALLEL-1];
  logic head_compute_start_d [0:TB_HEADS_PARALLEL-1];
  logic head_compute_done_d  [0:TB_HEADS_PARALLEL-1];

  // Operation-indexed banks for easier debug (inputs/outputs separated by op).
  logic [7:0] main_in_by_op   [0:31][0:DBG_MAIN_IN_BYTES-1];
  logic [7:0] main_out_by_op  [0:31][0:DBG_MAIN_OUT_BYTES-1];
  logic [7:0] head_in_by_op   [0:TB_NUM_HEADS-1][0:31][0:DBG_HEAD_IN_BYTES-1];
  logic [7:0] head_out_by_op  [0:TB_NUM_HEADS-1][0:31][0:DBG_HEAD_OUT_BYTES-1];

  // Decoded per-op output banks (same debug style as legacy TB).
  logic [7:0] out_proj_out [0:TB_D_MODEL-1];
  logic [7:0] resid1_out   [0:TB_D_MODEL-1];
  logic [7:0] resid2_out   [0:TB_D_MODEL-1];
  logic [7:0] ln0_out      [0:TB_D_MODEL-1];
  logic [7:0] ln1_out      [0:TB_D_MODEL-1];
  logic [7:0] ffn_w2_out   [0:TB_D_MODEL-1];
  logic [7:0] out_proj_out_by_tile [0:TB_NUM_WO_TILES-1][0:TB_D_TILE_WO-1];
  logic signed [15:0] ffn_w1_out_by_tile [0:TB_NUM_W1_TILES-1][0:TB_D_TILE_W1-1];
  logic [7:0] ffn_w2_out_by_tile [0:TB_NUM_W2_TILES-1][0:TB_D_TILE_W2-1];
  logic signed [31:0] final_norm_out [0:TB_D_MODEL-1];
  logic signed [15:0] ffn_w1_out [0:TB_D_FFN-1];
  logic signed [15:0] ffn_act_out[0:TB_D_FFN-1];
  logic signed [7:0] q_out        [0:TB_NUM_HEADS-1][0:TB_D_HEADS-1];
  logic signed [7:0] k_out        [0:TB_NUM_HEADS-1][0:TB_D_HEADS-1];
  logic signed [7:0] v_out        [0:TB_NUM_HEADS-1][0:TB_D_HEADS-1];
  logic signed [7:0] head_rq_out  [0:TB_NUM_HEADS-1][0:TB_D_HEADS-1];
  logic signed [31:0] att_scores_out [0:TB_NUM_HEADS-1][0:TB_CONTEXT_LENGTH-1];
  logic signed [15:0] val_scale_out  [0:TB_NUM_HEADS-1][0:TB_CONTEXT_LENGTH-1];
  logic signed [15:0] softmax_out    [0:TB_NUM_HEADS-1][0:TB_CONTEXT_LENGTH-1];
  logic signed [31:0] att_value_out  [0:TB_NUM_HEADS-1][0:TB_D_HEADS-1];

  integer cycle_count;
  integer i;
  logic axis_packet_sent;
  logic stream_fill_active;
  logic [$clog2(STREAM_IN_BUF_BYTES+1)-1:0] stream_fill_idx;
  logic [3:0] stream_gap_countdown;
  integer stream_out_count;
  logic stream_out_last_seen;

  // Simple AXI4-Full memory model state (single outstanding read/write burst).
  logic        axi_aw_active;
  logic [63:0] axi_aw_addr_latched;
  logic [7:0]  axi_aw_len_latched;
  logic [2:0]  axi_aw_size_latched;
  logic [7:0]  axi_w_beats_seen;
  logic [0:0]  axi_bid_latched;
  logic [1:0]  axi_bresp_latched;

  logic        axi_ar_active;
  logic [63:0] axi_ar_addr_latched;
  logic [7:0]  axi_ar_len_latched;
  logic [2:0]  axi_ar_size_latched;
  logic [7:0]  axi_r_beats_sent;
  logic [0:0]  axi_rid_latched;

  logic [31:0] ctrl_words [0:CTRL_MEM_WORDS-1];
  logic [31:0] dbg_ctrl_words [0:DBG_CTRL_MEM_WORDS-1];
  dbg_control_mem_t dbg_ctrl_mem_shadow;

  // AXI ctrl_mem word map for ControlMemSpace.
  // Note: there is one 32-bit alignment padding word before the first uint64_t field.
  localparam int CTRLW_CONTROL            = 0;
  localparam int CTRLW_IRQ_MASK           = 1;
  localparam int CTRLW_IRQ_CLEAR          = 2;
  localparam int CTRLW_DMA_LAYER_LEN      = 3;
  localparam int CTRLW_DMA_HEAD_LEN       = 4;
  localparam int CTRLW_DMA_TILE_LEN       = 5;
  localparam int CTRLW_LAYER_STRIDE       = 6;
  localparam int CTRLW_WQ_HEAD_STRIDE     = 7;
  localparam int CTRLW_WK_HEAD_STRIDE     = 8;
  localparam int CTRLW_WV_HEAD_STRIDE     = 9;
  localparam int CTRLW_K_CACHE_STRIDE     = 10;
  localparam int CTRLW_V_CACHE_STRIDE     = 11;
  localparam int CTRLW_WO_TILE_STRIDE     = 12;
  localparam int CTRLW_W1_TILE_STRIDE     = 13;
  localparam int CTRLW_W2_TILE_STRIDE     = 14;
  localparam int CTRLW_WQ_BIAS_HEAD_STRIDE = 15;
  localparam int CTRLW_WK_BIAS_HEAD_STRIDE = 16;
  localparam int CTRLW_WV_BIAS_HEAD_STRIDE = 17;
  localparam int CTRLW_WO_BIAS_TILE_STRIDE = 18;
  localparam int CTRLW_W1_BIAS_TILE_STRIDE = 19;
  localparam int CTRLW_W2_BIAS_TILE_STRIDE = 20;
  localparam int CTRLW_LN0_GAMMA_STRIDE   = 21;
  localparam int CTRLW_LN1_GAMMA_STRIDE   = 22;
  localparam int CTRLW_FINAL_NORM_GAMMA_STRIDE = 23;
  localparam int CTRLW_LN0_EPS_STRIDE     = 24;
  localparam int CTRLW_LN1_EPS_STRIDE     = 25;
  localparam int CTRLW_FINAL_NORM_EPS_STRIDE = 26;
  localparam int CTRLW_ALIGN_PAD0         = 27;
  localparam int CTRLW_WQ_BASE_LO         = 28;
  localparam int CTRLW_WQ_BASE_HI         = 29;
  localparam int CTRLW_WK_BASE_LO         = 30;
  localparam int CTRLW_WK_BASE_HI         = 31;
  localparam int CTRLW_WV_BASE_LO         = 32;
  localparam int CTRLW_WV_BASE_HI         = 33;
  localparam int CTRLW_WO_BASE_LO         = 34;
  localparam int CTRLW_WO_BASE_HI         = 35;
  localparam int CTRLW_W1_BASE_LO         = 36;
  localparam int CTRLW_W1_BASE_HI         = 37;
  localparam int CTRLW_W2_BASE_LO         = 38;
  localparam int CTRLW_W2_BASE_HI         = 39;
  localparam int CTRLW_K_CACHE_LO         = 40;
  localparam int CTRLW_K_CACHE_HI         = 41;
  localparam int CTRLW_V_CACHE_LO         = 42;
  localparam int CTRLW_V_CACHE_HI         = 43;
  localparam int CTRLW_WQ_BIAS_BASE_LO    = 44;
  localparam int CTRLW_WQ_BIAS_BASE_HI    = 45;
  localparam int CTRLW_WK_BIAS_BASE_LO    = 46;
  localparam int CTRLW_WK_BIAS_BASE_HI    = 47;
  localparam int CTRLW_WV_BIAS_BASE_LO    = 48;
  localparam int CTRLW_WV_BIAS_BASE_HI    = 49;
  localparam int CTRLW_WO_BIAS_BASE_LO    = 50;
  localparam int CTRLW_WO_BIAS_BASE_HI    = 51;
  localparam int CTRLW_W1_BIAS_BASE_LO    = 52;
  localparam int CTRLW_W1_BIAS_BASE_HI    = 53;
  localparam int CTRLW_W2_BIAS_BASE_LO    = 54;
  localparam int CTRLW_W2_BIAS_BASE_HI    = 55;
  localparam int CTRLW_LN0_GAMMA_BASE_LO  = 56;
  localparam int CTRLW_LN0_GAMMA_BASE_HI  = 57;
  localparam int CTRLW_LN1_GAMMA_BASE_LO  = 58;
  localparam int CTRLW_LN1_GAMMA_BASE_HI  = 59;
  localparam int CTRLW_FINAL_NORM_GAMMA_BASE_LO = 60;
  localparam int CTRLW_FINAL_NORM_GAMMA_BASE_HI = 61;
  localparam int CTRLW_LN0_EPS_BASE_LO    = 62;
  localparam int CTRLW_LN0_EPS_BASE_HI    = 63;
  localparam int CTRLW_LN1_EPS_BASE_LO    = 64;
  localparam int CTRLW_LN1_EPS_BASE_HI    = 65;
  localparam int CTRLW_FINAL_NORM_EPS_BASE_LO = 66;
  localparam int CTRLW_FINAL_NORM_EPS_BASE_HI = 67;

  // 64-bit DDR base map for control memory programming.
  localparam logic [63:0] BASE_WQ               = 64'h0000_0001_6000_0000;
  localparam logic [63:0] BASE_WK               = 64'h0000_0001_6100_0000;
  localparam logic [63:0] BASE_WV               = 64'h0000_0001_6200_0000;
  localparam logic [63:0] BASE_WO               = 64'h0000_0001_6300_0000;
  localparam logic [63:0] BASE_W1               = 64'h0000_0001_6400_0000;
  localparam logic [63:0] BASE_W2               = 64'h0000_0001_6500_0000;
  localparam logic [63:0] BASE_K_CACHE          = 64'h0000_0001_6600_0000;
  localparam logic [63:0] BASE_V_CACHE          = 64'h0000_0001_6700_0000;
  localparam logic [63:0] BASE_WQ_BIAS          = 64'h0000_0001_6008_0000;
  localparam logic [63:0] BASE_WK_BIAS          = 64'h0000_0001_6108_0000;
  localparam logic [63:0] BASE_WV_BIAS          = 64'h0000_0001_6208_0000;
  localparam logic [63:0] BASE_WO_BIAS          = 64'h0000_0001_6308_0000;
  localparam logic [63:0] BASE_W1_BIAS          = 64'h0000_0001_6408_0000;
  localparam logic [63:0] BASE_W2_BIAS          = 64'h0000_0001_6508_0000;
  localparam logic [63:0] BASE_LN0_GAMMA        = 64'h0000_0001_6800_0000;
  localparam logic [63:0] BASE_LN1_GAMMA        = 64'h0000_0001_6900_0000;
  localparam logic [63:0] BASE_FINAL_NORM_GAMMA = 64'h0000_0001_6C00_0000;
  localparam logic [63:0] BASE_LN0_EPS          = 64'h0000_0001_6A00_0000;
  localparam logic [63:0] BASE_LN1_EPS          = 64'h0000_0001_6B00_0000;
  localparam logic [63:0] BASE_FINAL_NORM_EPS   = 64'h0000_0001_6D00_0000;

  typedef enum logic [2:0] {
    AXI_IDLE,
    AXI_WRITE_ADDR,
    AXI_WRITE_RESP,
    AXI_READ_ADDR,
    AXI_READ_DATA
  } axi_state_t;
  axi_state_t axi_state;

  typedef enum logic [2:0] {
    CTRL_RESET_MEM,
    CTRL_ASSERT_RESET,
    CTRL_DEASSERT_RESET,
    CTRL_PROGRAM_BASES,
    CTRL_ASSERT_AP_START,
    CTRL_ASSERT_START,
    CTRL_CLEAR_START,
    CTRL_DONE
  } ctrl_init_stage_t;
  ctrl_init_stage_t ctrl_stage;

  typedef enum logic [1:0] {
    IRQ_RD_STATUS = 2'd0,
    IRQ_RD_STATE  = 2'd1,
    IRQ_RD_DONE   = 2'd2
  } irq_read_phase_t;
  irq_read_phase_t irq_read_phase;

  typedef enum logic [1:0] {
    ERR_PHASE_READ = 2'd0,
    ERR_PHASE_CLEAR = 2'd1
  } err_phase_t;
  err_phase_t err_phase;

  logic [8:0]  ctrl_addr;
  logic [31:0] ctrl_data_in;
  logic        ctrl_read_en;
  logic        ctrl_write_en;
  logic        ctrl_chip_en;
  logic [31:0] ctrl_shadow_control;
  integer      ctrl_gap_cycles;
  integer      base_assign_step;
  logic [31:0] axi_rdata;
  logic        axi_read_valid;
  logic [8:0]  axi_addr;
  logic        axi_is_write;
  logic        axi_aw_seen;
  logic        axi_w_seen;
  logic        axi_b_seen;
  logic [31:0] error_code_lat;
  logic        irq_pending;
  logic        irq_seen_done;
  logic        irq_seen_error;
  logic        irq_seen_done_clr;
  logic        irq_seen_error_clr;
  logic        irq_req_valid;
  logic        irq_req_read;
  logic [8:0]  irq_req_addr;
  logic        done_req_valid;
  logic        done_req_write;
  logic [8:0]  done_req_addr;
  logic [31:0] done_req_wdata;
  logic        error_req_valid;
  logic        error_req_write;
  logic        error_req_read;
  logic [8:0]  error_req_addr;
  logic [31:0] error_req_wdata;
  wire         irq_req_fire;
  wire         done_req_fire;
  wire         error_req_fire;
  wire         ctrl_can_issue;

  always #(CLK_PERIOD_NS/2) ap_clk = ~ap_clk;

  assign ctrl_can_issue = (ctrl_gap_cycles == 0) && (axi_state == AXI_IDLE);
  assign irq_req_fire   = ctrl_can_issue && irq_req_valid;
  assign done_req_fire  = ctrl_can_issue && !irq_req_valid && done_req_valid;
  assign error_req_fire = ctrl_can_issue && !irq_req_valid && !done_req_valid && error_req_valid;

  function automatic [31:0] dma_pattern_word(
    input [63:0] base_addr,
    input int unsigned word_idx
  );
    dma_pattern_word = base_addr[31:0] ^ (32'h1357_0000 + word_idx);
  endfunction

  function automatic [8:0] ctrl_mem_addr(input int word_idx);
    ctrl_mem_addr = ADDR_CTRL_MEM_DATA_0 + (word_idx * 4);
  endfunction

  function automatic [63:0] ctrl_base_addr64(input int lo_idx, input int hi_idx);
    ctrl_base_addr64 = {ctrl_words[hi_idx], ctrl_words[lo_idx]};
  endfunction

  function automatic bit in_range64(
    input [63:0] addr,
    input [63:0] base,
    input [63:0] bytes
  );
    in_range64 = (addr >= base) && (addr < (base + bytes));
  endfunction

  function automatic bit is_k_cache_addr(input [63:0] addr);
    is_k_cache_addr = in_range64(addr, ctrl_base_addr64(CTRLW_K_CACHE_LO, CTRLW_K_CACHE_HI), 64'h0000_0000_0100_0000);
  endfunction

  function automatic bit is_v_cache_addr(input [63:0] addr);
    is_v_cache_addr = in_range64(addr, ctrl_base_addr64(CTRLW_V_CACHE_LO, CTRLW_V_CACHE_HI), 64'h0000_0000_0100_0000);
  endfunction

  function automatic bit is_wq_addr(input [63:0] addr);
    is_wq_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WQ_BASE_LO, CTRLW_WQ_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic bit is_wk_addr(input [63:0] addr);
    is_wk_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WK_BASE_LO, CTRLW_WK_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic bit is_wv_addr(input [63:0] addr);
    is_wv_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WV_BASE_LO, CTRLW_WV_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic bit is_wo_addr(input [63:0] addr);
    is_wo_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WO_BASE_LO, CTRLW_WO_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic bit is_w1_addr(input [63:0] addr);
    is_w1_addr = in_range64(addr, ctrl_base_addr64(CTRLW_W1_BASE_LO, CTRLW_W1_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic bit is_w2_addr(input [63:0] addr);
    is_w2_addr = in_range64(addr, ctrl_base_addr64(CTRLW_W2_BASE_LO, CTRLW_W2_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic bit is_ln0_gamma_addr(input [63:0] addr);
    is_ln0_gamma_addr = in_range64(addr, ctrl_base_addr64(CTRLW_LN0_GAMMA_BASE_LO, CTRLW_LN0_GAMMA_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic bit is_ln1_gamma_addr(input [63:0] addr);
    is_ln1_gamma_addr = in_range64(addr, ctrl_base_addr64(CTRLW_LN1_GAMMA_BASE_LO, CTRLW_LN1_GAMMA_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic bit is_ln0_eps_addr(input [63:0] addr);
    is_ln0_eps_addr = in_range64(addr, ctrl_base_addr64(CTRLW_LN0_EPS_BASE_LO, CTRLW_LN0_EPS_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic bit is_ln1_eps_addr(input [63:0] addr);
    is_ln1_eps_addr = in_range64(addr, ctrl_base_addr64(CTRLW_LN1_EPS_BASE_LO, CTRLW_LN1_EPS_BASE_HI), (RAM_REGION_WORDS << 2));
  endfunction

  function automatic int unsigned region_index(
    input [63:0] addr,
    input [63:0] base_addr
  );
    logic [63:0] byte_off;
    begin
      byte_off = addr - base_addr;
      region_index = (byte_off >> 2) & (RAM_REGION_WORDS - 1);
    end
  endfunction

  function automatic int unsigned kv_store_index(
    input [63:0] addr,
    input [63:0] base_addr
  );
    logic [63:0] byte_off;
    begin
      byte_off = addr - base_addr;
      kv_store_index = (byte_off >> 2) & (KV_STORE_WORDS - 1);
    end
  endfunction

  function automatic [31:0] mem_read_word(input [63:0] addr64);
    logic [63:0] addr;
    int unsigned idx;
    begin
      addr = addr64;
      if (is_k_cache_addr(addr)) begin
        idx = kv_store_index(addr, ctrl_base_addr64(CTRLW_K_CACHE_LO, CTRLW_K_CACHE_HI));
        mem_read_word = k_cache_store[idx];
      end else if (is_v_cache_addr(addr)) begin
        idx = kv_store_index(addr, ctrl_base_addr64(CTRLW_V_CACHE_LO, CTRLW_V_CACHE_HI));
        mem_read_word = v_cache_store[idx];
      end else if (is_wq_addr(addr)) begin
        mem_read_word = wq_ram[region_index(addr, ctrl_base_addr64(CTRLW_WQ_BASE_LO, CTRLW_WQ_BASE_HI))];
      end else if (is_wk_addr(addr)) begin
        mem_read_word = wk_ram[region_index(addr, ctrl_base_addr64(CTRLW_WK_BASE_LO, CTRLW_WK_BASE_HI))];
      end else if (is_wv_addr(addr)) begin
        mem_read_word = wv_ram[region_index(addr, ctrl_base_addr64(CTRLW_WV_BASE_LO, CTRLW_WV_BASE_HI))];
      end else if (is_wo_addr(addr)) begin
        mem_read_word = wo_ram[region_index(addr, ctrl_base_addr64(CTRLW_WO_BASE_LO, CTRLW_WO_BASE_HI))];
      end else if (is_w1_addr(addr)) begin
        mem_read_word = w1_ram[region_index(addr, ctrl_base_addr64(CTRLW_W1_BASE_LO, CTRLW_W1_BASE_HI))];
      end else if (is_w2_addr(addr)) begin
        mem_read_word = w2_ram[region_index(addr, ctrl_base_addr64(CTRLW_W2_BASE_LO, CTRLW_W2_BASE_HI))];
      end else if (is_ln0_gamma_addr(addr)) begin
        mem_read_word = ln0_gamma_ram[region_index(addr, ctrl_base_addr64(CTRLW_LN0_GAMMA_BASE_LO, CTRLW_LN0_GAMMA_BASE_HI))];
      end else if (is_ln1_gamma_addr(addr)) begin
        mem_read_word = ln1_gamma_ram[region_index(addr, ctrl_base_addr64(CTRLW_LN1_GAMMA_BASE_LO, CTRLW_LN1_GAMMA_BASE_HI))];
      end else if (is_ln0_eps_addr(addr)) begin
        mem_read_word = ln0_eps_ram[region_index(addr, ctrl_base_addr64(CTRLW_LN0_EPS_BASE_LO, CTRLW_LN0_EPS_BASE_HI))];
      end else if (is_ln1_eps_addr(addr)) begin
        mem_read_word = ln1_eps_ram[region_index(addr, ctrl_base_addr64(CTRLW_LN1_EPS_BASE_LO, CTRLW_LN1_EPS_BASE_HI))];
      end else begin
        mem_read_word = dma_pattern_word(addr, 0);
      end
    end
  endfunction

  task automatic mem_write_word(
    input [63:0] addr64,
    input [31:0] wdata,
    input [3:0]  wstrb
  );
    logic [63:0] addr;
    logic [31:0] cur;
    logic [31:0] nxt;
    int unsigned idx;
    int b;
    begin
      addr = addr64;

      if (is_k_cache_addr(addr)) begin
        idx = kv_store_index(addr, ctrl_base_addr64(CTRLW_K_CACHE_LO, CTRLW_K_CACHE_HI));
        cur = k_cache_store[idx];
      end else if (is_v_cache_addr(addr)) begin
        idx = kv_store_index(addr, ctrl_base_addr64(CTRLW_V_CACHE_LO, CTRLW_V_CACHE_HI));
        cur = v_cache_store[idx];
      end else if (is_wo_addr(addr)) begin
        cur = wo_ram[region_index(addr, ctrl_base_addr64(CTRLW_WO_BASE_LO, CTRLW_WO_BASE_HI))];
      end else if (is_w1_addr(addr)) begin
        cur = w1_ram[region_index(addr, ctrl_base_addr64(CTRLW_W1_BASE_LO, CTRLW_W1_BASE_HI))];
      end else if (is_w2_addr(addr)) begin
        cur = w2_ram[region_index(addr, ctrl_base_addr64(CTRLW_W2_BASE_LO, CTRLW_W2_BASE_HI))];
      end else begin
        cur = 32'h0000_0000;
      end

      nxt = cur;
      for (b = 0; b < 4; b = b + 1) begin
        if (wstrb[b]) begin
          nxt[(b*8) +: 8] = wdata[(b*8) +: 8];
        end
      end

      if (is_k_cache_addr(addr)) begin
        idx = kv_store_index(addr, ctrl_base_addr64(CTRLW_K_CACHE_LO, CTRLW_K_CACHE_HI));
        k_cache_store[idx] = nxt;
      end else if (is_v_cache_addr(addr)) begin
        idx = kv_store_index(addr, ctrl_base_addr64(CTRLW_V_CACHE_LO, CTRLW_V_CACHE_HI));
        v_cache_store[idx] = nxt;
      end else if (is_wo_addr(addr)) begin
        wo_ram[region_index(addr, ctrl_base_addr64(CTRLW_WO_BASE_LO, CTRLW_WO_BASE_HI))] = nxt;
      end else if (is_w1_addr(addr)) begin
        w1_ram[region_index(addr, ctrl_base_addr64(CTRLW_W1_BASE_LO, CTRLW_W1_BASE_HI))] = nxt;
      end else if (is_w2_addr(addr)) begin
        w2_ram[region_index(addr, ctrl_base_addr64(CTRLW_W2_BASE_LO, CTRLW_W2_BASE_HI))] = nxt;
      end
    end
  endtask

  // AXI writes/reads are driven by AXI_CONTROL_LOGIC + START_FSM blocks.

  // AXI-Lite control bus driver (single outstanding transaction).
  always_ff @(posedge ap_clk) begin : AXI_CONTROL_LOGIC
    if (!ap_rst_n) begin
      axi_state             <= AXI_IDLE;
      axi_addr              <= '0;
      axi_is_write          <= 1'b0;
      axi_aw_seen           <= 1'b0;
      axi_w_seen            <= 1'b0;
      axi_b_seen            <= 1'b0;
      axi_rdata             <= '0;
      axi_read_valid        <= 1'b0;
      s_axi_control_AWVALID <= 1'b0;
      s_axi_control_WVALID  <= 1'b0;
      s_axi_control_ARVALID <= 1'b0;
      s_axi_control_RREADY  <= 1'b1;
      s_axi_control_BREADY  <= 1'b1;
      s_axi_control_AWADDR  <= '0;
      s_axi_control_WDATA   <= '0;
      s_axi_control_WSTRB   <= 4'hF;
      s_axi_control_ARADDR  <= '0;
    end else begin
      if (s_axi_control_BVALID) begin
        axi_b_seen <= 1'b1;
      end
      axi_read_valid <= 1'b0;
      case (axi_state)
        AXI_IDLE: begin
          if (ctrl_chip_en) begin
            axi_addr <= ctrl_addr;
            if (ctrl_write_en) begin
              axi_is_write          <= 1'b1;
              axi_aw_seen           <= 1'b0;
              axi_w_seen            <= 1'b0;
              axi_b_seen            <= 1'b0;
              s_axi_control_AWADDR  <= ctrl_addr;
              s_axi_control_WDATA   <= ctrl_data_in;
              s_axi_control_WSTRB   <= 4'hF;
              s_axi_control_AWVALID <= 1'b1;
              s_axi_control_WVALID  <= 1'b1;
              axi_state             <= AXI_WRITE_ADDR;
            end else if (ctrl_read_en) begin
              axi_is_write          <= 1'b0;
              s_axi_control_ARADDR  <= ctrl_addr;
              s_axi_control_ARVALID <= 1'b1;
              axi_state             <= AXI_READ_ADDR;
            end
          end
        end
        AXI_WRITE_ADDR: begin
          if (s_axi_control_AWREADY && s_axi_control_AWVALID) begin
            s_axi_control_AWVALID <= 1'b0;
            axi_aw_seen           <= 1'b1;
          end
          if (s_axi_control_WREADY && s_axi_control_WVALID) begin
            s_axi_control_WVALID <= 1'b0;
            axi_w_seen           <= 1'b1;
          end
          if (axi_aw_seen && axi_w_seen) begin
            axi_state <= axi_b_seen ? AXI_IDLE : AXI_WRITE_RESP;
          end
        end
        AXI_WRITE_RESP: begin
          if (axi_b_seen) begin
            axi_state   <= AXI_IDLE;
            axi_aw_seen <= 1'b0;
            axi_w_seen  <= 1'b0;
            axi_b_seen  <= 1'b0;
          end
        end
        AXI_READ_ADDR: begin
          if (s_axi_control_ARREADY) begin
            s_axi_control_ARVALID <= 1'b0;
            axi_state <= AXI_READ_DATA;
          end
        end
        AXI_READ_DATA: begin
          if (s_axi_control_RVALID) begin
            axi_rdata <= s_axi_control_RDATA;
            axi_read_valid <= 1'b1;
            axi_state <= AXI_IDLE;
          end
        end
        default: begin
          axi_state <= AXI_IDLE;
        end
      endcase
    end
  end

  // Decode packed dbg_ctrl_mem bus into named fields for waveform/debug readability.
  always_comb begin : p_dbg_ctrl_mem_shadow_unpack
    int w;
    for (w = 0; w < DBG_CTRL_MEM_WORDS; w = w + 1) begin
      dbg_ctrl_words[w] = dbg_ctrl_mem[w*32 +: 32];
    end

    dbg_ctrl_mem_shadow.control                 = dbg_ctrl_words[0];
    dbg_ctrl_mem_shadow.irq_mask                = dbg_ctrl_words[1];
    dbg_ctrl_mem_shadow.irq_clear               = dbg_ctrl_words[2];
    dbg_ctrl_mem_shadow.dma_layer_len           = dbg_ctrl_words[3];
    dbg_ctrl_mem_shadow.dma_head_len            = dbg_ctrl_words[4];
    dbg_ctrl_mem_shadow.dma_tile_len            = dbg_ctrl_words[5];
    dbg_ctrl_mem_shadow.layer_stride            = dbg_ctrl_words[6];
    dbg_ctrl_mem_shadow.wq_head_stride          = dbg_ctrl_words[7];
    dbg_ctrl_mem_shadow.wk_head_stride          = dbg_ctrl_words[8];
    dbg_ctrl_mem_shadow.wv_head_stride          = dbg_ctrl_words[9];
    dbg_ctrl_mem_shadow.k_cache_stride          = dbg_ctrl_words[10];
    dbg_ctrl_mem_shadow.v_cache_stride          = dbg_ctrl_words[11];
    dbg_ctrl_mem_shadow.wo_tile_stride          = dbg_ctrl_words[12];
    dbg_ctrl_mem_shadow.w1_tile_stride          = dbg_ctrl_words[13];
    dbg_ctrl_mem_shadow.w2_tile_stride          = dbg_ctrl_words[14];
    dbg_ctrl_mem_shadow.wq_bias_head_stride     = dbg_ctrl_words[15];
    dbg_ctrl_mem_shadow.wk_bias_head_stride     = dbg_ctrl_words[16];
    dbg_ctrl_mem_shadow.wv_bias_head_stride     = dbg_ctrl_words[17];
    dbg_ctrl_mem_shadow.wo_bias_tile_stride     = dbg_ctrl_words[18];
    dbg_ctrl_mem_shadow.w1_bias_tile_stride     = dbg_ctrl_words[19];
    dbg_ctrl_mem_shadow.w2_bias_tile_stride     = dbg_ctrl_words[20];
    dbg_ctrl_mem_shadow.ln0_gamma_stride        = dbg_ctrl_words[21];
    dbg_ctrl_mem_shadow.ln1_gamma_stride        = dbg_ctrl_words[22];
    dbg_ctrl_mem_shadow.final_norm_gamma_stride = dbg_ctrl_words[23];
    dbg_ctrl_mem_shadow.ln0_eps_stride          = dbg_ctrl_words[24];
    dbg_ctrl_mem_shadow.ln1_eps_stride          = dbg_ctrl_words[25];
    dbg_ctrl_mem_shadow.final_norm_eps_stride   = dbg_ctrl_words[26];
    dbg_ctrl_mem_shadow.wq_base_addr            = {dbg_ctrl_words[28], dbg_ctrl_words[27]};
    dbg_ctrl_mem_shadow.wk_base_addr            = {dbg_ctrl_words[30], dbg_ctrl_words[29]};
    dbg_ctrl_mem_shadow.wv_base_addr            = {dbg_ctrl_words[32], dbg_ctrl_words[31]};
    dbg_ctrl_mem_shadow.wo_base_addr            = {dbg_ctrl_words[34], dbg_ctrl_words[33]};
    dbg_ctrl_mem_shadow.w1_base_addr            = {dbg_ctrl_words[36], dbg_ctrl_words[35]};
    dbg_ctrl_mem_shadow.w2_base_addr            = {dbg_ctrl_words[38], dbg_ctrl_words[37]};
    dbg_ctrl_mem_shadow.k_cache_addr            = {dbg_ctrl_words[40], dbg_ctrl_words[39]};
    dbg_ctrl_mem_shadow.v_cache_addr            = {dbg_ctrl_words[42], dbg_ctrl_words[41]};
    dbg_ctrl_mem_shadow.wq_bias_base_addr       = {dbg_ctrl_words[44], dbg_ctrl_words[43]};
    dbg_ctrl_mem_shadow.wk_bias_base_addr       = {dbg_ctrl_words[46], dbg_ctrl_words[45]};
    dbg_ctrl_mem_shadow.wv_bias_base_addr       = {dbg_ctrl_words[48], dbg_ctrl_words[47]};
    dbg_ctrl_mem_shadow.wo_bias_base_addr       = {dbg_ctrl_words[50], dbg_ctrl_words[49]};
    dbg_ctrl_mem_shadow.w1_bias_base_addr       = {dbg_ctrl_words[52], dbg_ctrl_words[51]};
    dbg_ctrl_mem_shadow.w2_bias_base_addr       = {dbg_ctrl_words[54], dbg_ctrl_words[53]};
    dbg_ctrl_mem_shadow.ln0_gamma_base_addr     = {dbg_ctrl_words[56], dbg_ctrl_words[55]};
    dbg_ctrl_mem_shadow.ln1_gamma_base_addr     = {dbg_ctrl_words[58], dbg_ctrl_words[57]};
    dbg_ctrl_mem_shadow.final_norm_gamma_base_addr = {dbg_ctrl_words[60], dbg_ctrl_words[59]};
    dbg_ctrl_mem_shadow.ln0_eps_base_addr       = {dbg_ctrl_words[62], dbg_ctrl_words[61]};
    dbg_ctrl_mem_shadow.ln1_eps_base_addr       = {dbg_ctrl_words[64], dbg_ctrl_words[63]};
    dbg_ctrl_mem_shadow.final_norm_eps_base_addr = {dbg_ctrl_words[66], dbg_ctrl_words[65]};
  end

  // dbg_in_buf/dbg_out_buf are write-only in this RTL.

  // Headed debug buffers are write-only debug egress in this RTL.

  // Debug memory model writes for all dual-port debug interfaces.
  always_ff @(posedge ap_clk) begin : p_dbg_mem_writes
    if (dbg_in_buf_ce0 && dbg_in_buf_we0) begin
      dbg_in_buf_mem[dbg_in_buf_address0] <= dbg_in_buf_d0;
    end
    if (dbg_out_buf_ce0 && dbg_out_buf_we0) begin
      dbg_out_buf_mem[dbg_out_buf_address0] <= dbg_out_buf_d0;
    end
    if (dbg_head_in_buf_0_ce0 && dbg_head_in_buf_0_we0) begin
      dbg_head_in_buf_mem[{1'b0, dbg_head_in_buf_0_address0}] <= dbg_head_in_buf_0_d0;
    end
    if (dbg_head_in_buf_1_ce0 && dbg_head_in_buf_1_we0) begin
      dbg_head_in_buf_mem[{1'b1, dbg_head_in_buf_1_address0}] <= dbg_head_in_buf_1_d0;
    end
    if (dbg_head_out_buf_0_ce0 && dbg_head_out_buf_0_we0) begin
      dbg_head_out_buf_mem[{1'b0, dbg_head_out_buf_0_address0}] <= dbg_head_out_buf_0_d0;
    end
    if (dbg_head_out_buf_1_ce0 && dbg_head_out_buf_1_we0) begin
      dbg_head_out_buf_mem[{1'b1, dbg_head_out_buf_1_address0}] <= dbg_head_out_buf_1_d0;
    end
    if (dbg_stream_in_buf_ce0 && dbg_stream_in_buf_we0) begin
      dbg_stream_in_buf_mem[dbg_stream_in_buf_address0] <= dbg_stream_in_buf_d0;
    end
  end

  // Capture full debug buffers into snapshot RAMs for operation-level verification.
  always_ff @(posedge ap_clk) begin : p_dbg_buffer_snapshots
    int b;
    int lane;
    int op_idx;
    int head_idx;
    int elem_idx;
    logic lane_start_rise;
    logic lane_done_rise;
    logic lane_in_write_event;
    logic lane_out_write_event;
    logic [31:0] lane_instr;
    logic [7:0] lane_op;
    logic [7:0] lane_layer;
    logic [7:0] lane_head;
    logic [7:0] lane_tile;
    if (!ap_rst_n) begin
      main_in_snap_wr_idx      <= '0;
      main_out_snap_wr_idx     <= '0;
      main_in_capture_pending  <= 1'b0;
      main_out_capture_pending <= 1'b0;
      main_in_quiet_ctr        <= '0;
      main_out_quiet_ctr       <= '0;
      dbg_compute_start_d      <= 1'b0;
      dbg_compute_done_d       <= 1'b0;
      main_in_pending_instr    <= 32'd0;
      main_out_pending_instr   <= 32'd0;
      main_active_instr        <= 32'd0;
      main_in_pending_op       <= 8'd0;
      main_out_pending_op      <= 8'd0;
      main_active_op           <= 8'd0;
      main_in_pending_layer    <= 8'd0;
      main_out_pending_layer   <= 8'd0;
      main_active_layer        <= 8'd0;
      main_in_pending_head     <= 8'd0;
      main_out_pending_head    <= 8'd0;
      main_active_head         <= 8'd0;
      main_in_pending_tile     <= 8'd0;
      main_out_pending_tile    <= 8'd0;
      main_active_tile         <= 8'd0;
      main_last_seen_instr     <= 32'd0;
      for (b = 0; b < DBG_SNAP_DEPTH; b = b + 1) begin
        main_in_snap_valid[b]  <= 1'b0;
        main_out_snap_valid[b] <= 1'b0;
      end
      for (op_idx = 0; op_idx < 32; op_idx = op_idx + 1) begin
        for (b = 0; b < DBG_MAIN_IN_BYTES; b = b + 1) begin
          main_in_by_op[op_idx][b] <= 8'd0;
        end
        for (b = 0; b < DBG_MAIN_OUT_BYTES; b = b + 1) begin
          main_out_by_op[op_idx][b] <= 8'd0;
        end
      end
      for (elem_idx = 0; elem_idx < TB_D_MODEL; elem_idx = elem_idx + 1) begin
        out_proj_out[elem_idx]   <= 8'd0;
        resid1_out[elem_idx]     <= 8'd0;
        resid2_out[elem_idx]     <= 8'd0;
        ln0_out[elem_idx]        <= 8'd0;
        ln1_out[elem_idx]        <= 8'd0;
        ffn_w2_out[elem_idx]     <= 8'd0;
        final_norm_out[elem_idx] <= 32'sd0;
      end
      for (elem_idx = 0; elem_idx < TB_D_FFN; elem_idx = elem_idx + 1) begin
        ffn_w1_out[elem_idx] <= 16'sd0;
        ffn_act_out[elem_idx] <= 16'sd0;
      end
      for (op_idx = 0; op_idx < TB_NUM_WO_TILES; op_idx = op_idx + 1) begin
        for (elem_idx = 0; elem_idx < TB_D_TILE_WO; elem_idx = elem_idx + 1) begin
          out_proj_out_by_tile[op_idx][elem_idx] <= 8'd0;
        end
      end
      for (op_idx = 0; op_idx < TB_NUM_W1_TILES; op_idx = op_idx + 1) begin
        for (elem_idx = 0; elem_idx < TB_D_TILE_W1; elem_idx = elem_idx + 1) begin
          ffn_w1_out_by_tile[op_idx][elem_idx] <= 16'sd0;
        end
      end
      for (op_idx = 0; op_idx < TB_NUM_W2_TILES; op_idx = op_idx + 1) begin
        for (elem_idx = 0; elem_idx < TB_D_TILE_W2; elem_idx = elem_idx + 1) begin
          ffn_w2_out_by_tile[op_idx][elem_idx] <= 8'd0;
        end
      end
      for (head_idx = 0; head_idx < TB_NUM_HEADS; head_idx = head_idx + 1) begin
        for (elem_idx = 0; elem_idx < TB_D_HEADS; elem_idx = elem_idx + 1) begin
          q_out[head_idx][elem_idx]       <= 8'sd0;
          k_out[head_idx][elem_idx]       <= 8'sd0;
          v_out[head_idx][elem_idx]       <= 8'sd0;
          head_rq_out[head_idx][elem_idx] <= 8'sd0;
          att_value_out[head_idx][elem_idx] <= 32'sd0;
        end
        for (elem_idx = 0; elem_idx < TB_CONTEXT_LENGTH; elem_idx = elem_idx + 1) begin
          att_scores_out[head_idx][elem_idx] <= 32'sd0;
          val_scale_out[head_idx][elem_idx]  <= 16'sd0;
          softmax_out[head_idx][elem_idx]    <= 16'sd0;
        end
      end
      for (lane = 0; lane < TB_HEADS_PARALLEL; lane = lane + 1) begin
        head_in_snap_wr_idx[lane]      <= '0;
        head_out_snap_wr_idx[lane]     <= '0;
        head_in_capture_pending[lane]  <= 1'b0;
        head_out_capture_pending[lane] <= 1'b0;
        head_in_quiet_ctr[lane]        <= '0;
        head_out_quiet_ctr[lane]       <= '0;
        head_compute_start_d[lane]     <= 1'b0;
        head_compute_done_d[lane]      <= 1'b0;
        head_in_pending_instr[lane]    <= 32'd0;
        head_out_pending_instr[lane]   <= 32'd0;
        head_active_instr[lane]        <= 32'd0;
        head_in_pending_op[lane]       <= 8'd0;
        head_out_pending_op[lane]      <= 8'd0;
        head_active_op[lane]           <= 8'd0;
        head_in_pending_layer[lane]    <= 8'd0;
        head_out_pending_layer[lane]   <= 8'd0;
        head_active_layer[lane]        <= 8'd0;
        head_in_pending_head[lane]     <= 8'd0;
        head_out_pending_head[lane]    <= 8'd0;
        head_active_head[lane]         <= 8'd0;
        head_in_pending_tile[lane]     <= 8'd0;
        head_out_pending_tile[lane]    <= 8'd0;
        head_active_tile[lane]         <= 8'd0;
        head_last_seen_instr[lane]     <= 32'd0;
        for (b = 0; b < DBG_SNAP_DEPTH; b = b + 1) begin
          head_in_snap_valid[lane][b]  <= 1'b0;
          head_out_snap_valid[lane][b] <= 1'b0;
        end
      end
      for (head_idx = 0; head_idx < TB_NUM_HEADS; head_idx = head_idx + 1) begin
        for (op_idx = 0; op_idx < 32; op_idx = op_idx + 1) begin
          for (b = 0; b < DBG_HEAD_IN_BYTES; b = b + 1) begin
            head_in_by_op[head_idx][op_idx][b] <= 8'd0;
          end
          for (b = 0; b < DBG_HEAD_OUT_BYTES; b = b + 1) begin
            head_out_by_op[head_idx][op_idx][b] <= 8'd0;
          end
        end
      end
    end else begin
      // -------------------------
      // Main path snapshots
      // -------------------------
      // Latch current main compute instruction whenever a new tile/instruction appears.
      if (dbg_compute_instruction_ap_vld && dbg_compute_start[0] && (dbg_compute_instruction != 32'd0) &&
          (dbg_compute_instruction != main_last_seen_instr)) begin
        main_last_seen_instr     <= dbg_compute_instruction;
        main_in_capture_pending  <= 1'b1;
        main_in_quiet_ctr        <= '0;
        main_active_instr       <= dbg_compute_instruction;
        main_active_op          <= instr_op(dbg_compute_instruction);
        main_active_layer       <= instr_layer(dbg_compute_instruction);
        main_active_head        <= instr_head(dbg_compute_instruction);
        main_active_tile        <= instr_tile(dbg_compute_instruction);
        main_in_pending_instr   <= dbg_compute_instruction;
        main_in_pending_op      <= instr_op(dbg_compute_instruction);
        main_in_pending_layer   <= instr_layer(dbg_compute_instruction);
        main_in_pending_head    <= instr_head(dbg_compute_instruction);
        main_in_pending_tile    <= instr_tile(dbg_compute_instruction);
      end
      if (!dbg_compute_done_d && dbg_compute_done[0]) begin
        main_out_capture_pending <= 1'b1;
        main_out_quiet_ctr       <= '0;
        main_out_pending_instr   <= main_active_instr;
        main_out_pending_op      <= main_active_op;
        main_out_pending_layer   <= main_active_layer;
        main_out_pending_head    <= main_active_head;
        main_out_pending_tile    <= main_active_tile;
      end

      if (main_in_capture_pending) begin
        if (dbg_in_buf_ce0 && dbg_in_buf_we0) begin
          main_in_quiet_ctr <= '0;
        end else if (main_in_quiet_ctr < DBG_SNAP_QUIET_CYCLES) begin
          main_in_quiet_ctr <= main_in_quiet_ctr + 1'b1;
        end
        if (main_in_quiet_ctr >= DBG_SNAP_QUIET_CYCLES) begin
          for (b = 0; b < DBG_MAIN_IN_BYTES; b = b + 1) begin
            main_in_snap[main_in_snap_wr_idx][b] <= dbg_in_buf_mem[b];
          end
          if (main_in_pending_op < 32) begin
            for (b = 0; b < DBG_MAIN_IN_BYTES; b = b + 1) begin
              main_in_by_op[main_in_pending_op][b] <= dbg_in_buf_mem[b];
            end
          end
          main_in_snap_valid[main_in_snap_wr_idx] <= 1'b1;
          main_in_snap_cycle[main_in_snap_wr_idx] <= cycle_count;
          main_in_snap_instr[main_in_snap_wr_idx] <= main_in_pending_instr;
          main_in_snap_op[main_in_snap_wr_idx]    <= main_in_pending_op;
          main_in_snap_layer[main_in_snap_wr_idx] <= main_in_pending_layer;
          main_in_snap_head[main_in_snap_wr_idx]  <= main_in_pending_head;
          main_in_snap_tile[main_in_snap_wr_idx]  <= main_in_pending_tile;
          main_in_snap_wr_idx <= (main_in_snap_wr_idx == (DBG_SNAP_DEPTH-1)) ? '0 : (main_in_snap_wr_idx + 1'b1);
          main_in_capture_pending <= 1'b0;
          main_in_quiet_ctr <= '0;
        end
      end

      if (main_out_capture_pending) begin
        for (b = 0; b < DBG_MAIN_OUT_BYTES; b = b + 1) begin
          main_out_snap[main_out_snap_wr_idx][b] <= dbg_out_buf_mem[b];
        end
        if (main_out_pending_op < 32) begin
          for (b = 0; b < DBG_MAIN_OUT_BYTES; b = b + 1) begin
            main_out_by_op[main_out_pending_op][b] <= dbg_out_buf_mem[b];
          end
        end

        case (main_out_pending_op)
          OP_CMP_LN0: begin
            for (elem_idx = 0; elem_idx < TB_D_MODEL; elem_idx = elem_idx + 1) begin
              ln0_out[elem_idx] <= dbg_out_buf_mem[elem_idx];
            end
          end
          OP_CMP_LN1: begin
            for (elem_idx = 0; elem_idx < TB_D_MODEL; elem_idx = elem_idx + 1) begin
              ln1_out[elem_idx] <= dbg_out_buf_mem[elem_idx];
            end
          end
          OP_CMP_OUT_PROJ: begin
              for (elem_idx = 0; elem_idx < TB_D_MODEL; elem_idx = elem_idx + 1) begin
                out_proj_out[elem_idx] <= dbg_out_buf_mem[elem_idx];
              end
              if (main_out_pending_tile < TB_NUM_WO_TILES) begin
                for (elem_idx = 0; elem_idx < TB_D_TILE_WO; elem_idx = elem_idx + 1) begin
                  out_proj_out_by_tile[main_out_pending_tile][elem_idx] <= dbg_out_buf_mem[elem_idx];
                end
              end
            end
          OP_CMP_RESID1: begin
            for (elem_idx = 0; elem_idx < TB_D_MODEL; elem_idx = elem_idx + 1) begin
              resid1_out[elem_idx] <= dbg_out_buf_mem[elem_idx];
            end
          end
          OP_CMP_RESID2: begin
            for (elem_idx = 0; elem_idx < TB_D_MODEL; elem_idx = elem_idx + 1) begin
              resid2_out[elem_idx] <= dbg_out_buf_mem[elem_idx];
            end
          end
          OP_CMP_FFN_W2: begin
              for (elem_idx = 0; elem_idx < TB_D_MODEL; elem_idx = elem_idx + 1) begin
                ffn_w2_out[elem_idx] <= dbg_out_buf_mem[elem_idx];
              end
              if (main_out_pending_tile < TB_NUM_W2_TILES) begin
                for (elem_idx = 0; elem_idx < TB_D_TILE_W2; elem_idx = elem_idx + 1) begin
                  ffn_w2_out_by_tile[main_out_pending_tile][elem_idx] <= dbg_out_buf_mem[elem_idx];
                end
              end
            end
          OP_CMP_FFN_W1: begin
              for (elem_idx = 0; elem_idx < TB_D_FFN; elem_idx = elem_idx + 1) begin
                ffn_w1_out[elem_idx] <= {dbg_out_buf_mem[(2*elem_idx)+1], dbg_out_buf_mem[(2*elem_idx)+0]};
              end
              if (main_out_pending_tile < TB_NUM_W1_TILES) begin
                for (elem_idx = 0; elem_idx < TB_D_TILE_W1; elem_idx = elem_idx + 1) begin
                  ffn_w1_out_by_tile[main_out_pending_tile][elem_idx] <=
                    {dbg_out_buf_mem[(2*elem_idx)+1], dbg_out_buf_mem[(2*elem_idx)+0]};
                end
              end
            end
          OP_CMP_FFN_ACT: begin
            for (elem_idx = 0; elem_idx < TB_D_FFN; elem_idx = elem_idx + 1) begin
              ffn_act_out[elem_idx] <= {dbg_out_buf_mem[(2*elem_idx)+1], dbg_out_buf_mem[(2*elem_idx)+0]};
            end
          end
          OP_CMP_FINAL_NORM: begin
            for (elem_idx = 0; elem_idx < TB_D_MODEL; elem_idx = elem_idx + 1) begin
              final_norm_out[elem_idx] <= {dbg_out_buf_mem[(4*elem_idx)+3], dbg_out_buf_mem[(4*elem_idx)+2], dbg_out_buf_mem[(4*elem_idx)+1], dbg_out_buf_mem[(4*elem_idx)+0]};
            end
          end
          default: begin
          end
        endcase

        main_out_snap_valid[main_out_snap_wr_idx] <= 1'b1;
        main_out_snap_cycle[main_out_snap_wr_idx] <= cycle_count;
        main_out_snap_instr[main_out_snap_wr_idx] <= main_out_pending_instr;
        main_out_snap_op[main_out_snap_wr_idx]    <= main_out_pending_op;
        main_out_snap_layer[main_out_snap_wr_idx] <= main_out_pending_layer;
        main_out_snap_head[main_out_snap_wr_idx]  <= main_out_pending_head;
        main_out_snap_tile[main_out_snap_wr_idx]  <= main_out_pending_tile;
        main_out_snap_wr_idx <= (main_out_snap_wr_idx == (DBG_SNAP_DEPTH-1)) ? '0 : (main_out_snap_wr_idx + 1'b1);
        main_out_capture_pending <= 1'b0;
        main_out_quiet_ctr <= '0;
      end

      // -------------------------
      // Headed path snapshots (per lane)
      // -------------------------
      for (lane = 0; lane < TB_HEADS_PARALLEL; lane = lane + 1) begin
        lane_start_rise = 1'b0;
        lane_done_rise  = 1'b0;
        lane_instr      = 32'd0;
        lane_op         = 8'd0;
        lane_layer      = 8'd0;
        lane_head       = 8'd0;
        lane_tile       = 8'd0;
        lane_in_write_event  = 1'b0;
        lane_out_write_event = 1'b0;
        if (lane == 0) begin
          lane_start_rise = (!head_compute_start_d[0] && dbg_head_compute_ctx_0_struct.compute_start);
          lane_done_rise  = (!head_compute_done_d[0]  && dbg_head_compute_ctx_0_struct.compute_done);
          lane_instr      = (dbg_head_compute_ctx_0_struct.compute_instruction != 32'd0) ? dbg_head_compute_ctx_0_struct.compute_instruction :
                            ((dbg_head_compute_ctx_0_struct.req_instruction != 32'd0) ? dbg_head_compute_ctx_0_struct.req_instruction : dbg_head_compute_ctx_0_struct.mem_op);
          lane_op         = instr_op(lane_instr);
          lane_layer      = instr_layer(lane_instr);
          lane_head       = instr_head(lane_instr);
          lane_tile       = instr_tile(lane_instr);
          lane_in_write_event  = dbg_head_in_buf_0_ce0 && dbg_head_in_buf_0_we0;
          lane_out_write_event = dbg_head_out_buf_0_ce0 && dbg_head_out_buf_0_we0;
        end else begin
          lane_start_rise = (!head_compute_start_d[1] && dbg_head_compute_ctx_1_struct.compute_start);
          lane_done_rise  = (!head_compute_done_d[1]  && dbg_head_compute_ctx_1_struct.compute_done);
          lane_instr      = (dbg_head_compute_ctx_1_struct.compute_instruction != 32'd0) ? dbg_head_compute_ctx_1_struct.compute_instruction :
                            ((dbg_head_compute_ctx_1_struct.req_instruction != 32'd0) ? dbg_head_compute_ctx_1_struct.req_instruction : dbg_head_compute_ctx_1_struct.mem_op);
          lane_op         = instr_op(lane_instr);
          lane_layer      = instr_layer(lane_instr);
          lane_head       = instr_head(lane_instr);
          lane_tile       = instr_tile(lane_instr);
          lane_in_write_event  = dbg_head_in_buf_1_ce0 && dbg_head_in_buf_1_we0;
          lane_out_write_event = dbg_head_out_buf_1_ce0 && dbg_head_out_buf_1_we0;
        end

        if ((lane_instr != 32'd0) && (lane_instr != head_last_seen_instr[lane])) begin
          head_last_seen_instr[lane]   <= lane_instr;
          head_active_instr[lane]      <= lane_instr;
          head_active_op[lane]         <= lane_op;
          head_active_layer[lane]      <= lane_layer;
          head_active_head[lane]       <= lane_head;
          head_active_tile[lane]       <= lane_tile;
        end

        if (lane_start_rise || ((lane_instr != 32'd0) && (lane_instr != head_in_pending_instr[lane]) && (head_in_capture_pending[lane] == 1'b0))) begin
          head_in_capture_pending[lane] <= 1'b1;
          head_in_quiet_ctr[lane]       <= '0;
          head_in_pending_instr[lane]   <= lane_instr;
          head_in_pending_op[lane]      <= lane_op;
          head_in_pending_layer[lane]   <= lane_layer;
          head_in_pending_head[lane]    <= lane_head;
          head_in_pending_tile[lane]    <= lane_tile;
        end
        if (lane_done_rise) begin
          head_out_capture_pending[lane] <= 1'b1;
          head_out_quiet_ctr[lane]       <= '0;
          head_out_pending_instr[lane]   <= head_active_instr[lane];
          head_out_pending_op[lane]      <= head_active_op[lane];
          head_out_pending_layer[lane]   <= head_active_layer[lane];
          head_out_pending_head[lane]    <= head_active_head[lane];
          head_out_pending_tile[lane]    <= head_active_tile[lane];
        end

        if (head_in_capture_pending[lane]) begin
          if (lane_in_write_event) begin
            head_in_quiet_ctr[lane] <= '0;
          end else if (head_in_quiet_ctr[lane] < DBG_SNAP_QUIET_CYCLES) begin
            head_in_quiet_ctr[lane] <= head_in_quiet_ctr[lane] + 1'b1;
          end
          if (head_in_quiet_ctr[lane] >= DBG_SNAP_QUIET_CYCLES) begin
            for (b = 0; b < DBG_HEAD_IN_BYTES; b = b + 1) begin
              head_in_snap[lane][head_in_snap_wr_idx[lane]][b] <= dbg_head_in_buf_mem[(lane * DBG_HEAD_IN_BYTES) + b];
            end
            if ((head_in_pending_head[lane] < TB_NUM_HEADS) && (head_in_pending_op[lane] < 32)) begin
              for (b = 0; b < DBG_HEAD_IN_BYTES; b = b + 1) begin
                head_in_by_op[head_in_pending_head[lane]][head_in_pending_op[lane]][b] <= dbg_head_in_buf_mem[(lane * DBG_HEAD_IN_BYTES) + b];
              end
            end
            head_in_snap_valid[lane][head_in_snap_wr_idx[lane]] <= 1'b1;
            head_in_snap_cycle[lane][head_in_snap_wr_idx[lane]] <= cycle_count;
            head_in_snap_instr[lane][head_in_snap_wr_idx[lane]] <= head_in_pending_instr[lane];
            head_in_snap_op[lane][head_in_snap_wr_idx[lane]]    <= head_in_pending_op[lane];
            head_in_snap_layer[lane][head_in_snap_wr_idx[lane]] <= head_in_pending_layer[lane];
            head_in_snap_head[lane][head_in_snap_wr_idx[lane]]  <= head_in_pending_head[lane];
            head_in_snap_tile[lane][head_in_snap_wr_idx[lane]]  <= head_in_pending_tile[lane];
            head_in_snap_wr_idx[lane] <= (head_in_snap_wr_idx[lane] == (DBG_SNAP_DEPTH-1)) ? '0 : (head_in_snap_wr_idx[lane] + 1'b1);
            head_in_capture_pending[lane] <= 1'b0;
            head_in_quiet_ctr[lane] <= '0;
          end
        end

        if (head_out_capture_pending[lane]) begin
          for (b = 0; b < DBG_HEAD_OUT_BYTES; b = b + 1) begin
            head_out_snap[lane][head_out_snap_wr_idx[lane]][b] <= dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + b];
          end
          if ((head_out_pending_head[lane] < TB_NUM_HEADS) && (head_out_pending_op[lane] < 32)) begin
            for (b = 0; b < DBG_HEAD_OUT_BYTES; b = b + 1) begin
              head_out_by_op[head_out_pending_head[lane]][head_out_pending_op[lane]][b] <= dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + b];
            end

            case (head_out_pending_op[lane])
              OP_CMP_Q: begin
                for (elem_idx = 0; elem_idx < TB_D_HEADS; elem_idx = elem_idx + 1) begin
                  q_out[head_out_pending_head[lane]][elem_idx] <= $signed(dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + elem_idx]);
                end
              end
              OP_CMP_K: begin
                for (elem_idx = 0; elem_idx < TB_D_HEADS; elem_idx = elem_idx + 1) begin
                  k_out[head_out_pending_head[lane]][elem_idx] <= $signed(dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + elem_idx]);
                end
              end
              OP_CMP_V: begin
                for (elem_idx = 0; elem_idx < TB_D_HEADS; elem_idx = elem_idx + 1) begin
                  v_out[head_out_pending_head[lane]][elem_idx] <= $signed(dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + elem_idx]);
                end
              end
              OP_CMP_HEAD_REQUANT: begin
                for (elem_idx = 0; elem_idx < TB_D_HEADS; elem_idx = elem_idx + 1) begin
                  head_rq_out[head_out_pending_head[lane]][elem_idx] <= $signed(dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + elem_idx]);
                end
              end
              OP_CMP_ATT_SCORES: begin
                for (elem_idx = 0; elem_idx < TB_CONTEXT_LENGTH; elem_idx = elem_idx + 1) begin
                  att_scores_out[head_out_pending_head[lane]][elem_idx] <=
                    {dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (4*elem_idx) + 3],
                     dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (4*elem_idx) + 2],
                     dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (4*elem_idx) + 1],
                     dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (4*elem_idx) + 0]};
                end
              end
              OP_CMP_VALUE_SCALE: begin
                for (elem_idx = 0; elem_idx < TB_CONTEXT_LENGTH; elem_idx = elem_idx + 1) begin
                  val_scale_out[head_out_pending_head[lane]][elem_idx] <=
                    {dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (2*elem_idx) + 1],
                     dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (2*elem_idx) + 0]};
                end
              end
              OP_CMP_SOFTMAX: begin
                for (elem_idx = 0; elem_idx < TB_CONTEXT_LENGTH; elem_idx = elem_idx + 1) begin
                  softmax_out[head_out_pending_head[lane]][elem_idx] <=
                    {dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (2*elem_idx) + 1],
                     dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (2*elem_idx) + 0]};
                end
              end
              OP_CMP_ATT_VALUE: begin
                for (elem_idx = 0; elem_idx < TB_D_HEADS; elem_idx = elem_idx + 1) begin
                  att_value_out[head_out_pending_head[lane]][elem_idx] <=
                    {dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (4*elem_idx) + 3],
                     dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (4*elem_idx) + 2],
                     dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (4*elem_idx) + 1],
                     dbg_head_out_buf_mem[(lane * DBG_HEAD_OUT_BYTES) + (4*elem_idx) + 0]};
                end
              end
              default: begin
              end
            endcase
          end
          head_out_snap_valid[lane][head_out_snap_wr_idx[lane]] <= 1'b1;
          head_out_snap_cycle[lane][head_out_snap_wr_idx[lane]] <= cycle_count;
          head_out_snap_instr[lane][head_out_snap_wr_idx[lane]] <= head_out_pending_instr[lane];
          head_out_snap_op[lane][head_out_snap_wr_idx[lane]]    <= head_out_pending_op[lane];
          head_out_snap_layer[lane][head_out_snap_wr_idx[lane]] <= head_out_pending_layer[lane];
          head_out_snap_head[lane][head_out_snap_wr_idx[lane]]  <= head_out_pending_head[lane];
          head_out_snap_tile[lane][head_out_snap_wr_idx[lane]]  <= head_out_pending_tile[lane];
          head_out_snap_wr_idx[lane] <= (head_out_snap_wr_idx[lane] == (DBG_SNAP_DEPTH-1)) ? '0 : (head_out_snap_wr_idx[lane] + 1'b1);
          head_out_capture_pending[lane] <= 1'b0;
          head_out_quiet_ctr[lane] <= '0;
        end
      end

      dbg_compute_start_d <= dbg_compute_start[0];
      dbg_compute_done_d  <= dbg_compute_done[0];
      head_compute_start_d[0] <= dbg_head_compute_ctx_0_struct.compute_start;
      head_compute_start_d[1] <= dbg_head_compute_ctx_1_struct.compute_start;
      head_compute_done_d[0]  <= dbg_head_compute_ctx_0_struct.compute_done;
      head_compute_done_d[1]  <= dbg_head_compute_ctx_1_struct.compute_done;
    end
  end

  // Decode packed context debug busses into structs for waveform readability.
  always_comb begin : p_ctx_struct_views
    dbg_head_ctx_ref_0_struct      = unpack_head_ctx(dbg_head_ctx_ref_0);
    dbg_head_ctx_ref_1_struct      = unpack_head_ctx(dbg_head_ctx_ref_1);
    dbg_head_compute_ctx_0_struct  = unpack_compute_head_ctx(dbg_head_compute_ctx_0);
    dbg_head_compute_ctx_1_struct  = unpack_compute_head_ctx(dbg_head_compute_ctx_1);
  end

  // AXI stream constants.
  assign s_axis_in_TKEEP = 1'b1;
  assign s_axis_in_TSTRB = 1'b1;
  assign m_axis_out_TREADY = 1'b1;

  // Build/drive AXI-stream input packet.
  always_comb begin : p_axis_ingress_outputs
    s_axis_in_TVALID = stream_fill_active && (stream_gap_countdown == 0);
    s_axis_in_TLAST  = s_axis_in_TVALID && (stream_fill_idx == (STREAM_IN_BUF_BYTES-1));
    s_axis_in_TDATA  = stream_in_mem[stream_fill_idx];
  end

  // Build/drive stream-in beat traffic only when DUT requests ingress.
  always_ff @(posedge ap_clk) begin : axis_driver
    if (!ap_rst_n) begin
      axis_packet_sent   <= 1'b0;
      stream_fill_active <= 1'b0;
      stream_fill_idx    <= '0;
      stream_gap_countdown <= '0;
    end else begin
      if (stream_fill_active && (stream_gap_countdown != 0)) begin
        stream_gap_countdown <= stream_gap_countdown - 1'b1;
      end

      // Start ingress only once DUT is in STREAM_IN and ready.
      if (!axis_packet_sent && !stream_fill_active && (dbg_state == 32'd1) && s_axis_in_TREADY) begin
        stream_fill_active <= 1'b1;
        stream_fill_idx    <= '0;
        stream_gap_countdown <= '0;
      end
      if (stream_fill_active && s_axis_in_TREADY && s_axis_in_TVALID) begin
        if (stream_fill_idx == (STREAM_IN_BUF_BYTES-1)) begin
          axis_packet_sent   <= 1'b1;
          stream_fill_active <= 1'b0;
          stream_fill_idx    <= '0;
          stream_gap_countdown <= '0;
        end else begin
          stream_fill_idx <= stream_fill_idx + 1'b1;
          // Space out beats to make stream progression easier to inspect.
          stream_gap_countdown <= 4'd5;
        end
      end
    end
  end

  // Capture AXI-stream output payload.
  always_ff @(posedge ap_clk) begin : axis_output_sink
    if (!ap_rst_n) begin
      stream_out_count     <= 0;
      stream_out_last_seen <= 1'b0;
    end else begin
      if (m_axis_out_TVALID && m_axis_out_TREADY) begin
        if (stream_out_count < STREAM_OUT_BUF_BYTES) begin
          stream_out_mem[stream_out_count] <= m_axis_out_TDATA;
          stream_out_count <= stream_out_count + 1;
        end
        if (m_axis_out_TLAST[0]) begin
          stream_out_last_seen <= 1'b1;
          stream_out_count     <= 0;
        end
      end
    end
  end

  // AXI4-Full ready/user defaults.
  assign m_axi_gmem_AWREADY = !axi_aw_active;
  assign m_axi_gmem_WREADY  = axi_aw_active;
  assign m_axi_gmem_ARREADY = !axi_ar_active && !m_axi_gmem_RVALID;
  assign m_axi_gmem_RUSER   = 1'b0;
  assign m_axi_gmem_BUSER   = 1'b0;

  // AXI4-Full memory model (single outstanding read and write burst).
  always_ff @(posedge ap_clk) begin : m_axi_full_model
    logic [63:0] waddr_cur;
    logic [63:0] raddr_cur;
    if (!ap_rst_n) begin
      axi_aw_active        <= 1'b0;
      axi_aw_addr_latched  <= 64'd0;
      axi_aw_len_latched   <= 8'd0;
      axi_aw_size_latched  <= 3'd2;
      axi_w_beats_seen     <= 8'd0;
      axi_bid_latched      <= 1'b0;
      axi_bresp_latched    <= 2'b00;

      axi_ar_active        <= 1'b0;
      axi_ar_addr_latched  <= 64'd0;
      axi_ar_len_latched   <= 8'd0;
      axi_ar_size_latched  <= 3'd2;
      axi_r_beats_sent     <= 8'd0;
      axi_rid_latched      <= 1'b0;

      m_axi_gmem_RVALID    <= 1'b0;
      m_axi_gmem_RDATA     <= 32'd0;
      m_axi_gmem_RLAST     <= 1'b0;
      m_axi_gmem_RID       <= 1'b0;
      m_axi_gmem_RRESP     <= 2'b00;
      m_axi_gmem_BVALID    <= 1'b0;
      m_axi_gmem_BRESP     <= 2'b00;
      m_axi_gmem_BID       <= 1'b0;
    end else begin
      // ---------------- Write address ----------------
      if (m_axi_gmem_AWVALID && m_axi_gmem_AWREADY && !axi_aw_active) begin
        axi_aw_active       <= 1'b1;
        axi_aw_addr_latched <= m_axi_gmem_AWADDR;
        axi_aw_len_latched  <= m_axi_gmem_AWLEN;
        axi_aw_size_latched <= m_axi_gmem_AWSIZE;
        axi_w_beats_seen    <= 8'd0;
        axi_bid_latched     <= m_axi_gmem_AWID;
      end

      // ---------------- Write data ----------------
      if (axi_aw_active && m_axi_gmem_WVALID && m_axi_gmem_WREADY) begin
        waddr_cur = axi_aw_addr_latched + ({{56{1'b0}}, axi_w_beats_seen} << axi_aw_size_latched);
        mem_write_word(waddr_cur, m_axi_gmem_WDATA, m_axi_gmem_WSTRB);
        if (m_axi_gmem_WLAST || (axi_w_beats_seen == axi_aw_len_latched)) begin
          axi_aw_active     <= 1'b0;
          m_axi_gmem_BVALID <= 1'b1;
          m_axi_gmem_BRESP  <= axi_bresp_latched;
          m_axi_gmem_BID    <= axi_bid_latched;
        end else begin
          axi_w_beats_seen <= axi_w_beats_seen + 1'b1;
        end
      end

      if (m_axi_gmem_BVALID && m_axi_gmem_BREADY) begin
        m_axi_gmem_BVALID <= 1'b0;
      end

      // ---------------- Read address ----------------
      if (m_axi_gmem_ARVALID && m_axi_gmem_ARREADY && !axi_ar_active && !m_axi_gmem_RVALID) begin
        axi_ar_active       <= 1'b1;
        axi_ar_addr_latched <= m_axi_gmem_ARADDR;
        axi_ar_len_latched  <= m_axi_gmem_ARLEN;
        axi_ar_size_latched <= m_axi_gmem_ARSIZE;
        axi_r_beats_sent    <= 8'd0;
        axi_rid_latched     <= m_axi_gmem_ARID;
      end

      if (axi_ar_active && !m_axi_gmem_RVALID) begin
        raddr_cur = axi_ar_addr_latched + ({{56{1'b0}}, axi_r_beats_sent} << axi_ar_size_latched);
        m_axi_gmem_RDATA  <= mem_read_word(raddr_cur);
        m_axi_gmem_RID    <= axi_rid_latched;
        m_axi_gmem_RRESP  <= 2'b00;
        m_axi_gmem_RLAST  <= (axi_r_beats_sent == axi_ar_len_latched);
        m_axi_gmem_RVALID <= 1'b1;
      end else if (m_axi_gmem_RVALID && m_axi_gmem_RREADY) begin
        if (m_axi_gmem_RLAST) begin
          m_axi_gmem_RVALID <= 1'b0;
          m_axi_gmem_RLAST  <= 1'b0;
          axi_ar_active     <= 1'b0;
          axi_r_beats_sent  <= 8'd0;
        end else begin
          m_axi_gmem_RVALID   <= 1'b0;
          axi_r_beats_sent    <= axi_r_beats_sent + 1'b1;
        end
      end
    end
  end

  // Track IRQ status and decoded done/error flags.
  always_ff @(posedge ap_clk) begin : IRQ_TRACKER
    if (!ap_rst_n) begin
      irq_pending <= 1'b0;
      irq_seen_done <= 1'b0;
      irq_seen_error <= 1'b0;
      irq_seen_done_clr <= 1'b0;
      irq_seen_error_clr <= 1'b0;
      error_code_lat <= 32'd0;
    end else begin
      irq_seen_done_clr <= 1'b0;
      irq_seen_error_clr <= 1'b0;
      if (irq_ps[0]) begin
        irq_pending <= 1'b1;
      end
      if (axi_read_valid && (axi_addr == ADDR_STATUS_MEM_DATA_1)) begin
        if (axi_rdata[0]) irq_seen_done <= 1'b1;
        if (axi_rdata[1]) irq_seen_error <= 1'b1;
      end
      if (axi_read_valid && (axi_addr == ADDR_STATUS_MEM_DATA_2)) begin
        error_code_lat <= axi_rdata;
      end
      if (irq_seen_done_clr) begin
        irq_seen_done <= 1'b0;
      end
      if (irq_seen_error_clr) begin
        irq_seen_error <= 1'b0;
      end
      if (!irq_seen_done && !irq_seen_error && (irq_read_phase == IRQ_RD_DONE)) begin
        irq_pending <= 1'b0;
      end
    end
  end

  // Issue AXI reads for status/irq registers when IRQ is pending.
  always_ff @(posedge ap_clk) begin : IRQ_READER
    if (!ap_rst_n) begin
      irq_req_valid <= 1'b0;
      irq_req_read <= 1'b0;
      irq_req_addr <= ADDR_STATUS_MEM_DATA_1;
      irq_read_phase <= IRQ_RD_STATUS;
    end else begin
      irq_req_valid <= 1'b0;
      irq_req_read  <= 1'b0;
      irq_req_addr  <= ADDR_STATUS_MEM_DATA_1;
      if (irq_pending && !irq_seen_done && !irq_seen_error) begin
        case (irq_read_phase)
          IRQ_RD_STATUS: begin
            irq_req_valid <= 1'b1;
            irq_req_read  <= 1'b1;
            irq_req_addr  <= ADDR_STATUS_MEM_DATA_1;
            if (irq_req_fire) begin
              irq_read_phase <= IRQ_RD_STATE;
            end
          end
          IRQ_RD_STATE: begin
            irq_req_valid <= 1'b1;
            irq_req_read  <= 1'b1;
            irq_req_addr  <= ADDR_STATUS_MEM_DATA_0;
            if (irq_req_fire) begin
              irq_read_phase <= IRQ_RD_DONE;
            end
          end
          default: begin end
        endcase
      end else if (!irq_pending) begin
        irq_read_phase <= IRQ_RD_STATUS;
      end
    end
  end

  // Clear DONE IRQ after status has reached idle.
  always_ff @(posedge ap_clk) begin : HANDLE_IRQ_DONE
    if (!ap_rst_n) begin
      done_req_valid <= 1'b0;
      done_req_write <= 1'b0;
      done_req_addr  <= ctrl_mem_addr(2);
      done_req_wdata <= 32'd0;
    end else begin
      done_req_valid <= 1'b0;
      done_req_write <= 1'b0;
      done_req_addr  <= ctrl_mem_addr(2);
      done_req_wdata <= 32'd0;
      if (irq_seen_done) begin
        done_req_valid <= 1'b1;
        done_req_write <= 1'b1;
        done_req_addr  <= ctrl_mem_addr(2); // irq_clear
        done_req_wdata <= 32'h0000_0001;
        if (done_req_fire) begin
          irq_seen_done_clr <= 1'b1;
        end
      end
    end
  end

  // Handle/clear ERROR IRQ.
  always_ff @(posedge ap_clk) begin : HANDLE_ERROR
    if (!ap_rst_n) begin
      error_req_valid <= 1'b0;
      error_req_write <= 1'b0;
      error_req_read  <= 1'b0;
      error_req_addr  <= ADDR_STATUS_MEM_DATA_2;
      error_req_wdata <= 32'd0;
      err_phase       <= ERR_PHASE_READ;
    end else begin
      error_req_valid <= 1'b0;
      error_req_write <= 1'b0;
      error_req_read  <= 1'b0;
      error_req_addr  <= ADDR_STATUS_MEM_DATA_2;
      error_req_wdata <= 32'd0;
      case (err_phase)
        ERR_PHASE_READ: begin
          if (irq_seen_error) begin
            error_req_valid <= 1'b1;
            error_req_read  <= 1'b1;
            error_req_addr  <= ADDR_STATUS_MEM_DATA_2;
            if (error_req_fire) begin
              err_phase <= ERR_PHASE_CLEAR;
            end
          end
        end
        ERR_PHASE_CLEAR: begin
          error_req_valid <= 1'b1;
          error_req_write <= 1'b1;
          error_req_addr  <= ctrl_mem_addr(2); // irq_clear
          error_req_wdata <= 32'h0000_0002;
          if (error_req_fire) begin
            irq_seen_error_clr <= 1'b1;
            err_phase <= ERR_PHASE_READ;
          end
        end
        default: err_phase <= ERR_PHASE_READ;
      endcase
    end
  end

  // Top-level control initialization/programming sequence.
  always_ff @(posedge ap_clk) begin : START_FSM
    // default: no control transaction this cycle
    ctrl_addr     <= '0;
    ctrl_data_in  <= '0;
    ctrl_read_en  <= 1'b0;
    ctrl_write_en <= 1'b0;
    ctrl_chip_en  <= 1'b0;

    if (!ap_rst_n) begin
      ctrl_stage <= CTRL_RESET_MEM;
      ctrl_gap_cycles <= 0;
      base_assign_step <= 0;
      ctrl_shadow_control <= 32'd0;
    end else if (irq_req_fire) begin
      ctrl_addr     <= irq_req_addr;
      ctrl_data_in  <= 32'd0;
      ctrl_read_en  <= irq_req_read;
      ctrl_write_en <= 1'b0;
      ctrl_chip_en  <= 1'b1;
      ctrl_gap_cycles <= 1;
    end else if (done_req_fire) begin
      ctrl_addr     <= done_req_addr;
      ctrl_data_in  <= done_req_wdata;
      ctrl_write_en <= done_req_write;
      ctrl_chip_en  <= 1'b1;
      ctrl_gap_cycles <= 1;
    end else if (error_req_fire) begin
      ctrl_addr     <= error_req_addr;
      ctrl_data_in  <= error_req_wdata;
      ctrl_read_en  <= error_req_read;
      ctrl_write_en <= error_req_write;
      ctrl_chip_en  <= 1'b1;
      ctrl_gap_cycles <= 1;
    end else if (ctrl_gap_cycles > 0) begin
      ctrl_gap_cycles <= ctrl_gap_cycles - 1;
    end else if (axi_state != AXI_IDLE) begin
      // Wait for AXI-Lite transaction to finish before issuing next
      ctrl_gap_cycles <= 1;
    end else begin
      case (ctrl_stage)
        CTRL_RESET_MEM: begin
          ctrl_stage <= CTRL_ASSERT_RESET;
        end
        CTRL_ASSERT_RESET: begin
          ctrl_addr <= ctrl_mem_addr(0);
          ctrl_data_in <= 32'h0000_0000;
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_shadow_control <= 32'h0000_0000;
          ctrl_words[0] <= 32'h0000_0000;
          ctrl_stage <= CTRL_DEASSERT_RESET;
          ctrl_gap_cycles <= 5;
        end
        CTRL_DEASSERT_RESET: begin
          ctrl_addr <= ctrl_mem_addr(0);
          ctrl_data_in <= CTRL_RESETN_BIT;
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_shadow_control <= CTRL_RESETN_BIT;
          ctrl_words[0] <= CTRL_RESETN_BIT;
          ctrl_stage <= CTRL_PROGRAM_BASES;
          base_assign_step <= 0;
          ctrl_gap_cycles <= 5;
        end
        CTRL_PROGRAM_BASES: begin
          ctrl_write_en <= 1'b1;
          ctrl_chip_en  <= 1'b1;
          case (base_assign_step)
            0:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_DMA_LAYER_LEN);  ctrl_data_in <= 32'h0000_0100; end
            1:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_DMA_HEAD_LEN);   ctrl_data_in <= 32'h0000_0040; end
            2:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_DMA_TILE_LEN);   ctrl_data_in <= 32'h0000_0020; end
            3:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_LAYER_STRIDE);   ctrl_data_in <= 32'h0000_1000; end
            4:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_HEAD_STRIDE); ctrl_data_in <= 32'h0000_0100; end
            5:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_HEAD_STRIDE); ctrl_data_in <= 32'h0000_0100; end
            6:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_HEAD_STRIDE); ctrl_data_in <= 32'h0000_0100; end
            7:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_K_CACHE_STRIDE); ctrl_data_in <= 32'h0000_0100; end
            8:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_V_CACHE_STRIDE); ctrl_data_in <= 32'h0000_0100; end
            9:  begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_TILE_STRIDE); ctrl_data_in <= 32'h0000_0020; end
            10: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_TILE_STRIDE); ctrl_data_in <= 32'h0000_0040; end
            11: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_TILE_STRIDE); ctrl_data_in <= 32'h0000_0020; end
            12: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_BIAS_HEAD_STRIDE); ctrl_data_in <= 32'h0000_0100; end
            13: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_BIAS_HEAD_STRIDE); ctrl_data_in <= 32'h0000_0100; end
            14: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_BIAS_HEAD_STRIDE); ctrl_data_in <= 32'h0000_0100; end
            15: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_BIAS_TILE_STRIDE); ctrl_data_in <= 32'h0000_0020; end
            16: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_BIAS_TILE_STRIDE); ctrl_data_in <= 32'h0000_0040; end
            17: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_BIAS_TILE_STRIDE); ctrl_data_in <= 32'h0000_0020; end
            18: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_GAMMA_STRIDE); ctrl_data_in <= 32'h0000_0004; end
            19: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_GAMMA_STRIDE); ctrl_data_in <= 32'h0000_0004; end
            20: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_GAMMA_STRIDE); ctrl_data_in <= 32'h0000_0004; end
            21: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_EPS_STRIDE); ctrl_data_in <= 32'h0000_0004; end
            22: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_EPS_STRIDE); ctrl_data_in <= 32'h0000_0004; end
            23: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_EPS_STRIDE); ctrl_data_in <= 32'h0000_0004; end
            24: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_BASE_LO);      ctrl_data_in <= BASE_WQ[31:0]; end
            25: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_BASE_HI);      ctrl_data_in <= BASE_WQ[63:32]; end
            26: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_BASE_LO);      ctrl_data_in <= BASE_WK[31:0]; end
            27: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_BASE_HI);      ctrl_data_in <= BASE_WK[63:32]; end
            28: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_BASE_LO);      ctrl_data_in <= BASE_WV[31:0]; end
            29: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_BASE_HI);      ctrl_data_in <= BASE_WV[63:32]; end
            30: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_BASE_LO);      ctrl_data_in <= BASE_WO[31:0]; end
            31: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_BASE_HI);      ctrl_data_in <= BASE_WO[63:32]; end
            32: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_BASE_LO);      ctrl_data_in <= BASE_W1[31:0]; end
            33: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_BASE_HI);      ctrl_data_in <= BASE_W1[63:32]; end
            34: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_BASE_LO);      ctrl_data_in <= BASE_W2[31:0]; end
            35: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_BASE_HI);      ctrl_data_in <= BASE_W2[63:32]; end
            36: begin ctrl_addr <= ctrl_mem_addr(CTRLW_K_CACHE_LO);      ctrl_data_in <= BASE_K_CACHE[31:0]; end
            37: begin ctrl_addr <= ctrl_mem_addr(CTRLW_K_CACHE_HI);      ctrl_data_in <= BASE_K_CACHE[63:32]; end
            38: begin ctrl_addr <= ctrl_mem_addr(CTRLW_V_CACHE_LO);      ctrl_data_in <= BASE_V_CACHE[31:0]; end
            39: begin ctrl_addr <= ctrl_mem_addr(CTRLW_V_CACHE_HI);      ctrl_data_in <= BASE_V_CACHE[63:32]; end
            40: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_BIAS_BASE_LO); ctrl_data_in <= BASE_WQ_BIAS[31:0]; end
            41: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_BIAS_BASE_HI); ctrl_data_in <= BASE_WQ_BIAS[63:32]; end
            42: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_BIAS_BASE_LO); ctrl_data_in <= BASE_WK_BIAS[31:0]; end
            43: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_BIAS_BASE_HI); ctrl_data_in <= BASE_WK_BIAS[63:32]; end
            44: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_BIAS_BASE_LO); ctrl_data_in <= BASE_WV_BIAS[31:0]; end
            45: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_BIAS_BASE_HI); ctrl_data_in <= BASE_WV_BIAS[63:32]; end
            46: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_BIAS_BASE_LO); ctrl_data_in <= BASE_WO_BIAS[31:0]; end
            47: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_BIAS_BASE_HI); ctrl_data_in <= BASE_WO_BIAS[63:32]; end
            48: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_BIAS_BASE_LO); ctrl_data_in <= BASE_W1_BIAS[31:0]; end
            49: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_BIAS_BASE_HI); ctrl_data_in <= BASE_W1_BIAS[63:32]; end
            50: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_BIAS_BASE_LO); ctrl_data_in <= BASE_W2_BIAS[31:0]; end
            51: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_BIAS_BASE_HI); ctrl_data_in <= BASE_W2_BIAS[63:32]; end
            52: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_GAMMA_BASE_LO); ctrl_data_in <= BASE_LN0_GAMMA[31:0]; end
            53: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_GAMMA_BASE_HI); ctrl_data_in <= BASE_LN0_GAMMA[63:32]; end
            54: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_GAMMA_BASE_LO); ctrl_data_in <= BASE_LN1_GAMMA[31:0]; end
            55: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_GAMMA_BASE_HI); ctrl_data_in <= BASE_LN1_GAMMA[63:32]; end
            56: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_GAMMA_BASE_LO); ctrl_data_in <= BASE_FINAL_NORM_GAMMA[31:0]; end
            57: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_GAMMA_BASE_HI); ctrl_data_in <= BASE_FINAL_NORM_GAMMA[63:32]; end
            58: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_EPS_BASE_LO); ctrl_data_in <= BASE_LN0_EPS[31:0]; end
            59: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_EPS_BASE_HI); ctrl_data_in <= BASE_LN0_EPS[63:32]; end
            60: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_EPS_BASE_LO); ctrl_data_in <= BASE_LN1_EPS[31:0]; end
            61: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_EPS_BASE_HI); ctrl_data_in <= BASE_LN1_EPS[63:32]; end
            62: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_EPS_BASE_LO); ctrl_data_in <= BASE_FINAL_NORM_EPS[31:0]; end
            63: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_EPS_BASE_HI); ctrl_data_in <= BASE_FINAL_NORM_EPS[63:32]; end
            64: begin ctrl_addr <= ctrl_mem_addr(CTRLW_IRQ_MASK);        ctrl_data_in <= 32'h0000_0006; end
            default: begin ctrl_addr <= ctrl_mem_addr(CTRLW_IRQ_MASK);   ctrl_data_in <= 32'h0000_0006; end
          endcase
          case (base_assign_step)
            0: ctrl_words[CTRLW_DMA_LAYER_LEN] <= 32'h0000_0100;
            1: ctrl_words[CTRLW_DMA_HEAD_LEN] <= 32'h0000_0040;
            2: ctrl_words[CTRLW_DMA_TILE_LEN] <= 32'h0000_0020;
            3: ctrl_words[CTRLW_LAYER_STRIDE] <= 32'h0000_1000;
            4: ctrl_words[CTRLW_WQ_HEAD_STRIDE] <= 32'h0000_0100;
            5: ctrl_words[CTRLW_WK_HEAD_STRIDE] <= 32'h0000_0100;
            6: ctrl_words[CTRLW_WV_HEAD_STRIDE] <= 32'h0000_0100;
            7: ctrl_words[CTRLW_K_CACHE_STRIDE] <= 32'h0000_0100;
            8: ctrl_words[CTRLW_V_CACHE_STRIDE] <= 32'h0000_0100;
            9: ctrl_words[CTRLW_WO_TILE_STRIDE] <= 32'h0000_0020;
            10: ctrl_words[CTRLW_W1_TILE_STRIDE] <= 32'h0000_0040;
            11: ctrl_words[CTRLW_W2_TILE_STRIDE] <= 32'h0000_0020;
            12: ctrl_words[CTRLW_WQ_BIAS_HEAD_STRIDE] <= 32'h0000_0100;
            13: ctrl_words[CTRLW_WK_BIAS_HEAD_STRIDE] <= 32'h0000_0100;
            14: ctrl_words[CTRLW_WV_BIAS_HEAD_STRIDE] <= 32'h0000_0100;
            15: ctrl_words[CTRLW_WO_BIAS_TILE_STRIDE] <= 32'h0000_0020;
            16: ctrl_words[CTRLW_W1_BIAS_TILE_STRIDE] <= 32'h0000_0040;
            17: ctrl_words[CTRLW_W2_BIAS_TILE_STRIDE] <= 32'h0000_0020;
            18: ctrl_words[CTRLW_LN0_GAMMA_STRIDE] <= 32'h0000_0004;
            19: ctrl_words[CTRLW_LN1_GAMMA_STRIDE] <= 32'h0000_0004;
            20: ctrl_words[CTRLW_FINAL_NORM_GAMMA_STRIDE] <= 32'h0000_0004;
            21: ctrl_words[CTRLW_LN0_EPS_STRIDE] <= 32'h0000_0004;
            22: ctrl_words[CTRLW_LN1_EPS_STRIDE] <= 32'h0000_0004;
            23: ctrl_words[CTRLW_FINAL_NORM_EPS_STRIDE] <= 32'h0000_0004;
            24: ctrl_words[CTRLW_WQ_BASE_LO] <= BASE_WQ[31:0];
            25: ctrl_words[CTRLW_WQ_BASE_HI] <= BASE_WQ[63:32];
            26: ctrl_words[CTRLW_WK_BASE_LO] <= BASE_WK[31:0];
            27: ctrl_words[CTRLW_WK_BASE_HI] <= BASE_WK[63:32];
            28: ctrl_words[CTRLW_WV_BASE_LO] <= BASE_WV[31:0];
            29: ctrl_words[CTRLW_WV_BASE_HI] <= BASE_WV[63:32];
            30: ctrl_words[CTRLW_WO_BASE_LO] <= BASE_WO[31:0];
            31: ctrl_words[CTRLW_WO_BASE_HI] <= BASE_WO[63:32];
            32: ctrl_words[CTRLW_W1_BASE_LO] <= BASE_W1[31:0];
            33: ctrl_words[CTRLW_W1_BASE_HI] <= BASE_W1[63:32];
            34: ctrl_words[CTRLW_W2_BASE_LO] <= BASE_W2[31:0];
            35: ctrl_words[CTRLW_W2_BASE_HI] <= BASE_W2[63:32];
            36: ctrl_words[CTRLW_K_CACHE_LO] <= BASE_K_CACHE[31:0];
            37: ctrl_words[CTRLW_K_CACHE_HI] <= BASE_K_CACHE[63:32];
            38: ctrl_words[CTRLW_V_CACHE_LO] <= BASE_V_CACHE[31:0];
            39: ctrl_words[CTRLW_V_CACHE_HI] <= BASE_V_CACHE[63:32];
            40: ctrl_words[CTRLW_WQ_BIAS_BASE_LO] <= BASE_WQ_BIAS[31:0];
            41: ctrl_words[CTRLW_WQ_BIAS_BASE_HI] <= BASE_WQ_BIAS[63:32];
            42: ctrl_words[CTRLW_WK_BIAS_BASE_LO] <= BASE_WK_BIAS[31:0];
            43: ctrl_words[CTRLW_WK_BIAS_BASE_HI] <= BASE_WK_BIAS[63:32];
            44: ctrl_words[CTRLW_WV_BIAS_BASE_LO] <= BASE_WV_BIAS[31:0];
            45: ctrl_words[CTRLW_WV_BIAS_BASE_HI] <= BASE_WV_BIAS[63:32];
            46: ctrl_words[CTRLW_WO_BIAS_BASE_LO] <= BASE_WO_BIAS[31:0];
            47: ctrl_words[CTRLW_WO_BIAS_BASE_HI] <= BASE_WO_BIAS[63:32];
            48: ctrl_words[CTRLW_W1_BIAS_BASE_LO] <= BASE_W1_BIAS[31:0];
            49: ctrl_words[CTRLW_W1_BIAS_BASE_HI] <= BASE_W1_BIAS[63:32];
            50: ctrl_words[CTRLW_W2_BIAS_BASE_LO] <= BASE_W2_BIAS[31:0];
            51: ctrl_words[CTRLW_W2_BIAS_BASE_HI] <= BASE_W2_BIAS[63:32];
            52: ctrl_words[CTRLW_LN0_GAMMA_BASE_LO] <= BASE_LN0_GAMMA[31:0];
            53: ctrl_words[CTRLW_LN0_GAMMA_BASE_HI] <= BASE_LN0_GAMMA[63:32];
            54: ctrl_words[CTRLW_LN1_GAMMA_BASE_LO] <= BASE_LN1_GAMMA[31:0];
            55: ctrl_words[CTRLW_LN1_GAMMA_BASE_HI] <= BASE_LN1_GAMMA[63:32];
            56: ctrl_words[CTRLW_FINAL_NORM_GAMMA_BASE_LO] <= BASE_FINAL_NORM_GAMMA[31:0];
            57: ctrl_words[CTRLW_FINAL_NORM_GAMMA_BASE_HI] <= BASE_FINAL_NORM_GAMMA[63:32];
            58: ctrl_words[CTRLW_LN0_EPS_BASE_LO] <= BASE_LN0_EPS[31:0];
            59: ctrl_words[CTRLW_LN0_EPS_BASE_HI] <= BASE_LN0_EPS[63:32];
            60: ctrl_words[CTRLW_LN1_EPS_BASE_LO] <= BASE_LN1_EPS[31:0];
            61: ctrl_words[CTRLW_LN1_EPS_BASE_HI] <= BASE_LN1_EPS[63:32];
            62: ctrl_words[CTRLW_FINAL_NORM_EPS_BASE_LO] <= BASE_FINAL_NORM_EPS[31:0];
            63: ctrl_words[CTRLW_FINAL_NORM_EPS_BASE_HI] <= BASE_FINAL_NORM_EPS[63:32];
            64: ctrl_words[CTRLW_IRQ_MASK] <= 32'h0000_0006;
            default: ctrl_words[CTRLW_IRQ_MASK] <= 32'h0000_0006;
          endcase
          if (base_assign_step >= 64) begin
            // IMPORTANT: program ctrl_mem.control START before ap_start so HLS kernel
            // snapshots control args with START already high.
            ctrl_stage <= CTRL_ASSERT_START;
          end else begin
            base_assign_step <= base_assign_step + 1;
          end
          ctrl_gap_cycles <= 2;
        end
        CTRL_ASSERT_START: begin
          ctrl_addr <= ctrl_mem_addr(0);
          ctrl_data_in <= 32'h0000_0003;
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_shadow_control <= 32'h0000_0003;
          ctrl_words[0] <= 32'h0000_0003;
          ctrl_stage <= CTRL_ASSERT_AP_START;
          ctrl_gap_cycles <= 4;
        end
        CTRL_ASSERT_AP_START: begin
          ctrl_addr <= ADDR_AP_CTRL;
          ctrl_data_in <= 32'h0000_0081;
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_stage <= CTRL_CLEAR_START;
          ctrl_gap_cycles <= CTRL_START_HOLD_CYCLES;
        end
        CTRL_CLEAR_START: begin
          ctrl_addr <= ctrl_mem_addr(0);
          ctrl_data_in <= 32'h0000_0001;
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_shadow_control <= 32'h0000_0001;
          ctrl_words[0] <= 32'h0000_0001;
          ctrl_stage <= CTRL_DONE;
          ctrl_gap_cycles <= 1;
        end
        default: begin end
      endcase
    end
  end

  // Monitor progress and stop on done/error/timeout.
  always_ff @(posedge ap_clk) begin : p_sim_monitor
    cycle_count <= cycle_count + 1;

    if (dbg_error[0]) begin
      $finish;
    end
    if (irq_seen_done) begin
      $finish;
    end

    if (cycle_count > MAX_CYCLES) begin
      $finish;
    end

    $display("[TB][%0d] stream_fill_idx=%0d dbg_axis_is_empty=%0d dbg_axis_in_ready_wire=%0d dbg_axis_in_last_wire=%0d dbg_stream_in_counter=%0d stream_gap_countdown=%0d s_axis_in_TDATA=%02h s_axis_in_TKEEP=%0d s_axis_in_TLAST=%0d s_axis_in_TREADY=%0d s_axis_in_TSTRB=%0d s_axis_in_TVALID=%0d",
             cycle_count,
             stream_fill_idx,
             dbg_axis_is_empty[0],
             dbg_axis_in_ready_wire[0],
             dbg_axis_in_last_wire[0],
             dbg_stream_in_counter,
             stream_gap_countdown,
             s_axis_in_TDATA,
             s_axis_in_TKEEP[0],
             s_axis_in_TLAST[0],
             s_axis_in_TREADY,
             s_axis_in_TSTRB[0],
             s_axis_in_TVALID);
  end

  // Print debug mirror updates when DUT marks outputs valid.
  always_ff @(posedge ap_clk) begin : p_debug_vld_monitor
    if (!ap_rst_n) begin
      // no-op
    end
  end

  initial begin
    ap_clk = 1'b0;
    ap_rst_n = 1'b0;


    s_axis_in_TDATA  = 8'h00;
    s_axis_in_TVALID = 1'b0;
    s_axis_in_TLAST  = 1'b0;
    m_axis_out_TREADY = 1'b1;

    m_axi_gmem_RVALID = 1'b0;
    m_axi_gmem_RDATA  = 32'd0;
    m_axi_gmem_RLAST  = 1'b0;
    m_axi_gmem_RID    = 1'b0;
    m_axi_gmem_RRESP  = 2'b00;
    m_axi_gmem_BVALID = 1'b0;
    m_axi_gmem_BRESP  = 2'b00;
    m_axi_gmem_BID    = 1'b0;

    s_axi_control_AWADDR  = '0;
    s_axi_control_AWVALID = 1'b0;
    s_axi_control_WVALID  = 1'b0;
    s_axi_control_WDATA   = '0;
    s_axi_control_WSTRB   = 4'h0;
    s_axi_control_ARADDR  = '0;
    s_axi_control_ARVALID = 1'b0;
    s_axi_control_RREADY  = 1'b0;
    s_axi_control_BREADY  = 1'b0;

    cycle_count       = 0;
    axis_packet_sent  = 1'b0;
    stream_fill_active = 1'b0;
    stream_fill_idx    = '0;
    stream_gap_countdown = '0;
    stream_out_count   = 0;
    stream_out_last_seen = 1'b0;

    axi_aw_active       = 1'b0;
    axi_aw_addr_latched = 64'd0;
    axi_aw_len_latched  = 8'd0;
    axi_aw_size_latched = 3'd2;
    axi_w_beats_seen    = 8'd0;
    axi_bid_latched     = 1'b0;
    axi_bresp_latched   = 2'b00;
    axi_ar_active       = 1'b0;
    axi_ar_addr_latched = 64'd0;
    axi_ar_len_latched  = 8'd0;
    axi_ar_size_latched = 3'd2;
    axi_r_beats_sent    = 8'd0;
    axi_rid_latched     = 1'b0;
    ctrl_stage         = CTRL_RESET_MEM;
    ctrl_gap_cycles    = 0;
    base_assign_step   = 0;
    ctrl_shadow_control = 32'd0;
    axi_state          = AXI_IDLE;
    irq_pending        = 1'b0;
    irq_seen_done      = 1'b0;
    irq_seen_error     = 1'b0;
    irq_seen_done_clr  = 1'b0;
    irq_seen_error_clr = 1'b0;
    irq_req_valid      = 1'b0;
    done_req_valid     = 1'b0;
    error_req_valid    = 1'b0;
    irq_read_phase     = IRQ_RD_STATUS;
    err_phase          = ERR_PHASE_READ;
    ctrl_addr          = '0;
    ctrl_data_in       = '0;
    ctrl_read_en       = 1'b0;
    ctrl_write_en      = 1'b0;
    ctrl_chip_en       = 1'b0;

    for (i = 0; i < STREAM_IN_BUF_BYTES; i = i + 1) begin
      stream_in_mem[i] = 8'(8'h10 + i[7:0]);
    end
    for (i = 0; i < CTRL_MEM_WORDS; i = i + 1) begin
      ctrl_words[i] = 32'h0000_0000;
    end
    for (i = 0; i < DBG_CTRL_MEM_WORDS; i = i + 1) begin
      dbg_ctrl_words[i] = 32'h0000_0000;
    end
    for (i = 0; i < STREAM_OUT_BUF_BYTES; i = i + 1) begin
      stream_out_mem[i] = 8'h00;
    end
    for (i = 0; i < TOP_DMA_BUF_WORDS; i = i + 1) begin
      dma_rx_mem[i] = 32'h0000_0000;
      dma_tx_mem[i] = 32'h0000_0000;
    end
    for (i = 0; i < RAM_REGION_WORDS; i = i + 1) begin
      wq_ram[i] = 32'hA100_0000 + i;
      wk_ram[i] = 32'hA200_0000 + i;
      wv_ram[i] = 32'hA300_0000 + i;
      wo_ram[i] = 32'hA400_0000 + i;
      w1_ram[i] = 32'hA500_0000 + i;
      w2_ram[i] = 32'hA600_0000 + i;
      // Give LN gamma vectors a visible ramp so per-element AXI reads are easy to inspect.
      ln0_gamma_ram[i] = 32'h0000_2000 + i;
      ln1_gamma_ram[i] = 32'h0000_2100 + i;
      ln0_eps_ram[i] = 32'h0000_0001;
      ln1_eps_ram[i] = 32'h0000_0001;
    end
    for (i = 0; i < KV_STORE_WORDS; i = i + 1) begin
      k_cache_store[i] = 32'h0000_0000;
      v_cache_store[i] = 32'h0000_0000;
    end
    for (i = 0; i < STREAM_IN_BUF_BYTES; i = i + 1) begin
      dbg_stream_in_buf_mem[i] = 8'h00;
    end
    for (i = 0; i < 128; i = i + 1) begin
      dbg_in_buf_mem[i] = 8'h00;
      dbg_head_out_buf_mem[i] = 8'h00;
    end
    for (i = 0; i < 64; i = i + 1) begin
      dbg_out_buf_mem[i] = 8'h00;
    end
    for (i = 0; i < 256; i = i + 1) begin
      dbg_head_in_buf_mem[i] = 8'h00;
    end

    repeat (8) @(posedge ap_clk);
    ap_rst_n = 1'b1;
  end

  transformer_top dut (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),

    .m_axi_gmem_AWVALID(m_axi_gmem_AWVALID),
    .m_axi_gmem_AWREADY(m_axi_gmem_AWREADY),
    .m_axi_gmem_AWADDR(m_axi_gmem_AWADDR),
    .m_axi_gmem_AWID(m_axi_gmem_AWID),
    .m_axi_gmem_AWLEN(m_axi_gmem_AWLEN),
    .m_axi_gmem_AWSIZE(m_axi_gmem_AWSIZE),
    .m_axi_gmem_AWBURST(m_axi_gmem_AWBURST),
    .m_axi_gmem_AWLOCK(m_axi_gmem_AWLOCK),
    .m_axi_gmem_AWCACHE(m_axi_gmem_AWCACHE),
    .m_axi_gmem_AWPROT(m_axi_gmem_AWPROT),
    .m_axi_gmem_AWQOS(m_axi_gmem_AWQOS),
    .m_axi_gmem_AWREGION(m_axi_gmem_AWREGION),
    .m_axi_gmem_AWUSER(m_axi_gmem_AWUSER),
    .m_axi_gmem_WVALID(m_axi_gmem_WVALID),
    .m_axi_gmem_WREADY(m_axi_gmem_WREADY),
    .m_axi_gmem_WDATA(m_axi_gmem_WDATA),
    .m_axi_gmem_WSTRB(m_axi_gmem_WSTRB),
    .m_axi_gmem_WLAST(m_axi_gmem_WLAST),
    .m_axi_gmem_WID(m_axi_gmem_WID),
    .m_axi_gmem_WUSER(m_axi_gmem_WUSER),
    .m_axi_gmem_ARVALID(m_axi_gmem_ARVALID),
    .m_axi_gmem_ARREADY(m_axi_gmem_ARREADY),
    .m_axi_gmem_ARADDR(m_axi_gmem_ARADDR),
    .m_axi_gmem_ARID(m_axi_gmem_ARID),
    .m_axi_gmem_ARLEN(m_axi_gmem_ARLEN),
    .m_axi_gmem_ARSIZE(m_axi_gmem_ARSIZE),
    .m_axi_gmem_ARBURST(m_axi_gmem_ARBURST),
    .m_axi_gmem_ARLOCK(m_axi_gmem_ARLOCK),
    .m_axi_gmem_ARCACHE(m_axi_gmem_ARCACHE),
    .m_axi_gmem_ARPROT(m_axi_gmem_ARPROT),
    .m_axi_gmem_ARQOS(m_axi_gmem_ARQOS),
    .m_axi_gmem_ARREGION(m_axi_gmem_ARREGION),
    .m_axi_gmem_ARUSER(m_axi_gmem_ARUSER),
    .m_axi_gmem_RVALID(m_axi_gmem_RVALID),
    .m_axi_gmem_RREADY(m_axi_gmem_RREADY),
    .m_axi_gmem_RDATA(m_axi_gmem_RDATA),
    .m_axi_gmem_RLAST(m_axi_gmem_RLAST),
    .m_axi_gmem_RID(m_axi_gmem_RID),
    .m_axi_gmem_RUSER(m_axi_gmem_RUSER),
    .m_axi_gmem_RRESP(m_axi_gmem_RRESP),
    .m_axi_gmem_BVALID(m_axi_gmem_BVALID),
    .m_axi_gmem_BREADY(m_axi_gmem_BREADY),
    .m_axi_gmem_BRESP(m_axi_gmem_BRESP),
    .m_axi_gmem_BID(m_axi_gmem_BID),
    .m_axi_gmem_BUSER(m_axi_gmem_BUSER),

    .s_axis_in_TDATA(s_axis_in_TDATA),
    .s_axis_in_TVALID(s_axis_in_TVALID),
    .s_axis_in_TREADY(s_axis_in_TREADY),
    .s_axis_in_TKEEP(s_axis_in_TKEEP),
    .s_axis_in_TSTRB(s_axis_in_TSTRB),
    .s_axis_in_TLAST(s_axis_in_TLAST),

    .m_axis_out_TDATA(m_axis_out_TDATA),
    .m_axis_out_TVALID(m_axis_out_TVALID),
    .m_axis_out_TREADY(m_axis_out_TREADY),
    .m_axis_out_TKEEP(m_axis_out_TKEEP),
    .m_axis_out_TSTRB(m_axis_out_TSTRB),
    .m_axis_out_TLAST(m_axis_out_TLAST),

    .irq_ps(irq_ps),

    .dbg_state(dbg_state),
    .dbg_state_ap_vld(dbg_state_ap_vld),
    .dbg_head_ctx_ref_0(dbg_head_ctx_ref_0),
    .dbg_head_ctx_ref_0_ap_vld(dbg_head_ctx_ref_0_ap_vld),
    .dbg_head_ctx_ref_1(dbg_head_ctx_ref_1),
    .dbg_head_ctx_ref_1_ap_vld(dbg_head_ctx_ref_1_ap_vld),
    .dbg_head_compute_ctx_0(dbg_head_compute_ctx_0),
    .dbg_head_compute_ctx_0_ap_vld(dbg_head_compute_ctx_0_ap_vld),
    .dbg_head_compute_ctx_1(dbg_head_compute_ctx_1),
    .dbg_head_compute_ctx_1_ap_vld(dbg_head_compute_ctx_1_ap_vld),

    .dbg_ctrl_mem(dbg_ctrl_mem),
    .dbg_ctrl_mem_ap_vld(dbg_ctrl_mem_ap_vld),
    .control_reg(control_reg),
    .control_reg_ap_vld(control_reg_ap_vld),
    .irq_status_reg(irq_status_reg),
    .irq_status_reg_ap_vld(irq_status_reg_ap_vld),
    .irq_mask_reg(irq_mask_reg),
    .irq_mask_reg_ap_vld(irq_mask_reg_ap_vld),
    .irq_clear_reg(irq_clear_reg),
    .irq_clear_reg_ap_vld(irq_clear_reg_ap_vld),
    .wq_base_addr(wq_base_addr),
    .wq_base_addr_ap_vld(wq_base_addr_ap_vld),
    .wk_base_addr(wk_base_addr),
    .wk_base_addr_ap_vld(wk_base_addr_ap_vld),
    .wv_base_addr(wv_base_addr),
    .wv_base_addr_ap_vld(wv_base_addr_ap_vld),
    .wo_base_addr(wo_base_addr),
    .wo_base_addr_ap_vld(wo_base_addr_ap_vld),
    .w1_base_addr(w1_base_addr),
    .w1_base_addr_ap_vld(w1_base_addr_ap_vld),
    .w2_base_addr(w2_base_addr),
    .w2_base_addr_ap_vld(w2_base_addr_ap_vld),
    .wq_head_stride(wq_head_stride),
    .wq_head_stride_ap_vld(wq_head_stride_ap_vld),
    .wk_head_stride(wk_head_stride),
    .wk_head_stride_ap_vld(wk_head_stride_ap_vld),
    .wv_head_stride(wv_head_stride),
    .wv_head_stride_ap_vld(wv_head_stride_ap_vld),
    .wo_tile_stride(wo_tile_stride),
    .wo_tile_stride_ap_vld(wo_tile_stride_ap_vld),
    .w1_tile_stride(w1_tile_stride),
    .w1_tile_stride_ap_vld(w1_tile_stride_ap_vld),
    .w2_tile_stride(w2_tile_stride),
    .w2_tile_stride_ap_vld(w2_tile_stride_ap_vld),

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
    .dbg_head_group_idx(dbg_head_group_idx),
    .dbg_head_group_idx_ap_vld(dbg_head_group_idx_ap_vld),

    .dbg_wl_ready(dbg_wl_ready),
    .dbg_wl_ready_ap_vld(dbg_wl_ready_ap_vld),
    .dbg_wl_instruction(dbg_wl_instruction),
    .dbg_wl_instruction_ap_vld(dbg_wl_instruction_ap_vld),
    .dbg_wl_start(dbg_wl_start),
    .dbg_wl_start_ap_vld(dbg_wl_start_ap_vld),
    .dbg_wl_accept(dbg_wl_accept),
    .dbg_wl_accept_ap_vld(dbg_wl_accept_ap_vld),
    .dbg_dma_done(dbg_dma_done),
    .dbg_dma_done_ap_vld(dbg_dma_done_ap_vld),
    .dbg_mem_transfer_done(dbg_mem_transfer_done),
    .dbg_mem_transfer_done_ap_vld(dbg_mem_transfer_done_ap_vld),
    .dbg_mem_read_request(dbg_mem_read_request),
    .dbg_mem_read_request_ap_vld(dbg_mem_read_request_ap_vld),
    .dbg_mem_write_request(dbg_mem_write_request),
    .dbg_mem_write_request_ap_vld(dbg_mem_write_request_ap_vld),
    .dbg_mem_op(dbg_mem_op),
    .dbg_mem_op_ap_vld(dbg_mem_op_ap_vld),

    .dbg_in_buf_address0(dbg_in_buf_address0),
    .dbg_in_buf_ce0(dbg_in_buf_ce0),
    .dbg_in_buf_we0(dbg_in_buf_we0),
    .dbg_in_buf_d0(dbg_in_buf_d0),

    .dbg_out_buf_address0(dbg_out_buf_address0),
    .dbg_out_buf_ce0(dbg_out_buf_ce0),
    .dbg_out_buf_we0(dbg_out_buf_we0),
    .dbg_out_buf_d0(dbg_out_buf_d0),

    .dbg_head_in_buf_0_address0(dbg_head_in_buf_0_address0),
    .dbg_head_in_buf_0_ce0(dbg_head_in_buf_0_ce0),
    .dbg_head_in_buf_0_we0(dbg_head_in_buf_0_we0),
    .dbg_head_in_buf_0_d0(dbg_head_in_buf_0_d0),
    .dbg_head_in_buf_1_address0(dbg_head_in_buf_1_address0),
    .dbg_head_in_buf_1_ce0(dbg_head_in_buf_1_ce0),
    .dbg_head_in_buf_1_we0(dbg_head_in_buf_1_we0),
    .dbg_head_in_buf_1_d0(dbg_head_in_buf_1_d0),

    .dbg_head_out_buf_0_address0(dbg_head_out_buf_0_address0),
    .dbg_head_out_buf_0_ce0(dbg_head_out_buf_0_ce0),
    .dbg_head_out_buf_0_we0(dbg_head_out_buf_0_we0),
    .dbg_head_out_buf_0_d0(dbg_head_out_buf_0_d0),
    .dbg_head_out_buf_1_address0(dbg_head_out_buf_1_address0),
    .dbg_head_out_buf_1_ce0(dbg_head_out_buf_1_ce0),
    .dbg_head_out_buf_1_we0(dbg_head_out_buf_1_we0),
    .dbg_head_out_buf_1_d0(dbg_head_out_buf_1_d0),
    .dbg_stream_in_buf_address0(dbg_stream_in_buf_address0),
    .dbg_stream_in_buf_ce0(dbg_stream_in_buf_ce0),
    .dbg_stream_in_buf_we0(dbg_stream_in_buf_we0),
    .dbg_stream_in_buf_d0(dbg_stream_in_buf_d0),

    .dbg_error(dbg_error),
    .dbg_error_ap_vld(dbg_error_ap_vld),
    .dbg_error_code(dbg_error_code),
    .dbg_error_code_ap_vld(dbg_error_code_ap_vld),
    .dbg_done(dbg_done),
    .dbg_done_ap_vld(dbg_done_ap_vld),
    .dbg_axis_is_empty(dbg_axis_is_empty),
    .dbg_axis_is_empty_ap_vld(dbg_axis_is_empty_ap_vld),
    .dbg_axis_in_ready_wire(dbg_axis_in_ready_wire),
    .dbg_axis_in_ready_wire_ap_vld(dbg_axis_in_ready_wire_ap_vld),
    .dbg_axis_in_last_wire(dbg_axis_in_last_wire),
    .dbg_axis_in_last_wire_ap_vld(dbg_axis_in_last_wire_ap_vld),
    .dbg_stream_in_counter(dbg_stream_in_counter),
    .dbg_stream_in_counter_ap_vld(dbg_stream_in_counter_ap_vld),

    .s_axi_control_AWVALID(s_axi_control_AWVALID),
    .s_axi_control_AWREADY(s_axi_control_AWREADY),
    .s_axi_control_AWADDR(s_axi_control_AWADDR),
    .s_axi_control_WVALID(s_axi_control_WVALID),
    .s_axi_control_WREADY(s_axi_control_WREADY),
    .s_axi_control_WDATA(s_axi_control_WDATA),
    .s_axi_control_WSTRB(s_axi_control_WSTRB),
    .s_axi_control_ARVALID(s_axi_control_ARVALID),
    .s_axi_control_ARREADY(s_axi_control_ARREADY),
    .s_axi_control_ARADDR(s_axi_control_ARADDR),
    .s_axi_control_RVALID(s_axi_control_RVALID),
    .s_axi_control_RREADY(s_axi_control_RREADY),
    .s_axi_control_RDATA(s_axi_control_RDATA),
    .s_axi_control_RRESP(s_axi_control_RRESP),
    .s_axi_control_BVALID(s_axi_control_BVALID),
    .s_axi_control_BREADY(s_axi_control_BREADY),
    .s_axi_control_BRESP(s_axi_control_BRESP),
    .interrupt()
  );

endmodule
