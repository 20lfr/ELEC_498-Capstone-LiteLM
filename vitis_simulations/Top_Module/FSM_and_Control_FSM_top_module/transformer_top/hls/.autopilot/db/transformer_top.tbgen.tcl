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
	{ compute_ready uint 1 regular  }
	{ compute_done uint 1 regular  }
	{ head_ctx_ref_0 int 202 regular {pointer 2}  }
	{ head_ctx_ref_1 int 202 regular {pointer 2}  }
	{ head_ctx_ref_2 int 202 regular {pointer 2}  }
	{ head_ctx_ref_3 int 202 regular {pointer 2}  }
	{ compute_start int 1 regular {pointer 2}  }
	{ compute_op int 8 regular {pointer 1}  }
	{ stream_ready uint 1 regular  }
	{ stream_start int 1 regular {pointer 1}  }
	{ stream_done uint 1 regular  }
	{ wl_ready uint 1 regular  }
	{ wl_start int 1 regular {pointer 2}  }
	{ wl_addr_sel int 8 regular {pointer 1}  }
	{ wl_layer int 32 regular {pointer 1}  }
	{ wl_head int 32 regular {pointer 1}  }
	{ wl_tile int 32 regular {pointer 1}  }
	{ ctrl_addr int 32 regular  }
	{ ctrl_data_in int 32 regular  }
	{ ctrl_data_out int 32 regular {pointer 1}  }
	{ ctrl_read_en uint 1 regular  }
	{ ctrl_write_en uint 1 regular  }
	{ ctrl_chip_en uint 1 regular  }
	{ ctrl_resetn_in uint 1 regular  }
	{ dbg_state int 32 regular {pointer 1}  }
	{ dbg_ctrl_mem int 864 regular {pointer 1}  }
	{ done uint 1 unused  }
	{ irq_ps int 1 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "axis_in_valid", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "axis_in_last", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "axis_in_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dma_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "head_ctx_ref_0", "interface" : "wire", "bitwidth" : 202, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_1", "interface" : "wire", "bitwidth" : 202, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_2", "interface" : "wire", "bitwidth" : 202, "direction" : "READWRITE"} , 
 	{ "Name" : "head_ctx_ref_3", "interface" : "wire", "bitwidth" : 202, "direction" : "READWRITE"} , 
 	{ "Name" : "compute_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READWRITE"} , 
 	{ "Name" : "compute_op", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "stream_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "stream_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "stream_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "wl_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READWRITE"} , 
 	{ "Name" : "wl_addr_sel", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_layer", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_head", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "wl_tile", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "ctrl_addr", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_data_in", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_data_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "ctrl_read_en", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_write_en", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_chip_en", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "ctrl_resetn_in", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "dbg_state", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_ctrl_mem", "interface" : "wire", "bitwidth" : 864, "direction" : "WRITEONLY"} , 
 	{ "Name" : "done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "irq_ps", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 61
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
	{ compute_ready sc_in sc_lv 1 signal 4 } 
	{ compute_done sc_in sc_lv 1 signal 5 } 
	{ head_ctx_ref_0_i sc_in sc_lv 202 signal 6 } 
	{ head_ctx_ref_0_o sc_out sc_lv 202 signal 6 } 
	{ head_ctx_ref_0_o_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ head_ctx_ref_1_i sc_in sc_lv 202 signal 7 } 
	{ head_ctx_ref_1_o sc_out sc_lv 202 signal 7 } 
	{ head_ctx_ref_1_o_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ head_ctx_ref_2_i sc_in sc_lv 202 signal 8 } 
	{ head_ctx_ref_2_o sc_out sc_lv 202 signal 8 } 
	{ head_ctx_ref_2_o_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ head_ctx_ref_3_i sc_in sc_lv 202 signal 9 } 
	{ head_ctx_ref_3_o sc_out sc_lv 202 signal 9 } 
	{ head_ctx_ref_3_o_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ compute_start_i sc_in sc_lv 1 signal 10 } 
	{ compute_start_o sc_out sc_lv 1 signal 10 } 
	{ compute_start_o_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ compute_op sc_out sc_lv 8 signal 11 } 
	{ compute_op_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ stream_ready sc_in sc_lv 1 signal 12 } 
	{ stream_start sc_out sc_lv 1 signal 13 } 
	{ stream_start_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ stream_done sc_in sc_lv 1 signal 14 } 
	{ wl_ready sc_in sc_lv 1 signal 15 } 
	{ wl_start_i sc_in sc_lv 1 signal 16 } 
	{ wl_start_o sc_out sc_lv 1 signal 16 } 
	{ wl_start_o_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ wl_addr_sel sc_out sc_lv 8 signal 17 } 
	{ wl_addr_sel_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ wl_layer sc_out sc_lv 32 signal 18 } 
	{ wl_layer_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ wl_head sc_out sc_lv 32 signal 19 } 
	{ wl_head_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ wl_tile sc_out sc_lv 32 signal 20 } 
	{ wl_tile_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ ctrl_addr sc_in sc_lv 32 signal 21 } 
	{ ctrl_data_in sc_in sc_lv 32 signal 22 } 
	{ ctrl_data_out sc_out sc_lv 32 signal 23 } 
	{ ctrl_data_out_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ ctrl_read_en sc_in sc_lv 1 signal 24 } 
	{ ctrl_write_en sc_in sc_lv 1 signal 25 } 
	{ ctrl_chip_en sc_in sc_lv 1 signal 26 } 
	{ ctrl_resetn_in sc_in sc_lv 1 signal 27 } 
	{ dbg_state sc_out sc_lv 32 signal 28 } 
	{ dbg_state_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ dbg_ctrl_mem sc_out sc_lv 864 signal 29 } 
	{ dbg_ctrl_mem_ap_vld sc_out sc_logic 1 outvld 29 } 
	{ done sc_in sc_lv 1 signal 30 } 
	{ irq_ps sc_out sc_lv 1 signal 31 } 
	{ irq_ps_ap_vld sc_out sc_logic 1 outvld 31 } 
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
 	{ "name": "compute_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_ready", "role": "default" }} , 
 	{ "name": "compute_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_done", "role": "default" }} , 
 	{ "name": "head_ctx_ref_0_i", "direction": "in", "datatype": "sc_lv", "bitwidth":202, "type": "signal", "bundle":{"name": "head_ctx_ref_0", "role": "i" }} , 
 	{ "name": "head_ctx_ref_0_o", "direction": "out", "datatype": "sc_lv", "bitwidth":202, "type": "signal", "bundle":{"name": "head_ctx_ref_0", "role": "o" }} , 
 	{ "name": "head_ctx_ref_0_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_0", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_1_i", "direction": "in", "datatype": "sc_lv", "bitwidth":202, "type": "signal", "bundle":{"name": "head_ctx_ref_1", "role": "i" }} , 
 	{ "name": "head_ctx_ref_1_o", "direction": "out", "datatype": "sc_lv", "bitwidth":202, "type": "signal", "bundle":{"name": "head_ctx_ref_1", "role": "o" }} , 
 	{ "name": "head_ctx_ref_1_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_1", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_2_i", "direction": "in", "datatype": "sc_lv", "bitwidth":202, "type": "signal", "bundle":{"name": "head_ctx_ref_2", "role": "i" }} , 
 	{ "name": "head_ctx_ref_2_o", "direction": "out", "datatype": "sc_lv", "bitwidth":202, "type": "signal", "bundle":{"name": "head_ctx_ref_2", "role": "o" }} , 
 	{ "name": "head_ctx_ref_2_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_2", "role": "o_ap_vld" }} , 
 	{ "name": "head_ctx_ref_3_i", "direction": "in", "datatype": "sc_lv", "bitwidth":202, "type": "signal", "bundle":{"name": "head_ctx_ref_3", "role": "i" }} , 
 	{ "name": "head_ctx_ref_3_o", "direction": "out", "datatype": "sc_lv", "bitwidth":202, "type": "signal", "bundle":{"name": "head_ctx_ref_3", "role": "o" }} , 
 	{ "name": "head_ctx_ref_3_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "head_ctx_ref_3", "role": "o_ap_vld" }} , 
 	{ "name": "compute_start_i", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "i" }} , 
 	{ "name": "compute_start_o", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "o" }} , 
 	{ "name": "compute_start_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_start", "role": "o_ap_vld" }} , 
 	{ "name": "compute_op", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_op", "role": "default" }} , 
 	{ "name": "compute_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_op", "role": "ap_vld" }} , 
 	{ "name": "stream_ready", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_ready", "role": "default" }} , 
 	{ "name": "stream_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_start", "role": "default" }} , 
 	{ "name": "stream_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "stream_start", "role": "ap_vld" }} , 
 	{ "name": "stream_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_done", "role": "default" }} , 
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
 	{ "name": "ctrl_addr", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ctrl_addr", "role": "default" }} , 
 	{ "name": "ctrl_data_in", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ctrl_data_in", "role": "default" }} , 
 	{ "name": "ctrl_data_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ctrl_data_out", "role": "default" }} , 
 	{ "name": "ctrl_data_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "ctrl_data_out", "role": "ap_vld" }} , 
 	{ "name": "ctrl_read_en", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctrl_read_en", "role": "default" }} , 
 	{ "name": "ctrl_write_en", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctrl_write_en", "role": "default" }} , 
 	{ "name": "ctrl_chip_en", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctrl_chip_en", "role": "default" }} , 
 	{ "name": "ctrl_resetn_in", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ctrl_resetn_in", "role": "default" }} , 
 	{ "name": "dbg_state", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "dbg_state", "role": "default" }} , 
 	{ "name": "dbg_state_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_state", "role": "ap_vld" }} , 
 	{ "name": "dbg_ctrl_mem", "direction": "out", "datatype": "sc_lv", "bitwidth":864, "type": "signal", "bundle":{"name": "dbg_ctrl_mem", "role": "default" }} , 
 	{ "name": "dbg_ctrl_mem_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_ctrl_mem", "role": "ap_vld" }} , 
 	{ "name": "done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "done", "role": "default" }} , 
 	{ "name": "irq_ps", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "irq_ps", "role": "default" }} , 
 	{ "name": "irq_ps_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "irq_ps", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	transformer_top {
		axis_in_valid {Type I LastRead 0 FirstWrite -1}
		axis_in_last {Type I LastRead 0 FirstWrite -1}
		axis_in_ready {Type O LastRead -1 FirstWrite 1}
		dma_done {Type I LastRead 0 FirstWrite -1}
		compute_ready {Type I LastRead 0 FirstWrite -1}
		compute_done {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_0 {Type IO LastRead 0 FirstWrite 1}
		head_ctx_ref_1 {Type IO LastRead 0 FirstWrite 1}
		head_ctx_ref_2 {Type IO LastRead 0 FirstWrite 1}
		head_ctx_ref_3 {Type IO LastRead 0 FirstWrite 1}
		compute_start {Type IO LastRead 0 FirstWrite 1}
		compute_op {Type O LastRead -1 FirstWrite 1}
		stream_ready {Type I LastRead 0 FirstWrite -1}
		stream_start {Type O LastRead -1 FirstWrite 1}
		stream_done {Type I LastRead 0 FirstWrite -1}
		wl_ready {Type I LastRead 0 FirstWrite -1}
		wl_start {Type IO LastRead 0 FirstWrite 1}
		wl_addr_sel {Type O LastRead -1 FirstWrite 1}
		wl_layer {Type O LastRead -1 FirstWrite 1}
		wl_head {Type O LastRead -1 FirstWrite 1}
		wl_tile {Type O LastRead -1 FirstWrite 1}
		ctrl_addr {Type I LastRead 0 FirstWrite -1}
		ctrl_data_in {Type I LastRead 0 FirstWrite -1}
		ctrl_data_out {Type O LastRead -1 FirstWrite 1}
		ctrl_read_en {Type I LastRead 0 FirstWrite -1}
		ctrl_write_en {Type I LastRead 0 FirstWrite -1}
		ctrl_chip_en {Type I LastRead 0 FirstWrite -1}
		ctrl_resetn_in {Type I LastRead 0 FirstWrite -1}
		dbg_state {Type O LastRead -1 FirstWrite 1}
		dbg_ctrl_mem {Type O LastRead -1 FirstWrite 2}
		done {Type I LastRead -1 FirstWrite -1}
		irq_ps {Type O LastRead -1 FirstWrite 2}
		ctrl_mem_control {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_layer_index {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_status {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_irq_status {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_irq_enable {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_dma_layer_len {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_dma_head_len {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_dma_tile_len {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_layer_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_head_stride {Type IO LastRead -1 FirstWrite -1}
		ctrl_mem_tile_stride {Type IO LastRead -1 FirstWrite -1}
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
		axis_in_valid {Type I LastRead 0 FirstWrite -1}
		axis_in_last {Type I LastRead 0 FirstWrite -1}
		wl_ready {Type I LastRead 0 FirstWrite -1}
		wl_start_read {Type I LastRead 0 FirstWrite -1}
		wl_addr_sel {Type O LastRead -1 FirstWrite 1}
		wl_head {Type O LastRead -1 FirstWrite 1}
		wl_tile {Type O LastRead -1 FirstWrite 1}
		dma_done {Type I LastRead 0 FirstWrite -1}
		compute_ready {Type I LastRead 0 FirstWrite -1}
		compute_done {Type I LastRead 0 FirstWrite -1}
		p_read1 {Type I LastRead 0 FirstWrite -1}
		p_read2 {Type I LastRead 0 FirstWrite -1}
		p_read3 {Type I LastRead 0 FirstWrite -1}
		p_read4 {Type I LastRead 0 FirstWrite -1}
		compute_start_read {Type I LastRead 0 FirstWrite -1}
		compute_op {Type O LastRead -1 FirstWrite 1}
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
		head_ctx_ref_head_idx_0_val {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_head_idx_1_val {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_phase_read_5 {Type I LastRead 0 FirstWrite -1}
		p_read4 {Type I LastRead 0 FirstWrite -1}
		p_read13 {Type I LastRead 0 FirstWrite -1}
		p_read14 {Type I LastRead 0 FirstWrite -1}
		p_read15 {Type I LastRead 0 FirstWrite -1}
		p_read16 {Type I LastRead 0 FirstWrite -1}
		p_read17 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_compute_op_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_compute_op_read_5 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_last_compute_op_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_last_compute_op_read_5 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_last_wl_addr_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_last_wl_addr_read_5 {Type I LastRead 0 FirstWrite -1}
		p_read24 {Type I LastRead 0 FirstWrite -1}
		p_read25 {Type I LastRead 0 FirstWrite -1}
		p_read26 {Type I LastRead 0 FirstWrite -1}
		p_read27 {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_wl_addr_sel_read {Type I LastRead 0 FirstWrite -1}
		head_ctx_ref_wl_addr_sel_read_5 {Type I LastRead 0 FirstWrite -1}
		p_read30 {Type I LastRead 0 FirstWrite -1}
		p_read31 {Type I LastRead 0 FirstWrite -1}
		p_read32 {Type I LastRead 0 FirstWrite -1}
		p_read33 {Type I LastRead 0 FirstWrite -1}
		p_read34 {Type I LastRead 0 FirstWrite -1}
		p_read35 {Type I LastRead 0 FirstWrite -1}
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
		p_read90 {Type I LastRead 0 FirstWrite -1}
		p_read91 {Type I LastRead 0 FirstWrite -1}
		layer_idx {Type I LastRead 0 FirstWrite -1}
		start_r {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "3", "Max" : "3"}
	, {"Name" : "Interval", "Min" : "4", "Max" : "4"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	axis_in_valid { ap_none {  { axis_in_valid in_data 0 1 } } }
	axis_in_last { ap_none {  { axis_in_last in_data 0 1 } } }
	axis_in_ready { ap_vld {  { axis_in_ready out_data 1 1 }  { axis_in_ready_ap_vld out_vld 1 1 } } }
	dma_done { ap_none {  { dma_done in_data 0 1 } } }
	compute_ready { ap_none {  { compute_ready in_data 0 1 } } }
	compute_done { ap_none {  { compute_done in_data 0 1 } } }
	head_ctx_ref_0 { ap_ovld {  { head_ctx_ref_0_i in_data 0 202 }  { head_ctx_ref_0_o out_data 1 202 }  { head_ctx_ref_0_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_1 { ap_ovld {  { head_ctx_ref_1_i in_data 0 202 }  { head_ctx_ref_1_o out_data 1 202 }  { head_ctx_ref_1_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_2 { ap_ovld {  { head_ctx_ref_2_i in_data 0 202 }  { head_ctx_ref_2_o out_data 1 202 }  { head_ctx_ref_2_o_ap_vld out_vld 1 1 } } }
	head_ctx_ref_3 { ap_ovld {  { head_ctx_ref_3_i in_data 0 202 }  { head_ctx_ref_3_o out_data 1 202 }  { head_ctx_ref_3_o_ap_vld out_vld 1 1 } } }
	compute_start { ap_ovld {  { compute_start_i in_data 0 1 }  { compute_start_o out_data 1 1 }  { compute_start_o_ap_vld out_vld 1 1 } } }
	compute_op { ap_vld {  { compute_op out_data 1 8 }  { compute_op_ap_vld out_vld 1 1 } } }
	stream_ready { ap_none {  { stream_ready in_data 0 1 } } }
	stream_start { ap_vld {  { stream_start out_data 1 1 }  { stream_start_ap_vld out_vld 1 1 } } }
	stream_done { ap_none {  { stream_done in_data 0 1 } } }
	wl_ready { ap_none {  { wl_ready in_data 0 1 } } }
	wl_start { ap_ovld {  { wl_start_i in_data 0 1 }  { wl_start_o out_data 1 1 }  { wl_start_o_ap_vld out_vld 1 1 } } }
	wl_addr_sel { ap_vld {  { wl_addr_sel out_data 1 8 }  { wl_addr_sel_ap_vld out_vld 1 1 } } }
	wl_layer { ap_vld {  { wl_layer out_data 1 32 }  { wl_layer_ap_vld out_vld 1 1 } } }
	wl_head { ap_vld {  { wl_head out_data 1 32 }  { wl_head_ap_vld out_vld 1 1 } } }
	wl_tile { ap_vld {  { wl_tile out_data 1 32 }  { wl_tile_ap_vld out_vld 1 1 } } }
	ctrl_addr { ap_none {  { ctrl_addr in_data 0 32 } } }
	ctrl_data_in { ap_none {  { ctrl_data_in in_data 0 32 } } }
	ctrl_data_out { ap_vld {  { ctrl_data_out out_data 1 32 }  { ctrl_data_out_ap_vld out_vld 1 1 } } }
	ctrl_read_en { ap_none {  { ctrl_read_en in_data 0 1 } } }
	ctrl_write_en { ap_none {  { ctrl_write_en in_data 0 1 } } }
	ctrl_chip_en { ap_none {  { ctrl_chip_en in_data 0 1 } } }
	ctrl_resetn_in { ap_none {  { ctrl_resetn_in in_data 0 1 } } }
	dbg_state { ap_vld {  { dbg_state out_data 1 32 }  { dbg_state_ap_vld out_vld 1 1 } } }
	dbg_ctrl_mem { ap_vld {  { dbg_ctrl_mem out_data 1 864 }  { dbg_ctrl_mem_ap_vld out_vld 1 1 } } }
	done { ap_none {  { done in_data 0 1 } } }
	irq_ps { ap_vld {  { irq_ps out_data 1 1 }  { irq_ps_ap_vld out_vld 1 1 } } }
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
