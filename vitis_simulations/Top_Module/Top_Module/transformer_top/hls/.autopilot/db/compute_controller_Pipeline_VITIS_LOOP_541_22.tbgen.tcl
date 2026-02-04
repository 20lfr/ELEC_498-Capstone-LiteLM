set moduleName compute_controller_Pipeline_VITIS_LOOP_541_22
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
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_541_22}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict out_buf { MEM_WIDTH 8 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_153 int 8 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_154 int 8 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_155 int 8 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_156 int 8 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_157 int 8 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_158 int 8 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_159 int 8 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_160 int 8 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_161 int 8 regular  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_162 int 8 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_78 int 8 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_79 int 8 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_80 int 8 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_81 int 8 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_82 int 8 regular  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_83 int 8 regular  }
	{ out_buf int 8 regular {array 64 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_153", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_154", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_155", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_156", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_157", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_158", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_159", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_160", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_161", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_162", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_78", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_79", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_80", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_81", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_82", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_83", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "out_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 26
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_153 sc_in sc_lv 8 signal 0 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_154 sc_in sc_lv 8 signal 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_155 sc_in sc_lv 8 signal 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_156 sc_in sc_lv 8 signal 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_157 sc_in sc_lv 8 signal 4 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_158 sc_in sc_lv 8 signal 5 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_159 sc_in sc_lv 8 signal 6 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_160 sc_in sc_lv 8 signal 7 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_161 sc_in sc_lv 8 signal 8 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_162 sc_in sc_lv 8 signal 9 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_78 sc_in sc_lv 8 signal 10 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_79 sc_in sc_lv 8 signal 11 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_80 sc_in sc_lv 8 signal 12 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_81 sc_in sc_lv 8 signal 13 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_82 sc_in sc_lv 8 signal 14 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_83 sc_in sc_lv 8 signal 15 } 
	{ out_buf_address0 sc_out sc_lv 6 signal 16 } 
	{ out_buf_ce0 sc_out sc_logic 1 signal 16 } 
	{ out_buf_we0 sc_out sc_logic 1 signal 16 } 
	{ out_buf_d0 sc_out sc_lv 8 signal 16 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_153", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_153", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_154", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_154", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_155", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_155", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_156", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_156", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_157", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_157", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_158", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_158", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_159", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_159", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_160", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_160", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_161", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_161", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_162", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_162", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_78", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_78", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_79", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_79", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_80", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_80", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_81", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_81", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_82", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_82", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_83", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_83", "role": "default" }} , 
 	{ "name": "out_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "out_buf", "role": "address0" }} , 
 	{ "name": "out_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "ce0" }} , 
 	{ "name": "out_buf_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_buf", "role": "we0" }} , 
 	{ "name": "out_buf_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_buf", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
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
		out_buf {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "18", "Max" : "18"}
	, {"Name" : "Interval", "Min" : "18", "Max" : "18"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_153 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_153 in_data 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_154 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_154 in_data 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_155 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_155 in_data 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_156 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_156 in_data 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_157 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_157 in_data 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_158 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_158 in_data 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_159 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_159 in_data 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_160 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_160 in_data 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_161 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_161 in_data 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_162 { ap_none {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_162 in_data 0 8 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_78 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_78 in_data 0 8 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_79 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_79 in_data 0 8 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_80 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_80 in_data 0 8 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_81 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_81 in_data 0 8 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_82 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_82 in_data 0 8 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_83 { ap_none {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_83 in_data 0 8 } } }
	out_buf { ap_memory {  { out_buf_address0 mem_address 1 6 }  { out_buf_ce0 mem_ce 1 1 }  { out_buf_we0 mem_we 1 1 }  { out_buf_d0 mem_din 1 8 } } }
}
