set moduleName headed_compute_controller_Pipeline_VITIS_LOOP_661_33
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
set C_modelName {headed_compute_controller_Pipeline_VITIS_LOOP_661_33}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37 int 4 regular {pointer 1} {global 1}  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36 int 4 regular {pointer 1} {global 1}  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35 int 4 regular {pointer 1} {global 1}  }
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34 int 4 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37", "interface" : "wire", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36", "interface" : "wire", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35", "interface" : "wire", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34", "interface" : "wire", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 14
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37 sc_out sc_lv 4 signal 0 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37_ap_vld sc_out sc_logic 1 outvld 0 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36 sc_out sc_lv 4 signal 1 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35 sc_out sc_lv 4 signal 2 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34 sc_out sc_lv 4 signal 3 } 
	{ headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34_ap_vld sc_out sc_logic 1 outvld 3 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37", "role": "ap_vld" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36", "role": "ap_vld" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35", "role": "ap_vld" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34", "role": "default" }} , 
 	{ "name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	headed_compute_controller_Pipeline_VITIS_LOOP_661_33 {
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35 {Type O LastRead -1 FirstWrite 0}
		headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34 {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "18", "Max" : "18"}
	, {"Name" : "Interval", "Min" : "18", "Max" : "18"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37 { ap_vld {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37 out_data 1 4 }  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_37_ap_vld out_vld 1 1 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36 { ap_vld {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36 out_data 1 4 }  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_36_ap_vld out_vld 1 1 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35 { ap_vld {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35 out_data 1 4 }  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_35_ap_vld out_vld 1 1 } } }
	headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34 { ap_vld {  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34 out_data 1 4 }  { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_34_ap_vld out_vld 1 1 } } }
}
