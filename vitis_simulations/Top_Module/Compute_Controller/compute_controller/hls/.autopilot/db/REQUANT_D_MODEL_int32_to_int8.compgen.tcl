# This script segment is generated automatically by AutoPilot

set name compute_controller_mul_32s_32s_64_1_1
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
    id 508 \
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
    id 509 \
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
    id 510 \
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
    id 511 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_49 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 512 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_48 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 513 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_47 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 514 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_46 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 515 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_45 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 516 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_44 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 517 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_43 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 518 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_42 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 519 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_41 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 520 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_40 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 521 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_47 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 522 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_46 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 523 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_45 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 524 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_44 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 525 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_43 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 526 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_42 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 527 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_29_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 528 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_28_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 529 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_27_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 530 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_26_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 531 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_25_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 532 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_24_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 533 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_23_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 534 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_22_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 535 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_21_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 536 \
    name compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 \
    op interface \
    ports { compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20 { O 8 vector } compute_controller_bool_bool_unsigned_int_bool_bool_bool_bool_bool_u_20_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 537 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53 { O 8 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_53_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 538 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52 { O 8 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_52_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 539 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51 { O 8 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_51_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 540 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50 { O 8 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_50_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 541 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49 { O 8 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_49_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 542 \
    name p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48 \
    op interface \
    ports { p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48 { O 8 vector } p_ZZ18compute_controllerbbjRbS_bS_S_RjPKhPhR12ComputeStateS0_RhS6_S6_S6_S_S_S_S_E_48_ap_vld { O 1 bit } } \
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


