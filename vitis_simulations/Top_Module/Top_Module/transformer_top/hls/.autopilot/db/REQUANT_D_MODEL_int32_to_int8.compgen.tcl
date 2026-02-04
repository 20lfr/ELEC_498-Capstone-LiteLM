# This script segment is generated automatically by AutoPilot

set name transformer_top_mul_32s_32s_64_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 539 \
    name M \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_M \
    op interface \
    ports { M { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 540 \
    name n \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_n \
    op interface \
    ports { n { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 541 \
    name z_out \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_z_out \
    op interface \
    ports { z_out { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 542 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_49 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 543 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_48 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 544 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_47 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 545 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_46 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 546 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_45 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 547 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_44 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 548 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_43 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 549 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_42 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 550 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_41 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 551 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_40 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 552 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_47 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 553 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_46 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 554 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_45 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 555 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_44 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 556 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_43 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 557 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_42 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 558 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_29 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_29 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_29 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_29_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 559 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_28 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_28 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_28 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_28_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 560 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_27 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_27 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_27 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_27_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 561 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_26 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_26 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_26 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_26_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 562 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_25 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_25 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_25 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_25_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 563 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_24 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_24 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_24 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_24_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 564 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_23 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_23 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_23 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_23_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 565 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_22 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_22 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_22 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_22_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 566 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_21 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_21 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_21 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_21_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 567 \
    name compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_20 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_20 \
    op interface \
    ports { compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_20 { O 8 vector } compute_controller_ControlMemSpace_bool_unsigned_int_bool_bool_bool_bool_20_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 568 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_53 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_53 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_53 { O 8 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_53_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 569 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_52 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_52 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_52 { O 8 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_52_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 570 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_51 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_51 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_51 { O 8 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_51_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 571 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_50 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_50 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_50 { O 8 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_50_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 572 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_49 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_49 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_49 { O 8 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_49_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 573 \
    name p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_48 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_48 \
    op interface \
    ports { p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_48 { O 8 vector } p_ZZ18compute_controller15ControlMemSpacebjRbS0_bS0_S0_RjPKhPhR12ComputeStateS1_R_48_ap_vld { O 1 bit } } \
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


