set moduleName compute_controller
set isTopModule 1
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
set cdfgNum 13
set C_modelName {compute_controller}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict int8_activation { MEM_WIDTH 8 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict OUT_PROJ_valueB { MEM_WIDTH 4 MEM_SIZE 16 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict OUT_PROJ_bias { MEM_WIDTH 32 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict OUT_PROJ_accum { MEM_WIDTH 32 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN1_weights1 { MEM_WIDTH 4 MEM_SIZE 16 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN1_biases { MEM_WIDTH 4 MEM_SIZE 2 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN1_scale { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN1_output { MEM_WIDTH 16 MEM_SIZE 4 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict RELU_input { MEM_WIDTH 16 MEM_SIZE 44 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict RELU_output { MEM_WIDTH 16 MEM_SIZE 44 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN2_input { MEM_WIDTH 16 MEM_SIZE 44 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN2_weights2 { MEM_WIDTH 4 MEM_SIZE 110 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN2_biases { MEM_WIDTH 4 MEM_SIZE 5 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN2_scale { MEM_WIDTH 16 MEM_SIZE 10 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict FFN2_output { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict requant_activation { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict requant_output { MEM_WIDTH 8 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict layerNorm_gamma { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict layerNorm_beta { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict layerNorm_out { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict residualAdd_residual { MEM_WIDTH 8 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict residualAdd_output { MEM_WIDTH 8 MEM_SIZE 8 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ reset uint 1 regular  }
	{ compute_start uint 1 regular  }
	{ compute_instruction int 32 regular  }
	{ compute_ready int 1 regular {pointer 1}  }
	{ compute_done int 1 regular {pointer 1}  }
	{ mem_transfer_done uint 1 regular  }
	{ mem_read_request int 1 regular {pointer 1}  }
	{ mem_write_request int 1 regular {pointer 1}  }
	{ mem_op int 32 regular {pointer 1}  }
	{ int8_activation int 8 regular {array 8 { 1 1 } 1 1 }  }
	{ OUT_PROJ_valueB int 4 regular {array 16 { 1 1 } 1 1 }  }
	{ OUT_PROJ_bias int 32 regular {array 2 { 1 1 } 1 1 }  }
	{ OUT_PROJ_accum int 32 regular {array 2 { 0 0 } 0 1 }  }
	{ FFN1_weights1 int 4 regular {array 16 { 1 1 } 1 1 }  }
	{ FFN1_biases int 4 regular {array 2 { 1 3 } 1 1 }  }
	{ FFN1_scale int 16 regular {array 2 { 1 3 } 1 1 }  }
	{ FFN1_output int 16 regular {array 2 { 0 3 } 0 1 }  }
	{ RELU_input int 16 regular {array 22 { 1 3 } 1 1 }  }
	{ RELU_output int 16 regular {array 22 { 0 3 } 0 1 }  }
	{ FFN2_input int 16 regular {array 22 { 1 1 } 1 1 }  }
	{ FFN2_weights2 int 4 regular {array 110 { 1 1 } 1 1 }  }
	{ FFN2_biases int 4 regular {array 5 { 1 3 } 1 1 }  }
	{ FFN2_scale int 16 regular {array 5 { 1 3 } 1 1 }  }
	{ FFN2_output int 32 regular {array 8 { 0 3 } 0 1 }  }
	{ requant_activation int 32 regular {array 8 { 1 1 } 1 1 }  }
	{ requant_scale int 32 regular  }
	{ requant_shift int 32 regular  }
	{ requant_zero_point int 32 regular  }
	{ requant_output int 8 regular {array 8 { 0 0 } 0 1 }  }
	{ layerNorm_gamma int 32 regular {array 8 { 1 1 } 1 1 }  }
	{ layerNorm_beta int 32 regular {array 8 { 1 1 } 1 1 }  }
	{ layerNorm_epsilon int 32 regular  }
	{ layerNorm_out int 32 regular {array 8 { 0 0 } 0 1 }  }
	{ residualAdd_residual int 8 regular {array 8 { 1 1 } 1 1 }  }
	{ residualAdd_output int 8 regular {array 8 { 0 0 } 0 1 }  }
	{ error int 1 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "reset", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_start", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "compute_instruction", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "compute_ready", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "compute_done", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mem_transfer_done", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "mem_read_request", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mem_write_request", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mem_op", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "int8_activation", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "OUT_PROJ_valueB", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "OUT_PROJ_bias", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "OUT_PROJ_accum", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "FFN1_weights1", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "FFN1_biases", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "FFN1_scale", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "FFN1_output", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "RELU_input", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "RELU_output", "interface" : "memory", "bitwidth" : 16, "direction" : "WRITEONLY"} , 
 	{ "Name" : "FFN2_input", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "FFN2_weights2", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "FFN2_biases", "interface" : "memory", "bitwidth" : 4, "direction" : "READONLY"} , 
 	{ "Name" : "FFN2_scale", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "FFN2_output", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "requant_activation", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "requant_scale", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "requant_shift", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "requant_zero_point", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "requant_output", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "layerNorm_gamma", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "layerNorm_beta", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "layerNorm_epsilon", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "layerNorm_out", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "residualAdd_residual", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "residualAdd_output", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "error", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 145
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ reset sc_in sc_lv 1 signal 0 } 
	{ compute_start sc_in sc_lv 1 signal 1 } 
	{ compute_instruction sc_in sc_lv 32 signal 2 } 
	{ compute_ready sc_out sc_lv 1 signal 3 } 
	{ compute_ready_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ compute_done sc_out sc_lv 1 signal 4 } 
	{ compute_done_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ mem_transfer_done sc_in sc_lv 1 signal 5 } 
	{ mem_read_request sc_out sc_lv 1 signal 6 } 
	{ mem_read_request_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ mem_write_request sc_out sc_lv 1 signal 7 } 
	{ mem_write_request_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ mem_op sc_out sc_lv 32 signal 8 } 
	{ mem_op_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ int8_activation_address0 sc_out sc_lv 3 signal 9 } 
	{ int8_activation_ce0 sc_out sc_logic 1 signal 9 } 
	{ int8_activation_q0 sc_in sc_lv 8 signal 9 } 
	{ int8_activation_address1 sc_out sc_lv 3 signal 9 } 
	{ int8_activation_ce1 sc_out sc_logic 1 signal 9 } 
	{ int8_activation_q1 sc_in sc_lv 8 signal 9 } 
	{ OUT_PROJ_valueB_address0 sc_out sc_lv 4 signal 10 } 
	{ OUT_PROJ_valueB_ce0 sc_out sc_logic 1 signal 10 } 
	{ OUT_PROJ_valueB_q0 sc_in sc_lv 4 signal 10 } 
	{ OUT_PROJ_valueB_address1 sc_out sc_lv 4 signal 10 } 
	{ OUT_PROJ_valueB_ce1 sc_out sc_logic 1 signal 10 } 
	{ OUT_PROJ_valueB_q1 sc_in sc_lv 4 signal 10 } 
	{ OUT_PROJ_bias_address0 sc_out sc_lv 1 signal 11 } 
	{ OUT_PROJ_bias_ce0 sc_out sc_logic 1 signal 11 } 
	{ OUT_PROJ_bias_q0 sc_in sc_lv 32 signal 11 } 
	{ OUT_PROJ_bias_address1 sc_out sc_lv 1 signal 11 } 
	{ OUT_PROJ_bias_ce1 sc_out sc_logic 1 signal 11 } 
	{ OUT_PROJ_bias_q1 sc_in sc_lv 32 signal 11 } 
	{ OUT_PROJ_accum_address0 sc_out sc_lv 1 signal 12 } 
	{ OUT_PROJ_accum_ce0 sc_out sc_logic 1 signal 12 } 
	{ OUT_PROJ_accum_we0 sc_out sc_logic 1 signal 12 } 
	{ OUT_PROJ_accum_d0 sc_out sc_lv 32 signal 12 } 
	{ OUT_PROJ_accum_address1 sc_out sc_lv 1 signal 12 } 
	{ OUT_PROJ_accum_ce1 sc_out sc_logic 1 signal 12 } 
	{ OUT_PROJ_accum_we1 sc_out sc_logic 1 signal 12 } 
	{ OUT_PROJ_accum_d1 sc_out sc_lv 32 signal 12 } 
	{ FFN1_weights1_address0 sc_out sc_lv 4 signal 13 } 
	{ FFN1_weights1_ce0 sc_out sc_logic 1 signal 13 } 
	{ FFN1_weights1_q0 sc_in sc_lv 4 signal 13 } 
	{ FFN1_weights1_address1 sc_out sc_lv 4 signal 13 } 
	{ FFN1_weights1_ce1 sc_out sc_logic 1 signal 13 } 
	{ FFN1_weights1_q1 sc_in sc_lv 4 signal 13 } 
	{ FFN1_biases_address0 sc_out sc_lv 1 signal 14 } 
	{ FFN1_biases_ce0 sc_out sc_logic 1 signal 14 } 
	{ FFN1_biases_q0 sc_in sc_lv 4 signal 14 } 
	{ FFN1_scale_address0 sc_out sc_lv 1 signal 15 } 
	{ FFN1_scale_ce0 sc_out sc_logic 1 signal 15 } 
	{ FFN1_scale_q0 sc_in sc_lv 16 signal 15 } 
	{ FFN1_output_address0 sc_out sc_lv 1 signal 16 } 
	{ FFN1_output_ce0 sc_out sc_logic 1 signal 16 } 
	{ FFN1_output_we0 sc_out sc_logic 1 signal 16 } 
	{ FFN1_output_d0 sc_out sc_lv 16 signal 16 } 
	{ RELU_input_address0 sc_out sc_lv 5 signal 17 } 
	{ RELU_input_ce0 sc_out sc_logic 1 signal 17 } 
	{ RELU_input_q0 sc_in sc_lv 16 signal 17 } 
	{ RELU_output_address0 sc_out sc_lv 5 signal 18 } 
	{ RELU_output_ce0 sc_out sc_logic 1 signal 18 } 
	{ RELU_output_we0 sc_out sc_logic 1 signal 18 } 
	{ RELU_output_d0 sc_out sc_lv 16 signal 18 } 
	{ FFN2_input_address0 sc_out sc_lv 5 signal 19 } 
	{ FFN2_input_ce0 sc_out sc_logic 1 signal 19 } 
	{ FFN2_input_q0 sc_in sc_lv 16 signal 19 } 
	{ FFN2_input_address1 sc_out sc_lv 5 signal 19 } 
	{ FFN2_input_ce1 sc_out sc_logic 1 signal 19 } 
	{ FFN2_input_q1 sc_in sc_lv 16 signal 19 } 
	{ FFN2_weights2_address0 sc_out sc_lv 7 signal 20 } 
	{ FFN2_weights2_ce0 sc_out sc_logic 1 signal 20 } 
	{ FFN2_weights2_q0 sc_in sc_lv 4 signal 20 } 
	{ FFN2_weights2_address1 sc_out sc_lv 7 signal 20 } 
	{ FFN2_weights2_ce1 sc_out sc_logic 1 signal 20 } 
	{ FFN2_weights2_q1 sc_in sc_lv 4 signal 20 } 
	{ FFN2_biases_address0 sc_out sc_lv 3 signal 21 } 
	{ FFN2_biases_ce0 sc_out sc_logic 1 signal 21 } 
	{ FFN2_biases_q0 sc_in sc_lv 4 signal 21 } 
	{ FFN2_scale_address0 sc_out sc_lv 3 signal 22 } 
	{ FFN2_scale_ce0 sc_out sc_logic 1 signal 22 } 
	{ FFN2_scale_q0 sc_in sc_lv 16 signal 22 } 
	{ FFN2_output_address0 sc_out sc_lv 3 signal 23 } 
	{ FFN2_output_ce0 sc_out sc_logic 1 signal 23 } 
	{ FFN2_output_we0 sc_out sc_logic 1 signal 23 } 
	{ FFN2_output_d0 sc_out sc_lv 32 signal 23 } 
	{ requant_activation_address0 sc_out sc_lv 3 signal 24 } 
	{ requant_activation_ce0 sc_out sc_logic 1 signal 24 } 
	{ requant_activation_q0 sc_in sc_lv 32 signal 24 } 
	{ requant_activation_address1 sc_out sc_lv 3 signal 24 } 
	{ requant_activation_ce1 sc_out sc_logic 1 signal 24 } 
	{ requant_activation_q1 sc_in sc_lv 32 signal 24 } 
	{ requant_scale sc_in sc_lv 32 signal 25 } 
	{ requant_shift sc_in sc_lv 32 signal 26 } 
	{ requant_zero_point sc_in sc_lv 32 signal 27 } 
	{ requant_output_address0 sc_out sc_lv 3 signal 28 } 
	{ requant_output_ce0 sc_out sc_logic 1 signal 28 } 
	{ requant_output_we0 sc_out sc_logic 1 signal 28 } 
	{ requant_output_d0 sc_out sc_lv 8 signal 28 } 
	{ requant_output_address1 sc_out sc_lv 3 signal 28 } 
	{ requant_output_ce1 sc_out sc_logic 1 signal 28 } 
	{ requant_output_we1 sc_out sc_logic 1 signal 28 } 
	{ requant_output_d1 sc_out sc_lv 8 signal 28 } 
	{ layerNorm_gamma_address0 sc_out sc_lv 3 signal 29 } 
	{ layerNorm_gamma_ce0 sc_out sc_logic 1 signal 29 } 
	{ layerNorm_gamma_q0 sc_in sc_lv 32 signal 29 } 
	{ layerNorm_gamma_address1 sc_out sc_lv 3 signal 29 } 
	{ layerNorm_gamma_ce1 sc_out sc_logic 1 signal 29 } 
	{ layerNorm_gamma_q1 sc_in sc_lv 32 signal 29 } 
	{ layerNorm_beta_address0 sc_out sc_lv 3 signal 30 } 
	{ layerNorm_beta_ce0 sc_out sc_logic 1 signal 30 } 
	{ layerNorm_beta_q0 sc_in sc_lv 32 signal 30 } 
	{ layerNorm_beta_address1 sc_out sc_lv 3 signal 30 } 
	{ layerNorm_beta_ce1 sc_out sc_logic 1 signal 30 } 
	{ layerNorm_beta_q1 sc_in sc_lv 32 signal 30 } 
	{ layerNorm_epsilon sc_in sc_lv 32 signal 31 } 
	{ layerNorm_out_address0 sc_out sc_lv 3 signal 32 } 
	{ layerNorm_out_ce0 sc_out sc_logic 1 signal 32 } 
	{ layerNorm_out_we0 sc_out sc_logic 1 signal 32 } 
	{ layerNorm_out_d0 sc_out sc_lv 32 signal 32 } 
	{ layerNorm_out_address1 sc_out sc_lv 3 signal 32 } 
	{ layerNorm_out_ce1 sc_out sc_logic 1 signal 32 } 
	{ layerNorm_out_we1 sc_out sc_logic 1 signal 32 } 
	{ layerNorm_out_d1 sc_out sc_lv 32 signal 32 } 
	{ residualAdd_residual_address0 sc_out sc_lv 3 signal 33 } 
	{ residualAdd_residual_ce0 sc_out sc_logic 1 signal 33 } 
	{ residualAdd_residual_q0 sc_in sc_lv 8 signal 33 } 
	{ residualAdd_residual_address1 sc_out sc_lv 3 signal 33 } 
	{ residualAdd_residual_ce1 sc_out sc_logic 1 signal 33 } 
	{ residualAdd_residual_q1 sc_in sc_lv 8 signal 33 } 
	{ residualAdd_output_address0 sc_out sc_lv 3 signal 34 } 
	{ residualAdd_output_ce0 sc_out sc_logic 1 signal 34 } 
	{ residualAdd_output_we0 sc_out sc_logic 1 signal 34 } 
	{ residualAdd_output_d0 sc_out sc_lv 8 signal 34 } 
	{ residualAdd_output_address1 sc_out sc_lv 3 signal 34 } 
	{ residualAdd_output_ce1 sc_out sc_logic 1 signal 34 } 
	{ residualAdd_output_we1 sc_out sc_logic 1 signal 34 } 
	{ residualAdd_output_d1 sc_out sc_lv 8 signal 34 } 
	{ error sc_out sc_lv 1 signal 35 } 
	{ error_ap_vld sc_out sc_logic 1 outvld 35 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "reset", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "reset", "role": "default" }} , 
 	{ "name": "compute_start", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_start", "role": "default" }} , 
 	{ "name": "compute_instruction", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "compute_instruction", "role": "default" }} , 
 	{ "name": "compute_ready", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_ready", "role": "default" }} , 
 	{ "name": "compute_ready_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_ready", "role": "ap_vld" }} , 
 	{ "name": "compute_done", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "compute_done", "role": "default" }} , 
 	{ "name": "compute_done_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "compute_done", "role": "ap_vld" }} , 
 	{ "name": "mem_transfer_done", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_transfer_done", "role": "default" }} , 
 	{ "name": "mem_read_request", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_read_request", "role": "default" }} , 
 	{ "name": "mem_read_request_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem_read_request", "role": "ap_vld" }} , 
 	{ "name": "mem_write_request", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_write_request", "role": "default" }} , 
 	{ "name": "mem_write_request_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem_write_request", "role": "ap_vld" }} , 
 	{ "name": "mem_op", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mem_op", "role": "default" }} , 
 	{ "name": "mem_op_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mem_op", "role": "ap_vld" }} , 
 	{ "name": "int8_activation_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "int8_activation", "role": "address0" }} , 
 	{ "name": "int8_activation_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "int8_activation", "role": "ce0" }} , 
 	{ "name": "int8_activation_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation", "role": "q0" }} , 
 	{ "name": "int8_activation_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "int8_activation", "role": "address1" }} , 
 	{ "name": "int8_activation_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "int8_activation", "role": "ce1" }} , 
 	{ "name": "int8_activation_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "int8_activation", "role": "q1" }} , 
 	{ "name": "OUT_PROJ_valueB_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "address0" }} , 
 	{ "name": "OUT_PROJ_valueB_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "ce0" }} , 
 	{ "name": "OUT_PROJ_valueB_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "q0" }} , 
 	{ "name": "OUT_PROJ_valueB_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "address1" }} , 
 	{ "name": "OUT_PROJ_valueB_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "ce1" }} , 
 	{ "name": "OUT_PROJ_valueB_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "OUT_PROJ_valueB", "role": "q1" }} , 
 	{ "name": "OUT_PROJ_bias_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_bias", "role": "address0" }} , 
 	{ "name": "OUT_PROJ_bias_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_bias", "role": "ce0" }} , 
 	{ "name": "OUT_PROJ_bias_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUT_PROJ_bias", "role": "q0" }} , 
 	{ "name": "OUT_PROJ_bias_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_bias", "role": "address1" }} , 
 	{ "name": "OUT_PROJ_bias_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_bias", "role": "ce1" }} , 
 	{ "name": "OUT_PROJ_bias_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUT_PROJ_bias", "role": "q1" }} , 
 	{ "name": "OUT_PROJ_accum_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "address0" }} , 
 	{ "name": "OUT_PROJ_accum_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "ce0" }} , 
 	{ "name": "OUT_PROJ_accum_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "we0" }} , 
 	{ "name": "OUT_PROJ_accum_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "d0" }} , 
 	{ "name": "OUT_PROJ_accum_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "address1" }} , 
 	{ "name": "OUT_PROJ_accum_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "ce1" }} , 
 	{ "name": "OUT_PROJ_accum_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "we1" }} , 
 	{ "name": "OUT_PROJ_accum_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "OUT_PROJ_accum", "role": "d1" }} , 
 	{ "name": "FFN1_weights1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "address0" }} , 
 	{ "name": "FFN1_weights1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "ce0" }} , 
 	{ "name": "FFN1_weights1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "q0" }} , 
 	{ "name": "FFN1_weights1_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "address1" }} , 
 	{ "name": "FFN1_weights1_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "ce1" }} , 
 	{ "name": "FFN1_weights1_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_weights1", "role": "q1" }} , 
 	{ "name": "FFN1_biases_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_biases", "role": "address0" }} , 
 	{ "name": "FFN1_biases_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_biases", "role": "ce0" }} , 
 	{ "name": "FFN1_biases_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN1_biases", "role": "q0" }} , 
 	{ "name": "FFN1_scale_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_scale", "role": "address0" }} , 
 	{ "name": "FFN1_scale_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_scale", "role": "ce0" }} , 
 	{ "name": "FFN1_scale_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN1_scale", "role": "q0" }} , 
 	{ "name": "FFN1_output_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_output", "role": "address0" }} , 
 	{ "name": "FFN1_output_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_output", "role": "ce0" }} , 
 	{ "name": "FFN1_output_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN1_output", "role": "we0" }} , 
 	{ "name": "FFN1_output_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN1_output", "role": "d0" }} , 
 	{ "name": "RELU_input_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "RELU_input", "role": "address0" }} , 
 	{ "name": "RELU_input_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "RELU_input", "role": "ce0" }} , 
 	{ "name": "RELU_input_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "RELU_input", "role": "q0" }} , 
 	{ "name": "RELU_output_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "RELU_output", "role": "address0" }} , 
 	{ "name": "RELU_output_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "RELU_output", "role": "ce0" }} , 
 	{ "name": "RELU_output_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "RELU_output", "role": "we0" }} , 
 	{ "name": "RELU_output_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "RELU_output", "role": "d0" }} , 
 	{ "name": "FFN2_input_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "FFN2_input", "role": "address0" }} , 
 	{ "name": "FFN2_input_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_input", "role": "ce0" }} , 
 	{ "name": "FFN2_input_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN2_input", "role": "q0" }} , 
 	{ "name": "FFN2_input_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "FFN2_input", "role": "address1" }} , 
 	{ "name": "FFN2_input_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_input", "role": "ce1" }} , 
 	{ "name": "FFN2_input_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN2_input", "role": "q1" }} , 
 	{ "name": "FFN2_weights2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "address0" }} , 
 	{ "name": "FFN2_weights2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "ce0" }} , 
 	{ "name": "FFN2_weights2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "q0" }} , 
 	{ "name": "FFN2_weights2_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "address1" }} , 
 	{ "name": "FFN2_weights2_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "ce1" }} , 
 	{ "name": "FFN2_weights2_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN2_weights2", "role": "q1" }} , 
 	{ "name": "FFN2_biases_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "FFN2_biases", "role": "address0" }} , 
 	{ "name": "FFN2_biases_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_biases", "role": "ce0" }} , 
 	{ "name": "FFN2_biases_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "FFN2_biases", "role": "q0" }} , 
 	{ "name": "FFN2_scale_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "FFN2_scale", "role": "address0" }} , 
 	{ "name": "FFN2_scale_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_scale", "role": "ce0" }} , 
 	{ "name": "FFN2_scale_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "FFN2_scale", "role": "q0" }} , 
 	{ "name": "FFN2_output_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "FFN2_output", "role": "address0" }} , 
 	{ "name": "FFN2_output_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_output", "role": "ce0" }} , 
 	{ "name": "FFN2_output_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "FFN2_output", "role": "we0" }} , 
 	{ "name": "FFN2_output_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "FFN2_output", "role": "d0" }} , 
 	{ "name": "requant_activation_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "requant_activation", "role": "address0" }} , 
 	{ "name": "requant_activation_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_activation", "role": "ce0" }} , 
 	{ "name": "requant_activation_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "requant_activation", "role": "q0" }} , 
 	{ "name": "requant_activation_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "requant_activation", "role": "address1" }} , 
 	{ "name": "requant_activation_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_activation", "role": "ce1" }} , 
 	{ "name": "requant_activation_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "requant_activation", "role": "q1" }} , 
 	{ "name": "requant_scale", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "requant_scale", "role": "default" }} , 
 	{ "name": "requant_shift", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "requant_shift", "role": "default" }} , 
 	{ "name": "requant_zero_point", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "requant_zero_point", "role": "default" }} , 
 	{ "name": "requant_output_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "requant_output", "role": "address0" }} , 
 	{ "name": "requant_output_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_output", "role": "ce0" }} , 
 	{ "name": "requant_output_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_output", "role": "we0" }} , 
 	{ "name": "requant_output_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "requant_output", "role": "d0" }} , 
 	{ "name": "requant_output_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "requant_output", "role": "address1" }} , 
 	{ "name": "requant_output_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_output", "role": "ce1" }} , 
 	{ "name": "requant_output_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "requant_output", "role": "we1" }} , 
 	{ "name": "requant_output_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "requant_output", "role": "d1" }} , 
 	{ "name": "layerNorm_gamma_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "address0" }} , 
 	{ "name": "layerNorm_gamma_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "ce0" }} , 
 	{ "name": "layerNorm_gamma_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "q0" }} , 
 	{ "name": "layerNorm_gamma_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "address1" }} , 
 	{ "name": "layerNorm_gamma_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "ce1" }} , 
 	{ "name": "layerNorm_gamma_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_gamma", "role": "q1" }} , 
 	{ "name": "layerNorm_beta_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "address0" }} , 
 	{ "name": "layerNorm_beta_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "ce0" }} , 
 	{ "name": "layerNorm_beta_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "q0" }} , 
 	{ "name": "layerNorm_beta_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "address1" }} , 
 	{ "name": "layerNorm_beta_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "ce1" }} , 
 	{ "name": "layerNorm_beta_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_beta", "role": "q1" }} , 
 	{ "name": "layerNorm_epsilon", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_epsilon", "role": "default" }} , 
 	{ "name": "layerNorm_out_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "address0" }} , 
 	{ "name": "layerNorm_out_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "ce0" }} , 
 	{ "name": "layerNorm_out_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "we0" }} , 
 	{ "name": "layerNorm_out_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "d0" }} , 
 	{ "name": "layerNorm_out_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "address1" }} , 
 	{ "name": "layerNorm_out_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "ce1" }} , 
 	{ "name": "layerNorm_out_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "we1" }} , 
 	{ "name": "layerNorm_out_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "layerNorm_out", "role": "d1" }} , 
 	{ "name": "residualAdd_residual_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "address0" }} , 
 	{ "name": "residualAdd_residual_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "ce0" }} , 
 	{ "name": "residualAdd_residual_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "q0" }} , 
 	{ "name": "residualAdd_residual_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "address1" }} , 
 	{ "name": "residualAdd_residual_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "ce1" }} , 
 	{ "name": "residualAdd_residual_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "residualAdd_residual", "role": "q1" }} , 
 	{ "name": "residualAdd_output_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "address0" }} , 
 	{ "name": "residualAdd_output_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "ce0" }} , 
 	{ "name": "residualAdd_output_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "we0" }} , 
 	{ "name": "residualAdd_output_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "d0" }} , 
 	{ "name": "residualAdd_output_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "address1" }} , 
 	{ "name": "residualAdd_output_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "ce1" }} , 
 	{ "name": "residualAdd_output_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "we1" }} , 
 	{ "name": "residualAdd_output_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "residualAdd_output", "role": "d1" }} , 
 	{ "name": "error", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "error", "role": "default" }} , 
 	{ "name": "error_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "error", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	compute_controller {
		reset {Type I LastRead 0 FirstWrite -1}
		compute_start {Type I LastRead 0 FirstWrite -1}
		compute_instruction {Type I LastRead 0 FirstWrite -1}
		compute_ready {Type O LastRead -1 FirstWrite 5}
		compute_done {Type O LastRead -1 FirstWrite 5}
		mem_transfer_done {Type I LastRead 0 FirstWrite -1}
		mem_read_request {Type O LastRead -1 FirstWrite 5}
		mem_write_request {Type O LastRead -1 FirstWrite 5}
		mem_op {Type O LastRead -1 FirstWrite 5}
		int8_activation {Type I LastRead 51 FirstWrite -1}
		OUT_PROJ_valueB {Type I LastRead 8 FirstWrite -1}
		OUT_PROJ_bias {Type I LastRead 1 FirstWrite -1}
		OUT_PROJ_accum {Type O LastRead -1 FirstWrite 9}
		FFN1_weights1 {Type I LastRead 4 FirstWrite -1}
		FFN1_biases {Type I LastRead 0 FirstWrite -1}
		FFN1_scale {Type I LastRead 4 FirstWrite -1}
		FFN1_output {Type O LastRead -1 FirstWrite 9}
		RELU_input {Type I LastRead 0 FirstWrite -1}
		RELU_output {Type O LastRead -1 FirstWrite 1}
		FFN2_input {Type I LastRead 11 FirstWrite -1}
		FFN2_weights2 {Type I LastRead 11 FirstWrite -1}
		FFN2_biases {Type I LastRead 0 FirstWrite -1}
		FFN2_scale {Type I LastRead 11 FirstWrite -1}
		FFN2_output {Type O LastRead -1 FirstWrite 19}
		requant_activation {Type I LastRead 4 FirstWrite -1}
		requant_scale {Type I LastRead 0 FirstWrite -1}
		requant_shift {Type I LastRead 0 FirstWrite -1}
		requant_zero_point {Type I LastRead 0 FirstWrite -1}
		requant_output {Type O LastRead -1 FirstWrite 2}
		layerNorm_gamma {Type I LastRead 52 FirstWrite -1}
		layerNorm_beta {Type I LastRead 52 FirstWrite -1}
		layerNorm_epsilon {Type I LastRead 0 FirstWrite -1}
		layerNorm_out {Type O LastRead -1 FirstWrite 49}
		residualAdd_residual {Type I LastRead 4 FirstWrite -1}
		residualAdd_output {Type O LastRead -1 FirstWrite 1}
		error {Type O LastRead -1 FirstWrite 0}
		state {Type IO LastRead -1 FirstWrite -1}
		req_instruction {Type IO LastRead -1 FirstWrite -1}
		req_op {Type IO LastRead -1 FirstWrite -1}}
	REQUANT_D_MODEL_int32_to_int8 {
		requant_activation {Type I LastRead 4 FirstWrite -1}
		M {Type I LastRead 1 FirstWrite -1}
		n {Type I LastRead 1 FirstWrite -1}
		z_out {Type I LastRead 2 FirstWrite -1}
		requant_output {Type O LastRead -1 FirstWrite 2}}
	LAYER_NORM {
		int8_activation {Type I LastRead 51 FirstWrite -1}
		layerNorm_gamma {Type I LastRead 52 FirstWrite -1}
		layerNorm_beta {Type I LastRead 52 FirstWrite -1}
		epsilon {Type I LastRead 3 FirstWrite -1}
		layerNorm_out {Type O LastRead -1 FirstWrite 49}}
	LAYER_NORM_Pipeline_VITIS_LOOP_79_1 {
		int8_activation {Type I LastRead 0 FirstWrite -1}
		square_out {Type O LastRead -1 FirstWrite 3}
		sum_out {Type O LastRead -1 FirstWrite 3}}
	sqrt_fixed_32_16_s {
		x {Type I LastRead 0 FirstWrite -1}}
	RES_ADD {
		int8_activation {Type I LastRead 4 FirstWrite -1}
		residualAdd_residual {Type I LastRead 4 FirstWrite -1}
		residualAdd_output {Type O LastRead -1 FirstWrite 1}}
	FFN_POST_ACT {
		FFN2_input {Type I LastRead 11 FirstWrite -1}
		FFN2_weights2 {Type I LastRead 11 FirstWrite -1}
		FFN2_biases {Type I LastRead 0 FirstWrite -1}
		FFN2_scale {Type I LastRead 11 FirstWrite -1}
		FFN2_output {Type O LastRead -1 FirstWrite 19}}
	FFN_POST_ACT_Pipeline_VITIS_LOOP_151_1 {
		FFN2_biases {Type I LastRead 0 FirstWrite -1}
		FFN2_weights2 {Type I LastRead 11 FirstWrite -1}
		FFN2_scale {Type I LastRead 11 FirstWrite -1}
		FFN2_input_load_12_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_11_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_10_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_9_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_8_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_7_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_6_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_5_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_4_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_3_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_2_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_1_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_cast {Type I LastRead 0 FirstWrite -1}
		sext_ln151 {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_20_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_19_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_18_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_17_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_16_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_15_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_14_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_input_load_13_cast {Type I LastRead 0 FirstWrite -1}
		FFN2_output {Type O LastRead -1 FirstWrite 19}}
	compute_controller_Pipeline_VITIS_LOOP_132_1 {
		RELU_input {Type I LastRead 0 FirstWrite -1}
		RELU_output {Type O LastRead -1 FirstWrite 1}}
	compute_controller_Pipeline_VITIS_LOOP_113_1 {
		FFN1_biases {Type I LastRead 0 FirstWrite -1}
		FFN1_weights1 {Type I LastRead 4 FirstWrite -1}
		FFN1_scale {Type I LastRead 4 FirstWrite -1}
		int8_activation_load_cast {Type I LastRead 0 FirstWrite -1}
		sext_ln113 {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_6_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_5_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_4_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_3_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_2_cast {Type I LastRead 0 FirstWrite -1}
		int8_activation_load_1_cast {Type I LastRead 0 FirstWrite -1}
		FFN1_output {Type O LastRead -1 FirstWrite 9}}
	OUT_PROJ {
		int8_activation {Type I LastRead 8 FirstWrite -1}
		OUT_PROJ_valueB {Type I LastRead 8 FirstWrite -1}
		bias_0_0_val {Type I LastRead 8 FirstWrite -1}
		bias_0_1_val {Type I LastRead 8 FirstWrite -1}
		OUT_PROJ_accum {Type O LastRead -1 FirstWrite 9}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "79"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "80"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	reset { ap_none {  { reset in_data 0 1 } } }
	compute_start { ap_none {  { compute_start in_data 0 1 } } }
	compute_instruction { ap_none {  { compute_instruction in_data 0 32 } } }
	compute_ready { ap_vld {  { compute_ready out_data 1 1 }  { compute_ready_ap_vld out_vld 1 1 } } }
	compute_done { ap_vld {  { compute_done out_data 1 1 }  { compute_done_ap_vld out_vld 1 1 } } }
	mem_transfer_done { ap_none {  { mem_transfer_done in_data 0 1 } } }
	mem_read_request { ap_vld {  { mem_read_request out_data 1 1 }  { mem_read_request_ap_vld out_vld 1 1 } } }
	mem_write_request { ap_vld {  { mem_write_request out_data 1 1 }  { mem_write_request_ap_vld out_vld 1 1 } } }
	mem_op { ap_vld {  { mem_op out_data 1 32 }  { mem_op_ap_vld out_vld 1 1 } } }
	int8_activation { ap_memory {  { int8_activation_address0 mem_address 1 3 }  { int8_activation_ce0 mem_ce 1 1 }  { int8_activation_q0 mem_dout 0 8 }  { int8_activation_address1 MemPortADDR2 1 3 }  { int8_activation_ce1 MemPortCE2 1 1 }  { int8_activation_q1 MemPortDOUT2 0 8 } } }
	OUT_PROJ_valueB { ap_memory {  { OUT_PROJ_valueB_address0 mem_address 1 4 }  { OUT_PROJ_valueB_ce0 mem_ce 1 1 }  { OUT_PROJ_valueB_q0 mem_dout 0 4 }  { OUT_PROJ_valueB_address1 MemPortADDR2 1 4 }  { OUT_PROJ_valueB_ce1 MemPortCE2 1 1 }  { OUT_PROJ_valueB_q1 MemPortDOUT2 0 4 } } }
	OUT_PROJ_bias { ap_memory {  { OUT_PROJ_bias_address0 mem_address 1 1 }  { OUT_PROJ_bias_ce0 mem_ce 1 1 }  { OUT_PROJ_bias_q0 mem_dout 0 32 }  { OUT_PROJ_bias_address1 MemPortADDR2 1 1 }  { OUT_PROJ_bias_ce1 MemPortCE2 1 1 }  { OUT_PROJ_bias_q1 MemPortDOUT2 0 32 } } }
	OUT_PROJ_accum { ap_memory {  { OUT_PROJ_accum_address0 mem_address 1 1 }  { OUT_PROJ_accum_ce0 mem_ce 1 1 }  { OUT_PROJ_accum_we0 mem_we 1 1 }  { OUT_PROJ_accum_d0 mem_din 1 32 }  { OUT_PROJ_accum_address1 MemPortADDR2 1 1 }  { OUT_PROJ_accum_ce1 MemPortCE2 1 1 }  { OUT_PROJ_accum_we1 MemPortWE2 1 1 }  { OUT_PROJ_accum_d1 MemPortDIN2 1 32 } } }
	FFN1_weights1 { ap_memory {  { FFN1_weights1_address0 mem_address 1 4 }  { FFN1_weights1_ce0 mem_ce 1 1 }  { FFN1_weights1_q0 mem_dout 0 4 }  { FFN1_weights1_address1 MemPortADDR2 1 4 }  { FFN1_weights1_ce1 MemPortCE2 1 1 }  { FFN1_weights1_q1 MemPortDOUT2 0 4 } } }
	FFN1_biases { ap_memory {  { FFN1_biases_address0 mem_address 1 1 }  { FFN1_biases_ce0 mem_ce 1 1 }  { FFN1_biases_q0 mem_dout 0 4 } } }
	FFN1_scale { ap_memory {  { FFN1_scale_address0 mem_address 1 1 }  { FFN1_scale_ce0 mem_ce 1 1 }  { FFN1_scale_q0 mem_dout 0 16 } } }
	FFN1_output { ap_memory {  { FFN1_output_address0 mem_address 1 1 }  { FFN1_output_ce0 mem_ce 1 1 }  { FFN1_output_we0 mem_we 1 1 }  { FFN1_output_d0 mem_din 1 16 } } }
	RELU_input { ap_memory {  { RELU_input_address0 mem_address 1 5 }  { RELU_input_ce0 mem_ce 1 1 }  { RELU_input_q0 mem_dout 0 16 } } }
	RELU_output { ap_memory {  { RELU_output_address0 mem_address 1 5 }  { RELU_output_ce0 mem_ce 1 1 }  { RELU_output_we0 mem_we 1 1 }  { RELU_output_d0 mem_din 1 16 } } }
	FFN2_input { ap_memory {  { FFN2_input_address0 mem_address 1 5 }  { FFN2_input_ce0 mem_ce 1 1 }  { FFN2_input_q0 mem_dout 0 16 }  { FFN2_input_address1 MemPortADDR2 1 5 }  { FFN2_input_ce1 MemPortCE2 1 1 }  { FFN2_input_q1 MemPortDOUT2 0 16 } } }
	FFN2_weights2 { ap_memory {  { FFN2_weights2_address0 mem_address 1 7 }  { FFN2_weights2_ce0 mem_ce 1 1 }  { FFN2_weights2_q0 mem_dout 0 4 }  { FFN2_weights2_address1 MemPortADDR2 1 7 }  { FFN2_weights2_ce1 MemPortCE2 1 1 }  { FFN2_weights2_q1 MemPortDOUT2 0 4 } } }
	FFN2_biases { ap_memory {  { FFN2_biases_address0 mem_address 1 3 }  { FFN2_biases_ce0 mem_ce 1 1 }  { FFN2_biases_q0 mem_dout 0 4 } } }
	FFN2_scale { ap_memory {  { FFN2_scale_address0 mem_address 1 3 }  { FFN2_scale_ce0 mem_ce 1 1 }  { FFN2_scale_q0 mem_dout 0 16 } } }
	FFN2_output { ap_memory {  { FFN2_output_address0 mem_address 1 3 }  { FFN2_output_ce0 mem_ce 1 1 }  { FFN2_output_we0 mem_we 1 1 }  { FFN2_output_d0 mem_din 1 32 } } }
	requant_activation { ap_memory {  { requant_activation_address0 mem_address 1 3 }  { requant_activation_ce0 mem_ce 1 1 }  { requant_activation_q0 mem_dout 0 32 }  { requant_activation_address1 MemPortADDR2 1 3 }  { requant_activation_ce1 MemPortCE2 1 1 }  { requant_activation_q1 MemPortDOUT2 0 32 } } }
	requant_scale { ap_none {  { requant_scale in_data 0 32 } } }
	requant_shift { ap_none {  { requant_shift in_data 0 32 } } }
	requant_zero_point { ap_none {  { requant_zero_point in_data 0 32 } } }
	requant_output { ap_memory {  { requant_output_address0 mem_address 1 3 }  { requant_output_ce0 mem_ce 1 1 }  { requant_output_we0 mem_we 1 1 }  { requant_output_d0 mem_din 1 8 }  { requant_output_address1 MemPortADDR2 1 3 }  { requant_output_ce1 MemPortCE2 1 1 }  { requant_output_we1 MemPortWE2 1 1 }  { requant_output_d1 MemPortDIN2 1 8 } } }
	layerNorm_gamma { ap_memory {  { layerNorm_gamma_address0 mem_address 1 3 }  { layerNorm_gamma_ce0 mem_ce 1 1 }  { layerNorm_gamma_q0 mem_dout 0 32 }  { layerNorm_gamma_address1 MemPortADDR2 1 3 }  { layerNorm_gamma_ce1 MemPortCE2 1 1 }  { layerNorm_gamma_q1 MemPortDOUT2 0 32 } } }
	layerNorm_beta { ap_memory {  { layerNorm_beta_address0 mem_address 1 3 }  { layerNorm_beta_ce0 mem_ce 1 1 }  { layerNorm_beta_q0 mem_dout 0 32 }  { layerNorm_beta_address1 MemPortADDR2 1 3 }  { layerNorm_beta_ce1 MemPortCE2 1 1 }  { layerNorm_beta_q1 MemPortDOUT2 0 32 } } }
	layerNorm_epsilon { ap_none {  { layerNorm_epsilon in_data 0 32 } } }
	layerNorm_out { ap_memory {  { layerNorm_out_address0 mem_address 1 3 }  { layerNorm_out_ce0 mem_ce 1 1 }  { layerNorm_out_we0 mem_we 1 1 }  { layerNorm_out_d0 mem_din 1 32 }  { layerNorm_out_address1 MemPortADDR2 1 3 }  { layerNorm_out_ce1 MemPortCE2 1 1 }  { layerNorm_out_we1 MemPortWE2 1 1 }  { layerNorm_out_d1 MemPortDIN2 1 32 } } }
	residualAdd_residual { ap_memory {  { residualAdd_residual_address0 mem_address 1 3 }  { residualAdd_residual_ce0 mem_ce 1 1 }  { residualAdd_residual_q0 mem_dout 0 8 }  { residualAdd_residual_address1 MemPortADDR2 1 3 }  { residualAdd_residual_ce1 MemPortCE2 1 1 }  { residualAdd_residual_q1 MemPortDOUT2 0 8 } } }
	residualAdd_output { ap_memory {  { residualAdd_output_address0 mem_address 1 3 }  { residualAdd_output_ce0 mem_ce 1 1 }  { residualAdd_output_we0 mem_we 1 1 }  { residualAdd_output_d0 mem_din 1 8 }  { residualAdd_output_address1 MemPortADDR2 1 3 }  { residualAdd_output_ce1 MemPortCE2 1 1 }  { residualAdd_output_we1 MemPortWE2 1 1 }  { residualAdd_output_d1 MemPortDIN2 1 8 } } }
	error { ap_vld {  { error out_data 1 1 }  { error_ap_vld out_vld 1 1 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
