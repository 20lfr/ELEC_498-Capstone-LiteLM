`timescale 1ns/1ps

module top_module_hls_tb;
  localparam int CLK_PERIOD_NS        = 10;
  localparam int MAX_CYCLES           = 5000000;
  localparam int CTRL_MEM_WORDS       = 41;
  localparam int DBG_CTRL_MEM_WORDS   = 41;
  localparam int STREAM_IN_BUF_BYTES  = 16;
  localparam int MAX_STREAM_TOKENS    = 256;
  localparam int STREAM_IN_FILE_BYTES_MAX = STREAM_IN_BUF_BYTES * MAX_STREAM_TOKENS;
  localparam int STREAM_OUT_BUF_BYTES = 64;
  localparam int TOP_DMA_BUF_WORDS    = 16384;
  localparam int KV_STORE_WORDS       = 131072;
  localparam int DMA_LATENCY_CYCLES   = 4;
  localparam int STREAM_LATENCY_CYCLES = 6;
  localparam int TB_DEBUG_MODE         = 0; // <----- DEBUG MODE FLAG
  localparam int CTRL_START_HOLD_CYCLES = 128;
  localparam int CTRL_CTRL_GAP_CYCLES   = 24;
  localparam int RAM_REGION_WORDS      = 65536;
  `include "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/test_data/generated_mem_map.svh"
  localparam int TB_HEADS_PARALLEL     = 2;
  localparam int TB_NUM_HEADS          = 4;
  localparam int TB_D_MODEL            = 16;
  localparam int TB_D_FFN              = 24;
  localparam int TB_D_HEADS            = (TB_D_MODEL / TB_NUM_HEADS);
  localparam int TB_NUM_WO_TILES       = 4;
  localparam int TB_NUM_W1_TILES       = 8;
  localparam int TB_NUM_W2_TILES       = 4;
  localparam int TB_NUM_LOGIT_TILES    = 2;
  localparam int TB_NUM_QKV_HEAD_TILES = 2;
  localparam int TB_ATT_CTX_BLOCK      = 8;
  localparam int TB_NUM_ATT_VALUE_HEAD_TILES = 2;
  localparam int TB_D_TILE_WO          = (TB_D_MODEL / TB_NUM_WO_TILES);
  localparam int TB_D_TILE_W1          = ((TB_D_FFN * 2) / TB_NUM_W1_TILES);
  localparam int TB_D_TILE_W2          = (TB_D_MODEL / TB_NUM_W2_TILES);
  localparam int TB_D_VOCAB            = 32;
  localparam int TB_D_TILE_LOGIT       = (TB_D_VOCAB / TB_NUM_LOGIT_TILES);
  localparam int TB_CONTEXT_LENGTH     = 16;
  localparam int TB_D_HEAD_TILE_QKV    = (TB_D_HEADS / TB_NUM_QKV_HEAD_TILES);
  localparam int TB_NUM_ATT_CTX_BLOCKS = (TB_CONTEXT_LENGTH / TB_ATT_CTX_BLOCK);
  localparam int TB_D_HEAD_TILE_ATT_VALUE = (TB_D_HEADS / TB_NUM_ATT_VALUE_HEAD_TILES);
  localparam int TB_OUT_PROJ_W_BYTES   = ((TB_D_MODEL * TB_D_TILE_WO) + 1) / 2;
  localparam int TB_FFN_W1_W_BYTES     = ((TB_D_MODEL * TB_D_TILE_W1) + 1) / 2;
  localparam int TB_FFN_W2_W_BYTES     = ((TB_D_FFN * TB_D_TILE_W2) + 1) / 2;
  localparam int TB_QKV_W_BYTES        = ((TB_D_MODEL * TB_D_HEADS) + 1) / 2;
  localparam int TB_QKV_W_TILE_BYTES   = ((TB_D_MODEL * TB_D_HEAD_TILE_QKV) + 1) / 2;
  localparam int TB_LOGITS_W_BYTES     = ((TB_D_MODEL * TB_D_TILE_LOGIT) + 1) / 2;
  localparam int TB_ATT_SCORES_K_TILE_BYTES = (TB_ATT_CTX_BLOCK * TB_D_HEADS);
  localparam int TB_ATT_VALUE_V_TILE_BYTES  = (TB_CONTEXT_LENGTH * TB_D_HEAD_TILE_ATT_VALUE);
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
  localparam int OP_CMP_LOGITS      = 26;
  localparam int OP_CMP_ARGMAX      = 27;
  localparam logic [7:0] COMPUTE_STATE_WAIT_MEM = 8'd2;
  localparam logic [7:0] COMPUTE_STATE_EXECUTE  = 8'd3;

  localparam logic [7:0] ADDR_AP_CTRL           = 8'h00;
  localparam logic [7:0] ADDR_CTRL_MEM_DATA_0   = 8'h10;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_0 = 8'hB8;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_1 = 8'hBC;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_2 = 8'hC0;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_3 = 8'hC4;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_4 = 8'hC8;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_5 = 8'hCC;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_6 = 8'hD0;

  localparam logic [31:0] CTRL_RESETN_BIT = 32'h0000_0001;
  localparam logic [31:0] CTRL_START_BIT  = 32'h0000_0002;
  localparam logic [31:0] CTRL_DEBUG_MODE_BIT = 32'h0000_0008;
  localparam logic [31:0] IRQ_ERROR_BIT = 32'h0000_0002;
  localparam logic [31:0] IRQ_INFER_DONE_BIT = 32'h0000_0004;

  typedef struct packed {
    logic [31:0] control;
    logic [31:0] irq_mask;
    logic [31:0] irq_clear;
    logic [31:0] layer_stride;
    logic [31:0] wq_head_stride;
    logic [31:0] wk_head_stride;
    logic [31:0] wv_head_stride;
    logic [31:0] k_cache_stride;
    logic [31:0] v_cache_stride;
    logic [31:0] wo_tile_stride;
    logic [31:0] w1_tile_stride;
    logic [31:0] w2_tile_stride;
    logic [31:0] wo_bias_tile_stride;
    logic [31:0] w1_bias_tile_stride;
    logic [31:0] w2_bias_tile_stride;
    logic [31:0] wlogit_tile_stride;
    logic [31:0] ln0_gamma_stride;
    logic [31:0] ln1_gamma_stride;
    logic [31:0] final_norm_gamma_stride;
    logic [31:0] ln0_eps_stride;
    logic [31:0] ln1_eps_stride;
    logic [31:0] final_norm_eps_stride;
    logic [31:0] wq_offset;
    logic [31:0] wk_offset;
    logic [31:0] wv_offset;
    logic [31:0] wo_offset;
    logic [31:0] w1_offset;
    logic [31:0] w2_offset;
    logic [31:0] k_cache_offset;
    logic [31:0] v_cache_offset;
    logic [31:0] wo_bias_offset;
    logic [31:0] w1_bias_offset;
    logic [31:0] w2_bias_offset;
    logic [31:0] ln0_gamma_offset;
    logic [31:0] ln1_gamma_offset;
    logic [31:0] final_norm_gamma_offset;
    logic [31:0] ln0_eps_offset;
    logic [31:0] ln1_eps_offset;
    logic [31:0] final_norm_eps_offset;
    logic [31:0] wlogit_offset;
    logic [31:0] token_position;
  } dbg_control_mem_t;

  typedef struct packed {
    logic [31:0] status;
    logic [31:0] irq_status;
    logic [31:0] error_code;
    logic [31:0] mmu_error_subcode;
    logic [31:0] layer_index;
    logic [31:0] head_index;
    logic [31:0] token_index;
  } status_mem_shadow_t;

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

  // AXI4-Full (KV cache model) interface
  logic         m_axi_kv_gmem_AWVALID;
  logic         m_axi_kv_gmem_AWREADY;
  logic [63:0]  m_axi_kv_gmem_AWADDR;
  logic [0:0]   m_axi_kv_gmem_AWID;
  logic [7:0]   m_axi_kv_gmem_AWLEN;
  logic [2:0]   m_axi_kv_gmem_AWSIZE;
  logic [1:0]   m_axi_kv_gmem_AWBURST;
  logic [1:0]   m_axi_kv_gmem_AWLOCK;
  logic [3:0]   m_axi_kv_gmem_AWCACHE;
  logic [2:0]   m_axi_kv_gmem_AWPROT;
  logic [3:0]   m_axi_kv_gmem_AWQOS;
  logic [3:0]   m_axi_kv_gmem_AWREGION;
  logic [0:0]   m_axi_kv_gmem_AWUSER;

  logic         m_axi_kv_gmem_WVALID;
  logic         m_axi_kv_gmem_WREADY;
  logic [31:0]  m_axi_kv_gmem_WDATA;
  logic [3:0]   m_axi_kv_gmem_WSTRB;
  logic         m_axi_kv_gmem_WLAST;
  logic [0:0]   m_axi_kv_gmem_WID;
  logic [0:0]   m_axi_kv_gmem_WUSER;

  logic         m_axi_kv_gmem_ARVALID;
  logic         m_axi_kv_gmem_ARREADY;
  logic [63:0]  m_axi_kv_gmem_ARADDR;
  logic [0:0]   m_axi_kv_gmem_ARID;
  logic [7:0]   m_axi_kv_gmem_ARLEN;
  logic [2:0]   m_axi_kv_gmem_ARSIZE;
  logic [1:0]   m_axi_kv_gmem_ARBURST;
  logic [1:0]   m_axi_kv_gmem_ARLOCK;
  logic [3:0]   m_axi_kv_gmem_ARCACHE;
  logic [2:0]   m_axi_kv_gmem_ARPROT;
  logic [3:0]   m_axi_kv_gmem_ARQOS;
  logic [3:0]   m_axi_kv_gmem_ARREGION;
  logic [0:0]   m_axi_kv_gmem_ARUSER;

  logic         m_axi_kv_gmem_RVALID;
  logic         m_axi_kv_gmem_RREADY;
  logic [31:0]  m_axi_kv_gmem_RDATA;
  logic         m_axi_kv_gmem_RLAST;
  logic [0:0]   m_axi_kv_gmem_RID;
  logic [0:0]   m_axi_kv_gmem_RUSER;
  logic [1:0]   m_axi_kv_gmem_RRESP;

  logic         m_axi_kv_gmem_BVALID;
  logic         m_axi_kv_gmem_BREADY;
  logic [1:0]   m_axi_kv_gmem_BRESP;
  logic [0:0]   m_axi_kv_gmem_BID;
  logic [0:0]   m_axi_kv_gmem_BUSER;

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

  logic [7:0]  s_axi_control_AWADDR;
  logic        s_axi_control_AWVALID;
  logic        s_axi_control_WVALID;
  logic [31:0] s_axi_control_WDATA;
  logic [3:0]  s_axi_control_WSTRB;
  logic [7:0]  s_axi_control_ARADDR;
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

  logic [5:0]   s_axi_control_r_AWADDR;
  logic         s_axi_control_r_AWVALID;
  logic         s_axi_control_r_WVALID;
  logic [31:0]  s_axi_control_r_WDATA;
  logic [3:0]   s_axi_control_r_WSTRB;
  logic [5:0]   s_axi_control_r_ARADDR;
  logic         s_axi_control_r_ARVALID;
  logic         s_axi_control_r_RREADY;
  logic         s_axi_control_r_BREADY;

  logic         s_axi_control_r_AWREADY;
  logic         s_axi_control_r_WREADY;
  logic         s_axi_control_r_ARREADY;
  logic         s_axi_control_r_RVALID;
  logic [31:0]  s_axi_control_r_RDATA;
  logic [1:0]   s_axi_control_r_RRESP;
  logic         s_axi_control_r_BVALID;
  logic [1:0]   s_axi_control_r_BRESP;

  // Re-added reduced debug outputs from top_no_debug.cpp
  logic [31:0]  dbg_state;
  logic         dbg_state_ap_vld;
  logic [0:0]   dbg_error;
  logic         dbg_error_ap_vld;
  logic [31:0]  dbg_error_code;
  logic         dbg_error_code_ap_vld;

  logic [0:0] irq_ps;
  logic [0:0] irq_ps_shadow;
  logic [0:0] irq_ps_prev;
  logic [31:0] dbg_state_prev;
  logic [31:0] control_reg_prev;
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
  logic [31:0] wlogit_ram    [0:RAM_REGION_WORDS-1];
  logic [31:0] wo_bias_ram   [0:RAM_REGION_WORDS-1];
  logic [31:0] w1_bias_ram   [0:RAM_REGION_WORDS-1];
  logic [31:0] w2_bias_ram   [0:RAM_REGION_WORDS-1];
  logic [31:0] ln0_gamma_ram [0:RAM_REGION_WORDS-1];
  logic [31:0] ln1_gamma_ram [0:RAM_REGION_WORDS-1];
  logic [31:0] final_norm_gamma_ram [0:RAM_REGION_WORDS-1];
  logic [31:0] ln0_eps_ram   [0:RAM_REGION_WORDS-1];
  logic [31:0] ln1_eps_ram   [0:RAM_REGION_WORDS-1];
  logic [31:0] final_norm_eps_ram [0:RAM_REGION_WORDS-1];
  logic [31:0] k_cache_store [0:KV_STORE_WORDS-1];
  logic [31:0] v_cache_store [0:KV_STORE_WORDS-1];
  logic signed [31:0] stream_out_token;
  logic signed [3:0]  selected_embedding [0:TB_D_MODEL-1];

  integer cycle_count;
  integer i;
  integer file_fd;
  integer bytes_read;
  integer prog_word_idx;
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

  logic        kv_axi_aw_active;
  logic [63:0] kv_axi_aw_addr_latched;
  logic [7:0]  kv_axi_aw_len_latched;
  logic [2:0]  kv_axi_aw_size_latched;
  logic [7:0]  kv_axi_w_beats_seen;
  logic [0:0]  kv_axi_bid_latched;
  logic [1:0]  kv_axi_bresp_latched;

  logic        kv_axi_ar_active;
  logic [63:0] kv_axi_ar_addr_latched;
  logic [7:0]  kv_axi_ar_len_latched;
  logic [2:0]  kv_axi_ar_size_latched;
  logic [7:0]  kv_axi_r_beats_sent;
  logic [0:0]  kv_axi_rid_latched;

  logic [31:0] ctrl_words [0:CTRL_MEM_WORDS-1];
  logic [31:0] ctrl_init_words [0:CTRL_MEM_WORDS-1];
  logic [31:0] dbg_ctrl_words [0:DBG_CTRL_MEM_WORDS-1];
  dbg_control_mem_t dbg_ctrl_mem_shadow;
  byte unsigned ctrl_mem_file_bytes [0:(CTRL_MEM_WORDS*4)-1];
  byte unsigned ddr_image_bytes [0:('h43000)-1];
  byte unsigned stream_in_file_bytes [0:STREAM_IN_FILE_BYTES_MAX-1];
  integer total_stream_tokens;
  integer current_stream_token;
  logic next_token_pending;
  logic launch_next_token;

  // AXI ctrl_mem word map for the current 41-word ControlMemSpace.
  localparam int CTRLW_CONTROL            = 0;
  localparam int CTRLW_IRQ_MASK           = 1;
  localparam int CTRLW_IRQ_CLEAR          = 2;
  localparam int CTRLW_LAYER_STRIDE       = 3;
  localparam int CTRLW_WQ_HEAD_STRIDE     = 4;
  localparam int CTRLW_WK_HEAD_STRIDE     = 5;
  localparam int CTRLW_WV_HEAD_STRIDE     = 6;
  localparam int CTRLW_K_CACHE_STRIDE     = 7;
  localparam int CTRLW_V_CACHE_STRIDE     = 8;
  localparam int CTRLW_WO_TILE_STRIDE     = 9;
  localparam int CTRLW_W1_TILE_STRIDE     = 10;
  localparam int CTRLW_W2_TILE_STRIDE     = 11;
  localparam int CTRLW_WO_BIAS_TILE_STRIDE = 12;
  localparam int CTRLW_W1_BIAS_TILE_STRIDE = 13;
  localparam int CTRLW_W2_BIAS_TILE_STRIDE = 14;
  localparam int CTRLW_WLOGIT_TILE_STRIDE = 15;
  localparam int CTRLW_LN0_GAMMA_STRIDE   = 16;
  localparam int CTRLW_LN1_GAMMA_STRIDE   = 17;
  localparam int CTRLW_FINAL_NORM_GAMMA_STRIDE = 18;
  localparam int CTRLW_LN0_EPS_STRIDE     = 19;
  localparam int CTRLW_LN1_EPS_STRIDE     = 20;
  localparam int CTRLW_FINAL_NORM_EPS_STRIDE = 21;
  localparam int CTRLW_WQ_BASE_LO         = 22;
  localparam int CTRLW_WQ_BASE_HI         = 22;
  localparam int CTRLW_WK_BASE_LO         = 23;
  localparam int CTRLW_WK_BASE_HI         = 23;
  localparam int CTRLW_WV_BASE_LO         = 24;
  localparam int CTRLW_WV_BASE_HI         = 24;
  localparam int CTRLW_WO_BASE_LO         = 25;
  localparam int CTRLW_WO_BASE_HI         = 25;
  localparam int CTRLW_W1_BASE_LO         = 26;
  localparam int CTRLW_W1_BASE_HI         = 26;
  localparam int CTRLW_W2_BASE_LO         = 27;
  localparam int CTRLW_W2_BASE_HI         = 27;
  localparam int CTRLW_K_CACHE_LO         = 28;
  localparam int CTRLW_K_CACHE_HI         = 28;
  localparam int CTRLW_V_CACHE_LO         = 29;
  localparam int CTRLW_V_CACHE_HI         = 29;
  localparam int CTRLW_WO_BIAS_BASE_LO    = 30;
  localparam int CTRLW_WO_BIAS_BASE_HI    = 30;
  localparam int CTRLW_W1_BIAS_BASE_LO    = 31;
  localparam int CTRLW_W1_BIAS_BASE_HI    = 31;
  localparam int CTRLW_W2_BIAS_BASE_LO    = 32;
  localparam int CTRLW_W2_BIAS_BASE_HI    = 32;
  localparam int CTRLW_LN0_GAMMA_BASE_LO  = 33;
  localparam int CTRLW_LN0_GAMMA_BASE_HI  = 33;
  localparam int CTRLW_LN1_GAMMA_BASE_LO  = 34;
  localparam int CTRLW_LN1_GAMMA_BASE_HI  = 34;
  localparam int CTRLW_FINAL_NORM_GAMMA_BASE_LO = 35;
  localparam int CTRLW_FINAL_NORM_GAMMA_BASE_HI = 35;
  localparam int CTRLW_LN0_EPS_BASE_LO    = 36;
  localparam int CTRLW_LN0_EPS_BASE_HI    = 36;
  localparam int CTRLW_LN1_EPS_BASE_LO    = 37;
  localparam int CTRLW_LN1_EPS_BASE_HI    = 37;
  localparam int CTRLW_FINAL_NORM_EPS_BASE_LO = 38;
  localparam int CTRLW_FINAL_NORM_EPS_BASE_HI = 38;
  localparam int CTRLW_WLOGIT_BASE_LO     = 39;
  localparam int CTRLW_WLOGIT_BASE_HI     = 39;
  localparam int CTRLW_TOKEN_POSITION     = 40;
  // 64-bit DDR base map for control memory programming.
  localparam logic [63:0] BASE_WQ               = 64'h0000_0001_6000_0000;
  localparam logic [63:0] BASE_WK               = 64'h0000_0001_6100_0000;
  localparam logic [63:0] BASE_WV               = 64'h0000_0001_6200_0000;
  localparam logic [63:0] BASE_WO               = 64'h0000_0001_6300_0000;
  localparam logic [63:0] BASE_W1               = 64'h0000_0001_6400_0000;
  localparam logic [63:0] BASE_W2               = 64'h0000_0001_6500_0000;
  localparam logic [63:0] BASE_K_CACHE          = 64'h0000_0001_6600_0000;
  localparam logic [63:0] BASE_V_CACHE          = 64'h0000_0001_6700_0000;
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

  typedef enum logic [3:0] {
    CTRL_RESET_MEM,
    CTRL_ASSERT_RESET,
    CTRL_DEASSERT_RESET,
    CTRL_PROGRAM_BASES,
    CTRL_RELAUNCH_PREP,
    CTRL_ASSERT_DEBUG_MODE,
    CTRL_ASSERT_TOKEN_INDEX,
    CTRL_ASSERT_START,
    CTRL_ASSERT_AP_START,
    CTRL_HOLD_START,
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

  logic [7:0]  ctrl_addr;
  logic [31:0] ctrl_data_in;
  logic        ctrl_read_en;
  logic        ctrl_write_en;
  logic        ctrl_chip_en;
  logic [31:0] ctrl_shadow_control;
  integer      ctrl_gap_cycles;
  integer      base_assign_step;
  logic [31:0] axi_rdata;
  logic        axi_read_valid;
  logic [7:0]  axi_addr;
  logic        axi_is_write;
  logic        axi_aw_seen;
  logic        axi_w_seen;
  logic        axi_b_seen;
  logic [31:0] error_code_lat;
  status_mem_shadow_t status_mem_shadow;
  logic        irq_pending;
  logic        irq_seen_done;
  logic        irq_seen_error;
  logic        irq_req_valid;
  logic        irq_req_read;
  logic [7:0]  irq_req_addr;
  logic        done_req_valid;
  logic        done_req_write;
  logic [7:0]  done_req_addr;
  logic [31:0] done_req_wdata;
  logic        done_clear_release_pending;
  logic        error_req_valid;
  logic        error_req_write;
  logic        error_req_read;
  logic [7:0]  error_req_addr;
  logic [31:0] error_req_wdata;
  logic        error_clear_release_pending;
  logic [2:0]  status_poll_idx;
  wire         irq_req_fire;
  wire         done_req_fire;
  wire         error_req_fire;
  wire         ctrl_can_issue;

  always #(CLK_PERIOD_NS/2) ap_clk = ~ap_clk;

  assign ctrl_can_issue = (ctrl_gap_cycles == 0) && (axi_state == AXI_IDLE);
  assign irq_req_fire   = ctrl_can_issue && irq_req_valid;
  assign done_req_fire  = ctrl_can_issue && !irq_req_valid && done_req_valid;
  assign error_req_fire = ctrl_can_issue && !irq_req_valid && !done_req_valid && error_req_valid;

  // Decode the testbench's local ctrl_mem shadow into named fields for waveform readability.
  always_comb begin : p_dbg_ctrl_mem_shadow_unpack_active
    int w;
    for (w = 0; w < DBG_CTRL_MEM_WORDS; w = w + 1) begin
      dbg_ctrl_words[w] = ctrl_words[w];
    end

    dbg_ctrl_mem_shadow.control                 = dbg_ctrl_words[0];
    dbg_ctrl_mem_shadow.irq_mask                = dbg_ctrl_words[1];
    dbg_ctrl_mem_shadow.irq_clear               = dbg_ctrl_words[2];
    dbg_ctrl_mem_shadow.layer_stride            = dbg_ctrl_words[3];
    dbg_ctrl_mem_shadow.wq_head_stride          = dbg_ctrl_words[4];
    dbg_ctrl_mem_shadow.wk_head_stride          = dbg_ctrl_words[5];
    dbg_ctrl_mem_shadow.wv_head_stride          = dbg_ctrl_words[6];
    dbg_ctrl_mem_shadow.k_cache_stride          = dbg_ctrl_words[7];
    dbg_ctrl_mem_shadow.v_cache_stride          = dbg_ctrl_words[8];
    dbg_ctrl_mem_shadow.wo_tile_stride          = dbg_ctrl_words[9];
    dbg_ctrl_mem_shadow.w1_tile_stride          = dbg_ctrl_words[10];
    dbg_ctrl_mem_shadow.w2_tile_stride          = dbg_ctrl_words[11];
    dbg_ctrl_mem_shadow.wo_bias_tile_stride     = dbg_ctrl_words[12];
    dbg_ctrl_mem_shadow.w1_bias_tile_stride     = dbg_ctrl_words[13];
    dbg_ctrl_mem_shadow.w2_bias_tile_stride     = dbg_ctrl_words[14];
    dbg_ctrl_mem_shadow.wlogit_tile_stride      = dbg_ctrl_words[15];
    dbg_ctrl_mem_shadow.ln0_gamma_stride        = dbg_ctrl_words[16];
    dbg_ctrl_mem_shadow.ln1_gamma_stride        = dbg_ctrl_words[17];
    dbg_ctrl_mem_shadow.final_norm_gamma_stride = dbg_ctrl_words[18];
    dbg_ctrl_mem_shadow.ln0_eps_stride          = dbg_ctrl_words[19];
    dbg_ctrl_mem_shadow.ln1_eps_stride          = dbg_ctrl_words[20];
    dbg_ctrl_mem_shadow.final_norm_eps_stride   = dbg_ctrl_words[21];
    dbg_ctrl_mem_shadow.wq_offset               = dbg_ctrl_words[22];
    dbg_ctrl_mem_shadow.wk_offset               = dbg_ctrl_words[23];
    dbg_ctrl_mem_shadow.wv_offset               = dbg_ctrl_words[24];
    dbg_ctrl_mem_shadow.wo_offset               = dbg_ctrl_words[25];
    dbg_ctrl_mem_shadow.w1_offset               = dbg_ctrl_words[26];
    dbg_ctrl_mem_shadow.w2_offset               = dbg_ctrl_words[27];
    dbg_ctrl_mem_shadow.k_cache_offset          = dbg_ctrl_words[28];
    dbg_ctrl_mem_shadow.v_cache_offset          = dbg_ctrl_words[29];
    dbg_ctrl_mem_shadow.wo_bias_offset          = dbg_ctrl_words[30];
    dbg_ctrl_mem_shadow.w1_bias_offset          = dbg_ctrl_words[31];
    dbg_ctrl_mem_shadow.w2_bias_offset          = dbg_ctrl_words[32];
    dbg_ctrl_mem_shadow.ln0_gamma_offset        = dbg_ctrl_words[33];
    dbg_ctrl_mem_shadow.ln1_gamma_offset        = dbg_ctrl_words[34];
    dbg_ctrl_mem_shadow.final_norm_gamma_offset = dbg_ctrl_words[35];
    dbg_ctrl_mem_shadow.ln0_eps_offset          = dbg_ctrl_words[36];
    dbg_ctrl_mem_shadow.ln1_eps_offset          = dbg_ctrl_words[37];
    dbg_ctrl_mem_shadow.final_norm_eps_offset   = dbg_ctrl_words[38];
    dbg_ctrl_mem_shadow.wlogit_offset           = dbg_ctrl_words[39];
    dbg_ctrl_mem_shadow.token_position          = dbg_ctrl_words[40];
  end

  function automatic [31:0] dma_pattern_word(
    input [63:0] base_addr,
    input int unsigned word_idx
  );
    dma_pattern_word = base_addr[31:0] ^ (32'h1357_0000 + word_idx);
  endfunction

  function automatic [7:0] ctrl_mem_addr(input int word_idx);
    ctrl_mem_addr = ADDR_CTRL_MEM_DATA_0 + (word_idx * 4);
  endfunction

  function automatic [7:0] status_mem_addr(input logic [2:0] idx);
    case (idx)
      3'd0: status_mem_addr = ADDR_STATUS_MEM_DATA_0;
      3'd1: status_mem_addr = ADDR_STATUS_MEM_DATA_1;
      3'd2: status_mem_addr = ADDR_STATUS_MEM_DATA_2;
      3'd3: status_mem_addr = ADDR_STATUS_MEM_DATA_3;
      3'd4: status_mem_addr = ADDR_STATUS_MEM_DATA_4;
      3'd5: status_mem_addr = ADDR_STATUS_MEM_DATA_5;
      default: status_mem_addr = ADDR_STATUS_MEM_DATA_6;
    endcase
  endfunction

  function automatic [31:0] ctrl_debug_bits();
    ctrl_debug_bits = TB_DEBUG_MODE ? CTRL_DEBUG_MODE_BIT : 32'd0;
  endfunction

  task automatic load_stream_token(input int token_idx);
    int base_idx;
    int j;
    begin
      base_idx = token_idx * STREAM_IN_BUF_BYTES;
      for (j = 0; j < STREAM_IN_BUF_BYTES; j = j + 1) begin
        stream_in_mem[j] = stream_in_file_bytes[base_idx + j];
      end
    end
  endtask

  function automatic [63:0] ctrl_base_addr64(input int lo_idx, input int hi_idx);
    if (lo_idx == hi_idx) begin
      ctrl_base_addr64 = {32'h0000_0000, ctrl_words[lo_idx]};
    end else begin
      ctrl_base_addr64 = {ctrl_words[hi_idx], ctrl_words[lo_idx]};
    end
  endfunction

  function automatic [31:0] load_image_word(input int unsigned addr);
    begin
      if ((addr + 3) < DDR_IMAGE_BYTES) begin
        load_image_word = {ddr_image_bytes[addr + 3],
                           ddr_image_bytes[addr + 2],
                           ddr_image_bytes[addr + 1],
                           ddr_image_bytes[addr + 0]};
      end else begin
        load_image_word = 32'h0000_0000;
      end
    end
  endfunction

  function automatic int ctrl_prog_word_idx(input int step);
    begin
      if (step >= 0 && step <= (CTRL_MEM_WORDS - 2)) begin
        // Program words 1..CTRL_MEM_WORDS-1 after the initial control write.
        ctrl_prog_word_idx = step + 1;
      end else begin
        ctrl_prog_word_idx = CTRLW_IRQ_MASK;
      end
    end
  endfunction

  function automatic bit in_range64(
    input [63:0] addr,
    input [63:0] base,
    input [63:0] bytes
  );
    in_range64 = (addr >= base) && (addr < (base + bytes));
  endfunction

  function automatic bit is_k_cache_addr(input [63:0] addr);
    is_k_cache_addr = in_range64(addr, ctrl_base_addr64(CTRLW_K_CACHE_LO, CTRLW_K_CACHE_HI), IMG_SPAN_K_CACHE);
  endfunction

  function automatic bit is_v_cache_addr(input [63:0] addr);
    is_v_cache_addr = in_range64(addr, ctrl_base_addr64(CTRLW_V_CACHE_LO, CTRLW_V_CACHE_HI), IMG_SPAN_V_CACHE);
  endfunction

  function automatic bit is_wq_addr(input [63:0] addr);
    is_wq_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WQ_BASE_LO, CTRLW_WQ_BASE_HI), IMG_SPAN_WQ);
  endfunction

  function automatic bit is_wk_addr(input [63:0] addr);
    is_wk_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WK_BASE_LO, CTRLW_WK_BASE_HI), IMG_SPAN_WK);
  endfunction

  function automatic bit is_wv_addr(input [63:0] addr);
    is_wv_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WV_BASE_LO, CTRLW_WV_BASE_HI), IMG_SPAN_WV);
  endfunction

  function automatic bit is_wo_addr(input [63:0] addr);
    is_wo_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WO_BASE_LO, CTRLW_WO_BASE_HI), IMG_SPAN_WO);
  endfunction

  function automatic bit is_w1_addr(input [63:0] addr);
    is_w1_addr = in_range64(addr, ctrl_base_addr64(CTRLW_W1_BASE_LO, CTRLW_W1_BASE_HI), IMG_SPAN_W1);
  endfunction

  function automatic bit is_w2_addr(input [63:0] addr);
    is_w2_addr = in_range64(addr, ctrl_base_addr64(CTRLW_W2_BASE_LO, CTRLW_W2_BASE_HI), IMG_SPAN_W2);
  endfunction

  function automatic bit is_wlogit_addr(input [63:0] addr);
    is_wlogit_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WLOGIT_BASE_LO, CTRLW_WLOGIT_BASE_HI), IMG_SPAN_WVOCAB);
  endfunction

  function automatic bit is_wo_bias_addr(input [63:0] addr);
    is_wo_bias_addr = in_range64(addr, ctrl_base_addr64(CTRLW_WO_BIAS_BASE_LO, CTRLW_WO_BIAS_BASE_HI), IMG_SPAN_WO_BIAS);
  endfunction

  function automatic bit is_w1_bias_addr(input [63:0] addr);
    is_w1_bias_addr = in_range64(addr, ctrl_base_addr64(CTRLW_W1_BIAS_BASE_LO, CTRLW_W1_BIAS_BASE_HI), IMG_SPAN_W1_BIAS);
  endfunction

  function automatic bit is_w2_bias_addr(input [63:0] addr);
    is_w2_bias_addr = in_range64(addr, ctrl_base_addr64(CTRLW_W2_BIAS_BASE_LO, CTRLW_W2_BIAS_BASE_HI), IMG_SPAN_W2_BIAS);
  endfunction

  function automatic bit is_ln0_gamma_addr(input [63:0] addr);
    is_ln0_gamma_addr = in_range64(addr, ctrl_base_addr64(CTRLW_LN0_GAMMA_BASE_LO, CTRLW_LN0_GAMMA_BASE_HI), IMG_SPAN_LN0_GAMMA);
  endfunction

  function automatic bit is_ln1_gamma_addr(input [63:0] addr);
    is_ln1_gamma_addr = in_range64(addr, ctrl_base_addr64(CTRLW_LN1_GAMMA_BASE_LO, CTRLW_LN1_GAMMA_BASE_HI), IMG_SPAN_LN1_GAMMA);
  endfunction

  function automatic bit is_final_norm_gamma_addr(input [63:0] addr);
    is_final_norm_gamma_addr = in_range64(addr, ctrl_base_addr64(CTRLW_FINAL_NORM_GAMMA_BASE_LO, CTRLW_FINAL_NORM_GAMMA_BASE_HI), IMG_SPAN_FINAL_NORM_GAMMA);
  endfunction

  function automatic bit is_ln0_eps_addr(input [63:0] addr);
    is_ln0_eps_addr = in_range64(addr, ctrl_base_addr64(CTRLW_LN0_EPS_BASE_LO, CTRLW_LN0_EPS_BASE_HI), IMG_SPAN_LN0_EPS);
  endfunction

  function automatic bit is_ln1_eps_addr(input [63:0] addr);
    is_ln1_eps_addr = in_range64(addr, ctrl_base_addr64(CTRLW_LN1_EPS_BASE_LO, CTRLW_LN1_EPS_BASE_HI), IMG_SPAN_LN1_EPS);
  endfunction

  function automatic bit is_final_norm_eps_addr(input [63:0] addr);
    is_final_norm_eps_addr = in_range64(addr, ctrl_base_addr64(CTRLW_FINAL_NORM_EPS_BASE_LO, CTRLW_FINAL_NORM_EPS_BASE_HI), IMG_SPAN_FINAL_NORM_EPS);
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
      end else if (is_wlogit_addr(addr)) begin
        mem_read_word = wlogit_ram[region_index(addr, ctrl_base_addr64(CTRLW_WLOGIT_BASE_LO, CTRLW_WLOGIT_BASE_HI))];
      end else if (is_wo_bias_addr(addr)) begin
        mem_read_word = wo_bias_ram[region_index(addr, ctrl_base_addr64(CTRLW_WO_BIAS_BASE_LO, CTRLW_WO_BIAS_BASE_HI))];
      end else if (is_w1_bias_addr(addr)) begin
        mem_read_word = w1_bias_ram[region_index(addr, ctrl_base_addr64(CTRLW_W1_BIAS_BASE_LO, CTRLW_W1_BIAS_BASE_HI))];
      end else if (is_w2_bias_addr(addr)) begin
        mem_read_word = w2_bias_ram[region_index(addr, ctrl_base_addr64(CTRLW_W2_BIAS_BASE_LO, CTRLW_W2_BIAS_BASE_HI))];
      end else if (is_ln0_gamma_addr(addr)) begin
        mem_read_word = ln0_gamma_ram[region_index(addr, ctrl_base_addr64(CTRLW_LN0_GAMMA_BASE_LO, CTRLW_LN0_GAMMA_BASE_HI))];
      end else if (is_ln1_gamma_addr(addr)) begin
        mem_read_word = ln1_gamma_ram[region_index(addr, ctrl_base_addr64(CTRLW_LN1_GAMMA_BASE_LO, CTRLW_LN1_GAMMA_BASE_HI))];
      end else if (is_final_norm_gamma_addr(addr)) begin
        mem_read_word = final_norm_gamma_ram[region_index(addr, ctrl_base_addr64(CTRLW_FINAL_NORM_GAMMA_BASE_LO, CTRLW_FINAL_NORM_GAMMA_BASE_HI))];
      end else if (is_ln0_eps_addr(addr)) begin
        mem_read_word = ln0_eps_ram[region_index(addr, ctrl_base_addr64(CTRLW_LN0_EPS_BASE_LO, CTRLW_LN0_EPS_BASE_HI))];
      end else if (is_ln1_eps_addr(addr)) begin
        mem_read_word = ln1_eps_ram[region_index(addr, ctrl_base_addr64(CTRLW_LN1_EPS_BASE_LO, CTRLW_LN1_EPS_BASE_HI))];
      end else if (is_final_norm_eps_addr(addr)) begin
        mem_read_word = final_norm_eps_ram[region_index(addr, ctrl_base_addr64(CTRLW_FINAL_NORM_EPS_BASE_LO, CTRLW_FINAL_NORM_EPS_BASE_HI))];
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

  // AXI stream constants.
  assign s_axis_in_TKEEP = 1'b1;
  assign s_axis_in_TSTRB = 1'b1;
  assign m_axis_out_TREADY = 1'b1;
  assign s_axi_control_r_AWVALID = 1'b0;
  assign s_axi_control_r_WVALID  = 1'b0;
  assign s_axi_control_r_WDATA   = 32'd0;
  assign s_axi_control_r_WSTRB   = 4'h0;
  assign s_axi_control_r_ARVALID = 1'b0;
  assign s_axi_control_r_RREADY  = 1'b1;
  assign s_axi_control_r_BREADY  = 1'b1;
  assign s_axi_control_r_AWADDR  = 6'd0;
  assign s_axi_control_r_ARADDR  = 6'd0;

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
      if (launch_next_token) begin
        axis_packet_sent   <= 1'b0;
        stream_fill_active <= 1'b0;
        stream_fill_idx    <= '0;
        stream_gap_countdown <= '0;
      end
      if (stream_fill_active && (stream_gap_countdown != 0)) begin
        stream_gap_countdown <= stream_gap_countdown - 1'b1;
      end

      // Start ingress only once dbg_state reaches S_STREAM_IN.
      if (!axis_packet_sent && !stream_fill_active &&
          (dbg_state == 32'd1) &&
          s_axis_in_TREADY) begin
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
      stream_out_token     <= 32'sd0;
    end else begin
      if (launch_next_token) begin
        stream_out_count     <= 0;
        stream_out_last_seen <= 1'b0;
        stream_out_token     <= 32'sd0;
      end
      if (m_axis_out_TVALID && m_axis_out_TREADY) begin
        if (stream_out_count < STREAM_OUT_BUF_BYTES) begin
          stream_out_mem[stream_out_count] <= m_axis_out_TDATA;
          if (stream_out_count == 0) begin
            stream_out_token[7:0] <= m_axis_out_TDATA;
          end else if (stream_out_count == 1) begin
            stream_out_token[15:8] <= m_axis_out_TDATA;
          end else if (stream_out_count == 2) begin
            stream_out_token[23:16] <= m_axis_out_TDATA;
          end else if (stream_out_count == 3) begin
            stream_out_token[31:24] <= m_axis_out_TDATA;
          end
          stream_out_count <= stream_out_count + 1;
        end
        if (m_axis_out_TLAST[0]) begin
          stream_out_last_seen <= 1'b1;
          stream_out_count     <= 0;
        end
      end
    end
  end

  // Select embedding vector from vocab weight matrix using argmax token index.
  always_comb begin : p_embedding_lookup
    int wbase;
    wbase = stream_out_token * (TB_D_MODEL / 8);
    for (int k = 0; k < TB_D_MODEL; k++) begin
      selected_embedding[k] = $signed(wlogit_ram[wbase + (k / 8)][(k % 8) * 4 +: 4]);
    end
  end

  // AXI4-Full ready/user defaults.
  assign m_axi_gmem_AWREADY = !axi_aw_active;
  assign m_axi_gmem_WREADY  = axi_aw_active;
  assign m_axi_gmem_ARREADY = !axi_ar_active && !m_axi_gmem_RVALID;
  assign m_axi_gmem_RUSER   = 1'b0;
  assign m_axi_gmem_BUSER   = 1'b0;
  assign m_axi_kv_gmem_AWREADY = !kv_axi_aw_active;
  assign m_axi_kv_gmem_WREADY  = kv_axi_aw_active;
  assign m_axi_kv_gmem_ARREADY = !kv_axi_ar_active && !m_axi_kv_gmem_RVALID;
  assign m_axi_kv_gmem_RUSER   = 1'b0;
  assign m_axi_kv_gmem_BUSER   = 1'b0;

  // AXI4-Full memory model (single outstanding read and write burst).
  always_ff @(posedge ap_clk) begin : m_axi_full_model
    logic [63:0] waddr_cur;
    logic [63:0] raddr_cur;
    logic [31:0] rdata_cur;
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
        rdata_cur         = mem_read_word(raddr_cur);
        m_axi_gmem_RDATA  <= rdata_cur;
        m_axi_gmem_RID    <= axi_rid_latched;
        m_axi_gmem_RRESP  <= 2'b00;
        m_axi_gmem_RLAST  <= (axi_r_beats_sent == axi_ar_len_latched);
        m_axi_gmem_RVALID <= 1'b1;
        $display("[AXI-RD] cycle=%0d araddr=0x%016h rdata=0x%08h beat=%0d last=%0b",
                 cycle_count, raddr_cur, rdata_cur, axi_r_beats_sent,
                 (axi_r_beats_sent == axi_ar_len_latched));
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

  // AXI4-Full KV-cache memory model (single outstanding read and write burst).
  always_ff @(posedge ap_clk) begin : m_axi_kv_full_model
    logic [63:0] waddr_cur;
    logic [63:0] raddr_cur;
    logic [31:0] rdata_cur;
    if (!ap_rst_n) begin
      kv_axi_aw_active        <= 1'b0;
      kv_axi_aw_addr_latched  <= 64'd0;
      kv_axi_aw_len_latched   <= 8'd0;
      kv_axi_aw_size_latched  <= 3'd2;
      kv_axi_w_beats_seen     <= 8'd0;
      kv_axi_bid_latched      <= 1'b0;
      kv_axi_bresp_latched    <= 2'b00;

      kv_axi_ar_active        <= 1'b0;
      kv_axi_ar_addr_latched  <= 64'd0;
      kv_axi_ar_len_latched   <= 8'd0;
      kv_axi_ar_size_latched  <= 3'd2;
      kv_axi_r_beats_sent     <= 8'd0;
      kv_axi_rid_latched      <= 1'b0;

      m_axi_kv_gmem_RVALID    <= 1'b0;
      m_axi_kv_gmem_RDATA     <= 32'd0;
      m_axi_kv_gmem_RLAST     <= 1'b0;
      m_axi_kv_gmem_RID       <= 1'b0;
      m_axi_kv_gmem_RRESP     <= 2'b00;
      m_axi_kv_gmem_BVALID    <= 1'b0;
      m_axi_kv_gmem_BRESP     <= 2'b00;
      m_axi_kv_gmem_BID       <= 1'b0;
    end else begin
      if (m_axi_kv_gmem_AWVALID && m_axi_kv_gmem_AWREADY && !kv_axi_aw_active) begin
        kv_axi_aw_active       <= 1'b1;
        kv_axi_aw_addr_latched <= m_axi_kv_gmem_AWADDR;
        kv_axi_aw_len_latched  <= m_axi_kv_gmem_AWLEN;
        kv_axi_aw_size_latched <= m_axi_kv_gmem_AWSIZE;
        kv_axi_w_beats_seen    <= 8'd0;
        kv_axi_bid_latched     <= m_axi_kv_gmem_AWID;
      end

      if (kv_axi_aw_active && m_axi_kv_gmem_WVALID && m_axi_kv_gmem_WREADY) begin
        waddr_cur = kv_axi_aw_addr_latched + ({{56{1'b0}}, kv_axi_w_beats_seen} << kv_axi_aw_size_latched);
        mem_write_word(waddr_cur, m_axi_kv_gmem_WDATA, m_axi_kv_gmem_WSTRB);
        if (m_axi_kv_gmem_WLAST || (kv_axi_w_beats_seen == kv_axi_aw_len_latched)) begin
          kv_axi_aw_active        <= 1'b0;
          m_axi_kv_gmem_BVALID    <= 1'b1;
          m_axi_kv_gmem_BRESP     <= kv_axi_bresp_latched;
          m_axi_kv_gmem_BID       <= kv_axi_bid_latched;
        end else begin
          kv_axi_w_beats_seen <= kv_axi_w_beats_seen + 1'b1;
        end
      end

      if (m_axi_kv_gmem_BVALID && m_axi_kv_gmem_BREADY) begin
        m_axi_kv_gmem_BVALID <= 1'b0;
      end

      if (m_axi_kv_gmem_ARVALID && m_axi_kv_gmem_ARREADY && !kv_axi_ar_active && !m_axi_kv_gmem_RVALID) begin
        kv_axi_ar_active       <= 1'b1;
        kv_axi_ar_addr_latched <= m_axi_kv_gmem_ARADDR;
        kv_axi_ar_len_latched  <= m_axi_kv_gmem_ARLEN;
        kv_axi_ar_size_latched <= m_axi_kv_gmem_ARSIZE;
        kv_axi_r_beats_sent    <= 8'd0;
        kv_axi_rid_latched     <= m_axi_kv_gmem_ARID;
      end

      if (kv_axi_ar_active && !m_axi_kv_gmem_RVALID) begin
        raddr_cur = kv_axi_ar_addr_latched + ({{56{1'b0}}, kv_axi_r_beats_sent} << kv_axi_ar_size_latched);
        rdata_cur            = mem_read_word(raddr_cur);
        m_axi_kv_gmem_RDATA  <= rdata_cur;
        m_axi_kv_gmem_RID    <= kv_axi_rid_latched;
        m_axi_kv_gmem_RRESP  <= 2'b00;
        m_axi_kv_gmem_RLAST  <= (kv_axi_r_beats_sent == kv_axi_ar_len_latched);
        m_axi_kv_gmem_RVALID <= 1'b1;
        $display("[AXI-KV-RD] cycle=%0d araddr=0x%016h rdata=0x%08h beat=%0d last=%0b",
                 cycle_count, raddr_cur, rdata_cur, kv_axi_r_beats_sent,
                 (kv_axi_r_beats_sent == kv_axi_ar_len_latched));
      end else if (m_axi_kv_gmem_RVALID && m_axi_kv_gmem_RREADY) begin
        if (m_axi_kv_gmem_RLAST) begin
          m_axi_kv_gmem_RVALID <= 1'b0;
          m_axi_kv_gmem_RLAST  <= 1'b0;
          kv_axi_ar_active     <= 1'b0;
          kv_axi_r_beats_sent  <= 8'd0;
        end else begin
          m_axi_kv_gmem_RVALID <= 1'b0;
          kv_axi_r_beats_sent  <= kv_axi_r_beats_sent + 1'b1;
        end
      end
    end
  end

  // Track IRQ status and decoded done/error flags.
  always_ff @(posedge ap_clk) begin : IRQ_SHADOW_TRACKER
    if (!ap_rst_n) begin
      irq_ps_shadow <= 1'b0;
      irq_ps_prev   <= 1'b0;
    end else begin
      if ((irq_ps[0] === 1'b0) || (irq_ps[0] === 1'b1)) begin
        if (irq_ps !== irq_ps_prev) begin
          irq_ps_shadow <= irq_ps;
          irq_ps_prev   <= irq_ps;
        end
      end
    end
  end

  always_ff @(posedge ap_clk) begin : IRQ_TRACKER
    if (!ap_rst_n) begin
      irq_pending <= 1'b0;
      irq_seen_done <= 1'b0;
      irq_seen_error <= 1'b0;
      error_code_lat <= 32'd0;
      status_mem_shadow <= '0;
    end else begin
      if (irq_ps_shadow[0]) begin
        irq_pending <= 1'b1;
      end
      if (axi_read_valid) begin
        case (axi_addr)
          ADDR_STATUS_MEM_DATA_0: status_mem_shadow.status <= axi_rdata;
          ADDR_STATUS_MEM_DATA_1: status_mem_shadow.irq_status <= axi_rdata;
          ADDR_STATUS_MEM_DATA_2: status_mem_shadow.error_code <= axi_rdata;
          ADDR_STATUS_MEM_DATA_3: status_mem_shadow.mmu_error_subcode <= axi_rdata;
          ADDR_STATUS_MEM_DATA_4: status_mem_shadow.layer_index <= axi_rdata;
          ADDR_STATUS_MEM_DATA_5: status_mem_shadow.head_index <= axi_rdata;
          ADDR_STATUS_MEM_DATA_6: status_mem_shadow.token_index <= axi_rdata;
          default: begin end
        endcase
      end
      if (axi_read_valid && (axi_addr == ADDR_STATUS_MEM_DATA_1)) begin
        if (axi_rdata[2]) irq_seen_done <= 1'b1;
        if (axi_rdata[1]) irq_seen_error <= 1'b1;
      end
      if (axi_read_valid && (axi_addr == ADDR_STATUS_MEM_DATA_2)) begin
        error_code_lat <= axi_rdata;
      end
      if (done_req_fire) begin
        irq_seen_done <= 1'b0;
      end
      if (error_req_fire && error_req_write) begin
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
      done_clear_release_pending <= 1'b0;
    end else begin
      done_req_valid <= 1'b0;
      done_req_write <= 1'b0;
      done_req_addr  <= ctrl_mem_addr(2);
      done_req_wdata <= 32'd0;
      if (done_clear_release_pending) begin
        done_req_valid <= 1'b1;
        done_req_write <= 1'b1;
        done_req_addr  <= ctrl_mem_addr(2); // irq_clear
        done_req_wdata <= 32'd0;
        if (done_req_fire) begin
          done_clear_release_pending <= 1'b0;
        end
      end else if (irq_seen_done) begin
        done_req_valid <= 1'b1;
        done_req_write <= 1'b1;
        done_req_addr  <= ctrl_mem_addr(2); // irq_clear
        done_req_wdata <= IRQ_INFER_DONE_BIT;
        if (done_req_fire) begin
          done_clear_release_pending <= 1'b1;
        end
      end
    end
  end

  always_ff @(posedge ap_clk) begin : TOKEN_MANAGER
    if (!ap_rst_n) begin
      current_stream_token <= 0;
      next_token_pending   <= 1'b0;
      launch_next_token    <= 1'b0;
    end else begin
      launch_next_token <= 1'b0;
      if (irq_seen_done && !next_token_pending && ((current_stream_token + 1) < total_stream_tokens)) begin
        next_token_pending <= 1'b1;
      end
      if (next_token_pending &&
          !irq_ps_shadow[0] && !irq_pending && !irq_seen_done && !irq_seen_error &&
          (ctrl_stage == CTRL_DONE) && (axi_state == AXI_IDLE) && (ctrl_gap_cycles == 0)) begin
        $display("[TOKEN-MANAGER] cycle=%0d launching next token: current=%0d next=%0d dbg_state=%0d status=0x%08h irq_ps_shadow=%0b irq_pending=%0b",
                 cycle_count, current_stream_token, current_stream_token + 1, dbg_state,
                 status_mem_shadow.status, irq_ps_shadow[0], irq_pending);
        current_stream_token <= current_stream_token + 1;
        load_stream_token(current_stream_token + 1);
        next_token_pending <= 1'b0;
        launch_next_token <= 1'b1;
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
      error_clear_release_pending <= 1'b0;
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
          error_req_wdata <= error_clear_release_pending ? 32'd0 : IRQ_ERROR_BIT;
          if (error_req_fire) begin
            if (error_clear_release_pending) begin
              error_clear_release_pending <= 1'b0;
              err_phase <= ERR_PHASE_READ;
            end else begin
              error_clear_release_pending <= 1'b1;
            end
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
    end else if (launch_next_token) begin
      $display("[START-FSM] cycle=%0d relaunch token=%0d -> ctrl_stage=%s dbg_state=%0d status=0x%08h",
               cycle_count, current_stream_token + 1,
               "CTRL_RELAUNCH_PREP",
               dbg_state, status_mem_shadow.status);
      ctrl_stage <= CTRL_RELAUNCH_PREP;
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
          prog_word_idx = ctrl_prog_word_idx(base_assign_step);
          ctrl_addr <= ctrl_mem_addr(prog_word_idx);
          ctrl_data_in <= ctrl_init_words[prog_word_idx];
          ctrl_words[prog_word_idx] <= ctrl_init_words[prog_word_idx];
          if (base_assign_step >= (CTRL_MEM_WORDS - 2)) begin
            ctrl_stage <= TB_DEBUG_MODE ? CTRL_ASSERT_DEBUG_MODE : CTRL_ASSERT_TOKEN_INDEX;
          end else begin
            base_assign_step <= base_assign_step + 1;
          end
          ctrl_gap_cycles <= 2;
        end
        CTRL_RELAUNCH_PREP: begin
          $display("[CTRL] cycle=%0d token=%0d write control(relaunch-prep)=0x%08h dbg_state=%0d status=0x%08h",
                   cycle_count, current_stream_token, CTRL_RESETN_BIT | ctrl_debug_bits(),
                   dbg_state, status_mem_shadow.status);
          ctrl_addr <= ctrl_mem_addr(0);
          ctrl_data_in <= CTRL_RESETN_BIT | ctrl_debug_bits();
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_shadow_control <= CTRL_RESETN_BIT | ctrl_debug_bits();
          ctrl_words[0] <= CTRL_RESETN_BIT | ctrl_debug_bits();
          ctrl_stage <= TB_DEBUG_MODE ? CTRL_ASSERT_DEBUG_MODE : CTRL_ASSERT_TOKEN_INDEX;
          ctrl_gap_cycles <= CTRL_CTRL_GAP_CYCLES;
        end
        CTRL_ASSERT_DEBUG_MODE: begin
          $display("[CTRL] cycle=%0d token=%0d write control(debug)=0x%08h",
                   cycle_count, current_stream_token, CTRL_RESETN_BIT | ctrl_debug_bits());
          ctrl_addr <= ctrl_mem_addr(0);
          ctrl_data_in <= CTRL_RESETN_BIT | ctrl_debug_bits();
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_shadow_control <= CTRL_RESETN_BIT | ctrl_debug_bits();
          ctrl_words[0] <= CTRL_RESETN_BIT | ctrl_debug_bits();
          ctrl_stage <= CTRL_ASSERT_TOKEN_INDEX;
          ctrl_gap_cycles <= CTRL_CTRL_GAP_CYCLES;
        end
        CTRL_ASSERT_TOKEN_INDEX: begin
          $display("[CTRL] cycle=%0d token=%0d write token_position=%0d",
                   cycle_count, current_stream_token, current_stream_token);
          ctrl_addr <= ctrl_mem_addr(CTRLW_TOKEN_POSITION);
          ctrl_data_in <= current_stream_token[31:0];
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_words[CTRLW_TOKEN_POSITION] <= current_stream_token[31:0];
          ctrl_stage <= CTRL_ASSERT_START;
          ctrl_gap_cycles <= CTRL_CTRL_GAP_CYCLES;
        end
        CTRL_ASSERT_START: begin
          $display("[CTRL] cycle=%0d token=%0d write control(start)=0x%08h dbg_state=%0d status=0x%08h",
                   cycle_count, current_stream_token,
                   CTRL_RESETN_BIT | CTRL_START_BIT | ctrl_debug_bits(),
                   dbg_state, status_mem_shadow.status);
          ctrl_addr <= ctrl_mem_addr(0);
          ctrl_data_in <= CTRL_RESETN_BIT | CTRL_START_BIT | ctrl_debug_bits();
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_shadow_control <= CTRL_RESETN_BIT | CTRL_START_BIT | ctrl_debug_bits();
          ctrl_words[0] <= CTRL_RESETN_BIT | CTRL_START_BIT | ctrl_debug_bits();
          ctrl_stage <= (current_stream_token == 0) ? CTRL_ASSERT_AP_START : CTRL_HOLD_START;
          ctrl_gap_cycles <= CTRL_CTRL_GAP_CYCLES;
        end
        CTRL_ASSERT_AP_START: begin
          $display("[CTRL] cycle=%0d token=%0d write ap_start=0x00000081 dbg_state=%0d status=0x%08h",
                   cycle_count, current_stream_token, dbg_state, status_mem_shadow.status);
          ctrl_addr <= ADDR_AP_CTRL;
          ctrl_data_in <= 32'h0000_0081;
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_stage <= CTRL_HOLD_START;
          ctrl_gap_cycles <= CTRL_CTRL_GAP_CYCLES;
        end
        CTRL_HOLD_START: begin
          $display("[CTRL] cycle=%0d token=%0d hold control(start)=0x%08h dbg_state=%0d status=0x%08h",
                   cycle_count, current_stream_token,
                   CTRL_RESETN_BIT | CTRL_START_BIT | ctrl_debug_bits(),
                   dbg_state, status_mem_shadow.status);
          ctrl_stage <= CTRL_CLEAR_START;
          ctrl_gap_cycles <= CTRL_START_HOLD_CYCLES;
        end
        CTRL_CLEAR_START: begin
          $display("[CTRL] cycle=%0d token=%0d write control(clear-start)=0x%08h dbg_state=%0d status=0x%08h",
                   cycle_count, current_stream_token, CTRL_RESETN_BIT | ctrl_debug_bits(),
                   dbg_state, status_mem_shadow.status);
          ctrl_addr <= ctrl_mem_addr(0);
          ctrl_data_in <= CTRL_RESETN_BIT | ctrl_debug_bits();
          ctrl_write_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          ctrl_shadow_control <= CTRL_RESETN_BIT | ctrl_debug_bits();
          ctrl_words[0] <= CTRL_RESETN_BIT | ctrl_debug_bits();
          ctrl_stage <= CTRL_DONE;
          ctrl_gap_cycles <= CTRL_CTRL_GAP_CYCLES;
        end
        CTRL_DONE: begin
          ctrl_addr <= status_mem_addr(status_poll_idx);
          ctrl_read_en <= 1'b1;
          ctrl_chip_en <= 1'b1;
          status_poll_idx <= (status_poll_idx == 3'd6) ? 3'd0 : (status_poll_idx + 3'd1);
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
    if (irq_seen_done && ((current_stream_token + 1) >= total_stream_tokens)) begin
      $finish;
    end

    if (cycle_count > MAX_CYCLES) begin
      $finish;
    end

  end

  // Print debug mirror updates when DUT marks outputs valid.
  always_ff @(posedge ap_clk) begin : p_debug_vld_monitor
    if (!ap_rst_n) begin
      dbg_state_prev <= 32'd0;
      control_reg_prev <= 32'd0;
    end else begin
      if (dbg_state != dbg_state_prev) begin
        $display("[DBG-STATE] cycle=%0d token=%0d dbg_state %0d -> %0d status=0x%08h irq=0x%08h error=0x%08h",
                 cycle_count, current_stream_token, dbg_state_prev, dbg_state,
                 status_mem_shadow.status, status_mem_shadow.irq_status, status_mem_shadow.error_code);
        dbg_state_prev <= dbg_state;
      end
      if (ctrl_words[CTRLW_CONTROL] != control_reg_prev) begin
        $display("[CONTROL-REG] cycle=%0d token=%0d control_reg 0x%08h -> 0x%08h",
                 cycle_count, current_stream_token, control_reg_prev, ctrl_words[CTRLW_CONTROL]);
        control_reg_prev <= ctrl_words[CTRLW_CONTROL];
      end
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

    for (i = 0; i < STREAM_IN_FILE_BYTES_MAX; i = i + 1) begin
      stream_in_file_bytes[i] = 8'h00;
    end
    for (i = 0; i < STREAM_IN_BUF_BYTES; i = i + 1) begin
      stream_in_mem[i] = 8'h00;
    end
    for (i = 0; i < CTRL_MEM_WORDS; i = i + 1) begin
      ctrl_words[i] = 32'h0000_0000;
      ctrl_init_words[i] = 32'h0000_0000;
    end
    for (i = 0; i < (CTRL_MEM_WORDS*4); i = i + 1) begin
      ctrl_mem_file_bytes[i] = 8'h00;
    end
    for (i = 0; i < STREAM_OUT_BUF_BYTES; i = i + 1) begin
      stream_out_mem[i] = 8'h00;
    end
    for (i = 0; i < TOP_DMA_BUF_WORDS; i = i + 1) begin
      dma_rx_mem[i] = 32'h0000_0000;
      dma_tx_mem[i] = 32'h0000_0000;
    end
    for (i = 0; i < 'h43000; i = i + 1) begin
      ddr_image_bytes[i] = 8'h00;
    end

    file_fd = $fopen("/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/test_data/ctrl_mem.bin", "rb");
    if (file_fd == 0) begin
      $fatal(1, "Failed to open ctrl_mem.bin");
    end
    bytes_read = $fread(ctrl_mem_file_bytes, file_fd);
    $fclose(file_fd);
    if (bytes_read <= 0) begin
      $fatal(1, "Failed to read ctrl_mem.bin");
    end
    for (i = 0; i < CTRL_MEM_WORDS; i = i + 1) begin
      ctrl_init_words[i] = {ctrl_mem_file_bytes[(i*4)+3],
                            ctrl_mem_file_bytes[(i*4)+2],
                            ctrl_mem_file_bytes[(i*4)+1],
                            ctrl_mem_file_bytes[(i*4)+0]};
    end

    file_fd = $fopen("/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/test_data/stream_in.bin", "rb");
    if (file_fd == 0) begin
      $fatal(1, "Failed to open stream_in.bin");
    end
    bytes_read = $fread(stream_in_file_bytes, file_fd);
    $fclose(file_fd);
    if (bytes_read <= 0) begin
      $fatal(1, "Failed to read stream_in.bin");
    end
    if (bytes_read > STREAM_IN_FILE_BYTES_MAX) begin
      $fatal(1, "stream_in.bin too large for testbench buffer");
    end
    if ((bytes_read % STREAM_IN_BUF_BYTES) != 0) begin
      $fatal(1, "stream_in.bin size is not a whole number of tokens");
    end
    total_stream_tokens = bytes_read / STREAM_IN_BUF_BYTES;
    if (total_stream_tokens <= 0) begin
      $fatal(1, "stream_in.bin contains zero tokens");
    end
    load_stream_token(0);

    file_fd = $fopen("/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/test_data/ddr_image.bin", "rb");
    if (file_fd == 0) begin
      $fatal(1, "Failed to open ddr_image.bin");
    end
    bytes_read = $fread(ddr_image_bytes, file_fd);
    $fclose(file_fd);
    if (bytes_read <= 0) begin
      $fatal(1, "Failed to read ddr_image.bin");
    end
    for (i = 0; i < RAM_REGION_WORDS; i = i + 1) begin
      wq_ram[i] = load_image_word(IMG_BASE_WQ + (i * 4));
      wk_ram[i] = load_image_word(IMG_BASE_WK + (i * 4));
      wv_ram[i] = load_image_word(IMG_BASE_WV + (i * 4));
      wo_ram[i] = load_image_word(IMG_BASE_WO + (i * 4));
      w1_ram[i] = load_image_word(IMG_BASE_W1 + (i * 4));
      w2_ram[i] = load_image_word(IMG_BASE_W2 + (i * 4));
      wlogit_ram[i] = load_image_word(IMG_BASE_WVOCAB + (i * 4));
      wo_bias_ram[i] = load_image_word(IMG_BASE_WO_BIAS + (i * 4));
      w1_bias_ram[i] = load_image_word(IMG_BASE_W1_BIAS + (i * 4));
      w2_bias_ram[i] = load_image_word(IMG_BASE_W2_BIAS + (i * 4));
      ln0_gamma_ram[i] = load_image_word(IMG_BASE_LN0_GAMMA + (i * 4));
      ln1_gamma_ram[i] = load_image_word(IMG_BASE_LN1_GAMMA + (i * 4));
      final_norm_gamma_ram[i] = load_image_word(IMG_BASE_FINAL_NORM_GAMMA + (i * 4));
      ln0_eps_ram[i] = load_image_word(IMG_BASE_LN0_EPS + (i * 4));
      ln1_eps_ram[i] = load_image_word(IMG_BASE_LN1_EPS + (i * 4));
      final_norm_eps_ram[i] = load_image_word(IMG_BASE_FINAL_NORM_EPS + (i * 4));
    end
    for (i = 0; i < KV_STORE_WORDS; i = i + 1) begin
      k_cache_store[i] = 32'h0000_0000;
      v_cache_store[i] = 32'h0000_0000;
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
    .m_axi_kv_gmem_AWVALID(m_axi_kv_gmem_AWVALID),
    .m_axi_kv_gmem_AWREADY(m_axi_kv_gmem_AWREADY),
    .m_axi_kv_gmem_AWADDR(m_axi_kv_gmem_AWADDR),
    .m_axi_kv_gmem_AWID(m_axi_kv_gmem_AWID),
    .m_axi_kv_gmem_AWLEN(m_axi_kv_gmem_AWLEN),
    .m_axi_kv_gmem_AWSIZE(m_axi_kv_gmem_AWSIZE),
    .m_axi_kv_gmem_AWBURST(m_axi_kv_gmem_AWBURST),
    .m_axi_kv_gmem_AWLOCK(m_axi_kv_gmem_AWLOCK),
    .m_axi_kv_gmem_AWCACHE(m_axi_kv_gmem_AWCACHE),
    .m_axi_kv_gmem_AWPROT(m_axi_kv_gmem_AWPROT),
    .m_axi_kv_gmem_AWQOS(m_axi_kv_gmem_AWQOS),
    .m_axi_kv_gmem_AWREGION(m_axi_kv_gmem_AWREGION),
    .m_axi_kv_gmem_AWUSER(m_axi_kv_gmem_AWUSER),
    .m_axi_kv_gmem_WVALID(m_axi_kv_gmem_WVALID),
    .m_axi_kv_gmem_WREADY(m_axi_kv_gmem_WREADY),
    .m_axi_kv_gmem_WDATA(m_axi_kv_gmem_WDATA),
    .m_axi_kv_gmem_WSTRB(m_axi_kv_gmem_WSTRB),
    .m_axi_kv_gmem_WLAST(m_axi_kv_gmem_WLAST),
    .m_axi_kv_gmem_WID(m_axi_kv_gmem_WID),
    .m_axi_kv_gmem_WUSER(m_axi_kv_gmem_WUSER),
    .m_axi_kv_gmem_ARVALID(m_axi_kv_gmem_ARVALID),
    .m_axi_kv_gmem_ARREADY(m_axi_kv_gmem_ARREADY),
    .m_axi_kv_gmem_ARADDR(m_axi_kv_gmem_ARADDR),
    .m_axi_kv_gmem_ARID(m_axi_kv_gmem_ARID),
    .m_axi_kv_gmem_ARLEN(m_axi_kv_gmem_ARLEN),
    .m_axi_kv_gmem_ARSIZE(m_axi_kv_gmem_ARSIZE),
    .m_axi_kv_gmem_ARBURST(m_axi_kv_gmem_ARBURST),
    .m_axi_kv_gmem_ARLOCK(m_axi_kv_gmem_ARLOCK),
    .m_axi_kv_gmem_ARCACHE(m_axi_kv_gmem_ARCACHE),
    .m_axi_kv_gmem_ARPROT(m_axi_kv_gmem_ARPROT),
    .m_axi_kv_gmem_ARQOS(m_axi_kv_gmem_ARQOS),
    .m_axi_kv_gmem_ARREGION(m_axi_kv_gmem_ARREGION),
    .m_axi_kv_gmem_ARUSER(m_axi_kv_gmem_ARUSER),
    .m_axi_kv_gmem_RVALID(m_axi_kv_gmem_RVALID),
    .m_axi_kv_gmem_RREADY(m_axi_kv_gmem_RREADY),
    .m_axi_kv_gmem_RDATA(m_axi_kv_gmem_RDATA),
    .m_axi_kv_gmem_RLAST(m_axi_kv_gmem_RLAST),
    .m_axi_kv_gmem_RID(m_axi_kv_gmem_RID),
    .m_axi_kv_gmem_RUSER(m_axi_kv_gmem_RUSER),
    .m_axi_kv_gmem_RRESP(m_axi_kv_gmem_RRESP),
    .m_axi_kv_gmem_BVALID(m_axi_kv_gmem_BVALID),
    .m_axi_kv_gmem_BREADY(m_axi_kv_gmem_BREADY),
    .m_axi_kv_gmem_BRESP(m_axi_kv_gmem_BRESP),
    .m_axi_kv_gmem_BID(m_axi_kv_gmem_BID),
    .m_axi_kv_gmem_BUSER(m_axi_kv_gmem_BUSER),
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
    .interrupt(),
    .s_axi_control_r_AWVALID(s_axi_control_r_AWVALID),
    .s_axi_control_r_AWREADY(s_axi_control_r_AWREADY),
    .s_axi_control_r_AWADDR(s_axi_control_r_AWADDR),
    .s_axi_control_r_WVALID(s_axi_control_r_WVALID),
    .s_axi_control_r_WREADY(s_axi_control_r_WREADY),
    .s_axi_control_r_WDATA(s_axi_control_r_WDATA),
    .s_axi_control_r_WSTRB(s_axi_control_r_WSTRB),
    .s_axi_control_r_ARVALID(s_axi_control_r_ARVALID),
    .s_axi_control_r_ARREADY(s_axi_control_r_ARREADY),
    .s_axi_control_r_ARADDR(s_axi_control_r_ARADDR),
    .s_axi_control_r_RVALID(s_axi_control_r_RVALID),
    .s_axi_control_r_RREADY(s_axi_control_r_RREADY),
    .s_axi_control_r_RDATA(s_axi_control_r_RDATA),
    .s_axi_control_r_RRESP(s_axi_control_r_RRESP),
    .s_axi_control_r_BVALID(s_axi_control_r_BVALID),
    .s_axi_control_r_BREADY(s_axi_control_r_BREADY),
    .s_axi_control_r_BRESP(s_axi_control_r_BRESP)
  );

endmodule
