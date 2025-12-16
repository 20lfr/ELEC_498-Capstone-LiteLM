# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 119 \
    name axis_in_valid \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_axis_in_valid \
    op interface \
    ports { axis_in_valid { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 120 \
    name axis_in_last \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_axis_in_last \
    op interface \
    ports { axis_in_last { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 121 \
    name axis_in_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_axis_in_ready \
    op interface \
    ports { axis_in_ready { O 1 vector } axis_in_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 122 \
    name dma_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_dma_done \
    op interface \
    ports { dma_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 123 \
    name compute_ready \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_ready \
    op interface \
    ports { compute_ready { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 124 \
    name compute_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_done \
    op interface \
    ports { compute_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 125 \
    name head_ctx_ref_0 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_0 \
    op interface \
    ports { head_ctx_ref_0_i { I 202 vector } head_ctx_ref_0_o { O 202 vector } head_ctx_ref_0_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 126 \
    name head_ctx_ref_1 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_1 \
    op interface \
    ports { head_ctx_ref_1_i { I 202 vector } head_ctx_ref_1_o { O 202 vector } head_ctx_ref_1_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 127 \
    name head_ctx_ref_2 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_2 \
    op interface \
    ports { head_ctx_ref_2_i { I 202 vector } head_ctx_ref_2_o { O 202 vector } head_ctx_ref_2_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 128 \
    name head_ctx_ref_3 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_3 \
    op interface \
    ports { head_ctx_ref_3_i { I 202 vector } head_ctx_ref_3_o { O 202 vector } head_ctx_ref_3_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 129 \
    name compute_start \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_start \
    op interface \
    ports { compute_start_i { I 1 vector } compute_start_o { O 1 vector } compute_start_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 130 \
    name compute_op \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_compute_op \
    op interface \
    ports { compute_op { O 8 vector } compute_op_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 131 \
    name stream_ready \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_stream_ready \
    op interface \
    ports { stream_ready { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 132 \
    name stream_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_stream_start \
    op interface \
    ports { stream_start { O 1 vector } stream_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 133 \
    name stream_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_stream_done \
    op interface \
    ports { stream_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 134 \
    name wl_ready \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_ready \
    op interface \
    ports { wl_ready { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 135 \
    name wl_start \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_start \
    op interface \
    ports { wl_start_i { I 1 vector } wl_start_o { O 1 vector } wl_start_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 136 \
    name wl_addr_sel \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_addr_sel \
    op interface \
    ports { wl_addr_sel { O 8 vector } wl_addr_sel_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 137 \
    name wl_layer \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_layer \
    op interface \
    ports { wl_layer { O 32 vector } wl_layer_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 138 \
    name wl_head \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_head \
    op interface \
    ports { wl_head { O 32 vector } wl_head_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 139 \
    name wl_tile \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_tile \
    op interface \
    ports { wl_tile { O 32 vector } wl_tile_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 140 \
    name ctrl_addr \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctrl_addr \
    op interface \
    ports { ctrl_addr { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 141 \
    name ctrl_data_in \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctrl_data_in \
    op interface \
    ports { ctrl_data_in { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 142 \
    name ctrl_data_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_ctrl_data_out \
    op interface \
    ports { ctrl_data_out { O 32 vector } ctrl_data_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 143 \
    name ctrl_read_en \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctrl_read_en \
    op interface \
    ports { ctrl_read_en { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 144 \
    name ctrl_write_en \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctrl_write_en \
    op interface \
    ports { ctrl_write_en { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 145 \
    name ctrl_chip_en \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctrl_chip_en \
    op interface \
    ports { ctrl_chip_en { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 146 \
    name ctrl_resetn_in \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ctrl_resetn_in \
    op interface \
    ports { ctrl_resetn_in { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 147 \
    name dbg_state \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_state \
    op interface \
    ports { dbg_state { O 32 vector } dbg_state_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 148 \
    name dbg_ctrl_mem \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_ctrl_mem \
    op interface \
    ports { dbg_ctrl_mem { O 864 vector } dbg_ctrl_mem_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 149 \
    name irq_ps \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_irq_ps \
    op interface \
    ports { irq_ps { O 1 vector } irq_ps_ap_vld { O 1 bit } } \
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


