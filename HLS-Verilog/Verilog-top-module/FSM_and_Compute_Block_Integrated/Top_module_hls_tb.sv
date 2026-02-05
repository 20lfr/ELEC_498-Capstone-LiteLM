`timescale 1ns/1ps

// Enhanced testbench for transformer_top RTL matching C++ testbench functionality
module transformer_top_tb;
  localparam int CLK_PERIOD = 10;
  localparam int MAX_CYCLES = 30000;
  localparam int COMP_LAT = 3;
  localparam int COMP_LAT_MIN = 1;
  localparam int COMP_LAT_MAX = 4;
  localparam int DMA_LAT  = 3;
  localparam int DMA_LAT_MIN  = 1;
  localparam int DMA_LAT_MAX  = 4;
  localparam int AXIS_BEATS = 3;
  localparam int NUM_HEADS       = 4;
  localparam int NUM_LAYERS      = 2;
  localparam int NUM_WO_TILES    = 4;
  localparam int NUM_W1_TILES    = 4;
  localparam int NUM_W2_TILES    = 4;
  localparam int NUM_LOGIT_TILES = 2;
  localparam int D_MODEL = 16;
  localparam int D_FFN   = 22;
  localparam int D_HEADS = D_MODEL / NUM_HEADS;
  localparam int D_TILE_WO  = D_MODEL / NUM_WO_TILES;
  localparam int D_TILE_W1  = D_MODEL / NUM_W1_TILES;
  localparam int D_TILE_W2  = D_FFN   / NUM_W2_TILES;
  localparam int CONTEXT_LENGTH = 16;
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
  localparam int REQUANT_X_OFFSET = 0;
  localparam int REQUANT_M_OFFSET = REQUANT_X_OFFSET + (D_MODEL * 4);
  localparam int REQUANT_N_OFFSET = REQUANT_M_OFFSET + 4;
  localparam int REQUANT_Z_OFFSET = REQUANT_N_OFFSET + 4;
  localparam int RESID_X_OFFSET = 0;
  localparam int RESID_R_OFFSET = RESID_X_OFFSET + D_MODEL;
  localparam int LN_X_OFFSET = 0;
  localparam int LN_GAMMA_OFFSET = LN_X_OFFSET + D_MODEL;
  localparam int LN_EPS_OFFSET = LN_GAMMA_OFFSET + (D_MODEL * 4);
  localparam int FFN_W1_X_OFFSET = 0;
  localparam int FFN_W1_W_NIBBLES = D_MODEL * D_TILE_W1;
  localparam int FFN_W1_W_BYTES = (FFN_W1_W_NIBBLES + 1) / 2;
  localparam int FFN_W1_B_BYTES = D_TILE_W1 * 4;
  localparam int FFN_W1_S_BYTES = D_TILE_W1 * 2;
  localparam int FFN_W1_W_OFFSET = FFN_W1_X_OFFSET + D_MODEL;
  localparam int FFN_W1_B_OFFSET = FFN_W1_W_OFFSET + FFN_W1_W_BYTES;
  localparam int FFN_W1_S_OFFSET = FFN_W1_B_OFFSET + FFN_W1_B_BYTES;
  localparam int FFN_ACT_X_OFFSET = 0;
  localparam int FFN_W2_X_OFFSET = 0;
  localparam int FFN_W2_W_NIBBLES = D_FFN * D_TILE_W2;
  localparam int FFN_W2_W_BYTES = (FFN_W2_W_NIBBLES + 1) / 2;
  localparam int FFN_W2_B_BYTES = D_TILE_W2 * 4;
  localparam int FFN_W2_S_BYTES = D_TILE_W2 * 2;
  localparam int FFN_W2_W_OFFSET = FFN_W2_X_OFFSET + (D_FFN * 2);
  localparam int FFN_W2_B_OFFSET = FFN_W2_W_OFFSET + FFN_W2_W_BYTES;
  localparam int FFN_W2_S_OFFSET = FFN_W2_B_OFFSET + FFN_W2_B_BYTES;
  localparam int MEM_LAT = 8;
  // Control bits (mirror top_params.hpp)
  localparam logic [31:0] CTRL_RESETN_BIT    = 32'h0000_0001;
  localparam logic [31:0] CTRL_START_BIT     = 32'h0000_0002;
  localparam logic [31:0] IRQ_ERROR_BIT      = 32'h0000_0002;
  localparam logic [31:0] IRQ_INFER_DONE_BIT = 32'h0000_0004;
  localparam logic [31:0] STATUS_IDLE_BIT    = 32'h0000_0001;
  localparam logic [31:0] STATUS_BUSY_BIT    = 32'h0000_0004;
  localparam logic [31:0] ERR_DMA_ALIGNMENT  = 32'h0000_0010;
  localparam logic [31:0] ERR_DMA_ZERO_LEN   = 32'h0000_0011;

  // AXI-Lite address map (from transformer_top_control_s_axi.v)
  localparam logic [7:0] ADDR_AP_CTRL           = 8'h00;
  localparam logic [7:0] ADDR_GIE               = 8'h04;
  localparam logic [7:0] ADDR_IER               = 8'h08;
  localparam logic [7:0] ADDR_ISR               = 8'h0c;
  localparam logic [7:0] ADDR_CTRL_MEM_DATA_0   = 8'h10;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_0 = 8'hb4;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_1 = 8'hb8;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_2 = 8'hbc;
  localparam logic [7:0] ADDR_STATUS_MEM_DATA_3 = 8'hc0;
  localparam logic [7:0] ADDR_STATUS_MEM_CTRL   = 8'hc4;

  // ControlMemSpace word indices (ctrl_mem[31:0] = word 0)
  localparam int CTRL_MEM_WORD_CONTROL        = 0;
  localparam int CTRL_MEM_WORD_IRQ_MASK       = 1;
  localparam int CTRL_MEM_WORD_IRQ_CLEAR      = 2;
  localparam int CTRL_MEM_WORD_DMA_LAYER_LEN  = 3;
  localparam int CTRL_MEM_WORD_DMA_HEAD_LEN   = 4;
  localparam int CTRL_MEM_WORD_DMA_TILE_LEN   = 5;
  localparam int CTRL_MEM_WORD_LAYER_STRIDE   = 6;
  localparam int CTRL_MEM_WORD_WQ_HEAD_STRIDE = 7;
  localparam int CTRL_MEM_WORD_WK_HEAD_STRIDE = 8;
  localparam int CTRL_MEM_WORD_WV_HEAD_STRIDE = 9;
  localparam int CTRL_MEM_WORD_K_CACHE_STRIDE = 10;
  localparam int CTRL_MEM_WORD_V_CACHE_STRIDE = 11;
  localparam int CTRL_MEM_WORD_WO_TILE_STRIDE = 12;
  localparam int CTRL_MEM_WORD_W1_TILE_STRIDE = 13;
  localparam int CTRL_MEM_WORD_W2_TILE_STRIDE = 14;
  localparam int CTRL_MEM_WORD_PAD0           = 15; // alignment padding
  localparam int CTRL_MEM_WORD_WQ_BASE_LO     = 16;
  localparam int CTRL_MEM_WORD_WQ_BASE_HI     = 17;
  localparam int CTRL_MEM_WORD_WK_BASE_LO     = 18;
  localparam int CTRL_MEM_WORD_WK_BASE_HI     = 19;
  localparam int CTRL_MEM_WORD_WV_BASE_LO     = 20;
  localparam int CTRL_MEM_WORD_WV_BASE_HI     = 21;
  localparam int CTRL_MEM_WORD_WO_BASE_LO     = 22;
  localparam int CTRL_MEM_WORD_WO_BASE_HI     = 23;
  localparam int CTRL_MEM_WORD_W1_BASE_LO     = 24;
  localparam int CTRL_MEM_WORD_W1_BASE_HI     = 25;
  localparam int CTRL_MEM_WORD_W2_BASE_LO     = 26;
  localparam int CTRL_MEM_WORD_W2_BASE_HI     = 27;
  localparam int CTRL_MEM_WORD_K_CACHE_LO     = 28;
  localparam int CTRL_MEM_WORD_K_CACHE_HI     = 29;
  localparam int CTRL_MEM_WORD_V_CACHE_LO     = 30;
  localparam int CTRL_MEM_WORD_V_CACHE_HI     = 31;
  localparam int CTRL_MEM_WORD_LOGIT_SCALE_QV = 32;
  localparam int CTRL_MEM_WORD_SCALE_Q        = 33;
  localparam int CTRL_MEM_WORD_ZERO_POINT_Q   = 34;
  localparam int CTRL_MEM_WORD_SCALE_K        = 35;
  localparam int CTRL_MEM_WORD_ZERO_POINT_K   = 36;
  localparam int CTRL_MEM_WORD_SCALE_V        = 37;
  localparam int CTRL_MEM_WORD_ZERO_POINT_V   = 38;
  localparam int CTRL_MEM_WORD_PAD1           = 39; // tail padding

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
    logic [63:0] wq_base_addr;
    logic [63:0] wk_base_addr;
    logic [63:0] wv_base_addr;
    logic [63:0] wo_base_addr;
    logic [63:0] w1_base_addr;
    logic [63:0] w2_base_addr;
    logic [63:0] k_cache_addr;
    logic [63:0] v_cache_addr;
    logic [31:0] logit_scale_qv;
    logic [31:0] scale_q;
    logic [31:0] zero_point_q;
    logic [31:0] scale_k;
    logic [31:0] zero_point_k;
    logic [31:0] scale_v;
    logic [31:0] zero_point_v;
  } ControlMemSpace_t;

  

  typedef struct packed {
    logic [31:0] status;
    logic [31:0] irq_status;
    logic [31:0] error_code;
    logic [31:0] layer_index;
  } StatusMemSpace_t;

  // Clock / reset
  logic ap_clk = 1'b0;
  logic ap_rst_n = 1'b0;
  wire  ap_rst = ~ap_rst_n;
  always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

  // AXI4-Lite control (s_axi_control)
  logic        s_axi_control_AWVALID;
  logic        s_axi_control_AWREADY;
  logic [7:0]  s_axi_control_AWADDR;
  logic        s_axi_control_WVALID;
  logic        s_axi_control_WREADY;
  logic [31:0] s_axi_control_WDATA;
  logic [3:0]  s_axi_control_WSTRB;
  logic        s_axi_control_ARVALID;
  logic        s_axi_control_ARREADY;
  logic [7:0]  s_axi_control_ARADDR;
  logic        s_axi_control_RVALID;
  logic        s_axi_control_RREADY;
  logic [31:0] s_axi_control_RDATA;
  logic [1:0]  s_axi_control_RRESP;
  logic        s_axi_control_BVALID;
  logic        s_axi_control_BREADY;
  logic [1:0]  s_axi_control_BRESP;
  logic        interrupt;

  // DUT inputs

  logic [0:0] axis_in_valid;
  logic [0:0] axis_in_last;
  logic [0:0] dma_done;
  logic [0:0] wl_ready;
  logic [0:0] mem_transfer_done;
  logic [0:0] mem_read_request;
  logic       mem_read_request_ap_vld;
  logic [0:0] mem_write_request;
  logic       mem_write_request_ap_vld;
  logic [31:0] mem_op;
  logic       mem_op_ap_vld;
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
  logic [0:0] wl_start_i;
  logic [0:0] wl_start_o;
  logic       wl_start_o_ap_vld;
  logic [31:0] wl_instruction;
  logic        wl_instruction_ap_vld;
  logic [0:0] stream_ready;
  logic [0:0] stream_done;

  // DUT outputs
  logic [31:0] STATE;
  logic STATE_ap_vld;
  logic [0:0] dbg_compute_start;
  logic       dbg_compute_start_ap_vld;
  logic [31:0] dbg_compute_instruction;
  logic        dbg_compute_instruction_ap_vld;
  logic [0:0]  dbg_compute_ready;
  logic        dbg_compute_ready_ap_vld;
  logic [0:0]  dbg_compute_done;
  logic        dbg_compute_done_ap_vld;
  logic [31:0] dbg_compute_state;
  logic        dbg_compute_state_ap_vld;
  logic [31:0] dbg_req_instruction;
  logic        dbg_req_instruction_ap_vld;
  logic [7:0]  dbg_req_op;
  logic        dbg_req_op_ap_vld;
  logic [7:0]  dbg_req_layer;
  logic        dbg_req_layer_ap_vld;
  logic [7:0]  dbg_req_head;
  logic        dbg_req_head_ap_vld;
  logic [7:0]  dbg_req_tile;
  logic        dbg_req_tile_ap_vld;
  logic [0:0]  dbg_mac_start;
  logic        dbg_mac_start_ap_vld;
  logic [0:0]  dbg_mac_ready;
  logic        dbg_mac_ready_ap_vld;
  logic [0:0]  dbg_mac_complete;
  logic        dbg_mac_complete_ap_vld;
  logic [0:0]  dbg_ctrl_reset_asserted;
  logic        dbg_ctrl_reset_asserted_ap_vld;
  logic [0:0] axis_in_ready;
  logic axis_in_ready_ap_vld;
  logic [0:0] stream_start;
  logic stream_start_ap_vld;
  logic [1215:0] dbg_ctrl_mem;
  logic        dbg_ctrl_mem_ap_vld;
  logic [31:0] control_reg;
  logic        control_reg_ap_vld;
  logic [31:0] irq_status_reg;
  logic        irq_status_reg_ap_vld;
  logic [31:0] irq_mask_reg;
  logic        irq_mask_reg_ap_vld;
  logic [31:0] irq_clear_reg;
  logic        irq_clear_reg_ap_vld;
  logic [31:0] dbg_irq_status_reg;
  logic [31:0] dbg_irq_mask_reg;
  logic [31:0] dbg_irq_clear_reg;
  logic [31:0] wq_base_addr;
  logic        wq_base_addr_ap_vld;
  logic [31:0] wk_base_addr;
  logic        wk_base_addr_ap_vld;
  logic [31:0] wv_base_addr;
  logic        wv_base_addr_ap_vld;
  logic [31:0] wq_head_stride;
  logic        wq_head_stride_ap_vld;
  logic [31:0] wk_head_stride;
  logic        wk_head_stride_ap_vld;
  logic [31:0] wv_head_stride;
  logic        wv_head_stride_ap_vld;
  logic [31:0] wo_base_addr;
  logic        wo_base_addr_ap_vld;
  logic [31:0] w1_base_addr;
  logic        w1_base_addr_ap_vld;
  logic [31:0] w2_base_addr;
  logic        w2_base_addr_ap_vld;
  logic [31:0] wo_tile_stride;
  logic        wo_tile_stride_ap_vld;
  logic [31:0] w1_tile_stride;
  logic        w1_tile_stride_ap_vld;
  logic [31:0] w2_tile_stride;
  logic        w2_tile_stride_ap_vld;
  logic [0:0] irq_ps;
  logic [0:0]  dbg_done;
  logic        dbg_done_ap_vld;

  // Testbench state variables
  logic dma_busy;
  int dma_timer;
  logic stream_busy;
  logic start_pulsed;
  logic pending_start_clear;
  logic reset_released;
  logic reset_low_written;
  logic seen_done;
  int post_done_cycles;
  logic seen_idle_after;
  logic seen_concat;
  int axis_sent;
  logic axis_feed_done;
  logic axis_drive;
  // Control/Status memory images (testbench-side)
  ControlMemSpace_t ctrl_mem;
  StatusMemSpace_t  status_mem;
  // Control bus request (drives AXI-Lite master)
  logic [7:0]  ctrl_addr;
  logic [31:0] ctrl_data_in;
  logic        ctrl_read_en;
  logic        ctrl_write_en;
  logic        ctrl_chip_en;
  logic [31:0] ctrl_shadow_control;
  logic [31:0] dbg_control_register;
  int ctrl_gap_cycles;
  logic assign_base_addresses;
  int base_assign_step;
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
  int idle_after_done;
  logic axis_last_stretch_active;
  int axis_last_stretch_ctr;
  logic irq_seen_done;
  logic irq_seen_error;
  logic irq_seen_done_clr;
  logic irq_seen_error_clr;
  logic irq_pending;
  typedef enum logic [1:0] {
    IRQ_RD_STATUS = 2'd0,
    IRQ_RD_STATE  = 2'd1,
    IRQ_RD_DONE   = 2'd2
  } irq_read_phase_t;
  irq_read_phase_t irq_read_phase;
  // (interrupt latching removed)
  logic [31:0] ctrl_data_out_shadow;
  logic done_clear_pending;
  logic error_clear_pending;
  logic [1:0] done_clear_cnt;
  logic [1:0] error_clear_cnt;
  logic [31:0] error_code_lat;
  typedef enum logic [1:0] {
    ERR_PHASE_READ = 2'd0,
    ERR_PHASE_RELOAD = 2'd1,
    ERR_PHASE_CLEAR = 2'd2
  } err_phase_t;
  err_phase_t err_phase;
  logic [4:0] err_reload_step;

  // IRQ/Done/Error control requests
  logic        irq_req_valid;
  logic        irq_req_read;
  logic [7:0]  irq_req_addr;
  logic        done_req_valid;
  logic        done_req_write;
  logic [7:0]  done_req_addr;
  logic [31:0] done_req_wdata;
  logic        error_req_valid;
  logic        error_req_write;
  logic        error_req_read;
  logic [7:0]  error_req_addr;
  logic [31:0] error_req_wdata;
  wire         irq_req_fire;
  wire         done_req_fire;
  wire         error_req_fire;

  // AXI-lite master bookkeeping
  typedef enum logic [2:0] {
    AXI_IDLE,
    AXI_WRITE_ADDR,
    AXI_WRITE_RESP,
    AXI_READ_ADDR,
    AXI_READ_DATA
  } axi_state_t;
  axi_state_t axi_state;
  logic [7:0]  axi_addr;
  logic [31:0] axi_wdata;
  logic        axi_is_write;
  logic [31:0] axi_rdata;
  logic        axi_read_valid;
  logic        axi_aw_seen;
  logic        axi_w_seen;
  logic        axi_b_seen;
  // Head compute model
  localparam int HEADS_TOTAL = 4;
  localparam int HEADS_PAR   = 1;
  // ComputeOp encodings (must match Scheduler_FSM.hpp)
  localparam int CMP_ATT_SCORES = 7;
  localparam int CMP_CONCAT     = 13;
  // Compute controller ops (match compute_controller_tb.sv)
  localparam int CMP_LN0        = 8'h01;
  localparam int CMP_REQUANT1   = 8'h02;
  localparam int CMP_OUT_PROJ   = 8'h0F;
  localparam int CMP_RESID0     = 8'h10;
  localparam int CMP_REQUANT2   = 8'h11;
  localparam int CMP_FFN_W1     = 8'h12;
  localparam int CMP_FFN_ACT    = 8'h13;
  localparam int CMP_FFN_W2     = 8'h14;
  localparam int CMP_REQUANT3   = 8'h15;
  localparam int CMP_RESID1     = 8'h16;
  localparam int CMP_LN1        = 8'h17;
  localparam int CMP_REQUANT4   = 8'h18;
  localparam int CMP_FINAL_NORM = 8'h19;
  // LayerNorm fine-grain ops (for readability in logs)
  localparam int CMP_LN0_SUM      = 27;
  localparam int CMP_LN0_SUMSQ    = 28;
  localparam int CMP_LN0_MEAN     = 29;
  localparam int CMP_LN0_EYY      = 30;
  localparam int CMP_LN0_VAR      = 31;
  localparam int CMP_LN0_VAR_EPS  = 32;
  localparam int CMP_LN0_INV_STD  = 33;
  localparam int CMP_LN0_NORM     = 34;
  localparam int CMP_LN0_SCALE    = 35;
  localparam int CMP_LN0_SHIFT    = 36;
  localparam int CMP_LN1_SUM      = 37;
  localparam int CMP_LN1_SUMSQ    = 38;
  localparam int CMP_LN1_MEAN     = 39;
  localparam int CMP_LN1_EYY      = 40;
  localparam int CMP_LN1_VAR      = 41;
  localparam int CMP_LN1_VAR_EPS  = 42;
  localparam int CMP_LN1_INV_STD  = 43;
  localparam int CMP_LN1_NORM     = 44;
  localparam int CMP_LN1_SCALE    = 45;
  localparam int CMP_LN1_SHIFT    = 46;
  typedef struct packed {
    // Reverse order of HeadCtx so LSBs align with C layout
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
  localparam int HEAD_CTX_W = $bits(head_ctx_t);
  // Head context interfaces (4 lanes)
  logic [HEAD_CTX_W-1:0] head_ctx_ref_0_i, head_ctx_ref_0_o;
  logic        head_ctx_ref_0_o_ap_vld;
  logic [HEAD_CTX_W-1:0] head_ctx_ref_1_i, head_ctx_ref_1_o;
  logic        head_ctx_ref_1_o_ap_vld;
  logic [HEAD_CTX_W-1:0] head_ctx_ref_2_i, head_ctx_ref_2_o;
  logic        head_ctx_ref_2_o_ap_vld;
  logic [HEAD_CTX_W-1:0] head_ctx_ref_3_i, head_ctx_ref_3_o;
  logic        head_ctx_ref_3_o_ap_vld;
  // Debug visibility
  logic [7:0] head_phase_dbg   [0:HEADS_TOTAL-1];
  logic [31:0] head_op_dbg      [0:HEADS_TOTAL-1];
  logic [31:0] head_last_op_dbg      [0:HEADS_TOTAL-1];

  head_ctx_t head_ctx_shadow   [0:HEADS_TOTAL-1];
  logic [3:0] head_busy_ctr    [0:HEADS_TOTAL-1];
  logic       head_inflight    [0:HEADS_TOTAL-1];
  logic       head_done_hold   [0:HEADS_TOTAL-1];
  logic [2:0] head_done_ctr    [0:HEADS_TOTAL-1];
  logic       head_compute_ready [0:HEADS_TOTAL-1];
  logic       head_compute_done  [0:HEADS_TOTAL-1];
  logic [3:0] head_dma_ctr     [0:HEADS_TOTAL-1];
  logic       head_dma_inflight[0:HEADS_TOTAL-1];
  logic       head_dma_done_hold[0:HEADS_TOTAL-1];
  logic [6:0] head_dma_done_ctr[0:HEADS_TOTAL-1];
  logic       head_dma_done    [0:HEADS_TOTAL-1];
  logic       head_wl_stall    [0:HEADS_TOTAL-1];
  // Debug latches
  logic [0:0] dbg_compute_ready_lat;
  logic [0:0] dbg_compute_done_lat;

  // Compute controller memory model
  logic [7:0] in_buf_mem [0:IN_BUF_BYTES-1];
  logic [7:0] out_buf_mem [0:OUT_BUF_BYTES-1];
  typedef enum logic [1:0] { MEM_NONE=2'b00, MEM_READ=2'b01, MEM_WRITE=2'b10 } mem_pending_t;
  mem_pending_t mem_pending;
  logic mem_busy;
  int mem_timer;
  int mem_done_hold;
  int pending_tile;

  // Input data sets (mirrors compute_controller_tb.sv)
  logic [7:0]  full_valueA [0:D_MODEL-1];
  logic [3:0]  full_weights [0:D_MODEL*D_MODEL-1];
  logic [31:0] full_bias [0:D_MODEL-1];
  logic [31:0] rq1_x [0:D_MODEL-1];
  logic [31:0] rq2_x [0:D_MODEL-1];
  logic [31:0] rq3_x [0:D_MODEL-1];
  logic [31:0] rq4_x [0:D_MODEL-1];
  logic [31:0] rq1_M, rq1_N, rq1_Z;
  logic [31:0] rq2_M, rq2_N, rq2_Z;
  logic [31:0] rq3_M, rq3_N, rq3_Z;
  logic [31:0] rq4_M, rq4_N, rq4_Z;
  logic [31:0] full_accum [0:D_MODEL-1];
  logic [7:0]  rq1_out [0:D_MODEL-1];
  logic [7:0]  rq2_out [0:D_MODEL-1];
  logic [7:0]  rq3_out [0:D_MODEL-1];
  logic [7:0]  rq4_out [0:D_MODEL-1];
  logic [7:0]  resid0_out [0:D_MODEL-1];
  logic [7:0]  resid1_out [0:D_MODEL-1];
  logic [31:0] ln0_out [0:D_MODEL-1];
  logic [31:0] ln1_out [0:D_MODEL-1];
  logic [31:0] final_norm_out [0:D_MODEL-1];
  logic [7:0] resid0_x [0:D_MODEL-1];
  logic [7:0] resid0_r [0:D_MODEL-1];
  logic [7:0] resid1_x [0:D_MODEL-1];
  logic [7:0] resid1_r [0:D_MODEL-1];
  logic [7:0] ln0_x [0:D_MODEL-1];
  logic [7:0] ln1_x [0:D_MODEL-1];
  logic [7:0] final_norm_x [0:D_MODEL-1];
  logic [31:0] ln0_gamma [0:D_MODEL-1];
  logic [31:0] ln1_gamma [0:D_MODEL-1];
  logic [31:0] final_norm_gamma [0:D_MODEL-1];
  logic [31:0] ln0_eps;
  logic [31:0] ln1_eps;
  logic [31:0] final_norm_eps;
  logic [7:0] ffn1_x [0:D_MODEL-1];
  logic [3:0] ffn1_w [0:(D_MODEL*D_MODEL)-1];
  logic [31:0] ffn1_b [0:D_MODEL-1];
  logic [15:0] ffn1_s [0:D_MODEL-1];
  logic [15:0] ffn1_out [0:D_MODEL-1];
  logic [15:0] ffn_act_in [0:D_FFN-1];
  logic [15:0] ffn_act_out [0:D_FFN-1];
  logic [15:0] ffn2_x [0:D_FFN-1];
  logic [3:0] ffn2_w [0:(D_FFN*D_FFN)-1];
  logic [31:0] ffn2_b [0:D_FFN-1];
  logic [15:0] ffn2_s [0:D_FFN-1];
  logic [31:0] ffn2_out [0:(NUM_W2_TILES * D_TILE_W2)-1];
  // DMA done hold
  logic       dma_done_hold;
  logic [2:0] dma_done_ctr;
  // Stream done hold
  logic       stream_done_hold;
  logic [2:0] stream_done_ctr;

  

  // Helper to decode DMA select
  function string dma_name(input [7:0] sel);
    case (sel)
      8'd0:  return "NONE";
      8'd1:  return "WQ";
      8'd2:  return "WK";
      8'd3:  return "WV";
      8'd4:  return "CTX_K";
      8'd5:  return "CTX_V";
      8'd6:  return "K_WR";
      8'd7:  return "V_WR";
      8'd8:  return "WO";
      8'd9:  return "W1";
      8'd10: return "W2";
      8'd11: return "WLOGIT";
      8'd12: return "CONCAT";
      default: return "UNK";
    endcase
  endfunction

  function automatic int rand_comp_lat();
    rand_comp_lat = $urandom_range(COMP_LAT_MIN, COMP_LAT_MAX);
  endfunction

  function automatic int rand_dma_lat();
    rand_dma_lat = $urandom_range(DMA_LAT_MIN, DMA_LAT_MAX);
  endfunction

  // Initialize memory-backed input datasets for compute controller
  initial begin : init_mem
    int i;
    int t;
    int j;

    for (i = 0; i < D_MODEL; i = i + 1) begin
      full_valueA[i] = 8'h7f;
      full_bias[i] = 32'd7;
      full_accum[i] = 32'd0;
      rq1_x[i] = (i * 3) - 20;
      rq2_x[i] = (i * 2) + 5;
      rq3_x[i] = 100 - (i * 4);
      rq4_x[i] = (i * 5) - 11;
      rq1_out[i] = 8'd0;
      rq2_out[i] = 8'd0;
      rq3_out[i] = 8'd0;
      rq4_out[i] = 8'd0;
      resid0_x[i] = i;
      resid0_r[i] = i * 2;
      resid1_x[i] = -i;
      resid1_r[i] = i + 1;
      resid0_out[i] = 8'd0;
      resid1_out[i] = 8'd0;
      ln0_x[i] = i + 1;
      ln1_x[i] = i + 2;
      final_norm_x[i] = i + 3;
      ln0_gamma[i] = 32'd1;
      ln1_gamma[i] = 32'd2;
      final_norm_gamma[i] = 32'd3;
      ln0_out[i] = 32'd0;
      ln1_out[i] = 32'd0;
      final_norm_out[i] = 32'd0;
      ffn1_x[i] = i + 3;
      ffn1_b[i] = 32'd7;
      ffn1_s[i] = 16'h4000;
      ffn1_out[i] = 16'd0;
    end

    rq1_M = 32'd1; rq1_N = 32'd0; rq1_Z = 32'd0;
    rq2_M = 32'd2; rq2_N = 32'd1; rq2_Z = 32'd0;
    rq3_M = 32'd1; rq3_N = 32'd2; rq3_Z = 32'd0;
    rq4_M = 32'd3; rq4_N = 32'd1; rq4_Z = 32'd0;
    ln0_eps = 32'd1;
    ln1_eps = 32'd2;
    final_norm_eps = 32'd3;

    for (t = 0; t < D_MODEL; t = t + 1) begin
      for (j = 0; j < D_MODEL; j = j + 1) begin
        full_weights[t * D_MODEL + j] = 4'h7;
        ffn1_w[t * D_MODEL + j] = 4'h1;
      end
    end

    for (t = 0; t < D_FFN; t = t + 1) begin
      ffn_act_in[t] = (t * 3) - 20;
      ffn_act_out[t] = 16'd0;
      ffn2_x[t] = (t * 2) + 1;
      ffn2_b[t] = 32'd5;
      ffn2_s[t] = 16'h4000;
    end
    for (t = 0; t < (D_FFN * D_FFN); t = t + 1) begin
      ffn2_w[t] = 4'h1;
    end
    for (t = 0; t < (NUM_W2_TILES * D_TILE_W2); t = t + 1) begin
      ffn2_out[t] = 32'd0;
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

  function automatic logic [7:0] ctrl_mem_addr(input int unsigned word_idx);
    ctrl_mem_addr = ADDR_CTRL_MEM_DATA_0 + (word_idx[7:0] << 2);
  endfunction

  wire ctrl_can_issue = (ctrl_gap_cycles == 0) && (axi_state == AXI_IDLE);
  assign irq_req_fire   = ctrl_can_issue && irq_req_valid;
  assign done_req_fire  = ctrl_can_issue && !irq_req_valid && done_req_valid;
  assign error_req_fire = ctrl_can_issue && !irq_req_valid && !done_req_valid && error_req_valid;

  // (error handling removed)

  // AXI-Lite master for control/status space
  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      s_axi_control_AWVALID <= 1'b0;
      s_axi_control_WVALID  <= 1'b0;
      s_axi_control_ARVALID <= 1'b0;
      s_axi_control_AWADDR  <= 8'd0;
      s_axi_control_ARADDR  <= 8'd0;
      s_axi_control_WDATA   <= 32'd0;
      s_axi_control_WSTRB   <= 4'hF;
      s_axi_control_BREADY  <= 1'b1;
      s_axi_control_RREADY  <= 1'b1;
      axi_state             <= AXI_IDLE;
      axi_addr              <= 8'd0;
      axi_wdata             <= 32'd0;
      axi_is_write          <= 1'b0;
      axi_rdata             <= 32'd0;
      axi_read_valid        <= 1'b0;
      axi_aw_seen           <= 1'b0;
      axi_w_seen            <= 1'b0;
      axi_b_seen            <= 1'b0;
      ctrl_data_out_shadow  <= 32'd0;
      status_mem            <= '0;
    end else begin
      if (s_axi_control_BVALID) begin
        axi_b_seen <= 1'b1;
      end
      axi_read_valid <= 1'b0;
      case (axi_state)
        AXI_IDLE: begin
          if (ctrl_chip_en && (ctrl_write_en || ctrl_read_en)) begin
            axi_addr     <= ctrl_addr;
            axi_wdata    <= ctrl_data_in;
            axi_is_write <= ctrl_write_en;
            if (ctrl_write_en) begin
              s_axi_control_AWADDR  <= ctrl_addr;
              s_axi_control_WDATA   <= ctrl_data_in;
              s_axi_control_WSTRB   <= 4'hF;
              s_axi_control_AWVALID <= 1'b1;
              s_axi_control_WVALID  <= 1'b1;
              axi_aw_seen           <= 1'b0;
              axi_w_seen            <= 1'b0;
              axi_b_seen            <= 1'b0;
              axi_state             <= AXI_WRITE_ADDR;
            end else begin
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
            axi_state <= AXI_IDLE;
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
            axi_rdata        <= s_axi_control_RDATA;
            ctrl_data_out_shadow <= s_axi_control_RDATA;
            axi_read_valid   <= 1'b1;
            case (axi_addr)
              ADDR_STATUS_MEM_DATA_0: status_mem.status      <= s_axi_control_RDATA;
              ADDR_STATUS_MEM_DATA_1: status_mem.irq_status <= s_axi_control_RDATA;
              ADDR_STATUS_MEM_DATA_2: status_mem.error_code  <= s_axi_control_RDATA;
              ADDR_STATUS_MEM_DATA_3: status_mem.layer_index <= s_axi_control_RDATA;
              default: begin end
            endcase
            axi_state <= AXI_IDLE;
          end
        end
        default: axi_state <= AXI_IDLE;
      endcase
    end
  end

  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      dbg_compute_ready_lat <= 1'b0;
      dbg_compute_done_lat  <= 1'b0;
      dbg_control_register  <= 32'd0;
      dbg_irq_status_reg    <= 32'd0;
      dbg_irq_mask_reg      <= 32'd0;
      dbg_irq_clear_reg     <= 32'd0;
    end else begin
      if (dbg_compute_ready_ap_vld) begin
        dbg_compute_ready_lat <= dbg_compute_ready;
      end
      if (dbg_compute_done_ap_vld) begin
        dbg_compute_done_lat <= dbg_compute_done;
      end
      if (control_reg_ap_vld) begin
        dbg_control_register <= control_reg;
      end
      if (irq_status_reg_ap_vld) begin
        dbg_irq_status_reg <= irq_status_reg;
      end
      if (irq_mask_reg_ap_vld) begin
        dbg_irq_mask_reg <= irq_mask_reg;
      end
      if (irq_clear_reg_ap_vld) begin
        dbg_irq_clear_reg <= irq_clear_reg;
      end
    end
  end

  // Simple BRAM model for compute controller buffers
  always_ff @(posedge ap_clk) begin
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

  // Memory controller respond (mirrors compute_controller_tb.sv)
  always_ff @(posedge ap_clk) begin : MEM_controller_respond
    if (ap_rst) begin
      mem_transfer_done <= 1'b0;
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
            int layer_off;
            layer_off = mem_op[15:8] * 2;
            for (j = 0; j < IN_BUF_BYTES; j = j + 1) begin
              in_buf_mem[j] = 8'd0;
            end

            case (mem_op[7:0])
              CMP_OUT_PROJ: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[OUT_PROJ_ACT_OFFSET + j] = full_valueA[j] + layer_off;
                end
                if ((pending_tile >= 0) && (pending_tile < NUM_WO_TILES)) begin
                  out_base = pending_tile * D_TILE_WO;
                  for (t = 0; t < D_TILE_WO; t = t + 1) begin
                    for (j = 0; j < D_MODEL; j = j + 1) begin
                      write_i4_to_in_buf(
                        (OUT_PROJ_W_OFFSET * 2) + (t * D_MODEL) + j,
                        full_weights[(out_base + t) * D_MODEL + j] + layer_off);
                    end
                  end
                  for (t = 0; t < D_TILE_WO; t = t + 1) begin
                    write_i32_to_in_buf(
                      OUT_PROJ_B_OFFSET + (t * 4),
                      full_bias[out_base + t] + layer_off);
                  end
                end
              end
              CMP_REQUANT1: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  write_i32_to_in_buf(REQUANT_X_OFFSET + (j * 4), rq1_x[j] + layer_off);
                end
                write_i32_to_in_buf(REQUANT_M_OFFSET, rq1_M + layer_off);
                write_i32_to_in_buf(REQUANT_N_OFFSET, rq1_N + layer_off);
                write_i32_to_in_buf(REQUANT_Z_OFFSET, rq1_Z + layer_off);
              end
              CMP_REQUANT2: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  write_i32_to_in_buf(REQUANT_X_OFFSET + (j * 4), rq2_x[j] + layer_off);
                end
                write_i32_to_in_buf(REQUANT_M_OFFSET, rq2_M + layer_off);
                write_i32_to_in_buf(REQUANT_N_OFFSET, rq2_N + layer_off);
                write_i32_to_in_buf(REQUANT_Z_OFFSET, rq2_Z + layer_off);
              end
              CMP_REQUANT3: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  write_i32_to_in_buf(REQUANT_X_OFFSET + (j * 4), rq3_x[j] + layer_off);
                end
                write_i32_to_in_buf(REQUANT_M_OFFSET, rq3_M + layer_off);
                write_i32_to_in_buf(REQUANT_N_OFFSET, rq3_N + layer_off);
                write_i32_to_in_buf(REQUANT_Z_OFFSET, rq3_Z + layer_off);
              end
              CMP_REQUANT4: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  write_i32_to_in_buf(REQUANT_X_OFFSET + (j * 4), rq4_x[j] + layer_off);
                end
                write_i32_to_in_buf(REQUANT_M_OFFSET, rq4_M + layer_off);
                write_i32_to_in_buf(REQUANT_N_OFFSET, rq4_N + layer_off);
                write_i32_to_in_buf(REQUANT_Z_OFFSET, rq4_Z + layer_off);
              end
              CMP_RESID0: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[RESID_X_OFFSET + j] = resid0_x[j] + layer_off;
                  in_buf_mem[RESID_R_OFFSET + j] = resid0_r[j] + layer_off;
                end
              end
              CMP_RESID1: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[RESID_X_OFFSET + j] = resid1_x[j] + layer_off;
                  in_buf_mem[RESID_R_OFFSET + j] = resid1_r[j] + layer_off;
                end
              end
              CMP_LN0: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[LN_X_OFFSET + j] = ln0_x[j] + layer_off;
                  write_i32_to_in_buf(LN_GAMMA_OFFSET + (j * 4), ln0_gamma[j] + layer_off);
                end
                write_i32_to_in_buf(LN_EPS_OFFSET, ln0_eps + layer_off);
              end
              CMP_LN1: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[LN_X_OFFSET + j] = ln1_x[j] + layer_off;
                  write_i32_to_in_buf(LN_GAMMA_OFFSET + (j * 4), ln1_gamma[j] + layer_off);
                end
                write_i32_to_in_buf(LN_EPS_OFFSET, ln1_eps + layer_off);
              end
              CMP_FINAL_NORM: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[LN_X_OFFSET + j] = final_norm_x[j];
                  write_i32_to_in_buf(LN_GAMMA_OFFSET + (j * 4), final_norm_gamma[j]);
                end
                write_i32_to_in_buf(LN_EPS_OFFSET, final_norm_eps);
              end
              CMP_FFN_W1: begin
                for (j = 0; j < D_MODEL; j = j + 1) begin
                  in_buf_mem[FFN_W1_X_OFFSET + j] = ffn1_x[j] + layer_off;
                end
                if ((pending_tile >= 0) && (pending_tile < NUM_W1_TILES)) begin
                  out_base = pending_tile * D_TILE_W1;
                  for (t = 0; t < D_TILE_W1; t = t + 1) begin
                    for (j = 0; j < D_MODEL; j = j + 1) begin
                      write_i4_to_in_buf(
                        (FFN_W1_W_OFFSET * 2) + (t * D_MODEL) + j,
                        ffn1_w[(out_base + t) * D_MODEL + j] + layer_off);
                    end
                  end
                  for (t = 0; t < D_TILE_W1; t = t + 1) begin
                    write_i32_to_in_buf(
                      FFN_W1_B_OFFSET + (t * 4),
                      ffn1_b[out_base + t] + layer_off);
                    write_i16_to_in_buf(
                      FFN_W1_S_OFFSET + (t * 2),
                      ffn1_s[out_base + t] + layer_off);
                  end
                end
              end
              CMP_FFN_ACT: begin
                for (j = 0; j < D_FFN; j = j + 1) begin
                  write_i16_to_in_buf(FFN_ACT_X_OFFSET + (j * 2), ffn_act_in[j] + layer_off);
                end
              end
              CMP_FFN_W2: begin
                for (j = 0; j < D_FFN; j = j + 1) begin
                  write_i16_to_in_buf(FFN_W2_X_OFFSET + (j * 2), ffn2_x[j] + layer_off);
                end
                if ((pending_tile >= 0) && (pending_tile < NUM_W2_TILES)) begin
                  out_base = pending_tile * D_TILE_W2;
                  for (t = 0; t < D_TILE_W2; t = t + 1) begin
                    for (j = 0; j < D_FFN; j = j + 1) begin
                      write_i4_to_in_buf(
                        (FFN_W2_W_OFFSET * 2) + (t * D_FFN) + j,
                        ffn2_w[(out_base + t) * D_FFN + j] + layer_off);
                    end
                  end
                  for (t = 0; t < D_TILE_W2; t = t + 1) begin
                    write_i32_to_in_buf(
                      FFN_W2_B_OFFSET + (t * 4),
                      ffn2_b[out_base + t] + layer_off);
                    write_i16_to_in_buf(
                      FFN_W2_S_OFFSET + (t * 2),
                      ffn2_s[out_base + t] + layer_off);
                  end
                end
              end
              default: begin
              end
            endcase
          end else if (mem_pending == MEM_WRITE) begin
            int out_base;
            int t;
            case (mem_op[7:0])
              CMP_OUT_PROJ: begin
                if ((pending_tile >= 0) && (pending_tile < NUM_WO_TILES)) begin
                  out_base = pending_tile * D_TILE_WO;
                  for (t = 0; t < D_TILE_WO; t = t + 1) begin
                    full_accum[out_base + t] <= read_i32_from_out_buf(t * 4);
                  end
                end
              end
              CMP_REQUANT1: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  rq1_out[t] <= out_buf_mem[t];
                end
              end
              CMP_REQUANT2: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  rq2_out[t] <= out_buf_mem[t];
                end
              end
              CMP_REQUANT3: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  rq3_out[t] <= out_buf_mem[t];
                end
              end
              CMP_REQUANT4: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  rq4_out[t] <= out_buf_mem[t];
                end
              end
              CMP_RESID0: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  resid0_out[t] <= out_buf_mem[t];
                end
              end
              CMP_RESID1: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  resid1_out[t] <= out_buf_mem[t];
                end
              end
              CMP_LN0: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  ln0_out[t] <= read_i32_from_out_buf(t * 4);
                end
              end
              CMP_LN1: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  ln1_out[t] <= read_i32_from_out_buf(t * 4);
                end
              end
              CMP_FINAL_NORM: begin
                for (t = 0; t < D_MODEL; t = t + 1) begin
                  final_norm_out[t] <= read_i32_from_out_buf(t * 4);
                end
              end
              CMP_FFN_W1: begin
                if ((pending_tile >= 0) && (pending_tile < NUM_W1_TILES)) begin
                  out_base = pending_tile * D_TILE_W1;
                  for (t = 0; t < D_TILE_W1; t = t + 1) begin
                    ffn1_out[out_base + t] <= read_i16_from_out_buf(t * 2);
                  end
                end
              end
              CMP_FFN_ACT: begin
                for (t = 0; t < D_FFN; t = t + 1) begin
                  ffn_act_out[t] <= read_i16_from_out_buf(t * 2);
                end
              end
              CMP_FFN_W2: begin
                if ((pending_tile >= 0) && (pending_tile < NUM_W2_TILES)) begin
                  out_base = pending_tile * D_TILE_W2;
                  for (t = 0; t < D_TILE_W2; t = t + 1) begin
                    ffn2_out[out_base + t] <= read_i32_from_out_buf(t * 4);
                  end
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
        if (mem_read_request && mem_read_request_ap_vld) begin
          mem_busy <= 1'b1;
          mem_timer <= MEM_LAT - 1;
          mem_pending <= MEM_READ;
          pending_tile <= mem_op[31:24];
        end else if (mem_write_request && mem_write_request_ap_vld) begin
          mem_busy <= 1'b1;
          mem_timer <= MEM_LAT - 1;
          mem_pending <= MEM_WRITE;
          pending_tile <= mem_op[31:24];
        end
      end
    end
  end

  // Stream model
  always_ff @(posedge ap_clk) begin : stream_model
    if (ap_rst) begin
      stream_busy  <= 1'b0;
      stream_done  <= 1'b0;
      stream_done_hold <= 1'b0;
      stream_done_ctr  <= 0;
      stream_ready <= 1'b0;
    end else begin
      stream_done <= 1'b0;
      if (stream_busy) begin
        stream_busy <= 1'b0;
        stream_done_hold <= 1'b1;
        stream_done_ctr  <= 3'd4; // hold done high for a few extra cycles
      end
      if (stream_done_hold) begin
        stream_done <= 1'b1;
        if (stream_done_ctr == 0) begin
          stream_done_hold <= 1'b0;
        end else begin
          stream_done_ctr <= stream_done_ctr - 1;
        end
      end
      if (stream_start && stream_start_ap_vld && !stream_busy) begin
        stream_busy <= 1'b1;
      end
      stream_ready <= !stream_busy;
    end
  end

  // DMA model: honor DUT wl_start_o and return dma_done after a small latency
  always_ff @(posedge ap_clk) begin : dma_model
    int dma_lat_var;
    if (ap_rst) begin
      dma_busy  <= 1'b0;
      dma_timer <= 0;
      dma_done  <= 1'b0;
      dma_done_hold <= 1'b0;
      dma_done_ctr  <= 0;
      wl_ready <= 1'b0;
    end else begin
      dma_done <= 1'b0;
      wl_ready <= (!dma_busy) && !(wl_start_o && wl_start_o_ap_vld);
      if (dma_busy) begin
        if (dma_timer == 0) begin
          dma_busy <= 1'b0;
          dma_done_hold <= 1'b1;
          dma_done_ctr  <= 3'd4; // hold done high for a few extra cycles
        end else begin
          dma_timer <= dma_timer - 1;
        end
      end
      if (dma_done_hold) begin
        dma_done <= 1'b1;
        if (dma_done_ctr == 0) begin
          dma_done_hold <= 1'b0;
        end else begin
          dma_done_ctr <= dma_done_ctr - 1;
        end
      end
      if (wl_start_o && wl_start_o_ap_vld && wl_instruction_ap_vld && !dma_busy) begin
        dma_busy  <= 1'b1;
        dma_lat_var = rand_dma_lat();
        dma_timer <= (dma_lat_var > 0) ? dma_lat_var - 1 : 0;
        wl_ready <= 1'b0;
      end
    end
  end

  // AXIS ingress driver
  always_ff @(posedge ap_clk) begin : axis_driver
    if (ap_rst) begin
      axis_sent      <= 0;
      axis_feed_done <= 1'b0;
      axis_drive     <= 1'b0;
      axis_in_valid  <= 1'b0;
      axis_in_last   <= 1'b0;
      axis_last_stretch_active <= 1'b0;
      axis_last_stretch_ctr    <= 0;
    end else begin
      // If stretching TLAST, hold valid/last high for 3 cycles total
      if (axis_last_stretch_active) begin
        axis_in_valid <= 1'b1;
        axis_in_last  <= 1'b1;
        if (axis_last_stretch_ctr > 0) begin
          axis_last_stretch_ctr <= axis_last_stretch_ctr - 1;
        end else begin
          axis_last_stretch_active <= 1'b0;
          axis_in_valid <= 1'b0;
          axis_in_last  <= 1'b0;
          axis_feed_done <= 1'b1;
          axis_drive     <= 1'b0;
        end
      end else if (!axis_feed_done && (axis_drive || (ctrl_shadow_control[0] && start_pulsed))) begin
        axis_drive <= 1'b1;
        if (!axis_in_valid && axis_in_ready) begin
          axis_in_valid <= 1'b1;
          axis_in_last  <= (axis_sent == AXIS_BEATS - 1);
          if (axis_sent == AXIS_BEATS - 1) begin
            axis_last_stretch_active <= 1'b1;
            axis_last_stretch_ctr    <= 2; // current cycle + 2 more
          end
        end
      end else begin
        axis_in_valid <= 1'b0;
        axis_in_last  <= 1'b0;
      end

      // Only advance beat count when not in stretch mode
      if (axis_in_valid && axis_in_ready && !axis_last_stretch_active) begin
        axis_sent <= axis_sent + 1;
        axis_in_valid <= 1'b0;
        axis_in_last  <= 1'b0;
        if (axis_sent >= AXIS_BEATS - 1) begin
          axis_feed_done <= 1'b1;
          axis_drive     <= 1'b0;
        end
      end
    end
  end

  // Per-head compute model (separate from main compute)
  // Per-head external handshakes derived from simple latency models
  always_comb begin
    for (int h = 0; h < HEADS_TOTAL; h++) begin
      head_compute_ready[h] = !head_inflight[h];
      head_compute_done[h]  = (head_inflight[h] && (head_busy_ctr[h] == 0)) || head_done_hold[h];
      head_dma_done[h]      = (head_dma_inflight[h] && (head_dma_ctr[h] == 0)) || head_dma_done_hold[h];
    end
  end

  // Pack head_ctx_ref_i with current shadow + computed ready/done + DMA handshakes
  always_comb begin
    head_ctx_t t0, t1, t2, t3;
    t0 = head_ctx_shadow[0];
    t1 = head_ctx_shadow[1];
    t2 = head_ctx_shadow[2];
    t3 = head_ctx_shadow[3];
    t0.compute_ready = head_compute_ready[0];
    t1.compute_ready = head_compute_ready[1];
    t2.compute_ready = head_compute_ready[2];
    t3.compute_ready = head_compute_ready[3];
    t0.wl_ready      = !head_dma_inflight[0] && !head_wl_stall[0] && !head_ctx_ref_0_struct.wl_start;
    t1.wl_ready      = !head_dma_inflight[1] && !head_wl_stall[1] && !head_ctx_ref_1_struct.wl_start;
    t2.wl_ready      = !head_dma_inflight[2] && !head_wl_stall[2] && !head_ctx_ref_2_struct.wl_start;
    t3.wl_ready      = !head_dma_inflight[3] && !head_wl_stall[3] && !head_ctx_ref_3_struct.wl_start;
    t0.compute_done  = head_compute_done[0];
    t1.compute_done  = head_compute_done[1];
    t2.compute_done  = head_compute_done[2];
    t3.compute_done  = head_compute_done[3];
    t0.dma_done      = head_dma_done[0];
    t1.dma_done      = head_dma_done[1];
    t2.dma_done      = head_dma_done[2];
    t3.dma_done      = head_dma_done[3];
    head_ctx_ref_0_i = t0;
    head_ctx_ref_1_i = t1;
    head_ctx_ref_2_i = t2;
    head_ctx_ref_3_i = t3;
  end

  head_ctx_t head_ctx_ref_0_struct;
  head_ctx_t head_ctx_ref_1_struct;
  head_ctx_t head_ctx_ref_2_struct;
  head_ctx_t head_ctx_ref_3_struct;
  assign head_ctx_ref_0_struct = head_ctx_ref_0_o;
  assign head_ctx_ref_1_struct = head_ctx_ref_1_o;
  assign head_ctx_ref_2_struct = head_ctx_ref_2_o;
  assign head_ctx_ref_3_struct = head_ctx_ref_3_o;

  // Capture DUT head_ctx outputs and drive per-head compute/DMA latencies
  generate
    genvar hh;
    for (hh = 0; hh < HEADS_TOTAL; hh++) begin : HEAD_COMPUTE
      always_ff @(posedge ap_clk) begin
        int comp_lat_h;
        int dma_lat_h;
        logic compute_start_now;
        logic dma_start_now;
        logic is_ln_head_op;
        if (ap_rst) begin
          head_ctx_shadow[hh] <= '{
            layer_stamp: 32'd0,
            head_idx: hh,
            phase: 8'd0,
            compute_ready: 1'b0,
            compute_done: 1'b0,
            compute_start: 1'b0,
            last_wl_addr: 8'd0,
            last_compute_op: 32'd0,
            compute_op: 32'd0,
            wl_ready: 1'b0,
            wl_start: 1'b0,
            wl_instruction: 32'd0,
            dma_done: 1'b0,
            start_head: 1'b0,
            q_started: 1'b0,
            k_started: 1'b0,
            v_started: 1'b0,
            att_scores_started: 1'b0,
            val_scale_started: 1'b0,
            softmax_started: 1'b0,
            att_value_started: 1'b0,
            k_requant_started: 1'b0,
            k_writeback_started: 1'b0,
            v_requant_started: 1'b0,
            v_writeback_started: 1'b0,
            requant_q_started: 1'b0,
            head_requant_started: 1'b0,
            q_compute_done: 1'b0,
            k_compute_done: 1'b0,
            v_compute_done: 1'b0,
            att_scores_compute_done: 1'b0,
            val_scale_compute_done: 1'b0,
            softmax_compute_done: 1'b0,
            att_value_compute_done: 1'b0,
            k_requant_compute_done: 1'b0,
            v_requant_compute_done: 1'b0,
            requant_q_compute_done: 1'b0,
            head_requant_compute_done: 1'b0,
            q_dma_done: 1'b0,
            k_dma_done: 1'b0,
            k_writeback_dma_done: 1'b0,
            v_dma_done: 1'b0,
            v_writeback_dma_done: 1'b0,
            att_scores_dma_done: 1'b0,
            att_value_dma_done: 1'b0
          };
          head_busy_ctr[hh] <= 0;
          head_inflight[hh] <= 1'b0;
          head_done_hold[hh] <= 1'b0;
          head_done_ctr[hh] <= 0;
          head_dma_ctr[hh] <= 0;
          head_dma_inflight[hh] <= 1'b0;
          head_dma_done_hold[hh] <= 1'b0;
          head_dma_done_ctr[hh] <= 0;
          head_wl_stall[hh] <= 1'b0;
        end else begin
          if (hh == 0 && head_ctx_ref_0_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_0_struct;
          if (hh == 1 && head_ctx_ref_1_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_1_struct;
          if (hh == 2 && head_ctx_ref_2_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_2_struct;
          if (hh == 3 && head_ctx_ref_3_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_3_struct;

          head_phase_dbg[hh] <= head_ctx_shadow[hh].phase;
          head_op_dbg[hh]    <= head_ctx_shadow[hh].compute_op;
          head_last_op_dbg[hh] <= head_ctx_shadow[hh].last_compute_op;


          compute_start_now = 1'b0;
          dma_start_now     = 1'b0;
          if (hh == 0) begin
            compute_start_now = head_ctx_ref_0_struct.compute_start;
            dma_start_now     = head_ctx_ref_0_struct.wl_start;
          end else if (hh == 1) begin
            compute_start_now = head_ctx_ref_1_struct.compute_start;
            dma_start_now     = head_ctx_ref_1_struct.wl_start;
          end else if (hh == 2) begin
            compute_start_now = head_ctx_ref_2_struct.compute_start;
            dma_start_now     = head_ctx_ref_2_struct.wl_start;
          end else if (hh == 3) begin
            compute_start_now = head_ctx_ref_3_struct.compute_start;
            dma_start_now     = head_ctx_ref_3_struct.wl_start;
          end
          // detect compute_start and run latency model
          if (compute_start_now && !head_inflight[hh] && !head_done_hold[hh]) begin
            head_inflight[hh] <= 1'b1;
            is_ln_head_op = (head_ctx_shadow[hh].compute_op[7:0] >= CMP_LN0_SUM) &&
                            (head_ctx_shadow[hh].compute_op[7:0] <= CMP_LN1_SHIFT);
            comp_lat_h = is_ln_head_op ? 6 : 24;
            head_busy_ctr[hh] <= (comp_lat_h > 0) ? comp_lat_h - 1 : 0;
            head_done_hold[hh] <= 1'b0;
          end else if (head_inflight[hh]) begin
            if (head_busy_ctr[hh] == 0) begin
              head_inflight[hh] <= 1'b0;
              head_done_hold[hh] <= 1'b1;
              head_done_ctr[hh] <= 3'd6;
            end else begin
              head_busy_ctr[hh] <= head_busy_ctr[hh] - 1;
            end
          end else if (head_done_hold[hh]) begin
            if (head_done_ctr[hh] > 1) begin
              head_done_ctr[hh] <= head_done_ctr[hh] - 1;
            end else begin
              head_done_hold[hh] <= 1'b0;
            end
          end

          // Per-head DMA latency model
          if (dma_start_now && !head_dma_inflight[hh] && !head_dma_done_hold[hh]) begin
            head_dma_inflight[hh] <= 1'b1;
            dma_lat_h = rand_dma_lat();
            head_dma_ctr[hh] <= (dma_lat_h > 0) ? dma_lat_h - 1 : 0;
            head_dma_done_hold[hh] <= 1'b0;
            head_wl_stall[hh] <= 1'b1;
          end else if (head_dma_inflight[hh]) begin
            if (head_dma_ctr[hh] == 0) begin
              head_dma_inflight[hh] <= 1'b0;
              head_dma_done_hold[hh] <= 1'b1;
            head_dma_done_ctr[hh] <= 7'd100;
            end else begin
              head_dma_ctr[hh] <= head_dma_ctr[hh] - 1;
            end
          end else if (head_dma_done_hold[hh]) begin
            if (head_dma_done_ctr[hh] > 1) begin
              head_dma_done_ctr[hh] <= head_dma_done_ctr[hh] - 1;
            end else begin
              head_dma_done_hold[hh] <= 1'b0;
            end
          end
          if (head_dma_done[hh]) begin
            head_wl_stall[hh] <= 1'b0;
          end
        end
      end
    end
  endgenerate



  always_ff @(posedge ap_clk) begin : IRQ_TRACKER
    if (ap_rst) begin
      irq_pending <= 1'b0;
      irq_seen_done <= 1'b0;
      irq_seen_error <= 1'b0;
      error_code_lat <= 32'd0;
    end else begin
      if (irq_seen_done_clr) begin
        irq_seen_done <= 1'b0;
      end
      if (irq_seen_error_clr) begin
        irq_seen_error <= 1'b0;
      end
      if (irq_ps) begin
        irq_pending <= 1'b1;
      end
      if (axi_read_valid && (axi_addr == ADDR_STATUS_MEM_DATA_1)) begin
        if (axi_rdata & IRQ_INFER_DONE_BIT) begin
          irq_seen_done <= 1'b1;
        end
        if (axi_rdata & IRQ_ERROR_BIT) begin
          irq_seen_error <= 1'b1;
        end
      end
      if (axi_read_valid && (axi_addr == ADDR_STATUS_MEM_DATA_2)) begin
        error_code_lat <= axi_rdata;
      end
      if (!irq_seen_done && !irq_seen_error && (irq_read_phase == IRQ_RD_DONE)) begin
        irq_pending <= 1'b0;
      end
    end
  end

  always_ff @(posedge ap_clk) begin : IRQ_READER
    if (ap_rst) begin
      irq_req_valid <= 1'b0;
      irq_req_read <= 1'b0;
      irq_req_addr <= 8'd0;
      irq_read_phase <= IRQ_RD_STATUS;
    end else begin
      irq_req_valid <= 1'b0;
      irq_req_read <= 1'b0;
      irq_req_addr <= 8'd0;
      if (irq_pending && !irq_seen_done && !irq_seen_error) begin
        case (irq_read_phase)
          IRQ_RD_STATUS: begin
            irq_req_valid <= 1'b1;
            irq_req_read  <= 1'b1;
            irq_req_addr  <= ADDR_STATUS_MEM_DATA_1; // irq_status
            if (irq_req_fire) begin
              irq_read_phase <= IRQ_RD_STATE;
            end
          end
          IRQ_RD_STATE: begin
            irq_req_valid <= 1'b1;
            irq_req_read  <= 1'b1;
            irq_req_addr  <= ADDR_STATUS_MEM_DATA_0; // status
            if (irq_req_fire) begin
              irq_read_phase <= IRQ_RD_DONE;
            end
          end
          default: begin
            // no-op
          end
        endcase
      end else if (!irq_pending) begin
        irq_read_phase <= IRQ_RD_STATUS;
      end
    end
  end

  always_ff @(posedge ap_clk) begin : HANDLE_IRQ_DONE
    if (ap_rst) begin
      done_req_valid <= 1'b0;
      done_req_write <= 1'b0;
      done_req_addr <= 8'd0;
      done_req_wdata <= 32'd0;
      done_clear_pending <= 1'b0;
      done_clear_cnt <= 2'd0;
      irq_seen_done_clr <= 1'b0;
    end else begin
      done_req_valid <= 1'b0;
      done_req_write <= 1'b0;
      done_req_addr <= 8'd0;
      done_req_wdata <= 32'd0;
      irq_seen_done_clr <= 1'b0;
      if (irq_seen_done) begin
        if (!(status_mem.status & STATUS_IDLE_BIT)) begin
          done_req_valid <= 1'b1;
          done_req_write <= 1'b0;
          done_req_addr  <= ADDR_STATUS_MEM_DATA_0;
        end else begin
          done_req_valid <= 1'b1;
          done_req_write <= 1'b1;
          done_req_addr  <= ctrl_mem_addr(CTRL_MEM_WORD_IRQ_CLEAR);
          done_req_wdata <= 32'h0000_0001;
          if (done_req_fire) begin
            if (!done_clear_pending) begin
              done_clear_pending <= 1'b1;
              done_clear_cnt <= 2'd2;
            end
            if (done_clear_cnt > 0) begin
              done_clear_cnt <= done_clear_cnt - 1'b1;
            end
            if (done_clear_cnt == 1) begin
              done_clear_pending <= 1'b0;
              irq_seen_done_clr <= 1'b1;
            end
          end
        end
      end
    end
  end

  always_ff @(posedge ap_clk) begin : HANDLE_ERROR
    if (ap_rst) begin
      error_req_valid <= 1'b0;
      error_req_write <= 1'b0;
      error_req_read <= 1'b0;
      error_req_addr <= 8'd0;
      error_req_wdata <= 32'd0;
      error_clear_pending <= 1'b0;
      error_clear_cnt <= 2'd0;
      err_phase <= ERR_PHASE_READ;
      err_reload_step <= 5'd0;
      irq_seen_error_clr <= 1'b0;
    end else begin
      error_req_valid <= 1'b0;
      error_req_write <= 1'b0;
      error_req_read <= 1'b0;
      error_req_addr <= 8'd0;
      error_req_wdata <= 32'd0;
      irq_seen_error_clr <= 1'b0;

      if (irq_seen_error) begin
        case (err_phase)
          ERR_PHASE_READ: begin
            error_req_valid <= 1'b1;
            error_req_read  <= 1'b1;
            error_req_addr  <= ADDR_STATUS_MEM_DATA_2; // error_code
            if (error_req_fire) begin
              err_phase <= ERR_PHASE_RELOAD;
              err_reload_step <= 5'd0;
            end
          end
          ERR_PHASE_RELOAD: begin
            error_req_valid <= 1'b1;
            error_req_write <= 1'b1;
            if (error_code_lat == ERR_DMA_ZERO_LEN) begin
              case (err_reload_step)
                5'd0: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_DMA_LAYER_LEN); error_req_wdata <= ctrl_mem.dma_layer_len; end
                5'd1: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_DMA_HEAD_LEN);  error_req_wdata <= ctrl_mem.dma_head_len; end
                5'd2: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_DMA_TILE_LEN);  error_req_wdata <= ctrl_mem.dma_tile_len; end
                5'd3: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_LAYER_STRIDE);  error_req_wdata <= ctrl_mem.layer_stride; end
                5'd4: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_WQ_HEAD_STRIDE); error_req_wdata <= ctrl_mem.wq_head_stride; end
                5'd5: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_WK_HEAD_STRIDE); error_req_wdata <= ctrl_mem.wk_head_stride; end
                5'd6: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_WV_HEAD_STRIDE); error_req_wdata <= ctrl_mem.wv_head_stride; end
                5'd7: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_K_CACHE_STRIDE); error_req_wdata <= ctrl_mem.k_cache_stride; end
                5'd8: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_V_CACHE_STRIDE); error_req_wdata <= ctrl_mem.v_cache_stride; end
                5'd9: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_WO_TILE_STRIDE); error_req_wdata <= ctrl_mem.wo_tile_stride; end
                5'd10: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_W1_TILE_STRIDE); error_req_wdata <= ctrl_mem.w1_tile_stride; end
                default: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_W2_TILE_STRIDE); error_req_wdata <= ctrl_mem.w2_tile_stride; end
              endcase

              // Update Counter for RELOAD
              if (error_req_fire) begin
                if (err_reload_step >= 5'd10) begin
                  err_phase <= ERR_PHASE_CLEAR;
                end else begin
                  err_reload_step <= err_reload_step + 1'b1;
                end
              end
            end else if (error_code_lat == ERR_DMA_ALIGNMENT) begin
              case (err_reload_step)
                5'd0: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_WQ_BASE_LO); error_req_wdata <= ctrl_mem.wq_base_addr[31:0]; end
                5'd1: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_WK_BASE_LO); error_req_wdata <= ctrl_mem.wk_base_addr[31:0]; end
                5'd2: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_WV_BASE_LO); error_req_wdata <= ctrl_mem.wv_base_addr[31:0]; end
                5'd3: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_WO_BASE_LO); error_req_wdata <= ctrl_mem.wo_base_addr[31:0]; end
                5'd4: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_W1_BASE_LO); error_req_wdata <= ctrl_mem.w1_base_addr[31:0]; end
                5'd5: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_W2_BASE_LO); error_req_wdata <= ctrl_mem.w2_base_addr[31:0]; end
                5'd6: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_K_CACHE_LO); error_req_wdata <= ctrl_mem.k_cache_addr[31:0]; end
                default: begin error_req_addr <= ctrl_mem_addr(CTRL_MEM_WORD_V_CACHE_LO); error_req_wdata <= ctrl_mem.v_cache_addr[31:0]; end
              endcase
              
              // Update Counter for RELOAD
              if (error_req_fire) begin
                if (err_reload_step >= 5'd6) begin
                  err_phase <= ERR_PHASE_CLEAR;
                end else begin
                  err_reload_step <= err_reload_step + 1'b1;
                end
              end
            end else begin
              err_phase <= ERR_PHASE_CLEAR;
            end
          end
          ERR_PHASE_CLEAR: begin
            error_req_valid <= 1'b1;
            error_req_write <= 1'b1;
          error_req_addr  <= ctrl_mem_addr(CTRL_MEM_WORD_IRQ_CLEAR);
          error_req_wdata <= 32'h0000_0001;
            if (error_req_fire) begin
              if (!error_clear_pending) begin
                error_clear_pending <= 1'b1;
                error_clear_cnt <= 2'd2;
              end
              if (error_clear_cnt > 0) begin
                error_clear_cnt <= error_clear_cnt - 1'b1;
              end
              if (error_clear_cnt == 1) begin
                error_clear_pending <= 1'b0;
                irq_seen_error_clr <= 1'b1;
                err_phase <= ERR_PHASE_READ;
              end
            end
          end
          default: err_phase <= ERR_PHASE_READ;
        endcase
      end else begin
        err_phase <= ERR_PHASE_READ;
        err_reload_step <= 5'd0;
      end
    end
  end

  always_ff @(posedge ap_clk) begin : START_FSM
    // Default idle control transaction (none)
    ctrl_addr     <= 8'd0;
    ctrl_data_in  <= 32'd0;
    ctrl_read_en  <= 1'b0;
    ctrl_write_en <= 1'b0;
    ctrl_chip_en  <= 1'b0;

    if (irq_req_fire) begin
      ctrl_addr     <= irq_req_addr;
      ctrl_data_in  <= 32'd0;
      ctrl_read_en  <= irq_req_read;
      ctrl_write_en <= 1'b0;
      ctrl_chip_en  <= 1'b1;
      ctrl_gap_cycles <= 1;
    end else if (done_req_fire) begin
      ctrl_addr     <= done_req_addr;
      ctrl_data_in  <= done_req_wdata;
      ctrl_read_en  <= 1'b0;
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
          ctrl_gap_cycles <= 2;
        end
        CTRL_ASSERT_RESET: begin
          ctrl_mem.control <= 32'd0;
          ctrl_shadow_control <= 32'd0;
          ctrl_addr      <= ctrl_mem_addr(CTRL_MEM_WORD_CONTROL);
          ctrl_data_in   <= 32'd0;
          ctrl_write_en  <= 1'b1;
          ctrl_chip_en   <= 1'b1;
          ctrl_stage <= CTRL_DEASSERT_RESET;
          ctrl_gap_cycles <= 3;
        end
        CTRL_DEASSERT_RESET: begin
          ctrl_mem.control <= CTRL_RESETN_BIT;
          ctrl_shadow_control <= CTRL_RESETN_BIT;
          ctrl_addr      <= ctrl_mem_addr(CTRL_MEM_WORD_CONTROL);
          ctrl_data_in   <= CTRL_RESETN_BIT;
          ctrl_write_en  <= 1'b1;
          ctrl_chip_en   <= 1'b1;
          ctrl_stage <= CTRL_PROGRAM_BASES;
          ctrl_gap_cycles <= 3;
        end
        CTRL_PROGRAM_BASES: begin
          // Program control-space fields, one write per step
          ctrl_write_en  <= 1'b1;
          ctrl_chip_en   <= 1'b1;
          case (base_assign_step)
            0: begin
              ctrl_mem.dma_layer_len <= 32'h0000_0100;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_DMA_LAYER_LEN);
              ctrl_data_in <= 32'h0000_0100;
            end
            1: begin
              ctrl_mem.dma_head_len <= 32'h0000_0100;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_DMA_HEAD_LEN);
              ctrl_data_in <= 32'h0000_0100;
            end
            2: begin
              ctrl_mem.dma_tile_len <= 32'h0000_0100;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_DMA_TILE_LEN);
              ctrl_data_in <= 32'h0000_0100;
            end
            3: begin
              ctrl_mem.layer_stride <= 32'h0000_1000;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_LAYER_STRIDE);
              ctrl_data_in <= 32'h0000_1000;
            end
            4: begin
              ctrl_mem.wq_head_stride <= 32'h0000_0100;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_WQ_HEAD_STRIDE);
              ctrl_data_in <= 32'h0000_0100;
            end
            5: begin
              ctrl_mem.wk_head_stride <= 32'h0000_0100;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_WK_HEAD_STRIDE);
              ctrl_data_in <= 32'h0000_0100;
            end
            6: begin
              ctrl_mem.wv_head_stride <= 32'h0000_0100;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_WV_HEAD_STRIDE);
              ctrl_data_in <= 32'h0000_0100;
            end
            7: begin
              ctrl_mem.k_cache_stride <= 32'h0000_0400;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_K_CACHE_STRIDE);
              ctrl_data_in <= 32'h0000_0400;
            end
            8: begin
              ctrl_mem.v_cache_stride <= 32'h0000_0400;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_V_CACHE_STRIDE);
              ctrl_data_in <= 32'h0000_0400;
            end
            9: begin
              ctrl_mem.wo_tile_stride <= 32'h0000_0100;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_WO_TILE_STRIDE);
              ctrl_data_in <= 32'h0000_0100;
            end
            10: begin
              ctrl_mem.w1_tile_stride <= 32'h0000_0300;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_W1_TILE_STRIDE);
              ctrl_data_in <= 32'h0000_0300;
            end
            11: begin
              ctrl_mem.w2_tile_stride <= 32'h0000_0800;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_W2_TILE_STRIDE);
              ctrl_data_in <= 32'h0000_0800;
            end
            12: begin
              ctrl_mem.wq_base_addr <= 64'h0000_0000_1000_0000;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_WQ_BASE_LO);
              ctrl_data_in <= 32'h1000_0000;
            end
            13: begin
              ctrl_mem.wk_base_addr <= 64'h0000_0000_2000_0000;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_WK_BASE_LO);
              ctrl_data_in <= 32'h2000_0000;
            end
            14: begin
              ctrl_mem.wv_base_addr <= 64'h0000_0000_3000_0000;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_WV_BASE_LO);
              ctrl_data_in <= 32'h3000_0000;
            end
            15: begin
              ctrl_mem.k_cache_addr <= 64'h0000_0000_4000_0000;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_K_CACHE_LO);
              ctrl_data_in <= 32'h4000_0000;
            end
            16: begin
              ctrl_mem.v_cache_addr <= 64'h0000_0000_5000_0000;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_V_CACHE_LO);
              ctrl_data_in <= 32'h5000_0000;
            end
            17: begin
              ctrl_mem.wo_base_addr <= 64'h0000_0000_6000_0000;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_WO_BASE_LO);
              ctrl_data_in <= 32'h6000_0000;
            end
            18: begin
              ctrl_mem.w1_base_addr <= 64'h0000_0000_7000_0000;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_W1_BASE_LO);
              ctrl_data_in <= 32'h7000_0000;
            end
            19: begin
              ctrl_mem.w2_base_addr <= 64'h0000_0000_8000_0000;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_W2_BASE_LO);
              ctrl_data_in <= 32'h8000_0000;
            end
            20: begin
              ctrl_mem.irq_mask <= 32'h0000_0006;
              ctrl_addr    <= ctrl_mem_addr(CTRL_MEM_WORD_IRQ_MASK);
              ctrl_data_in <= 32'h0000_0006;
            end
            default: begin end
          endcase
          if (base_assign_step >= 20) begin
            assign_base_addresses <= 1'b1;
            ctrl_stage <= CTRL_ASSERT_AP_START;
          end else begin
            base_assign_step <= base_assign_step + 1;
          end
          ctrl_gap_cycles <= 2;
        end
        CTRL_ASSERT_AP_START: begin
          // ap_start + auto_restart
          ctrl_addr      <= ADDR_AP_CTRL;
          ctrl_data_in   <= 32'h0000_0081;
          ctrl_write_en  <= 1'b1;
          ctrl_chip_en   <= 1'b1;
          ctrl_stage <= CTRL_ASSERT_START;
          ctrl_gap_cycles <= 2;
        end
        CTRL_ASSERT_START: begin
          ctrl_mem.control <= 32'h0000_0003;
          ctrl_shadow_control <= 32'h0000_0003;
          ctrl_addr      <= ctrl_mem_addr(CTRL_MEM_WORD_CONTROL);
          ctrl_data_in   <= 32'h0000_0003;
          ctrl_write_en  <= 1'b1;
          ctrl_chip_en   <= 1'b1;
          reset_released <= 1'b1;
          start_pulsed   <= 1'b1;
          pending_start_clear <= 1'b1;
          ctrl_stage <= CTRL_CLEAR_START;
          ctrl_gap_cycles <= 2;
        end
        CTRL_CLEAR_START: begin
          ctrl_mem.control <= 32'h0000_0001;
          ctrl_shadow_control <= 32'h0000_0001;
          ctrl_addr      <= ctrl_mem_addr(CTRL_MEM_WORD_CONTROL);
          ctrl_data_in   <= 32'h0000_0001;
          ctrl_write_en  <= 1'b1;
          ctrl_chip_en   <= 1'b1;
          pending_start_clear <= 1'b0;
          ctrl_stage <= CTRL_DONE;
          ctrl_gap_cycles <= 2;
        end
        default: begin
          if (irq_seen_done || irq_seen_error || irq_pending) begin
            ctrl_gap_cycles <= 1;
          end else begin
            ctrl_addr     <= ADDR_STATUS_MEM_DATA_0; // status_mem.status
            ctrl_read_en  <= 1'b1;
            ctrl_chip_en  <= 1'b1;
            ctrl_gap_cycles <= 1;
          end
        end
        endcase
      end
  end

  // Main stimulus and control
  initial begin : stimulus
    int cycle;
    
    // Initialize
    ap_rst_n = 1'b0;
    ctrl_mem = '0;
    ctrl_mem.irq_mask = 32'h0000_0006;
    status_mem = '0;
    ctrl_shadow_control = 32'd0;
    ctrl_addr = 8'd0;
    ctrl_data_in = 32'd0;
    ctrl_read_en = 1'b0;
    ctrl_write_en = 1'b0;
    ctrl_chip_en = 1'b0;
    dbg_ctrl_mem = '0;
    ctrl_gap_cycles = 0;
    assign_base_addresses = 1'b0;
    base_assign_step = 0;
    ctrl_stage = CTRL_RESET_MEM;
    wl_start_i = 1'b0;
    start_pulsed = 1'b0;
    pending_start_clear = 1'b0;
    reset_low_written = 1'b0;
    reset_released = 1'b0;
    seen_done = 1'b0;
    post_done_cycles = 0;
    seen_idle_after = 1'b0;
    seen_concat = 1'b0;
    idle_after_done = 0;
    irq_seen_done = 1'b0;
    irq_seen_error = 1'b0;
    irq_pending = 1'b0;
    irq_read_phase = IRQ_RD_STATUS;
    done_clear_pending = 1'b0;
    error_clear_pending = 1'b0;
    done_clear_cnt = 2'd0;
    error_clear_cnt = 2'd0;
    err_phase = ERR_PHASE_READ;
    err_reload_step = 5'd0;

    // Print header
    $display("%-8s %-6s %-6s %-8s | %-12s | %-6s %-6s %-8s | %-8s %-8s | %-8s %-8s %-8s %-10s",
             "Cycle", "Start", "Reset", "Busy", "State",
             "AXIS_v", "AXIS_r", "AXIS_last",
             "WLStart", "DMA_Done",
             "CmpStrt", "CmpRdy", "CmpDone", "CmpOp");

    // Release reset at cycle 2
    repeat(2) @(posedge ap_clk);
    ap_rst_n = 1'b1;
    
    @(posedge ap_clk);

    // Main test loop
    for (cycle = 0; cycle < MAX_CYCLES; cycle++) begin
      @(posedge ap_clk);

      
      
      if (wl_start_o && wl_start_o_ap_vld && (STATE == 32'd6)) begin
        seen_concat <= 1'b1;
      end

      // Print state
      $display("%-8d %-6s %-6s %-8s | %-12s | %-6s %-6s %-8s | %-8s %-8s | %-8s %-8s %-8s 0x%08h",
               cycle,
               (ctrl_shadow_control[1]) ? "1" : "-",
               (ctrl_shadow_control[0]) ? "1" : "-",
               "-" ,
               state_name(STATE),
               axis_in_valid ? "1" : "-",
               axis_in_ready ? "1" : "-",
               axis_in_last ? "1" : "-",
               wl_start_o ? "1" : "-",
               dma_done ? "1" : "-",
               dbg_compute_start ? "1" : "-",
               dbg_compute_ready_lat ? "1" : "-",
               dbg_compute_done_lat ? "1" : "-",
               dbg_compute_instruction);
      
      // Track done signal
      // if (ap_done) begin
      //   seen_done <= 1'b1;
      // end
      
      
      // Exit once we've seen done and IDLE held for 4 cycles
      if (seen_done && seen_idle_after) begin
        break;
      end
    end

    // Check results
    if (!seen_done) begin
      $display("ERROR: DONE never asserted");
      $finish(1);
    end
    if (!seen_idle_after) begin
      $display("ERROR: FSM did not return to IDLE after DONE");
      $finish(1);
    end
    if (!seen_concat) begin
      $display("ERROR: CONCAT DMA request never issued");
      $finish(1);
    end

    $display("\nPASS: DONE observed and FSM returned to IDLE after %0d post-done cycles. Layer=%0d",
             post_done_cycles, 32'd0);
    $finish(0);
  end

  // Helper function to convert state to string
  function string state_name(input [31:0] st);
    case (st)
      32'd0:  return "S_IDLE";
      32'd1:  return "S_STREAM_IN";
      32'd2:  return "S_LAYER_COUNT";
      32'd3:  return "S_LAYER_NORM_0";
      32'd4:  return "S_REQUANT1";
      32'd5:  return "S_ATTENTION_HEADS";
      32'd6:  return "S_HEAD_CONCAT";
      32'd7:  return "S_OUT_PROJECTION";
      32'd8:  return "S_REQUANT2";
      32'd9:  return "S_RES_ADD_1";
      32'd10: return "S_LAYER_NORM_1";
      32'd11: return "S_REQUANT3";
      32'd12: return "S_FFN";
      32'd13: return "S_REQUANT4";
      32'd14: return "S_RES_ADD_2";
      32'd15: return "S_LOOP_CHECK";
      32'd16: return "S_FINAL_NORM";
      32'd17: return "S_STREAM_OUT";
      default: return "UNKNOWN";
    endcase
  endfunction

  function string op_name(input [7:0] op);
    case (op)
      8'd0:  return "NONE";
      8'd1:  return "Q";
      8'd2:  return "K";
      8'd3:  return "K_RQ";
      8'd4:  return "V";
      8'd5:  return "V_RQ";
      8'd6:  return "RQ_Q";
      8'd7:  return "ATT_SCO";
      8'd8:  return "VAL_SCL";
      8'd9:  return "SOFTMAX";
      8'd10: return "ATT_VAL";
      8'd11: return "HEAD_RQ";
      8'd12: return "RESV";
      8'd13: return "CONCAT";
      8'd14: return "OUT_PROJ";
      8'd15: return "RQ1";
      8'd16: return "RESID0";
      8'd17: return "LN0";
      8'd18: return "RQ3";
      8'd19: return "FFN_W1";
      8'd20: return "FFN_ACT";
      8'd21: return "FFN_W2";
      8'd22: return "RQ4";
      8'd23: return "RESID1";
      8'd24: return "LN1";
      8'd25: return "FINAL_NORM";
      8'd26: return "DEQUANT";
      8'd27: return "LOGITS";
      8'd27: return "LN0_SUM";
      8'd28: return "LN0_Q";
      8'd29: return "LN0_MEAN";
      8'd30: return "LN0_EYY";
      8'd31: return "LN0_VAR";
      8'd32: return "LN0_VEPS";
      8'd33: return "LN0_INV";
      8'd34: return "LN0_NORM";
      8'd35: return "LN0_SCL";
      8'd36: return "LN0_SHF";
      8'd37: return "LN1_SUM";
      8'd38: return "LN1_Q";
      8'd39: return "LN1_MEAN";
      8'd40: return "LN1_EYY";
      8'd41: return "LN1_VAR";
      8'd42: return "LN1_VEPS";
      8'd43: return "LN1_INV";
      8'd44: return "LN1_NORM";
      8'd45: return "LN1_SCL";
      8'd46: return "LN1_SHF";
      default: return "UNK";
    endcase
  endfunction

  // DUT instantiation
  transformer_top dut (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .axis_in_valid(axis_in_valid),
    .axis_in_last(axis_in_last),
    .axis_in_ready(axis_in_ready),
    .axis_in_ready_ap_vld(axis_in_ready_ap_vld),
    .dma_done(dma_done),
    .wl_ready(wl_ready),
    .wl_instruction(wl_instruction),
    .wl_instruction_ap_vld(wl_instruction_ap_vld),
    .wl_start_i(wl_start_i),
    .wl_start_o(wl_start_o),
    .wl_start_o_ap_vld(wl_start_o_ap_vld),
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
    .head_ctx_ref_0_i(head_ctx_ref_0_i),
    .head_ctx_ref_0_o(head_ctx_ref_0_o),
    .head_ctx_ref_0_o_ap_vld(head_ctx_ref_0_o_ap_vld),
    .head_ctx_ref_1_i(head_ctx_ref_1_i),
    .head_ctx_ref_1_o(head_ctx_ref_1_o),
    .head_ctx_ref_1_o_ap_vld(head_ctx_ref_1_o_ap_vld),
    .head_ctx_ref_2_i(head_ctx_ref_2_i),
    .head_ctx_ref_2_o(head_ctx_ref_2_o),
    .head_ctx_ref_2_o_ap_vld(head_ctx_ref_2_o_ap_vld),
    .head_ctx_ref_3_i(head_ctx_ref_3_i),
    .head_ctx_ref_3_o(head_ctx_ref_3_o),
    .head_ctx_ref_3_o_ap_vld(head_ctx_ref_3_o_ap_vld),
    .stream_ready(stream_ready),
    .stream_start(stream_start),
    .stream_start_ap_vld(stream_start_ap_vld),
    .stream_done(stream_done),
    .irq_ps(irq_ps),
    .STATE(STATE),
    .STATE_ap_vld(STATE_ap_vld),
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
    .interrupt(interrupt)
  );

endmodule
