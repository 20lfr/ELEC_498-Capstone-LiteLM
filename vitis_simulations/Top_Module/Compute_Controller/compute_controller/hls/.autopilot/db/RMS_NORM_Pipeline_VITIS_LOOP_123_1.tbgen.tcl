set moduleName RMS_NORM_Pipeline_VITIS_LOOP_123_1
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
set C_modelName {RMS_NORM_Pipeline_VITIS_LOOP_123_1}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_431 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_432 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_433 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_434 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_435 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_436 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_437 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_438 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_439 int 8 regular  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_440 int 8 regular  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_234 int 8 regular  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_235 int 8 regular  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_236 int 8 regular  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_237 int 8 regular  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_238 int 8 regular  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_239 int 8 regular  }
	{ square_out int 19 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_431", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_432", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_433", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_434", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_435", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_436", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_437", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_438", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_439", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_440", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_234", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_235", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_236", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_237", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_238", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_239", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "square_out", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 24
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_431 sc_in sc_lv 8 signal 0 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_432 sc_in sc_lv 8 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_433 sc_in sc_lv 8 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_434 sc_in sc_lv 8 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_435 sc_in sc_lv 8 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_436 sc_in sc_lv 8 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_437 sc_in sc_lv 8 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_438 sc_in sc_lv 8 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_439 sc_in sc_lv 8 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_440 sc_in sc_lv 8 signal 9 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_234 sc_in sc_lv 8 signal 10 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_235 sc_in sc_lv 8 signal 11 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_236 sc_in sc_lv 8 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_237 sc_in sc_lv 8 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_238 sc_in sc_lv 8 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_239 sc_in sc_lv 8 signal 15 } 
	{ square_out sc_out sc_lv 19 signal 16 } 
	{ square_out_ap_vld sc_out sc_logic 1 outvld 16 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_431", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_431", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_432", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_432", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_433", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_433", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_434", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_434", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_435", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_435", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_436", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_436", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_437", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_437", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_438", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_438", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_439", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_439", "role": "default" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_440", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_440", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_234", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_234", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_235", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_235", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_236", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_236", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_237", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_237", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_238", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_238", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_239", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_239", "role": "default" }} , 
 	{ "name": "square_out", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "square_out", "role": "default" }} , 
 	{ "name": "square_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "square_out", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	RMS_NORM_Pipeline_VITIS_LOOP_123_1 {
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_431 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_432 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_433 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_434 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_435 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_436 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_437 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_438 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_439 {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_440 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_234 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_235 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_236 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_237 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_238 {Type I LastRead 0 FirstWrite -1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_239 {Type I LastRead 0 FirstWrite -1}
		square_out {Type O LastRead -1 FirstWrite 2}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "20", "Max" : "20"}
	, {"Name" : "Interval", "Min" : "20", "Max" : "20"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_431 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_431 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_432 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_432 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_433 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_433 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_434 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_434 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_435 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_435 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_436 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_436 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_437 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_437 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_438 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_438 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_439 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_439 in_data 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_440 { ap_none {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_440 in_data 0 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_234 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_234 in_data 0 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_235 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_235 in_data 0 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_236 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_236 in_data 0 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_237 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_237 in_data 0 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_238 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_238 in_data 0 8 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_239 { ap_none {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_239 in_data 0 8 } } }
	square_out { ap_vld {  { square_out out_data 1 19 }  { square_out_ap_vld out_vld 1 1 } } }
}
