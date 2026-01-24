; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Top_Module/Top_Module/transformer_top/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i32, i32, i8, i1, i1, i8, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }
%struct.ControlMemSpace = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }

; Function Attrs: noinline willreturn
define void @apatb_transformer_top_ir(i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %dma_done, i1 zeroext %wl_ready, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i8* noalias nocapture nonnull dereferenceable(1) %wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %wl_head, i32* noalias nocapture nonnull dereferenceable(4) %wl_tile, i1 zeroext %compute_ready, i1 zeroext %compute_done, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i32* noalias nocapture nonnull dereferenceable(4) %compute_op, [4 x %struct.HeadCtx]* noalias nonnull dereferenceable(272) %head_ctx_ref, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* noalias nocapture nonnull dereferenceable(4) %ctrl_data_out, i1 zeroext %ctrl_read_en, i1 zeroext %ctrl_write_en, i1 zeroext %ctrl_chip_en, i1 zeroext %ctrl_resetn_in, i1* noalias nocapture nonnull dereferenceable(1) %irq_ps, i32* noalias nocapture nonnull dereferenceable(4) %dbg_state, %struct.ControlMemSpace* noalias nocapture nonnull readnone dereferenceable(132) %dbg_ctrl_mem, i32* noalias nocapture nonnull dereferenceable(4) %control_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_status_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_enable_reg, i32* noalias nocapture nonnull dereferenceable(4) %wq_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wk_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wv_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wo_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w1_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w2_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wq_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wk_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wv_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wo_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w1_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w2_tile_stride, i1* noalias nocapture nonnull dereferenceable(1) %dbg_done, i1* noalias nocapture nonnull dereferenceable(1) %dbg_error) local_unnamed_addr #0 {
entry:
  %axis_in_ready_copy = alloca i1, align 512
  %wl_start_copy = alloca i1, align 512
  %wl_addr_sel_copy = alloca i8, align 512
  %wl_layer_copy = alloca i32, align 512
  %wl_head_copy = alloca i32, align 512
  %wl_tile_copy = alloca i32, align 512
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i32, align 512
  %head_ctx_ref_copy_0 = alloca i254, align 512
  %head_ctx_ref_copy_1 = alloca i254, align 512
  %head_ctx_ref_copy_2 = alloca i254, align 512
  %head_ctx_ref_copy_3 = alloca i254, align 512
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
  %dbg_done_copy = alloca i1, align 512
  %dbg_error_copy = alloca i1, align 512
  call void @copy_in(i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i8* nonnull %wl_addr_sel, i8* nonnull align 512 %wl_addr_sel_copy, i32* nonnull %wl_layer, i32* nonnull align 512 %wl_layer_copy, i32* nonnull %wl_head, i32* nonnull align 512 %wl_head_copy, i32* nonnull %wl_tile, i32* nonnull align 512 %wl_tile_copy, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i32* nonnull %compute_op, i32* nonnull align 512 %compute_op_copy, [4 x %struct.HeadCtx]* nonnull %head_ctx_ref, i254* nonnull align 512 %head_ctx_ref_copy_0, i254* nonnull align 512 %head_ctx_ref_copy_1, i254* nonnull align 512 %head_ctx_ref_copy_2, i254* nonnull align 512 %head_ctx_ref_copy_3, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i32* nonnull %ctrl_data_out, i32* nonnull align 512 %ctrl_data_out_copy, i1* nonnull %irq_ps, i1* nonnull align 512 %irq_ps_copy, i32* nonnull %dbg_state, i32* nonnull align 512 %dbg_state_copy, %struct.ControlMemSpace* nonnull %dbg_ctrl_mem, i1056* nonnull align 512 %dbg_ctrl_mem_copy, i32* nonnull %control_reg, i32* nonnull align 512 %control_reg_copy, i32* nonnull %irq_status_reg, i32* nonnull align 512 %irq_status_reg_copy, i32* nonnull %irq_enable_reg, i32* nonnull align 512 %irq_enable_reg_copy, i32* nonnull %wq_base_addr, i32* nonnull align 512 %wq_base_addr_copy, i32* nonnull %wk_base_addr, i32* nonnull align 512 %wk_base_addr_copy, i32* nonnull %wv_base_addr, i32* nonnull align 512 %wv_base_addr_copy, i32* nonnull %wo_base_addr, i32* nonnull align 512 %wo_base_addr_copy, i32* nonnull %w1_base_addr, i32* nonnull align 512 %w1_base_addr_copy, i32* nonnull %w2_base_addr, i32* nonnull align 512 %w2_base_addr_copy, i32* nonnull %wq_head_stride, i32* nonnull align 512 %wq_head_stride_copy, i32* nonnull %wk_head_stride, i32* nonnull align 512 %wk_head_stride_copy, i32* nonnull %wv_head_stride, i32* nonnull align 512 %wv_head_stride_copy, i32* nonnull %wo_tile_stride, i32* nonnull align 512 %wo_tile_stride_copy, i32* nonnull %w1_tile_stride, i32* nonnull align 512 %w1_tile_stride_copy, i32* nonnull %w2_tile_stride, i32* nonnull align 512 %w2_tile_stride_copy, i1* nonnull %dbg_done, i1* nonnull align 512 %dbg_done_copy, i1* nonnull %dbg_error, i1* nonnull align 512 %dbg_error_copy)
  call void @apatb_transformer_top_hw(i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %dma_done, i1 %wl_ready, i1* %wl_start_copy, i8* %wl_addr_sel_copy, i32* %wl_layer_copy, i32* %wl_head_copy, i32* %wl_tile_copy, i1 %compute_ready, i1 %compute_done, i1* %compute_start_copy, i32* %compute_op_copy, i254* %head_ctx_ref_copy_0, i254* %head_ctx_ref_copy_1, i254* %head_ctx_ref_copy_2, i254* %head_ctx_ref_copy_3, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* %ctrl_data_out_copy, i1 %ctrl_read_en, i1 %ctrl_write_en, i1 %ctrl_chip_en, i1 %ctrl_resetn_in, i1* %irq_ps_copy, i32* %dbg_state_copy, i1056* %dbg_ctrl_mem_copy, i32* %control_reg_copy, i32* %irq_status_reg_copy, i32* %irq_enable_reg_copy, i32* %wq_base_addr_copy, i32* %wk_base_addr_copy, i32* %wv_base_addr_copy, i32* %wo_base_addr_copy, i32* %w1_base_addr_copy, i32* %w2_base_addr_copy, i32* %wq_head_stride_copy, i32* %wk_head_stride_copy, i32* %wv_head_stride_copy, i32* %wo_tile_stride_copy, i32* %w1_tile_stride_copy, i32* %w2_tile_stride_copy, i1* %dbg_done_copy, i1* %dbg_error_copy)
  call void @copy_back(i1* %axis_in_ready, i1* %axis_in_ready_copy, i1* %wl_start, i1* %wl_start_copy, i8* %wl_addr_sel, i8* %wl_addr_sel_copy, i32* %wl_layer, i32* %wl_layer_copy, i32* %wl_head, i32* %wl_head_copy, i32* %wl_tile, i32* %wl_tile_copy, i1* %compute_start, i1* %compute_start_copy, i32* %compute_op, i32* %compute_op_copy, [4 x %struct.HeadCtx]* %head_ctx_ref, i254* %head_ctx_ref_copy_0, i254* %head_ctx_ref_copy_1, i254* %head_ctx_ref_copy_2, i254* %head_ctx_ref_copy_3, i1* %stream_start, i1* %stream_start_copy, i32* %ctrl_data_out, i32* %ctrl_data_out_copy, i1* %irq_ps, i1* %irq_ps_copy, i32* %dbg_state, i32* %dbg_state_copy, %struct.ControlMemSpace* %dbg_ctrl_mem, i1056* %dbg_ctrl_mem_copy, i32* %control_reg, i32* %control_reg_copy, i32* %irq_status_reg, i32* %irq_status_reg_copy, i32* %irq_enable_reg, i32* %irq_enable_reg_copy, i32* %wq_base_addr, i32* %wq_base_addr_copy, i32* %wk_base_addr, i32* %wk_base_addr_copy, i32* %wv_base_addr, i32* %wv_base_addr_copy, i32* %wo_base_addr, i32* %wo_base_addr_copy, i32* %w1_base_addr, i32* %w1_base_addr_copy, i32* %w2_base_addr, i32* %w2_base_addr_copy, i32* %wq_head_stride, i32* %wq_head_stride_copy, i32* %wk_head_stride, i32* %wk_head_stride_copy, i32* %wv_head_stride, i32* %wv_head_stride_copy, i32* %wo_tile_stride, i32* %wo_tile_stride_copy, i32* %w1_tile_stride, i32* %w1_tile_stride_copy, i32* %w2_tile_stride, i32* %w2_tile_stride_copy, i1* %dbg_done, i1* %dbg_done_copy, i1* %dbg_error, i1* %dbg_error_copy)
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
define void @arraycpy_hls.p0a4struct.HeadCtx([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond102 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond102, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx103 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 0
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 1
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 1
  %4 = load i32, i32* %src.addr.110, align 4
  store i32 %4, i32* %dst.addr.111, align 4
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 2
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 2
  %5 = load i8, i8* %src.addr.212, align 1
  store i8 %5, i8* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 3
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 3
  %6 = bitcast i1* %src.addr.314 to i8*
  %7 = load i8, i8* %6
  %8 = trunc i8 %7 to i1
  store i1 %8, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 4
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 4
  %9 = bitcast i1* %src.addr.416 to i8*
  %10 = load i8, i8* %9
  %11 = trunc i8 %10 to i1
  store i1 %11, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 5
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 5
  %12 = bitcast i1* %src.addr.518 to i8*
  %13 = load i8, i8* %12
  %14 = trunc i8 %13 to i1
  store i1 %14, i1* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 6
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 6
  %15 = load i32, i32* %src.addr.620, align 4
  store i32 %15, i32* %dst.addr.621, align 4
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 7
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 7
  %16 = load i32, i32* %src.addr.722, align 4
  store i32 %16, i32* %dst.addr.723, align 4
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 8
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 8
  %17 = load i8, i8* %src.addr.824, align 1
  store i8 %17, i8* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 9
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 9
  %18 = bitcast i1* %src.addr.926 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  store i1 %20, i1* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 10
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 10
  %21 = bitcast i1* %src.addr.1028 to i8*
  %22 = load i8, i8* %21
  %23 = trunc i8 %22 to i1
  store i1 %23, i1* %dst.addr.1029, align 1
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 11
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 11
  %24 = load i8, i8* %src.addr.1130, align 1
  store i8 %24, i8* %dst.addr.1131, align 1
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 12
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 12
  %25 = load i32, i32* %src.addr.1232, align 4
  store i32 %25, i32* %dst.addr.1233, align 4
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 13
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 13
  %26 = load i32, i32* %src.addr.1334, align 4
  store i32 %26, i32* %dst.addr.1335, align 4
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 14
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 14
  %27 = bitcast i1* %src.addr.1436 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  store i1 %29, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 15
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 15
  %30 = bitcast i1* %src.addr.1538 to i8*
  %31 = load i8, i8* %30
  %32 = trunc i8 %31 to i1
  store i1 %32, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 16
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 16
  %33 = bitcast i1* %src.addr.1640 to i8*
  %34 = load i8, i8* %33
  %35 = trunc i8 %34 to i1
  store i1 %35, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 17
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 17
  %36 = bitcast i1* %src.addr.1742 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  store i1 %38, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 18
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 18
  %39 = bitcast i1* %src.addr.1844 to i8*
  %40 = load i8, i8* %39
  %41 = trunc i8 %40 to i1
  store i1 %41, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 19
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 19
  %42 = bitcast i1* %src.addr.1946 to i8*
  %43 = load i8, i8* %42
  %44 = trunc i8 %43 to i1
  store i1 %44, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 20
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 20
  %45 = bitcast i1* %src.addr.2048 to i8*
  %46 = load i8, i8* %45
  %47 = trunc i8 %46 to i1
  store i1 %47, i1* %dst.addr.2049, align 1
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 21
  %dst.addr.2151 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 21
  %48 = bitcast i1* %src.addr.2150 to i8*
  %49 = load i8, i8* %48
  %50 = trunc i8 %49 to i1
  store i1 %50, i1* %dst.addr.2151, align 1
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 22
  %dst.addr.2253 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 22
  %51 = bitcast i1* %src.addr.2252 to i8*
  %52 = load i8, i8* %51
  %53 = trunc i8 %52 to i1
  store i1 %53, i1* %dst.addr.2253, align 1
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 23
  %dst.addr.2355 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 23
  %54 = bitcast i1* %src.addr.2354 to i8*
  %55 = load i8, i8* %54
  %56 = trunc i8 %55 to i1
  store i1 %56, i1* %dst.addr.2355, align 1
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 24
  %dst.addr.2457 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 24
  %57 = bitcast i1* %src.addr.2456 to i8*
  %58 = load i8, i8* %57
  %59 = trunc i8 %58 to i1
  store i1 %59, i1* %dst.addr.2457, align 1
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 25
  %dst.addr.2559 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 25
  %60 = bitcast i1* %src.addr.2558 to i8*
  %61 = load i8, i8* %60
  %62 = trunc i8 %61 to i1
  store i1 %62, i1* %dst.addr.2559, align 1
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 26
  %dst.addr.2661 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 26
  %63 = bitcast i1* %src.addr.2660 to i8*
  %64 = load i8, i8* %63
  %65 = trunc i8 %64 to i1
  store i1 %65, i1* %dst.addr.2661, align 1
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 27
  %dst.addr.2763 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 27
  %66 = bitcast i1* %src.addr.2762 to i8*
  %67 = load i8, i8* %66
  %68 = trunc i8 %67 to i1
  store i1 %68, i1* %dst.addr.2763, align 1
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 28
  %dst.addr.2865 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 28
  %69 = bitcast i1* %src.addr.2864 to i8*
  %70 = load i8, i8* %69
  %71 = trunc i8 %70 to i1
  store i1 %71, i1* %dst.addr.2865, align 1
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 29
  %dst.addr.2967 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 29
  %72 = bitcast i1* %src.addr.2966 to i8*
  %73 = load i8, i8* %72
  %74 = trunc i8 %73 to i1
  store i1 %74, i1* %dst.addr.2967, align 1
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 30
  %dst.addr.3069 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 30
  %75 = bitcast i1* %src.addr.3068 to i8*
  %76 = load i8, i8* %75
  %77 = trunc i8 %76 to i1
  store i1 %77, i1* %dst.addr.3069, align 1
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 31
  %dst.addr.3171 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 31
  %78 = bitcast i1* %src.addr.3170 to i8*
  %79 = load i8, i8* %78
  %80 = trunc i8 %79 to i1
  store i1 %80, i1* %dst.addr.3171, align 1
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 32
  %dst.addr.3273 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 32
  %81 = bitcast i1* %src.addr.3272 to i8*
  %82 = load i8, i8* %81
  %83 = trunc i8 %82 to i1
  store i1 %83, i1* %dst.addr.3273, align 1
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 33
  %dst.addr.3375 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 33
  %84 = bitcast i1* %src.addr.3374 to i8*
  %85 = load i8, i8* %84
  %86 = trunc i8 %85 to i1
  store i1 %86, i1* %dst.addr.3375, align 1
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 34
  %dst.addr.3477 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 34
  %87 = bitcast i1* %src.addr.3476 to i8*
  %88 = load i8, i8* %87
  %89 = trunc i8 %88 to i1
  store i1 %89, i1* %dst.addr.3477, align 1
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 35
  %dst.addr.3579 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 35
  %90 = bitcast i1* %src.addr.3578 to i8*
  %91 = load i8, i8* %90
  %92 = trunc i8 %91 to i1
  store i1 %92, i1* %dst.addr.3579, align 1
  %src.addr.3680 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 36
  %dst.addr.3681 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 36
  %93 = bitcast i1* %src.addr.3680 to i8*
  %94 = load i8, i8* %93
  %95 = trunc i8 %94 to i1
  store i1 %95, i1* %dst.addr.3681, align 1
  %src.addr.3782 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 37
  %dst.addr.3783 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 37
  %96 = bitcast i1* %src.addr.3782 to i8*
  %97 = load i8, i8* %96
  %98 = trunc i8 %97 to i1
  store i1 %98, i1* %dst.addr.3783, align 1
  %src.addr.3884 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 38
  %dst.addr.3885 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 38
  %99 = bitcast i1* %src.addr.3884 to i8*
  %100 = load i8, i8* %99
  %101 = trunc i8 %100 to i1
  store i1 %101, i1* %dst.addr.3885, align 1
  %src.addr.3986 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 39
  %dst.addr.3987 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 39
  %102 = bitcast i1* %src.addr.3986 to i8*
  %103 = load i8, i8* %102
  %104 = trunc i8 %103 to i1
  store i1 %104, i1* %dst.addr.3987, align 1
  %src.addr.4088 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 40
  %dst.addr.4089 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 40
  %105 = bitcast i1* %src.addr.4088 to i8*
  %106 = load i8, i8* %105
  %107 = trunc i8 %106 to i1
  store i1 %107, i1* %dst.addr.4089, align 1
  %src.addr.4190 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 41
  %dst.addr.4191 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 41
  %108 = bitcast i1* %src.addr.4190 to i8*
  %109 = load i8, i8* %108
  %110 = trunc i8 %109 to i1
  store i1 %110, i1* %dst.addr.4191, align 1
  %src.addr.4292 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 42
  %dst.addr.4293 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 42
  %111 = bitcast i1* %src.addr.4292 to i8*
  %112 = load i8, i8* %111
  %113 = trunc i8 %112 to i1
  store i1 %113, i1* %dst.addr.4293, align 1
  %src.addr.4394 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 43
  %dst.addr.4395 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 43
  %114 = bitcast i1* %src.addr.4394 to i8*
  %115 = load i8, i8* %114
  %116 = trunc i8 %115 to i1
  store i1 %116, i1* %dst.addr.4395, align 1
  %src.addr.4496 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 44
  %dst.addr.4497 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 44
  %117 = bitcast i1* %src.addr.4496 to i8*
  %118 = load i8, i8* %117
  %119 = trunc i8 %118 to i1
  store i1 %119, i1* %dst.addr.4497, align 1
  %src.addr.4598 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 45
  %dst.addr.4599 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 45
  %120 = bitcast i1* %src.addr.4598 to i8*
  %121 = load i8, i8* %120
  %122 = trunc i8 %121 to i1
  store i1 %122, i1* %dst.addr.4599, align 1
  %src.addr.46100 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 46
  %dst.addr.46101 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 46
  %123 = bitcast i1* %src.addr.46100 to i8*
  %124 = load i8, i8* %123
  %125 = trunc i8 %124 to i1
  store i1 %125, i1* %dst.addr.46101, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx103, 1
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
define void @arraycpy_hls.p0a4struct.HeadCtx.13.14(i254* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i254* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i254* "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i254* "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i254* %dst_0, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond102 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond102, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %dst.addr.46101.exit, %for.loop.lr.ph
  %for.loop.idx103 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %dst.addr.46101.exit ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  switch i64 %for.loop.idx103, label %dst.addr.02.exit [
    i64 0, label %dst.addr.02.case.0
    i64 1, label %dst.addr.02.case.1
    i64 2, label %dst.addr.02.case.2
    i64 3, label %dst.addr.02.case.3
  ]

dst.addr.02.case.0:                               ; preds = %for.loop
  %4 = bitcast i254* %dst_0 to i256*
  %5 = load i256, i256* %4
  %6 = trunc i256 %5 to i254
  %7 = zext i32 %3 to i254
  %8 = and i254 %6, -4294967296
  %.partset187 = or i254 %8, %7
  store i254 %.partset187, i254* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i254* %dst_1 to i256*
  %10 = load i256, i256* %9
  %11 = trunc i256 %10 to i254
  %12 = zext i32 %3 to i254
  %13 = and i254 %11, -4294967296
  %.partset94 = or i254 %13, %12
  store i254 %.partset94, i254* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.2:                               ; preds = %for.loop
  %14 = bitcast i254* %dst_2 to i256*
  %15 = load i256, i256* %14
  %16 = trunc i256 %15 to i254
  %17 = zext i32 %3 to i254
  %18 = and i254 %16, -4294967296
  %.partset93 = or i254 %18, %17
  store i254 %.partset93, i254* %dst_2, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.3:                               ; preds = %for.loop
  %19 = bitcast i254* %dst_3 to i256*
  %20 = load i256, i256* %19
  %21 = trunc i256 %20 to i254
  %22 = zext i32 %3 to i254
  %23 = and i254 %21, -4294967296
  %.partset = or i254 %23, %22
  store i254 %.partset, i254* %dst_3, align 4
  br label %dst.addr.02.exit

dst.addr.02.exit:                                 ; preds = %dst.addr.02.case.3, %dst.addr.02.case.2, %dst.addr.02.case.1, %dst.addr.02.case.0, %for.loop
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 1
  %24 = load i32, i32* %src.addr.110, align 4
  switch i64 %for.loop.idx103, label %dst.addr.111.exit [
    i64 0, label %dst.addr.111.case.0
    i64 1, label %dst.addr.111.case.1
    i64 2, label %dst.addr.111.case.2
    i64 3, label %dst.addr.111.case.3
  ]

dst.addr.111.case.0:                              ; preds = %dst.addr.02.exit
  %25 = bitcast i254* %dst_0 to i256*
  %26 = load i256, i256* %25
  %27 = trunc i256 %26 to i254
  %28 = zext i32 %24 to i254
  %29 = shl i254 %28, 32
  %30 = and i254 %27, -18446744069414584321
  %.partset186 = or i254 %30, %29
  store i254 %.partset186, i254* %dst_0, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %31 = bitcast i254* %dst_1 to i256*
  %32 = load i256, i256* %31
  %33 = trunc i256 %32 to i254
  %34 = zext i32 %24 to i254
  %35 = shl i254 %34, 32
  %36 = and i254 %33, -18446744069414584321
  %.partset95 = or i254 %36, %35
  store i254 %.partset95, i254* %dst_1, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.2:                              ; preds = %dst.addr.02.exit
  %37 = bitcast i254* %dst_2 to i256*
  %38 = load i256, i256* %37
  %39 = trunc i256 %38 to i254
  %40 = zext i32 %24 to i254
  %41 = shl i254 %40, 32
  %42 = and i254 %39, -18446744069414584321
  %.partset92 = or i254 %42, %41
  store i254 %.partset92, i254* %dst_2, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.3:                              ; preds = %dst.addr.02.exit
  %43 = bitcast i254* %dst_3 to i256*
  %44 = load i256, i256* %43
  %45 = trunc i256 %44 to i254
  %46 = zext i32 %24 to i254
  %47 = shl i254 %46, 32
  %48 = and i254 %45, -18446744069414584321
  %.partset1 = or i254 %48, %47
  store i254 %.partset1, i254* %dst_3, align 4
  br label %dst.addr.111.exit

dst.addr.111.exit:                                ; preds = %dst.addr.111.case.3, %dst.addr.111.case.2, %dst.addr.111.case.1, %dst.addr.111.case.0, %dst.addr.02.exit
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 2
  %49 = load i8, i8* %src.addr.212, align 1
  switch i64 %for.loop.idx103, label %dst.addr.213.exit [
    i64 0, label %dst.addr.213.case.0
    i64 1, label %dst.addr.213.case.1
    i64 2, label %dst.addr.213.case.2
    i64 3, label %dst.addr.213.case.3
  ]

dst.addr.213.case.0:                              ; preds = %dst.addr.111.exit
  %50 = bitcast i254* %dst_0 to i256*
  %51 = load i256, i256* %50
  %52 = trunc i256 %51 to i254
  %53 = zext i8 %49 to i254
  %54 = shl i254 %53, 64
  %55 = and i254 %52, -4703919738795935662081
  %.partset185 = or i254 %55, %54
  store i254 %.partset185, i254* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %56 = bitcast i254* %dst_1 to i256*
  %57 = load i256, i256* %56
  %58 = trunc i256 %57 to i254
  %59 = zext i8 %49 to i254
  %60 = shl i254 %59, 64
  %61 = and i254 %58, -4703919738795935662081
  %.partset96 = or i254 %61, %60
  store i254 %.partset96, i254* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.2:                              ; preds = %dst.addr.111.exit
  %62 = bitcast i254* %dst_2 to i256*
  %63 = load i256, i256* %62
  %64 = trunc i256 %63 to i254
  %65 = zext i8 %49 to i254
  %66 = shl i254 %65, 64
  %67 = and i254 %64, -4703919738795935662081
  %.partset91 = or i254 %67, %66
  store i254 %.partset91, i254* %dst_2, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.3:                              ; preds = %dst.addr.111.exit
  %68 = bitcast i254* %dst_3 to i256*
  %69 = load i256, i256* %68
  %70 = trunc i256 %69 to i254
  %71 = zext i8 %49 to i254
  %72 = shl i254 %71, 64
  %73 = and i254 %70, -4703919738795935662081
  %.partset2 = or i254 %73, %72
  store i254 %.partset2, i254* %dst_3, align 1
  br label %dst.addr.213.exit

dst.addr.213.exit:                                ; preds = %dst.addr.213.case.3, %dst.addr.213.case.2, %dst.addr.213.case.1, %dst.addr.213.case.0, %dst.addr.111.exit
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 3
  %74 = bitcast i1* %src.addr.314 to i8*
  %75 = load i8, i8* %74
  %76 = trunc i8 %75 to i1
  switch i64 %for.loop.idx103, label %dst.addr.315.exit [
    i64 0, label %dst.addr.315.case.0
    i64 1, label %dst.addr.315.case.1
    i64 2, label %dst.addr.315.case.2
    i64 3, label %dst.addr.315.case.3
  ]

dst.addr.315.case.0:                              ; preds = %dst.addr.213.exit
  %77 = bitcast i254* %dst_0 to i256*
  %78 = load i256, i256* %77
  %79 = trunc i256 %78 to i254
  %80 = zext i1 %76 to i254
  %81 = shl i254 %80, 72
  %82 = and i254 %79, -4722366482869645213697
  %.partset184 = or i254 %82, %81
  store i254 %.partset184, i254* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %83 = bitcast i254* %dst_1 to i256*
  %84 = load i256, i256* %83
  %85 = trunc i256 %84 to i254
  %86 = zext i1 %76 to i254
  %87 = shl i254 %86, 72
  %88 = and i254 %85, -4722366482869645213697
  %.partset97 = or i254 %88, %87
  store i254 %.partset97, i254* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.2:                              ; preds = %dst.addr.213.exit
  %89 = bitcast i254* %dst_2 to i256*
  %90 = load i256, i256* %89
  %91 = trunc i256 %90 to i254
  %92 = zext i1 %76 to i254
  %93 = shl i254 %92, 72
  %94 = and i254 %91, -4722366482869645213697
  %.partset90 = or i254 %94, %93
  store i254 %.partset90, i254* %dst_2, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.3:                              ; preds = %dst.addr.213.exit
  %95 = bitcast i254* %dst_3 to i256*
  %96 = load i256, i256* %95
  %97 = trunc i256 %96 to i254
  %98 = zext i1 %76 to i254
  %99 = shl i254 %98, 72
  %100 = and i254 %97, -4722366482869645213697
  %.partset3 = or i254 %100, %99
  store i254 %.partset3, i254* %dst_3, align 1
  br label %dst.addr.315.exit

dst.addr.315.exit:                                ; preds = %dst.addr.315.case.3, %dst.addr.315.case.2, %dst.addr.315.case.1, %dst.addr.315.case.0, %dst.addr.213.exit
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 4
  %101 = bitcast i1* %src.addr.416 to i8*
  %102 = load i8, i8* %101
  %103 = trunc i8 %102 to i1
  switch i64 %for.loop.idx103, label %dst.addr.417.exit [
    i64 0, label %dst.addr.417.case.0
    i64 1, label %dst.addr.417.case.1
    i64 2, label %dst.addr.417.case.2
    i64 3, label %dst.addr.417.case.3
  ]

dst.addr.417.case.0:                              ; preds = %dst.addr.315.exit
  %104 = bitcast i254* %dst_0 to i256*
  %105 = load i256, i256* %104
  %106 = trunc i256 %105 to i254
  %107 = zext i1 %103 to i254
  %108 = shl i254 %107, 73
  %109 = and i254 %106, -9444732965739290427393
  %.partset183 = or i254 %109, %108
  store i254 %.partset183, i254* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %110 = bitcast i254* %dst_1 to i256*
  %111 = load i256, i256* %110
  %112 = trunc i256 %111 to i254
  %113 = zext i1 %103 to i254
  %114 = shl i254 %113, 73
  %115 = and i254 %112, -9444732965739290427393
  %.partset98 = or i254 %115, %114
  store i254 %.partset98, i254* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.2:                              ; preds = %dst.addr.315.exit
  %116 = bitcast i254* %dst_2 to i256*
  %117 = load i256, i256* %116
  %118 = trunc i256 %117 to i254
  %119 = zext i1 %103 to i254
  %120 = shl i254 %119, 73
  %121 = and i254 %118, -9444732965739290427393
  %.partset89 = or i254 %121, %120
  store i254 %.partset89, i254* %dst_2, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.3:                              ; preds = %dst.addr.315.exit
  %122 = bitcast i254* %dst_3 to i256*
  %123 = load i256, i256* %122
  %124 = trunc i256 %123 to i254
  %125 = zext i1 %103 to i254
  %126 = shl i254 %125, 73
  %127 = and i254 %124, -9444732965739290427393
  %.partset4 = or i254 %127, %126
  store i254 %.partset4, i254* %dst_3, align 1
  br label %dst.addr.417.exit

dst.addr.417.exit:                                ; preds = %dst.addr.417.case.3, %dst.addr.417.case.2, %dst.addr.417.case.1, %dst.addr.417.case.0, %dst.addr.315.exit
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 5
  %128 = bitcast i1* %src.addr.518 to i8*
  %129 = load i8, i8* %128
  %130 = trunc i8 %129 to i1
  switch i64 %for.loop.idx103, label %dst.addr.519.exit [
    i64 0, label %dst.addr.519.case.0
    i64 1, label %dst.addr.519.case.1
    i64 2, label %dst.addr.519.case.2
    i64 3, label %dst.addr.519.case.3
  ]

dst.addr.519.case.0:                              ; preds = %dst.addr.417.exit
  %131 = bitcast i254* %dst_0 to i256*
  %132 = load i256, i256* %131
  %133 = trunc i256 %132 to i254
  %134 = zext i1 %130 to i254
  %135 = shl i254 %134, 74
  %136 = and i254 %133, -18889465931478580854785
  %.partset182 = or i254 %136, %135
  store i254 %.partset182, i254* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %137 = bitcast i254* %dst_1 to i256*
  %138 = load i256, i256* %137
  %139 = trunc i256 %138 to i254
  %140 = zext i1 %130 to i254
  %141 = shl i254 %140, 74
  %142 = and i254 %139, -18889465931478580854785
  %.partset99 = or i254 %142, %141
  store i254 %.partset99, i254* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.2:                              ; preds = %dst.addr.417.exit
  %143 = bitcast i254* %dst_2 to i256*
  %144 = load i256, i256* %143
  %145 = trunc i256 %144 to i254
  %146 = zext i1 %130 to i254
  %147 = shl i254 %146, 74
  %148 = and i254 %145, -18889465931478580854785
  %.partset88 = or i254 %148, %147
  store i254 %.partset88, i254* %dst_2, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.3:                              ; preds = %dst.addr.417.exit
  %149 = bitcast i254* %dst_3 to i256*
  %150 = load i256, i256* %149
  %151 = trunc i256 %150 to i254
  %152 = zext i1 %130 to i254
  %153 = shl i254 %152, 74
  %154 = and i254 %151, -18889465931478580854785
  %.partset5 = or i254 %154, %153
  store i254 %.partset5, i254* %dst_3, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.3, %dst.addr.519.case.2, %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 6
  %155 = load i32, i32* %src.addr.620, align 4
  switch i64 %for.loop.idx103, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
    i64 2, label %dst.addr.621.case.2
    i64 3, label %dst.addr.621.case.3
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %156 = bitcast i254* %dst_0 to i256*
  %157 = load i256, i256* %156
  %158 = trunc i256 %157 to i254
  %159 = zext i32 %155 to i254
  %160 = shl i254 %159, 75
  %161 = and i254 %158, -162259276791434431528620848578561
  %.partset181 = or i254 %161, %160
  store i254 %.partset181, i254* %dst_0, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %162 = bitcast i254* %dst_1 to i256*
  %163 = load i256, i256* %162
  %164 = trunc i256 %163 to i254
  %165 = zext i32 %155 to i254
  %166 = shl i254 %165, 75
  %167 = and i254 %164, -162259276791434431528620848578561
  %.partset100 = or i254 %167, %166
  store i254 %.partset100, i254* %dst_1, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.2:                              ; preds = %dst.addr.519.exit
  %168 = bitcast i254* %dst_2 to i256*
  %169 = load i256, i256* %168
  %170 = trunc i256 %169 to i254
  %171 = zext i32 %155 to i254
  %172 = shl i254 %171, 75
  %173 = and i254 %170, -162259276791434431528620848578561
  %.partset87 = or i254 %173, %172
  store i254 %.partset87, i254* %dst_2, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.3:                              ; preds = %dst.addr.519.exit
  %174 = bitcast i254* %dst_3 to i256*
  %175 = load i256, i256* %174
  %176 = trunc i256 %175 to i254
  %177 = zext i32 %155 to i254
  %178 = shl i254 %177, 75
  %179 = and i254 %176, -162259276791434431528620848578561
  %.partset6 = or i254 %179, %178
  store i254 %.partset6, i254* %dst_3, align 4
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.3, %dst.addr.621.case.2, %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 7
  %180 = load i32, i32* %src.addr.722, align 4
  switch i64 %for.loop.idx103, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
    i64 2, label %dst.addr.723.case.2
    i64 3, label %dst.addr.723.case.3
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %181 = bitcast i254* %dst_0 to i256*
  %182 = load i256, i256* %181
  %183 = trunc i256 %182 to i254
  %184 = zext i32 %180 to i254
  %185 = shl i254 %184, 107
  %186 = and i254 %183, -696898287291822696343777832628683286773761
  %.partset180 = or i254 %186, %185
  store i254 %.partset180, i254* %dst_0, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %187 = bitcast i254* %dst_1 to i256*
  %188 = load i256, i256* %187
  %189 = trunc i256 %188 to i254
  %190 = zext i32 %180 to i254
  %191 = shl i254 %190, 107
  %192 = and i254 %189, -696898287291822696343777832628683286773761
  %.partset101 = or i254 %192, %191
  store i254 %.partset101, i254* %dst_1, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.2:                              ; preds = %dst.addr.621.exit
  %193 = bitcast i254* %dst_2 to i256*
  %194 = load i256, i256* %193
  %195 = trunc i256 %194 to i254
  %196 = zext i32 %180 to i254
  %197 = shl i254 %196, 107
  %198 = and i254 %195, -696898287291822696343777832628683286773761
  %.partset86 = or i254 %198, %197
  store i254 %.partset86, i254* %dst_2, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.3:                              ; preds = %dst.addr.621.exit
  %199 = bitcast i254* %dst_3 to i256*
  %200 = load i256, i256* %199
  %201 = trunc i256 %200 to i254
  %202 = zext i32 %180 to i254
  %203 = shl i254 %202, 107
  %204 = and i254 %201, -696898287291822696343777832628683286773761
  %.partset7 = or i254 %204, %203
  store i254 %.partset7, i254* %dst_3, align 4
  br label %dst.addr.723.exit

dst.addr.723.exit:                                ; preds = %dst.addr.723.case.3, %dst.addr.723.case.2, %dst.addr.723.case.1, %dst.addr.723.case.0, %dst.addr.621.exit
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 8
  %205 = load i8, i8* %src.addr.824, align 1
  switch i64 %for.loop.idx103, label %dst.addr.825.exit [
    i64 0, label %dst.addr.825.case.0
    i64 1, label %dst.addr.825.case.1
    i64 2, label %dst.addr.825.case.2
    i64 3, label %dst.addr.825.case.3
  ]

dst.addr.825.case.0:                              ; preds = %dst.addr.723.exit
  %206 = bitcast i254* %dst_0 to i256*
  %207 = load i256, i256* %206
  %208 = trunc i256 %207 to i254
  %209 = zext i8 %205 to i254
  %210 = shl i254 %209, 139
  %211 = and i254 %208, -177709063300790903159112754985166630750781441
  %.partset179 = or i254 %211, %210
  store i254 %.partset179, i254* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %212 = bitcast i254* %dst_1 to i256*
  %213 = load i256, i256* %212
  %214 = trunc i256 %213 to i254
  %215 = zext i8 %205 to i254
  %216 = shl i254 %215, 139
  %217 = and i254 %214, -177709063300790903159112754985166630750781441
  %.partset102 = or i254 %217, %216
  store i254 %.partset102, i254* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.2:                              ; preds = %dst.addr.723.exit
  %218 = bitcast i254* %dst_2 to i256*
  %219 = load i256, i256* %218
  %220 = trunc i256 %219 to i254
  %221 = zext i8 %205 to i254
  %222 = shl i254 %221, 139
  %223 = and i254 %220, -177709063300790903159112754985166630750781441
  %.partset85 = or i254 %223, %222
  store i254 %.partset85, i254* %dst_2, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.3:                              ; preds = %dst.addr.723.exit
  %224 = bitcast i254* %dst_3 to i256*
  %225 = load i256, i256* %224
  %226 = trunc i256 %225 to i254
  %227 = zext i8 %205 to i254
  %228 = shl i254 %227, 139
  %229 = and i254 %226, -177709063300790903159112754985166630750781441
  %.partset8 = or i254 %229, %228
  store i254 %.partset8, i254* %dst_3, align 1
  br label %dst.addr.825.exit

dst.addr.825.exit:                                ; preds = %dst.addr.825.case.3, %dst.addr.825.case.2, %dst.addr.825.case.1, %dst.addr.825.case.0, %dst.addr.723.exit
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 9
  %230 = bitcast i1* %src.addr.926 to i8*
  %231 = load i8, i8* %230
  %232 = trunc i8 %231 to i1
  switch i64 %for.loop.idx103, label %dst.addr.927.exit [
    i64 0, label %dst.addr.927.case.0
    i64 1, label %dst.addr.927.case.1
    i64 2, label %dst.addr.927.case.2
    i64 3, label %dst.addr.927.case.3
  ]

dst.addr.927.case.0:                              ; preds = %dst.addr.825.exit
  %233 = bitcast i254* %dst_0 to i256*
  %234 = load i256, i256* %233
  %235 = trunc i256 %234 to i254
  %236 = zext i1 %232 to i254
  %237 = shl i254 %236, 147
  %238 = and i254 %235, -178405961588244985132285746181186892047843329
  %.partset178 = or i254 %238, %237
  store i254 %.partset178, i254* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %239 = bitcast i254* %dst_1 to i256*
  %240 = load i256, i256* %239
  %241 = trunc i256 %240 to i254
  %242 = zext i1 %232 to i254
  %243 = shl i254 %242, 147
  %244 = and i254 %241, -178405961588244985132285746181186892047843329
  %.partset103 = or i254 %244, %243
  store i254 %.partset103, i254* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.2:                              ; preds = %dst.addr.825.exit
  %245 = bitcast i254* %dst_2 to i256*
  %246 = load i256, i256* %245
  %247 = trunc i256 %246 to i254
  %248 = zext i1 %232 to i254
  %249 = shl i254 %248, 147
  %250 = and i254 %247, -178405961588244985132285746181186892047843329
  %.partset84 = or i254 %250, %249
  store i254 %.partset84, i254* %dst_2, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.3:                              ; preds = %dst.addr.825.exit
  %251 = bitcast i254* %dst_3 to i256*
  %252 = load i256, i256* %251
  %253 = trunc i256 %252 to i254
  %254 = zext i1 %232 to i254
  %255 = shl i254 %254, 147
  %256 = and i254 %253, -178405961588244985132285746181186892047843329
  %.partset9 = or i254 %256, %255
  store i254 %.partset9, i254* %dst_3, align 1
  br label %dst.addr.927.exit

dst.addr.927.exit:                                ; preds = %dst.addr.927.case.3, %dst.addr.927.case.2, %dst.addr.927.case.1, %dst.addr.927.case.0, %dst.addr.825.exit
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 10
  %257 = bitcast i1* %src.addr.1028 to i8*
  %258 = load i8, i8* %257
  %259 = trunc i8 %258 to i1
  switch i64 %for.loop.idx103, label %dst.addr.1029.exit [
    i64 0, label %dst.addr.1029.case.0
    i64 1, label %dst.addr.1029.case.1
    i64 2, label %dst.addr.1029.case.2
    i64 3, label %dst.addr.1029.case.3
  ]

dst.addr.1029.case.0:                             ; preds = %dst.addr.927.exit
  %260 = bitcast i254* %dst_0 to i256*
  %261 = load i256, i256* %260
  %262 = trunc i256 %261 to i254
  %263 = zext i1 %259 to i254
  %264 = shl i254 %263, 148
  %265 = and i254 %262, -356811923176489970264571492362373784095686657
  %.partset177 = or i254 %265, %264
  store i254 %.partset177, i254* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %266 = bitcast i254* %dst_1 to i256*
  %267 = load i256, i256* %266
  %268 = trunc i256 %267 to i254
  %269 = zext i1 %259 to i254
  %270 = shl i254 %269, 148
  %271 = and i254 %268, -356811923176489970264571492362373784095686657
  %.partset104 = or i254 %271, %270
  store i254 %.partset104, i254* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.2:                             ; preds = %dst.addr.927.exit
  %272 = bitcast i254* %dst_2 to i256*
  %273 = load i256, i256* %272
  %274 = trunc i256 %273 to i254
  %275 = zext i1 %259 to i254
  %276 = shl i254 %275, 148
  %277 = and i254 %274, -356811923176489970264571492362373784095686657
  %.partset83 = or i254 %277, %276
  store i254 %.partset83, i254* %dst_2, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.3:                             ; preds = %dst.addr.927.exit
  %278 = bitcast i254* %dst_3 to i256*
  %279 = load i256, i256* %278
  %280 = trunc i256 %279 to i254
  %281 = zext i1 %259 to i254
  %282 = shl i254 %281, 148
  %283 = and i254 %280, -356811923176489970264571492362373784095686657
  %.partset10 = or i254 %283, %282
  store i254 %.partset10, i254* %dst_3, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.exit:                               ; preds = %dst.addr.1029.case.3, %dst.addr.1029.case.2, %dst.addr.1029.case.1, %dst.addr.1029.case.0, %dst.addr.927.exit
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 11
  %284 = load i8, i8* %src.addr.1130, align 1
  switch i64 %for.loop.idx103, label %dst.addr.1131.exit [
    i64 0, label %dst.addr.1131.case.0
    i64 1, label %dst.addr.1131.case.1
    i64 2, label %dst.addr.1131.case.2
    i64 3, label %dst.addr.1131.case.3
  ]

dst.addr.1131.case.0:                             ; preds = %dst.addr.1029.exit
  %285 = bitcast i254* %dst_0 to i256*
  %286 = load i256, i256* %285
  %287 = trunc i256 %286 to i254
  %288 = zext i8 %284 to i254
  %289 = shl i254 %288, 149
  %290 = and i254 %287, -181974080820009884834931461104810629888800194561
  %.partset176 = or i254 %290, %289
  store i254 %.partset176, i254* %dst_0, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %291 = bitcast i254* %dst_1 to i256*
  %292 = load i256, i256* %291
  %293 = trunc i256 %292 to i254
  %294 = zext i8 %284 to i254
  %295 = shl i254 %294, 149
  %296 = and i254 %293, -181974080820009884834931461104810629888800194561
  %.partset105 = or i254 %296, %295
  store i254 %.partset105, i254* %dst_1, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.2:                             ; preds = %dst.addr.1029.exit
  %297 = bitcast i254* %dst_2 to i256*
  %298 = load i256, i256* %297
  %299 = trunc i256 %298 to i254
  %300 = zext i8 %284 to i254
  %301 = shl i254 %300, 149
  %302 = and i254 %299, -181974080820009884834931461104810629888800194561
  %.partset82 = or i254 %302, %301
  store i254 %.partset82, i254* %dst_2, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.3:                             ; preds = %dst.addr.1029.exit
  %303 = bitcast i254* %dst_3 to i256*
  %304 = load i256, i256* %303
  %305 = trunc i256 %304 to i254
  %306 = zext i8 %284 to i254
  %307 = shl i254 %306, 149
  %308 = and i254 %305, -181974080820009884834931461104810629888800194561
  %.partset11 = or i254 %308, %307
  store i254 %.partset11, i254* %dst_3, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.exit:                               ; preds = %dst.addr.1131.case.3, %dst.addr.1131.case.2, %dst.addr.1131.case.1, %dst.addr.1131.case.0, %dst.addr.1029.exit
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 12
  %309 = load i32, i32* %src.addr.1232, align 4
  switch i64 %for.loop.idx103, label %dst.addr.1233.exit [
    i64 0, label %dst.addr.1233.case.0
    i64 1, label %dst.addr.1233.case.1
    i64 2, label %dst.addr.1233.case.2
    i64 3, label %dst.addr.1233.case.3
  ]

dst.addr.1233.case.0:                             ; preds = %dst.addr.1131.exit
  %310 = bitcast i254* %dst_0 to i256*
  %311 = load i256, i256* %310
  %312 = trunc i256 %311 to i254
  %313 = zext i32 %309 to i254
  %314 = shl i254 %313, 157
  %315 = and i254 %312, -784637716740647390813110813125497697923259053101012746241
  %.partset175 = or i254 %315, %314
  store i254 %.partset175, i254* %dst_0, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %316 = bitcast i254* %dst_1 to i256*
  %317 = load i256, i256* %316
  %318 = trunc i256 %317 to i254
  %319 = zext i32 %309 to i254
  %320 = shl i254 %319, 157
  %321 = and i254 %318, -784637716740647390813110813125497697923259053101012746241
  %.partset106 = or i254 %321, %320
  store i254 %.partset106, i254* %dst_1, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.2:                             ; preds = %dst.addr.1131.exit
  %322 = bitcast i254* %dst_2 to i256*
  %323 = load i256, i256* %322
  %324 = trunc i256 %323 to i254
  %325 = zext i32 %309 to i254
  %326 = shl i254 %325, 157
  %327 = and i254 %324, -784637716740647390813110813125497697923259053101012746241
  %.partset81 = or i254 %327, %326
  store i254 %.partset81, i254* %dst_2, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.3:                             ; preds = %dst.addr.1131.exit
  %328 = bitcast i254* %dst_3 to i256*
  %329 = load i256, i256* %328
  %330 = trunc i256 %329 to i254
  %331 = zext i32 %309 to i254
  %332 = shl i254 %331, 157
  %333 = and i254 %330, -784637716740647390813110813125497697923259053101012746241
  %.partset12 = or i254 %333, %332
  store i254 %.partset12, i254* %dst_3, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.exit:                               ; preds = %dst.addr.1233.case.3, %dst.addr.1233.case.2, %dst.addr.1233.case.1, %dst.addr.1233.case.0, %dst.addr.1131.exit
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 13
  %334 = load i32, i32* %src.addr.1334, align 4
  switch i64 %for.loop.idx103, label %dst.addr.1335.exit [
    i64 0, label %dst.addr.1335.case.0
    i64 1, label %dst.addr.1335.case.1
    i64 2, label %dst.addr.1335.case.2
    i64 3, label %dst.addr.1335.case.3
  ]

dst.addr.1335.case.0:                             ; preds = %dst.addr.1233.exit
  %335 = bitcast i254* %dst_0 to i256*
  %336 = load i256, i256* %335
  %337 = trunc i256 %336 to i254
  %338 = zext i32 %334 to i254
  %339 = shl i254 %338, 189
  %340 = and i254 %337, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset174 = or i254 %340, %339
  store i254 %.partset174, i254* %dst_0, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %341 = bitcast i254* %dst_1 to i256*
  %342 = load i256, i256* %341
  %343 = trunc i256 %342 to i254
  %344 = zext i32 %334 to i254
  %345 = shl i254 %344, 189
  %346 = and i254 %343, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset107 = or i254 %346, %345
  store i254 %.partset107, i254* %dst_1, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.2:                             ; preds = %dst.addr.1233.exit
  %347 = bitcast i254* %dst_2 to i256*
  %348 = load i256, i256* %347
  %349 = trunc i256 %348 to i254
  %350 = zext i32 %334 to i254
  %351 = shl i254 %350, 189
  %352 = and i254 %349, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset80 = or i254 %352, %351
  store i254 %.partset80, i254* %dst_2, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.3:                             ; preds = %dst.addr.1233.exit
  %353 = bitcast i254* %dst_3 to i256*
  %354 = load i256, i256* %353
  %355 = trunc i256 %354 to i254
  %356 = zext i32 %334 to i254
  %357 = shl i254 %356, 189
  %358 = and i254 %355, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset13 = or i254 %358, %357
  store i254 %.partset13, i254* %dst_3, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.exit:                               ; preds = %dst.addr.1335.case.3, %dst.addr.1335.case.2, %dst.addr.1335.case.1, %dst.addr.1335.case.0, %dst.addr.1233.exit
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 14
  %359 = bitcast i1* %src.addr.1436 to i8*
  %360 = load i8, i8* %359
  %361 = trunc i8 %360 to i1
  switch i64 %for.loop.idx103, label %dst.addr.1437.exit [
    i64 0, label %dst.addr.1437.case.0
    i64 1, label %dst.addr.1437.case.1
    i64 2, label %dst.addr.1437.case.2
    i64 3, label %dst.addr.1437.case.3
  ]

dst.addr.1437.case.0:                             ; preds = %dst.addr.1335.exit
  %362 = bitcast i254* %dst_0 to i256*
  %363 = load i256, i256* %362
  %364 = trunc i256 %363 to i254
  %365 = zext i1 %361 to i254
  %366 = shl i254 %365, 221
  %367 = and i254 %364, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset173 = or i254 %367, %366
  store i254 %.partset173, i254* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %368 = bitcast i254* %dst_1 to i256*
  %369 = load i256, i256* %368
  %370 = trunc i256 %369 to i254
  %371 = zext i1 %361 to i254
  %372 = shl i254 %371, 221
  %373 = and i254 %370, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset108 = or i254 %373, %372
  store i254 %.partset108, i254* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.2:                             ; preds = %dst.addr.1335.exit
  %374 = bitcast i254* %dst_2 to i256*
  %375 = load i256, i256* %374
  %376 = trunc i256 %375 to i254
  %377 = zext i1 %361 to i254
  %378 = shl i254 %377, 221
  %379 = and i254 %376, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset79 = or i254 %379, %378
  store i254 %.partset79, i254* %dst_2, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.3:                             ; preds = %dst.addr.1335.exit
  %380 = bitcast i254* %dst_3 to i256*
  %381 = load i256, i256* %380
  %382 = trunc i256 %381 to i254
  %383 = zext i1 %361 to i254
  %384 = shl i254 %383, 221
  %385 = and i254 %382, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset14 = or i254 %385, %384
  store i254 %.partset14, i254* %dst_3, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.exit:                               ; preds = %dst.addr.1437.case.3, %dst.addr.1437.case.2, %dst.addr.1437.case.1, %dst.addr.1437.case.0, %dst.addr.1335.exit
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 15
  %386 = bitcast i1* %src.addr.1538 to i8*
  %387 = load i8, i8* %386
  %388 = trunc i8 %387 to i1
  switch i64 %for.loop.idx103, label %dst.addr.1539.exit [
    i64 0, label %dst.addr.1539.case.0
    i64 1, label %dst.addr.1539.case.1
    i64 2, label %dst.addr.1539.case.2
    i64 3, label %dst.addr.1539.case.3
  ]

dst.addr.1539.case.0:                             ; preds = %dst.addr.1437.exit
  %389 = bitcast i254* %dst_0 to i256*
  %390 = load i256, i256* %389
  %391 = trunc i256 %390 to i254
  %392 = zext i1 %388 to i254
  %393 = shl i254 %392, 222
  %394 = and i254 %391, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset172 = or i254 %394, %393
  store i254 %.partset172, i254* %dst_0, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %395 = bitcast i254* %dst_1 to i256*
  %396 = load i256, i256* %395
  %397 = trunc i256 %396 to i254
  %398 = zext i1 %388 to i254
  %399 = shl i254 %398, 222
  %400 = and i254 %397, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset109 = or i254 %400, %399
  store i254 %.partset109, i254* %dst_1, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.2:                             ; preds = %dst.addr.1437.exit
  %401 = bitcast i254* %dst_2 to i256*
  %402 = load i256, i256* %401
  %403 = trunc i256 %402 to i254
  %404 = zext i1 %388 to i254
  %405 = shl i254 %404, 222
  %406 = and i254 %403, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset78 = or i254 %406, %405
  store i254 %.partset78, i254* %dst_2, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.3:                             ; preds = %dst.addr.1437.exit
  %407 = bitcast i254* %dst_3 to i256*
  %408 = load i256, i256* %407
  %409 = trunc i256 %408 to i254
  %410 = zext i1 %388 to i254
  %411 = shl i254 %410, 222
  %412 = and i254 %409, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset15 = or i254 %412, %411
  store i254 %.partset15, i254* %dst_3, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.exit:                               ; preds = %dst.addr.1539.case.3, %dst.addr.1539.case.2, %dst.addr.1539.case.1, %dst.addr.1539.case.0, %dst.addr.1437.exit
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 16
  %413 = bitcast i1* %src.addr.1640 to i8*
  %414 = load i8, i8* %413
  %415 = trunc i8 %414 to i1
  switch i64 %for.loop.idx103, label %dst.addr.1641.exit [
    i64 0, label %dst.addr.1641.case.0
    i64 1, label %dst.addr.1641.case.1
    i64 2, label %dst.addr.1641.case.2
    i64 3, label %dst.addr.1641.case.3
  ]

dst.addr.1641.case.0:                             ; preds = %dst.addr.1539.exit
  %416 = bitcast i254* %dst_0 to i256*
  %417 = load i256, i256* %416
  %418 = trunc i256 %417 to i254
  %419 = zext i1 %415 to i254
  %420 = shl i254 %419, 223
  %421 = and i254 %418, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset171 = or i254 %421, %420
  store i254 %.partset171, i254* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %422 = bitcast i254* %dst_1 to i256*
  %423 = load i256, i256* %422
  %424 = trunc i256 %423 to i254
  %425 = zext i1 %415 to i254
  %426 = shl i254 %425, 223
  %427 = and i254 %424, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset110 = or i254 %427, %426
  store i254 %.partset110, i254* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.2:                             ; preds = %dst.addr.1539.exit
  %428 = bitcast i254* %dst_2 to i256*
  %429 = load i256, i256* %428
  %430 = trunc i256 %429 to i254
  %431 = zext i1 %415 to i254
  %432 = shl i254 %431, 223
  %433 = and i254 %430, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset77 = or i254 %433, %432
  store i254 %.partset77, i254* %dst_2, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.3:                             ; preds = %dst.addr.1539.exit
  %434 = bitcast i254* %dst_3 to i256*
  %435 = load i256, i256* %434
  %436 = trunc i256 %435 to i254
  %437 = zext i1 %415 to i254
  %438 = shl i254 %437, 223
  %439 = and i254 %436, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset16 = or i254 %439, %438
  store i254 %.partset16, i254* %dst_3, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.exit:                               ; preds = %dst.addr.1641.case.3, %dst.addr.1641.case.2, %dst.addr.1641.case.1, %dst.addr.1641.case.0, %dst.addr.1539.exit
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 17
  %440 = bitcast i1* %src.addr.1742 to i8*
  %441 = load i8, i8* %440
  %442 = trunc i8 %441 to i1
  switch i64 %for.loop.idx103, label %dst.addr.1743.exit [
    i64 0, label %dst.addr.1743.case.0
    i64 1, label %dst.addr.1743.case.1
    i64 2, label %dst.addr.1743.case.2
    i64 3, label %dst.addr.1743.case.3
  ]

dst.addr.1743.case.0:                             ; preds = %dst.addr.1641.exit
  %443 = bitcast i254* %dst_0 to i256*
  %444 = load i256, i256* %443
  %445 = trunc i256 %444 to i254
  %446 = zext i1 %442 to i254
  %447 = shl i254 %446, 224
  %448 = and i254 %445, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset170 = or i254 %448, %447
  store i254 %.partset170, i254* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %449 = bitcast i254* %dst_1 to i256*
  %450 = load i256, i256* %449
  %451 = trunc i256 %450 to i254
  %452 = zext i1 %442 to i254
  %453 = shl i254 %452, 224
  %454 = and i254 %451, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset111 = or i254 %454, %453
  store i254 %.partset111, i254* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.2:                             ; preds = %dst.addr.1641.exit
  %455 = bitcast i254* %dst_2 to i256*
  %456 = load i256, i256* %455
  %457 = trunc i256 %456 to i254
  %458 = zext i1 %442 to i254
  %459 = shl i254 %458, 224
  %460 = and i254 %457, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset76 = or i254 %460, %459
  store i254 %.partset76, i254* %dst_2, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.3:                             ; preds = %dst.addr.1641.exit
  %461 = bitcast i254* %dst_3 to i256*
  %462 = load i256, i256* %461
  %463 = trunc i256 %462 to i254
  %464 = zext i1 %442 to i254
  %465 = shl i254 %464, 224
  %466 = and i254 %463, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset17 = or i254 %466, %465
  store i254 %.partset17, i254* %dst_3, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.exit:                               ; preds = %dst.addr.1743.case.3, %dst.addr.1743.case.2, %dst.addr.1743.case.1, %dst.addr.1743.case.0, %dst.addr.1641.exit
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 18
  %467 = bitcast i1* %src.addr.1844 to i8*
  %468 = load i8, i8* %467
  %469 = trunc i8 %468 to i1
  switch i64 %for.loop.idx103, label %dst.addr.1845.exit [
    i64 0, label %dst.addr.1845.case.0
    i64 1, label %dst.addr.1845.case.1
    i64 2, label %dst.addr.1845.case.2
    i64 3, label %dst.addr.1845.case.3
  ]

dst.addr.1845.case.0:                             ; preds = %dst.addr.1743.exit
  %470 = bitcast i254* %dst_0 to i256*
  %471 = load i256, i256* %470
  %472 = trunc i256 %471 to i254
  %473 = zext i1 %469 to i254
  %474 = shl i254 %473, 225
  %475 = and i254 %472, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset169 = or i254 %475, %474
  store i254 %.partset169, i254* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %476 = bitcast i254* %dst_1 to i256*
  %477 = load i256, i256* %476
  %478 = trunc i256 %477 to i254
  %479 = zext i1 %469 to i254
  %480 = shl i254 %479, 225
  %481 = and i254 %478, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset112 = or i254 %481, %480
  store i254 %.partset112, i254* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.2:                             ; preds = %dst.addr.1743.exit
  %482 = bitcast i254* %dst_2 to i256*
  %483 = load i256, i256* %482
  %484 = trunc i256 %483 to i254
  %485 = zext i1 %469 to i254
  %486 = shl i254 %485, 225
  %487 = and i254 %484, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset75 = or i254 %487, %486
  store i254 %.partset75, i254* %dst_2, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.3:                             ; preds = %dst.addr.1743.exit
  %488 = bitcast i254* %dst_3 to i256*
  %489 = load i256, i256* %488
  %490 = trunc i256 %489 to i254
  %491 = zext i1 %469 to i254
  %492 = shl i254 %491, 225
  %493 = and i254 %490, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset18 = or i254 %493, %492
  store i254 %.partset18, i254* %dst_3, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.exit:                               ; preds = %dst.addr.1845.case.3, %dst.addr.1845.case.2, %dst.addr.1845.case.1, %dst.addr.1845.case.0, %dst.addr.1743.exit
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 19
  %494 = bitcast i1* %src.addr.1946 to i8*
  %495 = load i8, i8* %494
  %496 = trunc i8 %495 to i1
  switch i64 %for.loop.idx103, label %dst.addr.1947.exit [
    i64 0, label %dst.addr.1947.case.0
    i64 1, label %dst.addr.1947.case.1
    i64 2, label %dst.addr.1947.case.2
    i64 3, label %dst.addr.1947.case.3
  ]

dst.addr.1947.case.0:                             ; preds = %dst.addr.1845.exit
  %497 = bitcast i254* %dst_0 to i256*
  %498 = load i256, i256* %497
  %499 = trunc i256 %498 to i254
  %500 = zext i1 %496 to i254
  %501 = shl i254 %500, 226
  %502 = and i254 %499, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset168 = or i254 %502, %501
  store i254 %.partset168, i254* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %503 = bitcast i254* %dst_1 to i256*
  %504 = load i256, i256* %503
  %505 = trunc i256 %504 to i254
  %506 = zext i1 %496 to i254
  %507 = shl i254 %506, 226
  %508 = and i254 %505, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset113 = or i254 %508, %507
  store i254 %.partset113, i254* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.2:                             ; preds = %dst.addr.1845.exit
  %509 = bitcast i254* %dst_2 to i256*
  %510 = load i256, i256* %509
  %511 = trunc i256 %510 to i254
  %512 = zext i1 %496 to i254
  %513 = shl i254 %512, 226
  %514 = and i254 %511, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset74 = or i254 %514, %513
  store i254 %.partset74, i254* %dst_2, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.3:                             ; preds = %dst.addr.1845.exit
  %515 = bitcast i254* %dst_3 to i256*
  %516 = load i256, i256* %515
  %517 = trunc i256 %516 to i254
  %518 = zext i1 %496 to i254
  %519 = shl i254 %518, 226
  %520 = and i254 %517, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset19 = or i254 %520, %519
  store i254 %.partset19, i254* %dst_3, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.exit:                               ; preds = %dst.addr.1947.case.3, %dst.addr.1947.case.2, %dst.addr.1947.case.1, %dst.addr.1947.case.0, %dst.addr.1845.exit
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 20
  %521 = bitcast i1* %src.addr.2048 to i8*
  %522 = load i8, i8* %521
  %523 = trunc i8 %522 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2049.exit [
    i64 0, label %dst.addr.2049.case.0
    i64 1, label %dst.addr.2049.case.1
    i64 2, label %dst.addr.2049.case.2
    i64 3, label %dst.addr.2049.case.3
  ]

dst.addr.2049.case.0:                             ; preds = %dst.addr.1947.exit
  %524 = bitcast i254* %dst_0 to i256*
  %525 = load i256, i256* %524
  %526 = trunc i256 %525 to i254
  %527 = zext i1 %523 to i254
  %528 = shl i254 %527, 227
  %529 = and i254 %526, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset167 = or i254 %529, %528
  store i254 %.partset167, i254* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %530 = bitcast i254* %dst_1 to i256*
  %531 = load i256, i256* %530
  %532 = trunc i256 %531 to i254
  %533 = zext i1 %523 to i254
  %534 = shl i254 %533, 227
  %535 = and i254 %532, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset114 = or i254 %535, %534
  store i254 %.partset114, i254* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.2:                             ; preds = %dst.addr.1947.exit
  %536 = bitcast i254* %dst_2 to i256*
  %537 = load i256, i256* %536
  %538 = trunc i256 %537 to i254
  %539 = zext i1 %523 to i254
  %540 = shl i254 %539, 227
  %541 = and i254 %538, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset73 = or i254 %541, %540
  store i254 %.partset73, i254* %dst_2, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.3:                             ; preds = %dst.addr.1947.exit
  %542 = bitcast i254* %dst_3 to i256*
  %543 = load i256, i256* %542
  %544 = trunc i256 %543 to i254
  %545 = zext i1 %523 to i254
  %546 = shl i254 %545, 227
  %547 = and i254 %544, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset20 = or i254 %547, %546
  store i254 %.partset20, i254* %dst_3, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.exit:                               ; preds = %dst.addr.2049.case.3, %dst.addr.2049.case.2, %dst.addr.2049.case.1, %dst.addr.2049.case.0, %dst.addr.1947.exit
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 21
  %548 = bitcast i1* %src.addr.2150 to i8*
  %549 = load i8, i8* %548
  %550 = trunc i8 %549 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2151.exit [
    i64 0, label %dst.addr.2151.case.0
    i64 1, label %dst.addr.2151.case.1
    i64 2, label %dst.addr.2151.case.2
    i64 3, label %dst.addr.2151.case.3
  ]

dst.addr.2151.case.0:                             ; preds = %dst.addr.2049.exit
  %551 = bitcast i254* %dst_0 to i256*
  %552 = load i256, i256* %551
  %553 = trunc i256 %552 to i254
  %554 = zext i1 %550 to i254
  %555 = shl i254 %554, 228
  %556 = and i254 %553, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset166 = or i254 %556, %555
  store i254 %.partset166, i254* %dst_0, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.1:                             ; preds = %dst.addr.2049.exit
  %557 = bitcast i254* %dst_1 to i256*
  %558 = load i256, i256* %557
  %559 = trunc i256 %558 to i254
  %560 = zext i1 %550 to i254
  %561 = shl i254 %560, 228
  %562 = and i254 %559, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset115 = or i254 %562, %561
  store i254 %.partset115, i254* %dst_1, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.2:                             ; preds = %dst.addr.2049.exit
  %563 = bitcast i254* %dst_2 to i256*
  %564 = load i256, i256* %563
  %565 = trunc i256 %564 to i254
  %566 = zext i1 %550 to i254
  %567 = shl i254 %566, 228
  %568 = and i254 %565, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset72 = or i254 %568, %567
  store i254 %.partset72, i254* %dst_2, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.3:                             ; preds = %dst.addr.2049.exit
  %569 = bitcast i254* %dst_3 to i256*
  %570 = load i256, i256* %569
  %571 = trunc i256 %570 to i254
  %572 = zext i1 %550 to i254
  %573 = shl i254 %572, 228
  %574 = and i254 %571, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset21 = or i254 %574, %573
  store i254 %.partset21, i254* %dst_3, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.exit:                               ; preds = %dst.addr.2151.case.3, %dst.addr.2151.case.2, %dst.addr.2151.case.1, %dst.addr.2151.case.0, %dst.addr.2049.exit
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 22
  %575 = bitcast i1* %src.addr.2252 to i8*
  %576 = load i8, i8* %575
  %577 = trunc i8 %576 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2253.exit [
    i64 0, label %dst.addr.2253.case.0
    i64 1, label %dst.addr.2253.case.1
    i64 2, label %dst.addr.2253.case.2
    i64 3, label %dst.addr.2253.case.3
  ]

dst.addr.2253.case.0:                             ; preds = %dst.addr.2151.exit
  %578 = bitcast i254* %dst_0 to i256*
  %579 = load i256, i256* %578
  %580 = trunc i256 %579 to i254
  %581 = zext i1 %577 to i254
  %582 = shl i254 %581, 229
  %583 = and i254 %580, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset165 = or i254 %583, %582
  store i254 %.partset165, i254* %dst_0, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.1:                             ; preds = %dst.addr.2151.exit
  %584 = bitcast i254* %dst_1 to i256*
  %585 = load i256, i256* %584
  %586 = trunc i256 %585 to i254
  %587 = zext i1 %577 to i254
  %588 = shl i254 %587, 229
  %589 = and i254 %586, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset116 = or i254 %589, %588
  store i254 %.partset116, i254* %dst_1, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.2:                             ; preds = %dst.addr.2151.exit
  %590 = bitcast i254* %dst_2 to i256*
  %591 = load i256, i256* %590
  %592 = trunc i256 %591 to i254
  %593 = zext i1 %577 to i254
  %594 = shl i254 %593, 229
  %595 = and i254 %592, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset71 = or i254 %595, %594
  store i254 %.partset71, i254* %dst_2, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.3:                             ; preds = %dst.addr.2151.exit
  %596 = bitcast i254* %dst_3 to i256*
  %597 = load i256, i256* %596
  %598 = trunc i256 %597 to i254
  %599 = zext i1 %577 to i254
  %600 = shl i254 %599, 229
  %601 = and i254 %598, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset22 = or i254 %601, %600
  store i254 %.partset22, i254* %dst_3, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.exit:                               ; preds = %dst.addr.2253.case.3, %dst.addr.2253.case.2, %dst.addr.2253.case.1, %dst.addr.2253.case.0, %dst.addr.2151.exit
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 23
  %602 = bitcast i1* %src.addr.2354 to i8*
  %603 = load i8, i8* %602
  %604 = trunc i8 %603 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2355.exit [
    i64 0, label %dst.addr.2355.case.0
    i64 1, label %dst.addr.2355.case.1
    i64 2, label %dst.addr.2355.case.2
    i64 3, label %dst.addr.2355.case.3
  ]

dst.addr.2355.case.0:                             ; preds = %dst.addr.2253.exit
  %605 = bitcast i254* %dst_0 to i256*
  %606 = load i256, i256* %605
  %607 = trunc i256 %606 to i254
  %608 = zext i1 %604 to i254
  %609 = shl i254 %608, 230
  %610 = and i254 %607, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset164 = or i254 %610, %609
  store i254 %.partset164, i254* %dst_0, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.1:                             ; preds = %dst.addr.2253.exit
  %611 = bitcast i254* %dst_1 to i256*
  %612 = load i256, i256* %611
  %613 = trunc i256 %612 to i254
  %614 = zext i1 %604 to i254
  %615 = shl i254 %614, 230
  %616 = and i254 %613, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset117 = or i254 %616, %615
  store i254 %.partset117, i254* %dst_1, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.2:                             ; preds = %dst.addr.2253.exit
  %617 = bitcast i254* %dst_2 to i256*
  %618 = load i256, i256* %617
  %619 = trunc i256 %618 to i254
  %620 = zext i1 %604 to i254
  %621 = shl i254 %620, 230
  %622 = and i254 %619, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset70 = or i254 %622, %621
  store i254 %.partset70, i254* %dst_2, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.3:                             ; preds = %dst.addr.2253.exit
  %623 = bitcast i254* %dst_3 to i256*
  %624 = load i256, i256* %623
  %625 = trunc i256 %624 to i254
  %626 = zext i1 %604 to i254
  %627 = shl i254 %626, 230
  %628 = and i254 %625, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset23 = or i254 %628, %627
  store i254 %.partset23, i254* %dst_3, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.exit:                               ; preds = %dst.addr.2355.case.3, %dst.addr.2355.case.2, %dst.addr.2355.case.1, %dst.addr.2355.case.0, %dst.addr.2253.exit
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 24
  %629 = bitcast i1* %src.addr.2456 to i8*
  %630 = load i8, i8* %629
  %631 = trunc i8 %630 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2457.exit [
    i64 0, label %dst.addr.2457.case.0
    i64 1, label %dst.addr.2457.case.1
    i64 2, label %dst.addr.2457.case.2
    i64 3, label %dst.addr.2457.case.3
  ]

dst.addr.2457.case.0:                             ; preds = %dst.addr.2355.exit
  %632 = bitcast i254* %dst_0 to i256*
  %633 = load i256, i256* %632
  %634 = trunc i256 %633 to i254
  %635 = zext i1 %631 to i254
  %636 = shl i254 %635, 231
  %637 = and i254 %634, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset163 = or i254 %637, %636
  store i254 %.partset163, i254* %dst_0, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.1:                             ; preds = %dst.addr.2355.exit
  %638 = bitcast i254* %dst_1 to i256*
  %639 = load i256, i256* %638
  %640 = trunc i256 %639 to i254
  %641 = zext i1 %631 to i254
  %642 = shl i254 %641, 231
  %643 = and i254 %640, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset118 = or i254 %643, %642
  store i254 %.partset118, i254* %dst_1, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.2:                             ; preds = %dst.addr.2355.exit
  %644 = bitcast i254* %dst_2 to i256*
  %645 = load i256, i256* %644
  %646 = trunc i256 %645 to i254
  %647 = zext i1 %631 to i254
  %648 = shl i254 %647, 231
  %649 = and i254 %646, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset69 = or i254 %649, %648
  store i254 %.partset69, i254* %dst_2, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.3:                             ; preds = %dst.addr.2355.exit
  %650 = bitcast i254* %dst_3 to i256*
  %651 = load i256, i256* %650
  %652 = trunc i256 %651 to i254
  %653 = zext i1 %631 to i254
  %654 = shl i254 %653, 231
  %655 = and i254 %652, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset24 = or i254 %655, %654
  store i254 %.partset24, i254* %dst_3, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.exit:                               ; preds = %dst.addr.2457.case.3, %dst.addr.2457.case.2, %dst.addr.2457.case.1, %dst.addr.2457.case.0, %dst.addr.2355.exit
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 25
  %656 = bitcast i1* %src.addr.2558 to i8*
  %657 = load i8, i8* %656
  %658 = trunc i8 %657 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2559.exit [
    i64 0, label %dst.addr.2559.case.0
    i64 1, label %dst.addr.2559.case.1
    i64 2, label %dst.addr.2559.case.2
    i64 3, label %dst.addr.2559.case.3
  ]

dst.addr.2559.case.0:                             ; preds = %dst.addr.2457.exit
  %659 = bitcast i254* %dst_0 to i256*
  %660 = load i256, i256* %659
  %661 = trunc i256 %660 to i254
  %662 = zext i1 %658 to i254
  %663 = shl i254 %662, 232
  %664 = and i254 %661, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset162 = or i254 %664, %663
  store i254 %.partset162, i254* %dst_0, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.1:                             ; preds = %dst.addr.2457.exit
  %665 = bitcast i254* %dst_1 to i256*
  %666 = load i256, i256* %665
  %667 = trunc i256 %666 to i254
  %668 = zext i1 %658 to i254
  %669 = shl i254 %668, 232
  %670 = and i254 %667, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset119 = or i254 %670, %669
  store i254 %.partset119, i254* %dst_1, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.2:                             ; preds = %dst.addr.2457.exit
  %671 = bitcast i254* %dst_2 to i256*
  %672 = load i256, i256* %671
  %673 = trunc i256 %672 to i254
  %674 = zext i1 %658 to i254
  %675 = shl i254 %674, 232
  %676 = and i254 %673, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset68 = or i254 %676, %675
  store i254 %.partset68, i254* %dst_2, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.3:                             ; preds = %dst.addr.2457.exit
  %677 = bitcast i254* %dst_3 to i256*
  %678 = load i256, i256* %677
  %679 = trunc i256 %678 to i254
  %680 = zext i1 %658 to i254
  %681 = shl i254 %680, 232
  %682 = and i254 %679, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset25 = or i254 %682, %681
  store i254 %.partset25, i254* %dst_3, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.exit:                               ; preds = %dst.addr.2559.case.3, %dst.addr.2559.case.2, %dst.addr.2559.case.1, %dst.addr.2559.case.0, %dst.addr.2457.exit
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 26
  %683 = bitcast i1* %src.addr.2660 to i8*
  %684 = load i8, i8* %683
  %685 = trunc i8 %684 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2661.exit [
    i64 0, label %dst.addr.2661.case.0
    i64 1, label %dst.addr.2661.case.1
    i64 2, label %dst.addr.2661.case.2
    i64 3, label %dst.addr.2661.case.3
  ]

dst.addr.2661.case.0:                             ; preds = %dst.addr.2559.exit
  %686 = bitcast i254* %dst_0 to i256*
  %687 = load i256, i256* %686
  %688 = trunc i256 %687 to i254
  %689 = zext i1 %685 to i254
  %690 = shl i254 %689, 233
  %691 = and i254 %688, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset161 = or i254 %691, %690
  store i254 %.partset161, i254* %dst_0, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.1:                             ; preds = %dst.addr.2559.exit
  %692 = bitcast i254* %dst_1 to i256*
  %693 = load i256, i256* %692
  %694 = trunc i256 %693 to i254
  %695 = zext i1 %685 to i254
  %696 = shl i254 %695, 233
  %697 = and i254 %694, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset120 = or i254 %697, %696
  store i254 %.partset120, i254* %dst_1, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.2:                             ; preds = %dst.addr.2559.exit
  %698 = bitcast i254* %dst_2 to i256*
  %699 = load i256, i256* %698
  %700 = trunc i256 %699 to i254
  %701 = zext i1 %685 to i254
  %702 = shl i254 %701, 233
  %703 = and i254 %700, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset67 = or i254 %703, %702
  store i254 %.partset67, i254* %dst_2, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.3:                             ; preds = %dst.addr.2559.exit
  %704 = bitcast i254* %dst_3 to i256*
  %705 = load i256, i256* %704
  %706 = trunc i256 %705 to i254
  %707 = zext i1 %685 to i254
  %708 = shl i254 %707, 233
  %709 = and i254 %706, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset26 = or i254 %709, %708
  store i254 %.partset26, i254* %dst_3, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.exit:                               ; preds = %dst.addr.2661.case.3, %dst.addr.2661.case.2, %dst.addr.2661.case.1, %dst.addr.2661.case.0, %dst.addr.2559.exit
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 27
  %710 = bitcast i1* %src.addr.2762 to i8*
  %711 = load i8, i8* %710
  %712 = trunc i8 %711 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2763.exit [
    i64 0, label %dst.addr.2763.case.0
    i64 1, label %dst.addr.2763.case.1
    i64 2, label %dst.addr.2763.case.2
    i64 3, label %dst.addr.2763.case.3
  ]

dst.addr.2763.case.0:                             ; preds = %dst.addr.2661.exit
  %713 = bitcast i254* %dst_0 to i256*
  %714 = load i256, i256* %713
  %715 = trunc i256 %714 to i254
  %716 = zext i1 %712 to i254
  %717 = shl i254 %716, 234
  %718 = and i254 %715, -27606985387162255149739023449108101809804435888681546220650096895197185
  %.partset160 = or i254 %718, %717
  store i254 %.partset160, i254* %dst_0, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.1:                             ; preds = %dst.addr.2661.exit
  %719 = bitcast i254* %dst_1 to i256*
  %720 = load i256, i256* %719
  %721 = trunc i256 %720 to i254
  %722 = zext i1 %712 to i254
  %723 = shl i254 %722, 234
  %724 = and i254 %721, -27606985387162255149739023449108101809804435888681546220650096895197185
  %.partset121 = or i254 %724, %723
  store i254 %.partset121, i254* %dst_1, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.2:                             ; preds = %dst.addr.2661.exit
  %725 = bitcast i254* %dst_2 to i256*
  %726 = load i256, i256* %725
  %727 = trunc i256 %726 to i254
  %728 = zext i1 %712 to i254
  %729 = shl i254 %728, 234
  %730 = and i254 %727, -27606985387162255149739023449108101809804435888681546220650096895197185
  %.partset66 = or i254 %730, %729
  store i254 %.partset66, i254* %dst_2, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.3:                             ; preds = %dst.addr.2661.exit
  %731 = bitcast i254* %dst_3 to i256*
  %732 = load i256, i256* %731
  %733 = trunc i256 %732 to i254
  %734 = zext i1 %712 to i254
  %735 = shl i254 %734, 234
  %736 = and i254 %733, -27606985387162255149739023449108101809804435888681546220650096895197185
  %.partset27 = or i254 %736, %735
  store i254 %.partset27, i254* %dst_3, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.exit:                               ; preds = %dst.addr.2763.case.3, %dst.addr.2763.case.2, %dst.addr.2763.case.1, %dst.addr.2763.case.0, %dst.addr.2661.exit
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 28
  %737 = bitcast i1* %src.addr.2864 to i8*
  %738 = load i8, i8* %737
  %739 = trunc i8 %738 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2865.exit [
    i64 0, label %dst.addr.2865.case.0
    i64 1, label %dst.addr.2865.case.1
    i64 2, label %dst.addr.2865.case.2
    i64 3, label %dst.addr.2865.case.3
  ]

dst.addr.2865.case.0:                             ; preds = %dst.addr.2763.exit
  %740 = bitcast i254* %dst_0 to i256*
  %741 = load i256, i256* %740
  %742 = trunc i256 %741 to i254
  %743 = zext i1 %739 to i254
  %744 = shl i254 %743, 235
  %745 = and i254 %742, -55213970774324510299478046898216203619608871777363092441300193790394369
  %.partset159 = or i254 %745, %744
  store i254 %.partset159, i254* %dst_0, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.1:                             ; preds = %dst.addr.2763.exit
  %746 = bitcast i254* %dst_1 to i256*
  %747 = load i256, i256* %746
  %748 = trunc i256 %747 to i254
  %749 = zext i1 %739 to i254
  %750 = shl i254 %749, 235
  %751 = and i254 %748, -55213970774324510299478046898216203619608871777363092441300193790394369
  %.partset122 = or i254 %751, %750
  store i254 %.partset122, i254* %dst_1, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.2:                             ; preds = %dst.addr.2763.exit
  %752 = bitcast i254* %dst_2 to i256*
  %753 = load i256, i256* %752
  %754 = trunc i256 %753 to i254
  %755 = zext i1 %739 to i254
  %756 = shl i254 %755, 235
  %757 = and i254 %754, -55213970774324510299478046898216203619608871777363092441300193790394369
  %.partset65 = or i254 %757, %756
  store i254 %.partset65, i254* %dst_2, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.3:                             ; preds = %dst.addr.2763.exit
  %758 = bitcast i254* %dst_3 to i256*
  %759 = load i256, i256* %758
  %760 = trunc i256 %759 to i254
  %761 = zext i1 %739 to i254
  %762 = shl i254 %761, 235
  %763 = and i254 %760, -55213970774324510299478046898216203619608871777363092441300193790394369
  %.partset28 = or i254 %763, %762
  store i254 %.partset28, i254* %dst_3, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.exit:                               ; preds = %dst.addr.2865.case.3, %dst.addr.2865.case.2, %dst.addr.2865.case.1, %dst.addr.2865.case.0, %dst.addr.2763.exit
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 29
  %764 = bitcast i1* %src.addr.2966 to i8*
  %765 = load i8, i8* %764
  %766 = trunc i8 %765 to i1
  switch i64 %for.loop.idx103, label %dst.addr.2967.exit [
    i64 0, label %dst.addr.2967.case.0
    i64 1, label %dst.addr.2967.case.1
    i64 2, label %dst.addr.2967.case.2
    i64 3, label %dst.addr.2967.case.3
  ]

dst.addr.2967.case.0:                             ; preds = %dst.addr.2865.exit
  %767 = bitcast i254* %dst_0 to i256*
  %768 = load i256, i256* %767
  %769 = trunc i256 %768 to i254
  %770 = zext i1 %766 to i254
  %771 = shl i254 %770, 236
  %772 = and i254 %769, -110427941548649020598956093796432407239217743554726184882600387580788737
  %.partset158 = or i254 %772, %771
  store i254 %.partset158, i254* %dst_0, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.1:                             ; preds = %dst.addr.2865.exit
  %773 = bitcast i254* %dst_1 to i256*
  %774 = load i256, i256* %773
  %775 = trunc i256 %774 to i254
  %776 = zext i1 %766 to i254
  %777 = shl i254 %776, 236
  %778 = and i254 %775, -110427941548649020598956093796432407239217743554726184882600387580788737
  %.partset123 = or i254 %778, %777
  store i254 %.partset123, i254* %dst_1, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.2:                             ; preds = %dst.addr.2865.exit
  %779 = bitcast i254* %dst_2 to i256*
  %780 = load i256, i256* %779
  %781 = trunc i256 %780 to i254
  %782 = zext i1 %766 to i254
  %783 = shl i254 %782, 236
  %784 = and i254 %781, -110427941548649020598956093796432407239217743554726184882600387580788737
  %.partset64 = or i254 %784, %783
  store i254 %.partset64, i254* %dst_2, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.3:                             ; preds = %dst.addr.2865.exit
  %785 = bitcast i254* %dst_3 to i256*
  %786 = load i256, i256* %785
  %787 = trunc i256 %786 to i254
  %788 = zext i1 %766 to i254
  %789 = shl i254 %788, 236
  %790 = and i254 %787, -110427941548649020598956093796432407239217743554726184882600387580788737
  %.partset29 = or i254 %790, %789
  store i254 %.partset29, i254* %dst_3, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.exit:                               ; preds = %dst.addr.2967.case.3, %dst.addr.2967.case.2, %dst.addr.2967.case.1, %dst.addr.2967.case.0, %dst.addr.2865.exit
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 30
  %791 = bitcast i1* %src.addr.3068 to i8*
  %792 = load i8, i8* %791
  %793 = trunc i8 %792 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3069.exit [
    i64 0, label %dst.addr.3069.case.0
    i64 1, label %dst.addr.3069.case.1
    i64 2, label %dst.addr.3069.case.2
    i64 3, label %dst.addr.3069.case.3
  ]

dst.addr.3069.case.0:                             ; preds = %dst.addr.2967.exit
  %794 = bitcast i254* %dst_0 to i256*
  %795 = load i256, i256* %794
  %796 = trunc i256 %795 to i254
  %797 = zext i1 %793 to i254
  %798 = shl i254 %797, 237
  %799 = and i254 %796, -220855883097298041197912187592864814478435487109452369765200775161577473
  %.partset157 = or i254 %799, %798
  store i254 %.partset157, i254* %dst_0, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.1:                             ; preds = %dst.addr.2967.exit
  %800 = bitcast i254* %dst_1 to i256*
  %801 = load i256, i256* %800
  %802 = trunc i256 %801 to i254
  %803 = zext i1 %793 to i254
  %804 = shl i254 %803, 237
  %805 = and i254 %802, -220855883097298041197912187592864814478435487109452369765200775161577473
  %.partset124 = or i254 %805, %804
  store i254 %.partset124, i254* %dst_1, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.2:                             ; preds = %dst.addr.2967.exit
  %806 = bitcast i254* %dst_2 to i256*
  %807 = load i256, i256* %806
  %808 = trunc i256 %807 to i254
  %809 = zext i1 %793 to i254
  %810 = shl i254 %809, 237
  %811 = and i254 %808, -220855883097298041197912187592864814478435487109452369765200775161577473
  %.partset63 = or i254 %811, %810
  store i254 %.partset63, i254* %dst_2, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.3:                             ; preds = %dst.addr.2967.exit
  %812 = bitcast i254* %dst_3 to i256*
  %813 = load i256, i256* %812
  %814 = trunc i256 %813 to i254
  %815 = zext i1 %793 to i254
  %816 = shl i254 %815, 237
  %817 = and i254 %814, -220855883097298041197912187592864814478435487109452369765200775161577473
  %.partset30 = or i254 %817, %816
  store i254 %.partset30, i254* %dst_3, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.exit:                               ; preds = %dst.addr.3069.case.3, %dst.addr.3069.case.2, %dst.addr.3069.case.1, %dst.addr.3069.case.0, %dst.addr.2967.exit
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 31
  %818 = bitcast i1* %src.addr.3170 to i8*
  %819 = load i8, i8* %818
  %820 = trunc i8 %819 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3171.exit [
    i64 0, label %dst.addr.3171.case.0
    i64 1, label %dst.addr.3171.case.1
    i64 2, label %dst.addr.3171.case.2
    i64 3, label %dst.addr.3171.case.3
  ]

dst.addr.3171.case.0:                             ; preds = %dst.addr.3069.exit
  %821 = bitcast i254* %dst_0 to i256*
  %822 = load i256, i256* %821
  %823 = trunc i256 %822 to i254
  %824 = zext i1 %820 to i254
  %825 = shl i254 %824, 238
  %826 = and i254 %823, -441711766194596082395824375185729628956870974218904739530401550323154945
  %.partset156 = or i254 %826, %825
  store i254 %.partset156, i254* %dst_0, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.1:                             ; preds = %dst.addr.3069.exit
  %827 = bitcast i254* %dst_1 to i256*
  %828 = load i256, i256* %827
  %829 = trunc i256 %828 to i254
  %830 = zext i1 %820 to i254
  %831 = shl i254 %830, 238
  %832 = and i254 %829, -441711766194596082395824375185729628956870974218904739530401550323154945
  %.partset125 = or i254 %832, %831
  store i254 %.partset125, i254* %dst_1, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.2:                             ; preds = %dst.addr.3069.exit
  %833 = bitcast i254* %dst_2 to i256*
  %834 = load i256, i256* %833
  %835 = trunc i256 %834 to i254
  %836 = zext i1 %820 to i254
  %837 = shl i254 %836, 238
  %838 = and i254 %835, -441711766194596082395824375185729628956870974218904739530401550323154945
  %.partset62 = or i254 %838, %837
  store i254 %.partset62, i254* %dst_2, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.3:                             ; preds = %dst.addr.3069.exit
  %839 = bitcast i254* %dst_3 to i256*
  %840 = load i256, i256* %839
  %841 = trunc i256 %840 to i254
  %842 = zext i1 %820 to i254
  %843 = shl i254 %842, 238
  %844 = and i254 %841, -441711766194596082395824375185729628956870974218904739530401550323154945
  %.partset31 = or i254 %844, %843
  store i254 %.partset31, i254* %dst_3, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.exit:                               ; preds = %dst.addr.3171.case.3, %dst.addr.3171.case.2, %dst.addr.3171.case.1, %dst.addr.3171.case.0, %dst.addr.3069.exit
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 32
  %845 = bitcast i1* %src.addr.3272 to i8*
  %846 = load i8, i8* %845
  %847 = trunc i8 %846 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3273.exit [
    i64 0, label %dst.addr.3273.case.0
    i64 1, label %dst.addr.3273.case.1
    i64 2, label %dst.addr.3273.case.2
    i64 3, label %dst.addr.3273.case.3
  ]

dst.addr.3273.case.0:                             ; preds = %dst.addr.3171.exit
  %848 = bitcast i254* %dst_0 to i256*
  %849 = load i256, i256* %848
  %850 = trunc i256 %849 to i254
  %851 = zext i1 %847 to i254
  %852 = shl i254 %851, 239
  %853 = and i254 %850, -883423532389192164791648750371459257913741948437809479060803100646309889
  %.partset155 = or i254 %853, %852
  store i254 %.partset155, i254* %dst_0, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.1:                             ; preds = %dst.addr.3171.exit
  %854 = bitcast i254* %dst_1 to i256*
  %855 = load i256, i256* %854
  %856 = trunc i256 %855 to i254
  %857 = zext i1 %847 to i254
  %858 = shl i254 %857, 239
  %859 = and i254 %856, -883423532389192164791648750371459257913741948437809479060803100646309889
  %.partset126 = or i254 %859, %858
  store i254 %.partset126, i254* %dst_1, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.2:                             ; preds = %dst.addr.3171.exit
  %860 = bitcast i254* %dst_2 to i256*
  %861 = load i256, i256* %860
  %862 = trunc i256 %861 to i254
  %863 = zext i1 %847 to i254
  %864 = shl i254 %863, 239
  %865 = and i254 %862, -883423532389192164791648750371459257913741948437809479060803100646309889
  %.partset61 = or i254 %865, %864
  store i254 %.partset61, i254* %dst_2, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.3:                             ; preds = %dst.addr.3171.exit
  %866 = bitcast i254* %dst_3 to i256*
  %867 = load i256, i256* %866
  %868 = trunc i256 %867 to i254
  %869 = zext i1 %847 to i254
  %870 = shl i254 %869, 239
  %871 = and i254 %868, -883423532389192164791648750371459257913741948437809479060803100646309889
  %.partset32 = or i254 %871, %870
  store i254 %.partset32, i254* %dst_3, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.exit:                               ; preds = %dst.addr.3273.case.3, %dst.addr.3273.case.2, %dst.addr.3273.case.1, %dst.addr.3273.case.0, %dst.addr.3171.exit
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 33
  %872 = bitcast i1* %src.addr.3374 to i8*
  %873 = load i8, i8* %872
  %874 = trunc i8 %873 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3375.exit [
    i64 0, label %dst.addr.3375.case.0
    i64 1, label %dst.addr.3375.case.1
    i64 2, label %dst.addr.3375.case.2
    i64 3, label %dst.addr.3375.case.3
  ]

dst.addr.3375.case.0:                             ; preds = %dst.addr.3273.exit
  %875 = bitcast i254* %dst_0 to i256*
  %876 = load i256, i256* %875
  %877 = trunc i256 %876 to i254
  %878 = zext i1 %874 to i254
  %879 = shl i254 %878, 240
  %880 = and i254 %877, -1766847064778384329583297500742918515827483896875618958121606201292619777
  %.partset154 = or i254 %880, %879
  store i254 %.partset154, i254* %dst_0, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.1:                             ; preds = %dst.addr.3273.exit
  %881 = bitcast i254* %dst_1 to i256*
  %882 = load i256, i256* %881
  %883 = trunc i256 %882 to i254
  %884 = zext i1 %874 to i254
  %885 = shl i254 %884, 240
  %886 = and i254 %883, -1766847064778384329583297500742918515827483896875618958121606201292619777
  %.partset127 = or i254 %886, %885
  store i254 %.partset127, i254* %dst_1, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.2:                             ; preds = %dst.addr.3273.exit
  %887 = bitcast i254* %dst_2 to i256*
  %888 = load i256, i256* %887
  %889 = trunc i256 %888 to i254
  %890 = zext i1 %874 to i254
  %891 = shl i254 %890, 240
  %892 = and i254 %889, -1766847064778384329583297500742918515827483896875618958121606201292619777
  %.partset60 = or i254 %892, %891
  store i254 %.partset60, i254* %dst_2, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.3:                             ; preds = %dst.addr.3273.exit
  %893 = bitcast i254* %dst_3 to i256*
  %894 = load i256, i256* %893
  %895 = trunc i256 %894 to i254
  %896 = zext i1 %874 to i254
  %897 = shl i254 %896, 240
  %898 = and i254 %895, -1766847064778384329583297500742918515827483896875618958121606201292619777
  %.partset33 = or i254 %898, %897
  store i254 %.partset33, i254* %dst_3, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.exit:                               ; preds = %dst.addr.3375.case.3, %dst.addr.3375.case.2, %dst.addr.3375.case.1, %dst.addr.3375.case.0, %dst.addr.3273.exit
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 34
  %899 = bitcast i1* %src.addr.3476 to i8*
  %900 = load i8, i8* %899
  %901 = trunc i8 %900 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3477.exit [
    i64 0, label %dst.addr.3477.case.0
    i64 1, label %dst.addr.3477.case.1
    i64 2, label %dst.addr.3477.case.2
    i64 3, label %dst.addr.3477.case.3
  ]

dst.addr.3477.case.0:                             ; preds = %dst.addr.3375.exit
  %902 = bitcast i254* %dst_0 to i256*
  %903 = load i256, i256* %902
  %904 = trunc i256 %903 to i254
  %905 = zext i1 %901 to i254
  %906 = shl i254 %905, 241
  %907 = and i254 %904, -3533694129556768659166595001485837031654967793751237916243212402585239553
  %.partset153 = or i254 %907, %906
  store i254 %.partset153, i254* %dst_0, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.1:                             ; preds = %dst.addr.3375.exit
  %908 = bitcast i254* %dst_1 to i256*
  %909 = load i256, i256* %908
  %910 = trunc i256 %909 to i254
  %911 = zext i1 %901 to i254
  %912 = shl i254 %911, 241
  %913 = and i254 %910, -3533694129556768659166595001485837031654967793751237916243212402585239553
  %.partset128 = or i254 %913, %912
  store i254 %.partset128, i254* %dst_1, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.2:                             ; preds = %dst.addr.3375.exit
  %914 = bitcast i254* %dst_2 to i256*
  %915 = load i256, i256* %914
  %916 = trunc i256 %915 to i254
  %917 = zext i1 %901 to i254
  %918 = shl i254 %917, 241
  %919 = and i254 %916, -3533694129556768659166595001485837031654967793751237916243212402585239553
  %.partset59 = or i254 %919, %918
  store i254 %.partset59, i254* %dst_2, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.3:                             ; preds = %dst.addr.3375.exit
  %920 = bitcast i254* %dst_3 to i256*
  %921 = load i256, i256* %920
  %922 = trunc i256 %921 to i254
  %923 = zext i1 %901 to i254
  %924 = shl i254 %923, 241
  %925 = and i254 %922, -3533694129556768659166595001485837031654967793751237916243212402585239553
  %.partset34 = or i254 %925, %924
  store i254 %.partset34, i254* %dst_3, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.exit:                               ; preds = %dst.addr.3477.case.3, %dst.addr.3477.case.2, %dst.addr.3477.case.1, %dst.addr.3477.case.0, %dst.addr.3375.exit
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 35
  %926 = bitcast i1* %src.addr.3578 to i8*
  %927 = load i8, i8* %926
  %928 = trunc i8 %927 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3579.exit [
    i64 0, label %dst.addr.3579.case.0
    i64 1, label %dst.addr.3579.case.1
    i64 2, label %dst.addr.3579.case.2
    i64 3, label %dst.addr.3579.case.3
  ]

dst.addr.3579.case.0:                             ; preds = %dst.addr.3477.exit
  %929 = bitcast i254* %dst_0 to i256*
  %930 = load i256, i256* %929
  %931 = trunc i256 %930 to i254
  %932 = zext i1 %928 to i254
  %933 = shl i254 %932, 242
  %934 = and i254 %931, -7067388259113537318333190002971674063309935587502475832486424805170479105
  %.partset152 = or i254 %934, %933
  store i254 %.partset152, i254* %dst_0, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.1:                             ; preds = %dst.addr.3477.exit
  %935 = bitcast i254* %dst_1 to i256*
  %936 = load i256, i256* %935
  %937 = trunc i256 %936 to i254
  %938 = zext i1 %928 to i254
  %939 = shl i254 %938, 242
  %940 = and i254 %937, -7067388259113537318333190002971674063309935587502475832486424805170479105
  %.partset129 = or i254 %940, %939
  store i254 %.partset129, i254* %dst_1, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.2:                             ; preds = %dst.addr.3477.exit
  %941 = bitcast i254* %dst_2 to i256*
  %942 = load i256, i256* %941
  %943 = trunc i256 %942 to i254
  %944 = zext i1 %928 to i254
  %945 = shl i254 %944, 242
  %946 = and i254 %943, -7067388259113537318333190002971674063309935587502475832486424805170479105
  %.partset58 = or i254 %946, %945
  store i254 %.partset58, i254* %dst_2, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.3:                             ; preds = %dst.addr.3477.exit
  %947 = bitcast i254* %dst_3 to i256*
  %948 = load i256, i256* %947
  %949 = trunc i256 %948 to i254
  %950 = zext i1 %928 to i254
  %951 = shl i254 %950, 242
  %952 = and i254 %949, -7067388259113537318333190002971674063309935587502475832486424805170479105
  %.partset35 = or i254 %952, %951
  store i254 %.partset35, i254* %dst_3, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.exit:                               ; preds = %dst.addr.3579.case.3, %dst.addr.3579.case.2, %dst.addr.3579.case.1, %dst.addr.3579.case.0, %dst.addr.3477.exit
  %src.addr.3680 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 36
  %953 = bitcast i1* %src.addr.3680 to i8*
  %954 = load i8, i8* %953
  %955 = trunc i8 %954 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3681.exit [
    i64 0, label %dst.addr.3681.case.0
    i64 1, label %dst.addr.3681.case.1
    i64 2, label %dst.addr.3681.case.2
    i64 3, label %dst.addr.3681.case.3
  ]

dst.addr.3681.case.0:                             ; preds = %dst.addr.3579.exit
  %956 = bitcast i254* %dst_0 to i256*
  %957 = load i256, i256* %956
  %958 = trunc i256 %957 to i254
  %959 = zext i1 %955 to i254
  %960 = shl i254 %959, 243
  %961 = and i254 %958, -14134776518227074636666380005943348126619871175004951664972849610340958209
  %.partset151 = or i254 %961, %960
  store i254 %.partset151, i254* %dst_0, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.1:                             ; preds = %dst.addr.3579.exit
  %962 = bitcast i254* %dst_1 to i256*
  %963 = load i256, i256* %962
  %964 = trunc i256 %963 to i254
  %965 = zext i1 %955 to i254
  %966 = shl i254 %965, 243
  %967 = and i254 %964, -14134776518227074636666380005943348126619871175004951664972849610340958209
  %.partset130 = or i254 %967, %966
  store i254 %.partset130, i254* %dst_1, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.2:                             ; preds = %dst.addr.3579.exit
  %968 = bitcast i254* %dst_2 to i256*
  %969 = load i256, i256* %968
  %970 = trunc i256 %969 to i254
  %971 = zext i1 %955 to i254
  %972 = shl i254 %971, 243
  %973 = and i254 %970, -14134776518227074636666380005943348126619871175004951664972849610340958209
  %.partset57 = or i254 %973, %972
  store i254 %.partset57, i254* %dst_2, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.3:                             ; preds = %dst.addr.3579.exit
  %974 = bitcast i254* %dst_3 to i256*
  %975 = load i256, i256* %974
  %976 = trunc i256 %975 to i254
  %977 = zext i1 %955 to i254
  %978 = shl i254 %977, 243
  %979 = and i254 %976, -14134776518227074636666380005943348126619871175004951664972849610340958209
  %.partset36 = or i254 %979, %978
  store i254 %.partset36, i254* %dst_3, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.exit:                               ; preds = %dst.addr.3681.case.3, %dst.addr.3681.case.2, %dst.addr.3681.case.1, %dst.addr.3681.case.0, %dst.addr.3579.exit
  %src.addr.3782 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 37
  %980 = bitcast i1* %src.addr.3782 to i8*
  %981 = load i8, i8* %980
  %982 = trunc i8 %981 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3783.exit [
    i64 0, label %dst.addr.3783.case.0
    i64 1, label %dst.addr.3783.case.1
    i64 2, label %dst.addr.3783.case.2
    i64 3, label %dst.addr.3783.case.3
  ]

dst.addr.3783.case.0:                             ; preds = %dst.addr.3681.exit
  %983 = bitcast i254* %dst_0 to i256*
  %984 = load i256, i256* %983
  %985 = trunc i256 %984 to i254
  %986 = zext i1 %982 to i254
  %987 = shl i254 %986, 244
  %988 = and i254 %985, -28269553036454149273332760011886696253239742350009903329945699220681916417
  %.partset150 = or i254 %988, %987
  store i254 %.partset150, i254* %dst_0, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.1:                             ; preds = %dst.addr.3681.exit
  %989 = bitcast i254* %dst_1 to i256*
  %990 = load i256, i256* %989
  %991 = trunc i256 %990 to i254
  %992 = zext i1 %982 to i254
  %993 = shl i254 %992, 244
  %994 = and i254 %991, -28269553036454149273332760011886696253239742350009903329945699220681916417
  %.partset131 = or i254 %994, %993
  store i254 %.partset131, i254* %dst_1, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.2:                             ; preds = %dst.addr.3681.exit
  %995 = bitcast i254* %dst_2 to i256*
  %996 = load i256, i256* %995
  %997 = trunc i256 %996 to i254
  %998 = zext i1 %982 to i254
  %999 = shl i254 %998, 244
  %1000 = and i254 %997, -28269553036454149273332760011886696253239742350009903329945699220681916417
  %.partset56 = or i254 %1000, %999
  store i254 %.partset56, i254* %dst_2, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.3:                             ; preds = %dst.addr.3681.exit
  %1001 = bitcast i254* %dst_3 to i256*
  %1002 = load i256, i256* %1001
  %1003 = trunc i256 %1002 to i254
  %1004 = zext i1 %982 to i254
  %1005 = shl i254 %1004, 244
  %1006 = and i254 %1003, -28269553036454149273332760011886696253239742350009903329945699220681916417
  %.partset37 = or i254 %1006, %1005
  store i254 %.partset37, i254* %dst_3, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.exit:                               ; preds = %dst.addr.3783.case.3, %dst.addr.3783.case.2, %dst.addr.3783.case.1, %dst.addr.3783.case.0, %dst.addr.3681.exit
  %src.addr.3884 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 38
  %1007 = bitcast i1* %src.addr.3884 to i8*
  %1008 = load i8, i8* %1007
  %1009 = trunc i8 %1008 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3885.exit [
    i64 0, label %dst.addr.3885.case.0
    i64 1, label %dst.addr.3885.case.1
    i64 2, label %dst.addr.3885.case.2
    i64 3, label %dst.addr.3885.case.3
  ]

dst.addr.3885.case.0:                             ; preds = %dst.addr.3783.exit
  %1010 = bitcast i254* %dst_0 to i256*
  %1011 = load i256, i256* %1010
  %1012 = trunc i256 %1011 to i254
  %1013 = zext i1 %1009 to i254
  %1014 = shl i254 %1013, 245
  %1015 = and i254 %1012, -56539106072908298546665520023773392506479484700019806659891398441363832833
  %.partset149 = or i254 %1015, %1014
  store i254 %.partset149, i254* %dst_0, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.1:                             ; preds = %dst.addr.3783.exit
  %1016 = bitcast i254* %dst_1 to i256*
  %1017 = load i256, i256* %1016
  %1018 = trunc i256 %1017 to i254
  %1019 = zext i1 %1009 to i254
  %1020 = shl i254 %1019, 245
  %1021 = and i254 %1018, -56539106072908298546665520023773392506479484700019806659891398441363832833
  %.partset132 = or i254 %1021, %1020
  store i254 %.partset132, i254* %dst_1, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.2:                             ; preds = %dst.addr.3783.exit
  %1022 = bitcast i254* %dst_2 to i256*
  %1023 = load i256, i256* %1022
  %1024 = trunc i256 %1023 to i254
  %1025 = zext i1 %1009 to i254
  %1026 = shl i254 %1025, 245
  %1027 = and i254 %1024, -56539106072908298546665520023773392506479484700019806659891398441363832833
  %.partset55 = or i254 %1027, %1026
  store i254 %.partset55, i254* %dst_2, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.3:                             ; preds = %dst.addr.3783.exit
  %1028 = bitcast i254* %dst_3 to i256*
  %1029 = load i256, i256* %1028
  %1030 = trunc i256 %1029 to i254
  %1031 = zext i1 %1009 to i254
  %1032 = shl i254 %1031, 245
  %1033 = and i254 %1030, -56539106072908298546665520023773392506479484700019806659891398441363832833
  %.partset38 = or i254 %1033, %1032
  store i254 %.partset38, i254* %dst_3, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.exit:                               ; preds = %dst.addr.3885.case.3, %dst.addr.3885.case.2, %dst.addr.3885.case.1, %dst.addr.3885.case.0, %dst.addr.3783.exit
  %src.addr.3986 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 39
  %1034 = bitcast i1* %src.addr.3986 to i8*
  %1035 = load i8, i8* %1034
  %1036 = trunc i8 %1035 to i1
  switch i64 %for.loop.idx103, label %dst.addr.3987.exit [
    i64 0, label %dst.addr.3987.case.0
    i64 1, label %dst.addr.3987.case.1
    i64 2, label %dst.addr.3987.case.2
    i64 3, label %dst.addr.3987.case.3
  ]

dst.addr.3987.case.0:                             ; preds = %dst.addr.3885.exit
  %1037 = bitcast i254* %dst_0 to i256*
  %1038 = load i256, i256* %1037
  %1039 = trunc i256 %1038 to i254
  %1040 = zext i1 %1036 to i254
  %1041 = shl i254 %1040, 246
  %1042 = and i254 %1039, -113078212145816597093331040047546785012958969400039613319782796882727665665
  %.partset148 = or i254 %1042, %1041
  store i254 %.partset148, i254* %dst_0, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.1:                             ; preds = %dst.addr.3885.exit
  %1043 = bitcast i254* %dst_1 to i256*
  %1044 = load i256, i256* %1043
  %1045 = trunc i256 %1044 to i254
  %1046 = zext i1 %1036 to i254
  %1047 = shl i254 %1046, 246
  %1048 = and i254 %1045, -113078212145816597093331040047546785012958969400039613319782796882727665665
  %.partset133 = or i254 %1048, %1047
  store i254 %.partset133, i254* %dst_1, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.2:                             ; preds = %dst.addr.3885.exit
  %1049 = bitcast i254* %dst_2 to i256*
  %1050 = load i256, i256* %1049
  %1051 = trunc i256 %1050 to i254
  %1052 = zext i1 %1036 to i254
  %1053 = shl i254 %1052, 246
  %1054 = and i254 %1051, -113078212145816597093331040047546785012958969400039613319782796882727665665
  %.partset54 = or i254 %1054, %1053
  store i254 %.partset54, i254* %dst_2, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.3:                             ; preds = %dst.addr.3885.exit
  %1055 = bitcast i254* %dst_3 to i256*
  %1056 = load i256, i256* %1055
  %1057 = trunc i256 %1056 to i254
  %1058 = zext i1 %1036 to i254
  %1059 = shl i254 %1058, 246
  %1060 = and i254 %1057, -113078212145816597093331040047546785012958969400039613319782796882727665665
  %.partset39 = or i254 %1060, %1059
  store i254 %.partset39, i254* %dst_3, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.exit:                               ; preds = %dst.addr.3987.case.3, %dst.addr.3987.case.2, %dst.addr.3987.case.1, %dst.addr.3987.case.0, %dst.addr.3885.exit
  %src.addr.4088 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 40
  %1061 = bitcast i1* %src.addr.4088 to i8*
  %1062 = load i8, i8* %1061
  %1063 = trunc i8 %1062 to i1
  switch i64 %for.loop.idx103, label %dst.addr.4089.exit [
    i64 0, label %dst.addr.4089.case.0
    i64 1, label %dst.addr.4089.case.1
    i64 2, label %dst.addr.4089.case.2
    i64 3, label %dst.addr.4089.case.3
  ]

dst.addr.4089.case.0:                             ; preds = %dst.addr.3987.exit
  %1064 = bitcast i254* %dst_0 to i256*
  %1065 = load i256, i256* %1064
  %1066 = trunc i256 %1065 to i254
  %1067 = zext i1 %1063 to i254
  %1068 = shl i254 %1067, 247
  %1069 = and i254 %1066, -226156424291633194186662080095093570025917938800079226639565593765455331329
  %.partset147 = or i254 %1069, %1068
  store i254 %.partset147, i254* %dst_0, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.1:                             ; preds = %dst.addr.3987.exit
  %1070 = bitcast i254* %dst_1 to i256*
  %1071 = load i256, i256* %1070
  %1072 = trunc i256 %1071 to i254
  %1073 = zext i1 %1063 to i254
  %1074 = shl i254 %1073, 247
  %1075 = and i254 %1072, -226156424291633194186662080095093570025917938800079226639565593765455331329
  %.partset134 = or i254 %1075, %1074
  store i254 %.partset134, i254* %dst_1, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.2:                             ; preds = %dst.addr.3987.exit
  %1076 = bitcast i254* %dst_2 to i256*
  %1077 = load i256, i256* %1076
  %1078 = trunc i256 %1077 to i254
  %1079 = zext i1 %1063 to i254
  %1080 = shl i254 %1079, 247
  %1081 = and i254 %1078, -226156424291633194186662080095093570025917938800079226639565593765455331329
  %.partset53 = or i254 %1081, %1080
  store i254 %.partset53, i254* %dst_2, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.3:                             ; preds = %dst.addr.3987.exit
  %1082 = bitcast i254* %dst_3 to i256*
  %1083 = load i256, i256* %1082
  %1084 = trunc i256 %1083 to i254
  %1085 = zext i1 %1063 to i254
  %1086 = shl i254 %1085, 247
  %1087 = and i254 %1084, -226156424291633194186662080095093570025917938800079226639565593765455331329
  %.partset40 = or i254 %1087, %1086
  store i254 %.partset40, i254* %dst_3, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.exit:                               ; preds = %dst.addr.4089.case.3, %dst.addr.4089.case.2, %dst.addr.4089.case.1, %dst.addr.4089.case.0, %dst.addr.3987.exit
  %src.addr.4190 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 41
  %1088 = bitcast i1* %src.addr.4190 to i8*
  %1089 = load i8, i8* %1088
  %1090 = trunc i8 %1089 to i1
  switch i64 %for.loop.idx103, label %dst.addr.4191.exit [
    i64 0, label %dst.addr.4191.case.0
    i64 1, label %dst.addr.4191.case.1
    i64 2, label %dst.addr.4191.case.2
    i64 3, label %dst.addr.4191.case.3
  ]

dst.addr.4191.case.0:                             ; preds = %dst.addr.4089.exit
  %1091 = bitcast i254* %dst_0 to i256*
  %1092 = load i256, i256* %1091
  %1093 = trunc i256 %1092 to i254
  %1094 = zext i1 %1090 to i254
  %1095 = shl i254 %1094, 248
  %1096 = and i254 %1093, -452312848583266388373324160190187140051835877600158453279131187530910662657
  %.partset146 = or i254 %1096, %1095
  store i254 %.partset146, i254* %dst_0, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.1:                             ; preds = %dst.addr.4089.exit
  %1097 = bitcast i254* %dst_1 to i256*
  %1098 = load i256, i256* %1097
  %1099 = trunc i256 %1098 to i254
  %1100 = zext i1 %1090 to i254
  %1101 = shl i254 %1100, 248
  %1102 = and i254 %1099, -452312848583266388373324160190187140051835877600158453279131187530910662657
  %.partset135 = or i254 %1102, %1101
  store i254 %.partset135, i254* %dst_1, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.2:                             ; preds = %dst.addr.4089.exit
  %1103 = bitcast i254* %dst_2 to i256*
  %1104 = load i256, i256* %1103
  %1105 = trunc i256 %1104 to i254
  %1106 = zext i1 %1090 to i254
  %1107 = shl i254 %1106, 248
  %1108 = and i254 %1105, -452312848583266388373324160190187140051835877600158453279131187530910662657
  %.partset52 = or i254 %1108, %1107
  store i254 %.partset52, i254* %dst_2, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.3:                             ; preds = %dst.addr.4089.exit
  %1109 = bitcast i254* %dst_3 to i256*
  %1110 = load i256, i256* %1109
  %1111 = trunc i256 %1110 to i254
  %1112 = zext i1 %1090 to i254
  %1113 = shl i254 %1112, 248
  %1114 = and i254 %1111, -452312848583266388373324160190187140051835877600158453279131187530910662657
  %.partset41 = or i254 %1114, %1113
  store i254 %.partset41, i254* %dst_3, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.exit:                               ; preds = %dst.addr.4191.case.3, %dst.addr.4191.case.2, %dst.addr.4191.case.1, %dst.addr.4191.case.0, %dst.addr.4089.exit
  %src.addr.4292 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 42
  %1115 = bitcast i1* %src.addr.4292 to i8*
  %1116 = load i8, i8* %1115
  %1117 = trunc i8 %1116 to i1
  switch i64 %for.loop.idx103, label %dst.addr.4293.exit [
    i64 0, label %dst.addr.4293.case.0
    i64 1, label %dst.addr.4293.case.1
    i64 2, label %dst.addr.4293.case.2
    i64 3, label %dst.addr.4293.case.3
  ]

dst.addr.4293.case.0:                             ; preds = %dst.addr.4191.exit
  %1118 = bitcast i254* %dst_0 to i256*
  %1119 = load i256, i256* %1118
  %1120 = trunc i256 %1119 to i254
  %1121 = zext i1 %1117 to i254
  %1122 = shl i254 %1121, 249
  %1123 = and i254 %1120, -904625697166532776746648320380374280103671755200316906558262375061821325313
  %.partset145 = or i254 %1123, %1122
  store i254 %.partset145, i254* %dst_0, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.1:                             ; preds = %dst.addr.4191.exit
  %1124 = bitcast i254* %dst_1 to i256*
  %1125 = load i256, i256* %1124
  %1126 = trunc i256 %1125 to i254
  %1127 = zext i1 %1117 to i254
  %1128 = shl i254 %1127, 249
  %1129 = and i254 %1126, -904625697166532776746648320380374280103671755200316906558262375061821325313
  %.partset136 = or i254 %1129, %1128
  store i254 %.partset136, i254* %dst_1, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.2:                             ; preds = %dst.addr.4191.exit
  %1130 = bitcast i254* %dst_2 to i256*
  %1131 = load i256, i256* %1130
  %1132 = trunc i256 %1131 to i254
  %1133 = zext i1 %1117 to i254
  %1134 = shl i254 %1133, 249
  %1135 = and i254 %1132, -904625697166532776746648320380374280103671755200316906558262375061821325313
  %.partset51 = or i254 %1135, %1134
  store i254 %.partset51, i254* %dst_2, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.3:                             ; preds = %dst.addr.4191.exit
  %1136 = bitcast i254* %dst_3 to i256*
  %1137 = load i256, i256* %1136
  %1138 = trunc i256 %1137 to i254
  %1139 = zext i1 %1117 to i254
  %1140 = shl i254 %1139, 249
  %1141 = and i254 %1138, -904625697166532776746648320380374280103671755200316906558262375061821325313
  %.partset42 = or i254 %1141, %1140
  store i254 %.partset42, i254* %dst_3, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.exit:                               ; preds = %dst.addr.4293.case.3, %dst.addr.4293.case.2, %dst.addr.4293.case.1, %dst.addr.4293.case.0, %dst.addr.4191.exit
  %src.addr.4394 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 43
  %1142 = bitcast i1* %src.addr.4394 to i8*
  %1143 = load i8, i8* %1142
  %1144 = trunc i8 %1143 to i1
  switch i64 %for.loop.idx103, label %dst.addr.4395.exit [
    i64 0, label %dst.addr.4395.case.0
    i64 1, label %dst.addr.4395.case.1
    i64 2, label %dst.addr.4395.case.2
    i64 3, label %dst.addr.4395.case.3
  ]

dst.addr.4395.case.0:                             ; preds = %dst.addr.4293.exit
  %1145 = bitcast i254* %dst_0 to i256*
  %1146 = load i256, i256* %1145
  %1147 = trunc i256 %1146 to i254
  %1148 = zext i1 %1144 to i254
  %1149 = shl i254 %1148, 250
  %1150 = and i254 %1147, -1809251394333065553493296640760748560207343510400633813116524750123642650625
  %.partset144 = or i254 %1150, %1149
  store i254 %.partset144, i254* %dst_0, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.1:                             ; preds = %dst.addr.4293.exit
  %1151 = bitcast i254* %dst_1 to i256*
  %1152 = load i256, i256* %1151
  %1153 = trunc i256 %1152 to i254
  %1154 = zext i1 %1144 to i254
  %1155 = shl i254 %1154, 250
  %1156 = and i254 %1153, -1809251394333065553493296640760748560207343510400633813116524750123642650625
  %.partset137 = or i254 %1156, %1155
  store i254 %.partset137, i254* %dst_1, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.2:                             ; preds = %dst.addr.4293.exit
  %1157 = bitcast i254* %dst_2 to i256*
  %1158 = load i256, i256* %1157
  %1159 = trunc i256 %1158 to i254
  %1160 = zext i1 %1144 to i254
  %1161 = shl i254 %1160, 250
  %1162 = and i254 %1159, -1809251394333065553493296640760748560207343510400633813116524750123642650625
  %.partset50 = or i254 %1162, %1161
  store i254 %.partset50, i254* %dst_2, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.3:                             ; preds = %dst.addr.4293.exit
  %1163 = bitcast i254* %dst_3 to i256*
  %1164 = load i256, i256* %1163
  %1165 = trunc i256 %1164 to i254
  %1166 = zext i1 %1144 to i254
  %1167 = shl i254 %1166, 250
  %1168 = and i254 %1165, -1809251394333065553493296640760748560207343510400633813116524750123642650625
  %.partset43 = or i254 %1168, %1167
  store i254 %.partset43, i254* %dst_3, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.exit:                               ; preds = %dst.addr.4395.case.3, %dst.addr.4395.case.2, %dst.addr.4395.case.1, %dst.addr.4395.case.0, %dst.addr.4293.exit
  %src.addr.4496 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 44
  %1169 = bitcast i1* %src.addr.4496 to i8*
  %1170 = load i8, i8* %1169
  %1171 = trunc i8 %1170 to i1
  switch i64 %for.loop.idx103, label %dst.addr.4497.exit [
    i64 0, label %dst.addr.4497.case.0
    i64 1, label %dst.addr.4497.case.1
    i64 2, label %dst.addr.4497.case.2
    i64 3, label %dst.addr.4497.case.3
  ]

dst.addr.4497.case.0:                             ; preds = %dst.addr.4395.exit
  %1172 = bitcast i254* %dst_0 to i256*
  %1173 = load i256, i256* %1172
  %1174 = trunc i256 %1173 to i254
  %1175 = zext i1 %1171 to i254
  %1176 = shl i254 %1175, 251
  %1177 = and i254 %1174, -3618502788666131106986593281521497120414687020801267626233049500247285301249
  %.partset143 = or i254 %1177, %1176
  store i254 %.partset143, i254* %dst_0, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.1:                             ; preds = %dst.addr.4395.exit
  %1178 = bitcast i254* %dst_1 to i256*
  %1179 = load i256, i256* %1178
  %1180 = trunc i256 %1179 to i254
  %1181 = zext i1 %1171 to i254
  %1182 = shl i254 %1181, 251
  %1183 = and i254 %1180, -3618502788666131106986593281521497120414687020801267626233049500247285301249
  %.partset138 = or i254 %1183, %1182
  store i254 %.partset138, i254* %dst_1, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.2:                             ; preds = %dst.addr.4395.exit
  %1184 = bitcast i254* %dst_2 to i256*
  %1185 = load i256, i256* %1184
  %1186 = trunc i256 %1185 to i254
  %1187 = zext i1 %1171 to i254
  %1188 = shl i254 %1187, 251
  %1189 = and i254 %1186, -3618502788666131106986593281521497120414687020801267626233049500247285301249
  %.partset49 = or i254 %1189, %1188
  store i254 %.partset49, i254* %dst_2, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.3:                             ; preds = %dst.addr.4395.exit
  %1190 = bitcast i254* %dst_3 to i256*
  %1191 = load i256, i256* %1190
  %1192 = trunc i256 %1191 to i254
  %1193 = zext i1 %1171 to i254
  %1194 = shl i254 %1193, 251
  %1195 = and i254 %1192, -3618502788666131106986593281521497120414687020801267626233049500247285301249
  %.partset44 = or i254 %1195, %1194
  store i254 %.partset44, i254* %dst_3, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.exit:                               ; preds = %dst.addr.4497.case.3, %dst.addr.4497.case.2, %dst.addr.4497.case.1, %dst.addr.4497.case.0, %dst.addr.4395.exit
  %src.addr.4598 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 45
  %1196 = bitcast i1* %src.addr.4598 to i8*
  %1197 = load i8, i8* %1196
  %1198 = trunc i8 %1197 to i1
  switch i64 %for.loop.idx103, label %dst.addr.4599.exit [
    i64 0, label %dst.addr.4599.case.0
    i64 1, label %dst.addr.4599.case.1
    i64 2, label %dst.addr.4599.case.2
    i64 3, label %dst.addr.4599.case.3
  ]

dst.addr.4599.case.0:                             ; preds = %dst.addr.4497.exit
  %1199 = bitcast i254* %dst_0 to i256*
  %1200 = load i256, i256* %1199
  %1201 = trunc i256 %1200 to i254
  %1202 = zext i1 %1198 to i254
  %1203 = shl i254 %1202, 252
  %1204 = and i254 %1201, -7237005577332262213973186563042994240829374041602535252466099000494570602497
  %.partset142 = or i254 %1204, %1203
  store i254 %.partset142, i254* %dst_0, align 1
  br label %dst.addr.4599.exit

dst.addr.4599.case.1:                             ; preds = %dst.addr.4497.exit
  %1205 = bitcast i254* %dst_1 to i256*
  %1206 = load i256, i256* %1205
  %1207 = trunc i256 %1206 to i254
  %1208 = zext i1 %1198 to i254
  %1209 = shl i254 %1208, 252
  %1210 = and i254 %1207, -7237005577332262213973186563042994240829374041602535252466099000494570602497
  %.partset139 = or i254 %1210, %1209
  store i254 %.partset139, i254* %dst_1, align 1
  br label %dst.addr.4599.exit

dst.addr.4599.case.2:                             ; preds = %dst.addr.4497.exit
  %1211 = bitcast i254* %dst_2 to i256*
  %1212 = load i256, i256* %1211
  %1213 = trunc i256 %1212 to i254
  %1214 = zext i1 %1198 to i254
  %1215 = shl i254 %1214, 252
  %1216 = and i254 %1213, -7237005577332262213973186563042994240829374041602535252466099000494570602497
  %.partset48 = or i254 %1216, %1215
  store i254 %.partset48, i254* %dst_2, align 1
  br label %dst.addr.4599.exit

dst.addr.4599.case.3:                             ; preds = %dst.addr.4497.exit
  %1217 = bitcast i254* %dst_3 to i256*
  %1218 = load i256, i256* %1217
  %1219 = trunc i256 %1218 to i254
  %1220 = zext i1 %1198 to i254
  %1221 = shl i254 %1220, 252
  %1222 = and i254 %1219, -7237005577332262213973186563042994240829374041602535252466099000494570602497
  %.partset45 = or i254 %1222, %1221
  store i254 %.partset45, i254* %dst_3, align 1
  br label %dst.addr.4599.exit

dst.addr.4599.exit:                               ; preds = %dst.addr.4599.case.3, %dst.addr.4599.case.2, %dst.addr.4599.case.1, %dst.addr.4599.case.0, %dst.addr.4497.exit
  %src.addr.46100 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx103, i32 46
  %1223 = bitcast i1* %src.addr.46100 to i8*
  %1224 = load i8, i8* %1223
  %1225 = trunc i8 %1224 to i1
  switch i64 %for.loop.idx103, label %dst.addr.46101.exit [
    i64 0, label %dst.addr.46101.case.0
    i64 1, label %dst.addr.46101.case.1
    i64 2, label %dst.addr.46101.case.2
    i64 3, label %dst.addr.46101.case.3
  ]

dst.addr.46101.case.0:                            ; preds = %dst.addr.4599.exit
  %1226 = bitcast i254* %dst_0 to i256*
  %1227 = load i256, i256* %1226
  %1228 = trunc i256 %1227 to i254
  %1229 = zext i1 %1225 to i254
  %1230 = shl i254 %1229, 253
  %1231 = and i254 %1228, 14474011154664524427946373126085988481658748083205070504932198000989141204991
  %.partset141 = or i254 %1231, %1230
  store i254 %.partset141, i254* %dst_0, align 1
  br label %dst.addr.46101.exit

dst.addr.46101.case.1:                            ; preds = %dst.addr.4599.exit
  %1232 = bitcast i254* %dst_1 to i256*
  %1233 = load i256, i256* %1232
  %1234 = trunc i256 %1233 to i254
  %1235 = zext i1 %1225 to i254
  %1236 = shl i254 %1235, 253
  %1237 = and i254 %1234, 14474011154664524427946373126085988481658748083205070504932198000989141204991
  %.partset140 = or i254 %1237, %1236
  store i254 %.partset140, i254* %dst_1, align 1
  br label %dst.addr.46101.exit

dst.addr.46101.case.2:                            ; preds = %dst.addr.4599.exit
  %1238 = bitcast i254* %dst_2 to i256*
  %1239 = load i256, i256* %1238
  %1240 = trunc i256 %1239 to i254
  %1241 = zext i1 %1225 to i254
  %1242 = shl i254 %1241, 253
  %1243 = and i254 %1240, 14474011154664524427946373126085988481658748083205070504932198000989141204991
  %.partset47 = or i254 %1243, %1242
  store i254 %.partset47, i254* %dst_2, align 1
  br label %dst.addr.46101.exit

dst.addr.46101.case.3:                            ; preds = %dst.addr.4599.exit
  %1244 = bitcast i254* %dst_3 to i256*
  %1245 = load i256, i256* %1244
  %1246 = trunc i256 %1245 to i254
  %1247 = zext i1 %1225 to i254
  %1248 = shl i254 %1247, 253
  %1249 = and i254 %1246, 14474011154664524427946373126085988481658748083205070504932198000989141204991
  %.partset46 = or i254 %1249, %1248
  store i254 %.partset46, i254* %dst_3, align 1
  br label %dst.addr.46101.exit

dst.addr.46101.exit:                              ; preds = %dst.addr.46101.case.3, %dst.addr.46101.case.2, %dst.addr.46101.case.1, %dst.addr.46101.case.0, %dst.addr.4599.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx103, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.46101.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.12.15(i254* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i254* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i254* noalias align 512 "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i254* noalias align 512 "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #1 {
entry:
  %0 = icmp eq i254* %dst_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.13.14(i254* nonnull %dst_0, i254* %dst_1, i254* %dst_2, i254* %dst_3, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in(i1* noalias readonly "orig.arg.no"="0", i1* noalias align 512 "orig.arg.no"="1", i1* noalias readonly "orig.arg.no"="2", i1* noalias align 512 "orig.arg.no"="3", i8* noalias readonly "orig.arg.no"="4", i8* noalias align 512 "orig.arg.no"="5", i32* noalias readonly "orig.arg.no"="6", i32* noalias align 512 "orig.arg.no"="7", i32* noalias readonly "orig.arg.no"="8", i32* noalias align 512 "orig.arg.no"="9", i32* noalias readonly "orig.arg.no"="10", i32* noalias align 512 "orig.arg.no"="11", i1* noalias readonly "orig.arg.no"="12", i1* noalias align 512 "orig.arg.no"="13", i32* noalias readonly "orig.arg.no"="14", i32* noalias align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="16", i254* noalias align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i254* noalias align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i254* noalias align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i254* noalias align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias readonly "orig.arg.no"="18", i1* noalias align 512 "orig.arg.no"="19", i32* noalias readonly "orig.arg.no"="20", i32* noalias align 512 "orig.arg.no"="21", i1* noalias readonly "orig.arg.no"="22", i1* noalias align 512 "orig.arg.no"="23", i32* noalias readonly "orig.arg.no"="24", i32* noalias align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias readonly "orig.arg.no"="26", i1056* noalias align 512 "orig.arg.no"="27", i32* noalias readonly "orig.arg.no"="28", i32* noalias align 512 "orig.arg.no"="29", i32* noalias readonly "orig.arg.no"="30", i32* noalias align 512 "orig.arg.no"="31", i32* noalias readonly "orig.arg.no"="32", i32* noalias align 512 "orig.arg.no"="33", i32* noalias readonly "orig.arg.no"="34", i32* noalias align 512 "orig.arg.no"="35", i32* noalias readonly "orig.arg.no"="36", i32* noalias align 512 "orig.arg.no"="37", i32* noalias readonly "orig.arg.no"="38", i32* noalias align 512 "orig.arg.no"="39", i32* noalias readonly "orig.arg.no"="40", i32* noalias align 512 "orig.arg.no"="41", i32* noalias readonly "orig.arg.no"="42", i32* noalias align 512 "orig.arg.no"="43", i32* noalias readonly "orig.arg.no"="44", i32* noalias align 512 "orig.arg.no"="45", i32* noalias readonly "orig.arg.no"="46", i32* noalias align 512 "orig.arg.no"="47", i32* noalias readonly "orig.arg.no"="48", i32* noalias align 512 "orig.arg.no"="49", i32* noalias readonly "orig.arg.no"="50", i32* noalias align 512 "orig.arg.no"="51", i32* noalias readonly "orig.arg.no"="52", i32* noalias align 512 "orig.arg.no"="53", i32* noalias readonly "orig.arg.no"="54", i32* noalias align 512 "orig.arg.no"="55", i32* noalias readonly "orig.arg.no"="56", i32* noalias align 512 "orig.arg.no"="57", i1* noalias readonly "orig.arg.no"="58", i1* noalias align 512 "orig.arg.no"="59", i1* noalias readonly "orig.arg.no"="60", i1* noalias align 512 "orig.arg.no"="61") #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %3, i1* %2)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %5, i8* %4)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %7, i32* %6)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %9, i32* %8)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %11, i32* %10)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %13, i1* %12)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %15, i32* %14)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.12.15(i254* align 512 %_0, i254* align 512 %_1, i254* align 512 %_2, i254* align 512 %_3, [4 x %struct.HeadCtx]* %16)
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
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %60, i1* %59)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.23.24([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i254* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i254* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i254* readonly "orig.arg.no"="1" "unpacked"="1.2" %src_2, i254* readonly "orig.arg.no"="1" "unpacked"="1.3" %src_3, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i254* %src_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond102 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond102, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.46100.exit, %for.loop.lr.ph
  %for.loop.idx103 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.46100.exit ]
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 0
  switch i64 %for.loop.idx103, label %src.addr.01.exit [
    i64 0, label %src.addr.01.case.0
    i64 1, label %src.addr.01.case.1
    i64 2, label %src.addr.01.case.2
    i64 3, label %src.addr.01.case.3
  ]

src.addr.01.case.0:                               ; preds = %for.loop
  %3 = bitcast i254* %src_0 to i256*
  %4 = load i256, i256* %3
  %5 = trunc i256 %4 to i254
  %_0.partselect = trunc i254 %5 to i32
  br label %src.addr.01.exit

src.addr.01.case.1:                               ; preds = %for.loop
  %6 = bitcast i254* %src_1 to i256*
  %7 = load i256, i256* %6
  %8 = trunc i256 %7 to i254
  %_1.partselect = trunc i254 %8 to i32
  br label %src.addr.01.exit

src.addr.01.case.2:                               ; preds = %for.loop
  %9 = bitcast i254* %src_2 to i256*
  %10 = load i256, i256* %9
  %11 = trunc i256 %10 to i254
  %_2.partselect = trunc i254 %11 to i32
  br label %src.addr.01.exit

src.addr.01.case.3:                               ; preds = %for.loop
  %12 = bitcast i254* %src_3 to i256*
  %13 = load i256, i256* %12
  %14 = trunc i256 %13 to i254
  %_3.partselect = trunc i254 %14 to i32
  br label %src.addr.01.exit

src.addr.01.exit:                                 ; preds = %src.addr.01.case.3, %src.addr.01.case.2, %src.addr.01.case.1, %src.addr.01.case.0, %for.loop
  %15 = phi i32 [ %_0.partselect, %src.addr.01.case.0 ], [ %_1.partselect, %src.addr.01.case.1 ], [ %_2.partselect, %src.addr.01.case.2 ], [ %_3.partselect, %src.addr.01.case.3 ], [ undef, %for.loop ]
  store i32 %15, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 1
  switch i64 %for.loop.idx103, label %src.addr.110.exit [
    i64 0, label %src.addr.110.case.0
    i64 1, label %src.addr.110.case.1
    i64 2, label %src.addr.110.case.2
    i64 3, label %src.addr.110.case.3
  ]

src.addr.110.case.0:                              ; preds = %src.addr.01.exit
  %16 = bitcast i254* %src_0 to i256*
  %17 = load i256, i256* %16
  %18 = trunc i256 %17 to i254
  %19 = lshr i254 %18, 32
  %_01.partselect = trunc i254 %19 to i32
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %20 = bitcast i254* %src_1 to i256*
  %21 = load i256, i256* %20
  %22 = trunc i256 %21 to i254
  %23 = lshr i254 %22, 32
  %_12.partselect = trunc i254 %23 to i32
  br label %src.addr.110.exit

src.addr.110.case.2:                              ; preds = %src.addr.01.exit
  %24 = bitcast i254* %src_2 to i256*
  %25 = load i256, i256* %24
  %26 = trunc i256 %25 to i254
  %27 = lshr i254 %26, 32
  %_23.partselect = trunc i254 %27 to i32
  br label %src.addr.110.exit

src.addr.110.case.3:                              ; preds = %src.addr.01.exit
  %28 = bitcast i254* %src_3 to i256*
  %29 = load i256, i256* %28
  %30 = trunc i256 %29 to i254
  %31 = lshr i254 %30, 32
  %_34.partselect = trunc i254 %31 to i32
  br label %src.addr.110.exit

src.addr.110.exit:                                ; preds = %src.addr.110.case.3, %src.addr.110.case.2, %src.addr.110.case.1, %src.addr.110.case.0, %src.addr.01.exit
  %32 = phi i32 [ %_01.partselect, %src.addr.110.case.0 ], [ %_12.partselect, %src.addr.110.case.1 ], [ %_23.partselect, %src.addr.110.case.2 ], [ %_34.partselect, %src.addr.110.case.3 ], [ undef, %src.addr.01.exit ]
  store i32 %32, i32* %dst.addr.111, align 4
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 2
  switch i64 %for.loop.idx103, label %src.addr.212.exit [
    i64 0, label %src.addr.212.case.0
    i64 1, label %src.addr.212.case.1
    i64 2, label %src.addr.212.case.2
    i64 3, label %src.addr.212.case.3
  ]

src.addr.212.case.0:                              ; preds = %src.addr.110.exit
  %33 = bitcast i254* %src_0 to i256*
  %34 = load i256, i256* %33
  %35 = trunc i256 %34 to i254
  %36 = lshr i254 %35, 64
  %_05.partselect = trunc i254 %36 to i8
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %37 = bitcast i254* %src_1 to i256*
  %38 = load i256, i256* %37
  %39 = trunc i256 %38 to i254
  %40 = lshr i254 %39, 64
  %_16.partselect = trunc i254 %40 to i8
  br label %src.addr.212.exit

src.addr.212.case.2:                              ; preds = %src.addr.110.exit
  %41 = bitcast i254* %src_2 to i256*
  %42 = load i256, i256* %41
  %43 = trunc i256 %42 to i254
  %44 = lshr i254 %43, 64
  %_27.partselect = trunc i254 %44 to i8
  br label %src.addr.212.exit

src.addr.212.case.3:                              ; preds = %src.addr.110.exit
  %45 = bitcast i254* %src_3 to i256*
  %46 = load i256, i256* %45
  %47 = trunc i256 %46 to i254
  %48 = lshr i254 %47, 64
  %_38.partselect = trunc i254 %48 to i8
  br label %src.addr.212.exit

src.addr.212.exit:                                ; preds = %src.addr.212.case.3, %src.addr.212.case.2, %src.addr.212.case.1, %src.addr.212.case.0, %src.addr.110.exit
  %49 = phi i8 [ %_05.partselect, %src.addr.212.case.0 ], [ %_16.partselect, %src.addr.212.case.1 ], [ %_27.partselect, %src.addr.212.case.2 ], [ %_38.partselect, %src.addr.212.case.3 ], [ undef, %src.addr.110.exit ]
  store i8 %49, i8* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 3
  switch i64 %for.loop.idx103, label %src.addr.314.exit [
    i64 0, label %src.addr.314.case.0
    i64 1, label %src.addr.314.case.1
    i64 2, label %src.addr.314.case.2
    i64 3, label %src.addr.314.case.3
  ]

src.addr.314.case.0:                              ; preds = %src.addr.212.exit
  %50 = bitcast i254* %src_0 to i256*
  %51 = load i256, i256* %50
  %52 = trunc i256 %51 to i254
  %53 = lshr i254 %52, 72
  %_09.partselect = trunc i254 %53 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %54 = bitcast i254* %src_1 to i256*
  %55 = load i256, i256* %54
  %56 = trunc i256 %55 to i254
  %57 = lshr i254 %56, 72
  %_110.partselect = trunc i254 %57 to i1
  br label %src.addr.314.exit

src.addr.314.case.2:                              ; preds = %src.addr.212.exit
  %58 = bitcast i254* %src_2 to i256*
  %59 = load i256, i256* %58
  %60 = trunc i256 %59 to i254
  %61 = lshr i254 %60, 72
  %_211.partselect = trunc i254 %61 to i1
  br label %src.addr.314.exit

src.addr.314.case.3:                              ; preds = %src.addr.212.exit
  %62 = bitcast i254* %src_3 to i256*
  %63 = load i256, i256* %62
  %64 = trunc i256 %63 to i254
  %65 = lshr i254 %64, 72
  %_312.partselect = trunc i254 %65 to i1
  br label %src.addr.314.exit

src.addr.314.exit:                                ; preds = %src.addr.314.case.3, %src.addr.314.case.2, %src.addr.314.case.1, %src.addr.314.case.0, %src.addr.212.exit
  %66 = phi i1 [ %_09.partselect, %src.addr.314.case.0 ], [ %_110.partselect, %src.addr.314.case.1 ], [ %_211.partselect, %src.addr.314.case.2 ], [ %_312.partselect, %src.addr.314.case.3 ], [ undef, %src.addr.212.exit ]
  store i1 %66, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 4
  switch i64 %for.loop.idx103, label %src.addr.416.exit [
    i64 0, label %src.addr.416.case.0
    i64 1, label %src.addr.416.case.1
    i64 2, label %src.addr.416.case.2
    i64 3, label %src.addr.416.case.3
  ]

src.addr.416.case.0:                              ; preds = %src.addr.314.exit
  %67 = bitcast i254* %src_0 to i256*
  %68 = load i256, i256* %67
  %69 = trunc i256 %68 to i254
  %70 = lshr i254 %69, 73
  %_013.partselect = trunc i254 %70 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %71 = bitcast i254* %src_1 to i256*
  %72 = load i256, i256* %71
  %73 = trunc i256 %72 to i254
  %74 = lshr i254 %73, 73
  %_114.partselect = trunc i254 %74 to i1
  br label %src.addr.416.exit

src.addr.416.case.2:                              ; preds = %src.addr.314.exit
  %75 = bitcast i254* %src_2 to i256*
  %76 = load i256, i256* %75
  %77 = trunc i256 %76 to i254
  %78 = lshr i254 %77, 73
  %_215.partselect = trunc i254 %78 to i1
  br label %src.addr.416.exit

src.addr.416.case.3:                              ; preds = %src.addr.314.exit
  %79 = bitcast i254* %src_3 to i256*
  %80 = load i256, i256* %79
  %81 = trunc i256 %80 to i254
  %82 = lshr i254 %81, 73
  %_316.partselect = trunc i254 %82 to i1
  br label %src.addr.416.exit

src.addr.416.exit:                                ; preds = %src.addr.416.case.3, %src.addr.416.case.2, %src.addr.416.case.1, %src.addr.416.case.0, %src.addr.314.exit
  %83 = phi i1 [ %_013.partselect, %src.addr.416.case.0 ], [ %_114.partselect, %src.addr.416.case.1 ], [ %_215.partselect, %src.addr.416.case.2 ], [ %_316.partselect, %src.addr.416.case.3 ], [ undef, %src.addr.314.exit ]
  store i1 %83, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 5
  switch i64 %for.loop.idx103, label %src.addr.518.exit [
    i64 0, label %src.addr.518.case.0
    i64 1, label %src.addr.518.case.1
    i64 2, label %src.addr.518.case.2
    i64 3, label %src.addr.518.case.3
  ]

src.addr.518.case.0:                              ; preds = %src.addr.416.exit
  %84 = bitcast i254* %src_0 to i256*
  %85 = load i256, i256* %84
  %86 = trunc i256 %85 to i254
  %87 = lshr i254 %86, 74
  %_017.partselect = trunc i254 %87 to i1
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %88 = bitcast i254* %src_1 to i256*
  %89 = load i256, i256* %88
  %90 = trunc i256 %89 to i254
  %91 = lshr i254 %90, 74
  %_118.partselect = trunc i254 %91 to i1
  br label %src.addr.518.exit

src.addr.518.case.2:                              ; preds = %src.addr.416.exit
  %92 = bitcast i254* %src_2 to i256*
  %93 = load i256, i256* %92
  %94 = trunc i256 %93 to i254
  %95 = lshr i254 %94, 74
  %_219.partselect = trunc i254 %95 to i1
  br label %src.addr.518.exit

src.addr.518.case.3:                              ; preds = %src.addr.416.exit
  %96 = bitcast i254* %src_3 to i256*
  %97 = load i256, i256* %96
  %98 = trunc i256 %97 to i254
  %99 = lshr i254 %98, 74
  %_320.partselect = trunc i254 %99 to i1
  br label %src.addr.518.exit

src.addr.518.exit:                                ; preds = %src.addr.518.case.3, %src.addr.518.case.2, %src.addr.518.case.1, %src.addr.518.case.0, %src.addr.416.exit
  %100 = phi i1 [ %_017.partselect, %src.addr.518.case.0 ], [ %_118.partselect, %src.addr.518.case.1 ], [ %_219.partselect, %src.addr.518.case.2 ], [ %_320.partselect, %src.addr.518.case.3 ], [ undef, %src.addr.416.exit ]
  store i1 %100, i1* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 6
  switch i64 %for.loop.idx103, label %src.addr.620.exit [
    i64 0, label %src.addr.620.case.0
    i64 1, label %src.addr.620.case.1
    i64 2, label %src.addr.620.case.2
    i64 3, label %src.addr.620.case.3
  ]

src.addr.620.case.0:                              ; preds = %src.addr.518.exit
  %101 = bitcast i254* %src_0 to i256*
  %102 = load i256, i256* %101
  %103 = trunc i256 %102 to i254
  %104 = lshr i254 %103, 75
  %_021.partselect = trunc i254 %104 to i32
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %105 = bitcast i254* %src_1 to i256*
  %106 = load i256, i256* %105
  %107 = trunc i256 %106 to i254
  %108 = lshr i254 %107, 75
  %_122.partselect = trunc i254 %108 to i32
  br label %src.addr.620.exit

src.addr.620.case.2:                              ; preds = %src.addr.518.exit
  %109 = bitcast i254* %src_2 to i256*
  %110 = load i256, i256* %109
  %111 = trunc i256 %110 to i254
  %112 = lshr i254 %111, 75
  %_223.partselect = trunc i254 %112 to i32
  br label %src.addr.620.exit

src.addr.620.case.3:                              ; preds = %src.addr.518.exit
  %113 = bitcast i254* %src_3 to i256*
  %114 = load i256, i256* %113
  %115 = trunc i256 %114 to i254
  %116 = lshr i254 %115, 75
  %_324.partselect = trunc i254 %116 to i32
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.3, %src.addr.620.case.2, %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %117 = phi i32 [ %_021.partselect, %src.addr.620.case.0 ], [ %_122.partselect, %src.addr.620.case.1 ], [ %_223.partselect, %src.addr.620.case.2 ], [ %_324.partselect, %src.addr.620.case.3 ], [ undef, %src.addr.518.exit ]
  store i32 %117, i32* %dst.addr.621, align 4
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 7
  switch i64 %for.loop.idx103, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
    i64 2, label %src.addr.722.case.2
    i64 3, label %src.addr.722.case.3
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %118 = bitcast i254* %src_0 to i256*
  %119 = load i256, i256* %118
  %120 = trunc i256 %119 to i254
  %121 = lshr i254 %120, 107
  %_025.partselect = trunc i254 %121 to i32
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %122 = bitcast i254* %src_1 to i256*
  %123 = load i256, i256* %122
  %124 = trunc i256 %123 to i254
  %125 = lshr i254 %124, 107
  %_126.partselect = trunc i254 %125 to i32
  br label %src.addr.722.exit

src.addr.722.case.2:                              ; preds = %src.addr.620.exit
  %126 = bitcast i254* %src_2 to i256*
  %127 = load i256, i256* %126
  %128 = trunc i256 %127 to i254
  %129 = lshr i254 %128, 107
  %_227.partselect = trunc i254 %129 to i32
  br label %src.addr.722.exit

src.addr.722.case.3:                              ; preds = %src.addr.620.exit
  %130 = bitcast i254* %src_3 to i256*
  %131 = load i256, i256* %130
  %132 = trunc i256 %131 to i254
  %133 = lshr i254 %132, 107
  %_328.partselect = trunc i254 %133 to i32
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.3, %src.addr.722.case.2, %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %134 = phi i32 [ %_025.partselect, %src.addr.722.case.0 ], [ %_126.partselect, %src.addr.722.case.1 ], [ %_227.partselect, %src.addr.722.case.2 ], [ %_328.partselect, %src.addr.722.case.3 ], [ undef, %src.addr.620.exit ]
  store i32 %134, i32* %dst.addr.723, align 4
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 8
  switch i64 %for.loop.idx103, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
    i64 2, label %src.addr.824.case.2
    i64 3, label %src.addr.824.case.3
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %135 = bitcast i254* %src_0 to i256*
  %136 = load i256, i256* %135
  %137 = trunc i256 %136 to i254
  %138 = lshr i254 %137, 139
  %_029.partselect = trunc i254 %138 to i8
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %139 = bitcast i254* %src_1 to i256*
  %140 = load i256, i256* %139
  %141 = trunc i256 %140 to i254
  %142 = lshr i254 %141, 139
  %_130.partselect = trunc i254 %142 to i8
  br label %src.addr.824.exit

src.addr.824.case.2:                              ; preds = %src.addr.722.exit
  %143 = bitcast i254* %src_2 to i256*
  %144 = load i256, i256* %143
  %145 = trunc i256 %144 to i254
  %146 = lshr i254 %145, 139
  %_231.partselect = trunc i254 %146 to i8
  br label %src.addr.824.exit

src.addr.824.case.3:                              ; preds = %src.addr.722.exit
  %147 = bitcast i254* %src_3 to i256*
  %148 = load i256, i256* %147
  %149 = trunc i256 %148 to i254
  %150 = lshr i254 %149, 139
  %_332.partselect = trunc i254 %150 to i8
  br label %src.addr.824.exit

src.addr.824.exit:                                ; preds = %src.addr.824.case.3, %src.addr.824.case.2, %src.addr.824.case.1, %src.addr.824.case.0, %src.addr.722.exit
  %151 = phi i8 [ %_029.partselect, %src.addr.824.case.0 ], [ %_130.partselect, %src.addr.824.case.1 ], [ %_231.partselect, %src.addr.824.case.2 ], [ %_332.partselect, %src.addr.824.case.3 ], [ undef, %src.addr.722.exit ]
  store i8 %151, i8* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 9
  switch i64 %for.loop.idx103, label %src.addr.926.exit [
    i64 0, label %src.addr.926.case.0
    i64 1, label %src.addr.926.case.1
    i64 2, label %src.addr.926.case.2
    i64 3, label %src.addr.926.case.3
  ]

src.addr.926.case.0:                              ; preds = %src.addr.824.exit
  %152 = bitcast i254* %src_0 to i256*
  %153 = load i256, i256* %152
  %154 = trunc i256 %153 to i254
  %155 = lshr i254 %154, 147
  %_033.partselect = trunc i254 %155 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %156 = bitcast i254* %src_1 to i256*
  %157 = load i256, i256* %156
  %158 = trunc i256 %157 to i254
  %159 = lshr i254 %158, 147
  %_134.partselect = trunc i254 %159 to i1
  br label %src.addr.926.exit

src.addr.926.case.2:                              ; preds = %src.addr.824.exit
  %160 = bitcast i254* %src_2 to i256*
  %161 = load i256, i256* %160
  %162 = trunc i256 %161 to i254
  %163 = lshr i254 %162, 147
  %_235.partselect = trunc i254 %163 to i1
  br label %src.addr.926.exit

src.addr.926.case.3:                              ; preds = %src.addr.824.exit
  %164 = bitcast i254* %src_3 to i256*
  %165 = load i256, i256* %164
  %166 = trunc i256 %165 to i254
  %167 = lshr i254 %166, 147
  %_336.partselect = trunc i254 %167 to i1
  br label %src.addr.926.exit

src.addr.926.exit:                                ; preds = %src.addr.926.case.3, %src.addr.926.case.2, %src.addr.926.case.1, %src.addr.926.case.0, %src.addr.824.exit
  %168 = phi i1 [ %_033.partselect, %src.addr.926.case.0 ], [ %_134.partselect, %src.addr.926.case.1 ], [ %_235.partselect, %src.addr.926.case.2 ], [ %_336.partselect, %src.addr.926.case.3 ], [ undef, %src.addr.824.exit ]
  store i1 %168, i1* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 10
  switch i64 %for.loop.idx103, label %src.addr.1028.exit [
    i64 0, label %src.addr.1028.case.0
    i64 1, label %src.addr.1028.case.1
    i64 2, label %src.addr.1028.case.2
    i64 3, label %src.addr.1028.case.3
  ]

src.addr.1028.case.0:                             ; preds = %src.addr.926.exit
  %169 = bitcast i254* %src_0 to i256*
  %170 = load i256, i256* %169
  %171 = trunc i256 %170 to i254
  %172 = lshr i254 %171, 148
  %_037.partselect = trunc i254 %172 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %173 = bitcast i254* %src_1 to i256*
  %174 = load i256, i256* %173
  %175 = trunc i256 %174 to i254
  %176 = lshr i254 %175, 148
  %_138.partselect = trunc i254 %176 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.2:                             ; preds = %src.addr.926.exit
  %177 = bitcast i254* %src_2 to i256*
  %178 = load i256, i256* %177
  %179 = trunc i256 %178 to i254
  %180 = lshr i254 %179, 148
  %_239.partselect = trunc i254 %180 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.3:                             ; preds = %src.addr.926.exit
  %181 = bitcast i254* %src_3 to i256*
  %182 = load i256, i256* %181
  %183 = trunc i256 %182 to i254
  %184 = lshr i254 %183, 148
  %_340.partselect = trunc i254 %184 to i1
  br label %src.addr.1028.exit

src.addr.1028.exit:                               ; preds = %src.addr.1028.case.3, %src.addr.1028.case.2, %src.addr.1028.case.1, %src.addr.1028.case.0, %src.addr.926.exit
  %185 = phi i1 [ %_037.partselect, %src.addr.1028.case.0 ], [ %_138.partselect, %src.addr.1028.case.1 ], [ %_239.partselect, %src.addr.1028.case.2 ], [ %_340.partselect, %src.addr.1028.case.3 ], [ undef, %src.addr.926.exit ]
  store i1 %185, i1* %dst.addr.1029, align 1
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 11
  switch i64 %for.loop.idx103, label %src.addr.1130.exit [
    i64 0, label %src.addr.1130.case.0
    i64 1, label %src.addr.1130.case.1
    i64 2, label %src.addr.1130.case.2
    i64 3, label %src.addr.1130.case.3
  ]

src.addr.1130.case.0:                             ; preds = %src.addr.1028.exit
  %186 = bitcast i254* %src_0 to i256*
  %187 = load i256, i256* %186
  %188 = trunc i256 %187 to i254
  %189 = lshr i254 %188, 149
  %_041.partselect = trunc i254 %189 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %190 = bitcast i254* %src_1 to i256*
  %191 = load i256, i256* %190
  %192 = trunc i256 %191 to i254
  %193 = lshr i254 %192, 149
  %_142.partselect = trunc i254 %193 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.2:                             ; preds = %src.addr.1028.exit
  %194 = bitcast i254* %src_2 to i256*
  %195 = load i256, i256* %194
  %196 = trunc i256 %195 to i254
  %197 = lshr i254 %196, 149
  %_243.partselect = trunc i254 %197 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.3:                             ; preds = %src.addr.1028.exit
  %198 = bitcast i254* %src_3 to i256*
  %199 = load i256, i256* %198
  %200 = trunc i256 %199 to i254
  %201 = lshr i254 %200, 149
  %_344.partselect = trunc i254 %201 to i8
  br label %src.addr.1130.exit

src.addr.1130.exit:                               ; preds = %src.addr.1130.case.3, %src.addr.1130.case.2, %src.addr.1130.case.1, %src.addr.1130.case.0, %src.addr.1028.exit
  %202 = phi i8 [ %_041.partselect, %src.addr.1130.case.0 ], [ %_142.partselect, %src.addr.1130.case.1 ], [ %_243.partselect, %src.addr.1130.case.2 ], [ %_344.partselect, %src.addr.1130.case.3 ], [ undef, %src.addr.1028.exit ]
  store i8 %202, i8* %dst.addr.1131, align 1
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 12
  switch i64 %for.loop.idx103, label %src.addr.1232.exit [
    i64 0, label %src.addr.1232.case.0
    i64 1, label %src.addr.1232.case.1
    i64 2, label %src.addr.1232.case.2
    i64 3, label %src.addr.1232.case.3
  ]

src.addr.1232.case.0:                             ; preds = %src.addr.1130.exit
  %203 = bitcast i254* %src_0 to i256*
  %204 = load i256, i256* %203
  %205 = trunc i256 %204 to i254
  %206 = lshr i254 %205, 157
  %_045.partselect = trunc i254 %206 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %207 = bitcast i254* %src_1 to i256*
  %208 = load i256, i256* %207
  %209 = trunc i256 %208 to i254
  %210 = lshr i254 %209, 157
  %_146.partselect = trunc i254 %210 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.2:                             ; preds = %src.addr.1130.exit
  %211 = bitcast i254* %src_2 to i256*
  %212 = load i256, i256* %211
  %213 = trunc i256 %212 to i254
  %214 = lshr i254 %213, 157
  %_247.partselect = trunc i254 %214 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.3:                             ; preds = %src.addr.1130.exit
  %215 = bitcast i254* %src_3 to i256*
  %216 = load i256, i256* %215
  %217 = trunc i256 %216 to i254
  %218 = lshr i254 %217, 157
  %_348.partselect = trunc i254 %218 to i32
  br label %src.addr.1232.exit

src.addr.1232.exit:                               ; preds = %src.addr.1232.case.3, %src.addr.1232.case.2, %src.addr.1232.case.1, %src.addr.1232.case.0, %src.addr.1130.exit
  %219 = phi i32 [ %_045.partselect, %src.addr.1232.case.0 ], [ %_146.partselect, %src.addr.1232.case.1 ], [ %_247.partselect, %src.addr.1232.case.2 ], [ %_348.partselect, %src.addr.1232.case.3 ], [ undef, %src.addr.1130.exit ]
  store i32 %219, i32* %dst.addr.1233, align 4
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 13
  switch i64 %for.loop.idx103, label %src.addr.1334.exit [
    i64 0, label %src.addr.1334.case.0
    i64 1, label %src.addr.1334.case.1
    i64 2, label %src.addr.1334.case.2
    i64 3, label %src.addr.1334.case.3
  ]

src.addr.1334.case.0:                             ; preds = %src.addr.1232.exit
  %220 = bitcast i254* %src_0 to i256*
  %221 = load i256, i256* %220
  %222 = trunc i256 %221 to i254
  %223 = lshr i254 %222, 189
  %_049.partselect = trunc i254 %223 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %224 = bitcast i254* %src_1 to i256*
  %225 = load i256, i256* %224
  %226 = trunc i256 %225 to i254
  %227 = lshr i254 %226, 189
  %_150.partselect = trunc i254 %227 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.2:                             ; preds = %src.addr.1232.exit
  %228 = bitcast i254* %src_2 to i256*
  %229 = load i256, i256* %228
  %230 = trunc i256 %229 to i254
  %231 = lshr i254 %230, 189
  %_251.partselect = trunc i254 %231 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.3:                             ; preds = %src.addr.1232.exit
  %232 = bitcast i254* %src_3 to i256*
  %233 = load i256, i256* %232
  %234 = trunc i256 %233 to i254
  %235 = lshr i254 %234, 189
  %_352.partselect = trunc i254 %235 to i32
  br label %src.addr.1334.exit

src.addr.1334.exit:                               ; preds = %src.addr.1334.case.3, %src.addr.1334.case.2, %src.addr.1334.case.1, %src.addr.1334.case.0, %src.addr.1232.exit
  %236 = phi i32 [ %_049.partselect, %src.addr.1334.case.0 ], [ %_150.partselect, %src.addr.1334.case.1 ], [ %_251.partselect, %src.addr.1334.case.2 ], [ %_352.partselect, %src.addr.1334.case.3 ], [ undef, %src.addr.1232.exit ]
  store i32 %236, i32* %dst.addr.1335, align 4
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 14
  switch i64 %for.loop.idx103, label %src.addr.1436.exit [
    i64 0, label %src.addr.1436.case.0
    i64 1, label %src.addr.1436.case.1
    i64 2, label %src.addr.1436.case.2
    i64 3, label %src.addr.1436.case.3
  ]

src.addr.1436.case.0:                             ; preds = %src.addr.1334.exit
  %237 = bitcast i254* %src_0 to i256*
  %238 = load i256, i256* %237
  %239 = trunc i256 %238 to i254
  %240 = lshr i254 %239, 221
  %_053.partselect = trunc i254 %240 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %241 = bitcast i254* %src_1 to i256*
  %242 = load i256, i256* %241
  %243 = trunc i256 %242 to i254
  %244 = lshr i254 %243, 221
  %_154.partselect = trunc i254 %244 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.2:                             ; preds = %src.addr.1334.exit
  %245 = bitcast i254* %src_2 to i256*
  %246 = load i256, i256* %245
  %247 = trunc i256 %246 to i254
  %248 = lshr i254 %247, 221
  %_255.partselect = trunc i254 %248 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.3:                             ; preds = %src.addr.1334.exit
  %249 = bitcast i254* %src_3 to i256*
  %250 = load i256, i256* %249
  %251 = trunc i256 %250 to i254
  %252 = lshr i254 %251, 221
  %_356.partselect = trunc i254 %252 to i1
  br label %src.addr.1436.exit

src.addr.1436.exit:                               ; preds = %src.addr.1436.case.3, %src.addr.1436.case.2, %src.addr.1436.case.1, %src.addr.1436.case.0, %src.addr.1334.exit
  %253 = phi i1 [ %_053.partselect, %src.addr.1436.case.0 ], [ %_154.partselect, %src.addr.1436.case.1 ], [ %_255.partselect, %src.addr.1436.case.2 ], [ %_356.partselect, %src.addr.1436.case.3 ], [ undef, %src.addr.1334.exit ]
  store i1 %253, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 15
  switch i64 %for.loop.idx103, label %src.addr.1538.exit [
    i64 0, label %src.addr.1538.case.0
    i64 1, label %src.addr.1538.case.1
    i64 2, label %src.addr.1538.case.2
    i64 3, label %src.addr.1538.case.3
  ]

src.addr.1538.case.0:                             ; preds = %src.addr.1436.exit
  %254 = bitcast i254* %src_0 to i256*
  %255 = load i256, i256* %254
  %256 = trunc i256 %255 to i254
  %257 = lshr i254 %256, 222
  %_057.partselect = trunc i254 %257 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %258 = bitcast i254* %src_1 to i256*
  %259 = load i256, i256* %258
  %260 = trunc i256 %259 to i254
  %261 = lshr i254 %260, 222
  %_158.partselect = trunc i254 %261 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.2:                             ; preds = %src.addr.1436.exit
  %262 = bitcast i254* %src_2 to i256*
  %263 = load i256, i256* %262
  %264 = trunc i256 %263 to i254
  %265 = lshr i254 %264, 222
  %_259.partselect = trunc i254 %265 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.3:                             ; preds = %src.addr.1436.exit
  %266 = bitcast i254* %src_3 to i256*
  %267 = load i256, i256* %266
  %268 = trunc i256 %267 to i254
  %269 = lshr i254 %268, 222
  %_360.partselect = trunc i254 %269 to i1
  br label %src.addr.1538.exit

src.addr.1538.exit:                               ; preds = %src.addr.1538.case.3, %src.addr.1538.case.2, %src.addr.1538.case.1, %src.addr.1538.case.0, %src.addr.1436.exit
  %270 = phi i1 [ %_057.partselect, %src.addr.1538.case.0 ], [ %_158.partselect, %src.addr.1538.case.1 ], [ %_259.partselect, %src.addr.1538.case.2 ], [ %_360.partselect, %src.addr.1538.case.3 ], [ undef, %src.addr.1436.exit ]
  store i1 %270, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 16
  switch i64 %for.loop.idx103, label %src.addr.1640.exit [
    i64 0, label %src.addr.1640.case.0
    i64 1, label %src.addr.1640.case.1
    i64 2, label %src.addr.1640.case.2
    i64 3, label %src.addr.1640.case.3
  ]

src.addr.1640.case.0:                             ; preds = %src.addr.1538.exit
  %271 = bitcast i254* %src_0 to i256*
  %272 = load i256, i256* %271
  %273 = trunc i256 %272 to i254
  %274 = lshr i254 %273, 223
  %_061.partselect = trunc i254 %274 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %275 = bitcast i254* %src_1 to i256*
  %276 = load i256, i256* %275
  %277 = trunc i256 %276 to i254
  %278 = lshr i254 %277, 223
  %_162.partselect = trunc i254 %278 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.2:                             ; preds = %src.addr.1538.exit
  %279 = bitcast i254* %src_2 to i256*
  %280 = load i256, i256* %279
  %281 = trunc i256 %280 to i254
  %282 = lshr i254 %281, 223
  %_263.partselect = trunc i254 %282 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.3:                             ; preds = %src.addr.1538.exit
  %283 = bitcast i254* %src_3 to i256*
  %284 = load i256, i256* %283
  %285 = trunc i256 %284 to i254
  %286 = lshr i254 %285, 223
  %_364.partselect = trunc i254 %286 to i1
  br label %src.addr.1640.exit

src.addr.1640.exit:                               ; preds = %src.addr.1640.case.3, %src.addr.1640.case.2, %src.addr.1640.case.1, %src.addr.1640.case.0, %src.addr.1538.exit
  %287 = phi i1 [ %_061.partselect, %src.addr.1640.case.0 ], [ %_162.partselect, %src.addr.1640.case.1 ], [ %_263.partselect, %src.addr.1640.case.2 ], [ %_364.partselect, %src.addr.1640.case.3 ], [ undef, %src.addr.1538.exit ]
  store i1 %287, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 17
  switch i64 %for.loop.idx103, label %src.addr.1742.exit [
    i64 0, label %src.addr.1742.case.0
    i64 1, label %src.addr.1742.case.1
    i64 2, label %src.addr.1742.case.2
    i64 3, label %src.addr.1742.case.3
  ]

src.addr.1742.case.0:                             ; preds = %src.addr.1640.exit
  %288 = bitcast i254* %src_0 to i256*
  %289 = load i256, i256* %288
  %290 = trunc i256 %289 to i254
  %291 = lshr i254 %290, 224
  %_065.partselect = trunc i254 %291 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %292 = bitcast i254* %src_1 to i256*
  %293 = load i256, i256* %292
  %294 = trunc i256 %293 to i254
  %295 = lshr i254 %294, 224
  %_166.partselect = trunc i254 %295 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.2:                             ; preds = %src.addr.1640.exit
  %296 = bitcast i254* %src_2 to i256*
  %297 = load i256, i256* %296
  %298 = trunc i256 %297 to i254
  %299 = lshr i254 %298, 224
  %_267.partselect = trunc i254 %299 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.3:                             ; preds = %src.addr.1640.exit
  %300 = bitcast i254* %src_3 to i256*
  %301 = load i256, i256* %300
  %302 = trunc i256 %301 to i254
  %303 = lshr i254 %302, 224
  %_368.partselect = trunc i254 %303 to i1
  br label %src.addr.1742.exit

src.addr.1742.exit:                               ; preds = %src.addr.1742.case.3, %src.addr.1742.case.2, %src.addr.1742.case.1, %src.addr.1742.case.0, %src.addr.1640.exit
  %304 = phi i1 [ %_065.partselect, %src.addr.1742.case.0 ], [ %_166.partselect, %src.addr.1742.case.1 ], [ %_267.partselect, %src.addr.1742.case.2 ], [ %_368.partselect, %src.addr.1742.case.3 ], [ undef, %src.addr.1640.exit ]
  store i1 %304, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 18
  switch i64 %for.loop.idx103, label %src.addr.1844.exit [
    i64 0, label %src.addr.1844.case.0
    i64 1, label %src.addr.1844.case.1
    i64 2, label %src.addr.1844.case.2
    i64 3, label %src.addr.1844.case.3
  ]

src.addr.1844.case.0:                             ; preds = %src.addr.1742.exit
  %305 = bitcast i254* %src_0 to i256*
  %306 = load i256, i256* %305
  %307 = trunc i256 %306 to i254
  %308 = lshr i254 %307, 225
  %_069.partselect = trunc i254 %308 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %309 = bitcast i254* %src_1 to i256*
  %310 = load i256, i256* %309
  %311 = trunc i256 %310 to i254
  %312 = lshr i254 %311, 225
  %_170.partselect = trunc i254 %312 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.2:                             ; preds = %src.addr.1742.exit
  %313 = bitcast i254* %src_2 to i256*
  %314 = load i256, i256* %313
  %315 = trunc i256 %314 to i254
  %316 = lshr i254 %315, 225
  %_271.partselect = trunc i254 %316 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.3:                             ; preds = %src.addr.1742.exit
  %317 = bitcast i254* %src_3 to i256*
  %318 = load i256, i256* %317
  %319 = trunc i256 %318 to i254
  %320 = lshr i254 %319, 225
  %_372.partselect = trunc i254 %320 to i1
  br label %src.addr.1844.exit

src.addr.1844.exit:                               ; preds = %src.addr.1844.case.3, %src.addr.1844.case.2, %src.addr.1844.case.1, %src.addr.1844.case.0, %src.addr.1742.exit
  %321 = phi i1 [ %_069.partselect, %src.addr.1844.case.0 ], [ %_170.partselect, %src.addr.1844.case.1 ], [ %_271.partselect, %src.addr.1844.case.2 ], [ %_372.partselect, %src.addr.1844.case.3 ], [ undef, %src.addr.1742.exit ]
  store i1 %321, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 19
  switch i64 %for.loop.idx103, label %src.addr.1946.exit [
    i64 0, label %src.addr.1946.case.0
    i64 1, label %src.addr.1946.case.1
    i64 2, label %src.addr.1946.case.2
    i64 3, label %src.addr.1946.case.3
  ]

src.addr.1946.case.0:                             ; preds = %src.addr.1844.exit
  %322 = bitcast i254* %src_0 to i256*
  %323 = load i256, i256* %322
  %324 = trunc i256 %323 to i254
  %325 = lshr i254 %324, 226
  %_073.partselect = trunc i254 %325 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %326 = bitcast i254* %src_1 to i256*
  %327 = load i256, i256* %326
  %328 = trunc i256 %327 to i254
  %329 = lshr i254 %328, 226
  %_174.partselect = trunc i254 %329 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.2:                             ; preds = %src.addr.1844.exit
  %330 = bitcast i254* %src_2 to i256*
  %331 = load i256, i256* %330
  %332 = trunc i256 %331 to i254
  %333 = lshr i254 %332, 226
  %_275.partselect = trunc i254 %333 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.3:                             ; preds = %src.addr.1844.exit
  %334 = bitcast i254* %src_3 to i256*
  %335 = load i256, i256* %334
  %336 = trunc i256 %335 to i254
  %337 = lshr i254 %336, 226
  %_376.partselect = trunc i254 %337 to i1
  br label %src.addr.1946.exit

src.addr.1946.exit:                               ; preds = %src.addr.1946.case.3, %src.addr.1946.case.2, %src.addr.1946.case.1, %src.addr.1946.case.0, %src.addr.1844.exit
  %338 = phi i1 [ %_073.partselect, %src.addr.1946.case.0 ], [ %_174.partselect, %src.addr.1946.case.1 ], [ %_275.partselect, %src.addr.1946.case.2 ], [ %_376.partselect, %src.addr.1946.case.3 ], [ undef, %src.addr.1844.exit ]
  store i1 %338, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 20
  switch i64 %for.loop.idx103, label %src.addr.2048.exit [
    i64 0, label %src.addr.2048.case.0
    i64 1, label %src.addr.2048.case.1
    i64 2, label %src.addr.2048.case.2
    i64 3, label %src.addr.2048.case.3
  ]

src.addr.2048.case.0:                             ; preds = %src.addr.1946.exit
  %339 = bitcast i254* %src_0 to i256*
  %340 = load i256, i256* %339
  %341 = trunc i256 %340 to i254
  %342 = lshr i254 %341, 227
  %_077.partselect = trunc i254 %342 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %343 = bitcast i254* %src_1 to i256*
  %344 = load i256, i256* %343
  %345 = trunc i256 %344 to i254
  %346 = lshr i254 %345, 227
  %_178.partselect = trunc i254 %346 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.2:                             ; preds = %src.addr.1946.exit
  %347 = bitcast i254* %src_2 to i256*
  %348 = load i256, i256* %347
  %349 = trunc i256 %348 to i254
  %350 = lshr i254 %349, 227
  %_279.partselect = trunc i254 %350 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.3:                             ; preds = %src.addr.1946.exit
  %351 = bitcast i254* %src_3 to i256*
  %352 = load i256, i256* %351
  %353 = trunc i256 %352 to i254
  %354 = lshr i254 %353, 227
  %_380.partselect = trunc i254 %354 to i1
  br label %src.addr.2048.exit

src.addr.2048.exit:                               ; preds = %src.addr.2048.case.3, %src.addr.2048.case.2, %src.addr.2048.case.1, %src.addr.2048.case.0, %src.addr.1946.exit
  %355 = phi i1 [ %_077.partselect, %src.addr.2048.case.0 ], [ %_178.partselect, %src.addr.2048.case.1 ], [ %_279.partselect, %src.addr.2048.case.2 ], [ %_380.partselect, %src.addr.2048.case.3 ], [ undef, %src.addr.1946.exit ]
  store i1 %355, i1* %dst.addr.2049, align 1
  %dst.addr.2151 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 21
  switch i64 %for.loop.idx103, label %src.addr.2150.exit [
    i64 0, label %src.addr.2150.case.0
    i64 1, label %src.addr.2150.case.1
    i64 2, label %src.addr.2150.case.2
    i64 3, label %src.addr.2150.case.3
  ]

src.addr.2150.case.0:                             ; preds = %src.addr.2048.exit
  %356 = bitcast i254* %src_0 to i256*
  %357 = load i256, i256* %356
  %358 = trunc i256 %357 to i254
  %359 = lshr i254 %358, 228
  %_081.partselect = trunc i254 %359 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.1:                             ; preds = %src.addr.2048.exit
  %360 = bitcast i254* %src_1 to i256*
  %361 = load i256, i256* %360
  %362 = trunc i256 %361 to i254
  %363 = lshr i254 %362, 228
  %_182.partselect = trunc i254 %363 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.2:                             ; preds = %src.addr.2048.exit
  %364 = bitcast i254* %src_2 to i256*
  %365 = load i256, i256* %364
  %366 = trunc i256 %365 to i254
  %367 = lshr i254 %366, 228
  %_283.partselect = trunc i254 %367 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.3:                             ; preds = %src.addr.2048.exit
  %368 = bitcast i254* %src_3 to i256*
  %369 = load i256, i256* %368
  %370 = trunc i256 %369 to i254
  %371 = lshr i254 %370, 228
  %_384.partselect = trunc i254 %371 to i1
  br label %src.addr.2150.exit

src.addr.2150.exit:                               ; preds = %src.addr.2150.case.3, %src.addr.2150.case.2, %src.addr.2150.case.1, %src.addr.2150.case.0, %src.addr.2048.exit
  %372 = phi i1 [ %_081.partselect, %src.addr.2150.case.0 ], [ %_182.partselect, %src.addr.2150.case.1 ], [ %_283.partselect, %src.addr.2150.case.2 ], [ %_384.partselect, %src.addr.2150.case.3 ], [ undef, %src.addr.2048.exit ]
  store i1 %372, i1* %dst.addr.2151, align 1
  %dst.addr.2253 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 22
  switch i64 %for.loop.idx103, label %src.addr.2252.exit [
    i64 0, label %src.addr.2252.case.0
    i64 1, label %src.addr.2252.case.1
    i64 2, label %src.addr.2252.case.2
    i64 3, label %src.addr.2252.case.3
  ]

src.addr.2252.case.0:                             ; preds = %src.addr.2150.exit
  %373 = bitcast i254* %src_0 to i256*
  %374 = load i256, i256* %373
  %375 = trunc i256 %374 to i254
  %376 = lshr i254 %375, 229
  %_085.partselect = trunc i254 %376 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.1:                             ; preds = %src.addr.2150.exit
  %377 = bitcast i254* %src_1 to i256*
  %378 = load i256, i256* %377
  %379 = trunc i256 %378 to i254
  %380 = lshr i254 %379, 229
  %_186.partselect = trunc i254 %380 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.2:                             ; preds = %src.addr.2150.exit
  %381 = bitcast i254* %src_2 to i256*
  %382 = load i256, i256* %381
  %383 = trunc i256 %382 to i254
  %384 = lshr i254 %383, 229
  %_287.partselect = trunc i254 %384 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.3:                             ; preds = %src.addr.2150.exit
  %385 = bitcast i254* %src_3 to i256*
  %386 = load i256, i256* %385
  %387 = trunc i256 %386 to i254
  %388 = lshr i254 %387, 229
  %_388.partselect = trunc i254 %388 to i1
  br label %src.addr.2252.exit

src.addr.2252.exit:                               ; preds = %src.addr.2252.case.3, %src.addr.2252.case.2, %src.addr.2252.case.1, %src.addr.2252.case.0, %src.addr.2150.exit
  %389 = phi i1 [ %_085.partselect, %src.addr.2252.case.0 ], [ %_186.partselect, %src.addr.2252.case.1 ], [ %_287.partselect, %src.addr.2252.case.2 ], [ %_388.partselect, %src.addr.2252.case.3 ], [ undef, %src.addr.2150.exit ]
  store i1 %389, i1* %dst.addr.2253, align 1
  %dst.addr.2355 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 23
  switch i64 %for.loop.idx103, label %src.addr.2354.exit [
    i64 0, label %src.addr.2354.case.0
    i64 1, label %src.addr.2354.case.1
    i64 2, label %src.addr.2354.case.2
    i64 3, label %src.addr.2354.case.3
  ]

src.addr.2354.case.0:                             ; preds = %src.addr.2252.exit
  %390 = bitcast i254* %src_0 to i256*
  %391 = load i256, i256* %390
  %392 = trunc i256 %391 to i254
  %393 = lshr i254 %392, 230
  %_089.partselect = trunc i254 %393 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.1:                             ; preds = %src.addr.2252.exit
  %394 = bitcast i254* %src_1 to i256*
  %395 = load i256, i256* %394
  %396 = trunc i256 %395 to i254
  %397 = lshr i254 %396, 230
  %_190.partselect = trunc i254 %397 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.2:                             ; preds = %src.addr.2252.exit
  %398 = bitcast i254* %src_2 to i256*
  %399 = load i256, i256* %398
  %400 = trunc i256 %399 to i254
  %401 = lshr i254 %400, 230
  %_291.partselect = trunc i254 %401 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.3:                             ; preds = %src.addr.2252.exit
  %402 = bitcast i254* %src_3 to i256*
  %403 = load i256, i256* %402
  %404 = trunc i256 %403 to i254
  %405 = lshr i254 %404, 230
  %_392.partselect = trunc i254 %405 to i1
  br label %src.addr.2354.exit

src.addr.2354.exit:                               ; preds = %src.addr.2354.case.3, %src.addr.2354.case.2, %src.addr.2354.case.1, %src.addr.2354.case.0, %src.addr.2252.exit
  %406 = phi i1 [ %_089.partselect, %src.addr.2354.case.0 ], [ %_190.partselect, %src.addr.2354.case.1 ], [ %_291.partselect, %src.addr.2354.case.2 ], [ %_392.partselect, %src.addr.2354.case.3 ], [ undef, %src.addr.2252.exit ]
  store i1 %406, i1* %dst.addr.2355, align 1
  %dst.addr.2457 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 24
  switch i64 %for.loop.idx103, label %src.addr.2456.exit [
    i64 0, label %src.addr.2456.case.0
    i64 1, label %src.addr.2456.case.1
    i64 2, label %src.addr.2456.case.2
    i64 3, label %src.addr.2456.case.3
  ]

src.addr.2456.case.0:                             ; preds = %src.addr.2354.exit
  %407 = bitcast i254* %src_0 to i256*
  %408 = load i256, i256* %407
  %409 = trunc i256 %408 to i254
  %410 = lshr i254 %409, 231
  %_093.partselect = trunc i254 %410 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.1:                             ; preds = %src.addr.2354.exit
  %411 = bitcast i254* %src_1 to i256*
  %412 = load i256, i256* %411
  %413 = trunc i256 %412 to i254
  %414 = lshr i254 %413, 231
  %_194.partselect = trunc i254 %414 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.2:                             ; preds = %src.addr.2354.exit
  %415 = bitcast i254* %src_2 to i256*
  %416 = load i256, i256* %415
  %417 = trunc i256 %416 to i254
  %418 = lshr i254 %417, 231
  %_295.partselect = trunc i254 %418 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.3:                             ; preds = %src.addr.2354.exit
  %419 = bitcast i254* %src_3 to i256*
  %420 = load i256, i256* %419
  %421 = trunc i256 %420 to i254
  %422 = lshr i254 %421, 231
  %_396.partselect = trunc i254 %422 to i1
  br label %src.addr.2456.exit

src.addr.2456.exit:                               ; preds = %src.addr.2456.case.3, %src.addr.2456.case.2, %src.addr.2456.case.1, %src.addr.2456.case.0, %src.addr.2354.exit
  %423 = phi i1 [ %_093.partselect, %src.addr.2456.case.0 ], [ %_194.partselect, %src.addr.2456.case.1 ], [ %_295.partselect, %src.addr.2456.case.2 ], [ %_396.partselect, %src.addr.2456.case.3 ], [ undef, %src.addr.2354.exit ]
  store i1 %423, i1* %dst.addr.2457, align 1
  %dst.addr.2559 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 25
  switch i64 %for.loop.idx103, label %src.addr.2558.exit [
    i64 0, label %src.addr.2558.case.0
    i64 1, label %src.addr.2558.case.1
    i64 2, label %src.addr.2558.case.2
    i64 3, label %src.addr.2558.case.3
  ]

src.addr.2558.case.0:                             ; preds = %src.addr.2456.exit
  %424 = bitcast i254* %src_0 to i256*
  %425 = load i256, i256* %424
  %426 = trunc i256 %425 to i254
  %427 = lshr i254 %426, 232
  %_097.partselect = trunc i254 %427 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.1:                             ; preds = %src.addr.2456.exit
  %428 = bitcast i254* %src_1 to i256*
  %429 = load i256, i256* %428
  %430 = trunc i256 %429 to i254
  %431 = lshr i254 %430, 232
  %_198.partselect = trunc i254 %431 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.2:                             ; preds = %src.addr.2456.exit
  %432 = bitcast i254* %src_2 to i256*
  %433 = load i256, i256* %432
  %434 = trunc i256 %433 to i254
  %435 = lshr i254 %434, 232
  %_299.partselect = trunc i254 %435 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.3:                             ; preds = %src.addr.2456.exit
  %436 = bitcast i254* %src_3 to i256*
  %437 = load i256, i256* %436
  %438 = trunc i256 %437 to i254
  %439 = lshr i254 %438, 232
  %_3100.partselect = trunc i254 %439 to i1
  br label %src.addr.2558.exit

src.addr.2558.exit:                               ; preds = %src.addr.2558.case.3, %src.addr.2558.case.2, %src.addr.2558.case.1, %src.addr.2558.case.0, %src.addr.2456.exit
  %440 = phi i1 [ %_097.partselect, %src.addr.2558.case.0 ], [ %_198.partselect, %src.addr.2558.case.1 ], [ %_299.partselect, %src.addr.2558.case.2 ], [ %_3100.partselect, %src.addr.2558.case.3 ], [ undef, %src.addr.2456.exit ]
  store i1 %440, i1* %dst.addr.2559, align 1
  %dst.addr.2661 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 26
  switch i64 %for.loop.idx103, label %src.addr.2660.exit [
    i64 0, label %src.addr.2660.case.0
    i64 1, label %src.addr.2660.case.1
    i64 2, label %src.addr.2660.case.2
    i64 3, label %src.addr.2660.case.3
  ]

src.addr.2660.case.0:                             ; preds = %src.addr.2558.exit
  %441 = bitcast i254* %src_0 to i256*
  %442 = load i256, i256* %441
  %443 = trunc i256 %442 to i254
  %444 = lshr i254 %443, 233
  %_0101.partselect = trunc i254 %444 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.1:                             ; preds = %src.addr.2558.exit
  %445 = bitcast i254* %src_1 to i256*
  %446 = load i256, i256* %445
  %447 = trunc i256 %446 to i254
  %448 = lshr i254 %447, 233
  %_1102.partselect = trunc i254 %448 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.2:                             ; preds = %src.addr.2558.exit
  %449 = bitcast i254* %src_2 to i256*
  %450 = load i256, i256* %449
  %451 = trunc i256 %450 to i254
  %452 = lshr i254 %451, 233
  %_2103.partselect = trunc i254 %452 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.3:                             ; preds = %src.addr.2558.exit
  %453 = bitcast i254* %src_3 to i256*
  %454 = load i256, i256* %453
  %455 = trunc i256 %454 to i254
  %456 = lshr i254 %455, 233
  %_3104.partselect = trunc i254 %456 to i1
  br label %src.addr.2660.exit

src.addr.2660.exit:                               ; preds = %src.addr.2660.case.3, %src.addr.2660.case.2, %src.addr.2660.case.1, %src.addr.2660.case.0, %src.addr.2558.exit
  %457 = phi i1 [ %_0101.partselect, %src.addr.2660.case.0 ], [ %_1102.partselect, %src.addr.2660.case.1 ], [ %_2103.partselect, %src.addr.2660.case.2 ], [ %_3104.partselect, %src.addr.2660.case.3 ], [ undef, %src.addr.2558.exit ]
  store i1 %457, i1* %dst.addr.2661, align 1
  %dst.addr.2763 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 27
  switch i64 %for.loop.idx103, label %src.addr.2762.exit [
    i64 0, label %src.addr.2762.case.0
    i64 1, label %src.addr.2762.case.1
    i64 2, label %src.addr.2762.case.2
    i64 3, label %src.addr.2762.case.3
  ]

src.addr.2762.case.0:                             ; preds = %src.addr.2660.exit
  %458 = bitcast i254* %src_0 to i256*
  %459 = load i256, i256* %458
  %460 = trunc i256 %459 to i254
  %461 = lshr i254 %460, 234
  %_0105.partselect = trunc i254 %461 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.1:                             ; preds = %src.addr.2660.exit
  %462 = bitcast i254* %src_1 to i256*
  %463 = load i256, i256* %462
  %464 = trunc i256 %463 to i254
  %465 = lshr i254 %464, 234
  %_1106.partselect = trunc i254 %465 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.2:                             ; preds = %src.addr.2660.exit
  %466 = bitcast i254* %src_2 to i256*
  %467 = load i256, i256* %466
  %468 = trunc i256 %467 to i254
  %469 = lshr i254 %468, 234
  %_2107.partselect = trunc i254 %469 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.3:                             ; preds = %src.addr.2660.exit
  %470 = bitcast i254* %src_3 to i256*
  %471 = load i256, i256* %470
  %472 = trunc i256 %471 to i254
  %473 = lshr i254 %472, 234
  %_3108.partselect = trunc i254 %473 to i1
  br label %src.addr.2762.exit

src.addr.2762.exit:                               ; preds = %src.addr.2762.case.3, %src.addr.2762.case.2, %src.addr.2762.case.1, %src.addr.2762.case.0, %src.addr.2660.exit
  %474 = phi i1 [ %_0105.partselect, %src.addr.2762.case.0 ], [ %_1106.partselect, %src.addr.2762.case.1 ], [ %_2107.partselect, %src.addr.2762.case.2 ], [ %_3108.partselect, %src.addr.2762.case.3 ], [ undef, %src.addr.2660.exit ]
  store i1 %474, i1* %dst.addr.2763, align 1
  %dst.addr.2865 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 28
  switch i64 %for.loop.idx103, label %src.addr.2864.exit [
    i64 0, label %src.addr.2864.case.0
    i64 1, label %src.addr.2864.case.1
    i64 2, label %src.addr.2864.case.2
    i64 3, label %src.addr.2864.case.3
  ]

src.addr.2864.case.0:                             ; preds = %src.addr.2762.exit
  %475 = bitcast i254* %src_0 to i256*
  %476 = load i256, i256* %475
  %477 = trunc i256 %476 to i254
  %478 = lshr i254 %477, 235
  %_0109.partselect = trunc i254 %478 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.1:                             ; preds = %src.addr.2762.exit
  %479 = bitcast i254* %src_1 to i256*
  %480 = load i256, i256* %479
  %481 = trunc i256 %480 to i254
  %482 = lshr i254 %481, 235
  %_1110.partselect = trunc i254 %482 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.2:                             ; preds = %src.addr.2762.exit
  %483 = bitcast i254* %src_2 to i256*
  %484 = load i256, i256* %483
  %485 = trunc i256 %484 to i254
  %486 = lshr i254 %485, 235
  %_2111.partselect = trunc i254 %486 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.3:                             ; preds = %src.addr.2762.exit
  %487 = bitcast i254* %src_3 to i256*
  %488 = load i256, i256* %487
  %489 = trunc i256 %488 to i254
  %490 = lshr i254 %489, 235
  %_3112.partselect = trunc i254 %490 to i1
  br label %src.addr.2864.exit

src.addr.2864.exit:                               ; preds = %src.addr.2864.case.3, %src.addr.2864.case.2, %src.addr.2864.case.1, %src.addr.2864.case.0, %src.addr.2762.exit
  %491 = phi i1 [ %_0109.partselect, %src.addr.2864.case.0 ], [ %_1110.partselect, %src.addr.2864.case.1 ], [ %_2111.partselect, %src.addr.2864.case.2 ], [ %_3112.partselect, %src.addr.2864.case.3 ], [ undef, %src.addr.2762.exit ]
  store i1 %491, i1* %dst.addr.2865, align 1
  %dst.addr.2967 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 29
  switch i64 %for.loop.idx103, label %src.addr.2966.exit [
    i64 0, label %src.addr.2966.case.0
    i64 1, label %src.addr.2966.case.1
    i64 2, label %src.addr.2966.case.2
    i64 3, label %src.addr.2966.case.3
  ]

src.addr.2966.case.0:                             ; preds = %src.addr.2864.exit
  %492 = bitcast i254* %src_0 to i256*
  %493 = load i256, i256* %492
  %494 = trunc i256 %493 to i254
  %495 = lshr i254 %494, 236
  %_0113.partselect = trunc i254 %495 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.1:                             ; preds = %src.addr.2864.exit
  %496 = bitcast i254* %src_1 to i256*
  %497 = load i256, i256* %496
  %498 = trunc i256 %497 to i254
  %499 = lshr i254 %498, 236
  %_1114.partselect = trunc i254 %499 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.2:                             ; preds = %src.addr.2864.exit
  %500 = bitcast i254* %src_2 to i256*
  %501 = load i256, i256* %500
  %502 = trunc i256 %501 to i254
  %503 = lshr i254 %502, 236
  %_2115.partselect = trunc i254 %503 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.3:                             ; preds = %src.addr.2864.exit
  %504 = bitcast i254* %src_3 to i256*
  %505 = load i256, i256* %504
  %506 = trunc i256 %505 to i254
  %507 = lshr i254 %506, 236
  %_3116.partselect = trunc i254 %507 to i1
  br label %src.addr.2966.exit

src.addr.2966.exit:                               ; preds = %src.addr.2966.case.3, %src.addr.2966.case.2, %src.addr.2966.case.1, %src.addr.2966.case.0, %src.addr.2864.exit
  %508 = phi i1 [ %_0113.partselect, %src.addr.2966.case.0 ], [ %_1114.partselect, %src.addr.2966.case.1 ], [ %_2115.partselect, %src.addr.2966.case.2 ], [ %_3116.partselect, %src.addr.2966.case.3 ], [ undef, %src.addr.2864.exit ]
  store i1 %508, i1* %dst.addr.2967, align 1
  %dst.addr.3069 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 30
  switch i64 %for.loop.idx103, label %src.addr.3068.exit [
    i64 0, label %src.addr.3068.case.0
    i64 1, label %src.addr.3068.case.1
    i64 2, label %src.addr.3068.case.2
    i64 3, label %src.addr.3068.case.3
  ]

src.addr.3068.case.0:                             ; preds = %src.addr.2966.exit
  %509 = bitcast i254* %src_0 to i256*
  %510 = load i256, i256* %509
  %511 = trunc i256 %510 to i254
  %512 = lshr i254 %511, 237
  %_0117.partselect = trunc i254 %512 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.1:                             ; preds = %src.addr.2966.exit
  %513 = bitcast i254* %src_1 to i256*
  %514 = load i256, i256* %513
  %515 = trunc i256 %514 to i254
  %516 = lshr i254 %515, 237
  %_1118.partselect = trunc i254 %516 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.2:                             ; preds = %src.addr.2966.exit
  %517 = bitcast i254* %src_2 to i256*
  %518 = load i256, i256* %517
  %519 = trunc i256 %518 to i254
  %520 = lshr i254 %519, 237
  %_2119.partselect = trunc i254 %520 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.3:                             ; preds = %src.addr.2966.exit
  %521 = bitcast i254* %src_3 to i256*
  %522 = load i256, i256* %521
  %523 = trunc i256 %522 to i254
  %524 = lshr i254 %523, 237
  %_3120.partselect = trunc i254 %524 to i1
  br label %src.addr.3068.exit

src.addr.3068.exit:                               ; preds = %src.addr.3068.case.3, %src.addr.3068.case.2, %src.addr.3068.case.1, %src.addr.3068.case.0, %src.addr.2966.exit
  %525 = phi i1 [ %_0117.partselect, %src.addr.3068.case.0 ], [ %_1118.partselect, %src.addr.3068.case.1 ], [ %_2119.partselect, %src.addr.3068.case.2 ], [ %_3120.partselect, %src.addr.3068.case.3 ], [ undef, %src.addr.2966.exit ]
  store i1 %525, i1* %dst.addr.3069, align 1
  %dst.addr.3171 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 31
  switch i64 %for.loop.idx103, label %src.addr.3170.exit [
    i64 0, label %src.addr.3170.case.0
    i64 1, label %src.addr.3170.case.1
    i64 2, label %src.addr.3170.case.2
    i64 3, label %src.addr.3170.case.3
  ]

src.addr.3170.case.0:                             ; preds = %src.addr.3068.exit
  %526 = bitcast i254* %src_0 to i256*
  %527 = load i256, i256* %526
  %528 = trunc i256 %527 to i254
  %529 = lshr i254 %528, 238
  %_0121.partselect = trunc i254 %529 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.1:                             ; preds = %src.addr.3068.exit
  %530 = bitcast i254* %src_1 to i256*
  %531 = load i256, i256* %530
  %532 = trunc i256 %531 to i254
  %533 = lshr i254 %532, 238
  %_1122.partselect = trunc i254 %533 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.2:                             ; preds = %src.addr.3068.exit
  %534 = bitcast i254* %src_2 to i256*
  %535 = load i256, i256* %534
  %536 = trunc i256 %535 to i254
  %537 = lshr i254 %536, 238
  %_2123.partselect = trunc i254 %537 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.3:                             ; preds = %src.addr.3068.exit
  %538 = bitcast i254* %src_3 to i256*
  %539 = load i256, i256* %538
  %540 = trunc i256 %539 to i254
  %541 = lshr i254 %540, 238
  %_3124.partselect = trunc i254 %541 to i1
  br label %src.addr.3170.exit

src.addr.3170.exit:                               ; preds = %src.addr.3170.case.3, %src.addr.3170.case.2, %src.addr.3170.case.1, %src.addr.3170.case.0, %src.addr.3068.exit
  %542 = phi i1 [ %_0121.partselect, %src.addr.3170.case.0 ], [ %_1122.partselect, %src.addr.3170.case.1 ], [ %_2123.partselect, %src.addr.3170.case.2 ], [ %_3124.partselect, %src.addr.3170.case.3 ], [ undef, %src.addr.3068.exit ]
  store i1 %542, i1* %dst.addr.3171, align 1
  %dst.addr.3273 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 32
  switch i64 %for.loop.idx103, label %src.addr.3272.exit [
    i64 0, label %src.addr.3272.case.0
    i64 1, label %src.addr.3272.case.1
    i64 2, label %src.addr.3272.case.2
    i64 3, label %src.addr.3272.case.3
  ]

src.addr.3272.case.0:                             ; preds = %src.addr.3170.exit
  %543 = bitcast i254* %src_0 to i256*
  %544 = load i256, i256* %543
  %545 = trunc i256 %544 to i254
  %546 = lshr i254 %545, 239
  %_0125.partselect = trunc i254 %546 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.1:                             ; preds = %src.addr.3170.exit
  %547 = bitcast i254* %src_1 to i256*
  %548 = load i256, i256* %547
  %549 = trunc i256 %548 to i254
  %550 = lshr i254 %549, 239
  %_1126.partselect = trunc i254 %550 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.2:                             ; preds = %src.addr.3170.exit
  %551 = bitcast i254* %src_2 to i256*
  %552 = load i256, i256* %551
  %553 = trunc i256 %552 to i254
  %554 = lshr i254 %553, 239
  %_2127.partselect = trunc i254 %554 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.3:                             ; preds = %src.addr.3170.exit
  %555 = bitcast i254* %src_3 to i256*
  %556 = load i256, i256* %555
  %557 = trunc i256 %556 to i254
  %558 = lshr i254 %557, 239
  %_3128.partselect = trunc i254 %558 to i1
  br label %src.addr.3272.exit

src.addr.3272.exit:                               ; preds = %src.addr.3272.case.3, %src.addr.3272.case.2, %src.addr.3272.case.1, %src.addr.3272.case.0, %src.addr.3170.exit
  %559 = phi i1 [ %_0125.partselect, %src.addr.3272.case.0 ], [ %_1126.partselect, %src.addr.3272.case.1 ], [ %_2127.partselect, %src.addr.3272.case.2 ], [ %_3128.partselect, %src.addr.3272.case.3 ], [ undef, %src.addr.3170.exit ]
  store i1 %559, i1* %dst.addr.3273, align 1
  %dst.addr.3375 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 33
  switch i64 %for.loop.idx103, label %src.addr.3374.exit [
    i64 0, label %src.addr.3374.case.0
    i64 1, label %src.addr.3374.case.1
    i64 2, label %src.addr.3374.case.2
    i64 3, label %src.addr.3374.case.3
  ]

src.addr.3374.case.0:                             ; preds = %src.addr.3272.exit
  %560 = bitcast i254* %src_0 to i256*
  %561 = load i256, i256* %560
  %562 = trunc i256 %561 to i254
  %563 = lshr i254 %562, 240
  %_0129.partselect = trunc i254 %563 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.1:                             ; preds = %src.addr.3272.exit
  %564 = bitcast i254* %src_1 to i256*
  %565 = load i256, i256* %564
  %566 = trunc i256 %565 to i254
  %567 = lshr i254 %566, 240
  %_1130.partselect = trunc i254 %567 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.2:                             ; preds = %src.addr.3272.exit
  %568 = bitcast i254* %src_2 to i256*
  %569 = load i256, i256* %568
  %570 = trunc i256 %569 to i254
  %571 = lshr i254 %570, 240
  %_2131.partselect = trunc i254 %571 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.3:                             ; preds = %src.addr.3272.exit
  %572 = bitcast i254* %src_3 to i256*
  %573 = load i256, i256* %572
  %574 = trunc i256 %573 to i254
  %575 = lshr i254 %574, 240
  %_3132.partselect = trunc i254 %575 to i1
  br label %src.addr.3374.exit

src.addr.3374.exit:                               ; preds = %src.addr.3374.case.3, %src.addr.3374.case.2, %src.addr.3374.case.1, %src.addr.3374.case.0, %src.addr.3272.exit
  %576 = phi i1 [ %_0129.partselect, %src.addr.3374.case.0 ], [ %_1130.partselect, %src.addr.3374.case.1 ], [ %_2131.partselect, %src.addr.3374.case.2 ], [ %_3132.partselect, %src.addr.3374.case.3 ], [ undef, %src.addr.3272.exit ]
  store i1 %576, i1* %dst.addr.3375, align 1
  %dst.addr.3477 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 34
  switch i64 %for.loop.idx103, label %src.addr.3476.exit [
    i64 0, label %src.addr.3476.case.0
    i64 1, label %src.addr.3476.case.1
    i64 2, label %src.addr.3476.case.2
    i64 3, label %src.addr.3476.case.3
  ]

src.addr.3476.case.0:                             ; preds = %src.addr.3374.exit
  %577 = bitcast i254* %src_0 to i256*
  %578 = load i256, i256* %577
  %579 = trunc i256 %578 to i254
  %580 = lshr i254 %579, 241
  %_0133.partselect = trunc i254 %580 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.1:                             ; preds = %src.addr.3374.exit
  %581 = bitcast i254* %src_1 to i256*
  %582 = load i256, i256* %581
  %583 = trunc i256 %582 to i254
  %584 = lshr i254 %583, 241
  %_1134.partselect = trunc i254 %584 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.2:                             ; preds = %src.addr.3374.exit
  %585 = bitcast i254* %src_2 to i256*
  %586 = load i256, i256* %585
  %587 = trunc i256 %586 to i254
  %588 = lshr i254 %587, 241
  %_2135.partselect = trunc i254 %588 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.3:                             ; preds = %src.addr.3374.exit
  %589 = bitcast i254* %src_3 to i256*
  %590 = load i256, i256* %589
  %591 = trunc i256 %590 to i254
  %592 = lshr i254 %591, 241
  %_3136.partselect = trunc i254 %592 to i1
  br label %src.addr.3476.exit

src.addr.3476.exit:                               ; preds = %src.addr.3476.case.3, %src.addr.3476.case.2, %src.addr.3476.case.1, %src.addr.3476.case.0, %src.addr.3374.exit
  %593 = phi i1 [ %_0133.partselect, %src.addr.3476.case.0 ], [ %_1134.partselect, %src.addr.3476.case.1 ], [ %_2135.partselect, %src.addr.3476.case.2 ], [ %_3136.partselect, %src.addr.3476.case.3 ], [ undef, %src.addr.3374.exit ]
  store i1 %593, i1* %dst.addr.3477, align 1
  %dst.addr.3579 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 35
  switch i64 %for.loop.idx103, label %src.addr.3578.exit [
    i64 0, label %src.addr.3578.case.0
    i64 1, label %src.addr.3578.case.1
    i64 2, label %src.addr.3578.case.2
    i64 3, label %src.addr.3578.case.3
  ]

src.addr.3578.case.0:                             ; preds = %src.addr.3476.exit
  %594 = bitcast i254* %src_0 to i256*
  %595 = load i256, i256* %594
  %596 = trunc i256 %595 to i254
  %597 = lshr i254 %596, 242
  %_0137.partselect = trunc i254 %597 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.1:                             ; preds = %src.addr.3476.exit
  %598 = bitcast i254* %src_1 to i256*
  %599 = load i256, i256* %598
  %600 = trunc i256 %599 to i254
  %601 = lshr i254 %600, 242
  %_1138.partselect = trunc i254 %601 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.2:                             ; preds = %src.addr.3476.exit
  %602 = bitcast i254* %src_2 to i256*
  %603 = load i256, i256* %602
  %604 = trunc i256 %603 to i254
  %605 = lshr i254 %604, 242
  %_2139.partselect = trunc i254 %605 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.3:                             ; preds = %src.addr.3476.exit
  %606 = bitcast i254* %src_3 to i256*
  %607 = load i256, i256* %606
  %608 = trunc i256 %607 to i254
  %609 = lshr i254 %608, 242
  %_3140.partselect = trunc i254 %609 to i1
  br label %src.addr.3578.exit

src.addr.3578.exit:                               ; preds = %src.addr.3578.case.3, %src.addr.3578.case.2, %src.addr.3578.case.1, %src.addr.3578.case.0, %src.addr.3476.exit
  %610 = phi i1 [ %_0137.partselect, %src.addr.3578.case.0 ], [ %_1138.partselect, %src.addr.3578.case.1 ], [ %_2139.partselect, %src.addr.3578.case.2 ], [ %_3140.partselect, %src.addr.3578.case.3 ], [ undef, %src.addr.3476.exit ]
  store i1 %610, i1* %dst.addr.3579, align 1
  %dst.addr.3681 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 36
  switch i64 %for.loop.idx103, label %src.addr.3680.exit [
    i64 0, label %src.addr.3680.case.0
    i64 1, label %src.addr.3680.case.1
    i64 2, label %src.addr.3680.case.2
    i64 3, label %src.addr.3680.case.3
  ]

src.addr.3680.case.0:                             ; preds = %src.addr.3578.exit
  %611 = bitcast i254* %src_0 to i256*
  %612 = load i256, i256* %611
  %613 = trunc i256 %612 to i254
  %614 = lshr i254 %613, 243
  %_0141.partselect = trunc i254 %614 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.1:                             ; preds = %src.addr.3578.exit
  %615 = bitcast i254* %src_1 to i256*
  %616 = load i256, i256* %615
  %617 = trunc i256 %616 to i254
  %618 = lshr i254 %617, 243
  %_1142.partselect = trunc i254 %618 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.2:                             ; preds = %src.addr.3578.exit
  %619 = bitcast i254* %src_2 to i256*
  %620 = load i256, i256* %619
  %621 = trunc i256 %620 to i254
  %622 = lshr i254 %621, 243
  %_2143.partselect = trunc i254 %622 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.3:                             ; preds = %src.addr.3578.exit
  %623 = bitcast i254* %src_3 to i256*
  %624 = load i256, i256* %623
  %625 = trunc i256 %624 to i254
  %626 = lshr i254 %625, 243
  %_3144.partselect = trunc i254 %626 to i1
  br label %src.addr.3680.exit

src.addr.3680.exit:                               ; preds = %src.addr.3680.case.3, %src.addr.3680.case.2, %src.addr.3680.case.1, %src.addr.3680.case.0, %src.addr.3578.exit
  %627 = phi i1 [ %_0141.partselect, %src.addr.3680.case.0 ], [ %_1142.partselect, %src.addr.3680.case.1 ], [ %_2143.partselect, %src.addr.3680.case.2 ], [ %_3144.partselect, %src.addr.3680.case.3 ], [ undef, %src.addr.3578.exit ]
  store i1 %627, i1* %dst.addr.3681, align 1
  %dst.addr.3783 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 37
  switch i64 %for.loop.idx103, label %src.addr.3782.exit [
    i64 0, label %src.addr.3782.case.0
    i64 1, label %src.addr.3782.case.1
    i64 2, label %src.addr.3782.case.2
    i64 3, label %src.addr.3782.case.3
  ]

src.addr.3782.case.0:                             ; preds = %src.addr.3680.exit
  %628 = bitcast i254* %src_0 to i256*
  %629 = load i256, i256* %628
  %630 = trunc i256 %629 to i254
  %631 = lshr i254 %630, 244
  %_0145.partselect = trunc i254 %631 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.1:                             ; preds = %src.addr.3680.exit
  %632 = bitcast i254* %src_1 to i256*
  %633 = load i256, i256* %632
  %634 = trunc i256 %633 to i254
  %635 = lshr i254 %634, 244
  %_1146.partselect = trunc i254 %635 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.2:                             ; preds = %src.addr.3680.exit
  %636 = bitcast i254* %src_2 to i256*
  %637 = load i256, i256* %636
  %638 = trunc i256 %637 to i254
  %639 = lshr i254 %638, 244
  %_2147.partselect = trunc i254 %639 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.3:                             ; preds = %src.addr.3680.exit
  %640 = bitcast i254* %src_3 to i256*
  %641 = load i256, i256* %640
  %642 = trunc i256 %641 to i254
  %643 = lshr i254 %642, 244
  %_3148.partselect = trunc i254 %643 to i1
  br label %src.addr.3782.exit

src.addr.3782.exit:                               ; preds = %src.addr.3782.case.3, %src.addr.3782.case.2, %src.addr.3782.case.1, %src.addr.3782.case.0, %src.addr.3680.exit
  %644 = phi i1 [ %_0145.partselect, %src.addr.3782.case.0 ], [ %_1146.partselect, %src.addr.3782.case.1 ], [ %_2147.partselect, %src.addr.3782.case.2 ], [ %_3148.partselect, %src.addr.3782.case.3 ], [ undef, %src.addr.3680.exit ]
  store i1 %644, i1* %dst.addr.3783, align 1
  %dst.addr.3885 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 38
  switch i64 %for.loop.idx103, label %src.addr.3884.exit [
    i64 0, label %src.addr.3884.case.0
    i64 1, label %src.addr.3884.case.1
    i64 2, label %src.addr.3884.case.2
    i64 3, label %src.addr.3884.case.3
  ]

src.addr.3884.case.0:                             ; preds = %src.addr.3782.exit
  %645 = bitcast i254* %src_0 to i256*
  %646 = load i256, i256* %645
  %647 = trunc i256 %646 to i254
  %648 = lshr i254 %647, 245
  %_0149.partselect = trunc i254 %648 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.1:                             ; preds = %src.addr.3782.exit
  %649 = bitcast i254* %src_1 to i256*
  %650 = load i256, i256* %649
  %651 = trunc i256 %650 to i254
  %652 = lshr i254 %651, 245
  %_1150.partselect = trunc i254 %652 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.2:                             ; preds = %src.addr.3782.exit
  %653 = bitcast i254* %src_2 to i256*
  %654 = load i256, i256* %653
  %655 = trunc i256 %654 to i254
  %656 = lshr i254 %655, 245
  %_2151.partselect = trunc i254 %656 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.3:                             ; preds = %src.addr.3782.exit
  %657 = bitcast i254* %src_3 to i256*
  %658 = load i256, i256* %657
  %659 = trunc i256 %658 to i254
  %660 = lshr i254 %659, 245
  %_3152.partselect = trunc i254 %660 to i1
  br label %src.addr.3884.exit

src.addr.3884.exit:                               ; preds = %src.addr.3884.case.3, %src.addr.3884.case.2, %src.addr.3884.case.1, %src.addr.3884.case.0, %src.addr.3782.exit
  %661 = phi i1 [ %_0149.partselect, %src.addr.3884.case.0 ], [ %_1150.partselect, %src.addr.3884.case.1 ], [ %_2151.partselect, %src.addr.3884.case.2 ], [ %_3152.partselect, %src.addr.3884.case.3 ], [ undef, %src.addr.3782.exit ]
  store i1 %661, i1* %dst.addr.3885, align 1
  %dst.addr.3987 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 39
  switch i64 %for.loop.idx103, label %src.addr.3986.exit [
    i64 0, label %src.addr.3986.case.0
    i64 1, label %src.addr.3986.case.1
    i64 2, label %src.addr.3986.case.2
    i64 3, label %src.addr.3986.case.3
  ]

src.addr.3986.case.0:                             ; preds = %src.addr.3884.exit
  %662 = bitcast i254* %src_0 to i256*
  %663 = load i256, i256* %662
  %664 = trunc i256 %663 to i254
  %665 = lshr i254 %664, 246
  %_0153.partselect = trunc i254 %665 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.1:                             ; preds = %src.addr.3884.exit
  %666 = bitcast i254* %src_1 to i256*
  %667 = load i256, i256* %666
  %668 = trunc i256 %667 to i254
  %669 = lshr i254 %668, 246
  %_1154.partselect = trunc i254 %669 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.2:                             ; preds = %src.addr.3884.exit
  %670 = bitcast i254* %src_2 to i256*
  %671 = load i256, i256* %670
  %672 = trunc i256 %671 to i254
  %673 = lshr i254 %672, 246
  %_2155.partselect = trunc i254 %673 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.3:                             ; preds = %src.addr.3884.exit
  %674 = bitcast i254* %src_3 to i256*
  %675 = load i256, i256* %674
  %676 = trunc i256 %675 to i254
  %677 = lshr i254 %676, 246
  %_3156.partselect = trunc i254 %677 to i1
  br label %src.addr.3986.exit

src.addr.3986.exit:                               ; preds = %src.addr.3986.case.3, %src.addr.3986.case.2, %src.addr.3986.case.1, %src.addr.3986.case.0, %src.addr.3884.exit
  %678 = phi i1 [ %_0153.partselect, %src.addr.3986.case.0 ], [ %_1154.partselect, %src.addr.3986.case.1 ], [ %_2155.partselect, %src.addr.3986.case.2 ], [ %_3156.partselect, %src.addr.3986.case.3 ], [ undef, %src.addr.3884.exit ]
  store i1 %678, i1* %dst.addr.3987, align 1
  %dst.addr.4089 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 40
  switch i64 %for.loop.idx103, label %src.addr.4088.exit [
    i64 0, label %src.addr.4088.case.0
    i64 1, label %src.addr.4088.case.1
    i64 2, label %src.addr.4088.case.2
    i64 3, label %src.addr.4088.case.3
  ]

src.addr.4088.case.0:                             ; preds = %src.addr.3986.exit
  %679 = bitcast i254* %src_0 to i256*
  %680 = load i256, i256* %679
  %681 = trunc i256 %680 to i254
  %682 = lshr i254 %681, 247
  %_0157.partselect = trunc i254 %682 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.1:                             ; preds = %src.addr.3986.exit
  %683 = bitcast i254* %src_1 to i256*
  %684 = load i256, i256* %683
  %685 = trunc i256 %684 to i254
  %686 = lshr i254 %685, 247
  %_1158.partselect = trunc i254 %686 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.2:                             ; preds = %src.addr.3986.exit
  %687 = bitcast i254* %src_2 to i256*
  %688 = load i256, i256* %687
  %689 = trunc i256 %688 to i254
  %690 = lshr i254 %689, 247
  %_2159.partselect = trunc i254 %690 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.3:                             ; preds = %src.addr.3986.exit
  %691 = bitcast i254* %src_3 to i256*
  %692 = load i256, i256* %691
  %693 = trunc i256 %692 to i254
  %694 = lshr i254 %693, 247
  %_3160.partselect = trunc i254 %694 to i1
  br label %src.addr.4088.exit

src.addr.4088.exit:                               ; preds = %src.addr.4088.case.3, %src.addr.4088.case.2, %src.addr.4088.case.1, %src.addr.4088.case.0, %src.addr.3986.exit
  %695 = phi i1 [ %_0157.partselect, %src.addr.4088.case.0 ], [ %_1158.partselect, %src.addr.4088.case.1 ], [ %_2159.partselect, %src.addr.4088.case.2 ], [ %_3160.partselect, %src.addr.4088.case.3 ], [ undef, %src.addr.3986.exit ]
  store i1 %695, i1* %dst.addr.4089, align 1
  %dst.addr.4191 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 41
  switch i64 %for.loop.idx103, label %src.addr.4190.exit [
    i64 0, label %src.addr.4190.case.0
    i64 1, label %src.addr.4190.case.1
    i64 2, label %src.addr.4190.case.2
    i64 3, label %src.addr.4190.case.3
  ]

src.addr.4190.case.0:                             ; preds = %src.addr.4088.exit
  %696 = bitcast i254* %src_0 to i256*
  %697 = load i256, i256* %696
  %698 = trunc i256 %697 to i254
  %699 = lshr i254 %698, 248
  %_0161.partselect = trunc i254 %699 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.1:                             ; preds = %src.addr.4088.exit
  %700 = bitcast i254* %src_1 to i256*
  %701 = load i256, i256* %700
  %702 = trunc i256 %701 to i254
  %703 = lshr i254 %702, 248
  %_1162.partselect = trunc i254 %703 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.2:                             ; preds = %src.addr.4088.exit
  %704 = bitcast i254* %src_2 to i256*
  %705 = load i256, i256* %704
  %706 = trunc i256 %705 to i254
  %707 = lshr i254 %706, 248
  %_2163.partselect = trunc i254 %707 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.3:                             ; preds = %src.addr.4088.exit
  %708 = bitcast i254* %src_3 to i256*
  %709 = load i256, i256* %708
  %710 = trunc i256 %709 to i254
  %711 = lshr i254 %710, 248
  %_3164.partselect = trunc i254 %711 to i1
  br label %src.addr.4190.exit

src.addr.4190.exit:                               ; preds = %src.addr.4190.case.3, %src.addr.4190.case.2, %src.addr.4190.case.1, %src.addr.4190.case.0, %src.addr.4088.exit
  %712 = phi i1 [ %_0161.partselect, %src.addr.4190.case.0 ], [ %_1162.partselect, %src.addr.4190.case.1 ], [ %_2163.partselect, %src.addr.4190.case.2 ], [ %_3164.partselect, %src.addr.4190.case.3 ], [ undef, %src.addr.4088.exit ]
  store i1 %712, i1* %dst.addr.4191, align 1
  %dst.addr.4293 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 42
  switch i64 %for.loop.idx103, label %src.addr.4292.exit [
    i64 0, label %src.addr.4292.case.0
    i64 1, label %src.addr.4292.case.1
    i64 2, label %src.addr.4292.case.2
    i64 3, label %src.addr.4292.case.3
  ]

src.addr.4292.case.0:                             ; preds = %src.addr.4190.exit
  %713 = bitcast i254* %src_0 to i256*
  %714 = load i256, i256* %713
  %715 = trunc i256 %714 to i254
  %716 = lshr i254 %715, 249
  %_0165.partselect = trunc i254 %716 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.1:                             ; preds = %src.addr.4190.exit
  %717 = bitcast i254* %src_1 to i256*
  %718 = load i256, i256* %717
  %719 = trunc i256 %718 to i254
  %720 = lshr i254 %719, 249
  %_1166.partselect = trunc i254 %720 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.2:                             ; preds = %src.addr.4190.exit
  %721 = bitcast i254* %src_2 to i256*
  %722 = load i256, i256* %721
  %723 = trunc i256 %722 to i254
  %724 = lshr i254 %723, 249
  %_2167.partselect = trunc i254 %724 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.3:                             ; preds = %src.addr.4190.exit
  %725 = bitcast i254* %src_3 to i256*
  %726 = load i256, i256* %725
  %727 = trunc i256 %726 to i254
  %728 = lshr i254 %727, 249
  %_3168.partselect = trunc i254 %728 to i1
  br label %src.addr.4292.exit

src.addr.4292.exit:                               ; preds = %src.addr.4292.case.3, %src.addr.4292.case.2, %src.addr.4292.case.1, %src.addr.4292.case.0, %src.addr.4190.exit
  %729 = phi i1 [ %_0165.partselect, %src.addr.4292.case.0 ], [ %_1166.partselect, %src.addr.4292.case.1 ], [ %_2167.partselect, %src.addr.4292.case.2 ], [ %_3168.partselect, %src.addr.4292.case.3 ], [ undef, %src.addr.4190.exit ]
  store i1 %729, i1* %dst.addr.4293, align 1
  %dst.addr.4395 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 43
  switch i64 %for.loop.idx103, label %src.addr.4394.exit [
    i64 0, label %src.addr.4394.case.0
    i64 1, label %src.addr.4394.case.1
    i64 2, label %src.addr.4394.case.2
    i64 3, label %src.addr.4394.case.3
  ]

src.addr.4394.case.0:                             ; preds = %src.addr.4292.exit
  %730 = bitcast i254* %src_0 to i256*
  %731 = load i256, i256* %730
  %732 = trunc i256 %731 to i254
  %733 = lshr i254 %732, 250
  %_0169.partselect = trunc i254 %733 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.1:                             ; preds = %src.addr.4292.exit
  %734 = bitcast i254* %src_1 to i256*
  %735 = load i256, i256* %734
  %736 = trunc i256 %735 to i254
  %737 = lshr i254 %736, 250
  %_1170.partselect = trunc i254 %737 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.2:                             ; preds = %src.addr.4292.exit
  %738 = bitcast i254* %src_2 to i256*
  %739 = load i256, i256* %738
  %740 = trunc i256 %739 to i254
  %741 = lshr i254 %740, 250
  %_2171.partselect = trunc i254 %741 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.3:                             ; preds = %src.addr.4292.exit
  %742 = bitcast i254* %src_3 to i256*
  %743 = load i256, i256* %742
  %744 = trunc i256 %743 to i254
  %745 = lshr i254 %744, 250
  %_3172.partselect = trunc i254 %745 to i1
  br label %src.addr.4394.exit

src.addr.4394.exit:                               ; preds = %src.addr.4394.case.3, %src.addr.4394.case.2, %src.addr.4394.case.1, %src.addr.4394.case.0, %src.addr.4292.exit
  %746 = phi i1 [ %_0169.partselect, %src.addr.4394.case.0 ], [ %_1170.partselect, %src.addr.4394.case.1 ], [ %_2171.partselect, %src.addr.4394.case.2 ], [ %_3172.partselect, %src.addr.4394.case.3 ], [ undef, %src.addr.4292.exit ]
  store i1 %746, i1* %dst.addr.4395, align 1
  %dst.addr.4497 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 44
  switch i64 %for.loop.idx103, label %src.addr.4496.exit [
    i64 0, label %src.addr.4496.case.0
    i64 1, label %src.addr.4496.case.1
    i64 2, label %src.addr.4496.case.2
    i64 3, label %src.addr.4496.case.3
  ]

src.addr.4496.case.0:                             ; preds = %src.addr.4394.exit
  %747 = bitcast i254* %src_0 to i256*
  %748 = load i256, i256* %747
  %749 = trunc i256 %748 to i254
  %750 = lshr i254 %749, 251
  %_0173.partselect = trunc i254 %750 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.1:                             ; preds = %src.addr.4394.exit
  %751 = bitcast i254* %src_1 to i256*
  %752 = load i256, i256* %751
  %753 = trunc i256 %752 to i254
  %754 = lshr i254 %753, 251
  %_1174.partselect = trunc i254 %754 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.2:                             ; preds = %src.addr.4394.exit
  %755 = bitcast i254* %src_2 to i256*
  %756 = load i256, i256* %755
  %757 = trunc i256 %756 to i254
  %758 = lshr i254 %757, 251
  %_2175.partselect = trunc i254 %758 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.3:                             ; preds = %src.addr.4394.exit
  %759 = bitcast i254* %src_3 to i256*
  %760 = load i256, i256* %759
  %761 = trunc i256 %760 to i254
  %762 = lshr i254 %761, 251
  %_3176.partselect = trunc i254 %762 to i1
  br label %src.addr.4496.exit

src.addr.4496.exit:                               ; preds = %src.addr.4496.case.3, %src.addr.4496.case.2, %src.addr.4496.case.1, %src.addr.4496.case.0, %src.addr.4394.exit
  %763 = phi i1 [ %_0173.partselect, %src.addr.4496.case.0 ], [ %_1174.partselect, %src.addr.4496.case.1 ], [ %_2175.partselect, %src.addr.4496.case.2 ], [ %_3176.partselect, %src.addr.4496.case.3 ], [ undef, %src.addr.4394.exit ]
  store i1 %763, i1* %dst.addr.4497, align 1
  %dst.addr.4599 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 45
  switch i64 %for.loop.idx103, label %src.addr.4598.exit [
    i64 0, label %src.addr.4598.case.0
    i64 1, label %src.addr.4598.case.1
    i64 2, label %src.addr.4598.case.2
    i64 3, label %src.addr.4598.case.3
  ]

src.addr.4598.case.0:                             ; preds = %src.addr.4496.exit
  %764 = bitcast i254* %src_0 to i256*
  %765 = load i256, i256* %764
  %766 = trunc i256 %765 to i254
  %767 = lshr i254 %766, 252
  %_0177.partselect = trunc i254 %767 to i1
  br label %src.addr.4598.exit

src.addr.4598.case.1:                             ; preds = %src.addr.4496.exit
  %768 = bitcast i254* %src_1 to i256*
  %769 = load i256, i256* %768
  %770 = trunc i256 %769 to i254
  %771 = lshr i254 %770, 252
  %_1178.partselect = trunc i254 %771 to i1
  br label %src.addr.4598.exit

src.addr.4598.case.2:                             ; preds = %src.addr.4496.exit
  %772 = bitcast i254* %src_2 to i256*
  %773 = load i256, i256* %772
  %774 = trunc i256 %773 to i254
  %775 = lshr i254 %774, 252
  %_2179.partselect = trunc i254 %775 to i1
  br label %src.addr.4598.exit

src.addr.4598.case.3:                             ; preds = %src.addr.4496.exit
  %776 = bitcast i254* %src_3 to i256*
  %777 = load i256, i256* %776
  %778 = trunc i256 %777 to i254
  %779 = lshr i254 %778, 252
  %_3180.partselect = trunc i254 %779 to i1
  br label %src.addr.4598.exit

src.addr.4598.exit:                               ; preds = %src.addr.4598.case.3, %src.addr.4598.case.2, %src.addr.4598.case.1, %src.addr.4598.case.0, %src.addr.4496.exit
  %780 = phi i1 [ %_0177.partselect, %src.addr.4598.case.0 ], [ %_1178.partselect, %src.addr.4598.case.1 ], [ %_2179.partselect, %src.addr.4598.case.2 ], [ %_3180.partselect, %src.addr.4598.case.3 ], [ undef, %src.addr.4496.exit ]
  store i1 %780, i1* %dst.addr.4599, align 1
  %dst.addr.46101 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx103, i32 46
  switch i64 %for.loop.idx103, label %src.addr.46100.exit [
    i64 0, label %src.addr.46100.case.0
    i64 1, label %src.addr.46100.case.1
    i64 2, label %src.addr.46100.case.2
    i64 3, label %src.addr.46100.case.3
  ]

src.addr.46100.case.0:                            ; preds = %src.addr.4598.exit
  %781 = bitcast i254* %src_0 to i256*
  %782 = load i256, i256* %781
  %783 = trunc i256 %782 to i254
  %784 = lshr i254 %783, 253
  %_0181.partselect = trunc i254 %784 to i1
  br label %src.addr.46100.exit

src.addr.46100.case.1:                            ; preds = %src.addr.4598.exit
  %785 = bitcast i254* %src_1 to i256*
  %786 = load i256, i256* %785
  %787 = trunc i256 %786 to i254
  %788 = lshr i254 %787, 253
  %_1182.partselect = trunc i254 %788 to i1
  br label %src.addr.46100.exit

src.addr.46100.case.2:                            ; preds = %src.addr.4598.exit
  %789 = bitcast i254* %src_2 to i256*
  %790 = load i256, i256* %789
  %791 = trunc i256 %790 to i254
  %792 = lshr i254 %791, 253
  %_2183.partselect = trunc i254 %792 to i1
  br label %src.addr.46100.exit

src.addr.46100.case.3:                            ; preds = %src.addr.4598.exit
  %793 = bitcast i254* %src_3 to i256*
  %794 = load i256, i256* %793
  %795 = trunc i256 %794 to i254
  %796 = lshr i254 %795, 253
  %_3184.partselect = trunc i254 %796 to i1
  br label %src.addr.46100.exit

src.addr.46100.exit:                              ; preds = %src.addr.46100.case.3, %src.addr.46100.case.2, %src.addr.46100.case.1, %src.addr.46100.case.0, %src.addr.4598.exit
  %797 = phi i1 [ %_0181.partselect, %src.addr.46100.case.0 ], [ %_1182.partselect, %src.addr.46100.case.1 ], [ %_2183.partselect, %src.addr.46100.case.2 ], [ %_3184.partselect, %src.addr.46100.case.3 ], [ undef, %src.addr.4598.exit ]
  store i1 %797, i1* %dst.addr.46101, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx103, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.46100.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i254* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i254* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1, i254* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.2" %src_2, i254* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.3" %src_3) #1 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i254* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.23.24([4 x %struct.HeadCtx]* nonnull %dst, i254* nonnull %src_0, i254* %src_1, i254* %src_2, i254* %src_3, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i8* noalias "orig.arg.no"="4", i8* noalias readonly align 512 "orig.arg.no"="5", i32* noalias "orig.arg.no"="6", i32* noalias readonly align 512 "orig.arg.no"="7", i32* noalias "orig.arg.no"="8", i32* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", i1* noalias "orig.arg.no"="12", i1* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="16", i254* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i254* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i254* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i254* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias "orig.arg.no"="18", i1* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21", i1* noalias "orig.arg.no"="22", i1* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias "orig.arg.no"="26", i1056* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i32* noalias "orig.arg.no"="52", i32* noalias readonly align 512 "orig.arg.no"="53", i32* noalias "orig.arg.no"="54", i32* noalias readonly align 512 "orig.arg.no"="55", i32* noalias "orig.arg.no"="56", i32* noalias readonly align 512 "orig.arg.no"="57", i1* noalias "orig.arg.no"="58", i1* noalias readonly align 512 "orig.arg.no"="59", i1* noalias "orig.arg.no"="60", i1* noalias readonly align 512 "orig.arg.no"="61") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %4, i8* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %6, i32* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %12, i1* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* %16, i254* align 512 %_0, i254* align 512 %_1, i254* align 512 %_2, i254* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %17, i1* align 512 %18)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %19, i32* align 512 %20)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %21, i1* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %23, i32* align 512 %24)
  call fastcc void @onebyonecpy_hls.p0struct.ControlMemSpace.30(%struct.ControlMemSpace* %25, i1056* align 512 %26)
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
  call fastcc void @onebyonecpy_hls.p0i1(i1* %59, i1* align 512 %60)
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

declare void @apatb_transformer_top_hw(i1, i1, i1*, i1, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1*, i32*, i254*, i254*, i254*, i254*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i8* noalias "orig.arg.no"="4", i8* noalias readonly align 512 "orig.arg.no"="5", i32* noalias "orig.arg.no"="6", i32* noalias readonly align 512 "orig.arg.no"="7", i32* noalias "orig.arg.no"="8", i32* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", i1* noalias "orig.arg.no"="12", i1* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="16", i254* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i254* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i254* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i254* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias "orig.arg.no"="18", i1* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21", i1* noalias "orig.arg.no"="22", i1* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias "orig.arg.no"="26", i1056* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i32* noalias "orig.arg.no"="52", i32* noalias readonly align 512 "orig.arg.no"="53", i32* noalias "orig.arg.no"="54", i32* noalias readonly align 512 "orig.arg.no"="55", i32* noalias "orig.arg.no"="56", i32* noalias readonly align 512 "orig.arg.no"="57", i1* noalias "orig.arg.no"="58", i1* noalias readonly align 512 "orig.arg.no"="59", i1* noalias "orig.arg.no"="60", i1* noalias readonly align 512 "orig.arg.no"="61") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %4, i8* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %6, i32* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %12, i1* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* %16, i254* align 512 %_0, i254* align 512 %_1, i254* align 512 %_2, i254* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %17, i1* align 512 %18)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %19, i32* align 512 %20)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %21, i1* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %23, i32* align 512 %24)
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
  call fastcc void @onebyonecpy_hls.p0i1(i1* %59, i1* align 512 %60)
  ret void
}

declare void @transformer_top_hw_stub(i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i8* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, [4 x %struct.HeadCtx]* noalias nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i32, i32, i32* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, %struct.ControlMemSpace* noalias nocapture nonnull readnone, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull)

define void @transformer_top_hw_stub_wrapper(i1, i1, i1*, i1, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1*, i32*, i254*, i254*, i254*, i254*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i1*) #5 {
entry:
  %48 = call i8* @malloc(i64 272)
  %49 = bitcast i8* %48 to [4 x %struct.HeadCtx]*
  %50 = call i8* @malloc(i64 132)
  %51 = bitcast i8* %50 to %struct.ControlMemSpace*
  call void @copy_out(i1* null, i1* %2, i1* null, i1* %5, i8* null, i8* %6, i32* null, i32* %7, i32* null, i32* %8, i32* null, i32* %9, i1* null, i1* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %49, i254* %14, i254* %15, i254* %16, i254* %17, i1* null, i1* %19, i32* null, i32* %23, i1* null, i1* %28, i32* null, i32* %29, %struct.ControlMemSpace* %51, i1056* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i32* null, i32* %42, i32* null, i32* %43, i32* null, i32* %44, i32* null, i32* %45, i1* null, i1* %46, i1* null, i1* %47)
  call void @transformer_top_hw_stub(i1 %0, i1 %1, i1* %2, i1 %3, i1 %4, i1* %5, i8* %6, i32* %7, i32* %8, i32* %9, i1 %10, i1 %11, i1* %12, i32* %13, [4 x %struct.HeadCtx]* %49, i1 %18, i1* %19, i1 %20, i32 %21, i32 %22, i32* %23, i1 %24, i1 %25, i1 %26, i1 %27, i1* %28, i32* %29, %struct.ControlMemSpace* %51, i32* %31, i32* %32, i32* %33, i32* %34, i32* %35, i32* %36, i32* %37, i32* %38, i32* %39, i32* %40, i32* %41, i32* %42, i32* %43, i32* %44, i32* %45, i1* %46, i1* %47)
  call void @copy_in(i1* null, i1* %2, i1* null, i1* %5, i8* null, i8* %6, i32* null, i32* %7, i32* null, i32* %8, i32* null, i32* %9, i1* null, i1* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %49, i254* %14, i254* %15, i254* %16, i254* %17, i1* null, i1* %19, i32* null, i32* %23, i1* null, i1* %28, i32* null, i32* %29, %struct.ControlMemSpace* %51, i1056* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i32* null, i32* %42, i32* null, i32* %43, i32* null, i32* %44, i32* null, i32* %45, i1* null, i1* %46, i1* null, i1* %47)
  call void @free(i8* %48)
  call void @free(i8* %50)
  ret void
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
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
!7 = !{!"14", [4 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12, !13, !14}
!11 = !{!"14.0", %struct.HeadCtx* null}
!12 = !{!"14.1", %struct.HeadCtx* null}
!13 = !{!"14.2", %struct.HeadCtx* null}
!14 = !{!"14.3", %struct.HeadCtx* null}
