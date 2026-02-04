set moduleName compute_controller_Pipeline_VITIS_LOOP_576_26
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
set cdfgNum 40
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_576_26}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59 { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58 { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57 { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56 { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55 { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54 { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59 int 16 regular {array 2 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58 int 16 regular {array 2 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57 int 16 regular {array 2 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56 int 16 regular {array 2 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55 int 16 regular {array 2 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54 int 16 regular {array 2 { 0 3 } 0 1 } {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 30
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_address0 sc_out sc_lv 1 signal 0 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_ce0 sc_out sc_logic 1 signal 0 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_we0 sc_out sc_logic 1 signal 0 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_d0 sc_out sc_lv 16 signal 0 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_address0 sc_out sc_lv 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_ce0 sc_out sc_logic 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_we0 sc_out sc_logic 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_d0 sc_out sc_lv 16 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_address0 sc_out sc_lv 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_ce0 sc_out sc_logic 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_we0 sc_out sc_logic 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_d0 sc_out sc_lv 16 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_address0 sc_out sc_lv 1 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_ce0 sc_out sc_logic 1 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_we0 sc_out sc_logic 1 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_d0 sc_out sc_lv 16 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_address0 sc_out sc_lv 1 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_ce0 sc_out sc_logic 1 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_we0 sc_out sc_logic 1 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_d0 sc_out sc_lv 16 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_address0 sc_out sc_lv 1 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_ce0 sc_out sc_logic 1 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_we0 sc_out sc_logic 1 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_d0 sc_out sc_lv 16 signal 5 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller_Pipeline_VITIS_LOOP_576_26 {
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59 {Type O LastRead -1 FirstWrite 0}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58 {Type O LastRead -1 FirstWrite 0}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57 {Type O LastRead -1 FirstWrite 0}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56 {Type O LastRead -1 FirstWrite 0}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55 {Type O LastRead -1 FirstWrite 0}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54 {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "8", "Max" : "8"}
	, {"Name" : "Interval", "Min" : "8", "Max" : "8"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_address0 mem_address 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_59_d0 mem_din 1 16 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_address0 mem_address 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_58_d0 mem_din 1 16 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_address0 mem_address 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_57_d0 mem_din 1 16 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_address0 mem_address 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_56_d0 mem_din 1 16 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_address0 mem_address 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_55_d0 mem_din 1 16 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_address0 mem_address 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_54_d0 mem_din 1 16 } } }
}
