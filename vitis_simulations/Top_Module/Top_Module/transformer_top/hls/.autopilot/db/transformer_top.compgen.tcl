# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 928 \
    name in_buf \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename in_buf \
    op interface \
    ports { in_buf_address0 { O 8 vector } in_buf_ce0 { O 1 bit } in_buf_q0 { I 8 vector } in_buf_address1 { O 8 vector } in_buf_ce1 { O 1 bit } in_buf_q1 { I 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'in_buf'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 929 \
    name out_buf \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename out_buf \
    op interface \
    ports { out_buf_address0 { O 6 vector } out_buf_ce0 { O 1 bit } out_buf_we0 { O 1 bit } out_buf_d0 { O 8 vector } out_buf_address1 { O 6 vector } out_buf_ce1 { O 1 bit } out_buf_we1 { O 1 bit } out_buf_d1 { O 8 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'out_buf'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 917 \
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
    id 918 \
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
    id 919 \
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
    id 920 \
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
    id 921 \
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
    id 922 \
    name wl_instruction \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_wl_instruction \
    op interface \
    ports { wl_instruction { O 32 vector } wl_instruction_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 923 \
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
    id 924 \
    name mem_transfer_done \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_transfer_done \
    op interface \
    ports { mem_transfer_done { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 925 \
    name mem_read_request \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_read_request \
    op interface \
    ports { mem_read_request { O 1 vector } mem_read_request_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 926 \
    name mem_write_request \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_write_request \
    op interface \
    ports { mem_write_request { O 1 vector } mem_write_request_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 927 \
    name mem_op \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mem_op \
    op interface \
    ports { mem_op { O 32 vector } mem_op_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 930 \
    name head_ctx_ref_0 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_0 \
    op interface \
    ports { head_ctx_ref_0_i { I 214 vector } head_ctx_ref_0_o { O 214 vector } head_ctx_ref_0_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 931 \
    name head_ctx_ref_1 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_1 \
    op interface \
    ports { head_ctx_ref_1_i { I 214 vector } head_ctx_ref_1_o { O 214 vector } head_ctx_ref_1_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 932 \
    name head_ctx_ref_2 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_2 \
    op interface \
    ports { head_ctx_ref_2_i { I 214 vector } head_ctx_ref_2_o { O 214 vector } head_ctx_ref_2_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 933 \
    name head_ctx_ref_3 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_head_ctx_ref_3 \
    op interface \
    ports { head_ctx_ref_3_i { I 214 vector } head_ctx_ref_3_o { O 214 vector } head_ctx_ref_3_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 934 \
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
    id 935 \
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
    id 936 \
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
    id 937 \
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
    id 938 \
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
    id 939 \
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
    id 940 \
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
    id 941 \
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
    id 942 \
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
    id 943 \
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
    id 944 \
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
    id 945 \
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
    id 946 \
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
    id 947 \
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
    id 948 \
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
    id 949 \
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
    id 950 \
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
    id 951 \
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
    id 952 \
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
    id 953 \
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
    id 954 \
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
    id 955 \
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
    id 956 \
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
    id 957 \
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
    id 958 \
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
    id 959 \
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
    id 960 \
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
    id 961 \
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
    id 962 \
    name dbg_compute_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_compute_start \
    op interface \
    ports { dbg_compute_start { O 1 vector } dbg_compute_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 963 \
    name dbg_compute_instruction \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_compute_instruction \
    op interface \
    ports { dbg_compute_instruction { O 32 vector } dbg_compute_instruction_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 964 \
    name dbg_compute_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_compute_ready \
    op interface \
    ports { dbg_compute_ready { O 1 vector } dbg_compute_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 965 \
    name dbg_compute_done \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_compute_done \
    op interface \
    ports { dbg_compute_done { O 1 vector } dbg_compute_done_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 966 \
    name dbg_compute_state \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_compute_state \
    op interface \
    ports { dbg_compute_state { O 8 vector } dbg_compute_state_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 967 \
    name dbg_req_instruction \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_instruction \
    op interface \
    ports { dbg_req_instruction { O 32 vector } dbg_req_instruction_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 968 \
    name dbg_req_op \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_op \
    op interface \
    ports { dbg_req_op { O 8 vector } dbg_req_op_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 969 \
    name dbg_req_layer \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_layer \
    op interface \
    ports { dbg_req_layer { O 8 vector } dbg_req_layer_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 970 \
    name dbg_req_head \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_head \
    op interface \
    ports { dbg_req_head { O 8 vector } dbg_req_head_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 971 \
    name dbg_req_tile \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_req_tile \
    op interface \
    ports { dbg_req_tile { O 8 vector } dbg_req_tile_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 972 \
    name dbg_mac_start \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_mac_start \
    op interface \
    ports { dbg_mac_start { O 1 vector } dbg_mac_start_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 973 \
    name dbg_mac_ready \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_mac_ready \
    op interface \
    ports { dbg_mac_ready { O 1 vector } dbg_mac_ready_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 974 \
    name dbg_mac_complete \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_mac_complete \
    op interface \
    ports { dbg_mac_complete { O 1 vector } dbg_mac_complete_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 975 \
    name dbg_ctrl_reset_asserted \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dbg_ctrl_reset_asserted \
    op interface \
    ports { dbg_ctrl_reset_asserted { O 1 vector } dbg_ctrl_reset_asserted_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 976 \
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
    id 977 \
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


