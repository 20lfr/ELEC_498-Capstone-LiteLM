# This script segment is generated automatically by AutoPilot

set name headed_compute_controller_mul_31s_16ns_31_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler headed_compute_controller_sparsemux_33_4_16_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
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
    id 126 \
    name soft_out \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename soft_out \
    op interface \
    ports { soft_out_address0 { O 4 vector } soft_out_ce0 { O 1 bit } soft_out_we0 { O 1 bit } soft_out_d0 { O 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'soft_out'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 109 \
    name exp_buf_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_reload \
    op interface \
    ports { exp_buf_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 110 \
    name exp_buf_1_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_1_reload \
    op interface \
    ports { exp_buf_1_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 111 \
    name exp_buf_2_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_2_reload \
    op interface \
    ports { exp_buf_2_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 112 \
    name exp_buf_3_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_3_reload \
    op interface \
    ports { exp_buf_3_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 113 \
    name exp_buf_4_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_4_reload \
    op interface \
    ports { exp_buf_4_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 114 \
    name exp_buf_5_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_5_reload \
    op interface \
    ports { exp_buf_5_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 115 \
    name exp_buf_6_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_6_reload \
    op interface \
    ports { exp_buf_6_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 116 \
    name exp_buf_7_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_7_reload \
    op interface \
    ports { exp_buf_7_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 117 \
    name exp_buf_8_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_8_reload \
    op interface \
    ports { exp_buf_8_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 118 \
    name exp_buf_9_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_9_reload \
    op interface \
    ports { exp_buf_9_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 119 \
    name exp_buf_10_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_10_reload \
    op interface \
    ports { exp_buf_10_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 120 \
    name exp_buf_11_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_11_reload \
    op interface \
    ports { exp_buf_11_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 121 \
    name exp_buf_12_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_12_reload \
    op interface \
    ports { exp_buf_12_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 122 \
    name exp_buf_13_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_13_reload \
    op interface \
    ports { exp_buf_13_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 123 \
    name exp_buf_14_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_14_reload \
    op interface \
    ports { exp_buf_14_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 124 \
    name exp_buf_15_reload \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_exp_buf_15_reload \
    op interface \
    ports { exp_buf_15_reload { I 16 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 125 \
    name inv_sum_q15_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_inv_sum_q15_1 \
    op interface \
    ports { inv_sum_q15_1 { I 31 vector } } \
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


