; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Top_Module/Top_Module/transformer_top/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i32, i32, i8, i1, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }
%struct.ControlMemSpace = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }

; Function Attrs: noinline willreturn
define void @apatb_transformer_top_ir(i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %dma_done, i1 zeroext %wl_ready, i32* noalias nocapture nonnull dereferenceable(4) %wl_instruction, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i1 zeroext %mem_transfer_done, i1* noalias nocapture nonnull dereferenceable(1) %mem_read_request, i1* noalias nocapture nonnull dereferenceable(1) %mem_write_request, i32* noalias nocapture nonnull dereferenceable(4) %mem_op, i8* noalias nonnull readonly "fpga.decayed.dim.hint"="129" %in_buf, i8* noalias nocapture nonnull "fpga.decayed.dim.hint"="64" %out_buf, [4 x %struct.HeadCtx]* noalias nonnull dereferenceable(256) %head_ctx_ref, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* noalias nocapture nonnull dereferenceable(4) %ctrl_data_out, i1 zeroext %ctrl_read_en, i1 zeroext %ctrl_write_en, i1 zeroext %ctrl_chip_en, i1 zeroext %ctrl_resetn_in, i1* noalias nocapture nonnull dereferenceable(1) %irq_ps, i32* noalias nocapture nonnull dereferenceable(4) %dbg_state, %struct.ControlMemSpace* noalias nocapture nonnull dereferenceable(132) %dbg_ctrl_mem, i32* noalias nocapture nonnull dereferenceable(4) %control_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_status_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_enable_reg, i32* noalias nocapture nonnull dereferenceable(4) %wq_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wk_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wv_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wo_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w1_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w2_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wq_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wk_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wv_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wo_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w1_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w2_tile_stride, i1* noalias nocapture nonnull dereferenceable(1) %dbg_compute_start, i32* noalias nocapture nonnull dereferenceable(4) %dbg_compute_instruction, i1* noalias nocapture nonnull dereferenceable(1) %dbg_compute_ready, i1* noalias nocapture nonnull dereferenceable(1) %dbg_compute_done, i8* noalias nocapture nonnull dereferenceable(1) %dbg_compute_state, i32* noalias nocapture nonnull dereferenceable(4) %dbg_req_instruction, i8* noalias nocapture nonnull dereferenceable(1) %dbg_req_op, i8* noalias nocapture nonnull dereferenceable(1) %dbg_req_layer, i8* noalias nocapture nonnull dereferenceable(1) %dbg_req_head, i8* noalias nocapture nonnull dereferenceable(1) %dbg_req_tile, i1* noalias nocapture nonnull dereferenceable(1) %dbg_mac_start, i1* noalias nocapture nonnull dereferenceable(1) %dbg_mac_ready, i1* noalias nocapture nonnull dereferenceable(1) %dbg_mac_complete, i1* noalias nocapture nonnull dereferenceable(1) %dbg_ctrl_reset_asserted, i1* noalias nocapture nonnull dereferenceable(1) %dbg_done, i1* noalias nocapture nonnull dereferenceable(1) %dbg_error) local_unnamed_addr #0 {
entry:
  %axis_in_ready_copy = alloca i1, align 512
  %wl_instruction_copy = alloca i32, align 512
  %wl_start_copy = alloca i1, align 512
  %mem_read_request_copy = alloca i1, align 512
  %mem_write_request_copy = alloca i1, align 512
  %mem_op_copy = alloca i32, align 512
  %0 = bitcast i8* %in_buf to [129 x i8]*
  %in_buf_copy = alloca [129 x i8], align 512
  %1 = bitcast i8* %out_buf to [64 x i8]*
  %out_buf_copy = alloca [64 x i8], align 512
  %head_ctx_ref_copy_0 = alloca i214, align 512
  %head_ctx_ref_copy_1 = alloca i214, align 512
  %head_ctx_ref_copy_2 = alloca i214, align 512
  %head_ctx_ref_copy_3 = alloca i214, align 512
  %stream_start_copy = alloca i1, align 512
  %ctrl_data_out_copy = alloca i32, align 512
  %irq_ps_copy = alloca i1, align 512
  %dbg_state_copy = alloca i32, align 512
  %dbg_ctrl_mem_copy = alloca i1056, align 512
  %control_reg_copy = alloca i32, align 512
  %irq_status_reg_copy = alloca i32, align 512
  %irq_enable_reg_copy = alloca i32, align 512
  %wq_base_addr_copy = alloca i32, align 512
  %wk_base_addr_copy = alloca i32, align 512
  %wv_base_addr_copy = alloca i32, align 512
  %wo_base_addr_copy = alloca i32, align 512
  %w1_base_addr_copy = alloca i32, align 512
  %w2_base_addr_copy = alloca i32, align 512
  %wq_head_stride_copy = alloca i32, align 512
  %wk_head_stride_copy = alloca i32, align 512
  %wv_head_stride_copy = alloca i32, align 512
  %wo_tile_stride_copy = alloca i32, align 512
  %w1_tile_stride_copy = alloca i32, align 512
  %w2_tile_stride_copy = alloca i32, align 512
  %dbg_compute_start_copy = alloca i1, align 512
  %dbg_compute_instruction_copy = alloca i32, align 512
  %dbg_compute_ready_copy = alloca i1, align 512
  %dbg_compute_done_copy = alloca i1, align 512
  %dbg_compute_state_copy = alloca i8, align 512
  %dbg_req_instruction_copy = alloca i32, align 512
  %dbg_req_op_copy = alloca i8, align 512
  %dbg_req_layer_copy = alloca i8, align 512
  %dbg_req_head_copy = alloca i8, align 512
  %dbg_req_tile_copy = alloca i8, align 512
  %dbg_mac_start_copy = alloca i1, align 512
  %dbg_mac_ready_copy = alloca i1, align 512
  %dbg_mac_complete_copy = alloca i1, align 512
  %dbg_ctrl_reset_asserted_copy = alloca i1, align 512
  %dbg_done_copy = alloca i1, align 512
  %dbg_error_copy = alloca i1, align 512
  call void @copy_in(i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, i32* nonnull %wl_instruction, i32* nonnull align 512 %wl_instruction_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i1* nonnull %mem_read_request, i1* nonnull align 512 %mem_read_request_copy, i1* nonnull %mem_write_request, i1* nonnull align 512 %mem_write_request_copy, i32* nonnull %mem_op, i32* nonnull align 512 %mem_op_copy, [129 x i8]* nonnull %0, [129 x i8]* nonnull align 512 %in_buf_copy, [64 x i8]* nonnull %1, [64 x i8]* nonnull align 512 %out_buf_copy, [4 x %struct.HeadCtx]* nonnull %head_ctx_ref, i214* nonnull align 512 %head_ctx_ref_copy_0, i214* nonnull align 512 %head_ctx_ref_copy_1, i214* nonnull align 512 %head_ctx_ref_copy_2, i214* nonnull align 512 %head_ctx_ref_copy_3, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i32* nonnull %ctrl_data_out, i32* nonnull align 512 %ctrl_data_out_copy, i1* nonnull %irq_ps, i1* nonnull align 512 %irq_ps_copy, i32* nonnull %dbg_state, i32* nonnull align 512 %dbg_state_copy, %struct.ControlMemSpace* nonnull %dbg_ctrl_mem, i1056* nonnull align 512 %dbg_ctrl_mem_copy, i32* nonnull %control_reg, i32* nonnull align 512 %control_reg_copy, i32* nonnull %irq_status_reg, i32* nonnull align 512 %irq_status_reg_copy, i32* nonnull %irq_enable_reg, i32* nonnull align 512 %irq_enable_reg_copy, i32* nonnull %wq_base_addr, i32* nonnull align 512 %wq_base_addr_copy, i32* nonnull %wk_base_addr, i32* nonnull align 512 %wk_base_addr_copy, i32* nonnull %wv_base_addr, i32* nonnull align 512 %wv_base_addr_copy, i32* nonnull %wo_base_addr, i32* nonnull align 512 %wo_base_addr_copy, i32* nonnull %w1_base_addr, i32* nonnull align 512 %w1_base_addr_copy, i32* nonnull %w2_base_addr, i32* nonnull align 512 %w2_base_addr_copy, i32* nonnull %wq_head_stride, i32* nonnull align 512 %wq_head_stride_copy, i32* nonnull %wk_head_stride, i32* nonnull align 512 %wk_head_stride_copy, i32* nonnull %wv_head_stride, i32* nonnull align 512 %wv_head_stride_copy, i32* nonnull %wo_tile_stride, i32* nonnull align 512 %wo_tile_stride_copy, i32* nonnull %w1_tile_stride, i32* nonnull align 512 %w1_tile_stride_copy, i32* nonnull %w2_tile_stride, i32* nonnull align 512 %w2_tile_stride_copy, i1* nonnull %dbg_compute_start, i1* nonnull align 512 %dbg_compute_start_copy, i32* nonnull %dbg_compute_instruction, i32* nonnull align 512 %dbg_compute_instruction_copy, i1* nonnull %dbg_compute_ready, i1* nonnull align 512 %dbg_compute_ready_copy, i1* nonnull %dbg_compute_done, i1* nonnull align 512 %dbg_compute_done_copy, i8* nonnull %dbg_compute_state, i8* nonnull align 512 %dbg_compute_state_copy, i32* nonnull %dbg_req_instruction, i32* nonnull align 512 %dbg_req_instruction_copy, i8* nonnull %dbg_req_op, i8* nonnull align 512 %dbg_req_op_copy, i8* nonnull %dbg_req_layer, i8* nonnull align 512 %dbg_req_layer_copy, i8* nonnull %dbg_req_head, i8* nonnull align 512 %dbg_req_head_copy, i8* nonnull %dbg_req_tile, i8* nonnull align 512 %dbg_req_tile_copy, i1* nonnull %dbg_mac_start, i1* nonnull align 512 %dbg_mac_start_copy, i1* nonnull %dbg_mac_ready, i1* nonnull align 512 %dbg_mac_ready_copy, i1* nonnull %dbg_mac_complete, i1* nonnull align 512 %dbg_mac_complete_copy, i1* nonnull %dbg_ctrl_reset_asserted, i1* nonnull align 512 %dbg_ctrl_reset_asserted_copy, i1* nonnull %dbg_done, i1* nonnull align 512 %dbg_done_copy, i1* nonnull %dbg_error, i1* nonnull align 512 %dbg_error_copy)
  call void @apatb_transformer_top_hw(i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %dma_done, i1 %wl_ready, i32* %wl_instruction_copy, i1* %wl_start_copy, i1 %mem_transfer_done, i1* %mem_read_request_copy, i1* %mem_write_request_copy, i32* %mem_op_copy, [129 x i8]* %in_buf_copy, [64 x i8]* %out_buf_copy, i214* %head_ctx_ref_copy_0, i214* %head_ctx_ref_copy_1, i214* %head_ctx_ref_copy_2, i214* %head_ctx_ref_copy_3, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* %ctrl_data_out_copy, i1 %ctrl_read_en, i1 %ctrl_write_en, i1 %ctrl_chip_en, i1 %ctrl_resetn_in, i1* %irq_ps_copy, i32* %dbg_state_copy, i1056* %dbg_ctrl_mem_copy, i32* %control_reg_copy, i32* %irq_status_reg_copy, i32* %irq_enable_reg_copy, i32* %wq_base_addr_copy, i32* %wk_base_addr_copy, i32* %wv_base_addr_copy, i32* %wo_base_addr_copy, i32* %w1_base_addr_copy, i32* %w2_base_addr_copy, i32* %wq_head_stride_copy, i32* %wk_head_stride_copy, i32* %wv_head_stride_copy, i32* %wo_tile_stride_copy, i32* %w1_tile_stride_copy, i32* %w2_tile_stride_copy, i1* %dbg_compute_start_copy, i32* %dbg_compute_instruction_copy, i1* %dbg_compute_ready_copy, i1* %dbg_compute_done_copy, i8* %dbg_compute_state_copy, i32* %dbg_req_instruction_copy, i8* %dbg_req_op_copy, i8* %dbg_req_layer_copy, i8* %dbg_req_head_copy, i8* %dbg_req_tile_copy, i1* %dbg_mac_start_copy, i1* %dbg_mac_ready_copy, i1* %dbg_mac_complete_copy, i1* %dbg_ctrl_reset_asserted_copy, i1* %dbg_done_copy, i1* %dbg_error_copy)
  call void @copy_back(i1* %axis_in_ready, i1* %axis_in_ready_copy, i32* %wl_instruction, i32* %wl_instruction_copy, i1* %wl_start, i1* %wl_start_copy, i1* %mem_read_request, i1* %mem_read_request_copy, i1* %mem_write_request, i1* %mem_write_request_copy, i32* %mem_op, i32* %mem_op_copy, [129 x i8]* %0, [129 x i8]* %in_buf_copy, [64 x i8]* %1, [64 x i8]* %out_buf_copy, [4 x %struct.HeadCtx]* %head_ctx_ref, i214* %head_ctx_ref_copy_0, i214* %head_ctx_ref_copy_1, i214* %head_ctx_ref_copy_2, i214* %head_ctx_ref_copy_3, i1* %stream_start, i1* %stream_start_copy, i32* %ctrl_data_out, i32* %ctrl_data_out_copy, i1* %irq_ps, i1* %irq_ps_copy, i32* %dbg_state, i32* %dbg_state_copy, %struct.ControlMemSpace* %dbg_ctrl_mem, i1056* %dbg_ctrl_mem_copy, i32* %control_reg, i32* %control_reg_copy, i32* %irq_status_reg, i32* %irq_status_reg_copy, i32* %irq_enable_reg, i32* %irq_enable_reg_copy, i32* %wq_base_addr, i32* %wq_base_addr_copy, i32* %wk_base_addr, i32* %wk_base_addr_copy, i32* %wv_base_addr, i32* %wv_base_addr_copy, i32* %wo_base_addr, i32* %wo_base_addr_copy, i32* %w1_base_addr, i32* %w1_base_addr_copy, i32* %w2_base_addr, i32* %w2_base_addr_copy, i32* %wq_head_stride, i32* %wq_head_stride_copy, i32* %wk_head_stride, i32* %wk_head_stride_copy, i32* %wv_head_stride, i32* %wv_head_stride_copy, i32* %wo_tile_stride, i32* %wo_tile_stride_copy, i32* %w1_tile_stride, i32* %w1_tile_stride_copy, i32* %w2_tile_stride, i32* %w2_tile_stride_copy, i1* %dbg_compute_start, i1* %dbg_compute_start_copy, i32* %dbg_compute_instruction, i32* %dbg_compute_instruction_copy, i1* %dbg_compute_ready, i1* %dbg_compute_ready_copy, i1* %dbg_compute_done, i1* %dbg_compute_done_copy, i8* %dbg_compute_state, i8* %dbg_compute_state_copy, i32* %dbg_req_instruction, i32* %dbg_req_instruction_copy, i8* %dbg_req_op, i8* %dbg_req_op_copy, i8* %dbg_req_layer, i8* %dbg_req_layer_copy, i8* %dbg_req_head, i8* %dbg_req_head_copy, i8* %dbg_req_tile, i8* %dbg_req_tile_copy, i1* %dbg_mac_start, i1* %dbg_mac_start_copy, i1* %dbg_mac_ready, i1* %dbg_mac_ready_copy, i1* %dbg_mac_complete, i1* %dbg_mac_complete_copy, i1* %dbg_ctrl_reset_asserted, i1* %dbg_ctrl_reset_asserted_copy, i1* %dbg_done, i1* %dbg_done_copy, i1* %dbg_error, i1* %dbg_error_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i1(i1* noalias align 512 %dst, i1* noalias readonly %src) unnamed_addr #1 {
entry:
  %0 = icmp eq i1* %dst, null
  %1 = icmp eq i1* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = bitcast i1* %src to i8*
  %4 = load i8, i8* %3
  %5 = trunc i8 %4 to i1
  store i1 %5, i1* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i32(i32* noalias align 512 %dst, i32* noalias readonly %src) unnamed_addr #1 {
entry:
  %0 = icmp eq i32* %dst, null
  %1 = icmp eq i32* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = load i32, i32* %src, align 4
  store i32 %3, i32* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a129i8([129 x i8]* noalias align 512 %dst, [129 x i8]* noalias readonly %src) unnamed_addr #1 {
entry:
  %0 = icmp eq [129 x i8]* %dst, null
  %1 = icmp eq [129 x i8]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a129i8([129 x i8]* nonnull %dst, [129 x i8]* nonnull %src, i64 129)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a129i8([129 x i8]* %dst, [129 x i8]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [129 x i8]* %src, null
  %1 = icmp eq [129 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [129 x i8], [129 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [129 x i8], [129 x i8]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i8, i8* %src.addr, align 1
  store i8 %3, i8* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a64i8([64 x i8]* noalias align 512 %dst, [64 x i8]* noalias readonly %src) unnamed_addr #1 {
entry:
  %0 = icmp eq [64 x i8]* %dst, null
  %1 = icmp eq [64 x i8]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a64i8([64 x i8]* nonnull %dst, [64 x i8]* nonnull %src, i64 64)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a64i8([64 x i8]* %dst, [64 x i8]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [64 x i8]* %src, null
  %1 = icmp eq [64 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [64 x i8], [64 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [64 x i8], [64 x i8]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i8, i8* %src.addr, align 1
  store i8 %3, i8* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond98 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond98, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx99 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 0
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 1
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 1
  %4 = load i32, i32* %src.addr.110, align 4
  store i32 %4, i32* %dst.addr.111, align 4
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 2
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 2
  %5 = load i8, i8* %src.addr.212, align 1
  store i8 %5, i8* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 3
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 3
  %6 = bitcast i1* %src.addr.314 to i8*
  %7 = load i8, i8* %6
  %8 = trunc i8 %7 to i1
  store i1 %8, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 4
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 4
  %9 = bitcast i1* %src.addr.416 to i8*
  %10 = load i8, i8* %9
  %11 = trunc i8 %10 to i1
  store i1 %11, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 5
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 5
  %12 = bitcast i1* %src.addr.518 to i8*
  %13 = load i8, i8* %12
  %14 = trunc i8 %13 to i1
  store i1 %14, i1* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 6
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 6
  %15 = load i32, i32* %src.addr.620, align 4
  store i32 %15, i32* %dst.addr.621, align 4
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 7
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 7
  %16 = load i32, i32* %src.addr.722, align 4
  store i32 %16, i32* %dst.addr.723, align 4
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 8
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 8
  %17 = load i8, i8* %src.addr.824, align 1
  store i8 %17, i8* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 9
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 9
  %18 = bitcast i1* %src.addr.926 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  store i1 %20, i1* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 10
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 10
  %21 = bitcast i1* %src.addr.1028 to i8*
  %22 = load i8, i8* %21
  %23 = trunc i8 %22 to i1
  store i1 %23, i1* %dst.addr.1029, align 1
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 11
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 11
  %24 = load i32, i32* %src.addr.1130, align 4
  store i32 %24, i32* %dst.addr.1131, align 4
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 12
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 12
  %25 = bitcast i1* %src.addr.1232 to i8*
  %26 = load i8, i8* %25
  %27 = trunc i8 %26 to i1
  store i1 %27, i1* %dst.addr.1233, align 1
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 13
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 13
  %28 = bitcast i1* %src.addr.1334 to i8*
  %29 = load i8, i8* %28
  %30 = trunc i8 %29 to i1
  store i1 %30, i1* %dst.addr.1335, align 1
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 14
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 14
  %31 = bitcast i1* %src.addr.1436 to i8*
  %32 = load i8, i8* %31
  %33 = trunc i8 %32 to i1
  store i1 %33, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 15
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 15
  %34 = bitcast i1* %src.addr.1538 to i8*
  %35 = load i8, i8* %34
  %36 = trunc i8 %35 to i1
  store i1 %36, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 16
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 16
  %37 = bitcast i1* %src.addr.1640 to i8*
  %38 = load i8, i8* %37
  %39 = trunc i8 %38 to i1
  store i1 %39, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 17
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 17
  %40 = bitcast i1* %src.addr.1742 to i8*
  %41 = load i8, i8* %40
  %42 = trunc i8 %41 to i1
  store i1 %42, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 18
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 18
  %43 = bitcast i1* %src.addr.1844 to i8*
  %44 = load i8, i8* %43
  %45 = trunc i8 %44 to i1
  store i1 %45, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 19
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 19
  %46 = bitcast i1* %src.addr.1946 to i8*
  %47 = load i8, i8* %46
  %48 = trunc i8 %47 to i1
  store i1 %48, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 20
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 20
  %49 = bitcast i1* %src.addr.2048 to i8*
  %50 = load i8, i8* %49
  %51 = trunc i8 %50 to i1
  store i1 %51, i1* %dst.addr.2049, align 1
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 21
  %dst.addr.2151 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 21
  %52 = bitcast i1* %src.addr.2150 to i8*
  %53 = load i8, i8* %52
  %54 = trunc i8 %53 to i1
  store i1 %54, i1* %dst.addr.2151, align 1
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 22
  %dst.addr.2253 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 22
  %55 = bitcast i1* %src.addr.2252 to i8*
  %56 = load i8, i8* %55
  %57 = trunc i8 %56 to i1
  store i1 %57, i1* %dst.addr.2253, align 1
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 23
  %dst.addr.2355 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 23
  %58 = bitcast i1* %src.addr.2354 to i8*
  %59 = load i8, i8* %58
  %60 = trunc i8 %59 to i1
  store i1 %60, i1* %dst.addr.2355, align 1
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 24
  %dst.addr.2457 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 24
  %61 = bitcast i1* %src.addr.2456 to i8*
  %62 = load i8, i8* %61
  %63 = trunc i8 %62 to i1
  store i1 %63, i1* %dst.addr.2457, align 1
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 25
  %dst.addr.2559 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 25
  %64 = bitcast i1* %src.addr.2558 to i8*
  %65 = load i8, i8* %64
  %66 = trunc i8 %65 to i1
  store i1 %66, i1* %dst.addr.2559, align 1
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 26
  %dst.addr.2661 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 26
  %67 = bitcast i1* %src.addr.2660 to i8*
  %68 = load i8, i8* %67
  %69 = trunc i8 %68 to i1
  store i1 %69, i1* %dst.addr.2661, align 1
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 27
  %dst.addr.2763 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 27
  %70 = bitcast i1* %src.addr.2762 to i8*
  %71 = load i8, i8* %70
  %72 = trunc i8 %71 to i1
  store i1 %72, i1* %dst.addr.2763, align 1
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 28
  %dst.addr.2865 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 28
  %73 = bitcast i1* %src.addr.2864 to i8*
  %74 = load i8, i8* %73
  %75 = trunc i8 %74 to i1
  store i1 %75, i1* %dst.addr.2865, align 1
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 29
  %dst.addr.2967 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 29
  %76 = bitcast i1* %src.addr.2966 to i8*
  %77 = load i8, i8* %76
  %78 = trunc i8 %77 to i1
  store i1 %78, i1* %dst.addr.2967, align 1
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 30
  %dst.addr.3069 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 30
  %79 = bitcast i1* %src.addr.3068 to i8*
  %80 = load i8, i8* %79
  %81 = trunc i8 %80 to i1
  store i1 %81, i1* %dst.addr.3069, align 1
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 31
  %dst.addr.3171 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 31
  %82 = bitcast i1* %src.addr.3170 to i8*
  %83 = load i8, i8* %82
  %84 = trunc i8 %83 to i1
  store i1 %84, i1* %dst.addr.3171, align 1
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 32
  %dst.addr.3273 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 32
  %85 = bitcast i1* %src.addr.3272 to i8*
  %86 = load i8, i8* %85
  %87 = trunc i8 %86 to i1
  store i1 %87, i1* %dst.addr.3273, align 1
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 33
  %dst.addr.3375 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 33
  %88 = bitcast i1* %src.addr.3374 to i8*
  %89 = load i8, i8* %88
  %90 = trunc i8 %89 to i1
  store i1 %90, i1* %dst.addr.3375, align 1
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 34
  %dst.addr.3477 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 34
  %91 = bitcast i1* %src.addr.3476 to i8*
  %92 = load i8, i8* %91
  %93 = trunc i8 %92 to i1
  store i1 %93, i1* %dst.addr.3477, align 1
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 35
  %dst.addr.3579 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 35
  %94 = bitcast i1* %src.addr.3578 to i8*
  %95 = load i8, i8* %94
  %96 = trunc i8 %95 to i1
  store i1 %96, i1* %dst.addr.3579, align 1
  %src.addr.3680 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 36
  %dst.addr.3681 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 36
  %97 = bitcast i1* %src.addr.3680 to i8*
  %98 = load i8, i8* %97
  %99 = trunc i8 %98 to i1
  store i1 %99, i1* %dst.addr.3681, align 1
  %src.addr.3782 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 37
  %dst.addr.3783 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 37
  %100 = bitcast i1* %src.addr.3782 to i8*
  %101 = load i8, i8* %100
  %102 = trunc i8 %101 to i1
  store i1 %102, i1* %dst.addr.3783, align 1
  %src.addr.3884 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 38
  %dst.addr.3885 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 38
  %103 = bitcast i1* %src.addr.3884 to i8*
  %104 = load i8, i8* %103
  %105 = trunc i8 %104 to i1
  store i1 %105, i1* %dst.addr.3885, align 1
  %src.addr.3986 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 39
  %dst.addr.3987 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 39
  %106 = bitcast i1* %src.addr.3986 to i8*
  %107 = load i8, i8* %106
  %108 = trunc i8 %107 to i1
  store i1 %108, i1* %dst.addr.3987, align 1
  %src.addr.4088 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 40
  %dst.addr.4089 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 40
  %109 = bitcast i1* %src.addr.4088 to i8*
  %110 = load i8, i8* %109
  %111 = trunc i8 %110 to i1
  store i1 %111, i1* %dst.addr.4089, align 1
  %src.addr.4190 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 41
  %dst.addr.4191 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 41
  %112 = bitcast i1* %src.addr.4190 to i8*
  %113 = load i8, i8* %112
  %114 = trunc i8 %113 to i1
  store i1 %114, i1* %dst.addr.4191, align 1
  %src.addr.4292 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 42
  %dst.addr.4293 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 42
  %115 = bitcast i1* %src.addr.4292 to i8*
  %116 = load i8, i8* %115
  %117 = trunc i8 %116 to i1
  store i1 %117, i1* %dst.addr.4293, align 1
  %src.addr.4394 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 43
  %dst.addr.4395 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 43
  %118 = bitcast i1* %src.addr.4394 to i8*
  %119 = load i8, i8* %118
  %120 = trunc i8 %119 to i1
  store i1 %120, i1* %dst.addr.4395, align 1
  %src.addr.4496 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 44
  %dst.addr.4497 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 44
  %121 = bitcast i1* %src.addr.4496 to i8*
  %122 = load i8, i8* %121
  %123 = trunc i8 %122 to i1
  store i1 %123, i1* %dst.addr.4497, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx99, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.ControlMemSpace(i1056* noalias align 512 %dst, %struct.ControlMemSpace* noalias readonly %src) unnamed_addr #1 {
entry:
  %0 = icmp eq i1056* %dst, null
  %1 = icmp eq %struct.ControlMemSpace* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 0
  %3 = load i32, i32* %src.0, align 4
  %4 = zext i32 %3 to i1056
  %src.1 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 1
  %5 = load i32, i32* %src.1, align 4
  %6 = zext i32 %5 to i1056
  %7 = shl i1056 %6, 32
  %src.2 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 2
  %8 = load i32, i32* %src.2, align 4
  %9 = zext i32 %8 to i1056
  %10 = shl i1056 %9, 64
  %src.3 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 3
  %11 = load i32, i32* %src.3, align 4
  %12 = zext i32 %11 to i1056
  %13 = shl i1056 %12, 96
  %src.4 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 4
  %14 = load i32, i32* %src.4, align 4
  %15 = zext i32 %14 to i1056
  %16 = shl i1056 %15, 128
  %src.5 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 5
  %17 = load i32, i32* %src.5, align 4
  %18 = zext i32 %17 to i1056
  %19 = shl i1056 %18, 160
  %src.6 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 6
  %20 = load i32, i32* %src.6, align 4
  %21 = zext i32 %20 to i1056
  %22 = shl i1056 %21, 192
  %src.7 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 7
  %23 = load i32, i32* %src.7, align 4
  %24 = zext i32 %23 to i1056
  %25 = shl i1056 %24, 224
  %src.8 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 8
  %26 = load i32, i32* %src.8, align 4
  %27 = zext i32 %26 to i1056
  %28 = shl i1056 %27, 256
  %src.9 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 9
  %29 = load i32, i32* %src.9, align 4
  %30 = zext i32 %29 to i1056
  %31 = shl i1056 %30, 288
  %src.10 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 10
  %32 = load i32, i32* %src.10, align 4
  %33 = zext i32 %32 to i1056
  %34 = shl i1056 %33, 320
  %src.11 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 11
  %35 = load i32, i32* %src.11, align 4
  %36 = zext i32 %35 to i1056
  %37 = shl i1056 %36, 352
  %src.12 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 12
  %38 = load i32, i32* %src.12, align 4
  %39 = zext i32 %38 to i1056
  %40 = shl i1056 %39, 384
  %src.13 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 13
  %41 = load i32, i32* %src.13, align 4
  %42 = zext i32 %41 to i1056
  %43 = shl i1056 %42, 416
  %src.14 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 14
  %44 = load i32, i32* %src.14, align 4
  %45 = zext i32 %44 to i1056
  %46 = shl i1056 %45, 448
  %src.15 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 15
  %47 = load i32, i32* %src.15, align 4
  %48 = zext i32 %47 to i1056
  %49 = shl i1056 %48, 480
  %src.16 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 16
  %50 = load i32, i32* %src.16, align 4
  %51 = zext i32 %50 to i1056
  %52 = shl i1056 %51, 512
  %src.17 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 17
  %53 = load i32, i32* %src.17, align 4
  %54 = zext i32 %53 to i1056
  %55 = shl i1056 %54, 544
  %src.18 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 18
  %56 = load i32, i32* %src.18, align 4
  %57 = zext i32 %56 to i1056
  %58 = shl i1056 %57, 576
  %src.19 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 19
  %59 = load i32, i32* %src.19, align 4
  %60 = zext i32 %59 to i1056
  %61 = shl i1056 %60, 608
  %src.20 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 20
  %62 = load i32, i32* %src.20, align 4
  %63 = zext i32 %62 to i1056
  %64 = shl i1056 %63, 640
  %src.21 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 21
  %65 = load i32, i32* %src.21, align 4
  %66 = zext i32 %65 to i1056
  %67 = shl i1056 %66, 672
  %src.22 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 22
  %68 = load i32, i32* %src.22, align 4
  %69 = zext i32 %68 to i1056
  %70 = shl i1056 %69, 704
  %src.23 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 23
  %71 = load i32, i32* %src.23, align 4
  %72 = zext i32 %71 to i1056
  %73 = shl i1056 %72, 736
  %src.24 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 24
  %74 = load i32, i32* %src.24, align 4
  %75 = zext i32 %74 to i1056
  %76 = shl i1056 %75, 768
  %src.25 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 25
  %77 = load i32, i32* %src.25, align 4
  %78 = zext i32 %77 to i1056
  %79 = shl i1056 %78, 800
  %src.26 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 26
  %80 = load i32, i32* %src.26, align 4
  %81 = zext i32 %80 to i1056
  %82 = shl i1056 %81, 832
  %src.27 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 27
  %83 = load i32, i32* %src.27, align 4
  %84 = zext i32 %83 to i1056
  %85 = shl i1056 %84, 864
  %src.28 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 28
  %86 = load i32, i32* %src.28, align 4
  %87 = zext i32 %86 to i1056
  %88 = shl i1056 %87, 896
  %src.29 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 29
  %89 = load i32, i32* %src.29, align 4
  %90 = zext i32 %89 to i1056
  %91 = shl i1056 %90, 928
  %src.30 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 30
  %92 = load i32, i32* %src.30, align 4
  %93 = zext i32 %92 to i1056
  %94 = shl i1056 %93, 960
  %src.31 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 31
  %95 = load i32, i32* %src.31, align 4
  %96 = zext i32 %95 to i1056
  %97 = shl i1056 %96, 992
  %src.32 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %src, i64 0, i32 32
  %98 = load i32, i32* %src.32, align 4
  %99 = zext i32 %98 to i1056
  %100 = shl i1056 %99, 1024
  %thr.or77 = or i1056 %7, %4
  %thr.or78 = or i1056 %100, %thr.or77
  %thr.or79 = or i1056 %97, %94
  %thr.or80 = or i1056 %91, %88
  %thr.or81 = or i1056 %85, %82
  %thr.or82 = or i1056 %79, %76
  %thr.or83 = or i1056 %73, %70
  %thr.or84 = or i1056 %67, %64
  %thr.or85 = or i1056 %61, %58
  %thr.or86 = or i1056 %55, %52
  %thr.or87 = or i1056 %49, %46
  %thr.or88 = or i1056 %43, %40
  %thr.or89 = or i1056 %37, %34
  %thr.or90 = or i1056 %31, %28
  %thr.or91 = or i1056 %25, %22
  %thr.or92 = or i1056 %19, %16
  %thr.or93 = or i1056 %13, %10
  %thr.or94 = or i1056 %thr.or78, %thr.or79
  %thr.or95 = or i1056 %thr.or80, %thr.or81
  %thr.or96 = or i1056 %thr.or82, %thr.or83
  %thr.or97 = or i1056 %thr.or84, %thr.or85
  %thr.or98 = or i1056 %thr.or86, %thr.or87
  %thr.or99 = or i1056 %thr.or88, %thr.or89
  %thr.or100 = or i1056 %thr.or90, %thr.or91
  %thr.or101 = or i1056 %thr.or92, %thr.or93
  %thr.or102 = or i1056 %thr.or94, %thr.or95
  %thr.or103 = or i1056 %thr.or96, %thr.or97
  %thr.or104 = or i1056 %thr.or98, %thr.or99
  %thr.or105 = or i1056 %thr.or100, %thr.or101
  %thr.or106 = or i1056 %thr.or102, %thr.or103
  %thr.or107 = or i1056 %thr.or104, %thr.or105
  %thr.or108 = or i1056 %thr.or106, %thr.or107
  store i1056 %thr.or108, i1056* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i8(i8* noalias align 512 %dst, i8* noalias readonly %src) unnamed_addr #1 {
entry:
  %0 = icmp eq i8* %dst, null
  %1 = icmp eq i8* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = load i8, i8* %src, align 1
  store i8 %3, i8* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.22.23(i214* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i214* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i214* "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i214* "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i214* %dst_0, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond98 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond98, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %dst.addr.4497.exit, %for.loop.lr.ph
  %for.loop.idx99 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %dst.addr.4497.exit ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  switch i64 %for.loop.idx99, label %dst.addr.02.exit [
    i64 0, label %dst.addr.02.case.0
    i64 1, label %dst.addr.02.case.1
    i64 2, label %dst.addr.02.case.2
    i64 3, label %dst.addr.02.case.3
  ]

dst.addr.02.case.0:                               ; preds = %for.loop
  %4 = bitcast i214* %dst_0 to i216*
  %5 = load i216, i216* %4
  %6 = trunc i216 %5 to i214
  %7 = zext i32 %3 to i214
  %8 = and i214 %6, -4294967296
  %.partset179 = or i214 %8, %7
  store i214 %.partset179, i214* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i214* %dst_1 to i216*
  %10 = load i216, i216* %9
  %11 = trunc i216 %10 to i214
  %12 = zext i32 %3 to i214
  %13 = and i214 %11, -4294967296
  %.partset90 = or i214 %13, %12
  store i214 %.partset90, i214* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.2:                               ; preds = %for.loop
  %14 = bitcast i214* %dst_2 to i216*
  %15 = load i216, i216* %14
  %16 = trunc i216 %15 to i214
  %17 = zext i32 %3 to i214
  %18 = and i214 %16, -4294967296
  %.partset89 = or i214 %18, %17
  store i214 %.partset89, i214* %dst_2, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.3:                               ; preds = %for.loop
  %19 = bitcast i214* %dst_3 to i216*
  %20 = load i216, i216* %19
  %21 = trunc i216 %20 to i214
  %22 = zext i32 %3 to i214
  %23 = and i214 %21, -4294967296
  %.partset = or i214 %23, %22
  store i214 %.partset, i214* %dst_3, align 4
  br label %dst.addr.02.exit

dst.addr.02.exit:                                 ; preds = %dst.addr.02.case.3, %dst.addr.02.case.2, %dst.addr.02.case.1, %dst.addr.02.case.0, %for.loop
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 1
  %24 = load i32, i32* %src.addr.110, align 4
  switch i64 %for.loop.idx99, label %dst.addr.111.exit [
    i64 0, label %dst.addr.111.case.0
    i64 1, label %dst.addr.111.case.1
    i64 2, label %dst.addr.111.case.2
    i64 3, label %dst.addr.111.case.3
  ]

dst.addr.111.case.0:                              ; preds = %dst.addr.02.exit
  %25 = bitcast i214* %dst_0 to i216*
  %26 = load i216, i216* %25
  %27 = trunc i216 %26 to i214
  %28 = zext i32 %24 to i214
  %29 = shl i214 %28, 32
  %30 = and i214 %27, -18446744069414584321
  %.partset178 = or i214 %30, %29
  store i214 %.partset178, i214* %dst_0, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %31 = bitcast i214* %dst_1 to i216*
  %32 = load i216, i216* %31
  %33 = trunc i216 %32 to i214
  %34 = zext i32 %24 to i214
  %35 = shl i214 %34, 32
  %36 = and i214 %33, -18446744069414584321
  %.partset91 = or i214 %36, %35
  store i214 %.partset91, i214* %dst_1, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.2:                              ; preds = %dst.addr.02.exit
  %37 = bitcast i214* %dst_2 to i216*
  %38 = load i216, i216* %37
  %39 = trunc i216 %38 to i214
  %40 = zext i32 %24 to i214
  %41 = shl i214 %40, 32
  %42 = and i214 %39, -18446744069414584321
  %.partset88 = or i214 %42, %41
  store i214 %.partset88, i214* %dst_2, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.3:                              ; preds = %dst.addr.02.exit
  %43 = bitcast i214* %dst_3 to i216*
  %44 = load i216, i216* %43
  %45 = trunc i216 %44 to i214
  %46 = zext i32 %24 to i214
  %47 = shl i214 %46, 32
  %48 = and i214 %45, -18446744069414584321
  %.partset1 = or i214 %48, %47
  store i214 %.partset1, i214* %dst_3, align 4
  br label %dst.addr.111.exit

dst.addr.111.exit:                                ; preds = %dst.addr.111.case.3, %dst.addr.111.case.2, %dst.addr.111.case.1, %dst.addr.111.case.0, %dst.addr.02.exit
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 2
  %49 = load i8, i8* %src.addr.212, align 1
  switch i64 %for.loop.idx99, label %dst.addr.213.exit [
    i64 0, label %dst.addr.213.case.0
    i64 1, label %dst.addr.213.case.1
    i64 2, label %dst.addr.213.case.2
    i64 3, label %dst.addr.213.case.3
  ]

dst.addr.213.case.0:                              ; preds = %dst.addr.111.exit
  %50 = bitcast i214* %dst_0 to i216*
  %51 = load i216, i216* %50
  %52 = trunc i216 %51 to i214
  %53 = zext i8 %49 to i214
  %54 = shl i214 %53, 64
  %55 = and i214 %52, -4703919738795935662081
  %.partset177 = or i214 %55, %54
  store i214 %.partset177, i214* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %56 = bitcast i214* %dst_1 to i216*
  %57 = load i216, i216* %56
  %58 = trunc i216 %57 to i214
  %59 = zext i8 %49 to i214
  %60 = shl i214 %59, 64
  %61 = and i214 %58, -4703919738795935662081
  %.partset92 = or i214 %61, %60
  store i214 %.partset92, i214* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.2:                              ; preds = %dst.addr.111.exit
  %62 = bitcast i214* %dst_2 to i216*
  %63 = load i216, i216* %62
  %64 = trunc i216 %63 to i214
  %65 = zext i8 %49 to i214
  %66 = shl i214 %65, 64
  %67 = and i214 %64, -4703919738795935662081
  %.partset87 = or i214 %67, %66
  store i214 %.partset87, i214* %dst_2, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.3:                              ; preds = %dst.addr.111.exit
  %68 = bitcast i214* %dst_3 to i216*
  %69 = load i216, i216* %68
  %70 = trunc i216 %69 to i214
  %71 = zext i8 %49 to i214
  %72 = shl i214 %71, 64
  %73 = and i214 %70, -4703919738795935662081
  %.partset2 = or i214 %73, %72
  store i214 %.partset2, i214* %dst_3, align 1
  br label %dst.addr.213.exit

dst.addr.213.exit:                                ; preds = %dst.addr.213.case.3, %dst.addr.213.case.2, %dst.addr.213.case.1, %dst.addr.213.case.0, %dst.addr.111.exit
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 3
  %74 = bitcast i1* %src.addr.314 to i8*
  %75 = load i8, i8* %74
  %76 = trunc i8 %75 to i1
  switch i64 %for.loop.idx99, label %dst.addr.315.exit [
    i64 0, label %dst.addr.315.case.0
    i64 1, label %dst.addr.315.case.1
    i64 2, label %dst.addr.315.case.2
    i64 3, label %dst.addr.315.case.3
  ]

dst.addr.315.case.0:                              ; preds = %dst.addr.213.exit
  %77 = bitcast i214* %dst_0 to i216*
  %78 = load i216, i216* %77
  %79 = trunc i216 %78 to i214
  %80 = zext i1 %76 to i214
  %81 = shl i214 %80, 72
  %82 = and i214 %79, -4722366482869645213697
  %.partset176 = or i214 %82, %81
  store i214 %.partset176, i214* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %83 = bitcast i214* %dst_1 to i216*
  %84 = load i216, i216* %83
  %85 = trunc i216 %84 to i214
  %86 = zext i1 %76 to i214
  %87 = shl i214 %86, 72
  %88 = and i214 %85, -4722366482869645213697
  %.partset93 = or i214 %88, %87
  store i214 %.partset93, i214* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.2:                              ; preds = %dst.addr.213.exit
  %89 = bitcast i214* %dst_2 to i216*
  %90 = load i216, i216* %89
  %91 = trunc i216 %90 to i214
  %92 = zext i1 %76 to i214
  %93 = shl i214 %92, 72
  %94 = and i214 %91, -4722366482869645213697
  %.partset86 = or i214 %94, %93
  store i214 %.partset86, i214* %dst_2, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.3:                              ; preds = %dst.addr.213.exit
  %95 = bitcast i214* %dst_3 to i216*
  %96 = load i216, i216* %95
  %97 = trunc i216 %96 to i214
  %98 = zext i1 %76 to i214
  %99 = shl i214 %98, 72
  %100 = and i214 %97, -4722366482869645213697
  %.partset3 = or i214 %100, %99
  store i214 %.partset3, i214* %dst_3, align 1
  br label %dst.addr.315.exit

dst.addr.315.exit:                                ; preds = %dst.addr.315.case.3, %dst.addr.315.case.2, %dst.addr.315.case.1, %dst.addr.315.case.0, %dst.addr.213.exit
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 4
  %101 = bitcast i1* %src.addr.416 to i8*
  %102 = load i8, i8* %101
  %103 = trunc i8 %102 to i1
  switch i64 %for.loop.idx99, label %dst.addr.417.exit [
    i64 0, label %dst.addr.417.case.0
    i64 1, label %dst.addr.417.case.1
    i64 2, label %dst.addr.417.case.2
    i64 3, label %dst.addr.417.case.3
  ]

dst.addr.417.case.0:                              ; preds = %dst.addr.315.exit
  %104 = bitcast i214* %dst_0 to i216*
  %105 = load i216, i216* %104
  %106 = trunc i216 %105 to i214
  %107 = zext i1 %103 to i214
  %108 = shl i214 %107, 73
  %109 = and i214 %106, -9444732965739290427393
  %.partset175 = or i214 %109, %108
  store i214 %.partset175, i214* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %110 = bitcast i214* %dst_1 to i216*
  %111 = load i216, i216* %110
  %112 = trunc i216 %111 to i214
  %113 = zext i1 %103 to i214
  %114 = shl i214 %113, 73
  %115 = and i214 %112, -9444732965739290427393
  %.partset94 = or i214 %115, %114
  store i214 %.partset94, i214* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.2:                              ; preds = %dst.addr.315.exit
  %116 = bitcast i214* %dst_2 to i216*
  %117 = load i216, i216* %116
  %118 = trunc i216 %117 to i214
  %119 = zext i1 %103 to i214
  %120 = shl i214 %119, 73
  %121 = and i214 %118, -9444732965739290427393
  %.partset85 = or i214 %121, %120
  store i214 %.partset85, i214* %dst_2, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.3:                              ; preds = %dst.addr.315.exit
  %122 = bitcast i214* %dst_3 to i216*
  %123 = load i216, i216* %122
  %124 = trunc i216 %123 to i214
  %125 = zext i1 %103 to i214
  %126 = shl i214 %125, 73
  %127 = and i214 %124, -9444732965739290427393
  %.partset4 = or i214 %127, %126
  store i214 %.partset4, i214* %dst_3, align 1
  br label %dst.addr.417.exit

dst.addr.417.exit:                                ; preds = %dst.addr.417.case.3, %dst.addr.417.case.2, %dst.addr.417.case.1, %dst.addr.417.case.0, %dst.addr.315.exit
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 5
  %128 = bitcast i1* %src.addr.518 to i8*
  %129 = load i8, i8* %128
  %130 = trunc i8 %129 to i1
  switch i64 %for.loop.idx99, label %dst.addr.519.exit [
    i64 0, label %dst.addr.519.case.0
    i64 1, label %dst.addr.519.case.1
    i64 2, label %dst.addr.519.case.2
    i64 3, label %dst.addr.519.case.3
  ]

dst.addr.519.case.0:                              ; preds = %dst.addr.417.exit
  %131 = bitcast i214* %dst_0 to i216*
  %132 = load i216, i216* %131
  %133 = trunc i216 %132 to i214
  %134 = zext i1 %130 to i214
  %135 = shl i214 %134, 74
  %136 = and i214 %133, -18889465931478580854785
  %.partset174 = or i214 %136, %135
  store i214 %.partset174, i214* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %137 = bitcast i214* %dst_1 to i216*
  %138 = load i216, i216* %137
  %139 = trunc i216 %138 to i214
  %140 = zext i1 %130 to i214
  %141 = shl i214 %140, 74
  %142 = and i214 %139, -18889465931478580854785
  %.partset95 = or i214 %142, %141
  store i214 %.partset95, i214* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.2:                              ; preds = %dst.addr.417.exit
  %143 = bitcast i214* %dst_2 to i216*
  %144 = load i216, i216* %143
  %145 = trunc i216 %144 to i214
  %146 = zext i1 %130 to i214
  %147 = shl i214 %146, 74
  %148 = and i214 %145, -18889465931478580854785
  %.partset84 = or i214 %148, %147
  store i214 %.partset84, i214* %dst_2, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.3:                              ; preds = %dst.addr.417.exit
  %149 = bitcast i214* %dst_3 to i216*
  %150 = load i216, i216* %149
  %151 = trunc i216 %150 to i214
  %152 = zext i1 %130 to i214
  %153 = shl i214 %152, 74
  %154 = and i214 %151, -18889465931478580854785
  %.partset5 = or i214 %154, %153
  store i214 %.partset5, i214* %dst_3, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.3, %dst.addr.519.case.2, %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 6
  %155 = load i32, i32* %src.addr.620, align 4
  switch i64 %for.loop.idx99, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
    i64 2, label %dst.addr.621.case.2
    i64 3, label %dst.addr.621.case.3
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %156 = bitcast i214* %dst_0 to i216*
  %157 = load i216, i216* %156
  %158 = trunc i216 %157 to i214
  %159 = zext i32 %155 to i214
  %160 = shl i214 %159, 75
  %161 = and i214 %158, -162259276791434431528620848578561
  %.partset173 = or i214 %161, %160
  store i214 %.partset173, i214* %dst_0, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %162 = bitcast i214* %dst_1 to i216*
  %163 = load i216, i216* %162
  %164 = trunc i216 %163 to i214
  %165 = zext i32 %155 to i214
  %166 = shl i214 %165, 75
  %167 = and i214 %164, -162259276791434431528620848578561
  %.partset96 = or i214 %167, %166
  store i214 %.partset96, i214* %dst_1, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.2:                              ; preds = %dst.addr.519.exit
  %168 = bitcast i214* %dst_2 to i216*
  %169 = load i216, i216* %168
  %170 = trunc i216 %169 to i214
  %171 = zext i32 %155 to i214
  %172 = shl i214 %171, 75
  %173 = and i214 %170, -162259276791434431528620848578561
  %.partset83 = or i214 %173, %172
  store i214 %.partset83, i214* %dst_2, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.3:                              ; preds = %dst.addr.519.exit
  %174 = bitcast i214* %dst_3 to i216*
  %175 = load i216, i216* %174
  %176 = trunc i216 %175 to i214
  %177 = zext i32 %155 to i214
  %178 = shl i214 %177, 75
  %179 = and i214 %176, -162259276791434431528620848578561
  %.partset6 = or i214 %179, %178
  store i214 %.partset6, i214* %dst_3, align 4
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.3, %dst.addr.621.case.2, %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 7
  %180 = load i32, i32* %src.addr.722, align 4
  switch i64 %for.loop.idx99, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
    i64 2, label %dst.addr.723.case.2
    i64 3, label %dst.addr.723.case.3
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %181 = bitcast i214* %dst_0 to i216*
  %182 = load i216, i216* %181
  %183 = trunc i216 %182 to i214
  %184 = zext i32 %180 to i214
  %185 = shl i214 %184, 107
  %186 = and i214 %183, -696898287291822696343777832628683286773761
  %.partset172 = or i214 %186, %185
  store i214 %.partset172, i214* %dst_0, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %187 = bitcast i214* %dst_1 to i216*
  %188 = load i216, i216* %187
  %189 = trunc i216 %188 to i214
  %190 = zext i32 %180 to i214
  %191 = shl i214 %190, 107
  %192 = and i214 %189, -696898287291822696343777832628683286773761
  %.partset97 = or i214 %192, %191
  store i214 %.partset97, i214* %dst_1, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.2:                              ; preds = %dst.addr.621.exit
  %193 = bitcast i214* %dst_2 to i216*
  %194 = load i216, i216* %193
  %195 = trunc i216 %194 to i214
  %196 = zext i32 %180 to i214
  %197 = shl i214 %196, 107
  %198 = and i214 %195, -696898287291822696343777832628683286773761
  %.partset82 = or i214 %198, %197
  store i214 %.partset82, i214* %dst_2, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.3:                              ; preds = %dst.addr.621.exit
  %199 = bitcast i214* %dst_3 to i216*
  %200 = load i216, i216* %199
  %201 = trunc i216 %200 to i214
  %202 = zext i32 %180 to i214
  %203 = shl i214 %202, 107
  %204 = and i214 %201, -696898287291822696343777832628683286773761
  %.partset7 = or i214 %204, %203
  store i214 %.partset7, i214* %dst_3, align 4
  br label %dst.addr.723.exit

dst.addr.723.exit:                                ; preds = %dst.addr.723.case.3, %dst.addr.723.case.2, %dst.addr.723.case.1, %dst.addr.723.case.0, %dst.addr.621.exit
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 8
  %205 = load i8, i8* %src.addr.824, align 1
  switch i64 %for.loop.idx99, label %dst.addr.825.exit [
    i64 0, label %dst.addr.825.case.0
    i64 1, label %dst.addr.825.case.1
    i64 2, label %dst.addr.825.case.2
    i64 3, label %dst.addr.825.case.3
  ]

dst.addr.825.case.0:                              ; preds = %dst.addr.723.exit
  %206 = bitcast i214* %dst_0 to i216*
  %207 = load i216, i216* %206
  %208 = trunc i216 %207 to i214
  %209 = zext i8 %205 to i214
  %210 = shl i214 %209, 139
  %211 = and i214 %208, -177709063300790903159112754985166630750781441
  %.partset171 = or i214 %211, %210
  store i214 %.partset171, i214* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %212 = bitcast i214* %dst_1 to i216*
  %213 = load i216, i216* %212
  %214 = trunc i216 %213 to i214
  %215 = zext i8 %205 to i214
  %216 = shl i214 %215, 139
  %217 = and i214 %214, -177709063300790903159112754985166630750781441
  %.partset98 = or i214 %217, %216
  store i214 %.partset98, i214* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.2:                              ; preds = %dst.addr.723.exit
  %218 = bitcast i214* %dst_2 to i216*
  %219 = load i216, i216* %218
  %220 = trunc i216 %219 to i214
  %221 = zext i8 %205 to i214
  %222 = shl i214 %221, 139
  %223 = and i214 %220, -177709063300790903159112754985166630750781441
  %.partset81 = or i214 %223, %222
  store i214 %.partset81, i214* %dst_2, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.3:                              ; preds = %dst.addr.723.exit
  %224 = bitcast i214* %dst_3 to i216*
  %225 = load i216, i216* %224
  %226 = trunc i216 %225 to i214
  %227 = zext i8 %205 to i214
  %228 = shl i214 %227, 139
  %229 = and i214 %226, -177709063300790903159112754985166630750781441
  %.partset8 = or i214 %229, %228
  store i214 %.partset8, i214* %dst_3, align 1
  br label %dst.addr.825.exit

dst.addr.825.exit:                                ; preds = %dst.addr.825.case.3, %dst.addr.825.case.2, %dst.addr.825.case.1, %dst.addr.825.case.0, %dst.addr.723.exit
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 9
  %230 = bitcast i1* %src.addr.926 to i8*
  %231 = load i8, i8* %230
  %232 = trunc i8 %231 to i1
  switch i64 %for.loop.idx99, label %dst.addr.927.exit [
    i64 0, label %dst.addr.927.case.0
    i64 1, label %dst.addr.927.case.1
    i64 2, label %dst.addr.927.case.2
    i64 3, label %dst.addr.927.case.3
  ]

dst.addr.927.case.0:                              ; preds = %dst.addr.825.exit
  %233 = bitcast i214* %dst_0 to i216*
  %234 = load i216, i216* %233
  %235 = trunc i216 %234 to i214
  %236 = zext i1 %232 to i214
  %237 = shl i214 %236, 147
  %238 = and i214 %235, -178405961588244985132285746181186892047843329
  %.partset170 = or i214 %238, %237
  store i214 %.partset170, i214* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %239 = bitcast i214* %dst_1 to i216*
  %240 = load i216, i216* %239
  %241 = trunc i216 %240 to i214
  %242 = zext i1 %232 to i214
  %243 = shl i214 %242, 147
  %244 = and i214 %241, -178405961588244985132285746181186892047843329
  %.partset99 = or i214 %244, %243
  store i214 %.partset99, i214* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.2:                              ; preds = %dst.addr.825.exit
  %245 = bitcast i214* %dst_2 to i216*
  %246 = load i216, i216* %245
  %247 = trunc i216 %246 to i214
  %248 = zext i1 %232 to i214
  %249 = shl i214 %248, 147
  %250 = and i214 %247, -178405961588244985132285746181186892047843329
  %.partset80 = or i214 %250, %249
  store i214 %.partset80, i214* %dst_2, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.3:                              ; preds = %dst.addr.825.exit
  %251 = bitcast i214* %dst_3 to i216*
  %252 = load i216, i216* %251
  %253 = trunc i216 %252 to i214
  %254 = zext i1 %232 to i214
  %255 = shl i214 %254, 147
  %256 = and i214 %253, -178405961588244985132285746181186892047843329
  %.partset9 = or i214 %256, %255
  store i214 %.partset9, i214* %dst_3, align 1
  br label %dst.addr.927.exit

dst.addr.927.exit:                                ; preds = %dst.addr.927.case.3, %dst.addr.927.case.2, %dst.addr.927.case.1, %dst.addr.927.case.0, %dst.addr.825.exit
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 10
  %257 = bitcast i1* %src.addr.1028 to i8*
  %258 = load i8, i8* %257
  %259 = trunc i8 %258 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1029.exit [
    i64 0, label %dst.addr.1029.case.0
    i64 1, label %dst.addr.1029.case.1
    i64 2, label %dst.addr.1029.case.2
    i64 3, label %dst.addr.1029.case.3
  ]

dst.addr.1029.case.0:                             ; preds = %dst.addr.927.exit
  %260 = bitcast i214* %dst_0 to i216*
  %261 = load i216, i216* %260
  %262 = trunc i216 %261 to i214
  %263 = zext i1 %259 to i214
  %264 = shl i214 %263, 148
  %265 = and i214 %262, -356811923176489970264571492362373784095686657
  %.partset169 = or i214 %265, %264
  store i214 %.partset169, i214* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %266 = bitcast i214* %dst_1 to i216*
  %267 = load i216, i216* %266
  %268 = trunc i216 %267 to i214
  %269 = zext i1 %259 to i214
  %270 = shl i214 %269, 148
  %271 = and i214 %268, -356811923176489970264571492362373784095686657
  %.partset100 = or i214 %271, %270
  store i214 %.partset100, i214* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.2:                             ; preds = %dst.addr.927.exit
  %272 = bitcast i214* %dst_2 to i216*
  %273 = load i216, i216* %272
  %274 = trunc i216 %273 to i214
  %275 = zext i1 %259 to i214
  %276 = shl i214 %275, 148
  %277 = and i214 %274, -356811923176489970264571492362373784095686657
  %.partset79 = or i214 %277, %276
  store i214 %.partset79, i214* %dst_2, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.3:                             ; preds = %dst.addr.927.exit
  %278 = bitcast i214* %dst_3 to i216*
  %279 = load i216, i216* %278
  %280 = trunc i216 %279 to i214
  %281 = zext i1 %259 to i214
  %282 = shl i214 %281, 148
  %283 = and i214 %280, -356811923176489970264571492362373784095686657
  %.partset10 = or i214 %283, %282
  store i214 %.partset10, i214* %dst_3, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.exit:                               ; preds = %dst.addr.1029.case.3, %dst.addr.1029.case.2, %dst.addr.1029.case.1, %dst.addr.1029.case.0, %dst.addr.927.exit
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 11
  %284 = load i32, i32* %src.addr.1130, align 4
  switch i64 %for.loop.idx99, label %dst.addr.1131.exit [
    i64 0, label %dst.addr.1131.case.0
    i64 1, label %dst.addr.1131.case.1
    i64 2, label %dst.addr.1131.case.2
    i64 3, label %dst.addr.1131.case.3
  ]

dst.addr.1131.case.0:                             ; preds = %dst.addr.1029.exit
  %285 = bitcast i214* %dst_0 to i216*
  %286 = load i216, i216* %285
  %287 = trunc i216 %286 to i214
  %288 = zext i32 %284 to i214
  %289 = shl i214 %288, 149
  %290 = and i214 %287, -3064991081018153870363714113771475382512730676175831041
  %.partset168 = or i214 %290, %289
  store i214 %.partset168, i214* %dst_0, align 4
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %291 = bitcast i214* %dst_1 to i216*
  %292 = load i216, i216* %291
  %293 = trunc i216 %292 to i214
  %294 = zext i32 %284 to i214
  %295 = shl i214 %294, 149
  %296 = and i214 %293, -3064991081018153870363714113771475382512730676175831041
  %.partset101 = or i214 %296, %295
  store i214 %.partset101, i214* %dst_1, align 4
  br label %dst.addr.1131.exit

dst.addr.1131.case.2:                             ; preds = %dst.addr.1029.exit
  %297 = bitcast i214* %dst_2 to i216*
  %298 = load i216, i216* %297
  %299 = trunc i216 %298 to i214
  %300 = zext i32 %284 to i214
  %301 = shl i214 %300, 149
  %302 = and i214 %299, -3064991081018153870363714113771475382512730676175831041
  %.partset78 = or i214 %302, %301
  store i214 %.partset78, i214* %dst_2, align 4
  br label %dst.addr.1131.exit

dst.addr.1131.case.3:                             ; preds = %dst.addr.1029.exit
  %303 = bitcast i214* %dst_3 to i216*
  %304 = load i216, i216* %303
  %305 = trunc i216 %304 to i214
  %306 = zext i32 %284 to i214
  %307 = shl i214 %306, 149
  %308 = and i214 %305, -3064991081018153870363714113771475382512730676175831041
  %.partset11 = or i214 %308, %307
  store i214 %.partset11, i214* %dst_3, align 4
  br label %dst.addr.1131.exit

dst.addr.1131.exit:                               ; preds = %dst.addr.1131.case.3, %dst.addr.1131.case.2, %dst.addr.1131.case.1, %dst.addr.1131.case.0, %dst.addr.1029.exit
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 12
  %309 = bitcast i1* %src.addr.1232 to i8*
  %310 = load i8, i8* %309
  %311 = trunc i8 %310 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1233.exit [
    i64 0, label %dst.addr.1233.case.0
    i64 1, label %dst.addr.1233.case.1
    i64 2, label %dst.addr.1233.case.2
    i64 3, label %dst.addr.1233.case.3
  ]

dst.addr.1233.case.0:                             ; preds = %dst.addr.1131.exit
  %312 = bitcast i214* %dst_0 to i216*
  %313 = load i216, i216* %312
  %314 = trunc i216 %313 to i214
  %315 = zext i1 %311 to i214
  %316 = shl i214 %315, 181
  %317 = and i214 %314, -3064991081731777716716694054300618367237478244367204353
  %.partset167 = or i214 %317, %316
  store i214 %.partset167, i214* %dst_0, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %318 = bitcast i214* %dst_1 to i216*
  %319 = load i216, i216* %318
  %320 = trunc i216 %319 to i214
  %321 = zext i1 %311 to i214
  %322 = shl i214 %321, 181
  %323 = and i214 %320, -3064991081731777716716694054300618367237478244367204353
  %.partset102 = or i214 %323, %322
  store i214 %.partset102, i214* %dst_1, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.case.2:                             ; preds = %dst.addr.1131.exit
  %324 = bitcast i214* %dst_2 to i216*
  %325 = load i216, i216* %324
  %326 = trunc i216 %325 to i214
  %327 = zext i1 %311 to i214
  %328 = shl i214 %327, 181
  %329 = and i214 %326, -3064991081731777716716694054300618367237478244367204353
  %.partset77 = or i214 %329, %328
  store i214 %.partset77, i214* %dst_2, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.case.3:                             ; preds = %dst.addr.1131.exit
  %330 = bitcast i214* %dst_3 to i216*
  %331 = load i216, i216* %330
  %332 = trunc i216 %331 to i214
  %333 = zext i1 %311 to i214
  %334 = shl i214 %333, 181
  %335 = and i214 %332, -3064991081731777716716694054300618367237478244367204353
  %.partset12 = or i214 %335, %334
  store i214 %.partset12, i214* %dst_3, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.exit:                               ; preds = %dst.addr.1233.case.3, %dst.addr.1233.case.2, %dst.addr.1233.case.1, %dst.addr.1233.case.0, %dst.addr.1131.exit
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 13
  %336 = bitcast i1* %src.addr.1334 to i8*
  %337 = load i8, i8* %336
  %338 = trunc i8 %337 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1335.exit [
    i64 0, label %dst.addr.1335.case.0
    i64 1, label %dst.addr.1335.case.1
    i64 2, label %dst.addr.1335.case.2
    i64 3, label %dst.addr.1335.case.3
  ]

dst.addr.1335.case.0:                             ; preds = %dst.addr.1233.exit
  %339 = bitcast i214* %dst_0 to i216*
  %340 = load i216, i216* %339
  %341 = trunc i216 %340 to i214
  %342 = zext i1 %338 to i214
  %343 = shl i214 %342, 182
  %344 = and i214 %341, -6129982163463555433433388108601236734474956488734408705
  %.partset166 = or i214 %344, %343
  store i214 %.partset166, i214* %dst_0, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %345 = bitcast i214* %dst_1 to i216*
  %346 = load i216, i216* %345
  %347 = trunc i216 %346 to i214
  %348 = zext i1 %338 to i214
  %349 = shl i214 %348, 182
  %350 = and i214 %347, -6129982163463555433433388108601236734474956488734408705
  %.partset103 = or i214 %350, %349
  store i214 %.partset103, i214* %dst_1, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.case.2:                             ; preds = %dst.addr.1233.exit
  %351 = bitcast i214* %dst_2 to i216*
  %352 = load i216, i216* %351
  %353 = trunc i216 %352 to i214
  %354 = zext i1 %338 to i214
  %355 = shl i214 %354, 182
  %356 = and i214 %353, -6129982163463555433433388108601236734474956488734408705
  %.partset76 = or i214 %356, %355
  store i214 %.partset76, i214* %dst_2, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.case.3:                             ; preds = %dst.addr.1233.exit
  %357 = bitcast i214* %dst_3 to i216*
  %358 = load i216, i216* %357
  %359 = trunc i216 %358 to i214
  %360 = zext i1 %338 to i214
  %361 = shl i214 %360, 182
  %362 = and i214 %359, -6129982163463555433433388108601236734474956488734408705
  %.partset13 = or i214 %362, %361
  store i214 %.partset13, i214* %dst_3, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.exit:                               ; preds = %dst.addr.1335.case.3, %dst.addr.1335.case.2, %dst.addr.1335.case.1, %dst.addr.1335.case.0, %dst.addr.1233.exit
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 14
  %363 = bitcast i1* %src.addr.1436 to i8*
  %364 = load i8, i8* %363
  %365 = trunc i8 %364 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1437.exit [
    i64 0, label %dst.addr.1437.case.0
    i64 1, label %dst.addr.1437.case.1
    i64 2, label %dst.addr.1437.case.2
    i64 3, label %dst.addr.1437.case.3
  ]

dst.addr.1437.case.0:                             ; preds = %dst.addr.1335.exit
  %366 = bitcast i214* %dst_0 to i216*
  %367 = load i216, i216* %366
  %368 = trunc i216 %367 to i214
  %369 = zext i1 %365 to i214
  %370 = shl i214 %369, 183
  %371 = and i214 %368, -12259964326927110866866776217202473468949912977468817409
  %.partset165 = or i214 %371, %370
  store i214 %.partset165, i214* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %372 = bitcast i214* %dst_1 to i216*
  %373 = load i216, i216* %372
  %374 = trunc i216 %373 to i214
  %375 = zext i1 %365 to i214
  %376 = shl i214 %375, 183
  %377 = and i214 %374, -12259964326927110866866776217202473468949912977468817409
  %.partset104 = or i214 %377, %376
  store i214 %.partset104, i214* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.2:                             ; preds = %dst.addr.1335.exit
  %378 = bitcast i214* %dst_2 to i216*
  %379 = load i216, i216* %378
  %380 = trunc i216 %379 to i214
  %381 = zext i1 %365 to i214
  %382 = shl i214 %381, 183
  %383 = and i214 %380, -12259964326927110866866776217202473468949912977468817409
  %.partset75 = or i214 %383, %382
  store i214 %.partset75, i214* %dst_2, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.3:                             ; preds = %dst.addr.1335.exit
  %384 = bitcast i214* %dst_3 to i216*
  %385 = load i216, i216* %384
  %386 = trunc i216 %385 to i214
  %387 = zext i1 %365 to i214
  %388 = shl i214 %387, 183
  %389 = and i214 %386, -12259964326927110866866776217202473468949912977468817409
  %.partset14 = or i214 %389, %388
  store i214 %.partset14, i214* %dst_3, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.exit:                               ; preds = %dst.addr.1437.case.3, %dst.addr.1437.case.2, %dst.addr.1437.case.1, %dst.addr.1437.case.0, %dst.addr.1335.exit
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 15
  %390 = bitcast i1* %src.addr.1538 to i8*
  %391 = load i8, i8* %390
  %392 = trunc i8 %391 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1539.exit [
    i64 0, label %dst.addr.1539.case.0
    i64 1, label %dst.addr.1539.case.1
    i64 2, label %dst.addr.1539.case.2
    i64 3, label %dst.addr.1539.case.3
  ]

dst.addr.1539.case.0:                             ; preds = %dst.addr.1437.exit
  %393 = bitcast i214* %dst_0 to i216*
  %394 = load i216, i216* %393
  %395 = trunc i216 %394 to i214
  %396 = zext i1 %392 to i214
  %397 = shl i214 %396, 184
  %398 = and i214 %395, -24519928653854221733733552434404946937899825954937634817
  %.partset164 = or i214 %398, %397
  store i214 %.partset164, i214* %dst_0, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %399 = bitcast i214* %dst_1 to i216*
  %400 = load i216, i216* %399
  %401 = trunc i216 %400 to i214
  %402 = zext i1 %392 to i214
  %403 = shl i214 %402, 184
  %404 = and i214 %401, -24519928653854221733733552434404946937899825954937634817
  %.partset105 = or i214 %404, %403
  store i214 %.partset105, i214* %dst_1, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.2:                             ; preds = %dst.addr.1437.exit
  %405 = bitcast i214* %dst_2 to i216*
  %406 = load i216, i216* %405
  %407 = trunc i216 %406 to i214
  %408 = zext i1 %392 to i214
  %409 = shl i214 %408, 184
  %410 = and i214 %407, -24519928653854221733733552434404946937899825954937634817
  %.partset74 = or i214 %410, %409
  store i214 %.partset74, i214* %dst_2, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.3:                             ; preds = %dst.addr.1437.exit
  %411 = bitcast i214* %dst_3 to i216*
  %412 = load i216, i216* %411
  %413 = trunc i216 %412 to i214
  %414 = zext i1 %392 to i214
  %415 = shl i214 %414, 184
  %416 = and i214 %413, -24519928653854221733733552434404946937899825954937634817
  %.partset15 = or i214 %416, %415
  store i214 %.partset15, i214* %dst_3, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.exit:                               ; preds = %dst.addr.1539.case.3, %dst.addr.1539.case.2, %dst.addr.1539.case.1, %dst.addr.1539.case.0, %dst.addr.1437.exit
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 16
  %417 = bitcast i1* %src.addr.1640 to i8*
  %418 = load i8, i8* %417
  %419 = trunc i8 %418 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1641.exit [
    i64 0, label %dst.addr.1641.case.0
    i64 1, label %dst.addr.1641.case.1
    i64 2, label %dst.addr.1641.case.2
    i64 3, label %dst.addr.1641.case.3
  ]

dst.addr.1641.case.0:                             ; preds = %dst.addr.1539.exit
  %420 = bitcast i214* %dst_0 to i216*
  %421 = load i216, i216* %420
  %422 = trunc i216 %421 to i214
  %423 = zext i1 %419 to i214
  %424 = shl i214 %423, 185
  %425 = and i214 %422, -49039857307708443467467104868809893875799651909875269633
  %.partset163 = or i214 %425, %424
  store i214 %.partset163, i214* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %426 = bitcast i214* %dst_1 to i216*
  %427 = load i216, i216* %426
  %428 = trunc i216 %427 to i214
  %429 = zext i1 %419 to i214
  %430 = shl i214 %429, 185
  %431 = and i214 %428, -49039857307708443467467104868809893875799651909875269633
  %.partset106 = or i214 %431, %430
  store i214 %.partset106, i214* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.2:                             ; preds = %dst.addr.1539.exit
  %432 = bitcast i214* %dst_2 to i216*
  %433 = load i216, i216* %432
  %434 = trunc i216 %433 to i214
  %435 = zext i1 %419 to i214
  %436 = shl i214 %435, 185
  %437 = and i214 %434, -49039857307708443467467104868809893875799651909875269633
  %.partset73 = or i214 %437, %436
  store i214 %.partset73, i214* %dst_2, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.3:                             ; preds = %dst.addr.1539.exit
  %438 = bitcast i214* %dst_3 to i216*
  %439 = load i216, i216* %438
  %440 = trunc i216 %439 to i214
  %441 = zext i1 %419 to i214
  %442 = shl i214 %441, 185
  %443 = and i214 %440, -49039857307708443467467104868809893875799651909875269633
  %.partset16 = or i214 %443, %442
  store i214 %.partset16, i214* %dst_3, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.exit:                               ; preds = %dst.addr.1641.case.3, %dst.addr.1641.case.2, %dst.addr.1641.case.1, %dst.addr.1641.case.0, %dst.addr.1539.exit
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 17
  %444 = bitcast i1* %src.addr.1742 to i8*
  %445 = load i8, i8* %444
  %446 = trunc i8 %445 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1743.exit [
    i64 0, label %dst.addr.1743.case.0
    i64 1, label %dst.addr.1743.case.1
    i64 2, label %dst.addr.1743.case.2
    i64 3, label %dst.addr.1743.case.3
  ]

dst.addr.1743.case.0:                             ; preds = %dst.addr.1641.exit
  %447 = bitcast i214* %dst_0 to i216*
  %448 = load i216, i216* %447
  %449 = trunc i216 %448 to i214
  %450 = zext i1 %446 to i214
  %451 = shl i214 %450, 186
  %452 = and i214 %449, -98079714615416886934934209737619787751599303819750539265
  %.partset162 = or i214 %452, %451
  store i214 %.partset162, i214* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %453 = bitcast i214* %dst_1 to i216*
  %454 = load i216, i216* %453
  %455 = trunc i216 %454 to i214
  %456 = zext i1 %446 to i214
  %457 = shl i214 %456, 186
  %458 = and i214 %455, -98079714615416886934934209737619787751599303819750539265
  %.partset107 = or i214 %458, %457
  store i214 %.partset107, i214* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.2:                             ; preds = %dst.addr.1641.exit
  %459 = bitcast i214* %dst_2 to i216*
  %460 = load i216, i216* %459
  %461 = trunc i216 %460 to i214
  %462 = zext i1 %446 to i214
  %463 = shl i214 %462, 186
  %464 = and i214 %461, -98079714615416886934934209737619787751599303819750539265
  %.partset72 = or i214 %464, %463
  store i214 %.partset72, i214* %dst_2, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.3:                             ; preds = %dst.addr.1641.exit
  %465 = bitcast i214* %dst_3 to i216*
  %466 = load i216, i216* %465
  %467 = trunc i216 %466 to i214
  %468 = zext i1 %446 to i214
  %469 = shl i214 %468, 186
  %470 = and i214 %467, -98079714615416886934934209737619787751599303819750539265
  %.partset17 = or i214 %470, %469
  store i214 %.partset17, i214* %dst_3, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.exit:                               ; preds = %dst.addr.1743.case.3, %dst.addr.1743.case.2, %dst.addr.1743.case.1, %dst.addr.1743.case.0, %dst.addr.1641.exit
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 18
  %471 = bitcast i1* %src.addr.1844 to i8*
  %472 = load i8, i8* %471
  %473 = trunc i8 %472 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1845.exit [
    i64 0, label %dst.addr.1845.case.0
    i64 1, label %dst.addr.1845.case.1
    i64 2, label %dst.addr.1845.case.2
    i64 3, label %dst.addr.1845.case.3
  ]

dst.addr.1845.case.0:                             ; preds = %dst.addr.1743.exit
  %474 = bitcast i214* %dst_0 to i216*
  %475 = load i216, i216* %474
  %476 = trunc i216 %475 to i214
  %477 = zext i1 %473 to i214
  %478 = shl i214 %477, 187
  %479 = and i214 %476, -196159429230833773869868419475239575503198607639501078529
  %.partset161 = or i214 %479, %478
  store i214 %.partset161, i214* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %480 = bitcast i214* %dst_1 to i216*
  %481 = load i216, i216* %480
  %482 = trunc i216 %481 to i214
  %483 = zext i1 %473 to i214
  %484 = shl i214 %483, 187
  %485 = and i214 %482, -196159429230833773869868419475239575503198607639501078529
  %.partset108 = or i214 %485, %484
  store i214 %.partset108, i214* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.2:                             ; preds = %dst.addr.1743.exit
  %486 = bitcast i214* %dst_2 to i216*
  %487 = load i216, i216* %486
  %488 = trunc i216 %487 to i214
  %489 = zext i1 %473 to i214
  %490 = shl i214 %489, 187
  %491 = and i214 %488, -196159429230833773869868419475239575503198607639501078529
  %.partset71 = or i214 %491, %490
  store i214 %.partset71, i214* %dst_2, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.3:                             ; preds = %dst.addr.1743.exit
  %492 = bitcast i214* %dst_3 to i216*
  %493 = load i216, i216* %492
  %494 = trunc i216 %493 to i214
  %495 = zext i1 %473 to i214
  %496 = shl i214 %495, 187
  %497 = and i214 %494, -196159429230833773869868419475239575503198607639501078529
  %.partset18 = or i214 %497, %496
  store i214 %.partset18, i214* %dst_3, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.exit:                               ; preds = %dst.addr.1845.case.3, %dst.addr.1845.case.2, %dst.addr.1845.case.1, %dst.addr.1845.case.0, %dst.addr.1743.exit
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 19
  %498 = bitcast i1* %src.addr.1946 to i8*
  %499 = load i8, i8* %498
  %500 = trunc i8 %499 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1947.exit [
    i64 0, label %dst.addr.1947.case.0
    i64 1, label %dst.addr.1947.case.1
    i64 2, label %dst.addr.1947.case.2
    i64 3, label %dst.addr.1947.case.3
  ]

dst.addr.1947.case.0:                             ; preds = %dst.addr.1845.exit
  %501 = bitcast i214* %dst_0 to i216*
  %502 = load i216, i216* %501
  %503 = trunc i216 %502 to i214
  %504 = zext i1 %500 to i214
  %505 = shl i214 %504, 188
  %506 = and i214 %503, -392318858461667547739736838950479151006397215279002157057
  %.partset160 = or i214 %506, %505
  store i214 %.partset160, i214* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %507 = bitcast i214* %dst_1 to i216*
  %508 = load i216, i216* %507
  %509 = trunc i216 %508 to i214
  %510 = zext i1 %500 to i214
  %511 = shl i214 %510, 188
  %512 = and i214 %509, -392318858461667547739736838950479151006397215279002157057
  %.partset109 = or i214 %512, %511
  store i214 %.partset109, i214* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.2:                             ; preds = %dst.addr.1845.exit
  %513 = bitcast i214* %dst_2 to i216*
  %514 = load i216, i216* %513
  %515 = trunc i216 %514 to i214
  %516 = zext i1 %500 to i214
  %517 = shl i214 %516, 188
  %518 = and i214 %515, -392318858461667547739736838950479151006397215279002157057
  %.partset70 = or i214 %518, %517
  store i214 %.partset70, i214* %dst_2, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.3:                             ; preds = %dst.addr.1845.exit
  %519 = bitcast i214* %dst_3 to i216*
  %520 = load i216, i216* %519
  %521 = trunc i216 %520 to i214
  %522 = zext i1 %500 to i214
  %523 = shl i214 %522, 188
  %524 = and i214 %521, -392318858461667547739736838950479151006397215279002157057
  %.partset19 = or i214 %524, %523
  store i214 %.partset19, i214* %dst_3, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.exit:                               ; preds = %dst.addr.1947.case.3, %dst.addr.1947.case.2, %dst.addr.1947.case.1, %dst.addr.1947.case.0, %dst.addr.1845.exit
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 20
  %525 = bitcast i1* %src.addr.2048 to i8*
  %526 = load i8, i8* %525
  %527 = trunc i8 %526 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2049.exit [
    i64 0, label %dst.addr.2049.case.0
    i64 1, label %dst.addr.2049.case.1
    i64 2, label %dst.addr.2049.case.2
    i64 3, label %dst.addr.2049.case.3
  ]

dst.addr.2049.case.0:                             ; preds = %dst.addr.1947.exit
  %528 = bitcast i214* %dst_0 to i216*
  %529 = load i216, i216* %528
  %530 = trunc i216 %529 to i214
  %531 = zext i1 %527 to i214
  %532 = shl i214 %531, 189
  %533 = and i214 %530, -784637716923335095479473677900958302012794430558004314113
  %.partset159 = or i214 %533, %532
  store i214 %.partset159, i214* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %534 = bitcast i214* %dst_1 to i216*
  %535 = load i216, i216* %534
  %536 = trunc i216 %535 to i214
  %537 = zext i1 %527 to i214
  %538 = shl i214 %537, 189
  %539 = and i214 %536, -784637716923335095479473677900958302012794430558004314113
  %.partset110 = or i214 %539, %538
  store i214 %.partset110, i214* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.2:                             ; preds = %dst.addr.1947.exit
  %540 = bitcast i214* %dst_2 to i216*
  %541 = load i216, i216* %540
  %542 = trunc i216 %541 to i214
  %543 = zext i1 %527 to i214
  %544 = shl i214 %543, 189
  %545 = and i214 %542, -784637716923335095479473677900958302012794430558004314113
  %.partset69 = or i214 %545, %544
  store i214 %.partset69, i214* %dst_2, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.3:                             ; preds = %dst.addr.1947.exit
  %546 = bitcast i214* %dst_3 to i216*
  %547 = load i216, i216* %546
  %548 = trunc i216 %547 to i214
  %549 = zext i1 %527 to i214
  %550 = shl i214 %549, 189
  %551 = and i214 %548, -784637716923335095479473677900958302012794430558004314113
  %.partset20 = or i214 %551, %550
  store i214 %.partset20, i214* %dst_3, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.exit:                               ; preds = %dst.addr.2049.case.3, %dst.addr.2049.case.2, %dst.addr.2049.case.1, %dst.addr.2049.case.0, %dst.addr.1947.exit
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 21
  %552 = bitcast i1* %src.addr.2150 to i8*
  %553 = load i8, i8* %552
  %554 = trunc i8 %553 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2151.exit [
    i64 0, label %dst.addr.2151.case.0
    i64 1, label %dst.addr.2151.case.1
    i64 2, label %dst.addr.2151.case.2
    i64 3, label %dst.addr.2151.case.3
  ]

dst.addr.2151.case.0:                             ; preds = %dst.addr.2049.exit
  %555 = bitcast i214* %dst_0 to i216*
  %556 = load i216, i216* %555
  %557 = trunc i216 %556 to i214
  %558 = zext i1 %554 to i214
  %559 = shl i214 %558, 190
  %560 = and i214 %557, -1569275433846670190958947355801916604025588861116008628225
  %.partset158 = or i214 %560, %559
  store i214 %.partset158, i214* %dst_0, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.1:                             ; preds = %dst.addr.2049.exit
  %561 = bitcast i214* %dst_1 to i216*
  %562 = load i216, i216* %561
  %563 = trunc i216 %562 to i214
  %564 = zext i1 %554 to i214
  %565 = shl i214 %564, 190
  %566 = and i214 %563, -1569275433846670190958947355801916604025588861116008628225
  %.partset111 = or i214 %566, %565
  store i214 %.partset111, i214* %dst_1, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.2:                             ; preds = %dst.addr.2049.exit
  %567 = bitcast i214* %dst_2 to i216*
  %568 = load i216, i216* %567
  %569 = trunc i216 %568 to i214
  %570 = zext i1 %554 to i214
  %571 = shl i214 %570, 190
  %572 = and i214 %569, -1569275433846670190958947355801916604025588861116008628225
  %.partset68 = or i214 %572, %571
  store i214 %.partset68, i214* %dst_2, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.3:                             ; preds = %dst.addr.2049.exit
  %573 = bitcast i214* %dst_3 to i216*
  %574 = load i216, i216* %573
  %575 = trunc i216 %574 to i214
  %576 = zext i1 %554 to i214
  %577 = shl i214 %576, 190
  %578 = and i214 %575, -1569275433846670190958947355801916604025588861116008628225
  %.partset21 = or i214 %578, %577
  store i214 %.partset21, i214* %dst_3, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.exit:                               ; preds = %dst.addr.2151.case.3, %dst.addr.2151.case.2, %dst.addr.2151.case.1, %dst.addr.2151.case.0, %dst.addr.2049.exit
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 22
  %579 = bitcast i1* %src.addr.2252 to i8*
  %580 = load i8, i8* %579
  %581 = trunc i8 %580 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2253.exit [
    i64 0, label %dst.addr.2253.case.0
    i64 1, label %dst.addr.2253.case.1
    i64 2, label %dst.addr.2253.case.2
    i64 3, label %dst.addr.2253.case.3
  ]

dst.addr.2253.case.0:                             ; preds = %dst.addr.2151.exit
  %582 = bitcast i214* %dst_0 to i216*
  %583 = load i216, i216* %582
  %584 = trunc i216 %583 to i214
  %585 = zext i1 %581 to i214
  %586 = shl i214 %585, 191
  %587 = and i214 %584, -3138550867693340381917894711603833208051177722232017256449
  %.partset157 = or i214 %587, %586
  store i214 %.partset157, i214* %dst_0, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.1:                             ; preds = %dst.addr.2151.exit
  %588 = bitcast i214* %dst_1 to i216*
  %589 = load i216, i216* %588
  %590 = trunc i216 %589 to i214
  %591 = zext i1 %581 to i214
  %592 = shl i214 %591, 191
  %593 = and i214 %590, -3138550867693340381917894711603833208051177722232017256449
  %.partset112 = or i214 %593, %592
  store i214 %.partset112, i214* %dst_1, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.2:                             ; preds = %dst.addr.2151.exit
  %594 = bitcast i214* %dst_2 to i216*
  %595 = load i216, i216* %594
  %596 = trunc i216 %595 to i214
  %597 = zext i1 %581 to i214
  %598 = shl i214 %597, 191
  %599 = and i214 %596, -3138550867693340381917894711603833208051177722232017256449
  %.partset67 = or i214 %599, %598
  store i214 %.partset67, i214* %dst_2, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.3:                             ; preds = %dst.addr.2151.exit
  %600 = bitcast i214* %dst_3 to i216*
  %601 = load i216, i216* %600
  %602 = trunc i216 %601 to i214
  %603 = zext i1 %581 to i214
  %604 = shl i214 %603, 191
  %605 = and i214 %602, -3138550867693340381917894711603833208051177722232017256449
  %.partset22 = or i214 %605, %604
  store i214 %.partset22, i214* %dst_3, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.exit:                               ; preds = %dst.addr.2253.case.3, %dst.addr.2253.case.2, %dst.addr.2253.case.1, %dst.addr.2253.case.0, %dst.addr.2151.exit
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 23
  %606 = bitcast i1* %src.addr.2354 to i8*
  %607 = load i8, i8* %606
  %608 = trunc i8 %607 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2355.exit [
    i64 0, label %dst.addr.2355.case.0
    i64 1, label %dst.addr.2355.case.1
    i64 2, label %dst.addr.2355.case.2
    i64 3, label %dst.addr.2355.case.3
  ]

dst.addr.2355.case.0:                             ; preds = %dst.addr.2253.exit
  %609 = bitcast i214* %dst_0 to i216*
  %610 = load i216, i216* %609
  %611 = trunc i216 %610 to i214
  %612 = zext i1 %608 to i214
  %613 = shl i214 %612, 192
  %614 = and i214 %611, -6277101735386680763835789423207666416102355444464034512897
  %.partset156 = or i214 %614, %613
  store i214 %.partset156, i214* %dst_0, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.1:                             ; preds = %dst.addr.2253.exit
  %615 = bitcast i214* %dst_1 to i216*
  %616 = load i216, i216* %615
  %617 = trunc i216 %616 to i214
  %618 = zext i1 %608 to i214
  %619 = shl i214 %618, 192
  %620 = and i214 %617, -6277101735386680763835789423207666416102355444464034512897
  %.partset113 = or i214 %620, %619
  store i214 %.partset113, i214* %dst_1, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.2:                             ; preds = %dst.addr.2253.exit
  %621 = bitcast i214* %dst_2 to i216*
  %622 = load i216, i216* %621
  %623 = trunc i216 %622 to i214
  %624 = zext i1 %608 to i214
  %625 = shl i214 %624, 192
  %626 = and i214 %623, -6277101735386680763835789423207666416102355444464034512897
  %.partset66 = or i214 %626, %625
  store i214 %.partset66, i214* %dst_2, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.3:                             ; preds = %dst.addr.2253.exit
  %627 = bitcast i214* %dst_3 to i216*
  %628 = load i216, i216* %627
  %629 = trunc i216 %628 to i214
  %630 = zext i1 %608 to i214
  %631 = shl i214 %630, 192
  %632 = and i214 %629, -6277101735386680763835789423207666416102355444464034512897
  %.partset23 = or i214 %632, %631
  store i214 %.partset23, i214* %dst_3, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.exit:                               ; preds = %dst.addr.2355.case.3, %dst.addr.2355.case.2, %dst.addr.2355.case.1, %dst.addr.2355.case.0, %dst.addr.2253.exit
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 24
  %633 = bitcast i1* %src.addr.2456 to i8*
  %634 = load i8, i8* %633
  %635 = trunc i8 %634 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2457.exit [
    i64 0, label %dst.addr.2457.case.0
    i64 1, label %dst.addr.2457.case.1
    i64 2, label %dst.addr.2457.case.2
    i64 3, label %dst.addr.2457.case.3
  ]

dst.addr.2457.case.0:                             ; preds = %dst.addr.2355.exit
  %636 = bitcast i214* %dst_0 to i216*
  %637 = load i216, i216* %636
  %638 = trunc i216 %637 to i214
  %639 = zext i1 %635 to i214
  %640 = shl i214 %639, 193
  %641 = and i214 %638, -12554203470773361527671578846415332832204710888928069025793
  %.partset155 = or i214 %641, %640
  store i214 %.partset155, i214* %dst_0, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.1:                             ; preds = %dst.addr.2355.exit
  %642 = bitcast i214* %dst_1 to i216*
  %643 = load i216, i216* %642
  %644 = trunc i216 %643 to i214
  %645 = zext i1 %635 to i214
  %646 = shl i214 %645, 193
  %647 = and i214 %644, -12554203470773361527671578846415332832204710888928069025793
  %.partset114 = or i214 %647, %646
  store i214 %.partset114, i214* %dst_1, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.2:                             ; preds = %dst.addr.2355.exit
  %648 = bitcast i214* %dst_2 to i216*
  %649 = load i216, i216* %648
  %650 = trunc i216 %649 to i214
  %651 = zext i1 %635 to i214
  %652 = shl i214 %651, 193
  %653 = and i214 %650, -12554203470773361527671578846415332832204710888928069025793
  %.partset65 = or i214 %653, %652
  store i214 %.partset65, i214* %dst_2, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.3:                             ; preds = %dst.addr.2355.exit
  %654 = bitcast i214* %dst_3 to i216*
  %655 = load i216, i216* %654
  %656 = trunc i216 %655 to i214
  %657 = zext i1 %635 to i214
  %658 = shl i214 %657, 193
  %659 = and i214 %656, -12554203470773361527671578846415332832204710888928069025793
  %.partset24 = or i214 %659, %658
  store i214 %.partset24, i214* %dst_3, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.exit:                               ; preds = %dst.addr.2457.case.3, %dst.addr.2457.case.2, %dst.addr.2457.case.1, %dst.addr.2457.case.0, %dst.addr.2355.exit
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 25
  %660 = bitcast i1* %src.addr.2558 to i8*
  %661 = load i8, i8* %660
  %662 = trunc i8 %661 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2559.exit [
    i64 0, label %dst.addr.2559.case.0
    i64 1, label %dst.addr.2559.case.1
    i64 2, label %dst.addr.2559.case.2
    i64 3, label %dst.addr.2559.case.3
  ]

dst.addr.2559.case.0:                             ; preds = %dst.addr.2457.exit
  %663 = bitcast i214* %dst_0 to i216*
  %664 = load i216, i216* %663
  %665 = trunc i216 %664 to i214
  %666 = zext i1 %662 to i214
  %667 = shl i214 %666, 194
  %668 = and i214 %665, -25108406941546723055343157692830665664409421777856138051585
  %.partset154 = or i214 %668, %667
  store i214 %.partset154, i214* %dst_0, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.1:                             ; preds = %dst.addr.2457.exit
  %669 = bitcast i214* %dst_1 to i216*
  %670 = load i216, i216* %669
  %671 = trunc i216 %670 to i214
  %672 = zext i1 %662 to i214
  %673 = shl i214 %672, 194
  %674 = and i214 %671, -25108406941546723055343157692830665664409421777856138051585
  %.partset115 = or i214 %674, %673
  store i214 %.partset115, i214* %dst_1, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.2:                             ; preds = %dst.addr.2457.exit
  %675 = bitcast i214* %dst_2 to i216*
  %676 = load i216, i216* %675
  %677 = trunc i216 %676 to i214
  %678 = zext i1 %662 to i214
  %679 = shl i214 %678, 194
  %680 = and i214 %677, -25108406941546723055343157692830665664409421777856138051585
  %.partset64 = or i214 %680, %679
  store i214 %.partset64, i214* %dst_2, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.3:                             ; preds = %dst.addr.2457.exit
  %681 = bitcast i214* %dst_3 to i216*
  %682 = load i216, i216* %681
  %683 = trunc i216 %682 to i214
  %684 = zext i1 %662 to i214
  %685 = shl i214 %684, 194
  %686 = and i214 %683, -25108406941546723055343157692830665664409421777856138051585
  %.partset25 = or i214 %686, %685
  store i214 %.partset25, i214* %dst_3, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.exit:                               ; preds = %dst.addr.2559.case.3, %dst.addr.2559.case.2, %dst.addr.2559.case.1, %dst.addr.2559.case.0, %dst.addr.2457.exit
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 26
  %687 = bitcast i1* %src.addr.2660 to i8*
  %688 = load i8, i8* %687
  %689 = trunc i8 %688 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2661.exit [
    i64 0, label %dst.addr.2661.case.0
    i64 1, label %dst.addr.2661.case.1
    i64 2, label %dst.addr.2661.case.2
    i64 3, label %dst.addr.2661.case.3
  ]

dst.addr.2661.case.0:                             ; preds = %dst.addr.2559.exit
  %690 = bitcast i214* %dst_0 to i216*
  %691 = load i216, i216* %690
  %692 = trunc i216 %691 to i214
  %693 = zext i1 %689 to i214
  %694 = shl i214 %693, 195
  %695 = and i214 %692, -50216813883093446110686315385661331328818843555712276103169
  %.partset153 = or i214 %695, %694
  store i214 %.partset153, i214* %dst_0, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.1:                             ; preds = %dst.addr.2559.exit
  %696 = bitcast i214* %dst_1 to i216*
  %697 = load i216, i216* %696
  %698 = trunc i216 %697 to i214
  %699 = zext i1 %689 to i214
  %700 = shl i214 %699, 195
  %701 = and i214 %698, -50216813883093446110686315385661331328818843555712276103169
  %.partset116 = or i214 %701, %700
  store i214 %.partset116, i214* %dst_1, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.2:                             ; preds = %dst.addr.2559.exit
  %702 = bitcast i214* %dst_2 to i216*
  %703 = load i216, i216* %702
  %704 = trunc i216 %703 to i214
  %705 = zext i1 %689 to i214
  %706 = shl i214 %705, 195
  %707 = and i214 %704, -50216813883093446110686315385661331328818843555712276103169
  %.partset63 = or i214 %707, %706
  store i214 %.partset63, i214* %dst_2, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.3:                             ; preds = %dst.addr.2559.exit
  %708 = bitcast i214* %dst_3 to i216*
  %709 = load i216, i216* %708
  %710 = trunc i216 %709 to i214
  %711 = zext i1 %689 to i214
  %712 = shl i214 %711, 195
  %713 = and i214 %710, -50216813883093446110686315385661331328818843555712276103169
  %.partset26 = or i214 %713, %712
  store i214 %.partset26, i214* %dst_3, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.exit:                               ; preds = %dst.addr.2661.case.3, %dst.addr.2661.case.2, %dst.addr.2661.case.1, %dst.addr.2661.case.0, %dst.addr.2559.exit
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 27
  %714 = bitcast i1* %src.addr.2762 to i8*
  %715 = load i8, i8* %714
  %716 = trunc i8 %715 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2763.exit [
    i64 0, label %dst.addr.2763.case.0
    i64 1, label %dst.addr.2763.case.1
    i64 2, label %dst.addr.2763.case.2
    i64 3, label %dst.addr.2763.case.3
  ]

dst.addr.2763.case.0:                             ; preds = %dst.addr.2661.exit
  %717 = bitcast i214* %dst_0 to i216*
  %718 = load i216, i216* %717
  %719 = trunc i216 %718 to i214
  %720 = zext i1 %716 to i214
  %721 = shl i214 %720, 196
  %722 = and i214 %719, -100433627766186892221372630771322662657637687111424552206337
  %.partset152 = or i214 %722, %721
  store i214 %.partset152, i214* %dst_0, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.1:                             ; preds = %dst.addr.2661.exit
  %723 = bitcast i214* %dst_1 to i216*
  %724 = load i216, i216* %723
  %725 = trunc i216 %724 to i214
  %726 = zext i1 %716 to i214
  %727 = shl i214 %726, 196
  %728 = and i214 %725, -100433627766186892221372630771322662657637687111424552206337
  %.partset117 = or i214 %728, %727
  store i214 %.partset117, i214* %dst_1, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.2:                             ; preds = %dst.addr.2661.exit
  %729 = bitcast i214* %dst_2 to i216*
  %730 = load i216, i216* %729
  %731 = trunc i216 %730 to i214
  %732 = zext i1 %716 to i214
  %733 = shl i214 %732, 196
  %734 = and i214 %731, -100433627766186892221372630771322662657637687111424552206337
  %.partset62 = or i214 %734, %733
  store i214 %.partset62, i214* %dst_2, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.3:                             ; preds = %dst.addr.2661.exit
  %735 = bitcast i214* %dst_3 to i216*
  %736 = load i216, i216* %735
  %737 = trunc i216 %736 to i214
  %738 = zext i1 %716 to i214
  %739 = shl i214 %738, 196
  %740 = and i214 %737, -100433627766186892221372630771322662657637687111424552206337
  %.partset27 = or i214 %740, %739
  store i214 %.partset27, i214* %dst_3, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.exit:                               ; preds = %dst.addr.2763.case.3, %dst.addr.2763.case.2, %dst.addr.2763.case.1, %dst.addr.2763.case.0, %dst.addr.2661.exit
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 28
  %741 = bitcast i1* %src.addr.2864 to i8*
  %742 = load i8, i8* %741
  %743 = trunc i8 %742 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2865.exit [
    i64 0, label %dst.addr.2865.case.0
    i64 1, label %dst.addr.2865.case.1
    i64 2, label %dst.addr.2865.case.2
    i64 3, label %dst.addr.2865.case.3
  ]

dst.addr.2865.case.0:                             ; preds = %dst.addr.2763.exit
  %744 = bitcast i214* %dst_0 to i216*
  %745 = load i216, i216* %744
  %746 = trunc i216 %745 to i214
  %747 = zext i1 %743 to i214
  %748 = shl i214 %747, 197
  %749 = and i214 %746, -200867255532373784442745261542645325315275374222849104412673
  %.partset151 = or i214 %749, %748
  store i214 %.partset151, i214* %dst_0, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.1:                             ; preds = %dst.addr.2763.exit
  %750 = bitcast i214* %dst_1 to i216*
  %751 = load i216, i216* %750
  %752 = trunc i216 %751 to i214
  %753 = zext i1 %743 to i214
  %754 = shl i214 %753, 197
  %755 = and i214 %752, -200867255532373784442745261542645325315275374222849104412673
  %.partset118 = or i214 %755, %754
  store i214 %.partset118, i214* %dst_1, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.2:                             ; preds = %dst.addr.2763.exit
  %756 = bitcast i214* %dst_2 to i216*
  %757 = load i216, i216* %756
  %758 = trunc i216 %757 to i214
  %759 = zext i1 %743 to i214
  %760 = shl i214 %759, 197
  %761 = and i214 %758, -200867255532373784442745261542645325315275374222849104412673
  %.partset61 = or i214 %761, %760
  store i214 %.partset61, i214* %dst_2, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.3:                             ; preds = %dst.addr.2763.exit
  %762 = bitcast i214* %dst_3 to i216*
  %763 = load i216, i216* %762
  %764 = trunc i216 %763 to i214
  %765 = zext i1 %743 to i214
  %766 = shl i214 %765, 197
  %767 = and i214 %764, -200867255532373784442745261542645325315275374222849104412673
  %.partset28 = or i214 %767, %766
  store i214 %.partset28, i214* %dst_3, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.exit:                               ; preds = %dst.addr.2865.case.3, %dst.addr.2865.case.2, %dst.addr.2865.case.1, %dst.addr.2865.case.0, %dst.addr.2763.exit
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 29
  %768 = bitcast i1* %src.addr.2966 to i8*
  %769 = load i8, i8* %768
  %770 = trunc i8 %769 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2967.exit [
    i64 0, label %dst.addr.2967.case.0
    i64 1, label %dst.addr.2967.case.1
    i64 2, label %dst.addr.2967.case.2
    i64 3, label %dst.addr.2967.case.3
  ]

dst.addr.2967.case.0:                             ; preds = %dst.addr.2865.exit
  %771 = bitcast i214* %dst_0 to i216*
  %772 = load i216, i216* %771
  %773 = trunc i216 %772 to i214
  %774 = zext i1 %770 to i214
  %775 = shl i214 %774, 198
  %776 = and i214 %773, -401734511064747568885490523085290650630550748445698208825345
  %.partset150 = or i214 %776, %775
  store i214 %.partset150, i214* %dst_0, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.1:                             ; preds = %dst.addr.2865.exit
  %777 = bitcast i214* %dst_1 to i216*
  %778 = load i216, i216* %777
  %779 = trunc i216 %778 to i214
  %780 = zext i1 %770 to i214
  %781 = shl i214 %780, 198
  %782 = and i214 %779, -401734511064747568885490523085290650630550748445698208825345
  %.partset119 = or i214 %782, %781
  store i214 %.partset119, i214* %dst_1, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.2:                             ; preds = %dst.addr.2865.exit
  %783 = bitcast i214* %dst_2 to i216*
  %784 = load i216, i216* %783
  %785 = trunc i216 %784 to i214
  %786 = zext i1 %770 to i214
  %787 = shl i214 %786, 198
  %788 = and i214 %785, -401734511064747568885490523085290650630550748445698208825345
  %.partset60 = or i214 %788, %787
  store i214 %.partset60, i214* %dst_2, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.3:                             ; preds = %dst.addr.2865.exit
  %789 = bitcast i214* %dst_3 to i216*
  %790 = load i216, i216* %789
  %791 = trunc i216 %790 to i214
  %792 = zext i1 %770 to i214
  %793 = shl i214 %792, 198
  %794 = and i214 %791, -401734511064747568885490523085290650630550748445698208825345
  %.partset29 = or i214 %794, %793
  store i214 %.partset29, i214* %dst_3, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.exit:                               ; preds = %dst.addr.2967.case.3, %dst.addr.2967.case.2, %dst.addr.2967.case.1, %dst.addr.2967.case.0, %dst.addr.2865.exit
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 30
  %795 = bitcast i1* %src.addr.3068 to i8*
  %796 = load i8, i8* %795
  %797 = trunc i8 %796 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3069.exit [
    i64 0, label %dst.addr.3069.case.0
    i64 1, label %dst.addr.3069.case.1
    i64 2, label %dst.addr.3069.case.2
    i64 3, label %dst.addr.3069.case.3
  ]

dst.addr.3069.case.0:                             ; preds = %dst.addr.2967.exit
  %798 = bitcast i214* %dst_0 to i216*
  %799 = load i216, i216* %798
  %800 = trunc i216 %799 to i214
  %801 = zext i1 %797 to i214
  %802 = shl i214 %801, 199
  %803 = and i214 %800, -803469022129495137770981046170581301261101496891396417650689
  %.partset149 = or i214 %803, %802
  store i214 %.partset149, i214* %dst_0, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.1:                             ; preds = %dst.addr.2967.exit
  %804 = bitcast i214* %dst_1 to i216*
  %805 = load i216, i216* %804
  %806 = trunc i216 %805 to i214
  %807 = zext i1 %797 to i214
  %808 = shl i214 %807, 199
  %809 = and i214 %806, -803469022129495137770981046170581301261101496891396417650689
  %.partset120 = or i214 %809, %808
  store i214 %.partset120, i214* %dst_1, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.2:                             ; preds = %dst.addr.2967.exit
  %810 = bitcast i214* %dst_2 to i216*
  %811 = load i216, i216* %810
  %812 = trunc i216 %811 to i214
  %813 = zext i1 %797 to i214
  %814 = shl i214 %813, 199
  %815 = and i214 %812, -803469022129495137770981046170581301261101496891396417650689
  %.partset59 = or i214 %815, %814
  store i214 %.partset59, i214* %dst_2, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.3:                             ; preds = %dst.addr.2967.exit
  %816 = bitcast i214* %dst_3 to i216*
  %817 = load i216, i216* %816
  %818 = trunc i216 %817 to i214
  %819 = zext i1 %797 to i214
  %820 = shl i214 %819, 199
  %821 = and i214 %818, -803469022129495137770981046170581301261101496891396417650689
  %.partset30 = or i214 %821, %820
  store i214 %.partset30, i214* %dst_3, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.exit:                               ; preds = %dst.addr.3069.case.3, %dst.addr.3069.case.2, %dst.addr.3069.case.1, %dst.addr.3069.case.0, %dst.addr.2967.exit
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 31
  %822 = bitcast i1* %src.addr.3170 to i8*
  %823 = load i8, i8* %822
  %824 = trunc i8 %823 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3171.exit [
    i64 0, label %dst.addr.3171.case.0
    i64 1, label %dst.addr.3171.case.1
    i64 2, label %dst.addr.3171.case.2
    i64 3, label %dst.addr.3171.case.3
  ]

dst.addr.3171.case.0:                             ; preds = %dst.addr.3069.exit
  %825 = bitcast i214* %dst_0 to i216*
  %826 = load i216, i216* %825
  %827 = trunc i216 %826 to i214
  %828 = zext i1 %824 to i214
  %829 = shl i214 %828, 200
  %830 = and i214 %827, -1606938044258990275541962092341162602522202993782792835301377
  %.partset148 = or i214 %830, %829
  store i214 %.partset148, i214* %dst_0, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.1:                             ; preds = %dst.addr.3069.exit
  %831 = bitcast i214* %dst_1 to i216*
  %832 = load i216, i216* %831
  %833 = trunc i216 %832 to i214
  %834 = zext i1 %824 to i214
  %835 = shl i214 %834, 200
  %836 = and i214 %833, -1606938044258990275541962092341162602522202993782792835301377
  %.partset121 = or i214 %836, %835
  store i214 %.partset121, i214* %dst_1, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.2:                             ; preds = %dst.addr.3069.exit
  %837 = bitcast i214* %dst_2 to i216*
  %838 = load i216, i216* %837
  %839 = trunc i216 %838 to i214
  %840 = zext i1 %824 to i214
  %841 = shl i214 %840, 200
  %842 = and i214 %839, -1606938044258990275541962092341162602522202993782792835301377
  %.partset58 = or i214 %842, %841
  store i214 %.partset58, i214* %dst_2, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.3:                             ; preds = %dst.addr.3069.exit
  %843 = bitcast i214* %dst_3 to i216*
  %844 = load i216, i216* %843
  %845 = trunc i216 %844 to i214
  %846 = zext i1 %824 to i214
  %847 = shl i214 %846, 200
  %848 = and i214 %845, -1606938044258990275541962092341162602522202993782792835301377
  %.partset31 = or i214 %848, %847
  store i214 %.partset31, i214* %dst_3, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.exit:                               ; preds = %dst.addr.3171.case.3, %dst.addr.3171.case.2, %dst.addr.3171.case.1, %dst.addr.3171.case.0, %dst.addr.3069.exit
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 32
  %849 = bitcast i1* %src.addr.3272 to i8*
  %850 = load i8, i8* %849
  %851 = trunc i8 %850 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3273.exit [
    i64 0, label %dst.addr.3273.case.0
    i64 1, label %dst.addr.3273.case.1
    i64 2, label %dst.addr.3273.case.2
    i64 3, label %dst.addr.3273.case.3
  ]

dst.addr.3273.case.0:                             ; preds = %dst.addr.3171.exit
  %852 = bitcast i214* %dst_0 to i216*
  %853 = load i216, i216* %852
  %854 = trunc i216 %853 to i214
  %855 = zext i1 %851 to i214
  %856 = shl i214 %855, 201
  %857 = and i214 %854, -3213876088517980551083924184682325205044405987565585670602753
  %.partset147 = or i214 %857, %856
  store i214 %.partset147, i214* %dst_0, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.1:                             ; preds = %dst.addr.3171.exit
  %858 = bitcast i214* %dst_1 to i216*
  %859 = load i216, i216* %858
  %860 = trunc i216 %859 to i214
  %861 = zext i1 %851 to i214
  %862 = shl i214 %861, 201
  %863 = and i214 %860, -3213876088517980551083924184682325205044405987565585670602753
  %.partset122 = or i214 %863, %862
  store i214 %.partset122, i214* %dst_1, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.2:                             ; preds = %dst.addr.3171.exit
  %864 = bitcast i214* %dst_2 to i216*
  %865 = load i216, i216* %864
  %866 = trunc i216 %865 to i214
  %867 = zext i1 %851 to i214
  %868 = shl i214 %867, 201
  %869 = and i214 %866, -3213876088517980551083924184682325205044405987565585670602753
  %.partset57 = or i214 %869, %868
  store i214 %.partset57, i214* %dst_2, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.3:                             ; preds = %dst.addr.3171.exit
  %870 = bitcast i214* %dst_3 to i216*
  %871 = load i216, i216* %870
  %872 = trunc i216 %871 to i214
  %873 = zext i1 %851 to i214
  %874 = shl i214 %873, 201
  %875 = and i214 %872, -3213876088517980551083924184682325205044405987565585670602753
  %.partset32 = or i214 %875, %874
  store i214 %.partset32, i214* %dst_3, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.exit:                               ; preds = %dst.addr.3273.case.3, %dst.addr.3273.case.2, %dst.addr.3273.case.1, %dst.addr.3273.case.0, %dst.addr.3171.exit
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 33
  %876 = bitcast i1* %src.addr.3374 to i8*
  %877 = load i8, i8* %876
  %878 = trunc i8 %877 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3375.exit [
    i64 0, label %dst.addr.3375.case.0
    i64 1, label %dst.addr.3375.case.1
    i64 2, label %dst.addr.3375.case.2
    i64 3, label %dst.addr.3375.case.3
  ]

dst.addr.3375.case.0:                             ; preds = %dst.addr.3273.exit
  %879 = bitcast i214* %dst_0 to i216*
  %880 = load i216, i216* %879
  %881 = trunc i216 %880 to i214
  %882 = zext i1 %878 to i214
  %883 = shl i214 %882, 202
  %884 = and i214 %881, -6427752177035961102167848369364650410088811975131171341205505
  %.partset146 = or i214 %884, %883
  store i214 %.partset146, i214* %dst_0, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.1:                             ; preds = %dst.addr.3273.exit
  %885 = bitcast i214* %dst_1 to i216*
  %886 = load i216, i216* %885
  %887 = trunc i216 %886 to i214
  %888 = zext i1 %878 to i214
  %889 = shl i214 %888, 202
  %890 = and i214 %887, -6427752177035961102167848369364650410088811975131171341205505
  %.partset123 = or i214 %890, %889
  store i214 %.partset123, i214* %dst_1, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.2:                             ; preds = %dst.addr.3273.exit
  %891 = bitcast i214* %dst_2 to i216*
  %892 = load i216, i216* %891
  %893 = trunc i216 %892 to i214
  %894 = zext i1 %878 to i214
  %895 = shl i214 %894, 202
  %896 = and i214 %893, -6427752177035961102167848369364650410088811975131171341205505
  %.partset56 = or i214 %896, %895
  store i214 %.partset56, i214* %dst_2, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.3:                             ; preds = %dst.addr.3273.exit
  %897 = bitcast i214* %dst_3 to i216*
  %898 = load i216, i216* %897
  %899 = trunc i216 %898 to i214
  %900 = zext i1 %878 to i214
  %901 = shl i214 %900, 202
  %902 = and i214 %899, -6427752177035961102167848369364650410088811975131171341205505
  %.partset33 = or i214 %902, %901
  store i214 %.partset33, i214* %dst_3, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.exit:                               ; preds = %dst.addr.3375.case.3, %dst.addr.3375.case.2, %dst.addr.3375.case.1, %dst.addr.3375.case.0, %dst.addr.3273.exit
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 34
  %903 = bitcast i1* %src.addr.3476 to i8*
  %904 = load i8, i8* %903
  %905 = trunc i8 %904 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3477.exit [
    i64 0, label %dst.addr.3477.case.0
    i64 1, label %dst.addr.3477.case.1
    i64 2, label %dst.addr.3477.case.2
    i64 3, label %dst.addr.3477.case.3
  ]

dst.addr.3477.case.0:                             ; preds = %dst.addr.3375.exit
  %906 = bitcast i214* %dst_0 to i216*
  %907 = load i216, i216* %906
  %908 = trunc i216 %907 to i214
  %909 = zext i1 %905 to i214
  %910 = shl i214 %909, 203
  %911 = and i214 %908, -12855504354071922204335696738729300820177623950262342682411009
  %.partset145 = or i214 %911, %910
  store i214 %.partset145, i214* %dst_0, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.1:                             ; preds = %dst.addr.3375.exit
  %912 = bitcast i214* %dst_1 to i216*
  %913 = load i216, i216* %912
  %914 = trunc i216 %913 to i214
  %915 = zext i1 %905 to i214
  %916 = shl i214 %915, 203
  %917 = and i214 %914, -12855504354071922204335696738729300820177623950262342682411009
  %.partset124 = or i214 %917, %916
  store i214 %.partset124, i214* %dst_1, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.2:                             ; preds = %dst.addr.3375.exit
  %918 = bitcast i214* %dst_2 to i216*
  %919 = load i216, i216* %918
  %920 = trunc i216 %919 to i214
  %921 = zext i1 %905 to i214
  %922 = shl i214 %921, 203
  %923 = and i214 %920, -12855504354071922204335696738729300820177623950262342682411009
  %.partset55 = or i214 %923, %922
  store i214 %.partset55, i214* %dst_2, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.3:                             ; preds = %dst.addr.3375.exit
  %924 = bitcast i214* %dst_3 to i216*
  %925 = load i216, i216* %924
  %926 = trunc i216 %925 to i214
  %927 = zext i1 %905 to i214
  %928 = shl i214 %927, 203
  %929 = and i214 %926, -12855504354071922204335696738729300820177623950262342682411009
  %.partset34 = or i214 %929, %928
  store i214 %.partset34, i214* %dst_3, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.exit:                               ; preds = %dst.addr.3477.case.3, %dst.addr.3477.case.2, %dst.addr.3477.case.1, %dst.addr.3477.case.0, %dst.addr.3375.exit
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 35
  %930 = bitcast i1* %src.addr.3578 to i8*
  %931 = load i8, i8* %930
  %932 = trunc i8 %931 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3579.exit [
    i64 0, label %dst.addr.3579.case.0
    i64 1, label %dst.addr.3579.case.1
    i64 2, label %dst.addr.3579.case.2
    i64 3, label %dst.addr.3579.case.3
  ]

dst.addr.3579.case.0:                             ; preds = %dst.addr.3477.exit
  %933 = bitcast i214* %dst_0 to i216*
  %934 = load i216, i216* %933
  %935 = trunc i216 %934 to i214
  %936 = zext i1 %932 to i214
  %937 = shl i214 %936, 204
  %938 = and i214 %935, -25711008708143844408671393477458601640355247900524685364822017
  %.partset144 = or i214 %938, %937
  store i214 %.partset144, i214* %dst_0, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.1:                             ; preds = %dst.addr.3477.exit
  %939 = bitcast i214* %dst_1 to i216*
  %940 = load i216, i216* %939
  %941 = trunc i216 %940 to i214
  %942 = zext i1 %932 to i214
  %943 = shl i214 %942, 204
  %944 = and i214 %941, -25711008708143844408671393477458601640355247900524685364822017
  %.partset125 = or i214 %944, %943
  store i214 %.partset125, i214* %dst_1, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.2:                             ; preds = %dst.addr.3477.exit
  %945 = bitcast i214* %dst_2 to i216*
  %946 = load i216, i216* %945
  %947 = trunc i216 %946 to i214
  %948 = zext i1 %932 to i214
  %949 = shl i214 %948, 204
  %950 = and i214 %947, -25711008708143844408671393477458601640355247900524685364822017
  %.partset54 = or i214 %950, %949
  store i214 %.partset54, i214* %dst_2, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.3:                             ; preds = %dst.addr.3477.exit
  %951 = bitcast i214* %dst_3 to i216*
  %952 = load i216, i216* %951
  %953 = trunc i216 %952 to i214
  %954 = zext i1 %932 to i214
  %955 = shl i214 %954, 204
  %956 = and i214 %953, -25711008708143844408671393477458601640355247900524685364822017
  %.partset35 = or i214 %956, %955
  store i214 %.partset35, i214* %dst_3, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.exit:                               ; preds = %dst.addr.3579.case.3, %dst.addr.3579.case.2, %dst.addr.3579.case.1, %dst.addr.3579.case.0, %dst.addr.3477.exit
  %src.addr.3680 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 36
  %957 = bitcast i1* %src.addr.3680 to i8*
  %958 = load i8, i8* %957
  %959 = trunc i8 %958 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3681.exit [
    i64 0, label %dst.addr.3681.case.0
    i64 1, label %dst.addr.3681.case.1
    i64 2, label %dst.addr.3681.case.2
    i64 3, label %dst.addr.3681.case.3
  ]

dst.addr.3681.case.0:                             ; preds = %dst.addr.3579.exit
  %960 = bitcast i214* %dst_0 to i216*
  %961 = load i216, i216* %960
  %962 = trunc i216 %961 to i214
  %963 = zext i1 %959 to i214
  %964 = shl i214 %963, 205
  %965 = and i214 %962, -51422017416287688817342786954917203280710495801049370729644033
  %.partset143 = or i214 %965, %964
  store i214 %.partset143, i214* %dst_0, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.1:                             ; preds = %dst.addr.3579.exit
  %966 = bitcast i214* %dst_1 to i216*
  %967 = load i216, i216* %966
  %968 = trunc i216 %967 to i214
  %969 = zext i1 %959 to i214
  %970 = shl i214 %969, 205
  %971 = and i214 %968, -51422017416287688817342786954917203280710495801049370729644033
  %.partset126 = or i214 %971, %970
  store i214 %.partset126, i214* %dst_1, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.2:                             ; preds = %dst.addr.3579.exit
  %972 = bitcast i214* %dst_2 to i216*
  %973 = load i216, i216* %972
  %974 = trunc i216 %973 to i214
  %975 = zext i1 %959 to i214
  %976 = shl i214 %975, 205
  %977 = and i214 %974, -51422017416287688817342786954917203280710495801049370729644033
  %.partset53 = or i214 %977, %976
  store i214 %.partset53, i214* %dst_2, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.3:                             ; preds = %dst.addr.3579.exit
  %978 = bitcast i214* %dst_3 to i216*
  %979 = load i216, i216* %978
  %980 = trunc i216 %979 to i214
  %981 = zext i1 %959 to i214
  %982 = shl i214 %981, 205
  %983 = and i214 %980, -51422017416287688817342786954917203280710495801049370729644033
  %.partset36 = or i214 %983, %982
  store i214 %.partset36, i214* %dst_3, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.exit:                               ; preds = %dst.addr.3681.case.3, %dst.addr.3681.case.2, %dst.addr.3681.case.1, %dst.addr.3681.case.0, %dst.addr.3579.exit
  %src.addr.3782 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 37
  %984 = bitcast i1* %src.addr.3782 to i8*
  %985 = load i8, i8* %984
  %986 = trunc i8 %985 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3783.exit [
    i64 0, label %dst.addr.3783.case.0
    i64 1, label %dst.addr.3783.case.1
    i64 2, label %dst.addr.3783.case.2
    i64 3, label %dst.addr.3783.case.3
  ]

dst.addr.3783.case.0:                             ; preds = %dst.addr.3681.exit
  %987 = bitcast i214* %dst_0 to i216*
  %988 = load i216, i216* %987
  %989 = trunc i216 %988 to i214
  %990 = zext i1 %986 to i214
  %991 = shl i214 %990, 206
  %992 = and i214 %989, -102844034832575377634685573909834406561420991602098741459288065
  %.partset142 = or i214 %992, %991
  store i214 %.partset142, i214* %dst_0, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.1:                             ; preds = %dst.addr.3681.exit
  %993 = bitcast i214* %dst_1 to i216*
  %994 = load i216, i216* %993
  %995 = trunc i216 %994 to i214
  %996 = zext i1 %986 to i214
  %997 = shl i214 %996, 206
  %998 = and i214 %995, -102844034832575377634685573909834406561420991602098741459288065
  %.partset127 = or i214 %998, %997
  store i214 %.partset127, i214* %dst_1, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.2:                             ; preds = %dst.addr.3681.exit
  %999 = bitcast i214* %dst_2 to i216*
  %1000 = load i216, i216* %999
  %1001 = trunc i216 %1000 to i214
  %1002 = zext i1 %986 to i214
  %1003 = shl i214 %1002, 206
  %1004 = and i214 %1001, -102844034832575377634685573909834406561420991602098741459288065
  %.partset52 = or i214 %1004, %1003
  store i214 %.partset52, i214* %dst_2, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.3:                             ; preds = %dst.addr.3681.exit
  %1005 = bitcast i214* %dst_3 to i216*
  %1006 = load i216, i216* %1005
  %1007 = trunc i216 %1006 to i214
  %1008 = zext i1 %986 to i214
  %1009 = shl i214 %1008, 206
  %1010 = and i214 %1007, -102844034832575377634685573909834406561420991602098741459288065
  %.partset37 = or i214 %1010, %1009
  store i214 %.partset37, i214* %dst_3, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.exit:                               ; preds = %dst.addr.3783.case.3, %dst.addr.3783.case.2, %dst.addr.3783.case.1, %dst.addr.3783.case.0, %dst.addr.3681.exit
  %src.addr.3884 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 38
  %1011 = bitcast i1* %src.addr.3884 to i8*
  %1012 = load i8, i8* %1011
  %1013 = trunc i8 %1012 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3885.exit [
    i64 0, label %dst.addr.3885.case.0
    i64 1, label %dst.addr.3885.case.1
    i64 2, label %dst.addr.3885.case.2
    i64 3, label %dst.addr.3885.case.3
  ]

dst.addr.3885.case.0:                             ; preds = %dst.addr.3783.exit
  %1014 = bitcast i214* %dst_0 to i216*
  %1015 = load i216, i216* %1014
  %1016 = trunc i216 %1015 to i214
  %1017 = zext i1 %1013 to i214
  %1018 = shl i214 %1017, 207
  %1019 = and i214 %1016, -205688069665150755269371147819668813122841983204197482918576129
  %.partset141 = or i214 %1019, %1018
  store i214 %.partset141, i214* %dst_0, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.1:                             ; preds = %dst.addr.3783.exit
  %1020 = bitcast i214* %dst_1 to i216*
  %1021 = load i216, i216* %1020
  %1022 = trunc i216 %1021 to i214
  %1023 = zext i1 %1013 to i214
  %1024 = shl i214 %1023, 207
  %1025 = and i214 %1022, -205688069665150755269371147819668813122841983204197482918576129
  %.partset128 = or i214 %1025, %1024
  store i214 %.partset128, i214* %dst_1, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.2:                             ; preds = %dst.addr.3783.exit
  %1026 = bitcast i214* %dst_2 to i216*
  %1027 = load i216, i216* %1026
  %1028 = trunc i216 %1027 to i214
  %1029 = zext i1 %1013 to i214
  %1030 = shl i214 %1029, 207
  %1031 = and i214 %1028, -205688069665150755269371147819668813122841983204197482918576129
  %.partset51 = or i214 %1031, %1030
  store i214 %.partset51, i214* %dst_2, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.3:                             ; preds = %dst.addr.3783.exit
  %1032 = bitcast i214* %dst_3 to i216*
  %1033 = load i216, i216* %1032
  %1034 = trunc i216 %1033 to i214
  %1035 = zext i1 %1013 to i214
  %1036 = shl i214 %1035, 207
  %1037 = and i214 %1034, -205688069665150755269371147819668813122841983204197482918576129
  %.partset38 = or i214 %1037, %1036
  store i214 %.partset38, i214* %dst_3, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.exit:                               ; preds = %dst.addr.3885.case.3, %dst.addr.3885.case.2, %dst.addr.3885.case.1, %dst.addr.3885.case.0, %dst.addr.3783.exit
  %src.addr.3986 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 39
  %1038 = bitcast i1* %src.addr.3986 to i8*
  %1039 = load i8, i8* %1038
  %1040 = trunc i8 %1039 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3987.exit [
    i64 0, label %dst.addr.3987.case.0
    i64 1, label %dst.addr.3987.case.1
    i64 2, label %dst.addr.3987.case.2
    i64 3, label %dst.addr.3987.case.3
  ]

dst.addr.3987.case.0:                             ; preds = %dst.addr.3885.exit
  %1041 = bitcast i214* %dst_0 to i216*
  %1042 = load i216, i216* %1041
  %1043 = trunc i216 %1042 to i214
  %1044 = zext i1 %1040 to i214
  %1045 = shl i214 %1044, 208
  %1046 = and i214 %1043, -411376139330301510538742295639337626245683966408394965837152257
  %.partset140 = or i214 %1046, %1045
  store i214 %.partset140, i214* %dst_0, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.1:                             ; preds = %dst.addr.3885.exit
  %1047 = bitcast i214* %dst_1 to i216*
  %1048 = load i216, i216* %1047
  %1049 = trunc i216 %1048 to i214
  %1050 = zext i1 %1040 to i214
  %1051 = shl i214 %1050, 208
  %1052 = and i214 %1049, -411376139330301510538742295639337626245683966408394965837152257
  %.partset129 = or i214 %1052, %1051
  store i214 %.partset129, i214* %dst_1, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.2:                             ; preds = %dst.addr.3885.exit
  %1053 = bitcast i214* %dst_2 to i216*
  %1054 = load i216, i216* %1053
  %1055 = trunc i216 %1054 to i214
  %1056 = zext i1 %1040 to i214
  %1057 = shl i214 %1056, 208
  %1058 = and i214 %1055, -411376139330301510538742295639337626245683966408394965837152257
  %.partset50 = or i214 %1058, %1057
  store i214 %.partset50, i214* %dst_2, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.3:                             ; preds = %dst.addr.3885.exit
  %1059 = bitcast i214* %dst_3 to i216*
  %1060 = load i216, i216* %1059
  %1061 = trunc i216 %1060 to i214
  %1062 = zext i1 %1040 to i214
  %1063 = shl i214 %1062, 208
  %1064 = and i214 %1061, -411376139330301510538742295639337626245683966408394965837152257
  %.partset39 = or i214 %1064, %1063
  store i214 %.partset39, i214* %dst_3, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.exit:                               ; preds = %dst.addr.3987.case.3, %dst.addr.3987.case.2, %dst.addr.3987.case.1, %dst.addr.3987.case.0, %dst.addr.3885.exit
  %src.addr.4088 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 40
  %1065 = bitcast i1* %src.addr.4088 to i8*
  %1066 = load i8, i8* %1065
  %1067 = trunc i8 %1066 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4089.exit [
    i64 0, label %dst.addr.4089.case.0
    i64 1, label %dst.addr.4089.case.1
    i64 2, label %dst.addr.4089.case.2
    i64 3, label %dst.addr.4089.case.3
  ]

dst.addr.4089.case.0:                             ; preds = %dst.addr.3987.exit
  %1068 = bitcast i214* %dst_0 to i216*
  %1069 = load i216, i216* %1068
  %1070 = trunc i216 %1069 to i214
  %1071 = zext i1 %1067 to i214
  %1072 = shl i214 %1071, 209
  %1073 = and i214 %1070, -822752278660603021077484591278675252491367932816789931674304513
  %.partset139 = or i214 %1073, %1072
  store i214 %.partset139, i214* %dst_0, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.1:                             ; preds = %dst.addr.3987.exit
  %1074 = bitcast i214* %dst_1 to i216*
  %1075 = load i216, i216* %1074
  %1076 = trunc i216 %1075 to i214
  %1077 = zext i1 %1067 to i214
  %1078 = shl i214 %1077, 209
  %1079 = and i214 %1076, -822752278660603021077484591278675252491367932816789931674304513
  %.partset130 = or i214 %1079, %1078
  store i214 %.partset130, i214* %dst_1, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.2:                             ; preds = %dst.addr.3987.exit
  %1080 = bitcast i214* %dst_2 to i216*
  %1081 = load i216, i216* %1080
  %1082 = trunc i216 %1081 to i214
  %1083 = zext i1 %1067 to i214
  %1084 = shl i214 %1083, 209
  %1085 = and i214 %1082, -822752278660603021077484591278675252491367932816789931674304513
  %.partset49 = or i214 %1085, %1084
  store i214 %.partset49, i214* %dst_2, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.3:                             ; preds = %dst.addr.3987.exit
  %1086 = bitcast i214* %dst_3 to i216*
  %1087 = load i216, i216* %1086
  %1088 = trunc i216 %1087 to i214
  %1089 = zext i1 %1067 to i214
  %1090 = shl i214 %1089, 209
  %1091 = and i214 %1088, -822752278660603021077484591278675252491367932816789931674304513
  %.partset40 = or i214 %1091, %1090
  store i214 %.partset40, i214* %dst_3, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.exit:                               ; preds = %dst.addr.4089.case.3, %dst.addr.4089.case.2, %dst.addr.4089.case.1, %dst.addr.4089.case.0, %dst.addr.3987.exit
  %src.addr.4190 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 41
  %1092 = bitcast i1* %src.addr.4190 to i8*
  %1093 = load i8, i8* %1092
  %1094 = trunc i8 %1093 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4191.exit [
    i64 0, label %dst.addr.4191.case.0
    i64 1, label %dst.addr.4191.case.1
    i64 2, label %dst.addr.4191.case.2
    i64 3, label %dst.addr.4191.case.3
  ]

dst.addr.4191.case.0:                             ; preds = %dst.addr.4089.exit
  %1095 = bitcast i214* %dst_0 to i216*
  %1096 = load i216, i216* %1095
  %1097 = trunc i216 %1096 to i214
  %1098 = zext i1 %1094 to i214
  %1099 = shl i214 %1098, 210
  %1100 = and i214 %1097, -1645504557321206042154969182557350504982735865633579863348609025
  %.partset138 = or i214 %1100, %1099
  store i214 %.partset138, i214* %dst_0, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.1:                             ; preds = %dst.addr.4089.exit
  %1101 = bitcast i214* %dst_1 to i216*
  %1102 = load i216, i216* %1101
  %1103 = trunc i216 %1102 to i214
  %1104 = zext i1 %1094 to i214
  %1105 = shl i214 %1104, 210
  %1106 = and i214 %1103, -1645504557321206042154969182557350504982735865633579863348609025
  %.partset131 = or i214 %1106, %1105
  store i214 %.partset131, i214* %dst_1, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.2:                             ; preds = %dst.addr.4089.exit
  %1107 = bitcast i214* %dst_2 to i216*
  %1108 = load i216, i216* %1107
  %1109 = trunc i216 %1108 to i214
  %1110 = zext i1 %1094 to i214
  %1111 = shl i214 %1110, 210
  %1112 = and i214 %1109, -1645504557321206042154969182557350504982735865633579863348609025
  %.partset48 = or i214 %1112, %1111
  store i214 %.partset48, i214* %dst_2, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.3:                             ; preds = %dst.addr.4089.exit
  %1113 = bitcast i214* %dst_3 to i216*
  %1114 = load i216, i216* %1113
  %1115 = trunc i216 %1114 to i214
  %1116 = zext i1 %1094 to i214
  %1117 = shl i214 %1116, 210
  %1118 = and i214 %1115, -1645504557321206042154969182557350504982735865633579863348609025
  %.partset41 = or i214 %1118, %1117
  store i214 %.partset41, i214* %dst_3, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.exit:                               ; preds = %dst.addr.4191.case.3, %dst.addr.4191.case.2, %dst.addr.4191.case.1, %dst.addr.4191.case.0, %dst.addr.4089.exit
  %src.addr.4292 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 42
  %1119 = bitcast i1* %src.addr.4292 to i8*
  %1120 = load i8, i8* %1119
  %1121 = trunc i8 %1120 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4293.exit [
    i64 0, label %dst.addr.4293.case.0
    i64 1, label %dst.addr.4293.case.1
    i64 2, label %dst.addr.4293.case.2
    i64 3, label %dst.addr.4293.case.3
  ]

dst.addr.4293.case.0:                             ; preds = %dst.addr.4191.exit
  %1122 = bitcast i214* %dst_0 to i216*
  %1123 = load i216, i216* %1122
  %1124 = trunc i216 %1123 to i214
  %1125 = zext i1 %1121 to i214
  %1126 = shl i214 %1125, 211
  %1127 = and i214 %1124, -3291009114642412084309938365114701009965471731267159726697218049
  %.partset137 = or i214 %1127, %1126
  store i214 %.partset137, i214* %dst_0, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.1:                             ; preds = %dst.addr.4191.exit
  %1128 = bitcast i214* %dst_1 to i216*
  %1129 = load i216, i216* %1128
  %1130 = trunc i216 %1129 to i214
  %1131 = zext i1 %1121 to i214
  %1132 = shl i214 %1131, 211
  %1133 = and i214 %1130, -3291009114642412084309938365114701009965471731267159726697218049
  %.partset132 = or i214 %1133, %1132
  store i214 %.partset132, i214* %dst_1, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.2:                             ; preds = %dst.addr.4191.exit
  %1134 = bitcast i214* %dst_2 to i216*
  %1135 = load i216, i216* %1134
  %1136 = trunc i216 %1135 to i214
  %1137 = zext i1 %1121 to i214
  %1138 = shl i214 %1137, 211
  %1139 = and i214 %1136, -3291009114642412084309938365114701009965471731267159726697218049
  %.partset47 = or i214 %1139, %1138
  store i214 %.partset47, i214* %dst_2, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.3:                             ; preds = %dst.addr.4191.exit
  %1140 = bitcast i214* %dst_3 to i216*
  %1141 = load i216, i216* %1140
  %1142 = trunc i216 %1141 to i214
  %1143 = zext i1 %1121 to i214
  %1144 = shl i214 %1143, 211
  %1145 = and i214 %1142, -3291009114642412084309938365114701009965471731267159726697218049
  %.partset42 = or i214 %1145, %1144
  store i214 %.partset42, i214* %dst_3, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.exit:                               ; preds = %dst.addr.4293.case.3, %dst.addr.4293.case.2, %dst.addr.4293.case.1, %dst.addr.4293.case.0, %dst.addr.4191.exit
  %src.addr.4394 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 43
  %1146 = bitcast i1* %src.addr.4394 to i8*
  %1147 = load i8, i8* %1146
  %1148 = trunc i8 %1147 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4395.exit [
    i64 0, label %dst.addr.4395.case.0
    i64 1, label %dst.addr.4395.case.1
    i64 2, label %dst.addr.4395.case.2
    i64 3, label %dst.addr.4395.case.3
  ]

dst.addr.4395.case.0:                             ; preds = %dst.addr.4293.exit
  %1149 = bitcast i214* %dst_0 to i216*
  %1150 = load i216, i216* %1149
  %1151 = trunc i216 %1150 to i214
  %1152 = zext i1 %1148 to i214
  %1153 = shl i214 %1152, 212
  %1154 = and i214 %1151, -6582018229284824168619876730229402019930943462534319453394436097
  %.partset136 = or i214 %1154, %1153
  store i214 %.partset136, i214* %dst_0, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.1:                             ; preds = %dst.addr.4293.exit
  %1155 = bitcast i214* %dst_1 to i216*
  %1156 = load i216, i216* %1155
  %1157 = trunc i216 %1156 to i214
  %1158 = zext i1 %1148 to i214
  %1159 = shl i214 %1158, 212
  %1160 = and i214 %1157, -6582018229284824168619876730229402019930943462534319453394436097
  %.partset133 = or i214 %1160, %1159
  store i214 %.partset133, i214* %dst_1, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.2:                             ; preds = %dst.addr.4293.exit
  %1161 = bitcast i214* %dst_2 to i216*
  %1162 = load i216, i216* %1161
  %1163 = trunc i216 %1162 to i214
  %1164 = zext i1 %1148 to i214
  %1165 = shl i214 %1164, 212
  %1166 = and i214 %1163, -6582018229284824168619876730229402019930943462534319453394436097
  %.partset46 = or i214 %1166, %1165
  store i214 %.partset46, i214* %dst_2, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.3:                             ; preds = %dst.addr.4293.exit
  %1167 = bitcast i214* %dst_3 to i216*
  %1168 = load i216, i216* %1167
  %1169 = trunc i216 %1168 to i214
  %1170 = zext i1 %1148 to i214
  %1171 = shl i214 %1170, 212
  %1172 = and i214 %1169, -6582018229284824168619876730229402019930943462534319453394436097
  %.partset43 = or i214 %1172, %1171
  store i214 %.partset43, i214* %dst_3, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.exit:                               ; preds = %dst.addr.4395.case.3, %dst.addr.4395.case.2, %dst.addr.4395.case.1, %dst.addr.4395.case.0, %dst.addr.4293.exit
  %src.addr.4496 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 44
  %1173 = bitcast i1* %src.addr.4496 to i8*
  %1174 = load i8, i8* %1173
  %1175 = trunc i8 %1174 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4497.exit [
    i64 0, label %dst.addr.4497.case.0
    i64 1, label %dst.addr.4497.case.1
    i64 2, label %dst.addr.4497.case.2
    i64 3, label %dst.addr.4497.case.3
  ]

dst.addr.4497.case.0:                             ; preds = %dst.addr.4395.exit
  %1176 = bitcast i214* %dst_0 to i216*
  %1177 = load i216, i216* %1176
  %1178 = trunc i216 %1177 to i214
  %1179 = zext i1 %1175 to i214
  %1180 = shl i214 %1179, 213
  %1181 = and i214 %1178, 13164036458569648337239753460458804039861886925068638906788872191
  %.partset135 = or i214 %1181, %1180
  store i214 %.partset135, i214* %dst_0, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.1:                             ; preds = %dst.addr.4395.exit
  %1182 = bitcast i214* %dst_1 to i216*
  %1183 = load i216, i216* %1182
  %1184 = trunc i216 %1183 to i214
  %1185 = zext i1 %1175 to i214
  %1186 = shl i214 %1185, 213
  %1187 = and i214 %1184, 13164036458569648337239753460458804039861886925068638906788872191
  %.partset134 = or i214 %1187, %1186
  store i214 %.partset134, i214* %dst_1, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.2:                             ; preds = %dst.addr.4395.exit
  %1188 = bitcast i214* %dst_2 to i216*
  %1189 = load i216, i216* %1188
  %1190 = trunc i216 %1189 to i214
  %1191 = zext i1 %1175 to i214
  %1192 = shl i214 %1191, 213
  %1193 = and i214 %1190, 13164036458569648337239753460458804039861886925068638906788872191
  %.partset45 = or i214 %1193, %1192
  store i214 %.partset45, i214* %dst_2, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.3:                             ; preds = %dst.addr.4395.exit
  %1194 = bitcast i214* %dst_3 to i216*
  %1195 = load i216, i216* %1194
  %1196 = trunc i216 %1195 to i214
  %1197 = zext i1 %1175 to i214
  %1198 = shl i214 %1197, 213
  %1199 = and i214 %1196, 13164036458569648337239753460458804039861886925068638906788872191
  %.partset44 = or i214 %1199, %1198
  store i214 %.partset44, i214* %dst_3, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.exit:                               ; preds = %dst.addr.4497.case.3, %dst.addr.4497.case.2, %dst.addr.4497.case.1, %dst.addr.4497.case.0, %dst.addr.4395.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx99, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.4497.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.21.24(i214* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i214* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i214* noalias align 512 "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i214* noalias align 512 "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #1 {
entry:
  %0 = icmp eq i214* %dst_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.22.23(i214* nonnull %dst_0, i214* %dst_1, i214* %dst_2, i214* %dst_3, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in(i1* noalias readonly "orig.arg.no"="0", i1* noalias align 512 "orig.arg.no"="1", i32* noalias readonly "orig.arg.no"="2", i32* noalias align 512 "orig.arg.no"="3", i1* noalias readonly "orig.arg.no"="4", i1* noalias align 512 "orig.arg.no"="5", i1* noalias readonly "orig.arg.no"="6", i1* noalias align 512 "orig.arg.no"="7", i1* noalias readonly "orig.arg.no"="8", i1* noalias align 512 "orig.arg.no"="9", i32* noalias readonly "orig.arg.no"="10", i32* noalias align 512 "orig.arg.no"="11", [129 x i8]* noalias readonly "orig.arg.no"="12", [129 x i8]* noalias align 512 "orig.arg.no"="13", [64 x i8]* noalias readonly "orig.arg.no"="14", [64 x i8]* noalias align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="16", i214* noalias align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i214* noalias align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i214* noalias align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i214* noalias align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias readonly "orig.arg.no"="18", i1* noalias align 512 "orig.arg.no"="19", i32* noalias readonly "orig.arg.no"="20", i32* noalias align 512 "orig.arg.no"="21", i1* noalias readonly "orig.arg.no"="22", i1* noalias align 512 "orig.arg.no"="23", i32* noalias readonly "orig.arg.no"="24", i32* noalias align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias readonly "orig.arg.no"="26", i1056* noalias align 512 "orig.arg.no"="27", i32* noalias readonly "orig.arg.no"="28", i32* noalias align 512 "orig.arg.no"="29", i32* noalias readonly "orig.arg.no"="30", i32* noalias align 512 "orig.arg.no"="31", i32* noalias readonly "orig.arg.no"="32", i32* noalias align 512 "orig.arg.no"="33", i32* noalias readonly "orig.arg.no"="34", i32* noalias align 512 "orig.arg.no"="35", i32* noalias readonly "orig.arg.no"="36", i32* noalias align 512 "orig.arg.no"="37", i32* noalias readonly "orig.arg.no"="38", i32* noalias align 512 "orig.arg.no"="39", i32* noalias readonly "orig.arg.no"="40", i32* noalias align 512 "orig.arg.no"="41", i32* noalias readonly "orig.arg.no"="42", i32* noalias align 512 "orig.arg.no"="43", i32* noalias readonly "orig.arg.no"="44", i32* noalias align 512 "orig.arg.no"="45", i32* noalias readonly "orig.arg.no"="46", i32* noalias align 512 "orig.arg.no"="47", i32* noalias readonly "orig.arg.no"="48", i32* noalias align 512 "orig.arg.no"="49", i32* noalias readonly "orig.arg.no"="50", i32* noalias align 512 "orig.arg.no"="51", i32* noalias readonly "orig.arg.no"="52", i32* noalias align 512 "orig.arg.no"="53", i32* noalias readonly "orig.arg.no"="54", i32* noalias align 512 "orig.arg.no"="55", i32* noalias readonly "orig.arg.no"="56", i32* noalias align 512 "orig.arg.no"="57", i1* noalias readonly "orig.arg.no"="58", i1* noalias align 512 "orig.arg.no"="59", i32* noalias readonly "orig.arg.no"="60", i32* noalias align 512 "orig.arg.no"="61", i1* noalias readonly "orig.arg.no"="62", i1* noalias align 512 "orig.arg.no"="63", i1* noalias readonly "orig.arg.no"="64", i1* noalias align 512 "orig.arg.no"="65", i8* noalias readonly "orig.arg.no"="66", i8* noalias align 512 "orig.arg.no"="67", i32* noalias readonly "orig.arg.no"="68", i32* noalias align 512 "orig.arg.no"="69", i8* noalias readonly "orig.arg.no"="70", i8* noalias align 512 "orig.arg.no"="71", i8* noalias readonly "orig.arg.no"="72", i8* noalias align 512 "orig.arg.no"="73", i8* noalias readonly "orig.arg.no"="74", i8* noalias align 512 "orig.arg.no"="75", i8* noalias readonly "orig.arg.no"="76", i8* noalias align 512 "orig.arg.no"="77", i1* noalias readonly "orig.arg.no"="78", i1* noalias align 512 "orig.arg.no"="79", i1* noalias readonly "orig.arg.no"="80", i1* noalias align 512 "orig.arg.no"="81", i1* noalias readonly "orig.arg.no"="82", i1* noalias align 512 "orig.arg.no"="83", i1* noalias readonly "orig.arg.no"="84", i1* noalias align 512 "orig.arg.no"="85", i1* noalias readonly "orig.arg.no"="86", i1* noalias align 512 "orig.arg.no"="87", i1* noalias readonly "orig.arg.no"="88", i1* noalias align 512 "orig.arg.no"="89") #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %3, i32* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %5, i1* %4)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %7, i1* %6)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %9, i1* %8)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %11, i32* %10)
  call fastcc void @onebyonecpy_hls.p0a129i8([129 x i8]* align 512 %13, [129 x i8]* %12)
  call fastcc void @onebyonecpy_hls.p0a64i8([64 x i8]* align 512 %15, [64 x i8]* %14)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.21.24(i214* align 512 %_0, i214* align 512 %_1, i214* align 512 %_2, i214* align 512 %_3, [4 x %struct.HeadCtx]* %16)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %18, i1* %17)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %20, i32* %19)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %22, i1* %21)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %24, i32* %23)
  call fastcc void @onebyonecpy_hls.p0struct.ControlMemSpace(i1056* align 512 %26, %struct.ControlMemSpace* %25)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %28, i32* %27)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %30, i32* %29)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %32, i32* %31)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %34, i32* %33)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %36, i32* %35)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %38, i32* %37)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %40, i32* %39)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %42, i32* %41)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %44, i32* %43)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %46, i32* %45)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %48, i32* %47)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %50, i32* %49)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %52, i32* %51)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %54, i32* %53)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %56, i32* %55)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %58, i1* %57)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %60, i32* %59)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %62, i1* %61)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %64, i1* %63)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %66, i8* %65)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %68, i32* %67)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %70, i8* %69)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %72, i8* %71)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %74, i8* %73)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %76, i8* %75)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %78, i1* %77)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %80, i1* %79)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %82, i1* %81)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %84, i1* %83)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %86, i1* %85)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %88, i1* %87)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.32.33([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i214* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i214* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i214* readonly "orig.arg.no"="1" "unpacked"="1.2" %src_2, i214* readonly "orig.arg.no"="1" "unpacked"="1.3" %src_3, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i214* %src_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond98 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond98, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.4496.exit, %for.loop.lr.ph
  %for.loop.idx99 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.4496.exit ]
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 0
  switch i64 %for.loop.idx99, label %src.addr.01.exit [
    i64 0, label %src.addr.01.case.0
    i64 1, label %src.addr.01.case.1
    i64 2, label %src.addr.01.case.2
    i64 3, label %src.addr.01.case.3
  ]

src.addr.01.case.0:                               ; preds = %for.loop
  %3 = bitcast i214* %src_0 to i216*
  %4 = load i216, i216* %3
  %5 = trunc i216 %4 to i214
  %_0.partselect = trunc i214 %5 to i32
  br label %src.addr.01.exit

src.addr.01.case.1:                               ; preds = %for.loop
  %6 = bitcast i214* %src_1 to i216*
  %7 = load i216, i216* %6
  %8 = trunc i216 %7 to i214
  %_1.partselect = trunc i214 %8 to i32
  br label %src.addr.01.exit

src.addr.01.case.2:                               ; preds = %for.loop
  %9 = bitcast i214* %src_2 to i216*
  %10 = load i216, i216* %9
  %11 = trunc i216 %10 to i214
  %_2.partselect = trunc i214 %11 to i32
  br label %src.addr.01.exit

src.addr.01.case.3:                               ; preds = %for.loop
  %12 = bitcast i214* %src_3 to i216*
  %13 = load i216, i216* %12
  %14 = trunc i216 %13 to i214
  %_3.partselect = trunc i214 %14 to i32
  br label %src.addr.01.exit

src.addr.01.exit:                                 ; preds = %src.addr.01.case.3, %src.addr.01.case.2, %src.addr.01.case.1, %src.addr.01.case.0, %for.loop
  %15 = phi i32 [ %_0.partselect, %src.addr.01.case.0 ], [ %_1.partselect, %src.addr.01.case.1 ], [ %_2.partselect, %src.addr.01.case.2 ], [ %_3.partselect, %src.addr.01.case.3 ], [ undef, %for.loop ]
  store i32 %15, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 1
  switch i64 %for.loop.idx99, label %src.addr.110.exit [
    i64 0, label %src.addr.110.case.0
    i64 1, label %src.addr.110.case.1
    i64 2, label %src.addr.110.case.2
    i64 3, label %src.addr.110.case.3
  ]

src.addr.110.case.0:                              ; preds = %src.addr.01.exit
  %16 = bitcast i214* %src_0 to i216*
  %17 = load i216, i216* %16
  %18 = trunc i216 %17 to i214
  %19 = lshr i214 %18, 32
  %_01.partselect = trunc i214 %19 to i32
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %20 = bitcast i214* %src_1 to i216*
  %21 = load i216, i216* %20
  %22 = trunc i216 %21 to i214
  %23 = lshr i214 %22, 32
  %_12.partselect = trunc i214 %23 to i32
  br label %src.addr.110.exit

src.addr.110.case.2:                              ; preds = %src.addr.01.exit
  %24 = bitcast i214* %src_2 to i216*
  %25 = load i216, i216* %24
  %26 = trunc i216 %25 to i214
  %27 = lshr i214 %26, 32
  %_23.partselect = trunc i214 %27 to i32
  br label %src.addr.110.exit

src.addr.110.case.3:                              ; preds = %src.addr.01.exit
  %28 = bitcast i214* %src_3 to i216*
  %29 = load i216, i216* %28
  %30 = trunc i216 %29 to i214
  %31 = lshr i214 %30, 32
  %_34.partselect = trunc i214 %31 to i32
  br label %src.addr.110.exit

src.addr.110.exit:                                ; preds = %src.addr.110.case.3, %src.addr.110.case.2, %src.addr.110.case.1, %src.addr.110.case.0, %src.addr.01.exit
  %32 = phi i32 [ %_01.partselect, %src.addr.110.case.0 ], [ %_12.partselect, %src.addr.110.case.1 ], [ %_23.partselect, %src.addr.110.case.2 ], [ %_34.partselect, %src.addr.110.case.3 ], [ undef, %src.addr.01.exit ]
  store i32 %32, i32* %dst.addr.111, align 4
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 2
  switch i64 %for.loop.idx99, label %src.addr.212.exit [
    i64 0, label %src.addr.212.case.0
    i64 1, label %src.addr.212.case.1
    i64 2, label %src.addr.212.case.2
    i64 3, label %src.addr.212.case.3
  ]

src.addr.212.case.0:                              ; preds = %src.addr.110.exit
  %33 = bitcast i214* %src_0 to i216*
  %34 = load i216, i216* %33
  %35 = trunc i216 %34 to i214
  %36 = lshr i214 %35, 64
  %_05.partselect = trunc i214 %36 to i8
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %37 = bitcast i214* %src_1 to i216*
  %38 = load i216, i216* %37
  %39 = trunc i216 %38 to i214
  %40 = lshr i214 %39, 64
  %_16.partselect = trunc i214 %40 to i8
  br label %src.addr.212.exit

src.addr.212.case.2:                              ; preds = %src.addr.110.exit
  %41 = bitcast i214* %src_2 to i216*
  %42 = load i216, i216* %41
  %43 = trunc i216 %42 to i214
  %44 = lshr i214 %43, 64
  %_27.partselect = trunc i214 %44 to i8
  br label %src.addr.212.exit

src.addr.212.case.3:                              ; preds = %src.addr.110.exit
  %45 = bitcast i214* %src_3 to i216*
  %46 = load i216, i216* %45
  %47 = trunc i216 %46 to i214
  %48 = lshr i214 %47, 64
  %_38.partselect = trunc i214 %48 to i8
  br label %src.addr.212.exit

src.addr.212.exit:                                ; preds = %src.addr.212.case.3, %src.addr.212.case.2, %src.addr.212.case.1, %src.addr.212.case.0, %src.addr.110.exit
  %49 = phi i8 [ %_05.partselect, %src.addr.212.case.0 ], [ %_16.partselect, %src.addr.212.case.1 ], [ %_27.partselect, %src.addr.212.case.2 ], [ %_38.partselect, %src.addr.212.case.3 ], [ undef, %src.addr.110.exit ]
  store i8 %49, i8* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 3
  switch i64 %for.loop.idx99, label %src.addr.314.exit [
    i64 0, label %src.addr.314.case.0
    i64 1, label %src.addr.314.case.1
    i64 2, label %src.addr.314.case.2
    i64 3, label %src.addr.314.case.3
  ]

src.addr.314.case.0:                              ; preds = %src.addr.212.exit
  %50 = bitcast i214* %src_0 to i216*
  %51 = load i216, i216* %50
  %52 = trunc i216 %51 to i214
  %53 = lshr i214 %52, 72
  %_09.partselect = trunc i214 %53 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %54 = bitcast i214* %src_1 to i216*
  %55 = load i216, i216* %54
  %56 = trunc i216 %55 to i214
  %57 = lshr i214 %56, 72
  %_110.partselect = trunc i214 %57 to i1
  br label %src.addr.314.exit

src.addr.314.case.2:                              ; preds = %src.addr.212.exit
  %58 = bitcast i214* %src_2 to i216*
  %59 = load i216, i216* %58
  %60 = trunc i216 %59 to i214
  %61 = lshr i214 %60, 72
  %_211.partselect = trunc i214 %61 to i1
  br label %src.addr.314.exit

src.addr.314.case.3:                              ; preds = %src.addr.212.exit
  %62 = bitcast i214* %src_3 to i216*
  %63 = load i216, i216* %62
  %64 = trunc i216 %63 to i214
  %65 = lshr i214 %64, 72
  %_312.partselect = trunc i214 %65 to i1
  br label %src.addr.314.exit

src.addr.314.exit:                                ; preds = %src.addr.314.case.3, %src.addr.314.case.2, %src.addr.314.case.1, %src.addr.314.case.0, %src.addr.212.exit
  %66 = phi i1 [ %_09.partselect, %src.addr.314.case.0 ], [ %_110.partselect, %src.addr.314.case.1 ], [ %_211.partselect, %src.addr.314.case.2 ], [ %_312.partselect, %src.addr.314.case.3 ], [ undef, %src.addr.212.exit ]
  store i1 %66, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 4
  switch i64 %for.loop.idx99, label %src.addr.416.exit [
    i64 0, label %src.addr.416.case.0
    i64 1, label %src.addr.416.case.1
    i64 2, label %src.addr.416.case.2
    i64 3, label %src.addr.416.case.3
  ]

src.addr.416.case.0:                              ; preds = %src.addr.314.exit
  %67 = bitcast i214* %src_0 to i216*
  %68 = load i216, i216* %67
  %69 = trunc i216 %68 to i214
  %70 = lshr i214 %69, 73
  %_013.partselect = trunc i214 %70 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %71 = bitcast i214* %src_1 to i216*
  %72 = load i216, i216* %71
  %73 = trunc i216 %72 to i214
  %74 = lshr i214 %73, 73
  %_114.partselect = trunc i214 %74 to i1
  br label %src.addr.416.exit

src.addr.416.case.2:                              ; preds = %src.addr.314.exit
  %75 = bitcast i214* %src_2 to i216*
  %76 = load i216, i216* %75
  %77 = trunc i216 %76 to i214
  %78 = lshr i214 %77, 73
  %_215.partselect = trunc i214 %78 to i1
  br label %src.addr.416.exit

src.addr.416.case.3:                              ; preds = %src.addr.314.exit
  %79 = bitcast i214* %src_3 to i216*
  %80 = load i216, i216* %79
  %81 = trunc i216 %80 to i214
  %82 = lshr i214 %81, 73
  %_316.partselect = trunc i214 %82 to i1
  br label %src.addr.416.exit

src.addr.416.exit:                                ; preds = %src.addr.416.case.3, %src.addr.416.case.2, %src.addr.416.case.1, %src.addr.416.case.0, %src.addr.314.exit
  %83 = phi i1 [ %_013.partselect, %src.addr.416.case.0 ], [ %_114.partselect, %src.addr.416.case.1 ], [ %_215.partselect, %src.addr.416.case.2 ], [ %_316.partselect, %src.addr.416.case.3 ], [ undef, %src.addr.314.exit ]
  store i1 %83, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 5
  switch i64 %for.loop.idx99, label %src.addr.518.exit [
    i64 0, label %src.addr.518.case.0
    i64 1, label %src.addr.518.case.1
    i64 2, label %src.addr.518.case.2
    i64 3, label %src.addr.518.case.3
  ]

src.addr.518.case.0:                              ; preds = %src.addr.416.exit
  %84 = bitcast i214* %src_0 to i216*
  %85 = load i216, i216* %84
  %86 = trunc i216 %85 to i214
  %87 = lshr i214 %86, 74
  %_017.partselect = trunc i214 %87 to i1
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %88 = bitcast i214* %src_1 to i216*
  %89 = load i216, i216* %88
  %90 = trunc i216 %89 to i214
  %91 = lshr i214 %90, 74
  %_118.partselect = trunc i214 %91 to i1
  br label %src.addr.518.exit

src.addr.518.case.2:                              ; preds = %src.addr.416.exit
  %92 = bitcast i214* %src_2 to i216*
  %93 = load i216, i216* %92
  %94 = trunc i216 %93 to i214
  %95 = lshr i214 %94, 74
  %_219.partselect = trunc i214 %95 to i1
  br label %src.addr.518.exit

src.addr.518.case.3:                              ; preds = %src.addr.416.exit
  %96 = bitcast i214* %src_3 to i216*
  %97 = load i216, i216* %96
  %98 = trunc i216 %97 to i214
  %99 = lshr i214 %98, 74
  %_320.partselect = trunc i214 %99 to i1
  br label %src.addr.518.exit

src.addr.518.exit:                                ; preds = %src.addr.518.case.3, %src.addr.518.case.2, %src.addr.518.case.1, %src.addr.518.case.0, %src.addr.416.exit
  %100 = phi i1 [ %_017.partselect, %src.addr.518.case.0 ], [ %_118.partselect, %src.addr.518.case.1 ], [ %_219.partselect, %src.addr.518.case.2 ], [ %_320.partselect, %src.addr.518.case.3 ], [ undef, %src.addr.416.exit ]
  store i1 %100, i1* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 6
  switch i64 %for.loop.idx99, label %src.addr.620.exit [
    i64 0, label %src.addr.620.case.0
    i64 1, label %src.addr.620.case.1
    i64 2, label %src.addr.620.case.2
    i64 3, label %src.addr.620.case.3
  ]

src.addr.620.case.0:                              ; preds = %src.addr.518.exit
  %101 = bitcast i214* %src_0 to i216*
  %102 = load i216, i216* %101
  %103 = trunc i216 %102 to i214
  %104 = lshr i214 %103, 75
  %_021.partselect = trunc i214 %104 to i32
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %105 = bitcast i214* %src_1 to i216*
  %106 = load i216, i216* %105
  %107 = trunc i216 %106 to i214
  %108 = lshr i214 %107, 75
  %_122.partselect = trunc i214 %108 to i32
  br label %src.addr.620.exit

src.addr.620.case.2:                              ; preds = %src.addr.518.exit
  %109 = bitcast i214* %src_2 to i216*
  %110 = load i216, i216* %109
  %111 = trunc i216 %110 to i214
  %112 = lshr i214 %111, 75
  %_223.partselect = trunc i214 %112 to i32
  br label %src.addr.620.exit

src.addr.620.case.3:                              ; preds = %src.addr.518.exit
  %113 = bitcast i214* %src_3 to i216*
  %114 = load i216, i216* %113
  %115 = trunc i216 %114 to i214
  %116 = lshr i214 %115, 75
  %_324.partselect = trunc i214 %116 to i32
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.3, %src.addr.620.case.2, %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %117 = phi i32 [ %_021.partselect, %src.addr.620.case.0 ], [ %_122.partselect, %src.addr.620.case.1 ], [ %_223.partselect, %src.addr.620.case.2 ], [ %_324.partselect, %src.addr.620.case.3 ], [ undef, %src.addr.518.exit ]
  store i32 %117, i32* %dst.addr.621, align 4
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 7
  switch i64 %for.loop.idx99, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
    i64 2, label %src.addr.722.case.2
    i64 3, label %src.addr.722.case.3
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %118 = bitcast i214* %src_0 to i216*
  %119 = load i216, i216* %118
  %120 = trunc i216 %119 to i214
  %121 = lshr i214 %120, 107
  %_025.partselect = trunc i214 %121 to i32
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %122 = bitcast i214* %src_1 to i216*
  %123 = load i216, i216* %122
  %124 = trunc i216 %123 to i214
  %125 = lshr i214 %124, 107
  %_126.partselect = trunc i214 %125 to i32
  br label %src.addr.722.exit

src.addr.722.case.2:                              ; preds = %src.addr.620.exit
  %126 = bitcast i214* %src_2 to i216*
  %127 = load i216, i216* %126
  %128 = trunc i216 %127 to i214
  %129 = lshr i214 %128, 107
  %_227.partselect = trunc i214 %129 to i32
  br label %src.addr.722.exit

src.addr.722.case.3:                              ; preds = %src.addr.620.exit
  %130 = bitcast i214* %src_3 to i216*
  %131 = load i216, i216* %130
  %132 = trunc i216 %131 to i214
  %133 = lshr i214 %132, 107
  %_328.partselect = trunc i214 %133 to i32
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.3, %src.addr.722.case.2, %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %134 = phi i32 [ %_025.partselect, %src.addr.722.case.0 ], [ %_126.partselect, %src.addr.722.case.1 ], [ %_227.partselect, %src.addr.722.case.2 ], [ %_328.partselect, %src.addr.722.case.3 ], [ undef, %src.addr.620.exit ]
  store i32 %134, i32* %dst.addr.723, align 4
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 8
  switch i64 %for.loop.idx99, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
    i64 2, label %src.addr.824.case.2
    i64 3, label %src.addr.824.case.3
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %135 = bitcast i214* %src_0 to i216*
  %136 = load i216, i216* %135
  %137 = trunc i216 %136 to i214
  %138 = lshr i214 %137, 139
  %_029.partselect = trunc i214 %138 to i8
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %139 = bitcast i214* %src_1 to i216*
  %140 = load i216, i216* %139
  %141 = trunc i216 %140 to i214
  %142 = lshr i214 %141, 139
  %_130.partselect = trunc i214 %142 to i8
  br label %src.addr.824.exit

src.addr.824.case.2:                              ; preds = %src.addr.722.exit
  %143 = bitcast i214* %src_2 to i216*
  %144 = load i216, i216* %143
  %145 = trunc i216 %144 to i214
  %146 = lshr i214 %145, 139
  %_231.partselect = trunc i214 %146 to i8
  br label %src.addr.824.exit

src.addr.824.case.3:                              ; preds = %src.addr.722.exit
  %147 = bitcast i214* %src_3 to i216*
  %148 = load i216, i216* %147
  %149 = trunc i216 %148 to i214
  %150 = lshr i214 %149, 139
  %_332.partselect = trunc i214 %150 to i8
  br label %src.addr.824.exit

src.addr.824.exit:                                ; preds = %src.addr.824.case.3, %src.addr.824.case.2, %src.addr.824.case.1, %src.addr.824.case.0, %src.addr.722.exit
  %151 = phi i8 [ %_029.partselect, %src.addr.824.case.0 ], [ %_130.partselect, %src.addr.824.case.1 ], [ %_231.partselect, %src.addr.824.case.2 ], [ %_332.partselect, %src.addr.824.case.3 ], [ undef, %src.addr.722.exit ]
  store i8 %151, i8* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 9
  switch i64 %for.loop.idx99, label %src.addr.926.exit [
    i64 0, label %src.addr.926.case.0
    i64 1, label %src.addr.926.case.1
    i64 2, label %src.addr.926.case.2
    i64 3, label %src.addr.926.case.3
  ]

src.addr.926.case.0:                              ; preds = %src.addr.824.exit
  %152 = bitcast i214* %src_0 to i216*
  %153 = load i216, i216* %152
  %154 = trunc i216 %153 to i214
  %155 = lshr i214 %154, 147
  %_033.partselect = trunc i214 %155 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %156 = bitcast i214* %src_1 to i216*
  %157 = load i216, i216* %156
  %158 = trunc i216 %157 to i214
  %159 = lshr i214 %158, 147
  %_134.partselect = trunc i214 %159 to i1
  br label %src.addr.926.exit

src.addr.926.case.2:                              ; preds = %src.addr.824.exit
  %160 = bitcast i214* %src_2 to i216*
  %161 = load i216, i216* %160
  %162 = trunc i216 %161 to i214
  %163 = lshr i214 %162, 147
  %_235.partselect = trunc i214 %163 to i1
  br label %src.addr.926.exit

src.addr.926.case.3:                              ; preds = %src.addr.824.exit
  %164 = bitcast i214* %src_3 to i216*
  %165 = load i216, i216* %164
  %166 = trunc i216 %165 to i214
  %167 = lshr i214 %166, 147
  %_336.partselect = trunc i214 %167 to i1
  br label %src.addr.926.exit

src.addr.926.exit:                                ; preds = %src.addr.926.case.3, %src.addr.926.case.2, %src.addr.926.case.1, %src.addr.926.case.0, %src.addr.824.exit
  %168 = phi i1 [ %_033.partselect, %src.addr.926.case.0 ], [ %_134.partselect, %src.addr.926.case.1 ], [ %_235.partselect, %src.addr.926.case.2 ], [ %_336.partselect, %src.addr.926.case.3 ], [ undef, %src.addr.824.exit ]
  store i1 %168, i1* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 10
  switch i64 %for.loop.idx99, label %src.addr.1028.exit [
    i64 0, label %src.addr.1028.case.0
    i64 1, label %src.addr.1028.case.1
    i64 2, label %src.addr.1028.case.2
    i64 3, label %src.addr.1028.case.3
  ]

src.addr.1028.case.0:                             ; preds = %src.addr.926.exit
  %169 = bitcast i214* %src_0 to i216*
  %170 = load i216, i216* %169
  %171 = trunc i216 %170 to i214
  %172 = lshr i214 %171, 148
  %_037.partselect = trunc i214 %172 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %173 = bitcast i214* %src_1 to i216*
  %174 = load i216, i216* %173
  %175 = trunc i216 %174 to i214
  %176 = lshr i214 %175, 148
  %_138.partselect = trunc i214 %176 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.2:                             ; preds = %src.addr.926.exit
  %177 = bitcast i214* %src_2 to i216*
  %178 = load i216, i216* %177
  %179 = trunc i216 %178 to i214
  %180 = lshr i214 %179, 148
  %_239.partselect = trunc i214 %180 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.3:                             ; preds = %src.addr.926.exit
  %181 = bitcast i214* %src_3 to i216*
  %182 = load i216, i216* %181
  %183 = trunc i216 %182 to i214
  %184 = lshr i214 %183, 148
  %_340.partselect = trunc i214 %184 to i1
  br label %src.addr.1028.exit

src.addr.1028.exit:                               ; preds = %src.addr.1028.case.3, %src.addr.1028.case.2, %src.addr.1028.case.1, %src.addr.1028.case.0, %src.addr.926.exit
  %185 = phi i1 [ %_037.partselect, %src.addr.1028.case.0 ], [ %_138.partselect, %src.addr.1028.case.1 ], [ %_239.partselect, %src.addr.1028.case.2 ], [ %_340.partselect, %src.addr.1028.case.3 ], [ undef, %src.addr.926.exit ]
  store i1 %185, i1* %dst.addr.1029, align 1
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 11
  switch i64 %for.loop.idx99, label %src.addr.1130.exit [
    i64 0, label %src.addr.1130.case.0
    i64 1, label %src.addr.1130.case.1
    i64 2, label %src.addr.1130.case.2
    i64 3, label %src.addr.1130.case.3
  ]

src.addr.1130.case.0:                             ; preds = %src.addr.1028.exit
  %186 = bitcast i214* %src_0 to i216*
  %187 = load i216, i216* %186
  %188 = trunc i216 %187 to i214
  %189 = lshr i214 %188, 149
  %_041.partselect = trunc i214 %189 to i32
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %190 = bitcast i214* %src_1 to i216*
  %191 = load i216, i216* %190
  %192 = trunc i216 %191 to i214
  %193 = lshr i214 %192, 149
  %_142.partselect = trunc i214 %193 to i32
  br label %src.addr.1130.exit

src.addr.1130.case.2:                             ; preds = %src.addr.1028.exit
  %194 = bitcast i214* %src_2 to i216*
  %195 = load i216, i216* %194
  %196 = trunc i216 %195 to i214
  %197 = lshr i214 %196, 149
  %_243.partselect = trunc i214 %197 to i32
  br label %src.addr.1130.exit

src.addr.1130.case.3:                             ; preds = %src.addr.1028.exit
  %198 = bitcast i214* %src_3 to i216*
  %199 = load i216, i216* %198
  %200 = trunc i216 %199 to i214
  %201 = lshr i214 %200, 149
  %_344.partselect = trunc i214 %201 to i32
  br label %src.addr.1130.exit

src.addr.1130.exit:                               ; preds = %src.addr.1130.case.3, %src.addr.1130.case.2, %src.addr.1130.case.1, %src.addr.1130.case.0, %src.addr.1028.exit
  %202 = phi i32 [ %_041.partselect, %src.addr.1130.case.0 ], [ %_142.partselect, %src.addr.1130.case.1 ], [ %_243.partselect, %src.addr.1130.case.2 ], [ %_344.partselect, %src.addr.1130.case.3 ], [ undef, %src.addr.1028.exit ]
  store i32 %202, i32* %dst.addr.1131, align 4
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 12
  switch i64 %for.loop.idx99, label %src.addr.1232.exit [
    i64 0, label %src.addr.1232.case.0
    i64 1, label %src.addr.1232.case.1
    i64 2, label %src.addr.1232.case.2
    i64 3, label %src.addr.1232.case.3
  ]

src.addr.1232.case.0:                             ; preds = %src.addr.1130.exit
  %203 = bitcast i214* %src_0 to i216*
  %204 = load i216, i216* %203
  %205 = trunc i216 %204 to i214
  %206 = lshr i214 %205, 181
  %_045.partselect = trunc i214 %206 to i1
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %207 = bitcast i214* %src_1 to i216*
  %208 = load i216, i216* %207
  %209 = trunc i216 %208 to i214
  %210 = lshr i214 %209, 181
  %_146.partselect = trunc i214 %210 to i1
  br label %src.addr.1232.exit

src.addr.1232.case.2:                             ; preds = %src.addr.1130.exit
  %211 = bitcast i214* %src_2 to i216*
  %212 = load i216, i216* %211
  %213 = trunc i216 %212 to i214
  %214 = lshr i214 %213, 181
  %_247.partselect = trunc i214 %214 to i1
  br label %src.addr.1232.exit

src.addr.1232.case.3:                             ; preds = %src.addr.1130.exit
  %215 = bitcast i214* %src_3 to i216*
  %216 = load i216, i216* %215
  %217 = trunc i216 %216 to i214
  %218 = lshr i214 %217, 181
  %_348.partselect = trunc i214 %218 to i1
  br label %src.addr.1232.exit

src.addr.1232.exit:                               ; preds = %src.addr.1232.case.3, %src.addr.1232.case.2, %src.addr.1232.case.1, %src.addr.1232.case.0, %src.addr.1130.exit
  %219 = phi i1 [ %_045.partselect, %src.addr.1232.case.0 ], [ %_146.partselect, %src.addr.1232.case.1 ], [ %_247.partselect, %src.addr.1232.case.2 ], [ %_348.partselect, %src.addr.1232.case.3 ], [ undef, %src.addr.1130.exit ]
  store i1 %219, i1* %dst.addr.1233, align 1
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 13
  switch i64 %for.loop.idx99, label %src.addr.1334.exit [
    i64 0, label %src.addr.1334.case.0
    i64 1, label %src.addr.1334.case.1
    i64 2, label %src.addr.1334.case.2
    i64 3, label %src.addr.1334.case.3
  ]

src.addr.1334.case.0:                             ; preds = %src.addr.1232.exit
  %220 = bitcast i214* %src_0 to i216*
  %221 = load i216, i216* %220
  %222 = trunc i216 %221 to i214
  %223 = lshr i214 %222, 182
  %_049.partselect = trunc i214 %223 to i1
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %224 = bitcast i214* %src_1 to i216*
  %225 = load i216, i216* %224
  %226 = trunc i216 %225 to i214
  %227 = lshr i214 %226, 182
  %_150.partselect = trunc i214 %227 to i1
  br label %src.addr.1334.exit

src.addr.1334.case.2:                             ; preds = %src.addr.1232.exit
  %228 = bitcast i214* %src_2 to i216*
  %229 = load i216, i216* %228
  %230 = trunc i216 %229 to i214
  %231 = lshr i214 %230, 182
  %_251.partselect = trunc i214 %231 to i1
  br label %src.addr.1334.exit

src.addr.1334.case.3:                             ; preds = %src.addr.1232.exit
  %232 = bitcast i214* %src_3 to i216*
  %233 = load i216, i216* %232
  %234 = trunc i216 %233 to i214
  %235 = lshr i214 %234, 182
  %_352.partselect = trunc i214 %235 to i1
  br label %src.addr.1334.exit

src.addr.1334.exit:                               ; preds = %src.addr.1334.case.3, %src.addr.1334.case.2, %src.addr.1334.case.1, %src.addr.1334.case.0, %src.addr.1232.exit
  %236 = phi i1 [ %_049.partselect, %src.addr.1334.case.0 ], [ %_150.partselect, %src.addr.1334.case.1 ], [ %_251.partselect, %src.addr.1334.case.2 ], [ %_352.partselect, %src.addr.1334.case.3 ], [ undef, %src.addr.1232.exit ]
  store i1 %236, i1* %dst.addr.1335, align 1
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 14
  switch i64 %for.loop.idx99, label %src.addr.1436.exit [
    i64 0, label %src.addr.1436.case.0
    i64 1, label %src.addr.1436.case.1
    i64 2, label %src.addr.1436.case.2
    i64 3, label %src.addr.1436.case.3
  ]

src.addr.1436.case.0:                             ; preds = %src.addr.1334.exit
  %237 = bitcast i214* %src_0 to i216*
  %238 = load i216, i216* %237
  %239 = trunc i216 %238 to i214
  %240 = lshr i214 %239, 183
  %_053.partselect = trunc i214 %240 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %241 = bitcast i214* %src_1 to i216*
  %242 = load i216, i216* %241
  %243 = trunc i216 %242 to i214
  %244 = lshr i214 %243, 183
  %_154.partselect = trunc i214 %244 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.2:                             ; preds = %src.addr.1334.exit
  %245 = bitcast i214* %src_2 to i216*
  %246 = load i216, i216* %245
  %247 = trunc i216 %246 to i214
  %248 = lshr i214 %247, 183
  %_255.partselect = trunc i214 %248 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.3:                             ; preds = %src.addr.1334.exit
  %249 = bitcast i214* %src_3 to i216*
  %250 = load i216, i216* %249
  %251 = trunc i216 %250 to i214
  %252 = lshr i214 %251, 183
  %_356.partselect = trunc i214 %252 to i1
  br label %src.addr.1436.exit

src.addr.1436.exit:                               ; preds = %src.addr.1436.case.3, %src.addr.1436.case.2, %src.addr.1436.case.1, %src.addr.1436.case.0, %src.addr.1334.exit
  %253 = phi i1 [ %_053.partselect, %src.addr.1436.case.0 ], [ %_154.partselect, %src.addr.1436.case.1 ], [ %_255.partselect, %src.addr.1436.case.2 ], [ %_356.partselect, %src.addr.1436.case.3 ], [ undef, %src.addr.1334.exit ]
  store i1 %253, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 15
  switch i64 %for.loop.idx99, label %src.addr.1538.exit [
    i64 0, label %src.addr.1538.case.0
    i64 1, label %src.addr.1538.case.1
    i64 2, label %src.addr.1538.case.2
    i64 3, label %src.addr.1538.case.3
  ]

src.addr.1538.case.0:                             ; preds = %src.addr.1436.exit
  %254 = bitcast i214* %src_0 to i216*
  %255 = load i216, i216* %254
  %256 = trunc i216 %255 to i214
  %257 = lshr i214 %256, 184
  %_057.partselect = trunc i214 %257 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %258 = bitcast i214* %src_1 to i216*
  %259 = load i216, i216* %258
  %260 = trunc i216 %259 to i214
  %261 = lshr i214 %260, 184
  %_158.partselect = trunc i214 %261 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.2:                             ; preds = %src.addr.1436.exit
  %262 = bitcast i214* %src_2 to i216*
  %263 = load i216, i216* %262
  %264 = trunc i216 %263 to i214
  %265 = lshr i214 %264, 184
  %_259.partselect = trunc i214 %265 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.3:                             ; preds = %src.addr.1436.exit
  %266 = bitcast i214* %src_3 to i216*
  %267 = load i216, i216* %266
  %268 = trunc i216 %267 to i214
  %269 = lshr i214 %268, 184
  %_360.partselect = trunc i214 %269 to i1
  br label %src.addr.1538.exit

src.addr.1538.exit:                               ; preds = %src.addr.1538.case.3, %src.addr.1538.case.2, %src.addr.1538.case.1, %src.addr.1538.case.0, %src.addr.1436.exit
  %270 = phi i1 [ %_057.partselect, %src.addr.1538.case.0 ], [ %_158.partselect, %src.addr.1538.case.1 ], [ %_259.partselect, %src.addr.1538.case.2 ], [ %_360.partselect, %src.addr.1538.case.3 ], [ undef, %src.addr.1436.exit ]
  store i1 %270, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 16
  switch i64 %for.loop.idx99, label %src.addr.1640.exit [
    i64 0, label %src.addr.1640.case.0
    i64 1, label %src.addr.1640.case.1
    i64 2, label %src.addr.1640.case.2
    i64 3, label %src.addr.1640.case.3
  ]

src.addr.1640.case.0:                             ; preds = %src.addr.1538.exit
  %271 = bitcast i214* %src_0 to i216*
  %272 = load i216, i216* %271
  %273 = trunc i216 %272 to i214
  %274 = lshr i214 %273, 185
  %_061.partselect = trunc i214 %274 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %275 = bitcast i214* %src_1 to i216*
  %276 = load i216, i216* %275
  %277 = trunc i216 %276 to i214
  %278 = lshr i214 %277, 185
  %_162.partselect = trunc i214 %278 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.2:                             ; preds = %src.addr.1538.exit
  %279 = bitcast i214* %src_2 to i216*
  %280 = load i216, i216* %279
  %281 = trunc i216 %280 to i214
  %282 = lshr i214 %281, 185
  %_263.partselect = trunc i214 %282 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.3:                             ; preds = %src.addr.1538.exit
  %283 = bitcast i214* %src_3 to i216*
  %284 = load i216, i216* %283
  %285 = trunc i216 %284 to i214
  %286 = lshr i214 %285, 185
  %_364.partselect = trunc i214 %286 to i1
  br label %src.addr.1640.exit

src.addr.1640.exit:                               ; preds = %src.addr.1640.case.3, %src.addr.1640.case.2, %src.addr.1640.case.1, %src.addr.1640.case.0, %src.addr.1538.exit
  %287 = phi i1 [ %_061.partselect, %src.addr.1640.case.0 ], [ %_162.partselect, %src.addr.1640.case.1 ], [ %_263.partselect, %src.addr.1640.case.2 ], [ %_364.partselect, %src.addr.1640.case.3 ], [ undef, %src.addr.1538.exit ]
  store i1 %287, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 17
  switch i64 %for.loop.idx99, label %src.addr.1742.exit [
    i64 0, label %src.addr.1742.case.0
    i64 1, label %src.addr.1742.case.1
    i64 2, label %src.addr.1742.case.2
    i64 3, label %src.addr.1742.case.3
  ]

src.addr.1742.case.0:                             ; preds = %src.addr.1640.exit
  %288 = bitcast i214* %src_0 to i216*
  %289 = load i216, i216* %288
  %290 = trunc i216 %289 to i214
  %291 = lshr i214 %290, 186
  %_065.partselect = trunc i214 %291 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %292 = bitcast i214* %src_1 to i216*
  %293 = load i216, i216* %292
  %294 = trunc i216 %293 to i214
  %295 = lshr i214 %294, 186
  %_166.partselect = trunc i214 %295 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.2:                             ; preds = %src.addr.1640.exit
  %296 = bitcast i214* %src_2 to i216*
  %297 = load i216, i216* %296
  %298 = trunc i216 %297 to i214
  %299 = lshr i214 %298, 186
  %_267.partselect = trunc i214 %299 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.3:                             ; preds = %src.addr.1640.exit
  %300 = bitcast i214* %src_3 to i216*
  %301 = load i216, i216* %300
  %302 = trunc i216 %301 to i214
  %303 = lshr i214 %302, 186
  %_368.partselect = trunc i214 %303 to i1
  br label %src.addr.1742.exit

src.addr.1742.exit:                               ; preds = %src.addr.1742.case.3, %src.addr.1742.case.2, %src.addr.1742.case.1, %src.addr.1742.case.0, %src.addr.1640.exit
  %304 = phi i1 [ %_065.partselect, %src.addr.1742.case.0 ], [ %_166.partselect, %src.addr.1742.case.1 ], [ %_267.partselect, %src.addr.1742.case.2 ], [ %_368.partselect, %src.addr.1742.case.3 ], [ undef, %src.addr.1640.exit ]
  store i1 %304, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 18
  switch i64 %for.loop.idx99, label %src.addr.1844.exit [
    i64 0, label %src.addr.1844.case.0
    i64 1, label %src.addr.1844.case.1
    i64 2, label %src.addr.1844.case.2
    i64 3, label %src.addr.1844.case.3
  ]

src.addr.1844.case.0:                             ; preds = %src.addr.1742.exit
  %305 = bitcast i214* %src_0 to i216*
  %306 = load i216, i216* %305
  %307 = trunc i216 %306 to i214
  %308 = lshr i214 %307, 187
  %_069.partselect = trunc i214 %308 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %309 = bitcast i214* %src_1 to i216*
  %310 = load i216, i216* %309
  %311 = trunc i216 %310 to i214
  %312 = lshr i214 %311, 187
  %_170.partselect = trunc i214 %312 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.2:                             ; preds = %src.addr.1742.exit
  %313 = bitcast i214* %src_2 to i216*
  %314 = load i216, i216* %313
  %315 = trunc i216 %314 to i214
  %316 = lshr i214 %315, 187
  %_271.partselect = trunc i214 %316 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.3:                             ; preds = %src.addr.1742.exit
  %317 = bitcast i214* %src_3 to i216*
  %318 = load i216, i216* %317
  %319 = trunc i216 %318 to i214
  %320 = lshr i214 %319, 187
  %_372.partselect = trunc i214 %320 to i1
  br label %src.addr.1844.exit

src.addr.1844.exit:                               ; preds = %src.addr.1844.case.3, %src.addr.1844.case.2, %src.addr.1844.case.1, %src.addr.1844.case.0, %src.addr.1742.exit
  %321 = phi i1 [ %_069.partselect, %src.addr.1844.case.0 ], [ %_170.partselect, %src.addr.1844.case.1 ], [ %_271.partselect, %src.addr.1844.case.2 ], [ %_372.partselect, %src.addr.1844.case.3 ], [ undef, %src.addr.1742.exit ]
  store i1 %321, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 19
  switch i64 %for.loop.idx99, label %src.addr.1946.exit [
    i64 0, label %src.addr.1946.case.0
    i64 1, label %src.addr.1946.case.1
    i64 2, label %src.addr.1946.case.2
    i64 3, label %src.addr.1946.case.3
  ]

src.addr.1946.case.0:                             ; preds = %src.addr.1844.exit
  %322 = bitcast i214* %src_0 to i216*
  %323 = load i216, i216* %322
  %324 = trunc i216 %323 to i214
  %325 = lshr i214 %324, 188
  %_073.partselect = trunc i214 %325 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %326 = bitcast i214* %src_1 to i216*
  %327 = load i216, i216* %326
  %328 = trunc i216 %327 to i214
  %329 = lshr i214 %328, 188
  %_174.partselect = trunc i214 %329 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.2:                             ; preds = %src.addr.1844.exit
  %330 = bitcast i214* %src_2 to i216*
  %331 = load i216, i216* %330
  %332 = trunc i216 %331 to i214
  %333 = lshr i214 %332, 188
  %_275.partselect = trunc i214 %333 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.3:                             ; preds = %src.addr.1844.exit
  %334 = bitcast i214* %src_3 to i216*
  %335 = load i216, i216* %334
  %336 = trunc i216 %335 to i214
  %337 = lshr i214 %336, 188
  %_376.partselect = trunc i214 %337 to i1
  br label %src.addr.1946.exit

src.addr.1946.exit:                               ; preds = %src.addr.1946.case.3, %src.addr.1946.case.2, %src.addr.1946.case.1, %src.addr.1946.case.0, %src.addr.1844.exit
  %338 = phi i1 [ %_073.partselect, %src.addr.1946.case.0 ], [ %_174.partselect, %src.addr.1946.case.1 ], [ %_275.partselect, %src.addr.1946.case.2 ], [ %_376.partselect, %src.addr.1946.case.3 ], [ undef, %src.addr.1844.exit ]
  store i1 %338, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 20
  switch i64 %for.loop.idx99, label %src.addr.2048.exit [
    i64 0, label %src.addr.2048.case.0
    i64 1, label %src.addr.2048.case.1
    i64 2, label %src.addr.2048.case.2
    i64 3, label %src.addr.2048.case.3
  ]

src.addr.2048.case.0:                             ; preds = %src.addr.1946.exit
  %339 = bitcast i214* %src_0 to i216*
  %340 = load i216, i216* %339
  %341 = trunc i216 %340 to i214
  %342 = lshr i214 %341, 189
  %_077.partselect = trunc i214 %342 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %343 = bitcast i214* %src_1 to i216*
  %344 = load i216, i216* %343
  %345 = trunc i216 %344 to i214
  %346 = lshr i214 %345, 189
  %_178.partselect = trunc i214 %346 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.2:                             ; preds = %src.addr.1946.exit
  %347 = bitcast i214* %src_2 to i216*
  %348 = load i216, i216* %347
  %349 = trunc i216 %348 to i214
  %350 = lshr i214 %349, 189
  %_279.partselect = trunc i214 %350 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.3:                             ; preds = %src.addr.1946.exit
  %351 = bitcast i214* %src_3 to i216*
  %352 = load i216, i216* %351
  %353 = trunc i216 %352 to i214
  %354 = lshr i214 %353, 189
  %_380.partselect = trunc i214 %354 to i1
  br label %src.addr.2048.exit

src.addr.2048.exit:                               ; preds = %src.addr.2048.case.3, %src.addr.2048.case.2, %src.addr.2048.case.1, %src.addr.2048.case.0, %src.addr.1946.exit
  %355 = phi i1 [ %_077.partselect, %src.addr.2048.case.0 ], [ %_178.partselect, %src.addr.2048.case.1 ], [ %_279.partselect, %src.addr.2048.case.2 ], [ %_380.partselect, %src.addr.2048.case.3 ], [ undef, %src.addr.1946.exit ]
  store i1 %355, i1* %dst.addr.2049, align 1
  %dst.addr.2151 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 21
  switch i64 %for.loop.idx99, label %src.addr.2150.exit [
    i64 0, label %src.addr.2150.case.0
    i64 1, label %src.addr.2150.case.1
    i64 2, label %src.addr.2150.case.2
    i64 3, label %src.addr.2150.case.3
  ]

src.addr.2150.case.0:                             ; preds = %src.addr.2048.exit
  %356 = bitcast i214* %src_0 to i216*
  %357 = load i216, i216* %356
  %358 = trunc i216 %357 to i214
  %359 = lshr i214 %358, 190
  %_081.partselect = trunc i214 %359 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.1:                             ; preds = %src.addr.2048.exit
  %360 = bitcast i214* %src_1 to i216*
  %361 = load i216, i216* %360
  %362 = trunc i216 %361 to i214
  %363 = lshr i214 %362, 190
  %_182.partselect = trunc i214 %363 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.2:                             ; preds = %src.addr.2048.exit
  %364 = bitcast i214* %src_2 to i216*
  %365 = load i216, i216* %364
  %366 = trunc i216 %365 to i214
  %367 = lshr i214 %366, 190
  %_283.partselect = trunc i214 %367 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.3:                             ; preds = %src.addr.2048.exit
  %368 = bitcast i214* %src_3 to i216*
  %369 = load i216, i216* %368
  %370 = trunc i216 %369 to i214
  %371 = lshr i214 %370, 190
  %_384.partselect = trunc i214 %371 to i1
  br label %src.addr.2150.exit

src.addr.2150.exit:                               ; preds = %src.addr.2150.case.3, %src.addr.2150.case.2, %src.addr.2150.case.1, %src.addr.2150.case.0, %src.addr.2048.exit
  %372 = phi i1 [ %_081.partselect, %src.addr.2150.case.0 ], [ %_182.partselect, %src.addr.2150.case.1 ], [ %_283.partselect, %src.addr.2150.case.2 ], [ %_384.partselect, %src.addr.2150.case.3 ], [ undef, %src.addr.2048.exit ]
  store i1 %372, i1* %dst.addr.2151, align 1
  %dst.addr.2253 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 22
  switch i64 %for.loop.idx99, label %src.addr.2252.exit [
    i64 0, label %src.addr.2252.case.0
    i64 1, label %src.addr.2252.case.1
    i64 2, label %src.addr.2252.case.2
    i64 3, label %src.addr.2252.case.3
  ]

src.addr.2252.case.0:                             ; preds = %src.addr.2150.exit
  %373 = bitcast i214* %src_0 to i216*
  %374 = load i216, i216* %373
  %375 = trunc i216 %374 to i214
  %376 = lshr i214 %375, 191
  %_085.partselect = trunc i214 %376 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.1:                             ; preds = %src.addr.2150.exit
  %377 = bitcast i214* %src_1 to i216*
  %378 = load i216, i216* %377
  %379 = trunc i216 %378 to i214
  %380 = lshr i214 %379, 191
  %_186.partselect = trunc i214 %380 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.2:                             ; preds = %src.addr.2150.exit
  %381 = bitcast i214* %src_2 to i216*
  %382 = load i216, i216* %381
  %383 = trunc i216 %382 to i214
  %384 = lshr i214 %383, 191
  %_287.partselect = trunc i214 %384 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.3:                             ; preds = %src.addr.2150.exit
  %385 = bitcast i214* %src_3 to i216*
  %386 = load i216, i216* %385
  %387 = trunc i216 %386 to i214
  %388 = lshr i214 %387, 191
  %_388.partselect = trunc i214 %388 to i1
  br label %src.addr.2252.exit

src.addr.2252.exit:                               ; preds = %src.addr.2252.case.3, %src.addr.2252.case.2, %src.addr.2252.case.1, %src.addr.2252.case.0, %src.addr.2150.exit
  %389 = phi i1 [ %_085.partselect, %src.addr.2252.case.0 ], [ %_186.partselect, %src.addr.2252.case.1 ], [ %_287.partselect, %src.addr.2252.case.2 ], [ %_388.partselect, %src.addr.2252.case.3 ], [ undef, %src.addr.2150.exit ]
  store i1 %389, i1* %dst.addr.2253, align 1
  %dst.addr.2355 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 23
  switch i64 %for.loop.idx99, label %src.addr.2354.exit [
    i64 0, label %src.addr.2354.case.0
    i64 1, label %src.addr.2354.case.1
    i64 2, label %src.addr.2354.case.2
    i64 3, label %src.addr.2354.case.3
  ]

src.addr.2354.case.0:                             ; preds = %src.addr.2252.exit
  %390 = bitcast i214* %src_0 to i216*
  %391 = load i216, i216* %390
  %392 = trunc i216 %391 to i214
  %393 = lshr i214 %392, 192
  %_089.partselect = trunc i214 %393 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.1:                             ; preds = %src.addr.2252.exit
  %394 = bitcast i214* %src_1 to i216*
  %395 = load i216, i216* %394
  %396 = trunc i216 %395 to i214
  %397 = lshr i214 %396, 192
  %_190.partselect = trunc i214 %397 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.2:                             ; preds = %src.addr.2252.exit
  %398 = bitcast i214* %src_2 to i216*
  %399 = load i216, i216* %398
  %400 = trunc i216 %399 to i214
  %401 = lshr i214 %400, 192
  %_291.partselect = trunc i214 %401 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.3:                             ; preds = %src.addr.2252.exit
  %402 = bitcast i214* %src_3 to i216*
  %403 = load i216, i216* %402
  %404 = trunc i216 %403 to i214
  %405 = lshr i214 %404, 192
  %_392.partselect = trunc i214 %405 to i1
  br label %src.addr.2354.exit

src.addr.2354.exit:                               ; preds = %src.addr.2354.case.3, %src.addr.2354.case.2, %src.addr.2354.case.1, %src.addr.2354.case.0, %src.addr.2252.exit
  %406 = phi i1 [ %_089.partselect, %src.addr.2354.case.0 ], [ %_190.partselect, %src.addr.2354.case.1 ], [ %_291.partselect, %src.addr.2354.case.2 ], [ %_392.partselect, %src.addr.2354.case.3 ], [ undef, %src.addr.2252.exit ]
  store i1 %406, i1* %dst.addr.2355, align 1
  %dst.addr.2457 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 24
  switch i64 %for.loop.idx99, label %src.addr.2456.exit [
    i64 0, label %src.addr.2456.case.0
    i64 1, label %src.addr.2456.case.1
    i64 2, label %src.addr.2456.case.2
    i64 3, label %src.addr.2456.case.3
  ]

src.addr.2456.case.0:                             ; preds = %src.addr.2354.exit
  %407 = bitcast i214* %src_0 to i216*
  %408 = load i216, i216* %407
  %409 = trunc i216 %408 to i214
  %410 = lshr i214 %409, 193
  %_093.partselect = trunc i214 %410 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.1:                             ; preds = %src.addr.2354.exit
  %411 = bitcast i214* %src_1 to i216*
  %412 = load i216, i216* %411
  %413 = trunc i216 %412 to i214
  %414 = lshr i214 %413, 193
  %_194.partselect = trunc i214 %414 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.2:                             ; preds = %src.addr.2354.exit
  %415 = bitcast i214* %src_2 to i216*
  %416 = load i216, i216* %415
  %417 = trunc i216 %416 to i214
  %418 = lshr i214 %417, 193
  %_295.partselect = trunc i214 %418 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.3:                             ; preds = %src.addr.2354.exit
  %419 = bitcast i214* %src_3 to i216*
  %420 = load i216, i216* %419
  %421 = trunc i216 %420 to i214
  %422 = lshr i214 %421, 193
  %_396.partselect = trunc i214 %422 to i1
  br label %src.addr.2456.exit

src.addr.2456.exit:                               ; preds = %src.addr.2456.case.3, %src.addr.2456.case.2, %src.addr.2456.case.1, %src.addr.2456.case.0, %src.addr.2354.exit
  %423 = phi i1 [ %_093.partselect, %src.addr.2456.case.0 ], [ %_194.partselect, %src.addr.2456.case.1 ], [ %_295.partselect, %src.addr.2456.case.2 ], [ %_396.partselect, %src.addr.2456.case.3 ], [ undef, %src.addr.2354.exit ]
  store i1 %423, i1* %dst.addr.2457, align 1
  %dst.addr.2559 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 25
  switch i64 %for.loop.idx99, label %src.addr.2558.exit [
    i64 0, label %src.addr.2558.case.0
    i64 1, label %src.addr.2558.case.1
    i64 2, label %src.addr.2558.case.2
    i64 3, label %src.addr.2558.case.3
  ]

src.addr.2558.case.0:                             ; preds = %src.addr.2456.exit
  %424 = bitcast i214* %src_0 to i216*
  %425 = load i216, i216* %424
  %426 = trunc i216 %425 to i214
  %427 = lshr i214 %426, 194
  %_097.partselect = trunc i214 %427 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.1:                             ; preds = %src.addr.2456.exit
  %428 = bitcast i214* %src_1 to i216*
  %429 = load i216, i216* %428
  %430 = trunc i216 %429 to i214
  %431 = lshr i214 %430, 194
  %_198.partselect = trunc i214 %431 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.2:                             ; preds = %src.addr.2456.exit
  %432 = bitcast i214* %src_2 to i216*
  %433 = load i216, i216* %432
  %434 = trunc i216 %433 to i214
  %435 = lshr i214 %434, 194
  %_299.partselect = trunc i214 %435 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.3:                             ; preds = %src.addr.2456.exit
  %436 = bitcast i214* %src_3 to i216*
  %437 = load i216, i216* %436
  %438 = trunc i216 %437 to i214
  %439 = lshr i214 %438, 194
  %_3100.partselect = trunc i214 %439 to i1
  br label %src.addr.2558.exit

src.addr.2558.exit:                               ; preds = %src.addr.2558.case.3, %src.addr.2558.case.2, %src.addr.2558.case.1, %src.addr.2558.case.0, %src.addr.2456.exit
  %440 = phi i1 [ %_097.partselect, %src.addr.2558.case.0 ], [ %_198.partselect, %src.addr.2558.case.1 ], [ %_299.partselect, %src.addr.2558.case.2 ], [ %_3100.partselect, %src.addr.2558.case.3 ], [ undef, %src.addr.2456.exit ]
  store i1 %440, i1* %dst.addr.2559, align 1
  %dst.addr.2661 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 26
  switch i64 %for.loop.idx99, label %src.addr.2660.exit [
    i64 0, label %src.addr.2660.case.0
    i64 1, label %src.addr.2660.case.1
    i64 2, label %src.addr.2660.case.2
    i64 3, label %src.addr.2660.case.3
  ]

src.addr.2660.case.0:                             ; preds = %src.addr.2558.exit
  %441 = bitcast i214* %src_0 to i216*
  %442 = load i216, i216* %441
  %443 = trunc i216 %442 to i214
  %444 = lshr i214 %443, 195
  %_0101.partselect = trunc i214 %444 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.1:                             ; preds = %src.addr.2558.exit
  %445 = bitcast i214* %src_1 to i216*
  %446 = load i216, i216* %445
  %447 = trunc i216 %446 to i214
  %448 = lshr i214 %447, 195
  %_1102.partselect = trunc i214 %448 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.2:                             ; preds = %src.addr.2558.exit
  %449 = bitcast i214* %src_2 to i216*
  %450 = load i216, i216* %449
  %451 = trunc i216 %450 to i214
  %452 = lshr i214 %451, 195
  %_2103.partselect = trunc i214 %452 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.3:                             ; preds = %src.addr.2558.exit
  %453 = bitcast i214* %src_3 to i216*
  %454 = load i216, i216* %453
  %455 = trunc i216 %454 to i214
  %456 = lshr i214 %455, 195
  %_3104.partselect = trunc i214 %456 to i1
  br label %src.addr.2660.exit

src.addr.2660.exit:                               ; preds = %src.addr.2660.case.3, %src.addr.2660.case.2, %src.addr.2660.case.1, %src.addr.2660.case.0, %src.addr.2558.exit
  %457 = phi i1 [ %_0101.partselect, %src.addr.2660.case.0 ], [ %_1102.partselect, %src.addr.2660.case.1 ], [ %_2103.partselect, %src.addr.2660.case.2 ], [ %_3104.partselect, %src.addr.2660.case.3 ], [ undef, %src.addr.2558.exit ]
  store i1 %457, i1* %dst.addr.2661, align 1
  %dst.addr.2763 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 27
  switch i64 %for.loop.idx99, label %src.addr.2762.exit [
    i64 0, label %src.addr.2762.case.0
    i64 1, label %src.addr.2762.case.1
    i64 2, label %src.addr.2762.case.2
    i64 3, label %src.addr.2762.case.3
  ]

src.addr.2762.case.0:                             ; preds = %src.addr.2660.exit
  %458 = bitcast i214* %src_0 to i216*
  %459 = load i216, i216* %458
  %460 = trunc i216 %459 to i214
  %461 = lshr i214 %460, 196
  %_0105.partselect = trunc i214 %461 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.1:                             ; preds = %src.addr.2660.exit
  %462 = bitcast i214* %src_1 to i216*
  %463 = load i216, i216* %462
  %464 = trunc i216 %463 to i214
  %465 = lshr i214 %464, 196
  %_1106.partselect = trunc i214 %465 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.2:                             ; preds = %src.addr.2660.exit
  %466 = bitcast i214* %src_2 to i216*
  %467 = load i216, i216* %466
  %468 = trunc i216 %467 to i214
  %469 = lshr i214 %468, 196
  %_2107.partselect = trunc i214 %469 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.3:                             ; preds = %src.addr.2660.exit
  %470 = bitcast i214* %src_3 to i216*
  %471 = load i216, i216* %470
  %472 = trunc i216 %471 to i214
  %473 = lshr i214 %472, 196
  %_3108.partselect = trunc i214 %473 to i1
  br label %src.addr.2762.exit

src.addr.2762.exit:                               ; preds = %src.addr.2762.case.3, %src.addr.2762.case.2, %src.addr.2762.case.1, %src.addr.2762.case.0, %src.addr.2660.exit
  %474 = phi i1 [ %_0105.partselect, %src.addr.2762.case.0 ], [ %_1106.partselect, %src.addr.2762.case.1 ], [ %_2107.partselect, %src.addr.2762.case.2 ], [ %_3108.partselect, %src.addr.2762.case.3 ], [ undef, %src.addr.2660.exit ]
  store i1 %474, i1* %dst.addr.2763, align 1
  %dst.addr.2865 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 28
  switch i64 %for.loop.idx99, label %src.addr.2864.exit [
    i64 0, label %src.addr.2864.case.0
    i64 1, label %src.addr.2864.case.1
    i64 2, label %src.addr.2864.case.2
    i64 3, label %src.addr.2864.case.3
  ]

src.addr.2864.case.0:                             ; preds = %src.addr.2762.exit
  %475 = bitcast i214* %src_0 to i216*
  %476 = load i216, i216* %475
  %477 = trunc i216 %476 to i214
  %478 = lshr i214 %477, 197
  %_0109.partselect = trunc i214 %478 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.1:                             ; preds = %src.addr.2762.exit
  %479 = bitcast i214* %src_1 to i216*
  %480 = load i216, i216* %479
  %481 = trunc i216 %480 to i214
  %482 = lshr i214 %481, 197
  %_1110.partselect = trunc i214 %482 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.2:                             ; preds = %src.addr.2762.exit
  %483 = bitcast i214* %src_2 to i216*
  %484 = load i216, i216* %483
  %485 = trunc i216 %484 to i214
  %486 = lshr i214 %485, 197
  %_2111.partselect = trunc i214 %486 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.3:                             ; preds = %src.addr.2762.exit
  %487 = bitcast i214* %src_3 to i216*
  %488 = load i216, i216* %487
  %489 = trunc i216 %488 to i214
  %490 = lshr i214 %489, 197
  %_3112.partselect = trunc i214 %490 to i1
  br label %src.addr.2864.exit

src.addr.2864.exit:                               ; preds = %src.addr.2864.case.3, %src.addr.2864.case.2, %src.addr.2864.case.1, %src.addr.2864.case.0, %src.addr.2762.exit
  %491 = phi i1 [ %_0109.partselect, %src.addr.2864.case.0 ], [ %_1110.partselect, %src.addr.2864.case.1 ], [ %_2111.partselect, %src.addr.2864.case.2 ], [ %_3112.partselect, %src.addr.2864.case.3 ], [ undef, %src.addr.2762.exit ]
  store i1 %491, i1* %dst.addr.2865, align 1
  %dst.addr.2967 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 29
  switch i64 %for.loop.idx99, label %src.addr.2966.exit [
    i64 0, label %src.addr.2966.case.0
    i64 1, label %src.addr.2966.case.1
    i64 2, label %src.addr.2966.case.2
    i64 3, label %src.addr.2966.case.3
  ]

src.addr.2966.case.0:                             ; preds = %src.addr.2864.exit
  %492 = bitcast i214* %src_0 to i216*
  %493 = load i216, i216* %492
  %494 = trunc i216 %493 to i214
  %495 = lshr i214 %494, 198
  %_0113.partselect = trunc i214 %495 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.1:                             ; preds = %src.addr.2864.exit
  %496 = bitcast i214* %src_1 to i216*
  %497 = load i216, i216* %496
  %498 = trunc i216 %497 to i214
  %499 = lshr i214 %498, 198
  %_1114.partselect = trunc i214 %499 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.2:                             ; preds = %src.addr.2864.exit
  %500 = bitcast i214* %src_2 to i216*
  %501 = load i216, i216* %500
  %502 = trunc i216 %501 to i214
  %503 = lshr i214 %502, 198
  %_2115.partselect = trunc i214 %503 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.3:                             ; preds = %src.addr.2864.exit
  %504 = bitcast i214* %src_3 to i216*
  %505 = load i216, i216* %504
  %506 = trunc i216 %505 to i214
  %507 = lshr i214 %506, 198
  %_3116.partselect = trunc i214 %507 to i1
  br label %src.addr.2966.exit

src.addr.2966.exit:                               ; preds = %src.addr.2966.case.3, %src.addr.2966.case.2, %src.addr.2966.case.1, %src.addr.2966.case.0, %src.addr.2864.exit
  %508 = phi i1 [ %_0113.partselect, %src.addr.2966.case.0 ], [ %_1114.partselect, %src.addr.2966.case.1 ], [ %_2115.partselect, %src.addr.2966.case.2 ], [ %_3116.partselect, %src.addr.2966.case.3 ], [ undef, %src.addr.2864.exit ]
  store i1 %508, i1* %dst.addr.2967, align 1
  %dst.addr.3069 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 30
  switch i64 %for.loop.idx99, label %src.addr.3068.exit [
    i64 0, label %src.addr.3068.case.0
    i64 1, label %src.addr.3068.case.1
    i64 2, label %src.addr.3068.case.2
    i64 3, label %src.addr.3068.case.3
  ]

src.addr.3068.case.0:                             ; preds = %src.addr.2966.exit
  %509 = bitcast i214* %src_0 to i216*
  %510 = load i216, i216* %509
  %511 = trunc i216 %510 to i214
  %512 = lshr i214 %511, 199
  %_0117.partselect = trunc i214 %512 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.1:                             ; preds = %src.addr.2966.exit
  %513 = bitcast i214* %src_1 to i216*
  %514 = load i216, i216* %513
  %515 = trunc i216 %514 to i214
  %516 = lshr i214 %515, 199
  %_1118.partselect = trunc i214 %516 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.2:                             ; preds = %src.addr.2966.exit
  %517 = bitcast i214* %src_2 to i216*
  %518 = load i216, i216* %517
  %519 = trunc i216 %518 to i214
  %520 = lshr i214 %519, 199
  %_2119.partselect = trunc i214 %520 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.3:                             ; preds = %src.addr.2966.exit
  %521 = bitcast i214* %src_3 to i216*
  %522 = load i216, i216* %521
  %523 = trunc i216 %522 to i214
  %524 = lshr i214 %523, 199
  %_3120.partselect = trunc i214 %524 to i1
  br label %src.addr.3068.exit

src.addr.3068.exit:                               ; preds = %src.addr.3068.case.3, %src.addr.3068.case.2, %src.addr.3068.case.1, %src.addr.3068.case.0, %src.addr.2966.exit
  %525 = phi i1 [ %_0117.partselect, %src.addr.3068.case.0 ], [ %_1118.partselect, %src.addr.3068.case.1 ], [ %_2119.partselect, %src.addr.3068.case.2 ], [ %_3120.partselect, %src.addr.3068.case.3 ], [ undef, %src.addr.2966.exit ]
  store i1 %525, i1* %dst.addr.3069, align 1
  %dst.addr.3171 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 31
  switch i64 %for.loop.idx99, label %src.addr.3170.exit [
    i64 0, label %src.addr.3170.case.0
    i64 1, label %src.addr.3170.case.1
    i64 2, label %src.addr.3170.case.2
    i64 3, label %src.addr.3170.case.3
  ]

src.addr.3170.case.0:                             ; preds = %src.addr.3068.exit
  %526 = bitcast i214* %src_0 to i216*
  %527 = load i216, i216* %526
  %528 = trunc i216 %527 to i214
  %529 = lshr i214 %528, 200
  %_0121.partselect = trunc i214 %529 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.1:                             ; preds = %src.addr.3068.exit
  %530 = bitcast i214* %src_1 to i216*
  %531 = load i216, i216* %530
  %532 = trunc i216 %531 to i214
  %533 = lshr i214 %532, 200
  %_1122.partselect = trunc i214 %533 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.2:                             ; preds = %src.addr.3068.exit
  %534 = bitcast i214* %src_2 to i216*
  %535 = load i216, i216* %534
  %536 = trunc i216 %535 to i214
  %537 = lshr i214 %536, 200
  %_2123.partselect = trunc i214 %537 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.3:                             ; preds = %src.addr.3068.exit
  %538 = bitcast i214* %src_3 to i216*
  %539 = load i216, i216* %538
  %540 = trunc i216 %539 to i214
  %541 = lshr i214 %540, 200
  %_3124.partselect = trunc i214 %541 to i1
  br label %src.addr.3170.exit

src.addr.3170.exit:                               ; preds = %src.addr.3170.case.3, %src.addr.3170.case.2, %src.addr.3170.case.1, %src.addr.3170.case.0, %src.addr.3068.exit
  %542 = phi i1 [ %_0121.partselect, %src.addr.3170.case.0 ], [ %_1122.partselect, %src.addr.3170.case.1 ], [ %_2123.partselect, %src.addr.3170.case.2 ], [ %_3124.partselect, %src.addr.3170.case.3 ], [ undef, %src.addr.3068.exit ]
  store i1 %542, i1* %dst.addr.3171, align 1
  %dst.addr.3273 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 32
  switch i64 %for.loop.idx99, label %src.addr.3272.exit [
    i64 0, label %src.addr.3272.case.0
    i64 1, label %src.addr.3272.case.1
    i64 2, label %src.addr.3272.case.2
    i64 3, label %src.addr.3272.case.3
  ]

src.addr.3272.case.0:                             ; preds = %src.addr.3170.exit
  %543 = bitcast i214* %src_0 to i216*
  %544 = load i216, i216* %543
  %545 = trunc i216 %544 to i214
  %546 = lshr i214 %545, 201
  %_0125.partselect = trunc i214 %546 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.1:                             ; preds = %src.addr.3170.exit
  %547 = bitcast i214* %src_1 to i216*
  %548 = load i216, i216* %547
  %549 = trunc i216 %548 to i214
  %550 = lshr i214 %549, 201
  %_1126.partselect = trunc i214 %550 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.2:                             ; preds = %src.addr.3170.exit
  %551 = bitcast i214* %src_2 to i216*
  %552 = load i216, i216* %551
  %553 = trunc i216 %552 to i214
  %554 = lshr i214 %553, 201
  %_2127.partselect = trunc i214 %554 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.3:                             ; preds = %src.addr.3170.exit
  %555 = bitcast i214* %src_3 to i216*
  %556 = load i216, i216* %555
  %557 = trunc i216 %556 to i214
  %558 = lshr i214 %557, 201
  %_3128.partselect = trunc i214 %558 to i1
  br label %src.addr.3272.exit

src.addr.3272.exit:                               ; preds = %src.addr.3272.case.3, %src.addr.3272.case.2, %src.addr.3272.case.1, %src.addr.3272.case.0, %src.addr.3170.exit
  %559 = phi i1 [ %_0125.partselect, %src.addr.3272.case.0 ], [ %_1126.partselect, %src.addr.3272.case.1 ], [ %_2127.partselect, %src.addr.3272.case.2 ], [ %_3128.partselect, %src.addr.3272.case.3 ], [ undef, %src.addr.3170.exit ]
  store i1 %559, i1* %dst.addr.3273, align 1
  %dst.addr.3375 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 33
  switch i64 %for.loop.idx99, label %src.addr.3374.exit [
    i64 0, label %src.addr.3374.case.0
    i64 1, label %src.addr.3374.case.1
    i64 2, label %src.addr.3374.case.2
    i64 3, label %src.addr.3374.case.3
  ]

src.addr.3374.case.0:                             ; preds = %src.addr.3272.exit
  %560 = bitcast i214* %src_0 to i216*
  %561 = load i216, i216* %560
  %562 = trunc i216 %561 to i214
  %563 = lshr i214 %562, 202
  %_0129.partselect = trunc i214 %563 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.1:                             ; preds = %src.addr.3272.exit
  %564 = bitcast i214* %src_1 to i216*
  %565 = load i216, i216* %564
  %566 = trunc i216 %565 to i214
  %567 = lshr i214 %566, 202
  %_1130.partselect = trunc i214 %567 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.2:                             ; preds = %src.addr.3272.exit
  %568 = bitcast i214* %src_2 to i216*
  %569 = load i216, i216* %568
  %570 = trunc i216 %569 to i214
  %571 = lshr i214 %570, 202
  %_2131.partselect = trunc i214 %571 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.3:                             ; preds = %src.addr.3272.exit
  %572 = bitcast i214* %src_3 to i216*
  %573 = load i216, i216* %572
  %574 = trunc i216 %573 to i214
  %575 = lshr i214 %574, 202
  %_3132.partselect = trunc i214 %575 to i1
  br label %src.addr.3374.exit

src.addr.3374.exit:                               ; preds = %src.addr.3374.case.3, %src.addr.3374.case.2, %src.addr.3374.case.1, %src.addr.3374.case.0, %src.addr.3272.exit
  %576 = phi i1 [ %_0129.partselect, %src.addr.3374.case.0 ], [ %_1130.partselect, %src.addr.3374.case.1 ], [ %_2131.partselect, %src.addr.3374.case.2 ], [ %_3132.partselect, %src.addr.3374.case.3 ], [ undef, %src.addr.3272.exit ]
  store i1 %576, i1* %dst.addr.3375, align 1
  %dst.addr.3477 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 34
  switch i64 %for.loop.idx99, label %src.addr.3476.exit [
    i64 0, label %src.addr.3476.case.0
    i64 1, label %src.addr.3476.case.1
    i64 2, label %src.addr.3476.case.2
    i64 3, label %src.addr.3476.case.3
  ]

src.addr.3476.case.0:                             ; preds = %src.addr.3374.exit
  %577 = bitcast i214* %src_0 to i216*
  %578 = load i216, i216* %577
  %579 = trunc i216 %578 to i214
  %580 = lshr i214 %579, 203
  %_0133.partselect = trunc i214 %580 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.1:                             ; preds = %src.addr.3374.exit
  %581 = bitcast i214* %src_1 to i216*
  %582 = load i216, i216* %581
  %583 = trunc i216 %582 to i214
  %584 = lshr i214 %583, 203
  %_1134.partselect = trunc i214 %584 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.2:                             ; preds = %src.addr.3374.exit
  %585 = bitcast i214* %src_2 to i216*
  %586 = load i216, i216* %585
  %587 = trunc i216 %586 to i214
  %588 = lshr i214 %587, 203
  %_2135.partselect = trunc i214 %588 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.3:                             ; preds = %src.addr.3374.exit
  %589 = bitcast i214* %src_3 to i216*
  %590 = load i216, i216* %589
  %591 = trunc i216 %590 to i214
  %592 = lshr i214 %591, 203
  %_3136.partselect = trunc i214 %592 to i1
  br label %src.addr.3476.exit

src.addr.3476.exit:                               ; preds = %src.addr.3476.case.3, %src.addr.3476.case.2, %src.addr.3476.case.1, %src.addr.3476.case.0, %src.addr.3374.exit
  %593 = phi i1 [ %_0133.partselect, %src.addr.3476.case.0 ], [ %_1134.partselect, %src.addr.3476.case.1 ], [ %_2135.partselect, %src.addr.3476.case.2 ], [ %_3136.partselect, %src.addr.3476.case.3 ], [ undef, %src.addr.3374.exit ]
  store i1 %593, i1* %dst.addr.3477, align 1
  %dst.addr.3579 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 35
  switch i64 %for.loop.idx99, label %src.addr.3578.exit [
    i64 0, label %src.addr.3578.case.0
    i64 1, label %src.addr.3578.case.1
    i64 2, label %src.addr.3578.case.2
    i64 3, label %src.addr.3578.case.3
  ]

src.addr.3578.case.0:                             ; preds = %src.addr.3476.exit
  %594 = bitcast i214* %src_0 to i216*
  %595 = load i216, i216* %594
  %596 = trunc i216 %595 to i214
  %597 = lshr i214 %596, 204
  %_0137.partselect = trunc i214 %597 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.1:                             ; preds = %src.addr.3476.exit
  %598 = bitcast i214* %src_1 to i216*
  %599 = load i216, i216* %598
  %600 = trunc i216 %599 to i214
  %601 = lshr i214 %600, 204
  %_1138.partselect = trunc i214 %601 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.2:                             ; preds = %src.addr.3476.exit
  %602 = bitcast i214* %src_2 to i216*
  %603 = load i216, i216* %602
  %604 = trunc i216 %603 to i214
  %605 = lshr i214 %604, 204
  %_2139.partselect = trunc i214 %605 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.3:                             ; preds = %src.addr.3476.exit
  %606 = bitcast i214* %src_3 to i216*
  %607 = load i216, i216* %606
  %608 = trunc i216 %607 to i214
  %609 = lshr i214 %608, 204
  %_3140.partselect = trunc i214 %609 to i1
  br label %src.addr.3578.exit

src.addr.3578.exit:                               ; preds = %src.addr.3578.case.3, %src.addr.3578.case.2, %src.addr.3578.case.1, %src.addr.3578.case.0, %src.addr.3476.exit
  %610 = phi i1 [ %_0137.partselect, %src.addr.3578.case.0 ], [ %_1138.partselect, %src.addr.3578.case.1 ], [ %_2139.partselect, %src.addr.3578.case.2 ], [ %_3140.partselect, %src.addr.3578.case.3 ], [ undef, %src.addr.3476.exit ]
  store i1 %610, i1* %dst.addr.3579, align 1
  %dst.addr.3681 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 36
  switch i64 %for.loop.idx99, label %src.addr.3680.exit [
    i64 0, label %src.addr.3680.case.0
    i64 1, label %src.addr.3680.case.1
    i64 2, label %src.addr.3680.case.2
    i64 3, label %src.addr.3680.case.3
  ]

src.addr.3680.case.0:                             ; preds = %src.addr.3578.exit
  %611 = bitcast i214* %src_0 to i216*
  %612 = load i216, i216* %611
  %613 = trunc i216 %612 to i214
  %614 = lshr i214 %613, 205
  %_0141.partselect = trunc i214 %614 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.1:                             ; preds = %src.addr.3578.exit
  %615 = bitcast i214* %src_1 to i216*
  %616 = load i216, i216* %615
  %617 = trunc i216 %616 to i214
  %618 = lshr i214 %617, 205
  %_1142.partselect = trunc i214 %618 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.2:                             ; preds = %src.addr.3578.exit
  %619 = bitcast i214* %src_2 to i216*
  %620 = load i216, i216* %619
  %621 = trunc i216 %620 to i214
  %622 = lshr i214 %621, 205
  %_2143.partselect = trunc i214 %622 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.3:                             ; preds = %src.addr.3578.exit
  %623 = bitcast i214* %src_3 to i216*
  %624 = load i216, i216* %623
  %625 = trunc i216 %624 to i214
  %626 = lshr i214 %625, 205
  %_3144.partselect = trunc i214 %626 to i1
  br label %src.addr.3680.exit

src.addr.3680.exit:                               ; preds = %src.addr.3680.case.3, %src.addr.3680.case.2, %src.addr.3680.case.1, %src.addr.3680.case.0, %src.addr.3578.exit
  %627 = phi i1 [ %_0141.partselect, %src.addr.3680.case.0 ], [ %_1142.partselect, %src.addr.3680.case.1 ], [ %_2143.partselect, %src.addr.3680.case.2 ], [ %_3144.partselect, %src.addr.3680.case.3 ], [ undef, %src.addr.3578.exit ]
  store i1 %627, i1* %dst.addr.3681, align 1
  %dst.addr.3783 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 37
  switch i64 %for.loop.idx99, label %src.addr.3782.exit [
    i64 0, label %src.addr.3782.case.0
    i64 1, label %src.addr.3782.case.1
    i64 2, label %src.addr.3782.case.2
    i64 3, label %src.addr.3782.case.3
  ]

src.addr.3782.case.0:                             ; preds = %src.addr.3680.exit
  %628 = bitcast i214* %src_0 to i216*
  %629 = load i216, i216* %628
  %630 = trunc i216 %629 to i214
  %631 = lshr i214 %630, 206
  %_0145.partselect = trunc i214 %631 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.1:                             ; preds = %src.addr.3680.exit
  %632 = bitcast i214* %src_1 to i216*
  %633 = load i216, i216* %632
  %634 = trunc i216 %633 to i214
  %635 = lshr i214 %634, 206
  %_1146.partselect = trunc i214 %635 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.2:                             ; preds = %src.addr.3680.exit
  %636 = bitcast i214* %src_2 to i216*
  %637 = load i216, i216* %636
  %638 = trunc i216 %637 to i214
  %639 = lshr i214 %638, 206
  %_2147.partselect = trunc i214 %639 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.3:                             ; preds = %src.addr.3680.exit
  %640 = bitcast i214* %src_3 to i216*
  %641 = load i216, i216* %640
  %642 = trunc i216 %641 to i214
  %643 = lshr i214 %642, 206
  %_3148.partselect = trunc i214 %643 to i1
  br label %src.addr.3782.exit

src.addr.3782.exit:                               ; preds = %src.addr.3782.case.3, %src.addr.3782.case.2, %src.addr.3782.case.1, %src.addr.3782.case.0, %src.addr.3680.exit
  %644 = phi i1 [ %_0145.partselect, %src.addr.3782.case.0 ], [ %_1146.partselect, %src.addr.3782.case.1 ], [ %_2147.partselect, %src.addr.3782.case.2 ], [ %_3148.partselect, %src.addr.3782.case.3 ], [ undef, %src.addr.3680.exit ]
  store i1 %644, i1* %dst.addr.3783, align 1
  %dst.addr.3885 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 38
  switch i64 %for.loop.idx99, label %src.addr.3884.exit [
    i64 0, label %src.addr.3884.case.0
    i64 1, label %src.addr.3884.case.1
    i64 2, label %src.addr.3884.case.2
    i64 3, label %src.addr.3884.case.3
  ]

src.addr.3884.case.0:                             ; preds = %src.addr.3782.exit
  %645 = bitcast i214* %src_0 to i216*
  %646 = load i216, i216* %645
  %647 = trunc i216 %646 to i214
  %648 = lshr i214 %647, 207
  %_0149.partselect = trunc i214 %648 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.1:                             ; preds = %src.addr.3782.exit
  %649 = bitcast i214* %src_1 to i216*
  %650 = load i216, i216* %649
  %651 = trunc i216 %650 to i214
  %652 = lshr i214 %651, 207
  %_1150.partselect = trunc i214 %652 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.2:                             ; preds = %src.addr.3782.exit
  %653 = bitcast i214* %src_2 to i216*
  %654 = load i216, i216* %653
  %655 = trunc i216 %654 to i214
  %656 = lshr i214 %655, 207
  %_2151.partselect = trunc i214 %656 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.3:                             ; preds = %src.addr.3782.exit
  %657 = bitcast i214* %src_3 to i216*
  %658 = load i216, i216* %657
  %659 = trunc i216 %658 to i214
  %660 = lshr i214 %659, 207
  %_3152.partselect = trunc i214 %660 to i1
  br label %src.addr.3884.exit

src.addr.3884.exit:                               ; preds = %src.addr.3884.case.3, %src.addr.3884.case.2, %src.addr.3884.case.1, %src.addr.3884.case.0, %src.addr.3782.exit
  %661 = phi i1 [ %_0149.partselect, %src.addr.3884.case.0 ], [ %_1150.partselect, %src.addr.3884.case.1 ], [ %_2151.partselect, %src.addr.3884.case.2 ], [ %_3152.partselect, %src.addr.3884.case.3 ], [ undef, %src.addr.3782.exit ]
  store i1 %661, i1* %dst.addr.3885, align 1
  %dst.addr.3987 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 39
  switch i64 %for.loop.idx99, label %src.addr.3986.exit [
    i64 0, label %src.addr.3986.case.0
    i64 1, label %src.addr.3986.case.1
    i64 2, label %src.addr.3986.case.2
    i64 3, label %src.addr.3986.case.3
  ]

src.addr.3986.case.0:                             ; preds = %src.addr.3884.exit
  %662 = bitcast i214* %src_0 to i216*
  %663 = load i216, i216* %662
  %664 = trunc i216 %663 to i214
  %665 = lshr i214 %664, 208
  %_0153.partselect = trunc i214 %665 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.1:                             ; preds = %src.addr.3884.exit
  %666 = bitcast i214* %src_1 to i216*
  %667 = load i216, i216* %666
  %668 = trunc i216 %667 to i214
  %669 = lshr i214 %668, 208
  %_1154.partselect = trunc i214 %669 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.2:                             ; preds = %src.addr.3884.exit
  %670 = bitcast i214* %src_2 to i216*
  %671 = load i216, i216* %670
  %672 = trunc i216 %671 to i214
  %673 = lshr i214 %672, 208
  %_2155.partselect = trunc i214 %673 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.3:                             ; preds = %src.addr.3884.exit
  %674 = bitcast i214* %src_3 to i216*
  %675 = load i216, i216* %674
  %676 = trunc i216 %675 to i214
  %677 = lshr i214 %676, 208
  %_3156.partselect = trunc i214 %677 to i1
  br label %src.addr.3986.exit

src.addr.3986.exit:                               ; preds = %src.addr.3986.case.3, %src.addr.3986.case.2, %src.addr.3986.case.1, %src.addr.3986.case.0, %src.addr.3884.exit
  %678 = phi i1 [ %_0153.partselect, %src.addr.3986.case.0 ], [ %_1154.partselect, %src.addr.3986.case.1 ], [ %_2155.partselect, %src.addr.3986.case.2 ], [ %_3156.partselect, %src.addr.3986.case.3 ], [ undef, %src.addr.3884.exit ]
  store i1 %678, i1* %dst.addr.3987, align 1
  %dst.addr.4089 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 40
  switch i64 %for.loop.idx99, label %src.addr.4088.exit [
    i64 0, label %src.addr.4088.case.0
    i64 1, label %src.addr.4088.case.1
    i64 2, label %src.addr.4088.case.2
    i64 3, label %src.addr.4088.case.3
  ]

src.addr.4088.case.0:                             ; preds = %src.addr.3986.exit
  %679 = bitcast i214* %src_0 to i216*
  %680 = load i216, i216* %679
  %681 = trunc i216 %680 to i214
  %682 = lshr i214 %681, 209
  %_0157.partselect = trunc i214 %682 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.1:                             ; preds = %src.addr.3986.exit
  %683 = bitcast i214* %src_1 to i216*
  %684 = load i216, i216* %683
  %685 = trunc i216 %684 to i214
  %686 = lshr i214 %685, 209
  %_1158.partselect = trunc i214 %686 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.2:                             ; preds = %src.addr.3986.exit
  %687 = bitcast i214* %src_2 to i216*
  %688 = load i216, i216* %687
  %689 = trunc i216 %688 to i214
  %690 = lshr i214 %689, 209
  %_2159.partselect = trunc i214 %690 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.3:                             ; preds = %src.addr.3986.exit
  %691 = bitcast i214* %src_3 to i216*
  %692 = load i216, i216* %691
  %693 = trunc i216 %692 to i214
  %694 = lshr i214 %693, 209
  %_3160.partselect = trunc i214 %694 to i1
  br label %src.addr.4088.exit

src.addr.4088.exit:                               ; preds = %src.addr.4088.case.3, %src.addr.4088.case.2, %src.addr.4088.case.1, %src.addr.4088.case.0, %src.addr.3986.exit
  %695 = phi i1 [ %_0157.partselect, %src.addr.4088.case.0 ], [ %_1158.partselect, %src.addr.4088.case.1 ], [ %_2159.partselect, %src.addr.4088.case.2 ], [ %_3160.partselect, %src.addr.4088.case.3 ], [ undef, %src.addr.3986.exit ]
  store i1 %695, i1* %dst.addr.4089, align 1
  %dst.addr.4191 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 41
  switch i64 %for.loop.idx99, label %src.addr.4190.exit [
    i64 0, label %src.addr.4190.case.0
    i64 1, label %src.addr.4190.case.1
    i64 2, label %src.addr.4190.case.2
    i64 3, label %src.addr.4190.case.3
  ]

src.addr.4190.case.0:                             ; preds = %src.addr.4088.exit
  %696 = bitcast i214* %src_0 to i216*
  %697 = load i216, i216* %696
  %698 = trunc i216 %697 to i214
  %699 = lshr i214 %698, 210
  %_0161.partselect = trunc i214 %699 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.1:                             ; preds = %src.addr.4088.exit
  %700 = bitcast i214* %src_1 to i216*
  %701 = load i216, i216* %700
  %702 = trunc i216 %701 to i214
  %703 = lshr i214 %702, 210
  %_1162.partselect = trunc i214 %703 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.2:                             ; preds = %src.addr.4088.exit
  %704 = bitcast i214* %src_2 to i216*
  %705 = load i216, i216* %704
  %706 = trunc i216 %705 to i214
  %707 = lshr i214 %706, 210
  %_2163.partselect = trunc i214 %707 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.3:                             ; preds = %src.addr.4088.exit
  %708 = bitcast i214* %src_3 to i216*
  %709 = load i216, i216* %708
  %710 = trunc i216 %709 to i214
  %711 = lshr i214 %710, 210
  %_3164.partselect = trunc i214 %711 to i1
  br label %src.addr.4190.exit

src.addr.4190.exit:                               ; preds = %src.addr.4190.case.3, %src.addr.4190.case.2, %src.addr.4190.case.1, %src.addr.4190.case.0, %src.addr.4088.exit
  %712 = phi i1 [ %_0161.partselect, %src.addr.4190.case.0 ], [ %_1162.partselect, %src.addr.4190.case.1 ], [ %_2163.partselect, %src.addr.4190.case.2 ], [ %_3164.partselect, %src.addr.4190.case.3 ], [ undef, %src.addr.4088.exit ]
  store i1 %712, i1* %dst.addr.4191, align 1
  %dst.addr.4293 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 42
  switch i64 %for.loop.idx99, label %src.addr.4292.exit [
    i64 0, label %src.addr.4292.case.0
    i64 1, label %src.addr.4292.case.1
    i64 2, label %src.addr.4292.case.2
    i64 3, label %src.addr.4292.case.3
  ]

src.addr.4292.case.0:                             ; preds = %src.addr.4190.exit
  %713 = bitcast i214* %src_0 to i216*
  %714 = load i216, i216* %713
  %715 = trunc i216 %714 to i214
  %716 = lshr i214 %715, 211
  %_0165.partselect = trunc i214 %716 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.1:                             ; preds = %src.addr.4190.exit
  %717 = bitcast i214* %src_1 to i216*
  %718 = load i216, i216* %717
  %719 = trunc i216 %718 to i214
  %720 = lshr i214 %719, 211
  %_1166.partselect = trunc i214 %720 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.2:                             ; preds = %src.addr.4190.exit
  %721 = bitcast i214* %src_2 to i216*
  %722 = load i216, i216* %721
  %723 = trunc i216 %722 to i214
  %724 = lshr i214 %723, 211
  %_2167.partselect = trunc i214 %724 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.3:                             ; preds = %src.addr.4190.exit
  %725 = bitcast i214* %src_3 to i216*
  %726 = load i216, i216* %725
  %727 = trunc i216 %726 to i214
  %728 = lshr i214 %727, 211
  %_3168.partselect = trunc i214 %728 to i1
  br label %src.addr.4292.exit

src.addr.4292.exit:                               ; preds = %src.addr.4292.case.3, %src.addr.4292.case.2, %src.addr.4292.case.1, %src.addr.4292.case.0, %src.addr.4190.exit
  %729 = phi i1 [ %_0165.partselect, %src.addr.4292.case.0 ], [ %_1166.partselect, %src.addr.4292.case.1 ], [ %_2167.partselect, %src.addr.4292.case.2 ], [ %_3168.partselect, %src.addr.4292.case.3 ], [ undef, %src.addr.4190.exit ]
  store i1 %729, i1* %dst.addr.4293, align 1
  %dst.addr.4395 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 43
  switch i64 %for.loop.idx99, label %src.addr.4394.exit [
    i64 0, label %src.addr.4394.case.0
    i64 1, label %src.addr.4394.case.1
    i64 2, label %src.addr.4394.case.2
    i64 3, label %src.addr.4394.case.3
  ]

src.addr.4394.case.0:                             ; preds = %src.addr.4292.exit
  %730 = bitcast i214* %src_0 to i216*
  %731 = load i216, i216* %730
  %732 = trunc i216 %731 to i214
  %733 = lshr i214 %732, 212
  %_0169.partselect = trunc i214 %733 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.1:                             ; preds = %src.addr.4292.exit
  %734 = bitcast i214* %src_1 to i216*
  %735 = load i216, i216* %734
  %736 = trunc i216 %735 to i214
  %737 = lshr i214 %736, 212
  %_1170.partselect = trunc i214 %737 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.2:                             ; preds = %src.addr.4292.exit
  %738 = bitcast i214* %src_2 to i216*
  %739 = load i216, i216* %738
  %740 = trunc i216 %739 to i214
  %741 = lshr i214 %740, 212
  %_2171.partselect = trunc i214 %741 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.3:                             ; preds = %src.addr.4292.exit
  %742 = bitcast i214* %src_3 to i216*
  %743 = load i216, i216* %742
  %744 = trunc i216 %743 to i214
  %745 = lshr i214 %744, 212
  %_3172.partselect = trunc i214 %745 to i1
  br label %src.addr.4394.exit

src.addr.4394.exit:                               ; preds = %src.addr.4394.case.3, %src.addr.4394.case.2, %src.addr.4394.case.1, %src.addr.4394.case.0, %src.addr.4292.exit
  %746 = phi i1 [ %_0169.partselect, %src.addr.4394.case.0 ], [ %_1170.partselect, %src.addr.4394.case.1 ], [ %_2171.partselect, %src.addr.4394.case.2 ], [ %_3172.partselect, %src.addr.4394.case.3 ], [ undef, %src.addr.4292.exit ]
  store i1 %746, i1* %dst.addr.4395, align 1
  %dst.addr.4497 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 44
  switch i64 %for.loop.idx99, label %src.addr.4496.exit [
    i64 0, label %src.addr.4496.case.0
    i64 1, label %src.addr.4496.case.1
    i64 2, label %src.addr.4496.case.2
    i64 3, label %src.addr.4496.case.3
  ]

src.addr.4496.case.0:                             ; preds = %src.addr.4394.exit
  %747 = bitcast i214* %src_0 to i216*
  %748 = load i216, i216* %747
  %749 = trunc i216 %748 to i214
  %750 = lshr i214 %749, 213
  %_0173.partselect = trunc i214 %750 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.1:                             ; preds = %src.addr.4394.exit
  %751 = bitcast i214* %src_1 to i216*
  %752 = load i216, i216* %751
  %753 = trunc i216 %752 to i214
  %754 = lshr i214 %753, 213
  %_1174.partselect = trunc i214 %754 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.2:                             ; preds = %src.addr.4394.exit
  %755 = bitcast i214* %src_2 to i216*
  %756 = load i216, i216* %755
  %757 = trunc i216 %756 to i214
  %758 = lshr i214 %757, 213
  %_2175.partselect = trunc i214 %758 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.3:                             ; preds = %src.addr.4394.exit
  %759 = bitcast i214* %src_3 to i216*
  %760 = load i216, i216* %759
  %761 = trunc i216 %760 to i214
  %762 = lshr i214 %761, 213
  %_3176.partselect = trunc i214 %762 to i1
  br label %src.addr.4496.exit

src.addr.4496.exit:                               ; preds = %src.addr.4496.case.3, %src.addr.4496.case.2, %src.addr.4496.case.1, %src.addr.4496.case.0, %src.addr.4394.exit
  %763 = phi i1 [ %_0173.partselect, %src.addr.4496.case.0 ], [ %_1174.partselect, %src.addr.4496.case.1 ], [ %_2175.partselect, %src.addr.4496.case.2 ], [ %_3176.partselect, %src.addr.4496.case.3 ], [ undef, %src.addr.4394.exit ]
  store i1 %763, i1* %dst.addr.4497, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx99, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.4496.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.31.34([4 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i214* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i214* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1, i214* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.2" %src_2, i214* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.3" %src_3) #1 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i214* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.32.33([4 x %struct.HeadCtx]* nonnull %dst, i214* nonnull %src_0, i214* %src_1, i214* %src_2, i214* %src_3, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i32* noalias "orig.arg.no"="2", i32* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", [129 x i8]* noalias "orig.arg.no"="12", [129 x i8]* noalias readonly align 512 "orig.arg.no"="13", [64 x i8]* noalias "orig.arg.no"="14", [64 x i8]* noalias readonly align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="16", i214* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i214* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i214* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i214* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias "orig.arg.no"="18", i1* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21", i1* noalias "orig.arg.no"="22", i1* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias "orig.arg.no"="26", i1056* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i32* noalias "orig.arg.no"="52", i32* noalias readonly align 512 "orig.arg.no"="53", i32* noalias "orig.arg.no"="54", i32* noalias readonly align 512 "orig.arg.no"="55", i32* noalias "orig.arg.no"="56", i32* noalias readonly align 512 "orig.arg.no"="57", i1* noalias "orig.arg.no"="58", i1* noalias readonly align 512 "orig.arg.no"="59", i32* noalias "orig.arg.no"="60", i32* noalias readonly align 512 "orig.arg.no"="61", i1* noalias "orig.arg.no"="62", i1* noalias readonly align 512 "orig.arg.no"="63", i1* noalias "orig.arg.no"="64", i1* noalias readonly align 512 "orig.arg.no"="65", i8* noalias "orig.arg.no"="66", i8* noalias readonly align 512 "orig.arg.no"="67", i32* noalias "orig.arg.no"="68", i32* noalias readonly align 512 "orig.arg.no"="69", i8* noalias "orig.arg.no"="70", i8* noalias readonly align 512 "orig.arg.no"="71", i8* noalias "orig.arg.no"="72", i8* noalias readonly align 512 "orig.arg.no"="73", i8* noalias "orig.arg.no"="74", i8* noalias readonly align 512 "orig.arg.no"="75", i8* noalias "orig.arg.no"="76", i8* noalias readonly align 512 "orig.arg.no"="77", i1* noalias "orig.arg.no"="78", i1* noalias readonly align 512 "orig.arg.no"="79", i1* noalias "orig.arg.no"="80", i1* noalias readonly align 512 "orig.arg.no"="81", i1* noalias "orig.arg.no"="82", i1* noalias readonly align 512 "orig.arg.no"="83", i1* noalias "orig.arg.no"="84", i1* noalias readonly align 512 "orig.arg.no"="85", i1* noalias "orig.arg.no"="86", i1* noalias readonly align 512 "orig.arg.no"="87", i1* noalias "orig.arg.no"="88", i1* noalias readonly align 512 "orig.arg.no"="89") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %2, i32* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %8, i1* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0a129i8([129 x i8]* %12, [129 x i8]* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0a64i8([64 x i8]* %14, [64 x i8]* align 512 %15)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.31.34([4 x %struct.HeadCtx]* %16, i214* align 512 %_0, i214* align 512 %_1, i214* align 512 %_2, i214* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %17, i1* align 512 %18)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %19, i32* align 512 %20)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %21, i1* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %23, i32* align 512 %24)
  call fastcc void @onebyonecpy_hls.p0struct.ControlMemSpace.39(%struct.ControlMemSpace* %25, i1056* align 512 %26)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %27, i32* align 512 %28)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %29, i32* align 512 %30)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %31, i32* align 512 %32)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %33, i32* align 512 %34)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %35, i32* align 512 %36)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %37, i32* align 512 %38)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %39, i32* align 512 %40)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %41, i32* align 512 %42)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %43, i32* align 512 %44)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %45, i32* align 512 %46)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %47, i32* align 512 %48)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %49, i32* align 512 %50)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %51, i32* align 512 %52)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %53, i32* align 512 %54)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %55, i32* align 512 %56)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %57, i1* align 512 %58)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %59, i32* align 512 %60)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %61, i1* align 512 %62)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %63, i1* align 512 %64)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %65, i8* align 512 %66)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %67, i32* align 512 %68)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %69, i8* align 512 %70)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %71, i8* align 512 %72)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %73, i8* align 512 %74)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %75, i8* align 512 %76)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %77, i1* align 512 %78)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %79, i1* align 512 %80)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %81, i1* align 512 %82)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %83, i1* align 512 %84)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %85, i1* align 512 %86)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %87, i1* align 512 %88)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.ControlMemSpace.39(%struct.ControlMemSpace* noalias %dst, i1056* noalias readonly align 512 %src) unnamed_addr #1 {
entry:
  %0 = icmp eq %struct.ControlMemSpace* %dst, null
  %1 = icmp eq i1056* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 0
  %3 = load i1056, i1056* %src, align 512
  %.partselect32 = trunc i1056 %3 to i32
  store i32 %.partselect32, i32* %dst.0, align 512
  %dst.1 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 1
  %4 = lshr i1056 %3, 32
  %.partselect31 = trunc i1056 %4 to i32
  store i32 %.partselect31, i32* %dst.1, align 4
  %dst.2 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 2
  %5 = lshr i1056 %3, 64
  %.partselect30 = trunc i1056 %5 to i32
  store i32 %.partselect30, i32* %dst.2, align 8
  %dst.3 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 3
  %6 = lshr i1056 %3, 96
  %.partselect29 = trunc i1056 %6 to i32
  store i32 %.partselect29, i32* %dst.3, align 4
  %dst.4 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 4
  %7 = lshr i1056 %3, 128
  %.partselect28 = trunc i1056 %7 to i32
  store i32 %.partselect28, i32* %dst.4, align 16
  %dst.5 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 5
  %8 = lshr i1056 %3, 160
  %.partselect27 = trunc i1056 %8 to i32
  store i32 %.partselect27, i32* %dst.5, align 4
  %dst.6 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 6
  %9 = lshr i1056 %3, 192
  %.partselect26 = trunc i1056 %9 to i32
  store i32 %.partselect26, i32* %dst.6, align 8
  %dst.7 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 7
  %10 = lshr i1056 %3, 224
  %.partselect25 = trunc i1056 %10 to i32
  store i32 %.partselect25, i32* %dst.7, align 4
  %dst.8 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 8
  %11 = lshr i1056 %3, 256
  %.partselect24 = trunc i1056 %11 to i32
  store i32 %.partselect24, i32* %dst.8, align 32
  %dst.9 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 9
  %12 = lshr i1056 %3, 288
  %.partselect23 = trunc i1056 %12 to i32
  store i32 %.partselect23, i32* %dst.9, align 4
  %dst.10 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 10
  %13 = lshr i1056 %3, 320
  %.partselect22 = trunc i1056 %13 to i32
  store i32 %.partselect22, i32* %dst.10, align 8
  %dst.11 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 11
  %14 = lshr i1056 %3, 352
  %.partselect21 = trunc i1056 %14 to i32
  store i32 %.partselect21, i32* %dst.11, align 4
  %dst.12 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 12
  %15 = lshr i1056 %3, 384
  %.partselect20 = trunc i1056 %15 to i32
  store i32 %.partselect20, i32* %dst.12, align 16
  %dst.13 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 13
  %16 = lshr i1056 %3, 416
  %.partselect19 = trunc i1056 %16 to i32
  store i32 %.partselect19, i32* %dst.13, align 4
  %dst.14 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 14
  %17 = lshr i1056 %3, 448
  %.partselect18 = trunc i1056 %17 to i32
  store i32 %.partselect18, i32* %dst.14, align 8
  %dst.15 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 15
  %18 = lshr i1056 %3, 480
  %.partselect17 = trunc i1056 %18 to i32
  store i32 %.partselect17, i32* %dst.15, align 4
  %dst.16 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 16
  %19 = lshr i1056 %3, 512
  %.partselect16 = trunc i1056 %19 to i32
  store i32 %.partselect16, i32* %dst.16, align 64
  %dst.17 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 17
  %20 = lshr i1056 %3, 544
  %.partselect15 = trunc i1056 %20 to i32
  store i32 %.partselect15, i32* %dst.17, align 4
  %dst.18 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 18
  %21 = lshr i1056 %3, 576
  %.partselect14 = trunc i1056 %21 to i32
  store i32 %.partselect14, i32* %dst.18, align 8
  %dst.19 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 19
  %22 = lshr i1056 %3, 608
  %.partselect13 = trunc i1056 %22 to i32
  store i32 %.partselect13, i32* %dst.19, align 4
  %dst.20 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 20
  %23 = lshr i1056 %3, 640
  %.partselect12 = trunc i1056 %23 to i32
  store i32 %.partselect12, i32* %dst.20, align 16
  %dst.21 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 21
  %24 = lshr i1056 %3, 672
  %.partselect11 = trunc i1056 %24 to i32
  store i32 %.partselect11, i32* %dst.21, align 4
  %dst.22 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 22
  %25 = lshr i1056 %3, 704
  %.partselect10 = trunc i1056 %25 to i32
  store i32 %.partselect10, i32* %dst.22, align 8
  %dst.23 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 23
  %26 = lshr i1056 %3, 736
  %.partselect9 = trunc i1056 %26 to i32
  store i32 %.partselect9, i32* %dst.23, align 4
  %dst.24 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 24
  %27 = lshr i1056 %3, 768
  %.partselect8 = trunc i1056 %27 to i32
  store i32 %.partselect8, i32* %dst.24, align 32
  %dst.25 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 25
  %28 = lshr i1056 %3, 800
  %.partselect7 = trunc i1056 %28 to i32
  store i32 %.partselect7, i32* %dst.25, align 4
  %dst.26 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 26
  %29 = lshr i1056 %3, 832
  %.partselect6 = trunc i1056 %29 to i32
  store i32 %.partselect6, i32* %dst.26, align 8
  %dst.27 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 27
  %30 = lshr i1056 %3, 864
  %.partselect5 = trunc i1056 %30 to i32
  store i32 %.partselect5, i32* %dst.27, align 4
  %dst.28 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 28
  %31 = lshr i1056 %3, 896
  %.partselect4 = trunc i1056 %31 to i32
  store i32 %.partselect4, i32* %dst.28, align 16
  %dst.29 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 29
  %32 = lshr i1056 %3, 928
  %.partselect3 = trunc i1056 %32 to i32
  store i32 %.partselect3, i32* %dst.29, align 4
  %dst.30 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 30
  %33 = lshr i1056 %3, 960
  %.partselect2 = trunc i1056 %33 to i32
  store i32 %.partselect2, i32* %dst.30, align 8
  %dst.31 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 31
  %34 = lshr i1056 %3, 992
  %.partselect1 = trunc i1056 %34 to i32
  store i32 %.partselect1, i32* %dst.31, align 4
  %dst.32 = getelementptr %struct.ControlMemSpace, %struct.ControlMemSpace* %dst, i64 0, i32 32
  %35 = lshr i1056 %3, 1024
  %.partselect = trunc i1056 %35 to i32
  store i32 %.partselect, i32* %dst.32, align 128
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare void @apatb_transformer_top_hw(i1, i1, i1*, i1, i1, i32*, i1*, i1, i1*, i1*, i32*, [129 x i8]*, [64 x i8]*, i214*, i214*, i214*, i214*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i32*, i1*, i1*, i8*, i32*, i8*, i8*, i8*, i8*, i1*, i1*, i1*, i1*, i1*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i32* noalias "orig.arg.no"="2", i32* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", [129 x i8]* noalias "orig.arg.no"="12", [129 x i8]* noalias readonly align 512 "orig.arg.no"="13", [64 x i8]* noalias "orig.arg.no"="14", [64 x i8]* noalias readonly align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="16", i214* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i214* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i214* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i214* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias "orig.arg.no"="18", i1* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21", i1* noalias "orig.arg.no"="22", i1* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias "orig.arg.no"="26", i1056* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i32* noalias "orig.arg.no"="52", i32* noalias readonly align 512 "orig.arg.no"="53", i32* noalias "orig.arg.no"="54", i32* noalias readonly align 512 "orig.arg.no"="55", i32* noalias "orig.arg.no"="56", i32* noalias readonly align 512 "orig.arg.no"="57", i1* noalias "orig.arg.no"="58", i1* noalias readonly align 512 "orig.arg.no"="59", i32* noalias "orig.arg.no"="60", i32* noalias readonly align 512 "orig.arg.no"="61", i1* noalias "orig.arg.no"="62", i1* noalias readonly align 512 "orig.arg.no"="63", i1* noalias "orig.arg.no"="64", i1* noalias readonly align 512 "orig.arg.no"="65", i8* noalias "orig.arg.no"="66", i8* noalias readonly align 512 "orig.arg.no"="67", i32* noalias "orig.arg.no"="68", i32* noalias readonly align 512 "orig.arg.no"="69", i8* noalias "orig.arg.no"="70", i8* noalias readonly align 512 "orig.arg.no"="71", i8* noalias "orig.arg.no"="72", i8* noalias readonly align 512 "orig.arg.no"="73", i8* noalias "orig.arg.no"="74", i8* noalias readonly align 512 "orig.arg.no"="75", i8* noalias "orig.arg.no"="76", i8* noalias readonly align 512 "orig.arg.no"="77", i1* noalias "orig.arg.no"="78", i1* noalias readonly align 512 "orig.arg.no"="79", i1* noalias "orig.arg.no"="80", i1* noalias readonly align 512 "orig.arg.no"="81", i1* noalias "orig.arg.no"="82", i1* noalias readonly align 512 "orig.arg.no"="83", i1* noalias "orig.arg.no"="84", i1* noalias readonly align 512 "orig.arg.no"="85", i1* noalias "orig.arg.no"="86", i1* noalias readonly align 512 "orig.arg.no"="87", i1* noalias "orig.arg.no"="88", i1* noalias readonly align 512 "orig.arg.no"="89") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %2, i32* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %8, i1* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0a64i8([64 x i8]* %14, [64 x i8]* align 512 %15)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.31.34([4 x %struct.HeadCtx]* %16, i214* align 512 %_0, i214* align 512 %_1, i214* align 512 %_2, i214* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %17, i1* align 512 %18)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %19, i32* align 512 %20)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %21, i1* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %23, i32* align 512 %24)
  call fastcc void @onebyonecpy_hls.p0struct.ControlMemSpace.39(%struct.ControlMemSpace* %25, i1056* align 512 %26)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %27, i32* align 512 %28)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %29, i32* align 512 %30)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %31, i32* align 512 %32)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %33, i32* align 512 %34)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %35, i32* align 512 %36)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %37, i32* align 512 %38)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %39, i32* align 512 %40)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %41, i32* align 512 %42)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %43, i32* align 512 %44)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %45, i32* align 512 %46)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %47, i32* align 512 %48)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %49, i32* align 512 %50)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %51, i32* align 512 %52)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %53, i32* align 512 %54)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %55, i32* align 512 %56)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %57, i1* align 512 %58)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %59, i32* align 512 %60)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %61, i1* align 512 %62)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %63, i1* align 512 %64)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %65, i8* align 512 %66)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %67, i32* align 512 %68)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %69, i8* align 512 %70)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %71, i8* align 512 %72)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %73, i8* align 512 %74)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %75, i8* align 512 %76)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %77, i1* align 512 %78)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %79, i1* align 512 %80)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %81, i1* align 512 %82)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %83, i1* align 512 %84)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %85, i1* align 512 %86)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %87, i1* align 512 %88)
  ret void
}

declare void @transformer_top_hw_stub(i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i8* noalias nonnull readonly, i8* noalias nocapture nonnull, [4 x %struct.HeadCtx]* noalias nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i32, i32, i32* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, %struct.ControlMemSpace* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i8* noalias nocapture nonnull, i32* noalias nocapture nonnull, i8* noalias nocapture nonnull, i8* noalias nocapture nonnull, i8* noalias nocapture nonnull, i8* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull)

define void @transformer_top_hw_stub_wrapper(i1, i1, i1*, i1, i1, i32*, i1*, i1, i1*, i1*, i32*, [129 x i8]*, [64 x i8]*, i214*, i214*, i214*, i214*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i32*, i1*, i1*, i8*, i32*, i8*, i8*, i8*, i8*, i1*, i1*, i1*, i1*, i1*, i1*) #5 {
entry:
  %61 = call i8* @malloc(i64 256)
  %62 = bitcast i8* %61 to [4 x %struct.HeadCtx]*
  %63 = call i8* @malloc(i64 132)
  %64 = bitcast i8* %63 to %struct.ControlMemSpace*
  call void @copy_out(i1* null, i1* %2, i32* null, i32* %5, i1* null, i1* %6, i1* null, i1* %8, i1* null, i1* %9, i32* null, i32* %10, [129 x i8]* null, [129 x i8]* %11, [64 x i8]* null, [64 x i8]* %12, [4 x %struct.HeadCtx]* %62, i214* %13, i214* %14, i214* %15, i214* %16, i1* null, i1* %18, i32* null, i32* %22, i1* null, i1* %27, i32* null, i32* %28, %struct.ControlMemSpace* %64, i1056* %29, i32* null, i32* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i32* null, i32* %42, i32* null, i32* %43, i32* null, i32* %44, i1* null, i1* %45, i32* null, i32* %46, i1* null, i1* %47, i1* null, i1* %48, i8* null, i8* %49, i32* null, i32* %50, i8* null, i8* %51, i8* null, i8* %52, i8* null, i8* %53, i8* null, i8* %54, i1* null, i1* %55, i1* null, i1* %56, i1* null, i1* %57, i1* null, i1* %58, i1* null, i1* %59, i1* null, i1* %60)
  %65 = bitcast [129 x i8]* %11 to i8*
  %66 = bitcast [64 x i8]* %12 to i8*
  call void @transformer_top_hw_stub(i1 %0, i1 %1, i1* %2, i1 %3, i1 %4, i32* %5, i1* %6, i1 %7, i1* %8, i1* %9, i32* %10, i8* %65, i8* %66, [4 x %struct.HeadCtx]* %62, i1 %17, i1* %18, i1 %19, i32 %20, i32 %21, i32* %22, i1 %23, i1 %24, i1 %25, i1 %26, i1* %27, i32* %28, %struct.ControlMemSpace* %64, i32* %30, i32* %31, i32* %32, i32* %33, i32* %34, i32* %35, i32* %36, i32* %37, i32* %38, i32* %39, i32* %40, i32* %41, i32* %42, i32* %43, i32* %44, i1* %45, i32* %46, i1* %47, i1* %48, i8* %49, i32* %50, i8* %51, i8* %52, i8* %53, i8* %54, i1* %55, i1* %56, i1* %57, i1* %58, i1* %59, i1* %60)
  call void @copy_in(i1* null, i1* %2, i32* null, i32* %5, i1* null, i1* %6, i1* null, i1* %8, i1* null, i1* %9, i32* null, i32* %10, [129 x i8]* null, [129 x i8]* %11, [64 x i8]* null, [64 x i8]* %12, [4 x %struct.HeadCtx]* %62, i214* %13, i214* %14, i214* %15, i214* %16, i1* null, i1* %18, i32* null, i32* %22, i1* null, i1* %27, i32* null, i32* %28, %struct.ControlMemSpace* %64, i1056* %29, i32* null, i32* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i32* null, i32* %42, i32* null, i32* %43, i32* null, i32* %44, i1* null, i1* %45, i32* null, i32* %46, i1* null, i1* %47, i1* null, i1* %48, i8* null, i8* %49, i32* null, i32* %50, i8* null, i8* %51, i8* null, i8* %52, i8* null, i8* %53, i8* null, i8* %54, i1* null, i1* %55, i1* null, i1* %56, i1* null, i1* %57, i1* null, i1* %58, i1* null, i1* %59, i1* null, i1* %60)
  call void @free(i8* %61)
  call void @free(i8* %63)
  ret void
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}
!datalayout.transforms.on.top = !{!5}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = !{!6, !8, !10}
!6 = !{!7}
!7 = !{!"13", [4 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12, !13, !14}
!11 = !{!"13.0", %struct.HeadCtx* null}
!12 = !{!"13.1", %struct.HeadCtx* null}
!13 = !{!"13.2", %struct.HeadCtx* null}
!14 = !{!"13.3", %struct.HeadCtx* null}
