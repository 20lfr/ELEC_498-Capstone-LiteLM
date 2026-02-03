# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler headed_compute_controller_sparsemux_7_2_15_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {onehotencoding_realdef}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler headed_compute_controller_SOFTMAX_Pipeline_VITIS_LOOP_245_2_exp_lut_q15_ROM_AUTO_1R BINDTYPE {storage} TYPE {rom} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
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
    id 104 \
    name soft_in \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename soft_in \
    op interface \
    ports { soft_in_address0 { O 4 vector } soft_in_ce0 { O 1 bit } soft_in_q0 { I 16 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'soft_in'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 86 \
    name max_val_1_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_max_val_1_reload \
    op interface \
    ports { max_val_1_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 87 \
    name exp_buf_15_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_15_out \
    op interface \
    ports { exp_buf_15_out { O 16 vector } exp_buf_15_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 88 \
    name exp_buf_14_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_14_out \
    op interface \
    ports { exp_buf_14_out { O 16 vector } exp_buf_14_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 89 \
    name exp_buf_13_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_13_out \
    op interface \
    ports { exp_buf_13_out { O 16 vector } exp_buf_13_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 90 \
    name exp_buf_12_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_12_out \
    op interface \
    ports { exp_buf_12_out { O 16 vector } exp_buf_12_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 91 \
    name exp_buf_11_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_11_out \
    op interface \
    ports { exp_buf_11_out { O 16 vector } exp_buf_11_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 92 \
    name exp_buf_10_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_10_out \
    op interface \
    ports { exp_buf_10_out { O 16 vector } exp_buf_10_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 93 \
    name exp_buf_9_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_9_out \
    op interface \
    ports { exp_buf_9_out { O 16 vector } exp_buf_9_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 94 \
    name exp_buf_8_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_8_out \
    op interface \
    ports { exp_buf_8_out { O 16 vector } exp_buf_8_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 95 \
    name exp_buf_7_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_7_out \
    op interface \
    ports { exp_buf_7_out { O 16 vector } exp_buf_7_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 96 \
    name exp_buf_6_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_6_out \
    op interface \
    ports { exp_buf_6_out { O 16 vector } exp_buf_6_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 97 \
    name exp_buf_5_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_5_out \
    op interface \
    ports { exp_buf_5_out { O 16 vector } exp_buf_5_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 98 \
    name exp_buf_4_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_4_out \
    op interface \
    ports { exp_buf_4_out { O 16 vector } exp_buf_4_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 99 \
    name exp_buf_3_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_3_out \
    op interface \
    ports { exp_buf_3_out { O 16 vector } exp_buf_3_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 100 \
    name exp_buf_2_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_2_out \
    op interface \
    ports { exp_buf_2_out { O 16 vector } exp_buf_2_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 101 \
    name exp_buf_1_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_1_out \
    op interface \
    ports { exp_buf_1_out { O 16 vector } exp_buf_1_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 102 \
    name exp_buf_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_out \
    op interface \
    ports { exp_buf_out { O 16 vector } exp_buf_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 103 \
    name sum_exp_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_sum_exp_out \
    op interface \
    ports { sum_exp_out { O 19 vector } sum_exp_out_ap_vld { O 1 bit } } \
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
set InstName headed_compute_controller_flow_control_loop_pipe_sequential_init_U
set CompName headed_compute_controller_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix headed_compute_controller_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


