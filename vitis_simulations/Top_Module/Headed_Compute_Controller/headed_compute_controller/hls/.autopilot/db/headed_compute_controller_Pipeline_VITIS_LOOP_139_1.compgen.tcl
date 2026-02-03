# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler headed_compute_controller_sparsemux_33_4_4_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


set name headed_compute_controller_mul_8s_8s_16_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler headed_compute_controller_mac_muladd_8s_8s_4s_16_4_1 BINDTYPE {op} TYPE {all} IMPL {dsp_slice} LATENCY 3
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler headed_compute_controller_mac_muladd_8s_8s_16s_17_4_1 BINDTYPE {op} TYPE {all} IMPL {dsp_slice} LATENCY 3
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
    id 335 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_33'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 336 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_32'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 337 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_31'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 338 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_30'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 339 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_29'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 340 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_28'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 341 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_27'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 342 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_26'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 343 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_25'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 344 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24_address0 { O 4 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24_ce0 { O 1 bit } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_24'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 345 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_17'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 346 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_16'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 347 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_15'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 348 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_14'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 349 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_13'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 350 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12_address0 { O 4 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12_ce0 { O 1 bit } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12_q0 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_12'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 314 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_114 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_114 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_114 { I 4 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 315 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_115 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_115 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_115 { I 4 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 316 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_116 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_116 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_116 { I 4 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 317 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_117 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_117 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_117 { I 4 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 318 \
    name sext_ln139 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_sext_ln139 \
    op interface \
    ports { sext_ln139 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 319 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_128 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_128 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_128 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 320 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_129 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_129 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_129 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 321 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_130 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_130 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_130 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 322 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_131 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_131 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_131 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 323 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_132 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_132 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_132 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 324 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_133 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_133 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_133 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 325 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_134 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_134 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_134 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 326 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_135 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_135 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_135 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 327 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_136 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_136 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_136 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 328 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_137 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_137 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_137 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 329 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_60 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_60 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_60 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 330 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_61 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_61 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_61 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 331 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_62 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_62 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_62 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 332 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_63 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_63 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_63 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 333 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_64 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_64 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_64 { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 334 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_23 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_23 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_23 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_23_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 351 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_22 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_22 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_22 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_22_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 352 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_21 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_21 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_21 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_21_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 353 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_20 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_20 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_20 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_20_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 354 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_19 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_19 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_19 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_19_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 355 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_18 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_18 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_18 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_18_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 356 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_17 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_17 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_17 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_17_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 357 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_16 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_16 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_16 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_16_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 358 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_15 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_15 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_15 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_15_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 359 \
    name headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_14 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_14 \
    op interface \
    ports { headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_14 { O 20 vector } headed_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_b_14_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 360 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_11 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_11 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_11 { O 20 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_11_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 361 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_10 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_10 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_10 { O 20 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_10_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 362 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_9 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_9 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_9 { O 20 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_9_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 363 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_8 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_8 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_8 { O 20 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_8_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 364 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_7 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_7 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_7 { O 20 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_7_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 365 \
    name p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_6 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_6 \
    op interface \
    ports { p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_6 { O 20 vector } p_ZZ25headed_compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_6_ap_vld { O 1 bit } } \
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


