set moduleName headed_compute_controller_Pipeline_VITIS_LOOP_599_23
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type loop_auto_rewind
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
set C_modelName {headed_compute_controller_Pipeline_VITIS_LOOP_599_23}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict out_buf { MEM_WIDTH 8 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80 int 20 regular  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81 int 20 regular  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82 int 20 regular  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83 int 20 regular  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84 int 20 regular  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85 int 20 regular  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86 int 20 regular  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87 int 20 regular  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88 int 20 regular  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89 int 20 regular  }
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36 int 20 regular  }
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37 int 20 regular  }
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38 int 20 regular  }
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39 int 20 regular  }
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40 int 20 regular  }
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41 int 20 regular  }
	{ out_buf int 8 regular {array 64 { 0 0 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "out_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 30
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80 sc_in sc_lv 20 signal 0 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81 sc_in sc_lv 20 signal 1 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82 sc_in sc_lv 20 signal 2 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83 sc_in sc_lv 20 signal 3 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84 sc_in sc_lv 20 signal 4 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85 sc_in sc_lv 20 signal 5 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86 sc_in sc_lv 20 signal 6 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87 sc_in sc_lv 20 signal 7 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88 sc_in sc_lv 20 signal 8 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89 sc_in sc_lv 20 signal 9 } 
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36 sc_in sc_lv 20 signal 10 } 
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37 sc_in sc_lv 20 signal 11 } 
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38 sc_in sc_lv 20 signal 12 } 
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39 sc_in sc_lv 20 signal 13 } 
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40 sc_in sc_lv 20 signal 14 } 
	{ p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41 sc_in sc_lv 20 signal 15 } 
	{ out_buf_address0 sc_out sc_lv 6 signal 16 } 
	{ out_buf_ce0 sc_out sc_logic 1 signal 16 } 
	{ out_buf_we0 sc_out sc_logic 1 signal 16 } 
	{ out_buf_d0 sc_out sc_lv 8 signal 16 } 
	{ out_buf_address1 sc_out sc_lv 6 signal 16 } 
	{ out_buf_ce1 sc_out sc_logic 1 signal 16 } 
	{ out_buf_we1 sc_out sc_logic 1 signal 16 } 
	{ out_buf_d1 sc_out sc_lv 8 signal 16 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89", "role": "default" }} , 
 	{ "name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36", "role": "default" }} , 
 	{ "name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37", "role": "default" }} , 
 	{ "name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38", "role": "default" }} , 
 	{ "name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39", "role": "default" }} , 
 	{ "name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40", "role": "default" }} , 
 	{ "name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41", "role": "default" }} , 
 	{ "name": "out_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "out_buf", "role": "address0" }} , 
 	{ "name": "out_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "ce0" }} , 
 	{ "name": "out_buf_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "we0" }} , 
 	{ "name": "out_buf_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_buf", "role": "d0" }} , 
 	{ "name": "out_buf_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "out_buf", "role": "address1" }} , 
 	{ "name": "out_buf_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "ce1" }} , 
 	{ "name": "out_buf_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "we1" }} , 
 	{ "name": "out_buf_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_buf", "role": "d1" }}  ]}

set ArgLastReadFirstWriteLatency {
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
		out_buf {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "34", "Max" : "34"}
	, {"Name" : "Interval", "Min" : "34", "Max" : "34"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_80 in_data 0 20 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_81 in_data 0 20 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_82 in_data 0 20 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_83 in_data 0 20 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_84 in_data 0 20 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_85 in_data 0 20 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_86 in_data 0 20 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_87 in_data 0 20 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_88 in_data 0 20 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89 { ap_none {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_89 in_data 0 20 } } }
	p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36 { ap_none {  { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_36 in_data 0 20 } } }
	p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37 { ap_none {  { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_37 in_data 0 20 } } }
	p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38 { ap_none {  { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_38 in_data 0 20 } } }
	p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39 { ap_none {  { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_39 in_data 0 20 } } }
	p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40 { ap_none {  { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_40 in_data 0 20 } } }
	p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41 { ap_none {  { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_41 in_data 0 20 } } }
	out_buf { ap_memory {  { out_buf_address0 mem_address 1 6 }  { out_buf_ce0 mem_ce 1 1 }  { out_buf_we0 mem_we 1 1 }  { out_buf_d0 mem_din 1 8 }  { out_buf_address1 MemPortADDR2 1 6 }  { out_buf_ce1 MemPortCE2 1 1 }  { out_buf_we1 MemPortWE2 1 1 }  { out_buf_d1 MemPortDIN2 1 8 } } }
}
