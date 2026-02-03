set moduleName headed_compute_controller
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
set cdfgNum 34
set C_modelName {headed_compute_controller}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 80 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict out_buf { MEM_WIDTH 8 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ reset uint 1 regular  }
	{ compute_start uint 1 regular  }
	{ compute_instruction int 32 regular  }
	{ compute_ready int 1 regular {pointer 1}  }
	{ compute_done int 1 regular {pointer 1}  }
	{ mem_transfer_done uint 1 regular  }
	{ mem_read_request int 1 regular {pointer 1}  }
	{ mem_write_request int 1 regular {pointer 1}  }
	{ mem_op int 32 regular {pointer 1}  }
	{ in_buf int 8 regular {array 80 { 1 1 } 1 1 }  }
	{ out_buf int 8 regular {array 64 { 0 0 } 0 1 }  }
	{ dbg_state int 8 regular {pointer 1}  }
	{ dbg_req_instruction int 32 regular {pointer 1}  }
	{ dbg_req_op int 8 regular {pointer 1}  }
	{ dbg_req_layer int 8 regular {pointer 1}  }
	{ dbg_req_head int 8 regular {pointer 1}  }
	{ dbg_req_tile int 8 regular {pointer 1}  }
	{ error int 1 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "reset", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_instruction", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "compute_done", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mem_transfer_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "mem_read_request", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mem_write_request", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mem_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "in_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "out_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_state", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_instruction", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_op", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_layer", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_head", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_req_tile", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "error", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 48
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ reset sc_in sc_lv 1 signal 0 } 
	{ compute_start sc_in sc_lv 1 signal 1 } 
	{ compute_instruction sc_in sc_lv 32 signal 2 } 
	{ compute_ready sc_out sc_lv 1 signal 3 } 
	{ compute_ready_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ compute_done sc_out sc_lv 1 signal 4 } 
	{ compute_done_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ mem_transfer_done sc_in sc_lv 1 signal 5 } 
	{ mem_read_request sc_out sc_lv 1 signal 6 } 
	{ mem_read_request_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ mem_write_request sc_out sc_lv 1 signal 7 } 
	{ mem_write_request_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ mem_op sc_out sc_lv 32 signal 8 } 
	{ mem_op_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ in_buf_address0 sc_out sc_lv 7 signal 9 } 
	{ in_buf_ce0 sc_out sc_logic 1 signal 9 } 
	{ in_buf_q0 sc_in sc_lv 8 signal 9 } 
	{ in_buf_address1 sc_out sc_lv 7 signal 9 } 
	{ in_buf_ce1 sc_out sc_logic 1 signal 9 } 
	{ in_buf_q1 sc_in sc_lv 8 signal 9 } 
	{ out_buf_address0 sc_out sc_lv 6 signal 10 } 
	{ out_buf_ce0 sc_out sc_logic 1 signal 10 } 
	{ out_buf_we0 sc_out sc_logic 1 signal 10 } 
	{ out_buf_d0 sc_out sc_lv 8 signal 10 } 
	{ out_buf_address1 sc_out sc_lv 6 signal 10 } 
	{ out_buf_ce1 sc_out sc_logic 1 signal 10 } 
	{ out_buf_we1 sc_out sc_logic 1 signal 10 } 
	{ out_buf_d1 sc_out sc_lv 8 signal 10 } 
	{ dbg_state sc_out sc_lv 8 signal 11 } 
	{ dbg_state_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ dbg_req_instruction sc_out sc_lv 32 signal 12 } 
	{ dbg_req_instruction_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ dbg_req_op sc_out sc_lv 8 signal 13 } 
	{ dbg_req_op_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ dbg_req_layer sc_out sc_lv 8 signal 14 } 
	{ dbg_req_layer_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ dbg_req_head sc_out sc_lv 8 signal 15 } 
	{ dbg_req_head_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ dbg_req_tile sc_out sc_lv 8 signal 16 } 
	{ dbg_req_tile_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ error sc_out sc_lv 1 signal 17 } 
	{ error_ap_vld sc_out sc_logic 1 outvld 17 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "reset", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "reset", "role": "default" }} , 
 	{ "name": "compute_start", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "default" }} , 
 	{ "name": "compute_instruction", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_instruction", "role": "default" }} , 
 	{ "name": "compute_ready", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_ready", "role": "default" }} , 
 	{ "name": "compute_ready_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_ready", "role": "ap_vld" }} , 
 	{ "name": "compute_done", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_done", "role": "default" }} , 
 	{ "name": "compute_done_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_done", "role": "ap_vld" }} , 
 	{ "name": "mem_transfer_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_transfer_done", "role": "default" }} , 
 	{ "name": "mem_read_request", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_read_request", "role": "default" }} , 
 	{ "name": "mem_read_request_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem_read_request", "role": "ap_vld" }} , 
 	{ "name": "mem_write_request", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_write_request", "role": "default" }} , 
 	{ "name": "mem_write_request_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem_write_request", "role": "ap_vld" }} , 
 	{ "name": "mem_op", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mem_op", "role": "default" }} , 
 	{ "name": "mem_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem_op", "role": "ap_vld" }} , 
 	{ "name": "in_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "in_buf", "role": "address0" }} , 
 	{ "name": "in_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce0" }} , 
 	{ "name": "in_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q0" }} , 
 	{ "name": "in_buf_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "in_buf", "role": "address1" }} , 
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
 	{ "name": "dbg_state", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "dbg_state", "role": "default" }} , 
 	{ "name": "dbg_state_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_state", "role": "ap_vld" }} , 
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
 	{ "name": "error", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "error", "role": "default" }} , 
 	{ "name": "error_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "error", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	headed_compute_controller {
		reset {Type I LastRead 0 FirstWrite -1}
		compute_start {Type I LastRead 0 FirstWrite -1}
		compute_instruction {Type I LastRead 0 FirstWrite -1}
		compute_ready {Type O LastRead -1 FirstWrite 9}
		compute_done {Type O LastRead -1 FirstWrite 9}
		mem_transfer_done {Type I LastRead 0 FirstWrite -1}
		mem_read_request {Type O LastRead -1 FirstWrite 9}
		mem_write_request {Type O LastRead -1 FirstWrite 9}
		mem_op {Type O LastRead -1 FirstWrite 9}
		in_buf {Type I LastRead 8 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}
		dbg_state {Type O LastRead -1 FirstWrite 7}
		dbg_req_instruction {Type O LastRead -1 FirstWrite 7}
		dbg_req_op {Type O LastRead -1 FirstWrite 7}
		dbg_req_layer {Type O LastRead -1 FirstWrite 7}
		dbg_req_head {Type O LastRead -1 FirstWrite 7}
		dbg_req_tile {Type O LastRead -1 FirstWrite 7}
		error {Type O LastRead -1 FirstWrite 0}
		state {Type IO LastRead -1 FirstWrite -1}
		req_instruction {Type IO LastRead -1 FirstWrite -1}
		req_op {Type IO LastRead -1 FirstWrite -1}
		mac_ready {Type IO LastRead -1 FirstWrite -1}
		mac_complete {Type IO LastRead -1 FirstWrite -1}
		req_layer_idx {Type IO LastRead -1 FirstWrite -1}
		req_head_idx {Type IO LastRead -1 FirstWrite -1}
		req_tile_idx {Type IO LastRead -1 FirstWrite -1}
		clear_pending {Type IO LastRead -1 FirstWrite -1}
		capture_pending {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_23 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_22 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_21 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_20 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_19 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_18 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_17 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_16 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_15 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_14 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_11 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_10 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_9 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_8 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_7 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_6 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_3 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_2 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_1 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 {Type IO LastRead -1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 {Type IO LastRead -1 FirstWrite -1}
		val_in {Type IO LastRead -1 FirstWrite -1}
		val_scaled {Type IO LastRead -1 FirstWrite -1}
		soft_in {Type IO LastRead -1 FirstWrite -1}
		exp_lut_q15 {Type I LastRead -1 FirstWrite -1}
		soft_out {Type IO LastRead -1 FirstWrite -1}
		busy {Type IO LastRead -1 FirstWrite -1}
		compute_done_r {Type IO LastRead -1 FirstWrite -1}}
	headed_compute_controller_Pipeline_VITIS_LOOP_622_26 {
		in_buf {Type I LastRead 1 FirstWrite -1}
		soft_in {Type O LastRead -1 FirstWrite 1}}
	headed_compute_controller_Pipeline_VITIS_LOOP_610_24 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		val_in {Type O LastRead -1 FirstWrite 2}}
	headed_compute_controller_Pipeline_VITIS_LOOP_548_15 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_3 {Type O LastRead -1 FirstWrite 2}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_2 {Type O LastRead -1 FirstWrite 2}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_1 {Type O LastRead -1 FirstWrite 2}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b {Type O LastRead -1 FirstWrite 2}}
	headed_compute_controller_Pipeline_VITIS_LOOP_496_7 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_506_9 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_636_28 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_646_30 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_661_33 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34 {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_640_29 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s {Type O LastRead -1 FirstWrite 1}}
	headed_compute_controller_Pipeline_VITIS_LOOP_650_31 {
		in_buf {Type I LastRead 8 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 {Type O LastRead -1 FirstWrite 2}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 {Type O LastRead -1 FirstWrite 2}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 {Type O LastRead -1 FirstWrite 3}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 {Type O LastRead -1 FirstWrite 3}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 {Type O LastRead -1 FirstWrite 4}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 {Type O LastRead -1 FirstWrite 4}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 {Type O LastRead -1 FirstWrite 5}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 {Type O LastRead -1 FirstWrite 6}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 {Type O LastRead -1 FirstWrite 6}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 {Type O LastRead -1 FirstWrite 7}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 {Type O LastRead -1 FirstWrite 7}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 {Type O LastRead -1 FirstWrite 8}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 {Type O LastRead -1 FirstWrite 8}}
	headed_compute_controller_Pipeline_VITIS_LOOP_672_34 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_110 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_111 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_112 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_113 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}
	SOFTMAX {
		soft_in {Type I LastRead 0 FirstWrite -1}
		exp_lut_q15 {Type I LastRead -1 FirstWrite -1}
		soft_out {Type O LastRead -1 FirstWrite 0}}
	SOFTMAX_Pipeline_VITIS_LOOP_232_1 {
		max_val {Type I LastRead 0 FirstWrite -1}
		max_val_1_out {Type O LastRead -1 FirstWrite 0}
		soft_in {Type I LastRead 0 FirstWrite -1}}
	SOFTMAX_Pipeline_VITIS_LOOP_245_2 {
		max_val_1_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_15_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_14_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_13_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_12_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_11_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_10_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_9_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_8_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_7_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_6_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_5_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_4_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_3_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_2_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_1_out {Type O LastRead -1 FirstWrite 1}
		exp_buf_out {Type O LastRead -1 FirstWrite 1}
		sum_exp_out {Type O LastRead -1 FirstWrite 1}
		soft_in {Type I LastRead 0 FirstWrite -1}
		exp_lut_q15 {Type I LastRead -1 FirstWrite -1}}
	SOFTMAX_Pipeline_VITIS_LOOP_266_3 {
		exp_buf_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_1_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_2_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_3_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_4_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_5_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_6_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_7_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_8_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_9_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_10_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_11_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_12_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_13_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_14_reload {Type I LastRead 0 FirstWrite -1}
		exp_buf_15_reload {Type I LastRead 0 FirstWrite -1}
		inv_sum_q15_1 {Type I LastRead 0 FirstWrite -1}
		soft_out {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_160_1 {
		val_in {Type I LastRead 0 FirstWrite -1}
		val_scaled {Type O LastRead -1 FirstWrite 1}}
	headed_compute_controller_Pipeline_VITIS_LOOP_627_27 {
		out_buf {Type O LastRead -1 FirstWrite 1}
		soft_out {Type I LastRead 0 FirstWrite -1}}
	headed_compute_controller_Pipeline_VITIS_LOOP_615_25 {
		out_buf {Type O LastRead -1 FirstWrite 1}
		val_scaled {Type I LastRead 0 FirstWrite -1}}
	headed_compute_controller_Pipeline_VITIS_LOOP_564_17 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_574_19 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 {Type O LastRead -1 FirstWrite 0}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_589_22 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34 {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_568_18 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 {Type O LastRead -1 FirstWrite 1}}
	headed_compute_controller_Pipeline_VITIS_LOOP_578_20 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 {Type O LastRead -1 FirstWrite 2}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 {Type O LastRead -1 FirstWrite 2}}
	headed_compute_controller_Pipeline_VITIS_LOOP_599_23 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_555_16 {
		select_ln293 {Type I LastRead 0 FirstWrite -1}
		select_ln293_1 {Type I LastRead 0 FirstWrite -1}
		select_ln293_2 {Type I LastRead 0 FirstWrite -1}
		select_ln293_3 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_139_1 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_114 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_115 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_116 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_117 {Type I LastRead 0 FirstWrite -1}
		sext_ln139 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_128 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_129 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_130 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_131 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_132 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_133 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_134 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_135 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_136 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_137 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_60 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_61 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_62 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_63 {Type I LastRead 0 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_64 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_23 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 {Type I LastRead 3 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 {Type I LastRead 1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 {Type I LastRead 3 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 {Type I LastRead 1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 {Type I LastRead 3 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 {Type I LastRead 1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 {Type I LastRead 1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 {Type I LastRead 1 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 {Type I LastRead 3 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 {Type I LastRead 1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 {Type I LastRead 3 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 {Type I LastRead 1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 {Type I LastRead 3 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 {Type I LastRead 1 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 {Type I LastRead 3 FirstWrite -1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_22 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_21 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_20 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_19 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_18 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_17 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_16 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_15 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_14 {Type O LastRead -1 FirstWrite 5}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_11 {Type O LastRead -1 FirstWrite 5}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_10 {Type O LastRead -1 FirstWrite 5}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_9 {Type O LastRead -1 FirstWrite 5}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_8 {Type O LastRead -1 FirstWrite 5}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_7 {Type O LastRead -1 FirstWrite 5}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_6 {Type O LastRead -1 FirstWrite 5}}
	headed_compute_controller_Pipeline_VITIS_LOOP_500_8 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_13 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_12 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_11 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_10 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_9 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_8 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_7 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_6 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_5 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_4 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_5 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_4 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_3 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_2 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_1 {Type O LastRead -1 FirstWrite 1}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_s {Type O LastRead -1 FirstWrite 1}}
	headed_compute_controller_Pipeline_VITIS_LOOP_510_10 {
		in_buf {Type I LastRead 8 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 {Type O LastRead -1 FirstWrite 2}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 {Type O LastRead -1 FirstWrite 2}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 {Type O LastRead -1 FirstWrite 3}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 {Type O LastRead -1 FirstWrite 3}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 {Type O LastRead -1 FirstWrite 4}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 {Type O LastRead -1 FirstWrite 4}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 {Type O LastRead -1 FirstWrite 5}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 {Type O LastRead -1 FirstWrite 5}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 {Type O LastRead -1 FirstWrite 6}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 {Type O LastRead -1 FirstWrite 6}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 {Type O LastRead -1 FirstWrite 7}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 {Type O LastRead -1 FirstWrite 7}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 {Type O LastRead -1 FirstWrite 8}
		p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 {Type O LastRead -1 FirstWrite 8}}
	headed_compute_controller_Pipeline_VITIS_LOOP_520_12 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35 {Type O LastRead -1 FirstWrite 1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34 {Type O LastRead -1 FirstWrite 1}}
	headed_compute_controller_Pipeline_VITIS_LOOP_534_14 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_58 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_59 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_60 {Type I LastRead 0 FirstWrite -1}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_61 {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 0}}
	headed_compute_controller_Pipeline_VITIS_LOOP_440_6 {
		out_buf {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "363"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "364"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	reset { ap_none {  { reset in_data 0 1 } } }
	compute_start { ap_none {  { compute_start in_data 0 1 } } }
	compute_instruction { ap_none {  { compute_instruction in_data 0 32 } } }
	compute_ready { ap_vld {  { compute_ready out_data 1 1 }  { compute_ready_ap_vld out_vld 1 1 } } }
	compute_done { ap_vld {  { compute_done out_data 1 1 }  { compute_done_ap_vld out_vld 1 1 } } }
	mem_transfer_done { ap_none {  { mem_transfer_done in_data 0 1 } } }
	mem_read_request { ap_vld {  { mem_read_request out_data 1 1 }  { mem_read_request_ap_vld out_vld 1 1 } } }
	mem_write_request { ap_vld {  { mem_write_request out_data 1 1 }  { mem_write_request_ap_vld out_vld 1 1 } } }
	mem_op { ap_vld {  { mem_op out_data 1 32 }  { mem_op_ap_vld out_vld 1 1 } } }
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 7 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 }  { in_buf_address1 MemPortADDR2 1 7 }  { in_buf_ce1 MemPortCE2 1 1 }  { in_buf_q1 MemPortDOUT2 0 8 } } }
	out_buf { ap_memory {  { out_buf_address0 mem_address 1 6 }  { out_buf_ce0 mem_ce 1 1 }  { out_buf_we0 mem_we 1 1 }  { out_buf_d0 mem_din 1 8 }  { out_buf_address1 MemPortADDR2 1 6 }  { out_buf_ce1 MemPortCE2 1 1 }  { out_buf_we1 MemPortWE2 1 1 }  { out_buf_d1 MemPortDIN2 1 8 } } }
	dbg_state { ap_vld {  { dbg_state out_data 1 8 }  { dbg_state_ap_vld out_vld 1 1 } } }
	dbg_req_instruction { ap_vld {  { dbg_req_instruction out_data 1 32 }  { dbg_req_instruction_ap_vld out_vld 1 1 } } }
	dbg_req_op { ap_vld {  { dbg_req_op out_data 1 8 }  { dbg_req_op_ap_vld out_vld 1 1 } } }
	dbg_req_layer { ap_vld {  { dbg_req_layer out_data 1 8 }  { dbg_req_layer_ap_vld out_vld 1 1 } } }
	dbg_req_head { ap_vld {  { dbg_req_head out_data 1 8 }  { dbg_req_head_ap_vld out_vld 1 1 } } }
	dbg_req_tile { ap_vld {  { dbg_req_tile out_data 1 8 }  { dbg_req_tile_ap_vld out_vld 1 1 } } }
	error { ap_vld {  { error out_data 1 1 }  { error_ap_vld out_vld 1 1 } } }
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
