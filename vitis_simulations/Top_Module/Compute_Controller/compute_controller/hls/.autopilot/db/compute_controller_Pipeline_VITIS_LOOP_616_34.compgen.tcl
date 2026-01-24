# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler compute_controller_sparsemux_33_4_15_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
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
    id 169 \
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
    id 170 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_168 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_168 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_168_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_168_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_168_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_168'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 171 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_167 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_167 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_167_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_167_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_167_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_167'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 172 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_166 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_166 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_166_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_166_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_166_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_166'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 173 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_165 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_165 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_165_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_165_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_165_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_165'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 174 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_164 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_164 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_164_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_164_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_164_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_164'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 175 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_163 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_163 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_163_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_163_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_163_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_163'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 176 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_162'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 177 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_161 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_161 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_161_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_161_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_161_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_161'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 178 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_160 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_160 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_160_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_160_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_160_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_160'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 179 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_159 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_159 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_159_address0 { O 1 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_159_ce0 { O 1 bit } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_159_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_159'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 180 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_89 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_89 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_89_address0 { O 1 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_89_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_89_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_89'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 181 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_88 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_88 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_88_address0 { O 1 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_88_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_88_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_88'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 182 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_87 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_87 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_87_address0 { O 1 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_87_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_87_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_87'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 183 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_86 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_86 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_86_address0 { O 1 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_86_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_86_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_86'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 184 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_85 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_85 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_85_address0 { O 1 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_85_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_85_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_85'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 185 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_84 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_84 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_84_address0 { O 1 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_84_ce0 { O 1 bit } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_84_q0 { I 15 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_84'"
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


