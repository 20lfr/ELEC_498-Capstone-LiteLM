set moduleName compute_controller
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
set cdfgNum 23
set C_modelName {compute_controller}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 4920 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict out_buf { MEM_WIDTH 8 MEM_SIZE 768 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
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
	{ in_buf int 8 regular {array 4920 { 1 3 } 1 1 }  }
	{ out_buf int 8 regular {array 768 { 0 0 } 0 1 }  }
	{ dbg_state int 8 regular {pointer 1}  }
	{ dbg_req_instruction int 32 regular {pointer 1}  }
	{ dbg_req_op int 8 regular {pointer 1}  }
	{ dbg_req_layer int 8 regular {pointer 1}  }
	{ dbg_req_head int 8 regular {pointer 1}  }
	{ dbg_req_tile int 8 regular {pointer 1}  }
	{ dbg_mac_start int 1 regular {pointer 1}  }
	{ dbg_mac_ready int 1 regular {pointer 1}  }
	{ dbg_mac_complete int 1 regular {pointer 1}  }
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
 	{ "Name" : "dbg_mac_start", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_mac_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dbg_mac_complete", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "error", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 51
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
	{ in_buf_address0 sc_out sc_lv 13 signal 9 } 
	{ in_buf_ce0 sc_out sc_logic 1 signal 9 } 
	{ in_buf_q0 sc_in sc_lv 8 signal 9 } 
	{ out_buf_address0 sc_out sc_lv 10 signal 10 } 
	{ out_buf_ce0 sc_out sc_logic 1 signal 10 } 
	{ out_buf_we0 sc_out sc_logic 1 signal 10 } 
	{ out_buf_d0 sc_out sc_lv 8 signal 10 } 
	{ out_buf_address1 sc_out sc_lv 10 signal 10 } 
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
	{ dbg_mac_start sc_out sc_lv 1 signal 17 } 
	{ dbg_mac_start_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ dbg_mac_ready sc_out sc_lv 1 signal 18 } 
	{ dbg_mac_ready_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ dbg_mac_complete sc_out sc_lv 1 signal 19 } 
	{ dbg_mac_complete_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ error sc_out sc_lv 1 signal 20 } 
	{ error_ap_vld sc_out sc_logic 1 outvld 20 } 
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
 	{ "name": "in_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":13, "type": "signal", "bundle":{"name": "in_buf", "role": "address0" }} , 
 	{ "name": "in_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce0" }} , 
 	{ "name": "in_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q0" }} , 
 	{ "name": "out_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "out_buf", "role": "address0" }} , 
 	{ "name": "out_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "ce0" }} , 
 	{ "name": "out_buf_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "we0" }} , 
 	{ "name": "out_buf_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_buf", "role": "d0" }} , 
 	{ "name": "out_buf_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "out_buf", "role": "address1" }} , 
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
 	{ "name": "dbg_mac_start", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_mac_start", "role": "default" }} , 
 	{ "name": "dbg_mac_start_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_mac_start", "role": "ap_vld" }} , 
 	{ "name": "dbg_mac_ready", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_mac_ready", "role": "default" }} , 
 	{ "name": "dbg_mac_ready_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_mac_ready", "role": "ap_vld" }} , 
 	{ "name": "dbg_mac_complete", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dbg_mac_complete", "role": "default" }} , 
 	{ "name": "dbg_mac_complete_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "dbg_mac_complete", "role": "ap_vld" }} , 
 	{ "name": "error", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "error", "role": "default" }} , 
 	{ "name": "error_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "error", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller {
		reset {Type I LastRead 0 FirstWrite -1}
		compute_start {Type I LastRead 0 FirstWrite -1}
		compute_instruction {Type I LastRead 0 FirstWrite -1}
		compute_ready {Type O LastRead -1 FirstWrite 287}
		compute_done {Type O LastRead -1 FirstWrite 287}
		mem_transfer_done {Type I LastRead 0 FirstWrite -1}
		mem_read_request {Type O LastRead -1 FirstWrite 287}
		mem_write_request {Type O LastRead -1 FirstWrite 287}
		mem_op {Type O LastRead -1 FirstWrite 287}
		in_buf {Type I LastRead 0 FirstWrite -1}
		out_buf {Type O LastRead -1 FirstWrite 1}
		dbg_state {Type O LastRead -1 FirstWrite 9}
		dbg_req_instruction {Type O LastRead -1 FirstWrite 9}
		dbg_req_op {Type O LastRead -1 FirstWrite 9}
		dbg_req_layer {Type O LastRead -1 FirstWrite 286}
		dbg_req_head {Type O LastRead -1 FirstWrite 286}
		dbg_req_tile {Type O LastRead -1 FirstWrite 286}
		dbg_mac_start {Type O LastRead -1 FirstWrite 9}
		dbg_mac_ready {Type O LastRead -1 FirstWrite 9}
		dbg_mac_complete {Type O LastRead -1 FirstWrite 9}
		error {Type O LastRead -1 FirstWrite 0}
		state {Type IO LastRead -1 FirstWrite -1}
		req_instruction {Type IO LastRead -1 FirstWrite -1}
		req_op {Type IO LastRead -1 FirstWrite -1}
		mac_ready {Type IO LastRead -1 FirstWrite -1}
		mac_complete {Type IO LastRead -1 FirstWrite -1}
		req_layer_idx {Type IO LastRead -1 FirstWrite -1}
		req_head_idx {Type IO LastRead -1 FirstWrite -1}
		req_tile_idx {Type IO LastRead -1 FirstWrite -1}
		capture_pending {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_19 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_18 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_17 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_16 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_15 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_14 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_13 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_12 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11 {Type IO LastRead -1 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_23 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_22 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_21 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_20 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_19 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_18 {Type IO LastRead -1 FirstWrite -1}
		busy {Type IO LastRead -1 FirstWrite -1}
		compute_done_r {Type IO LastRead -1 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_372_4 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_381_6_VITIS_LOOP_382_7 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_394_8 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12 {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_410_10 {
		out_buf {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_19 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_18 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_17 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_16 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_15 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_14 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_13 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_12 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_23 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_22 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_21 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_20 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_19 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_18 {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_2 {
		sext_ln39 {Type I LastRead 0 FirstWrite -1}
		mul_ln40 {Type I LastRead 0 FirstWrite -1}
		acc_1_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_21 {
		sext_ln39_1 {Type I LastRead 0 FirstWrite -1}
		mul_ln40_1 {Type I LastRead 0 FirstWrite -1}
		acc_4_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_22 {
		sext_ln39_2 {Type I LastRead 0 FirstWrite -1}
		mul_ln40_2 {Type I LastRead 0 FirstWrite -1}
		acc_7_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_23 {
		sext_ln39_3 {Type I LastRead 0 FirstWrite -1}
		mul_ln40_3 {Type I LastRead 0 FirstWrite -1}
		acc_10_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_24 {
		sext_ln39_4 {Type I LastRead 0 FirstWrite -1}
		mul_ln40_4 {Type I LastRead 0 FirstWrite -1}
		acc_13_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_25 {
		sext_ln39_5 {Type I LastRead 0 FirstWrite -1}
		mul_ln40_5 {Type I LastRead 0 FirstWrite -1}
		acc_16_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_26 {
		sext_ln39_6 {Type I LastRead 0 FirstWrite -1}
		mul_ln40_6 {Type I LastRead 0 FirstWrite -1}
		acc_19_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_27 {
		sext_ln39_7 {Type I LastRead 0 FirstWrite -1}
		mul_ln40_7 {Type I LastRead 0 FirstWrite -1}
		acc_22_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_28 {
		sext_ln39_8 {Type I LastRead 0 FirstWrite -1}
		p_udiv1167 {Type I LastRead 0 FirstWrite -1}
		acc_25_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_29 {
		sext_ln39_9 {Type I LastRead 0 FirstWrite -1}
		p_udiv1244 {Type I LastRead 0 FirstWrite -1}
		acc_28_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_210 {
		sext_ln39_10 {Type I LastRead 0 FirstWrite -1}
		p_udiv1321 {Type I LastRead 0 FirstWrite -1}
		acc_31_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_211 {
		sext_ln39_11 {Type I LastRead 0 FirstWrite -1}
		p_udiv1398 {Type I LastRead 0 FirstWrite -1}
		acc_34_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_212 {
		sext_ln39_12 {Type I LastRead 0 FirstWrite -1}
		p_udiv1475 {Type I LastRead 0 FirstWrite -1}
		acc_37_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_213 {
		sext_ln39_13 {Type I LastRead 0 FirstWrite -1}
		p_udiv1552 {Type I LastRead 0 FirstWrite -1}
		acc_40_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_214 {
		sext_ln39_14 {Type I LastRead 0 FirstWrite -1}
		p_udiv1629 {Type I LastRead 0 FirstWrite -1}
		acc_43_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}
	compute_controller_Pipeline_VITIS_LOOP_40_215 {
		sext_ln39_15 {Type I LastRead 0 FirstWrite -1}
		p_udiv1706 {Type I LastRead 0 FirstWrite -1}
		acc_46_out {Type O LastRead -1 FirstWrite 3}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_9 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_8 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_7 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_6 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_5 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_4 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_3 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_2 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_1 {Type I LastRead 2 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_11 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_5 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_10 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_4 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_9 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_3 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_8 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_2 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_7 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_1 {Type I LastRead 2 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_6 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "279", "Max" : "10765"}
	, {"Name" : "Interval", "Min" : "280", "Max" : "10766"}
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
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 13 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 } } }
	out_buf { ap_memory {  { out_buf_address0 mem_address 1 10 }  { out_buf_ce0 mem_ce 1 1 }  { out_buf_we0 mem_we 1 1 }  { out_buf_d0 mem_din 1 8 }  { out_buf_address1 MemPortADDR2 1 10 }  { out_buf_ce1 MemPortCE2 1 1 }  { out_buf_we1 MemPortWE2 1 1 }  { out_buf_d1 MemPortDIN2 1 8 } } }
	dbg_state { ap_vld {  { dbg_state out_data 1 8 }  { dbg_state_ap_vld out_vld 1 1 } } }
	dbg_req_instruction { ap_vld {  { dbg_req_instruction out_data 1 32 }  { dbg_req_instruction_ap_vld out_vld 1 1 } } }
	dbg_req_op { ap_vld {  { dbg_req_op out_data 1 8 }  { dbg_req_op_ap_vld out_vld 1 1 } } }
	dbg_req_layer { ap_vld {  { dbg_req_layer out_data 1 8 }  { dbg_req_layer_ap_vld out_vld 1 1 } } }
	dbg_req_head { ap_vld {  { dbg_req_head out_data 1 8 }  { dbg_req_head_ap_vld out_vld 1 1 } } }
	dbg_req_tile { ap_vld {  { dbg_req_tile out_data 1 8 }  { dbg_req_tile_ap_vld out_vld 1 1 } } }
	dbg_mac_start { ap_vld {  { dbg_mac_start out_data 1 1 }  { dbg_mac_start_ap_vld out_vld 1 1 } } }
	dbg_mac_ready { ap_vld {  { dbg_mac_ready out_data 1 1 }  { dbg_mac_ready_ap_vld out_vld 1 1 } } }
	dbg_mac_complete { ap_vld {  { dbg_mac_complete out_data 1 1 }  { dbg_mac_complete_ap_vld out_vld 1 1 } } }
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
