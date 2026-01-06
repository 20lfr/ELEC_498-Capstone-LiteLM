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
set cdfgNum 4
set C_modelName {transformer_top}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ axis_in_valid uint 1 regular  }
	{ axis_in_last uint 1 regular  }
	{ axis_in_ready int 1 regular {pointer 1}  }
	{ dma_done uint 1 regular  }
	{ wl_ready uint 1 regular  }
	{ wl_start int 1 regular {pointer 2}  }
	{ wl_addr_sel int 8 regular {pointer 1}  }
	{ wl_layer int 32 regular {pointer 1}  }
	{ wl_head int 32 regular {pointer 1}  }
	{ wl_tile int 32 regular {pointer 1}  }
	{ compute_ready uint 1 regular  }
	{ compute_done uint 1 regular  }
	{ compute_start int 1 regular {pointer 2}  }
	{ compute_op int 32 regular {pointer 1}  }
	{ head_ctx_ref_0 int 283 regular {pointer 2}  }
	{ head_ctx_ref_1 int 283 regular {pointer 2}  }
	{ head_ctx_ref_2 int 283 regular {pointer 2}  }
	{ head_ctx_ref_3 int 283 regular {pointer 2}  }
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
	{ dbg_ctrl_mem int 1056 unused {pointer 0}  }
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
 	{ "Name" : "wl_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READWRITE"} , 
 	{ "Name" : "wl_addr_sel", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_layer", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_head", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_tile", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "compute_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READWRITE"} , 
 	{ "Name" : "compute_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "head_ctx_ref_0", "interface" : "wire", "bitwidth" : 283, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_1", "interface" : "wire", "bitwidth" : 283, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_2", "interface" : "wire", "bitwidth" : 283, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_3", "interface" : "wire", "bitwidth" : 283, "direction" : "READWRITE"} , 
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
 	{ "Name" : "dbg_ctrl_mem", "interface" : "wire", "bitwidth" : 1056, "direction" : "READONLY"} , 
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
 	{ "Name" : "dbg_done", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_error", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 93
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
	{ wl_start_i sc_in sc_lv 1 signal 5 } 
	{ wl_start_o sc_out sc_lv 1 signal 5 } 
	{ wl_start_o_ap_vld sc_out sc_logic 1 outvld 5 } 
	{ wl_addr_sel sc_out sc_lv 8 signal 6 } 
	{ wl_addr_sel_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ wl_layer sc_out sc_lv 32 signal 7 } 
	{ wl_layer_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ wl_head sc_out sc_lv 32 signal 8 } 
	{ wl_head_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ wl_tile sc_out sc_lv 32 signal 9 } 
	{ wl_tile_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ compute_ready sc_in sc_lv 1 signal 10 } 
	{ compute_done sc_in sc_lv 1 signal 11 } 
	{ compute_start_i sc_in sc_lv 1 signal 12 } 
	{ compute_start_o sc_out sc_lv 1 signal 12 } 
	{ compute_start_o_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ compute_op sc_out sc_lv 32 signal 13 } 
	{ compute_op_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ head_ctx_ref_0_i sc_in sc_lv 283 signal 14 } 
	{ head_ctx_ref_0_o sc_out sc_lv 283 signal 14 } 
	{ head_ctx_ref_0_o_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ head_ctx_ref_1_i sc_in sc_lv 283 signal 15 } 
	{ head_ctx_ref_1_o sc_out sc_lv 283 signal 15 } 
	{ head_ctx_ref_1_o_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ head_ctx_ref_2_i sc_in sc_lv 283 signal 16 } 
	{ head_ctx_ref_2_o sc_out sc_lv 283 signal 16 } 
	{ head_ctx_ref_2_o_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ head_ctx_ref_3_i sc_in sc_lv 283 signal 17 } 
	{ head_ctx_ref_3_o sc_out sc_lv 283 signal 17 } 
	{ head_ctx_ref_3_o_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ stream_ready sc_in sc_lv 1 signal 18 } 
	{ stream_start sc_out sc_lv 1 signal 19 } 
	{ stream_start_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ stream_done sc_in sc_lv 1 signal 20 } 
	{ ctrl_addr sc_in sc_lv 32 signal 21 } 
	{ ctrl_data_in sc_in sc_lv 32 signal 22 } 
	{ ctrl_data_out sc_out sc_lv 32 signal 23 } 
	{ ctrl_data_out_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ ctrl_read_en sc_in sc_lv 1 signal 24 } 
	{ ctrl_write_en sc_in sc_lv 1 signal 25 } 
	{ ctrl_chip_en sc_in sc_lv 1 signal 26 } 
	{ ctrl_resetn_in sc_in sc_lv 1 signal 27 } 
	{ irq_ps sc_out sc_lv 1 signal 28 } 
	{ irq_ps_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ dbg_state sc_out sc_lv 32 signal 29 } 
	{ dbg_state_ap_vld sc_out sc_logic 1 outvld 29 } 
	{ dbg_ctrl_mem sc_in sc_lv 1056 signal 30 } 
	{ control_reg sc_out sc_lv 32 signal 31 } 
	{ control_reg_ap_vld sc_out sc_logic 1 outvld 31 } 
	{ irq_status_reg sc_out sc_lv 32 signal 32 } 
	{ irq_status_reg_ap_vld sc_out sc_logic 1 outvld 32 } 
	{ irq_enable_reg sc_out sc_lv 32 signal 33 } 
	{ irq_enable_reg_ap_vld sc_out sc_logic 1 outvld 33 } 
	{ wq_base_addr sc_out sc_lv 32 signal 34 } 
	{ wq_base_addr_ap_vld sc_out sc_logic 1 outvld 34 } 
	{ wk_base_addr sc_out sc_lv 32 signal 35 } 
	{ wk_base_addr_ap_vld sc_out sc_logic 1 outvld 35 } 
	{ wv_base_addr sc_out sc_lv 32 signal 36 } 
	{ wv_base_addr_ap_vld sc_out sc_logic 1 outvld 36 } 
	{ wo_base_addr sc_out sc_lv 32 signal 37 } 
	{ wo_base_addr_ap_vld sc_out sc_logic 1 outvld 37 } 
	{ w1_base_addr sc_out sc_lv 32 signal 38 } 
	{ w1_base_addr_ap_vld sc_out sc_logic 1 outvld 38 } 
	{ w2_base_addr sc_out sc_lv 32 signal 39 } 
	{ w2_base_addr_ap_vld sc_out sc_logic 1 outvld 39 } 
	{ wq_head_stride sc_out sc_lv 32 signal 40 } 
	{ wq_head_stride_ap_vld sc_out sc_logic 1 outvld 40 } 
	{ wk_head_stride sc_out sc_lv 32 signal 41 } 
	{ wk_head_stride_ap_vld sc_out sc_logic 1 outvld 41 } 
	{ wv_head_stride sc_out sc_lv 32 signal 42 } 
	{ wv_head_stride_ap_vld sc_out sc_logic 1 outvld 42 } 
	{ wo_tile_stride sc_out sc_lv 32 signal 43 } 
	{ wo_tile_stride_ap_vld sc_out sc_logic 1 outvld 43 } 
	{ w1_tile_stride sc_out sc_lv 32 signal 44 } 
	{ w1_tile_stride_ap_vld sc_out sc_logic 1 outvld 44 } 
	{ w2_tile_stride sc_out sc_lv 32 signal 45 } 
	{ w2_tile_stride_ap_vld sc_out sc_logic 1 outvld 45 } 
	{ dbg_done sc_out sc_lv 1 signal 46 } 
	{ dbg_done_ap_vld sc_out sc_logic 1 outvld 46 } 
	{ dbg_error sc_out sc_lv 1 signal 47 } 
	{ dbg_error_ap_vld sc_out sc_logic 1 outvld 47 } 
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
 	{ "name": "wl_start_i", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_start", "role": "i" }} , 
 	{ "name": "wl_start_o", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "wl_start", "role": "o" }} , 
 	{ "name": "wl_start_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_start", "role": "o_ap_vld" }} , 
 	{ "name": "wl_addr_sel", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "wl_addr_sel", "role": "default" }} , 
 	{ "name": "wl_addr_sel_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_addr_sel", "role": "ap_vld" }} , 
 	{ "name": "wl_layer", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_layer", "role": "default" }} , 
 	{ "name": "wl_layer_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_layer", "role": "ap_vld" }} , 
 	{ "name": "wl_head", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_head", "role": "default" }} , 
 	{ "name": "wl_head_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_head", "role": "ap_vld" }} , 
 	{ "name": "wl_tile", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "wl_tile", "role": "default" }} , 
 	{ "name": "wl_tile_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "wl_tile", "role": "ap_vld" }} , 
 	{ "name": "compute_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_ready", "role": "default" }} , 
 	{ "name": "compute_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_done", "role": "default" }} , 
 	{ "name": "compute_start_i", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "i" }} , 
 	{ "name": "compute_start_o", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "o" }} , 
 	{ "name": "compute_start_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_start", "role": "o_ap_vld" }} , 
 	{ "name": "compute_op", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_op", "role": "default" }} , 
 	{ "name": "compute_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_op", "role": "ap_vld" }} , 
 	{ "name": "head_ctx_ref_0_i", "direction": "in", "datatype": "sc_lv", "bitwidth":283, "type": "signal", "bundle":{"name": "head_ctx_ref_0", "role": "i" }} , 
 	{ "name": "head_ctx_ref_0_o", "direction": "out", "datatype": "sc_lv", "bitwidth":283, "type": "signal", "bundle":{"name": "head_ctx_ref_0", "role": "o" }} , 
 	{ "name": "head_ctx_ref_0_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_0", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_1_i", "direction": "in", "datatype": "sc_lv", "bitwidth":283, "type": "signal", "bundle":{"name": "head_ctx_ref_1", "role": "i" }} , 
 	{ "name": "head_ctx_ref_1_o", "direction": "out", "datatype": "sc_lv", "bitwidth":283, "type": "signal", "bundle":{"name": "head_ctx_ref_1", "role": "o" }} , 
 	{ "name": "head_ctx_ref_1_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_1", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_2_i", "direction": "in", "datatype": "sc_lv", "bitwidth":283, "type": "signal", "bundle":{"name": "head_ctx_ref_2", "role": "i" }} , 
 	{ "name": "head_ctx_ref_2_o", "direction": "out", "datatype": "sc_lv", "bitwidth":283, "type": "signal", "bundle":{"name": "head_ctx_ref_2", "role": "o" }} , 
 	{ "name": "head_ctx_ref_2_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_2", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_3_i", "direction": "in", "datatype": "sc_lv", "bitwidth":283, "type": "signal", "bundle":{"name": "head_ctx_ref_3", "role": "i" }} , 
 	{ "name": "head_ctx_ref_3_o", "direction": "out", "datatype": "sc_lv", "bitwidth":283, "type": "signal", "bundle":{"name": "head_ctx_ref_3", "role": "o" }} , 
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
 	{ "name": "dbg_ctrl_mem", "direction": "in", "datatype": "sc_lv", "bitwidth":1056, "type": "signal", "bundle":{"name": "dbg_ctrl_mem", "role": "default" }} , 
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
 	{ "name": "dbg_done", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_done", "role": "default" }} , 
 	{ "name": "dbg_done_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_done", "role": "ap_vld" }} , 
 	{ "name": "dbg_error", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_error", "role": "default" }} , 
 	{ "name": "dbg_error_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_error", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	transformer_top {
		axis_in_valid {Type I LastRead 0 FirstWrite -1}
		axis_in_last {Type I LastRead 0 FirstWrite -1}
		axis_in_ready {Type O LastRead -1 FirstWrite 1}
		dma_done {Type I LastRead 0 FirstWrite -1}
		wl_ready {Type I LastRead 0 FirstWrite -1}
		wl_start {Type IO LastRead 0 FirstWrite 1}
		wl_addr_sel {Type O LastRead -1 FirstWrite 2}
		wl_layer {Type O LastRead -1 FirstWrite 1}
		wl_head {Type O LastRead -1 FirstWrite 2}
		wl_tile {Type O LastRead -1 FirstWrite 2}
		compute_ready {Type I LastRead 0 FirstWrite -1}
		compute_done {Type I LastRead 0 FirstWrite -1}
		compute_start {Type IO LastRead 0 FirstWrite 1}
		compute_op {Type O LastRead -1 FirstWrite 2}
		head_ctx_ref_0 {Type IO LastRead 0 FirstWrite 1}
		head_ctx_ref_1 {Type IO LastRead 0 FirstWrite 1}
		head_ctx_ref_2 {Type IO LastRead 0 FirstWrite 1}
		head_ctx_ref_3 {Type IO LastRead 0 FirstWrite 1}
		stream_ready {Type I LastRead 0 FirstWrite -1}
		stream_start {Type O LastRead -1 FirstWrite 1}
		stream_done {Type I LastRead 0 FirstWrite -1}
		ctrl_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_data_in {Type I LastRead 0 FirstWrite -1}
		ctrl_data_out {Type O LastRead -1 FirstWrite 1}
		ctrl_read_en {Type I LastRead 0 FirstWrite -1}
		ctrl_write_en {Type I LastRead 0 FirstWrite -1}
		ctrl_chip_en {Type I LastRead 0 FirstWrite -1}
		ctrl_resetn_in {Type I LastRead 0 FirstWrite -1}
		irq_ps {Type O LastRead -1 FirstWrite 1}
		dbg_state {Type O LastRead -1 FirstWrite 1}
		dbg_ctrl_mem {Type I LastRead -1 FirstWrite -1}
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
		dbg_done {Type O LastRead -1 FirstWrite 1}
		dbg_error {Type O LastRead -1 FirstWrite 1}
		ctrl_mem_control {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_irq_status {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_irq_enable {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wq_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wk_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wv_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wo_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_w1_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_w2_base_addr {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wq_head_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wk_head_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wv_head_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_wo_tile_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_w1_tile_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_w2_tile_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_layer_index {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_status {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_dma_layer_len {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_dma_head_len {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_dma_tile_len {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_layer_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_k_cache_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_v_cache_stride {Type IO LastRead -1 FirstWrite -1}
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
		concat_compute_done {Type IO LastRead -1 FirstWrite -1}
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
		ln0_phase {Type IO LastRead -1 FirstWrite -1}
		ffn_w1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_act_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w2_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_stage {Type IO LastRead -1 FirstWrite -1}
		ffn_started {Type IO LastRead -1 FirstWrite -1}
		resid1_started {Type IO LastRead -1 FirstWrite -1}
		resid1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln1_started {Type IO LastRead -1 FirstWrite -1}
		ln1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln1_phase {Type IO LastRead -1 FirstWrite -1}
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
		w2_comp_busy {Type IO LastRead -1 FirstWrite -1}}
	scheduler_hls {
		ctrl_mem_control {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_layer_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wq_head_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wk_head_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wv_head_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_k_cache_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_v_cache_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wq_base_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wk_base_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wv_base_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_k_cache_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_v_cache_addr {Type I LastRead 0 FirstWrite -1}
		axis_in_valid {Type I LastRead 0 FirstWrite -1}
		axis_in_last {Type I LastRead 0 FirstWrite -1}
		dma_done {Type I LastRead 0 FirstWrite -1}
		wl_ready {Type I LastRead 0 FirstWrite -1}
		wl_start_read {Type I LastRead 0 FirstWrite -1}
		wl_addr_sel {Type O LastRead -1 FirstWrite 2}
		wl_head {Type O LastRead -1 FirstWrite 2}
		wl_tile {Type O LastRead -1 FirstWrite 2}
		compute_ready {Type I LastRead 0 FirstWrite -1}
		compute_done {Type I LastRead 0 FirstWrite -1}
		p_read1 {Type I LastRead 0 FirstWrite -1}
		p_read2 {Type I LastRead 0 FirstWrite -1}
		p_read3 {Type I LastRead 0 FirstWrite -1}
		p_read4 {Type I LastRead 0 FirstWrite -1}
		compute_start_read {Type I LastRead 0 FirstWrite -1}
		compute_op {Type O LastRead -1 FirstWrite 2}
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
		concat_compute_done {Type IO LastRead -1 FirstWrite -1}
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
		ln0_phase {Type IO LastRead -1 FirstWrite -1}
		ffn_w1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_act_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_w2_compute_done {Type IO LastRead -1 FirstWrite -1}
		ffn_stage {Type IO LastRead -1 FirstWrite -1}
		ffn_started {Type IO LastRead -1 FirstWrite -1}
		resid1_started {Type IO LastRead -1 FirstWrite -1}
		resid1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln1_started {Type IO LastRead -1 FirstWrite -1}
		ln1_compute_done {Type IO LastRead -1 FirstWrite -1}
		ln1_phase {Type IO LastRead -1 FirstWrite -1}
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
		w2_comp_busy {Type IO LastRead -1 FirstWrite -1}}
	drive_group_head_phase {
		p_read {Type I LastRead 0 FirstWrite -1}
		p_read1 {Type I LastRead 0 FirstWrite -1}
		p_read2 {Type I LastRead 0 FirstWrite -1}
		p_read3 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read_5 {Type I LastRead 0 FirstWrite -1}
		p_read6 {Type I LastRead 0 FirstWrite -1}
		p_read7 {Type I LastRead 0 FirstWrite -1}
		p_read8 {Type I LastRead 0 FirstWrite -1}
		p_read9 {Type I LastRead 0 FirstWrite -1}
		p_read10 {Type I LastRead 0 FirstWrite -1}
		p_read11 {Type I LastRead 0 FirstWrite -1}
		p_read12 {Type I LastRead 0 FirstWrite -1}
		p_read13 {Type I LastRead 0 FirstWrite -1}
		p_read14 {Type I LastRead 0 FirstWrite -1}
		p_read15 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_last_wl_addr_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_last_wl_addr_read_5 {Type I LastRead 0 FirstWrite -1}
		p_read18 {Type I LastRead 0 FirstWrite -1}
		p_read19 {Type I LastRead 0 FirstWrite -1}
		p_read20 {Type I LastRead 0 FirstWrite -1}
		p_read21 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_wl_addr_sel_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_wl_addr_sel_read_5 {Type I LastRead 0 FirstWrite -1}
		p_read24 {Type I LastRead 0 FirstWrite -1}
		p_read25 {Type I LastRead 0 FirstWrite -1}
		p_read26 {Type I LastRead 0 FirstWrite -1}
		p_read27 {Type I LastRead 0 FirstWrite -1}
		p_read28 {Type I LastRead 0 FirstWrite -1}
		p_read29 {Type I LastRead 0 FirstWrite -1}
		p_read30 {Type I LastRead 0 FirstWrite -1}
		p_read31 {Type I LastRead 0 FirstWrite -1}
		p_read32 {Type I LastRead 0 FirstWrite -1}
		p_read33 {Type I LastRead 0 FirstWrite -1}
		p_read36 {Type I LastRead 0 FirstWrite -1}
		p_read37 {Type I LastRead 0 FirstWrite -1}
		p_read38 {Type I LastRead 0 FirstWrite -1}
		p_read39 {Type I LastRead 0 FirstWrite -1}
		p_read40 {Type I LastRead 0 FirstWrite -1}
		p_read41 {Type I LastRead 0 FirstWrite -1}
		p_read42 {Type I LastRead 0 FirstWrite -1}
		p_read43 {Type I LastRead 0 FirstWrite -1}
		p_read44 {Type I LastRead 0 FirstWrite -1}
		p_read45 {Type I LastRead 0 FirstWrite -1}
		p_read46 {Type I LastRead 0 FirstWrite -1}
		p_read47 {Type I LastRead 0 FirstWrite -1}
		p_read48 {Type I LastRead 0 FirstWrite -1}
		p_read49 {Type I LastRead 0 FirstWrite -1}
		p_read50 {Type I LastRead 0 FirstWrite -1}
		p_read51 {Type I LastRead 0 FirstWrite -1}
		p_read52 {Type I LastRead 0 FirstWrite -1}
		p_read53 {Type I LastRead 0 FirstWrite -1}
		p_read54 {Type I LastRead 0 FirstWrite -1}
		p_read55 {Type I LastRead 0 FirstWrite -1}
		p_read56 {Type I LastRead 0 FirstWrite -1}
		p_read57 {Type I LastRead 0 FirstWrite -1}
		p_read58 {Type I LastRead 0 FirstWrite -1}
		p_read59 {Type I LastRead 0 FirstWrite -1}
		p_read60 {Type I LastRead 0 FirstWrite -1}
		p_read61 {Type I LastRead 0 FirstWrite -1}
		p_read62 {Type I LastRead 0 FirstWrite -1}
		p_read63 {Type I LastRead 0 FirstWrite -1}
		p_read64 {Type I LastRead 0 FirstWrite -1}
		p_read65 {Type I LastRead 0 FirstWrite -1}
		p_read66 {Type I LastRead 0 FirstWrite -1}
		p_read67 {Type I LastRead 0 FirstWrite -1}
		p_read68 {Type I LastRead 0 FirstWrite -1}
		p_read69 {Type I LastRead 0 FirstWrite -1}
		p_read70 {Type I LastRead 0 FirstWrite -1}
		p_read71 {Type I LastRead 0 FirstWrite -1}
		p_read72 {Type I LastRead 0 FirstWrite -1}
		p_read73 {Type I LastRead 0 FirstWrite -1}
		p_read74 {Type I LastRead 0 FirstWrite -1}
		p_read75 {Type I LastRead 0 FirstWrite -1}
		p_read76 {Type I LastRead 0 FirstWrite -1}
		p_read77 {Type I LastRead 0 FirstWrite -1}
		p_read78 {Type I LastRead 0 FirstWrite -1}
		p_read79 {Type I LastRead 0 FirstWrite -1}
		p_read80 {Type I LastRead 0 FirstWrite -1}
		p_read81 {Type I LastRead 0 FirstWrite -1}
		p_read82 {Type I LastRead 0 FirstWrite -1}
		p_read83 {Type I LastRead 0 FirstWrite -1}
		p_read84 {Type I LastRead 0 FirstWrite -1}
		p_read85 {Type I LastRead 0 FirstWrite -1}
		p_read86 {Type I LastRead 0 FirstWrite -1}
		p_read87 {Type I LastRead 0 FirstWrite -1}
		p_read88 {Type I LastRead 0 FirstWrite -1}
		p_read89 {Type I LastRead 0 FirstWrite -1}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		start_r {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_layer_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wq_head_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wk_head_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wv_head_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_k_cache_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_v_cache_stride {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wq_base_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wk_base_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_wv_base_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_k_cache_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_mem_v_cache_addr {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2", "Max" : "5"}
	, {"Name" : "Interval", "Min" : "3", "Max" : "6"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	axis_in_valid { ap_none {  { axis_in_valid in_data 0 1 } } }
	axis_in_last { ap_none {  { axis_in_last in_data 0 1 } } }
	axis_in_ready { ap_vld {  { axis_in_ready out_data 1 1 }  { axis_in_ready_ap_vld out_vld 1 1 } } }
	dma_done { ap_none {  { dma_done in_data 0 1 } } }
	wl_ready { ap_none {  { wl_ready in_data 0 1 } } }
	wl_start { ap_ovld {  { wl_start_i in_data 0 1 }  { wl_start_o out_data 1 1 }  { wl_start_o_ap_vld out_vld 1 1 } } }
	wl_addr_sel { ap_vld {  { wl_addr_sel out_data 1 8 }  { wl_addr_sel_ap_vld out_vld 1 1 } } }
	wl_layer { ap_vld {  { wl_layer out_data 1 32 }  { wl_layer_ap_vld out_vld 1 1 } } }
	wl_head { ap_vld {  { wl_head out_data 1 32 }  { wl_head_ap_vld out_vld 1 1 } } }
	wl_tile { ap_vld {  { wl_tile out_data 1 32 }  { wl_tile_ap_vld out_vld 1 1 } } }
	compute_ready { ap_none {  { compute_ready in_data 0 1 } } }
	compute_done { ap_none {  { compute_done in_data 0 1 } } }
	compute_start { ap_ovld {  { compute_start_i in_data 0 1 }  { compute_start_o out_data 1 1 }  { compute_start_o_ap_vld out_vld 1 1 } } }
	compute_op { ap_vld {  { compute_op out_data 1 32 }  { compute_op_ap_vld out_vld 1 1 } } }
	head_ctx_ref_0 { ap_ovld {  { head_ctx_ref_0_i in_data 0 283 }  { head_ctx_ref_0_o out_data 1 283 }  { head_ctx_ref_0_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_1 { ap_ovld {  { head_ctx_ref_1_i in_data 0 283 }  { head_ctx_ref_1_o out_data 1 283 }  { head_ctx_ref_1_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_2 { ap_ovld {  { head_ctx_ref_2_i in_data 0 283 }  { head_ctx_ref_2_o out_data 1 283 }  { head_ctx_ref_2_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_3 { ap_ovld {  { head_ctx_ref_3_i in_data 0 283 }  { head_ctx_ref_3_o out_data 1 283 }  { head_ctx_ref_3_o_ap_vld out_vld 1 1 } } }
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
	dbg_ctrl_mem { ap_none {  { dbg_ctrl_mem in_data 0 1056 } } }
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
