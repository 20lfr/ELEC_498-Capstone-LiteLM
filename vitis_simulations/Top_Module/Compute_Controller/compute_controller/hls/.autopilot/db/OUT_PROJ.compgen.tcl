# This script segment is generated automatically by AutoPilot

set name compute_controller_mul_8s_4s_12_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_mac_muladd_8s_4s_12s_13_4_1 BINDTYPE {op} TYPE {all} IMPL {dsp_slice} LATENCY 3
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
    id 19 \
    name OUT_PROJ_valueA \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename OUT_PROJ_valueA \
    op interface \
    ports { OUT_PROJ_valueA_address0 { O 3 vector } OUT_PROJ_valueA_ce0 { O 1 bit } OUT_PROJ_valueA_q0 { I 8 vector } OUT_PROJ_valueA_address1 { O 3 vector } OUT_PROJ_valueA_ce1 { O 1 bit } OUT_PROJ_valueA_q1 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'OUT_PROJ_valueA'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 20 \
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
    id 21 \
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


