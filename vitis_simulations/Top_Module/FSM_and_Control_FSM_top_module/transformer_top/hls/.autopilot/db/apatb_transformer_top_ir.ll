; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Top_Module/FSM_and_Control_FSM_top_module/transformer_top/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i32, i32, i8, i1, i1, i8, i32, i32, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }
%struct.ControlMemSpace = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }

; Function Attrs: noinline willreturn
define void @apatb_transformer_top_ir(i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %dma_done, i1 zeroext %wl_ready, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i8* noalias nocapture nonnull dereferenceable(1) %wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %wl_head, i32* noalias nocapture nonnull dereferenceable(4) %wl_tile, i1 zeroext %compute_ready, i1 zeroext %compute_done, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i32* noalias nocapture nonnull dereferenceable(4) %compute_op, [4 x %struct.HeadCtx]* noalias nonnull dereferenceable(288) %head_ctx_ref, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* noalias nocapture nonnull dereferenceable(4) %ctrl_data_out, i1 zeroext %ctrl_read_en, i1 zeroext %ctrl_write_en, i1 zeroext %ctrl_chip_en, i1 zeroext %ctrl_resetn_in, i1* noalias nocapture nonnull dereferenceable(1) %irq_ps, i32* noalias nocapture nonnull dereferenceable(4) %dbg_state, %struct.ControlMemSpace* noalias nocapture nonnull readnone dereferenceable(132) %dbg_ctrl_mem, i32* noalias nocapture nonnull dereferenceable(4) %control_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_status_reg, i32* noalias nocapture nonnull dereferenceable(4) %irq_enable_reg, i32* noalias nocapture nonnull dereferenceable(4) %wq_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wk_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wv_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wo_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w1_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %w2_base_addr, i32* noalias nocapture nonnull dereferenceable(4) %wq_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wk_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wv_head_stride, i32* noalias nocapture nonnull dereferenceable(4) %wo_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w1_tile_stride, i32* noalias nocapture nonnull dereferenceable(4) %w2_tile_stride, i1* noalias nocapture nonnull dereferenceable(1) %dbg_done, i1* noalias nocapture nonnull dereferenceable(1) %dbg_error) local_unnamed_addr #0 {
entry:
  %axis_in_ready_copy = alloca i1, align 512
  %wl_start_copy = alloca i1, align 512
  %wl_addr_sel_copy = alloca i8, align 512
  %wl_layer_copy = alloca i32, align 512
  %wl_head_copy = alloca i32, align 512
  %wl_tile_copy = alloca i32, align 512
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i32, align 512
  %head_ctx_ref_copy_0 = alloca i283, align 512
  %head_ctx_ref_copy_1 = alloca i283, align 512
  %head_ctx_ref_copy_2 = alloca i283, align 512
  %head_ctx_ref_copy_3 = alloca i283, align 512
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
  call void @copy_in(i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i8* nonnull %wl_addr_sel, i8* nonnull align 512 %wl_addr_sel_copy, i32* nonnull %wl_layer, i32* nonnull align 512 %wl_layer_copy, i32* nonnull %wl_head, i32* nonnull align 512 %wl_head_copy, i32* nonnull %wl_tile, i32* nonnull align 512 %wl_tile_copy, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i32* nonnull %compute_op, i32* nonnull align 512 %compute_op_copy, [4 x %struct.HeadCtx]* nonnull %head_ctx_ref, i283* nonnull align 512 %head_ctx_ref_copy_0, i283* nonnull align 512 %head_ctx_ref_copy_1, i283* nonnull align 512 %head_ctx_ref_copy_2, i283* nonnull align 512 %head_ctx_ref_copy_3, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i32* nonnull %ctrl_data_out, i32* nonnull align 512 %ctrl_data_out_copy, i1* nonnull %irq_ps, i1* nonnull align 512 %irq_ps_copy, i32* nonnull %dbg_state, i32* nonnull align 512 %dbg_state_copy, %struct.ControlMemSpace* nonnull %dbg_ctrl_mem, i1056* nonnull align 512 %dbg_ctrl_mem_copy, i32* nonnull %control_reg, i32* nonnull align 512 %control_reg_copy, i32* nonnull %irq_status_reg, i32* nonnull align 512 %irq_status_reg_copy, i32* nonnull %irq_enable_reg, i32* nonnull align 512 %irq_enable_reg_copy, i32* nonnull %wq_base_addr, i32* nonnull align 512 %wq_base_addr_copy, i32* nonnull %wk_base_addr, i32* nonnull align 512 %wk_base_addr_copy, i32* nonnull %wv_base_addr, i32* nonnull align 512 %wv_base_addr_copy, i32* nonnull %wo_base_addr, i32* nonnull align 512 %wo_base_addr_copy, i32* nonnull %w1_base_addr, i32* nonnull align 512 %w1_base_addr_copy, i32* nonnull %w2_base_addr, i32* nonnull align 512 %w2_base_addr_copy, i32* nonnull %wq_head_stride, i32* nonnull align 512 %wq_head_stride_copy, i32* nonnull %wk_head_stride, i32* nonnull align 512 %wk_head_stride_copy, i32* nonnull %wv_head_stride, i32* nonnull align 512 %wv_head_stride_copy, i32* nonnull %wo_tile_stride, i32* nonnull align 512 %wo_tile_stride_copy, i32* nonnull %w1_tile_stride, i32* nonnull align 512 %w1_tile_stride_copy, i32* nonnull %w2_tile_stride, i32* nonnull align 512 %w2_tile_stride_copy, i1* nonnull %dbg_done, i1* nonnull align 512 %dbg_done_copy, i1* nonnull %dbg_error, i1* nonnull align 512 %dbg_error_copy)
  call void @apatb_transformer_top_hw(i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %dma_done, i1 %wl_ready, i1* %wl_start_copy, i8* %wl_addr_sel_copy, i32* %wl_layer_copy, i32* %wl_head_copy, i32* %wl_tile_copy, i1 %compute_ready, i1 %compute_done, i1* %compute_start_copy, i32* %compute_op_copy, i283* %head_ctx_ref_copy_0, i283* %head_ctx_ref_copy_1, i283* %head_ctx_ref_copy_2, i283* %head_ctx_ref_copy_3, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i32 %ctrl_addr, i32 %ctrl_data_in, i32* %ctrl_data_out_copy, i1 %ctrl_read_en, i1 %ctrl_write_en, i1 %ctrl_chip_en, i1 %ctrl_resetn_in, i1* %irq_ps_copy, i32* %dbg_state_copy, i1056* %dbg_ctrl_mem_copy, i32* %control_reg_copy, i32* %irq_status_reg_copy, i32* %irq_enable_reg_copy, i32* %wq_base_addr_copy, i32* %wk_base_addr_copy, i32* %wv_base_addr_copy, i32* %wo_base_addr_copy, i32* %w1_base_addr_copy, i32* %w2_base_addr_copy, i32* %wq_head_stride_copy, i32* %wk_head_stride_copy, i32* %wv_head_stride_copy, i32* %wo_tile_stride_copy, i32* %w1_tile_stride_copy, i32* %w2_tile_stride_copy, i1* %dbg_done_copy, i1* %dbg_error_copy)
  call void @copy_back(i1* %axis_in_ready, i1* %axis_in_ready_copy, i1* %wl_start, i1* %wl_start_copy, i8* %wl_addr_sel, i8* %wl_addr_sel_copy, i32* %wl_layer, i32* %wl_layer_copy, i32* %wl_head, i32* %wl_head_copy, i32* %wl_tile, i32* %wl_tile_copy, i1* %compute_start, i1* %compute_start_copy, i32* %compute_op, i32* %compute_op_copy, [4 x %struct.HeadCtx]* %head_ctx_ref, i283* %head_ctx_ref_copy_0, i283* %head_ctx_ref_copy_1, i283* %head_ctx_ref_copy_2, i283* %head_ctx_ref_copy_3, i1* %stream_start, i1* %stream_start_copy, i32* %ctrl_data_out, i32* %ctrl_data_out_copy, i1* %irq_ps, i1* %irq_ps_copy, i32* %dbg_state, i32* %dbg_state_copy, %struct.ControlMemSpace* %dbg_ctrl_mem, i1056* %dbg_ctrl_mem_copy, i32* %control_reg, i32* %control_reg_copy, i32* %irq_status_reg, i32* %irq_status_reg_copy, i32* %irq_enable_reg, i32* %irq_enable_reg_copy, i32* %wq_base_addr, i32* %wq_base_addr_copy, i32* %wk_base_addr, i32* %wk_base_addr_copy, i32* %wv_base_addr, i32* %wv_base_addr_copy, i32* %wo_base_addr, i32* %wo_base_addr_copy, i32* %w1_base_addr, i32* %w1_base_addr_copy, i32* %w2_base_addr, i32* %w2_base_addr_copy, i32* %wq_head_stride, i32* %wq_head_stride_copy, i32* %wk_head_stride, i32* %wk_head_stride_copy, i32* %wv_head_stride, i32* %wv_head_stride_copy, i32* %wo_tile_stride, i32* %wo_tile_stride_copy, i32* %w1_tile_stride, i32* %w1_tile_stride_copy, i32* %w2_tile_stride, i32* %w2_tile_stride_copy, i1* %dbg_done, i1* %dbg_done_copy, i1* %dbg_error, i1* %dbg_error_copy)
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
define void @arraycpy_hls.p0a4struct.HeadCtx.13.14(i283* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i283* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i283* "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i283* "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i283* %dst_0, null
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
  %4 = bitcast i283* %dst_0 to i288*
  %5 = load i288, i288* %4
  %6 = trunc i288 %5 to i283
  %7 = zext i32 %3 to i283
  %8 = and i283 %6, -4294967296
  %.partset179 = or i283 %8, %7
  store i283 %.partset179, i283* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i283* %dst_1 to i288*
  %10 = load i288, i288* %9
  %11 = trunc i288 %10 to i283
  %12 = zext i32 %3 to i283
  %13 = and i283 %11, -4294967296
  %.partset90 = or i283 %13, %12
  store i283 %.partset90, i283* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.2:                               ; preds = %for.loop
  %14 = bitcast i283* %dst_2 to i288*
  %15 = load i288, i288* %14
  %16 = trunc i288 %15 to i283
  %17 = zext i32 %3 to i283
  %18 = and i283 %16, -4294967296
  %.partset89 = or i283 %18, %17
  store i283 %.partset89, i283* %dst_2, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.3:                               ; preds = %for.loop
  %19 = bitcast i283* %dst_3 to i288*
  %20 = load i288, i288* %19
  %21 = trunc i288 %20 to i283
  %22 = zext i32 %3 to i283
  %23 = and i283 %21, -4294967296
  %.partset = or i283 %23, %22
  store i283 %.partset, i283* %dst_3, align 4
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
  %25 = bitcast i283* %dst_0 to i288*
  %26 = load i288, i288* %25
  %27 = trunc i288 %26 to i283
  %28 = zext i32 %24 to i283
  %29 = shl i283 %28, 32
  %30 = and i283 %27, -18446744069414584321
  %.partset178 = or i283 %30, %29
  store i283 %.partset178, i283* %dst_0, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %31 = bitcast i283* %dst_1 to i288*
  %32 = load i288, i288* %31
  %33 = trunc i288 %32 to i283
  %34 = zext i32 %24 to i283
  %35 = shl i283 %34, 32
  %36 = and i283 %33, -18446744069414584321
  %.partset91 = or i283 %36, %35
  store i283 %.partset91, i283* %dst_1, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.2:                              ; preds = %dst.addr.02.exit
  %37 = bitcast i283* %dst_2 to i288*
  %38 = load i288, i288* %37
  %39 = trunc i288 %38 to i283
  %40 = zext i32 %24 to i283
  %41 = shl i283 %40, 32
  %42 = and i283 %39, -18446744069414584321
  %.partset88 = or i283 %42, %41
  store i283 %.partset88, i283* %dst_2, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.3:                              ; preds = %dst.addr.02.exit
  %43 = bitcast i283* %dst_3 to i288*
  %44 = load i288, i288* %43
  %45 = trunc i288 %44 to i283
  %46 = zext i32 %24 to i283
  %47 = shl i283 %46, 32
  %48 = and i283 %45, -18446744069414584321
  %.partset1 = or i283 %48, %47
  store i283 %.partset1, i283* %dst_3, align 4
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
  %50 = bitcast i283* %dst_0 to i288*
  %51 = load i288, i288* %50
  %52 = trunc i288 %51 to i283
  %53 = zext i8 %49 to i283
  %54 = shl i283 %53, 64
  %55 = and i283 %52, -4703919738795935662081
  %.partset177 = or i283 %55, %54
  store i283 %.partset177, i283* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %56 = bitcast i283* %dst_1 to i288*
  %57 = load i288, i288* %56
  %58 = trunc i288 %57 to i283
  %59 = zext i8 %49 to i283
  %60 = shl i283 %59, 64
  %61 = and i283 %58, -4703919738795935662081
  %.partset92 = or i283 %61, %60
  store i283 %.partset92, i283* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.2:                              ; preds = %dst.addr.111.exit
  %62 = bitcast i283* %dst_2 to i288*
  %63 = load i288, i288* %62
  %64 = trunc i288 %63 to i283
  %65 = zext i8 %49 to i283
  %66 = shl i283 %65, 64
  %67 = and i283 %64, -4703919738795935662081
  %.partset87 = or i283 %67, %66
  store i283 %.partset87, i283* %dst_2, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.3:                              ; preds = %dst.addr.111.exit
  %68 = bitcast i283* %dst_3 to i288*
  %69 = load i288, i288* %68
  %70 = trunc i288 %69 to i283
  %71 = zext i8 %49 to i283
  %72 = shl i283 %71, 64
  %73 = and i283 %70, -4703919738795935662081
  %.partset2 = or i283 %73, %72
  store i283 %.partset2, i283* %dst_3, align 1
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
  %77 = bitcast i283* %dst_0 to i288*
  %78 = load i288, i288* %77
  %79 = trunc i288 %78 to i283
  %80 = zext i1 %76 to i283
  %81 = shl i283 %80, 72
  %82 = and i283 %79, -4722366482869645213697
  %.partset176 = or i283 %82, %81
  store i283 %.partset176, i283* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %83 = bitcast i283* %dst_1 to i288*
  %84 = load i288, i288* %83
  %85 = trunc i288 %84 to i283
  %86 = zext i1 %76 to i283
  %87 = shl i283 %86, 72
  %88 = and i283 %85, -4722366482869645213697
  %.partset93 = or i283 %88, %87
  store i283 %.partset93, i283* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.2:                              ; preds = %dst.addr.213.exit
  %89 = bitcast i283* %dst_2 to i288*
  %90 = load i288, i288* %89
  %91 = trunc i288 %90 to i283
  %92 = zext i1 %76 to i283
  %93 = shl i283 %92, 72
  %94 = and i283 %91, -4722366482869645213697
  %.partset86 = or i283 %94, %93
  store i283 %.partset86, i283* %dst_2, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.3:                              ; preds = %dst.addr.213.exit
  %95 = bitcast i283* %dst_3 to i288*
  %96 = load i288, i288* %95
  %97 = trunc i288 %96 to i283
  %98 = zext i1 %76 to i283
  %99 = shl i283 %98, 72
  %100 = and i283 %97, -4722366482869645213697
  %.partset3 = or i283 %100, %99
  store i283 %.partset3, i283* %dst_3, align 1
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
  %104 = bitcast i283* %dst_0 to i288*
  %105 = load i288, i288* %104
  %106 = trunc i288 %105 to i283
  %107 = zext i1 %103 to i283
  %108 = shl i283 %107, 73
  %109 = and i283 %106, -9444732965739290427393
  %.partset175 = or i283 %109, %108
  store i283 %.partset175, i283* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %110 = bitcast i283* %dst_1 to i288*
  %111 = load i288, i288* %110
  %112 = trunc i288 %111 to i283
  %113 = zext i1 %103 to i283
  %114 = shl i283 %113, 73
  %115 = and i283 %112, -9444732965739290427393
  %.partset94 = or i283 %115, %114
  store i283 %.partset94, i283* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.2:                              ; preds = %dst.addr.315.exit
  %116 = bitcast i283* %dst_2 to i288*
  %117 = load i288, i288* %116
  %118 = trunc i288 %117 to i283
  %119 = zext i1 %103 to i283
  %120 = shl i283 %119, 73
  %121 = and i283 %118, -9444732965739290427393
  %.partset85 = or i283 %121, %120
  store i283 %.partset85, i283* %dst_2, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.3:                              ; preds = %dst.addr.315.exit
  %122 = bitcast i283* %dst_3 to i288*
  %123 = load i288, i288* %122
  %124 = trunc i288 %123 to i283
  %125 = zext i1 %103 to i283
  %126 = shl i283 %125, 73
  %127 = and i283 %124, -9444732965739290427393
  %.partset4 = or i283 %127, %126
  store i283 %.partset4, i283* %dst_3, align 1
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
  %131 = bitcast i283* %dst_0 to i288*
  %132 = load i288, i288* %131
  %133 = trunc i288 %132 to i283
  %134 = zext i1 %130 to i283
  %135 = shl i283 %134, 74
  %136 = and i283 %133, -18889465931478580854785
  %.partset174 = or i283 %136, %135
  store i283 %.partset174, i283* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %137 = bitcast i283* %dst_1 to i288*
  %138 = load i288, i288* %137
  %139 = trunc i288 %138 to i283
  %140 = zext i1 %130 to i283
  %141 = shl i283 %140, 74
  %142 = and i283 %139, -18889465931478580854785
  %.partset95 = or i283 %142, %141
  store i283 %.partset95, i283* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.2:                              ; preds = %dst.addr.417.exit
  %143 = bitcast i283* %dst_2 to i288*
  %144 = load i288, i288* %143
  %145 = trunc i288 %144 to i283
  %146 = zext i1 %130 to i283
  %147 = shl i283 %146, 74
  %148 = and i283 %145, -18889465931478580854785
  %.partset84 = or i283 %148, %147
  store i283 %.partset84, i283* %dst_2, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.3:                              ; preds = %dst.addr.417.exit
  %149 = bitcast i283* %dst_3 to i288*
  %150 = load i288, i288* %149
  %151 = trunc i288 %150 to i283
  %152 = zext i1 %130 to i283
  %153 = shl i283 %152, 74
  %154 = and i283 %151, -18889465931478580854785
  %.partset5 = or i283 %154, %153
  store i283 %.partset5, i283* %dst_3, align 1
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
  %156 = bitcast i283* %dst_0 to i288*
  %157 = load i288, i288* %156
  %158 = trunc i288 %157 to i283
  %159 = zext i32 %155 to i283
  %160 = shl i283 %159, 75
  %161 = and i283 %158, -162259276791434431528620848578561
  %.partset173 = or i283 %161, %160
  store i283 %.partset173, i283* %dst_0, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %162 = bitcast i283* %dst_1 to i288*
  %163 = load i288, i288* %162
  %164 = trunc i288 %163 to i283
  %165 = zext i32 %155 to i283
  %166 = shl i283 %165, 75
  %167 = and i283 %164, -162259276791434431528620848578561
  %.partset96 = or i283 %167, %166
  store i283 %.partset96, i283* %dst_1, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.2:                              ; preds = %dst.addr.519.exit
  %168 = bitcast i283* %dst_2 to i288*
  %169 = load i288, i288* %168
  %170 = trunc i288 %169 to i283
  %171 = zext i32 %155 to i283
  %172 = shl i283 %171, 75
  %173 = and i283 %170, -162259276791434431528620848578561
  %.partset83 = or i283 %173, %172
  store i283 %.partset83, i283* %dst_2, align 4
  br label %dst.addr.621.exit

dst.addr.621.case.3:                              ; preds = %dst.addr.519.exit
  %174 = bitcast i283* %dst_3 to i288*
  %175 = load i288, i288* %174
  %176 = trunc i288 %175 to i283
  %177 = zext i32 %155 to i283
  %178 = shl i283 %177, 75
  %179 = and i283 %176, -162259276791434431528620848578561
  %.partset6 = or i283 %179, %178
  store i283 %.partset6, i283* %dst_3, align 4
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
  %181 = bitcast i283* %dst_0 to i288*
  %182 = load i288, i288* %181
  %183 = trunc i288 %182 to i283
  %184 = zext i32 %180 to i283
  %185 = shl i283 %184, 107
  %186 = and i283 %183, -696898287291822696343777832628683286773761
  %.partset172 = or i283 %186, %185
  store i283 %.partset172, i283* %dst_0, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %187 = bitcast i283* %dst_1 to i288*
  %188 = load i288, i288* %187
  %189 = trunc i288 %188 to i283
  %190 = zext i32 %180 to i283
  %191 = shl i283 %190, 107
  %192 = and i283 %189, -696898287291822696343777832628683286773761
  %.partset97 = or i283 %192, %191
  store i283 %.partset97, i283* %dst_1, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.2:                              ; preds = %dst.addr.621.exit
  %193 = bitcast i283* %dst_2 to i288*
  %194 = load i288, i288* %193
  %195 = trunc i288 %194 to i283
  %196 = zext i32 %180 to i283
  %197 = shl i283 %196, 107
  %198 = and i283 %195, -696898287291822696343777832628683286773761
  %.partset82 = or i283 %198, %197
  store i283 %.partset82, i283* %dst_2, align 4
  br label %dst.addr.723.exit

dst.addr.723.case.3:                              ; preds = %dst.addr.621.exit
  %199 = bitcast i283* %dst_3 to i288*
  %200 = load i288, i288* %199
  %201 = trunc i288 %200 to i283
  %202 = zext i32 %180 to i283
  %203 = shl i283 %202, 107
  %204 = and i283 %201, -696898287291822696343777832628683286773761
  %.partset7 = or i283 %204, %203
  store i283 %.partset7, i283* %dst_3, align 4
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
  %206 = bitcast i283* %dst_0 to i288*
  %207 = load i288, i288* %206
  %208 = trunc i288 %207 to i283
  %209 = zext i8 %205 to i283
  %210 = shl i283 %209, 139
  %211 = and i283 %208, -177709063300790903159112754985166630750781441
  %.partset171 = or i283 %211, %210
  store i283 %.partset171, i283* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %212 = bitcast i283* %dst_1 to i288*
  %213 = load i288, i288* %212
  %214 = trunc i288 %213 to i283
  %215 = zext i8 %205 to i283
  %216 = shl i283 %215, 139
  %217 = and i283 %214, -177709063300790903159112754985166630750781441
  %.partset98 = or i283 %217, %216
  store i283 %.partset98, i283* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.2:                              ; preds = %dst.addr.723.exit
  %218 = bitcast i283* %dst_2 to i288*
  %219 = load i288, i288* %218
  %220 = trunc i288 %219 to i283
  %221 = zext i8 %205 to i283
  %222 = shl i283 %221, 139
  %223 = and i283 %220, -177709063300790903159112754985166630750781441
  %.partset81 = or i283 %223, %222
  store i283 %.partset81, i283* %dst_2, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.3:                              ; preds = %dst.addr.723.exit
  %224 = bitcast i283* %dst_3 to i288*
  %225 = load i288, i288* %224
  %226 = trunc i288 %225 to i283
  %227 = zext i8 %205 to i283
  %228 = shl i283 %227, 139
  %229 = and i283 %226, -177709063300790903159112754985166630750781441
  %.partset8 = or i283 %229, %228
  store i283 %.partset8, i283* %dst_3, align 1
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
  %233 = bitcast i283* %dst_0 to i288*
  %234 = load i288, i288* %233
  %235 = trunc i288 %234 to i283
  %236 = zext i1 %232 to i283
  %237 = shl i283 %236, 147
  %238 = and i283 %235, -178405961588244985132285746181186892047843329
  %.partset170 = or i283 %238, %237
  store i283 %.partset170, i283* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %239 = bitcast i283* %dst_1 to i288*
  %240 = load i288, i288* %239
  %241 = trunc i288 %240 to i283
  %242 = zext i1 %232 to i283
  %243 = shl i283 %242, 147
  %244 = and i283 %241, -178405961588244985132285746181186892047843329
  %.partset99 = or i283 %244, %243
  store i283 %.partset99, i283* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.2:                              ; preds = %dst.addr.825.exit
  %245 = bitcast i283* %dst_2 to i288*
  %246 = load i288, i288* %245
  %247 = trunc i288 %246 to i283
  %248 = zext i1 %232 to i283
  %249 = shl i283 %248, 147
  %250 = and i283 %247, -178405961588244985132285746181186892047843329
  %.partset80 = or i283 %250, %249
  store i283 %.partset80, i283* %dst_2, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.3:                              ; preds = %dst.addr.825.exit
  %251 = bitcast i283* %dst_3 to i288*
  %252 = load i288, i288* %251
  %253 = trunc i288 %252 to i283
  %254 = zext i1 %232 to i283
  %255 = shl i283 %254, 147
  %256 = and i283 %253, -178405961588244985132285746181186892047843329
  %.partset9 = or i283 %256, %255
  store i283 %.partset9, i283* %dst_3, align 1
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
  %260 = bitcast i283* %dst_0 to i288*
  %261 = load i288, i288* %260
  %262 = trunc i288 %261 to i283
  %263 = zext i1 %259 to i283
  %264 = shl i283 %263, 148
  %265 = and i283 %262, -356811923176489970264571492362373784095686657
  %.partset169 = or i283 %265, %264
  store i283 %.partset169, i283* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %266 = bitcast i283* %dst_1 to i288*
  %267 = load i288, i288* %266
  %268 = trunc i288 %267 to i283
  %269 = zext i1 %259 to i283
  %270 = shl i283 %269, 148
  %271 = and i283 %268, -356811923176489970264571492362373784095686657
  %.partset100 = or i283 %271, %270
  store i283 %.partset100, i283* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.2:                             ; preds = %dst.addr.927.exit
  %272 = bitcast i283* %dst_2 to i288*
  %273 = load i288, i288* %272
  %274 = trunc i288 %273 to i283
  %275 = zext i1 %259 to i283
  %276 = shl i283 %275, 148
  %277 = and i283 %274, -356811923176489970264571492362373784095686657
  %.partset79 = or i283 %277, %276
  store i283 %.partset79, i283* %dst_2, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.3:                             ; preds = %dst.addr.927.exit
  %278 = bitcast i283* %dst_3 to i288*
  %279 = load i288, i288* %278
  %280 = trunc i288 %279 to i283
  %281 = zext i1 %259 to i283
  %282 = shl i283 %281, 148
  %283 = and i283 %280, -356811923176489970264571492362373784095686657
  %.partset10 = or i283 %283, %282
  store i283 %.partset10, i283* %dst_3, align 1
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
  %285 = bitcast i283* %dst_0 to i288*
  %286 = load i288, i288* %285
  %287 = trunc i288 %286 to i283
  %288 = zext i8 %284 to i283
  %289 = shl i283 %288, 149
  %290 = and i283 %287, -181974080820009884834931461104810629888800194561
  %.partset168 = or i283 %290, %289
  store i283 %.partset168, i283* %dst_0, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %291 = bitcast i283* %dst_1 to i288*
  %292 = load i288, i288* %291
  %293 = trunc i288 %292 to i283
  %294 = zext i8 %284 to i283
  %295 = shl i283 %294, 149
  %296 = and i283 %293, -181974080820009884834931461104810629888800194561
  %.partset101 = or i283 %296, %295
  store i283 %.partset101, i283* %dst_1, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.2:                             ; preds = %dst.addr.1029.exit
  %297 = bitcast i283* %dst_2 to i288*
  %298 = load i288, i288* %297
  %299 = trunc i288 %298 to i283
  %300 = zext i8 %284 to i283
  %301 = shl i283 %300, 149
  %302 = and i283 %299, -181974080820009884834931461104810629888800194561
  %.partset78 = or i283 %302, %301
  store i283 %.partset78, i283* %dst_2, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.3:                             ; preds = %dst.addr.1029.exit
  %303 = bitcast i283* %dst_3 to i288*
  %304 = load i288, i288* %303
  %305 = trunc i288 %304 to i283
  %306 = zext i8 %284 to i283
  %307 = shl i283 %306, 149
  %308 = and i283 %305, -181974080820009884834931461104810629888800194561
  %.partset11 = or i283 %308, %307
  store i283 %.partset11, i283* %dst_3, align 1
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
  %310 = bitcast i283* %dst_0 to i288*
  %311 = load i288, i288* %310
  %312 = trunc i288 %311 to i283
  %313 = zext i32 %309 to i283
  %314 = shl i283 %313, 157
  %315 = and i283 %312, -784637716740647390813110813125497697923259053101012746241
  %.partset167 = or i283 %315, %314
  store i283 %.partset167, i283* %dst_0, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %316 = bitcast i283* %dst_1 to i288*
  %317 = load i288, i288* %316
  %318 = trunc i288 %317 to i283
  %319 = zext i32 %309 to i283
  %320 = shl i283 %319, 157
  %321 = and i283 %318, -784637716740647390813110813125497697923259053101012746241
  %.partset102 = or i283 %321, %320
  store i283 %.partset102, i283* %dst_1, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.2:                             ; preds = %dst.addr.1131.exit
  %322 = bitcast i283* %dst_2 to i288*
  %323 = load i288, i288* %322
  %324 = trunc i288 %323 to i283
  %325 = zext i32 %309 to i283
  %326 = shl i283 %325, 157
  %327 = and i283 %324, -784637716740647390813110813125497697923259053101012746241
  %.partset77 = or i283 %327, %326
  store i283 %.partset77, i283* %dst_2, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.3:                             ; preds = %dst.addr.1131.exit
  %328 = bitcast i283* %dst_3 to i288*
  %329 = load i288, i288* %328
  %330 = trunc i288 %329 to i283
  %331 = zext i32 %309 to i283
  %332 = shl i283 %331, 157
  %333 = and i283 %330, -784637716740647390813110813125497697923259053101012746241
  %.partset12 = or i283 %333, %332
  store i283 %.partset12, i283* %dst_3, align 4
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
  %335 = bitcast i283* %dst_0 to i288*
  %336 = load i288, i288* %335
  %337 = trunc i288 %336 to i283
  %338 = zext i32 %334 to i283
  %339 = shl i283 %338, 189
  %340 = and i283 %337, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset166 = or i283 %340, %339
  store i283 %.partset166, i283* %dst_0, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %341 = bitcast i283* %dst_1 to i288*
  %342 = load i288, i288* %341
  %343 = trunc i288 %342 to i283
  %344 = zext i32 %334 to i283
  %345 = shl i283 %344, 189
  %346 = and i283 %343, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset103 = or i283 %346, %345
  store i283 %.partset103, i283* %dst_1, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.2:                             ; preds = %dst.addr.1233.exit
  %347 = bitcast i283* %dst_2 to i288*
  %348 = load i288, i288* %347
  %349 = trunc i288 %348 to i283
  %350 = zext i32 %334 to i283
  %351 = shl i283 %350, 189
  %352 = and i283 %349, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset76 = or i283 %352, %351
  store i283 %.partset76, i283* %dst_2, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.3:                             ; preds = %dst.addr.1233.exit
  %353 = bitcast i283* %dst_3 to i288*
  %354 = load i288, i288* %353
  %355 = trunc i288 %354 to i283
  %356 = zext i32 %334 to i283
  %357 = shl i283 %356, 189
  %358 = and i283 %355, -3369993332609192257410041790397980156303684750804777129579946967041
  %.partset13 = or i283 %358, %357
  store i283 %.partset13, i283* %dst_3, align 4
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
  %362 = bitcast i283* %dst_0 to i288*
  %363 = load i288, i288* %362
  %364 = trunc i288 %363 to i283
  %365 = zext i1 %361 to i283
  %366 = shl i283 %365, 221
  %367 = and i283 %364, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset165 = or i283 %367, %366
  store i283 %.partset165, i283* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %368 = bitcast i283* %dst_1 to i288*
  %369 = load i288, i288* %368
  %370 = trunc i288 %369 to i283
  %371 = zext i1 %361 to i283
  %372 = shl i283 %371, 221
  %373 = and i283 %370, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset104 = or i283 %373, %372
  store i283 %.partset104, i283* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.2:                             ; preds = %dst.addr.1335.exit
  %374 = bitcast i283* %dst_2 to i288*
  %375 = load i288, i288* %374
  %376 = trunc i288 %375 to i283
  %377 = zext i1 %361 to i283
  %378 = shl i283 %377, 221
  %379 = and i283 %376, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset75 = or i283 %379, %378
  store i283 %.partset75, i283* %dst_2, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.3:                             ; preds = %dst.addr.1335.exit
  %380 = bitcast i283* %dst_3 to i288*
  %381 = load i288, i288* %380
  %382 = trunc i288 %381 to i283
  %383 = zext i1 %361 to i283
  %384 = shl i283 %383, 221
  %385 = and i283 %382, -3369993333393829974333376885877453834204643052817571560137951281153
  %.partset14 = or i283 %385, %384
  store i283 %.partset14, i283* %dst_3, align 1
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
  %387 = bitcast i283* %dst_0 to i288*
  %388 = load i288, i288* %387
  %389 = trunc i288 %388 to i283
  %390 = zext i32 %386 to i283
  %391 = shl i283 %390, 222
  %392 = and i283 %389, -28948022302589062189105086303505223191562588498000854904229252881702379847681
  %.partset164 = or i283 %392, %391
  store i283 %.partset164, i283* %dst_0, align 4
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %393 = bitcast i283* %dst_1 to i288*
  %394 = load i288, i288* %393
  %395 = trunc i288 %394 to i283
  %396 = zext i32 %386 to i283
  %397 = shl i283 %396, 222
  %398 = and i283 %395, -28948022302589062189105086303505223191562588498000854904229252881702379847681
  %.partset105 = or i283 %398, %397
  store i283 %.partset105, i283* %dst_1, align 4
  br label %dst.addr.1539.exit

dst.addr.1539.case.2:                             ; preds = %dst.addr.1437.exit
  %399 = bitcast i283* %dst_2 to i288*
  %400 = load i288, i288* %399
  %401 = trunc i288 %400 to i283
  %402 = zext i32 %386 to i283
  %403 = shl i283 %402, 222
  %404 = and i283 %401, -28948022302589062189105086303505223191562588498000854904229252881702379847681
  %.partset74 = or i283 %404, %403
  store i283 %.partset74, i283* %dst_2, align 4
  br label %dst.addr.1539.exit

dst.addr.1539.case.3:                             ; preds = %dst.addr.1437.exit
  %405 = bitcast i283* %dst_3 to i288*
  %406 = load i288, i288* %405
  %407 = trunc i288 %406 to i283
  %408 = zext i32 %386 to i283
  %409 = shl i283 %408, 222
  %410 = and i283 %407, -28948022302589062189105086303505223191562588498000854904229252881702379847681
  %.partset15 = or i283 %410, %409
  store i283 %.partset15, i283* %dst_3, align 4
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
  %414 = bitcast i283* %dst_0 to i288*
  %415 = load i288, i288* %414
  %416 = trunc i288 %415 to i283
  %417 = zext i1 %413 to i283
  %418 = shl i283 %417, 254
  %419 = and i283 %416, -28948022309329048855892746252171976963317496166410141009864396001978282409985
  %.partset163 = or i283 %419, %418
  store i283 %.partset163, i283* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %420 = bitcast i283* %dst_1 to i288*
  %421 = load i288, i288* %420
  %422 = trunc i288 %421 to i283
  %423 = zext i1 %413 to i283
  %424 = shl i283 %423, 254
  %425 = and i283 %422, -28948022309329048855892746252171976963317496166410141009864396001978282409985
  %.partset106 = or i283 %425, %424
  store i283 %.partset106, i283* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.2:                             ; preds = %dst.addr.1539.exit
  %426 = bitcast i283* %dst_2 to i288*
  %427 = load i288, i288* %426
  %428 = trunc i288 %427 to i283
  %429 = zext i1 %413 to i283
  %430 = shl i283 %429, 254
  %431 = and i283 %428, -28948022309329048855892746252171976963317496166410141009864396001978282409985
  %.partset73 = or i283 %431, %430
  store i283 %.partset73, i283* %dst_2, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.3:                             ; preds = %dst.addr.1539.exit
  %432 = bitcast i283* %dst_3 to i288*
  %433 = load i288, i288* %432
  %434 = trunc i288 %433 to i283
  %435 = zext i1 %413 to i283
  %436 = shl i283 %435, 254
  %437 = and i283 %434, -28948022309329048855892746252171976963317496166410141009864396001978282409985
  %.partset16 = or i283 %437, %436
  store i283 %.partset16, i283* %dst_3, align 1
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
  %441 = bitcast i283* %dst_0 to i288*
  %442 = load i288, i288* %441
  %443 = trunc i288 %442 to i283
  %444 = zext i1 %440 to i283
  %445 = shl i283 %444, 255
  %446 = and i283 %443, -57896044618658097711785492504343953926634992332820282019728792003956564819969
  %.partset162 = or i283 %446, %445
  store i283 %.partset162, i283* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %447 = bitcast i283* %dst_1 to i288*
  %448 = load i288, i288* %447
  %449 = trunc i288 %448 to i283
  %450 = zext i1 %440 to i283
  %451 = shl i283 %450, 255
  %452 = and i283 %449, -57896044618658097711785492504343953926634992332820282019728792003956564819969
  %.partset107 = or i283 %452, %451
  store i283 %.partset107, i283* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.2:                             ; preds = %dst.addr.1641.exit
  %453 = bitcast i283* %dst_2 to i288*
  %454 = load i288, i288* %453
  %455 = trunc i288 %454 to i283
  %456 = zext i1 %440 to i283
  %457 = shl i283 %456, 255
  %458 = and i283 %455, -57896044618658097711785492504343953926634992332820282019728792003956564819969
  %.partset72 = or i283 %458, %457
  store i283 %.partset72, i283* %dst_2, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.3:                             ; preds = %dst.addr.1641.exit
  %459 = bitcast i283* %dst_3 to i288*
  %460 = load i288, i288* %459
  %461 = trunc i288 %460 to i283
  %462 = zext i1 %440 to i283
  %463 = shl i283 %462, 255
  %464 = and i283 %461, -57896044618658097711785492504343953926634992332820282019728792003956564819969
  %.partset17 = or i283 %464, %463
  store i283 %.partset17, i283* %dst_3, align 1
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
  %468 = bitcast i283* %dst_0 to i288*
  %469 = load i288, i288* %468
  %470 = trunc i288 %469 to i283
  %471 = zext i1 %467 to i283
  %472 = shl i283 %471, 256
  %473 = and i283 %470, -115792089237316195423570985008687907853269984665640564039457584007913129639937
  %.partset161 = or i283 %473, %472
  store i283 %.partset161, i283* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %474 = bitcast i283* %dst_1 to i288*
  %475 = load i288, i288* %474
  %476 = trunc i288 %475 to i283
  %477 = zext i1 %467 to i283
  %478 = shl i283 %477, 256
  %479 = and i283 %476, -115792089237316195423570985008687907853269984665640564039457584007913129639937
  %.partset108 = or i283 %479, %478
  store i283 %.partset108, i283* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.2:                             ; preds = %dst.addr.1743.exit
  %480 = bitcast i283* %dst_2 to i288*
  %481 = load i288, i288* %480
  %482 = trunc i288 %481 to i283
  %483 = zext i1 %467 to i283
  %484 = shl i283 %483, 256
  %485 = and i283 %482, -115792089237316195423570985008687907853269984665640564039457584007913129639937
  %.partset71 = or i283 %485, %484
  store i283 %.partset71, i283* %dst_2, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.3:                             ; preds = %dst.addr.1743.exit
  %486 = bitcast i283* %dst_3 to i288*
  %487 = load i288, i288* %486
  %488 = trunc i288 %487 to i283
  %489 = zext i1 %467 to i283
  %490 = shl i283 %489, 256
  %491 = and i283 %488, -115792089237316195423570985008687907853269984665640564039457584007913129639937
  %.partset18 = or i283 %491, %490
  store i283 %.partset18, i283* %dst_3, align 1
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
  %495 = bitcast i283* %dst_0 to i288*
  %496 = load i288, i288* %495
  %497 = trunc i288 %496 to i283
  %498 = zext i1 %494 to i283
  %499 = shl i283 %498, 257
  %500 = and i283 %497, -231584178474632390847141970017375815706539969331281128078915168015826259279873
  %.partset160 = or i283 %500, %499
  store i283 %.partset160, i283* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %501 = bitcast i283* %dst_1 to i288*
  %502 = load i288, i288* %501
  %503 = trunc i288 %502 to i283
  %504 = zext i1 %494 to i283
  %505 = shl i283 %504, 257
  %506 = and i283 %503, -231584178474632390847141970017375815706539969331281128078915168015826259279873
  %.partset109 = or i283 %506, %505
  store i283 %.partset109, i283* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.2:                             ; preds = %dst.addr.1845.exit
  %507 = bitcast i283* %dst_2 to i288*
  %508 = load i288, i288* %507
  %509 = trunc i288 %508 to i283
  %510 = zext i1 %494 to i283
  %511 = shl i283 %510, 257
  %512 = and i283 %509, -231584178474632390847141970017375815706539969331281128078915168015826259279873
  %.partset70 = or i283 %512, %511
  store i283 %.partset70, i283* %dst_2, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.3:                             ; preds = %dst.addr.1845.exit
  %513 = bitcast i283* %dst_3 to i288*
  %514 = load i288, i288* %513
  %515 = trunc i288 %514 to i283
  %516 = zext i1 %494 to i283
  %517 = shl i283 %516, 257
  %518 = and i283 %515, -231584178474632390847141970017375815706539969331281128078915168015826259279873
  %.partset19 = or i283 %518, %517
  store i283 %.partset19, i283* %dst_3, align 1
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
  %522 = bitcast i283* %dst_0 to i288*
  %523 = load i288, i288* %522
  %524 = trunc i288 %523 to i283
  %525 = zext i1 %521 to i283
  %526 = shl i283 %525, 258
  %527 = and i283 %524, -463168356949264781694283940034751631413079938662562256157830336031652518559745
  %.partset159 = or i283 %527, %526
  store i283 %.partset159, i283* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %528 = bitcast i283* %dst_1 to i288*
  %529 = load i288, i288* %528
  %530 = trunc i288 %529 to i283
  %531 = zext i1 %521 to i283
  %532 = shl i283 %531, 258
  %533 = and i283 %530, -463168356949264781694283940034751631413079938662562256157830336031652518559745
  %.partset110 = or i283 %533, %532
  store i283 %.partset110, i283* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.2:                             ; preds = %dst.addr.1947.exit
  %534 = bitcast i283* %dst_2 to i288*
  %535 = load i288, i288* %534
  %536 = trunc i288 %535 to i283
  %537 = zext i1 %521 to i283
  %538 = shl i283 %537, 258
  %539 = and i283 %536, -463168356949264781694283940034751631413079938662562256157830336031652518559745
  %.partset69 = or i283 %539, %538
  store i283 %.partset69, i283* %dst_2, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.3:                             ; preds = %dst.addr.1947.exit
  %540 = bitcast i283* %dst_3 to i288*
  %541 = load i288, i288* %540
  %542 = trunc i288 %541 to i283
  %543 = zext i1 %521 to i283
  %544 = shl i283 %543, 258
  %545 = and i283 %542, -463168356949264781694283940034751631413079938662562256157830336031652518559745
  %.partset20 = or i283 %545, %544
  store i283 %.partset20, i283* %dst_3, align 1
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
  %549 = bitcast i283* %dst_0 to i288*
  %550 = load i288, i288* %549
  %551 = trunc i288 %550 to i283
  %552 = zext i1 %548 to i283
  %553 = shl i283 %552, 259
  %554 = and i283 %551, -926336713898529563388567880069503262826159877325124512315660672063305037119489
  %.partset158 = or i283 %554, %553
  store i283 %.partset158, i283* %dst_0, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.1:                             ; preds = %dst.addr.2049.exit
  %555 = bitcast i283* %dst_1 to i288*
  %556 = load i288, i288* %555
  %557 = trunc i288 %556 to i283
  %558 = zext i1 %548 to i283
  %559 = shl i283 %558, 259
  %560 = and i283 %557, -926336713898529563388567880069503262826159877325124512315660672063305037119489
  %.partset111 = or i283 %560, %559
  store i283 %.partset111, i283* %dst_1, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.2:                             ; preds = %dst.addr.2049.exit
  %561 = bitcast i283* %dst_2 to i288*
  %562 = load i288, i288* %561
  %563 = trunc i288 %562 to i283
  %564 = zext i1 %548 to i283
  %565 = shl i283 %564, 259
  %566 = and i283 %563, -926336713898529563388567880069503262826159877325124512315660672063305037119489
  %.partset68 = or i283 %566, %565
  store i283 %.partset68, i283* %dst_2, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.3:                             ; preds = %dst.addr.2049.exit
  %567 = bitcast i283* %dst_3 to i288*
  %568 = load i288, i288* %567
  %569 = trunc i288 %568 to i283
  %570 = zext i1 %548 to i283
  %571 = shl i283 %570, 259
  %572 = and i283 %569, -926336713898529563388567880069503262826159877325124512315660672063305037119489
  %.partset21 = or i283 %572, %571
  store i283 %.partset21, i283* %dst_3, align 1
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
  %576 = bitcast i283* %dst_0 to i288*
  %577 = load i288, i288* %576
  %578 = trunc i288 %577 to i283
  %579 = zext i1 %575 to i283
  %580 = shl i283 %579, 260
  %581 = and i283 %578, -1852673427797059126777135760139006525652319754650249024631321344126610074238977
  %.partset157 = or i283 %581, %580
  store i283 %.partset157, i283* %dst_0, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.1:                             ; preds = %dst.addr.2151.exit
  %582 = bitcast i283* %dst_1 to i288*
  %583 = load i288, i288* %582
  %584 = trunc i288 %583 to i283
  %585 = zext i1 %575 to i283
  %586 = shl i283 %585, 260
  %587 = and i283 %584, -1852673427797059126777135760139006525652319754650249024631321344126610074238977
  %.partset112 = or i283 %587, %586
  store i283 %.partset112, i283* %dst_1, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.2:                             ; preds = %dst.addr.2151.exit
  %588 = bitcast i283* %dst_2 to i288*
  %589 = load i288, i288* %588
  %590 = trunc i288 %589 to i283
  %591 = zext i1 %575 to i283
  %592 = shl i283 %591, 260
  %593 = and i283 %590, -1852673427797059126777135760139006525652319754650249024631321344126610074238977
  %.partset67 = or i283 %593, %592
  store i283 %.partset67, i283* %dst_2, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.3:                             ; preds = %dst.addr.2151.exit
  %594 = bitcast i283* %dst_3 to i288*
  %595 = load i288, i288* %594
  %596 = trunc i288 %595 to i283
  %597 = zext i1 %575 to i283
  %598 = shl i283 %597, 260
  %599 = and i283 %596, -1852673427797059126777135760139006525652319754650249024631321344126610074238977
  %.partset22 = or i283 %599, %598
  store i283 %.partset22, i283* %dst_3, align 1
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
  %603 = bitcast i283* %dst_0 to i288*
  %604 = load i288, i288* %603
  %605 = trunc i288 %604 to i283
  %606 = zext i1 %602 to i283
  %607 = shl i283 %606, 261
  %608 = and i283 %605, -3705346855594118253554271520278013051304639509300498049262642688253220148477953
  %.partset156 = or i283 %608, %607
  store i283 %.partset156, i283* %dst_0, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.1:                             ; preds = %dst.addr.2253.exit
  %609 = bitcast i283* %dst_1 to i288*
  %610 = load i288, i288* %609
  %611 = trunc i288 %610 to i283
  %612 = zext i1 %602 to i283
  %613 = shl i283 %612, 261
  %614 = and i283 %611, -3705346855594118253554271520278013051304639509300498049262642688253220148477953
  %.partset113 = or i283 %614, %613
  store i283 %.partset113, i283* %dst_1, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.2:                             ; preds = %dst.addr.2253.exit
  %615 = bitcast i283* %dst_2 to i288*
  %616 = load i288, i288* %615
  %617 = trunc i288 %616 to i283
  %618 = zext i1 %602 to i283
  %619 = shl i283 %618, 261
  %620 = and i283 %617, -3705346855594118253554271520278013051304639509300498049262642688253220148477953
  %.partset66 = or i283 %620, %619
  store i283 %.partset66, i283* %dst_2, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.3:                             ; preds = %dst.addr.2253.exit
  %621 = bitcast i283* %dst_3 to i288*
  %622 = load i288, i288* %621
  %623 = trunc i288 %622 to i283
  %624 = zext i1 %602 to i283
  %625 = shl i283 %624, 261
  %626 = and i283 %623, -3705346855594118253554271520278013051304639509300498049262642688253220148477953
  %.partset23 = or i283 %626, %625
  store i283 %.partset23, i283* %dst_3, align 1
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
  %630 = bitcast i283* %dst_0 to i288*
  %631 = load i288, i288* %630
  %632 = trunc i288 %631 to i283
  %633 = zext i1 %629 to i283
  %634 = shl i283 %633, 262
  %635 = and i283 %632, -7410693711188236507108543040556026102609279018600996098525285376506440296955905
  %.partset155 = or i283 %635, %634
  store i283 %.partset155, i283* %dst_0, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.1:                             ; preds = %dst.addr.2355.exit
  %636 = bitcast i283* %dst_1 to i288*
  %637 = load i288, i288* %636
  %638 = trunc i288 %637 to i283
  %639 = zext i1 %629 to i283
  %640 = shl i283 %639, 262
  %641 = and i283 %638, -7410693711188236507108543040556026102609279018600996098525285376506440296955905
  %.partset114 = or i283 %641, %640
  store i283 %.partset114, i283* %dst_1, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.2:                             ; preds = %dst.addr.2355.exit
  %642 = bitcast i283* %dst_2 to i288*
  %643 = load i288, i288* %642
  %644 = trunc i288 %643 to i283
  %645 = zext i1 %629 to i283
  %646 = shl i283 %645, 262
  %647 = and i283 %644, -7410693711188236507108543040556026102609279018600996098525285376506440296955905
  %.partset65 = or i283 %647, %646
  store i283 %.partset65, i283* %dst_2, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.3:                             ; preds = %dst.addr.2355.exit
  %648 = bitcast i283* %dst_3 to i288*
  %649 = load i288, i288* %648
  %650 = trunc i288 %649 to i283
  %651 = zext i1 %629 to i283
  %652 = shl i283 %651, 262
  %653 = and i283 %650, -7410693711188236507108543040556026102609279018600996098525285376506440296955905
  %.partset24 = or i283 %653, %652
  store i283 %.partset24, i283* %dst_3, align 1
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
  %657 = bitcast i283* %dst_0 to i288*
  %658 = load i288, i288* %657
  %659 = trunc i288 %658 to i283
  %660 = zext i1 %656 to i283
  %661 = shl i283 %660, 263
  %662 = and i283 %659, -14821387422376473014217086081112052205218558037201992197050570753012880593911809
  %.partset154 = or i283 %662, %661
  store i283 %.partset154, i283* %dst_0, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.1:                             ; preds = %dst.addr.2457.exit
  %663 = bitcast i283* %dst_1 to i288*
  %664 = load i288, i288* %663
  %665 = trunc i288 %664 to i283
  %666 = zext i1 %656 to i283
  %667 = shl i283 %666, 263
  %668 = and i283 %665, -14821387422376473014217086081112052205218558037201992197050570753012880593911809
  %.partset115 = or i283 %668, %667
  store i283 %.partset115, i283* %dst_1, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.2:                             ; preds = %dst.addr.2457.exit
  %669 = bitcast i283* %dst_2 to i288*
  %670 = load i288, i288* %669
  %671 = trunc i288 %670 to i283
  %672 = zext i1 %656 to i283
  %673 = shl i283 %672, 263
  %674 = and i283 %671, -14821387422376473014217086081112052205218558037201992197050570753012880593911809
  %.partset64 = or i283 %674, %673
  store i283 %.partset64, i283* %dst_2, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.3:                             ; preds = %dst.addr.2457.exit
  %675 = bitcast i283* %dst_3 to i288*
  %676 = load i288, i288* %675
  %677 = trunc i288 %676 to i283
  %678 = zext i1 %656 to i283
  %679 = shl i283 %678, 263
  %680 = and i283 %677, -14821387422376473014217086081112052205218558037201992197050570753012880593911809
  %.partset25 = or i283 %680, %679
  store i283 %.partset25, i283* %dst_3, align 1
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
  %684 = bitcast i283* %dst_0 to i288*
  %685 = load i288, i288* %684
  %686 = trunc i288 %685 to i283
  %687 = zext i1 %683 to i283
  %688 = shl i283 %687, 264
  %689 = and i283 %686, -29642774844752946028434172162224104410437116074403984394101141506025761187823617
  %.partset153 = or i283 %689, %688
  store i283 %.partset153, i283* %dst_0, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.1:                             ; preds = %dst.addr.2559.exit
  %690 = bitcast i283* %dst_1 to i288*
  %691 = load i288, i288* %690
  %692 = trunc i288 %691 to i283
  %693 = zext i1 %683 to i283
  %694 = shl i283 %693, 264
  %695 = and i283 %692, -29642774844752946028434172162224104410437116074403984394101141506025761187823617
  %.partset116 = or i283 %695, %694
  store i283 %.partset116, i283* %dst_1, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.2:                             ; preds = %dst.addr.2559.exit
  %696 = bitcast i283* %dst_2 to i288*
  %697 = load i288, i288* %696
  %698 = trunc i288 %697 to i283
  %699 = zext i1 %683 to i283
  %700 = shl i283 %699, 264
  %701 = and i283 %698, -29642774844752946028434172162224104410437116074403984394101141506025761187823617
  %.partset63 = or i283 %701, %700
  store i283 %.partset63, i283* %dst_2, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.3:                             ; preds = %dst.addr.2559.exit
  %702 = bitcast i283* %dst_3 to i288*
  %703 = load i288, i288* %702
  %704 = trunc i288 %703 to i283
  %705 = zext i1 %683 to i283
  %706 = shl i283 %705, 264
  %707 = and i283 %704, -29642774844752946028434172162224104410437116074403984394101141506025761187823617
  %.partset26 = or i283 %707, %706
  store i283 %.partset26, i283* %dst_3, align 1
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
  %711 = bitcast i283* %dst_0 to i288*
  %712 = load i288, i288* %711
  %713 = trunc i288 %712 to i283
  %714 = zext i1 %710 to i283
  %715 = shl i283 %714, 265
  %716 = and i283 %713, -59285549689505892056868344324448208820874232148807968788202283012051522375647233
  %.partset152 = or i283 %716, %715
  store i283 %.partset152, i283* %dst_0, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.1:                             ; preds = %dst.addr.2661.exit
  %717 = bitcast i283* %dst_1 to i288*
  %718 = load i288, i288* %717
  %719 = trunc i288 %718 to i283
  %720 = zext i1 %710 to i283
  %721 = shl i283 %720, 265
  %722 = and i283 %719, -59285549689505892056868344324448208820874232148807968788202283012051522375647233
  %.partset117 = or i283 %722, %721
  store i283 %.partset117, i283* %dst_1, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.2:                             ; preds = %dst.addr.2661.exit
  %723 = bitcast i283* %dst_2 to i288*
  %724 = load i288, i288* %723
  %725 = trunc i288 %724 to i283
  %726 = zext i1 %710 to i283
  %727 = shl i283 %726, 265
  %728 = and i283 %725, -59285549689505892056868344324448208820874232148807968788202283012051522375647233
  %.partset62 = or i283 %728, %727
  store i283 %.partset62, i283* %dst_2, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.3:                             ; preds = %dst.addr.2661.exit
  %729 = bitcast i283* %dst_3 to i288*
  %730 = load i288, i288* %729
  %731 = trunc i288 %730 to i283
  %732 = zext i1 %710 to i283
  %733 = shl i283 %732, 265
  %734 = and i283 %731, -59285549689505892056868344324448208820874232148807968788202283012051522375647233
  %.partset27 = or i283 %734, %733
  store i283 %.partset27, i283* %dst_3, align 1
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
  %738 = bitcast i283* %dst_0 to i288*
  %739 = load i288, i288* %738
  %740 = trunc i288 %739 to i283
  %741 = zext i1 %737 to i283
  %742 = shl i283 %741, 266
  %743 = and i283 %740, -118571099379011784113736688648896417641748464297615937576404566024103044751294465
  %.partset151 = or i283 %743, %742
  store i283 %.partset151, i283* %dst_0, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.1:                             ; preds = %dst.addr.2763.exit
  %744 = bitcast i283* %dst_1 to i288*
  %745 = load i288, i288* %744
  %746 = trunc i288 %745 to i283
  %747 = zext i1 %737 to i283
  %748 = shl i283 %747, 266
  %749 = and i283 %746, -118571099379011784113736688648896417641748464297615937576404566024103044751294465
  %.partset118 = or i283 %749, %748
  store i283 %.partset118, i283* %dst_1, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.2:                             ; preds = %dst.addr.2763.exit
  %750 = bitcast i283* %dst_2 to i288*
  %751 = load i288, i288* %750
  %752 = trunc i288 %751 to i283
  %753 = zext i1 %737 to i283
  %754 = shl i283 %753, 266
  %755 = and i283 %752, -118571099379011784113736688648896417641748464297615937576404566024103044751294465
  %.partset61 = or i283 %755, %754
  store i283 %.partset61, i283* %dst_2, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.3:                             ; preds = %dst.addr.2763.exit
  %756 = bitcast i283* %dst_3 to i288*
  %757 = load i288, i288* %756
  %758 = trunc i288 %757 to i283
  %759 = zext i1 %737 to i283
  %760 = shl i283 %759, 266
  %761 = and i283 %758, -118571099379011784113736688648896417641748464297615937576404566024103044751294465
  %.partset28 = or i283 %761, %760
  store i283 %.partset28, i283* %dst_3, align 1
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
  %765 = bitcast i283* %dst_0 to i288*
  %766 = load i288, i288* %765
  %767 = trunc i288 %766 to i283
  %768 = zext i1 %764 to i283
  %769 = shl i283 %768, 267
  %770 = and i283 %767, -237142198758023568227473377297792835283496928595231875152809132048206089502588929
  %.partset150 = or i283 %770, %769
  store i283 %.partset150, i283* %dst_0, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.1:                             ; preds = %dst.addr.2865.exit
  %771 = bitcast i283* %dst_1 to i288*
  %772 = load i288, i288* %771
  %773 = trunc i288 %772 to i283
  %774 = zext i1 %764 to i283
  %775 = shl i283 %774, 267
  %776 = and i283 %773, -237142198758023568227473377297792835283496928595231875152809132048206089502588929
  %.partset119 = or i283 %776, %775
  store i283 %.partset119, i283* %dst_1, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.2:                             ; preds = %dst.addr.2865.exit
  %777 = bitcast i283* %dst_2 to i288*
  %778 = load i288, i288* %777
  %779 = trunc i288 %778 to i283
  %780 = zext i1 %764 to i283
  %781 = shl i283 %780, 267
  %782 = and i283 %779, -237142198758023568227473377297792835283496928595231875152809132048206089502588929
  %.partset60 = or i283 %782, %781
  store i283 %.partset60, i283* %dst_2, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.3:                             ; preds = %dst.addr.2865.exit
  %783 = bitcast i283* %dst_3 to i288*
  %784 = load i288, i288* %783
  %785 = trunc i288 %784 to i283
  %786 = zext i1 %764 to i283
  %787 = shl i283 %786, 267
  %788 = and i283 %785, -237142198758023568227473377297792835283496928595231875152809132048206089502588929
  %.partset29 = or i283 %788, %787
  store i283 %.partset29, i283* %dst_3, align 1
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
  %792 = bitcast i283* %dst_0 to i288*
  %793 = load i288, i288* %792
  %794 = trunc i288 %793 to i283
  %795 = zext i1 %791 to i283
  %796 = shl i283 %795, 268
  %797 = and i283 %794, -474284397516047136454946754595585670566993857190463750305618264096412179005177857
  %.partset149 = or i283 %797, %796
  store i283 %.partset149, i283* %dst_0, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.1:                             ; preds = %dst.addr.2967.exit
  %798 = bitcast i283* %dst_1 to i288*
  %799 = load i288, i288* %798
  %800 = trunc i288 %799 to i283
  %801 = zext i1 %791 to i283
  %802 = shl i283 %801, 268
  %803 = and i283 %800, -474284397516047136454946754595585670566993857190463750305618264096412179005177857
  %.partset120 = or i283 %803, %802
  store i283 %.partset120, i283* %dst_1, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.2:                             ; preds = %dst.addr.2967.exit
  %804 = bitcast i283* %dst_2 to i288*
  %805 = load i288, i288* %804
  %806 = trunc i288 %805 to i283
  %807 = zext i1 %791 to i283
  %808 = shl i283 %807, 268
  %809 = and i283 %806, -474284397516047136454946754595585670566993857190463750305618264096412179005177857
  %.partset59 = or i283 %809, %808
  store i283 %.partset59, i283* %dst_2, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.3:                             ; preds = %dst.addr.2967.exit
  %810 = bitcast i283* %dst_3 to i288*
  %811 = load i288, i288* %810
  %812 = trunc i288 %811 to i283
  %813 = zext i1 %791 to i283
  %814 = shl i283 %813, 268
  %815 = and i283 %812, -474284397516047136454946754595585670566993857190463750305618264096412179005177857
  %.partset30 = or i283 %815, %814
  store i283 %.partset30, i283* %dst_3, align 1
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
  %819 = bitcast i283* %dst_0 to i288*
  %820 = load i288, i288* %819
  %821 = trunc i288 %820 to i283
  %822 = zext i1 %818 to i283
  %823 = shl i283 %822, 269
  %824 = and i283 %821, -948568795032094272909893509191171341133987714380927500611236528192824358010355713
  %.partset148 = or i283 %824, %823
  store i283 %.partset148, i283* %dst_0, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.1:                             ; preds = %dst.addr.3069.exit
  %825 = bitcast i283* %dst_1 to i288*
  %826 = load i288, i288* %825
  %827 = trunc i288 %826 to i283
  %828 = zext i1 %818 to i283
  %829 = shl i283 %828, 269
  %830 = and i283 %827, -948568795032094272909893509191171341133987714380927500611236528192824358010355713
  %.partset121 = or i283 %830, %829
  store i283 %.partset121, i283* %dst_1, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.2:                             ; preds = %dst.addr.3069.exit
  %831 = bitcast i283* %dst_2 to i288*
  %832 = load i288, i288* %831
  %833 = trunc i288 %832 to i283
  %834 = zext i1 %818 to i283
  %835 = shl i283 %834, 269
  %836 = and i283 %833, -948568795032094272909893509191171341133987714380927500611236528192824358010355713
  %.partset58 = or i283 %836, %835
  store i283 %.partset58, i283* %dst_2, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.3:                             ; preds = %dst.addr.3069.exit
  %837 = bitcast i283* %dst_3 to i288*
  %838 = load i288, i288* %837
  %839 = trunc i288 %838 to i283
  %840 = zext i1 %818 to i283
  %841 = shl i283 %840, 269
  %842 = and i283 %839, -948568795032094272909893509191171341133987714380927500611236528192824358010355713
  %.partset31 = or i283 %842, %841
  store i283 %.partset31, i283* %dst_3, align 1
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
  %846 = bitcast i283* %dst_0 to i288*
  %847 = load i288, i288* %846
  %848 = trunc i288 %847 to i283
  %849 = zext i1 %845 to i283
  %850 = shl i283 %849, 270
  %851 = and i283 %848, -1897137590064188545819787018382342682267975428761855001222473056385648716020711425
  %.partset147 = or i283 %851, %850
  store i283 %.partset147, i283* %dst_0, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.1:                             ; preds = %dst.addr.3171.exit
  %852 = bitcast i283* %dst_1 to i288*
  %853 = load i288, i288* %852
  %854 = trunc i288 %853 to i283
  %855 = zext i1 %845 to i283
  %856 = shl i283 %855, 270
  %857 = and i283 %854, -1897137590064188545819787018382342682267975428761855001222473056385648716020711425
  %.partset122 = or i283 %857, %856
  store i283 %.partset122, i283* %dst_1, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.2:                             ; preds = %dst.addr.3171.exit
  %858 = bitcast i283* %dst_2 to i288*
  %859 = load i288, i288* %858
  %860 = trunc i288 %859 to i283
  %861 = zext i1 %845 to i283
  %862 = shl i283 %861, 270
  %863 = and i283 %860, -1897137590064188545819787018382342682267975428761855001222473056385648716020711425
  %.partset57 = or i283 %863, %862
  store i283 %.partset57, i283* %dst_2, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.3:                             ; preds = %dst.addr.3171.exit
  %864 = bitcast i283* %dst_3 to i288*
  %865 = load i288, i288* %864
  %866 = trunc i288 %865 to i283
  %867 = zext i1 %845 to i283
  %868 = shl i283 %867, 270
  %869 = and i283 %866, -1897137590064188545819787018382342682267975428761855001222473056385648716020711425
  %.partset32 = or i283 %869, %868
  store i283 %.partset32, i283* %dst_3, align 1
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
  %873 = bitcast i283* %dst_0 to i288*
  %874 = load i288, i288* %873
  %875 = trunc i288 %874 to i283
  %876 = zext i1 %872 to i283
  %877 = shl i283 %876, 271
  %878 = and i283 %875, -3794275180128377091639574036764685364535950857523710002444946112771297432041422849
  %.partset146 = or i283 %878, %877
  store i283 %.partset146, i283* %dst_0, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.1:                             ; preds = %dst.addr.3273.exit
  %879 = bitcast i283* %dst_1 to i288*
  %880 = load i288, i288* %879
  %881 = trunc i288 %880 to i283
  %882 = zext i1 %872 to i283
  %883 = shl i283 %882, 271
  %884 = and i283 %881, -3794275180128377091639574036764685364535950857523710002444946112771297432041422849
  %.partset123 = or i283 %884, %883
  store i283 %.partset123, i283* %dst_1, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.2:                             ; preds = %dst.addr.3273.exit
  %885 = bitcast i283* %dst_2 to i288*
  %886 = load i288, i288* %885
  %887 = trunc i288 %886 to i283
  %888 = zext i1 %872 to i283
  %889 = shl i283 %888, 271
  %890 = and i283 %887, -3794275180128377091639574036764685364535950857523710002444946112771297432041422849
  %.partset56 = or i283 %890, %889
  store i283 %.partset56, i283* %dst_2, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.3:                             ; preds = %dst.addr.3273.exit
  %891 = bitcast i283* %dst_3 to i288*
  %892 = load i288, i288* %891
  %893 = trunc i288 %892 to i283
  %894 = zext i1 %872 to i283
  %895 = shl i283 %894, 271
  %896 = and i283 %893, -3794275180128377091639574036764685364535950857523710002444946112771297432041422849
  %.partset33 = or i283 %896, %895
  store i283 %.partset33, i283* %dst_3, align 1
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
  %900 = bitcast i283* %dst_0 to i288*
  %901 = load i288, i288* %900
  %902 = trunc i288 %901 to i283
  %903 = zext i1 %899 to i283
  %904 = shl i283 %903, 272
  %905 = and i283 %902, -7588550360256754183279148073529370729071901715047420004889892225542594864082845697
  %.partset145 = or i283 %905, %904
  store i283 %.partset145, i283* %dst_0, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.1:                             ; preds = %dst.addr.3375.exit
  %906 = bitcast i283* %dst_1 to i288*
  %907 = load i288, i288* %906
  %908 = trunc i288 %907 to i283
  %909 = zext i1 %899 to i283
  %910 = shl i283 %909, 272
  %911 = and i283 %908, -7588550360256754183279148073529370729071901715047420004889892225542594864082845697
  %.partset124 = or i283 %911, %910
  store i283 %.partset124, i283* %dst_1, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.2:                             ; preds = %dst.addr.3375.exit
  %912 = bitcast i283* %dst_2 to i288*
  %913 = load i288, i288* %912
  %914 = trunc i288 %913 to i283
  %915 = zext i1 %899 to i283
  %916 = shl i283 %915, 272
  %917 = and i283 %914, -7588550360256754183279148073529370729071901715047420004889892225542594864082845697
  %.partset55 = or i283 %917, %916
  store i283 %.partset55, i283* %dst_2, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.3:                             ; preds = %dst.addr.3375.exit
  %918 = bitcast i283* %dst_3 to i288*
  %919 = load i288, i288* %918
  %920 = trunc i288 %919 to i283
  %921 = zext i1 %899 to i283
  %922 = shl i283 %921, 272
  %923 = and i283 %920, -7588550360256754183279148073529370729071901715047420004889892225542594864082845697
  %.partset34 = or i283 %923, %922
  store i283 %.partset34, i283* %dst_3, align 1
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
  %927 = bitcast i283* %dst_0 to i288*
  %928 = load i288, i288* %927
  %929 = trunc i288 %928 to i283
  %930 = zext i1 %926 to i283
  %931 = shl i283 %930, 273
  %932 = and i283 %929, -15177100720513508366558296147058741458143803430094840009779784451085189728165691393
  %.partset144 = or i283 %932, %931
  store i283 %.partset144, i283* %dst_0, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.1:                             ; preds = %dst.addr.3477.exit
  %933 = bitcast i283* %dst_1 to i288*
  %934 = load i288, i288* %933
  %935 = trunc i288 %934 to i283
  %936 = zext i1 %926 to i283
  %937 = shl i283 %936, 273
  %938 = and i283 %935, -15177100720513508366558296147058741458143803430094840009779784451085189728165691393
  %.partset125 = or i283 %938, %937
  store i283 %.partset125, i283* %dst_1, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.2:                             ; preds = %dst.addr.3477.exit
  %939 = bitcast i283* %dst_2 to i288*
  %940 = load i288, i288* %939
  %941 = trunc i288 %940 to i283
  %942 = zext i1 %926 to i283
  %943 = shl i283 %942, 273
  %944 = and i283 %941, -15177100720513508366558296147058741458143803430094840009779784451085189728165691393
  %.partset54 = or i283 %944, %943
  store i283 %.partset54, i283* %dst_2, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.3:                             ; preds = %dst.addr.3477.exit
  %945 = bitcast i283* %dst_3 to i288*
  %946 = load i288, i288* %945
  %947 = trunc i288 %946 to i283
  %948 = zext i1 %926 to i283
  %949 = shl i283 %948, 273
  %950 = and i283 %947, -15177100720513508366558296147058741458143803430094840009779784451085189728165691393
  %.partset35 = or i283 %950, %949
  store i283 %.partset35, i283* %dst_3, align 1
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
  %954 = bitcast i283* %dst_0 to i288*
  %955 = load i288, i288* %954
  %956 = trunc i288 %955 to i283
  %957 = zext i1 %953 to i283
  %958 = shl i283 %957, 274
  %959 = and i283 %956, -30354201441027016733116592294117482916287606860189680019559568902170379456331382785
  %.partset143 = or i283 %959, %958
  store i283 %.partset143, i283* %dst_0, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.1:                             ; preds = %dst.addr.3579.exit
  %960 = bitcast i283* %dst_1 to i288*
  %961 = load i288, i288* %960
  %962 = trunc i288 %961 to i283
  %963 = zext i1 %953 to i283
  %964 = shl i283 %963, 274
  %965 = and i283 %962, -30354201441027016733116592294117482916287606860189680019559568902170379456331382785
  %.partset126 = or i283 %965, %964
  store i283 %.partset126, i283* %dst_1, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.2:                             ; preds = %dst.addr.3579.exit
  %966 = bitcast i283* %dst_2 to i288*
  %967 = load i288, i288* %966
  %968 = trunc i288 %967 to i283
  %969 = zext i1 %953 to i283
  %970 = shl i283 %969, 274
  %971 = and i283 %968, -30354201441027016733116592294117482916287606860189680019559568902170379456331382785
  %.partset53 = or i283 %971, %970
  store i283 %.partset53, i283* %dst_2, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.3:                             ; preds = %dst.addr.3579.exit
  %972 = bitcast i283* %dst_3 to i288*
  %973 = load i288, i288* %972
  %974 = trunc i288 %973 to i283
  %975 = zext i1 %953 to i283
  %976 = shl i283 %975, 274
  %977 = and i283 %974, -30354201441027016733116592294117482916287606860189680019559568902170379456331382785
  %.partset36 = or i283 %977, %976
  store i283 %.partset36, i283* %dst_3, align 1
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
  %981 = bitcast i283* %dst_0 to i288*
  %982 = load i288, i288* %981
  %983 = trunc i288 %982 to i283
  %984 = zext i1 %980 to i283
  %985 = shl i283 %984, 275
  %986 = and i283 %983, -60708402882054033466233184588234965832575213720379360039119137804340758912662765569
  %.partset142 = or i283 %986, %985
  store i283 %.partset142, i283* %dst_0, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.1:                             ; preds = %dst.addr.3681.exit
  %987 = bitcast i283* %dst_1 to i288*
  %988 = load i288, i288* %987
  %989 = trunc i288 %988 to i283
  %990 = zext i1 %980 to i283
  %991 = shl i283 %990, 275
  %992 = and i283 %989, -60708402882054033466233184588234965832575213720379360039119137804340758912662765569
  %.partset127 = or i283 %992, %991
  store i283 %.partset127, i283* %dst_1, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.2:                             ; preds = %dst.addr.3681.exit
  %993 = bitcast i283* %dst_2 to i288*
  %994 = load i288, i288* %993
  %995 = trunc i288 %994 to i283
  %996 = zext i1 %980 to i283
  %997 = shl i283 %996, 275
  %998 = and i283 %995, -60708402882054033466233184588234965832575213720379360039119137804340758912662765569
  %.partset52 = or i283 %998, %997
  store i283 %.partset52, i283* %dst_2, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.3:                             ; preds = %dst.addr.3681.exit
  %999 = bitcast i283* %dst_3 to i288*
  %1000 = load i288, i288* %999
  %1001 = trunc i288 %1000 to i283
  %1002 = zext i1 %980 to i283
  %1003 = shl i283 %1002, 275
  %1004 = and i283 %1001, -60708402882054033466233184588234965832575213720379360039119137804340758912662765569
  %.partset37 = or i283 %1004, %1003
  store i283 %.partset37, i283* %dst_3, align 1
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
  %1008 = bitcast i283* %dst_0 to i288*
  %1009 = load i288, i288* %1008
  %1010 = trunc i288 %1009 to i283
  %1011 = zext i1 %1007 to i283
  %1012 = shl i283 %1011, 276
  %1013 = and i283 %1010, -121416805764108066932466369176469931665150427440758720078238275608681517825325531137
  %.partset141 = or i283 %1013, %1012
  store i283 %.partset141, i283* %dst_0, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.1:                             ; preds = %dst.addr.3783.exit
  %1014 = bitcast i283* %dst_1 to i288*
  %1015 = load i288, i288* %1014
  %1016 = trunc i288 %1015 to i283
  %1017 = zext i1 %1007 to i283
  %1018 = shl i283 %1017, 276
  %1019 = and i283 %1016, -121416805764108066932466369176469931665150427440758720078238275608681517825325531137
  %.partset128 = or i283 %1019, %1018
  store i283 %.partset128, i283* %dst_1, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.2:                             ; preds = %dst.addr.3783.exit
  %1020 = bitcast i283* %dst_2 to i288*
  %1021 = load i288, i288* %1020
  %1022 = trunc i288 %1021 to i283
  %1023 = zext i1 %1007 to i283
  %1024 = shl i283 %1023, 276
  %1025 = and i283 %1022, -121416805764108066932466369176469931665150427440758720078238275608681517825325531137
  %.partset51 = or i283 %1025, %1024
  store i283 %.partset51, i283* %dst_2, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.3:                             ; preds = %dst.addr.3783.exit
  %1026 = bitcast i283* %dst_3 to i288*
  %1027 = load i288, i288* %1026
  %1028 = trunc i288 %1027 to i283
  %1029 = zext i1 %1007 to i283
  %1030 = shl i283 %1029, 276
  %1031 = and i283 %1028, -121416805764108066932466369176469931665150427440758720078238275608681517825325531137
  %.partset38 = or i283 %1031, %1030
  store i283 %.partset38, i283* %dst_3, align 1
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
  %1035 = bitcast i283* %dst_0 to i288*
  %1036 = load i288, i288* %1035
  %1037 = trunc i288 %1036 to i283
  %1038 = zext i1 %1034 to i283
  %1039 = shl i283 %1038, 277
  %1040 = and i283 %1037, -242833611528216133864932738352939863330300854881517440156476551217363035650651062273
  %.partset140 = or i283 %1040, %1039
  store i283 %.partset140, i283* %dst_0, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.1:                             ; preds = %dst.addr.3885.exit
  %1041 = bitcast i283* %dst_1 to i288*
  %1042 = load i288, i288* %1041
  %1043 = trunc i288 %1042 to i283
  %1044 = zext i1 %1034 to i283
  %1045 = shl i283 %1044, 277
  %1046 = and i283 %1043, -242833611528216133864932738352939863330300854881517440156476551217363035650651062273
  %.partset129 = or i283 %1046, %1045
  store i283 %.partset129, i283* %dst_1, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.2:                             ; preds = %dst.addr.3885.exit
  %1047 = bitcast i283* %dst_2 to i288*
  %1048 = load i288, i288* %1047
  %1049 = trunc i288 %1048 to i283
  %1050 = zext i1 %1034 to i283
  %1051 = shl i283 %1050, 277
  %1052 = and i283 %1049, -242833611528216133864932738352939863330300854881517440156476551217363035650651062273
  %.partset50 = or i283 %1052, %1051
  store i283 %.partset50, i283* %dst_2, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.3:                             ; preds = %dst.addr.3885.exit
  %1053 = bitcast i283* %dst_3 to i288*
  %1054 = load i288, i288* %1053
  %1055 = trunc i288 %1054 to i283
  %1056 = zext i1 %1034 to i283
  %1057 = shl i283 %1056, 277
  %1058 = and i283 %1055, -242833611528216133864932738352939863330300854881517440156476551217363035650651062273
  %.partset39 = or i283 %1058, %1057
  store i283 %.partset39, i283* %dst_3, align 1
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
  %1062 = bitcast i283* %dst_0 to i288*
  %1063 = load i288, i288* %1062
  %1064 = trunc i288 %1063 to i283
  %1065 = zext i1 %1061 to i283
  %1066 = shl i283 %1065, 278
  %1067 = and i283 %1064, -485667223056432267729865476705879726660601709763034880312953102434726071301302124545
  %.partset139 = or i283 %1067, %1066
  store i283 %.partset139, i283* %dst_0, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.1:                             ; preds = %dst.addr.3987.exit
  %1068 = bitcast i283* %dst_1 to i288*
  %1069 = load i288, i288* %1068
  %1070 = trunc i288 %1069 to i283
  %1071 = zext i1 %1061 to i283
  %1072 = shl i283 %1071, 278
  %1073 = and i283 %1070, -485667223056432267729865476705879726660601709763034880312953102434726071301302124545
  %.partset130 = or i283 %1073, %1072
  store i283 %.partset130, i283* %dst_1, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.2:                             ; preds = %dst.addr.3987.exit
  %1074 = bitcast i283* %dst_2 to i288*
  %1075 = load i288, i288* %1074
  %1076 = trunc i288 %1075 to i283
  %1077 = zext i1 %1061 to i283
  %1078 = shl i283 %1077, 278
  %1079 = and i283 %1076, -485667223056432267729865476705879726660601709763034880312953102434726071301302124545
  %.partset49 = or i283 %1079, %1078
  store i283 %.partset49, i283* %dst_2, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.3:                             ; preds = %dst.addr.3987.exit
  %1080 = bitcast i283* %dst_3 to i288*
  %1081 = load i288, i288* %1080
  %1082 = trunc i288 %1081 to i283
  %1083 = zext i1 %1061 to i283
  %1084 = shl i283 %1083, 278
  %1085 = and i283 %1082, -485667223056432267729865476705879726660601709763034880312953102434726071301302124545
  %.partset40 = or i283 %1085, %1084
  store i283 %.partset40, i283* %dst_3, align 1
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
  %1089 = bitcast i283* %dst_0 to i288*
  %1090 = load i288, i288* %1089
  %1091 = trunc i288 %1090 to i283
  %1092 = zext i1 %1088 to i283
  %1093 = shl i283 %1092, 279
  %1094 = and i283 %1091, -971334446112864535459730953411759453321203419526069760625906204869452142602604249089
  %.partset138 = or i283 %1094, %1093
  store i283 %.partset138, i283* %dst_0, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.1:                             ; preds = %dst.addr.4089.exit
  %1095 = bitcast i283* %dst_1 to i288*
  %1096 = load i288, i288* %1095
  %1097 = trunc i288 %1096 to i283
  %1098 = zext i1 %1088 to i283
  %1099 = shl i283 %1098, 279
  %1100 = and i283 %1097, -971334446112864535459730953411759453321203419526069760625906204869452142602604249089
  %.partset131 = or i283 %1100, %1099
  store i283 %.partset131, i283* %dst_1, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.2:                             ; preds = %dst.addr.4089.exit
  %1101 = bitcast i283* %dst_2 to i288*
  %1102 = load i288, i288* %1101
  %1103 = trunc i288 %1102 to i283
  %1104 = zext i1 %1088 to i283
  %1105 = shl i283 %1104, 279
  %1106 = and i283 %1103, -971334446112864535459730953411759453321203419526069760625906204869452142602604249089
  %.partset48 = or i283 %1106, %1105
  store i283 %.partset48, i283* %dst_2, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.3:                             ; preds = %dst.addr.4089.exit
  %1107 = bitcast i283* %dst_3 to i288*
  %1108 = load i288, i288* %1107
  %1109 = trunc i288 %1108 to i283
  %1110 = zext i1 %1088 to i283
  %1111 = shl i283 %1110, 279
  %1112 = and i283 %1109, -971334446112864535459730953411759453321203419526069760625906204869452142602604249089
  %.partset41 = or i283 %1112, %1111
  store i283 %.partset41, i283* %dst_3, align 1
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
  %1116 = bitcast i283* %dst_0 to i288*
  %1117 = load i288, i288* %1116
  %1118 = trunc i288 %1117 to i283
  %1119 = zext i1 %1115 to i283
  %1120 = shl i283 %1119, 280
  %1121 = and i283 %1118, -1942668892225729070919461906823518906642406839052139521251812409738904285205208498177
  %.partset137 = or i283 %1121, %1120
  store i283 %.partset137, i283* %dst_0, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.1:                             ; preds = %dst.addr.4191.exit
  %1122 = bitcast i283* %dst_1 to i288*
  %1123 = load i288, i288* %1122
  %1124 = trunc i288 %1123 to i283
  %1125 = zext i1 %1115 to i283
  %1126 = shl i283 %1125, 280
  %1127 = and i283 %1124, -1942668892225729070919461906823518906642406839052139521251812409738904285205208498177
  %.partset132 = or i283 %1127, %1126
  store i283 %.partset132, i283* %dst_1, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.2:                             ; preds = %dst.addr.4191.exit
  %1128 = bitcast i283* %dst_2 to i288*
  %1129 = load i288, i288* %1128
  %1130 = trunc i288 %1129 to i283
  %1131 = zext i1 %1115 to i283
  %1132 = shl i283 %1131, 280
  %1133 = and i283 %1130, -1942668892225729070919461906823518906642406839052139521251812409738904285205208498177
  %.partset47 = or i283 %1133, %1132
  store i283 %.partset47, i283* %dst_2, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.3:                             ; preds = %dst.addr.4191.exit
  %1134 = bitcast i283* %dst_3 to i288*
  %1135 = load i288, i288* %1134
  %1136 = trunc i288 %1135 to i283
  %1137 = zext i1 %1115 to i283
  %1138 = shl i283 %1137, 280
  %1139 = and i283 %1136, -1942668892225729070919461906823518906642406839052139521251812409738904285205208498177
  %.partset42 = or i283 %1139, %1138
  store i283 %.partset42, i283* %dst_3, align 1
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
  %1143 = bitcast i283* %dst_0 to i288*
  %1144 = load i288, i288* %1143
  %1145 = trunc i288 %1144 to i283
  %1146 = zext i1 %1142 to i283
  %1147 = shl i283 %1146, 281
  %1148 = and i283 %1145, -3885337784451458141838923813647037813284813678104279042503624819477808570410416996353
  %.partset136 = or i283 %1148, %1147
  store i283 %.partset136, i283* %dst_0, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.1:                             ; preds = %dst.addr.4293.exit
  %1149 = bitcast i283* %dst_1 to i288*
  %1150 = load i288, i288* %1149
  %1151 = trunc i288 %1150 to i283
  %1152 = zext i1 %1142 to i283
  %1153 = shl i283 %1152, 281
  %1154 = and i283 %1151, -3885337784451458141838923813647037813284813678104279042503624819477808570410416996353
  %.partset133 = or i283 %1154, %1153
  store i283 %.partset133, i283* %dst_1, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.2:                             ; preds = %dst.addr.4293.exit
  %1155 = bitcast i283* %dst_2 to i288*
  %1156 = load i288, i288* %1155
  %1157 = trunc i288 %1156 to i283
  %1158 = zext i1 %1142 to i283
  %1159 = shl i283 %1158, 281
  %1160 = and i283 %1157, -3885337784451458141838923813647037813284813678104279042503624819477808570410416996353
  %.partset46 = or i283 %1160, %1159
  store i283 %.partset46, i283* %dst_2, align 1
  br label %dst.addr.4395.exit

dst.addr.4395.case.3:                             ; preds = %dst.addr.4293.exit
  %1161 = bitcast i283* %dst_3 to i288*
  %1162 = load i288, i288* %1161
  %1163 = trunc i288 %1162 to i283
  %1164 = zext i1 %1142 to i283
  %1165 = shl i283 %1164, 281
  %1166 = and i283 %1163, -3885337784451458141838923813647037813284813678104279042503624819477808570410416996353
  %.partset43 = or i283 %1166, %1165
  store i283 %.partset43, i283* %dst_3, align 1
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
  %1170 = bitcast i283* %dst_0 to i288*
  %1171 = load i288, i288* %1170
  %1172 = trunc i288 %1171 to i283
  %1173 = zext i1 %1169 to i283
  %1174 = shl i283 %1173, 282
  %1175 = and i283 %1172, 7770675568902916283677847627294075626569627356208558085007249638955617140820833992703
  %.partset135 = or i283 %1175, %1174
  store i283 %.partset135, i283* %dst_0, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.1:                             ; preds = %dst.addr.4395.exit
  %1176 = bitcast i283* %dst_1 to i288*
  %1177 = load i288, i288* %1176
  %1178 = trunc i288 %1177 to i283
  %1179 = zext i1 %1169 to i283
  %1180 = shl i283 %1179, 282
  %1181 = and i283 %1178, 7770675568902916283677847627294075626569627356208558085007249638955617140820833992703
  %.partset134 = or i283 %1181, %1180
  store i283 %.partset134, i283* %dst_1, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.2:                             ; preds = %dst.addr.4395.exit
  %1182 = bitcast i283* %dst_2 to i288*
  %1183 = load i288, i288* %1182
  %1184 = trunc i288 %1183 to i283
  %1185 = zext i1 %1169 to i283
  %1186 = shl i283 %1185, 282
  %1187 = and i283 %1184, 7770675568902916283677847627294075626569627356208558085007249638955617140820833992703
  %.partset45 = or i283 %1187, %1186
  store i283 %.partset45, i283* %dst_2, align 1
  br label %dst.addr.4497.exit

dst.addr.4497.case.3:                             ; preds = %dst.addr.4395.exit
  %1188 = bitcast i283* %dst_3 to i288*
  %1189 = load i288, i288* %1188
  %1190 = trunc i288 %1189 to i283
  %1191 = zext i1 %1169 to i283
  %1192 = shl i283 %1191, 282
  %1193 = and i283 %1190, 7770675568902916283677847627294075626569627356208558085007249638955617140820833992703
  %.partset44 = or i283 %1193, %1192
  store i283 %.partset44, i283* %dst_3, align 1
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
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.12.15(i283* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i283* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i283* noalias align 512 "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i283* noalias align 512 "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #1 {
entry:
  %0 = icmp eq i283* %dst_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.13.14(i283* nonnull %dst_0, i283* %dst_1, i283* %dst_2, i283* %dst_3, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in(i1* noalias readonly "orig.arg.no"="0", i1* noalias align 512 "orig.arg.no"="1", i1* noalias readonly "orig.arg.no"="2", i1* noalias align 512 "orig.arg.no"="3", i8* noalias readonly "orig.arg.no"="4", i8* noalias align 512 "orig.arg.no"="5", i32* noalias readonly "orig.arg.no"="6", i32* noalias align 512 "orig.arg.no"="7", i32* noalias readonly "orig.arg.no"="8", i32* noalias align 512 "orig.arg.no"="9", i32* noalias readonly "orig.arg.no"="10", i32* noalias align 512 "orig.arg.no"="11", i1* noalias readonly "orig.arg.no"="12", i1* noalias align 512 "orig.arg.no"="13", i32* noalias readonly "orig.arg.no"="14", i32* noalias align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="16", i283* noalias align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i283* noalias align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i283* noalias align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i283* noalias align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias readonly "orig.arg.no"="18", i1* noalias align 512 "orig.arg.no"="19", i32* noalias readonly "orig.arg.no"="20", i32* noalias align 512 "orig.arg.no"="21", i1* noalias readonly "orig.arg.no"="22", i1* noalias align 512 "orig.arg.no"="23", i32* noalias readonly "orig.arg.no"="24", i32* noalias align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias readonly "orig.arg.no"="26", i1056* noalias align 512 "orig.arg.no"="27", i32* noalias readonly "orig.arg.no"="28", i32* noalias align 512 "orig.arg.no"="29", i32* noalias readonly "orig.arg.no"="30", i32* noalias align 512 "orig.arg.no"="31", i32* noalias readonly "orig.arg.no"="32", i32* noalias align 512 "orig.arg.no"="33", i32* noalias readonly "orig.arg.no"="34", i32* noalias align 512 "orig.arg.no"="35", i32* noalias readonly "orig.arg.no"="36", i32* noalias align 512 "orig.arg.no"="37", i32* noalias readonly "orig.arg.no"="38", i32* noalias align 512 "orig.arg.no"="39", i32* noalias readonly "orig.arg.no"="40", i32* noalias align 512 "orig.arg.no"="41", i32* noalias readonly "orig.arg.no"="42", i32* noalias align 512 "orig.arg.no"="43", i32* noalias readonly "orig.arg.no"="44", i32* noalias align 512 "orig.arg.no"="45", i32* noalias readonly "orig.arg.no"="46", i32* noalias align 512 "orig.arg.no"="47", i32* noalias readonly "orig.arg.no"="48", i32* noalias align 512 "orig.arg.no"="49", i32* noalias readonly "orig.arg.no"="50", i32* noalias align 512 "orig.arg.no"="51", i32* noalias readonly "orig.arg.no"="52", i32* noalias align 512 "orig.arg.no"="53", i32* noalias readonly "orig.arg.no"="54", i32* noalias align 512 "orig.arg.no"="55", i32* noalias readonly "orig.arg.no"="56", i32* noalias align 512 "orig.arg.no"="57", i1* noalias readonly "orig.arg.no"="58", i1* noalias align 512 "orig.arg.no"="59", i1* noalias readonly "orig.arg.no"="60", i1* noalias align 512 "orig.arg.no"="61") #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %3, i1* %2)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %5, i8* %4)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %7, i32* %6)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %9, i32* %8)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %11, i32* %10)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %13, i1* %12)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %15, i32* %14)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.12.15(i283* align 512 %_0, i283* align 512 %_1, i283* align 512 %_2, i283* align 512 %_3, [4 x %struct.HeadCtx]* %16)
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
define void @arraycpy_hls.p0a4struct.HeadCtx.23.24([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i283* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i283* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i283* readonly "orig.arg.no"="1" "unpacked"="1.2" %src_2, i283* readonly "orig.arg.no"="1" "unpacked"="1.3" %src_3, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i283* %src_0, null
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
  %3 = bitcast i283* %src_0 to i288*
  %4 = load i288, i288* %3
  %5 = trunc i288 %4 to i283
  %_0.partselect = trunc i283 %5 to i32
  br label %src.addr.01.exit

src.addr.01.case.1:                               ; preds = %for.loop
  %6 = bitcast i283* %src_1 to i288*
  %7 = load i288, i288* %6
  %8 = trunc i288 %7 to i283
  %_1.partselect = trunc i283 %8 to i32
  br label %src.addr.01.exit

src.addr.01.case.2:                               ; preds = %for.loop
  %9 = bitcast i283* %src_2 to i288*
  %10 = load i288, i288* %9
  %11 = trunc i288 %10 to i283
  %_2.partselect = trunc i283 %11 to i32
  br label %src.addr.01.exit

src.addr.01.case.3:                               ; preds = %for.loop
  %12 = bitcast i283* %src_3 to i288*
  %13 = load i288, i288* %12
  %14 = trunc i288 %13 to i283
  %_3.partselect = trunc i283 %14 to i32
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
  %16 = bitcast i283* %src_0 to i288*
  %17 = load i288, i288* %16
  %18 = trunc i288 %17 to i283
  %19 = lshr i283 %18, 32
  %_01.partselect = trunc i283 %19 to i32
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %20 = bitcast i283* %src_1 to i288*
  %21 = load i288, i288* %20
  %22 = trunc i288 %21 to i283
  %23 = lshr i283 %22, 32
  %_12.partselect = trunc i283 %23 to i32
  br label %src.addr.110.exit

src.addr.110.case.2:                              ; preds = %src.addr.01.exit
  %24 = bitcast i283* %src_2 to i288*
  %25 = load i288, i288* %24
  %26 = trunc i288 %25 to i283
  %27 = lshr i283 %26, 32
  %_23.partselect = trunc i283 %27 to i32
  br label %src.addr.110.exit

src.addr.110.case.3:                              ; preds = %src.addr.01.exit
  %28 = bitcast i283* %src_3 to i288*
  %29 = load i288, i288* %28
  %30 = trunc i288 %29 to i283
  %31 = lshr i283 %30, 32
  %_34.partselect = trunc i283 %31 to i32
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
  %33 = bitcast i283* %src_0 to i288*
  %34 = load i288, i288* %33
  %35 = trunc i288 %34 to i283
  %36 = lshr i283 %35, 64
  %_05.partselect = trunc i283 %36 to i8
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %37 = bitcast i283* %src_1 to i288*
  %38 = load i288, i288* %37
  %39 = trunc i288 %38 to i283
  %40 = lshr i283 %39, 64
  %_16.partselect = trunc i283 %40 to i8
  br label %src.addr.212.exit

src.addr.212.case.2:                              ; preds = %src.addr.110.exit
  %41 = bitcast i283* %src_2 to i288*
  %42 = load i288, i288* %41
  %43 = trunc i288 %42 to i283
  %44 = lshr i283 %43, 64
  %_27.partselect = trunc i283 %44 to i8
  br label %src.addr.212.exit

src.addr.212.case.3:                              ; preds = %src.addr.110.exit
  %45 = bitcast i283* %src_3 to i288*
  %46 = load i288, i288* %45
  %47 = trunc i288 %46 to i283
  %48 = lshr i283 %47, 64
  %_38.partselect = trunc i283 %48 to i8
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
  %50 = bitcast i283* %src_0 to i288*
  %51 = load i288, i288* %50
  %52 = trunc i288 %51 to i283
  %53 = lshr i283 %52, 72
  %_09.partselect = trunc i283 %53 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %54 = bitcast i283* %src_1 to i288*
  %55 = load i288, i288* %54
  %56 = trunc i288 %55 to i283
  %57 = lshr i283 %56, 72
  %_110.partselect = trunc i283 %57 to i1
  br label %src.addr.314.exit

src.addr.314.case.2:                              ; preds = %src.addr.212.exit
  %58 = bitcast i283* %src_2 to i288*
  %59 = load i288, i288* %58
  %60 = trunc i288 %59 to i283
  %61 = lshr i283 %60, 72
  %_211.partselect = trunc i283 %61 to i1
  br label %src.addr.314.exit

src.addr.314.case.3:                              ; preds = %src.addr.212.exit
  %62 = bitcast i283* %src_3 to i288*
  %63 = load i288, i288* %62
  %64 = trunc i288 %63 to i283
  %65 = lshr i283 %64, 72
  %_312.partselect = trunc i283 %65 to i1
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
  %67 = bitcast i283* %src_0 to i288*
  %68 = load i288, i288* %67
  %69 = trunc i288 %68 to i283
  %70 = lshr i283 %69, 73
  %_013.partselect = trunc i283 %70 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %71 = bitcast i283* %src_1 to i288*
  %72 = load i288, i288* %71
  %73 = trunc i288 %72 to i283
  %74 = lshr i283 %73, 73
  %_114.partselect = trunc i283 %74 to i1
  br label %src.addr.416.exit

src.addr.416.case.2:                              ; preds = %src.addr.314.exit
  %75 = bitcast i283* %src_2 to i288*
  %76 = load i288, i288* %75
  %77 = trunc i288 %76 to i283
  %78 = lshr i283 %77, 73
  %_215.partselect = trunc i283 %78 to i1
  br label %src.addr.416.exit

src.addr.416.case.3:                              ; preds = %src.addr.314.exit
  %79 = bitcast i283* %src_3 to i288*
  %80 = load i288, i288* %79
  %81 = trunc i288 %80 to i283
  %82 = lshr i283 %81, 73
  %_316.partselect = trunc i283 %82 to i1
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
  %84 = bitcast i283* %src_0 to i288*
  %85 = load i288, i288* %84
  %86 = trunc i288 %85 to i283
  %87 = lshr i283 %86, 74
  %_017.partselect = trunc i283 %87 to i1
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %88 = bitcast i283* %src_1 to i288*
  %89 = load i288, i288* %88
  %90 = trunc i288 %89 to i283
  %91 = lshr i283 %90, 74
  %_118.partselect = trunc i283 %91 to i1
  br label %src.addr.518.exit

src.addr.518.case.2:                              ; preds = %src.addr.416.exit
  %92 = bitcast i283* %src_2 to i288*
  %93 = load i288, i288* %92
  %94 = trunc i288 %93 to i283
  %95 = lshr i283 %94, 74
  %_219.partselect = trunc i283 %95 to i1
  br label %src.addr.518.exit

src.addr.518.case.3:                              ; preds = %src.addr.416.exit
  %96 = bitcast i283* %src_3 to i288*
  %97 = load i288, i288* %96
  %98 = trunc i288 %97 to i283
  %99 = lshr i283 %98, 74
  %_320.partselect = trunc i283 %99 to i1
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
  %101 = bitcast i283* %src_0 to i288*
  %102 = load i288, i288* %101
  %103 = trunc i288 %102 to i283
  %104 = lshr i283 %103, 75
  %_021.partselect = trunc i283 %104 to i32
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %105 = bitcast i283* %src_1 to i288*
  %106 = load i288, i288* %105
  %107 = trunc i288 %106 to i283
  %108 = lshr i283 %107, 75
  %_122.partselect = trunc i283 %108 to i32
  br label %src.addr.620.exit

src.addr.620.case.2:                              ; preds = %src.addr.518.exit
  %109 = bitcast i283* %src_2 to i288*
  %110 = load i288, i288* %109
  %111 = trunc i288 %110 to i283
  %112 = lshr i283 %111, 75
  %_223.partselect = trunc i283 %112 to i32
  br label %src.addr.620.exit

src.addr.620.case.3:                              ; preds = %src.addr.518.exit
  %113 = bitcast i283* %src_3 to i288*
  %114 = load i288, i288* %113
  %115 = trunc i288 %114 to i283
  %116 = lshr i283 %115, 75
  %_324.partselect = trunc i283 %116 to i32
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
  %118 = bitcast i283* %src_0 to i288*
  %119 = load i288, i288* %118
  %120 = trunc i288 %119 to i283
  %121 = lshr i283 %120, 107
  %_025.partselect = trunc i283 %121 to i32
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %122 = bitcast i283* %src_1 to i288*
  %123 = load i288, i288* %122
  %124 = trunc i288 %123 to i283
  %125 = lshr i283 %124, 107
  %_126.partselect = trunc i283 %125 to i32
  br label %src.addr.722.exit

src.addr.722.case.2:                              ; preds = %src.addr.620.exit
  %126 = bitcast i283* %src_2 to i288*
  %127 = load i288, i288* %126
  %128 = trunc i288 %127 to i283
  %129 = lshr i283 %128, 107
  %_227.partselect = trunc i283 %129 to i32
  br label %src.addr.722.exit

src.addr.722.case.3:                              ; preds = %src.addr.620.exit
  %130 = bitcast i283* %src_3 to i288*
  %131 = load i288, i288* %130
  %132 = trunc i288 %131 to i283
  %133 = lshr i283 %132, 107
  %_328.partselect = trunc i283 %133 to i32
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
  %135 = bitcast i283* %src_0 to i288*
  %136 = load i288, i288* %135
  %137 = trunc i288 %136 to i283
  %138 = lshr i283 %137, 139
  %_029.partselect = trunc i283 %138 to i8
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %139 = bitcast i283* %src_1 to i288*
  %140 = load i288, i288* %139
  %141 = trunc i288 %140 to i283
  %142 = lshr i283 %141, 139
  %_130.partselect = trunc i283 %142 to i8
  br label %src.addr.824.exit

src.addr.824.case.2:                              ; preds = %src.addr.722.exit
  %143 = bitcast i283* %src_2 to i288*
  %144 = load i288, i288* %143
  %145 = trunc i288 %144 to i283
  %146 = lshr i283 %145, 139
  %_231.partselect = trunc i283 %146 to i8
  br label %src.addr.824.exit

src.addr.824.case.3:                              ; preds = %src.addr.722.exit
  %147 = bitcast i283* %src_3 to i288*
  %148 = load i288, i288* %147
  %149 = trunc i288 %148 to i283
  %150 = lshr i283 %149, 139
  %_332.partselect = trunc i283 %150 to i8
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
  %152 = bitcast i283* %src_0 to i288*
  %153 = load i288, i288* %152
  %154 = trunc i288 %153 to i283
  %155 = lshr i283 %154, 147
  %_033.partselect = trunc i283 %155 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %156 = bitcast i283* %src_1 to i288*
  %157 = load i288, i288* %156
  %158 = trunc i288 %157 to i283
  %159 = lshr i283 %158, 147
  %_134.partselect = trunc i283 %159 to i1
  br label %src.addr.926.exit

src.addr.926.case.2:                              ; preds = %src.addr.824.exit
  %160 = bitcast i283* %src_2 to i288*
  %161 = load i288, i288* %160
  %162 = trunc i288 %161 to i283
  %163 = lshr i283 %162, 147
  %_235.partselect = trunc i283 %163 to i1
  br label %src.addr.926.exit

src.addr.926.case.3:                              ; preds = %src.addr.824.exit
  %164 = bitcast i283* %src_3 to i288*
  %165 = load i288, i288* %164
  %166 = trunc i288 %165 to i283
  %167 = lshr i283 %166, 147
  %_336.partselect = trunc i283 %167 to i1
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
  %169 = bitcast i283* %src_0 to i288*
  %170 = load i288, i288* %169
  %171 = trunc i288 %170 to i283
  %172 = lshr i283 %171, 148
  %_037.partselect = trunc i283 %172 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %173 = bitcast i283* %src_1 to i288*
  %174 = load i288, i288* %173
  %175 = trunc i288 %174 to i283
  %176 = lshr i283 %175, 148
  %_138.partselect = trunc i283 %176 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.2:                             ; preds = %src.addr.926.exit
  %177 = bitcast i283* %src_2 to i288*
  %178 = load i288, i288* %177
  %179 = trunc i288 %178 to i283
  %180 = lshr i283 %179, 148
  %_239.partselect = trunc i283 %180 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.3:                             ; preds = %src.addr.926.exit
  %181 = bitcast i283* %src_3 to i288*
  %182 = load i288, i288* %181
  %183 = trunc i288 %182 to i283
  %184 = lshr i283 %183, 148
  %_340.partselect = trunc i283 %184 to i1
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
  %186 = bitcast i283* %src_0 to i288*
  %187 = load i288, i288* %186
  %188 = trunc i288 %187 to i283
  %189 = lshr i283 %188, 149
  %_041.partselect = trunc i283 %189 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %190 = bitcast i283* %src_1 to i288*
  %191 = load i288, i288* %190
  %192 = trunc i288 %191 to i283
  %193 = lshr i283 %192, 149
  %_142.partselect = trunc i283 %193 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.2:                             ; preds = %src.addr.1028.exit
  %194 = bitcast i283* %src_2 to i288*
  %195 = load i288, i288* %194
  %196 = trunc i288 %195 to i283
  %197 = lshr i283 %196, 149
  %_243.partselect = trunc i283 %197 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.3:                             ; preds = %src.addr.1028.exit
  %198 = bitcast i283* %src_3 to i288*
  %199 = load i288, i288* %198
  %200 = trunc i288 %199 to i283
  %201 = lshr i283 %200, 149
  %_344.partselect = trunc i283 %201 to i8
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
  %203 = bitcast i283* %src_0 to i288*
  %204 = load i288, i288* %203
  %205 = trunc i288 %204 to i283
  %206 = lshr i283 %205, 157
  %_045.partselect = trunc i283 %206 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %207 = bitcast i283* %src_1 to i288*
  %208 = load i288, i288* %207
  %209 = trunc i288 %208 to i283
  %210 = lshr i283 %209, 157
  %_146.partselect = trunc i283 %210 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.2:                             ; preds = %src.addr.1130.exit
  %211 = bitcast i283* %src_2 to i288*
  %212 = load i288, i288* %211
  %213 = trunc i288 %212 to i283
  %214 = lshr i283 %213, 157
  %_247.partselect = trunc i283 %214 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.3:                             ; preds = %src.addr.1130.exit
  %215 = bitcast i283* %src_3 to i288*
  %216 = load i288, i288* %215
  %217 = trunc i288 %216 to i283
  %218 = lshr i283 %217, 157
  %_348.partselect = trunc i283 %218 to i32
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
  %220 = bitcast i283* %src_0 to i288*
  %221 = load i288, i288* %220
  %222 = trunc i288 %221 to i283
  %223 = lshr i283 %222, 189
  %_049.partselect = trunc i283 %223 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %224 = bitcast i283* %src_1 to i288*
  %225 = load i288, i288* %224
  %226 = trunc i288 %225 to i283
  %227 = lshr i283 %226, 189
  %_150.partselect = trunc i283 %227 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.2:                             ; preds = %src.addr.1232.exit
  %228 = bitcast i283* %src_2 to i288*
  %229 = load i288, i288* %228
  %230 = trunc i288 %229 to i283
  %231 = lshr i283 %230, 189
  %_251.partselect = trunc i283 %231 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.3:                             ; preds = %src.addr.1232.exit
  %232 = bitcast i283* %src_3 to i288*
  %233 = load i288, i288* %232
  %234 = trunc i288 %233 to i283
  %235 = lshr i283 %234, 189
  %_352.partselect = trunc i283 %235 to i32
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
  %237 = bitcast i283* %src_0 to i288*
  %238 = load i288, i288* %237
  %239 = trunc i288 %238 to i283
  %240 = lshr i283 %239, 221
  %_053.partselect = trunc i283 %240 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %241 = bitcast i283* %src_1 to i288*
  %242 = load i288, i288* %241
  %243 = trunc i288 %242 to i283
  %244 = lshr i283 %243, 221
  %_154.partselect = trunc i283 %244 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.2:                             ; preds = %src.addr.1334.exit
  %245 = bitcast i283* %src_2 to i288*
  %246 = load i288, i288* %245
  %247 = trunc i288 %246 to i283
  %248 = lshr i283 %247, 221
  %_255.partselect = trunc i283 %248 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.3:                             ; preds = %src.addr.1334.exit
  %249 = bitcast i283* %src_3 to i288*
  %250 = load i288, i288* %249
  %251 = trunc i288 %250 to i283
  %252 = lshr i283 %251, 221
  %_356.partselect = trunc i283 %252 to i1
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
  %254 = bitcast i283* %src_0 to i288*
  %255 = load i288, i288* %254
  %256 = trunc i288 %255 to i283
  %257 = lshr i283 %256, 222
  %_057.partselect = trunc i283 %257 to i32
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %258 = bitcast i283* %src_1 to i288*
  %259 = load i288, i288* %258
  %260 = trunc i288 %259 to i283
  %261 = lshr i283 %260, 222
  %_158.partselect = trunc i283 %261 to i32
  br label %src.addr.1538.exit

src.addr.1538.case.2:                             ; preds = %src.addr.1436.exit
  %262 = bitcast i283* %src_2 to i288*
  %263 = load i288, i288* %262
  %264 = trunc i288 %263 to i283
  %265 = lshr i283 %264, 222
  %_259.partselect = trunc i283 %265 to i32
  br label %src.addr.1538.exit

src.addr.1538.case.3:                             ; preds = %src.addr.1436.exit
  %266 = bitcast i283* %src_3 to i288*
  %267 = load i288, i288* %266
  %268 = trunc i288 %267 to i283
  %269 = lshr i283 %268, 222
  %_360.partselect = trunc i283 %269 to i32
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
  %271 = bitcast i283* %src_0 to i288*
  %272 = load i288, i288* %271
  %273 = trunc i288 %272 to i283
  %274 = lshr i283 %273, 254
  %_061.partselect = trunc i283 %274 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %275 = bitcast i283* %src_1 to i288*
  %276 = load i288, i288* %275
  %277 = trunc i288 %276 to i283
  %278 = lshr i283 %277, 254
  %_162.partselect = trunc i283 %278 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.2:                             ; preds = %src.addr.1538.exit
  %279 = bitcast i283* %src_2 to i288*
  %280 = load i288, i288* %279
  %281 = trunc i288 %280 to i283
  %282 = lshr i283 %281, 254
  %_263.partselect = trunc i283 %282 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.3:                             ; preds = %src.addr.1538.exit
  %283 = bitcast i283* %src_3 to i288*
  %284 = load i288, i288* %283
  %285 = trunc i288 %284 to i283
  %286 = lshr i283 %285, 254
  %_364.partselect = trunc i283 %286 to i1
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
  %288 = bitcast i283* %src_0 to i288*
  %289 = load i288, i288* %288
  %290 = trunc i288 %289 to i283
  %291 = lshr i283 %290, 255
  %_065.partselect = trunc i283 %291 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %292 = bitcast i283* %src_1 to i288*
  %293 = load i288, i288* %292
  %294 = trunc i288 %293 to i283
  %295 = lshr i283 %294, 255
  %_166.partselect = trunc i283 %295 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.2:                             ; preds = %src.addr.1640.exit
  %296 = bitcast i283* %src_2 to i288*
  %297 = load i288, i288* %296
  %298 = trunc i288 %297 to i283
  %299 = lshr i283 %298, 255
  %_267.partselect = trunc i283 %299 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.3:                             ; preds = %src.addr.1640.exit
  %300 = bitcast i283* %src_3 to i288*
  %301 = load i288, i288* %300
  %302 = trunc i288 %301 to i283
  %303 = lshr i283 %302, 255
  %_368.partselect = trunc i283 %303 to i1
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
  %305 = bitcast i283* %src_0 to i288*
  %306 = load i288, i288* %305
  %307 = trunc i288 %306 to i283
  %308 = lshr i283 %307, 256
  %_069.partselect = trunc i283 %308 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %309 = bitcast i283* %src_1 to i288*
  %310 = load i288, i288* %309
  %311 = trunc i288 %310 to i283
  %312 = lshr i283 %311, 256
  %_170.partselect = trunc i283 %312 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.2:                             ; preds = %src.addr.1742.exit
  %313 = bitcast i283* %src_2 to i288*
  %314 = load i288, i288* %313
  %315 = trunc i288 %314 to i283
  %316 = lshr i283 %315, 256
  %_271.partselect = trunc i283 %316 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.3:                             ; preds = %src.addr.1742.exit
  %317 = bitcast i283* %src_3 to i288*
  %318 = load i288, i288* %317
  %319 = trunc i288 %318 to i283
  %320 = lshr i283 %319, 256
  %_372.partselect = trunc i283 %320 to i1
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
  %322 = bitcast i283* %src_0 to i288*
  %323 = load i288, i288* %322
  %324 = trunc i288 %323 to i283
  %325 = lshr i283 %324, 257
  %_073.partselect = trunc i283 %325 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %326 = bitcast i283* %src_1 to i288*
  %327 = load i288, i288* %326
  %328 = trunc i288 %327 to i283
  %329 = lshr i283 %328, 257
  %_174.partselect = trunc i283 %329 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.2:                             ; preds = %src.addr.1844.exit
  %330 = bitcast i283* %src_2 to i288*
  %331 = load i288, i288* %330
  %332 = trunc i288 %331 to i283
  %333 = lshr i283 %332, 257
  %_275.partselect = trunc i283 %333 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.3:                             ; preds = %src.addr.1844.exit
  %334 = bitcast i283* %src_3 to i288*
  %335 = load i288, i288* %334
  %336 = trunc i288 %335 to i283
  %337 = lshr i283 %336, 257
  %_376.partselect = trunc i283 %337 to i1
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
  %339 = bitcast i283* %src_0 to i288*
  %340 = load i288, i288* %339
  %341 = trunc i288 %340 to i283
  %342 = lshr i283 %341, 258
  %_077.partselect = trunc i283 %342 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %343 = bitcast i283* %src_1 to i288*
  %344 = load i288, i288* %343
  %345 = trunc i288 %344 to i283
  %346 = lshr i283 %345, 258
  %_178.partselect = trunc i283 %346 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.2:                             ; preds = %src.addr.1946.exit
  %347 = bitcast i283* %src_2 to i288*
  %348 = load i288, i288* %347
  %349 = trunc i288 %348 to i283
  %350 = lshr i283 %349, 258
  %_279.partselect = trunc i283 %350 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.3:                             ; preds = %src.addr.1946.exit
  %351 = bitcast i283* %src_3 to i288*
  %352 = load i288, i288* %351
  %353 = trunc i288 %352 to i283
  %354 = lshr i283 %353, 258
  %_380.partselect = trunc i283 %354 to i1
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
  %356 = bitcast i283* %src_0 to i288*
  %357 = load i288, i288* %356
  %358 = trunc i288 %357 to i283
  %359 = lshr i283 %358, 259
  %_081.partselect = trunc i283 %359 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.1:                             ; preds = %src.addr.2048.exit
  %360 = bitcast i283* %src_1 to i288*
  %361 = load i288, i288* %360
  %362 = trunc i288 %361 to i283
  %363 = lshr i283 %362, 259
  %_182.partselect = trunc i283 %363 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.2:                             ; preds = %src.addr.2048.exit
  %364 = bitcast i283* %src_2 to i288*
  %365 = load i288, i288* %364
  %366 = trunc i288 %365 to i283
  %367 = lshr i283 %366, 259
  %_283.partselect = trunc i283 %367 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.3:                             ; preds = %src.addr.2048.exit
  %368 = bitcast i283* %src_3 to i288*
  %369 = load i288, i288* %368
  %370 = trunc i288 %369 to i283
  %371 = lshr i283 %370, 259
  %_384.partselect = trunc i283 %371 to i1
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
  %373 = bitcast i283* %src_0 to i288*
  %374 = load i288, i288* %373
  %375 = trunc i288 %374 to i283
  %376 = lshr i283 %375, 260
  %_085.partselect = trunc i283 %376 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.1:                             ; preds = %src.addr.2150.exit
  %377 = bitcast i283* %src_1 to i288*
  %378 = load i288, i288* %377
  %379 = trunc i288 %378 to i283
  %380 = lshr i283 %379, 260
  %_186.partselect = trunc i283 %380 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.2:                             ; preds = %src.addr.2150.exit
  %381 = bitcast i283* %src_2 to i288*
  %382 = load i288, i288* %381
  %383 = trunc i288 %382 to i283
  %384 = lshr i283 %383, 260
  %_287.partselect = trunc i283 %384 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.3:                             ; preds = %src.addr.2150.exit
  %385 = bitcast i283* %src_3 to i288*
  %386 = load i288, i288* %385
  %387 = trunc i288 %386 to i283
  %388 = lshr i283 %387, 260
  %_388.partselect = trunc i283 %388 to i1
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
  %390 = bitcast i283* %src_0 to i288*
  %391 = load i288, i288* %390
  %392 = trunc i288 %391 to i283
  %393 = lshr i283 %392, 261
  %_089.partselect = trunc i283 %393 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.1:                             ; preds = %src.addr.2252.exit
  %394 = bitcast i283* %src_1 to i288*
  %395 = load i288, i288* %394
  %396 = trunc i288 %395 to i283
  %397 = lshr i283 %396, 261
  %_190.partselect = trunc i283 %397 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.2:                             ; preds = %src.addr.2252.exit
  %398 = bitcast i283* %src_2 to i288*
  %399 = load i288, i288* %398
  %400 = trunc i288 %399 to i283
  %401 = lshr i283 %400, 261
  %_291.partselect = trunc i283 %401 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.3:                             ; preds = %src.addr.2252.exit
  %402 = bitcast i283* %src_3 to i288*
  %403 = load i288, i288* %402
  %404 = trunc i288 %403 to i283
  %405 = lshr i283 %404, 261
  %_392.partselect = trunc i283 %405 to i1
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
  %407 = bitcast i283* %src_0 to i288*
  %408 = load i288, i288* %407
  %409 = trunc i288 %408 to i283
  %410 = lshr i283 %409, 262
  %_093.partselect = trunc i283 %410 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.1:                             ; preds = %src.addr.2354.exit
  %411 = bitcast i283* %src_1 to i288*
  %412 = load i288, i288* %411
  %413 = trunc i288 %412 to i283
  %414 = lshr i283 %413, 262
  %_194.partselect = trunc i283 %414 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.2:                             ; preds = %src.addr.2354.exit
  %415 = bitcast i283* %src_2 to i288*
  %416 = load i288, i288* %415
  %417 = trunc i288 %416 to i283
  %418 = lshr i283 %417, 262
  %_295.partselect = trunc i283 %418 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.3:                             ; preds = %src.addr.2354.exit
  %419 = bitcast i283* %src_3 to i288*
  %420 = load i288, i288* %419
  %421 = trunc i288 %420 to i283
  %422 = lshr i283 %421, 262
  %_396.partselect = trunc i283 %422 to i1
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
  %424 = bitcast i283* %src_0 to i288*
  %425 = load i288, i288* %424
  %426 = trunc i288 %425 to i283
  %427 = lshr i283 %426, 263
  %_097.partselect = trunc i283 %427 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.1:                             ; preds = %src.addr.2456.exit
  %428 = bitcast i283* %src_1 to i288*
  %429 = load i288, i288* %428
  %430 = trunc i288 %429 to i283
  %431 = lshr i283 %430, 263
  %_198.partselect = trunc i283 %431 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.2:                             ; preds = %src.addr.2456.exit
  %432 = bitcast i283* %src_2 to i288*
  %433 = load i288, i288* %432
  %434 = trunc i288 %433 to i283
  %435 = lshr i283 %434, 263
  %_299.partselect = trunc i283 %435 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.3:                             ; preds = %src.addr.2456.exit
  %436 = bitcast i283* %src_3 to i288*
  %437 = load i288, i288* %436
  %438 = trunc i288 %437 to i283
  %439 = lshr i283 %438, 263
  %_3100.partselect = trunc i283 %439 to i1
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
  %441 = bitcast i283* %src_0 to i288*
  %442 = load i288, i288* %441
  %443 = trunc i288 %442 to i283
  %444 = lshr i283 %443, 264
  %_0101.partselect = trunc i283 %444 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.1:                             ; preds = %src.addr.2558.exit
  %445 = bitcast i283* %src_1 to i288*
  %446 = load i288, i288* %445
  %447 = trunc i288 %446 to i283
  %448 = lshr i283 %447, 264
  %_1102.partselect = trunc i283 %448 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.2:                             ; preds = %src.addr.2558.exit
  %449 = bitcast i283* %src_2 to i288*
  %450 = load i288, i288* %449
  %451 = trunc i288 %450 to i283
  %452 = lshr i283 %451, 264
  %_2103.partselect = trunc i283 %452 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.3:                             ; preds = %src.addr.2558.exit
  %453 = bitcast i283* %src_3 to i288*
  %454 = load i288, i288* %453
  %455 = trunc i288 %454 to i283
  %456 = lshr i283 %455, 264
  %_3104.partselect = trunc i283 %456 to i1
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
  %458 = bitcast i283* %src_0 to i288*
  %459 = load i288, i288* %458
  %460 = trunc i288 %459 to i283
  %461 = lshr i283 %460, 265
  %_0105.partselect = trunc i283 %461 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.1:                             ; preds = %src.addr.2660.exit
  %462 = bitcast i283* %src_1 to i288*
  %463 = load i288, i288* %462
  %464 = trunc i288 %463 to i283
  %465 = lshr i283 %464, 265
  %_1106.partselect = trunc i283 %465 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.2:                             ; preds = %src.addr.2660.exit
  %466 = bitcast i283* %src_2 to i288*
  %467 = load i288, i288* %466
  %468 = trunc i288 %467 to i283
  %469 = lshr i283 %468, 265
  %_2107.partselect = trunc i283 %469 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.3:                             ; preds = %src.addr.2660.exit
  %470 = bitcast i283* %src_3 to i288*
  %471 = load i288, i288* %470
  %472 = trunc i288 %471 to i283
  %473 = lshr i283 %472, 265
  %_3108.partselect = trunc i283 %473 to i1
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
  %475 = bitcast i283* %src_0 to i288*
  %476 = load i288, i288* %475
  %477 = trunc i288 %476 to i283
  %478 = lshr i283 %477, 266
  %_0109.partselect = trunc i283 %478 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.1:                             ; preds = %src.addr.2762.exit
  %479 = bitcast i283* %src_1 to i288*
  %480 = load i288, i288* %479
  %481 = trunc i288 %480 to i283
  %482 = lshr i283 %481, 266
  %_1110.partselect = trunc i283 %482 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.2:                             ; preds = %src.addr.2762.exit
  %483 = bitcast i283* %src_2 to i288*
  %484 = load i288, i288* %483
  %485 = trunc i288 %484 to i283
  %486 = lshr i283 %485, 266
  %_2111.partselect = trunc i283 %486 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.3:                             ; preds = %src.addr.2762.exit
  %487 = bitcast i283* %src_3 to i288*
  %488 = load i288, i288* %487
  %489 = trunc i288 %488 to i283
  %490 = lshr i283 %489, 266
  %_3112.partselect = trunc i283 %490 to i1
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
  %492 = bitcast i283* %src_0 to i288*
  %493 = load i288, i288* %492
  %494 = trunc i288 %493 to i283
  %495 = lshr i283 %494, 267
  %_0113.partselect = trunc i283 %495 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.1:                             ; preds = %src.addr.2864.exit
  %496 = bitcast i283* %src_1 to i288*
  %497 = load i288, i288* %496
  %498 = trunc i288 %497 to i283
  %499 = lshr i283 %498, 267
  %_1114.partselect = trunc i283 %499 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.2:                             ; preds = %src.addr.2864.exit
  %500 = bitcast i283* %src_2 to i288*
  %501 = load i288, i288* %500
  %502 = trunc i288 %501 to i283
  %503 = lshr i283 %502, 267
  %_2115.partselect = trunc i283 %503 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.3:                             ; preds = %src.addr.2864.exit
  %504 = bitcast i283* %src_3 to i288*
  %505 = load i288, i288* %504
  %506 = trunc i288 %505 to i283
  %507 = lshr i283 %506, 267
  %_3116.partselect = trunc i283 %507 to i1
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
  %509 = bitcast i283* %src_0 to i288*
  %510 = load i288, i288* %509
  %511 = trunc i288 %510 to i283
  %512 = lshr i283 %511, 268
  %_0117.partselect = trunc i283 %512 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.1:                             ; preds = %src.addr.2966.exit
  %513 = bitcast i283* %src_1 to i288*
  %514 = load i288, i288* %513
  %515 = trunc i288 %514 to i283
  %516 = lshr i283 %515, 268
  %_1118.partselect = trunc i283 %516 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.2:                             ; preds = %src.addr.2966.exit
  %517 = bitcast i283* %src_2 to i288*
  %518 = load i288, i288* %517
  %519 = trunc i288 %518 to i283
  %520 = lshr i283 %519, 268
  %_2119.partselect = trunc i283 %520 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.3:                             ; preds = %src.addr.2966.exit
  %521 = bitcast i283* %src_3 to i288*
  %522 = load i288, i288* %521
  %523 = trunc i288 %522 to i283
  %524 = lshr i283 %523, 268
  %_3120.partselect = trunc i283 %524 to i1
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
  %526 = bitcast i283* %src_0 to i288*
  %527 = load i288, i288* %526
  %528 = trunc i288 %527 to i283
  %529 = lshr i283 %528, 269
  %_0121.partselect = trunc i283 %529 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.1:                             ; preds = %src.addr.3068.exit
  %530 = bitcast i283* %src_1 to i288*
  %531 = load i288, i288* %530
  %532 = trunc i288 %531 to i283
  %533 = lshr i283 %532, 269
  %_1122.partselect = trunc i283 %533 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.2:                             ; preds = %src.addr.3068.exit
  %534 = bitcast i283* %src_2 to i288*
  %535 = load i288, i288* %534
  %536 = trunc i288 %535 to i283
  %537 = lshr i283 %536, 269
  %_2123.partselect = trunc i283 %537 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.3:                             ; preds = %src.addr.3068.exit
  %538 = bitcast i283* %src_3 to i288*
  %539 = load i288, i288* %538
  %540 = trunc i288 %539 to i283
  %541 = lshr i283 %540, 269
  %_3124.partselect = trunc i283 %541 to i1
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
  %543 = bitcast i283* %src_0 to i288*
  %544 = load i288, i288* %543
  %545 = trunc i288 %544 to i283
  %546 = lshr i283 %545, 270
  %_0125.partselect = trunc i283 %546 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.1:                             ; preds = %src.addr.3170.exit
  %547 = bitcast i283* %src_1 to i288*
  %548 = load i288, i288* %547
  %549 = trunc i288 %548 to i283
  %550 = lshr i283 %549, 270
  %_1126.partselect = trunc i283 %550 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.2:                             ; preds = %src.addr.3170.exit
  %551 = bitcast i283* %src_2 to i288*
  %552 = load i288, i288* %551
  %553 = trunc i288 %552 to i283
  %554 = lshr i283 %553, 270
  %_2127.partselect = trunc i283 %554 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.3:                             ; preds = %src.addr.3170.exit
  %555 = bitcast i283* %src_3 to i288*
  %556 = load i288, i288* %555
  %557 = trunc i288 %556 to i283
  %558 = lshr i283 %557, 270
  %_3128.partselect = trunc i283 %558 to i1
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
  %560 = bitcast i283* %src_0 to i288*
  %561 = load i288, i288* %560
  %562 = trunc i288 %561 to i283
  %563 = lshr i283 %562, 271
  %_0129.partselect = trunc i283 %563 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.1:                             ; preds = %src.addr.3272.exit
  %564 = bitcast i283* %src_1 to i288*
  %565 = load i288, i288* %564
  %566 = trunc i288 %565 to i283
  %567 = lshr i283 %566, 271
  %_1130.partselect = trunc i283 %567 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.2:                             ; preds = %src.addr.3272.exit
  %568 = bitcast i283* %src_2 to i288*
  %569 = load i288, i288* %568
  %570 = trunc i288 %569 to i283
  %571 = lshr i283 %570, 271
  %_2131.partselect = trunc i283 %571 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.3:                             ; preds = %src.addr.3272.exit
  %572 = bitcast i283* %src_3 to i288*
  %573 = load i288, i288* %572
  %574 = trunc i288 %573 to i283
  %575 = lshr i283 %574, 271
  %_3132.partselect = trunc i283 %575 to i1
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
  %577 = bitcast i283* %src_0 to i288*
  %578 = load i288, i288* %577
  %579 = trunc i288 %578 to i283
  %580 = lshr i283 %579, 272
  %_0133.partselect = trunc i283 %580 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.1:                             ; preds = %src.addr.3374.exit
  %581 = bitcast i283* %src_1 to i288*
  %582 = load i288, i288* %581
  %583 = trunc i288 %582 to i283
  %584 = lshr i283 %583, 272
  %_1134.partselect = trunc i283 %584 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.2:                             ; preds = %src.addr.3374.exit
  %585 = bitcast i283* %src_2 to i288*
  %586 = load i288, i288* %585
  %587 = trunc i288 %586 to i283
  %588 = lshr i283 %587, 272
  %_2135.partselect = trunc i283 %588 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.3:                             ; preds = %src.addr.3374.exit
  %589 = bitcast i283* %src_3 to i288*
  %590 = load i288, i288* %589
  %591 = trunc i288 %590 to i283
  %592 = lshr i283 %591, 272
  %_3136.partselect = trunc i283 %592 to i1
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
  %594 = bitcast i283* %src_0 to i288*
  %595 = load i288, i288* %594
  %596 = trunc i288 %595 to i283
  %597 = lshr i283 %596, 273
  %_0137.partselect = trunc i283 %597 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.1:                             ; preds = %src.addr.3476.exit
  %598 = bitcast i283* %src_1 to i288*
  %599 = load i288, i288* %598
  %600 = trunc i288 %599 to i283
  %601 = lshr i283 %600, 273
  %_1138.partselect = trunc i283 %601 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.2:                             ; preds = %src.addr.3476.exit
  %602 = bitcast i283* %src_2 to i288*
  %603 = load i288, i288* %602
  %604 = trunc i288 %603 to i283
  %605 = lshr i283 %604, 273
  %_2139.partselect = trunc i283 %605 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.3:                             ; preds = %src.addr.3476.exit
  %606 = bitcast i283* %src_3 to i288*
  %607 = load i288, i288* %606
  %608 = trunc i288 %607 to i283
  %609 = lshr i283 %608, 273
  %_3140.partselect = trunc i283 %609 to i1
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
  %611 = bitcast i283* %src_0 to i288*
  %612 = load i288, i288* %611
  %613 = trunc i288 %612 to i283
  %614 = lshr i283 %613, 274
  %_0141.partselect = trunc i283 %614 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.1:                             ; preds = %src.addr.3578.exit
  %615 = bitcast i283* %src_1 to i288*
  %616 = load i288, i288* %615
  %617 = trunc i288 %616 to i283
  %618 = lshr i283 %617, 274
  %_1142.partselect = trunc i283 %618 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.2:                             ; preds = %src.addr.3578.exit
  %619 = bitcast i283* %src_2 to i288*
  %620 = load i288, i288* %619
  %621 = trunc i288 %620 to i283
  %622 = lshr i283 %621, 274
  %_2143.partselect = trunc i283 %622 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.3:                             ; preds = %src.addr.3578.exit
  %623 = bitcast i283* %src_3 to i288*
  %624 = load i288, i288* %623
  %625 = trunc i288 %624 to i283
  %626 = lshr i283 %625, 274
  %_3144.partselect = trunc i283 %626 to i1
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
  %628 = bitcast i283* %src_0 to i288*
  %629 = load i288, i288* %628
  %630 = trunc i288 %629 to i283
  %631 = lshr i283 %630, 275
  %_0145.partselect = trunc i283 %631 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.1:                             ; preds = %src.addr.3680.exit
  %632 = bitcast i283* %src_1 to i288*
  %633 = load i288, i288* %632
  %634 = trunc i288 %633 to i283
  %635 = lshr i283 %634, 275
  %_1146.partselect = trunc i283 %635 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.2:                             ; preds = %src.addr.3680.exit
  %636 = bitcast i283* %src_2 to i288*
  %637 = load i288, i288* %636
  %638 = trunc i288 %637 to i283
  %639 = lshr i283 %638, 275
  %_2147.partselect = trunc i283 %639 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.3:                             ; preds = %src.addr.3680.exit
  %640 = bitcast i283* %src_3 to i288*
  %641 = load i288, i288* %640
  %642 = trunc i288 %641 to i283
  %643 = lshr i283 %642, 275
  %_3148.partselect = trunc i283 %643 to i1
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
  %645 = bitcast i283* %src_0 to i288*
  %646 = load i288, i288* %645
  %647 = trunc i288 %646 to i283
  %648 = lshr i283 %647, 276
  %_0149.partselect = trunc i283 %648 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.1:                             ; preds = %src.addr.3782.exit
  %649 = bitcast i283* %src_1 to i288*
  %650 = load i288, i288* %649
  %651 = trunc i288 %650 to i283
  %652 = lshr i283 %651, 276
  %_1150.partselect = trunc i283 %652 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.2:                             ; preds = %src.addr.3782.exit
  %653 = bitcast i283* %src_2 to i288*
  %654 = load i288, i288* %653
  %655 = trunc i288 %654 to i283
  %656 = lshr i283 %655, 276
  %_2151.partselect = trunc i283 %656 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.3:                             ; preds = %src.addr.3782.exit
  %657 = bitcast i283* %src_3 to i288*
  %658 = load i288, i288* %657
  %659 = trunc i288 %658 to i283
  %660 = lshr i283 %659, 276
  %_3152.partselect = trunc i283 %660 to i1
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
  %662 = bitcast i283* %src_0 to i288*
  %663 = load i288, i288* %662
  %664 = trunc i288 %663 to i283
  %665 = lshr i283 %664, 277
  %_0153.partselect = trunc i283 %665 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.1:                             ; preds = %src.addr.3884.exit
  %666 = bitcast i283* %src_1 to i288*
  %667 = load i288, i288* %666
  %668 = trunc i288 %667 to i283
  %669 = lshr i283 %668, 277
  %_1154.partselect = trunc i283 %669 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.2:                             ; preds = %src.addr.3884.exit
  %670 = bitcast i283* %src_2 to i288*
  %671 = load i288, i288* %670
  %672 = trunc i288 %671 to i283
  %673 = lshr i283 %672, 277
  %_2155.partselect = trunc i283 %673 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.3:                             ; preds = %src.addr.3884.exit
  %674 = bitcast i283* %src_3 to i288*
  %675 = load i288, i288* %674
  %676 = trunc i288 %675 to i283
  %677 = lshr i283 %676, 277
  %_3156.partselect = trunc i283 %677 to i1
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
  %679 = bitcast i283* %src_0 to i288*
  %680 = load i288, i288* %679
  %681 = trunc i288 %680 to i283
  %682 = lshr i283 %681, 278
  %_0157.partselect = trunc i283 %682 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.1:                             ; preds = %src.addr.3986.exit
  %683 = bitcast i283* %src_1 to i288*
  %684 = load i288, i288* %683
  %685 = trunc i288 %684 to i283
  %686 = lshr i283 %685, 278
  %_1158.partselect = trunc i283 %686 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.2:                             ; preds = %src.addr.3986.exit
  %687 = bitcast i283* %src_2 to i288*
  %688 = load i288, i288* %687
  %689 = trunc i288 %688 to i283
  %690 = lshr i283 %689, 278
  %_2159.partselect = trunc i283 %690 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.3:                             ; preds = %src.addr.3986.exit
  %691 = bitcast i283* %src_3 to i288*
  %692 = load i288, i288* %691
  %693 = trunc i288 %692 to i283
  %694 = lshr i283 %693, 278
  %_3160.partselect = trunc i283 %694 to i1
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
  %696 = bitcast i283* %src_0 to i288*
  %697 = load i288, i288* %696
  %698 = trunc i288 %697 to i283
  %699 = lshr i283 %698, 279
  %_0161.partselect = trunc i283 %699 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.1:                             ; preds = %src.addr.4088.exit
  %700 = bitcast i283* %src_1 to i288*
  %701 = load i288, i288* %700
  %702 = trunc i288 %701 to i283
  %703 = lshr i283 %702, 279
  %_1162.partselect = trunc i283 %703 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.2:                             ; preds = %src.addr.4088.exit
  %704 = bitcast i283* %src_2 to i288*
  %705 = load i288, i288* %704
  %706 = trunc i288 %705 to i283
  %707 = lshr i283 %706, 279
  %_2163.partselect = trunc i283 %707 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.3:                             ; preds = %src.addr.4088.exit
  %708 = bitcast i283* %src_3 to i288*
  %709 = load i288, i288* %708
  %710 = trunc i288 %709 to i283
  %711 = lshr i283 %710, 279
  %_3164.partselect = trunc i283 %711 to i1
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
  %713 = bitcast i283* %src_0 to i288*
  %714 = load i288, i288* %713
  %715 = trunc i288 %714 to i283
  %716 = lshr i283 %715, 280
  %_0165.partselect = trunc i283 %716 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.1:                             ; preds = %src.addr.4190.exit
  %717 = bitcast i283* %src_1 to i288*
  %718 = load i288, i288* %717
  %719 = trunc i288 %718 to i283
  %720 = lshr i283 %719, 280
  %_1166.partselect = trunc i283 %720 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.2:                             ; preds = %src.addr.4190.exit
  %721 = bitcast i283* %src_2 to i288*
  %722 = load i288, i288* %721
  %723 = trunc i288 %722 to i283
  %724 = lshr i283 %723, 280
  %_2167.partselect = trunc i283 %724 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.3:                             ; preds = %src.addr.4190.exit
  %725 = bitcast i283* %src_3 to i288*
  %726 = load i288, i288* %725
  %727 = trunc i288 %726 to i283
  %728 = lshr i283 %727, 280
  %_3168.partselect = trunc i283 %728 to i1
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
  %730 = bitcast i283* %src_0 to i288*
  %731 = load i288, i288* %730
  %732 = trunc i288 %731 to i283
  %733 = lshr i283 %732, 281
  %_0169.partselect = trunc i283 %733 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.1:                             ; preds = %src.addr.4292.exit
  %734 = bitcast i283* %src_1 to i288*
  %735 = load i288, i288* %734
  %736 = trunc i288 %735 to i283
  %737 = lshr i283 %736, 281
  %_1170.partselect = trunc i283 %737 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.2:                             ; preds = %src.addr.4292.exit
  %738 = bitcast i283* %src_2 to i288*
  %739 = load i288, i288* %738
  %740 = trunc i288 %739 to i283
  %741 = lshr i283 %740, 281
  %_2171.partselect = trunc i283 %741 to i1
  br label %src.addr.4394.exit

src.addr.4394.case.3:                             ; preds = %src.addr.4292.exit
  %742 = bitcast i283* %src_3 to i288*
  %743 = load i288, i288* %742
  %744 = trunc i288 %743 to i283
  %745 = lshr i283 %744, 281
  %_3172.partselect = trunc i283 %745 to i1
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
  %747 = bitcast i283* %src_0 to i288*
  %748 = load i288, i288* %747
  %749 = trunc i288 %748 to i283
  %750 = lshr i283 %749, 282
  %_0173.partselect = trunc i283 %750 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.1:                             ; preds = %src.addr.4394.exit
  %751 = bitcast i283* %src_1 to i288*
  %752 = load i288, i288* %751
  %753 = trunc i288 %752 to i283
  %754 = lshr i283 %753, 282
  %_1174.partselect = trunc i283 %754 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.2:                             ; preds = %src.addr.4394.exit
  %755 = bitcast i283* %src_2 to i288*
  %756 = load i288, i288* %755
  %757 = trunc i288 %756 to i283
  %758 = lshr i283 %757, 282
  %_2175.partselect = trunc i283 %758 to i1
  br label %src.addr.4496.exit

src.addr.4496.case.3:                             ; preds = %src.addr.4394.exit
  %759 = bitcast i283* %src_3 to i288*
  %760 = load i288, i288* %759
  %761 = trunc i288 %760 to i283
  %762 = lshr i283 %761, 282
  %_3176.partselect = trunc i283 %762 to i1
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
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i283* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i283* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1, i283* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.2" %src_2, i283* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.3" %src_3) #1 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i283* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.23.24([4 x %struct.HeadCtx]* nonnull %dst, i283* nonnull %src_0, i283* %src_1, i283* %src_2, i283* %src_3, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i8* noalias "orig.arg.no"="4", i8* noalias readonly align 512 "orig.arg.no"="5", i32* noalias "orig.arg.no"="6", i32* noalias readonly align 512 "orig.arg.no"="7", i32* noalias "orig.arg.no"="8", i32* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", i1* noalias "orig.arg.no"="12", i1* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="16", i283* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i283* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i283* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i283* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias "orig.arg.no"="18", i1* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21", i1* noalias "orig.arg.no"="22", i1* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias "orig.arg.no"="26", i1056* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i32* noalias "orig.arg.no"="52", i32* noalias readonly align 512 "orig.arg.no"="53", i32* noalias "orig.arg.no"="54", i32* noalias readonly align 512 "orig.arg.no"="55", i32* noalias "orig.arg.no"="56", i32* noalias readonly align 512 "orig.arg.no"="57", i1* noalias "orig.arg.no"="58", i1* noalias readonly align 512 "orig.arg.no"="59", i1* noalias "orig.arg.no"="60", i1* noalias readonly align 512 "orig.arg.no"="61") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %4, i8* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %6, i32* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %12, i1* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* %16, i283* align 512 %_0, i283* align 512 %_1, i283* align 512 %_2, i283* align 512 %_3)
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

declare void @apatb_transformer_top_hw(i1, i1, i1*, i1, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1*, i32*, i283*, i283*, i283*, i283*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i8* noalias "orig.arg.no"="4", i8* noalias readonly align 512 "orig.arg.no"="5", i32* noalias "orig.arg.no"="6", i32* noalias readonly align 512 "orig.arg.no"="7", i32* noalias "orig.arg.no"="8", i32* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", i1* noalias "orig.arg.no"="12", i1* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="16", i283* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.0" %_0, i283* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.1" %_1, i283* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.2" %_2, i283* noalias readonly align 512 "orig.arg.no"="17" "unpacked"="17.3" %_3, i1* noalias "orig.arg.no"="18", i1* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21", i1* noalias "orig.arg.no"="22", i1* noalias readonly align 512 "orig.arg.no"="23", i32* noalias "orig.arg.no"="24", i32* noalias readonly align 512 "orig.arg.no"="25", %struct.ControlMemSpace* noalias "orig.arg.no"="26", i1056* noalias readonly align 512 "orig.arg.no"="27", i32* noalias "orig.arg.no"="28", i32* noalias readonly align 512 "orig.arg.no"="29", i32* noalias "orig.arg.no"="30", i32* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35", i32* noalias "orig.arg.no"="36", i32* noalias readonly align 512 "orig.arg.no"="37", i32* noalias "orig.arg.no"="38", i32* noalias readonly align 512 "orig.arg.no"="39", i32* noalias "orig.arg.no"="40", i32* noalias readonly align 512 "orig.arg.no"="41", i32* noalias "orig.arg.no"="42", i32* noalias readonly align 512 "orig.arg.no"="43", i32* noalias "orig.arg.no"="44", i32* noalias readonly align 512 "orig.arg.no"="45", i32* noalias "orig.arg.no"="46", i32* noalias readonly align 512 "orig.arg.no"="47", i32* noalias "orig.arg.no"="48", i32* noalias readonly align 512 "orig.arg.no"="49", i32* noalias "orig.arg.no"="50", i32* noalias readonly align 512 "orig.arg.no"="51", i32* noalias "orig.arg.no"="52", i32* noalias readonly align 512 "orig.arg.no"="53", i32* noalias "orig.arg.no"="54", i32* noalias readonly align 512 "orig.arg.no"="55", i32* noalias "orig.arg.no"="56", i32* noalias readonly align 512 "orig.arg.no"="57", i1* noalias "orig.arg.no"="58", i1* noalias readonly align 512 "orig.arg.no"="59", i1* noalias "orig.arg.no"="60", i1* noalias readonly align 512 "orig.arg.no"="61") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %4, i8* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %6, i32* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %12, i1* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.22.25([4 x %struct.HeadCtx]* %16, i283* align 512 %_0, i283* align 512 %_1, i283* align 512 %_2, i283* align 512 %_3)
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

define void @transformer_top_hw_stub_wrapper(i1, i1, i1*, i1, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1*, i32*, i283*, i283*, i283*, i283*, i1, i1*, i1, i32, i32, i32*, i1, i1, i1, i1, i1*, i32*, i1056*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i1*, i1*) #5 {
entry:
  %48 = call i8* @malloc(i64 288)
  %49 = bitcast i8* %48 to [4 x %struct.HeadCtx]*
  %50 = call i8* @malloc(i64 132)
  %51 = bitcast i8* %50 to %struct.ControlMemSpace*
  call void @copy_out(i1* null, i1* %2, i1* null, i1* %5, i8* null, i8* %6, i32* null, i32* %7, i32* null, i32* %8, i32* null, i32* %9, i1* null, i1* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %49, i283* %14, i283* %15, i283* %16, i283* %17, i1* null, i1* %19, i32* null, i32* %23, i1* null, i1* %28, i32* null, i32* %29, %struct.ControlMemSpace* %51, i1056* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i32* null, i32* %42, i32* null, i32* %43, i32* null, i32* %44, i32* null, i32* %45, i1* null, i1* %46, i1* null, i1* %47)
  call void @transformer_top_hw_stub(i1 %0, i1 %1, i1* %2, i1 %3, i1 %4, i1* %5, i8* %6, i32* %7, i32* %8, i32* %9, i1 %10, i1 %11, i1* %12, i32* %13, [4 x %struct.HeadCtx]* %49, i1 %18, i1* %19, i1 %20, i32 %21, i32 %22, i32* %23, i1 %24, i1 %25, i1 %26, i1 %27, i1* %28, i32* %29, %struct.ControlMemSpace* %51, i32* %31, i32* %32, i32* %33, i32* %34, i32* %35, i32* %36, i32* %37, i32* %38, i32* %39, i32* %40, i32* %41, i32* %42, i32* %43, i32* %44, i32* %45, i1* %46, i1* %47)
  call void @copy_in(i1* null, i1* %2, i1* null, i1* %5, i8* null, i8* %6, i32* null, i32* %7, i32* null, i32* %8, i32* null, i32* %9, i1* null, i1* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %49, i283* %14, i283* %15, i283* %16, i283* %17, i1* null, i1* %19, i32* null, i32* %23, i1* null, i1* %28, i32* null, i32* %29, %struct.ControlMemSpace* %51, i1056* %30, i32* null, i32* %31, i32* null, i32* %32, i32* null, i32* %33, i32* null, i32* %34, i32* null, i32* %35, i32* null, i32* %36, i32* null, i32* %37, i32* null, i32* %38, i32* null, i32* %39, i32* null, i32* %40, i32* null, i32* %41, i32* null, i32* %42, i32* null, i32* %43, i32* null, i32* %44, i32* null, i32* %45, i1* null, i1* %46, i1* null, i1* %47)
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
