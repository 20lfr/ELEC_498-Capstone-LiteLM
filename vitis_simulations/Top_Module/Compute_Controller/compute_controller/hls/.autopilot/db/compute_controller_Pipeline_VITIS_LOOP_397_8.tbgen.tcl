set moduleName compute_controller_Pipeline_VITIS_LOOP_397_8
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
set cdfgNum 23
set C_modelName {compute_controller_Pipeline_VITIS_LOOP_397_8}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict in_buf { MEM_WIDTH 8 MEM_SIZE 4920 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12 { MEM_WIDTH 4 MEM_SIZE 3 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ in_buf int 8 regular {array 4920 { 1 3 } 1 1 }  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12 int 4 regular {array 3 { 0 3 } 0 1 } {global 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "in_buf", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12", "interface" : "memory", "bitwidth" : 4, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 73
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ in_buf_address0 sc_out sc_lv 13 signal 0 } 
	{ in_buf_ce0 sc_out sc_logic 1 signal 0 } 
	{ in_buf_q0 sc_in sc_lv 8 signal 0 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_address0 sc_out sc_lv 2 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_ce0 sc_out sc_logic 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_we0 sc_out sc_logic 1 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_d0 sc_out sc_lv 4 signal 1 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_address0 sc_out sc_lv 2 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_ce0 sc_out sc_logic 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_we0 sc_out sc_logic 1 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_d0 sc_out sc_lv 4 signal 2 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_address0 sc_out sc_lv 2 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_ce0 sc_out sc_logic 1 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_we0 sc_out sc_logic 1 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_d0 sc_out sc_lv 4 signal 3 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_address0 sc_out sc_lv 2 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_ce0 sc_out sc_logic 1 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_we0 sc_out sc_logic 1 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_d0 sc_out sc_lv 4 signal 4 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_address0 sc_out sc_lv 2 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_ce0 sc_out sc_logic 1 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_we0 sc_out sc_logic 1 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_d0 sc_out sc_lv 4 signal 5 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_address0 sc_out sc_lv 2 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_ce0 sc_out sc_logic 1 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_we0 sc_out sc_logic 1 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_d0 sc_out sc_lv 4 signal 6 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_address0 sc_out sc_lv 2 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_ce0 sc_out sc_logic 1 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_we0 sc_out sc_logic 1 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_d0 sc_out sc_lv 4 signal 7 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_address0 sc_out sc_lv 2 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_ce0 sc_out sc_logic 1 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_we0 sc_out sc_logic 1 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_d0 sc_out sc_lv 4 signal 8 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_address0 sc_out sc_lv 2 signal 9 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_ce0 sc_out sc_logic 1 signal 9 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_we0 sc_out sc_logic 1 signal 9 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_d0 sc_out sc_lv 4 signal 9 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_address0 sc_out sc_lv 2 signal 10 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_ce0 sc_out sc_logic 1 signal 10 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_we0 sc_out sc_logic 1 signal 10 } 
	{ compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_d0 sc_out sc_lv 4 signal 10 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_address0 sc_out sc_lv 2 signal 11 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_ce0 sc_out sc_logic 1 signal 11 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_we0 sc_out sc_logic 1 signal 11 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_d0 sc_out sc_lv 4 signal 11 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_address0 sc_out sc_lv 2 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_ce0 sc_out sc_logic 1 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_we0 sc_out sc_logic 1 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_d0 sc_out sc_lv 4 signal 12 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_address0 sc_out sc_lv 2 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_ce0 sc_out sc_logic 1 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_we0 sc_out sc_logic 1 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_d0 sc_out sc_lv 4 signal 13 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_address0 sc_out sc_lv 2 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_ce0 sc_out sc_logic 1 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_we0 sc_out sc_logic 1 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_d0 sc_out sc_lv 4 signal 14 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_address0 sc_out sc_lv 2 signal 15 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_ce0 sc_out sc_logic 1 signal 15 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_we0 sc_out sc_logic 1 signal 15 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_d0 sc_out sc_lv 4 signal 15 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_address0 sc_out sc_lv 2 signal 16 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_ce0 sc_out sc_logic 1 signal 16 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_we0 sc_out sc_logic 1 signal 16 } 
	{ p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_d0 sc_out sc_lv 4 signal 16 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "in_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":13, "type": "signal", "bundle":{"name": "in_buf", "role": "address0" }} , 
 	{ "name": "in_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_buf", "role": "ce0" }} , 
 	{ "name": "in_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "in_buf", "role": "q0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31", "role": "d0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30", "role": "address0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30", "role": "ce0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30", "role": "we0" }} , 
 	{ "name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13", "role": "d0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12", "role": "address0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12", "role": "ce0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12", "role": "we0" }} , 
 	{ "name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller_Pipeline_VITIS_LOOP_397_8 {
		in_buf {Type I LastRead 0 FirstWrite -1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31 {Type O LastRead -1 FirstWrite 1}
		compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13 {Type O LastRead -1 FirstWrite 1}
		p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12 {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "50", "Max" : "50"}
	, {"Name" : "Interval", "Min" : "50", "Max" : "50"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	in_buf { ap_memory {  { in_buf_address0 mem_address 1 13 }  { in_buf_ce0 mem_ce 1 1 }  { in_buf_q0 mem_dout 0 8 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_39_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_38_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_37_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_36_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_35_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_34_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_33_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_32_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_31_d0 mem_din 1 4 } } }
	compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30 { ap_memory {  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_address0 mem_address 1 2 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_ce0 mem_ce 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_we0 mem_we 1 1 }  { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_30_d0 mem_din 1 4 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_address0 mem_address 1 2 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_17_d0 mem_din 1 4 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_address0 mem_address 1 2 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_16_d0 mem_din 1 4 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_address0 mem_address 1 2 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_15_d0 mem_din 1 4 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_address0 mem_address 1 2 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_14_d0 mem_din 1 4 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_address0 mem_address 1 2 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_13_d0 mem_din 1 4 } } }
	p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12 { ap_memory {  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_address0 mem_address 1 2 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_ce0 mem_ce 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_we0 mem_we 1 1 }  { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_12_d0 mem_din 1 4 } } }
}
