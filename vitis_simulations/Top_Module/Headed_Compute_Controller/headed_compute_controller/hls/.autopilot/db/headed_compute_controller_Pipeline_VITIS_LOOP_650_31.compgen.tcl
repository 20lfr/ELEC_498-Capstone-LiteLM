# This script segment is generated automatically by AutoPilot

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
    id 50 \
    name in_buf \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename in_buf \
    op interface \
    ports { in_buf_address0 { O 7 vector } in_buf_ce0 { O 1 bit } in_buf_q0 { I 8 vector } in_buf_address1 { O 7 vector } in_buf_ce1 { O 1 bit } in_buf_q1 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'in_buf'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 51 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 52 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 53 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 54 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 55 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 56 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 57 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 58 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 59 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 60 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24_we0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 61 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17_we0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 62 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16_we0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 63 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15_we0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 64 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14_we0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 65 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13_we0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 66 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12_we0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12_d0 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12'"
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


