# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 151 \
    name int8_activation \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename int8_activation \
    op interface \
    ports { int8_activation_address0 { O 3 vector } int8_activation_ce0 { O 1 bit } int8_activation_q0 { I 8 vector } int8_activation_address1 { O 3 vector } int8_activation_ce1 { O 1 bit } int8_activation_q1 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'int8_activation'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 152 \
    name OUT_PROJ_valueB \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename OUT_PROJ_valueB \
    op interface \
    ports { OUT_PROJ_valueB_address0 { O 4 vector } OUT_PROJ_valueB_ce0 { O 1 bit } OUT_PROJ_valueB_q0 { I 4 vector } OUT_PROJ_valueB_address1 { O 4 vector } OUT_PROJ_valueB_ce1 { O 1 bit } OUT_PROJ_valueB_q1 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'OUT_PROJ_valueB'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 153 \
    name OUT_PROJ_bias \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename OUT_PROJ_bias \
    op interface \
    ports { OUT_PROJ_bias_address0 { O 1 vector } OUT_PROJ_bias_ce0 { O 1 bit } OUT_PROJ_bias_q0 { I 32 vector } OUT_PROJ_bias_address1 { O 1 vector } OUT_PROJ_bias_ce1 { O 1 bit } OUT_PROJ_bias_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'OUT_PROJ_bias'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 154 \
    name OUT_PROJ_accum \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename OUT_PROJ_accum \
    op interface \
    ports { OUT_PROJ_accum_address0 { O 1 vector } OUT_PROJ_accum_ce0 { O 1 bit } OUT_PROJ_accum_we0 { O 1 bit } OUT_PROJ_accum_d0 { O 32 vector } OUT_PROJ_accum_address1 { O 1 vector } OUT_PROJ_accum_ce1 { O 1 bit } OUT_PROJ_accum_we1 { O 1 bit } OUT_PROJ_accum_d1 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'OUT_PROJ_accum'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 155 \
    name FFN1_weights1 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename FFN1_weights1 \
    op interface \
    ports { FFN1_weights1_address0 { O 4 vector } FFN1_weights1_ce0 { O 1 bit } FFN1_weights1_q0 { I 4 vector } FFN1_weights1_address1 { O 4 vector } FFN1_weights1_ce1 { O 1 bit } FFN1_weights1_q1 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'FFN1_weights1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 156 \
    name FFN1_biases \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename FFN1_biases \
    op interface \
    ports { FFN1_biases_address0 { O 1 vector } FFN1_biases_ce0 { O 1 bit } FFN1_biases_q0 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'FFN1_biases'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 157 \
    name FFN1_scale \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename FFN1_scale \
    op interface \
    ports { FFN1_scale_address0 { O 1 vector } FFN1_scale_ce0 { O 1 bit } FFN1_scale_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'FFN1_scale'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 158 \
    name FFN1_output \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename FFN1_output \
    op interface \
    ports { FFN1_output_address0 { O 1 vector } FFN1_output_ce0 { O 1 bit } FFN1_output_we0 { O 1 bit } FFN1_output_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'FFN1_output'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 159 \
    name RELU_input \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename RELU_input \
    op interface \
    ports { RELU_input_address0 { O 5 vector } RELU_input_ce0 { O 1 bit } RELU_input_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'RELU_input'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 160 \
    name RELU_output \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename RELU_output \
    op interface \
    ports { RELU_output_address0 { O 5 vector } RELU_output_ce0 { O 1 bit } RELU_output_we0 { O 1 bit } RELU_output_d0 { O 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'RELU_output'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 161 \
    name FFN2_input \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename FFN2_input \
    op interface \
    ports { FFN2_input_address0 { O 5 vector } FFN2_input_ce0 { O 1 bit } FFN2_input_q0 { I 16 vector } FFN2_input_address1 { O 5 vector } FFN2_input_ce1 { O 1 bit } FFN2_input_q1 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'FFN2_input'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 162 \
    name FFN2_weights2 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename FFN2_weights2 \
    op interface \
    ports { FFN2_weights2_address0 { O 7 vector } FFN2_weights2_ce0 { O 1 bit } FFN2_weights2_q0 { I 4 vector } FFN2_weights2_address1 { O 7 vector } FFN2_weights2_ce1 { O 1 bit } FFN2_weights2_q1 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'FFN2_weights2'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 163 \
    name FFN2_biases \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename FFN2_biases \
    op interface \
    ports { FFN2_biases_address0 { O 3 vector } FFN2_biases_ce0 { O 1 bit } FFN2_biases_q0 { I 4 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'FFN2_biases'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 164 \
    name FFN2_scale \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename FFN2_scale \
    op interface \
    ports { FFN2_scale_address0 { O 3 vector } FFN2_scale_ce0 { O 1 bit } FFN2_scale_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'FFN2_scale'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 165 \
    name FFN2_output \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename FFN2_output \
    op interface \
    ports { FFN2_output_address0 { O 3 vector } FFN2_output_ce0 { O 1 bit } FFN2_output_we0 { O 1 bit } FFN2_output_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'FFN2_output'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 166 \
    name requant_activation \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename requant_activation \
    op interface \
    ports { requant_activation_address0 { O 3 vector } requant_activation_ce0 { O 1 bit } requant_activation_q0 { I 32 vector } requant_activation_address1 { O 3 vector } requant_activation_ce1 { O 1 bit } requant_activation_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'requant_activation'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 170 \
    name requant_output \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename requant_output \
    op interface \
    ports { requant_output_address0 { O 3 vector } requant_output_ce0 { O 1 bit } requant_output_we0 { O 1 bit } requant_output_d0 { O 8 vector } requant_output_address1 { O 3 vector } requant_output_ce1 { O 1 bit } requant_output_we1 { O 1 bit } requant_output_d1 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'requant_output'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 171 \
    name layerNorm_gamma \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename layerNorm_gamma \
    op interface \
    ports { layerNorm_gamma_address0 { O 3 vector } layerNorm_gamma_ce0 { O 1 bit } layerNorm_gamma_q0 { I 32 vector } layerNorm_gamma_address1 { O 3 vector } layerNorm_gamma_ce1 { O 1 bit } layerNorm_gamma_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'layerNorm_gamma'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 172 \
    name layerNorm_beta \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename layerNorm_beta \
    op interface \
    ports { layerNorm_beta_address0 { O 3 vector } layerNorm_beta_ce0 { O 1 bit } layerNorm_beta_q0 { I 32 vector } layerNorm_beta_address1 { O 3 vector } layerNorm_beta_ce1 { O 1 bit } layerNorm_beta_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'layerNorm_beta'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 174 \
    name layerNorm_out \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename layerNorm_out \
    op interface \
    ports { layerNorm_out_address0 { O 3 vector } layerNorm_out_ce0 { O 1 bit } layerNorm_out_we0 { O 1 bit } layerNorm_out_d0 { O 32 vector } layerNorm_out_address1 { O 3 vector } layerNorm_out_ce1 { O 1 bit } layerNorm_out_we1 { O 1 bit } layerNorm_out_d1 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'layerNorm_out'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 175 \
    name residualAdd_residual \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename residualAdd_residual \
    op interface \
    ports { residualAdd_residual_address0 { O 3 vector } residualAdd_residual_ce0 { O 1 bit } residualAdd_residual_q0 { I 8 vector } residualAdd_residual_address1 { O 3 vector } residualAdd_residual_ce1 { O 1 bit } residualAdd_residual_q1 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'residualAdd_residual'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 176 \
    name residualAdd_output \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename residualAdd_output \
    op interface \
    ports { residualAdd_output_address0 { O 3 vector } residualAdd_output_ce0 { O 1 bit } residualAdd_output_we0 { O 1 bit } residualAdd_output_d0 { O 8 vector } residualAdd_output_address1 { O 3 vector } residualAdd_output_ce1 { O 1 bit } residualAdd_output_we1 { O 1 bit } residualAdd_output_d1 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'residualAdd_output'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 142 \
    name reset \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_reset \
    op interface \
    ports { reset { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 143 \
    name compute_start \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_start \
    op interface \
    ports { compute_start { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 144 \
    name compute_instruction \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_instruction \
    op interface \
    ports { compute_instruction { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 145 \
    name compute_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_ready \
    op interface \
    ports { compute_ready { O 1 vector } compute_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 146 \
    name compute_done \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_done \
    op interface \
    ports { compute_done { O 1 vector } compute_done_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 147 \
    name mem_transfer_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_transfer_done \
    op interface \
    ports { mem_transfer_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 148 \
    name mem_read_request \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_read_request \
    op interface \
    ports { mem_read_request { O 1 vector } mem_read_request_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 149 \
    name mem_write_request \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_write_request \
    op interface \
    ports { mem_write_request { O 1 vector } mem_write_request_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 150 \
    name mem_op \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_op \
    op interface \
    ports { mem_op { O 32 vector } mem_op_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 167 \
    name requant_scale \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_requant_scale \
    op interface \
    ports { requant_scale { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 168 \
    name requant_shift \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_requant_shift \
    op interface \
    ports { requant_shift { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 169 \
    name requant_zero_point \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_requant_zero_point \
    op interface \
    ports { requant_zero_point { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 173 \
    name layerNorm_epsilon \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_layerNorm_epsilon \
    op interface \
    ports { layerNorm_epsilon { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 177 \
    name error \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_error \
    op interface \
    ports { error { O 1 vector } error_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


