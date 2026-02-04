set moduleName compute_controller_Pipeline_VITIS_LOOP_567_24
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
set cdfgNum 42
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_567_24}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict out_buf { MEM_WIDTH 8 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_163 int 32 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_164 int 32 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_165 int 32 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_166 int 32 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_167 int 32 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_168 int 32 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_169 int 32 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_170 int 32 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_171 int 32 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_172 int 32 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_84 int 32 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_85 int 32 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_86 int 32 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_87 int 32 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_88 int 32 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_89 int 32 regular  }
	{ out_buf int 8 regular {array 64 { 0 0 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_163", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_164", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_165", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_166", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_167", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_168", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_169", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_170", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_171", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_172", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_84", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_85", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_86", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_87", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_88", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_89", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
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
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_163 sc_in sc_lv 32 signal 0 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_164 sc_in sc_lv 32 signal 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_165 sc_in sc_lv 32 signal 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_166 sc_in sc_lv 32 signal 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_167 sc_in sc_lv 32 signal 4 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_168 sc_in sc_lv 32 signal 5 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_169 sc_in sc_lv 32 signal 6 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_170 sc_in sc_lv 32 signal 7 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_171 sc_in sc_lv 32 signal 8 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_172 sc_in sc_lv 32 signal 9 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_84 sc_in sc_lv 32 signal 10 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_85 sc_in sc_lv 32 signal 11 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_86 sc_in sc_lv 32 signal 12 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_87 sc_in sc_lv 32 signal 13 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_88 sc_in sc_lv 32 signal 14 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_89 sc_in sc_lv 32 signal 15 } 
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
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_163", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_163", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_164", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_164", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_165", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_165", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_166", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_166", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_167", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_167", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_168", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_168", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_169", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_169", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_170", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_170", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_171", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_171", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_172", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_172", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_84", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_84", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_85", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_85", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_86", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_86", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_87", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_87", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_88", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_88", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_89", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_89", "role": "default" }} , 
 	{ "name": "out_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "out_buf", "role": "address0" }} , 
 	{ "name": "out_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "ce0" }} , 
 	{ "name": "out_buf_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "we0" }} , 
 	{ "name": "out_buf_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_buf", "role": "d0" }} , 
 	{ "name": "out_buf_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "out_buf", "role": "address1" }} , 
 	{ "name": "out_buf_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "ce1" }} , 
 	{ "name": "out_buf_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "we1" }} , 
 	{ "name": "out_buf_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_buf", "role": "d1" }}  ]}

set ArgLastReadFirstWriteLatency {
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
		out_buf {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "34", "Max" : "34"}
	, {"Name" : "Interval", "Min" : "34", "Max" : "34"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_163 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_163 in_data 0 32 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_164 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_164 in_data 0 32 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_165 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_165 in_data 0 32 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_166 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_166 in_data 0 32 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_167 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_167 in_data 0 32 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_168 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_168 in_data 0 32 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_169 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_169 in_data 0 32 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_170 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_170 in_data 0 32 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_171 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_171 in_data 0 32 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_172 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_172 in_data 0 32 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_84 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_84 in_data 0 32 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_85 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_85 in_data 0 32 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_86 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_86 in_data 0 32 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_87 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_87 in_data 0 32 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_88 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_88 in_data 0 32 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_89 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_89 in_data 0 32 } } }
	out_buf { ap_memory {  { out_buf_address0 mem_address 1 6 }  { out_buf_ce0 mem_ce 1 1 }  { out_buf_we0 mem_we 1 1 }  { out_buf_d0 mem_din 1 8 }  { out_buf_address1 MemPortADDR2 1 6 }  { out_buf_ce1 MemPortCE2 1 1 }  { out_buf_we1 MemPortWE2 1 1 }  { out_buf_d1 MemPortDIN2 1 8 } } }
}
