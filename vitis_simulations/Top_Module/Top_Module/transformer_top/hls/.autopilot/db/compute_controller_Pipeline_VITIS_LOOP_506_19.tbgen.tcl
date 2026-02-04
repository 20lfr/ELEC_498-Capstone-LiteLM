set moduleName compute_controller_Pipeline_VITIS_LOOP_506_19
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
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_506_19}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 129 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ in_buf int 8 regular {array 129 { 1 1 } 1 1 }  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 int 32 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 int 32 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 int 32 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 int 32 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 int 32 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 int 32 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 int 32 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 int 32 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "in_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 44
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
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 sc_out sc_lv 32 signal 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 sc_out sc_lv 32 signal 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 sc_out sc_lv 32 signal 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 sc_out sc_lv 32 signal 4 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 sc_out sc_lv 32 signal 5 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45_ap_vld sc_out sc_logic 1 outvld 5 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 sc_out sc_lv 32 signal 6 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 sc_out sc_lv 32 signal 7 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 sc_out sc_lv 32 signal 8 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 sc_out sc_lv 32 signal 9 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 sc_out sc_lv 32 signal 10 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 sc_out sc_lv 32 signal 11 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 sc_out sc_lv 32 signal 12 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 sc_out sc_lv 32 signal 13 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 sc_out sc_lv 32 signal 14 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 sc_out sc_lv 32 signal 15 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 sc_out sc_lv 32 signal 16 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42_ap_vld sc_out sc_logic 1 outvld 16 } 
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
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller_Pipeline_VITIS_LOOP_506_19 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 {Type O LastRead -1 FirstWrite 3}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 {Type O LastRead -1 FirstWrite 3}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 {Type O LastRead -1 FirstWrite 3}}
	read_i32 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		byte_addr {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "35", "Max" : "35"}
	, {"Name" : "Interval", "Min" : "35", "Max" : "35"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 8 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 }  { in_buf_address1 MemPortADDR2 1 8 }  { in_buf_ce1 MemPortCE2 1 1 }  { in_buf_q1 MemPortDOUT2 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 out_data 1 32 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 out_data 1 32 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 out_data 1 32 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 out_data 1 32 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 out_data 1 32 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 out_data 1 32 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 out_data 1 32 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42_ap_vld out_vld 1 1 } } }
}
