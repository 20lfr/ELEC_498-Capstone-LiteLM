# This script segment is generated automatically by AutoPilot

set name transformer_top_mul_32s_32s_32_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name transformer_top_mul_2s_32s_32_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


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
    id 129 \
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
    id 130 \
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
    id 131 \
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
    id 132 \
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
    id 133 \
    name dma_address \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dma_address \
    op interface \
    ports { dma_address { O 32 vector } dma_address_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 134 \
    name memory_request \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_memory_request \
    op interface \
    ports { memory_request { O 1 vector } memory_request_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 135 \
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
    id 136 \
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
    id 137 \
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
    id 138 \
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
    id 139 \
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
    id 140 \
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
    id 141 \
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
    id 142 \
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
    id 143 \
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
    id 144 \
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
    id 145 \
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
    id 146 \
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
    id 147 \
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
    id 148 \
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
    id 149 \
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
    id 150 \
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
    id 151 \
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
    id 152 \
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
    id 153 \
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
    id 154 \
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
    id 155 \
    name dbg_ctrl_mem \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_ctrl_mem \
    op interface \
    ports { dbg_ctrl_mem { O 1056 vector } dbg_ctrl_mem_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 156 \
    name control_reg \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_control_reg \
    op interface \
    ports { control_reg { O 32 vector } control_reg_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 157 \
    name irq_status_reg \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_irq_status_reg \
    op interface \
    ports { irq_status_reg { O 32 vector } irq_status_reg_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 158 \
    name irq_enable_reg \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_irq_enable_reg \
    op interface \
    ports { irq_enable_reg { O 32 vector } irq_enable_reg_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 159 \
    name wq_base_addr \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wq_base_addr \
    op interface \
    ports { wq_base_addr { O 32 vector } wq_base_addr_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 160 \
    name wk_base_addr \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wk_base_addr \
    op interface \
    ports { wk_base_addr { O 32 vector } wk_base_addr_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 161 \
    name wv_base_addr \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wv_base_addr \
    op interface \
    ports { wv_base_addr { O 32 vector } wv_base_addr_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 162 \
    name wo_base_addr \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wo_base_addr \
    op interface \
    ports { wo_base_addr { O 32 vector } wo_base_addr_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 163 \
    name w1_base_addr \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w1_base_addr \
    op interface \
    ports { w1_base_addr { O 32 vector } w1_base_addr_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 164 \
    name w2_base_addr \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w2_base_addr \
    op interface \
    ports { w2_base_addr { O 32 vector } w2_base_addr_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 165 \
    name wq_head_stride \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wq_head_stride \
    op interface \
    ports { wq_head_stride { O 32 vector } wq_head_stride_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 166 \
    name wk_head_stride \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wk_head_stride \
    op interface \
    ports { wk_head_stride { O 32 vector } wk_head_stride_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 167 \
    name wv_head_stride \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wv_head_stride \
    op interface \
    ports { wv_head_stride { O 32 vector } wv_head_stride_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 168 \
    name wo_tile_stride \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wo_tile_stride \
    op interface \
    ports { wo_tile_stride { O 32 vector } wo_tile_stride_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 169 \
    name w1_tile_stride \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w1_tile_stride \
    op interface \
    ports { w1_tile_stride { O 32 vector } w1_tile_stride_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 170 \
    name w2_tile_stride \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w2_tile_stride \
    op interface \
    ports { w2_tile_stride { O 32 vector } w2_tile_stride_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 171 \
    name dbg_wl_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_ready \
    op interface \
    ports { dbg_wl_ready { O 1 vector } dbg_wl_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 172 \
    name dbg_wl_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_start \
    op interface \
    ports { dbg_wl_start { O 1 vector } dbg_wl_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 173 \
    name dbg_wl_addr_sel \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_addr_sel \
    op interface \
    ports { dbg_wl_addr_sel { O 8 vector } dbg_wl_addr_sel_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 174 \
    name dbg_wl_layer \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_layer \
    op interface \
    ports { dbg_wl_layer { O 32 vector } dbg_wl_layer_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 175 \
    name dbg_wl_head \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_head \
    op interface \
    ports { dbg_wl_head { O 32 vector } dbg_wl_head_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 176 \
    name dbg_wl_tile \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_wl_tile \
    op interface \
    ports { dbg_wl_tile { O 32 vector } dbg_wl_tile_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 177 \
    name dbg_done \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_done \
    op interface \
    ports { dbg_done { O 1 vector } dbg_done_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 178 \
    name dbg_error \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_error \
    op interface \
    ports { dbg_error { O 1 vector } dbg_error_ap_vld { O 1 bit } } \
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


