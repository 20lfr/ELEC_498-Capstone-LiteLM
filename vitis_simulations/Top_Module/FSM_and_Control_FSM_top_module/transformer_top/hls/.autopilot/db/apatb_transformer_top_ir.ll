; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Top_Module/FSM_and_Control_FSM_top_module/transformer_top/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i8, i8, i8, i1, i1, i8, i32, i32, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }
%struct.ControlMemSpace = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }

; Function Attrs: noinline willreturn
define void @apatb_transformer_top_ir(i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %dma_done, i32* noalias nocapture nonnull dereferenceable(4) %dma_address, i1* noalias nocapture nonnull dereferenceable(1) %memory_request, i1 zeroext %compute_ready, i1 zeroext %compute_done, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i8* noalias nocapture nonnull dereferenceable(1) %compute_op, [4 x %struct.HeadCtx]* noalias nonnull dereferenceable(272) %head_ctx_ref, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* noalias nocapture nonnull dereferenceable(4) %ctrl_data_out, i1 zeroext %ctrl_read_en, i1 zeroext %ctrl_write_en, i1 zeroext %ctrl_chip_en, i1 zeroext %ctrl_resetn_in, i1* noalias nocapture nonnull dereferenceable(1) %irq_ps, i32* noalias nocapture nonnull dereferenceable(4) %dbg_state, %struct.ControlMemSpace* noalias nocapture nonnull readnone dereferenceable(132) %dbg_ctrl_mem, i32* noalias nocapture nonnull dereferenceable(4) %control_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_status_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_enable_reg, i32* noalias nocapture nonnull dereferenceable(4) %wq_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wk_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wv_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wo_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w1_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w2_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wq_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wk_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wv_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wo_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w1_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w2_tile_stride, i1* noalias nocapture nonnull dereferenceable(1) %dbg_wl_ready, i1* noalias nocapture nonnull dereferenceable(1) %dbg_wl_start, i8* noalias nocapture nonnull dereferenceable(1) %dbg_wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %dbg_wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %dbg_wl_head, i32* noalias nocapture nonnull dereferenceable(4) %dbg_wl_tile, i1* noalias nocapture nonnull dereferenceable(1) %dbg_done, i1* noalias nocapture nonnull dereferenceable(1) %dbg_error) local_unnamed_addr #0 {
entry:
  %axis_in_ready_copy = alloca i1, align 512
  %dma_address_copy = alloca i32, align 512
  %memory_request_copy = alloca i1, align 512
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i8, align 512
  %head_ctx_ref_copy_0 = alloca i235, align 512
  %head_ctx_ref_copy_1 = alloca i235, align 512
  %head_ctx_ref_copy_2 = alloca i235, align 512
  %head_ctx_ref_copy_3 = alloca i235, align 512
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
  %dbg_wl_ready_copy = alloca i1, align 512
  %dbg_wl_start_copy = alloca i1, align 512
  %dbg_wl_addr_sel_copy = alloca i8, align 512
  %dbg_wl_layer_copy = alloca i32, align 512
  %dbg_wl_head_copy = alloca i32, align 512
  %dbg_wl_tile_copy = alloca i32, align 512
  %dbg_done_copy = alloca i1, align 512
  %dbg_error_copy = alloca i1, align 512
  call void @copy_in(i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, i32* nonnull %dma_address, i32* nonnull align 512 %dma_address_copy, i1* nonnull %memory_request, i1* nonnull align 512 %memory_request_copy, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i8* nonnull %compute_op, i8* nonnull align 512 %compute_op_copy, [4 x %struct.HeadCtx]* nonnull %head_ctx_ref, i235* nonnull align 512 %head_ctx_ref_copy_0, i235* nonnull align 512 %head_ctx_ref_copy_1, i235* nonnull align 512 %head_ctx_ref_copy_2, i235* nonnull align 512 %head_ctx_ref_copy_3, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i32* nonnull %ctrl_data_out, i32* nonnull align 512 %ctrl_data_out_copy, i1* nonnull %irq_ps, i1* nonnull align 512 %irq_ps_copy, i32* nonnull %dbg_state, i32* nonnull align 512 %dbg_state_copy, %struct.ControlMemSpace* nonnull %dbg_ctrl_mem, i1056* nonnull align 512 %dbg_ctrl_mem_copy, i32* nonnull %control_reg, i32* nonnull align 512 %control_reg_copy, i32* nonnull %irq_status_reg, i32* nonnull align 512 %irq_status_reg_copy, i32* nonnull %irq_enable_reg, i32* nonnull align 512 %irq_enable_reg_copy, i32* nonnull %wq_base_addr, i32* nonnull align 512 %wq_base_addr_copy, i32* nonnull %wk_base_addr, i32* nonnull align 512 %wk_base_addr_copy, i32* nonnull %wv_base_addr, i32* nonnull align 512 %wv_base_addr_copy, i32* nonnull %wo_base_addr, i32* nonnull align 512 %wo_base_addr_copy, i32* nonnull %w1_base_addr, i32* nonnull align 512 %w1_base_addr_copy, i32* nonnull %w2_base_addr, i32* nonnull align 512 %w2_base_addr_copy, i32* nonnull %wq_head_stride, i32* nonnull align 512 %wq_head_stride_copy, i32* nonnull %wk_head_stride, i32* nonnull align 512 %wk_head_stride_copy, i32* nonnull %wv_head_stride, i32* nonnull align 512 %wv_head_stride_copy, i32* nonnull %wo_tile_stride, i32* nonnull align 512 %wo_tile_stride_copy, i32* nonnull %w1_tile_stride, i32* nonnull align 512 %w1_tile_stride_copy, i32* nonnull %w2_tile_stride, i32* nonnull align 512 %w2_tile_stride_copy, i1* nonnull %dbg_wl_ready, i1* nonnull align 512 %dbg_wl_ready_copy, i1* nonnull %dbg_wl_start, i1* nonnull align 512 %dbg_wl_start_copy, i8* nonnull %dbg_wl_addr_sel, i8* nonnull align 512 %dbg_wl_addr_sel_copy, i32* nonnull %dbg_wl_layer, i32* nonnull align 512 %dbg_wl_layer_copy, i32* nonnull %dbg_wl_head, i32* nonnull align 512 %dbg_wl_head_copy, i32* nonnull %dbg_wl_tile, i32* nonnull align 512 %dbg_wl_tile_copy, i1* nonnull %dbg_done, i1* nonnull align 512 %dbg_done_copy, i1* nonnull %dbg_error, i1* nonnull align 512 %dbg_error_copy)
  call void @apatb_transformer_top_hw(i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %dma_done, i32* %dma_address_copy, i1* %memory_request_copy, i1 %compute_ready, i1 %compute_done, i1* %compute_start_copy, i8* %compute_op_copy, i235* %head_ctx_ref_copy_0, i235* %head_ctx_ref_copy_1, i235* %head_ctx_ref_copy_2, i235* %head_ctx_ref_copy_3, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* %ctrl_data_out_copy, i1 %ctrl_read_en, i1 %ctrl_write_en, i1 %ctrl_chip_en, i1 %ctrl_resetn_in, i1* %irq_ps_copy, i32* %dbg_state_copy, i1056* %dbg_ctrl_mem_copy, i32* %control_reg_copy, i32* %irq_status_reg_copy, i32* %irq_enable_reg_copy, i32* %wq_base_addr_copy, i32* %wk_base_addr_copy, i32* %wv_base_addr_copy, i32* %wo_base_addr_copy, i32* %w1_base_addr_copy, i32* %w2_base_addr_copy, i32* %wq_head_stride_copy, i32* %wk_head_stride_copy, i32* %wv_head_stride_copy, i32* %wo_tile_stride_copy, i32* %w1_tile_stride_copy, i32* %w2_tile_stride_copy, i1* %dbg_wl_ready_copy, i1* %dbg_wl_start_copy, i8* %dbg_wl_addr_sel_copy, i32* %dbg_wl_layer_copy, i32* %dbg_wl_head_copy, i32* %dbg_wl_tile_copy, i1* %dbg_done_copy, i1* %dbg_error_copy)
  call void @copy_back(i1* %axis_in_ready, i1* %axis_in_ready_copy, i32* %dma_address, i32* %dma_address_copy, i1* %memory_request, i1* %memory_request_copy, i1* %compute_start, i1* %compute_start_copy, i8* %compute_op, i8* %compute_op_copy, [4 x %struct.HeadCtx]* %head_ctx_ref, i235* %head_ctx_ref_copy_0, i235* %head_ctx_ref_copy_1, i235* %head_ctx_ref_copy_2, i235* %head_ctx_ref_copy_3, i1* %stream_start, i1* %stream_start_copy, i32* %ctrl_data_out, i32* %ctrl_data_out_copy, i1* %irq_ps, i1* %irq_ps_copy, i32* %dbg_state, i32* %dbg_state_copy, %struct.ControlMemSpace* %dbg_ctrl_mem, i1056* %dbg_ctrl_mem_copy, i32* %control_reg, i32* %control_reg_copy, i32* %irq_status_reg, i32* %irq_status_reg_copy, i32* %irq_enable_reg, i32* %irq_enable_reg_copy, i32* %wq_base_addr, i32* %wq_base_addr_copy, i32* %wk_base_addr, i32* %wk_base_addr_copy, i32* %wv_base_addr, i32* %wv_base_addr_copy, i32* %wo_base_addr, i32* %wo_base_addr_copy, i32* %w1_base_addr, i32* %w1_base_addr_copy, i32* %w2_base_addr, i32* %w2_base_addr_copy, i32* %wq_head_stride, i32* %wq_head_stride_copy, i32* %wk_head_stride, i32* %wk_head_stride_copy, i32* %wv_head_stride, i32* %wv_head_stride_copy, i32* %wo_tile_stride, i32* %wo_tile_stride_copy, i32* %w1_tile_stride, i32* %w1_tile_stride_copy, i32* %w2_tile_stride, i32* %w2_tile_stride_copy, i1* %dbg_wl_ready, i1* %dbg_wl_ready_copy, i1* %dbg_wl_start, i1* %dbg_wl_start_copy, i8* %dbg_wl_addr_sel, i8* %dbg_wl_addr_sel_copy, i32* %dbg_wl_layer, i32* %dbg_wl_layer_copy, i32* %dbg_wl_head, i32* %dbg_wl_head_copy, i32* %dbg_wl_tile, i32* %dbg_wl_tile_copy, i1* %dbg_done, i1* %dbg_done_copy, i1* %dbg_error, i1* %dbg_error_copy)
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
  %15 = load i8, i8* %src.addr.620, align 1
  store i8 %15, i8* %dst.addr.621, align 1
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 7
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 7
  %16 = load i8, i8* %src.addr.722, align 1
  store i8 %16, i8* %dst.addr.723, align 1
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
  %24 = load i8, i8* %src.addr.1130, align 1
  store i8 %24, i8* %dst.addr.1131, align 1
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 12
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 12
  %25 = load i32, i32* %src.addr.1232, align 4
  store i32 %25, i32* %dst.addr.1233, align 4
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 13
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 13
  %26 = load i32, i32* %src.addr.1334, align 4
  store i32 %26, i32* %dst.addr.1335, align 4
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 14
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 14
  %27 = bitcast i1* %src.addr.1436 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  store i1 %29, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 15
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 15
  %30 = load i32, i32* %src.addr.1538, align 4
  store i32 %30, i32* %dst.addr.1539, align 4
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 16
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 16
  %31 = bitcast i1* %src.addr.1640 to i8*
  %32 = load i8, i8* %31
  %33 = trunc i8 %32 to i1
  store i1 %33, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 17
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 17
  %34 = bitcast i1* %src.addr.1742 to i8*
  %35 = load i8, i8* %34
  %36 = trunc i8 %35 to i1
  store i1 %36, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 18
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 18
  %37 = bitcast i1* %src.addr.1844 to i8*
  %38 = load i8, i8* %37
  %39 = trunc i8 %38 to i1
  store i1 %39, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 19
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 19
  %40 = bitcast i1* %src.addr.1946 to i8*
  %41 = load i8, i8* %40
  %42 = trunc i8 %41 to i1
  store i1 %42, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 20
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 20
  %43 = bitcast i1* %src.addr.2048 to i8*
  %44 = load i8, i8* %43
  %45 = trunc i8 %44 to i1
  store i1 %45, i1* %dst.addr.2049, align 1
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 21
  %dst.addr.2151 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 21
  %46 = bitcast i1* %src.addr.2150 to i8*
  %47 = load i8, i8* %46
  %48 = trunc i8 %47 to i1
  store i1 %48, i1* %dst.addr.2151, align 1
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 22
  %dst.addr.2253 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 22
  %49 = bitcast i1* %src.addr.2252 to i8*
  %50 = load i8, i8* %49
  %51 = trunc i8 %50 to i1
  store i1 %51, i1* %dst.addr.2253, align 1
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 23
  %dst.addr.2355 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 23
  %52 = bitcast i1* %src.addr.2354 to i8*
  %53 = load i8, i8* %52
  %54 = trunc i8 %53 to i1
  store i1 %54, i1* %dst.addr.2355, align 1
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 24
  %dst.addr.2457 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 24
  %55 = bitcast i1* %src.addr.2456 to i8*
  %56 = load i8, i8* %55
  %57 = trunc i8 %56 to i1
  store i1 %57, i1* %dst.addr.2457, align 1
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 25
  %dst.addr.2559 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 25
  %58 = bitcast i1* %src.addr.2558 to i8*
  %59 = load i8, i8* %58
  %60 = trunc i8 %59 to i1
  store i1 %60, i1* %dst.addr.2559, align 1
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 26
  %dst.addr.2661 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 26
  %61 = bitcast i1* %src.addr.2660 to i8*
  %62 = load i8, i8* %61
  %63 = trunc i8 %62 to i1
  store i1 %63, i1* %dst.addr.2661, align 1
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 27
  %dst.addr.2763 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 27
  %64 = bitcast i1* %src.addr.2762 to i8*
  %65 = load i8, i8* %64
  %66 = trunc i8 %65 to i1
  store i1 %66, i1* %dst.addr.2763, align 1
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 28
  %dst.addr.2865 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 28
  %67 = bitcast i1* %src.addr.2864 to i8*
  %68 = load i8, i8* %67
  %69 = trunc i8 %68 to i1
  store i1 %69, i1* %dst.addr.2865, align 1
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 29
  %dst.addr.2967 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 29
  %70 = bitcast i1* %src.addr.2966 to i8*
  %71 = load i8, i8* %70
  %72 = trunc i8 %71 to i1
  store i1 %72, i1* %dst.addr.2967, align 1
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 30
  %dst.addr.3069 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 30
  %73 = bitcast i1* %src.addr.3068 to i8*
  %74 = load i8, i8* %73
  %75 = trunc i8 %74 to i1
  store i1 %75, i1* %dst.addr.3069, align 1
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 31
  %dst.addr.3171 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 31
  %76 = bitcast i1* %src.addr.3170 to i8*
  %77 = load i8, i8* %76
  %78 = trunc i8 %77 to i1
  store i1 %78, i1* %dst.addr.3171, align 1
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 32
  %dst.addr.3273 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 32
  %79 = bitcast i1* %src.addr.3272 to i8*
  %80 = load i8, i8* %79
  %81 = trunc i8 %80 to i1
  store i1 %81, i1* %dst.addr.3273, align 1
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 33
  %dst.addr.3375 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 33
  %82 = bitcast i1* %src.addr.3374 to i8*
  %83 = load i8, i8* %82
  %84 = trunc i8 %83 to i1
  store i1 %84, i1* %dst.addr.3375, align 1
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 34
  %dst.addr.3477 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 34
  %85 = bitcast i1* %src.addr.3476 to i8*
  %86 = load i8, i8* %85
  %87 = trunc i8 %86 to i1
  store i1 %87, i1* %dst.addr.3477, align 1
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 35
  %dst.addr.3579 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 35
  %88 = bitcast i1* %src.addr.3578 to i8*
  %89 = load i8, i8* %88
  %90 = trunc i8 %89 to i1
  store i1 %90, i1* %dst.addr.3579, align 1
  %src.addr.3680 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 36
  %dst.addr.3681 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 36
  %91 = bitcast i1* %src.addr.3680 to i8*
  %92 = load i8, i8* %91
  %93 = trunc i8 %92 to i1
  store i1 %93, i1* %dst.addr.3681, align 1
  %src.addr.3782 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 37
  %dst.addr.3783 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 37
  %94 = bitcast i1* %src.addr.3782 to i8*
  %95 = load i8, i8* %94
  %96 = trunc i8 %95 to i1
  store i1 %96, i1* %dst.addr.3783, align 1
  %src.addr.3884 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 38
  %dst.addr.3885 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 38
  %97 = bitcast i1* %src.addr.3884 to i8*
  %98 = load i8, i8* %97
  %99 = trunc i8 %98 to i1
  store i1 %99, i1* %dst.addr.3885, align 1
  %src.addr.3986 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 39
  %dst.addr.3987 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 39
  %100 = bitcast i1* %src.addr.3986 to i8*
  %101 = load i8, i8* %100
  %102 = trunc i8 %101 to i1
  store i1 %102, i1* %dst.addr.3987, align 1
  %src.addr.4088 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 40
  %dst.addr.4089 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 40
  %103 = bitcast i1* %src.addr.4088 to i8*
  %104 = load i8, i8* %103
  %105 = trunc i8 %104 to i1
  store i1 %105, i1* %dst.addr.4089, align 1
  %src.addr.4190 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 41
  %dst.addr.4191 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 41
  %106 = bitcast i1* %src.addr.4190 to i8*
  %107 = load i8, i8* %106
  %108 = trunc i8 %107 to i1
  store i1 %108, i1* %dst.addr.4191, align 1
  %src.addr.4292 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 42
  %dst.addr.4293 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 42
  %109 = bitcast i1* %src.addr.4292 to i8*
  %110 = load i8, i8* %109
  %111 = trunc i8 %110 to i1
  store i1 %111, i1* %dst.addr.4293, align 1
  %src.addr.4394 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 43
  %dst.addr.4395 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 43
  %112 = bitcast i1* %src.addr.4394 to i8*
  %113 = load i8, i8* %112
  %114 = trunc i8 %113 to i1
  store i1 %114, i1* %dst.addr.4395, align 1
  %src.addr.4496 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 44
  %dst.addr.4497 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 44
  %115 = bitcast i1* %src.addr.4496 to i8*
  %116 = load i8, i8* %115
  %117 = trunc i8 %116 to i1
  store i1 %117, i1* %dst.addr.4497, align 1
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
define void @arraycpy_hls.p0a4struct.HeadCtx.13.14(i235* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i235* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i235* "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i235* "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i235* %dst_0, null
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
  %4 = bitcast i235* %dst_0 to i240*
  %5 = load i240, i240* %4
  %6 = trunc i240 %5 to i235
  %7 = zext i32 %3 to i235
  %8 = and i235 %6, -4294967296
  %.partset179 = or i235 %8, %7
  store i235 %.partset179, i235* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i235* %dst_1 to i240*
  %10 = load i240, i240* %9
  %11 = trunc i240 %10 to i235
  %12 = zext i32 %3 to i235
  %13 = and i235 %11, -4294967296
  %.partset90 = or i235 %13, %12
  store i235 %.partset90, i235* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.2:                               ; preds = %for.loop
  %14 = bitcast i235* %dst_2 to i240*
  %15 = load i240, i240* %14
  %16 = trunc i240 %15 to i235
  %17 = zext i32 %3 to i235
  %18 = and i235 %16, -4294967296
  %.partset89 = or i235 %18, %17
  store i235 %.partset89, i235* %dst_2, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.3:                               ; preds = %for.loop
  %19 = bitcast i235* %dst_3 to i240*
  %20 = load i240, i240* %19
  %21 = trunc i240 %20 to i235
  %22 = zext i32 %3 to i235
  %23 = and i235 %21, -4294967296
  %.partset = or i235 %23, %22
  store i235 %.partset, i235* %dst_3, align 4
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
  %25 = bitcast i235* %dst_0 to i240*
  %26 = load i240, i240* %25
  %27 = trunc i240 %26 to i235
  %28 = zext i32 %24 to i235
  %29 = shl i235 %28, 32
  %30 = and i235 %27, -18446744069414584321
  %.partset178 = or i235 %30, %29
  store i235 %.partset178, i235* %dst_0, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %31 = bitcast i235* %dst_1 to i240*
  %32 = load i240, i240* %31
  %33 = trunc i240 %32 to i235
  %34 = zext i32 %24 to i235
  %35 = shl i235 %34, 32
  %36 = and i235 %33, -18446744069414584321
  %.partset91 = or i235 %36, %35
  store i235 %.partset91, i235* %dst_1, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.2:                              ; preds = %dst.addr.02.exit
  %37 = bitcast i235* %dst_2 to i240*
  %38 = load i240, i240* %37
  %39 = trunc i240 %38 to i235
  %40 = zext i32 %24 to i235
  %41 = shl i235 %40, 32
  %42 = and i235 %39, -18446744069414584321
  %.partset88 = or i235 %42, %41
  store i235 %.partset88, i235* %dst_2, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.3:                              ; preds = %dst.addr.02.exit
  %43 = bitcast i235* %dst_3 to i240*
  %44 = load i240, i240* %43
  %45 = trunc i240 %44 to i235
  %46 = zext i32 %24 to i235
  %47 = shl i235 %46, 32
  %48 = and i235 %45, -18446744069414584321
  %.partset1 = or i235 %48, %47
  store i235 %.partset1, i235* %dst_3, align 4
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
  %50 = bitcast i235* %dst_0 to i240*
  %51 = load i240, i240* %50
  %52 = trunc i240 %51 to i235
  %53 = zext i8 %49 to i235
  %54 = shl i235 %53, 64
  %55 = and i235 %52, -4703919738795935662081
  %.partset177 = or i235 %55, %54
  store i235 %.partset177, i235* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %56 = bitcast i235* %dst_1 to i240*
  %57 = load i240, i240* %56
  %58 = trunc i240 %57 to i235
  %59 = zext i8 %49 to i235
  %60 = shl i235 %59, 64
  %61 = and i235 %58, -4703919738795935662081
  %.partset92 = or i235 %61, %60
  store i235 %.partset92, i235* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.2:                              ; preds = %dst.addr.111.exit
  %62 = bitcast i235* %dst_2 to i240*
  %63 = load i240, i240* %62
  %64 = trunc i240 %63 to i235
  %65 = zext i8 %49 to i235
  %66 = shl i235 %65, 64
  %67 = and i235 %64, -4703919738795935662081
  %.partset87 = or i235 %67, %66
  store i235 %.partset87, i235* %dst_2, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.3:                              ; preds = %dst.addr.111.exit
  %68 = bitcast i235* %dst_3 to i240*
  %69 = load i240, i240* %68
  %70 = trunc i240 %69 to i235
  %71 = zext i8 %49 to i235
  %72 = shl i235 %71, 64
  %73 = and i235 %70, -4703919738795935662081
  %.partset2 = or i235 %73, %72
  store i235 %.partset2, i235* %dst_3, align 1
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
  %77 = bitcast i235* %dst_0 to i240*
  %78 = load i240, i240* %77
  %79 = trunc i240 %78 to i235
  %80 = zext i1 %76 to i235
  %81 = shl i235 %80, 72
  %82 = and i235 %79, -4722366482869645213697
  %.partset176 = or i235 %82, %81
  store i235 %.partset176, i235* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %83 = bitcast i235* %dst_1 to i240*
  %84 = load i240, i240* %83
  %85 = trunc i240 %84 to i235
  %86 = zext i1 %76 to i235
  %87 = shl i235 %86, 72
  %88 = and i235 %85, -4722366482869645213697
  %.partset93 = or i235 %88, %87
  store i235 %.partset93, i235* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.2:                              ; preds = %dst.addr.213.exit
  %89 = bitcast i235* %dst_2 to i240*
  %90 = load i240, i240* %89
  %91 = trunc i240 %90 to i235
  %92 = zext i1 %76 to i235
  %93 = shl i235 %92, 72
  %94 = and i235 %91, -4722366482869645213697
  %.partset86 = or i235 %94, %93
  store i235 %.partset86, i235* %dst_2, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.3:                              ; preds = %dst.addr.213.exit
  %95 = bitcast i235* %dst_3 to i240*
  %96 = load i240, i240* %95
  %97 = trunc i240 %96 to i235
  %98 = zext i1 %76 to i235
  %99 = shl i235 %98, 72
  %100 = and i235 %97, -4722366482869645213697
  %.partset3 = or i235 %100, %99
  store i235 %.partset3, i235* %dst_3, align 1
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
  %104 = bitcast i235* %dst_0 to i240*
  %105 = load i240, i240* %104
  %106 = trunc i240 %105 to i235
  %107 = zext i1 %103 to i235
  %108 = shl i235 %107, 73
  %109 = and i235 %106, -9444732965739290427393
  %.partset175 = or i235 %109, %108
  store i235 %.partset175, i235* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %110 = bitcast i235* %dst_1 to i240*
  %111 = load i240, i240* %110
  %112 = trunc i240 %111 to i235
  %113 = zext i1 %103 to i235
  %114 = shl i235 %113, 73
  %115 = and i235 %112, -9444732965739290427393
  %.partset94 = or i235 %115, %114
  store i235 %.partset94, i235* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.2:                              ; preds = %dst.addr.315.exit
  %116 = bitcast i235* %dst_2 to i240*
  %117 = load i240, i240* %116
  %118 = trunc i240 %117 to i235
  %119 = zext i1 %103 to i235
  %120 = shl i235 %119, 73
  %121 = and i235 %118, -9444732965739290427393
  %.partset85 = or i235 %121, %120
  store i235 %.partset85, i235* %dst_2, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.3:                              ; preds = %dst.addr.315.exit
  %122 = bitcast i235* %dst_3 to i240*
  %123 = load i240, i240* %122
  %124 = trunc i240 %123 to i235
  %125 = zext i1 %103 to i235
  %126 = shl i235 %125, 73
  %127 = and i235 %124, -9444732965739290427393
  %.partset4 = or i235 %127, %126
  store i235 %.partset4, i235* %dst_3, align 1
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
  %131 = bitcast i235* %dst_0 to i240*
  %132 = load i240, i240* %131
  %133 = trunc i240 %132 to i235
  %134 = zext i1 %130 to i235
  %135 = shl i235 %134, 74
  %136 = and i235 %133, -18889465931478580854785
  %.partset174 = or i235 %136, %135
  store i235 %.partset174, i235* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %137 = bitcast i235* %dst_1 to i240*
  %138 = load i240, i240* %137
  %139 = trunc i240 %138 to i235
  %140 = zext i1 %130 to i235
  %141 = shl i235 %140, 74
  %142 = and i235 %139, -18889465931478580854785
  %.partset95 = or i235 %142, %141
  store i235 %.partset95, i235* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.2:                              ; preds = %dst.addr.417.exit
  %143 = bitcast i235* %dst_2 to i240*
  %144 = load i240, i240* %143
  %145 = trunc i240 %144 to i235
  %146 = zext i1 %130 to i235
  %147 = shl i235 %146, 74
  %148 = and i235 %145, -18889465931478580854785
  %.partset84 = or i235 %148, %147
  store i235 %.partset84, i235* %dst_2, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.3:                              ; preds = %dst.addr.417.exit
  %149 = bitcast i235* %dst_3 to i240*
  %150 = load i240, i240* %149
  %151 = trunc i240 %150 to i235
  %152 = zext i1 %130 to i235
  %153 = shl i235 %152, 74
  %154 = and i235 %151, -18889465931478580854785
  %.partset5 = or i235 %154, %153
  store i235 %.partset5, i235* %dst_3, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.3, %dst.addr.519.case.2, %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 6
  %155 = load i8, i8* %src.addr.620, align 1
  switch i64 %for.loop.idx99, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
    i64 2, label %dst.addr.621.case.2
    i64 3, label %dst.addr.621.case.3
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %156 = bitcast i235* %dst_0 to i240*
  %157 = load i240, i240* %156
  %158 = trunc i240 %157 to i235
  %159 = zext i8 %155 to i235
  %160 = shl i235 %159, 75
  %161 = and i235 %158, -9633627625054076235939841
  %.partset173 = or i235 %161, %160
  store i235 %.partset173, i235* %dst_0, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %162 = bitcast i235* %dst_1 to i240*
  %163 = load i240, i240* %162
  %164 = trunc i240 %163 to i235
  %165 = zext i8 %155 to i235
  %166 = shl i235 %165, 75
  %167 = and i235 %164, -9633627625054076235939841
  %.partset96 = or i235 %167, %166
  store i235 %.partset96, i235* %dst_1, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.2:                              ; preds = %dst.addr.519.exit
  %168 = bitcast i235* %dst_2 to i240*
  %169 = load i240, i240* %168
  %170 = trunc i240 %169 to i235
  %171 = zext i8 %155 to i235
  %172 = shl i235 %171, 75
  %173 = and i235 %170, -9633627625054076235939841
  %.partset83 = or i235 %173, %172
  store i235 %.partset83, i235* %dst_2, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.3:                              ; preds = %dst.addr.519.exit
  %174 = bitcast i235* %dst_3 to i240*
  %175 = load i240, i240* %174
  %176 = trunc i240 %175 to i235
  %177 = zext i8 %155 to i235
  %178 = shl i235 %177, 75
  %179 = and i235 %176, -9633627625054076235939841
  %.partset6 = or i235 %179, %178
  store i235 %.partset6, i235* %dst_3, align 1
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.3, %dst.addr.621.case.2, %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 7
  %180 = load i8, i8* %src.addr.722, align 1
  switch i64 %for.loop.idx99, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
    i64 2, label %dst.addr.723.case.2
    i64 3, label %dst.addr.723.case.3
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %181 = bitcast i235* %dst_0 to i240*
  %182 = load i240, i240* %181
  %183 = trunc i240 %182 to i235
  %184 = zext i8 %180 to i235
  %185 = shl i235 %184, 83
  %186 = and i235 %183, -2466208672013843516400599041
  %.partset172 = or i235 %186, %185
  store i235 %.partset172, i235* %dst_0, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %187 = bitcast i235* %dst_1 to i240*
  %188 = load i240, i240* %187
  %189 = trunc i240 %188 to i235
  %190 = zext i8 %180 to i235
  %191 = shl i235 %190, 83
  %192 = and i235 %189, -2466208672013843516400599041
  %.partset97 = or i235 %192, %191
  store i235 %.partset97, i235* %dst_1, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.2:                              ; preds = %dst.addr.621.exit
  %193 = bitcast i235* %dst_2 to i240*
  %194 = load i240, i240* %193
  %195 = trunc i240 %194 to i235
  %196 = zext i8 %180 to i235
  %197 = shl i235 %196, 83
  %198 = and i235 %195, -2466208672013843516400599041
  %.partset82 = or i235 %198, %197
  store i235 %.partset82, i235* %dst_2, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.3:                              ; preds = %dst.addr.621.exit
  %199 = bitcast i235* %dst_3 to i240*
  %200 = load i240, i240* %199
  %201 = trunc i240 %200 to i235
  %202 = zext i8 %180 to i235
  %203 = shl i235 %202, 83
  %204 = and i235 %201, -2466208672013843516400599041
  %.partset7 = or i235 %204, %203
  store i235 %.partset7, i235* %dst_3, align 1
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
  %206 = bitcast i235* %dst_0 to i240*
  %207 = load i240, i240* %206
  %208 = trunc i240 %207 to i235
  %209 = zext i8 %205 to i235
  %210 = shl i235 %209, 91
  %211 = and i235 %208, -631349420035543940198553354241
  %.partset171 = or i235 %211, %210
  store i235 %.partset171, i235* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %212 = bitcast i235* %dst_1 to i240*
  %213 = load i240, i240* %212
  %214 = trunc i240 %213 to i235
  %215 = zext i8 %205 to i235
  %216 = shl i235 %215, 91
  %217 = and i235 %214, -631349420035543940198553354241
  %.partset98 = or i235 %217, %216
  store i235 %.partset98, i235* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.2:                              ; preds = %dst.addr.723.exit
  %218 = bitcast i235* %dst_2 to i240*
  %219 = load i240, i240* %218
  %220 = trunc i240 %219 to i235
  %221 = zext i8 %205 to i235
  %222 = shl i235 %221, 91
  %223 = and i235 %220, -631349420035543940198553354241
  %.partset81 = or i235 %223, %222
  store i235 %.partset81, i235* %dst_2, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.3:                              ; preds = %dst.addr.723.exit
  %224 = bitcast i235* %dst_3 to i240*
  %225 = load i240, i240* %224
  %226 = trunc i240 %225 to i235
  %227 = zext i8 %205 to i235
  %228 = shl i235 %227, 91
  %229 = and i235 %226, -631349420035543940198553354241
  %.partset8 = or i235 %229, %228
  store i235 %.partset8, i235* %dst_3, align 1
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
  %233 = bitcast i235* %dst_0 to i240*
  %234 = load i240, i240* %233
  %235 = trunc i240 %234 to i235
  %236 = zext i1 %232 to i235
  %237 = shl i235 %236, 99
  %238 = and i235 %235, -633825300114114700748351602689
  %.partset170 = or i235 %238, %237
  store i235 %.partset170, i235* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %239 = bitcast i235* %dst_1 to i240*
  %240 = load i240, i240* %239
  %241 = trunc i240 %240 to i235
  %242 = zext i1 %232 to i235
  %243 = shl i235 %242, 99
  %244 = and i235 %241, -633825300114114700748351602689
  %.partset99 = or i235 %244, %243
  store i235 %.partset99, i235* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.2:                              ; preds = %dst.addr.825.exit
  %245 = bitcast i235* %dst_2 to i240*
  %246 = load i240, i240* %245
  %247 = trunc i240 %246 to i235
  %248 = zext i1 %232 to i235
  %249 = shl i235 %248, 99
  %250 = and i235 %247, -633825300114114700748351602689
  %.partset80 = or i235 %250, %249
  store i235 %.partset80, i235* %dst_2, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.3:                              ; preds = %dst.addr.825.exit
  %251 = bitcast i235* %dst_3 to i240*
  %252 = load i240, i240* %251
  %253 = trunc i240 %252 to i235
  %254 = zext i1 %232 to i235
  %255 = shl i235 %254, 99
  %256 = and i235 %253, -633825300114114700748351602689
  %.partset9 = or i235 %256, %255
  store i235 %.partset9, i235* %dst_3, align 1
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
  %260 = bitcast i235* %dst_0 to i240*
  %261 = load i240, i240* %260
  %262 = trunc i240 %261 to i235
  %263 = zext i1 %259 to i235
  %264 = shl i235 %263, 100
  %265 = and i235 %262, -1267650600228229401496703205377
  %.partset169 = or i235 %265, %264
  store i235 %.partset169, i235* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %266 = bitcast i235* %dst_1 to i240*
  %267 = load i240, i240* %266
  %268 = trunc i240 %267 to i235
  %269 = zext i1 %259 to i235
  %270 = shl i235 %269, 100
  %271 = and i235 %268, -1267650600228229401496703205377
  %.partset100 = or i235 %271, %270
  store i235 %.partset100, i235* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.2:                             ; preds = %dst.addr.927.exit
  %272 = bitcast i235* %dst_2 to i240*
  %273 = load i240, i240* %272
  %274 = trunc i240 %273 to i235
  %275 = zext i1 %259 to i235
  %276 = shl i235 %275, 100
  %277 = and i235 %274, -1267650600228229401496703205377
  %.partset79 = or i235 %277, %276
  store i235 %.partset79, i235* %dst_2, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.3:                             ; preds = %dst.addr.927.exit
  %278 = bitcast i235* %dst_3 to i240*
  %279 = load i240, i240* %278
  %280 = trunc i240 %279 to i235
  %281 = zext i1 %259 to i235
  %282 = shl i235 %281, 100
  %283 = and i235 %280, -1267650600228229401496703205377
  %.partset10 = or i235 %283, %282
  store i235 %.partset10, i235* %dst_3, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.exit:                               ; preds = %dst.addr.1029.case.3, %dst.addr.1029.case.2, %dst.addr.1029.case.1, %dst.addr.1029.case.0, %dst.addr.927.exit
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 11
  %284 = load i8, i8* %src.addr.1130, align 1
  switch i64 %for.loop.idx99, label %dst.addr.1131.exit [
    i64 0, label %dst.addr.1131.case.0
    i64 1, label %dst.addr.1131.case.1
    i64 2, label %dst.addr.1131.case.2
    i64 3, label %dst.addr.1131.case.3
  ]

dst.addr.1131.case.0:                             ; preds = %dst.addr.1029.exit
  %285 = bitcast i235* %dst_0 to i240*
  %286 = load i240, i240* %285
  %287 = trunc i240 %286 to i235
  %288 = zext i8 %284 to i235
  %289 = shl i235 %288, 101
  %290 = and i235 %287, -646501806116396994763318634741761
  %.partset168 = or i235 %290, %289
  store i235 %.partset168, i235* %dst_0, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %291 = bitcast i235* %dst_1 to i240*
  %292 = load i240, i240* %291
  %293 = trunc i240 %292 to i235
  %294 = zext i8 %284 to i235
  %295 = shl i235 %294, 101
  %296 = and i235 %293, -646501806116396994763318634741761
  %.partset101 = or i235 %296, %295
  store i235 %.partset101, i235* %dst_1, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.2:                             ; preds = %dst.addr.1029.exit
  %297 = bitcast i235* %dst_2 to i240*
  %298 = load i240, i240* %297
  %299 = trunc i240 %298 to i235
  %300 = zext i8 %284 to i235
  %301 = shl i235 %300, 101
  %302 = and i235 %299, -646501806116396994763318634741761
  %.partset78 = or i235 %302, %301
  store i235 %.partset78, i235* %dst_2, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.3:                             ; preds = %dst.addr.1029.exit
  %303 = bitcast i235* %dst_3 to i240*
  %304 = load i240, i240* %303
  %305 = trunc i240 %304 to i235
  %306 = zext i8 %284 to i235
  %307 = shl i235 %306, 101
  %308 = and i235 %305, -646501806116396994763318634741761
  %.partset11 = or i235 %308, %307
  store i235 %.partset11, i235* %dst_3, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.exit:                               ; preds = %dst.addr.1131.case.3, %dst.addr.1131.case.2, %dst.addr.1131.case.1, %dst.addr.1131.case.0, %dst.addr.1029.exit
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 12
  %309 = load i32, i32* %src.addr.1232, align 4
  switch i64 %for.loop.idx99, label %dst.addr.1233.exit [
    i64 0, label %dst.addr.1233.case.0
    i64 1, label %dst.addr.1233.case.1
    i64 2, label %dst.addr.1233.case.2
    i64 3, label %dst.addr.1233.case.3
  ]

dst.addr.1233.case.0:                             ; preds = %dst.addr.1131.exit
  %310 = bitcast i235* %dst_0 to i240*
  %311 = load i240, i240* %310
  %312 = trunc i240 %311 to i235
  %313 = zext i32 %309 to i235
  %314 = shl i235 %313, 109
  %315 = and i235 %312, -2787593149167290785375111330514733147095041
  %.partset167 = or i235 %315, %314
  store i235 %.partset167, i235* %dst_0, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %316 = bitcast i235* %dst_1 to i240*
  %317 = load i240, i240* %316
  %318 = trunc i240 %317 to i235
  %319 = zext i32 %309 to i235
  %320 = shl i235 %319, 109
  %321 = and i235 %318, -2787593149167290785375111330514733147095041
  %.partset102 = or i235 %321, %320
  store i235 %.partset102, i235* %dst_1, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.2:                             ; preds = %dst.addr.1131.exit
  %322 = bitcast i235* %dst_2 to i240*
  %323 = load i240, i240* %322
  %324 = trunc i240 %323 to i235
  %325 = zext i32 %309 to i235
  %326 = shl i235 %325, 109
  %327 = and i235 %324, -2787593149167290785375111330514733147095041
  %.partset77 = or i235 %327, %326
  store i235 %.partset77, i235* %dst_2, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.3:                             ; preds = %dst.addr.1131.exit
  %328 = bitcast i235* %dst_3 to i240*
  %329 = load i240, i240* %328
  %330 = trunc i240 %329 to i235
  %331 = zext i32 %309 to i235
  %332 = shl i235 %331, 109
  %333 = and i235 %330, -2787593149167290785375111330514733147095041
  %.partset12 = or i235 %333, %332
  store i235 %.partset12, i235* %dst_3, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.exit:                               ; preds = %dst.addr.1233.case.3, %dst.addr.1233.case.2, %dst.addr.1233.case.1, %dst.addr.1233.case.0, %dst.addr.1131.exit
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 13
  %334 = load i32, i32* %src.addr.1334, align 4
  switch i64 %for.loop.idx99, label %dst.addr.1335.exit [
    i64 0, label %dst.addr.1335.case.0
    i64 1, label %dst.addr.1335.case.1
    i64 2, label %dst.addr.1335.case.2
    i64 3, label %dst.addr.1335.case.3
  ]

dst.addr.1335.case.0:                             ; preds = %dst.addr.1233.exit
  %335 = bitcast i235* %dst_0 to i240*
  %336 = load i240, i240* %335
  %337 = trunc i240 %336 to i235
  %338 = zext i32 %334 to i235
  %339 = shl i235 %338, 141
  %340 = and i235 %337, -11972621410227163556108258256919825712940354203811841
  %.partset166 = or i235 %340, %339
  store i235 %.partset166, i235* %dst_0, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %341 = bitcast i235* %dst_1 to i240*
  %342 = load i240, i240* %341
  %343 = trunc i240 %342 to i235
  %344 = zext i32 %334 to i235
  %345 = shl i235 %344, 141
  %346 = and i235 %343, -11972621410227163556108258256919825712940354203811841
  %.partset103 = or i235 %346, %345
  store i235 %.partset103, i235* %dst_1, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.2:                             ; preds = %dst.addr.1233.exit
  %347 = bitcast i235* %dst_2 to i240*
  %348 = load i240, i240* %347
  %349 = trunc i240 %348 to i235
  %350 = zext i32 %334 to i235
  %351 = shl i235 %350, 141
  %352 = and i235 %349, -11972621410227163556108258256919825712940354203811841
  %.partset76 = or i235 %352, %351
  store i235 %.partset76, i235* %dst_2, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.3:                             ; preds = %dst.addr.1233.exit
  %353 = bitcast i235* %dst_3 to i240*
  %354 = load i240, i240* %353
  %355 = trunc i240 %354 to i235
  %356 = zext i32 %334 to i235
  %357 = shl i235 %356, 141
  %358 = and i235 %355, -11972621410227163556108258256919825712940354203811841
  %.partset13 = or i235 %358, %357
  store i235 %.partset13, i235* %dst_3, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.exit:                               ; preds = %dst.addr.1335.case.3, %dst.addr.1335.case.2, %dst.addr.1335.case.1, %dst.addr.1335.case.0, %dst.addr.1233.exit
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 14
  %359 = bitcast i1* %src.addr.1436 to i8*
  %360 = load i8, i8* %359
  %361 = trunc i8 %360 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1437.exit [
    i64 0, label %dst.addr.1437.case.0
    i64 1, label %dst.addr.1437.case.1
    i64 2, label %dst.addr.1437.case.2
    i64 3, label %dst.addr.1437.case.3
  ]

dst.addr.1437.case.0:                             ; preds = %dst.addr.1335.exit
  %362 = bitcast i235* %dst_0 to i240*
  %363 = load i240, i240* %362
  %364 = trunc i240 %363 to i235
  %365 = zext i1 %361 to i235
  %366 = shl i235 %365, 173
  %367 = and i235 %364, -11972621413014756705924586149611790497021399392059393
  %.partset165 = or i235 %367, %366
  store i235 %.partset165, i235* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %368 = bitcast i235* %dst_1 to i240*
  %369 = load i240, i240* %368
  %370 = trunc i240 %369 to i235
  %371 = zext i1 %361 to i235
  %372 = shl i235 %371, 173
  %373 = and i235 %370, -11972621413014756705924586149611790497021399392059393
  %.partset104 = or i235 %373, %372
  store i235 %.partset104, i235* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.2:                             ; preds = %dst.addr.1335.exit
  %374 = bitcast i235* %dst_2 to i240*
  %375 = load i240, i240* %374
  %376 = trunc i240 %375 to i235
  %377 = zext i1 %361 to i235
  %378 = shl i235 %377, 173
  %379 = and i235 %376, -11972621413014756705924586149611790497021399392059393
  %.partset75 = or i235 %379, %378
  store i235 %.partset75, i235* %dst_2, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.3:                             ; preds = %dst.addr.1335.exit
  %380 = bitcast i235* %dst_3 to i240*
  %381 = load i240, i240* %380
  %382 = trunc i240 %381 to i235
  %383 = zext i1 %361 to i235
  %384 = shl i235 %383, 173
  %385 = and i235 %382, -11972621413014756705924586149611790497021399392059393
  %.partset14 = or i235 %385, %384
  store i235 %.partset14, i235* %dst_3, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.exit:                               ; preds = %dst.addr.1437.case.3, %dst.addr.1437.case.2, %dst.addr.1437.case.1, %dst.addr.1437.case.0, %dst.addr.1335.exit
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 15
  %386 = load i32, i32* %src.addr.1538, align 4
  switch i64 %for.loop.idx99, label %dst.addr.1539.exit [
    i64 0, label %dst.addr.1539.case.0
    i64 1, label %dst.addr.1539.case.1
    i64 2, label %dst.addr.1539.case.2
    i64 3, label %dst.addr.1539.case.3
  ]

dst.addr.1539.case.0:                             ; preds = %dst.addr.1437.exit
  %387 = bitcast i235* %dst_0 to i240*
  %388 = load i240, i240* %387
  %389 = trunc i240 %388 to i235
  %390 = zext i32 %386 to i235
  %391 = shl i235 %390, 174
  %392 = and i235 %389, -102844034808630134808656060497985234262197410608055942675169281
  %.partset164 = or i235 %392, %391
  store i235 %.partset164, i235* %dst_0, align 4
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %393 = bitcast i235* %dst_1 to i240*
  %394 = load i240, i240* %393
  %395 = trunc i240 %394 to i235
  %396 = zext i32 %386 to i235
  %397 = shl i235 %396, 174
  %398 = and i235 %395, -102844034808630134808656060497985234262197410608055942675169281
  %.partset105 = or i235 %398, %397
  store i235 %.partset105, i235* %dst_1, align 4
  br label %dst.addr.1539.exit

dst.addr.1539.case.2:                             ; preds = %dst.addr.1437.exit
  %399 = bitcast i235* %dst_2 to i240*
  %400 = load i240, i240* %399
  %401 = trunc i240 %400 to i235
  %402 = zext i32 %386 to i235
  %403 = shl i235 %402, 174
  %404 = and i235 %401, -102844034808630134808656060497985234262197410608055942675169281
  %.partset74 = or i235 %404, %403
  store i235 %.partset74, i235* %dst_2, align 4
  br label %dst.addr.1539.exit

dst.addr.1539.case.3:                             ; preds = %dst.addr.1437.exit
  %405 = bitcast i235* %dst_3 to i240*
  %406 = load i240, i240* %405
  %407 = trunc i240 %406 to i235
  %408 = zext i32 %386 to i235
  %409 = shl i235 %408, 174
  %410 = and i235 %407, -102844034808630134808656060497985234262197410608055942675169281
  %.partset15 = or i235 %410, %409
  store i235 %.partset15, i235* %dst_3, align 4
  br label %dst.addr.1539.exit

dst.addr.1539.exit:                               ; preds = %dst.addr.1539.case.3, %dst.addr.1539.case.2, %dst.addr.1539.case.1, %dst.addr.1539.case.0, %dst.addr.1437.exit
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 16
  %411 = bitcast i1* %src.addr.1640 to i8*
  %412 = load i8, i8* %411
  %413 = trunc i8 %412 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1641.exit [
    i64 0, label %dst.addr.1641.case.0
    i64 1, label %dst.addr.1641.case.1
    i64 2, label %dst.addr.1641.case.2
    i64 3, label %dst.addr.1641.case.3
  ]

dst.addr.1641.case.0:                             ; preds = %dst.addr.1539.exit
  %414 = bitcast i235* %dst_0 to i240*
  %415 = load i240, i240* %414
  %416 = trunc i240 %415 to i235
  %417 = zext i1 %413 to i235
  %418 = shl i235 %417, 206
  %419 = and i235 %416, -102844034832575377634685573909834406561420991602098741459288065
  %.partset163 = or i235 %419, %418
  store i235 %.partset163, i235* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %420 = bitcast i235* %dst_1 to i240*
  %421 = load i240, i240* %420
  %422 = trunc i240 %421 to i235
  %423 = zext i1 %413 to i235
  %424 = shl i235 %423, 206
  %425 = and i235 %422, -102844034832575377634685573909834406561420991602098741459288065
  %.partset106 = or i235 %425, %424
  store i235 %.partset106, i235* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.2:                             ; preds = %dst.addr.1539.exit
  %426 = bitcast i235* %dst_2 to i240*
  %427 = load i240, i240* %426
  %428 = trunc i240 %427 to i235
  %429 = zext i1 %413 to i235
  %430 = shl i235 %429, 206
  %431 = and i235 %428, -102844034832575377634685573909834406561420991602098741459288065
  %.partset73 = or i235 %431, %430
  store i235 %.partset73, i235* %dst_2, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.3:                             ; preds = %dst.addr.1539.exit
  %432 = bitcast i235* %dst_3 to i240*
  %433 = load i240, i240* %432
  %434 = trunc i240 %433 to i235
  %435 = zext i1 %413 to i235
  %436 = shl i235 %435, 206
  %437 = and i235 %434, -102844034832575377634685573909834406561420991602098741459288065
  %.partset16 = or i235 %437, %436
  store i235 %.partset16, i235* %dst_3, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.exit:                               ; preds = %dst.addr.1641.case.3, %dst.addr.1641.case.2, %dst.addr.1641.case.1, %dst.addr.1641.case.0, %dst.addr.1539.exit
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 17
  %438 = bitcast i1* %src.addr.1742 to i8*
  %439 = load i8, i8* %438
  %440 = trunc i8 %439 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1743.exit [
    i64 0, label %dst.addr.1743.case.0
    i64 1, label %dst.addr.1743.case.1
    i64 2, label %dst.addr.1743.case.2
    i64 3, label %dst.addr.1743.case.3
  ]

dst.addr.1743.case.0:                             ; preds = %dst.addr.1641.exit
  %441 = bitcast i235* %dst_0 to i240*
  %442 = load i240, i240* %441
  %443 = trunc i240 %442 to i235
  %444 = zext i1 %440 to i235
  %445 = shl i235 %444, 207
  %446 = and i235 %443, -205688069665150755269371147819668813122841983204197482918576129
  %.partset162 = or i235 %446, %445
  store i235 %.partset162, i235* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %447 = bitcast i235* %dst_1 to i240*
  %448 = load i240, i240* %447
  %449 = trunc i240 %448 to i235
  %450 = zext i1 %440 to i235
  %451 = shl i235 %450, 207
  %452 = and i235 %449, -205688069665150755269371147819668813122841983204197482918576129
  %.partset107 = or i235 %452, %451
  store i235 %.partset107, i235* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.2:                             ; preds = %dst.addr.1641.exit
  %453 = bitcast i235* %dst_2 to i240*
  %454 = load i240, i240* %453
  %455 = trunc i240 %454 to i235
  %456 = zext i1 %440 to i235
  %457 = shl i235 %456, 207
  %458 = and i235 %455, -205688069665150755269371147819668813122841983204197482918576129
  %.partset72 = or i235 %458, %457
  store i235 %.partset72, i235* %dst_2, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.3:                             ; preds = %dst.addr.1641.exit
  %459 = bitcast i235* %dst_3 to i240*
  %460 = load i240, i240* %459
  %461 = trunc i240 %460 to i235
  %462 = zext i1 %440 to i235
  %463 = shl i235 %462, 207
  %464 = and i235 %461, -205688069665150755269371147819668813122841983204197482918576129
  %.partset17 = or i235 %464, %463
  store i235 %.partset17, i235* %dst_3, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.exit:                               ; preds = %dst.addr.1743.case.3, %dst.addr.1743.case.2, %dst.addr.1743.case.1, %dst.addr.1743.case.0, %dst.addr.1641.exit
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 18
  %465 = bitcast i1* %src.addr.1844 to i8*
  %466 = load i8, i8* %465
  %467 = trunc i8 %466 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1845.exit [
    i64 0, label %dst.addr.1845.case.0
    i64 1, label %dst.addr.1845.case.1
    i64 2, label %dst.addr.1845.case.2
    i64 3, label %dst.addr.1845.case.3
  ]

dst.addr.1845.case.0:                             ; preds = %dst.addr.1743.exit
  %468 = bitcast i235* %dst_0 to i240*
  %469 = load i240, i240* %468
  %470 = trunc i240 %469 to i235
  %471 = zext i1 %467 to i235
  %472 = shl i235 %471, 208
  %473 = and i235 %470, -411376139330301510538742295639337626245683966408394965837152257
  %.partset161 = or i235 %473, %472
  store i235 %.partset161, i235* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %474 = bitcast i235* %dst_1 to i240*
  %475 = load i240, i240* %474
  %476 = trunc i240 %475 to i235
  %477 = zext i1 %467 to i235
  %478 = shl i235 %477, 208
  %479 = and i235 %476, -411376139330301510538742295639337626245683966408394965837152257
  %.partset108 = or i235 %479, %478
  store i235 %.partset108, i235* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.2:                             ; preds = %dst.addr.1743.exit
  %480 = bitcast i235* %dst_2 to i240*
  %481 = load i240, i240* %480
  %482 = trunc i240 %481 to i235
  %483 = zext i1 %467 to i235
  %484 = shl i235 %483, 208
  %485 = and i235 %482, -411376139330301510538742295639337626245683966408394965837152257
  %.partset71 = or i235 %485, %484
  store i235 %.partset71, i235* %dst_2, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.3:                             ; preds = %dst.addr.1743.exit
  %486 = bitcast i235* %dst_3 to i240*
  %487 = load i240, i240* %486
  %488 = trunc i240 %487 to i235
  %489 = zext i1 %467 to i235
  %490 = shl i235 %489, 208
  %491 = and i235 %488, -411376139330301510538742295639337626245683966408394965837152257
  %.partset18 = or i235 %491, %490
  store i235 %.partset18, i235* %dst_3, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.exit:                               ; preds = %dst.addr.1845.case.3, %dst.addr.1845.case.2, %dst.addr.1845.case.1, %dst.addr.1845.case.0, %dst.addr.1743.exit
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 19
  %492 = bitcast i1* %src.addr.1946 to i8*
  %493 = load i8, i8* %492
  %494 = trunc i8 %493 to i1
  switch i64 %for.loop.idx99, label %dst.addr.1947.exit [
    i64 0, label %dst.addr.1947.case.0
    i64 1, label %dst.addr.1947.case.1
    i64 2, label %dst.addr.1947.case.2
    i64 3, label %dst.addr.1947.case.3
  ]

dst.addr.1947.case.0:                             ; preds = %dst.addr.1845.exit
  %495 = bitcast i235* %dst_0 to i240*
  %496 = load i240, i240* %495
  %497 = trunc i240 %496 to i235
  %498 = zext i1 %494 to i235
  %499 = shl i235 %498, 209
  %500 = and i235 %497, -822752278660603021077484591278675252491367932816789931674304513
  %.partset160 = or i235 %500, %499
  store i235 %.partset160, i235* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %501 = bitcast i235* %dst_1 to i240*
  %502 = load i240, i240* %501
  %503 = trunc i240 %502 to i235
  %504 = zext i1 %494 to i235
  %505 = shl i235 %504, 209
  %506 = and i235 %503, -822752278660603021077484591278675252491367932816789931674304513
  %.partset109 = or i235 %506, %505
  store i235 %.partset109, i235* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.2:                             ; preds = %dst.addr.1845.exit
  %507 = bitcast i235* %dst_2 to i240*
  %508 = load i240, i240* %507
  %509 = trunc i240 %508 to i235
  %510 = zext i1 %494 to i235
  %511 = shl i235 %510, 209
  %512 = and i235 %509, -822752278660603021077484591278675252491367932816789931674304513
  %.partset70 = or i235 %512, %511
  store i235 %.partset70, i235* %dst_2, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.3:                             ; preds = %dst.addr.1845.exit
  %513 = bitcast i235* %dst_3 to i240*
  %514 = load i240, i240* %513
  %515 = trunc i240 %514 to i235
  %516 = zext i1 %494 to i235
  %517 = shl i235 %516, 209
  %518 = and i235 %515, -822752278660603021077484591278675252491367932816789931674304513
  %.partset19 = or i235 %518, %517
  store i235 %.partset19, i235* %dst_3, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.exit:                               ; preds = %dst.addr.1947.case.3, %dst.addr.1947.case.2, %dst.addr.1947.case.1, %dst.addr.1947.case.0, %dst.addr.1845.exit
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 20
  %519 = bitcast i1* %src.addr.2048 to i8*
  %520 = load i8, i8* %519
  %521 = trunc i8 %520 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2049.exit [
    i64 0, label %dst.addr.2049.case.0
    i64 1, label %dst.addr.2049.case.1
    i64 2, label %dst.addr.2049.case.2
    i64 3, label %dst.addr.2049.case.3
  ]

dst.addr.2049.case.0:                             ; preds = %dst.addr.1947.exit
  %522 = bitcast i235* %dst_0 to i240*
  %523 = load i240, i240* %522
  %524 = trunc i240 %523 to i235
  %525 = zext i1 %521 to i235
  %526 = shl i235 %525, 210
  %527 = and i235 %524, -1645504557321206042154969182557350504982735865633579863348609025
  %.partset159 = or i235 %527, %526
  store i235 %.partset159, i235* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %528 = bitcast i235* %dst_1 to i240*
  %529 = load i240, i240* %528
  %530 = trunc i240 %529 to i235
  %531 = zext i1 %521 to i235
  %532 = shl i235 %531, 210
  %533 = and i235 %530, -1645504557321206042154969182557350504982735865633579863348609025
  %.partset110 = or i235 %533, %532
  store i235 %.partset110, i235* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.2:                             ; preds = %dst.addr.1947.exit
  %534 = bitcast i235* %dst_2 to i240*
  %535 = load i240, i240* %534
  %536 = trunc i240 %535 to i235
  %537 = zext i1 %521 to i235
  %538 = shl i235 %537, 210
  %539 = and i235 %536, -1645504557321206042154969182557350504982735865633579863348609025
  %.partset69 = or i235 %539, %538
  store i235 %.partset69, i235* %dst_2, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.3:                             ; preds = %dst.addr.1947.exit
  %540 = bitcast i235* %dst_3 to i240*
  %541 = load i240, i240* %540
  %542 = trunc i240 %541 to i235
  %543 = zext i1 %521 to i235
  %544 = shl i235 %543, 210
  %545 = and i235 %542, -1645504557321206042154969182557350504982735865633579863348609025
  %.partset20 = or i235 %545, %544
  store i235 %.partset20, i235* %dst_3, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.exit:                               ; preds = %dst.addr.2049.case.3, %dst.addr.2049.case.2, %dst.addr.2049.case.1, %dst.addr.2049.case.0, %dst.addr.1947.exit
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 21
  %546 = bitcast i1* %src.addr.2150 to i8*
  %547 = load i8, i8* %546
  %548 = trunc i8 %547 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2151.exit [
    i64 0, label %dst.addr.2151.case.0
    i64 1, label %dst.addr.2151.case.1
    i64 2, label %dst.addr.2151.case.2
    i64 3, label %dst.addr.2151.case.3
  ]

dst.addr.2151.case.0:                             ; preds = %dst.addr.2049.exit
  %549 = bitcast i235* %dst_0 to i240*
  %550 = load i240, i240* %549
  %551 = trunc i240 %550 to i235
  %552 = zext i1 %548 to i235
  %553 = shl i235 %552, 211
  %554 = and i235 %551, -3291009114642412084309938365114701009965471731267159726697218049
  %.partset158 = or i235 %554, %553
  store i235 %.partset158, i235* %dst_0, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.1:                             ; preds = %dst.addr.2049.exit
  %555 = bitcast i235* %dst_1 to i240*
  %556 = load i240, i240* %555
  %557 = trunc i240 %556 to i235
  %558 = zext i1 %548 to i235
  %559 = shl i235 %558, 211
  %560 = and i235 %557, -3291009114642412084309938365114701009965471731267159726697218049
  %.partset111 = or i235 %560, %559
  store i235 %.partset111, i235* %dst_1, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.2:                             ; preds = %dst.addr.2049.exit
  %561 = bitcast i235* %dst_2 to i240*
  %562 = load i240, i240* %561
  %563 = trunc i240 %562 to i235
  %564 = zext i1 %548 to i235
  %565 = shl i235 %564, 211
  %566 = and i235 %563, -3291009114642412084309938365114701009965471731267159726697218049
  %.partset68 = or i235 %566, %565
  store i235 %.partset68, i235* %dst_2, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.3:                             ; preds = %dst.addr.2049.exit
  %567 = bitcast i235* %dst_3 to i240*
  %568 = load i240, i240* %567
  %569 = trunc i240 %568 to i235
  %570 = zext i1 %548 to i235
  %571 = shl i235 %570, 211
  %572 = and i235 %569, -3291009114642412084309938365114701009965471731267159726697218049
  %.partset21 = or i235 %572, %571
  store i235 %.partset21, i235* %dst_3, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.exit:                               ; preds = %dst.addr.2151.case.3, %dst.addr.2151.case.2, %dst.addr.2151.case.1, %dst.addr.2151.case.0, %dst.addr.2049.exit
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 22
  %573 = bitcast i1* %src.addr.2252 to i8*
  %574 = load i8, i8* %573
  %575 = trunc i8 %574 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2253.exit [
    i64 0, label %dst.addr.2253.case.0
    i64 1, label %dst.addr.2253.case.1
    i64 2, label %dst.addr.2253.case.2
    i64 3, label %dst.addr.2253.case.3
  ]

dst.addr.2253.case.0:                             ; preds = %dst.addr.2151.exit
  %576 = bitcast i235* %dst_0 to i240*
  %577 = load i240, i240* %576
  %578 = trunc i240 %577 to i235
  %579 = zext i1 %575 to i235
  %580 = shl i235 %579, 212
  %581 = and i235 %578, -6582018229284824168619876730229402019930943462534319453394436097
  %.partset157 = or i235 %581, %580
  store i235 %.partset157, i235* %dst_0, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.1:                             ; preds = %dst.addr.2151.exit
  %582 = bitcast i235* %dst_1 to i240*
  %583 = load i240, i240* %582
  %584 = trunc i240 %583 to i235
  %585 = zext i1 %575 to i235
  %586 = shl i235 %585, 212
  %587 = and i235 %584, -6582018229284824168619876730229402019930943462534319453394436097
  %.partset112 = or i235 %587, %586
  store i235 %.partset112, i235* %dst_1, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.2:                             ; preds = %dst.addr.2151.exit
  %588 = bitcast i235* %dst_2 to i240*
  %589 = load i240, i240* %588
  %590 = trunc i240 %589 to i235
  %591 = zext i1 %575 to i235
  %592 = shl i235 %591, 212
  %593 = and i235 %590, -6582018229284824168619876730229402019930943462534319453394436097
  %.partset67 = or i235 %593, %592
  store i235 %.partset67, i235* %dst_2, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.3:                             ; preds = %dst.addr.2151.exit
  %594 = bitcast i235* %dst_3 to i240*
  %595 = load i240, i240* %594
  %596 = trunc i240 %595 to i235
  %597 = zext i1 %575 to i235
  %598 = shl i235 %597, 212
  %599 = and i235 %596, -6582018229284824168619876730229402019930943462534319453394436097
  %.partset22 = or i235 %599, %598
  store i235 %.partset22, i235* %dst_3, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.exit:                               ; preds = %dst.addr.2253.case.3, %dst.addr.2253.case.2, %dst.addr.2253.case.1, %dst.addr.2253.case.0, %dst.addr.2151.exit
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 23
  %600 = bitcast i1* %src.addr.2354 to i8*
  %601 = load i8, i8* %600
  %602 = trunc i8 %601 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2355.exit [
    i64 0, label %dst.addr.2355.case.0
    i64 1, label %dst.addr.2355.case.1
    i64 2, label %dst.addr.2355.case.2
    i64 3, label %dst.addr.2355.case.3
  ]

dst.addr.2355.case.0:                             ; preds = %dst.addr.2253.exit
  %603 = bitcast i235* %dst_0 to i240*
  %604 = load i240, i240* %603
  %605 = trunc i240 %604 to i235
  %606 = zext i1 %602 to i235
  %607 = shl i235 %606, 213
  %608 = and i235 %605, -13164036458569648337239753460458804039861886925068638906788872193
  %.partset156 = or i235 %608, %607
  store i235 %.partset156, i235* %dst_0, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.1:                             ; preds = %dst.addr.2253.exit
  %609 = bitcast i235* %dst_1 to i240*
  %610 = load i240, i240* %609
  %611 = trunc i240 %610 to i235
  %612 = zext i1 %602 to i235
  %613 = shl i235 %612, 213
  %614 = and i235 %611, -13164036458569648337239753460458804039861886925068638906788872193
  %.partset113 = or i235 %614, %613
  store i235 %.partset113, i235* %dst_1, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.2:                             ; preds = %dst.addr.2253.exit
  %615 = bitcast i235* %dst_2 to i240*
  %616 = load i240, i240* %615
  %617 = trunc i240 %616 to i235
  %618 = zext i1 %602 to i235
  %619 = shl i235 %618, 213
  %620 = and i235 %617, -13164036458569648337239753460458804039861886925068638906788872193
  %.partset66 = or i235 %620, %619
  store i235 %.partset66, i235* %dst_2, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.3:                             ; preds = %dst.addr.2253.exit
  %621 = bitcast i235* %dst_3 to i240*
  %622 = load i240, i240* %621
  %623 = trunc i240 %622 to i235
  %624 = zext i1 %602 to i235
  %625 = shl i235 %624, 213
  %626 = and i235 %623, -13164036458569648337239753460458804039861886925068638906788872193
  %.partset23 = or i235 %626, %625
  store i235 %.partset23, i235* %dst_3, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.exit:                               ; preds = %dst.addr.2355.case.3, %dst.addr.2355.case.2, %dst.addr.2355.case.1, %dst.addr.2355.case.0, %dst.addr.2253.exit
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 24
  %627 = bitcast i1* %src.addr.2456 to i8*
  %628 = load i8, i8* %627
  %629 = trunc i8 %628 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2457.exit [
    i64 0, label %dst.addr.2457.case.0
    i64 1, label %dst.addr.2457.case.1
    i64 2, label %dst.addr.2457.case.2
    i64 3, label %dst.addr.2457.case.3
  ]

dst.addr.2457.case.0:                             ; preds = %dst.addr.2355.exit
  %630 = bitcast i235* %dst_0 to i240*
  %631 = load i240, i240* %630
  %632 = trunc i240 %631 to i235
  %633 = zext i1 %629 to i235
  %634 = shl i235 %633, 214
  %635 = and i235 %632, -26328072917139296674479506920917608079723773850137277813577744385
  %.partset155 = or i235 %635, %634
  store i235 %.partset155, i235* %dst_0, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.1:                             ; preds = %dst.addr.2355.exit
  %636 = bitcast i235* %dst_1 to i240*
  %637 = load i240, i240* %636
  %638 = trunc i240 %637 to i235
  %639 = zext i1 %629 to i235
  %640 = shl i235 %639, 214
  %641 = and i235 %638, -26328072917139296674479506920917608079723773850137277813577744385
  %.partset114 = or i235 %641, %640
  store i235 %.partset114, i235* %dst_1, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.2:                             ; preds = %dst.addr.2355.exit
  %642 = bitcast i235* %dst_2 to i240*
  %643 = load i240, i240* %642
  %644 = trunc i240 %643 to i235
  %645 = zext i1 %629 to i235
  %646 = shl i235 %645, 214
  %647 = and i235 %644, -26328072917139296674479506920917608079723773850137277813577744385
  %.partset65 = or i235 %647, %646
  store i235 %.partset65, i235* %dst_2, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.3:                             ; preds = %dst.addr.2355.exit
  %648 = bitcast i235* %dst_3 to i240*
  %649 = load i240, i240* %648
  %650 = trunc i240 %649 to i235
  %651 = zext i1 %629 to i235
  %652 = shl i235 %651, 214
  %653 = and i235 %650, -26328072917139296674479506920917608079723773850137277813577744385
  %.partset24 = or i235 %653, %652
  store i235 %.partset24, i235* %dst_3, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.exit:                               ; preds = %dst.addr.2457.case.3, %dst.addr.2457.case.2, %dst.addr.2457.case.1, %dst.addr.2457.case.0, %dst.addr.2355.exit
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 25
  %654 = bitcast i1* %src.addr.2558 to i8*
  %655 = load i8, i8* %654
  %656 = trunc i8 %655 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2559.exit [
    i64 0, label %dst.addr.2559.case.0
    i64 1, label %dst.addr.2559.case.1
    i64 2, label %dst.addr.2559.case.2
    i64 3, label %dst.addr.2559.case.3
  ]

dst.addr.2559.case.0:                             ; preds = %dst.addr.2457.exit
  %657 = bitcast i235* %dst_0 to i240*
  %658 = load i240, i240* %657
  %659 = trunc i240 %658 to i235
  %660 = zext i1 %656 to i235
  %661 = shl i235 %660, 215
  %662 = and i235 %659, -52656145834278593348959013841835216159447547700274555627155488769
  %.partset154 = or i235 %662, %661
  store i235 %.partset154, i235* %dst_0, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.1:                             ; preds = %dst.addr.2457.exit
  %663 = bitcast i235* %dst_1 to i240*
  %664 = load i240, i240* %663
  %665 = trunc i240 %664 to i235
  %666 = zext i1 %656 to i235
  %667 = shl i235 %666, 215
  %668 = and i235 %665, -52656145834278593348959013841835216159447547700274555627155488769
  %.partset115 = or i235 %668, %667
  store i235 %.partset115, i235* %dst_1, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.2:                             ; preds = %dst.addr.2457.exit
  %669 = bitcast i235* %dst_2 to i240*
  %670 = load i240, i240* %669
  %671 = trunc i240 %670 to i235
  %672 = zext i1 %656 to i235
  %673 = shl i235 %672, 215
  %674 = and i235 %671, -52656145834278593348959013841835216159447547700274555627155488769
  %.partset64 = or i235 %674, %673
  store i235 %.partset64, i235* %dst_2, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.3:                             ; preds = %dst.addr.2457.exit
  %675 = bitcast i235* %dst_3 to i240*
  %676 = load i240, i240* %675
  %677 = trunc i240 %676 to i235
  %678 = zext i1 %656 to i235
  %679 = shl i235 %678, 215
  %680 = and i235 %677, -52656145834278593348959013841835216159447547700274555627155488769
  %.partset25 = or i235 %680, %679
  store i235 %.partset25, i235* %dst_3, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.exit:                               ; preds = %dst.addr.2559.case.3, %dst.addr.2559.case.2, %dst.addr.2559.case.1, %dst.addr.2559.case.0, %dst.addr.2457.exit
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 26
  %681 = bitcast i1* %src.addr.2660 to i8*
  %682 = load i8, i8* %681
  %683 = trunc i8 %682 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2661.exit [
    i64 0, label %dst.addr.2661.case.0
    i64 1, label %dst.addr.2661.case.1
    i64 2, label %dst.addr.2661.case.2
    i64 3, label %dst.addr.2661.case.3
  ]

dst.addr.2661.case.0:                             ; preds = %dst.addr.2559.exit
  %684 = bitcast i235* %dst_0 to i240*
  %685 = load i240, i240* %684
  %686 = trunc i240 %685 to i235
  %687 = zext i1 %683 to i235
  %688 = shl i235 %687, 216
  %689 = and i235 %686, -105312291668557186697918027683670432318895095400549111254310977537
  %.partset153 = or i235 %689, %688
  store i235 %.partset153, i235* %dst_0, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.1:                             ; preds = %dst.addr.2559.exit
  %690 = bitcast i235* %dst_1 to i240*
  %691 = load i240, i240* %690
  %692 = trunc i240 %691 to i235
  %693 = zext i1 %683 to i235
  %694 = shl i235 %693, 216
  %695 = and i235 %692, -105312291668557186697918027683670432318895095400549111254310977537
  %.partset116 = or i235 %695, %694
  store i235 %.partset116, i235* %dst_1, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.2:                             ; preds = %dst.addr.2559.exit
  %696 = bitcast i235* %dst_2 to i240*
  %697 = load i240, i240* %696
  %698 = trunc i240 %697 to i235
  %699 = zext i1 %683 to i235
  %700 = shl i235 %699, 216
  %701 = and i235 %698, -105312291668557186697918027683670432318895095400549111254310977537
  %.partset63 = or i235 %701, %700
  store i235 %.partset63, i235* %dst_2, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.3:                             ; preds = %dst.addr.2559.exit
  %702 = bitcast i235* %dst_3 to i240*
  %703 = load i240, i240* %702
  %704 = trunc i240 %703 to i235
  %705 = zext i1 %683 to i235
  %706 = shl i235 %705, 216
  %707 = and i235 %704, -105312291668557186697918027683670432318895095400549111254310977537
  %.partset26 = or i235 %707, %706
  store i235 %.partset26, i235* %dst_3, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.exit:                               ; preds = %dst.addr.2661.case.3, %dst.addr.2661.case.2, %dst.addr.2661.case.1, %dst.addr.2661.case.0, %dst.addr.2559.exit
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 27
  %708 = bitcast i1* %src.addr.2762 to i8*
  %709 = load i8, i8* %708
  %710 = trunc i8 %709 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2763.exit [
    i64 0, label %dst.addr.2763.case.0
    i64 1, label %dst.addr.2763.case.1
    i64 2, label %dst.addr.2763.case.2
    i64 3, label %dst.addr.2763.case.3
  ]

dst.addr.2763.case.0:                             ; preds = %dst.addr.2661.exit
  %711 = bitcast i235* %dst_0 to i240*
  %712 = load i240, i240* %711
  %713 = trunc i240 %712 to i235
  %714 = zext i1 %710 to i235
  %715 = shl i235 %714, 217
  %716 = and i235 %713, -210624583337114373395836055367340864637790190801098222508621955073
  %.partset152 = or i235 %716, %715
  store i235 %.partset152, i235* %dst_0, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.1:                             ; preds = %dst.addr.2661.exit
  %717 = bitcast i235* %dst_1 to i240*
  %718 = load i240, i240* %717
  %719 = trunc i240 %718 to i235
  %720 = zext i1 %710 to i235
  %721 = shl i235 %720, 217
  %722 = and i235 %719, -210624583337114373395836055367340864637790190801098222508621955073
  %.partset117 = or i235 %722, %721
  store i235 %.partset117, i235* %dst_1, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.2:                             ; preds = %dst.addr.2661.exit
  %723 = bitcast i235* %dst_2 to i240*
  %724 = load i240, i240* %723
  %725 = trunc i240 %724 to i235
  %726 = zext i1 %710 to i235
  %727 = shl i235 %726, 217
  %728 = and i235 %725, -210624583337114373395836055367340864637790190801098222508621955073
  %.partset62 = or i235 %728, %727
  store i235 %.partset62, i235* %dst_2, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.3:                             ; preds = %dst.addr.2661.exit
  %729 = bitcast i235* %dst_3 to i240*
  %730 = load i240, i240* %729
  %731 = trunc i240 %730 to i235
  %732 = zext i1 %710 to i235
  %733 = shl i235 %732, 217
  %734 = and i235 %731, -210624583337114373395836055367340864637790190801098222508621955073
  %.partset27 = or i235 %734, %733
  store i235 %.partset27, i235* %dst_3, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.exit:                               ; preds = %dst.addr.2763.case.3, %dst.addr.2763.case.2, %dst.addr.2763.case.1, %dst.addr.2763.case.0, %dst.addr.2661.exit
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 28
  %735 = bitcast i1* %src.addr.2864 to i8*
  %736 = load i8, i8* %735
  %737 = trunc i8 %736 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2865.exit [
    i64 0, label %dst.addr.2865.case.0
    i64 1, label %dst.addr.2865.case.1
    i64 2, label %dst.addr.2865.case.2
    i64 3, label %dst.addr.2865.case.3
  ]

dst.addr.2865.case.0:                             ; preds = %dst.addr.2763.exit
  %738 = bitcast i235* %dst_0 to i240*
  %739 = load i240, i240* %738
  %740 = trunc i240 %739 to i235
  %741 = zext i1 %737 to i235
  %742 = shl i235 %741, 218
  %743 = and i235 %740, -421249166674228746791672110734681729275580381602196445017243910145
  %.partset151 = or i235 %743, %742
  store i235 %.partset151, i235* %dst_0, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.1:                             ; preds = %dst.addr.2763.exit
  %744 = bitcast i235* %dst_1 to i240*
  %745 = load i240, i240* %744
  %746 = trunc i240 %745 to i235
  %747 = zext i1 %737 to i235
  %748 = shl i235 %747, 218
  %749 = and i235 %746, -421249166674228746791672110734681729275580381602196445017243910145
  %.partset118 = or i235 %749, %748
  store i235 %.partset118, i235* %dst_1, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.2:                             ; preds = %dst.addr.2763.exit
  %750 = bitcast i235* %dst_2 to i240*
  %751 = load i240, i240* %750
  %752 = trunc i240 %751 to i235
  %753 = zext i1 %737 to i235
  %754 = shl i235 %753, 218
  %755 = and i235 %752, -421249166674228746791672110734681729275580381602196445017243910145
  %.partset61 = or i235 %755, %754
  store i235 %.partset61, i235* %dst_2, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.3:                             ; preds = %dst.addr.2763.exit
  %756 = bitcast i235* %dst_3 to i240*
  %757 = load i240, i240* %756
  %758 = trunc i240 %757 to i235
  %759 = zext i1 %737 to i235
  %760 = shl i235 %759, 218
  %761 = and i235 %758, -421249166674228746791672110734681729275580381602196445017243910145
  %.partset28 = or i235 %761, %760
  store i235 %.partset28, i235* %dst_3, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.exit:                               ; preds = %dst.addr.2865.case.3, %dst.addr.2865.case.2, %dst.addr.2865.case.1, %dst.addr.2865.case.0, %dst.addr.2763.exit
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 29
  %762 = bitcast i1* %src.addr.2966 to i8*
  %763 = load i8, i8* %762
  %764 = trunc i8 %763 to i1
  switch i64 %for.loop.idx99, label %dst.addr.2967.exit [
    i64 0, label %dst.addr.2967.case.0
    i64 1, label %dst.addr.2967.case.1
    i64 2, label %dst.addr.2967.case.2
    i64 3, label %dst.addr.2967.case.3
  ]

dst.addr.2967.case.0:                             ; preds = %dst.addr.2865.exit
  %765 = bitcast i235* %dst_0 to i240*
  %766 = load i240, i240* %765
  %767 = trunc i240 %766 to i235
  %768 = zext i1 %764 to i235
  %769 = shl i235 %768, 219
  %770 = and i235 %767, -842498333348457493583344221469363458551160763204392890034487820289
  %.partset150 = or i235 %770, %769
  store i235 %.partset150, i235* %dst_0, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.1:                             ; preds = %dst.addr.2865.exit
  %771 = bitcast i235* %dst_1 to i240*
  %772 = load i240, i240* %771
  %773 = trunc i240 %772 to i235
  %774 = zext i1 %764 to i235
  %775 = shl i235 %774, 219
  %776 = and i235 %773, -842498333348457493583344221469363458551160763204392890034487820289
  %.partset119 = or i235 %776, %775
  store i235 %.partset119, i235* %dst_1, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.2:                             ; preds = %dst.addr.2865.exit
  %777 = bitcast i235* %dst_2 to i240*
  %778 = load i240, i240* %777
  %779 = trunc i240 %778 to i235
  %780 = zext i1 %764 to i235
  %781 = shl i235 %780, 219
  %782 = and i235 %779, -842498333348457493583344221469363458551160763204392890034487820289
  %.partset60 = or i235 %782, %781
  store i235 %.partset60, i235* %dst_2, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.3:                             ; preds = %dst.addr.2865.exit
  %783 = bitcast i235* %dst_3 to i240*
  %784 = load i240, i240* %783
  %785 = trunc i240 %784 to i235
  %786 = zext i1 %764 to i235
  %787 = shl i235 %786, 219
  %788 = and i235 %785, -842498333348457493583344221469363458551160763204392890034487820289
  %.partset29 = or i235 %788, %787
  store i235 %.partset29, i235* %dst_3, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.exit:                               ; preds = %dst.addr.2967.case.3, %dst.addr.2967.case.2, %dst.addr.2967.case.1, %dst.addr.2967.case.0, %dst.addr.2865.exit
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 30
  %789 = bitcast i1* %src.addr.3068 to i8*
  %790 = load i8, i8* %789
  %791 = trunc i8 %790 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3069.exit [
    i64 0, label %dst.addr.3069.case.0
    i64 1, label %dst.addr.3069.case.1
    i64 2, label %dst.addr.3069.case.2
    i64 3, label %dst.addr.3069.case.3
  ]

dst.addr.3069.case.0:                             ; preds = %dst.addr.2967.exit
  %792 = bitcast i235* %dst_0 to i240*
  %793 = load i240, i240* %792
  %794 = trunc i240 %793 to i235
  %795 = zext i1 %791 to i235
  %796 = shl i235 %795, 220
  %797 = and i235 %794, -1684996666696914987166688442938726917102321526408785780068975640577
  %.partset149 = or i235 %797, %796
  store i235 %.partset149, i235* %dst_0, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.1:                             ; preds = %dst.addr.2967.exit
  %798 = bitcast i235* %dst_1 to i240*
  %799 = load i240, i240* %798
  %800 = trunc i240 %799 to i235
  %801 = zext i1 %791 to i235
  %802 = shl i235 %801, 220
  %803 = and i235 %800, -1684996666696914987166688442938726917102321526408785780068975640577
  %.partset120 = or i235 %803, %802
  store i235 %.partset120, i235* %dst_1, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.2:                             ; preds = %dst.addr.2967.exit
  %804 = bitcast i235* %dst_2 to i240*
  %805 = load i240, i240* %804
  %806 = trunc i240 %805 to i235
  %807 = zext i1 %791 to i235
  %808 = shl i235 %807, 220
  %809 = and i235 %806, -1684996666696914987166688442938726917102321526408785780068975640577
  %.partset59 = or i235 %809, %808
  store i235 %.partset59, i235* %dst_2, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.3:                             ; preds = %dst.addr.2967.exit
  %810 = bitcast i235* %dst_3 to i240*
  %811 = load i240, i240* %810
  %812 = trunc i240 %811 to i235
  %813 = zext i1 %791 to i235
  %814 = shl i235 %813, 220
  %815 = and i235 %812, -1684996666696914987166688442938726917102321526408785780068975640577
  %.partset30 = or i235 %815, %814
  store i235 %.partset30, i235* %dst_3, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.exit:                               ; preds = %dst.addr.3069.case.3, %dst.addr.3069.case.2, %dst.addr.3069.case.1, %dst.addr.3069.case.0, %dst.addr.2967.exit
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 31
  %816 = bitcast i1* %src.addr.3170 to i8*
  %817 = load i8, i8* %816
  %818 = trunc i8 %817 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3171.exit [
    i64 0, label %dst.addr.3171.case.0
    i64 1, label %dst.addr.3171.case.1
    i64 2, label %dst.addr.3171.case.2
    i64 3, label %dst.addr.3171.case.3
  ]

dst.addr.3171.case.0:                             ; preds = %dst.addr.3069.exit
  %819 = bitcast i235* %dst_0 to i240*
  %820 = load i240, i240* %819
  %821 = trunc i240 %820 to i235
  %822 = zext i1 %818 to i235
  %823 = shl i235 %822, 221
  %824 = and i235 %821, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset148 = or i235 %824, %823
  store i235 %.partset148, i235* %dst_0, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.1:                             ; preds = %dst.addr.3069.exit
  %825 = bitcast i235* %dst_1 to i240*
  %826 = load i240, i240* %825
  %827 = trunc i240 %826 to i235
  %828 = zext i1 %818 to i235
  %829 = shl i235 %828, 221
  %830 = and i235 %827, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset121 = or i235 %830, %829
  store i235 %.partset121, i235* %dst_1, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.2:                             ; preds = %dst.addr.3069.exit
  %831 = bitcast i235* %dst_2 to i240*
  %832 = load i240, i240* %831
  %833 = trunc i240 %832 to i235
  %834 = zext i1 %818 to i235
  %835 = shl i235 %834, 221
  %836 = and i235 %833, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset58 = or i235 %836, %835
  store i235 %.partset58, i235* %dst_2, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.3:                             ; preds = %dst.addr.3069.exit
  %837 = bitcast i235* %dst_3 to i240*
  %838 = load i240, i240* %837
  %839 = trunc i240 %838 to i235
  %840 = zext i1 %818 to i235
  %841 = shl i235 %840, 221
  %842 = and i235 %839, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset31 = or i235 %842, %841
  store i235 %.partset31, i235* %dst_3, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.exit:                               ; preds = %dst.addr.3171.case.3, %dst.addr.3171.case.2, %dst.addr.3171.case.1, %dst.addr.3171.case.0, %dst.addr.3069.exit
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 32
  %843 = bitcast i1* %src.addr.3272 to i8*
  %844 = load i8, i8* %843
  %845 = trunc i8 %844 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3273.exit [
    i64 0, label %dst.addr.3273.case.0
    i64 1, label %dst.addr.3273.case.1
    i64 2, label %dst.addr.3273.case.2
    i64 3, label %dst.addr.3273.case.3
  ]

dst.addr.3273.case.0:                             ; preds = %dst.addr.3171.exit
  %846 = bitcast i235* %dst_0 to i240*
  %847 = load i240, i240* %846
  %848 = trunc i240 %847 to i235
  %849 = zext i1 %845 to i235
  %850 = shl i235 %849, 222
  %851 = and i235 %848, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset147 = or i235 %851, %850
  store i235 %.partset147, i235* %dst_0, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.1:                             ; preds = %dst.addr.3171.exit
  %852 = bitcast i235* %dst_1 to i240*
  %853 = load i240, i240* %852
  %854 = trunc i240 %853 to i235
  %855 = zext i1 %845 to i235
  %856 = shl i235 %855, 222
  %857 = and i235 %854, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset122 = or i235 %857, %856
  store i235 %.partset122, i235* %dst_1, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.2:                             ; preds = %dst.addr.3171.exit
  %858 = bitcast i235* %dst_2 to i240*
  %859 = load i240, i240* %858
  %860 = trunc i240 %859 to i235
  %861 = zext i1 %845 to i235
  %862 = shl i235 %861, 222
  %863 = and i235 %860, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset57 = or i235 %863, %862
  store i235 %.partset57, i235* %dst_2, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.3:                             ; preds = %dst.addr.3171.exit
  %864 = bitcast i235* %dst_3 to i240*
  %865 = load i240, i240* %864
  %866 = trunc i240 %865 to i235
  %867 = zext i1 %845 to i235
  %868 = shl i235 %867, 222
  %869 = and i235 %866, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset32 = or i235 %869, %868
  store i235 %.partset32, i235* %dst_3, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.exit:                               ; preds = %dst.addr.3273.case.3, %dst.addr.3273.case.2, %dst.addr.3273.case.1, %dst.addr.3273.case.0, %dst.addr.3171.exit
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 33
  %870 = bitcast i1* %src.addr.3374 to i8*
  %871 = load i8, i8* %870
  %872 = trunc i8 %871 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3375.exit [
    i64 0, label %dst.addr.3375.case.0
    i64 1, label %dst.addr.3375.case.1
    i64 2, label %dst.addr.3375.case.2
    i64 3, label %dst.addr.3375.case.3
  ]

dst.addr.3375.case.0:                             ; preds = %dst.addr.3273.exit
  %873 = bitcast i235* %dst_0 to i240*
  %874 = load i240, i240* %873
  %875 = trunc i240 %874 to i235
  %876 = zext i1 %872 to i235
  %877 = shl i235 %876, 223
  %878 = and i235 %875, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset146 = or i235 %878, %877
  store i235 %.partset146, i235* %dst_0, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.1:                             ; preds = %dst.addr.3273.exit
  %879 = bitcast i235* %dst_1 to i240*
  %880 = load i240, i240* %879
  %881 = trunc i240 %880 to i235
  %882 = zext i1 %872 to i235
  %883 = shl i235 %882, 223
  %884 = and i235 %881, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset123 = or i235 %884, %883
  store i235 %.partset123, i235* %dst_1, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.2:                             ; preds = %dst.addr.3273.exit
  %885 = bitcast i235* %dst_2 to i240*
  %886 = load i240, i240* %885
  %887 = trunc i240 %886 to i235
  %888 = zext i1 %872 to i235
  %889 = shl i235 %888, 223
  %890 = and i235 %887, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset56 = or i235 %890, %889
  store i235 %.partset56, i235* %dst_2, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.3:                             ; preds = %dst.addr.3273.exit
  %891 = bitcast i235* %dst_3 to i240*
  %892 = load i240, i240* %891
  %893 = trunc i240 %892 to i235
  %894 = zext i1 %872 to i235
  %895 = shl i235 %894, 223
  %896 = and i235 %893, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset33 = or i235 %896, %895
  store i235 %.partset33, i235* %dst_3, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.exit:                               ; preds = %dst.addr.3375.case.3, %dst.addr.3375.case.2, %dst.addr.3375.case.1, %dst.addr.3375.case.0, %dst.addr.3273.exit
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 34
  %897 = bitcast i1* %src.addr.3476 to i8*
  %898 = load i8, i8* %897
  %899 = trunc i8 %898 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3477.exit [
    i64 0, label %dst.addr.3477.case.0
    i64 1, label %dst.addr.3477.case.1
    i64 2, label %dst.addr.3477.case.2
    i64 3, label %dst.addr.3477.case.3
  ]

dst.addr.3477.case.0:                             ; preds = %dst.addr.3375.exit
  %900 = bitcast i235* %dst_0 to i240*
  %901 = load i240, i240* %900
  %902 = trunc i240 %901 to i235
  %903 = zext i1 %899 to i235
  %904 = shl i235 %903, 224
  %905 = and i235 %902, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset145 = or i235 %905, %904
  store i235 %.partset145, i235* %dst_0, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.1:                             ; preds = %dst.addr.3375.exit
  %906 = bitcast i235* %dst_1 to i240*
  %907 = load i240, i240* %906
  %908 = trunc i240 %907 to i235
  %909 = zext i1 %899 to i235
  %910 = shl i235 %909, 224
  %911 = and i235 %908, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset124 = or i235 %911, %910
  store i235 %.partset124, i235* %dst_1, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.2:                             ; preds = %dst.addr.3375.exit
  %912 = bitcast i235* %dst_2 to i240*
  %913 = load i240, i240* %912
  %914 = trunc i240 %913 to i235
  %915 = zext i1 %899 to i235
  %916 = shl i235 %915, 224
  %917 = and i235 %914, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset55 = or i235 %917, %916
  store i235 %.partset55, i235* %dst_2, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.3:                             ; preds = %dst.addr.3375.exit
  %918 = bitcast i235* %dst_3 to i240*
  %919 = load i240, i240* %918
  %920 = trunc i240 %919 to i235
  %921 = zext i1 %899 to i235
  %922 = shl i235 %921, 224
  %923 = and i235 %920, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset34 = or i235 %923, %922
  store i235 %.partset34, i235* %dst_3, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.exit:                               ; preds = %dst.addr.3477.case.3, %dst.addr.3477.case.2, %dst.addr.3477.case.1, %dst.addr.3477.case.0, %dst.addr.3375.exit
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 35
  %924 = bitcast i1* %src.addr.3578 to i8*
  %925 = load i8, i8* %924
  %926 = trunc i8 %925 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3579.exit [
    i64 0, label %dst.addr.3579.case.0
    i64 1, label %dst.addr.3579.case.1
    i64 2, label %dst.addr.3579.case.2
    i64 3, label %dst.addr.3579.case.3
  ]

dst.addr.3579.case.0:                             ; preds = %dst.addr.3477.exit
  %927 = bitcast i235* %dst_0 to i240*
  %928 = load i240, i240* %927
  %929 = trunc i240 %928 to i235
  %930 = zext i1 %926 to i235
  %931 = shl i235 %930, 225
  %932 = and i235 %929, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset144 = or i235 %932, %931
  store i235 %.partset144, i235* %dst_0, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.1:                             ; preds = %dst.addr.3477.exit
  %933 = bitcast i235* %dst_1 to i240*
  %934 = load i240, i240* %933
  %935 = trunc i240 %934 to i235
  %936 = zext i1 %926 to i235
  %937 = shl i235 %936, 225
  %938 = and i235 %935, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset125 = or i235 %938, %937
  store i235 %.partset125, i235* %dst_1, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.2:                             ; preds = %dst.addr.3477.exit
  %939 = bitcast i235* %dst_2 to i240*
  %940 = load i240, i240* %939
  %941 = trunc i240 %940 to i235
  %942 = zext i1 %926 to i235
  %943 = shl i235 %942, 225
  %944 = and i235 %941, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset54 = or i235 %944, %943
  store i235 %.partset54, i235* %dst_2, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.3:                             ; preds = %dst.addr.3477.exit
  %945 = bitcast i235* %dst_3 to i240*
  %946 = load i240, i240* %945
  %947 = trunc i240 %946 to i235
  %948 = zext i1 %926 to i235
  %949 = shl i235 %948, 225
  %950 = and i235 %947, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset35 = or i235 %950, %949
  store i235 %.partset35, i235* %dst_3, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.exit:                               ; preds = %dst.addr.3579.case.3, %dst.addr.3579.case.2, %dst.addr.3579.case.1, %dst.addr.3579.case.0, %dst.addr.3477.exit
  %src.addr.3680 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 36
  %951 = bitcast i1* %src.addr.3680 to i8*
  %952 = load i8, i8* %951
  %953 = trunc i8 %952 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3681.exit [
    i64 0, label %dst.addr.3681.case.0
    i64 1, label %dst.addr.3681.case.1
    i64 2, label %dst.addr.3681.case.2
    i64 3, label %dst.addr.3681.case.3
  ]

dst.addr.3681.case.0:                             ; preds = %dst.addr.3579.exit
  %954 = bitcast i235* %dst_0 to i240*
  %955 = load i240, i240* %954
  %956 = trunc i240 %955 to i235
  %957 = zext i1 %953 to i235
  %958 = shl i235 %957, 226
  %959 = and i235 %956, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset143 = or i235 %959, %958
  store i235 %.partset143, i235* %dst_0, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.1:                             ; preds = %dst.addr.3579.exit
  %960 = bitcast i235* %dst_1 to i240*
  %961 = load i240, i240* %960
  %962 = trunc i240 %961 to i235
  %963 = zext i1 %953 to i235
  %964 = shl i235 %963, 226
  %965 = and i235 %962, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset126 = or i235 %965, %964
  store i235 %.partset126, i235* %dst_1, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.2:                             ; preds = %dst.addr.3579.exit
  %966 = bitcast i235* %dst_2 to i240*
  %967 = load i240, i240* %966
  %968 = trunc i240 %967 to i235
  %969 = zext i1 %953 to i235
  %970 = shl i235 %969, 226
  %971 = and i235 %968, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset53 = or i235 %971, %970
  store i235 %.partset53, i235* %dst_2, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.3:                             ; preds = %dst.addr.3579.exit
  %972 = bitcast i235* %dst_3 to i240*
  %973 = load i240, i240* %972
  %974 = trunc i240 %973 to i235
  %975 = zext i1 %953 to i235
  %976 = shl i235 %975, 226
  %977 = and i235 %974, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset36 = or i235 %977, %976
  store i235 %.partset36, i235* %dst_3, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.exit:                               ; preds = %dst.addr.3681.case.3, %dst.addr.3681.case.2, %dst.addr.3681.case.1, %dst.addr.3681.case.0, %dst.addr.3579.exit
  %src.addr.3782 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 37
  %978 = bitcast i1* %src.addr.3782 to i8*
  %979 = load i8, i8* %978
  %980 = trunc i8 %979 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3783.exit [
    i64 0, label %dst.addr.3783.case.0
    i64 1, label %dst.addr.3783.case.1
    i64 2, label %dst.addr.3783.case.2
    i64 3, label %dst.addr.3783.case.3
  ]

dst.addr.3783.case.0:                             ; preds = %dst.addr.3681.exit
  %981 = bitcast i235* %dst_0 to i240*
  %982 = load i240, i240* %981
  %983 = trunc i240 %982 to i235
  %984 = zext i1 %980 to i235
  %985 = shl i235 %984, 227
  %986 = and i235 %983, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset142 = or i235 %986, %985
  store i235 %.partset142, i235* %dst_0, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.1:                             ; preds = %dst.addr.3681.exit
  %987 = bitcast i235* %dst_1 to i240*
  %988 = load i240, i240* %987
  %989 = trunc i240 %988 to i235
  %990 = zext i1 %980 to i235
  %991 = shl i235 %990, 227
  %992 = and i235 %989, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset127 = or i235 %992, %991
  store i235 %.partset127, i235* %dst_1, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.2:                             ; preds = %dst.addr.3681.exit
  %993 = bitcast i235* %dst_2 to i240*
  %994 = load i240, i240* %993
  %995 = trunc i240 %994 to i235
  %996 = zext i1 %980 to i235
  %997 = shl i235 %996, 227
  %998 = and i235 %995, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset52 = or i235 %998, %997
  store i235 %.partset52, i235* %dst_2, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.3:                             ; preds = %dst.addr.3681.exit
  %999 = bitcast i235* %dst_3 to i240*
  %1000 = load i240, i240* %999
  %1001 = trunc i240 %1000 to i235
  %1002 = zext i1 %980 to i235
  %1003 = shl i235 %1002, 227
  %1004 = and i235 %1001, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset37 = or i235 %1004, %1003
  store i235 %.partset37, i235* %dst_3, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.exit:                               ; preds = %dst.addr.3783.case.3, %dst.addr.3783.case.2, %dst.addr.3783.case.1, %dst.addr.3783.case.0, %dst.addr.3681.exit
  %src.addr.3884 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 38
  %1005 = bitcast i1* %src.addr.3884 to i8*
  %1006 = load i8, i8* %1005
  %1007 = trunc i8 %1006 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3885.exit [
    i64 0, label %dst.addr.3885.case.0
    i64 1, label %dst.addr.3885.case.1
    i64 2, label %dst.addr.3885.case.2
    i64 3, label %dst.addr.3885.case.3
  ]

dst.addr.3885.case.0:                             ; preds = %dst.addr.3783.exit
  %1008 = bitcast i235* %dst_0 to i240*
  %1009 = load i240, i240* %1008
  %1010 = trunc i240 %1009 to i235
  %1011 = zext i1 %1007 to i235
  %1012 = shl i235 %1011, 228
  %1013 = and i235 %1010, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset141 = or i235 %1013, %1012
  store i235 %.partset141, i235* %dst_0, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.1:                             ; preds = %dst.addr.3783.exit
  %1014 = bitcast i235* %dst_1 to i240*
  %1015 = load i240, i240* %1014
  %1016 = trunc i240 %1015 to i235
  %1017 = zext i1 %1007 to i235
  %1018 = shl i235 %1017, 228
  %1019 = and i235 %1016, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset128 = or i235 %1019, %1018
  store i235 %.partset128, i235* %dst_1, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.2:                             ; preds = %dst.addr.3783.exit
  %1020 = bitcast i235* %dst_2 to i240*
  %1021 = load i240, i240* %1020
  %1022 = trunc i240 %1021 to i235
  %1023 = zext i1 %1007 to i235
  %1024 = shl i235 %1023, 228
  %1025 = and i235 %1022, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset51 = or i235 %1025, %1024
  store i235 %.partset51, i235* %dst_2, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.3:                             ; preds = %dst.addr.3783.exit
  %1026 = bitcast i235* %dst_3 to i240*
  %1027 = load i240, i240* %1026
  %1028 = trunc i240 %1027 to i235
  %1029 = zext i1 %1007 to i235
  %1030 = shl i235 %1029, 228
  %1031 = and i235 %1028, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset38 = or i235 %1031, %1030
  store i235 %.partset38, i235* %dst_3, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.exit:                               ; preds = %dst.addr.3885.case.3, %dst.addr.3885.case.2, %dst.addr.3885.case.1, %dst.addr.3885.case.0, %dst.addr.3783.exit
  %src.addr.3986 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 39
  %1032 = bitcast i1* %src.addr.3986 to i8*
  %1033 = load i8, i8* %1032
  %1034 = trunc i8 %1033 to i1
  switch i64 %for.loop.idx99, label %dst.addr.3987.exit [
    i64 0, label %dst.addr.3987.case.0
    i64 1, label %dst.addr.3987.case.1
    i64 2, label %dst.addr.3987.case.2
    i64 3, label %dst.addr.3987.case.3
  ]

dst.addr.3987.case.0:                             ; preds = %dst.addr.3885.exit
  %1035 = bitcast i235* %dst_0 to i240*
  %1036 = load i240, i240* %1035
  %1037 = trunc i240 %1036 to i235
  %1038 = zext i1 %1034 to i235
  %1039 = shl i235 %1038, 229
  %1040 = and i235 %1037, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset140 = or i235 %1040, %1039
  store i235 %.partset140, i235* %dst_0, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.1:                             ; preds = %dst.addr.3885.exit
  %1041 = bitcast i235* %dst_1 to i240*
  %1042 = load i240, i240* %1041
  %1043 = trunc i240 %1042 to i235
  %1044 = zext i1 %1034 to i235
  %1045 = shl i235 %1044, 229
  %1046 = and i235 %1043, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset129 = or i235 %1046, %1045
  store i235 %.partset129, i235* %dst_1, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.2:                             ; preds = %dst.addr.3885.exit
  %1047 = bitcast i235* %dst_2 to i240*
  %1048 = load i240, i240* %1047
  %1049 = trunc i240 %1048 to i235
  %1050 = zext i1 %1034 to i235
  %1051 = shl i235 %1050, 229
  %1052 = and i235 %1049, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset50 = or i235 %1052, %1051
  store i235 %.partset50, i235* %dst_2, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.3:                             ; preds = %dst.addr.3885.exit
  %1053 = bitcast i235* %dst_3 to i240*
  %1054 = load i240, i240* %1053
  %1055 = trunc i240 %1054 to i235
  %1056 = zext i1 %1034 to i235
  %1057 = shl i235 %1056, 229
  %1058 = and i235 %1055, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset39 = or i235 %1058, %1057
  store i235 %.partset39, i235* %dst_3, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.exit:                               ; preds = %dst.addr.3987.case.3, %dst.addr.3987.case.2, %dst.addr.3987.case.1, %dst.addr.3987.case.0, %dst.addr.3885.exit
  %src.addr.4088 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 40
  %1059 = bitcast i1* %src.addr.4088 to i8*
  %1060 = load i8, i8* %1059
  %1061 = trunc i8 %1060 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4089.exit [
    i64 0, label %dst.addr.4089.case.0
    i64 1, label %dst.addr.4089.case.1
    i64 2, label %dst.addr.4089.case.2
    i64 3, label %dst.addr.4089.case.3
  ]

dst.addr.4089.case.0:                             ; preds = %dst.addr.3987.exit
  %1062 = bitcast i235* %dst_0 to i240*
  %1063 = load i240, i240* %1062
  %1064 = trunc i240 %1063 to i235
  %1065 = zext i1 %1061 to i235
  %1066 = shl i235 %1065, 230
  %1067 = and i235 %1064, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset139 = or i235 %1067, %1066
  store i235 %.partset139, i235* %dst_0, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.1:                             ; preds = %dst.addr.3987.exit
  %1068 = bitcast i235* %dst_1 to i240*
  %1069 = load i240, i240* %1068
  %1070 = trunc i240 %1069 to i235
  %1071 = zext i1 %1061 to i235
  %1072 = shl i235 %1071, 230
  %1073 = and i235 %1070, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset130 = or i235 %1073, %1072
  store i235 %.partset130, i235* %dst_1, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.2:                             ; preds = %dst.addr.3987.exit
  %1074 = bitcast i235* %dst_2 to i240*
  %1075 = load i240, i240* %1074
  %1076 = trunc i240 %1075 to i235
  %1077 = zext i1 %1061 to i235
  %1078 = shl i235 %1077, 230
  %1079 = and i235 %1076, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset49 = or i235 %1079, %1078
  store i235 %.partset49, i235* %dst_2, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.3:                             ; preds = %dst.addr.3987.exit
  %1080 = bitcast i235* %dst_3 to i240*
  %1081 = load i240, i240* %1080
  %1082 = trunc i240 %1081 to i235
  %1083 = zext i1 %1061 to i235
  %1084 = shl i235 %1083, 230
  %1085 = and i235 %1082, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset40 = or i235 %1085, %1084
  store i235 %.partset40, i235* %dst_3, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.exit:                               ; preds = %dst.addr.4089.case.3, %dst.addr.4089.case.2, %dst.addr.4089.case.1, %dst.addr.4089.case.0, %dst.addr.3987.exit
  %src.addr.4190 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 41
  %1086 = bitcast i1* %src.addr.4190 to i8*
  %1087 = load i8, i8* %1086
  %1088 = trunc i8 %1087 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4191.exit [
    i64 0, label %dst.addr.4191.case.0
    i64 1, label %dst.addr.4191.case.1
    i64 2, label %dst.addr.4191.case.2
    i64 3, label %dst.addr.4191.case.3
  ]

dst.addr.4191.case.0:                             ; preds = %dst.addr.4089.exit
  %1089 = bitcast i235* %dst_0 to i240*
  %1090 = load i240, i240* %1089
  %1091 = trunc i240 %1090 to i235
  %1092 = zext i1 %1088 to i235
  %1093 = shl i235 %1092, 231
  %1094 = and i235 %1091, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset138 = or i235 %1094, %1093
  store i235 %.partset138, i235* %dst_0, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.1:                             ; preds = %dst.addr.4089.exit
  %1095 = bitcast i235* %dst_1 to i240*
  %1096 = load i240, i240* %1095
  %1097 = trunc i240 %1096 to i235
  %1098 = zext i1 %1088 to i235
  %1099 = shl i235 %1098, 231
  %1100 = and i235 %1097, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset131 = or i235 %1100, %1099
  store i235 %.partset131, i235* %dst_1, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.2:                             ; preds = %dst.addr.4089.exit
  %1101 = bitcast i235* %dst_2 to i240*
  %1102 = load i240, i240* %1101
  %1103 = trunc i240 %1102 to i235
  %1104 = zext i1 %1088 to i235
  %1105 = shl i235 %1104, 231
  %1106 = and i235 %1103, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset48 = or i235 %1106, %1105
  store i235 %.partset48, i235* %dst_2, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.3:                             ; preds = %dst.addr.4089.exit
  %1107 = bitcast i235* %dst_3 to i240*
  %1108 = load i240, i240* %1107
  %1109 = trunc i240 %1108 to i235
  %1110 = zext i1 %1088 to i235
  %1111 = shl i235 %1110, 231
  %1112 = and i235 %1109, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset41 = or i235 %1112, %1111
  store i235 %.partset41, i235* %dst_3, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.exit:                               ; preds = %dst.addr.4191.case.3, %dst.addr.4191.case.2, %dst.addr.4191.case.1, %dst.addr.4191.case.0, %dst.addr.4089.exit
  %src.addr.4292 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 42
  %1113 = bitcast i1* %src.addr.4292 to i8*
  %1114 = load i8, i8* %1113
  %1115 = trunc i8 %1114 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4293.exit [
    i64 0, label %dst.addr.4293.case.0
    i64 1, label %dst.addr.4293.case.1
    i64 2, label %dst.addr.4293.case.2
    i64 3, label %dst.addr.4293.case.3
  ]

dst.addr.4293.case.0:                             ; preds = %dst.addr.4191.exit
  %1116 = bitcast i235* %dst_0 to i240*
  %1117 = load i240, i240* %1116
  %1118 = trunc i240 %1117 to i235
  %1119 = zext i1 %1115 to i235
  %1120 = shl i235 %1119, 232
  %1121 = and i235 %1118, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset137 = or i235 %1121, %1120
  store i235 %.partset137, i235* %dst_0, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.1:                             ; preds = %dst.addr.4191.exit
  %1122 = bitcast i235* %dst_1 to i240*
  %1123 = load i240, i240* %1122
  %1124 = trunc i240 %1123 to i235
  %1125 = zext i1 %1115 to i235
  %1126 = shl i235 %1125, 232
  %1127 = and i235 %1124, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset132 = or i235 %1127, %1126
  store i235 %.partset132, i235* %dst_1, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.2:                             ; preds = %dst.addr.4191.exit
  %1128 = bitcast i235* %dst_2 to i240*
  %1129 = load i240, i240* %1128
  %1130 = trunc i240 %1129 to i235
  %1131 = zext i1 %1115 to i235
  %1132 = shl i235 %1131, 232
  %1133 = and i235 %1130, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset47 = or i235 %1133, %1132
  store i235 %.partset47, i235* %dst_2, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.3:                             ; preds = %dst.addr.4191.exit
  %1134 = bitcast i235* %dst_3 to i240*
  %1135 = load i240, i240* %1134
  %1136 = trunc i240 %1135 to i235
  %1137 = zext i1 %1115 to i235
  %1138 = shl i235 %1137, 232
  %1139 = and i235 %1136, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset42 = or i235 %1139, %1138
  store i235 %.partset42, i235* %dst_3, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.exit:                               ; preds = %dst.addr.4293.case.3, %dst.addr.4293.case.2, %dst.addr.4293.case.1, %dst.addr.4293.case.0, %dst.addr.4191.exit
  %src.addr.4394 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 43
  %1140 = bitcast i1* %src.addr.4394 to i8*
  %1141 = load i8, i8* %1140
  %1142 = trunc i8 %1141 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4395.exit [
    i64 0, label %dst.addr.4395.case.0
    i64 1, label %dst.addr.4395.case.1
    i64 2, label %dst.addr.4395.case.2
    i64 3, label %dst.addr.4395.case.3
  ]

dst.addr.4395.case.0:                             ; preds = %dst.addr.4293.exit
  %1143 = bitcast i235* %dst_0 to i240*
  %1144 = load i240, i240* %1143
  %1145 = trunc i240 %1144 to i235
  %1146 = zext i1 %1142 to i235
  %1147 = shl i235 %1146, 233
  %1148 = and i235 %1145, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset136 = or i235 %1148, %1147
  store i235 %.partset136, i235* %dst_0, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.1:                             ; preds = %dst.addr.4293.exit
  %1149 = bitcast i235* %dst_1 to i240*
  %1150 = load i240, i240* %1149
  %1151 = trunc i240 %1150 to i235
  %1152 = zext i1 %1142 to i235
  %1153 = shl i235 %1152, 233
  %1154 = and i235 %1151, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset133 = or i235 %1154, %1153
  store i235 %.partset133, i235* %dst_1, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.2:                             ; preds = %dst.addr.4293.exit
  %1155 = bitcast i235* %dst_2 to i240*
  %1156 = load i240, i240* %1155
  %1157 = trunc i240 %1156 to i235
  %1158 = zext i1 %1142 to i235
  %1159 = shl i235 %1158, 233
  %1160 = and i235 %1157, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset46 = or i235 %1160, %1159
  store i235 %.partset46, i235* %dst_2, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.3:                             ; preds = %dst.addr.4293.exit
  %1161 = bitcast i235* %dst_3 to i240*
  %1162 = load i240, i240* %1161
  %1163 = trunc i240 %1162 to i235
  %1164 = zext i1 %1142 to i235
  %1165 = shl i235 %1164, 233
  %1166 = and i235 %1163, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset43 = or i235 %1166, %1165
  store i235 %.partset43, i235* %dst_3, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.exit:                               ; preds = %dst.addr.4395.case.3, %dst.addr.4395.case.2, %dst.addr.4395.case.1, %dst.addr.4395.case.0, %dst.addr.4293.exit
  %src.addr.4496 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx99, i32 44
  %1167 = bitcast i1* %src.addr.4496 to i8*
  %1168 = load i8, i8* %1167
  %1169 = trunc i8 %1168 to i1
  switch i64 %for.loop.idx99, label %dst.addr.4497.exit [
    i64 0, label %dst.addr.4497.case.0
    i64 1, label %dst.addr.4497.case.1
    i64 2, label %dst.addr.4497.case.2
    i64 3, label %dst.addr.4497.case.3
  ]

dst.addr.4497.case.0:                             ; preds = %dst.addr.4395.exit
  %1170 = bitcast i235* %dst_0 to i240*
  %1171 = load i240, i240* %1170
  %1172 = trunc i240 %1171 to i235
  %1173 = zext i1 %1169 to i235
  %1174 = shl i235 %1173, 234
  %1175 = and i235 %1172, 27606985387162255149739023449108101809804435888681546220650096895197183
  %.partset135 = or i235 %1175, %1174
  store i235 %.partset135, i235* %dst_0, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.1:                             ; preds = %dst.addr.4395.exit
  %1176 = bitcast i235* %dst_1 to i240*
  %1177 = load i240, i240* %1176
  %1178 = trunc i240 %1177 to i235
  %1179 = zext i1 %1169 to i235
  %1180 = shl i235 %1179, 234
  %1181 = and i235 %1178, 27606985387162255149739023449108101809804435888681546220650096895197183
  %.partset134 = or i235 %1181, %1180
  store i235 %.partset134, i235* %dst_1, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.2:                             ; preds = %dst.addr.4395.exit
  %1182 = bitcast i235* %dst_2 to i240*
  %1183 = load i240, i240* %1182
  %1184 = trunc i240 %1183 to i235
  %1185 = zext i1 %1169 to i235
  %1186 = shl i235 %1185, 234
  %1187 = and i235 %1184, 27606985387162255149739023449108101809804435888681546220650096895197183
  %.partset45 = or i235 %1187, %1186
  store i235 %.partset45, i235* %dst_2, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.3:                             ; preds = %dst.addr.4395.exit
  %1188 = bitcast i235* %dst_3 to i240*
  %1189 = load i240, i240* %1188
  %1190 = trunc i240 %1189 to i235
  %1191 = zext i1 %1169 to i235
  %1192 = shl i235 %1191, 234
  %1193 = and i235 %1190, 27606985387162255149739023449108101809804435888681546220650096895197183
  %.partset44 = or i235 %1193, %1192
  store i235 %.partset44, i235* %dst_3, align 1
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
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.12.15(i235* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i235* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i235* noalias align 512 "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i235* noalias align 512 "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #1 {
entry:
  %0 = icmp eq i235* %dst_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.13.14(i235* nonnull %dst_0, i235* %dst_1, i235* %dst_2, i235* %dst_3, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in(i1* noalias readonly "orig.arg.no"="0", i1* noalias align 512 "orig.arg.no"="1", i32* noalias readonly "orig.arg.no"="2", i32* noalias align 512 "orig.arg.no"="3", i1* noalias readonly "orig.arg.no"="4", i1* noalias align 512 "orig.arg.no"="5", i1* noalias readonly "orig.arg.no"="6", i1* noalias align 512 "orig.arg.no"="7", i8* noalias readonly "orig.arg.no"="8", i8* noalias align 512 "orig.arg.no"="9", [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="10", i235* noalias align 512 "orig.arg.no"="11" "unpacked"="11.0" %_0, i235* noalias align 512 "orig.arg.no"="11" "unpacked"="11.1" %_1, i235* noalias align 512 "orig.arg.no"="11" "unpacked"="11.2" %_2, i235* noalias align 512 "orig.arg.no"="11" "unpacked"="11.3" %_3, i1* noalias readonly "orig.arg.no"="12", i1* noalias align 512 "orig.arg.no"="13", i32* noalias readonly "orig.arg.no"="14", i32* noalias align 512 "orig.arg.no"="15", i1* noalias readonly "orig.arg.no"="16", i1* noalias align 512 "orig.arg.no"="17", i32* noalias readonly "orig.arg.no"="18", i32* noalias align 512 "orig.arg.no"="19", %struct.ControlMemSpace* noalias readonly "orig.arg.no"="20", i1056* noalias align 512 "orig.arg.no"="21", i32* noalias readonly "orig.arg.no"="22", i32* noalias align 512 "orig.arg.no"="23", i32* noalias readonly "orig.arg.no"="24", i32* noalias align 512 "orig.arg.no"="25", i32* noalias readonly "orig.arg.no"="26", i32* noalias align 512 "orig.arg.no"="27", i32* noalias readonly "orig.arg.no"="28", i32* noalias align 512 "orig.arg.no"="29", i32* noalias readonly "orig.arg.no"="30", i32* noalias align 512 "orig.arg.no"="31", i32* noalias readonly "orig.arg.no"="32", i32* noalias align 512 "orig.arg.no"="33", i32* noalias readonly "orig.arg.no"="34", i32* noalias align 512 "orig.arg.no"="35", i32* noalias readonly "orig.arg.no"="36", i32* noalias align 512 "orig.arg.no"="37", i32* noalias readonly "orig.arg.no"="38", i32* noalias align 512 "orig.arg.no"="39", i32* noalias readonly "orig.arg.no"="40", i32* noalias align 512 "orig.arg.no"="41", i32* noalias readonly "orig.arg.no"="42", i32* noalias align 512 "orig.arg.no"="43", i32* noalias readonly "orig.arg.no"="44", i32* noalias align 512 "orig.arg.no"="45", i32* noalias readonly "orig.arg.no"="46", i32* noalias align 512 "orig.arg.no"="47", i32* noalias readonly "orig.arg.no"="48", i32* noalias align 512 "orig.arg.no"="49", i32* noalias readonly "orig.arg.no"="50", i32* noalias align 512 "orig.arg.no"="51", i1* noalias readonly "orig.arg.no"="52", i1* noalias align 512 "orig.arg.no"="53", i1* noalias readonly "orig.arg.no"="54", i1* noalias align 512 "orig.arg.no"="55", i8* noalias readonly "orig.arg.no"="56", i8* noalias align 512 "orig.arg.no"="57", i32* noalias readonly "orig.arg.no"="58", i32* noalias align 512 "orig.arg.no"="59", i32* noalias readonly "orig.arg.no"="60", i32* noalias align 512 "orig.arg.no"="61", i32* noalias readonly "orig.arg.no"="62", i32* noalias align 512 "orig.arg.no"="63", i1* noalias readonly "orig.arg.no"="64", i1* noalias align 512 "orig.arg.no"="65", i1* noalias readonly "orig.arg.no"="66", i1* noalias align 512 "orig.arg.no"="67") #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %3, i32* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %5, i1* %4)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %7, i1* %6)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %9, i8* %8)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.12.15(i235* align 512 %_0, i235* align 512 %_1, i235* align 512 %_2, i235* align 512 %_3, [4 x %struct.HeadCtx]* %10)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %12, i1* %11)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %14, i32* %13)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %16, i1* %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %18, i32* %17)
  call fastcc void @onebyonecpy_hls.p0struct.ControlMemSpace(i1056* align 512 %20, %struct.ControlMemSpace* %19)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %22, i32* %21)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %24, i32* %23)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %26, i32* %25)
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
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %52, i1* %51)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %54, i1* %53)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %56, i8* %55)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %58, i32* %57)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %60, i32* %59)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %62, i32* %61)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %64, i1* %63)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %66, i1* %65)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.23.24([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i235* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i235* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i235* readonly "orig.arg.no"="1" "unpacked"="1.2" %src_2, i235* readonly "orig.arg.no"="1" "unpacked"="1.3" %src_3, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i235* %src_0, null
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
  %3 = bitcast i235* %src_0 to i240*
  %4 = load i240, i240* %3
  %5 = trunc i240 %4 to i235
  %_0.partselect = trunc i235 %5 to i32
  br label %src.addr.01.exit

src.addr.01.case.1:                               ; preds = %for.loop
  %6 = bitcast i235* %src_1 to i240*
  %7 = load i240, i240* %6
  %8 = trunc i240 %7 to i235
  %_1.partselect = trunc i235 %8 to i32
  br label %src.addr.01.exit

src.addr.01.case.2:                               ; preds = %for.loop
  %9 = bitcast i235* %src_2 to i240*
  %10 = load i240, i240* %9
  %11 = trunc i240 %10 to i235
  %_2.partselect = trunc i235 %11 to i32
  br label %src.addr.01.exit

src.addr.01.case.3:                               ; preds = %for.loop
  %12 = bitcast i235* %src_3 to i240*
  %13 = load i240, i240* %12
  %14 = trunc i240 %13 to i235
  %_3.partselect = trunc i235 %14 to i32
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
  %16 = bitcast i235* %src_0 to i240*
  %17 = load i240, i240* %16
  %18 = trunc i240 %17 to i235
  %19 = lshr i235 %18, 32
  %_01.partselect = trunc i235 %19 to i32
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %20 = bitcast i235* %src_1 to i240*
  %21 = load i240, i240* %20
  %22 = trunc i240 %21 to i235
  %23 = lshr i235 %22, 32
  %_12.partselect = trunc i235 %23 to i32
  br label %src.addr.110.exit

src.addr.110.case.2:                              ; preds = %src.addr.01.exit
  %24 = bitcast i235* %src_2 to i240*
  %25 = load i240, i240* %24
  %26 = trunc i240 %25 to i235
  %27 = lshr i235 %26, 32
  %_23.partselect = trunc i235 %27 to i32
  br label %src.addr.110.exit

src.addr.110.case.3:                              ; preds = %src.addr.01.exit
  %28 = bitcast i235* %src_3 to i240*
  %29 = load i240, i240* %28
  %30 = trunc i240 %29 to i235
  %31 = lshr i235 %30, 32
  %_34.partselect = trunc i235 %31 to i32
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
  %33 = bitcast i235* %src_0 to i240*
  %34 = load i240, i240* %33
  %35 = trunc i240 %34 to i235
  %36 = lshr i235 %35, 64
  %_05.partselect = trunc i235 %36 to i8
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %37 = bitcast i235* %src_1 to i240*
  %38 = load i240, i240* %37
  %39 = trunc i240 %38 to i235
  %40 = lshr i235 %39, 64
  %_16.partselect = trunc i235 %40 to i8
  br label %src.addr.212.exit

src.addr.212.case.2:                              ; preds = %src.addr.110.exit
  %41 = bitcast i235* %src_2 to i240*
  %42 = load i240, i240* %41
  %43 = trunc i240 %42 to i235
  %44 = lshr i235 %43, 64
  %_27.partselect = trunc i235 %44 to i8
  br label %src.addr.212.exit

src.addr.212.case.3:                              ; preds = %src.addr.110.exit
  %45 = bitcast i235* %src_3 to i240*
  %46 = load i240, i240* %45
  %47 = trunc i240 %46 to i235
  %48 = lshr i235 %47, 64
  %_38.partselect = trunc i235 %48 to i8
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
  %50 = bitcast i235* %src_0 to i240*
  %51 = load i240, i240* %50
  %52 = trunc i240 %51 to i235
  %53 = lshr i235 %52, 72
  %_09.partselect = trunc i235 %53 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %54 = bitcast i235* %src_1 to i240*
  %55 = load i240, i240* %54
  %56 = trunc i240 %55 to i235
  %57 = lshr i235 %56, 72
  %_110.partselect = trunc i235 %57 to i1
  br label %src.addr.314.exit

src.addr.314.case.2:                              ; preds = %src.addr.212.exit
  %58 = bitcast i235* %src_2 to i240*
  %59 = load i240, i240* %58
  %60 = trunc i240 %59 to i235
  %61 = lshr i235 %60, 72
  %_211.partselect = trunc i235 %61 to i1
  br label %src.addr.314.exit

src.addr.314.case.3:                              ; preds = %src.addr.212.exit
  %62 = bitcast i235* %src_3 to i240*
  %63 = load i240, i240* %62
  %64 = trunc i240 %63 to i235
  %65 = lshr i235 %64, 72
  %_312.partselect = trunc i235 %65 to i1
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
  %67 = bitcast i235* %src_0 to i240*
  %68 = load i240, i240* %67
  %69 = trunc i240 %68 to i235
  %70 = lshr i235 %69, 73
  %_013.partselect = trunc i235 %70 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %71 = bitcast i235* %src_1 to i240*
  %72 = load i240, i240* %71
  %73 = trunc i240 %72 to i235
  %74 = lshr i235 %73, 73
  %_114.partselect = trunc i235 %74 to i1
  br label %src.addr.416.exit

src.addr.416.case.2:                              ; preds = %src.addr.314.exit
  %75 = bitcast i235* %src_2 to i240*
  %76 = load i240, i240* %75
  %77 = trunc i240 %76 to i235
  %78 = lshr i235 %77, 73
  %_215.partselect = trunc i235 %78 to i1
  br label %src.addr.416.exit

src.addr.416.case.3:                              ; preds = %src.addr.314.exit
  %79 = bitcast i235* %src_3 to i240*
  %80 = load i240, i240* %79
  %81 = trunc i240 %80 to i235
  %82 = lshr i235 %81, 73
  %_316.partselect = trunc i235 %82 to i1
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
  %84 = bitcast i235* %src_0 to i240*
  %85 = load i240, i240* %84
  %86 = trunc i240 %85 to i235
  %87 = lshr i235 %86, 74
  %_017.partselect = trunc i235 %87 to i1
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %88 = bitcast i235* %src_1 to i240*
  %89 = load i240, i240* %88
  %90 = trunc i240 %89 to i235
  %91 = lshr i235 %90, 74
  %_118.partselect = trunc i235 %91 to i1
  br label %src.addr.518.exit

src.addr.518.case.2:                              ; preds = %src.addr.416.exit
  %92 = bitcast i235* %src_2 to i240*
  %93 = load i240, i240* %92
  %94 = trunc i240 %93 to i235
  %95 = lshr i235 %94, 74
  %_219.partselect = trunc i235 %95 to i1
  br label %src.addr.518.exit

src.addr.518.case.3:                              ; preds = %src.addr.416.exit
  %96 = bitcast i235* %src_3 to i240*
  %97 = load i240, i240* %96
  %98 = trunc i240 %97 to i235
  %99 = lshr i235 %98, 74
  %_320.partselect = trunc i235 %99 to i1
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
  %101 = bitcast i235* %src_0 to i240*
  %102 = load i240, i240* %101
  %103 = trunc i240 %102 to i235
  %104 = lshr i235 %103, 75
  %_021.partselect = trunc i235 %104 to i8
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %105 = bitcast i235* %src_1 to i240*
  %106 = load i240, i240* %105
  %107 = trunc i240 %106 to i235
  %108 = lshr i235 %107, 75
  %_122.partselect = trunc i235 %108 to i8
  br label %src.addr.620.exit

src.addr.620.case.2:                              ; preds = %src.addr.518.exit
  %109 = bitcast i235* %src_2 to i240*
  %110 = load i240, i240* %109
  %111 = trunc i240 %110 to i235
  %112 = lshr i235 %111, 75
  %_223.partselect = trunc i235 %112 to i8
  br label %src.addr.620.exit

src.addr.620.case.3:                              ; preds = %src.addr.518.exit
  %113 = bitcast i235* %src_3 to i240*
  %114 = load i240, i240* %113
  %115 = trunc i240 %114 to i235
  %116 = lshr i235 %115, 75
  %_324.partselect = trunc i235 %116 to i8
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.3, %src.addr.620.case.2, %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %117 = phi i8 [ %_021.partselect, %src.addr.620.case.0 ], [ %_122.partselect, %src.addr.620.case.1 ], [ %_223.partselect, %src.addr.620.case.2 ], [ %_324.partselect, %src.addr.620.case.3 ], [ undef, %src.addr.518.exit ]
  store i8 %117, i8* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 7
  switch i64 %for.loop.idx99, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
    i64 2, label %src.addr.722.case.2
    i64 3, label %src.addr.722.case.3
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %118 = bitcast i235* %src_0 to i240*
  %119 = load i240, i240* %118
  %120 = trunc i240 %119 to i235
  %121 = lshr i235 %120, 83
  %_025.partselect = trunc i235 %121 to i8
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %122 = bitcast i235* %src_1 to i240*
  %123 = load i240, i240* %122
  %124 = trunc i240 %123 to i235
  %125 = lshr i235 %124, 83
  %_126.partselect = trunc i235 %125 to i8
  br label %src.addr.722.exit

src.addr.722.case.2:                              ; preds = %src.addr.620.exit
  %126 = bitcast i235* %src_2 to i240*
  %127 = load i240, i240* %126
  %128 = trunc i240 %127 to i235
  %129 = lshr i235 %128, 83
  %_227.partselect = trunc i235 %129 to i8
  br label %src.addr.722.exit

src.addr.722.case.3:                              ; preds = %src.addr.620.exit
  %130 = bitcast i235* %src_3 to i240*
  %131 = load i240, i240* %130
  %132 = trunc i240 %131 to i235
  %133 = lshr i235 %132, 83
  %_328.partselect = trunc i235 %133 to i8
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.3, %src.addr.722.case.2, %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %134 = phi i8 [ %_025.partselect, %src.addr.722.case.0 ], [ %_126.partselect, %src.addr.722.case.1 ], [ %_227.partselect, %src.addr.722.case.2 ], [ %_328.partselect, %src.addr.722.case.3 ], [ undef, %src.addr.620.exit ]
  store i8 %134, i8* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 8
  switch i64 %for.loop.idx99, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
    i64 2, label %src.addr.824.case.2
    i64 3, label %src.addr.824.case.3
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %135 = bitcast i235* %src_0 to i240*
  %136 = load i240, i240* %135
  %137 = trunc i240 %136 to i235
  %138 = lshr i235 %137, 91
  %_029.partselect = trunc i235 %138 to i8
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %139 = bitcast i235* %src_1 to i240*
  %140 = load i240, i240* %139
  %141 = trunc i240 %140 to i235
  %142 = lshr i235 %141, 91
  %_130.partselect = trunc i235 %142 to i8
  br label %src.addr.824.exit

src.addr.824.case.2:                              ; preds = %src.addr.722.exit
  %143 = bitcast i235* %src_2 to i240*
  %144 = load i240, i240* %143
  %145 = trunc i240 %144 to i235
  %146 = lshr i235 %145, 91
  %_231.partselect = trunc i235 %146 to i8
  br label %src.addr.824.exit

src.addr.824.case.3:                              ; preds = %src.addr.722.exit
  %147 = bitcast i235* %src_3 to i240*
  %148 = load i240, i240* %147
  %149 = trunc i240 %148 to i235
  %150 = lshr i235 %149, 91
  %_332.partselect = trunc i235 %150 to i8
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
  %152 = bitcast i235* %src_0 to i240*
  %153 = load i240, i240* %152
  %154 = trunc i240 %153 to i235
  %155 = lshr i235 %154, 99
  %_033.partselect = trunc i235 %155 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %156 = bitcast i235* %src_1 to i240*
  %157 = load i240, i240* %156
  %158 = trunc i240 %157 to i235
  %159 = lshr i235 %158, 99
  %_134.partselect = trunc i235 %159 to i1
  br label %src.addr.926.exit

src.addr.926.case.2:                              ; preds = %src.addr.824.exit
  %160 = bitcast i235* %src_2 to i240*
  %161 = load i240, i240* %160
  %162 = trunc i240 %161 to i235
  %163 = lshr i235 %162, 99
  %_235.partselect = trunc i235 %163 to i1
  br label %src.addr.926.exit

src.addr.926.case.3:                              ; preds = %src.addr.824.exit
  %164 = bitcast i235* %src_3 to i240*
  %165 = load i240, i240* %164
  %166 = trunc i240 %165 to i235
  %167 = lshr i235 %166, 99
  %_336.partselect = trunc i235 %167 to i1
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
  %169 = bitcast i235* %src_0 to i240*
  %170 = load i240, i240* %169
  %171 = trunc i240 %170 to i235
  %172 = lshr i235 %171, 100
  %_037.partselect = trunc i235 %172 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %173 = bitcast i235* %src_1 to i240*
  %174 = load i240, i240* %173
  %175 = trunc i240 %174 to i235
  %176 = lshr i235 %175, 100
  %_138.partselect = trunc i235 %176 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.2:                             ; preds = %src.addr.926.exit
  %177 = bitcast i235* %src_2 to i240*
  %178 = load i240, i240* %177
  %179 = trunc i240 %178 to i235
  %180 = lshr i235 %179, 100
  %_239.partselect = trunc i235 %180 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.3:                             ; preds = %src.addr.926.exit
  %181 = bitcast i235* %src_3 to i240*
  %182 = load i240, i240* %181
  %183 = trunc i240 %182 to i235
  %184 = lshr i235 %183, 100
  %_340.partselect = trunc i235 %184 to i1
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
  %186 = bitcast i235* %src_0 to i240*
  %187 = load i240, i240* %186
  %188 = trunc i240 %187 to i235
  %189 = lshr i235 %188, 101
  %_041.partselect = trunc i235 %189 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %190 = bitcast i235* %src_1 to i240*
  %191 = load i240, i240* %190
  %192 = trunc i240 %191 to i235
  %193 = lshr i235 %192, 101
  %_142.partselect = trunc i235 %193 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.2:                             ; preds = %src.addr.1028.exit
  %194 = bitcast i235* %src_2 to i240*
  %195 = load i240, i240* %194
  %196 = trunc i240 %195 to i235
  %197 = lshr i235 %196, 101
  %_243.partselect = trunc i235 %197 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.3:                             ; preds = %src.addr.1028.exit
  %198 = bitcast i235* %src_3 to i240*
  %199 = load i240, i240* %198
  %200 = trunc i240 %199 to i235
  %201 = lshr i235 %200, 101
  %_344.partselect = trunc i235 %201 to i8
  br label %src.addr.1130.exit

src.addr.1130.exit:                               ; preds = %src.addr.1130.case.3, %src.addr.1130.case.2, %src.addr.1130.case.1, %src.addr.1130.case.0, %src.addr.1028.exit
  %202 = phi i8 [ %_041.partselect, %src.addr.1130.case.0 ], [ %_142.partselect, %src.addr.1130.case.1 ], [ %_243.partselect, %src.addr.1130.case.2 ], [ %_344.partselect, %src.addr.1130.case.3 ], [ undef, %src.addr.1028.exit ]
  store i8 %202, i8* %dst.addr.1131, align 1
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 12
  switch i64 %for.loop.idx99, label %src.addr.1232.exit [
    i64 0, label %src.addr.1232.case.0
    i64 1, label %src.addr.1232.case.1
    i64 2, label %src.addr.1232.case.2
    i64 3, label %src.addr.1232.case.3
  ]

src.addr.1232.case.0:                             ; preds = %src.addr.1130.exit
  %203 = bitcast i235* %src_0 to i240*
  %204 = load i240, i240* %203
  %205 = trunc i240 %204 to i235
  %206 = lshr i235 %205, 109
  %_045.partselect = trunc i235 %206 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %207 = bitcast i235* %src_1 to i240*
  %208 = load i240, i240* %207
  %209 = trunc i240 %208 to i235
  %210 = lshr i235 %209, 109
  %_146.partselect = trunc i235 %210 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.2:                             ; preds = %src.addr.1130.exit
  %211 = bitcast i235* %src_2 to i240*
  %212 = load i240, i240* %211
  %213 = trunc i240 %212 to i235
  %214 = lshr i235 %213, 109
  %_247.partselect = trunc i235 %214 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.3:                             ; preds = %src.addr.1130.exit
  %215 = bitcast i235* %src_3 to i240*
  %216 = load i240, i240* %215
  %217 = trunc i240 %216 to i235
  %218 = lshr i235 %217, 109
  %_348.partselect = trunc i235 %218 to i32
  br label %src.addr.1232.exit

src.addr.1232.exit:                               ; preds = %src.addr.1232.case.3, %src.addr.1232.case.2, %src.addr.1232.case.1, %src.addr.1232.case.0, %src.addr.1130.exit
  %219 = phi i32 [ %_045.partselect, %src.addr.1232.case.0 ], [ %_146.partselect, %src.addr.1232.case.1 ], [ %_247.partselect, %src.addr.1232.case.2 ], [ %_348.partselect, %src.addr.1232.case.3 ], [ undef, %src.addr.1130.exit ]
  store i32 %219, i32* %dst.addr.1233, align 4
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 13
  switch i64 %for.loop.idx99, label %src.addr.1334.exit [
    i64 0, label %src.addr.1334.case.0
    i64 1, label %src.addr.1334.case.1
    i64 2, label %src.addr.1334.case.2
    i64 3, label %src.addr.1334.case.3
  ]

src.addr.1334.case.0:                             ; preds = %src.addr.1232.exit
  %220 = bitcast i235* %src_0 to i240*
  %221 = load i240, i240* %220
  %222 = trunc i240 %221 to i235
  %223 = lshr i235 %222, 141
  %_049.partselect = trunc i235 %223 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %224 = bitcast i235* %src_1 to i240*
  %225 = load i240, i240* %224
  %226 = trunc i240 %225 to i235
  %227 = lshr i235 %226, 141
  %_150.partselect = trunc i235 %227 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.2:                             ; preds = %src.addr.1232.exit
  %228 = bitcast i235* %src_2 to i240*
  %229 = load i240, i240* %228
  %230 = trunc i240 %229 to i235
  %231 = lshr i235 %230, 141
  %_251.partselect = trunc i235 %231 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.3:                             ; preds = %src.addr.1232.exit
  %232 = bitcast i235* %src_3 to i240*
  %233 = load i240, i240* %232
  %234 = trunc i240 %233 to i235
  %235 = lshr i235 %234, 141
  %_352.partselect = trunc i235 %235 to i32
  br label %src.addr.1334.exit

src.addr.1334.exit:                               ; preds = %src.addr.1334.case.3, %src.addr.1334.case.2, %src.addr.1334.case.1, %src.addr.1334.case.0, %src.addr.1232.exit
  %236 = phi i32 [ %_049.partselect, %src.addr.1334.case.0 ], [ %_150.partselect, %src.addr.1334.case.1 ], [ %_251.partselect, %src.addr.1334.case.2 ], [ %_352.partselect, %src.addr.1334.case.3 ], [ undef, %src.addr.1232.exit ]
  store i32 %236, i32* %dst.addr.1335, align 4
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 14
  switch i64 %for.loop.idx99, label %src.addr.1436.exit [
    i64 0, label %src.addr.1436.case.0
    i64 1, label %src.addr.1436.case.1
    i64 2, label %src.addr.1436.case.2
    i64 3, label %src.addr.1436.case.3
  ]

src.addr.1436.case.0:                             ; preds = %src.addr.1334.exit
  %237 = bitcast i235* %src_0 to i240*
  %238 = load i240, i240* %237
  %239 = trunc i240 %238 to i235
  %240 = lshr i235 %239, 173
  %_053.partselect = trunc i235 %240 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %241 = bitcast i235* %src_1 to i240*
  %242 = load i240, i240* %241
  %243 = trunc i240 %242 to i235
  %244 = lshr i235 %243, 173
  %_154.partselect = trunc i235 %244 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.2:                             ; preds = %src.addr.1334.exit
  %245 = bitcast i235* %src_2 to i240*
  %246 = load i240, i240* %245
  %247 = trunc i240 %246 to i235
  %248 = lshr i235 %247, 173
  %_255.partselect = trunc i235 %248 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.3:                             ; preds = %src.addr.1334.exit
  %249 = bitcast i235* %src_3 to i240*
  %250 = load i240, i240* %249
  %251 = trunc i240 %250 to i235
  %252 = lshr i235 %251, 173
  %_356.partselect = trunc i235 %252 to i1
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
  %254 = bitcast i235* %src_0 to i240*
  %255 = load i240, i240* %254
  %256 = trunc i240 %255 to i235
  %257 = lshr i235 %256, 174
  %_057.partselect = trunc i235 %257 to i32
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %258 = bitcast i235* %src_1 to i240*
  %259 = load i240, i240* %258
  %260 = trunc i240 %259 to i235
  %261 = lshr i235 %260, 174
  %_158.partselect = trunc i235 %261 to i32
  br label %src.addr.1538.exit

src.addr.1538.case.2:                             ; preds = %src.addr.1436.exit
  %262 = bitcast i235* %src_2 to i240*
  %263 = load i240, i240* %262
  %264 = trunc i240 %263 to i235
  %265 = lshr i235 %264, 174
  %_259.partselect = trunc i235 %265 to i32
  br label %src.addr.1538.exit

src.addr.1538.case.3:                             ; preds = %src.addr.1436.exit
  %266 = bitcast i235* %src_3 to i240*
  %267 = load i240, i240* %266
  %268 = trunc i240 %267 to i235
  %269 = lshr i235 %268, 174
  %_360.partselect = trunc i235 %269 to i32
  br label %src.addr.1538.exit

src.addr.1538.exit:                               ; preds = %src.addr.1538.case.3, %src.addr.1538.case.2, %src.addr.1538.case.1, %src.addr.1538.case.0, %src.addr.1436.exit
  %270 = phi i32 [ %_057.partselect, %src.addr.1538.case.0 ], [ %_158.partselect, %src.addr.1538.case.1 ], [ %_259.partselect, %src.addr.1538.case.2 ], [ %_360.partselect, %src.addr.1538.case.3 ], [ undef, %src.addr.1436.exit ]
  store i32 %270, i32* %dst.addr.1539, align 4
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx99, i32 16
  switch i64 %for.loop.idx99, label %src.addr.1640.exit [
    i64 0, label %src.addr.1640.case.0
    i64 1, label %src.addr.1640.case.1
    i64 2, label %src.addr.1640.case.2
    i64 3, label %src.addr.1640.case.3
  ]

src.addr.1640.case.0:                             ; preds = %src.addr.1538.exit
  %271 = bitcast i235* %src_0 to i240*
  %272 = load i240, i240* %271
  %273 = trunc i240 %272 to i235
  %274 = lshr i235 %273, 206
  %_061.partselect = trunc i235 %274 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %275 = bitcast i235* %src_1 to i240*
  %276 = load i240, i240* %275
  %277 = trunc i240 %276 to i235
  %278 = lshr i235 %277, 206
  %_162.partselect = trunc i235 %278 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.2:                             ; preds = %src.addr.1538.exit
  %279 = bitcast i235* %src_2 to i240*
  %280 = load i240, i240* %279
  %281 = trunc i240 %280 to i235
  %282 = lshr i235 %281, 206
  %_263.partselect = trunc i235 %282 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.3:                             ; preds = %src.addr.1538.exit
  %283 = bitcast i235* %src_3 to i240*
  %284 = load i240, i240* %283
  %285 = trunc i240 %284 to i235
  %286 = lshr i235 %285, 206
  %_364.partselect = trunc i235 %286 to i1
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
  %288 = bitcast i235* %src_0 to i240*
  %289 = load i240, i240* %288
  %290 = trunc i240 %289 to i235
  %291 = lshr i235 %290, 207
  %_065.partselect = trunc i235 %291 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %292 = bitcast i235* %src_1 to i240*
  %293 = load i240, i240* %292
  %294 = trunc i240 %293 to i235
  %295 = lshr i235 %294, 207
  %_166.partselect = trunc i235 %295 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.2:                             ; preds = %src.addr.1640.exit
  %296 = bitcast i235* %src_2 to i240*
  %297 = load i240, i240* %296
  %298 = trunc i240 %297 to i235
  %299 = lshr i235 %298, 207
  %_267.partselect = trunc i235 %299 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.3:                             ; preds = %src.addr.1640.exit
  %300 = bitcast i235* %src_3 to i240*
  %301 = load i240, i240* %300
  %302 = trunc i240 %301 to i235
  %303 = lshr i235 %302, 207
  %_368.partselect = trunc i235 %303 to i1
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
  %305 = bitcast i235* %src_0 to i240*
  %306 = load i240, i240* %305
  %307 = trunc i240 %306 to i235
  %308 = lshr i235 %307, 208
  %_069.partselect = trunc i235 %308 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %309 = bitcast i235* %src_1 to i240*
  %310 = load i240, i240* %309
  %311 = trunc i240 %310 to i235
  %312 = lshr i235 %311, 208
  %_170.partselect = trunc i235 %312 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.2:                             ; preds = %src.addr.1742.exit
  %313 = bitcast i235* %src_2 to i240*
  %314 = load i240, i240* %313
  %315 = trunc i240 %314 to i235
  %316 = lshr i235 %315, 208
  %_271.partselect = trunc i235 %316 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.3:                             ; preds = %src.addr.1742.exit
  %317 = bitcast i235* %src_3 to i240*
  %318 = load i240, i240* %317
  %319 = trunc i240 %318 to i235
  %320 = lshr i235 %319, 208
  %_372.partselect = trunc i235 %320 to i1
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
  %322 = bitcast i235* %src_0 to i240*
  %323 = load i240, i240* %322
  %324 = trunc i240 %323 to i235
  %325 = lshr i235 %324, 209
  %_073.partselect = trunc i235 %325 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %326 = bitcast i235* %src_1 to i240*
  %327 = load i240, i240* %326
  %328 = trunc i240 %327 to i235
  %329 = lshr i235 %328, 209
  %_174.partselect = trunc i235 %329 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.2:                             ; preds = %src.addr.1844.exit
  %330 = bitcast i235* %src_2 to i240*
  %331 = load i240, i240* %330
  %332 = trunc i240 %331 to i235
  %333 = lshr i235 %332, 209
  %_275.partselect = trunc i235 %333 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.3:                             ; preds = %src.addr.1844.exit
  %334 = bitcast i235* %src_3 to i240*
  %335 = load i240, i240* %334
  %336 = trunc i240 %335 to i235
  %337 = lshr i235 %336, 209
  %_376.partselect = trunc i235 %337 to i1
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
  %339 = bitcast i235* %src_0 to i240*
  %340 = load i240, i240* %339
  %341 = trunc i240 %340 to i235
  %342 = lshr i235 %341, 210
  %_077.partselect = trunc i235 %342 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %343 = bitcast i235* %src_1 to i240*
  %344 = load i240, i240* %343
  %345 = trunc i240 %344 to i235
  %346 = lshr i235 %345, 210
  %_178.partselect = trunc i235 %346 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.2:                             ; preds = %src.addr.1946.exit
  %347 = bitcast i235* %src_2 to i240*
  %348 = load i240, i240* %347
  %349 = trunc i240 %348 to i235
  %350 = lshr i235 %349, 210
  %_279.partselect = trunc i235 %350 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.3:                             ; preds = %src.addr.1946.exit
  %351 = bitcast i235* %src_3 to i240*
  %352 = load i240, i240* %351
  %353 = trunc i240 %352 to i235
  %354 = lshr i235 %353, 210
  %_380.partselect = trunc i235 %354 to i1
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
  %356 = bitcast i235* %src_0 to i240*
  %357 = load i240, i240* %356
  %358 = trunc i240 %357 to i235
  %359 = lshr i235 %358, 211
  %_081.partselect = trunc i235 %359 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.1:                             ; preds = %src.addr.2048.exit
  %360 = bitcast i235* %src_1 to i240*
  %361 = load i240, i240* %360
  %362 = trunc i240 %361 to i235
  %363 = lshr i235 %362, 211
  %_182.partselect = trunc i235 %363 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.2:                             ; preds = %src.addr.2048.exit
  %364 = bitcast i235* %src_2 to i240*
  %365 = load i240, i240* %364
  %366 = trunc i240 %365 to i235
  %367 = lshr i235 %366, 211
  %_283.partselect = trunc i235 %367 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.3:                             ; preds = %src.addr.2048.exit
  %368 = bitcast i235* %src_3 to i240*
  %369 = load i240, i240* %368
  %370 = trunc i240 %369 to i235
  %371 = lshr i235 %370, 211
  %_384.partselect = trunc i235 %371 to i1
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
  %373 = bitcast i235* %src_0 to i240*
  %374 = load i240, i240* %373
  %375 = trunc i240 %374 to i235
  %376 = lshr i235 %375, 212
  %_085.partselect = trunc i235 %376 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.1:                             ; preds = %src.addr.2150.exit
  %377 = bitcast i235* %src_1 to i240*
  %378 = load i240, i240* %377
  %379 = trunc i240 %378 to i235
  %380 = lshr i235 %379, 212
  %_186.partselect = trunc i235 %380 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.2:                             ; preds = %src.addr.2150.exit
  %381 = bitcast i235* %src_2 to i240*
  %382 = load i240, i240* %381
  %383 = trunc i240 %382 to i235
  %384 = lshr i235 %383, 212
  %_287.partselect = trunc i235 %384 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.3:                             ; preds = %src.addr.2150.exit
  %385 = bitcast i235* %src_3 to i240*
  %386 = load i240, i240* %385
  %387 = trunc i240 %386 to i235
  %388 = lshr i235 %387, 212
  %_388.partselect = trunc i235 %388 to i1
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
  %390 = bitcast i235* %src_0 to i240*
  %391 = load i240, i240* %390
  %392 = trunc i240 %391 to i235
  %393 = lshr i235 %392, 213
  %_089.partselect = trunc i235 %393 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.1:                             ; preds = %src.addr.2252.exit
  %394 = bitcast i235* %src_1 to i240*
  %395 = load i240, i240* %394
  %396 = trunc i240 %395 to i235
  %397 = lshr i235 %396, 213
  %_190.partselect = trunc i235 %397 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.2:                             ; preds = %src.addr.2252.exit
  %398 = bitcast i235* %src_2 to i240*
  %399 = load i240, i240* %398
  %400 = trunc i240 %399 to i235
  %401 = lshr i235 %400, 213
  %_291.partselect = trunc i235 %401 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.3:                             ; preds = %src.addr.2252.exit
  %402 = bitcast i235* %src_3 to i240*
  %403 = load i240, i240* %402
  %404 = trunc i240 %403 to i235
  %405 = lshr i235 %404, 213
  %_392.partselect = trunc i235 %405 to i1
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
  %407 = bitcast i235* %src_0 to i240*
  %408 = load i240, i240* %407
  %409 = trunc i240 %408 to i235
  %410 = lshr i235 %409, 214
  %_093.partselect = trunc i235 %410 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.1:                             ; preds = %src.addr.2354.exit
  %411 = bitcast i235* %src_1 to i240*
  %412 = load i240, i240* %411
  %413 = trunc i240 %412 to i235
  %414 = lshr i235 %413, 214
  %_194.partselect = trunc i235 %414 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.2:                             ; preds = %src.addr.2354.exit
  %415 = bitcast i235* %src_2 to i240*
  %416 = load i240, i240* %415
  %417 = trunc i240 %416 to i235
  %418 = lshr i235 %417, 214
  %_295.partselect = trunc i235 %418 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.3:                             ; preds = %src.addr.2354.exit
  %419 = bitcast i235* %src_3 to i240*
  %420 = load i240, i240* %419
  %421 = trunc i240 %420 to i235
  %422 = lshr i235 %421, 214
  %_396.partselect = trunc i235 %422 to i1
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
  %424 = bitcast i235* %src_0 to i240*
  %425 = load i240, i240* %424
  %426 = trunc i240 %425 to i235
  %427 = lshr i235 %426, 215
  %_097.partselect = trunc i235 %427 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.1:                             ; preds = %src.addr.2456.exit
  %428 = bitcast i235* %src_1 to i240*
  %429 = load i240, i240* %428
  %430 = trunc i240 %429 to i235
  %431 = lshr i235 %430, 215
  %_198.partselect = trunc i235 %431 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.2:                             ; preds = %src.addr.2456.exit
  %432 = bitcast i235* %src_2 to i240*
  %433 = load i240, i240* %432
  %434 = trunc i240 %433 to i235
  %435 = lshr i235 %434, 215
  %_299.partselect = trunc i235 %435 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.3:                             ; preds = %src.addr.2456.exit
  %436 = bitcast i235* %src_3 to i240*
  %437 = load i240, i240* %436
  %438 = trunc i240 %437 to i235
  %439 = lshr i235 %438, 215
  %_3100.partselect = trunc i235 %439 to i1
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
  %441 = bitcast i235* %src_0 to i240*
  %442 = load i240, i240* %441
  %443 = trunc i240 %442 to i235
  %444 = lshr i235 %443, 216
  %_0101.partselect = trunc i235 %444 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.1:                             ; preds = %src.addr.2558.exit
  %445 = bitcast i235* %src_1 to i240*
  %446 = load i240, i240* %445
  %447 = trunc i240 %446 to i235
  %448 = lshr i235 %447, 216
  %_1102.partselect = trunc i235 %448 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.2:                             ; preds = %src.addr.2558.exit
  %449 = bitcast i235* %src_2 to i240*
  %450 = load i240, i240* %449
  %451 = trunc i240 %450 to i235
  %452 = lshr i235 %451, 216
  %_2103.partselect = trunc i235 %452 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.3:                             ; preds = %src.addr.2558.exit
  %453 = bitcast i235* %src_3 to i240*
  %454 = load i240, i240* %453
  %455 = trunc i240 %454 to i235
  %456 = lshr i235 %455, 216
  %_3104.partselect = trunc i235 %456 to i1
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
  %458 = bitcast i235* %src_0 to i240*
  %459 = load i240, i240* %458
  %460 = trunc i240 %459 to i235
  %461 = lshr i235 %460, 217
  %_0105.partselect = trunc i235 %461 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.1:                             ; preds = %src.addr.2660.exit
  %462 = bitcast i235* %src_1 to i240*
  %463 = load i240, i240* %462
  %464 = trunc i240 %463 to i235
  %465 = lshr i235 %464, 217
  %_1106.partselect = trunc i235 %465 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.2:                             ; preds = %src.addr.2660.exit
  %466 = bitcast i235* %src_2 to i240*
  %467 = load i240, i240* %466
  %468 = trunc i240 %467 to i235
  %469 = lshr i235 %468, 217
  %_2107.partselect = trunc i235 %469 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.3:                             ; preds = %src.addr.2660.exit
  %470 = bitcast i235* %src_3 to i240*
  %471 = load i240, i240* %470
  %472 = trunc i240 %471 to i235
  %473 = lshr i235 %472, 217
  %_3108.partselect = trunc i235 %473 to i1
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
  %475 = bitcast i235* %src_0 to i240*
  %476 = load i240, i240* %475
  %477 = trunc i240 %476 to i235
  %478 = lshr i235 %477, 218
  %_0109.partselect = trunc i235 %478 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.1:                             ; preds = %src.addr.2762.exit
  %479 = bitcast i235* %src_1 to i240*
  %480 = load i240, i240* %479
  %481 = trunc i240 %480 to i235
  %482 = lshr i235 %481, 218
  %_1110.partselect = trunc i235 %482 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.2:                             ; preds = %src.addr.2762.exit
  %483 = bitcast i235* %src_2 to i240*
  %484 = load i240, i240* %483
  %485 = trunc i240 %484 to i235
  %486 = lshr i235 %485, 218
  %_2111.partselect = trunc i235 %486 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.3:                             ; preds = %src.addr.2762.exit
  %487 = bitcast i235* %src_3 to i240*
  %488 = load i240, i240* %487
  %489 = trunc i240 %488 to i235
  %490 = lshr i235 %489, 218
  %_3112.partselect = trunc i235 %490 to i1
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
  %492 = bitcast i235* %src_0 to i240*
  %493 = load i240, i240* %492
  %494 = trunc i240 %493 to i235
  %495 = lshr i235 %494, 219
  %_0113.partselect = trunc i235 %495 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.1:                             ; preds = %src.addr.2864.exit
  %496 = bitcast i235* %src_1 to i240*
  %497 = load i240, i240* %496
  %498 = trunc i240 %497 to i235
  %499 = lshr i235 %498, 219
  %_1114.partselect = trunc i235 %499 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.2:                             ; preds = %src.addr.2864.exit
  %500 = bitcast i235* %src_2 to i240*
  %501 = load i240, i240* %500
  %502 = trunc i240 %501 to i235
  %503 = lshr i235 %502, 219
  %_2115.partselect = trunc i235 %503 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.3:                             ; preds = %src.addr.2864.exit
  %504 = bitcast i235* %src_3 to i240*
  %505 = load i240, i240* %504
  %506 = trunc i240 %505 to i235
  %507 = lshr i235 %506, 219
  %_3116.partselect = trunc i235 %507 to i1
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
  %509 = bitcast i235* %src_0 to i240*
  %510 = load i240, i240* %509
  %511 = trunc i240 %510 to i235
  %512 = lshr i235 %511, 220
  %_0117.partselect = trunc i235 %512 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.1:                             ; preds = %src.addr.2966.exit
  %513 = bitcast i235* %src_1 to i240*
  %514 = load i240, i240* %513
  %515 = trunc i240 %514 to i235
  %516 = lshr i235 %515, 220
  %_1118.partselect = trunc i235 %516 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.2:                             ; preds = %src.addr.2966.exit
  %517 = bitcast i235* %src_2 to i240*
  %518 = load i240, i240* %517
  %519 = trunc i240 %518 to i235
  %520 = lshr i235 %519, 220
  %_2119.partselect = trunc i235 %520 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.3:                             ; preds = %src.addr.2966.exit
  %521 = bitcast i235* %src_3 to i240*
  %522 = load i240, i240* %521
  %523 = trunc i240 %522 to i235
  %524 = lshr i235 %523, 220
  %_3120.partselect = trunc i235 %524 to i1
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
  %526 = bitcast i235* %src_0 to i240*
  %527 = load i240, i240* %526
  %528 = trunc i240 %527 to i235
  %529 = lshr i235 %528, 221
  %_0121.partselect = trunc i235 %529 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.1:                             ; preds = %src.addr.3068.exit
  %530 = bitcast i235* %src_1 to i240*
  %531 = load i240, i240* %530
  %532 = trunc i240 %531 to i235
  %533 = lshr i235 %532, 221
  %_1122.partselect = trunc i235 %533 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.2:                             ; preds = %src.addr.3068.exit
  %534 = bitcast i235* %src_2 to i240*
  %535 = load i240, i240* %534
  %536 = trunc i240 %535 to i235
  %537 = lshr i235 %536, 221
  %_2123.partselect = trunc i235 %537 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.3:                             ; preds = %src.addr.3068.exit
  %538 = bitcast i235* %src_3 to i240*
  %539 = load i240, i240* %538
  %540 = trunc i240 %539 to i235
  %541 = lshr i235 %540, 221
  %_3124.partselect = trunc i235 %541 to i1
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
  %543 = bitcast i235* %src_0 to i240*
  %544 = load i240, i240* %543
  %545 = trunc i240 %544 to i235
  %546 = lshr i235 %545, 222
  %_0125.partselect = trunc i235 %546 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.1:                             ; preds = %src.addr.3170.exit
  %547 = bitcast i235* %src_1 to i240*
  %548 = load i240, i240* %547
  %549 = trunc i240 %548 to i235
  %550 = lshr i235 %549, 222
  %_1126.partselect = trunc i235 %550 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.2:                             ; preds = %src.addr.3170.exit
  %551 = bitcast i235* %src_2 to i240*
  %552 = load i240, i240* %551
  %553 = trunc i240 %552 to i235
  %554 = lshr i235 %553, 222
  %_2127.partselect = trunc i235 %554 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.3:                             ; preds = %src.addr.3170.exit
  %555 = bitcast i235* %src_3 to i240*
  %556 = load i240, i240* %555
  %557 = trunc i240 %556 to i235
  %558 = lshr i235 %557, 222
  %_3128.partselect = trunc i235 %558 to i1
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
  %560 = bitcast i235* %src_0 to i240*
  %561 = load i240, i240* %560
  %562 = trunc i240 %561 to i235
  %563 = lshr i235 %562, 223
  %_0129.partselect = trunc i235 %563 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.1:                             ; preds = %src.addr.3272.exit
  %564 = bitcast i235* %src_1 to i240*
  %565 = load i240, i240* %564
  %566 = trunc i240 %565 to i235
  %567 = lshr i235 %566, 223
  %_1130.partselect = trunc i235 %567 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.2:                             ; preds = %src.addr.3272.exit
  %568 = bitcast i235* %src_2 to i240*
  %569 = load i240, i240* %568
  %570 = trunc i240 %569 to i235
  %571 = lshr i235 %570, 223
  %_2131.partselect = trunc i235 %571 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.3:                             ; preds = %src.addr.3272.exit
  %572 = bitcast i235* %src_3 to i240*
  %573 = load i240, i240* %572
  %574 = trunc i240 %573 to i235
  %575 = lshr i235 %574, 223
  %_3132.partselect = trunc i235 %575 to i1
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
  %577 = bitcast i235* %src_0 to i240*
  %578 = load i240, i240* %577
  %579 = trunc i240 %578 to i235
  %580 = lshr i235 %579, 224
  %_0133.partselect = trunc i235 %580 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.1:                             ; preds = %src.addr.3374.exit
  %581 = bitcast i235* %src_1 to i240*
  %582 = load i240, i240* %581
  %583 = trunc i240 %582 to i235
  %584 = lshr i235 %583, 224
  %_1134.partselect = trunc i235 %584 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.2:                             ; preds = %src.addr.3374.exit
  %585 = bitcast i235* %src_2 to i240*
  %586 = load i240, i240* %585
  %587 = trunc i240 %586 to i235
  %588 = lshr i235 %587, 224
  %_2135.partselect = trunc i235 %588 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.3:                             ; preds = %src.addr.3374.exit
  %589 = bitcast i235* %src_3 to i240*
  %590 = load i240, i240* %589
  %591 = trunc i240 %590 to i235
  %592 = lshr i235 %591, 224
  %_3136.partselect = trunc i235 %592 to i1
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
  %594 = bitcast i235* %src_0 to i240*
  %595 = load i240, i240* %594
  %596 = trunc i240 %595 to i235
  %597 = lshr i235 %596, 225
  %_0137.partselect = trunc i235 %597 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.1:                             ; preds = %src.addr.3476.exit
  %598 = bitcast i235* %src_1 to i240*
  %599 = load i240, i240* %598
  %600 = trunc i240 %599 to i235
  %601 = lshr i235 %600, 225
  %_1138.partselect = trunc i235 %601 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.2:                             ; preds = %src.addr.3476.exit
  %602 = bitcast i235* %src_2 to i240*
  %603 = load i240, i240* %602
  %604 = trunc i240 %603 to i235
  %605 = lshr i235 %604, 225
  %_2139.partselect = trunc i235 %605 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.3:                             ; preds = %src.addr.3476.exit
  %606 = bitcast i235* %src_3 to i240*
  %607 = load i240, i240* %606
  %608 = trunc i240 %607 to i235
  %609 = lshr i235 %608, 225
  %_3140.partselect = trunc i235 %609 to i1
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
  %611 = bitcast i235* %src_0 to i240*
  %612 = load i240, i240* %611
  %613 = trunc i240 %612 to i235
  %614 = lshr i235 %613, 226
  %_0141.partselect = trunc i235 %614 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.1:                             ; preds = %src.addr.3578.exit
  %615 = bitcast i235* %src_1 to i240*
  %616 = load i240, i240* %615
  %617 = trunc i240 %616 to i235
  %618 = lshr i235 %617, 226
  %_1142.partselect = trunc i235 %618 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.2:                             ; preds = %src.addr.3578.exit
  %619 = bitcast i235* %src_2 to i240*
  %620 = load i240, i240* %619
  %621 = trunc i240 %620 to i235
  %622 = lshr i235 %621, 226
  %_2143.partselect = trunc i235 %622 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.3:                             ; preds = %src.addr.3578.exit
  %623 = bitcast i235* %src_3 to i240*
  %624 = load i240, i240* %623
  %625 = trunc i240 %624 to i235
  %626 = lshr i235 %625, 226
  %_3144.partselect = trunc i235 %626 to i1
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
  %628 = bitcast i235* %src_0 to i240*
  %629 = load i240, i240* %628
  %630 = trunc i240 %629 to i235
  %631 = lshr i235 %630, 227
  %_0145.partselect = trunc i235 %631 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.1:                             ; preds = %src.addr.3680.exit
  %632 = bitcast i235* %src_1 to i240*
  %633 = load i240, i240* %632
  %634 = trunc i240 %633 to i235
  %635 = lshr i235 %634, 227
  %_1146.partselect = trunc i235 %635 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.2:                             ; preds = %src.addr.3680.exit
  %636 = bitcast i235* %src_2 to i240*
  %637 = load i240, i240* %636
  %638 = trunc i240 %637 to i235
  %639 = lshr i235 %638, 227
  %_2147.partselect = trunc i235 %639 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.3:                             ; preds = %src.addr.3680.exit
  %640 = bitcast i235* %src_3 to i240*
  %641 = load i240, i240* %640
  %642 = trunc i240 %641 to i235
  %643 = lshr i235 %642, 227
  %_3148.partselect = trunc i235 %643 to i1
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
  %645 = bitcast i235* %src_0 to i240*
  %646 = load i240, i240* %645
  %647 = trunc i240 %646 to i235
  %648 = lshr i235 %647, 228
  %_0149.partselect = trunc i235 %648 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.1:                             ; preds = %src.addr.3782.exit
  %649 = bitcast i235* %src_1 to i240*
  %650 = load i240, i240* %649
  %651 = trunc i240 %650 to i235
  %652 = lshr i235 %651, 228
  %_1150.partselect = trunc i235 %652 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.2:                             ; preds = %src.addr.3782.exit
  %653 = bitcast i235* %src_2 to i240*
  %654 = load i240, i240* %653
  %655 = trunc i240 %654 to i235
  %656 = lshr i235 %655, 228
  %_2151.partselect = trunc i235 %656 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.3:                             ; preds = %src.addr.3782.exit
  %657 = bitcast i235* %src_3 to i240*
  %658 = load i240, i240* %657
  %659 = trunc i240 %658 to i235
  %660 = lshr i235 %659, 228
  %_3152.partselect = trunc i235 %660 to i1
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
  %662 = bitcast i235* %src_0 to i240*
  %663 = load i240, i240* %662
  %664 = trunc i240 %663 to i235
  %665 = lshr i235 %664, 229
  %_0153.partselect = trunc i235 %665 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.1:                             ; preds = %src.addr.3884.exit
  %666 = bitcast i235* %src_1 to i240*
  %667 = load i240, i240* %666
  %668 = trunc i240 %667 to i235
  %669 = lshr i235 %668, 229
  %_1154.partselect = trunc i235 %669 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.2:                             ; preds = %src.addr.3884.exit
  %670 = bitcast i235* %src_2 to i240*
  %671 = load i240, i240* %670
  %672 = trunc i240 %671 to i235
  %673 = lshr i235 %672, 229
  %_2155.partselect = trunc i235 %673 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.3:                             ; preds = %src.addr.3884.exit
  %674 = bitcast i235* %src_3 to i240*
  %675 = load i240, i240* %674
  %676 = trunc i240 %675 to i235
  %677 = lshr i235 %676, 229
  %_3156.partselect = trunc i235 %677 to i1
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
  %679 = bitcast i235* %src_0 to i240*
  %680 = load i240, i240* %679
  %681 = trunc i240 %680 to i235
  %682 = lshr i235 %681, 230
  %_0157.partselect = trunc i235 %682 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.1:                             ; preds = %src.addr.3986.exit
  %683 = bitcast i235* %src_1 to i240*
  %684 = load i240, i240* %683
  %685 = trunc i240 %684 to i235
  %686 = lshr i235 %685, 230
  %_1158.partselect = trunc i235 %686 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.2:                             ; preds = %src.addr.3986.exit
  %687 = bitcast i235* %src_2 to i240*
  %688 = load i240, i240* %687
  %689 = trunc i240 %688 to i235
  %690 = lshr i235 %689, 230
  %_2159.partselect = trunc i235 %690 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.3:                             ; preds = %src.addr.3986.exit
  %691 = bitcast i235* %src_3 to i240*
  %692 = load i240, i240* %691
  %693 = trunc i240 %692 to i235
  %694 = lshr i235 %693, 230
  %_3160.partselect = trunc i235 %694 to i1
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
  %696 = bitcast i235* %src_0 to i240*
  %697 = load i240, i240* %696
  %698 = trunc i240 %697 to i235
  %699 = lshr i235 %698, 231
  %_0161.partselect = trunc i235 %699 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.1:                             ; preds = %src.addr.4088.exit
  %700 = bitcast i235* %src_1 to i240*
  %701 = load i240, i240* %700
  %702 = trunc i240 %701 to i235
  %703 = lshr i235 %702, 231
  %_1162.partselect = trunc i235 %703 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.2:                             ; preds = %src.addr.4088.exit
  %704 = bitcast i235* %src_2 to i240*
  %705 = load i240, i240* %704
  %706 = trunc i240 %705 to i235
  %707 = lshr i235 %706, 231
  %_2163.partselect = trunc i235 %707 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.3:                             ; preds = %src.addr.4088.exit
  %708 = bitcast i235* %src_3 to i240*
  %709 = load i240, i240* %708
  %710 = trunc i240 %709 to i235
  %711 = lshr i235 %710, 231
  %_3164.partselect = trunc i235 %711 to i1
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
  %713 = bitcast i235* %src_0 to i240*
  %714 = load i240, i240* %713
  %715 = trunc i240 %714 to i235
  %716 = lshr i235 %715, 232
  %_0165.partselect = trunc i235 %716 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.1:                             ; preds = %src.addr.4190.exit
  %717 = bitcast i235* %src_1 to i240*
  %718 = load i240, i240* %717
  %719 = trunc i240 %718 to i235
  %720 = lshr i235 %719, 232
  %_1166.partselect = trunc i235 %720 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.2:                             ; preds = %src.addr.4190.exit
  %721 = bitcast i235* %src_2 to i240*
  %722 = load i240, i240* %721
  %723 = trunc i240 %722 to i235
  %724 = lshr i235 %723, 232
  %_2167.partselect = trunc i235 %724 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.3:                             ; preds = %src.addr.4190.exit
  %725 = bitcast i235* %src_3 to i240*
  %726 = load i240, i240* %725
  %727 = trunc i240 %726 to i235
  %728 = lshr i235 %727, 232
  %_3168.partselect = trunc i235 %728 to i1
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
  %730 = bitcast i235* %src_0 to i240*
  %731 = load i240, i240* %730
  %732 = trunc i240 %731 to i235
  %733 = lshr i235 %732, 233
  %_0169.partselect = trunc i235 %733 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.1:                             ; preds = %src.addr.4292.exit
  %734 = bitcast i235* %src_1 to i240*
  %735 = load i240, i240* %734
  %736 = trunc i240 %735 to i235
  %737 = lshr i235 %736, 233
  %_1170.partselect = trunc i235 %737 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.2:                             ; preds = %src.addr.4292.exit
  %738 = bitcast i235* %src_2 to i240*
  %739 = load i240, i240* %738
  %740 = trunc i240 %739 to i235
  %741 = lshr i235 %740, 233
  %_2171.partselect = trunc i235 %741 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.3:                             ; preds = %src.addr.4292.exit
  %742 = bitcast i235* %src_3 to i240*
  %743 = load i240, i240* %742
  %744 = trunc i240 %743 to i235
  %745 = lshr i235 %744, 233
  %_3172.partselect = trunc i235 %745 to i1
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
  %747 = bitcast i235* %src_0 to i240*
  %748 = load i240, i240* %747
  %749 = trunc i240 %748 to i235
  %750 = lshr i235 %749, 234
  %_0173.partselect = trunc i235 %750 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.1:                             ; preds = %src.addr.4394.exit
  %751 = bitcast i235* %src_1 to i240*
  %752 = load i240, i240* %751
  %753 = trunc i240 %752 to i235
  %754 = lshr i235 %753, 234
  %_1174.partselect = trunc i235 %754 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.2:                             ; preds = %src.addr.4394.exit
  %755 = bitcast i235* %src_2 to i240*
  %756 = load i240, i240* %755
  %757 = trunc i240 %756 to i235
  %758 = lshr i235 %757, 234
  %_2175.partselect = trunc i235 %758 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.3:                             ; preds = %src.addr.4394.exit
  %759 = bitcast i235* %src_3 to i240*
  %760 = load i240, i240* %759
  %761 = trunc i240 %760 to i235
  %762 = lshr i235 %761, 234
  %_3176.partselect = trunc i235 %762 to i1
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
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i235* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i235* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1, i235* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.2" %src_2, i235* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.3" %src_3) #1 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i235* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.23.24([4 x %struct.HeadCtx]* nonnull %dst, i235* nonnull %src_0, i235* %src_1, i235* %src_2, i235* %src_3, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i32* noalias "orig.arg.no"="2", i32* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i8* noalias "orig.arg.no"="8", i8* noalias readonly align 512 "orig.arg.no"="9", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="10", i235* noalias readonly align 512 "orig.arg.no"="11" "unpacked"="11.0" %_0, i235* noalias readonly align 512 "orig.arg.no"="11" "unpacked"="11.1" %_1, i235* noalias readonly align 512 "orig.arg.no"="11" "unpacked"="11.2" %_2, i235* noalias readonly align 512 "orig.arg.no"="11" "unpacked"="11.3" %_3, i1* noalias "orig.arg.no"="12", i1* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i1* noalias "orig.arg.no"="16", i1* noalias readonly align 512 "orig.arg.no"="17", i32* noalias "orig.arg.no"="18", i32* noalias readonly align 512 "orig.arg.no"="19", %struct.ControlMemSpace* noalias "orig.arg.no"="20", i1056* noalias readonly align 512 "orig.arg.no"="21", i32* noalias "orig.arg.no"="22", i32* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", i32* noalias "orig.arg.no"="26", i32* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i1* noalias "orig.arg.no"="52", i1* noalias readonly align 512 "orig.arg.no"="53", i1* noalias "orig.arg.no"="54", i1* noalias readonly align 512 "orig.arg.no"="55", i8* noalias "orig.arg.no"="56", i8* noalias readonly align 512 "orig.arg.no"="57", i32* noalias "orig.arg.no"="58", i32* noalias readonly align 512 "orig.arg.no"="59", i32* noalias "orig.arg.no"="60", i32* noalias readonly align 512 "orig.arg.no"="61", i32* noalias "orig.arg.no"="62", i32* noalias readonly align 512 "orig.arg.no"="63", i1* noalias "orig.arg.no"="64", i1* noalias readonly align 512 "orig.arg.no"="65", i1* noalias "orig.arg.no"="66", i1* noalias readonly align 512 "orig.arg.no"="67") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %2, i32* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %8, i8* align 512 %9)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* %10, i235* align 512 %_0, i235* align 512 %_1, i235* align 512 %_2, i235* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %11, i1* align 512 %12)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %13, i32* align 512 %14)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %15, i1* align 512 %16)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %17, i32* align 512 %18)
  call fastcc void @onebyonecpy_hls.p0struct.ControlMemSpace.30(%struct.ControlMemSpace* %19, i1056* align 512 %20)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %21, i32* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %23, i32* align 512 %24)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %25, i32* align 512 %26)
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
  call fastcc void @onebyonecpy_hls.p0i1(i1* %51, i1* align 512 %52)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %53, i1* align 512 %54)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %55, i8* align 512 %56)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %57, i32* align 512 %58)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %59, i32* align 512 %60)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %61, i32* align 512 %62)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %63, i1* align 512 %64)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %65, i1* align 512 %66)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.ControlMemSpace.30(%struct.ControlMemSpace* noalias %dst, i1056* noalias readonly align 512 %src) unnamed_addr #1 {
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

declare void @apatb_transformer_top_hw(i1, i1, i1*, i1, i32*, i1*, i1, i1, i1*, i8*, i235*, i235*, i235*, i235*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i1*, i8*, i32*, i32*, i32*, i1*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i32* noalias "orig.arg.no"="2", i32* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i8* noalias "orig.arg.no"="8", i8* noalias readonly align 512 "orig.arg.no"="9", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="10", i235* noalias readonly align 512 "orig.arg.no"="11" "unpacked"="11.0" %_0, i235* noalias readonly align 512 "orig.arg.no"="11" "unpacked"="11.1" %_1, i235* noalias readonly align 512 "orig.arg.no"="11" "unpacked"="11.2" %_2, i235* noalias readonly align 512 "orig.arg.no"="11" "unpacked"="11.3" %_3, i1* noalias "orig.arg.no"="12", i1* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i1* noalias "orig.arg.no"="16", i1* noalias readonly align 512 "orig.arg.no"="17", i32* noalias "orig.arg.no"="18", i32* noalias readonly align 512 "orig.arg.no"="19", %struct.ControlMemSpace* noalias "orig.arg.no"="20", i1056* noalias readonly align 512 "orig.arg.no"="21", i32* noalias "orig.arg.no"="22", i32* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", i32* noalias "orig.arg.no"="26", i32* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i1* noalias "orig.arg.no"="52", i1* noalias readonly align 512 "orig.arg.no"="53", i1* noalias "orig.arg.no"="54", i1* noalias readonly align 512 "orig.arg.no"="55", i8* noalias "orig.arg.no"="56", i8* noalias readonly align 512 "orig.arg.no"="57", i32* noalias "orig.arg.no"="58", i32* noalias readonly align 512 "orig.arg.no"="59", i32* noalias "orig.arg.no"="60", i32* noalias readonly align 512 "orig.arg.no"="61", i32* noalias "orig.arg.no"="62", i32* noalias readonly align 512 "orig.arg.no"="63", i1* noalias "orig.arg.no"="64", i1* noalias readonly align 512 "orig.arg.no"="65", i1* noalias "orig.arg.no"="66", i1* noalias readonly align 512 "orig.arg.no"="67") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %2, i32* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %8, i8* align 512 %9)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* %10, i235* align 512 %_0, i235* align 512 %_1, i235* align 512 %_2, i235* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %11, i1* align 512 %12)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %13, i32* align 512 %14)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %15, i1* align 512 %16)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %17, i32* align 512 %18)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %21, i32* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %23, i32* align 512 %24)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %25, i32* align 512 %26)
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
  call fastcc void @onebyonecpy_hls.p0i1(i1* %51, i1* align 512 %52)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %53, i1* align 512 %54)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %55, i8* align 512 %56)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %57, i32* align 512 %58)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %59, i32* align 512 %60)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %61, i32* align 512 %62)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %63, i1* align 512 %64)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %65, i1* align 512 %66)
  ret void
}

declare void @transformer_top_hw_stub(i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i8* noalias nocapture nonnull, [4 x %struct.HeadCtx]* noalias nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i32, i32, i32* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, %struct.ControlMemSpace* noalias nocapture nonnull readnone, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i8* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull)

define void @transformer_top_hw_stub_wrapper(i1, i1, i1*, i1, i32*, i1*, i1, i1, i1*, i8*, i235*, i235*, i235*, i235*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i1*, i8*, i32*, i32*, i32*, i1*, i1*) #5 {
entry:
  %50 = call i8* @malloc(i64 272)
  %51 = bitcast i8* %50 to [4 x %struct.HeadCtx]*
  %52 = call i8* @malloc(i64 132)
  %53 = bitcast i8* %52 to %struct.ControlMemSpace*
  call void @copy_out(i1* null, i1* %2, i32* null, i32* %4, i1* null, i1* %5, i1* null, i1* %8, i8* null, i8* %9, [4 x %struct.HeadCtx]* %51, i235* %10, i235* %11, i235* %12, i235* %13, i1* null, i1* %15, i32* null, i32* %19, i1* null, i1* %24, i32* null, i32* %25, %struct.ControlMemSpace* %53, i1056* %26, i32* null, i32* %27, i32* null, i32* %28, i32* null, i32* %29, i32* null, i32* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i1* null, i1* %42, i1* null, i1* %43, i8* null, i8* %44, i32* null, i32* %45, i32* null, i32* %46, i32* null, i32* %47, i1* null, i1* %48, i1* null, i1* %49)
  call void @transformer_top_hw_stub(i1 %0, i1 %1, i1* %2, i1 %3, i32* %4, i1* %5, i1 %6, i1 %7, i1* %8, i8* %9, [4 x %struct.HeadCtx]* %51, i1 %14, i1* %15, i1 %16, i32 %17, i32 %18, i32* %19, i1 %20, i1 %21, i1 %22, i1 %23, i1* %24, i32* %25, %struct.ControlMemSpace* %53, i32* %27, i32* %28, i32* %29, i32* %30, i32* %31, i32* %32, i32* %33, i32* %34, i32* %35, i32* %36, i32* %37, i32* %38, i32* %39, i32* %40, i32* %41, i1* %42, i1* %43, i8* %44, i32* %45, i32* %46, i32* %47, i1* %48, i1* %49)
  call void @copy_in(i1* null, i1* %2, i32* null, i32* %4, i1* null, i1* %5, i1* null, i1* %8, i8* null, i8* %9, [4 x %struct.HeadCtx]* %51, i235* %10, i235* %11, i235* %12, i235* %13, i1* null, i1* %15, i32* null, i32* %19, i1* null, i1* %24, i32* null, i32* %25, %struct.ControlMemSpace* %53, i1056* %26, i32* null, i32* %27, i32* null, i32* %28, i32* null, i32* %29, i32* null, i32* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i1* null, i1* %42, i1* null, i1* %43, i8* null, i8* %44, i32* null, i32* %45, i32* null, i32* %46, i32* null, i32* %47, i1* null, i1* %48, i1* null, i1* %49)
  call void @free(i8* %50)
  call void @free(i8* %52)
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
!7 = !{!"10", [4 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12, !13, !14}
!11 = !{!"10.0", %struct.HeadCtx* null}
!12 = !{!"10.1", %struct.HeadCtx* null}
!13 = !{!"10.2", %struct.HeadCtx* null}
!14 = !{!"10.3", %struct.HeadCtx* null}
