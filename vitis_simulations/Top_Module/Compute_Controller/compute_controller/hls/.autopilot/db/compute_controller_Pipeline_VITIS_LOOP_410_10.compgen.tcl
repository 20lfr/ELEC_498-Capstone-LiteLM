# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_sparsemux_33_4_19_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
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
    id 54 \
    name out_buf \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename out_buf \
    op interface \
    ports { out_buf_address0 { O 10 vector } out_buf_ce0 { O 1 bit } out_buf_we0 { O 1 bit } out_buf_d0 { O 8 vector } out_buf_address1 { O 10 vector } out_buf_ce1 { O 1 bit } out_buf_we1 { O 1 bit } out_buf_d1 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'out_buf'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 55 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_19 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_19 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_19_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_19_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_19_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_19'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 56 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_18 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_18 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_18_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_18_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_18_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_18'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 57 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_17 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_17 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_17_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_17_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_17_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_17'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 58 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_16 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_16 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_16_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_16_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_16_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_16'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 59 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_15 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_15 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_15_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_15_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_15_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_15'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 60 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_14 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_14 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_14_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_14_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_14_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_14'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 61 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_13 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_13 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_13_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_13_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_13_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_13'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 62 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_12 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_12 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_12_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_12_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_12_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_12'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 63 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_11'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 64 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_address0 { O 2 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_10'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 65 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_23 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_23 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_23_address0 { O 2 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_23_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_23_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_23'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 66 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_22 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_22 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_22_address0 { O 2 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_22_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_22_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_22'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 67 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_21 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_21 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_21_address0 { O 2 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_21_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_21_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_21'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 68 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_20 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_20 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_20_address0 { O 2 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_20_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_20_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_20'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 69 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_19 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_19 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_19_address0 { O 2 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_19_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_19_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_19'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 70 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_18 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_18 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_18_address0 { O 2 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_18_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_18_q0 { I 19 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_18'"
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


