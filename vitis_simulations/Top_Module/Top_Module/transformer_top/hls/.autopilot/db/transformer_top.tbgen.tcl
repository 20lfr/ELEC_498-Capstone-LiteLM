set moduleName transformer_top
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 42
set C_modelName {transformer_top}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 129 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict out_buf { MEM_WIDTH 8 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ axis_in_valid uint 1 regular  }
	{ axis_in_last uint 1 regular  }
	{ axis_in_ready int 1 regular {pointer 1}  }
	{ dma_done uint 1 regular  }
	{ wl_ready uint 1 regular  }
	{ wl_instruction int 32 regular {pointer 1}  }
	{ wl_start int 1 regular {pointer 2}  }
	{ mem_transfer_done uint 1 regular  }
	{ mem_read_request int 1 regular {pointer 1}  }
	{ mem_write_request int 1 regular {pointer 1}  }
	{ mem_op int 32 regular {pointer 1}  }
	{ in_buf int 8 regular {array 129 { 1 1 } 1 1 }  }
	{ out_buf int 8 regular {array 64 { 0 0 } 0 1 }  }
	{ head_ctx_ref_0 int 214 regular {pointer 2}  }
	{ head_ctx_ref_1 int 214 regular {pointer 2}  }
	{ head_ctx_ref_2 int 214 regular {pointer 2}  }
	{ head_ctx_ref_3 int 214 regular {pointer 2}  }
	{ stream_ready uint 1 regular  }
	{ stream_start int 1 regular {pointer 1}  }
	{ stream_done uint 1 regular  }
	{ ctrl_addr int 32 regular  }
	{ ctrl_data_in int 32 regular  }
	{ ctrl_data_out int 32 regular {pointer 1}  }
	{ ctrl_read_en uint 1 regular  }
	{ ctrl_write_en uint 1 regular  }
	{ ctrl_chip_en uint 1 regular  }
	{ ctrl_resetn_in uint 1 regular  }
	{ irq_ps int 1 regular {pointer 1}  }
	{ dbg_state int 32 regular {pointer 1}  }
	{ dbg_ctrl_mem int 1056 regular {pointer 1}  }
	{ control_reg int 32 regular {pointer 1}  }
	{ irq_status_reg int 32 regular {pointer 1}  }
	{ irq_enable_reg int 32 regular {pointer 1}  }
	{ wq_base_addr int 32 regular {pointer 1}  }
	{ wk_base_addr int 32 regular {pointer 1}  }
	{ wv_base_addr int 32 regular {pointer 1}  }
	{ wo_base_addr int 32 regular {pointer 1}  }
	{ w1_base_addr int 32 regular {pointer 1}  }
	{ w2_base_addr int 32 regular {pointer 1}  }
	{ wq_head_stride int 32 regular {pointer 1}  }
	{ wk_head_stride int 32 regular {pointer 1}  }
	{ wv_head_stride int 32 regular {pointer 1}  }
	{ wo_tile_stride int 32 regular {pointer 1}  }
	{ w1_tile_stride int 32 regular {pointer 1}  }
	{ w2_tile_stride int 32 regular {pointer 1}  }
	{ dbg_compute_start int 1 regular {pointer 1}  }
	{ dbg_compute_instruction int 32 regular {pointer 1}  }
	{ dbg_compute_ready int 1 regular {pointer 1}  }
	{ dbg_compute_done int 1 regular {pointer 1}  }
	{ dbg_compute_state int 8 regular {pointer 1}  }
	{ dbg_req_instruction int 32 regular {pointer 1}  }
	{ dbg_req_op int 8 regular {pointer 1}  }
	{ dbg_req_layer int 8 regular {pointer 1}  }
	{ dbg_req_head int 8 regular {pointer 1}  }
	{ dbg_req_tile int 8 regular {pointer 1}  }
	{ dbg_mac_start int 1 regular {pointer 1}  }
	{ dbg_mac_ready int 1 regular {pointer 1}  }
	{ dbg_mac_complete int 1 regular {pointer 1}  }
	{ dbg_ctrl_reset_asserted int 1 regular {pointer 1}  }
	{ dbg_done int 1 regular {pointer 1}  }
	{ dbg_error int 1 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "axis_in_valid", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "axis_in_last", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "axis_in_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dma_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_instruction", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READWRITE"} , 
 	{ "Name" : "mem_transfer_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "mem_read_request", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mem_write_request", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mem_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "in_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "out_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "head_ctx_ref_0", "interface" : "wire", "bitwidth" : 214, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_1", "interface" : "wire", "bitwidth" : 214, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_2", "interface" : "wire", "bitwidth" : 214, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_3", "interface" : "wire", "bitwidth" : 214, "direction" : "READWRITE"} , 
 	{ "Name" : "stream_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "stream_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "stream_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_addr", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_data_in", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_data_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "ctrl_read_en", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_write_en", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_chip_en", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_resetn_in", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "irq_ps", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_state", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_ctrl_mem", "interface" : "wire", "bitwidth" : 1056, "direction" : "WRITEONLY"} , 
 	{ "Name" : "control_reg", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "irq_status_reg", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "irq_enable_reg", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wq_base_addr", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wk_base_addr", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wv_base_addr", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wo_base_addr", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w1_base_addr", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w2_base_addr", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wq_head_stride", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wk_head_stride", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wv_head_stride", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wo_tile_stride", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w1_tile_stride", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w2_tile_stride", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_compute_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_compute_instruction", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_compute_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_compute_done", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_compute_state", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_instruction", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_op", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_layer", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_head", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_tile", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_mac_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_mac_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_mac_complete", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_ctrl_reset_asserted", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_done", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_error", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 130
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ axis_in_valid sc_in sc_lv 1 signal 0 } 
	{ axis_in_last sc_in sc_lv 1 signal 1 } 
	{ axis_in_ready sc_out sc_lv 1 signal 2 } 
	{ axis_in_ready_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ dma_done sc_in sc_lv 1 signal 3 } 
	{ wl_ready sc_in sc_lv 1 signal 4 } 
	{ wl_instruction sc_out sc_lv 32 signal 5 } 
	{ wl_instruction_ap_vld sc_out sc_logic 1 outvld 5 } 
	{ wl_start_i sc_in sc_lv 1 signal 6 } 
	{ wl_start_o sc_out sc_lv 1 signal 6 } 
	{ wl_start_o_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ mem_transfer_done sc_in sc_lv 1 signal 7 } 
	{ mem_read_request sc_out sc_lv 1 signal 8 } 
	{ mem_read_request_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ mem_write_request sc_out sc_lv 1 signal 9 } 
	{ mem_write_request_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ mem_op sc_out sc_lv 32 signal 10 } 
	{ mem_op_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ in_buf_address0 sc_out sc_lv 8 signal 11 } 
	{ in_buf_ce0 sc_out sc_logic 1 signal 11 } 
	{ in_buf_q0 sc_in sc_lv 8 signal 11 } 
	{ in_buf_address1 sc_out sc_lv 8 signal 11 } 
	{ in_buf_ce1 sc_out sc_logic 1 signal 11 } 
	{ in_buf_q1 sc_in sc_lv 8 signal 11 } 
	{ out_buf_address0 sc_out sc_lv 6 signal 12 } 
	{ out_buf_ce0 sc_out sc_logic 1 signal 12 } 
	{ out_buf_we0 sc_out sc_logic 1 signal 12 } 
	{ out_buf_d0 sc_out sc_lv 8 signal 12 } 
	{ out_buf_address1 sc_out sc_lv 6 signal 12 } 
	{ out_buf_ce1 sc_out sc_logic 1 signal 12 } 
	{ out_buf_we1 sc_out sc_logic 1 signal 12 } 
	{ out_buf_d1 sc_out sc_lv 8 signal 12 } 
	{ head_ctx_ref_0_i sc_in sc_lv 214 signal 13 } 
	{ head_ctx_ref_0_o sc_out sc_lv 214 signal 13 } 
	{ head_ctx_ref_0_o_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ head_ctx_ref_1_i sc_in sc_lv 214 signal 14 } 
	{ head_ctx_ref_1_o sc_out sc_lv 214 signal 14 } 
	{ head_ctx_ref_1_o_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ head_ctx_ref_2_i sc_in sc_lv 214 signal 15 } 
	{ head_ctx_ref_2_o sc_out sc_lv 214 signal 15 } 
	{ head_ctx_ref_2_o_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ head_ctx_ref_3_i sc_in sc_lv 214 signal 16 } 
	{ head_ctx_ref_3_o sc_out sc_lv 214 signal 16 } 
	{ head_ctx_ref_3_o_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ stream_ready sc_in sc_lv 1 signal 17 } 
	{ stream_start sc_out sc_lv 1 signal 18 } 
	{ stream_start_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ stream_done sc_in sc_lv 1 signal 19 } 
	{ ctrl_addr sc_in sc_lv 32 signal 20 } 
	{ ctrl_data_in sc_in sc_lv 32 signal 21 } 
	{ ctrl_data_out sc_out sc_lv 32 signal 22 } 
	{ ctrl_data_out_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ ctrl_read_en sc_in sc_lv 1 signal 23 } 
	{ ctrl_write_en sc_in sc_lv 1 signal 24 } 
	{ ctrl_chip_en sc_in sc_lv 1 signal 25 } 
	{ ctrl_resetn_in sc_in sc_lv 1 signal 26 } 
	{ irq_ps sc_out sc_lv 1 signal 27 } 
	{ irq_ps_ap_vld sc_out sc_logic 1 outvld 27 } 
	{ dbg_state sc_out sc_lv 32 signal 28 } 
	{ dbg_state_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ dbg_ctrl_mem sc_out sc_lv 1056 signal 29 } 
	{ dbg_ctrl_mem_ap_vld sc_out sc_logic 1 outvld 29 } 
	{ control_reg sc_out sc_lv 32 signal 30 } 
	{ control_reg_ap_vld sc_out sc_logic 1 outvld 30 } 
	{ irq_status_reg sc_out sc_lv 32 signal 31 } 
	{ irq_status_reg_ap_vld sc_out sc_logic 1 outvld 31 } 
	{ irq_enable_reg sc_out sc_lv 32 signal 32 } 
	{ irq_enable_reg_ap_vld sc_out sc_logic 1 outvld 32 } 
	{ wq_base_addr sc_out sc_lv 32 signal 33 } 
	{ wq_base_addr_ap_vld sc_out sc_logic 1 outvld 33 } 
	{ wk_base_addr sc_out sc_lv 32 signal 34 } 
	{ wk_base_addr_ap_vld sc_out sc_logic 1 outvld 34 } 
	{ wv_base_addr sc_out sc_lv 32 signal 35 } 
	{ wv_base_addr_ap_vld sc_out sc_logic 1 outvld 35 } 
	{ wo_base_addr sc_out sc_lv 32 signal 36 } 
	{ wo_base_addr_ap_vld sc_out sc_logic 1 outvld 36 } 
	{ w1_base_addr sc_out sc_lv 32 signal 37 } 
	{ w1_base_addr_ap_vld sc_out sc_logic 1 outvld 37 } 
	{ w2_base_addr sc_out sc_lv 32 signal 38 } 
	{ w2_base_addr_ap_vld sc_out sc_logic 1 outvld 38 } 
	{ wq_head_stride sc_out sc_lv 32 signal 39 } 
	{ wq_head_stride_ap_vld sc_out sc_logic 1 outvld 39 } 
	{ wk_head_stride sc_out sc_lv 32 signal 40 } 
	{ wk_head_stride_ap_vld sc_out sc_logic 1 outvld 40 } 
	{ wv_head_stride sc_out sc_lv 32 signal 41 } 
	{ wv_head_stride_ap_vld sc_out sc_logic 1 outvld 41 } 
	{ wo_tile_stride sc_out sc_lv 32 signal 42 } 
	{ wo_tile_stride_ap_vld sc_out sc_logic 1 outvld 42 } 
	{ w1_tile_stride sc_out sc_lv 32 signal 43 } 
	{ w1_tile_stride_ap_vld sc_out sc_logic 1 outvld 43 } 
	{ w2_tile_stride sc_out sc_lv 32 signal 44 } 
	{ w2_tile_stride_ap_vld sc_out sc_logic 1 outvld 44 } 
	{ dbg_compute_start sc_out sc_lv 1 signal 45 } 
	{ dbg_compute_start_ap_vld sc_out sc_logic 1 outvld 45 } 
	{ dbg_compute_instruction sc_out sc_lv 32 signal 46 } 
	{ dbg_compute_instruction_ap_vld sc_out sc_logic 1 outvld 46 } 
	{ dbg_compute_ready sc_out sc_lv 1 signal 47 } 
	{ dbg_compute_ready_ap_vld sc_out sc_logic 1 outvld 47 } 
	{ dbg_compute_done sc_out sc_lv 1 signal 48 } 
	{ dbg_compute_done_ap_vld sc_out sc_logic 1 outvld 48 } 
	{ dbg_compute_state sc_out sc_lv 8 signal 49 } 
	{ dbg_compute_state_ap_vld sc_out sc_logic 1 outvld 49 } 
	{ dbg_req_instruction sc_out sc_lv 32 signal 50 } 
	{ dbg_req_instruction_ap_vld sc_out sc_logic 1 outvld 50 } 
	{ dbg_req_op sc_out sc_lv 8 signal 51 } 
	{ dbg_req_op_ap_vld sc_out sc_logic 1 outvld 51 } 
	{ dbg_req_layer sc_out sc_lv 8 signal 52 } 
	{ dbg_req_layer_ap_vld sc_out sc_logic 1 outvld 52 } 
	{ dbg_req_head sc_out sc_lv 8 signal 53 } 
	{ dbg_req_head_ap_vld sc_out sc_logic 1 outvld 53 } 
	{ dbg_req_tile sc_out sc_lv 8 signal 54 } 
	{ dbg_req_tile_ap_vld sc_out sc_logic 1 outvld 54 } 
	{ dbg_mac_start sc_out sc_lv 1 signal 55 } 
	{ dbg_mac_start_ap_vld sc_out sc_logic 1 outvld 55 } 
	{ dbg_mac_ready sc_out sc_lv 1 signal 56 } 
	{ dbg_mac_ready_ap_vld sc_out sc_logic 1 outvld 56 } 
	{ dbg_mac_complete sc_out sc_lv 1 signal 57 } 
	{ dbg_mac_complete_ap_vld sc_out sc_logic 1 outvld 57 } 
	{ dbg_ctrl_reset_asserted sc_out sc_lv 1 signal 58 } 
	{ dbg_ctrl_reset_asserted_ap_vld sc_out sc_logic 1 outvld 58 } 
	{ dbg_done sc_out sc_lv 1 signal 59 } 
	{ dbg_done_ap_vld sc_out sc_logic 1 outvld 59 } 
	{ dbg_error sc_out sc_lv 1 signal 60 } 
	{ dbg_error_ap_vld sc_out sc_logic 1 outvld 60 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "axis_in_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "axis_in_valid", "role": "default" }} , 
 	{ "name": "axis_in_last", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "axis_in_last", "role": "default" }} , 
 	{ "name": "axis_in_ready", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "axis_in_ready", "role": "default" }} , 
 	{ "name": "axis_in_ready_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "axis_in_ready", "role": "ap_vld" }} , 
 	{ "name": "dma_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dma_done", "role": "default" }} , 
 	{ "name": "wl_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_ready", "role": "default" }} , 
 	{ "name": "wl_instruction", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_instruction", "role": "default" }} , 
 	{ "name": "wl_instruction_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_instruction", "role": "ap_vld" }} , 
 	{ "name": "wl_start_i", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_start", "role": "i" }} , 
 	{ "name": "wl_start_o", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_start", "role": "o" }} , 
 	{ "name": "wl_start_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_start", "role": "o_ap_vld" }} , 
 	{ "name": "mem_transfer_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_transfer_done", "role": "default" }} , 
 	{ "name": "mem_read_request", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_read_request", "role": "default" }} , 
 	{ "name": "mem_read_request_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem_read_request", "role": "ap_vld" }} , 
 	{ "name": "mem_write_request", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_write_request", "role": "default" }} , 
 	{ "name": "mem_write_request_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem_write_request", "role": "ap_vld" }} , 
 	{ "name": "mem_op", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mem_op", "role": "default" }} , 
 	{ "name": "mem_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem_op", "role": "ap_vld" }} , 
 	{ "name": "in_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "address0" }} , 
 	{ "name": "in_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce0" }} , 
 	{ "name": "in_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q0" }} , 
 	{ "name": "in_buf_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "address1" }} , 
 	{ "name": "in_buf_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce1" }} , 
 	{ "name": "in_buf_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q1" }} , 
 	{ "name": "out_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "out_buf", "role": "address0" }} , 
 	{ "name": "out_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "ce0" }} , 
 	{ "name": "out_buf_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "we0" }} , 
 	{ "name": "out_buf_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_buf", "role": "d0" }} , 
 	{ "name": "out_buf_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "out_buf", "role": "address1" }} , 
 	{ "name": "out_buf_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "ce1" }} , 
 	{ "name": "out_buf_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "we1" }} , 
 	{ "name": "out_buf_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_buf", "role": "d1" }} , 
 	{ "name": "head_ctx_ref_0_i", "direction": "in", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "head_ctx_ref_0", "role": "i" }} , 
 	{ "name": "head_ctx_ref_0_o", "direction": "out", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "head_ctx_ref_0", "role": "o" }} , 
 	{ "name": "head_ctx_ref_0_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_0", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_1_i", "direction": "in", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "head_ctx_ref_1", "role": "i" }} , 
 	{ "name": "head_ctx_ref_1_o", "direction": "out", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "head_ctx_ref_1", "role": "o" }} , 
 	{ "name": "head_ctx_ref_1_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_1", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_2_i", "direction": "in", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "head_ctx_ref_2", "role": "i" }} , 
 	{ "name": "head_ctx_ref_2_o", "direction": "out", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "head_ctx_ref_2", "role": "o" }} , 
 	{ "name": "head_ctx_ref_2_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_2", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_3_i", "direction": "in", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "head_ctx_ref_3", "role": "i" }} , 
 	{ "name": "head_ctx_ref_3_o", "direction": "out", "datatype": "sc_lv", "bitwidth":214, "type": "signal", "bundle":{"name": "head_ctx_ref_3", "role": "o" }} , 
 	{ "name": "head_ctx_ref_3_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_3", "role": "o_ap_vld" }} , 
 	{ "name": "stream_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_ready", "role": "default" }} , 
 	{ "name": "stream_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_start", "role": "default" }} , 
 	{ "name": "stream_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "stream_start", "role": "ap_vld" }} , 
 	{ "name": "stream_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_done", "role": "default" }} , 
 	{ "name": "ctrl_addr", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ctrl_addr", "role": "default" }} , 
 	{ "name": "ctrl_data_in", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ctrl_data_in", "role": "default" }} , 
 	{ "name": "ctrl_data_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ctrl_data_out", "role": "default" }} , 
 	{ "name": "ctrl_data_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "ctrl_data_out", "role": "ap_vld" }} , 
 	{ "name": "ctrl_read_en", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctrl_read_en", "role": "default" }} , 
 	{ "name": "ctrl_write_en", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctrl_write_en", "role": "default" }} , 
 	{ "name": "ctrl_chip_en", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctrl_chip_en", "role": "default" }} , 
 	{ "name": "ctrl_resetn_in", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctrl_resetn_in", "role": "default" }} , 
 	{ "name": "irq_ps", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "irq_ps", "role": "default" }} , 
 	{ "name": "irq_ps_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "irq_ps", "role": "ap_vld" }} , 
 	{ "name": "dbg_state", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "dbg_state", "role": "default" }} , 
 	{ "name": "dbg_state_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_state", "role": "ap_vld" }} , 
 	{ "name": "dbg_ctrl_mem", "direction": "out", "datatype": "sc_lv", "bitwidth":1056, "type": "signal", "bundle":{"name": "dbg_ctrl_mem", "role": "default" }} , 
 	{ "name": "dbg_ctrl_mem_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_ctrl_mem", "role": "ap_vld" }} , 
 	{ "name": "control_reg", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control_reg", "role": "default" }} , 
 	{ "name": "control_reg_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "control_reg", "role": "ap_vld" }} , 
 	{ "name": "irq_status_reg", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "irq_status_reg", "role": "default" }} , 
 	{ "name": "irq_status_reg_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "irq_status_reg", "role": "ap_vld" }} , 
 	{ "name": "irq_enable_reg", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "irq_enable_reg", "role": "default" }} , 
 	{ "name": "irq_enable_reg_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "irq_enable_reg", "role": "ap_vld" }} , 
 	{ "name": "wq_base_addr", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wq_base_addr", "role": "default" }} , 
 	{ "name": "wq_base_addr_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wq_base_addr", "role": "ap_vld" }} , 
 	{ "name": "wk_base_addr", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wk_base_addr", "role": "default" }} , 
 	{ "name": "wk_base_addr_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wk_base_addr", "role": "ap_vld" }} , 
 	{ "name": "wv_base_addr", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wv_base_addr", "role": "default" }} , 
 	{ "name": "wv_base_addr_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wv_base_addr", "role": "ap_vld" }} , 
 	{ "name": "wo_base_addr", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wo_base_addr", "role": "default" }} , 
 	{ "name": "wo_base_addr_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wo_base_addr", "role": "ap_vld" }} , 
 	{ "name": "w1_base_addr", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w1_base_addr", "role": "default" }} , 
 	{ "name": "w1_base_addr_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w1_base_addr", "role": "ap_vld" }} , 
 	{ "name": "w2_base_addr", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w2_base_addr", "role": "default" }} , 
 	{ "name": "w2_base_addr_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w2_base_addr", "role": "ap_vld" }} , 
 	{ "name": "wq_head_stride", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wq_head_stride", "role": "default" }} , 
 	{ "name": "wq_head_stride_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wq_head_stride", "role": "ap_vld" }} , 
 	{ "name": "wk_head_stride", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wk_head_stride", "role": "default" }} , 
 	{ "name": "wk_head_stride_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wk_head_stride", "role": "ap_vld" }} , 
 	{ "name": "wv_head_stride", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wv_head_stride", "role": "default" }} , 
 	{ "name": "wv_head_stride_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wv_head_stride", "role": "ap_vld" }} , 
 	{ "name": "wo_tile_stride", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wo_tile_stride", "role": "default" }} , 
 	{ "name": "wo_tile_stride_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wo_tile_stride", "role": "ap_vld" }} , 
 	{ "name": "w1_tile_stride", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w1_tile_stride", "role": "default" }} , 
 	{ "name": "w1_tile_stride_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w1_tile_stride", "role": "ap_vld" }} , 
 	{ "name": "w2_tile_stride", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w2_tile_stride", "role": "default" }} , 
 	{ "name": "w2_tile_stride_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w2_tile_stride", "role": "ap_vld" }} , 
 	{ "name": "dbg_compute_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_compute_start", "role": "default" }} , 
 	{ "name": "dbg_compute_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_compute_start", "role": "ap_vld" }} , 
 	{ "name": "dbg_compute_instruction", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "dbg_compute_instruction", "role": "default" }} , 
 	{ "name": "dbg_compute_instruction_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_compute_instruction", "role": "ap_vld" }} , 
 	{ "name": "dbg_compute_ready", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_compute_ready", "role": "default" }} , 
 	{ "name": "dbg_compute_ready_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_compute_ready", "role": "ap_vld" }} , 
 	{ "name": "dbg_compute_done", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_compute_done", "role": "default" }} , 
 	{ "name": "dbg_compute_done_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_compute_done", "role": "ap_vld" }} , 
 	{ "name": "dbg_compute_state", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "dbg_compute_state", "role": "default" }} , 
 	{ "name": "dbg_compute_state_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_compute_state", "role": "ap_vld" }} , 
 	{ "name": "dbg_req_instruction", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "dbg_req_instruction", "role": "default" }} , 
 	{ "name": "dbg_req_instruction_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_req_instruction", "role": "ap_vld" }} , 
 	{ "name": "dbg_req_op", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "dbg_req_op", "role": "default" }} , 
 	{ "name": "dbg_req_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_req_op", "role": "ap_vld" }} , 
 	{ "name": "dbg_req_layer", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "dbg_req_layer", "role": "default" }} , 
 	{ "name": "dbg_req_layer_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_req_layer", "role": "ap_vld" }} , 
 	{ "name": "dbg_req_head", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "dbg_req_head", "role": "default" }} , 
 	{ "name": "dbg_req_head_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_req_head", "role": "ap_vld" }} , 
 	{ "name": "dbg_req_tile", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "dbg_req_tile", "role": "default" }} , 
 	{ "name": "dbg_req_tile_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_req_tile", "role": "ap_vld" }} , 
 	{ "name": "dbg_mac_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_mac_start", "role": "default" }} , 
 	{ "name": "dbg_mac_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_mac_start", "role": "ap_vld" }} , 
 	{ "name": "dbg_mac_ready", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_mac_ready", "role": "default" }} , 
 	{ "name": "dbg_mac_ready_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_mac_ready", "role": "ap_vld" }} , 
 	{ "name": "dbg_mac_complete", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_mac_complete", "role": "default" }} , 
 	{ "name": "dbg_mac_complete_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_mac_complete", "role": "ap_vld" }} , 
 	{ "name": "dbg_ctrl_reset_asserted", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_ctrl_reset_asserted", "role": "default" }} , 
 	{ "name": "dbg_ctrl_reset_asserted_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_ctrl_reset_asserted", "role": "ap_vld" }} , 
 	{ "name": "dbg_done", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_done", "role": "default" }} , 
 	{ "name": "dbg_done_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_done", "role": "ap_vld" }} , 
 	{ "name": "dbg_error", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_error", "role": "default" }} , 
 	{ "name": "dbg_error_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_error", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	transformer_top {
		axis_in_valid {Type I LastRead 0 FirstWrite -1}
		axis_in_last {Type I LastRead 0 FirstWrite -1}
		axis_in_ready {Type O LastRead -1 FirstWrite 2}
		dma_done {Type I LastRead 0 FirstWrite -1}
		wl_ready {Type I LastRead 0 FirstWrite -1}
		wl_instruction {Type O LastRead -1 FirstWrite 1}
		wl_start {Type IO LastRead 1 FirstWrite 2}
		mem_transfer_done {Type I LastRead 0 FirstWrite -1}
		mem_read_request {Type O LastRead -1 FirstWrite 27}
		mem_write_request {Type O LastRead -1 FirstWrite 27}
		mem_op {Type O LastRead -1 FirstWrite 27}
		in_buf {Type I LastRead 2 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}
		head_ctx_ref_0 {Type IO LastRead 1 FirstWrite 2}
		head_ctx_ref_1 {Type IO LastRead 1 FirstWrite 2}
		head_ctx_ref_2 {Type IO LastRead 1 FirstWrite 2}
		head_ctx_ref_3 {Type IO LastRead 1 FirstWrite 2}
		stream_ready {Type I LastRead 0 FirstWrite -1}
		stream_start {Type O LastRead -1 FirstWrite 2}
		stream_done {Type I LastRead 0 FirstWrite -1}
		ctrl_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_data_in {Type I LastRead 0 FirstWrite -1}
		ctrl_data_out {Type O LastRead -1 FirstWrite 4}
		ctrl_read_en {Type I LastRead 0 FirstWrite -1}
		ctrl_write_en {Type I LastRead 0 FirstWrite -1}
		ctrl_chip_en {Type I LastRead 0 FirstWrite -1}
		ctrl_resetn_in {Type I LastRead 0 FirstWrite -1}
		irq_ps {Type O LastRead -1 FirstWrite 4}
		dbg_state {Type O LastRead -1 FirstWrite 2}
		dbg_ctrl_mem {Type O LastRead -1 FirstWrite 0}
		control_reg {Type O LastRead -1 FirstWrite 0}
		irq_status_reg {Type O LastRead -1 FirstWrite 0}
		irq_enable_reg {Type O LastRead -1 FirstWrite 0}
		wq_base_addr {Type O LastRead -1 FirstWrite 0}
		wk_base_addr {Type O LastRead -1 FirstWrite 0}
		wv_base_addr {Type O LastRead -1 FirstWrite 0}
		wo_base_addr {Type O LastRead -1 FirstWrite 0}
		w1_base_addr {Type O LastRead -1 FirstWrite 0}
		w2_base_addr {Type O LastRead -1 FirstWrite 0}
		wq_head_stride {Type O LastRead -1 FirstWrite 0}
		wk_head_stride {Type O LastRead -1 FirstWrite 0}
		wv_head_stride {Type O LastRead -1 FirstWrite 0}
		wo_tile_stride {Type O LastRead -1 FirstWrite 0}
		w1_tile_stride {Type O LastRead -1 FirstWrite 0}
		w2_tile_stride {Type O LastRead -1 FirstWrite 0}
		dbg_compute_start {Type O LastRead -1 FirstWrite 5}
		dbg_compute_instruction {Type O LastRead -1 FirstWrite 5}
		dbg_compute_ready {Type O LastRead -1 FirstWrite 5}
		dbg_compute_done {Type O LastRead -1 FirstWrite 5}
		dbg_compute_state {Type O LastRead -1 FirstWrite 4}
		dbg_req_instruction {Type O LastRead -1 FirstWrite 4}
		dbg_req_op {Type O LastRead -1 FirstWrite 4}
		dbg_req_layer {Type O LastRead -1 FirstWrite 4}
		dbg_req_head {Type O LastRead -1 FirstWrite 4}
		dbg_req_tile {Type O LastRead -1 FirstWrite 4}
		dbg_mac_start {Type O LastRead -1 FirstWrite 27}
		dbg_mac_ready {Type O LastRead -1 FirstWrite 27}
		dbg_mac_complete {Type O LastRead -1 FirstWrite 27}
		dbg_ctrl_reset_asserted {Type O LastRead -1 FirstWrite 0}
		dbg_done {Type O LastRead -1 FirstWrite 4}
		dbg_error {Type O LastRead -1 FirstWrite 4}
		ctrl_mem_control {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_layer_index {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_status {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_irq_status {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_irq_enable {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_dma_layer_len {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_dma_head_len {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_dma_tile_len {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_layer_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wq_head_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wk_head_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wv_head_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_k_cache_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_v_cache_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wo_tile_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_w1_tile_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_w2_tile_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wq_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wk_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wv_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wo_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_w1_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_w2_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_k_cache_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_v_cache_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_logit_scale_qv {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_scale_q {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_zero_point_q {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_scale_k {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_zero_point_k {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_scale_v {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_zero_point_v {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_reserved_debug {Type IO LastRead -1 FirstWrite -1}
		compute_ready {Type IO LastRead -1 FirstWrite -1}
		compute_done {Type IO LastRead -1 FirstWrite -1}
		compute_start {Type IO LastRead -1 FirstWrite -1}
		compute_instruction {Type IO LastRead -1 FirstWrite -1}
		st {Type IO LastRead -1 FirstWrite -1}
		layer_idx {Type IO LastRead -1 FirstWrite -1}
		attn_started {Type IO LastRead -1 FirstWrite -1}
		group_idx {Type IO LastRead -1 FirstWrite -1}
		start_head_group {Type IO LastRead -1 FirstWrite -1}
		requant1_started {Type IO LastRead -1 FirstWrite -1}
		requant2_started {Type IO LastRead -1 FirstWrite -1}
		requant3_started {Type IO LastRead -1 FirstWrite -1}
		requant4_started {Type IO LastRead -1 FirstWrite -1}
		requant1_compute_done {Type IO LastRead -1 FirstWrite -1}
		requant2_compute_done {Type IO LastRead -1 FirstWrite -1}
		requant3_compute_done {Type IO LastRead -1 FirstWrite -1}
		requant4_compute_done {Type IO LastRead -1 FirstWrite -1}
		concat_dma_done {Type IO LastRead -1 FirstWrite -1}
		concat_started {Type IO LastRead -1 FirstWrite -1}
		outproj_started {Type IO LastRead -1 FirstWrite -1}
		outproj_compute_done {Type IO LastRead -1 FirstWrite -1}
		wo_dma_done {Type IO LastRead -1 FirstWrite -1}
		w1_dma_done {Type IO LastRead -1 FirstWrite -1}
		w2_dma_done {Type IO LastRead -1 FirstWrite -1}
		resid0_started {Type IO LastRead -1 FirstWrite -1}
		resid0_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln0_started {Type IO LastRead -1 FirstWrite -1}
		ln0_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_act_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w2_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_stage {Type IO LastRead -1 FirstWrite -1}
		ffn_started {Type IO LastRead -1 FirstWrite -1}
		resid1_started {Type IO LastRead -1 FirstWrite -1}
		resid1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln1_started {Type IO LastRead -1 FirstWrite -1}
		ln1_compute_done {Type IO LastRead -1 FirstWrite -1}
		final_norm_started {Type IO LastRead -1 FirstWrite -1}
		final_norm_compute_done {Type IO LastRead -1 FirstWrite -1}
		axis_last_seen {Type IO LastRead -1 FirstWrite -1}
		stream_done_seen {Type IO LastRead -1 FirstWrite -1}
		stream_started {Type IO LastRead -1 FirstWrite -1}
		wo_tile {Type IO LastRead -1 FirstWrite -1}
		wo_dma_busy {Type IO LastRead -1 FirstWrite -1}
		wo_comp_busy {Type IO LastRead -1 FirstWrite -1}
		w1_tile {Type IO LastRead -1 FirstWrite -1}
		w1_dma_busy {Type IO LastRead -1 FirstWrite -1}
		w1_comp_busy {Type IO LastRead -1 FirstWrite -1}
		w2_tile {Type IO LastRead -1 FirstWrite -1}
		w2_dma_busy {Type IO LastRead -1 FirstWrite -1}
		w2_comp_busy {Type IO LastRead -1 FirstWrite -1}
		state {Type IO LastRead -1 FirstWrite -1}
		req_instruction {Type IO LastRead -1 FirstWrite -1}
		req_op {Type IO LastRead -1 FirstWrite -1}
		mac_ready {Type IO LastRead -1 FirstWrite -1}
		mac_complete {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_64 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_63 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_62 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_61 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_79 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_78 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_77 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_76 {Type IO LastRead -1 FirstWrite -1}
		req_layer_idx {Type IO LastRead -1 FirstWrite -1}
		req_head_idx {Type IO LastRead -1 FirstWrite -1}
		req_tile_idx {Type IO LastRead -1 FirstWrite -1}
		capture_pending {Type IO LastRead -1 FirstWrite -1}
		clear_pending {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_128 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_60 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_75 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_19 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_18 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_17 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_16 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_15 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_14 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_13 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_12 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_11 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_10 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_35 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_34 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_33 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_32 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_31 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_30 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_9 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_8 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_7 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_6 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_5 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_4 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_3 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_2 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_1 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_17 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_16 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_15 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_14 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_13 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_12 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_29 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_28 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_27 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_26 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_25 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_24 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_23 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_22 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_21 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_20 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_53 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_52 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_51 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_50 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_49 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_48 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60 {Type IO LastRead -1 FirstWrite -1}
		busy {Type IO LastRead -1 FirstWrite -1}
		compute_done_1 {Type IO LastRead -1 FirstWrite -1}}
	scheduler_hls {
		ctrl_mem_control {Type I LastRead 0 FirstWrite -1}
		axis_in_valid {Type I LastRead 0 FirstWrite -1}
		axis_in_last {Type I LastRead 0 FirstWrite -1}
		dma_done {Type I LastRead 0 FirstWrite -1}
		wl_ready {Type I LastRead 0 FirstWrite -1}
		wl_instruction {Type O LastRead -1 FirstWrite 1}
		wl_start_read {Type I LastRead 0 FirstWrite -1}
		compute_ready {Type I LastRead 0 FirstWrite -1}
		compute_done {Type I LastRead 0 FirstWrite -1}
		p_read1 {Type I LastRead 0 FirstWrite -1}
		p_read2 {Type I LastRead 0 FirstWrite -1}
		p_read3 {Type I LastRead 0 FirstWrite -1}
		p_read4 {Type I LastRead 0 FirstWrite -1}
		stream_ready {Type I LastRead 0 FirstWrite -1}
		stream_done {Type I LastRead 0 FirstWrite -1}
		st {Type IO LastRead -1 FirstWrite -1}
		layer_idx {Type IO LastRead -1 FirstWrite -1}
		attn_started {Type IO LastRead -1 FirstWrite -1}
		group_idx {Type IO LastRead -1 FirstWrite -1}
		start_head_group {Type IO LastRead -1 FirstWrite -1}
		requant1_started {Type IO LastRead -1 FirstWrite -1}
		requant2_started {Type IO LastRead -1 FirstWrite -1}
		requant3_started {Type IO LastRead -1 FirstWrite -1}
		requant4_started {Type IO LastRead -1 FirstWrite -1}
		requant1_compute_done {Type IO LastRead -1 FirstWrite -1}
		requant2_compute_done {Type IO LastRead -1 FirstWrite -1}
		requant3_compute_done {Type IO LastRead -1 FirstWrite -1}
		requant4_compute_done {Type IO LastRead -1 FirstWrite -1}
		concat_dma_done {Type IO LastRead -1 FirstWrite -1}
		concat_started {Type IO LastRead -1 FirstWrite -1}
		outproj_started {Type IO LastRead -1 FirstWrite -1}
		outproj_compute_done {Type IO LastRead -1 FirstWrite -1}
		wo_dma_done {Type IO LastRead -1 FirstWrite -1}
		w1_dma_done {Type IO LastRead -1 FirstWrite -1}
		w2_dma_done {Type IO LastRead -1 FirstWrite -1}
		resid0_started {Type IO LastRead -1 FirstWrite -1}
		resid0_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln0_started {Type IO LastRead -1 FirstWrite -1}
		ln0_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_act_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w2_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_stage {Type IO LastRead -1 FirstWrite -1}
		ffn_started {Type IO LastRead -1 FirstWrite -1}
		resid1_started {Type IO LastRead -1 FirstWrite -1}
		resid1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln1_started {Type IO LastRead -1 FirstWrite -1}
		ln1_compute_done {Type IO LastRead -1 FirstWrite -1}
		final_norm_started {Type IO LastRead -1 FirstWrite -1}
		final_norm_compute_done {Type IO LastRead -1 FirstWrite -1}
		axis_last_seen {Type IO LastRead -1 FirstWrite -1}
		stream_done_seen {Type IO LastRead -1 FirstWrite -1}
		stream_started {Type IO LastRead -1 FirstWrite -1}
		wo_tile {Type IO LastRead -1 FirstWrite -1}
		wo_dma_busy {Type IO LastRead -1 FirstWrite -1}
		wo_comp_busy {Type IO LastRead -1 FirstWrite -1}
		w1_tile {Type IO LastRead -1 FirstWrite -1}
		w1_dma_busy {Type IO LastRead -1 FirstWrite -1}
		w1_comp_busy {Type IO LastRead -1 FirstWrite -1}
		w2_tile {Type IO LastRead -1 FirstWrite -1}
		w2_dma_busy {Type IO LastRead -1 FirstWrite -1}
		w2_comp_busy {Type IO LastRead -1 FirstWrite -1}
		compute_start {Type IO LastRead 0 FirstWrite 1}
		compute_instruction {Type O LastRead -1 FirstWrite 1}}
	compute_controller {
		ctrl_mem_control {Type I LastRead 0 FirstWrite -1}
		compute_start {Type I LastRead 0 FirstWrite -1}
		compute_instruction {Type I LastRead 0 FirstWrite -1}
		mem_transfer_done {Type I LastRead 0 FirstWrite -1}
		mem_read_request {Type O LastRead -1 FirstWrite 27}
		mem_write_request {Type O LastRead -1 FirstWrite 27}
		mem_op {Type O LastRead -1 FirstWrite 27}
		in_buf {Type I LastRead 2 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}
		dbg_mac_start {Type O LastRead -1 FirstWrite 27}
		dbg_mac_ready {Type O LastRead -1 FirstWrite 27}
		dbg_mac_complete {Type O LastRead -1 FirstWrite 27}
		state {Type IO LastRead -1 FirstWrite -1}
		req_instruction {Type IO LastRead -1 FirstWrite -1}
		req_op {Type IO LastRead -1 FirstWrite -1}
		mac_ready {Type IO LastRead -1 FirstWrite -1}
		mac_complete {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_64 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_63 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_62 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_61 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_79 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_78 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_77 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_76 {Type IO LastRead -1 FirstWrite -1}
		req_layer_idx {Type IO LastRead -1 FirstWrite -1}
		req_head_idx {Type IO LastRead -1 FirstWrite -1}
		req_tile_idx {Type IO LastRead -1 FirstWrite -1}
		capture_pending {Type IO LastRead -1 FirstWrite -1}
		clear_pending {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_128 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_60 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_75 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_19 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_18 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_17 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_16 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_15 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_14 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_13 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_12 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_11 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_10 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_35 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_34 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_33 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_32 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_31 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_30 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_9 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_8 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_7 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_6 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_5 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_4 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_3 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_2 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_1 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_17 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_16 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_15 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_14 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_13 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_12 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_29 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_28 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_27 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_26 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_25 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_24 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_23 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_22 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_21 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_20 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_53 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_52 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_51 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_50 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_49 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_48 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60 {Type IO LastRead -1 FirstWrite -1}
		busy {Type IO LastRead -1 FirstWrite -1}
		compute_done_1 {Type IO LastRead -1 FirstWrite -1}
		compute_done {Type O LastRead -1 FirstWrite 27}
		compute_ready {Type O LastRead -1 FirstWrite 27}}
	compute_controller_Pipeline_VITIS_LOOP_654_36 {
		in_buf {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_638_34 {
		in_buf {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_575_25 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_530_21 {
		in_buf {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_456_12 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_663_38_VITIS_LOOP_664_39 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_676_40 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_128 {Type O LastRead -1 FirstWrite 3}}
	read_i32 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		byte_addr {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_684_42 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_128 {Type I LastRead 0 FirstWrite -1}
		in_buf {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_271_out {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_272_out {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_273_out {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_274_out {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_64 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_63 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_62 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_61 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_60 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_697_44 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_279 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_271_reload {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_272_reload {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_273_reload {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_274_reload {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_280 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}
	compute_controller_Pipeline_VITIS_LOOP_163_1 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_142 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_141 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_140 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_139 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_59 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_58 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_57 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_56 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_55 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_54 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_646_35 {
		out_buf {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_138 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_137 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_136 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_135 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_134 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_133 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_65 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_64 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_63 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_62 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_61 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_60 {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_580_26 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type O LastRead -1 FirstWrite 0}}
	compute_controller_Pipeline_VITIS_LOOP_584_27_VITIS_LOOP_585_28 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_597_29 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 {Type O LastRead -1 FirstWrite 3}}
	read_i32 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		byte_addr {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_605_31 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_128 {Type I LastRead 0 FirstWrite -1}
		in_buf {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_183_out {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_184_out {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_185_out {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_186_out {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_64 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_63 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_62 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_61 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_620_33 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_183_reload {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_184_reload {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_185_reload {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_186_reload {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_551_23 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6 {Type O LastRead -1 FirstWrite 2}}
	read_i32 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		byte_addr {Type I LastRead 0 FirstWrite -1}}
	RMS_NORM {
		epsilon {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90 {Type I LastRead 41 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11 {Type I LastRead 41 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10 {Type I LastRead 41 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9 {Type I LastRead 41 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8 {Type I LastRead 41 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7 {Type I LastRead 41 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6 {Type I LastRead 41 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_19 {Type O LastRead -1 FirstWrite 41}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_18 {Type O LastRead -1 FirstWrite 41}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_17 {Type O LastRead -1 FirstWrite 41}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_16 {Type O LastRead -1 FirstWrite 41}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_15 {Type O LastRead -1 FirstWrite 41}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_14 {Type O LastRead -1 FirstWrite 41}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_13 {Type O LastRead -1 FirstWrite 41}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_12 {Type O LastRead -1 FirstWrite 41}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_11 {Type O LastRead -1 FirstWrite 41}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_10 {Type O LastRead -1 FirstWrite 41}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_35 {Type O LastRead -1 FirstWrite 41}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_34 {Type O LastRead -1 FirstWrite 41}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_33 {Type O LastRead -1 FirstWrite 41}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_32 {Type O LastRead -1 FirstWrite 41}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_31 {Type O LastRead -1 FirstWrite 41}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_30 {Type O LastRead -1 FirstWrite 41}}
	RMS_NORM_Pipeline_VITIS_LOOP_123_1 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_431 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_432 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_433 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_434 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_435 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_436 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_437 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_438 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_439 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_440 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_234 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_235 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_236 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_237 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_238 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_239 {Type I LastRead 0 FirstWrite -1}
		square_out {Type O LastRead -1 FirstWrite 2}}
	sqrt_fixed_32_19_s {
		x {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_567_24 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_163 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_164 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_165 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_166 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_167 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_168 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_169 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_170 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_171 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_172 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_84 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_85 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_86 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_87 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_88 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_89 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}
	RES_ADD {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_74 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_73 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_72 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_71 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_70 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_69 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_68 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_67 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_66 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_65 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_5 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_3 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_1 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_9 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_8 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_7 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_6 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_5 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_4 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_3 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_2 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_1 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool {Type O LastRead -1 FirstWrite 0}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_17 {Type O LastRead -1 FirstWrite 0}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_16 {Type O LastRead -1 FirstWrite 0}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_15 {Type O LastRead -1 FirstWrite 0}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_14 {Type O LastRead -1 FirstWrite 0}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_13 {Type O LastRead -1 FirstWrite 0}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_12 {Type O LastRead -1 FirstWrite 0}}
	compute_controller_Pipeline_VITIS_LOOP_541_22 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_153 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_154 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_155 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_156 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_157 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_158 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_159 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_160 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_161 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_162 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_78 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_79 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_80 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_81 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_82 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_83 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}
	compute_controller_Pipeline_VITIS_LOOP_506_19 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 {Type O LastRead -1 FirstWrite 3}}
	read_i32 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		byte_addr {Type I LastRead 0 FirstWrite -1}}
	REQUANT_D_MODEL_int32_to_int8 {
		M {Type I LastRead 0 FirstWrite -1}
		n {Type I LastRead 0 FirstWrite -1}
		z_out {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_29 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_28 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_27 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_26 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_25 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_24 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_23 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_22 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_21 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_20 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_53 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_52 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_51 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_50 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_49 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_48 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_521_20 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_143 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_144 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_145 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_146 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_147 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_148 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_149 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_150 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_151 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_152 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_72 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_73 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_74 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_75 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_76 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_77 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}
	compute_controller_Pipeline_VITIS_LOOP_42_2 {
		acc {Type I LastRead 0 FirstWrite -1}
		acc_3_out {Type O LastRead -1 FirstWrite 6}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type I LastRead 1 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_461_13 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type O LastRead -1 FirstWrite 0}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type O LastRead -1 FirstWrite 0}}
	compute_controller_Pipeline_VITIS_LOOP_465_14_VITIS_LOOP_466_15 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_478_16 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 {Type O LastRead -1 FirstWrite 3}}
	read_i32 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		byte_addr {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_493_18 {
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_129 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_130 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_131 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_132 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}
	compute_controller_Pipeline_VITIS_LOOP_42_21 {
		acc_2 {Type I LastRead 0 FirstWrite -1}
		acc_7_out {Type O LastRead -1 FirstWrite 6}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type I LastRead 1 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_42_22 {
		acc_6 {Type I LastRead 0 FirstWrite -1}
		acc_11_out {Type O LastRead -1 FirstWrite 6}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type I LastRead 1 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_42_23 {
		acc_10 {Type I LastRead 0 FirstWrite -1}
		acc_15_out {Type O LastRead -1 FirstWrite 6}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type I LastRead 1 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_42_24 {
		acc_14 {Type I LastRead 0 FirstWrite -1}
		acc_18_out {Type O LastRead -1 FirstWrite 6}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_81 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_59 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_80 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_57 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_29 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_56 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_28 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_55 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_27 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_54 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_26 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_53 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_52 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_24 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_51 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_89 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_50 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_88 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_58 {Type I LastRead 0 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_87 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_86 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_22 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_85 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_21 {Type I LastRead 1 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_84 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_20 {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_83 {Type I LastRead 3 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_19 {Type I LastRead 3 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_82 {Type I LastRead 1 FirstWrite -1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_18 {Type I LastRead 1 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_398_11 {
		out_buf {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "7", "Max" : "239"}
	, {"Name" : "Interval", "Min" : "8", "Max" : "240"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	axis_in_valid { ap_none {  { axis_in_valid in_data 0 1 } } }
	axis_in_last { ap_none {  { axis_in_last in_data 0 1 } } }
	axis_in_ready { ap_vld {  { axis_in_ready out_data 1 1 }  { axis_in_ready_ap_vld out_vld 1 1 } } }
	dma_done { ap_none {  { dma_done in_data 0 1 } } }
	wl_ready { ap_none {  { wl_ready in_data 0 1 } } }
	wl_instruction { ap_vld {  { wl_instruction out_data 1 32 }  { wl_instruction_ap_vld out_vld 1 1 } } }
	wl_start { ap_ovld {  { wl_start_i in_data 0 1 }  { wl_start_o out_data 1 1 }  { wl_start_o_ap_vld out_vld 1 1 } } }
	mem_transfer_done { ap_none {  { mem_transfer_done in_data 0 1 } } }
	mem_read_request { ap_vld {  { mem_read_request out_data 1 1 }  { mem_read_request_ap_vld out_vld 1 1 } } }
	mem_write_request { ap_vld {  { mem_write_request out_data 1 1 }  { mem_write_request_ap_vld out_vld 1 1 } } }
	mem_op { ap_vld {  { mem_op out_data 1 32 }  { mem_op_ap_vld out_vld 1 1 } } }
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 8 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 }  { in_buf_address1 MemPortADDR2 1 8 }  { in_buf_ce1 MemPortCE2 1 1 }  { in_buf_q1 MemPortDOUT2 0 8 } } }
	out_buf { ap_memory {  { out_buf_address0 mem_address 1 6 }  { out_buf_ce0 mem_ce 1 1 }  { out_buf_we0 mem_we 1 1 }  { out_buf_d0 mem_din 1 8 }  { out_buf_address1 MemPortADDR2 1 6 }  { out_buf_ce1 MemPortCE2 1 1 }  { out_buf_we1 MemPortWE2 1 1 }  { out_buf_d1 MemPortDIN2 1 8 } } }
	head_ctx_ref_0 { ap_ovld {  { head_ctx_ref_0_i in_data 0 214 }  { head_ctx_ref_0_o out_data 1 214 }  { head_ctx_ref_0_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_1 { ap_ovld {  { head_ctx_ref_1_i in_data 0 214 }  { head_ctx_ref_1_o out_data 1 214 }  { head_ctx_ref_1_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_2 { ap_ovld {  { head_ctx_ref_2_i in_data 0 214 }  { head_ctx_ref_2_o out_data 1 214 }  { head_ctx_ref_2_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_3 { ap_ovld {  { head_ctx_ref_3_i in_data 0 214 }  { head_ctx_ref_3_o out_data 1 214 }  { head_ctx_ref_3_o_ap_vld out_vld 1 1 } } }
	stream_ready { ap_none {  { stream_ready in_data 0 1 } } }
	stream_start { ap_vld {  { stream_start out_data 1 1 }  { stream_start_ap_vld out_vld 1 1 } } }
	stream_done { ap_none {  { stream_done in_data 0 1 } } }
	ctrl_addr { ap_none {  { ctrl_addr in_data 0 32 } } }
	ctrl_data_in { ap_none {  { ctrl_data_in in_data 0 32 } } }
	ctrl_data_out { ap_vld {  { ctrl_data_out out_data 1 32 }  { ctrl_data_out_ap_vld out_vld 1 1 } } }
	ctrl_read_en { ap_none {  { ctrl_read_en in_data 0 1 } } }
	ctrl_write_en { ap_none {  { ctrl_write_en in_data 0 1 } } }
	ctrl_chip_en { ap_none {  { ctrl_chip_en in_data 0 1 } } }
	ctrl_resetn_in { ap_none {  { ctrl_resetn_in in_data 0 1 } } }
	irq_ps { ap_vld {  { irq_ps out_data 1 1 }  { irq_ps_ap_vld out_vld 1 1 } } }
	dbg_state { ap_vld {  { dbg_state out_data 1 32 }  { dbg_state_ap_vld out_vld 1 1 } } }
	dbg_ctrl_mem { ap_vld {  { dbg_ctrl_mem out_data 1 1056 }  { dbg_ctrl_mem_ap_vld out_vld 1 1 } } }
	control_reg { ap_vld {  { control_reg out_data 1 32 }  { control_reg_ap_vld out_vld 1 1 } } }
	irq_status_reg { ap_vld {  { irq_status_reg out_data 1 32 }  { irq_status_reg_ap_vld out_vld 1 1 } } }
	irq_enable_reg { ap_vld {  { irq_enable_reg out_data 1 32 }  { irq_enable_reg_ap_vld out_vld 1 1 } } }
	wq_base_addr { ap_vld {  { wq_base_addr out_data 1 32 }  { wq_base_addr_ap_vld out_vld 1 1 } } }
	wk_base_addr { ap_vld {  { wk_base_addr out_data 1 32 }  { wk_base_addr_ap_vld out_vld 1 1 } } }
	wv_base_addr { ap_vld {  { wv_base_addr out_data 1 32 }  { wv_base_addr_ap_vld out_vld 1 1 } } }
	wo_base_addr { ap_vld {  { wo_base_addr out_data 1 32 }  { wo_base_addr_ap_vld out_vld 1 1 } } }
	w1_base_addr { ap_vld {  { w1_base_addr out_data 1 32 }  { w1_base_addr_ap_vld out_vld 1 1 } } }
	w2_base_addr { ap_vld {  { w2_base_addr out_data 1 32 }  { w2_base_addr_ap_vld out_vld 1 1 } } }
	wq_head_stride { ap_vld {  { wq_head_stride out_data 1 32 }  { wq_head_stride_ap_vld out_vld 1 1 } } }
	wk_head_stride { ap_vld {  { wk_head_stride out_data 1 32 }  { wk_head_stride_ap_vld out_vld 1 1 } } }
	wv_head_stride { ap_vld {  { wv_head_stride out_data 1 32 }  { wv_head_stride_ap_vld out_vld 1 1 } } }
	wo_tile_stride { ap_vld {  { wo_tile_stride out_data 1 32 }  { wo_tile_stride_ap_vld out_vld 1 1 } } }
	w1_tile_stride { ap_vld {  { w1_tile_stride out_data 1 32 }  { w1_tile_stride_ap_vld out_vld 1 1 } } }
	w2_tile_stride { ap_vld {  { w2_tile_stride out_data 1 32 }  { w2_tile_stride_ap_vld out_vld 1 1 } } }
	dbg_compute_start { ap_vld {  { dbg_compute_start out_data 1 1 }  { dbg_compute_start_ap_vld out_vld 1 1 } } }
	dbg_compute_instruction { ap_vld {  { dbg_compute_instruction out_data 1 32 }  { dbg_compute_instruction_ap_vld out_vld 1 1 } } }
	dbg_compute_ready { ap_vld {  { dbg_compute_ready out_data 1 1 }  { dbg_compute_ready_ap_vld out_vld 1 1 } } }
	dbg_compute_done { ap_vld {  { dbg_compute_done out_data 1 1 }  { dbg_compute_done_ap_vld out_vld 1 1 } } }
	dbg_compute_state { ap_vld {  { dbg_compute_state out_data 1 8 }  { dbg_compute_state_ap_vld out_vld 1 1 } } }
	dbg_req_instruction { ap_vld {  { dbg_req_instruction out_data 1 32 }  { dbg_req_instruction_ap_vld out_vld 1 1 } } }
	dbg_req_op { ap_vld {  { dbg_req_op out_data 1 8 }  { dbg_req_op_ap_vld out_vld 1 1 } } }
	dbg_req_layer { ap_vld {  { dbg_req_layer out_data 1 8 }  { dbg_req_layer_ap_vld out_vld 1 1 } } }
	dbg_req_head { ap_vld {  { dbg_req_head out_data 1 8 }  { dbg_req_head_ap_vld out_vld 1 1 } } }
	dbg_req_tile { ap_vld {  { dbg_req_tile out_data 1 8 }  { dbg_req_tile_ap_vld out_vld 1 1 } } }
	dbg_mac_start { ap_vld {  { dbg_mac_start out_data 1 1 }  { dbg_mac_start_ap_vld out_vld 1 1 } } }
	dbg_mac_ready { ap_vld {  { dbg_mac_ready out_data 1 1 }  { dbg_mac_ready_ap_vld out_vld 1 1 } } }
	dbg_mac_complete { ap_vld {  { dbg_mac_complete out_data 1 1 }  { dbg_mac_complete_ap_vld out_vld 1 1 } } }
	dbg_ctrl_reset_asserted { ap_vld {  { dbg_ctrl_reset_asserted out_data 1 1 }  { dbg_ctrl_reset_asserted_ap_vld out_vld 1 1 } } }
	dbg_done { ap_vld {  { dbg_done out_data 1 1 }  { dbg_done_ap_vld out_vld 1 1 } } }
	dbg_error { ap_vld {  { dbg_error out_data 1 1 }  { dbg_error_ap_vld out_vld 1 1 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
