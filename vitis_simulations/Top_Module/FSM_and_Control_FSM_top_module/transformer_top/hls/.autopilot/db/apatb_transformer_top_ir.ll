; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Top_Module/FSM_and_Control_FSM_top_module/transformer_top/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i32, i32, i8, i1, i1, i8, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }
%struct.ControlMemSpace = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }

; Function Attrs: noinline willreturn
define void @apatb_transformer_top_ir(i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %dma_done, i1 zeroext %wl_ready, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i8* noalias nocapture nonnull dereferenceable(1) %wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %wl_head, i32* noalias nocapture nonnull dereferenceable(4) %wl_tile, i1 zeroext %compute_ready, i1 zeroext %compute_done, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i32* noalias nocapture nonnull dereferenceable(4) %compute_op, [4 x %struct.HeadCtx]* noalias nonnull dereferenceable(256) %head_ctx_ref, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* noalias nocapture nonnull dereferenceable(4) %ctrl_data_out, i1 zeroext %ctrl_read_en, i1 zeroext %ctrl_write_en, i1 zeroext %ctrl_chip_en, i1 zeroext %ctrl_resetn_in, i1* noalias nocapture nonnull dereferenceable(1) %irq_ps, i32* noalias nocapture nonnull dereferenceable(4) %dbg_state, %struct.ControlMemSpace* noalias nocapture nonnull readnone dereferenceable(132) %dbg_ctrl_mem, i32* noalias nocapture nonnull dereferenceable(4) %control_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_status_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_enable_reg, i32* noalias nocapture nonnull dereferenceable(4) %wq_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wk_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wv_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wo_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w1_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w2_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wq_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wk_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wv_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wo_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w1_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w2_tile_stride, i1* noalias nocapture nonnull dereferenceable(1) %dbg_done, i1* noalias nocapture nonnull dereferenceable(1) %dbg_error) local_unnamed_addr #0 {
entry:
  %axis_in_ready_copy = alloca i1, align 512
  %wl_start_copy = alloca i1, align 512
  %wl_addr_sel_copy = alloca i8, align 512
  %wl_layer_copy = alloca i32, align 512
  %wl_head_copy = alloca i32, align 512
  %wl_tile_copy = alloca i32, align 512
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i32, align 512
  %head_ctx_ref_copy_0 = alloca i250, align 512
  %head_ctx_ref_copy_1 = alloca i250, align 512
  %head_ctx_ref_copy_2 = alloca i250, align 512
  %head_ctx_ref_copy_3 = alloca i250, align 512
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
  call void @copy_in(i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i8* nonnull %wl_addr_sel, i8* nonnull align 512 %wl_addr_sel_copy, i32* nonnull %wl_layer, i32* nonnull align 512 %wl_layer_copy, i32* nonnull %wl_head, i32* nonnull align 512 %wl_head_copy, i32* nonnull %wl_tile, i32* nonnull align 512 %wl_tile_copy, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i32* nonnull %compute_op, i32* nonnull align 512 %compute_op_copy, [4 x %struct.HeadCtx]* nonnull %head_ctx_ref, i250* nonnull align 512 %head_ctx_ref_copy_0, i250* nonnull align 512 %head_ctx_ref_copy_1, i250* nonnull align 512 %head_ctx_ref_copy_2, i250* nonnull align 512 %head_ctx_ref_copy_3, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i32* nonnull %ctrl_data_out, i32* nonnull align 512 %ctrl_data_out_copy, i1* nonnull %irq_ps, i1* nonnull align 512 %irq_ps_copy, i32* nonnull %dbg_state, i32* nonnull align 512 %dbg_state_copy, %struct.ControlMemSpace* nonnull %dbg_ctrl_mem, i1056* nonnull align 512 %dbg_ctrl_mem_copy, i32* nonnull %control_reg, i32* nonnull align 512 %control_reg_copy, i32* nonnull %irq_status_reg, i32* nonnull align 512 %irq_status_reg_copy, i32* nonnull %irq_enable_reg, i32* nonnull align 512 %irq_enable_reg_copy, i32* nonnull %wq_base_addr, i32* nonnull align 512 %wq_base_addr_copy, i32* nonnull %wk_base_addr, i32* nonnull align 512 %wk_base_addr_copy, i32* nonnull %wv_base_addr, i32* nonnull align 512 %wv_base_addr_copy, i32* nonnull %wo_base_addr, i32* nonnull align 512 %wo_base_addr_copy, i32* nonnull %w1_base_addr, i32* nonnull align 512 %w1_base_addr_copy, i32* nonnull %w2_base_addr, i32* nonnull align 512 %w2_base_addr_copy, i32* nonnull %wq_head_stride, i32* nonnull align 512 %wq_head_stride_copy, i32* nonnull %wk_head_stride, i32* nonnull align 512 %wk_head_stride_copy, i32* nonnull %wv_head_stride, i32* nonnull align 512 %wv_head_stride_copy, i32* nonnull %wo_tile_stride, i32* nonnull align 512 %wo_tile_stride_copy, i32* nonnull %w1_tile_stride, i32* nonnull align 512 %w1_tile_stride_copy, i32* nonnull %w2_tile_stride, i32* nonnull align 512 %w2_tile_stride_copy, i1* nonnull %dbg_done, i1* nonnull align 512 %dbg_done_copy, i1* nonnull %dbg_error, i1* nonnull align 512 %dbg_error_copy)
  call void @apatb_transformer_top_hw(i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %dma_done, i1 %wl_ready, i1* %wl_start_copy, i8* %wl_addr_sel_copy, i32* %wl_layer_copy, i32* %wl_head_copy, i32* %wl_tile_copy, i1 %compute_ready, i1 %compute_done, i1* %compute_start_copy, i32* %compute_op_copy, i250* %head_ctx_ref_copy_0, i250* %head_ctx_ref_copy_1, i250* %head_ctx_ref_copy_2, i250* %head_ctx_ref_copy_3, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* %ctrl_data_out_copy, i1 %ctrl_read_en, i1 %ctrl_write_en, i1 %ctrl_chip_en, i1 %ctrl_resetn_in, i1* %irq_ps_copy, i32* %dbg_state_copy, i1056* %dbg_ctrl_mem_copy, i32* %control_reg_copy, i32* %irq_status_reg_copy, i32* %irq_enable_reg_copy, i32* %wq_base_addr_copy, i32* %wk_base_addr_copy, i32* %wv_base_addr_copy, i32* %wo_base_addr_copy, i32* %w1_base_addr_copy, i32* %w2_base_addr_copy, i32* %wq_head_stride_copy, i32* %wk_head_stride_copy, i32* %wv_head_stride_copy, i32* %wo_tile_stride_copy, i32* %w1_tile_stride_copy, i32* %w2_tile_stride_copy, i1* %dbg_done_copy, i1* %dbg_error_copy)
  call void @copy_back(i1* %axis_in_ready, i1* %axis_in_ready_copy, i1* %wl_start, i1* %wl_start_copy, i8* %wl_addr_sel, i8* %wl_addr_sel_copy, i32* %wl_layer, i32* %wl_layer_copy, i32* %wl_head, i32* %wl_head_copy, i32* %wl_tile, i32* %wl_tile_copy, i1* %compute_start, i1* %compute_start_copy, i32* %compute_op, i32* %compute_op_copy, [4 x %struct.HeadCtx]* %head_ctx_ref, i250* %head_ctx_ref_copy_0, i250* %head_ctx_ref_copy_1, i250* %head_ctx_ref_copy_2, i250* %head_ctx_ref_copy_3, i1* %stream_start, i1* %stream_start_copy, i32* %ctrl_data_out, i32* %ctrl_data_out_copy, i1* %irq_ps, i1* %irq_ps_copy, i32* %dbg_state, i32* %dbg_state_copy, %struct.ControlMemSpace* %dbg_ctrl_mem, i1056* %dbg_ctrl_mem_copy, i32* %control_reg, i32* %control_reg_copy, i32* %irq_status_reg, i32* %irq_status_reg_copy, i32* %irq_enable_reg, i32* %irq_enable_reg_copy, i32* %wq_base_addr, i32* %wq_base_addr_copy, i32* %wk_base_addr, i32* %wk_base_addr_copy, i32* %wv_base_addr, i32* %wv_base_addr_copy, i32* %wo_base_addr, i32* %wo_base_addr_copy, i32* %w1_base_addr, i32* %w1_base_addr_copy, i32* %w2_base_addr, i32* %w2_base_addr_copy, i32* %wq_head_stride, i32* %wq_head_stride_copy, i32* %wk_head_stride, i32* %wk_head_stride_copy, i32* %wv_head_stride, i32* %wv_head_stride_copy, i32* %wo_tile_stride, i32* %wo_tile_stride_copy, i32* %w1_tile_stride, i32* %w1_tile_stride_copy, i32* %w2_tile_stride, i32* %w2_tile_stride_copy, i1* %dbg_done, i1* %dbg_done_copy, i1* %dbg_error, i1* %dbg_error_copy)
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
  %for.loop.cond94 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond94, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx95 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 0
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 1
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 1
  %4 = load i32, i32* %src.addr.110, align 4
  store i32 %4, i32* %dst.addr.111, align 4
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 2
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 2
  %5 = load i8, i8* %src.addr.212, align 1
  store i8 %5, i8* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 3
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 3
  %6 = bitcast i1* %src.addr.314 to i8*
  %7 = load i8, i8* %6
  %8 = trunc i8 %7 to i1
  store i1 %8, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 4
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 4
  %9 = bitcast i1* %src.addr.416 to i8*
  %10 = load i8, i8* %9
  %11 = trunc i8 %10 to i1
  store i1 %11, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 5
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 5
  %12 = bitcast i1* %src.addr.518 to i8*
  %13 = load i8, i8* %12
  %14 = trunc i8 %13 to i1
  store i1 %14, i1* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 6
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 6
  %15 = load i32, i32* %src.addr.620, align 4
  store i32 %15, i32* %dst.addr.621, align 4
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 7
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 7
  %16 = load i32, i32* %src.addr.722, align 4
  store i32 %16, i32* %dst.addr.723, align 4
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 8
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 8
  %17 = load i8, i8* %src.addr.824, align 1
  store i8 %17, i8* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 9
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 9
  %18 = bitcast i1* %src.addr.926 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  store i1 %20, i1* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 10
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 10
  %21 = bitcast i1* %src.addr.1028 to i8*
  %22 = load i8, i8* %21
  %23 = trunc i8 %22 to i1
  store i1 %23, i1* %dst.addr.1029, align 1
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 11
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 11
  %24 = load i8, i8* %src.addr.1130, align 1
  store i8 %24, i8* %dst.addr.1131, align 1
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 12
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 12
  %25 = load i32, i32* %src.addr.1232, align 4
  store i32 %25, i32* %dst.addr.1233, align 4
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 13
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 13
  %26 = load i32, i32* %src.addr.1334, align 4
  store i32 %26, i32* %dst.addr.1335, align 4
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 14
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 14
  %27 = bitcast i1* %src.addr.1436 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  store i1 %29, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 15
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 15
  %30 = bitcast i1* %src.addr.1538 to i8*
  %31 = load i8, i8* %30
  %32 = trunc i8 %31 to i1
  store i1 %32, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 16
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 16
  %33 = bitcast i1* %src.addr.1640 to i8*
  %34 = load i8, i8* %33
  %35 = trunc i8 %34 to i1
  store i1 %35, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 17
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 17
  %36 = bitcast i1* %src.addr.1742 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  store i1 %38, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 18
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 18
  %39 = bitcast i1* %src.addr.1844 to i8*
  %40 = load i8, i8* %39
  %41 = trunc i8 %40 to i1
  store i1 %41, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 19
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 19
  %42 = bitcast i1* %src.addr.1946 to i8*
  %43 = load i8, i8* %42
  %44 = trunc i8 %43 to i1
  store i1 %44, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 20
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 20
  %45 = bitcast i1* %src.addr.2048 to i8*
  %46 = load i8, i8* %45
  %47 = trunc i8 %46 to i1
  store i1 %47, i1* %dst.addr.2049, align 1
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 21
  %dst.addr.2151 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 21
  %48 = bitcast i1* %src.addr.2150 to i8*
  %49 = load i8, i8* %48
  %50 = trunc i8 %49 to i1
  store i1 %50, i1* %dst.addr.2151, align 1
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 22
  %dst.addr.2253 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 22
  %51 = bitcast i1* %src.addr.2252 to i8*
  %52 = load i8, i8* %51
  %53 = trunc i8 %52 to i1
  store i1 %53, i1* %dst.addr.2253, align 1
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 23
  %dst.addr.2355 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 23
  %54 = bitcast i1* %src.addr.2354 to i8*
  %55 = load i8, i8* %54
  %56 = trunc i8 %55 to i1
  store i1 %56, i1* %dst.addr.2355, align 1
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 24
  %dst.addr.2457 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 24
  %57 = bitcast i1* %src.addr.2456 to i8*
  %58 = load i8, i8* %57
  %59 = trunc i8 %58 to i1
  store i1 %59, i1* %dst.addr.2457, align 1
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 25
  %dst.addr.2559 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 25
  %60 = bitcast i1* %src.addr.2558 to i8*
  %61 = load i8, i8* %60
  %62 = trunc i8 %61 to i1
  store i1 %62, i1* %dst.addr.2559, align 1
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 26
  %dst.addr.2661 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 26
  %63 = bitcast i1* %src.addr.2660 to i8*
  %64 = load i8, i8* %63
  %65 = trunc i8 %64 to i1
  store i1 %65, i1* %dst.addr.2661, align 1
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 27
  %dst.addr.2763 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 27
  %66 = bitcast i1* %src.addr.2762 to i8*
  %67 = load i8, i8* %66
  %68 = trunc i8 %67 to i1
  store i1 %68, i1* %dst.addr.2763, align 1
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 28
  %dst.addr.2865 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 28
  %69 = bitcast i1* %src.addr.2864 to i8*
  %70 = load i8, i8* %69
  %71 = trunc i8 %70 to i1
  store i1 %71, i1* %dst.addr.2865, align 1
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 29
  %dst.addr.2967 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 29
  %72 = bitcast i1* %src.addr.2966 to i8*
  %73 = load i8, i8* %72
  %74 = trunc i8 %73 to i1
  store i1 %74, i1* %dst.addr.2967, align 1
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 30
  %dst.addr.3069 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 30
  %75 = bitcast i1* %src.addr.3068 to i8*
  %76 = load i8, i8* %75
  %77 = trunc i8 %76 to i1
  store i1 %77, i1* %dst.addr.3069, align 1
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 31
  %dst.addr.3171 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 31
  %78 = bitcast i1* %src.addr.3170 to i8*
  %79 = load i8, i8* %78
  %80 = trunc i8 %79 to i1
  store i1 %80, i1* %dst.addr.3171, align 1
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 32
  %dst.addr.3273 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 32
  %81 = bitcast i1* %src.addr.3272 to i8*
  %82 = load i8, i8* %81
  %83 = trunc i8 %82 to i1
  store i1 %83, i1* %dst.addr.3273, align 1
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 33
  %dst.addr.3375 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 33
  %84 = bitcast i1* %src.addr.3374 to i8*
  %85 = load i8, i8* %84
  %86 = trunc i8 %85 to i1
  store i1 %86, i1* %dst.addr.3375, align 1
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 34
  %dst.addr.3477 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 34
  %87 = bitcast i1* %src.addr.3476 to i8*
  %88 = load i8, i8* %87
  %89 = trunc i8 %88 to i1
  store i1 %89, i1* %dst.addr.3477, align 1
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 35
  %dst.addr.3579 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 35
  %90 = bitcast i1* %src.addr.3578 to i8*
  %91 = load i8, i8* %90
  %92 = trunc i8 %91 to i1
  store i1 %92, i1* %dst.addr.3579, align 1
  %src.addr.3680 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 36
  %dst.addr.3681 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 36
  %93 = bitcast i1* %src.addr.3680 to i8*
  %94 = load i8, i8* %93
  %95 = trunc i8 %94 to i1
  store i1 %95, i1* %dst.addr.3681, align 1
  %src.addr.3782 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 37
  %dst.addr.3783 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 37
  %96 = bitcast i1* %src.addr.3782 to i8*
  %97 = load i8, i8* %96
  %98 = trunc i8 %97 to i1
  store i1 %98, i1* %dst.addr.3783, align 1
  %src.addr.3884 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 38
  %dst.addr.3885 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 38
  %99 = bitcast i1* %src.addr.3884 to i8*
  %100 = load i8, i8* %99
  %101 = trunc i8 %100 to i1
  store i1 %101, i1* %dst.addr.3885, align 1
  %src.addr.3986 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 39
  %dst.addr.3987 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 39
  %102 = bitcast i1* %src.addr.3986 to i8*
  %103 = load i8, i8* %102
  %104 = trunc i8 %103 to i1
  store i1 %104, i1* %dst.addr.3987, align 1
  %src.addr.4088 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 40
  %dst.addr.4089 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 40
  %105 = bitcast i1* %src.addr.4088 to i8*
  %106 = load i8, i8* %105
  %107 = trunc i8 %106 to i1
  store i1 %107, i1* %dst.addr.4089, align 1
  %src.addr.4190 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 41
  %dst.addr.4191 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 41
  %108 = bitcast i1* %src.addr.4190 to i8*
  %109 = load i8, i8* %108
  %110 = trunc i8 %109 to i1
  store i1 %110, i1* %dst.addr.4191, align 1
  %src.addr.4292 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 42
  %dst.addr.4293 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 42
  %111 = bitcast i1* %src.addr.4292 to i8*
  %112 = load i8, i8* %111
  %113 = trunc i8 %112 to i1
  store i1 %113, i1* %dst.addr.4293, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx95, 1
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
define void @arraycpy_hls.p0a4struct.HeadCtx.13.14(i250* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i250* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i250* "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i250* "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i250* %dst_0, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond94 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond94, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %dst.addr.4293.exit, %for.loop.lr.ph
  %for.loop.idx95 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %dst.addr.4293.exit ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  switch i64 %for.loop.idx95, label %dst.addr.02.exit [
    i64 0, label %dst.addr.02.case.0
    i64 1, label %dst.addr.02.case.1
    i64 2, label %dst.addr.02.case.2
    i64 3, label %dst.addr.02.case.3
  ]

dst.addr.02.case.0:                               ; preds = %for.loop
  %4 = bitcast i250* %dst_0 to i256*
  %5 = load i256, i256* %4
  %6 = trunc i256 %5 to i250
  %7 = zext i32 %3 to i250
  %8 = and i250 %6, -4294967296
  %.partset171 = or i250 %8, %7
  store i250 %.partset171, i250* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i250* %dst_1 to i256*
  %10 = load i256, i256* %9
  %11 = trunc i256 %10 to i250
  %12 = zext i32 %3 to i250
  %13 = and i250 %11, -4294967296
  %.partset86 = or i250 %13, %12
  store i250 %.partset86, i250* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.2:                               ; preds = %for.loop
  %14 = bitcast i250* %dst_2 to i256*
  %15 = load i256, i256* %14
  %16 = trunc i256 %15 to i250
  %17 = zext i32 %3 to i250
  %18 = and i250 %16, -4294967296
  %.partset85 = or i250 %18, %17
  store i250 %.partset85, i250* %dst_2, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.3:                               ; preds = %for.loop
  %19 = bitcast i250* %dst_3 to i256*
  %20 = load i256, i256* %19
  %21 = trunc i256 %20 to i250
  %22 = zext i32 %3 to i250
  %23 = and i250 %21, -4294967296
  %.partset = or i250 %23, %22
  store i250 %.partset, i250* %dst_3, align 4
  br label %dst.addr.02.exit

dst.addr.02.exit:                                 ; preds = %dst.addr.02.case.3, %dst.addr.02.case.2, %dst.addr.02.case.1, %dst.addr.02.case.0, %for.loop
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 1
  %24 = load i32, i32* %src.addr.110, align 4
  switch i64 %for.loop.idx95, label %dst.addr.111.exit [
    i64 0, label %dst.addr.111.case.0
    i64 1, label %dst.addr.111.case.1
    i64 2, label %dst.addr.111.case.2
    i64 3, label %dst.addr.111.case.3
  ]

dst.addr.111.case.0:                              ; preds = %dst.addr.02.exit
  %25 = bitcast i250* %dst_0 to i256*
  %26 = load i256, i256* %25
  %27 = trunc i256 %26 to i250
  %28 = zext i32 %24 to i250
  %29 = shl i250 %28, 32
  %30 = and i250 %27, -18446744069414584321
  %.partset170 = or i250 %30, %29
  store i250 %.partset170, i250* %dst_0, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %31 = bitcast i250* %dst_1 to i256*
  %32 = load i256, i256* %31
  %33 = trunc i256 %32 to i250
  %34 = zext i32 %24 to i250
  %35 = shl i250 %34, 32
  %36 = and i250 %33, -18446744069414584321
  %.partset87 = or i250 %36, %35
  store i250 %.partset87, i250* %dst_1, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.2:                              ; preds = %dst.addr.02.exit
  %37 = bitcast i250* %dst_2 to i256*
  %38 = load i256, i256* %37
  %39 = trunc i256 %38 to i250
  %40 = zext i32 %24 to i250
  %41 = shl i250 %40, 32
  %42 = and i250 %39, -18446744069414584321
  %.partset84 = or i250 %42, %41
  store i250 %.partset84, i250* %dst_2, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.3:                              ; preds = %dst.addr.02.exit
  %43 = bitcast i250* %dst_3 to i256*
  %44 = load i256, i256* %43
  %45 = trunc i256 %44 to i250
  %46 = zext i32 %24 to i250
  %47 = shl i250 %46, 32
  %48 = and i250 %45, -18446744069414584321
  %.partset1 = or i250 %48, %47
  store i250 %.partset1, i250* %dst_3, align 4
  br label %dst.addr.111.exit

dst.addr.111.exit:                                ; preds = %dst.addr.111.case.3, %dst.addr.111.case.2, %dst.addr.111.case.1, %dst.addr.111.case.0, %dst.addr.02.exit
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 2
  %49 = load i8, i8* %src.addr.212, align 1
  switch i64 %for.loop.idx95, label %dst.addr.213.exit [
    i64 0, label %dst.addr.213.case.0
    i64 1, label %dst.addr.213.case.1
    i64 2, label %dst.addr.213.case.2
    i64 3, label %dst.addr.213.case.3
  ]

dst.addr.213.case.0:                              ; preds = %dst.addr.111.exit
  %50 = bitcast i250* %dst_0 to i256*
  %51 = load i256, i256* %50
  %52 = trunc i256 %51 to i250
  %53 = zext i8 %49 to i250
  %54 = shl i250 %53, 64
  %55 = and i250 %52, -4703919738795935662081
  %.partset169 = or i250 %55, %54
  store i250 %.partset169, i250* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %56 = bitcast i250* %dst_1 to i256*
  %57 = load i256, i256* %56
  %58 = trunc i256 %57 to i250
  %59 = zext i8 %49 to i250
  %60 = shl i250 %59, 64
  %61 = and i250 %58, -4703919738795935662081
  %.partset88 = or i250 %61, %60
  store i250 %.partset88, i250* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.2:                              ; preds = %dst.addr.111.exit
  %62 = bitcast i250* %dst_2 to i256*
  %63 = load i256, i256* %62
  %64 = trunc i256 %63 to i250
  %65 = zext i8 %49 to i250
  %66 = shl i250 %65, 64
  %67 = and i250 %64, -4703919738795935662081
  %.partset83 = or i250 %67, %66
  store i250 %.partset83, i250* %dst_2, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.3:                              ; preds = %dst.addr.111.exit
  %68 = bitcast i250* %dst_3 to i256*
  %69 = load i256, i256* %68
  %70 = trunc i256 %69 to i250
  %71 = zext i8 %49 to i250
  %72 = shl i250 %71, 64
  %73 = and i250 %70, -4703919738795935662081
  %.partset2 = or i250 %73, %72
  store i250 %.partset2, i250* %dst_3, align 1
  br label %dst.addr.213.exit

dst.addr.213.exit:                                ; preds = %dst.addr.213.case.3, %dst.addr.213.case.2, %dst.addr.213.case.1, %dst.addr.213.case.0, %dst.addr.111.exit
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 3
  %74 = bitcast i1* %src.addr.314 to i8*
  %75 = load i8, i8* %74
  %76 = trunc i8 %75 to i1
  switch i64 %for.loop.idx95, label %dst.addr.315.exit [
    i64 0, label %dst.addr.315.case.0
    i64 1, label %dst.addr.315.case.1
    i64 2, label %dst.addr.315.case.2
    i64 3, label %dst.addr.315.case.3
  ]

dst.addr.315.case.0:                              ; preds = %dst.addr.213.exit
  %77 = bitcast i250* %dst_0 to i256*
  %78 = load i256, i256* %77
  %79 = trunc i256 %78 to i250
  %80 = zext i1 %76 to i250
  %81 = shl i250 %80, 72
  %82 = and i250 %79, -4722366482869645213697
  %.partset168 = or i250 %82, %81
  store i250 %.partset168, i250* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %83 = bitcast i250* %dst_1 to i256*
  %84 = load i256, i256* %83
  %85 = trunc i256 %84 to i250
  %86 = zext i1 %76 to i250
  %87 = shl i250 %86, 72
  %88 = and i250 %85, -4722366482869645213697
  %.partset89 = or i250 %88, %87
  store i250 %.partset89, i250* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.2:                              ; preds = %dst.addr.213.exit
  %89 = bitcast i250* %dst_2 to i256*
  %90 = load i256, i256* %89
  %91 = trunc i256 %90 to i250
  %92 = zext i1 %76 to i250
  %93 = shl i250 %92, 72
  %94 = and i250 %91, -4722366482869645213697
  %.partset82 = or i250 %94, %93
  store i250 %.partset82, i250* %dst_2, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.3:                              ; preds = %dst.addr.213.exit
  %95 = bitcast i250* %dst_3 to i256*
  %96 = load i256, i256* %95
  %97 = trunc i256 %96 to i250
  %98 = zext i1 %76 to i250
  %99 = shl i250 %98, 72
  %100 = and i250 %97, -4722366482869645213697
  %.partset3 = or i250 %100, %99
  store i250 %.partset3, i250* %dst_3, align 1
  br label %dst.addr.315.exit

dst.addr.315.exit:                                ; preds = %dst.addr.315.case.3, %dst.addr.315.case.2, %dst.addr.315.case.1, %dst.addr.315.case.0, %dst.addr.213.exit
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 4
  %101 = bitcast i1* %src.addr.416 to i8*
  %102 = load i8, i8* %101
  %103 = trunc i8 %102 to i1
  switch i64 %for.loop.idx95, label %dst.addr.417.exit [
    i64 0, label %dst.addr.417.case.0
    i64 1, label %dst.addr.417.case.1
    i64 2, label %dst.addr.417.case.2
    i64 3, label %dst.addr.417.case.3
  ]

dst.addr.417.case.0:                              ; preds = %dst.addr.315.exit
  %104 = bitcast i250* %dst_0 to i256*
  %105 = load i256, i256* %104
  %106 = trunc i256 %105 to i250
  %107 = zext i1 %103 to i250
  %108 = shl i250 %107, 73
  %109 = and i250 %106, -9444732965739290427393
  %.partset167 = or i250 %109, %108
  store i250 %.partset167, i250* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %110 = bitcast i250* %dst_1 to i256*
  %111 = load i256, i256* %110
  %112 = trunc i256 %111 to i250
  %113 = zext i1 %103 to i250
  %114 = shl i250 %113, 73
  %115 = and i250 %112, -9444732965739290427393
  %.partset90 = or i250 %115, %114
  store i250 %.partset90, i250* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.2:                              ; preds = %dst.addr.315.exit
  %116 = bitcast i250* %dst_2 to i256*
  %117 = load i256, i256* %116
  %118 = trunc i256 %117 to i250
  %119 = zext i1 %103 to i250
  %120 = shl i250 %119, 73
  %121 = and i250 %118, -9444732965739290427393
  %.partset81 = or i250 %121, %120
  store i250 %.partset81, i250* %dst_2, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.3:                              ; preds = %dst.addr.315.exit
  %122 = bitcast i250* %dst_3 to i256*
  %123 = load i256, i256* %122
  %124 = trunc i256 %123 to i250
  %125 = zext i1 %103 to i250
  %126 = shl i250 %125, 73
  %127 = and i250 %124, -9444732965739290427393
  %.partset4 = or i250 %127, %126
  store i250 %.partset4, i250* %dst_3, align 1
  br label %dst.addr.417.exit

dst.addr.417.exit:                                ; preds = %dst.addr.417.case.3, %dst.addr.417.case.2, %dst.addr.417.case.1, %dst.addr.417.case.0, %dst.addr.315.exit
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 5
  %128 = bitcast i1* %src.addr.518 to i8*
  %129 = load i8, i8* %128
  %130 = trunc i8 %129 to i1
  switch i64 %for.loop.idx95, label %dst.addr.519.exit [
    i64 0, label %dst.addr.519.case.0
    i64 1, label %dst.addr.519.case.1
    i64 2, label %dst.addr.519.case.2
    i64 3, label %dst.addr.519.case.3
  ]

dst.addr.519.case.0:                              ; preds = %dst.addr.417.exit
  %131 = bitcast i250* %dst_0 to i256*
  %132 = load i256, i256* %131
  %133 = trunc i256 %132 to i250
  %134 = zext i1 %130 to i250
  %135 = shl i250 %134, 74
  %136 = and i250 %133, -18889465931478580854785
  %.partset166 = or i250 %136, %135
  store i250 %.partset166, i250* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %137 = bitcast i250* %dst_1 to i256*
  %138 = load i256, i256* %137
  %139 = trunc i256 %138 to i250
  %140 = zext i1 %130 to i250
  %141 = shl i250 %140, 74
  %142 = and i250 %139, -18889465931478580854785
  %.partset91 = or i250 %142, %141
  store i250 %.partset91, i250* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.2:                              ; preds = %dst.addr.417.exit
  %143 = bitcast i250* %dst_2 to i256*
  %144 = load i256, i256* %143
  %145 = trunc i256 %144 to i250
  %146 = zext i1 %130 to i250
  %147 = shl i250 %146, 74
  %148 = and i250 %145, -18889465931478580854785
  %.partset80 = or i250 %148, %147
  store i250 %.partset80, i250* %dst_2, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.3:                              ; preds = %dst.addr.417.exit
  %149 = bitcast i250* %dst_3 to i256*
  %150 = load i256, i256* %149
  %151 = trunc i256 %150 to i250
  %152 = zext i1 %130 to i250
  %153 = shl i250 %152, 74
  %154 = and i250 %151, -18889465931478580854785
  %.partset5 = or i250 %154, %153
  store i250 %.partset5, i250* %dst_3, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.3, %dst.addr.519.case.2, %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 6
  %155 = load i32, i32* %src.addr.620, align 4
  switch i64 %for.loop.idx95, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
    i64 2, label %dst.addr.621.case.2
    i64 3, label %dst.addr.621.case.3
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %156 = bitcast i250* %dst_0 to i256*
  %157 = load i256, i256* %156
  %158 = trunc i256 %157 to i250
  %159 = zext i32 %155 to i250
  %160 = shl i250 %159, 75
  %161 = and i250 %158, -162259276791434431528620848578561
  %.partset165 = or i250 %161, %160
  store i250 %.partset165, i250* %dst_0, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %162 = bitcast i250* %dst_1 to i256*
  %163 = load i256, i256* %162
  %164 = trunc i256 %163 to i250
  %165 = zext i32 %155 to i250
  %166 = shl i250 %165, 75
  %167 = and i250 %164, -162259276791434431528620848578561
  %.partset92 = or i250 %167, %166
  store i250 %.partset92, i250* %dst_1, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.2:                              ; preds = %dst.addr.519.exit
  %168 = bitcast i250* %dst_2 to i256*
  %169 = load i256, i256* %168
  %170 = trunc i256 %169 to i250
  %171 = zext i32 %155 to i250
  %172 = shl i250 %171, 75
  %173 = and i250 %170, -162259276791434431528620848578561
  %.partset79 = or i250 %173, %172
  store i250 %.partset79, i250* %dst_2, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.3:                              ; preds = %dst.addr.519.exit
  %174 = bitcast i250* %dst_3 to i256*
  %175 = load i256, i256* %174
  %176 = trunc i256 %175 to i250
  %177 = zext i32 %155 to i250
  %178 = shl i250 %177, 75
  %179 = and i250 %176, -162259276791434431528620848578561
  %.partset6 = or i250 %179, %178
  store i250 %.partset6, i250* %dst_3, align 4
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.3, %dst.addr.621.case.2, %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 7
  %180 = load i32, i32* %src.addr.722, align 4
  switch i64 %for.loop.idx95, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
    i64 2, label %dst.addr.723.case.2
    i64 3, label %dst.addr.723.case.3
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %181 = bitcast i250* %dst_0 to i256*
  %182 = load i256, i256* %181
  %183 = trunc i256 %182 to i250
  %184 = zext i32 %180 to i250
  %185 = shl i250 %184, 107
  %186 = and i250 %183, -696898287291822696343777832628683286773761
  %.partset164 = or i250 %186, %185
  store i250 %.partset164, i250* %dst_0, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %187 = bitcast i250* %dst_1 to i256*
  %188 = load i256, i256* %187
  %189 = trunc i256 %188 to i250
  %190 = zext i32 %180 to i250
  %191 = shl i250 %190, 107
  %192 = and i250 %189, -696898287291822696343777832628683286773761
  %.partset93 = or i250 %192, %191
  store i250 %.partset93, i250* %dst_1, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.2:                              ; preds = %dst.addr.621.exit
  %193 = bitcast i250* %dst_2 to i256*
  %194 = load i256, i256* %193
  %195 = trunc i256 %194 to i250
  %196 = zext i32 %180 to i250
  %197 = shl i250 %196, 107
  %198 = and i250 %195, -696898287291822696343777832628683286773761
  %.partset78 = or i250 %198, %197
  store i250 %.partset78, i250* %dst_2, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.3:                              ; preds = %dst.addr.621.exit
  %199 = bitcast i250* %dst_3 to i256*
  %200 = load i256, i256* %199
  %201 = trunc i256 %200 to i250
  %202 = zext i32 %180 to i250
  %203 = shl i250 %202, 107
  %204 = and i250 %201, -696898287291822696343777832628683286773761
  %.partset7 = or i250 %204, %203
  store i250 %.partset7, i250* %dst_3, align 4
  br label %dst.addr.723.exit

dst.addr.723.exit:                                ; preds = %dst.addr.723.case.3, %dst.addr.723.case.2, %dst.addr.723.case.1, %dst.addr.723.case.0, %dst.addr.621.exit
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 8
  %205 = load i8, i8* %src.addr.824, align 1
  switch i64 %for.loop.idx95, label %dst.addr.825.exit [
    i64 0, label %dst.addr.825.case.0
    i64 1, label %dst.addr.825.case.1
    i64 2, label %dst.addr.825.case.2
    i64 3, label %dst.addr.825.case.3
  ]

dst.addr.825.case.0:                              ; preds = %dst.addr.723.exit
  %206 = bitcast i250* %dst_0 to i256*
  %207 = load i256, i256* %206
  %208 = trunc i256 %207 to i250
  %209 = zext i8 %205 to i250
  %210 = shl i250 %209, 139
  %211 = and i250 %208, -177709063300790903159112754985166630750781441
  %.partset163 = or i250 %211, %210
  store i250 %.partset163, i250* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %212 = bitcast i250* %dst_1 to i256*
  %213 = load i256, i256* %212
  %214 = trunc i256 %213 to i250
  %215 = zext i8 %205 to i250
  %216 = shl i250 %215, 139
  %217 = and i250 %214, -177709063300790903159112754985166630750781441
  %.partset94 = or i250 %217, %216
  store i250 %.partset94, i250* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.2:                              ; preds = %dst.addr.723.exit
  %218 = bitcast i250* %dst_2 to i256*
  %219 = load i256, i256* %218
  %220 = trunc i256 %219 to i250
  %221 = zext i8 %205 to i250
  %222 = shl i250 %221, 139
  %223 = and i250 %220, -177709063300790903159112754985166630750781441
  %.partset77 = or i250 %223, %222
  store i250 %.partset77, i250* %dst_2, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.3:                              ; preds = %dst.addr.723.exit
  %224 = bitcast i250* %dst_3 to i256*
  %225 = load i256, i256* %224
  %226 = trunc i256 %225 to i250
  %227 = zext i8 %205 to i250
  %228 = shl i250 %227, 139
  %229 = and i250 %226, -177709063300790903159112754985166630750781441
  %.partset8 = or i250 %229, %228
  store i250 %.partset8, i250* %dst_3, align 1
  br label %dst.addr.825.exit

dst.addr.825.exit:                                ; preds = %dst.addr.825.case.3, %dst.addr.825.case.2, %dst.addr.825.case.1, %dst.addr.825.case.0, %dst.addr.723.exit
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 9
  %230 = bitcast i1* %src.addr.926 to i8*
  %231 = load i8, i8* %230
  %232 = trunc i8 %231 to i1
  switch i64 %for.loop.idx95, label %dst.addr.927.exit [
    i64 0, label %dst.addr.927.case.0
    i64 1, label %dst.addr.927.case.1
    i64 2, label %dst.addr.927.case.2
    i64 3, label %dst.addr.927.case.3
  ]

dst.addr.927.case.0:                              ; preds = %dst.addr.825.exit
  %233 = bitcast i250* %dst_0 to i256*
  %234 = load i256, i256* %233
  %235 = trunc i256 %234 to i250
  %236 = zext i1 %232 to i250
  %237 = shl i250 %236, 147
  %238 = and i250 %235, -178405961588244985132285746181186892047843329
  %.partset162 = or i250 %238, %237
  store i250 %.partset162, i250* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %239 = bitcast i250* %dst_1 to i256*
  %240 = load i256, i256* %239
  %241 = trunc i256 %240 to i250
  %242 = zext i1 %232 to i250
  %243 = shl i250 %242, 147
  %244 = and i250 %241, -178405961588244985132285746181186892047843329
  %.partset95 = or i250 %244, %243
  store i250 %.partset95, i250* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.2:                              ; preds = %dst.addr.825.exit
  %245 = bitcast i250* %dst_2 to i256*
  %246 = load i256, i256* %245
  %247 = trunc i256 %246 to i250
  %248 = zext i1 %232 to i250
  %249 = shl i250 %248, 147
  %250 = and i250 %247, -178405961588244985132285746181186892047843329
  %.partset76 = or i250 %250, %249
  store i250 %.partset76, i250* %dst_2, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.3:                              ; preds = %dst.addr.825.exit
  %251 = bitcast i250* %dst_3 to i256*
  %252 = load i256, i256* %251
  %253 = trunc i256 %252 to i250
  %254 = zext i1 %232 to i250
  %255 = shl i250 %254, 147
  %256 = and i250 %253, -178405961588244985132285746181186892047843329
  %.partset9 = or i250 %256, %255
  store i250 %.partset9, i250* %dst_3, align 1
  br label %dst.addr.927.exit

dst.addr.927.exit:                                ; preds = %dst.addr.927.case.3, %dst.addr.927.case.2, %dst.addr.927.case.1, %dst.addr.927.case.0, %dst.addr.825.exit
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 10
  %257 = bitcast i1* %src.addr.1028 to i8*
  %258 = load i8, i8* %257
  %259 = trunc i8 %258 to i1
  switch i64 %for.loop.idx95, label %dst.addr.1029.exit [
    i64 0, label %dst.addr.1029.case.0
    i64 1, label %dst.addr.1029.case.1
    i64 2, label %dst.addr.1029.case.2
    i64 3, label %dst.addr.1029.case.3
  ]

dst.addr.1029.case.0:                             ; preds = %dst.addr.927.exit
  %260 = bitcast i250* %dst_0 to i256*
  %261 = load i256, i256* %260
  %262 = trunc i256 %261 to i250
  %263 = zext i1 %259 to i250
  %264 = shl i250 %263, 148
  %265 = and i250 %262, -356811923176489970264571492362373784095686657
  %.partset161 = or i250 %265, %264
  store i250 %.partset161, i250* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %266 = bitcast i250* %dst_1 to i256*
  %267 = load i256, i256* %266
  %268 = trunc i256 %267 to i250
  %269 = zext i1 %259 to i250
  %270 = shl i250 %269, 148
  %271 = and i250 %268, -356811923176489970264571492362373784095686657
  %.partset96 = or i250 %271, %270
  store i250 %.partset96, i250* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.2:                             ; preds = %dst.addr.927.exit
  %272 = bitcast i250* %dst_2 to i256*
  %273 = load i256, i256* %272
  %274 = trunc i256 %273 to i250
  %275 = zext i1 %259 to i250
  %276 = shl i250 %275, 148
  %277 = and i250 %274, -356811923176489970264571492362373784095686657
  %.partset75 = or i250 %277, %276
  store i250 %.partset75, i250* %dst_2, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.3:                             ; preds = %dst.addr.927.exit
  %278 = bitcast i250* %dst_3 to i256*
  %279 = load i256, i256* %278
  %280 = trunc i256 %279 to i250
  %281 = zext i1 %259 to i250
  %282 = shl i250 %281, 148
  %283 = and i250 %280, -356811923176489970264571492362373784095686657
  %.partset10 = or i250 %283, %282
  store i250 %.partset10, i250* %dst_3, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.exit:                               ; preds = %dst.addr.1029.case.3, %dst.addr.1029.case.2, %dst.addr.1029.case.1, %dst.addr.1029.case.0, %dst.addr.927.exit
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 11
  %284 = load i8, i8* %src.addr.1130, align 1
  switch i64 %for.loop.idx95, label %dst.addr.1131.exit [
    i64 0, label %dst.addr.1131.case.0
    i64 1, label %dst.addr.1131.case.1
    i64 2, label %dst.addr.1131.case.2
    i64 3, label %dst.addr.1131.case.3
  ]

dst.addr.1131.case.0:                             ; preds = %dst.addr.1029.exit
  %285 = bitcast i250* %dst_0 to i256*
  %286 = load i256, i256* %285
  %287 = trunc i256 %286 to i250
  %288 = zext i8 %284 to i250
  %289 = shl i250 %288, 149
  %290 = and i250 %287, -181974080820009884834931461104810629888800194561
  %.partset160 = or i250 %290, %289
  store i250 %.partset160, i250* %dst_0, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %291 = bitcast i250* %dst_1 to i256*
  %292 = load i256, i256* %291
  %293 = trunc i256 %292 to i250
  %294 = zext i8 %284 to i250
  %295 = shl i250 %294, 149
  %296 = and i250 %293, -181974080820009884834931461104810629888800194561
  %.partset97 = or i250 %296, %295
  store i250 %.partset97, i250* %dst_1, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.2:                             ; preds = %dst.addr.1029.exit
  %297 = bitcast i250* %dst_2 to i256*
  %298 = load i256, i256* %297
  %299 = trunc i256 %298 to i250
  %300 = zext i8 %284 to i250
  %301 = shl i250 %300, 149
  %302 = and i250 %299, -181974080820009884834931461104810629888800194561
  %.partset74 = or i250 %302, %301
  store i250 %.partset74, i250* %dst_2, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.3:                             ; preds = %dst.addr.1029.exit
  %303 = bitcast i250* %dst_3 to i256*
  %304 = load i256, i256* %303
  %305 = trunc i256 %304 to i250
  %306 = zext i8 %284 to i250
  %307 = shl i250 %306, 149
  %308 = and i250 %305, -181974080820009884834931461104810629888800194561
  %.partset11 = or i250 %308, %307
  store i250 %.partset11, i250* %dst_3, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.exit:                               ; preds = %dst.addr.1131.case.3, %dst.addr.1131.case.2, %dst.addr.1131.case.1, %dst.addr.1131.case.0, %dst.addr.1029.exit
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 12
  %309 = load i32, i32* %src.addr.1232, align 4
  switch i64 %for.loop.idx95, label %dst.addr.1233.exit [
    i64 0, label %dst.addr.1233.case.0
    i64 1, label %dst.addr.1233.case.1
    i64 2, label %dst.addr.1233.case.2
    i64 3, label %dst.addr.1233.case.3
  ]

dst.addr.1233.case.0:                             ; preds = %dst.addr.1131.exit
  %310 = bitcast i250* %dst_0 to i256*
  %311 = load i256, i256* %310
  %312 = trunc i256 %311 to i250
  %313 = zext i32 %309 to i250
  %314 = shl i250 %313, 157
  %315 = and i250 %312, -784637716740647390813110813125497697923259053101012746241
  %.partset159 = or i250 %315, %314
  store i250 %.partset159, i250* %dst_0, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %316 = bitcast i250* %dst_1 to i256*
  %317 = load i256, i256* %316
  %318 = trunc i256 %317 to i250
  %319 = zext i32 %309 to i250
  %320 = shl i250 %319, 157
  %321 = and i250 %318, -784637716740647390813110813125497697923259053101012746241
  %.partset98 = or i250 %321, %320
  store i250 %.partset98, i250* %dst_1, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.2:                             ; preds = %dst.addr.1131.exit
  %322 = bitcast i250* %dst_2 to i256*
  %323 = load i256, i256* %322
  %324 = trunc i256 %323 to i250
  %325 = zext i32 %309 to i250
  %326 = shl i250 %325, 157
  %327 = and i250 %324, -784637716740647390813110813125497697923259053101012746241
  %.partset73 = or i250 %327, %326
  store i250 %.partset73, i250* %dst_2, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.3:                             ; preds = %dst.addr.1131.exit
  %328 = bitcast i250* %dst_3 to i256*
  %329 = load i256, i256* %328
  %330 = trunc i256 %329 to i250
  %331 = zext i32 %309 to i250
  %332 = shl i250 %331, 157
  %333 = and i250 %330, -784637716740647390813110813125497697923259053101012746241
  %.partset12 = or i250 %333, %332
  store i250 %.partset12, i250* %dst_3, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.exit:                               ; preds = %dst.addr.1233.case.3, %dst.addr.1233.case.2, %dst.addr.1233.case.1, %dst.addr.1233.case.0, %dst.addr.1131.exit
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 13
  %334 = load i32, i32* %src.addr.1334, align 4
  switch i64 %for.loop.idx95, label %dst.addr.1335.exit [
    i64 0, label %dst.addr.1335.case.0
    i64 1, label %dst.addr.1335.case.1
    i64 2, label %dst.addr.1335.case.2
    i64 3, label %dst.addr.1335.case.3
  ]

dst.addr.1335.case.0:                             ; preds = %dst.addr.1233.exit
  %335 = bitcast i250* %dst_0 to i256*
  %336 = load i256, i256* %335
  %337 = trunc i256 %336 to i250
  %338 = zext i32 %334 to i250
  %339 = shl i250 %338, 189
  %340 = and i250 %337, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset158 = or i250 %340, %339
  store i250 %.partset158, i250* %dst_0, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %341 = bitcast i250* %dst_1 to i256*
  %342 = load i256, i256* %341
  %343 = trunc i256 %342 to i250
  %344 = zext i32 %334 to i250
  %345 = shl i250 %344, 189
  %346 = and i250 %343, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset99 = or i250 %346, %345
  store i250 %.partset99, i250* %dst_1, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.2:                             ; preds = %dst.addr.1233.exit
  %347 = bitcast i250* %dst_2 to i256*
  %348 = load i256, i256* %347
  %349 = trunc i256 %348 to i250
  %350 = zext i32 %334 to i250
  %351 = shl i250 %350, 189
  %352 = and i250 %349, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset72 = or i250 %352, %351
  store i250 %.partset72, i250* %dst_2, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.3:                             ; preds = %dst.addr.1233.exit
  %353 = bitcast i250* %dst_3 to i256*
  %354 = load i256, i256* %353
  %355 = trunc i256 %354 to i250
  %356 = zext i32 %334 to i250
  %357 = shl i250 %356, 189
  %358 = and i250 %355, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset13 = or i250 %358, %357
  store i250 %.partset13, i250* %dst_3, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.exit:                               ; preds = %dst.addr.1335.case.3, %dst.addr.1335.case.2, %dst.addr.1335.case.1, %dst.addr.1335.case.0, %dst.addr.1233.exit
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 14
  %359 = bitcast i1* %src.addr.1436 to i8*
  %360 = load i8, i8* %359
  %361 = trunc i8 %360 to i1
  switch i64 %for.loop.idx95, label %dst.addr.1437.exit [
    i64 0, label %dst.addr.1437.case.0
    i64 1, label %dst.addr.1437.case.1
    i64 2, label %dst.addr.1437.case.2
    i64 3, label %dst.addr.1437.case.3
  ]

dst.addr.1437.case.0:                             ; preds = %dst.addr.1335.exit
  %362 = bitcast i250* %dst_0 to i256*
  %363 = load i256, i256* %362
  %364 = trunc i256 %363 to i250
  %365 = zext i1 %361 to i250
  %366 = shl i250 %365, 221
  %367 = and i250 %364, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset157 = or i250 %367, %366
  store i250 %.partset157, i250* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %368 = bitcast i250* %dst_1 to i256*
  %369 = load i256, i256* %368
  %370 = trunc i256 %369 to i250
  %371 = zext i1 %361 to i250
  %372 = shl i250 %371, 221
  %373 = and i250 %370, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset100 = or i250 %373, %372
  store i250 %.partset100, i250* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.2:                             ; preds = %dst.addr.1335.exit
  %374 = bitcast i250* %dst_2 to i256*
  %375 = load i256, i256* %374
  %376 = trunc i256 %375 to i250
  %377 = zext i1 %361 to i250
  %378 = shl i250 %377, 221
  %379 = and i250 %376, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset71 = or i250 %379, %378
  store i250 %.partset71, i250* %dst_2, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.3:                             ; preds = %dst.addr.1335.exit
  %380 = bitcast i250* %dst_3 to i256*
  %381 = load i256, i256* %380
  %382 = trunc i256 %381 to i250
  %383 = zext i1 %361 to i250
  %384 = shl i250 %383, 221
  %385 = and i250 %382, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset14 = or i250 %385, %384
  store i250 %.partset14, i250* %dst_3, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.exit:                               ; preds = %dst.addr.1437.case.3, %dst.addr.1437.case.2, %dst.addr.1437.case.1, %dst.addr.1437.case.0, %dst.addr.1335.exit
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 15
  %386 = bitcast i1* %src.addr.1538 to i8*
  %387 = load i8, i8* %386
  %388 = trunc i8 %387 to i1
  switch i64 %for.loop.idx95, label %dst.addr.1539.exit [
    i64 0, label %dst.addr.1539.case.0
    i64 1, label %dst.addr.1539.case.1
    i64 2, label %dst.addr.1539.case.2
    i64 3, label %dst.addr.1539.case.3
  ]

dst.addr.1539.case.0:                             ; preds = %dst.addr.1437.exit
  %389 = bitcast i250* %dst_0 to i256*
  %390 = load i256, i256* %389
  %391 = trunc i256 %390 to i250
  %392 = zext i1 %388 to i250
  %393 = shl i250 %392, 222
  %394 = and i250 %391, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset156 = or i250 %394, %393
  store i250 %.partset156, i250* %dst_0, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %395 = bitcast i250* %dst_1 to i256*
  %396 = load i256, i256* %395
  %397 = trunc i256 %396 to i250
  %398 = zext i1 %388 to i250
  %399 = shl i250 %398, 222
  %400 = and i250 %397, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset101 = or i250 %400, %399
  store i250 %.partset101, i250* %dst_1, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.2:                             ; preds = %dst.addr.1437.exit
  %401 = bitcast i250* %dst_2 to i256*
  %402 = load i256, i256* %401
  %403 = trunc i256 %402 to i250
  %404 = zext i1 %388 to i250
  %405 = shl i250 %404, 222
  %406 = and i250 %403, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset70 = or i250 %406, %405
  store i250 %.partset70, i250* %dst_2, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.3:                             ; preds = %dst.addr.1437.exit
  %407 = bitcast i250* %dst_3 to i256*
  %408 = load i256, i256* %407
  %409 = trunc i256 %408 to i250
  %410 = zext i1 %388 to i250
  %411 = shl i250 %410, 222
  %412 = and i250 %409, -6739986666787659948666753771754907668409286105635143120275902562305
  %.partset15 = or i250 %412, %411
  store i250 %.partset15, i250* %dst_3, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.exit:                               ; preds = %dst.addr.1539.case.3, %dst.addr.1539.case.2, %dst.addr.1539.case.1, %dst.addr.1539.case.0, %dst.addr.1437.exit
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 16
  %413 = bitcast i1* %src.addr.1640 to i8*
  %414 = load i8, i8* %413
  %415 = trunc i8 %414 to i1
  switch i64 %for.loop.idx95, label %dst.addr.1641.exit [
    i64 0, label %dst.addr.1641.case.0
    i64 1, label %dst.addr.1641.case.1
    i64 2, label %dst.addr.1641.case.2
    i64 3, label %dst.addr.1641.case.3
  ]

dst.addr.1641.case.0:                             ; preds = %dst.addr.1539.exit
  %416 = bitcast i250* %dst_0 to i256*
  %417 = load i256, i256* %416
  %418 = trunc i256 %417 to i250
  %419 = zext i1 %415 to i250
  %420 = shl i250 %419, 223
  %421 = and i250 %418, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset155 = or i250 %421, %420
  store i250 %.partset155, i250* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %422 = bitcast i250* %dst_1 to i256*
  %423 = load i256, i256* %422
  %424 = trunc i256 %423 to i250
  %425 = zext i1 %415 to i250
  %426 = shl i250 %425, 223
  %427 = and i250 %424, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset102 = or i250 %427, %426
  store i250 %.partset102, i250* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.2:                             ; preds = %dst.addr.1539.exit
  %428 = bitcast i250* %dst_2 to i256*
  %429 = load i256, i256* %428
  %430 = trunc i256 %429 to i250
  %431 = zext i1 %415 to i250
  %432 = shl i250 %431, 223
  %433 = and i250 %430, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset69 = or i250 %433, %432
  store i250 %.partset69, i250* %dst_2, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.3:                             ; preds = %dst.addr.1539.exit
  %434 = bitcast i250* %dst_3 to i256*
  %435 = load i256, i256* %434
  %436 = trunc i256 %435 to i250
  %437 = zext i1 %415 to i250
  %438 = shl i250 %437, 223
  %439 = and i250 %436, -13479973333575319897333507543509815336818572211270286240551805124609
  %.partset16 = or i250 %439, %438
  store i250 %.partset16, i250* %dst_3, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.exit:                               ; preds = %dst.addr.1641.case.3, %dst.addr.1641.case.2, %dst.addr.1641.case.1, %dst.addr.1641.case.0, %dst.addr.1539.exit
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 17
  %440 = bitcast i1* %src.addr.1742 to i8*
  %441 = load i8, i8* %440
  %442 = trunc i8 %441 to i1
  switch i64 %for.loop.idx95, label %dst.addr.1743.exit [
    i64 0, label %dst.addr.1743.case.0
    i64 1, label %dst.addr.1743.case.1
    i64 2, label %dst.addr.1743.case.2
    i64 3, label %dst.addr.1743.case.3
  ]

dst.addr.1743.case.0:                             ; preds = %dst.addr.1641.exit
  %443 = bitcast i250* %dst_0 to i256*
  %444 = load i256, i256* %443
  %445 = trunc i256 %444 to i250
  %446 = zext i1 %442 to i250
  %447 = shl i250 %446, 224
  %448 = and i250 %445, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset154 = or i250 %448, %447
  store i250 %.partset154, i250* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %449 = bitcast i250* %dst_1 to i256*
  %450 = load i256, i256* %449
  %451 = trunc i256 %450 to i250
  %452 = zext i1 %442 to i250
  %453 = shl i250 %452, 224
  %454 = and i250 %451, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset103 = or i250 %454, %453
  store i250 %.partset103, i250* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.2:                             ; preds = %dst.addr.1641.exit
  %455 = bitcast i250* %dst_2 to i256*
  %456 = load i256, i256* %455
  %457 = trunc i256 %456 to i250
  %458 = zext i1 %442 to i250
  %459 = shl i250 %458, 224
  %460 = and i250 %457, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset68 = or i250 %460, %459
  store i250 %.partset68, i250* %dst_2, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.3:                             ; preds = %dst.addr.1641.exit
  %461 = bitcast i250* %dst_3 to i256*
  %462 = load i256, i256* %461
  %463 = trunc i256 %462 to i250
  %464 = zext i1 %442 to i250
  %465 = shl i250 %464, 224
  %466 = and i250 %463, -26959946667150639794667015087019630673637144422540572481103610249217
  %.partset17 = or i250 %466, %465
  store i250 %.partset17, i250* %dst_3, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.exit:                               ; preds = %dst.addr.1743.case.3, %dst.addr.1743.case.2, %dst.addr.1743.case.1, %dst.addr.1743.case.0, %dst.addr.1641.exit
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 18
  %467 = bitcast i1* %src.addr.1844 to i8*
  %468 = load i8, i8* %467
  %469 = trunc i8 %468 to i1
  switch i64 %for.loop.idx95, label %dst.addr.1845.exit [
    i64 0, label %dst.addr.1845.case.0
    i64 1, label %dst.addr.1845.case.1
    i64 2, label %dst.addr.1845.case.2
    i64 3, label %dst.addr.1845.case.3
  ]

dst.addr.1845.case.0:                             ; preds = %dst.addr.1743.exit
  %470 = bitcast i250* %dst_0 to i256*
  %471 = load i256, i256* %470
  %472 = trunc i256 %471 to i250
  %473 = zext i1 %469 to i250
  %474 = shl i250 %473, 225
  %475 = and i250 %472, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset153 = or i250 %475, %474
  store i250 %.partset153, i250* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %476 = bitcast i250* %dst_1 to i256*
  %477 = load i256, i256* %476
  %478 = trunc i256 %477 to i250
  %479 = zext i1 %469 to i250
  %480 = shl i250 %479, 225
  %481 = and i250 %478, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset104 = or i250 %481, %480
  store i250 %.partset104, i250* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.2:                             ; preds = %dst.addr.1743.exit
  %482 = bitcast i250* %dst_2 to i256*
  %483 = load i256, i256* %482
  %484 = trunc i256 %483 to i250
  %485 = zext i1 %469 to i250
  %486 = shl i250 %485, 225
  %487 = and i250 %484, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset67 = or i250 %487, %486
  store i250 %.partset67, i250* %dst_2, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.3:                             ; preds = %dst.addr.1743.exit
  %488 = bitcast i250* %dst_3 to i256*
  %489 = load i256, i256* %488
  %490 = trunc i256 %489 to i250
  %491 = zext i1 %469 to i250
  %492 = shl i250 %491, 225
  %493 = and i250 %490, -53919893334301279589334030174039261347274288845081144962207220498433
  %.partset18 = or i250 %493, %492
  store i250 %.partset18, i250* %dst_3, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.exit:                               ; preds = %dst.addr.1845.case.3, %dst.addr.1845.case.2, %dst.addr.1845.case.1, %dst.addr.1845.case.0, %dst.addr.1743.exit
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 19
  %494 = bitcast i1* %src.addr.1946 to i8*
  %495 = load i8, i8* %494
  %496 = trunc i8 %495 to i1
  switch i64 %for.loop.idx95, label %dst.addr.1947.exit [
    i64 0, label %dst.addr.1947.case.0
    i64 1, label %dst.addr.1947.case.1
    i64 2, label %dst.addr.1947.case.2
    i64 3, label %dst.addr.1947.case.3
  ]

dst.addr.1947.case.0:                             ; preds = %dst.addr.1845.exit
  %497 = bitcast i250* %dst_0 to i256*
  %498 = load i256, i256* %497
  %499 = trunc i256 %498 to i250
  %500 = zext i1 %496 to i250
  %501 = shl i250 %500, 226
  %502 = and i250 %499, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset152 = or i250 %502, %501
  store i250 %.partset152, i250* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %503 = bitcast i250* %dst_1 to i256*
  %504 = load i256, i256* %503
  %505 = trunc i256 %504 to i250
  %506 = zext i1 %496 to i250
  %507 = shl i250 %506, 226
  %508 = and i250 %505, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset105 = or i250 %508, %507
  store i250 %.partset105, i250* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.2:                             ; preds = %dst.addr.1845.exit
  %509 = bitcast i250* %dst_2 to i256*
  %510 = load i256, i256* %509
  %511 = trunc i256 %510 to i250
  %512 = zext i1 %496 to i250
  %513 = shl i250 %512, 226
  %514 = and i250 %511, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset66 = or i250 %514, %513
  store i250 %.partset66, i250* %dst_2, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.3:                             ; preds = %dst.addr.1845.exit
  %515 = bitcast i250* %dst_3 to i256*
  %516 = load i256, i256* %515
  %517 = trunc i256 %516 to i250
  %518 = zext i1 %496 to i250
  %519 = shl i250 %518, 226
  %520 = and i250 %517, -107839786668602559178668060348078522694548577690162289924414440996865
  %.partset19 = or i250 %520, %519
  store i250 %.partset19, i250* %dst_3, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.exit:                               ; preds = %dst.addr.1947.case.3, %dst.addr.1947.case.2, %dst.addr.1947.case.1, %dst.addr.1947.case.0, %dst.addr.1845.exit
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 20
  %521 = bitcast i1* %src.addr.2048 to i8*
  %522 = load i8, i8* %521
  %523 = trunc i8 %522 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2049.exit [
    i64 0, label %dst.addr.2049.case.0
    i64 1, label %dst.addr.2049.case.1
    i64 2, label %dst.addr.2049.case.2
    i64 3, label %dst.addr.2049.case.3
  ]

dst.addr.2049.case.0:                             ; preds = %dst.addr.1947.exit
  %524 = bitcast i250* %dst_0 to i256*
  %525 = load i256, i256* %524
  %526 = trunc i256 %525 to i250
  %527 = zext i1 %523 to i250
  %528 = shl i250 %527, 227
  %529 = and i250 %526, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset151 = or i250 %529, %528
  store i250 %.partset151, i250* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %530 = bitcast i250* %dst_1 to i256*
  %531 = load i256, i256* %530
  %532 = trunc i256 %531 to i250
  %533 = zext i1 %523 to i250
  %534 = shl i250 %533, 227
  %535 = and i250 %532, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset106 = or i250 %535, %534
  store i250 %.partset106, i250* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.2:                             ; preds = %dst.addr.1947.exit
  %536 = bitcast i250* %dst_2 to i256*
  %537 = load i256, i256* %536
  %538 = trunc i256 %537 to i250
  %539 = zext i1 %523 to i250
  %540 = shl i250 %539, 227
  %541 = and i250 %538, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset65 = or i250 %541, %540
  store i250 %.partset65, i250* %dst_2, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.3:                             ; preds = %dst.addr.1947.exit
  %542 = bitcast i250* %dst_3 to i256*
  %543 = load i256, i256* %542
  %544 = trunc i256 %543 to i250
  %545 = zext i1 %523 to i250
  %546 = shl i250 %545, 227
  %547 = and i250 %544, -215679573337205118357336120696157045389097155380324579848828881993729
  %.partset20 = or i250 %547, %546
  store i250 %.partset20, i250* %dst_3, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.exit:                               ; preds = %dst.addr.2049.case.3, %dst.addr.2049.case.2, %dst.addr.2049.case.1, %dst.addr.2049.case.0, %dst.addr.1947.exit
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 21
  %548 = bitcast i1* %src.addr.2150 to i8*
  %549 = load i8, i8* %548
  %550 = trunc i8 %549 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2151.exit [
    i64 0, label %dst.addr.2151.case.0
    i64 1, label %dst.addr.2151.case.1
    i64 2, label %dst.addr.2151.case.2
    i64 3, label %dst.addr.2151.case.3
  ]

dst.addr.2151.case.0:                             ; preds = %dst.addr.2049.exit
  %551 = bitcast i250* %dst_0 to i256*
  %552 = load i256, i256* %551
  %553 = trunc i256 %552 to i250
  %554 = zext i1 %550 to i250
  %555 = shl i250 %554, 228
  %556 = and i250 %553, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset150 = or i250 %556, %555
  store i250 %.partset150, i250* %dst_0, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.1:                             ; preds = %dst.addr.2049.exit
  %557 = bitcast i250* %dst_1 to i256*
  %558 = load i256, i256* %557
  %559 = trunc i256 %558 to i250
  %560 = zext i1 %550 to i250
  %561 = shl i250 %560, 228
  %562 = and i250 %559, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset107 = or i250 %562, %561
  store i250 %.partset107, i250* %dst_1, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.2:                             ; preds = %dst.addr.2049.exit
  %563 = bitcast i250* %dst_2 to i256*
  %564 = load i256, i256* %563
  %565 = trunc i256 %564 to i250
  %566 = zext i1 %550 to i250
  %567 = shl i250 %566, 228
  %568 = and i250 %565, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset64 = or i250 %568, %567
  store i250 %.partset64, i250* %dst_2, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.3:                             ; preds = %dst.addr.2049.exit
  %569 = bitcast i250* %dst_3 to i256*
  %570 = load i256, i256* %569
  %571 = trunc i256 %570 to i250
  %572 = zext i1 %550 to i250
  %573 = shl i250 %572, 228
  %574 = and i250 %571, -431359146674410236714672241392314090778194310760649159697657763987457
  %.partset21 = or i250 %574, %573
  store i250 %.partset21, i250* %dst_3, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.exit:                               ; preds = %dst.addr.2151.case.3, %dst.addr.2151.case.2, %dst.addr.2151.case.1, %dst.addr.2151.case.0, %dst.addr.2049.exit
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 22
  %575 = bitcast i1* %src.addr.2252 to i8*
  %576 = load i8, i8* %575
  %577 = trunc i8 %576 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2253.exit [
    i64 0, label %dst.addr.2253.case.0
    i64 1, label %dst.addr.2253.case.1
    i64 2, label %dst.addr.2253.case.2
    i64 3, label %dst.addr.2253.case.3
  ]

dst.addr.2253.case.0:                             ; preds = %dst.addr.2151.exit
  %578 = bitcast i250* %dst_0 to i256*
  %579 = load i256, i256* %578
  %580 = trunc i256 %579 to i250
  %581 = zext i1 %577 to i250
  %582 = shl i250 %581, 229
  %583 = and i250 %580, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset149 = or i250 %583, %582
  store i250 %.partset149, i250* %dst_0, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.1:                             ; preds = %dst.addr.2151.exit
  %584 = bitcast i250* %dst_1 to i256*
  %585 = load i256, i256* %584
  %586 = trunc i256 %585 to i250
  %587 = zext i1 %577 to i250
  %588 = shl i250 %587, 229
  %589 = and i250 %586, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset108 = or i250 %589, %588
  store i250 %.partset108, i250* %dst_1, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.2:                             ; preds = %dst.addr.2151.exit
  %590 = bitcast i250* %dst_2 to i256*
  %591 = load i256, i256* %590
  %592 = trunc i256 %591 to i250
  %593 = zext i1 %577 to i250
  %594 = shl i250 %593, 229
  %595 = and i250 %592, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset63 = or i250 %595, %594
  store i250 %.partset63, i250* %dst_2, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.3:                             ; preds = %dst.addr.2151.exit
  %596 = bitcast i250* %dst_3 to i256*
  %597 = load i256, i256* %596
  %598 = trunc i256 %597 to i250
  %599 = zext i1 %577 to i250
  %600 = shl i250 %599, 229
  %601 = and i250 %598, -862718293348820473429344482784628181556388621521298319395315527974913
  %.partset22 = or i250 %601, %600
  store i250 %.partset22, i250* %dst_3, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.exit:                               ; preds = %dst.addr.2253.case.3, %dst.addr.2253.case.2, %dst.addr.2253.case.1, %dst.addr.2253.case.0, %dst.addr.2151.exit
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 23
  %602 = bitcast i1* %src.addr.2354 to i8*
  %603 = load i8, i8* %602
  %604 = trunc i8 %603 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2355.exit [
    i64 0, label %dst.addr.2355.case.0
    i64 1, label %dst.addr.2355.case.1
    i64 2, label %dst.addr.2355.case.2
    i64 3, label %dst.addr.2355.case.3
  ]

dst.addr.2355.case.0:                             ; preds = %dst.addr.2253.exit
  %605 = bitcast i250* %dst_0 to i256*
  %606 = load i256, i256* %605
  %607 = trunc i256 %606 to i250
  %608 = zext i1 %604 to i250
  %609 = shl i250 %608, 230
  %610 = and i250 %607, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset148 = or i250 %610, %609
  store i250 %.partset148, i250* %dst_0, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.1:                             ; preds = %dst.addr.2253.exit
  %611 = bitcast i250* %dst_1 to i256*
  %612 = load i256, i256* %611
  %613 = trunc i256 %612 to i250
  %614 = zext i1 %604 to i250
  %615 = shl i250 %614, 230
  %616 = and i250 %613, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset109 = or i250 %616, %615
  store i250 %.partset109, i250* %dst_1, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.2:                             ; preds = %dst.addr.2253.exit
  %617 = bitcast i250* %dst_2 to i256*
  %618 = load i256, i256* %617
  %619 = trunc i256 %618 to i250
  %620 = zext i1 %604 to i250
  %621 = shl i250 %620, 230
  %622 = and i250 %619, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset62 = or i250 %622, %621
  store i250 %.partset62, i250* %dst_2, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.3:                             ; preds = %dst.addr.2253.exit
  %623 = bitcast i250* %dst_3 to i256*
  %624 = load i256, i256* %623
  %625 = trunc i256 %624 to i250
  %626 = zext i1 %604 to i250
  %627 = shl i250 %626, 230
  %628 = and i250 %625, -1725436586697640946858688965569256363112777243042596638790631055949825
  %.partset23 = or i250 %628, %627
  store i250 %.partset23, i250* %dst_3, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.exit:                               ; preds = %dst.addr.2355.case.3, %dst.addr.2355.case.2, %dst.addr.2355.case.1, %dst.addr.2355.case.0, %dst.addr.2253.exit
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 24
  %629 = bitcast i1* %src.addr.2456 to i8*
  %630 = load i8, i8* %629
  %631 = trunc i8 %630 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2457.exit [
    i64 0, label %dst.addr.2457.case.0
    i64 1, label %dst.addr.2457.case.1
    i64 2, label %dst.addr.2457.case.2
    i64 3, label %dst.addr.2457.case.3
  ]

dst.addr.2457.case.0:                             ; preds = %dst.addr.2355.exit
  %632 = bitcast i250* %dst_0 to i256*
  %633 = load i256, i256* %632
  %634 = trunc i256 %633 to i250
  %635 = zext i1 %631 to i250
  %636 = shl i250 %635, 231
  %637 = and i250 %634, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset147 = or i250 %637, %636
  store i250 %.partset147, i250* %dst_0, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.1:                             ; preds = %dst.addr.2355.exit
  %638 = bitcast i250* %dst_1 to i256*
  %639 = load i256, i256* %638
  %640 = trunc i256 %639 to i250
  %641 = zext i1 %631 to i250
  %642 = shl i250 %641, 231
  %643 = and i250 %640, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset110 = or i250 %643, %642
  store i250 %.partset110, i250* %dst_1, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.2:                             ; preds = %dst.addr.2355.exit
  %644 = bitcast i250* %dst_2 to i256*
  %645 = load i256, i256* %644
  %646 = trunc i256 %645 to i250
  %647 = zext i1 %631 to i250
  %648 = shl i250 %647, 231
  %649 = and i250 %646, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset61 = or i250 %649, %648
  store i250 %.partset61, i250* %dst_2, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.3:                             ; preds = %dst.addr.2355.exit
  %650 = bitcast i250* %dst_3 to i256*
  %651 = load i256, i256* %650
  %652 = trunc i256 %651 to i250
  %653 = zext i1 %631 to i250
  %654 = shl i250 %653, 231
  %655 = and i250 %652, -3450873173395281893717377931138512726225554486085193277581262111899649
  %.partset24 = or i250 %655, %654
  store i250 %.partset24, i250* %dst_3, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.exit:                               ; preds = %dst.addr.2457.case.3, %dst.addr.2457.case.2, %dst.addr.2457.case.1, %dst.addr.2457.case.0, %dst.addr.2355.exit
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 25
  %656 = bitcast i1* %src.addr.2558 to i8*
  %657 = load i8, i8* %656
  %658 = trunc i8 %657 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2559.exit [
    i64 0, label %dst.addr.2559.case.0
    i64 1, label %dst.addr.2559.case.1
    i64 2, label %dst.addr.2559.case.2
    i64 3, label %dst.addr.2559.case.3
  ]

dst.addr.2559.case.0:                             ; preds = %dst.addr.2457.exit
  %659 = bitcast i250* %dst_0 to i256*
  %660 = load i256, i256* %659
  %661 = trunc i256 %660 to i250
  %662 = zext i1 %658 to i250
  %663 = shl i250 %662, 232
  %664 = and i250 %661, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset146 = or i250 %664, %663
  store i250 %.partset146, i250* %dst_0, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.1:                             ; preds = %dst.addr.2457.exit
  %665 = bitcast i250* %dst_1 to i256*
  %666 = load i256, i256* %665
  %667 = trunc i256 %666 to i250
  %668 = zext i1 %658 to i250
  %669 = shl i250 %668, 232
  %670 = and i250 %667, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset111 = or i250 %670, %669
  store i250 %.partset111, i250* %dst_1, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.2:                             ; preds = %dst.addr.2457.exit
  %671 = bitcast i250* %dst_2 to i256*
  %672 = load i256, i256* %671
  %673 = trunc i256 %672 to i250
  %674 = zext i1 %658 to i250
  %675 = shl i250 %674, 232
  %676 = and i250 %673, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset60 = or i250 %676, %675
  store i250 %.partset60, i250* %dst_2, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.3:                             ; preds = %dst.addr.2457.exit
  %677 = bitcast i250* %dst_3 to i256*
  %678 = load i256, i256* %677
  %679 = trunc i256 %678 to i250
  %680 = zext i1 %658 to i250
  %681 = shl i250 %680, 232
  %682 = and i250 %679, -6901746346790563787434755862277025452451108972170386555162524223799297
  %.partset25 = or i250 %682, %681
  store i250 %.partset25, i250* %dst_3, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.exit:                               ; preds = %dst.addr.2559.case.3, %dst.addr.2559.case.2, %dst.addr.2559.case.1, %dst.addr.2559.case.0, %dst.addr.2457.exit
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 26
  %683 = bitcast i1* %src.addr.2660 to i8*
  %684 = load i8, i8* %683
  %685 = trunc i8 %684 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2661.exit [
    i64 0, label %dst.addr.2661.case.0
    i64 1, label %dst.addr.2661.case.1
    i64 2, label %dst.addr.2661.case.2
    i64 3, label %dst.addr.2661.case.3
  ]

dst.addr.2661.case.0:                             ; preds = %dst.addr.2559.exit
  %686 = bitcast i250* %dst_0 to i256*
  %687 = load i256, i256* %686
  %688 = trunc i256 %687 to i250
  %689 = zext i1 %685 to i250
  %690 = shl i250 %689, 233
  %691 = and i250 %688, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset145 = or i250 %691, %690
  store i250 %.partset145, i250* %dst_0, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.1:                             ; preds = %dst.addr.2559.exit
  %692 = bitcast i250* %dst_1 to i256*
  %693 = load i256, i256* %692
  %694 = trunc i256 %693 to i250
  %695 = zext i1 %685 to i250
  %696 = shl i250 %695, 233
  %697 = and i250 %694, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset112 = or i250 %697, %696
  store i250 %.partset112, i250* %dst_1, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.2:                             ; preds = %dst.addr.2559.exit
  %698 = bitcast i250* %dst_2 to i256*
  %699 = load i256, i256* %698
  %700 = trunc i256 %699 to i250
  %701 = zext i1 %685 to i250
  %702 = shl i250 %701, 233
  %703 = and i250 %700, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset59 = or i250 %703, %702
  store i250 %.partset59, i250* %dst_2, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.3:                             ; preds = %dst.addr.2559.exit
  %704 = bitcast i250* %dst_3 to i256*
  %705 = load i256, i256* %704
  %706 = trunc i256 %705 to i250
  %707 = zext i1 %685 to i250
  %708 = shl i250 %707, 233
  %709 = and i250 %706, -13803492693581127574869511724554050904902217944340773110325048447598593
  %.partset26 = or i250 %709, %708
  store i250 %.partset26, i250* %dst_3, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.exit:                               ; preds = %dst.addr.2661.case.3, %dst.addr.2661.case.2, %dst.addr.2661.case.1, %dst.addr.2661.case.0, %dst.addr.2559.exit
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 27
  %710 = bitcast i1* %src.addr.2762 to i8*
  %711 = load i8, i8* %710
  %712 = trunc i8 %711 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2763.exit [
    i64 0, label %dst.addr.2763.case.0
    i64 1, label %dst.addr.2763.case.1
    i64 2, label %dst.addr.2763.case.2
    i64 3, label %dst.addr.2763.case.3
  ]

dst.addr.2763.case.0:                             ; preds = %dst.addr.2661.exit
  %713 = bitcast i250* %dst_0 to i256*
  %714 = load i256, i256* %713
  %715 = trunc i256 %714 to i250
  %716 = zext i1 %712 to i250
  %717 = shl i250 %716, 234
  %718 = and i250 %715, -27606985387162255149739023449108101809804435888681546220650096895197185
  %.partset144 = or i250 %718, %717
  store i250 %.partset144, i250* %dst_0, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.1:                             ; preds = %dst.addr.2661.exit
  %719 = bitcast i250* %dst_1 to i256*
  %720 = load i256, i256* %719
  %721 = trunc i256 %720 to i250
  %722 = zext i1 %712 to i250
  %723 = shl i250 %722, 234
  %724 = and i250 %721, -27606985387162255149739023449108101809804435888681546220650096895197185
  %.partset113 = or i250 %724, %723
  store i250 %.partset113, i250* %dst_1, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.2:                             ; preds = %dst.addr.2661.exit
  %725 = bitcast i250* %dst_2 to i256*
  %726 = load i256, i256* %725
  %727 = trunc i256 %726 to i250
  %728 = zext i1 %712 to i250
  %729 = shl i250 %728, 234
  %730 = and i250 %727, -27606985387162255149739023449108101809804435888681546220650096895197185
  %.partset58 = or i250 %730, %729
  store i250 %.partset58, i250* %dst_2, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.3:                             ; preds = %dst.addr.2661.exit
  %731 = bitcast i250* %dst_3 to i256*
  %732 = load i256, i256* %731
  %733 = trunc i256 %732 to i250
  %734 = zext i1 %712 to i250
  %735 = shl i250 %734, 234
  %736 = and i250 %733, -27606985387162255149739023449108101809804435888681546220650096895197185
  %.partset27 = or i250 %736, %735
  store i250 %.partset27, i250* %dst_3, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.exit:                               ; preds = %dst.addr.2763.case.3, %dst.addr.2763.case.2, %dst.addr.2763.case.1, %dst.addr.2763.case.0, %dst.addr.2661.exit
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 28
  %737 = bitcast i1* %src.addr.2864 to i8*
  %738 = load i8, i8* %737
  %739 = trunc i8 %738 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2865.exit [
    i64 0, label %dst.addr.2865.case.0
    i64 1, label %dst.addr.2865.case.1
    i64 2, label %dst.addr.2865.case.2
    i64 3, label %dst.addr.2865.case.3
  ]

dst.addr.2865.case.0:                             ; preds = %dst.addr.2763.exit
  %740 = bitcast i250* %dst_0 to i256*
  %741 = load i256, i256* %740
  %742 = trunc i256 %741 to i250
  %743 = zext i1 %739 to i250
  %744 = shl i250 %743, 235
  %745 = and i250 %742, -55213970774324510299478046898216203619608871777363092441300193790394369
  %.partset143 = or i250 %745, %744
  store i250 %.partset143, i250* %dst_0, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.1:                             ; preds = %dst.addr.2763.exit
  %746 = bitcast i250* %dst_1 to i256*
  %747 = load i256, i256* %746
  %748 = trunc i256 %747 to i250
  %749 = zext i1 %739 to i250
  %750 = shl i250 %749, 235
  %751 = and i250 %748, -55213970774324510299478046898216203619608871777363092441300193790394369
  %.partset114 = or i250 %751, %750
  store i250 %.partset114, i250* %dst_1, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.2:                             ; preds = %dst.addr.2763.exit
  %752 = bitcast i250* %dst_2 to i256*
  %753 = load i256, i256* %752
  %754 = trunc i256 %753 to i250
  %755 = zext i1 %739 to i250
  %756 = shl i250 %755, 235
  %757 = and i250 %754, -55213970774324510299478046898216203619608871777363092441300193790394369
  %.partset57 = or i250 %757, %756
  store i250 %.partset57, i250* %dst_2, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.3:                             ; preds = %dst.addr.2763.exit
  %758 = bitcast i250* %dst_3 to i256*
  %759 = load i256, i256* %758
  %760 = trunc i256 %759 to i250
  %761 = zext i1 %739 to i250
  %762 = shl i250 %761, 235
  %763 = and i250 %760, -55213970774324510299478046898216203619608871777363092441300193790394369
  %.partset28 = or i250 %763, %762
  store i250 %.partset28, i250* %dst_3, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.exit:                               ; preds = %dst.addr.2865.case.3, %dst.addr.2865.case.2, %dst.addr.2865.case.1, %dst.addr.2865.case.0, %dst.addr.2763.exit
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 29
  %764 = bitcast i1* %src.addr.2966 to i8*
  %765 = load i8, i8* %764
  %766 = trunc i8 %765 to i1
  switch i64 %for.loop.idx95, label %dst.addr.2967.exit [
    i64 0, label %dst.addr.2967.case.0
    i64 1, label %dst.addr.2967.case.1
    i64 2, label %dst.addr.2967.case.2
    i64 3, label %dst.addr.2967.case.3
  ]

dst.addr.2967.case.0:                             ; preds = %dst.addr.2865.exit
  %767 = bitcast i250* %dst_0 to i256*
  %768 = load i256, i256* %767
  %769 = trunc i256 %768 to i250
  %770 = zext i1 %766 to i250
  %771 = shl i250 %770, 236
  %772 = and i250 %769, -110427941548649020598956093796432407239217743554726184882600387580788737
  %.partset142 = or i250 %772, %771
  store i250 %.partset142, i250* %dst_0, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.1:                             ; preds = %dst.addr.2865.exit
  %773 = bitcast i250* %dst_1 to i256*
  %774 = load i256, i256* %773
  %775 = trunc i256 %774 to i250
  %776 = zext i1 %766 to i250
  %777 = shl i250 %776, 236
  %778 = and i250 %775, -110427941548649020598956093796432407239217743554726184882600387580788737
  %.partset115 = or i250 %778, %777
  store i250 %.partset115, i250* %dst_1, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.2:                             ; preds = %dst.addr.2865.exit
  %779 = bitcast i250* %dst_2 to i256*
  %780 = load i256, i256* %779
  %781 = trunc i256 %780 to i250
  %782 = zext i1 %766 to i250
  %783 = shl i250 %782, 236
  %784 = and i250 %781, -110427941548649020598956093796432407239217743554726184882600387580788737
  %.partset56 = or i250 %784, %783
  store i250 %.partset56, i250* %dst_2, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.3:                             ; preds = %dst.addr.2865.exit
  %785 = bitcast i250* %dst_3 to i256*
  %786 = load i256, i256* %785
  %787 = trunc i256 %786 to i250
  %788 = zext i1 %766 to i250
  %789 = shl i250 %788, 236
  %790 = and i250 %787, -110427941548649020598956093796432407239217743554726184882600387580788737
  %.partset29 = or i250 %790, %789
  store i250 %.partset29, i250* %dst_3, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.exit:                               ; preds = %dst.addr.2967.case.3, %dst.addr.2967.case.2, %dst.addr.2967.case.1, %dst.addr.2967.case.0, %dst.addr.2865.exit
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 30
  %791 = bitcast i1* %src.addr.3068 to i8*
  %792 = load i8, i8* %791
  %793 = trunc i8 %792 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3069.exit [
    i64 0, label %dst.addr.3069.case.0
    i64 1, label %dst.addr.3069.case.1
    i64 2, label %dst.addr.3069.case.2
    i64 3, label %dst.addr.3069.case.3
  ]

dst.addr.3069.case.0:                             ; preds = %dst.addr.2967.exit
  %794 = bitcast i250* %dst_0 to i256*
  %795 = load i256, i256* %794
  %796 = trunc i256 %795 to i250
  %797 = zext i1 %793 to i250
  %798 = shl i250 %797, 237
  %799 = and i250 %796, -220855883097298041197912187592864814478435487109452369765200775161577473
  %.partset141 = or i250 %799, %798
  store i250 %.partset141, i250* %dst_0, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.1:                             ; preds = %dst.addr.2967.exit
  %800 = bitcast i250* %dst_1 to i256*
  %801 = load i256, i256* %800
  %802 = trunc i256 %801 to i250
  %803 = zext i1 %793 to i250
  %804 = shl i250 %803, 237
  %805 = and i250 %802, -220855883097298041197912187592864814478435487109452369765200775161577473
  %.partset116 = or i250 %805, %804
  store i250 %.partset116, i250* %dst_1, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.2:                             ; preds = %dst.addr.2967.exit
  %806 = bitcast i250* %dst_2 to i256*
  %807 = load i256, i256* %806
  %808 = trunc i256 %807 to i250
  %809 = zext i1 %793 to i250
  %810 = shl i250 %809, 237
  %811 = and i250 %808, -220855883097298041197912187592864814478435487109452369765200775161577473
  %.partset55 = or i250 %811, %810
  store i250 %.partset55, i250* %dst_2, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.3:                             ; preds = %dst.addr.2967.exit
  %812 = bitcast i250* %dst_3 to i256*
  %813 = load i256, i256* %812
  %814 = trunc i256 %813 to i250
  %815 = zext i1 %793 to i250
  %816 = shl i250 %815, 237
  %817 = and i250 %814, -220855883097298041197912187592864814478435487109452369765200775161577473
  %.partset30 = or i250 %817, %816
  store i250 %.partset30, i250* %dst_3, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.exit:                               ; preds = %dst.addr.3069.case.3, %dst.addr.3069.case.2, %dst.addr.3069.case.1, %dst.addr.3069.case.0, %dst.addr.2967.exit
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 31
  %818 = bitcast i1* %src.addr.3170 to i8*
  %819 = load i8, i8* %818
  %820 = trunc i8 %819 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3171.exit [
    i64 0, label %dst.addr.3171.case.0
    i64 1, label %dst.addr.3171.case.1
    i64 2, label %dst.addr.3171.case.2
    i64 3, label %dst.addr.3171.case.3
  ]

dst.addr.3171.case.0:                             ; preds = %dst.addr.3069.exit
  %821 = bitcast i250* %dst_0 to i256*
  %822 = load i256, i256* %821
  %823 = trunc i256 %822 to i250
  %824 = zext i1 %820 to i250
  %825 = shl i250 %824, 238
  %826 = and i250 %823, -441711766194596082395824375185729628956870974218904739530401550323154945
  %.partset140 = or i250 %826, %825
  store i250 %.partset140, i250* %dst_0, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.1:                             ; preds = %dst.addr.3069.exit
  %827 = bitcast i250* %dst_1 to i256*
  %828 = load i256, i256* %827
  %829 = trunc i256 %828 to i250
  %830 = zext i1 %820 to i250
  %831 = shl i250 %830, 238
  %832 = and i250 %829, -441711766194596082395824375185729628956870974218904739530401550323154945
  %.partset117 = or i250 %832, %831
  store i250 %.partset117, i250* %dst_1, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.2:                             ; preds = %dst.addr.3069.exit
  %833 = bitcast i250* %dst_2 to i256*
  %834 = load i256, i256* %833
  %835 = trunc i256 %834 to i250
  %836 = zext i1 %820 to i250
  %837 = shl i250 %836, 238
  %838 = and i250 %835, -441711766194596082395824375185729628956870974218904739530401550323154945
  %.partset54 = or i250 %838, %837
  store i250 %.partset54, i250* %dst_2, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.3:                             ; preds = %dst.addr.3069.exit
  %839 = bitcast i250* %dst_3 to i256*
  %840 = load i256, i256* %839
  %841 = trunc i256 %840 to i250
  %842 = zext i1 %820 to i250
  %843 = shl i250 %842, 238
  %844 = and i250 %841, -441711766194596082395824375185729628956870974218904739530401550323154945
  %.partset31 = or i250 %844, %843
  store i250 %.partset31, i250* %dst_3, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.exit:                               ; preds = %dst.addr.3171.case.3, %dst.addr.3171.case.2, %dst.addr.3171.case.1, %dst.addr.3171.case.0, %dst.addr.3069.exit
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 32
  %845 = bitcast i1* %src.addr.3272 to i8*
  %846 = load i8, i8* %845
  %847 = trunc i8 %846 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3273.exit [
    i64 0, label %dst.addr.3273.case.0
    i64 1, label %dst.addr.3273.case.1
    i64 2, label %dst.addr.3273.case.2
    i64 3, label %dst.addr.3273.case.3
  ]

dst.addr.3273.case.0:                             ; preds = %dst.addr.3171.exit
  %848 = bitcast i250* %dst_0 to i256*
  %849 = load i256, i256* %848
  %850 = trunc i256 %849 to i250
  %851 = zext i1 %847 to i250
  %852 = shl i250 %851, 239
  %853 = and i250 %850, -883423532389192164791648750371459257913741948437809479060803100646309889
  %.partset139 = or i250 %853, %852
  store i250 %.partset139, i250* %dst_0, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.1:                             ; preds = %dst.addr.3171.exit
  %854 = bitcast i250* %dst_1 to i256*
  %855 = load i256, i256* %854
  %856 = trunc i256 %855 to i250
  %857 = zext i1 %847 to i250
  %858 = shl i250 %857, 239
  %859 = and i250 %856, -883423532389192164791648750371459257913741948437809479060803100646309889
  %.partset118 = or i250 %859, %858
  store i250 %.partset118, i250* %dst_1, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.2:                             ; preds = %dst.addr.3171.exit
  %860 = bitcast i250* %dst_2 to i256*
  %861 = load i256, i256* %860
  %862 = trunc i256 %861 to i250
  %863 = zext i1 %847 to i250
  %864 = shl i250 %863, 239
  %865 = and i250 %862, -883423532389192164791648750371459257913741948437809479060803100646309889
  %.partset53 = or i250 %865, %864
  store i250 %.partset53, i250* %dst_2, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.3:                             ; preds = %dst.addr.3171.exit
  %866 = bitcast i250* %dst_3 to i256*
  %867 = load i256, i256* %866
  %868 = trunc i256 %867 to i250
  %869 = zext i1 %847 to i250
  %870 = shl i250 %869, 239
  %871 = and i250 %868, -883423532389192164791648750371459257913741948437809479060803100646309889
  %.partset32 = or i250 %871, %870
  store i250 %.partset32, i250* %dst_3, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.exit:                               ; preds = %dst.addr.3273.case.3, %dst.addr.3273.case.2, %dst.addr.3273.case.1, %dst.addr.3273.case.0, %dst.addr.3171.exit
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 33
  %872 = bitcast i1* %src.addr.3374 to i8*
  %873 = load i8, i8* %872
  %874 = trunc i8 %873 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3375.exit [
    i64 0, label %dst.addr.3375.case.0
    i64 1, label %dst.addr.3375.case.1
    i64 2, label %dst.addr.3375.case.2
    i64 3, label %dst.addr.3375.case.3
  ]

dst.addr.3375.case.0:                             ; preds = %dst.addr.3273.exit
  %875 = bitcast i250* %dst_0 to i256*
  %876 = load i256, i256* %875
  %877 = trunc i256 %876 to i250
  %878 = zext i1 %874 to i250
  %879 = shl i250 %878, 240
  %880 = and i250 %877, -1766847064778384329583297500742918515827483896875618958121606201292619777
  %.partset138 = or i250 %880, %879
  store i250 %.partset138, i250* %dst_0, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.1:                             ; preds = %dst.addr.3273.exit
  %881 = bitcast i250* %dst_1 to i256*
  %882 = load i256, i256* %881
  %883 = trunc i256 %882 to i250
  %884 = zext i1 %874 to i250
  %885 = shl i250 %884, 240
  %886 = and i250 %883, -1766847064778384329583297500742918515827483896875618958121606201292619777
  %.partset119 = or i250 %886, %885
  store i250 %.partset119, i250* %dst_1, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.2:                             ; preds = %dst.addr.3273.exit
  %887 = bitcast i250* %dst_2 to i256*
  %888 = load i256, i256* %887
  %889 = trunc i256 %888 to i250
  %890 = zext i1 %874 to i250
  %891 = shl i250 %890, 240
  %892 = and i250 %889, -1766847064778384329583297500742918515827483896875618958121606201292619777
  %.partset52 = or i250 %892, %891
  store i250 %.partset52, i250* %dst_2, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.3:                             ; preds = %dst.addr.3273.exit
  %893 = bitcast i250* %dst_3 to i256*
  %894 = load i256, i256* %893
  %895 = trunc i256 %894 to i250
  %896 = zext i1 %874 to i250
  %897 = shl i250 %896, 240
  %898 = and i250 %895, -1766847064778384329583297500742918515827483896875618958121606201292619777
  %.partset33 = or i250 %898, %897
  store i250 %.partset33, i250* %dst_3, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.exit:                               ; preds = %dst.addr.3375.case.3, %dst.addr.3375.case.2, %dst.addr.3375.case.1, %dst.addr.3375.case.0, %dst.addr.3273.exit
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 34
  %899 = bitcast i1* %src.addr.3476 to i8*
  %900 = load i8, i8* %899
  %901 = trunc i8 %900 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3477.exit [
    i64 0, label %dst.addr.3477.case.0
    i64 1, label %dst.addr.3477.case.1
    i64 2, label %dst.addr.3477.case.2
    i64 3, label %dst.addr.3477.case.3
  ]

dst.addr.3477.case.0:                             ; preds = %dst.addr.3375.exit
  %902 = bitcast i250* %dst_0 to i256*
  %903 = load i256, i256* %902
  %904 = trunc i256 %903 to i250
  %905 = zext i1 %901 to i250
  %906 = shl i250 %905, 241
  %907 = and i250 %904, -3533694129556768659166595001485837031654967793751237916243212402585239553
  %.partset137 = or i250 %907, %906
  store i250 %.partset137, i250* %dst_0, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.1:                             ; preds = %dst.addr.3375.exit
  %908 = bitcast i250* %dst_1 to i256*
  %909 = load i256, i256* %908
  %910 = trunc i256 %909 to i250
  %911 = zext i1 %901 to i250
  %912 = shl i250 %911, 241
  %913 = and i250 %910, -3533694129556768659166595001485837031654967793751237916243212402585239553
  %.partset120 = or i250 %913, %912
  store i250 %.partset120, i250* %dst_1, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.2:                             ; preds = %dst.addr.3375.exit
  %914 = bitcast i250* %dst_2 to i256*
  %915 = load i256, i256* %914
  %916 = trunc i256 %915 to i250
  %917 = zext i1 %901 to i250
  %918 = shl i250 %917, 241
  %919 = and i250 %916, -3533694129556768659166595001485837031654967793751237916243212402585239553
  %.partset51 = or i250 %919, %918
  store i250 %.partset51, i250* %dst_2, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.3:                             ; preds = %dst.addr.3375.exit
  %920 = bitcast i250* %dst_3 to i256*
  %921 = load i256, i256* %920
  %922 = trunc i256 %921 to i250
  %923 = zext i1 %901 to i250
  %924 = shl i250 %923, 241
  %925 = and i250 %922, -3533694129556768659166595001485837031654967793751237916243212402585239553
  %.partset34 = or i250 %925, %924
  store i250 %.partset34, i250* %dst_3, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.exit:                               ; preds = %dst.addr.3477.case.3, %dst.addr.3477.case.2, %dst.addr.3477.case.1, %dst.addr.3477.case.0, %dst.addr.3375.exit
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 35
  %926 = bitcast i1* %src.addr.3578 to i8*
  %927 = load i8, i8* %926
  %928 = trunc i8 %927 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3579.exit [
    i64 0, label %dst.addr.3579.case.0
    i64 1, label %dst.addr.3579.case.1
    i64 2, label %dst.addr.3579.case.2
    i64 3, label %dst.addr.3579.case.3
  ]

dst.addr.3579.case.0:                             ; preds = %dst.addr.3477.exit
  %929 = bitcast i250* %dst_0 to i256*
  %930 = load i256, i256* %929
  %931 = trunc i256 %930 to i250
  %932 = zext i1 %928 to i250
  %933 = shl i250 %932, 242
  %934 = and i250 %931, -7067388259113537318333190002971674063309935587502475832486424805170479105
  %.partset136 = or i250 %934, %933
  store i250 %.partset136, i250* %dst_0, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.1:                             ; preds = %dst.addr.3477.exit
  %935 = bitcast i250* %dst_1 to i256*
  %936 = load i256, i256* %935
  %937 = trunc i256 %936 to i250
  %938 = zext i1 %928 to i250
  %939 = shl i250 %938, 242
  %940 = and i250 %937, -7067388259113537318333190002971674063309935587502475832486424805170479105
  %.partset121 = or i250 %940, %939
  store i250 %.partset121, i250* %dst_1, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.2:                             ; preds = %dst.addr.3477.exit
  %941 = bitcast i250* %dst_2 to i256*
  %942 = load i256, i256* %941
  %943 = trunc i256 %942 to i250
  %944 = zext i1 %928 to i250
  %945 = shl i250 %944, 242
  %946 = and i250 %943, -7067388259113537318333190002971674063309935587502475832486424805170479105
  %.partset50 = or i250 %946, %945
  store i250 %.partset50, i250* %dst_2, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.3:                             ; preds = %dst.addr.3477.exit
  %947 = bitcast i250* %dst_3 to i256*
  %948 = load i256, i256* %947
  %949 = trunc i256 %948 to i250
  %950 = zext i1 %928 to i250
  %951 = shl i250 %950, 242
  %952 = and i250 %949, -7067388259113537318333190002971674063309935587502475832486424805170479105
  %.partset35 = or i250 %952, %951
  store i250 %.partset35, i250* %dst_3, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.exit:                               ; preds = %dst.addr.3579.case.3, %dst.addr.3579.case.2, %dst.addr.3579.case.1, %dst.addr.3579.case.0, %dst.addr.3477.exit
  %src.addr.3680 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 36
  %953 = bitcast i1* %src.addr.3680 to i8*
  %954 = load i8, i8* %953
  %955 = trunc i8 %954 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3681.exit [
    i64 0, label %dst.addr.3681.case.0
    i64 1, label %dst.addr.3681.case.1
    i64 2, label %dst.addr.3681.case.2
    i64 3, label %dst.addr.3681.case.3
  ]

dst.addr.3681.case.0:                             ; preds = %dst.addr.3579.exit
  %956 = bitcast i250* %dst_0 to i256*
  %957 = load i256, i256* %956
  %958 = trunc i256 %957 to i250
  %959 = zext i1 %955 to i250
  %960 = shl i250 %959, 243
  %961 = and i250 %958, -14134776518227074636666380005943348126619871175004951664972849610340958209
  %.partset135 = or i250 %961, %960
  store i250 %.partset135, i250* %dst_0, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.1:                             ; preds = %dst.addr.3579.exit
  %962 = bitcast i250* %dst_1 to i256*
  %963 = load i256, i256* %962
  %964 = trunc i256 %963 to i250
  %965 = zext i1 %955 to i250
  %966 = shl i250 %965, 243
  %967 = and i250 %964, -14134776518227074636666380005943348126619871175004951664972849610340958209
  %.partset122 = or i250 %967, %966
  store i250 %.partset122, i250* %dst_1, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.2:                             ; preds = %dst.addr.3579.exit
  %968 = bitcast i250* %dst_2 to i256*
  %969 = load i256, i256* %968
  %970 = trunc i256 %969 to i250
  %971 = zext i1 %955 to i250
  %972 = shl i250 %971, 243
  %973 = and i250 %970, -14134776518227074636666380005943348126619871175004951664972849610340958209
  %.partset49 = or i250 %973, %972
  store i250 %.partset49, i250* %dst_2, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.3:                             ; preds = %dst.addr.3579.exit
  %974 = bitcast i250* %dst_3 to i256*
  %975 = load i256, i256* %974
  %976 = trunc i256 %975 to i250
  %977 = zext i1 %955 to i250
  %978 = shl i250 %977, 243
  %979 = and i250 %976, -14134776518227074636666380005943348126619871175004951664972849610340958209
  %.partset36 = or i250 %979, %978
  store i250 %.partset36, i250* %dst_3, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.exit:                               ; preds = %dst.addr.3681.case.3, %dst.addr.3681.case.2, %dst.addr.3681.case.1, %dst.addr.3681.case.0, %dst.addr.3579.exit
  %src.addr.3782 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 37
  %980 = bitcast i1* %src.addr.3782 to i8*
  %981 = load i8, i8* %980
  %982 = trunc i8 %981 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3783.exit [
    i64 0, label %dst.addr.3783.case.0
    i64 1, label %dst.addr.3783.case.1
    i64 2, label %dst.addr.3783.case.2
    i64 3, label %dst.addr.3783.case.3
  ]

dst.addr.3783.case.0:                             ; preds = %dst.addr.3681.exit
  %983 = bitcast i250* %dst_0 to i256*
  %984 = load i256, i256* %983
  %985 = trunc i256 %984 to i250
  %986 = zext i1 %982 to i250
  %987 = shl i250 %986, 244
  %988 = and i250 %985, -28269553036454149273332760011886696253239742350009903329945699220681916417
  %.partset134 = or i250 %988, %987
  store i250 %.partset134, i250* %dst_0, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.1:                             ; preds = %dst.addr.3681.exit
  %989 = bitcast i250* %dst_1 to i256*
  %990 = load i256, i256* %989
  %991 = trunc i256 %990 to i250
  %992 = zext i1 %982 to i250
  %993 = shl i250 %992, 244
  %994 = and i250 %991, -28269553036454149273332760011886696253239742350009903329945699220681916417
  %.partset123 = or i250 %994, %993
  store i250 %.partset123, i250* %dst_1, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.2:                             ; preds = %dst.addr.3681.exit
  %995 = bitcast i250* %dst_2 to i256*
  %996 = load i256, i256* %995
  %997 = trunc i256 %996 to i250
  %998 = zext i1 %982 to i250
  %999 = shl i250 %998, 244
  %1000 = and i250 %997, -28269553036454149273332760011886696253239742350009903329945699220681916417
  %.partset48 = or i250 %1000, %999
  store i250 %.partset48, i250* %dst_2, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.3:                             ; preds = %dst.addr.3681.exit
  %1001 = bitcast i250* %dst_3 to i256*
  %1002 = load i256, i256* %1001
  %1003 = trunc i256 %1002 to i250
  %1004 = zext i1 %982 to i250
  %1005 = shl i250 %1004, 244
  %1006 = and i250 %1003, -28269553036454149273332760011886696253239742350009903329945699220681916417
  %.partset37 = or i250 %1006, %1005
  store i250 %.partset37, i250* %dst_3, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.exit:                               ; preds = %dst.addr.3783.case.3, %dst.addr.3783.case.2, %dst.addr.3783.case.1, %dst.addr.3783.case.0, %dst.addr.3681.exit
  %src.addr.3884 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 38
  %1007 = bitcast i1* %src.addr.3884 to i8*
  %1008 = load i8, i8* %1007
  %1009 = trunc i8 %1008 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3885.exit [
    i64 0, label %dst.addr.3885.case.0
    i64 1, label %dst.addr.3885.case.1
    i64 2, label %dst.addr.3885.case.2
    i64 3, label %dst.addr.3885.case.3
  ]

dst.addr.3885.case.0:                             ; preds = %dst.addr.3783.exit
  %1010 = bitcast i250* %dst_0 to i256*
  %1011 = load i256, i256* %1010
  %1012 = trunc i256 %1011 to i250
  %1013 = zext i1 %1009 to i250
  %1014 = shl i250 %1013, 245
  %1015 = and i250 %1012, -56539106072908298546665520023773392506479484700019806659891398441363832833
  %.partset133 = or i250 %1015, %1014
  store i250 %.partset133, i250* %dst_0, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.1:                             ; preds = %dst.addr.3783.exit
  %1016 = bitcast i250* %dst_1 to i256*
  %1017 = load i256, i256* %1016
  %1018 = trunc i256 %1017 to i250
  %1019 = zext i1 %1009 to i250
  %1020 = shl i250 %1019, 245
  %1021 = and i250 %1018, -56539106072908298546665520023773392506479484700019806659891398441363832833
  %.partset124 = or i250 %1021, %1020
  store i250 %.partset124, i250* %dst_1, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.2:                             ; preds = %dst.addr.3783.exit
  %1022 = bitcast i250* %dst_2 to i256*
  %1023 = load i256, i256* %1022
  %1024 = trunc i256 %1023 to i250
  %1025 = zext i1 %1009 to i250
  %1026 = shl i250 %1025, 245
  %1027 = and i250 %1024, -56539106072908298546665520023773392506479484700019806659891398441363832833
  %.partset47 = or i250 %1027, %1026
  store i250 %.partset47, i250* %dst_2, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.3:                             ; preds = %dst.addr.3783.exit
  %1028 = bitcast i250* %dst_3 to i256*
  %1029 = load i256, i256* %1028
  %1030 = trunc i256 %1029 to i250
  %1031 = zext i1 %1009 to i250
  %1032 = shl i250 %1031, 245
  %1033 = and i250 %1030, -56539106072908298546665520023773392506479484700019806659891398441363832833
  %.partset38 = or i250 %1033, %1032
  store i250 %.partset38, i250* %dst_3, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.exit:                               ; preds = %dst.addr.3885.case.3, %dst.addr.3885.case.2, %dst.addr.3885.case.1, %dst.addr.3885.case.0, %dst.addr.3783.exit
  %src.addr.3986 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 39
  %1034 = bitcast i1* %src.addr.3986 to i8*
  %1035 = load i8, i8* %1034
  %1036 = trunc i8 %1035 to i1
  switch i64 %for.loop.idx95, label %dst.addr.3987.exit [
    i64 0, label %dst.addr.3987.case.0
    i64 1, label %dst.addr.3987.case.1
    i64 2, label %dst.addr.3987.case.2
    i64 3, label %dst.addr.3987.case.3
  ]

dst.addr.3987.case.0:                             ; preds = %dst.addr.3885.exit
  %1037 = bitcast i250* %dst_0 to i256*
  %1038 = load i256, i256* %1037
  %1039 = trunc i256 %1038 to i250
  %1040 = zext i1 %1036 to i250
  %1041 = shl i250 %1040, 246
  %1042 = and i250 %1039, -113078212145816597093331040047546785012958969400039613319782796882727665665
  %.partset132 = or i250 %1042, %1041
  store i250 %.partset132, i250* %dst_0, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.1:                             ; preds = %dst.addr.3885.exit
  %1043 = bitcast i250* %dst_1 to i256*
  %1044 = load i256, i256* %1043
  %1045 = trunc i256 %1044 to i250
  %1046 = zext i1 %1036 to i250
  %1047 = shl i250 %1046, 246
  %1048 = and i250 %1045, -113078212145816597093331040047546785012958969400039613319782796882727665665
  %.partset125 = or i250 %1048, %1047
  store i250 %.partset125, i250* %dst_1, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.2:                             ; preds = %dst.addr.3885.exit
  %1049 = bitcast i250* %dst_2 to i256*
  %1050 = load i256, i256* %1049
  %1051 = trunc i256 %1050 to i250
  %1052 = zext i1 %1036 to i250
  %1053 = shl i250 %1052, 246
  %1054 = and i250 %1051, -113078212145816597093331040047546785012958969400039613319782796882727665665
  %.partset46 = or i250 %1054, %1053
  store i250 %.partset46, i250* %dst_2, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.3:                             ; preds = %dst.addr.3885.exit
  %1055 = bitcast i250* %dst_3 to i256*
  %1056 = load i256, i256* %1055
  %1057 = trunc i256 %1056 to i250
  %1058 = zext i1 %1036 to i250
  %1059 = shl i250 %1058, 246
  %1060 = and i250 %1057, -113078212145816597093331040047546785012958969400039613319782796882727665665
  %.partset39 = or i250 %1060, %1059
  store i250 %.partset39, i250* %dst_3, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.exit:                               ; preds = %dst.addr.3987.case.3, %dst.addr.3987.case.2, %dst.addr.3987.case.1, %dst.addr.3987.case.0, %dst.addr.3885.exit
  %src.addr.4088 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 40
  %1061 = bitcast i1* %src.addr.4088 to i8*
  %1062 = load i8, i8* %1061
  %1063 = trunc i8 %1062 to i1
  switch i64 %for.loop.idx95, label %dst.addr.4089.exit [
    i64 0, label %dst.addr.4089.case.0
    i64 1, label %dst.addr.4089.case.1
    i64 2, label %dst.addr.4089.case.2
    i64 3, label %dst.addr.4089.case.3
  ]

dst.addr.4089.case.0:                             ; preds = %dst.addr.3987.exit
  %1064 = bitcast i250* %dst_0 to i256*
  %1065 = load i256, i256* %1064
  %1066 = trunc i256 %1065 to i250
  %1067 = zext i1 %1063 to i250
  %1068 = shl i250 %1067, 247
  %1069 = and i250 %1066, -226156424291633194186662080095093570025917938800079226639565593765455331329
  %.partset131 = or i250 %1069, %1068
  store i250 %.partset131, i250* %dst_0, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.1:                             ; preds = %dst.addr.3987.exit
  %1070 = bitcast i250* %dst_1 to i256*
  %1071 = load i256, i256* %1070
  %1072 = trunc i256 %1071 to i250
  %1073 = zext i1 %1063 to i250
  %1074 = shl i250 %1073, 247
  %1075 = and i250 %1072, -226156424291633194186662080095093570025917938800079226639565593765455331329
  %.partset126 = or i250 %1075, %1074
  store i250 %.partset126, i250* %dst_1, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.2:                             ; preds = %dst.addr.3987.exit
  %1076 = bitcast i250* %dst_2 to i256*
  %1077 = load i256, i256* %1076
  %1078 = trunc i256 %1077 to i250
  %1079 = zext i1 %1063 to i250
  %1080 = shl i250 %1079, 247
  %1081 = and i250 %1078, -226156424291633194186662080095093570025917938800079226639565593765455331329
  %.partset45 = or i250 %1081, %1080
  store i250 %.partset45, i250* %dst_2, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.3:                             ; preds = %dst.addr.3987.exit
  %1082 = bitcast i250* %dst_3 to i256*
  %1083 = load i256, i256* %1082
  %1084 = trunc i256 %1083 to i250
  %1085 = zext i1 %1063 to i250
  %1086 = shl i250 %1085, 247
  %1087 = and i250 %1084, -226156424291633194186662080095093570025917938800079226639565593765455331329
  %.partset40 = or i250 %1087, %1086
  store i250 %.partset40, i250* %dst_3, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.exit:                               ; preds = %dst.addr.4089.case.3, %dst.addr.4089.case.2, %dst.addr.4089.case.1, %dst.addr.4089.case.0, %dst.addr.3987.exit
  %src.addr.4190 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 41
  %1088 = bitcast i1* %src.addr.4190 to i8*
  %1089 = load i8, i8* %1088
  %1090 = trunc i8 %1089 to i1
  switch i64 %for.loop.idx95, label %dst.addr.4191.exit [
    i64 0, label %dst.addr.4191.case.0
    i64 1, label %dst.addr.4191.case.1
    i64 2, label %dst.addr.4191.case.2
    i64 3, label %dst.addr.4191.case.3
  ]

dst.addr.4191.case.0:                             ; preds = %dst.addr.4089.exit
  %1091 = bitcast i250* %dst_0 to i256*
  %1092 = load i256, i256* %1091
  %1093 = trunc i256 %1092 to i250
  %1094 = zext i1 %1090 to i250
  %1095 = shl i250 %1094, 248
  %1096 = and i250 %1093, -452312848583266388373324160190187140051835877600158453279131187530910662657
  %.partset130 = or i250 %1096, %1095
  store i250 %.partset130, i250* %dst_0, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.1:                             ; preds = %dst.addr.4089.exit
  %1097 = bitcast i250* %dst_1 to i256*
  %1098 = load i256, i256* %1097
  %1099 = trunc i256 %1098 to i250
  %1100 = zext i1 %1090 to i250
  %1101 = shl i250 %1100, 248
  %1102 = and i250 %1099, -452312848583266388373324160190187140051835877600158453279131187530910662657
  %.partset127 = or i250 %1102, %1101
  store i250 %.partset127, i250* %dst_1, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.2:                             ; preds = %dst.addr.4089.exit
  %1103 = bitcast i250* %dst_2 to i256*
  %1104 = load i256, i256* %1103
  %1105 = trunc i256 %1104 to i250
  %1106 = zext i1 %1090 to i250
  %1107 = shl i250 %1106, 248
  %1108 = and i250 %1105, -452312848583266388373324160190187140051835877600158453279131187530910662657
  %.partset44 = or i250 %1108, %1107
  store i250 %.partset44, i250* %dst_2, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.3:                             ; preds = %dst.addr.4089.exit
  %1109 = bitcast i250* %dst_3 to i256*
  %1110 = load i256, i256* %1109
  %1111 = trunc i256 %1110 to i250
  %1112 = zext i1 %1090 to i250
  %1113 = shl i250 %1112, 248
  %1114 = and i250 %1111, -452312848583266388373324160190187140051835877600158453279131187530910662657
  %.partset41 = or i250 %1114, %1113
  store i250 %.partset41, i250* %dst_3, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.exit:                               ; preds = %dst.addr.4191.case.3, %dst.addr.4191.case.2, %dst.addr.4191.case.1, %dst.addr.4191.case.0, %dst.addr.4089.exit
  %src.addr.4292 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 42
  %1115 = bitcast i1* %src.addr.4292 to i8*
  %1116 = load i8, i8* %1115
  %1117 = trunc i8 %1116 to i1
  switch i64 %for.loop.idx95, label %dst.addr.4293.exit [
    i64 0, label %dst.addr.4293.case.0
    i64 1, label %dst.addr.4293.case.1
    i64 2, label %dst.addr.4293.case.2
    i64 3, label %dst.addr.4293.case.3
  ]

dst.addr.4293.case.0:                             ; preds = %dst.addr.4191.exit
  %1118 = bitcast i250* %dst_0 to i256*
  %1119 = load i256, i256* %1118
  %1120 = trunc i256 %1119 to i250
  %1121 = zext i1 %1117 to i250
  %1122 = shl i250 %1121, 249
  %1123 = and i250 %1120, 904625697166532776746648320380374280103671755200316906558262375061821325311
  %.partset129 = or i250 %1123, %1122
  store i250 %.partset129, i250* %dst_0, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.1:                             ; preds = %dst.addr.4191.exit
  %1124 = bitcast i250* %dst_1 to i256*
  %1125 = load i256, i256* %1124
  %1126 = trunc i256 %1125 to i250
  %1127 = zext i1 %1117 to i250
  %1128 = shl i250 %1127, 249
  %1129 = and i250 %1126, 904625697166532776746648320380374280103671755200316906558262375061821325311
  %.partset128 = or i250 %1129, %1128
  store i250 %.partset128, i250* %dst_1, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.2:                             ; preds = %dst.addr.4191.exit
  %1130 = bitcast i250* %dst_2 to i256*
  %1131 = load i256, i256* %1130
  %1132 = trunc i256 %1131 to i250
  %1133 = zext i1 %1117 to i250
  %1134 = shl i250 %1133, 249
  %1135 = and i250 %1132, 904625697166532776746648320380374280103671755200316906558262375061821325311
  %.partset43 = or i250 %1135, %1134
  store i250 %.partset43, i250* %dst_2, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.3:                             ; preds = %dst.addr.4191.exit
  %1136 = bitcast i250* %dst_3 to i256*
  %1137 = load i256, i256* %1136
  %1138 = trunc i256 %1137 to i250
  %1139 = zext i1 %1117 to i250
  %1140 = shl i250 %1139, 249
  %1141 = and i250 %1138, 904625697166532776746648320380374280103671755200316906558262375061821325311
  %.partset42 = or i250 %1141, %1140
  store i250 %.partset42, i250* %dst_3, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.exit:                               ; preds = %dst.addr.4293.case.3, %dst.addr.4293.case.2, %dst.addr.4293.case.1, %dst.addr.4293.case.0, %dst.addr.4191.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx95, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.4293.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.12.15(i250* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i250* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i250* noalias align 512 "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i250* noalias align 512 "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #1 {
entry:
  %0 = icmp eq i250* %dst_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.13.14(i250* nonnull %dst_0, i250* %dst_1, i250* %dst_2, i250* %dst_3, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in(i1* noalias readonly "orig.arg.no"="0", i1* noalias align 512 "orig.arg.no"="1", i1* noalias readonly "orig.arg.no"="2", i1* noalias align 512 "orig.arg.no"="3", i8* noalias readonly "orig.arg.no"="4", i8* noalias align 512 "orig.arg.no"="5", i32* noalias readonly "orig.arg.no"="6", i32* noalias align 512 "orig.arg.no"="7", i32* noalias readonly "orig.arg.no"="8", i32* noalias align 512 "orig.arg.no"="9", i32* noalias readonly "orig.arg.no"="10", i32* noalias align 512 "orig.arg.no"="11", i1* noalias readonly "orig.arg.no"="12", i1* noalias align 512 "orig.arg.no"="13", i32* noalias readonly "orig.arg.no"="14", i32* noalias align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="16", i250* noalias align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i250* noalias align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i250* noalias align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i250* noalias align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias readonly "orig.arg.no"="18", i1* noalias align 512 "orig.arg.no"="19", i32* noalias readonly "orig.arg.no"="20", i32* noalias align 512 "orig.arg.no"="21", i1* noalias readonly "orig.arg.no"="22", i1* noalias align 512 "orig.arg.no"="23", i32* noalias readonly "orig.arg.no"="24", i32* noalias align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias readonly "orig.arg.no"="26", i1056* noalias align 512 "orig.arg.no"="27", i32* noalias readonly "orig.arg.no"="28", i32* noalias align 512 "orig.arg.no"="29", i32* noalias readonly "orig.arg.no"="30", i32* noalias align 512 "orig.arg.no"="31", i32* noalias readonly "orig.arg.no"="32", i32* noalias align 512 "orig.arg.no"="33", i32* noalias readonly "orig.arg.no"="34", i32* noalias align 512 "orig.arg.no"="35", i32* noalias readonly "orig.arg.no"="36", i32* noalias align 512 "orig.arg.no"="37", i32* noalias readonly "orig.arg.no"="38", i32* noalias align 512 "orig.arg.no"="39", i32* noalias readonly "orig.arg.no"="40", i32* noalias align 512 "orig.arg.no"="41", i32* noalias readonly "orig.arg.no"="42", i32* noalias align 512 "orig.arg.no"="43", i32* noalias readonly "orig.arg.no"="44", i32* noalias align 512 "orig.arg.no"="45", i32* noalias readonly "orig.arg.no"="46", i32* noalias align 512 "orig.arg.no"="47", i32* noalias readonly "orig.arg.no"="48", i32* noalias align 512 "orig.arg.no"="49", i32* noalias readonly "orig.arg.no"="50", i32* noalias align 512 "orig.arg.no"="51", i32* noalias readonly "orig.arg.no"="52", i32* noalias align 512 "orig.arg.no"="53", i32* noalias readonly "orig.arg.no"="54", i32* noalias align 512 "orig.arg.no"="55", i32* noalias readonly "orig.arg.no"="56", i32* noalias align 512 "orig.arg.no"="57", i1* noalias readonly "orig.arg.no"="58", i1* noalias align 512 "orig.arg.no"="59", i1* noalias readonly "orig.arg.no"="60", i1* noalias align 512 "orig.arg.no"="61") #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %3, i1* %2)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %5, i8* %4)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %7, i32* %6)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %9, i32* %8)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %11, i32* %10)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %13, i1* %12)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %15, i32* %14)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.12.15(i250* align 512 %_0, i250* align 512 %_1, i250* align 512 %_2, i250* align 512 %_3, [4 x %struct.HeadCtx]* %16)
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
define void @arraycpy_hls.p0a4struct.HeadCtx.23.24([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i250* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i250* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i250* readonly "orig.arg.no"="1" "unpacked"="1.2" %src_2, i250* readonly "orig.arg.no"="1" "unpacked"="1.3" %src_3, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i250* %src_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond94 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond94, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.4292.exit, %for.loop.lr.ph
  %for.loop.idx95 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.4292.exit ]
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 0
  switch i64 %for.loop.idx95, label %src.addr.01.exit [
    i64 0, label %src.addr.01.case.0
    i64 1, label %src.addr.01.case.1
    i64 2, label %src.addr.01.case.2
    i64 3, label %src.addr.01.case.3
  ]

src.addr.01.case.0:                               ; preds = %for.loop
  %3 = bitcast i250* %src_0 to i256*
  %4 = load i256, i256* %3
  %5 = trunc i256 %4 to i250
  %_0.partselect = trunc i250 %5 to i32
  br label %src.addr.01.exit

src.addr.01.case.1:                               ; preds = %for.loop
  %6 = bitcast i250* %src_1 to i256*
  %7 = load i256, i256* %6
  %8 = trunc i256 %7 to i250
  %_1.partselect = trunc i250 %8 to i32
  br label %src.addr.01.exit

src.addr.01.case.2:                               ; preds = %for.loop
  %9 = bitcast i250* %src_2 to i256*
  %10 = load i256, i256* %9
  %11 = trunc i256 %10 to i250
  %_2.partselect = trunc i250 %11 to i32
  br label %src.addr.01.exit

src.addr.01.case.3:                               ; preds = %for.loop
  %12 = bitcast i250* %src_3 to i256*
  %13 = load i256, i256* %12
  %14 = trunc i256 %13 to i250
  %_3.partselect = trunc i250 %14 to i32
  br label %src.addr.01.exit

src.addr.01.exit:                                 ; preds = %src.addr.01.case.3, %src.addr.01.case.2, %src.addr.01.case.1, %src.addr.01.case.0, %for.loop
  %15 = phi i32 [ %_0.partselect, %src.addr.01.case.0 ], [ %_1.partselect, %src.addr.01.case.1 ], [ %_2.partselect, %src.addr.01.case.2 ], [ %_3.partselect, %src.addr.01.case.3 ], [ undef, %for.loop ]
  store i32 %15, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 1
  switch i64 %for.loop.idx95, label %src.addr.110.exit [
    i64 0, label %src.addr.110.case.0
    i64 1, label %src.addr.110.case.1
    i64 2, label %src.addr.110.case.2
    i64 3, label %src.addr.110.case.3
  ]

src.addr.110.case.0:                              ; preds = %src.addr.01.exit
  %16 = bitcast i250* %src_0 to i256*
  %17 = load i256, i256* %16
  %18 = trunc i256 %17 to i250
  %19 = lshr i250 %18, 32
  %_01.partselect = trunc i250 %19 to i32
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %20 = bitcast i250* %src_1 to i256*
  %21 = load i256, i256* %20
  %22 = trunc i256 %21 to i250
  %23 = lshr i250 %22, 32
  %_12.partselect = trunc i250 %23 to i32
  br label %src.addr.110.exit

src.addr.110.case.2:                              ; preds = %src.addr.01.exit
  %24 = bitcast i250* %src_2 to i256*
  %25 = load i256, i256* %24
  %26 = trunc i256 %25 to i250
  %27 = lshr i250 %26, 32
  %_23.partselect = trunc i250 %27 to i32
  br label %src.addr.110.exit

src.addr.110.case.3:                              ; preds = %src.addr.01.exit
  %28 = bitcast i250* %src_3 to i256*
  %29 = load i256, i256* %28
  %30 = trunc i256 %29 to i250
  %31 = lshr i250 %30, 32
  %_34.partselect = trunc i250 %31 to i32
  br label %src.addr.110.exit

src.addr.110.exit:                                ; preds = %src.addr.110.case.3, %src.addr.110.case.2, %src.addr.110.case.1, %src.addr.110.case.0, %src.addr.01.exit
  %32 = phi i32 [ %_01.partselect, %src.addr.110.case.0 ], [ %_12.partselect, %src.addr.110.case.1 ], [ %_23.partselect, %src.addr.110.case.2 ], [ %_34.partselect, %src.addr.110.case.3 ], [ undef, %src.addr.01.exit ]
  store i32 %32, i32* %dst.addr.111, align 4
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 2
  switch i64 %for.loop.idx95, label %src.addr.212.exit [
    i64 0, label %src.addr.212.case.0
    i64 1, label %src.addr.212.case.1
    i64 2, label %src.addr.212.case.2
    i64 3, label %src.addr.212.case.3
  ]

src.addr.212.case.0:                              ; preds = %src.addr.110.exit
  %33 = bitcast i250* %src_0 to i256*
  %34 = load i256, i256* %33
  %35 = trunc i256 %34 to i250
  %36 = lshr i250 %35, 64
  %_05.partselect = trunc i250 %36 to i8
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %37 = bitcast i250* %src_1 to i256*
  %38 = load i256, i256* %37
  %39 = trunc i256 %38 to i250
  %40 = lshr i250 %39, 64
  %_16.partselect = trunc i250 %40 to i8
  br label %src.addr.212.exit

src.addr.212.case.2:                              ; preds = %src.addr.110.exit
  %41 = bitcast i250* %src_2 to i256*
  %42 = load i256, i256* %41
  %43 = trunc i256 %42 to i250
  %44 = lshr i250 %43, 64
  %_27.partselect = trunc i250 %44 to i8
  br label %src.addr.212.exit

src.addr.212.case.3:                              ; preds = %src.addr.110.exit
  %45 = bitcast i250* %src_3 to i256*
  %46 = load i256, i256* %45
  %47 = trunc i256 %46 to i250
  %48 = lshr i250 %47, 64
  %_38.partselect = trunc i250 %48 to i8
  br label %src.addr.212.exit

src.addr.212.exit:                                ; preds = %src.addr.212.case.3, %src.addr.212.case.2, %src.addr.212.case.1, %src.addr.212.case.0, %src.addr.110.exit
  %49 = phi i8 [ %_05.partselect, %src.addr.212.case.0 ], [ %_16.partselect, %src.addr.212.case.1 ], [ %_27.partselect, %src.addr.212.case.2 ], [ %_38.partselect, %src.addr.212.case.3 ], [ undef, %src.addr.110.exit ]
  store i8 %49, i8* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 3
  switch i64 %for.loop.idx95, label %src.addr.314.exit [
    i64 0, label %src.addr.314.case.0
    i64 1, label %src.addr.314.case.1
    i64 2, label %src.addr.314.case.2
    i64 3, label %src.addr.314.case.3
  ]

src.addr.314.case.0:                              ; preds = %src.addr.212.exit
  %50 = bitcast i250* %src_0 to i256*
  %51 = load i256, i256* %50
  %52 = trunc i256 %51 to i250
  %53 = lshr i250 %52, 72
  %_09.partselect = trunc i250 %53 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %54 = bitcast i250* %src_1 to i256*
  %55 = load i256, i256* %54
  %56 = trunc i256 %55 to i250
  %57 = lshr i250 %56, 72
  %_110.partselect = trunc i250 %57 to i1
  br label %src.addr.314.exit

src.addr.314.case.2:                              ; preds = %src.addr.212.exit
  %58 = bitcast i250* %src_2 to i256*
  %59 = load i256, i256* %58
  %60 = trunc i256 %59 to i250
  %61 = lshr i250 %60, 72
  %_211.partselect = trunc i250 %61 to i1
  br label %src.addr.314.exit

src.addr.314.case.3:                              ; preds = %src.addr.212.exit
  %62 = bitcast i250* %src_3 to i256*
  %63 = load i256, i256* %62
  %64 = trunc i256 %63 to i250
  %65 = lshr i250 %64, 72
  %_312.partselect = trunc i250 %65 to i1
  br label %src.addr.314.exit

src.addr.314.exit:                                ; preds = %src.addr.314.case.3, %src.addr.314.case.2, %src.addr.314.case.1, %src.addr.314.case.0, %src.addr.212.exit
  %66 = phi i1 [ %_09.partselect, %src.addr.314.case.0 ], [ %_110.partselect, %src.addr.314.case.1 ], [ %_211.partselect, %src.addr.314.case.2 ], [ %_312.partselect, %src.addr.314.case.3 ], [ undef, %src.addr.212.exit ]
  store i1 %66, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 4
  switch i64 %for.loop.idx95, label %src.addr.416.exit [
    i64 0, label %src.addr.416.case.0
    i64 1, label %src.addr.416.case.1
    i64 2, label %src.addr.416.case.2
    i64 3, label %src.addr.416.case.3
  ]

src.addr.416.case.0:                              ; preds = %src.addr.314.exit
  %67 = bitcast i250* %src_0 to i256*
  %68 = load i256, i256* %67
  %69 = trunc i256 %68 to i250
  %70 = lshr i250 %69, 73
  %_013.partselect = trunc i250 %70 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %71 = bitcast i250* %src_1 to i256*
  %72 = load i256, i256* %71
  %73 = trunc i256 %72 to i250
  %74 = lshr i250 %73, 73
  %_114.partselect = trunc i250 %74 to i1
  br label %src.addr.416.exit

src.addr.416.case.2:                              ; preds = %src.addr.314.exit
  %75 = bitcast i250* %src_2 to i256*
  %76 = load i256, i256* %75
  %77 = trunc i256 %76 to i250
  %78 = lshr i250 %77, 73
  %_215.partselect = trunc i250 %78 to i1
  br label %src.addr.416.exit

src.addr.416.case.3:                              ; preds = %src.addr.314.exit
  %79 = bitcast i250* %src_3 to i256*
  %80 = load i256, i256* %79
  %81 = trunc i256 %80 to i250
  %82 = lshr i250 %81, 73
  %_316.partselect = trunc i250 %82 to i1
  br label %src.addr.416.exit

src.addr.416.exit:                                ; preds = %src.addr.416.case.3, %src.addr.416.case.2, %src.addr.416.case.1, %src.addr.416.case.0, %src.addr.314.exit
  %83 = phi i1 [ %_013.partselect, %src.addr.416.case.0 ], [ %_114.partselect, %src.addr.416.case.1 ], [ %_215.partselect, %src.addr.416.case.2 ], [ %_316.partselect, %src.addr.416.case.3 ], [ undef, %src.addr.314.exit ]
  store i1 %83, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 5
  switch i64 %for.loop.idx95, label %src.addr.518.exit [
    i64 0, label %src.addr.518.case.0
    i64 1, label %src.addr.518.case.1
    i64 2, label %src.addr.518.case.2
    i64 3, label %src.addr.518.case.3
  ]

src.addr.518.case.0:                              ; preds = %src.addr.416.exit
  %84 = bitcast i250* %src_0 to i256*
  %85 = load i256, i256* %84
  %86 = trunc i256 %85 to i250
  %87 = lshr i250 %86, 74
  %_017.partselect = trunc i250 %87 to i1
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %88 = bitcast i250* %src_1 to i256*
  %89 = load i256, i256* %88
  %90 = trunc i256 %89 to i250
  %91 = lshr i250 %90, 74
  %_118.partselect = trunc i250 %91 to i1
  br label %src.addr.518.exit

src.addr.518.case.2:                              ; preds = %src.addr.416.exit
  %92 = bitcast i250* %src_2 to i256*
  %93 = load i256, i256* %92
  %94 = trunc i256 %93 to i250
  %95 = lshr i250 %94, 74
  %_219.partselect = trunc i250 %95 to i1
  br label %src.addr.518.exit

src.addr.518.case.3:                              ; preds = %src.addr.416.exit
  %96 = bitcast i250* %src_3 to i256*
  %97 = load i256, i256* %96
  %98 = trunc i256 %97 to i250
  %99 = lshr i250 %98, 74
  %_320.partselect = trunc i250 %99 to i1
  br label %src.addr.518.exit

src.addr.518.exit:                                ; preds = %src.addr.518.case.3, %src.addr.518.case.2, %src.addr.518.case.1, %src.addr.518.case.0, %src.addr.416.exit
  %100 = phi i1 [ %_017.partselect, %src.addr.518.case.0 ], [ %_118.partselect, %src.addr.518.case.1 ], [ %_219.partselect, %src.addr.518.case.2 ], [ %_320.partselect, %src.addr.518.case.3 ], [ undef, %src.addr.416.exit ]
  store i1 %100, i1* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 6
  switch i64 %for.loop.idx95, label %src.addr.620.exit [
    i64 0, label %src.addr.620.case.0
    i64 1, label %src.addr.620.case.1
    i64 2, label %src.addr.620.case.2
    i64 3, label %src.addr.620.case.3
  ]

src.addr.620.case.0:                              ; preds = %src.addr.518.exit
  %101 = bitcast i250* %src_0 to i256*
  %102 = load i256, i256* %101
  %103 = trunc i256 %102 to i250
  %104 = lshr i250 %103, 75
  %_021.partselect = trunc i250 %104 to i32
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %105 = bitcast i250* %src_1 to i256*
  %106 = load i256, i256* %105
  %107 = trunc i256 %106 to i250
  %108 = lshr i250 %107, 75
  %_122.partselect = trunc i250 %108 to i32
  br label %src.addr.620.exit

src.addr.620.case.2:                              ; preds = %src.addr.518.exit
  %109 = bitcast i250* %src_2 to i256*
  %110 = load i256, i256* %109
  %111 = trunc i256 %110 to i250
  %112 = lshr i250 %111, 75
  %_223.partselect = trunc i250 %112 to i32
  br label %src.addr.620.exit

src.addr.620.case.3:                              ; preds = %src.addr.518.exit
  %113 = bitcast i250* %src_3 to i256*
  %114 = load i256, i256* %113
  %115 = trunc i256 %114 to i250
  %116 = lshr i250 %115, 75
  %_324.partselect = trunc i250 %116 to i32
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.3, %src.addr.620.case.2, %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %117 = phi i32 [ %_021.partselect, %src.addr.620.case.0 ], [ %_122.partselect, %src.addr.620.case.1 ], [ %_223.partselect, %src.addr.620.case.2 ], [ %_324.partselect, %src.addr.620.case.3 ], [ undef, %src.addr.518.exit ]
  store i32 %117, i32* %dst.addr.621, align 4
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 7
  switch i64 %for.loop.idx95, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
    i64 2, label %src.addr.722.case.2
    i64 3, label %src.addr.722.case.3
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %118 = bitcast i250* %src_0 to i256*
  %119 = load i256, i256* %118
  %120 = trunc i256 %119 to i250
  %121 = lshr i250 %120, 107
  %_025.partselect = trunc i250 %121 to i32
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %122 = bitcast i250* %src_1 to i256*
  %123 = load i256, i256* %122
  %124 = trunc i256 %123 to i250
  %125 = lshr i250 %124, 107
  %_126.partselect = trunc i250 %125 to i32
  br label %src.addr.722.exit

src.addr.722.case.2:                              ; preds = %src.addr.620.exit
  %126 = bitcast i250* %src_2 to i256*
  %127 = load i256, i256* %126
  %128 = trunc i256 %127 to i250
  %129 = lshr i250 %128, 107
  %_227.partselect = trunc i250 %129 to i32
  br label %src.addr.722.exit

src.addr.722.case.3:                              ; preds = %src.addr.620.exit
  %130 = bitcast i250* %src_3 to i256*
  %131 = load i256, i256* %130
  %132 = trunc i256 %131 to i250
  %133 = lshr i250 %132, 107
  %_328.partselect = trunc i250 %133 to i32
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.3, %src.addr.722.case.2, %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %134 = phi i32 [ %_025.partselect, %src.addr.722.case.0 ], [ %_126.partselect, %src.addr.722.case.1 ], [ %_227.partselect, %src.addr.722.case.2 ], [ %_328.partselect, %src.addr.722.case.3 ], [ undef, %src.addr.620.exit ]
  store i32 %134, i32* %dst.addr.723, align 4
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 8
  switch i64 %for.loop.idx95, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
    i64 2, label %src.addr.824.case.2
    i64 3, label %src.addr.824.case.3
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %135 = bitcast i250* %src_0 to i256*
  %136 = load i256, i256* %135
  %137 = trunc i256 %136 to i250
  %138 = lshr i250 %137, 139
  %_029.partselect = trunc i250 %138 to i8
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %139 = bitcast i250* %src_1 to i256*
  %140 = load i256, i256* %139
  %141 = trunc i256 %140 to i250
  %142 = lshr i250 %141, 139
  %_130.partselect = trunc i250 %142 to i8
  br label %src.addr.824.exit

src.addr.824.case.2:                              ; preds = %src.addr.722.exit
  %143 = bitcast i250* %src_2 to i256*
  %144 = load i256, i256* %143
  %145 = trunc i256 %144 to i250
  %146 = lshr i250 %145, 139
  %_231.partselect = trunc i250 %146 to i8
  br label %src.addr.824.exit

src.addr.824.case.3:                              ; preds = %src.addr.722.exit
  %147 = bitcast i250* %src_3 to i256*
  %148 = load i256, i256* %147
  %149 = trunc i256 %148 to i250
  %150 = lshr i250 %149, 139
  %_332.partselect = trunc i250 %150 to i8
  br label %src.addr.824.exit

src.addr.824.exit:                                ; preds = %src.addr.824.case.3, %src.addr.824.case.2, %src.addr.824.case.1, %src.addr.824.case.0, %src.addr.722.exit
  %151 = phi i8 [ %_029.partselect, %src.addr.824.case.0 ], [ %_130.partselect, %src.addr.824.case.1 ], [ %_231.partselect, %src.addr.824.case.2 ], [ %_332.partselect, %src.addr.824.case.3 ], [ undef, %src.addr.722.exit ]
  store i8 %151, i8* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 9
  switch i64 %for.loop.idx95, label %src.addr.926.exit [
    i64 0, label %src.addr.926.case.0
    i64 1, label %src.addr.926.case.1
    i64 2, label %src.addr.926.case.2
    i64 3, label %src.addr.926.case.3
  ]

src.addr.926.case.0:                              ; preds = %src.addr.824.exit
  %152 = bitcast i250* %src_0 to i256*
  %153 = load i256, i256* %152
  %154 = trunc i256 %153 to i250
  %155 = lshr i250 %154, 147
  %_033.partselect = trunc i250 %155 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %156 = bitcast i250* %src_1 to i256*
  %157 = load i256, i256* %156
  %158 = trunc i256 %157 to i250
  %159 = lshr i250 %158, 147
  %_134.partselect = trunc i250 %159 to i1
  br label %src.addr.926.exit

src.addr.926.case.2:                              ; preds = %src.addr.824.exit
  %160 = bitcast i250* %src_2 to i256*
  %161 = load i256, i256* %160
  %162 = trunc i256 %161 to i250
  %163 = lshr i250 %162, 147
  %_235.partselect = trunc i250 %163 to i1
  br label %src.addr.926.exit

src.addr.926.case.3:                              ; preds = %src.addr.824.exit
  %164 = bitcast i250* %src_3 to i256*
  %165 = load i256, i256* %164
  %166 = trunc i256 %165 to i250
  %167 = lshr i250 %166, 147
  %_336.partselect = trunc i250 %167 to i1
  br label %src.addr.926.exit

src.addr.926.exit:                                ; preds = %src.addr.926.case.3, %src.addr.926.case.2, %src.addr.926.case.1, %src.addr.926.case.0, %src.addr.824.exit
  %168 = phi i1 [ %_033.partselect, %src.addr.926.case.0 ], [ %_134.partselect, %src.addr.926.case.1 ], [ %_235.partselect, %src.addr.926.case.2 ], [ %_336.partselect, %src.addr.926.case.3 ], [ undef, %src.addr.824.exit ]
  store i1 %168, i1* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 10
  switch i64 %for.loop.idx95, label %src.addr.1028.exit [
    i64 0, label %src.addr.1028.case.0
    i64 1, label %src.addr.1028.case.1
    i64 2, label %src.addr.1028.case.2
    i64 3, label %src.addr.1028.case.3
  ]

src.addr.1028.case.0:                             ; preds = %src.addr.926.exit
  %169 = bitcast i250* %src_0 to i256*
  %170 = load i256, i256* %169
  %171 = trunc i256 %170 to i250
  %172 = lshr i250 %171, 148
  %_037.partselect = trunc i250 %172 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %173 = bitcast i250* %src_1 to i256*
  %174 = load i256, i256* %173
  %175 = trunc i256 %174 to i250
  %176 = lshr i250 %175, 148
  %_138.partselect = trunc i250 %176 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.2:                             ; preds = %src.addr.926.exit
  %177 = bitcast i250* %src_2 to i256*
  %178 = load i256, i256* %177
  %179 = trunc i256 %178 to i250
  %180 = lshr i250 %179, 148
  %_239.partselect = trunc i250 %180 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.3:                             ; preds = %src.addr.926.exit
  %181 = bitcast i250* %src_3 to i256*
  %182 = load i256, i256* %181
  %183 = trunc i256 %182 to i250
  %184 = lshr i250 %183, 148
  %_340.partselect = trunc i250 %184 to i1
  br label %src.addr.1028.exit

src.addr.1028.exit:                               ; preds = %src.addr.1028.case.3, %src.addr.1028.case.2, %src.addr.1028.case.1, %src.addr.1028.case.0, %src.addr.926.exit
  %185 = phi i1 [ %_037.partselect, %src.addr.1028.case.0 ], [ %_138.partselect, %src.addr.1028.case.1 ], [ %_239.partselect, %src.addr.1028.case.2 ], [ %_340.partselect, %src.addr.1028.case.3 ], [ undef, %src.addr.926.exit ]
  store i1 %185, i1* %dst.addr.1029, align 1
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 11
  switch i64 %for.loop.idx95, label %src.addr.1130.exit [
    i64 0, label %src.addr.1130.case.0
    i64 1, label %src.addr.1130.case.1
    i64 2, label %src.addr.1130.case.2
    i64 3, label %src.addr.1130.case.3
  ]

src.addr.1130.case.0:                             ; preds = %src.addr.1028.exit
  %186 = bitcast i250* %src_0 to i256*
  %187 = load i256, i256* %186
  %188 = trunc i256 %187 to i250
  %189 = lshr i250 %188, 149
  %_041.partselect = trunc i250 %189 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %190 = bitcast i250* %src_1 to i256*
  %191 = load i256, i256* %190
  %192 = trunc i256 %191 to i250
  %193 = lshr i250 %192, 149
  %_142.partselect = trunc i250 %193 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.2:                             ; preds = %src.addr.1028.exit
  %194 = bitcast i250* %src_2 to i256*
  %195 = load i256, i256* %194
  %196 = trunc i256 %195 to i250
  %197 = lshr i250 %196, 149
  %_243.partselect = trunc i250 %197 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.3:                             ; preds = %src.addr.1028.exit
  %198 = bitcast i250* %src_3 to i256*
  %199 = load i256, i256* %198
  %200 = trunc i256 %199 to i250
  %201 = lshr i250 %200, 149
  %_344.partselect = trunc i250 %201 to i8
  br label %src.addr.1130.exit

src.addr.1130.exit:                               ; preds = %src.addr.1130.case.3, %src.addr.1130.case.2, %src.addr.1130.case.1, %src.addr.1130.case.0, %src.addr.1028.exit
  %202 = phi i8 [ %_041.partselect, %src.addr.1130.case.0 ], [ %_142.partselect, %src.addr.1130.case.1 ], [ %_243.partselect, %src.addr.1130.case.2 ], [ %_344.partselect, %src.addr.1130.case.3 ], [ undef, %src.addr.1028.exit ]
  store i8 %202, i8* %dst.addr.1131, align 1
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 12
  switch i64 %for.loop.idx95, label %src.addr.1232.exit [
    i64 0, label %src.addr.1232.case.0
    i64 1, label %src.addr.1232.case.1
    i64 2, label %src.addr.1232.case.2
    i64 3, label %src.addr.1232.case.3
  ]

src.addr.1232.case.0:                             ; preds = %src.addr.1130.exit
  %203 = bitcast i250* %src_0 to i256*
  %204 = load i256, i256* %203
  %205 = trunc i256 %204 to i250
  %206 = lshr i250 %205, 157
  %_045.partselect = trunc i250 %206 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %207 = bitcast i250* %src_1 to i256*
  %208 = load i256, i256* %207
  %209 = trunc i256 %208 to i250
  %210 = lshr i250 %209, 157
  %_146.partselect = trunc i250 %210 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.2:                             ; preds = %src.addr.1130.exit
  %211 = bitcast i250* %src_2 to i256*
  %212 = load i256, i256* %211
  %213 = trunc i256 %212 to i250
  %214 = lshr i250 %213, 157
  %_247.partselect = trunc i250 %214 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.3:                             ; preds = %src.addr.1130.exit
  %215 = bitcast i250* %src_3 to i256*
  %216 = load i256, i256* %215
  %217 = trunc i256 %216 to i250
  %218 = lshr i250 %217, 157
  %_348.partselect = trunc i250 %218 to i32
  br label %src.addr.1232.exit

src.addr.1232.exit:                               ; preds = %src.addr.1232.case.3, %src.addr.1232.case.2, %src.addr.1232.case.1, %src.addr.1232.case.0, %src.addr.1130.exit
  %219 = phi i32 [ %_045.partselect, %src.addr.1232.case.0 ], [ %_146.partselect, %src.addr.1232.case.1 ], [ %_247.partselect, %src.addr.1232.case.2 ], [ %_348.partselect, %src.addr.1232.case.3 ], [ undef, %src.addr.1130.exit ]
  store i32 %219, i32* %dst.addr.1233, align 4
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 13
  switch i64 %for.loop.idx95, label %src.addr.1334.exit [
    i64 0, label %src.addr.1334.case.0
    i64 1, label %src.addr.1334.case.1
    i64 2, label %src.addr.1334.case.2
    i64 3, label %src.addr.1334.case.3
  ]

src.addr.1334.case.0:                             ; preds = %src.addr.1232.exit
  %220 = bitcast i250* %src_0 to i256*
  %221 = load i256, i256* %220
  %222 = trunc i256 %221 to i250
  %223 = lshr i250 %222, 189
  %_049.partselect = trunc i250 %223 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %224 = bitcast i250* %src_1 to i256*
  %225 = load i256, i256* %224
  %226 = trunc i256 %225 to i250
  %227 = lshr i250 %226, 189
  %_150.partselect = trunc i250 %227 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.2:                             ; preds = %src.addr.1232.exit
  %228 = bitcast i250* %src_2 to i256*
  %229 = load i256, i256* %228
  %230 = trunc i256 %229 to i250
  %231 = lshr i250 %230, 189
  %_251.partselect = trunc i250 %231 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.3:                             ; preds = %src.addr.1232.exit
  %232 = bitcast i250* %src_3 to i256*
  %233 = load i256, i256* %232
  %234 = trunc i256 %233 to i250
  %235 = lshr i250 %234, 189
  %_352.partselect = trunc i250 %235 to i32
  br label %src.addr.1334.exit

src.addr.1334.exit:                               ; preds = %src.addr.1334.case.3, %src.addr.1334.case.2, %src.addr.1334.case.1, %src.addr.1334.case.0, %src.addr.1232.exit
  %236 = phi i32 [ %_049.partselect, %src.addr.1334.case.0 ], [ %_150.partselect, %src.addr.1334.case.1 ], [ %_251.partselect, %src.addr.1334.case.2 ], [ %_352.partselect, %src.addr.1334.case.3 ], [ undef, %src.addr.1232.exit ]
  store i32 %236, i32* %dst.addr.1335, align 4
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 14
  switch i64 %for.loop.idx95, label %src.addr.1436.exit [
    i64 0, label %src.addr.1436.case.0
    i64 1, label %src.addr.1436.case.1
    i64 2, label %src.addr.1436.case.2
    i64 3, label %src.addr.1436.case.3
  ]

src.addr.1436.case.0:                             ; preds = %src.addr.1334.exit
  %237 = bitcast i250* %src_0 to i256*
  %238 = load i256, i256* %237
  %239 = trunc i256 %238 to i250
  %240 = lshr i250 %239, 221
  %_053.partselect = trunc i250 %240 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %241 = bitcast i250* %src_1 to i256*
  %242 = load i256, i256* %241
  %243 = trunc i256 %242 to i250
  %244 = lshr i250 %243, 221
  %_154.partselect = trunc i250 %244 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.2:                             ; preds = %src.addr.1334.exit
  %245 = bitcast i250* %src_2 to i256*
  %246 = load i256, i256* %245
  %247 = trunc i256 %246 to i250
  %248 = lshr i250 %247, 221
  %_255.partselect = trunc i250 %248 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.3:                             ; preds = %src.addr.1334.exit
  %249 = bitcast i250* %src_3 to i256*
  %250 = load i256, i256* %249
  %251 = trunc i256 %250 to i250
  %252 = lshr i250 %251, 221
  %_356.partselect = trunc i250 %252 to i1
  br label %src.addr.1436.exit

src.addr.1436.exit:                               ; preds = %src.addr.1436.case.3, %src.addr.1436.case.2, %src.addr.1436.case.1, %src.addr.1436.case.0, %src.addr.1334.exit
  %253 = phi i1 [ %_053.partselect, %src.addr.1436.case.0 ], [ %_154.partselect, %src.addr.1436.case.1 ], [ %_255.partselect, %src.addr.1436.case.2 ], [ %_356.partselect, %src.addr.1436.case.3 ], [ undef, %src.addr.1334.exit ]
  store i1 %253, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 15
  switch i64 %for.loop.idx95, label %src.addr.1538.exit [
    i64 0, label %src.addr.1538.case.0
    i64 1, label %src.addr.1538.case.1
    i64 2, label %src.addr.1538.case.2
    i64 3, label %src.addr.1538.case.3
  ]

src.addr.1538.case.0:                             ; preds = %src.addr.1436.exit
  %254 = bitcast i250* %src_0 to i256*
  %255 = load i256, i256* %254
  %256 = trunc i256 %255 to i250
  %257 = lshr i250 %256, 222
  %_057.partselect = trunc i250 %257 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %258 = bitcast i250* %src_1 to i256*
  %259 = load i256, i256* %258
  %260 = trunc i256 %259 to i250
  %261 = lshr i250 %260, 222
  %_158.partselect = trunc i250 %261 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.2:                             ; preds = %src.addr.1436.exit
  %262 = bitcast i250* %src_2 to i256*
  %263 = load i256, i256* %262
  %264 = trunc i256 %263 to i250
  %265 = lshr i250 %264, 222
  %_259.partselect = trunc i250 %265 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.3:                             ; preds = %src.addr.1436.exit
  %266 = bitcast i250* %src_3 to i256*
  %267 = load i256, i256* %266
  %268 = trunc i256 %267 to i250
  %269 = lshr i250 %268, 222
  %_360.partselect = trunc i250 %269 to i1
  br label %src.addr.1538.exit

src.addr.1538.exit:                               ; preds = %src.addr.1538.case.3, %src.addr.1538.case.2, %src.addr.1538.case.1, %src.addr.1538.case.0, %src.addr.1436.exit
  %270 = phi i1 [ %_057.partselect, %src.addr.1538.case.0 ], [ %_158.partselect, %src.addr.1538.case.1 ], [ %_259.partselect, %src.addr.1538.case.2 ], [ %_360.partselect, %src.addr.1538.case.3 ], [ undef, %src.addr.1436.exit ]
  store i1 %270, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 16
  switch i64 %for.loop.idx95, label %src.addr.1640.exit [
    i64 0, label %src.addr.1640.case.0
    i64 1, label %src.addr.1640.case.1
    i64 2, label %src.addr.1640.case.2
    i64 3, label %src.addr.1640.case.3
  ]

src.addr.1640.case.0:                             ; preds = %src.addr.1538.exit
  %271 = bitcast i250* %src_0 to i256*
  %272 = load i256, i256* %271
  %273 = trunc i256 %272 to i250
  %274 = lshr i250 %273, 223
  %_061.partselect = trunc i250 %274 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %275 = bitcast i250* %src_1 to i256*
  %276 = load i256, i256* %275
  %277 = trunc i256 %276 to i250
  %278 = lshr i250 %277, 223
  %_162.partselect = trunc i250 %278 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.2:                             ; preds = %src.addr.1538.exit
  %279 = bitcast i250* %src_2 to i256*
  %280 = load i256, i256* %279
  %281 = trunc i256 %280 to i250
  %282 = lshr i250 %281, 223
  %_263.partselect = trunc i250 %282 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.3:                             ; preds = %src.addr.1538.exit
  %283 = bitcast i250* %src_3 to i256*
  %284 = load i256, i256* %283
  %285 = trunc i256 %284 to i250
  %286 = lshr i250 %285, 223
  %_364.partselect = trunc i250 %286 to i1
  br label %src.addr.1640.exit

src.addr.1640.exit:                               ; preds = %src.addr.1640.case.3, %src.addr.1640.case.2, %src.addr.1640.case.1, %src.addr.1640.case.0, %src.addr.1538.exit
  %287 = phi i1 [ %_061.partselect, %src.addr.1640.case.0 ], [ %_162.partselect, %src.addr.1640.case.1 ], [ %_263.partselect, %src.addr.1640.case.2 ], [ %_364.partselect, %src.addr.1640.case.3 ], [ undef, %src.addr.1538.exit ]
  store i1 %287, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 17
  switch i64 %for.loop.idx95, label %src.addr.1742.exit [
    i64 0, label %src.addr.1742.case.0
    i64 1, label %src.addr.1742.case.1
    i64 2, label %src.addr.1742.case.2
    i64 3, label %src.addr.1742.case.3
  ]

src.addr.1742.case.0:                             ; preds = %src.addr.1640.exit
  %288 = bitcast i250* %src_0 to i256*
  %289 = load i256, i256* %288
  %290 = trunc i256 %289 to i250
  %291 = lshr i250 %290, 224
  %_065.partselect = trunc i250 %291 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %292 = bitcast i250* %src_1 to i256*
  %293 = load i256, i256* %292
  %294 = trunc i256 %293 to i250
  %295 = lshr i250 %294, 224
  %_166.partselect = trunc i250 %295 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.2:                             ; preds = %src.addr.1640.exit
  %296 = bitcast i250* %src_2 to i256*
  %297 = load i256, i256* %296
  %298 = trunc i256 %297 to i250
  %299 = lshr i250 %298, 224
  %_267.partselect = trunc i250 %299 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.3:                             ; preds = %src.addr.1640.exit
  %300 = bitcast i250* %src_3 to i256*
  %301 = load i256, i256* %300
  %302 = trunc i256 %301 to i250
  %303 = lshr i250 %302, 224
  %_368.partselect = trunc i250 %303 to i1
  br label %src.addr.1742.exit

src.addr.1742.exit:                               ; preds = %src.addr.1742.case.3, %src.addr.1742.case.2, %src.addr.1742.case.1, %src.addr.1742.case.0, %src.addr.1640.exit
  %304 = phi i1 [ %_065.partselect, %src.addr.1742.case.0 ], [ %_166.partselect, %src.addr.1742.case.1 ], [ %_267.partselect, %src.addr.1742.case.2 ], [ %_368.partselect, %src.addr.1742.case.3 ], [ undef, %src.addr.1640.exit ]
  store i1 %304, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 18
  switch i64 %for.loop.idx95, label %src.addr.1844.exit [
    i64 0, label %src.addr.1844.case.0
    i64 1, label %src.addr.1844.case.1
    i64 2, label %src.addr.1844.case.2
    i64 3, label %src.addr.1844.case.3
  ]

src.addr.1844.case.0:                             ; preds = %src.addr.1742.exit
  %305 = bitcast i250* %src_0 to i256*
  %306 = load i256, i256* %305
  %307 = trunc i256 %306 to i250
  %308 = lshr i250 %307, 225
  %_069.partselect = trunc i250 %308 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %309 = bitcast i250* %src_1 to i256*
  %310 = load i256, i256* %309
  %311 = trunc i256 %310 to i250
  %312 = lshr i250 %311, 225
  %_170.partselect = trunc i250 %312 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.2:                             ; preds = %src.addr.1742.exit
  %313 = bitcast i250* %src_2 to i256*
  %314 = load i256, i256* %313
  %315 = trunc i256 %314 to i250
  %316 = lshr i250 %315, 225
  %_271.partselect = trunc i250 %316 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.3:                             ; preds = %src.addr.1742.exit
  %317 = bitcast i250* %src_3 to i256*
  %318 = load i256, i256* %317
  %319 = trunc i256 %318 to i250
  %320 = lshr i250 %319, 225
  %_372.partselect = trunc i250 %320 to i1
  br label %src.addr.1844.exit

src.addr.1844.exit:                               ; preds = %src.addr.1844.case.3, %src.addr.1844.case.2, %src.addr.1844.case.1, %src.addr.1844.case.0, %src.addr.1742.exit
  %321 = phi i1 [ %_069.partselect, %src.addr.1844.case.0 ], [ %_170.partselect, %src.addr.1844.case.1 ], [ %_271.partselect, %src.addr.1844.case.2 ], [ %_372.partselect, %src.addr.1844.case.3 ], [ undef, %src.addr.1742.exit ]
  store i1 %321, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 19
  switch i64 %for.loop.idx95, label %src.addr.1946.exit [
    i64 0, label %src.addr.1946.case.0
    i64 1, label %src.addr.1946.case.1
    i64 2, label %src.addr.1946.case.2
    i64 3, label %src.addr.1946.case.3
  ]

src.addr.1946.case.0:                             ; preds = %src.addr.1844.exit
  %322 = bitcast i250* %src_0 to i256*
  %323 = load i256, i256* %322
  %324 = trunc i256 %323 to i250
  %325 = lshr i250 %324, 226
  %_073.partselect = trunc i250 %325 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %326 = bitcast i250* %src_1 to i256*
  %327 = load i256, i256* %326
  %328 = trunc i256 %327 to i250
  %329 = lshr i250 %328, 226
  %_174.partselect = trunc i250 %329 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.2:                             ; preds = %src.addr.1844.exit
  %330 = bitcast i250* %src_2 to i256*
  %331 = load i256, i256* %330
  %332 = trunc i256 %331 to i250
  %333 = lshr i250 %332, 226
  %_275.partselect = trunc i250 %333 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.3:                             ; preds = %src.addr.1844.exit
  %334 = bitcast i250* %src_3 to i256*
  %335 = load i256, i256* %334
  %336 = trunc i256 %335 to i250
  %337 = lshr i250 %336, 226
  %_376.partselect = trunc i250 %337 to i1
  br label %src.addr.1946.exit

src.addr.1946.exit:                               ; preds = %src.addr.1946.case.3, %src.addr.1946.case.2, %src.addr.1946.case.1, %src.addr.1946.case.0, %src.addr.1844.exit
  %338 = phi i1 [ %_073.partselect, %src.addr.1946.case.0 ], [ %_174.partselect, %src.addr.1946.case.1 ], [ %_275.partselect, %src.addr.1946.case.2 ], [ %_376.partselect, %src.addr.1946.case.3 ], [ undef, %src.addr.1844.exit ]
  store i1 %338, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 20
  switch i64 %for.loop.idx95, label %src.addr.2048.exit [
    i64 0, label %src.addr.2048.case.0
    i64 1, label %src.addr.2048.case.1
    i64 2, label %src.addr.2048.case.2
    i64 3, label %src.addr.2048.case.3
  ]

src.addr.2048.case.0:                             ; preds = %src.addr.1946.exit
  %339 = bitcast i250* %src_0 to i256*
  %340 = load i256, i256* %339
  %341 = trunc i256 %340 to i250
  %342 = lshr i250 %341, 227
  %_077.partselect = trunc i250 %342 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %343 = bitcast i250* %src_1 to i256*
  %344 = load i256, i256* %343
  %345 = trunc i256 %344 to i250
  %346 = lshr i250 %345, 227
  %_178.partselect = trunc i250 %346 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.2:                             ; preds = %src.addr.1946.exit
  %347 = bitcast i250* %src_2 to i256*
  %348 = load i256, i256* %347
  %349 = trunc i256 %348 to i250
  %350 = lshr i250 %349, 227
  %_279.partselect = trunc i250 %350 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.3:                             ; preds = %src.addr.1946.exit
  %351 = bitcast i250* %src_3 to i256*
  %352 = load i256, i256* %351
  %353 = trunc i256 %352 to i250
  %354 = lshr i250 %353, 227
  %_380.partselect = trunc i250 %354 to i1
  br label %src.addr.2048.exit

src.addr.2048.exit:                               ; preds = %src.addr.2048.case.3, %src.addr.2048.case.2, %src.addr.2048.case.1, %src.addr.2048.case.0, %src.addr.1946.exit
  %355 = phi i1 [ %_077.partselect, %src.addr.2048.case.0 ], [ %_178.partselect, %src.addr.2048.case.1 ], [ %_279.partselect, %src.addr.2048.case.2 ], [ %_380.partselect, %src.addr.2048.case.3 ], [ undef, %src.addr.1946.exit ]
  store i1 %355, i1* %dst.addr.2049, align 1
  %dst.addr.2151 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 21
  switch i64 %for.loop.idx95, label %src.addr.2150.exit [
    i64 0, label %src.addr.2150.case.0
    i64 1, label %src.addr.2150.case.1
    i64 2, label %src.addr.2150.case.2
    i64 3, label %src.addr.2150.case.3
  ]

src.addr.2150.case.0:                             ; preds = %src.addr.2048.exit
  %356 = bitcast i250* %src_0 to i256*
  %357 = load i256, i256* %356
  %358 = trunc i256 %357 to i250
  %359 = lshr i250 %358, 228
  %_081.partselect = trunc i250 %359 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.1:                             ; preds = %src.addr.2048.exit
  %360 = bitcast i250* %src_1 to i256*
  %361 = load i256, i256* %360
  %362 = trunc i256 %361 to i250
  %363 = lshr i250 %362, 228
  %_182.partselect = trunc i250 %363 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.2:                             ; preds = %src.addr.2048.exit
  %364 = bitcast i250* %src_2 to i256*
  %365 = load i256, i256* %364
  %366 = trunc i256 %365 to i250
  %367 = lshr i250 %366, 228
  %_283.partselect = trunc i250 %367 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.3:                             ; preds = %src.addr.2048.exit
  %368 = bitcast i250* %src_3 to i256*
  %369 = load i256, i256* %368
  %370 = trunc i256 %369 to i250
  %371 = lshr i250 %370, 228
  %_384.partselect = trunc i250 %371 to i1
  br label %src.addr.2150.exit

src.addr.2150.exit:                               ; preds = %src.addr.2150.case.3, %src.addr.2150.case.2, %src.addr.2150.case.1, %src.addr.2150.case.0, %src.addr.2048.exit
  %372 = phi i1 [ %_081.partselect, %src.addr.2150.case.0 ], [ %_182.partselect, %src.addr.2150.case.1 ], [ %_283.partselect, %src.addr.2150.case.2 ], [ %_384.partselect, %src.addr.2150.case.3 ], [ undef, %src.addr.2048.exit ]
  store i1 %372, i1* %dst.addr.2151, align 1
  %dst.addr.2253 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 22
  switch i64 %for.loop.idx95, label %src.addr.2252.exit [
    i64 0, label %src.addr.2252.case.0
    i64 1, label %src.addr.2252.case.1
    i64 2, label %src.addr.2252.case.2
    i64 3, label %src.addr.2252.case.3
  ]

src.addr.2252.case.0:                             ; preds = %src.addr.2150.exit
  %373 = bitcast i250* %src_0 to i256*
  %374 = load i256, i256* %373
  %375 = trunc i256 %374 to i250
  %376 = lshr i250 %375, 229
  %_085.partselect = trunc i250 %376 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.1:                             ; preds = %src.addr.2150.exit
  %377 = bitcast i250* %src_1 to i256*
  %378 = load i256, i256* %377
  %379 = trunc i256 %378 to i250
  %380 = lshr i250 %379, 229
  %_186.partselect = trunc i250 %380 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.2:                             ; preds = %src.addr.2150.exit
  %381 = bitcast i250* %src_2 to i256*
  %382 = load i256, i256* %381
  %383 = trunc i256 %382 to i250
  %384 = lshr i250 %383, 229
  %_287.partselect = trunc i250 %384 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.3:                             ; preds = %src.addr.2150.exit
  %385 = bitcast i250* %src_3 to i256*
  %386 = load i256, i256* %385
  %387 = trunc i256 %386 to i250
  %388 = lshr i250 %387, 229
  %_388.partselect = trunc i250 %388 to i1
  br label %src.addr.2252.exit

src.addr.2252.exit:                               ; preds = %src.addr.2252.case.3, %src.addr.2252.case.2, %src.addr.2252.case.1, %src.addr.2252.case.0, %src.addr.2150.exit
  %389 = phi i1 [ %_085.partselect, %src.addr.2252.case.0 ], [ %_186.partselect, %src.addr.2252.case.1 ], [ %_287.partselect, %src.addr.2252.case.2 ], [ %_388.partselect, %src.addr.2252.case.3 ], [ undef, %src.addr.2150.exit ]
  store i1 %389, i1* %dst.addr.2253, align 1
  %dst.addr.2355 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 23
  switch i64 %for.loop.idx95, label %src.addr.2354.exit [
    i64 0, label %src.addr.2354.case.0
    i64 1, label %src.addr.2354.case.1
    i64 2, label %src.addr.2354.case.2
    i64 3, label %src.addr.2354.case.3
  ]

src.addr.2354.case.0:                             ; preds = %src.addr.2252.exit
  %390 = bitcast i250* %src_0 to i256*
  %391 = load i256, i256* %390
  %392 = trunc i256 %391 to i250
  %393 = lshr i250 %392, 230
  %_089.partselect = trunc i250 %393 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.1:                             ; preds = %src.addr.2252.exit
  %394 = bitcast i250* %src_1 to i256*
  %395 = load i256, i256* %394
  %396 = trunc i256 %395 to i250
  %397 = lshr i250 %396, 230
  %_190.partselect = trunc i250 %397 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.2:                             ; preds = %src.addr.2252.exit
  %398 = bitcast i250* %src_2 to i256*
  %399 = load i256, i256* %398
  %400 = trunc i256 %399 to i250
  %401 = lshr i250 %400, 230
  %_291.partselect = trunc i250 %401 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.3:                             ; preds = %src.addr.2252.exit
  %402 = bitcast i250* %src_3 to i256*
  %403 = load i256, i256* %402
  %404 = trunc i256 %403 to i250
  %405 = lshr i250 %404, 230
  %_392.partselect = trunc i250 %405 to i1
  br label %src.addr.2354.exit

src.addr.2354.exit:                               ; preds = %src.addr.2354.case.3, %src.addr.2354.case.2, %src.addr.2354.case.1, %src.addr.2354.case.0, %src.addr.2252.exit
  %406 = phi i1 [ %_089.partselect, %src.addr.2354.case.0 ], [ %_190.partselect, %src.addr.2354.case.1 ], [ %_291.partselect, %src.addr.2354.case.2 ], [ %_392.partselect, %src.addr.2354.case.3 ], [ undef, %src.addr.2252.exit ]
  store i1 %406, i1* %dst.addr.2355, align 1
  %dst.addr.2457 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 24
  switch i64 %for.loop.idx95, label %src.addr.2456.exit [
    i64 0, label %src.addr.2456.case.0
    i64 1, label %src.addr.2456.case.1
    i64 2, label %src.addr.2456.case.2
    i64 3, label %src.addr.2456.case.3
  ]

src.addr.2456.case.0:                             ; preds = %src.addr.2354.exit
  %407 = bitcast i250* %src_0 to i256*
  %408 = load i256, i256* %407
  %409 = trunc i256 %408 to i250
  %410 = lshr i250 %409, 231
  %_093.partselect = trunc i250 %410 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.1:                             ; preds = %src.addr.2354.exit
  %411 = bitcast i250* %src_1 to i256*
  %412 = load i256, i256* %411
  %413 = trunc i256 %412 to i250
  %414 = lshr i250 %413, 231
  %_194.partselect = trunc i250 %414 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.2:                             ; preds = %src.addr.2354.exit
  %415 = bitcast i250* %src_2 to i256*
  %416 = load i256, i256* %415
  %417 = trunc i256 %416 to i250
  %418 = lshr i250 %417, 231
  %_295.partselect = trunc i250 %418 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.3:                             ; preds = %src.addr.2354.exit
  %419 = bitcast i250* %src_3 to i256*
  %420 = load i256, i256* %419
  %421 = trunc i256 %420 to i250
  %422 = lshr i250 %421, 231
  %_396.partselect = trunc i250 %422 to i1
  br label %src.addr.2456.exit

src.addr.2456.exit:                               ; preds = %src.addr.2456.case.3, %src.addr.2456.case.2, %src.addr.2456.case.1, %src.addr.2456.case.0, %src.addr.2354.exit
  %423 = phi i1 [ %_093.partselect, %src.addr.2456.case.0 ], [ %_194.partselect, %src.addr.2456.case.1 ], [ %_295.partselect, %src.addr.2456.case.2 ], [ %_396.partselect, %src.addr.2456.case.3 ], [ undef, %src.addr.2354.exit ]
  store i1 %423, i1* %dst.addr.2457, align 1
  %dst.addr.2559 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 25
  switch i64 %for.loop.idx95, label %src.addr.2558.exit [
    i64 0, label %src.addr.2558.case.0
    i64 1, label %src.addr.2558.case.1
    i64 2, label %src.addr.2558.case.2
    i64 3, label %src.addr.2558.case.3
  ]

src.addr.2558.case.0:                             ; preds = %src.addr.2456.exit
  %424 = bitcast i250* %src_0 to i256*
  %425 = load i256, i256* %424
  %426 = trunc i256 %425 to i250
  %427 = lshr i250 %426, 232
  %_097.partselect = trunc i250 %427 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.1:                             ; preds = %src.addr.2456.exit
  %428 = bitcast i250* %src_1 to i256*
  %429 = load i256, i256* %428
  %430 = trunc i256 %429 to i250
  %431 = lshr i250 %430, 232
  %_198.partselect = trunc i250 %431 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.2:                             ; preds = %src.addr.2456.exit
  %432 = bitcast i250* %src_2 to i256*
  %433 = load i256, i256* %432
  %434 = trunc i256 %433 to i250
  %435 = lshr i250 %434, 232
  %_299.partselect = trunc i250 %435 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.3:                             ; preds = %src.addr.2456.exit
  %436 = bitcast i250* %src_3 to i256*
  %437 = load i256, i256* %436
  %438 = trunc i256 %437 to i250
  %439 = lshr i250 %438, 232
  %_3100.partselect = trunc i250 %439 to i1
  br label %src.addr.2558.exit

src.addr.2558.exit:                               ; preds = %src.addr.2558.case.3, %src.addr.2558.case.2, %src.addr.2558.case.1, %src.addr.2558.case.0, %src.addr.2456.exit
  %440 = phi i1 [ %_097.partselect, %src.addr.2558.case.0 ], [ %_198.partselect, %src.addr.2558.case.1 ], [ %_299.partselect, %src.addr.2558.case.2 ], [ %_3100.partselect, %src.addr.2558.case.3 ], [ undef, %src.addr.2456.exit ]
  store i1 %440, i1* %dst.addr.2559, align 1
  %dst.addr.2661 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 26
  switch i64 %for.loop.idx95, label %src.addr.2660.exit [
    i64 0, label %src.addr.2660.case.0
    i64 1, label %src.addr.2660.case.1
    i64 2, label %src.addr.2660.case.2
    i64 3, label %src.addr.2660.case.3
  ]

src.addr.2660.case.0:                             ; preds = %src.addr.2558.exit
  %441 = bitcast i250* %src_0 to i256*
  %442 = load i256, i256* %441
  %443 = trunc i256 %442 to i250
  %444 = lshr i250 %443, 233
  %_0101.partselect = trunc i250 %444 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.1:                             ; preds = %src.addr.2558.exit
  %445 = bitcast i250* %src_1 to i256*
  %446 = load i256, i256* %445
  %447 = trunc i256 %446 to i250
  %448 = lshr i250 %447, 233
  %_1102.partselect = trunc i250 %448 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.2:                             ; preds = %src.addr.2558.exit
  %449 = bitcast i250* %src_2 to i256*
  %450 = load i256, i256* %449
  %451 = trunc i256 %450 to i250
  %452 = lshr i250 %451, 233
  %_2103.partselect = trunc i250 %452 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.3:                             ; preds = %src.addr.2558.exit
  %453 = bitcast i250* %src_3 to i256*
  %454 = load i256, i256* %453
  %455 = trunc i256 %454 to i250
  %456 = lshr i250 %455, 233
  %_3104.partselect = trunc i250 %456 to i1
  br label %src.addr.2660.exit

src.addr.2660.exit:                               ; preds = %src.addr.2660.case.3, %src.addr.2660.case.2, %src.addr.2660.case.1, %src.addr.2660.case.0, %src.addr.2558.exit
  %457 = phi i1 [ %_0101.partselect, %src.addr.2660.case.0 ], [ %_1102.partselect, %src.addr.2660.case.1 ], [ %_2103.partselect, %src.addr.2660.case.2 ], [ %_3104.partselect, %src.addr.2660.case.3 ], [ undef, %src.addr.2558.exit ]
  store i1 %457, i1* %dst.addr.2661, align 1
  %dst.addr.2763 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 27
  switch i64 %for.loop.idx95, label %src.addr.2762.exit [
    i64 0, label %src.addr.2762.case.0
    i64 1, label %src.addr.2762.case.1
    i64 2, label %src.addr.2762.case.2
    i64 3, label %src.addr.2762.case.3
  ]

src.addr.2762.case.0:                             ; preds = %src.addr.2660.exit
  %458 = bitcast i250* %src_0 to i256*
  %459 = load i256, i256* %458
  %460 = trunc i256 %459 to i250
  %461 = lshr i250 %460, 234
  %_0105.partselect = trunc i250 %461 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.1:                             ; preds = %src.addr.2660.exit
  %462 = bitcast i250* %src_1 to i256*
  %463 = load i256, i256* %462
  %464 = trunc i256 %463 to i250
  %465 = lshr i250 %464, 234
  %_1106.partselect = trunc i250 %465 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.2:                             ; preds = %src.addr.2660.exit
  %466 = bitcast i250* %src_2 to i256*
  %467 = load i256, i256* %466
  %468 = trunc i256 %467 to i250
  %469 = lshr i250 %468, 234
  %_2107.partselect = trunc i250 %469 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.3:                             ; preds = %src.addr.2660.exit
  %470 = bitcast i250* %src_3 to i256*
  %471 = load i256, i256* %470
  %472 = trunc i256 %471 to i250
  %473 = lshr i250 %472, 234
  %_3108.partselect = trunc i250 %473 to i1
  br label %src.addr.2762.exit

src.addr.2762.exit:                               ; preds = %src.addr.2762.case.3, %src.addr.2762.case.2, %src.addr.2762.case.1, %src.addr.2762.case.0, %src.addr.2660.exit
  %474 = phi i1 [ %_0105.partselect, %src.addr.2762.case.0 ], [ %_1106.partselect, %src.addr.2762.case.1 ], [ %_2107.partselect, %src.addr.2762.case.2 ], [ %_3108.partselect, %src.addr.2762.case.3 ], [ undef, %src.addr.2660.exit ]
  store i1 %474, i1* %dst.addr.2763, align 1
  %dst.addr.2865 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 28
  switch i64 %for.loop.idx95, label %src.addr.2864.exit [
    i64 0, label %src.addr.2864.case.0
    i64 1, label %src.addr.2864.case.1
    i64 2, label %src.addr.2864.case.2
    i64 3, label %src.addr.2864.case.3
  ]

src.addr.2864.case.0:                             ; preds = %src.addr.2762.exit
  %475 = bitcast i250* %src_0 to i256*
  %476 = load i256, i256* %475
  %477 = trunc i256 %476 to i250
  %478 = lshr i250 %477, 235
  %_0109.partselect = trunc i250 %478 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.1:                             ; preds = %src.addr.2762.exit
  %479 = bitcast i250* %src_1 to i256*
  %480 = load i256, i256* %479
  %481 = trunc i256 %480 to i250
  %482 = lshr i250 %481, 235
  %_1110.partselect = trunc i250 %482 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.2:                             ; preds = %src.addr.2762.exit
  %483 = bitcast i250* %src_2 to i256*
  %484 = load i256, i256* %483
  %485 = trunc i256 %484 to i250
  %486 = lshr i250 %485, 235
  %_2111.partselect = trunc i250 %486 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.3:                             ; preds = %src.addr.2762.exit
  %487 = bitcast i250* %src_3 to i256*
  %488 = load i256, i256* %487
  %489 = trunc i256 %488 to i250
  %490 = lshr i250 %489, 235
  %_3112.partselect = trunc i250 %490 to i1
  br label %src.addr.2864.exit

src.addr.2864.exit:                               ; preds = %src.addr.2864.case.3, %src.addr.2864.case.2, %src.addr.2864.case.1, %src.addr.2864.case.0, %src.addr.2762.exit
  %491 = phi i1 [ %_0109.partselect, %src.addr.2864.case.0 ], [ %_1110.partselect, %src.addr.2864.case.1 ], [ %_2111.partselect, %src.addr.2864.case.2 ], [ %_3112.partselect, %src.addr.2864.case.3 ], [ undef, %src.addr.2762.exit ]
  store i1 %491, i1* %dst.addr.2865, align 1
  %dst.addr.2967 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 29
  switch i64 %for.loop.idx95, label %src.addr.2966.exit [
    i64 0, label %src.addr.2966.case.0
    i64 1, label %src.addr.2966.case.1
    i64 2, label %src.addr.2966.case.2
    i64 3, label %src.addr.2966.case.3
  ]

src.addr.2966.case.0:                             ; preds = %src.addr.2864.exit
  %492 = bitcast i250* %src_0 to i256*
  %493 = load i256, i256* %492
  %494 = trunc i256 %493 to i250
  %495 = lshr i250 %494, 236
  %_0113.partselect = trunc i250 %495 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.1:                             ; preds = %src.addr.2864.exit
  %496 = bitcast i250* %src_1 to i256*
  %497 = load i256, i256* %496
  %498 = trunc i256 %497 to i250
  %499 = lshr i250 %498, 236
  %_1114.partselect = trunc i250 %499 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.2:                             ; preds = %src.addr.2864.exit
  %500 = bitcast i250* %src_2 to i256*
  %501 = load i256, i256* %500
  %502 = trunc i256 %501 to i250
  %503 = lshr i250 %502, 236
  %_2115.partselect = trunc i250 %503 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.3:                             ; preds = %src.addr.2864.exit
  %504 = bitcast i250* %src_3 to i256*
  %505 = load i256, i256* %504
  %506 = trunc i256 %505 to i250
  %507 = lshr i250 %506, 236
  %_3116.partselect = trunc i250 %507 to i1
  br label %src.addr.2966.exit

src.addr.2966.exit:                               ; preds = %src.addr.2966.case.3, %src.addr.2966.case.2, %src.addr.2966.case.1, %src.addr.2966.case.0, %src.addr.2864.exit
  %508 = phi i1 [ %_0113.partselect, %src.addr.2966.case.0 ], [ %_1114.partselect, %src.addr.2966.case.1 ], [ %_2115.partselect, %src.addr.2966.case.2 ], [ %_3116.partselect, %src.addr.2966.case.3 ], [ undef, %src.addr.2864.exit ]
  store i1 %508, i1* %dst.addr.2967, align 1
  %dst.addr.3069 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 30
  switch i64 %for.loop.idx95, label %src.addr.3068.exit [
    i64 0, label %src.addr.3068.case.0
    i64 1, label %src.addr.3068.case.1
    i64 2, label %src.addr.3068.case.2
    i64 3, label %src.addr.3068.case.3
  ]

src.addr.3068.case.0:                             ; preds = %src.addr.2966.exit
  %509 = bitcast i250* %src_0 to i256*
  %510 = load i256, i256* %509
  %511 = trunc i256 %510 to i250
  %512 = lshr i250 %511, 237
  %_0117.partselect = trunc i250 %512 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.1:                             ; preds = %src.addr.2966.exit
  %513 = bitcast i250* %src_1 to i256*
  %514 = load i256, i256* %513
  %515 = trunc i256 %514 to i250
  %516 = lshr i250 %515, 237
  %_1118.partselect = trunc i250 %516 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.2:                             ; preds = %src.addr.2966.exit
  %517 = bitcast i250* %src_2 to i256*
  %518 = load i256, i256* %517
  %519 = trunc i256 %518 to i250
  %520 = lshr i250 %519, 237
  %_2119.partselect = trunc i250 %520 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.3:                             ; preds = %src.addr.2966.exit
  %521 = bitcast i250* %src_3 to i256*
  %522 = load i256, i256* %521
  %523 = trunc i256 %522 to i250
  %524 = lshr i250 %523, 237
  %_3120.partselect = trunc i250 %524 to i1
  br label %src.addr.3068.exit

src.addr.3068.exit:                               ; preds = %src.addr.3068.case.3, %src.addr.3068.case.2, %src.addr.3068.case.1, %src.addr.3068.case.0, %src.addr.2966.exit
  %525 = phi i1 [ %_0117.partselect, %src.addr.3068.case.0 ], [ %_1118.partselect, %src.addr.3068.case.1 ], [ %_2119.partselect, %src.addr.3068.case.2 ], [ %_3120.partselect, %src.addr.3068.case.3 ], [ undef, %src.addr.2966.exit ]
  store i1 %525, i1* %dst.addr.3069, align 1
  %dst.addr.3171 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 31
  switch i64 %for.loop.idx95, label %src.addr.3170.exit [
    i64 0, label %src.addr.3170.case.0
    i64 1, label %src.addr.3170.case.1
    i64 2, label %src.addr.3170.case.2
    i64 3, label %src.addr.3170.case.3
  ]

src.addr.3170.case.0:                             ; preds = %src.addr.3068.exit
  %526 = bitcast i250* %src_0 to i256*
  %527 = load i256, i256* %526
  %528 = trunc i256 %527 to i250
  %529 = lshr i250 %528, 238
  %_0121.partselect = trunc i250 %529 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.1:                             ; preds = %src.addr.3068.exit
  %530 = bitcast i250* %src_1 to i256*
  %531 = load i256, i256* %530
  %532 = trunc i256 %531 to i250
  %533 = lshr i250 %532, 238
  %_1122.partselect = trunc i250 %533 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.2:                             ; preds = %src.addr.3068.exit
  %534 = bitcast i250* %src_2 to i256*
  %535 = load i256, i256* %534
  %536 = trunc i256 %535 to i250
  %537 = lshr i250 %536, 238
  %_2123.partselect = trunc i250 %537 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.3:                             ; preds = %src.addr.3068.exit
  %538 = bitcast i250* %src_3 to i256*
  %539 = load i256, i256* %538
  %540 = trunc i256 %539 to i250
  %541 = lshr i250 %540, 238
  %_3124.partselect = trunc i250 %541 to i1
  br label %src.addr.3170.exit

src.addr.3170.exit:                               ; preds = %src.addr.3170.case.3, %src.addr.3170.case.2, %src.addr.3170.case.1, %src.addr.3170.case.0, %src.addr.3068.exit
  %542 = phi i1 [ %_0121.partselect, %src.addr.3170.case.0 ], [ %_1122.partselect, %src.addr.3170.case.1 ], [ %_2123.partselect, %src.addr.3170.case.2 ], [ %_3124.partselect, %src.addr.3170.case.3 ], [ undef, %src.addr.3068.exit ]
  store i1 %542, i1* %dst.addr.3171, align 1
  %dst.addr.3273 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 32
  switch i64 %for.loop.idx95, label %src.addr.3272.exit [
    i64 0, label %src.addr.3272.case.0
    i64 1, label %src.addr.3272.case.1
    i64 2, label %src.addr.3272.case.2
    i64 3, label %src.addr.3272.case.3
  ]

src.addr.3272.case.0:                             ; preds = %src.addr.3170.exit
  %543 = bitcast i250* %src_0 to i256*
  %544 = load i256, i256* %543
  %545 = trunc i256 %544 to i250
  %546 = lshr i250 %545, 239
  %_0125.partselect = trunc i250 %546 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.1:                             ; preds = %src.addr.3170.exit
  %547 = bitcast i250* %src_1 to i256*
  %548 = load i256, i256* %547
  %549 = trunc i256 %548 to i250
  %550 = lshr i250 %549, 239
  %_1126.partselect = trunc i250 %550 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.2:                             ; preds = %src.addr.3170.exit
  %551 = bitcast i250* %src_2 to i256*
  %552 = load i256, i256* %551
  %553 = trunc i256 %552 to i250
  %554 = lshr i250 %553, 239
  %_2127.partselect = trunc i250 %554 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.3:                             ; preds = %src.addr.3170.exit
  %555 = bitcast i250* %src_3 to i256*
  %556 = load i256, i256* %555
  %557 = trunc i256 %556 to i250
  %558 = lshr i250 %557, 239
  %_3128.partselect = trunc i250 %558 to i1
  br label %src.addr.3272.exit

src.addr.3272.exit:                               ; preds = %src.addr.3272.case.3, %src.addr.3272.case.2, %src.addr.3272.case.1, %src.addr.3272.case.0, %src.addr.3170.exit
  %559 = phi i1 [ %_0125.partselect, %src.addr.3272.case.0 ], [ %_1126.partselect, %src.addr.3272.case.1 ], [ %_2127.partselect, %src.addr.3272.case.2 ], [ %_3128.partselect, %src.addr.3272.case.3 ], [ undef, %src.addr.3170.exit ]
  store i1 %559, i1* %dst.addr.3273, align 1
  %dst.addr.3375 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 33
  switch i64 %for.loop.idx95, label %src.addr.3374.exit [
    i64 0, label %src.addr.3374.case.0
    i64 1, label %src.addr.3374.case.1
    i64 2, label %src.addr.3374.case.2
    i64 3, label %src.addr.3374.case.3
  ]

src.addr.3374.case.0:                             ; preds = %src.addr.3272.exit
  %560 = bitcast i250* %src_0 to i256*
  %561 = load i256, i256* %560
  %562 = trunc i256 %561 to i250
  %563 = lshr i250 %562, 240
  %_0129.partselect = trunc i250 %563 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.1:                             ; preds = %src.addr.3272.exit
  %564 = bitcast i250* %src_1 to i256*
  %565 = load i256, i256* %564
  %566 = trunc i256 %565 to i250
  %567 = lshr i250 %566, 240
  %_1130.partselect = trunc i250 %567 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.2:                             ; preds = %src.addr.3272.exit
  %568 = bitcast i250* %src_2 to i256*
  %569 = load i256, i256* %568
  %570 = trunc i256 %569 to i250
  %571 = lshr i250 %570, 240
  %_2131.partselect = trunc i250 %571 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.3:                             ; preds = %src.addr.3272.exit
  %572 = bitcast i250* %src_3 to i256*
  %573 = load i256, i256* %572
  %574 = trunc i256 %573 to i250
  %575 = lshr i250 %574, 240
  %_3132.partselect = trunc i250 %575 to i1
  br label %src.addr.3374.exit

src.addr.3374.exit:                               ; preds = %src.addr.3374.case.3, %src.addr.3374.case.2, %src.addr.3374.case.1, %src.addr.3374.case.0, %src.addr.3272.exit
  %576 = phi i1 [ %_0129.partselect, %src.addr.3374.case.0 ], [ %_1130.partselect, %src.addr.3374.case.1 ], [ %_2131.partselect, %src.addr.3374.case.2 ], [ %_3132.partselect, %src.addr.3374.case.3 ], [ undef, %src.addr.3272.exit ]
  store i1 %576, i1* %dst.addr.3375, align 1
  %dst.addr.3477 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 34
  switch i64 %for.loop.idx95, label %src.addr.3476.exit [
    i64 0, label %src.addr.3476.case.0
    i64 1, label %src.addr.3476.case.1
    i64 2, label %src.addr.3476.case.2
    i64 3, label %src.addr.3476.case.3
  ]

src.addr.3476.case.0:                             ; preds = %src.addr.3374.exit
  %577 = bitcast i250* %src_0 to i256*
  %578 = load i256, i256* %577
  %579 = trunc i256 %578 to i250
  %580 = lshr i250 %579, 241
  %_0133.partselect = trunc i250 %580 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.1:                             ; preds = %src.addr.3374.exit
  %581 = bitcast i250* %src_1 to i256*
  %582 = load i256, i256* %581
  %583 = trunc i256 %582 to i250
  %584 = lshr i250 %583, 241
  %_1134.partselect = trunc i250 %584 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.2:                             ; preds = %src.addr.3374.exit
  %585 = bitcast i250* %src_2 to i256*
  %586 = load i256, i256* %585
  %587 = trunc i256 %586 to i250
  %588 = lshr i250 %587, 241
  %_2135.partselect = trunc i250 %588 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.3:                             ; preds = %src.addr.3374.exit
  %589 = bitcast i250* %src_3 to i256*
  %590 = load i256, i256* %589
  %591 = trunc i256 %590 to i250
  %592 = lshr i250 %591, 241
  %_3136.partselect = trunc i250 %592 to i1
  br label %src.addr.3476.exit

src.addr.3476.exit:                               ; preds = %src.addr.3476.case.3, %src.addr.3476.case.2, %src.addr.3476.case.1, %src.addr.3476.case.0, %src.addr.3374.exit
  %593 = phi i1 [ %_0133.partselect, %src.addr.3476.case.0 ], [ %_1134.partselect, %src.addr.3476.case.1 ], [ %_2135.partselect, %src.addr.3476.case.2 ], [ %_3136.partselect, %src.addr.3476.case.3 ], [ undef, %src.addr.3374.exit ]
  store i1 %593, i1* %dst.addr.3477, align 1
  %dst.addr.3579 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 35
  switch i64 %for.loop.idx95, label %src.addr.3578.exit [
    i64 0, label %src.addr.3578.case.0
    i64 1, label %src.addr.3578.case.1
    i64 2, label %src.addr.3578.case.2
    i64 3, label %src.addr.3578.case.3
  ]

src.addr.3578.case.0:                             ; preds = %src.addr.3476.exit
  %594 = bitcast i250* %src_0 to i256*
  %595 = load i256, i256* %594
  %596 = trunc i256 %595 to i250
  %597 = lshr i250 %596, 242
  %_0137.partselect = trunc i250 %597 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.1:                             ; preds = %src.addr.3476.exit
  %598 = bitcast i250* %src_1 to i256*
  %599 = load i256, i256* %598
  %600 = trunc i256 %599 to i250
  %601 = lshr i250 %600, 242
  %_1138.partselect = trunc i250 %601 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.2:                             ; preds = %src.addr.3476.exit
  %602 = bitcast i250* %src_2 to i256*
  %603 = load i256, i256* %602
  %604 = trunc i256 %603 to i250
  %605 = lshr i250 %604, 242
  %_2139.partselect = trunc i250 %605 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.3:                             ; preds = %src.addr.3476.exit
  %606 = bitcast i250* %src_3 to i256*
  %607 = load i256, i256* %606
  %608 = trunc i256 %607 to i250
  %609 = lshr i250 %608, 242
  %_3140.partselect = trunc i250 %609 to i1
  br label %src.addr.3578.exit

src.addr.3578.exit:                               ; preds = %src.addr.3578.case.3, %src.addr.3578.case.2, %src.addr.3578.case.1, %src.addr.3578.case.0, %src.addr.3476.exit
  %610 = phi i1 [ %_0137.partselect, %src.addr.3578.case.0 ], [ %_1138.partselect, %src.addr.3578.case.1 ], [ %_2139.partselect, %src.addr.3578.case.2 ], [ %_3140.partselect, %src.addr.3578.case.3 ], [ undef, %src.addr.3476.exit ]
  store i1 %610, i1* %dst.addr.3579, align 1
  %dst.addr.3681 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 36
  switch i64 %for.loop.idx95, label %src.addr.3680.exit [
    i64 0, label %src.addr.3680.case.0
    i64 1, label %src.addr.3680.case.1
    i64 2, label %src.addr.3680.case.2
    i64 3, label %src.addr.3680.case.3
  ]

src.addr.3680.case.0:                             ; preds = %src.addr.3578.exit
  %611 = bitcast i250* %src_0 to i256*
  %612 = load i256, i256* %611
  %613 = trunc i256 %612 to i250
  %614 = lshr i250 %613, 243
  %_0141.partselect = trunc i250 %614 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.1:                             ; preds = %src.addr.3578.exit
  %615 = bitcast i250* %src_1 to i256*
  %616 = load i256, i256* %615
  %617 = trunc i256 %616 to i250
  %618 = lshr i250 %617, 243
  %_1142.partselect = trunc i250 %618 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.2:                             ; preds = %src.addr.3578.exit
  %619 = bitcast i250* %src_2 to i256*
  %620 = load i256, i256* %619
  %621 = trunc i256 %620 to i250
  %622 = lshr i250 %621, 243
  %_2143.partselect = trunc i250 %622 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.3:                             ; preds = %src.addr.3578.exit
  %623 = bitcast i250* %src_3 to i256*
  %624 = load i256, i256* %623
  %625 = trunc i256 %624 to i250
  %626 = lshr i250 %625, 243
  %_3144.partselect = trunc i250 %626 to i1
  br label %src.addr.3680.exit

src.addr.3680.exit:                               ; preds = %src.addr.3680.case.3, %src.addr.3680.case.2, %src.addr.3680.case.1, %src.addr.3680.case.0, %src.addr.3578.exit
  %627 = phi i1 [ %_0141.partselect, %src.addr.3680.case.0 ], [ %_1142.partselect, %src.addr.3680.case.1 ], [ %_2143.partselect, %src.addr.3680.case.2 ], [ %_3144.partselect, %src.addr.3680.case.3 ], [ undef, %src.addr.3578.exit ]
  store i1 %627, i1* %dst.addr.3681, align 1
  %dst.addr.3783 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 37
  switch i64 %for.loop.idx95, label %src.addr.3782.exit [
    i64 0, label %src.addr.3782.case.0
    i64 1, label %src.addr.3782.case.1
    i64 2, label %src.addr.3782.case.2
    i64 3, label %src.addr.3782.case.3
  ]

src.addr.3782.case.0:                             ; preds = %src.addr.3680.exit
  %628 = bitcast i250* %src_0 to i256*
  %629 = load i256, i256* %628
  %630 = trunc i256 %629 to i250
  %631 = lshr i250 %630, 244
  %_0145.partselect = trunc i250 %631 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.1:                             ; preds = %src.addr.3680.exit
  %632 = bitcast i250* %src_1 to i256*
  %633 = load i256, i256* %632
  %634 = trunc i256 %633 to i250
  %635 = lshr i250 %634, 244
  %_1146.partselect = trunc i250 %635 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.2:                             ; preds = %src.addr.3680.exit
  %636 = bitcast i250* %src_2 to i256*
  %637 = load i256, i256* %636
  %638 = trunc i256 %637 to i250
  %639 = lshr i250 %638, 244
  %_2147.partselect = trunc i250 %639 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.3:                             ; preds = %src.addr.3680.exit
  %640 = bitcast i250* %src_3 to i256*
  %641 = load i256, i256* %640
  %642 = trunc i256 %641 to i250
  %643 = lshr i250 %642, 244
  %_3148.partselect = trunc i250 %643 to i1
  br label %src.addr.3782.exit

src.addr.3782.exit:                               ; preds = %src.addr.3782.case.3, %src.addr.3782.case.2, %src.addr.3782.case.1, %src.addr.3782.case.0, %src.addr.3680.exit
  %644 = phi i1 [ %_0145.partselect, %src.addr.3782.case.0 ], [ %_1146.partselect, %src.addr.3782.case.1 ], [ %_2147.partselect, %src.addr.3782.case.2 ], [ %_3148.partselect, %src.addr.3782.case.3 ], [ undef, %src.addr.3680.exit ]
  store i1 %644, i1* %dst.addr.3783, align 1
  %dst.addr.3885 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 38
  switch i64 %for.loop.idx95, label %src.addr.3884.exit [
    i64 0, label %src.addr.3884.case.0
    i64 1, label %src.addr.3884.case.1
    i64 2, label %src.addr.3884.case.2
    i64 3, label %src.addr.3884.case.3
  ]

src.addr.3884.case.0:                             ; preds = %src.addr.3782.exit
  %645 = bitcast i250* %src_0 to i256*
  %646 = load i256, i256* %645
  %647 = trunc i256 %646 to i250
  %648 = lshr i250 %647, 245
  %_0149.partselect = trunc i250 %648 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.1:                             ; preds = %src.addr.3782.exit
  %649 = bitcast i250* %src_1 to i256*
  %650 = load i256, i256* %649
  %651 = trunc i256 %650 to i250
  %652 = lshr i250 %651, 245
  %_1150.partselect = trunc i250 %652 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.2:                             ; preds = %src.addr.3782.exit
  %653 = bitcast i250* %src_2 to i256*
  %654 = load i256, i256* %653
  %655 = trunc i256 %654 to i250
  %656 = lshr i250 %655, 245
  %_2151.partselect = trunc i250 %656 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.3:                             ; preds = %src.addr.3782.exit
  %657 = bitcast i250* %src_3 to i256*
  %658 = load i256, i256* %657
  %659 = trunc i256 %658 to i250
  %660 = lshr i250 %659, 245
  %_3152.partselect = trunc i250 %660 to i1
  br label %src.addr.3884.exit

src.addr.3884.exit:                               ; preds = %src.addr.3884.case.3, %src.addr.3884.case.2, %src.addr.3884.case.1, %src.addr.3884.case.0, %src.addr.3782.exit
  %661 = phi i1 [ %_0149.partselect, %src.addr.3884.case.0 ], [ %_1150.partselect, %src.addr.3884.case.1 ], [ %_2151.partselect, %src.addr.3884.case.2 ], [ %_3152.partselect, %src.addr.3884.case.3 ], [ undef, %src.addr.3782.exit ]
  store i1 %661, i1* %dst.addr.3885, align 1
  %dst.addr.3987 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 39
  switch i64 %for.loop.idx95, label %src.addr.3986.exit [
    i64 0, label %src.addr.3986.case.0
    i64 1, label %src.addr.3986.case.1
    i64 2, label %src.addr.3986.case.2
    i64 3, label %src.addr.3986.case.3
  ]

src.addr.3986.case.0:                             ; preds = %src.addr.3884.exit
  %662 = bitcast i250* %src_0 to i256*
  %663 = load i256, i256* %662
  %664 = trunc i256 %663 to i250
  %665 = lshr i250 %664, 246
  %_0153.partselect = trunc i250 %665 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.1:                             ; preds = %src.addr.3884.exit
  %666 = bitcast i250* %src_1 to i256*
  %667 = load i256, i256* %666
  %668 = trunc i256 %667 to i250
  %669 = lshr i250 %668, 246
  %_1154.partselect = trunc i250 %669 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.2:                             ; preds = %src.addr.3884.exit
  %670 = bitcast i250* %src_2 to i256*
  %671 = load i256, i256* %670
  %672 = trunc i256 %671 to i250
  %673 = lshr i250 %672, 246
  %_2155.partselect = trunc i250 %673 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.3:                             ; preds = %src.addr.3884.exit
  %674 = bitcast i250* %src_3 to i256*
  %675 = load i256, i256* %674
  %676 = trunc i256 %675 to i250
  %677 = lshr i250 %676, 246
  %_3156.partselect = trunc i250 %677 to i1
  br label %src.addr.3986.exit

src.addr.3986.exit:                               ; preds = %src.addr.3986.case.3, %src.addr.3986.case.2, %src.addr.3986.case.1, %src.addr.3986.case.0, %src.addr.3884.exit
  %678 = phi i1 [ %_0153.partselect, %src.addr.3986.case.0 ], [ %_1154.partselect, %src.addr.3986.case.1 ], [ %_2155.partselect, %src.addr.3986.case.2 ], [ %_3156.partselect, %src.addr.3986.case.3 ], [ undef, %src.addr.3884.exit ]
  store i1 %678, i1* %dst.addr.3987, align 1
  %dst.addr.4089 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 40
  switch i64 %for.loop.idx95, label %src.addr.4088.exit [
    i64 0, label %src.addr.4088.case.0
    i64 1, label %src.addr.4088.case.1
    i64 2, label %src.addr.4088.case.2
    i64 3, label %src.addr.4088.case.3
  ]

src.addr.4088.case.0:                             ; preds = %src.addr.3986.exit
  %679 = bitcast i250* %src_0 to i256*
  %680 = load i256, i256* %679
  %681 = trunc i256 %680 to i250
  %682 = lshr i250 %681, 247
  %_0157.partselect = trunc i250 %682 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.1:                             ; preds = %src.addr.3986.exit
  %683 = bitcast i250* %src_1 to i256*
  %684 = load i256, i256* %683
  %685 = trunc i256 %684 to i250
  %686 = lshr i250 %685, 247
  %_1158.partselect = trunc i250 %686 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.2:                             ; preds = %src.addr.3986.exit
  %687 = bitcast i250* %src_2 to i256*
  %688 = load i256, i256* %687
  %689 = trunc i256 %688 to i250
  %690 = lshr i250 %689, 247
  %_2159.partselect = trunc i250 %690 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.3:                             ; preds = %src.addr.3986.exit
  %691 = bitcast i250* %src_3 to i256*
  %692 = load i256, i256* %691
  %693 = trunc i256 %692 to i250
  %694 = lshr i250 %693, 247
  %_3160.partselect = trunc i250 %694 to i1
  br label %src.addr.4088.exit

src.addr.4088.exit:                               ; preds = %src.addr.4088.case.3, %src.addr.4088.case.2, %src.addr.4088.case.1, %src.addr.4088.case.0, %src.addr.3986.exit
  %695 = phi i1 [ %_0157.partselect, %src.addr.4088.case.0 ], [ %_1158.partselect, %src.addr.4088.case.1 ], [ %_2159.partselect, %src.addr.4088.case.2 ], [ %_3160.partselect, %src.addr.4088.case.3 ], [ undef, %src.addr.3986.exit ]
  store i1 %695, i1* %dst.addr.4089, align 1
  %dst.addr.4191 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 41
  switch i64 %for.loop.idx95, label %src.addr.4190.exit [
    i64 0, label %src.addr.4190.case.0
    i64 1, label %src.addr.4190.case.1
    i64 2, label %src.addr.4190.case.2
    i64 3, label %src.addr.4190.case.3
  ]

src.addr.4190.case.0:                             ; preds = %src.addr.4088.exit
  %696 = bitcast i250* %src_0 to i256*
  %697 = load i256, i256* %696
  %698 = trunc i256 %697 to i250
  %699 = lshr i250 %698, 248
  %_0161.partselect = trunc i250 %699 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.1:                             ; preds = %src.addr.4088.exit
  %700 = bitcast i250* %src_1 to i256*
  %701 = load i256, i256* %700
  %702 = trunc i256 %701 to i250
  %703 = lshr i250 %702, 248
  %_1162.partselect = trunc i250 %703 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.2:                             ; preds = %src.addr.4088.exit
  %704 = bitcast i250* %src_2 to i256*
  %705 = load i256, i256* %704
  %706 = trunc i256 %705 to i250
  %707 = lshr i250 %706, 248
  %_2163.partselect = trunc i250 %707 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.3:                             ; preds = %src.addr.4088.exit
  %708 = bitcast i250* %src_3 to i256*
  %709 = load i256, i256* %708
  %710 = trunc i256 %709 to i250
  %711 = lshr i250 %710, 248
  %_3164.partselect = trunc i250 %711 to i1
  br label %src.addr.4190.exit

src.addr.4190.exit:                               ; preds = %src.addr.4190.case.3, %src.addr.4190.case.2, %src.addr.4190.case.1, %src.addr.4190.case.0, %src.addr.4088.exit
  %712 = phi i1 [ %_0161.partselect, %src.addr.4190.case.0 ], [ %_1162.partselect, %src.addr.4190.case.1 ], [ %_2163.partselect, %src.addr.4190.case.2 ], [ %_3164.partselect, %src.addr.4190.case.3 ], [ undef, %src.addr.4088.exit ]
  store i1 %712, i1* %dst.addr.4191, align 1
  %dst.addr.4293 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 42
  switch i64 %for.loop.idx95, label %src.addr.4292.exit [
    i64 0, label %src.addr.4292.case.0
    i64 1, label %src.addr.4292.case.1
    i64 2, label %src.addr.4292.case.2
    i64 3, label %src.addr.4292.case.3
  ]

src.addr.4292.case.0:                             ; preds = %src.addr.4190.exit
  %713 = bitcast i250* %src_0 to i256*
  %714 = load i256, i256* %713
  %715 = trunc i256 %714 to i250
  %716 = lshr i250 %715, 249
  %_0165.partselect = trunc i250 %716 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.1:                             ; preds = %src.addr.4190.exit
  %717 = bitcast i250* %src_1 to i256*
  %718 = load i256, i256* %717
  %719 = trunc i256 %718 to i250
  %720 = lshr i250 %719, 249
  %_1166.partselect = trunc i250 %720 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.2:                             ; preds = %src.addr.4190.exit
  %721 = bitcast i250* %src_2 to i256*
  %722 = load i256, i256* %721
  %723 = trunc i256 %722 to i250
  %724 = lshr i250 %723, 249
  %_2167.partselect = trunc i250 %724 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.3:                             ; preds = %src.addr.4190.exit
  %725 = bitcast i250* %src_3 to i256*
  %726 = load i256, i256* %725
  %727 = trunc i256 %726 to i250
  %728 = lshr i250 %727, 249
  %_3168.partselect = trunc i250 %728 to i1
  br label %src.addr.4292.exit

src.addr.4292.exit:                               ; preds = %src.addr.4292.case.3, %src.addr.4292.case.2, %src.addr.4292.case.1, %src.addr.4292.case.0, %src.addr.4190.exit
  %729 = phi i1 [ %_0165.partselect, %src.addr.4292.case.0 ], [ %_1166.partselect, %src.addr.4292.case.1 ], [ %_2167.partselect, %src.addr.4292.case.2 ], [ %_3168.partselect, %src.addr.4292.case.3 ], [ undef, %src.addr.4190.exit ]
  store i1 %729, i1* %dst.addr.4293, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx95, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.4292.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i250* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i250* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1, i250* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.2" %src_2, i250* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.3" %src_3) #1 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i250* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.23.24([4 x %struct.HeadCtx]* nonnull %dst, i250* nonnull %src_0, i250* %src_1, i250* %src_2, i250* %src_3, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i8* noalias "orig.arg.no"="4", i8* noalias readonly align 512 "orig.arg.no"="5", i32* noalias "orig.arg.no"="6", i32* noalias readonly align 512 "orig.arg.no"="7", i32* noalias "orig.arg.no"="8", i32* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", i1* noalias "orig.arg.no"="12", i1* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="16", i250* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i250* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i250* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i250* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias "orig.arg.no"="18", i1* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21", i1* noalias "orig.arg.no"="22", i1* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias "orig.arg.no"="26", i1056* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i32* noalias "orig.arg.no"="52", i32* noalias readonly align 512 "orig.arg.no"="53", i32* noalias "orig.arg.no"="54", i32* noalias readonly align 512 "orig.arg.no"="55", i32* noalias "orig.arg.no"="56", i32* noalias readonly align 512 "orig.arg.no"="57", i1* noalias "orig.arg.no"="58", i1* noalias readonly align 512 "orig.arg.no"="59", i1* noalias "orig.arg.no"="60", i1* noalias readonly align 512 "orig.arg.no"="61") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %4, i8* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %6, i32* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %12, i1* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* %16, i250* align 512 %_0, i250* align 512 %_1, i250* align 512 %_2, i250* align 512 %_3)
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

declare void @apatb_transformer_top_hw(i1, i1, i1*, i1, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1*, i32*, i250*, i250*, i250*, i250*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i8* noalias "orig.arg.no"="4", i8* noalias readonly align 512 "orig.arg.no"="5", i32* noalias "orig.arg.no"="6", i32* noalias readonly align 512 "orig.arg.no"="7", i32* noalias "orig.arg.no"="8", i32* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", i1* noalias "orig.arg.no"="12", i1* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="16", i250* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i250* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i250* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i250* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias "orig.arg.no"="18", i1* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21", i1* noalias "orig.arg.no"="22", i1* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias "orig.arg.no"="26", i1056* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i32* noalias "orig.arg.no"="52", i32* noalias readonly align 512 "orig.arg.no"="53", i32* noalias "orig.arg.no"="54", i32* noalias readonly align 512 "orig.arg.no"="55", i32* noalias "orig.arg.no"="56", i32* noalias readonly align 512 "orig.arg.no"="57", i1* noalias "orig.arg.no"="58", i1* noalias readonly align 512 "orig.arg.no"="59", i1* noalias "orig.arg.no"="60", i1* noalias readonly align 512 "orig.arg.no"="61") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %4, i8* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %6, i32* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %12, i1* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* %16, i250* align 512 %_0, i250* align 512 %_1, i250* align 512 %_2, i250* align 512 %_3)
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

define void @transformer_top_hw_stub_wrapper(i1, i1, i1*, i1, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1*, i32*, i250*, i250*, i250*, i250*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i1*) #5 {
entry:
  %48 = call i8* @malloc(i64 256)
  %49 = bitcast i8* %48 to [4 x %struct.HeadCtx]*
  %50 = call i8* @malloc(i64 132)
  %51 = bitcast i8* %50 to %struct.ControlMemSpace*
  call void @copy_out(i1* null, i1* %2, i1* null, i1* %5, i8* null, i8* %6, i32* null, i32* %7, i32* null, i32* %8, i32* null, i32* %9, i1* null, i1* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %49, i250* %14, i250* %15, i250* %16, i250* %17, i1* null, i1* %19, i32* null, i32* %23, i1* null, i1* %28, i32* null, i32* %29, %struct.ControlMemSpace* %51, i1056* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i32* null, i32* %42, i32* null, i32* %43, i32* null, i32* %44, i32* null, i32* %45, i1* null, i1* %46, i1* null, i1* %47)
  call void @transformer_top_hw_stub(i1 %0, i1 %1, i1* %2, i1 %3, i1 %4, i1* %5, i8* %6, i32* %7, i32* %8, i32* %9, i1 %10, i1 %11, i1* %12, i32* %13, [4 x %struct.HeadCtx]* %49, i1 %18, i1* %19, i1 %20, i32 %21, i32 %22, i32* %23, i1 %24, i1 %25, i1 %26, i1 %27, i1* %28, i32* %29, %struct.ControlMemSpace* %51, i32* %31, i32* %32, i32* %33, i32* %34, i32* %35, i32* %36, i32* %37, i32* %38, i32* %39, i32* %40, i32* %41, i32* %42, i32* %43, i32* %44, i32* %45, i1* %46, i1* %47)
  call void @copy_in(i1* null, i1* %2, i1* null, i1* %5, i8* null, i8* %6, i32* null, i32* %7, i32* null, i32* %8, i32* null, i32* %9, i1* null, i1* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %49, i250* %14, i250* %15, i250* %16, i250* %17, i1* null, i1* %19, i32* null, i32* %23, i1* null, i1* %28, i32* null, i32* %29, %struct.ControlMemSpace* %51, i1056* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i32* null, i32* %42, i32* null, i32* %43, i32* null, i32* %44, i32* null, i32* %45, i1* null, i1* %46, i1* null, i1* %47)
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
!7 = !{!"14", [4 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12, !13, !14}
!11 = !{!"14.0", %struct.HeadCtx* null}
!12 = !{!"14.1", %struct.HeadCtx* null}
!13 = !{!"14.2", %struct.HeadCtx* null}
!14 = !{!"14.3", %struct.HeadCtx* null}
