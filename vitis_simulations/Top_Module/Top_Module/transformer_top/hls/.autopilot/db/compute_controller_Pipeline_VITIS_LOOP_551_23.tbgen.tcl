set moduleName compute_controller_Pipeline_VITIS_LOOP_551_23
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
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_551_23}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 129 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ in_buf int 8 regular {array 129 { 1 1 } 1 1 }  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99 int 19 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98 int 19 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97 int 19 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96 int 19 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95 int 19 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94 int 19 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93 int 19 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92 int 19 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91 int 19 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 int 8 regular {pointer 1} {global 1}  }
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90 int 19 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11 int 19 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10 int 19 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9 int 19 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8 int 19 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7 int 19 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 int 8 regular {pointer 1} {global 1}  }
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6 int 19 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "in_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6", "interface" : "wire", "bitwidth" : 19, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 76
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
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 sc_out sc_lv 8 signal 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99 sc_out sc_lv 19 signal 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 sc_out sc_lv 8 signal 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98 sc_out sc_lv 19 signal 4 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 sc_out sc_lv 8 signal 5 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37_ap_vld sc_out sc_logic 1 outvld 5 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97 sc_out sc_lv 19 signal 6 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 sc_out sc_lv 8 signal 7 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96 sc_out sc_lv 19 signal 8 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 sc_out sc_lv 8 signal 9 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95 sc_out sc_lv 19 signal 10 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 sc_out sc_lv 8 signal 11 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94 sc_out sc_lv 19 signal 12 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 sc_out sc_lv 8 signal 13 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93 sc_out sc_lv 19 signal 14 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 sc_out sc_lv 8 signal 15 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92 sc_out sc_lv 19 signal 16 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 sc_out sc_lv 8 signal 17 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91 sc_out sc_lv 19 signal 18 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 sc_out sc_lv 8 signal 19 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90 sc_out sc_lv 19 signal 20 } 
	{ compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 sc_out sc_lv 8 signal 21 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11 sc_out sc_lv 19 signal 22 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 sc_out sc_lv 8 signal 23 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10 sc_out sc_lv 19 signal 24 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 sc_out sc_lv 8 signal 25 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39_ap_vld sc_out sc_logic 1 outvld 25 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9 sc_out sc_lv 19 signal 26 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9_ap_vld sc_out sc_logic 1 outvld 26 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 sc_out sc_lv 8 signal 27 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38_ap_vld sc_out sc_logic 1 outvld 27 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8 sc_out sc_lv 19 signal 28 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 sc_out sc_lv 8 signal 29 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37_ap_vld sc_out sc_logic 1 outvld 29 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7 sc_out sc_lv 19 signal 30 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7_ap_vld sc_out sc_logic 1 outvld 30 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 sc_out sc_lv 8 signal 31 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36_ap_vld sc_out sc_logic 1 outvld 31 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6 sc_out sc_lv 19 signal 32 } 
	{ p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6_ap_vld sc_out sc_logic 1 outvld 32 } 
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
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30", "role": "ap_vld" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90", "role": "default" }} , 
 	{ "name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36", "role": "ap_vld" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6", "direction": "out", "datatype": "sc_lv", "bitwidth":19, "type": "signal", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6", "role": "default" }} , 
 	{ "name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller_Pipeline_VITIS_LOOP_551_23 {
		in_buf {Type I LastRead 2 FirstWrite -1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91 {Type O LastRead -1 FirstWrite 2}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 {Type O LastRead -1 FirstWrite 1}
		compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7 {Type O LastRead -1 FirstWrite 2}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6 {Type O LastRead -1 FirstWrite 2}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "34", "Max" : "34"}
	, {"Name" : "Interval", "Min" : "34", "Max" : "34"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 8 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 }  { in_buf_address1 MemPortADDR2 1 8 }  { in_buf_ce1 MemPortCE2 1 1 }  { in_buf_q1 MemPortDOUT2 0 8 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_39_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_99_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_38_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_98_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_37_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_97_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_36_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_96_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_35_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_95_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_34_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_94_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_33_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_93_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_32_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_92_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_31_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_91_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30 out_data 1 8 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_30_ap_vld out_vld 1 1 } } }
	compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90 { ap_vld {  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90 out_data 1 19 }  { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_90_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_41_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11 out_data 1 19 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_11_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_40_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10 out_data 1 19 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_10_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_39_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9 out_data 1 19 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_9_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_38_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8 out_data 1 19 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_8_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_37_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7 out_data 1 19 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_7_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36 out_data 1 8 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_36_ap_vld out_vld 1 1 } } }
	p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6 { ap_vld {  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6 out_data 1 19 }  { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_6_ap_vld out_vld 1 1 } } }
}
