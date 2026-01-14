set moduleName OUT_PROJ
set isTopModule 0
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
set cdfgNum 3
set C_modelName {OUT_PROJ}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict OUT_PROJ_valueA { MEM_WIDTH 8 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict OUT_PROJ_valueB { MEM_WIDTH 4 MEM_SIZE 16 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict OUT_PROJ_accum { MEM_WIDTH 32 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ OUT_PROJ_valueA int 8 regular {array 8 { 1 1 } 1 1 }  }
	{ OUT_PROJ_valueB int 4 regular {array 16 { 1 1 } 1 1 }  }
	{ OUT_PROJ_accum int 32 regular {array 2 { 0 0 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "OUT_PROJ_valueA", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "OUT_PROJ_valueB", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "OUT_PROJ_accum", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 26
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ OUT_PROJ_valueA_address0 sc_out sc_lv 3 signal 0 } 
	{ OUT_PROJ_valueA_ce0 sc_out sc_logic 1 signal 0 } 
	{ OUT_PROJ_valueA_q0 sc_in sc_lv 8 signal 0 } 
	{ OUT_PROJ_valueA_address1 sc_out sc_lv 3 signal 0 } 
	{ OUT_PROJ_valueA_ce1 sc_out sc_logic 1 signal 0 } 
	{ OUT_PROJ_valueA_q1 sc_in sc_lv 8 signal 0 } 
	{ OUT_PROJ_valueB_address0 sc_out sc_lv 4 signal 1 } 
	{ OUT_PROJ_valueB_ce0 sc_out sc_logic 1 signal 1 } 
	{ OUT_PROJ_valueB_q0 sc_in sc_lv 4 signal 1 } 
	{ OUT_PROJ_valueB_address1 sc_out sc_lv 4 signal 1 } 
	{ OUT_PROJ_valueB_ce1 sc_out sc_logic 1 signal 1 } 
	{ OUT_PROJ_valueB_q1 sc_in sc_lv 4 signal 1 } 
	{ OUT_PROJ_accum_address0 sc_out sc_lv 1 signal 2 } 
	{ OUT_PROJ_accum_ce0 sc_out sc_logic 1 signal 2 } 
	{ OUT_PROJ_accum_we0 sc_out sc_logic 1 signal 2 } 
	{ OUT_PROJ_accum_d0 sc_out sc_lv 32 signal 2 } 
	{ OUT_PROJ_accum_address1 sc_out sc_lv 1 signal 2 } 
	{ OUT_PROJ_accum_ce1 sc_out sc_logic 1 signal 2 } 
	{ OUT_PROJ_accum_we1 sc_out sc_logic 1 signal 2 } 
	{ OUT_PROJ_accum_d1 sc_out sc_lv 32 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "OUT_PROJ_valueA_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "OUT_PROJ_valueA", "role": "address0" }} , 
 	{ "name": "OUT_PROJ_valueA_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_valueA", "role": "ce0" }} , 
 	{ "name": "OUT_PROJ_valueA_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "OUT_PROJ_valueA", "role": "q0" }} , 
 	{ "name": "OUT_PROJ_valueA_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "OUT_PROJ_valueA", "role": "address1" }} , 
 	{ "name": "OUT_PROJ_valueA_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_valueA", "role": "ce1" }} , 
 	{ "name": "OUT_PROJ_valueA_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "OUT_PROJ_valueA", "role": "q1" }} , 
 	{ "name": "OUT_PROJ_valueB_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "address0" }} , 
 	{ "name": "OUT_PROJ_valueB_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "ce0" }} , 
 	{ "name": "OUT_PROJ_valueB_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "q0" }} , 
 	{ "name": "OUT_PROJ_valueB_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "address1" }} , 
 	{ "name": "OUT_PROJ_valueB_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "ce1" }} , 
 	{ "name": "OUT_PROJ_valueB_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "q1" }} , 
 	{ "name": "OUT_PROJ_accum_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "address0" }} , 
 	{ "name": "OUT_PROJ_accum_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "ce0" }} , 
 	{ "name": "OUT_PROJ_accum_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "we0" }} , 
 	{ "name": "OUT_PROJ_accum_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "d0" }} , 
 	{ "name": "OUT_PROJ_accum_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "address1" }} , 
 	{ "name": "OUT_PROJ_accum_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "ce1" }} , 
 	{ "name": "OUT_PROJ_accum_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "we1" }} , 
 	{ "name": "OUT_PROJ_accum_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "d1" }}  ]}

set ArgLastReadFirstWriteLatency {
	OUT_PROJ {
		OUT_PROJ_valueA {Type I LastRead 8 FirstWrite -1}
		OUT_PROJ_valueB {Type I LastRead 8 FirstWrite -1}
		OUT_PROJ_accum {Type O LastRead -1 FirstWrite 9}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "9", "Max" : "9"}
	, {"Name" : "Interval", "Min" : "9", "Max" : "9"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	OUT_PROJ_valueA { ap_memory {  { OUT_PROJ_valueA_address0 mem_address 1 3 }  { OUT_PROJ_valueA_ce0 mem_ce 1 1 }  { OUT_PROJ_valueA_q0 mem_dout 0 8 }  { OUT_PROJ_valueA_address1 MemPortADDR2 1 3 }  { OUT_PROJ_valueA_ce1 MemPortCE2 1 1 }  { OUT_PROJ_valueA_q1 MemPortDOUT2 0 8 } } }
	OUT_PROJ_valueB { ap_memory {  { OUT_PROJ_valueB_address0 mem_address 1 4 }  { OUT_PROJ_valueB_ce0 mem_ce 1 1 }  { OUT_PROJ_valueB_q0 mem_dout 0 4 }  { OUT_PROJ_valueB_address1 MemPortADDR2 1 4 }  { OUT_PROJ_valueB_ce1 MemPortCE2 1 1 }  { OUT_PROJ_valueB_q1 MemPortDOUT2 0 4 } } }
	OUT_PROJ_accum { ap_memory {  { OUT_PROJ_accum_address0 mem_address 1 1 }  { OUT_PROJ_accum_ce0 mem_ce 1 1 }  { OUT_PROJ_accum_we0 mem_we 1 1 }  { OUT_PROJ_accum_d0 mem_din 1 32 }  { OUT_PROJ_accum_address1 MemPortADDR2 1 1 }  { OUT_PROJ_accum_ce1 MemPortCE2 1 1 }  { OUT_PROJ_accum_we1 MemPortWE2 1 1 }  { OUT_PROJ_accum_d1 MemPortDIN2 1 32 } } }
}
