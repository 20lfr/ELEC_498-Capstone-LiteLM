# This script segment is generated automatically by AutoPilot

set name compute_controller_mul_16s_4s_20_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_mac_muladd_16s_4s_4s_20_4_1 BINDTYPE {op} TYPE {all} IMPL {dsp_slice} LATENCY 3
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_mac_muladd_16s_4s_20s_21_4_1 BINDTYPE {op} TYPE {all} IMPL {dsp_slice} LATENCY 3
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_mac_muladd_16s_4s_21s_21_4_1 BINDTYPE {op} TYPE {all} IMPL {dsp_slice} LATENCY 3
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_am_addmul_23s_23s_16s_32_4_1 BINDTYPE {op} TYPE {all} IMPL {dsp_slice} LATENCY 3
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 61 \
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
    id 62 \
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
    id 63 \
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
    id 86 \
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


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 64 \
    name FFN2_input_load_12_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_12_cast \
    op interface \
    ports { FFN2_input_load_12_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 65 \
    name FFN2_input_load_11_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_11_cast \
    op interface \
    ports { FFN2_input_load_11_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 66 \
    name FFN2_input_load_10_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_10_cast \
    op interface \
    ports { FFN2_input_load_10_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 67 \
    name FFN2_input_load_9_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_9_cast \
    op interface \
    ports { FFN2_input_load_9_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 68 \
    name FFN2_input_load_8_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_8_cast \
    op interface \
    ports { FFN2_input_load_8_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 69 \
    name FFN2_input_load_7_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_7_cast \
    op interface \
    ports { FFN2_input_load_7_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 70 \
    name FFN2_input_load_6_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_6_cast \
    op interface \
    ports { FFN2_input_load_6_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 71 \
    name FFN2_input_load_5_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_5_cast \
    op interface \
    ports { FFN2_input_load_5_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 72 \
    name FFN2_input_load_4_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_4_cast \
    op interface \
    ports { FFN2_input_load_4_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 73 \
    name FFN2_input_load_3_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_3_cast \
    op interface \
    ports { FFN2_input_load_3_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 74 \
    name FFN2_input_load_2_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_2_cast \
    op interface \
    ports { FFN2_input_load_2_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 75 \
    name FFN2_input_load_1_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_1_cast \
    op interface \
    ports { FFN2_input_load_1_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 76 \
    name FFN2_input_load_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_cast \
    op interface \
    ports { FFN2_input_load_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 77 \
    name sext_ln151 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_sext_ln151 \
    op interface \
    ports { sext_ln151 { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 78 \
    name FFN2_input_load_20_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_20_cast \
    op interface \
    ports { FFN2_input_load_20_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 79 \
    name FFN2_input_load_19_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_19_cast \
    op interface \
    ports { FFN2_input_load_19_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 80 \
    name FFN2_input_load_18_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_18_cast \
    op interface \
    ports { FFN2_input_load_18_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 81 \
    name FFN2_input_load_17_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_17_cast \
    op interface \
    ports { FFN2_input_load_17_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 82 \
    name FFN2_input_load_16_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_16_cast \
    op interface \
    ports { FFN2_input_load_16_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 83 \
    name FFN2_input_load_15_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_15_cast \
    op interface \
    ports { FFN2_input_load_15_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 84 \
    name FFN2_input_load_14_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_14_cast \
    op interface \
    ports { FFN2_input_load_14_cast { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 85 \
    name FFN2_input_load_13_cast \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_FFN2_input_load_13_cast \
    op interface \
    ports { FFN2_input_load_13_cast { I 16 vector } } \
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


# flow_control definition:
set InstName compute_controller_flow_control_loop_pipe_sequential_init_U
set CompName compute_controller_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix compute_controller_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


