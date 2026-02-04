set moduleName compute_controller_Pipeline_VITIS_LOOP_597_29
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
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_597_29}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 129 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ in_buf int 8 regular {array 129 { 1 1 } 1 1 }  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 int 32 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "in_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 20
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ in_buf_address0 sc_out sc_lv 8 signal 0 } 
	{ in_buf_ce0 sc_out sc_logic 1 signal 0 } 
	{ in_buf_q0 sc_in sc_lv 8 signal 0 } 
	{ in_buf_address1 sc_out sc_lv 8 signal 0 } 
	{ in_buf_ce1 sc_out sc_logic 1 signal 0 } 
	{ in_buf_q1 sc_in sc_lv 8 signal 0 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 sc_out sc_lv 32 signal 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 sc_out sc_lv 32 signal 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 sc_out sc_lv 32 signal 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 sc_out sc_lv 32 signal 4 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127_ap_vld sc_out sc_logic 1 outvld 4 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "in_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "address0" }} , 
 	{ "name": "in_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce0" }} , 
 	{ "name": "in_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q0" }} , 
 	{ "name": "in_buf_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "address1" }} , 
 	{ "name": "in_buf_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce1" }} , 
 	{ "name": "in_buf_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q1" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller_Pipeline_VITIS_LOOP_597_29 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 {Type O LastRead -1 FirstWrite 3}}
	read_i32 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		byte_addr {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "11", "Max" : "11"}
	, {"Name" : "Interval", "Min" : "11", "Max" : "11"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 8 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 }  { in_buf_address1 MemPortADDR2 1 8 }  { in_buf_ce1 MemPortCE2 1 1 }  { in_buf_q1 MemPortDOUT2 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_124_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_125_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_126_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_127_ap_vld out_vld 1 1 } } }
}
