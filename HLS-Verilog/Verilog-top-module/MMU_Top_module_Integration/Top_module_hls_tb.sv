`timescale 1ns/1ps

module top_module_hls_tb;
  localparam int CLK_PERIOD_NS        = 10;
  localparam int MAX_CYCLES           = 50000;
  localparam int CTRL_MEM_WORDS       = 76;
  localparam int DBG_CTRL_MEM_WORDS   = 74;
  localparam int STREAM_IN_BUF_BYTES  = 16;
  localparam int STREAM_OUT_BUF_BYTES = 64;
  localparam int TOP_DMA_BUF_WORDS    = 16384;
  localparam int KV_STORE_WORDS       = 131072;
  localparam int DMA_LATENCY_CYCLES   = 4;
  localparam int STREAM_LATENCY_CYCLES = 6;
  localparam int CTRL_START_HOLD_CYCLES = 24;
  localparam int RAM_REGION_WORDS      = 65536;

  localparam logic [8:0] ADDR_AP_CTRL         = 9'h000;
  localparam logic [8:0] ADDR_CTRL_MEM_DATA_0 = 9'h010;
  localparam logic [8:0] ADDR_STATUS_MEM_DATA_0 = 9'h144;
  localparam logic [8:0] ADDR_STATUS_MEM_DATA_1 = 9'h148;
  localparam logic [8:0] ADDR_STATUS_MEM_DATA_2 = 9'h14C;

  localparam logic [31:0] CTRL_RESETN_BIT = 32'h0000_0001;
  localparam logic [31:0] CTRL_START_BIT  = 32'h0000_0002;

  // Debug struct mirrors copied from the working integrated TB format.
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
  } compute_head_ctx_t;

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
    logic [31:0] logit_scale_qv;
    logic [31:0] scale_q;
    logic [31:0] zero_point_q;
    logic [31:0] scale_k;
    logic [31:0] zero_point_k;
    logic [31:0] scale_v;
    logic [31:0] zero_point_v;
  } dbg_control_mem_t;

  logic ap_clk;
  logic ap_rst_n;

  logic [0:0] axis_in_valid;
  logic [0:0] axis_in_last;
  logic [0:0] axis_in_ready;

  logic [0:0] stream_ready;
  logic [0:0] stream_start_i;
  logic [0:0] stream_done;

  logic [0:0] dma_ready;
  logic [0:0] dma_done;

  logic [7:0]  stream_in_buf_q0;
  logic [31:0] dma_rx_buf_q0;

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

  logic       axis_in_ready_ap_vld;

  logic [0:0] stream_start_o;
  logic       stream_start_o_ap_vld;
  logic [3:0] stream_in_buf_address0;
  logic       stream_in_buf_ce0;
  logic [5:0] stream_out_buf_address0;
  logic       stream_out_buf_ce0;
  logic       stream_out_buf_we0;
  logic [7:0] stream_out_buf_d0;

  logic [13:0] dma_rx_buf_address0;
  logic        dma_rx_buf_ce0;
  logic [13:0] dma_tx_buf_address0;
  logic        dma_tx_buf_ce0;
  logic        dma_tx_buf_we0;
  logic [31:0] dma_tx_buf_d0;

  logic [0:0] dma_start;
  logic       dma_start_ap_vld;
  logic [31:0] dma_addr;
  logic       dma_addr_ap_vld;
  logic [31:0] dma_len;
  logic       dma_len_ap_vld;
  logic [0:0] dma_is_write;
  logic       dma_is_write_ap_vld;

  logic [0:0] irq_ps;
  logic [31:0] dbg_state;
  logic       dbg_state_ap_vld;
  logic [2367:0] dbg_ctrl_mem;
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

  wire [1:0]   dbg_head_ctx_ref_address0;
  wire         dbg_head_ctx_ref_ce0;
  wire         dbg_head_ctx_ref_we0;
  wire [214:0] dbg_head_ctx_ref_d0;
  logic [214:0] dbg_head_ctx_ref_q0;
  wire [1:0]   dbg_head_ctx_ref_address1;
  wire         dbg_head_ctx_ref_ce1;
  wire         dbg_head_ctx_ref_we1;
  wire [214:0] dbg_head_ctx_ref_d1;
  logic [214:0] dbg_head_ctx_ref_q1;

  wire [0:0]   dbg_head_compute_ctx_address0;
  wire         dbg_head_compute_ctx_ce0;
  wire         dbg_head_compute_ctx_we0;
  wire [148:0] dbg_head_compute_ctx_d0;
  logic [148:0] dbg_head_compute_ctx_q0;
  wire [0:0]   dbg_head_compute_ctx_address1;
  wire         dbg_head_compute_ctx_ce1;
  wire         dbg_head_compute_ctx_we1;
  wire [148:0] dbg_head_compute_ctx_d1;
  logic [148:0] dbg_head_compute_ctx_q1;

  wire [6:0] dbg_in_buf_address0;
  wire       dbg_in_buf_ce0;
  wire       dbg_in_buf_we0;
  wire [7:0] dbg_in_buf_d0;
  logic [7:0] dbg_in_buf_q0;
  wire [6:0] dbg_in_buf_address1;
  wire       dbg_in_buf_ce1;
  wire       dbg_in_buf_we1;
  wire [7:0] dbg_in_buf_d1;
  logic [7:0] dbg_in_buf_q1;

  wire [5:0] dbg_out_buf_address0;
  wire       dbg_out_buf_ce0;
  wire       dbg_out_buf_we0;
  wire [7:0] dbg_out_buf_d0;
  logic [7:0] dbg_out_buf_q0;
  wire [5:0] dbg_out_buf_address1;
  wire       dbg_out_buf_ce1;
  wire       dbg_out_buf_we1;
  wire [7:0] dbg_out_buf_d1;
  logic [7:0] dbg_out_buf_q1;

  wire [7:0] dbg_head_in_buf_address0;
  wire       dbg_head_in_buf_ce0;
  wire       dbg_head_in_buf_we0;
  wire [7:0] dbg_head_in_buf_d0;
  logic [7:0] dbg_head_in_buf_q0;
  wire [7:0] dbg_head_in_buf_address1;
  wire       dbg_head_in_buf_ce1;
  wire       dbg_head_in_buf_we1;
  wire [7:0] dbg_head_in_buf_d1;
  logic [7:0] dbg_head_in_buf_q1;

  wire [6:0] dbg_head_out_buf_address0;
  wire       dbg_head_out_buf_ce0;
  wire       dbg_head_out_buf_we0;
  wire [7:0] dbg_head_out_buf_d0;
  logic [7:0] dbg_head_out_buf_q0;
  wire [6:0] dbg_head_out_buf_address1;
  wire       dbg_head_out_buf_ce1;
  wire       dbg_head_out_buf_we1;
  wire [7:0] dbg_head_out_buf_d1;
  logic [7:0] dbg_head_out_buf_q1;

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
  logic [214:0] dbg_head_ctx_mem [0:3];
  logic [148:0] dbg_head_compute_ctx_mem [0:1];
  head_ctx_t dbg_head_ctx_shadow [0:3];
  compute_head_ctx_t dbg_head_compute_ctx_shadow [0:1];
  logic [7:0] dbg_in_buf_mem [0:127];
  logic [7:0] dbg_out_buf_mem [0:63];
  logic [7:0] dbg_head_in_buf_mem [0:255];
  logic [7:0] dbg_head_out_buf_mem [0:127];

  integer cycle_count;
  integer dma_countdown;
  integer stream_countdown;
  integer i;

  logic dma_busy;
  logic stream_busy;
  logic axis_packet_sent;
  logic stream_fill_active;
  logic [$clog2(STREAM_IN_BUF_BYTES+1)-1:0] stream_fill_idx;

  logic [31:0] dma_addr_latched;
  logic [31:0] dma_len_latched;
  logic [0:0]  dma_is_write_latched;

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
  localparam int CTRLW_LOGIT_SCALE_QV     = 68;
  localparam int CTRLW_SCALE_Q            = 69;
  localparam int CTRLW_ZERO_POINT_Q       = 70;
  localparam int CTRLW_SCALE_K            = 71;
  localparam int CTRLW_ZERO_POINT_K       = 72;
  localparam int CTRLW_SCALE_V            = 73;
  localparam int CTRLW_ZERO_POINT_V       = 74;

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
    input [31:0] base_addr,
    input int unsigned word_idx
  );
    dma_pattern_word = base_addr ^ (32'h1357_0000 + word_idx);
  endfunction

  function automatic [8:0] ctrl_mem_addr(input int word_idx);
    ctrl_mem_addr = ADDR_CTRL_MEM_DATA_0 + (word_idx * 4);
  endfunction

  function automatic bit is_k_cache_addr(input [31:0] addr);
    is_k_cache_addr = (addr >= ctrl_words[CTRLW_K_CACHE_LO]) && (addr < (ctrl_words[CTRLW_K_CACHE_LO] + 32'h0100_0000));
  endfunction

  function automatic bit is_v_cache_addr(input [31:0] addr);
    is_v_cache_addr = (addr >= ctrl_words[CTRLW_V_CACHE_LO]) && (addr < (ctrl_words[CTRLW_V_CACHE_LO] + 32'h0100_0000));
  endfunction

  function automatic bit is_wq_addr(input [31:0] addr);
    is_wq_addr = (addr >= ctrl_words[CTRLW_WQ_BASE_LO]) && (addr < (ctrl_words[CTRLW_WQ_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic bit is_wk_addr(input [31:0] addr);
    is_wk_addr = (addr >= ctrl_words[CTRLW_WK_BASE_LO]) && (addr < (ctrl_words[CTRLW_WK_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic bit is_wv_addr(input [31:0] addr);
    is_wv_addr = (addr >= ctrl_words[CTRLW_WV_BASE_LO]) && (addr < (ctrl_words[CTRLW_WV_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic bit is_wo_addr(input [31:0] addr);
    is_wo_addr = (addr >= ctrl_words[CTRLW_WO_BASE_LO]) && (addr < (ctrl_words[CTRLW_WO_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic bit is_w1_addr(input [31:0] addr);
    is_w1_addr = (addr >= ctrl_words[CTRLW_W1_BASE_LO]) && (addr < (ctrl_words[CTRLW_W1_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic bit is_w2_addr(input [31:0] addr);
    is_w2_addr = (addr >= ctrl_words[CTRLW_W2_BASE_LO]) && (addr < (ctrl_words[CTRLW_W2_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic bit is_ln0_gamma_addr(input [31:0] addr);
    is_ln0_gamma_addr = (addr >= ctrl_words[CTRLW_LN0_GAMMA_BASE_LO]) && (addr < (ctrl_words[CTRLW_LN0_GAMMA_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic bit is_ln1_gamma_addr(input [31:0] addr);
    is_ln1_gamma_addr = (addr >= ctrl_words[CTRLW_LN1_GAMMA_BASE_LO]) && (addr < (ctrl_words[CTRLW_LN1_GAMMA_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic bit is_ln0_eps_addr(input [31:0] addr);
    is_ln0_eps_addr = (addr >= ctrl_words[CTRLW_LN0_EPS_BASE_LO]) && (addr < (ctrl_words[CTRLW_LN0_EPS_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic bit is_ln1_eps_addr(input [31:0] addr);
    is_ln1_eps_addr = (addr >= ctrl_words[CTRLW_LN1_EPS_BASE_LO]) && (addr < (ctrl_words[CTRLW_LN1_EPS_BASE_LO] + (RAM_REGION_WORDS << 2)));
  endfunction

  function automatic int unsigned region_index(
    input [31:0] base_addr,
    input int unsigned word_idx
  );
    logic [31:0] byte_addr;
    begin
      byte_addr = base_addr + (word_idx << 2);
      region_index = byte_addr[17:2];
    end
  endfunction

  function automatic int unsigned kv_store_index(
    input [31:0] base_addr,
    input int unsigned word_idx
  );
    logic [31:0] byte_addr;
    begin
      byte_addr = base_addr + (word_idx << 2);
      kv_store_index = byte_addr[18:2];
    end
  endfunction

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



  // Stream-in memory read response for DUT stream_in_buf interface.
  always_comb begin : p_stream_in_mem_read
    stream_in_buf_q0 = 8'h00;
    if (stream_in_buf_ce0) begin
      stream_in_buf_q0 = stream_in_mem[stream_in_buf_address0];
    end
  end

  // DMA read memory response for DUT dma_rx_buf interface.
  always_comb begin : p_dma_rx_mem_read
    dma_rx_buf_q0 = 32'h0000_0000;
    if (dma_rx_buf_ce0) begin
      dma_rx_buf_q0 = dma_rx_mem[dma_rx_buf_address0];
    end
  end

  // Debug memory model for dbg_head_ctx_ref dual-port interface.
  always_comb begin : p_dbg_head_ctx_mem_read
    dbg_head_ctx_ref_q0 = '0;
    dbg_head_ctx_ref_q1 = '0;
    if (dbg_head_ctx_ref_ce0) begin
      dbg_head_ctx_ref_q0 = dbg_head_ctx_mem[dbg_head_ctx_ref_address0];
    end
    if (dbg_head_ctx_ref_ce1) begin
      dbg_head_ctx_ref_q1 = dbg_head_ctx_mem[dbg_head_ctx_ref_address1];
    end
  end

  // Debug memory model for dbg_head_compute_ctx dual-port interface.
  always_comb begin : p_dbg_head_compute_ctx_mem_read
    dbg_head_compute_ctx_q0 = '0;
    dbg_head_compute_ctx_q1 = '0;
    if (dbg_head_compute_ctx_ce0) begin
      dbg_head_compute_ctx_q0 = dbg_head_compute_ctx_mem[dbg_head_compute_ctx_address0];
    end
    if (dbg_head_compute_ctx_ce1) begin
      dbg_head_compute_ctx_q1 = dbg_head_compute_ctx_mem[dbg_head_compute_ctx_address1];
    end
  end

  // (moved to ctx_shadow_latch)

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
    dbg_ctrl_mem_shadow.logit_scale_qv          = dbg_ctrl_words[67];
    dbg_ctrl_mem_shadow.scale_q                 = dbg_ctrl_words[68];
    dbg_ctrl_mem_shadow.zero_point_q            = dbg_ctrl_words[69];
    dbg_ctrl_mem_shadow.scale_k                 = dbg_ctrl_words[70];
    dbg_ctrl_mem_shadow.zero_point_k            = dbg_ctrl_words[71];
    dbg_ctrl_mem_shadow.scale_v                 = dbg_ctrl_words[72];
    dbg_ctrl_mem_shadow.zero_point_v            = dbg_ctrl_words[73];
  end

  // Debug memory model for dbg_in_buf dual-port interface.
  always_comb begin : p_dbg_in_buf_mem_read
    dbg_in_buf_q0 = 8'h00;
    dbg_in_buf_q1 = 8'h00;
    if (dbg_in_buf_ce0) begin
      dbg_in_buf_q0 = dbg_in_buf_mem[dbg_in_buf_address0];
    end
    if (dbg_in_buf_ce1) begin
      dbg_in_buf_q1 = dbg_in_buf_mem[dbg_in_buf_address1];
    end
  end

  // Debug memory model for dbg_out_buf dual-port interface.
  always_comb begin : p_dbg_out_buf_mem_read
    dbg_out_buf_q0 = 8'h00;
    dbg_out_buf_q1 = 8'h00;
    if (dbg_out_buf_ce0) begin
      dbg_out_buf_q0 = dbg_out_buf_mem[dbg_out_buf_address0];
    end
    if (dbg_out_buf_ce1) begin
      dbg_out_buf_q1 = dbg_out_buf_mem[dbg_out_buf_address1];
    end
  end

  // Debug memory model for dbg_head_in_buf dual-port interface.
  always_comb begin : p_dbg_head_in_buf_mem_read
    dbg_head_in_buf_q0 = 8'h00;
    dbg_head_in_buf_q1 = 8'h00;
    if (dbg_head_in_buf_ce0) begin
      dbg_head_in_buf_q0 = dbg_head_in_buf_mem[dbg_head_in_buf_address0];
    end
    if (dbg_head_in_buf_ce1) begin
      dbg_head_in_buf_q1 = dbg_head_in_buf_mem[dbg_head_in_buf_address1];
    end
  end

  // Debug memory model for dbg_head_out_buf dual-port interface.
  always_comb begin : p_dbg_head_out_buf_mem_read
    dbg_head_out_buf_q0 = 8'h00;
    dbg_head_out_buf_q1 = 8'h00;
    if (dbg_head_out_buf_ce0) begin
      dbg_head_out_buf_q0 = dbg_head_out_buf_mem[dbg_head_out_buf_address0];
    end
    if (dbg_head_out_buf_ce1) begin
      dbg_head_out_buf_q1 = dbg_head_out_buf_mem[dbg_head_out_buf_address1];
    end
  end

  // Capture stream-out payload written by DUT.
  always_ff @(posedge ap_clk) begin : p_stream_out_capture
    if (stream_out_buf_ce0 && stream_out_buf_we0) begin
      stream_out_mem[stream_out_buf_address0] <= stream_out_buf_d0;
    end
  end

  // Capture DMA writeback payload written by DUT.
  always_ff @(posedge ap_clk) begin : p_dma_tx_capture
    if (dma_tx_buf_ce0 && dma_tx_buf_we0) begin
      dma_tx_mem[dma_tx_buf_address0] <= dma_tx_buf_d0;
    end
  end

  // Debug memory model writes for all dual-port debug interfaces.
  always_ff @(posedge ap_clk) begin : p_dbg_mem_writes
    if (dbg_head_ctx_ref_ce0 && dbg_head_ctx_ref_we0) begin
      dbg_head_ctx_mem[dbg_head_ctx_ref_address0] <= dbg_head_ctx_ref_d0;
    end
    if (dbg_head_ctx_ref_ce1 && dbg_head_ctx_ref_we1) begin
      dbg_head_ctx_mem[dbg_head_ctx_ref_address1] <= dbg_head_ctx_ref_d1;
    end
    if (dbg_head_compute_ctx_ce0 && dbg_head_compute_ctx_we0) begin
      dbg_head_compute_ctx_mem[dbg_head_compute_ctx_address0] <= dbg_head_compute_ctx_d0;
    end
    if (dbg_head_compute_ctx_ce1 && dbg_head_compute_ctx_we1) begin
      dbg_head_compute_ctx_mem[dbg_head_compute_ctx_address1] <= dbg_head_compute_ctx_d1;
    end
    if (dbg_in_buf_ce0 && dbg_in_buf_we0) begin
      dbg_in_buf_mem[dbg_in_buf_address0] <= dbg_in_buf_d0;
    end
    if (dbg_in_buf_ce1 && dbg_in_buf_we1) begin
      dbg_in_buf_mem[dbg_in_buf_address1] <= dbg_in_buf_d1;
    end
    if (dbg_out_buf_ce0 && dbg_out_buf_we0) begin
      dbg_out_buf_mem[dbg_out_buf_address0] <= dbg_out_buf_d0;
    end
    if (dbg_out_buf_ce1 && dbg_out_buf_we1) begin
      dbg_out_buf_mem[dbg_out_buf_address1] <= dbg_out_buf_d1;
    end
    if (dbg_head_in_buf_ce0 && dbg_head_in_buf_we0) begin
      dbg_head_in_buf_mem[dbg_head_in_buf_address0] <= dbg_head_in_buf_d0;
    end
    if (dbg_head_in_buf_ce1 && dbg_head_in_buf_we1) begin
      dbg_head_in_buf_mem[dbg_head_in_buf_address1] <= dbg_head_in_buf_d1;
    end
    if (dbg_head_out_buf_ce0 && dbg_head_out_buf_we0) begin
      dbg_head_out_buf_mem[dbg_head_out_buf_address0] <= dbg_head_out_buf_d0;
    end
    if (dbg_head_out_buf_ce1 && dbg_head_out_buf_we1) begin
      dbg_head_out_buf_mem[dbg_head_out_buf_address1] <= dbg_head_out_buf_d1;
    end
  end

  // Latch debug context SRAM snapshots for easier debug inspection.
  always_ff @(posedge ap_clk) begin : ctx_shadow_latch
    if (!ap_rst_n) begin
      dbg_head_ctx_shadow[0] <= '0;
      dbg_head_ctx_shadow[1] <= '0;
      dbg_head_ctx_shadow[2] <= '0;
      dbg_head_ctx_shadow[3] <= '0;
      dbg_head_compute_ctx_shadow[0] <= '0;
      dbg_head_compute_ctx_shadow[1] <= '0;
    end else begin
      dbg_head_ctx_shadow[0] <= head_ctx_t'(dbg_head_ctx_mem[0]);
      dbg_head_ctx_shadow[1] <= head_ctx_t'(dbg_head_ctx_mem[1]);
      dbg_head_ctx_shadow[2] <= head_ctx_t'(dbg_head_ctx_mem[2]);
      dbg_head_ctx_shadow[3] <= head_ctx_t'(dbg_head_ctx_mem[3]);
      dbg_head_compute_ctx_shadow[0] <= compute_head_ctx_t'(dbg_head_compute_ctx_mem[0]);
      dbg_head_compute_ctx_shadow[1] <= compute_head_ctx_t'(dbg_head_compute_ctx_mem[1]);
    end
  end

  // Drive AXIS input pins from stream ingress state.
  always_comb begin : p_axis_ingress_outputs
    axis_in_valid = stream_fill_active;
    axis_in_last  = stream_fill_active && (stream_fill_idx == (STREAM_IN_BUF_BYTES-1));
  end

  // Build/drive stream-in beat traffic only when DUT requests ingress.
  always_ff @(posedge ap_clk) begin : axis_driver
    if (!ap_rst_n) begin
      axis_packet_sent   <= 1'b0;
      stream_fill_active <= 1'b0;
      stream_fill_idx    <= '0;
    end else begin
      // Start sending one packet once DUT asserts tready in STREAM_IN.
      if (!axis_packet_sent && !stream_fill_active && axis_in_ready[0]) begin
        stream_fill_active <= 1'b1;
        stream_fill_idx    <= '0;
        stream_in_mem[0]   <= 8'h10;
      end

      // Advance one beat per handshake; assert TLAST only on the final beat.
      if (stream_fill_active && axis_in_ready[0]) begin
        if (stream_fill_idx == (STREAM_IN_BUF_BYTES-1)) begin
          axis_packet_sent   <= 1'b1;
          stream_fill_active <= 1'b0;
          stream_fill_idx    <= '0;
        end else begin
          stream_in_mem[stream_fill_idx + 1'b1] <= 8'(8'h10 + stream_fill_idx[7:0] + 8'h01);
          stream_fill_idx <= stream_fill_idx + 1'b1;
        end
      end
    end
  end

  // Respond to stream_start by pulsing stream_done after fixed latency.
  always_ff @(posedge ap_clk) begin : stream_model
    int unsigned stream_checksum;
    int si;
    if (!ap_rst_n) begin
      stream_done     <= 1'b0;
      stream_busy     <= 1'b0;
      stream_countdown <= 0;
    end else begin
      stream_done <= 1'b0;
      if (!stream_busy && stream_start_o[0] && stream_ready[0]) begin
        stream_busy <= 1'b1;
        stream_countdown <= STREAM_LATENCY_CYCLES;
      end else if (stream_busy) begin
        if (stream_countdown > 0) begin
          stream_countdown <= stream_countdown - 1;
        end else begin
          stream_busy <= 1'b0;
          stream_done <= 1'b1;
          stream_checksum = 0;
          for (si = 0; si < STREAM_OUT_BUF_BYTES; si = si + 1) begin
            stream_checksum = stream_checksum + stream_out_mem[si];
          end
        end
      end
    end
  end

  // DMA handshake/timing model.
  always_ff @(posedge ap_clk) begin : DMA_HANDSHAKE
    if (!ap_rst_n) begin
      dma_done             <= 1'b0;
      dma_busy             <= 1'b0;
      dma_countdown        <= 0;
      dma_addr_latched     <= 32'h0;
      dma_len_latched      <= 32'h0;
      dma_is_write_latched <= 1'b0;
    end else begin
      dma_done <= 1'b0;
      if (!dma_busy && dma_start[0] && dma_ready[0]) begin
        dma_busy             <= 1'b1;
        dma_countdown        <= DMA_LATENCY_CYCLES;
        dma_addr_latched     <= dma_addr;
        dma_len_latched      <= dma_len;
        dma_is_write_latched <= dma_is_write;
      end else if (dma_busy) begin
        if (dma_countdown > 0) begin
          dma_countdown <= dma_countdown - 1;
        end else begin
          dma_busy <= 1'b0;
          dma_done <= 1'b1;
        end
      end
    end
  end

  // Populate DMA RX payload from RAM-style address-mapped memory.
  always_ff @(posedge ap_clk) begin : dma_rx_loader
    int unsigned requested_words;
    int unsigned slot;
    int idx;
    if (!ap_rst_n) begin
      for (idx = 0; idx < TOP_DMA_BUF_WORDS; idx = idx + 1) begin
        dma_rx_mem[idx] <= 32'h0;
      end
    end else if (!dma_busy && dma_start[0] && dma_ready[0] && !dma_is_write[0]) begin
      requested_words = (dma_len + 32'd3) >> 2;
      if (requested_words > TOP_DMA_BUF_WORDS) begin
        requested_words = TOP_DMA_BUF_WORDS;
      end
      for (idx = 0; idx < TOP_DMA_BUF_WORDS; idx = idx + 1) begin
        if (idx < requested_words) begin
          if (is_k_cache_addr(dma_addr)) begin
            slot = kv_store_index(dma_addr, idx);
            dma_rx_mem[idx] <= k_cache_store[slot];
          end else if (is_v_cache_addr(dma_addr)) begin
            slot = kv_store_index(dma_addr, idx);
            dma_rx_mem[idx] <= v_cache_store[slot];
          end else if (is_wq_addr(dma_addr)) begin
            dma_rx_mem[idx] <= wq_ram[region_index(dma_addr, idx)];
          end else if (is_wk_addr(dma_addr)) begin
            dma_rx_mem[idx] <= wk_ram[region_index(dma_addr, idx)];
          end else if (is_wv_addr(dma_addr)) begin
            dma_rx_mem[idx] <= wv_ram[region_index(dma_addr, idx)];
          end else if (is_wo_addr(dma_addr)) begin
            dma_rx_mem[idx] <= wo_ram[region_index(dma_addr, idx)];
          end else if (is_w1_addr(dma_addr)) begin
            dma_rx_mem[idx] <= w1_ram[region_index(dma_addr, idx)];
          end else if (is_w2_addr(dma_addr)) begin
            dma_rx_mem[idx] <= w2_ram[region_index(dma_addr, idx)];
          end else if (is_ln0_gamma_addr(dma_addr)) begin
            dma_rx_mem[idx] <= ln0_gamma_ram[region_index(dma_addr, idx)];
          end else if (is_ln1_gamma_addr(dma_addr)) begin
            dma_rx_mem[idx] <= ln1_gamma_ram[region_index(dma_addr, idx)];
          end else if (is_ln0_eps_addr(dma_addr)) begin
            dma_rx_mem[idx] <= ln0_eps_ram[region_index(dma_addr, idx)];
          end else if (is_ln1_eps_addr(dma_addr)) begin
            dma_rx_mem[idx] <= ln1_eps_ram[region_index(dma_addr, idx)];
          end else begin
            dma_rx_mem[idx] <= dma_pattern_word(dma_addr, idx);
          end
        end
      end
    end
  end

  // Consume DMA TX payload back into RAM model on write transactions.
  always_ff @(posedge ap_clk) begin : dma_tx_reader
    int unsigned commit_words;
    int unsigned slot;
    int idx;
    if (!ap_rst_n) begin
      // no-op
    end else if (dma_done && dma_is_write_latched[0]) begin
      commit_words = (dma_len_latched + 32'd3) >> 2;
      if (commit_words > TOP_DMA_BUF_WORDS) begin
        commit_words = TOP_DMA_BUF_WORDS;
      end
      for (idx = 0; idx < commit_words; idx = idx + 1) begin
        if (is_k_cache_addr(dma_addr_latched)) begin
          slot = kv_store_index(dma_addr_latched, idx);
          k_cache_store[slot] <= dma_tx_mem[idx];
        end else if (is_v_cache_addr(dma_addr_latched)) begin
          slot = kv_store_index(dma_addr_latched, idx);
          v_cache_store[slot] <= dma_tx_mem[idx];
        end else if (is_wo_addr(dma_addr_latched)) begin
          wo_ram[region_index(dma_addr_latched, idx)] <= dma_tx_mem[idx];
        end else if (is_w1_addr(dma_addr_latched)) begin
          w1_ram[region_index(dma_addr_latched, idx)] <= dma_tx_mem[idx];
        end else if (is_w2_addr(dma_addr_latched)) begin
          w2_ram[region_index(dma_addr_latched, idx)] <= dma_tx_mem[idx];
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
            24: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_BASE_LO);      ctrl_data_in <= 32'h6000_0000; end
            25: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_BASE_HI);      ctrl_data_in <= 32'h0000_0000; end
            26: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_BASE_LO);      ctrl_data_in <= 32'h6100_0000; end
            27: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_BASE_HI);      ctrl_data_in <= 32'h0000_0000; end
            28: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_BASE_LO);      ctrl_data_in <= 32'h6200_0000; end
            29: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_BASE_HI);      ctrl_data_in <= 32'h0000_0000; end
            30: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_BASE_LO);      ctrl_data_in <= 32'h6300_0000; end
            31: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_BASE_HI);      ctrl_data_in <= 32'h0000_0000; end
            32: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_BASE_LO);      ctrl_data_in <= 32'h6400_0000; end
            33: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_BASE_HI);      ctrl_data_in <= 32'h0000_0000; end
            34: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_BASE_LO);      ctrl_data_in <= 32'h6500_0000; end
            35: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_BASE_HI);      ctrl_data_in <= 32'h0000_0000; end
            36: begin ctrl_addr <= ctrl_mem_addr(CTRLW_K_CACHE_LO);      ctrl_data_in <= 32'h6600_0000; end
            37: begin ctrl_addr <= ctrl_mem_addr(CTRLW_K_CACHE_HI);      ctrl_data_in <= 32'h0000_0000; end
            38: begin ctrl_addr <= ctrl_mem_addr(CTRLW_V_CACHE_LO);      ctrl_data_in <= 32'h6700_0000; end
            39: begin ctrl_addr <= ctrl_mem_addr(CTRLW_V_CACHE_HI);      ctrl_data_in <= 32'h0000_0000; end
            40: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_BIAS_BASE_LO); ctrl_data_in <= 32'h6008_0000; end
            41: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WQ_BIAS_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            42: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_BIAS_BASE_LO); ctrl_data_in <= 32'h6108_0000; end
            43: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WK_BIAS_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            44: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_BIAS_BASE_LO); ctrl_data_in <= 32'h6208_0000; end
            45: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WV_BIAS_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            46: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_BIAS_BASE_LO); ctrl_data_in <= 32'h6308_0000; end
            47: begin ctrl_addr <= ctrl_mem_addr(CTRLW_WO_BIAS_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            48: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_BIAS_BASE_LO); ctrl_data_in <= 32'h6408_0000; end
            49: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W1_BIAS_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            50: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_BIAS_BASE_LO); ctrl_data_in <= 32'h6508_0000; end
            51: begin ctrl_addr <= ctrl_mem_addr(CTRLW_W2_BIAS_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            52: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_GAMMA_BASE_LO); ctrl_data_in <= 32'h6800_0000; end
            53: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_GAMMA_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            54: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_GAMMA_BASE_LO); ctrl_data_in <= 32'h6900_0000; end
            55: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_GAMMA_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            56: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_GAMMA_BASE_LO); ctrl_data_in <= 32'h6C00_0000; end
            57: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_GAMMA_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            58: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_EPS_BASE_LO); ctrl_data_in <= 32'h6A00_0000; end
            59: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN0_EPS_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            60: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_EPS_BASE_LO); ctrl_data_in <= 32'h6B00_0000; end
            61: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LN1_EPS_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            62: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_EPS_BASE_LO); ctrl_data_in <= 32'h6D00_0000; end
            63: begin ctrl_addr <= ctrl_mem_addr(CTRLW_FINAL_NORM_EPS_BASE_HI); ctrl_data_in <= 32'h0000_0000; end
            64: begin ctrl_addr <= ctrl_mem_addr(CTRLW_LOGIT_SCALE_QV);  ctrl_data_in <= 32'h0000_0080; end
            65: begin ctrl_addr <= ctrl_mem_addr(CTRLW_SCALE_Q);         ctrl_data_in <= 32'h0000_0080; end
            66: begin ctrl_addr <= ctrl_mem_addr(CTRLW_ZERO_POINT_Q);    ctrl_data_in <= 32'h0000_0000; end
            67: begin ctrl_addr <= ctrl_mem_addr(CTRLW_SCALE_K);         ctrl_data_in <= 32'h0000_0080; end
            68: begin ctrl_addr <= ctrl_mem_addr(CTRLW_ZERO_POINT_K);    ctrl_data_in <= 32'h0000_0000; end
            69: begin ctrl_addr <= ctrl_mem_addr(CTRLW_SCALE_V);         ctrl_data_in <= 32'h0000_0080; end
            70: begin ctrl_addr <= ctrl_mem_addr(CTRLW_ZERO_POINT_V);    ctrl_data_in <= 32'h0000_0000; end
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
            24: ctrl_words[CTRLW_WQ_BASE_LO] <= 32'h6000_0000;
            25: ctrl_words[CTRLW_WQ_BASE_HI] <= 32'h0000_0000;
            26: ctrl_words[CTRLW_WK_BASE_LO] <= 32'h6100_0000;
            27: ctrl_words[CTRLW_WK_BASE_HI] <= 32'h0000_0000;
            28: ctrl_words[CTRLW_WV_BASE_LO] <= 32'h6200_0000;
            29: ctrl_words[CTRLW_WV_BASE_HI] <= 32'h0000_0000;
            30: ctrl_words[CTRLW_WO_BASE_LO] <= 32'h6300_0000;
            31: ctrl_words[CTRLW_WO_BASE_HI] <= 32'h0000_0000;
            32: ctrl_words[CTRLW_W1_BASE_LO] <= 32'h6400_0000;
            33: ctrl_words[CTRLW_W1_BASE_HI] <= 32'h0000_0000;
            34: ctrl_words[CTRLW_W2_BASE_LO] <= 32'h6500_0000;
            35: ctrl_words[CTRLW_W2_BASE_HI] <= 32'h0000_0000;
            36: ctrl_words[CTRLW_K_CACHE_LO] <= 32'h6600_0000;
            37: ctrl_words[CTRLW_K_CACHE_HI] <= 32'h0000_0000;
            38: ctrl_words[CTRLW_V_CACHE_LO] <= 32'h6700_0000;
            39: ctrl_words[CTRLW_V_CACHE_HI] <= 32'h0000_0000;
            40: ctrl_words[CTRLW_WQ_BIAS_BASE_LO] <= 32'h6008_0000;
            41: ctrl_words[CTRLW_WQ_BIAS_BASE_HI] <= 32'h0000_0000;
            42: ctrl_words[CTRLW_WK_BIAS_BASE_LO] <= 32'h6108_0000;
            43: ctrl_words[CTRLW_WK_BIAS_BASE_HI] <= 32'h0000_0000;
            44: ctrl_words[CTRLW_WV_BIAS_BASE_LO] <= 32'h6208_0000;
            45: ctrl_words[CTRLW_WV_BIAS_BASE_HI] <= 32'h0000_0000;
            46: ctrl_words[CTRLW_WO_BIAS_BASE_LO] <= 32'h6308_0000;
            47: ctrl_words[CTRLW_WO_BIAS_BASE_HI] <= 32'h0000_0000;
            48: ctrl_words[CTRLW_W1_BIAS_BASE_LO] <= 32'h6408_0000;
            49: ctrl_words[CTRLW_W1_BIAS_BASE_HI] <= 32'h0000_0000;
            50: ctrl_words[CTRLW_W2_BIAS_BASE_LO] <= 32'h6508_0000;
            51: ctrl_words[CTRLW_W2_BIAS_BASE_HI] <= 32'h0000_0000;
            52: ctrl_words[CTRLW_LN0_GAMMA_BASE_LO] <= 32'h6800_0000;
            53: ctrl_words[CTRLW_LN0_GAMMA_BASE_HI] <= 32'h0000_0000;
            54: ctrl_words[CTRLW_LN1_GAMMA_BASE_LO] <= 32'h6900_0000;
            55: ctrl_words[CTRLW_LN1_GAMMA_BASE_HI] <= 32'h0000_0000;
            56: ctrl_words[CTRLW_FINAL_NORM_GAMMA_BASE_LO] <= 32'h6C00_0000;
            57: ctrl_words[CTRLW_FINAL_NORM_GAMMA_BASE_HI] <= 32'h0000_0000;
            58: ctrl_words[CTRLW_LN0_EPS_BASE_LO] <= 32'h6A00_0000;
            59: ctrl_words[CTRLW_LN0_EPS_BASE_HI] <= 32'h0000_0000;
            60: ctrl_words[CTRLW_LN1_EPS_BASE_LO] <= 32'h6B00_0000;
            61: ctrl_words[CTRLW_LN1_EPS_BASE_HI] <= 32'h0000_0000;
            62: ctrl_words[CTRLW_FINAL_NORM_EPS_BASE_LO] <= 32'h6D00_0000;
            63: ctrl_words[CTRLW_FINAL_NORM_EPS_BASE_HI] <= 32'h0000_0000;
            64: ctrl_words[CTRLW_LOGIT_SCALE_QV] <= 32'h0000_0080;
            65: ctrl_words[CTRLW_SCALE_Q] <= 32'h0000_0080;
            66: ctrl_words[CTRLW_ZERO_POINT_Q] <= 32'h0000_0000;
            67: ctrl_words[CTRLW_SCALE_K] <= 32'h0000_0080;
            68: ctrl_words[CTRLW_ZERO_POINT_K] <= 32'h0000_0000;
            69: ctrl_words[CTRLW_SCALE_V] <= 32'h0000_0080;
            70: ctrl_words[CTRLW_ZERO_POINT_V] <= 32'h0000_0000;
            default: ctrl_words[CTRLW_IRQ_MASK] <= 32'h0000_0006;
          endcase
          if (base_assign_step >= 71) begin
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

    if (dbg_done[0]) begin
      $finish;
    end

    if (cycle_count > MAX_CYCLES) begin
      $finish;
    end

    $display("[TB][%0d] state=%0d axis_in_v=%0d axis_in_l=%0d axis_in_r=%0d axis_in_r_vld=%0d stream_ready=%0d stream_start_i=%0d stream_start_o=%0d stream_start_o_vld=%0d stream_done=%0d stream_in_ce=%0d stream_in_addr=%0d stream_in_q=0x%02h stream_out_ce=%0d stream_out_we=%0d stream_out_addr=%0d stream_out_d=0x%02h",
             cycle_count,
             dbg_state,
             axis_in_valid[0],
             axis_in_last[0],
             axis_in_ready[0],
             axis_in_ready_ap_vld,
             stream_ready[0],
             stream_start_i[0],
             stream_start_o[0],
             stream_start_o_ap_vld,
             stream_done[0],
             stream_in_buf_ce0,
             stream_in_buf_address0,
             stream_in_buf_q0,
             stream_out_buf_ce0,
             stream_out_buf_we0,
             stream_out_buf_address0,
             stream_out_buf_d0);
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


    stream_ready   = 1'b1;
    stream_start_i = 1'b0;
    stream_done    = 1'b0;

    dma_ready = 1'b1;
    dma_done  = 1'b0;

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
    dma_countdown     = 0;
    stream_countdown  = 0;
    dma_busy          = 1'b0;
    stream_busy       = 1'b0;
    axis_packet_sent  = 1'b0;
    stream_fill_active = 1'b0;
    stream_fill_idx    = '0;
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
      stream_in_mem[i] = 8'h00;
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
      ln0_gamma_ram[i] = 32'h0000_2000;
      ln1_gamma_ram[i] = 32'h0000_2000;
      ln0_eps_ram[i] = 32'h0000_0001;
      ln1_eps_ram[i] = 32'h0000_0001;
    end
    for (i = 0; i < KV_STORE_WORDS; i = i + 1) begin
      k_cache_store[i] = 32'h0000_0000;
      v_cache_store[i] = 32'h0000_0000;
    end
    for (i = 0; i < 4; i = i + 1) begin
      dbg_head_ctx_mem[i] = '0;
    end
    for (i = 0; i < 2; i = i + 1) begin
      dbg_head_compute_ctx_mem[i] = '0;
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

    .axis_in_valid(axis_in_valid),
    .axis_in_last(axis_in_last),
    .axis_in_ready(axis_in_ready),
    .axis_in_ready_ap_vld(axis_in_ready_ap_vld),

    .stream_ready(stream_ready),
    .stream_start_i(stream_start_i),
    .stream_start_o(stream_start_o),
    .stream_start_o_ap_vld(stream_start_o_ap_vld),
    .stream_done(stream_done),

    .stream_in_buf_address0(stream_in_buf_address0),
    .stream_in_buf_ce0(stream_in_buf_ce0),
    .stream_in_buf_q0(stream_in_buf_q0),

    .stream_out_buf_address0(stream_out_buf_address0),
    .stream_out_buf_ce0(stream_out_buf_ce0),
    .stream_out_buf_we0(stream_out_buf_we0),
    .stream_out_buf_d0(stream_out_buf_d0),

    .irq_ps(irq_ps),

    .dma_ready(dma_ready),
    .dma_done(dma_done),
    .dma_rx_buf_address0(dma_rx_buf_address0),
    .dma_rx_buf_ce0(dma_rx_buf_ce0),
    .dma_rx_buf_q0(dma_rx_buf_q0),
    .dma_tx_buf_address0(dma_tx_buf_address0),
    .dma_tx_buf_ce0(dma_tx_buf_ce0),
    .dma_tx_buf_we0(dma_tx_buf_we0),
    .dma_tx_buf_d0(dma_tx_buf_d0),
    .dma_start(dma_start),
    .dma_start_ap_vld(dma_start_ap_vld),
    .dma_addr(dma_addr),
    .dma_addr_ap_vld(dma_addr_ap_vld),
    .dma_len(dma_len),
    .dma_len_ap_vld(dma_len_ap_vld),
    .dma_is_write(dma_is_write),
    .dma_is_write_ap_vld(dma_is_write_ap_vld),

    .dbg_state(dbg_state),
    .dbg_state_ap_vld(dbg_state_ap_vld),
    .dbg_head_ctx_ref_address0(dbg_head_ctx_ref_address0),
    .dbg_head_ctx_ref_ce0(dbg_head_ctx_ref_ce0),
    .dbg_head_ctx_ref_we0(dbg_head_ctx_ref_we0),
    .dbg_head_ctx_ref_d0(dbg_head_ctx_ref_d0),
    .dbg_head_ctx_ref_q0(dbg_head_ctx_ref_q0),
    .dbg_head_ctx_ref_address1(dbg_head_ctx_ref_address1),
    .dbg_head_ctx_ref_ce1(dbg_head_ctx_ref_ce1),
    .dbg_head_ctx_ref_we1(dbg_head_ctx_ref_we1),
    .dbg_head_ctx_ref_d1(dbg_head_ctx_ref_d1),
    .dbg_head_ctx_ref_q1(dbg_head_ctx_ref_q1),
    .dbg_head_compute_ctx_address0(dbg_head_compute_ctx_address0),
    .dbg_head_compute_ctx_ce0(dbg_head_compute_ctx_ce0),
    .dbg_head_compute_ctx_we0(dbg_head_compute_ctx_we0),
    .dbg_head_compute_ctx_d0(dbg_head_compute_ctx_d0),
    .dbg_head_compute_ctx_q0(dbg_head_compute_ctx_q0),
    .dbg_head_compute_ctx_address1(dbg_head_compute_ctx_address1),
    .dbg_head_compute_ctx_ce1(dbg_head_compute_ctx_ce1),
    .dbg_head_compute_ctx_we1(dbg_head_compute_ctx_we1),
    .dbg_head_compute_ctx_d1(dbg_head_compute_ctx_d1),
    .dbg_head_compute_ctx_q1(dbg_head_compute_ctx_q1),

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
    .dbg_in_buf_q0(dbg_in_buf_q0),
    .dbg_in_buf_address1(dbg_in_buf_address1),
    .dbg_in_buf_ce1(dbg_in_buf_ce1),
    .dbg_in_buf_we1(dbg_in_buf_we1),
    .dbg_in_buf_d1(dbg_in_buf_d1),
    .dbg_in_buf_q1(dbg_in_buf_q1),

    .dbg_out_buf_address0(dbg_out_buf_address0),
    .dbg_out_buf_ce0(dbg_out_buf_ce0),
    .dbg_out_buf_we0(dbg_out_buf_we0),
    .dbg_out_buf_d0(dbg_out_buf_d0),
    .dbg_out_buf_q0(dbg_out_buf_q0),
    .dbg_out_buf_address1(dbg_out_buf_address1),
    .dbg_out_buf_ce1(dbg_out_buf_ce1),
    .dbg_out_buf_we1(dbg_out_buf_we1),
    .dbg_out_buf_d1(dbg_out_buf_d1),
    .dbg_out_buf_q1(dbg_out_buf_q1),

    .dbg_head_in_buf_address0(dbg_head_in_buf_address0),
    .dbg_head_in_buf_ce0(dbg_head_in_buf_ce0),
    .dbg_head_in_buf_we0(dbg_head_in_buf_we0),
    .dbg_head_in_buf_d0(dbg_head_in_buf_d0),
    .dbg_head_in_buf_q0(dbg_head_in_buf_q0),
    .dbg_head_in_buf_address1(dbg_head_in_buf_address1),
    .dbg_head_in_buf_ce1(dbg_head_in_buf_ce1),
    .dbg_head_in_buf_we1(dbg_head_in_buf_we1),
    .dbg_head_in_buf_d1(dbg_head_in_buf_d1),
    .dbg_head_in_buf_q1(dbg_head_in_buf_q1),

    .dbg_head_out_buf_address0(dbg_head_out_buf_address0),
    .dbg_head_out_buf_ce0(dbg_head_out_buf_ce0),
    .dbg_head_out_buf_we0(dbg_head_out_buf_we0),
    .dbg_head_out_buf_d0(dbg_head_out_buf_d0),
    .dbg_head_out_buf_q0(dbg_head_out_buf_q0),
    .dbg_head_out_buf_address1(dbg_head_out_buf_address1),
    .dbg_head_out_buf_ce1(dbg_head_out_buf_ce1),
    .dbg_head_out_buf_we1(dbg_head_out_buf_we1),
    .dbg_head_out_buf_d1(dbg_head_out_buf_d1),
    .dbg_head_out_buf_q1(dbg_head_out_buf_q1),

    .dbg_error(dbg_error),
    .dbg_error_ap_vld(dbg_error_ap_vld),
    .dbg_error_code(dbg_error_code),
    .dbg_error_code_ap_vld(dbg_error_code_ap_vld),
    .dbg_done(dbg_done),
    .dbg_done_ap_vld(dbg_done_ap_vld),

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
