; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_total/Scheduler_FSM_DMA_heads/scheduler_hls/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i8, i8, i8, i1, i1, i8, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }

; Function Attrs: noinline willreturn
define void @apatb_scheduler_hls_ir(i1 zeroext %cntrl_start, i1 zeroext %cntrl_reset_n, i32* noalias nocapture nonnull dereferenceable(4) %cntrl_layer_idx, i1* noalias nocapture nonnull dereferenceable(1) %cntrl_busy, i1* noalias nocapture nonnull dereferenceable(1) %cntrl_start_out, i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %wl_ready, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i8* noalias nocapture nonnull dereferenceable(1) %wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %wl_head, i32* noalias nocapture nonnull dereferenceable(4) %wl_tile, i1 zeroext %dma_done, i1 zeroext %compute_ready, i1 zeroext %compute_done, i1 zeroext %requant_ready, i1 zeroext %requant_done, [4 x %struct.HeadCtx]* noalias nonnull dereferenceable(208) "partition" %head_ctx_ref, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i32* noalias nocapture nonnull dereferenceable(4) %compute_op, i1* noalias nocapture nonnull dereferenceable(1) %requant_start, i32* noalias nocapture nonnull dereferenceable(4) %requant_op, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i1* noalias nocapture nonnull dereferenceable(1) %done, i32* noalias nocapture nonnull dereferenceable(4) %debug_compute_done, i32* noalias nocapture nonnull dereferenceable(4) %STATE) local_unnamed_addr #0 {
entry:
  %cntrl_layer_idx_copy = alloca i32, align 512
  %cntrl_busy_copy = alloca i1, align 512
  %cntrl_start_out_copy = alloca i1, align 512
  %axis_in_ready_copy = alloca i1, align 512
  %wl_start_copy = alloca i1, align 512
  %wl_addr_sel_copy = alloca i8, align 512
  %wl_layer_copy = alloca i32, align 512
  %wl_head_copy = alloca i32, align 512
  %wl_tile_copy = alloca i32, align 512
  %head_ctx_ref_copy_0 = alloca i195, align 512
  %head_ctx_ref_copy_1 = alloca i195, align 512
  %head_ctx_ref_copy_2 = alloca i195, align 512
  %head_ctx_ref_copy_3 = alloca i195, align 512
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i32, align 512
  %requant_start_copy = alloca i1, align 512
  %requant_op_copy = alloca i32, align 512
  %stream_start_copy = alloca i1, align 512
  %done_copy = alloca i1, align 512
  %debug_compute_done_copy = alloca i32, align 512
  %STATE_copy = alloca i32, align 512
  call void @copy_in(i32* nonnull %cntrl_layer_idx, i32* nonnull align 512 %cntrl_layer_idx_copy, i1* nonnull %cntrl_busy, i1* nonnull align 512 %cntrl_busy_copy, i1* nonnull %cntrl_start_out, i1* nonnull align 512 %cntrl_start_out_copy, i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i8* nonnull %wl_addr_sel, i8* nonnull align 512 %wl_addr_sel_copy, i32* nonnull %wl_layer, i32* nonnull align 512 %wl_layer_copy, i32* nonnull %wl_head, i32* nonnull align 512 %wl_head_copy, i32* nonnull %wl_tile, i32* nonnull align 512 %wl_tile_copy, [4 x %struct.HeadCtx]* nonnull %head_ctx_ref, i195* nonnull align 512 %head_ctx_ref_copy_0, i195* nonnull align 512 %head_ctx_ref_copy_1, i195* nonnull align 512 %head_ctx_ref_copy_2, i195* nonnull align 512 %head_ctx_ref_copy_3, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i32* nonnull %compute_op, i32* nonnull align 512 %compute_op_copy, i1* nonnull %requant_start, i1* nonnull align 512 %requant_start_copy, i32* nonnull %requant_op, i32* nonnull align 512 %requant_op_copy, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i1* nonnull %done, i1* nonnull align 512 %done_copy, i32* nonnull %debug_compute_done, i32* nonnull align 512 %debug_compute_done_copy, i32* nonnull %STATE, i32* nonnull align 512 %STATE_copy)
  call void @apatb_scheduler_hls_hw(i1 %cntrl_start, i1 %cntrl_reset_n, i32* %cntrl_layer_idx_copy, i1* %cntrl_busy_copy, i1* %cntrl_start_out_copy, i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %wl_ready, i1* %wl_start_copy, i8* %wl_addr_sel_copy, i32* %wl_layer_copy, i32* %wl_head_copy, i32* %wl_tile_copy, i1 %dma_done, i1 %compute_ready, i1 %compute_done, i1 %requant_ready, i1 %requant_done, i195* %head_ctx_ref_copy_0, i195* %head_ctx_ref_copy_1, i195* %head_ctx_ref_copy_2, i195* %head_ctx_ref_copy_3, i1* %compute_start_copy, i32* %compute_op_copy, i1* %requant_start_copy, i32* %requant_op_copy, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i1* %done_copy, i32* %debug_compute_done_copy, i32* %STATE_copy)
  call void @copy_back(i32* %cntrl_layer_idx, i32* %cntrl_layer_idx_copy, i1* %cntrl_busy, i1* %cntrl_busy_copy, i1* %cntrl_start_out, i1* %cntrl_start_out_copy, i1* %axis_in_ready, i1* %axis_in_ready_copy, i1* %wl_start, i1* %wl_start_copy, i8* %wl_addr_sel, i8* %wl_addr_sel_copy, i32* %wl_layer, i32* %wl_layer_copy, i32* %wl_head, i32* %wl_head_copy, i32* %wl_tile, i32* %wl_tile_copy, [4 x %struct.HeadCtx]* %head_ctx_ref, i195* %head_ctx_ref_copy_0, i195* %head_ctx_ref_copy_1, i195* %head_ctx_ref_copy_2, i195* %head_ctx_ref_copy_3, i1* %compute_start, i1* %compute_start_copy, i32* %compute_op, i32* %compute_op_copy, i1* %requant_start, i1* %requant_start_copy, i32* %requant_op, i32* %requant_op_copy, i1* %stream_start, i1* %stream_start_copy, i1* %done, i1* %done_copy, i32* %debug_compute_done, i32* %debug_compute_done_copy, i32* %STATE, i32* %STATE_copy)
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
define void @arraycpy_hls.p0a4struct.HeadCtx([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond80 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond80, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx81 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 0
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 1
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 1
  %4 = load i32, i32* %src.addr.110, align 4
  store i32 %4, i32* %dst.addr.111, align 4
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 2
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 2
  %5 = load i8, i8* %src.addr.212, align 1
  store i8 %5, i8* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 3
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 3
  %6 = bitcast i1* %src.addr.314 to i8*
  %7 = load i8, i8* %6
  %8 = trunc i8 %7 to i1
  store i1 %8, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 4
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 4
  %9 = bitcast i1* %src.addr.416 to i8*
  %10 = load i8, i8* %9
  %11 = trunc i8 %10 to i1
  store i1 %11, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 5
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 5
  %12 = bitcast i1* %src.addr.518 to i8*
  %13 = load i8, i8* %12
  %14 = trunc i8 %13 to i1
  store i1 %14, i1* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 6
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 6
  %15 = load i8, i8* %src.addr.620, align 1
  store i8 %15, i8* %dst.addr.621, align 1
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 7
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 7
  %16 = load i8, i8* %src.addr.722, align 1
  store i8 %16, i8* %dst.addr.723, align 1
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 8
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 8
  %17 = load i8, i8* %src.addr.824, align 1
  store i8 %17, i8* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 9
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 9
  %18 = bitcast i1* %src.addr.926 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  store i1 %20, i1* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 10
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 10
  %21 = bitcast i1* %src.addr.1028 to i8*
  %22 = load i8, i8* %21
  %23 = trunc i8 %22 to i1
  store i1 %23, i1* %dst.addr.1029, align 1
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 11
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 11
  %24 = load i8, i8* %src.addr.1130, align 1
  store i8 %24, i8* %dst.addr.1131, align 1
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 12
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 12
  %25 = load i32, i32* %src.addr.1232, align 4
  store i32 %25, i32* %dst.addr.1233, align 4
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 13
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 13
  %26 = load i32, i32* %src.addr.1334, align 4
  store i32 %26, i32* %dst.addr.1335, align 4
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 14
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 14
  %27 = bitcast i1* %src.addr.1436 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  store i1 %29, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 15
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 15
  %30 = bitcast i1* %src.addr.1538 to i8*
  %31 = load i8, i8* %30
  %32 = trunc i8 %31 to i1
  store i1 %32, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 16
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 16
  %33 = bitcast i1* %src.addr.1640 to i8*
  %34 = load i8, i8* %33
  %35 = trunc i8 %34 to i1
  store i1 %35, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 17
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 17
  %36 = bitcast i1* %src.addr.1742 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  store i1 %38, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 18
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 18
  %39 = bitcast i1* %src.addr.1844 to i8*
  %40 = load i8, i8* %39
  %41 = trunc i8 %40 to i1
  store i1 %41, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 19
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 19
  %42 = bitcast i1* %src.addr.1946 to i8*
  %43 = load i8, i8* %42
  %44 = trunc i8 %43 to i1
  store i1 %44, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 20
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 20
  %45 = bitcast i1* %src.addr.2048 to i8*
  %46 = load i8, i8* %45
  %47 = trunc i8 %46 to i1
  store i1 %47, i1* %dst.addr.2049, align 1
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 21
  %dst.addr.2151 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 21
  %48 = bitcast i1* %src.addr.2150 to i8*
  %49 = load i8, i8* %48
  %50 = trunc i8 %49 to i1
  store i1 %50, i1* %dst.addr.2151, align 1
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 22
  %dst.addr.2253 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 22
  %51 = bitcast i1* %src.addr.2252 to i8*
  %52 = load i8, i8* %51
  %53 = trunc i8 %52 to i1
  store i1 %53, i1* %dst.addr.2253, align 1
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 23
  %dst.addr.2355 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 23
  %54 = bitcast i1* %src.addr.2354 to i8*
  %55 = load i8, i8* %54
  %56 = trunc i8 %55 to i1
  store i1 %56, i1* %dst.addr.2355, align 1
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 24
  %dst.addr.2457 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 24
  %57 = bitcast i1* %src.addr.2456 to i8*
  %58 = load i8, i8* %57
  %59 = trunc i8 %58 to i1
  store i1 %59, i1* %dst.addr.2457, align 1
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 25
  %dst.addr.2559 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 25
  %60 = bitcast i1* %src.addr.2558 to i8*
  %61 = load i8, i8* %60
  %62 = trunc i8 %61 to i1
  store i1 %62, i1* %dst.addr.2559, align 1
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 26
  %dst.addr.2661 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 26
  %63 = bitcast i1* %src.addr.2660 to i8*
  %64 = load i8, i8* %63
  %65 = trunc i8 %64 to i1
  store i1 %65, i1* %dst.addr.2661, align 1
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 27
  %dst.addr.2763 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 27
  %66 = bitcast i1* %src.addr.2762 to i8*
  %67 = load i8, i8* %66
  %68 = trunc i8 %67 to i1
  store i1 %68, i1* %dst.addr.2763, align 1
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 28
  %dst.addr.2865 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 28
  %69 = bitcast i1* %src.addr.2864 to i8*
  %70 = load i8, i8* %69
  %71 = trunc i8 %70 to i1
  store i1 %71, i1* %dst.addr.2865, align 1
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 29
  %dst.addr.2967 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 29
  %72 = bitcast i1* %src.addr.2966 to i8*
  %73 = load i8, i8* %72
  %74 = trunc i8 %73 to i1
  store i1 %74, i1* %dst.addr.2967, align 1
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 30
  %dst.addr.3069 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 30
  %75 = bitcast i1* %src.addr.3068 to i8*
  %76 = load i8, i8* %75
  %77 = trunc i8 %76 to i1
  store i1 %77, i1* %dst.addr.3069, align 1
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 31
  %dst.addr.3171 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 31
  %78 = bitcast i1* %src.addr.3170 to i8*
  %79 = load i8, i8* %78
  %80 = trunc i8 %79 to i1
  store i1 %80, i1* %dst.addr.3171, align 1
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 32
  %dst.addr.3273 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 32
  %81 = bitcast i1* %src.addr.3272 to i8*
  %82 = load i8, i8* %81
  %83 = trunc i8 %82 to i1
  store i1 %83, i1* %dst.addr.3273, align 1
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 33
  %dst.addr.3375 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 33
  %84 = bitcast i1* %src.addr.3374 to i8*
  %85 = load i8, i8* %84
  %86 = trunc i8 %85 to i1
  store i1 %86, i1* %dst.addr.3375, align 1
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 34
  %dst.addr.3477 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 34
  %87 = bitcast i1* %src.addr.3476 to i8*
  %88 = load i8, i8* %87
  %89 = trunc i8 %88 to i1
  store i1 %89, i1* %dst.addr.3477, align 1
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 35
  %dst.addr.3579 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 35
  %90 = bitcast i1* %src.addr.3578 to i8*
  %91 = load i8, i8* %90
  %92 = trunc i8 %91 to i1
  store i1 %92, i1* %dst.addr.3579, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx81, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.10.11(i195* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i195* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i195* "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i195* "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i195* %dst_0, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond80 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond80, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %dst.addr.3579.exit, %for.loop.lr.ph
  %for.loop.idx81 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %dst.addr.3579.exit ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  switch i64 %for.loop.idx81, label %dst.addr.02.exit [
    i64 0, label %dst.addr.02.case.0
    i64 1, label %dst.addr.02.case.1
    i64 2, label %dst.addr.02.case.2
    i64 3, label %dst.addr.02.case.3
  ]

dst.addr.02.case.0:                               ; preds = %for.loop
  %4 = bitcast i195* %dst_0 to i200*
  %5 = load i200, i200* %4
  %6 = trunc i200 %5 to i195
  %7 = zext i32 %3 to i195
  %8 = and i195 %6, -4294967296
  %.partset143 = or i195 %8, %7
  store i195 %.partset143, i195* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i195* %dst_1 to i200*
  %10 = load i200, i200* %9
  %11 = trunc i200 %10 to i195
  %12 = zext i32 %3 to i195
  %13 = and i195 %11, -4294967296
  %.partset72 = or i195 %13, %12
  store i195 %.partset72, i195* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.2:                               ; preds = %for.loop
  %14 = bitcast i195* %dst_2 to i200*
  %15 = load i200, i200* %14
  %16 = trunc i200 %15 to i195
  %17 = zext i32 %3 to i195
  %18 = and i195 %16, -4294967296
  %.partset71 = or i195 %18, %17
  store i195 %.partset71, i195* %dst_2, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.3:                               ; preds = %for.loop
  %19 = bitcast i195* %dst_3 to i200*
  %20 = load i200, i200* %19
  %21 = trunc i200 %20 to i195
  %22 = zext i32 %3 to i195
  %23 = and i195 %21, -4294967296
  %.partset = or i195 %23, %22
  store i195 %.partset, i195* %dst_3, align 4
  br label %dst.addr.02.exit

dst.addr.02.exit:                                 ; preds = %dst.addr.02.case.3, %dst.addr.02.case.2, %dst.addr.02.case.1, %dst.addr.02.case.0, %for.loop
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 1
  %24 = load i32, i32* %src.addr.110, align 4
  switch i64 %for.loop.idx81, label %dst.addr.111.exit [
    i64 0, label %dst.addr.111.case.0
    i64 1, label %dst.addr.111.case.1
    i64 2, label %dst.addr.111.case.2
    i64 3, label %dst.addr.111.case.3
  ]

dst.addr.111.case.0:                              ; preds = %dst.addr.02.exit
  %25 = bitcast i195* %dst_0 to i200*
  %26 = load i200, i200* %25
  %27 = trunc i200 %26 to i195
  %28 = zext i32 %24 to i195
  %29 = shl i195 %28, 32
  %30 = and i195 %27, -18446744069414584321
  %.partset142 = or i195 %30, %29
  store i195 %.partset142, i195* %dst_0, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %31 = bitcast i195* %dst_1 to i200*
  %32 = load i200, i200* %31
  %33 = trunc i200 %32 to i195
  %34 = zext i32 %24 to i195
  %35 = shl i195 %34, 32
  %36 = and i195 %33, -18446744069414584321
  %.partset73 = or i195 %36, %35
  store i195 %.partset73, i195* %dst_1, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.2:                              ; preds = %dst.addr.02.exit
  %37 = bitcast i195* %dst_2 to i200*
  %38 = load i200, i200* %37
  %39 = trunc i200 %38 to i195
  %40 = zext i32 %24 to i195
  %41 = shl i195 %40, 32
  %42 = and i195 %39, -18446744069414584321
  %.partset70 = or i195 %42, %41
  store i195 %.partset70, i195* %dst_2, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.3:                              ; preds = %dst.addr.02.exit
  %43 = bitcast i195* %dst_3 to i200*
  %44 = load i200, i200* %43
  %45 = trunc i200 %44 to i195
  %46 = zext i32 %24 to i195
  %47 = shl i195 %46, 32
  %48 = and i195 %45, -18446744069414584321
  %.partset1 = or i195 %48, %47
  store i195 %.partset1, i195* %dst_3, align 4
  br label %dst.addr.111.exit

dst.addr.111.exit:                                ; preds = %dst.addr.111.case.3, %dst.addr.111.case.2, %dst.addr.111.case.1, %dst.addr.111.case.0, %dst.addr.02.exit
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 2
  %49 = load i8, i8* %src.addr.212, align 1
  switch i64 %for.loop.idx81, label %dst.addr.213.exit [
    i64 0, label %dst.addr.213.case.0
    i64 1, label %dst.addr.213.case.1
    i64 2, label %dst.addr.213.case.2
    i64 3, label %dst.addr.213.case.3
  ]

dst.addr.213.case.0:                              ; preds = %dst.addr.111.exit
  %50 = bitcast i195* %dst_0 to i200*
  %51 = load i200, i200* %50
  %52 = trunc i200 %51 to i195
  %53 = zext i8 %49 to i195
  %54 = shl i195 %53, 64
  %55 = and i195 %52, -4703919738795935662081
  %.partset141 = or i195 %55, %54
  store i195 %.partset141, i195* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %56 = bitcast i195* %dst_1 to i200*
  %57 = load i200, i200* %56
  %58 = trunc i200 %57 to i195
  %59 = zext i8 %49 to i195
  %60 = shl i195 %59, 64
  %61 = and i195 %58, -4703919738795935662081
  %.partset74 = or i195 %61, %60
  store i195 %.partset74, i195* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.2:                              ; preds = %dst.addr.111.exit
  %62 = bitcast i195* %dst_2 to i200*
  %63 = load i200, i200* %62
  %64 = trunc i200 %63 to i195
  %65 = zext i8 %49 to i195
  %66 = shl i195 %65, 64
  %67 = and i195 %64, -4703919738795935662081
  %.partset69 = or i195 %67, %66
  store i195 %.partset69, i195* %dst_2, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.3:                              ; preds = %dst.addr.111.exit
  %68 = bitcast i195* %dst_3 to i200*
  %69 = load i200, i200* %68
  %70 = trunc i200 %69 to i195
  %71 = zext i8 %49 to i195
  %72 = shl i195 %71, 64
  %73 = and i195 %70, -4703919738795935662081
  %.partset2 = or i195 %73, %72
  store i195 %.partset2, i195* %dst_3, align 1
  br label %dst.addr.213.exit

dst.addr.213.exit:                                ; preds = %dst.addr.213.case.3, %dst.addr.213.case.2, %dst.addr.213.case.1, %dst.addr.213.case.0, %dst.addr.111.exit
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 3
  %74 = bitcast i1* %src.addr.314 to i8*
  %75 = load i8, i8* %74
  %76 = trunc i8 %75 to i1
  switch i64 %for.loop.idx81, label %dst.addr.315.exit [
    i64 0, label %dst.addr.315.case.0
    i64 1, label %dst.addr.315.case.1
    i64 2, label %dst.addr.315.case.2
    i64 3, label %dst.addr.315.case.3
  ]

dst.addr.315.case.0:                              ; preds = %dst.addr.213.exit
  %77 = bitcast i195* %dst_0 to i200*
  %78 = load i200, i200* %77
  %79 = trunc i200 %78 to i195
  %80 = zext i1 %76 to i195
  %81 = shl i195 %80, 72
  %82 = and i195 %79, -4722366482869645213697
  %.partset140 = or i195 %82, %81
  store i195 %.partset140, i195* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %83 = bitcast i195* %dst_1 to i200*
  %84 = load i200, i200* %83
  %85 = trunc i200 %84 to i195
  %86 = zext i1 %76 to i195
  %87 = shl i195 %86, 72
  %88 = and i195 %85, -4722366482869645213697
  %.partset75 = or i195 %88, %87
  store i195 %.partset75, i195* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.2:                              ; preds = %dst.addr.213.exit
  %89 = bitcast i195* %dst_2 to i200*
  %90 = load i200, i200* %89
  %91 = trunc i200 %90 to i195
  %92 = zext i1 %76 to i195
  %93 = shl i195 %92, 72
  %94 = and i195 %91, -4722366482869645213697
  %.partset68 = or i195 %94, %93
  store i195 %.partset68, i195* %dst_2, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.3:                              ; preds = %dst.addr.213.exit
  %95 = bitcast i195* %dst_3 to i200*
  %96 = load i200, i200* %95
  %97 = trunc i200 %96 to i195
  %98 = zext i1 %76 to i195
  %99 = shl i195 %98, 72
  %100 = and i195 %97, -4722366482869645213697
  %.partset3 = or i195 %100, %99
  store i195 %.partset3, i195* %dst_3, align 1
  br label %dst.addr.315.exit

dst.addr.315.exit:                                ; preds = %dst.addr.315.case.3, %dst.addr.315.case.2, %dst.addr.315.case.1, %dst.addr.315.case.0, %dst.addr.213.exit
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 4
  %101 = bitcast i1* %src.addr.416 to i8*
  %102 = load i8, i8* %101
  %103 = trunc i8 %102 to i1
  switch i64 %for.loop.idx81, label %dst.addr.417.exit [
    i64 0, label %dst.addr.417.case.0
    i64 1, label %dst.addr.417.case.1
    i64 2, label %dst.addr.417.case.2
    i64 3, label %dst.addr.417.case.3
  ]

dst.addr.417.case.0:                              ; preds = %dst.addr.315.exit
  %104 = bitcast i195* %dst_0 to i200*
  %105 = load i200, i200* %104
  %106 = trunc i200 %105 to i195
  %107 = zext i1 %103 to i195
  %108 = shl i195 %107, 73
  %109 = and i195 %106, -9444732965739290427393
  %.partset139 = or i195 %109, %108
  store i195 %.partset139, i195* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %110 = bitcast i195* %dst_1 to i200*
  %111 = load i200, i200* %110
  %112 = trunc i200 %111 to i195
  %113 = zext i1 %103 to i195
  %114 = shl i195 %113, 73
  %115 = and i195 %112, -9444732965739290427393
  %.partset76 = or i195 %115, %114
  store i195 %.partset76, i195* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.2:                              ; preds = %dst.addr.315.exit
  %116 = bitcast i195* %dst_2 to i200*
  %117 = load i200, i200* %116
  %118 = trunc i200 %117 to i195
  %119 = zext i1 %103 to i195
  %120 = shl i195 %119, 73
  %121 = and i195 %118, -9444732965739290427393
  %.partset67 = or i195 %121, %120
  store i195 %.partset67, i195* %dst_2, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.3:                              ; preds = %dst.addr.315.exit
  %122 = bitcast i195* %dst_3 to i200*
  %123 = load i200, i200* %122
  %124 = trunc i200 %123 to i195
  %125 = zext i1 %103 to i195
  %126 = shl i195 %125, 73
  %127 = and i195 %124, -9444732965739290427393
  %.partset4 = or i195 %127, %126
  store i195 %.partset4, i195* %dst_3, align 1
  br label %dst.addr.417.exit

dst.addr.417.exit:                                ; preds = %dst.addr.417.case.3, %dst.addr.417.case.2, %dst.addr.417.case.1, %dst.addr.417.case.0, %dst.addr.315.exit
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 5
  %128 = bitcast i1* %src.addr.518 to i8*
  %129 = load i8, i8* %128
  %130 = trunc i8 %129 to i1
  switch i64 %for.loop.idx81, label %dst.addr.519.exit [
    i64 0, label %dst.addr.519.case.0
    i64 1, label %dst.addr.519.case.1
    i64 2, label %dst.addr.519.case.2
    i64 3, label %dst.addr.519.case.3
  ]

dst.addr.519.case.0:                              ; preds = %dst.addr.417.exit
  %131 = bitcast i195* %dst_0 to i200*
  %132 = load i200, i200* %131
  %133 = trunc i200 %132 to i195
  %134 = zext i1 %130 to i195
  %135 = shl i195 %134, 74
  %136 = and i195 %133, -18889465931478580854785
  %.partset138 = or i195 %136, %135
  store i195 %.partset138, i195* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %137 = bitcast i195* %dst_1 to i200*
  %138 = load i200, i200* %137
  %139 = trunc i200 %138 to i195
  %140 = zext i1 %130 to i195
  %141 = shl i195 %140, 74
  %142 = and i195 %139, -18889465931478580854785
  %.partset77 = or i195 %142, %141
  store i195 %.partset77, i195* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.2:                              ; preds = %dst.addr.417.exit
  %143 = bitcast i195* %dst_2 to i200*
  %144 = load i200, i200* %143
  %145 = trunc i200 %144 to i195
  %146 = zext i1 %130 to i195
  %147 = shl i195 %146, 74
  %148 = and i195 %145, -18889465931478580854785
  %.partset66 = or i195 %148, %147
  store i195 %.partset66, i195* %dst_2, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.3:                              ; preds = %dst.addr.417.exit
  %149 = bitcast i195* %dst_3 to i200*
  %150 = load i200, i200* %149
  %151 = trunc i200 %150 to i195
  %152 = zext i1 %130 to i195
  %153 = shl i195 %152, 74
  %154 = and i195 %151, -18889465931478580854785
  %.partset5 = or i195 %154, %153
  store i195 %.partset5, i195* %dst_3, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.3, %dst.addr.519.case.2, %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 6
  %155 = load i8, i8* %src.addr.620, align 1
  switch i64 %for.loop.idx81, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
    i64 2, label %dst.addr.621.case.2
    i64 3, label %dst.addr.621.case.3
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %156 = bitcast i195* %dst_0 to i200*
  %157 = load i200, i200* %156
  %158 = trunc i200 %157 to i195
  %159 = zext i8 %155 to i195
  %160 = shl i195 %159, 75
  %161 = and i195 %158, -9633627625054076235939841
  %.partset137 = or i195 %161, %160
  store i195 %.partset137, i195* %dst_0, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %162 = bitcast i195* %dst_1 to i200*
  %163 = load i200, i200* %162
  %164 = trunc i200 %163 to i195
  %165 = zext i8 %155 to i195
  %166 = shl i195 %165, 75
  %167 = and i195 %164, -9633627625054076235939841
  %.partset78 = or i195 %167, %166
  store i195 %.partset78, i195* %dst_1, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.2:                              ; preds = %dst.addr.519.exit
  %168 = bitcast i195* %dst_2 to i200*
  %169 = load i200, i200* %168
  %170 = trunc i200 %169 to i195
  %171 = zext i8 %155 to i195
  %172 = shl i195 %171, 75
  %173 = and i195 %170, -9633627625054076235939841
  %.partset65 = or i195 %173, %172
  store i195 %.partset65, i195* %dst_2, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.3:                              ; preds = %dst.addr.519.exit
  %174 = bitcast i195* %dst_3 to i200*
  %175 = load i200, i200* %174
  %176 = trunc i200 %175 to i195
  %177 = zext i8 %155 to i195
  %178 = shl i195 %177, 75
  %179 = and i195 %176, -9633627625054076235939841
  %.partset6 = or i195 %179, %178
  store i195 %.partset6, i195* %dst_3, align 1
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.3, %dst.addr.621.case.2, %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 7
  %180 = load i8, i8* %src.addr.722, align 1
  switch i64 %for.loop.idx81, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
    i64 2, label %dst.addr.723.case.2
    i64 3, label %dst.addr.723.case.3
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %181 = bitcast i195* %dst_0 to i200*
  %182 = load i200, i200* %181
  %183 = trunc i200 %182 to i195
  %184 = zext i8 %180 to i195
  %185 = shl i195 %184, 83
  %186 = and i195 %183, -2466208672013843516400599041
  %.partset136 = or i195 %186, %185
  store i195 %.partset136, i195* %dst_0, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %187 = bitcast i195* %dst_1 to i200*
  %188 = load i200, i200* %187
  %189 = trunc i200 %188 to i195
  %190 = zext i8 %180 to i195
  %191 = shl i195 %190, 83
  %192 = and i195 %189, -2466208672013843516400599041
  %.partset79 = or i195 %192, %191
  store i195 %.partset79, i195* %dst_1, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.2:                              ; preds = %dst.addr.621.exit
  %193 = bitcast i195* %dst_2 to i200*
  %194 = load i200, i200* %193
  %195 = trunc i200 %194 to i195
  %196 = zext i8 %180 to i195
  %197 = shl i195 %196, 83
  %198 = and i195 %195, -2466208672013843516400599041
  %.partset64 = or i195 %198, %197
  store i195 %.partset64, i195* %dst_2, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.3:                              ; preds = %dst.addr.621.exit
  %199 = bitcast i195* %dst_3 to i200*
  %200 = load i200, i200* %199
  %201 = trunc i200 %200 to i195
  %202 = zext i8 %180 to i195
  %203 = shl i195 %202, 83
  %204 = and i195 %201, -2466208672013843516400599041
  %.partset7 = or i195 %204, %203
  store i195 %.partset7, i195* %dst_3, align 1
  br label %dst.addr.723.exit

dst.addr.723.exit:                                ; preds = %dst.addr.723.case.3, %dst.addr.723.case.2, %dst.addr.723.case.1, %dst.addr.723.case.0, %dst.addr.621.exit
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 8
  %205 = load i8, i8* %src.addr.824, align 1
  switch i64 %for.loop.idx81, label %dst.addr.825.exit [
    i64 0, label %dst.addr.825.case.0
    i64 1, label %dst.addr.825.case.1
    i64 2, label %dst.addr.825.case.2
    i64 3, label %dst.addr.825.case.3
  ]

dst.addr.825.case.0:                              ; preds = %dst.addr.723.exit
  %206 = bitcast i195* %dst_0 to i200*
  %207 = load i200, i200* %206
  %208 = trunc i200 %207 to i195
  %209 = zext i8 %205 to i195
  %210 = shl i195 %209, 91
  %211 = and i195 %208, -631349420035543940198553354241
  %.partset135 = or i195 %211, %210
  store i195 %.partset135, i195* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %212 = bitcast i195* %dst_1 to i200*
  %213 = load i200, i200* %212
  %214 = trunc i200 %213 to i195
  %215 = zext i8 %205 to i195
  %216 = shl i195 %215, 91
  %217 = and i195 %214, -631349420035543940198553354241
  %.partset80 = or i195 %217, %216
  store i195 %.partset80, i195* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.2:                              ; preds = %dst.addr.723.exit
  %218 = bitcast i195* %dst_2 to i200*
  %219 = load i200, i200* %218
  %220 = trunc i200 %219 to i195
  %221 = zext i8 %205 to i195
  %222 = shl i195 %221, 91
  %223 = and i195 %220, -631349420035543940198553354241
  %.partset63 = or i195 %223, %222
  store i195 %.partset63, i195* %dst_2, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.3:                              ; preds = %dst.addr.723.exit
  %224 = bitcast i195* %dst_3 to i200*
  %225 = load i200, i200* %224
  %226 = trunc i200 %225 to i195
  %227 = zext i8 %205 to i195
  %228 = shl i195 %227, 91
  %229 = and i195 %226, -631349420035543940198553354241
  %.partset8 = or i195 %229, %228
  store i195 %.partset8, i195* %dst_3, align 1
  br label %dst.addr.825.exit

dst.addr.825.exit:                                ; preds = %dst.addr.825.case.3, %dst.addr.825.case.2, %dst.addr.825.case.1, %dst.addr.825.case.0, %dst.addr.723.exit
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 9
  %230 = bitcast i1* %src.addr.926 to i8*
  %231 = load i8, i8* %230
  %232 = trunc i8 %231 to i1
  switch i64 %for.loop.idx81, label %dst.addr.927.exit [
    i64 0, label %dst.addr.927.case.0
    i64 1, label %dst.addr.927.case.1
    i64 2, label %dst.addr.927.case.2
    i64 3, label %dst.addr.927.case.3
  ]

dst.addr.927.case.0:                              ; preds = %dst.addr.825.exit
  %233 = bitcast i195* %dst_0 to i200*
  %234 = load i200, i200* %233
  %235 = trunc i200 %234 to i195
  %236 = zext i1 %232 to i195
  %237 = shl i195 %236, 99
  %238 = and i195 %235, -633825300114114700748351602689
  %.partset134 = or i195 %238, %237
  store i195 %.partset134, i195* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %239 = bitcast i195* %dst_1 to i200*
  %240 = load i200, i200* %239
  %241 = trunc i200 %240 to i195
  %242 = zext i1 %232 to i195
  %243 = shl i195 %242, 99
  %244 = and i195 %241, -633825300114114700748351602689
  %.partset81 = or i195 %244, %243
  store i195 %.partset81, i195* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.2:                              ; preds = %dst.addr.825.exit
  %245 = bitcast i195* %dst_2 to i200*
  %246 = load i200, i200* %245
  %247 = trunc i200 %246 to i195
  %248 = zext i1 %232 to i195
  %249 = shl i195 %248, 99
  %250 = and i195 %247, -633825300114114700748351602689
  %.partset62 = or i195 %250, %249
  store i195 %.partset62, i195* %dst_2, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.3:                              ; preds = %dst.addr.825.exit
  %251 = bitcast i195* %dst_3 to i200*
  %252 = load i200, i200* %251
  %253 = trunc i200 %252 to i195
  %254 = zext i1 %232 to i195
  %255 = shl i195 %254, 99
  %256 = and i195 %253, -633825300114114700748351602689
  %.partset9 = or i195 %256, %255
  store i195 %.partset9, i195* %dst_3, align 1
  br label %dst.addr.927.exit

dst.addr.927.exit:                                ; preds = %dst.addr.927.case.3, %dst.addr.927.case.2, %dst.addr.927.case.1, %dst.addr.927.case.0, %dst.addr.825.exit
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 10
  %257 = bitcast i1* %src.addr.1028 to i8*
  %258 = load i8, i8* %257
  %259 = trunc i8 %258 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1029.exit [
    i64 0, label %dst.addr.1029.case.0
    i64 1, label %dst.addr.1029.case.1
    i64 2, label %dst.addr.1029.case.2
    i64 3, label %dst.addr.1029.case.3
  ]

dst.addr.1029.case.0:                             ; preds = %dst.addr.927.exit
  %260 = bitcast i195* %dst_0 to i200*
  %261 = load i200, i200* %260
  %262 = trunc i200 %261 to i195
  %263 = zext i1 %259 to i195
  %264 = shl i195 %263, 100
  %265 = and i195 %262, -1267650600228229401496703205377
  %.partset133 = or i195 %265, %264
  store i195 %.partset133, i195* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %266 = bitcast i195* %dst_1 to i200*
  %267 = load i200, i200* %266
  %268 = trunc i200 %267 to i195
  %269 = zext i1 %259 to i195
  %270 = shl i195 %269, 100
  %271 = and i195 %268, -1267650600228229401496703205377
  %.partset82 = or i195 %271, %270
  store i195 %.partset82, i195* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.2:                             ; preds = %dst.addr.927.exit
  %272 = bitcast i195* %dst_2 to i200*
  %273 = load i200, i200* %272
  %274 = trunc i200 %273 to i195
  %275 = zext i1 %259 to i195
  %276 = shl i195 %275, 100
  %277 = and i195 %274, -1267650600228229401496703205377
  %.partset61 = or i195 %277, %276
  store i195 %.partset61, i195* %dst_2, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.3:                             ; preds = %dst.addr.927.exit
  %278 = bitcast i195* %dst_3 to i200*
  %279 = load i200, i200* %278
  %280 = trunc i200 %279 to i195
  %281 = zext i1 %259 to i195
  %282 = shl i195 %281, 100
  %283 = and i195 %280, -1267650600228229401496703205377
  %.partset10 = or i195 %283, %282
  store i195 %.partset10, i195* %dst_3, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.exit:                               ; preds = %dst.addr.1029.case.3, %dst.addr.1029.case.2, %dst.addr.1029.case.1, %dst.addr.1029.case.0, %dst.addr.927.exit
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 11
  %284 = load i8, i8* %src.addr.1130, align 1
  switch i64 %for.loop.idx81, label %dst.addr.1131.exit [
    i64 0, label %dst.addr.1131.case.0
    i64 1, label %dst.addr.1131.case.1
    i64 2, label %dst.addr.1131.case.2
    i64 3, label %dst.addr.1131.case.3
  ]

dst.addr.1131.case.0:                             ; preds = %dst.addr.1029.exit
  %285 = bitcast i195* %dst_0 to i200*
  %286 = load i200, i200* %285
  %287 = trunc i200 %286 to i195
  %288 = zext i8 %284 to i195
  %289 = shl i195 %288, 101
  %290 = and i195 %287, -646501806116396994763318634741761
  %.partset132 = or i195 %290, %289
  store i195 %.partset132, i195* %dst_0, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %291 = bitcast i195* %dst_1 to i200*
  %292 = load i200, i200* %291
  %293 = trunc i200 %292 to i195
  %294 = zext i8 %284 to i195
  %295 = shl i195 %294, 101
  %296 = and i195 %293, -646501806116396994763318634741761
  %.partset83 = or i195 %296, %295
  store i195 %.partset83, i195* %dst_1, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.2:                             ; preds = %dst.addr.1029.exit
  %297 = bitcast i195* %dst_2 to i200*
  %298 = load i200, i200* %297
  %299 = trunc i200 %298 to i195
  %300 = zext i8 %284 to i195
  %301 = shl i195 %300, 101
  %302 = and i195 %299, -646501806116396994763318634741761
  %.partset60 = or i195 %302, %301
  store i195 %.partset60, i195* %dst_2, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.3:                             ; preds = %dst.addr.1029.exit
  %303 = bitcast i195* %dst_3 to i200*
  %304 = load i200, i200* %303
  %305 = trunc i200 %304 to i195
  %306 = zext i8 %284 to i195
  %307 = shl i195 %306, 101
  %308 = and i195 %305, -646501806116396994763318634741761
  %.partset11 = or i195 %308, %307
  store i195 %.partset11, i195* %dst_3, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.exit:                               ; preds = %dst.addr.1131.case.3, %dst.addr.1131.case.2, %dst.addr.1131.case.1, %dst.addr.1131.case.0, %dst.addr.1029.exit
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 12
  %309 = load i32, i32* %src.addr.1232, align 4
  switch i64 %for.loop.idx81, label %dst.addr.1233.exit [
    i64 0, label %dst.addr.1233.case.0
    i64 1, label %dst.addr.1233.case.1
    i64 2, label %dst.addr.1233.case.2
    i64 3, label %dst.addr.1233.case.3
  ]

dst.addr.1233.case.0:                             ; preds = %dst.addr.1131.exit
  %310 = bitcast i195* %dst_0 to i200*
  %311 = load i200, i200* %310
  %312 = trunc i200 %311 to i195
  %313 = zext i32 %309 to i195
  %314 = shl i195 %313, 109
  %315 = and i195 %312, -2787593149167290785375111330514733147095041
  %.partset131 = or i195 %315, %314
  store i195 %.partset131, i195* %dst_0, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %316 = bitcast i195* %dst_1 to i200*
  %317 = load i200, i200* %316
  %318 = trunc i200 %317 to i195
  %319 = zext i32 %309 to i195
  %320 = shl i195 %319, 109
  %321 = and i195 %318, -2787593149167290785375111330514733147095041
  %.partset84 = or i195 %321, %320
  store i195 %.partset84, i195* %dst_1, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.2:                             ; preds = %dst.addr.1131.exit
  %322 = bitcast i195* %dst_2 to i200*
  %323 = load i200, i200* %322
  %324 = trunc i200 %323 to i195
  %325 = zext i32 %309 to i195
  %326 = shl i195 %325, 109
  %327 = and i195 %324, -2787593149167290785375111330514733147095041
  %.partset59 = or i195 %327, %326
  store i195 %.partset59, i195* %dst_2, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.3:                             ; preds = %dst.addr.1131.exit
  %328 = bitcast i195* %dst_3 to i200*
  %329 = load i200, i200* %328
  %330 = trunc i200 %329 to i195
  %331 = zext i32 %309 to i195
  %332 = shl i195 %331, 109
  %333 = and i195 %330, -2787593149167290785375111330514733147095041
  %.partset12 = or i195 %333, %332
  store i195 %.partset12, i195* %dst_3, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.exit:                               ; preds = %dst.addr.1233.case.3, %dst.addr.1233.case.2, %dst.addr.1233.case.1, %dst.addr.1233.case.0, %dst.addr.1131.exit
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 13
  %334 = load i32, i32* %src.addr.1334, align 4
  switch i64 %for.loop.idx81, label %dst.addr.1335.exit [
    i64 0, label %dst.addr.1335.case.0
    i64 1, label %dst.addr.1335.case.1
    i64 2, label %dst.addr.1335.case.2
    i64 3, label %dst.addr.1335.case.3
  ]

dst.addr.1335.case.0:                             ; preds = %dst.addr.1233.exit
  %335 = bitcast i195* %dst_0 to i200*
  %336 = load i200, i200* %335
  %337 = trunc i200 %336 to i195
  %338 = zext i32 %334 to i195
  %339 = shl i195 %338, 141
  %340 = and i195 %337, -11972621410227163556108258256919825712940354203811841
  %.partset130 = or i195 %340, %339
  store i195 %.partset130, i195* %dst_0, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %341 = bitcast i195* %dst_1 to i200*
  %342 = load i200, i200* %341
  %343 = trunc i200 %342 to i195
  %344 = zext i32 %334 to i195
  %345 = shl i195 %344, 141
  %346 = and i195 %343, -11972621410227163556108258256919825712940354203811841
  %.partset85 = or i195 %346, %345
  store i195 %.partset85, i195* %dst_1, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.2:                             ; preds = %dst.addr.1233.exit
  %347 = bitcast i195* %dst_2 to i200*
  %348 = load i200, i200* %347
  %349 = trunc i200 %348 to i195
  %350 = zext i32 %334 to i195
  %351 = shl i195 %350, 141
  %352 = and i195 %349, -11972621410227163556108258256919825712940354203811841
  %.partset58 = or i195 %352, %351
  store i195 %.partset58, i195* %dst_2, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.3:                             ; preds = %dst.addr.1233.exit
  %353 = bitcast i195* %dst_3 to i200*
  %354 = load i200, i200* %353
  %355 = trunc i200 %354 to i195
  %356 = zext i32 %334 to i195
  %357 = shl i195 %356, 141
  %358 = and i195 %355, -11972621410227163556108258256919825712940354203811841
  %.partset13 = or i195 %358, %357
  store i195 %.partset13, i195* %dst_3, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.exit:                               ; preds = %dst.addr.1335.case.3, %dst.addr.1335.case.2, %dst.addr.1335.case.1, %dst.addr.1335.case.0, %dst.addr.1233.exit
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 14
  %359 = bitcast i1* %src.addr.1436 to i8*
  %360 = load i8, i8* %359
  %361 = trunc i8 %360 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1437.exit [
    i64 0, label %dst.addr.1437.case.0
    i64 1, label %dst.addr.1437.case.1
    i64 2, label %dst.addr.1437.case.2
    i64 3, label %dst.addr.1437.case.3
  ]

dst.addr.1437.case.0:                             ; preds = %dst.addr.1335.exit
  %362 = bitcast i195* %dst_0 to i200*
  %363 = load i200, i200* %362
  %364 = trunc i200 %363 to i195
  %365 = zext i1 %361 to i195
  %366 = shl i195 %365, 173
  %367 = and i195 %364, -11972621413014756705924586149611790497021399392059393
  %.partset129 = or i195 %367, %366
  store i195 %.partset129, i195* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %368 = bitcast i195* %dst_1 to i200*
  %369 = load i200, i200* %368
  %370 = trunc i200 %369 to i195
  %371 = zext i1 %361 to i195
  %372 = shl i195 %371, 173
  %373 = and i195 %370, -11972621413014756705924586149611790497021399392059393
  %.partset86 = or i195 %373, %372
  store i195 %.partset86, i195* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.2:                             ; preds = %dst.addr.1335.exit
  %374 = bitcast i195* %dst_2 to i200*
  %375 = load i200, i200* %374
  %376 = trunc i200 %375 to i195
  %377 = zext i1 %361 to i195
  %378 = shl i195 %377, 173
  %379 = and i195 %376, -11972621413014756705924586149611790497021399392059393
  %.partset57 = or i195 %379, %378
  store i195 %.partset57, i195* %dst_2, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.3:                             ; preds = %dst.addr.1335.exit
  %380 = bitcast i195* %dst_3 to i200*
  %381 = load i200, i200* %380
  %382 = trunc i200 %381 to i195
  %383 = zext i1 %361 to i195
  %384 = shl i195 %383, 173
  %385 = and i195 %382, -11972621413014756705924586149611790497021399392059393
  %.partset14 = or i195 %385, %384
  store i195 %.partset14, i195* %dst_3, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.exit:                               ; preds = %dst.addr.1437.case.3, %dst.addr.1437.case.2, %dst.addr.1437.case.1, %dst.addr.1437.case.0, %dst.addr.1335.exit
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 15
  %386 = bitcast i1* %src.addr.1538 to i8*
  %387 = load i8, i8* %386
  %388 = trunc i8 %387 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1539.exit [
    i64 0, label %dst.addr.1539.case.0
    i64 1, label %dst.addr.1539.case.1
    i64 2, label %dst.addr.1539.case.2
    i64 3, label %dst.addr.1539.case.3
  ]

dst.addr.1539.case.0:                             ; preds = %dst.addr.1437.exit
  %389 = bitcast i195* %dst_0 to i200*
  %390 = load i200, i200* %389
  %391 = trunc i200 %390 to i195
  %392 = zext i1 %388 to i195
  %393 = shl i195 %392, 174
  %394 = and i195 %391, -23945242826029513411849172299223580994042798784118785
  %.partset128 = or i195 %394, %393
  store i195 %.partset128, i195* %dst_0, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %395 = bitcast i195* %dst_1 to i200*
  %396 = load i200, i200* %395
  %397 = trunc i200 %396 to i195
  %398 = zext i1 %388 to i195
  %399 = shl i195 %398, 174
  %400 = and i195 %397, -23945242826029513411849172299223580994042798784118785
  %.partset87 = or i195 %400, %399
  store i195 %.partset87, i195* %dst_1, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.2:                             ; preds = %dst.addr.1437.exit
  %401 = bitcast i195* %dst_2 to i200*
  %402 = load i200, i200* %401
  %403 = trunc i200 %402 to i195
  %404 = zext i1 %388 to i195
  %405 = shl i195 %404, 174
  %406 = and i195 %403, -23945242826029513411849172299223580994042798784118785
  %.partset56 = or i195 %406, %405
  store i195 %.partset56, i195* %dst_2, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.3:                             ; preds = %dst.addr.1437.exit
  %407 = bitcast i195* %dst_3 to i200*
  %408 = load i200, i200* %407
  %409 = trunc i200 %408 to i195
  %410 = zext i1 %388 to i195
  %411 = shl i195 %410, 174
  %412 = and i195 %409, -23945242826029513411849172299223580994042798784118785
  %.partset15 = or i195 %412, %411
  store i195 %.partset15, i195* %dst_3, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.exit:                               ; preds = %dst.addr.1539.case.3, %dst.addr.1539.case.2, %dst.addr.1539.case.1, %dst.addr.1539.case.0, %dst.addr.1437.exit
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 16
  %413 = bitcast i1* %src.addr.1640 to i8*
  %414 = load i8, i8* %413
  %415 = trunc i8 %414 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1641.exit [
    i64 0, label %dst.addr.1641.case.0
    i64 1, label %dst.addr.1641.case.1
    i64 2, label %dst.addr.1641.case.2
    i64 3, label %dst.addr.1641.case.3
  ]

dst.addr.1641.case.0:                             ; preds = %dst.addr.1539.exit
  %416 = bitcast i195* %dst_0 to i200*
  %417 = load i200, i200* %416
  %418 = trunc i200 %417 to i195
  %419 = zext i1 %415 to i195
  %420 = shl i195 %419, 175
  %421 = and i195 %418, -47890485652059026823698344598447161988085597568237569
  %.partset127 = or i195 %421, %420
  store i195 %.partset127, i195* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %422 = bitcast i195* %dst_1 to i200*
  %423 = load i200, i200* %422
  %424 = trunc i200 %423 to i195
  %425 = zext i1 %415 to i195
  %426 = shl i195 %425, 175
  %427 = and i195 %424, -47890485652059026823698344598447161988085597568237569
  %.partset88 = or i195 %427, %426
  store i195 %.partset88, i195* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.2:                             ; preds = %dst.addr.1539.exit
  %428 = bitcast i195* %dst_2 to i200*
  %429 = load i200, i200* %428
  %430 = trunc i200 %429 to i195
  %431 = zext i1 %415 to i195
  %432 = shl i195 %431, 175
  %433 = and i195 %430, -47890485652059026823698344598447161988085597568237569
  %.partset55 = or i195 %433, %432
  store i195 %.partset55, i195* %dst_2, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.3:                             ; preds = %dst.addr.1539.exit
  %434 = bitcast i195* %dst_3 to i200*
  %435 = load i200, i200* %434
  %436 = trunc i200 %435 to i195
  %437 = zext i1 %415 to i195
  %438 = shl i195 %437, 175
  %439 = and i195 %436, -47890485652059026823698344598447161988085597568237569
  %.partset16 = or i195 %439, %438
  store i195 %.partset16, i195* %dst_3, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.exit:                               ; preds = %dst.addr.1641.case.3, %dst.addr.1641.case.2, %dst.addr.1641.case.1, %dst.addr.1641.case.0, %dst.addr.1539.exit
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 17
  %440 = bitcast i1* %src.addr.1742 to i8*
  %441 = load i8, i8* %440
  %442 = trunc i8 %441 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1743.exit [
    i64 0, label %dst.addr.1743.case.0
    i64 1, label %dst.addr.1743.case.1
    i64 2, label %dst.addr.1743.case.2
    i64 3, label %dst.addr.1743.case.3
  ]

dst.addr.1743.case.0:                             ; preds = %dst.addr.1641.exit
  %443 = bitcast i195* %dst_0 to i200*
  %444 = load i200, i200* %443
  %445 = trunc i200 %444 to i195
  %446 = zext i1 %442 to i195
  %447 = shl i195 %446, 176
  %448 = and i195 %445, -95780971304118053647396689196894323976171195136475137
  %.partset126 = or i195 %448, %447
  store i195 %.partset126, i195* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %449 = bitcast i195* %dst_1 to i200*
  %450 = load i200, i200* %449
  %451 = trunc i200 %450 to i195
  %452 = zext i1 %442 to i195
  %453 = shl i195 %452, 176
  %454 = and i195 %451, -95780971304118053647396689196894323976171195136475137
  %.partset89 = or i195 %454, %453
  store i195 %.partset89, i195* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.2:                             ; preds = %dst.addr.1641.exit
  %455 = bitcast i195* %dst_2 to i200*
  %456 = load i200, i200* %455
  %457 = trunc i200 %456 to i195
  %458 = zext i1 %442 to i195
  %459 = shl i195 %458, 176
  %460 = and i195 %457, -95780971304118053647396689196894323976171195136475137
  %.partset54 = or i195 %460, %459
  store i195 %.partset54, i195* %dst_2, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.3:                             ; preds = %dst.addr.1641.exit
  %461 = bitcast i195* %dst_3 to i200*
  %462 = load i200, i200* %461
  %463 = trunc i200 %462 to i195
  %464 = zext i1 %442 to i195
  %465 = shl i195 %464, 176
  %466 = and i195 %463, -95780971304118053647396689196894323976171195136475137
  %.partset17 = or i195 %466, %465
  store i195 %.partset17, i195* %dst_3, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.exit:                               ; preds = %dst.addr.1743.case.3, %dst.addr.1743.case.2, %dst.addr.1743.case.1, %dst.addr.1743.case.0, %dst.addr.1641.exit
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 18
  %467 = bitcast i1* %src.addr.1844 to i8*
  %468 = load i8, i8* %467
  %469 = trunc i8 %468 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1845.exit [
    i64 0, label %dst.addr.1845.case.0
    i64 1, label %dst.addr.1845.case.1
    i64 2, label %dst.addr.1845.case.2
    i64 3, label %dst.addr.1845.case.3
  ]

dst.addr.1845.case.0:                             ; preds = %dst.addr.1743.exit
  %470 = bitcast i195* %dst_0 to i200*
  %471 = load i200, i200* %470
  %472 = trunc i200 %471 to i195
  %473 = zext i1 %469 to i195
  %474 = shl i195 %473, 177
  %475 = and i195 %472, -191561942608236107294793378393788647952342390272950273
  %.partset125 = or i195 %475, %474
  store i195 %.partset125, i195* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %476 = bitcast i195* %dst_1 to i200*
  %477 = load i200, i200* %476
  %478 = trunc i200 %477 to i195
  %479 = zext i1 %469 to i195
  %480 = shl i195 %479, 177
  %481 = and i195 %478, -191561942608236107294793378393788647952342390272950273
  %.partset90 = or i195 %481, %480
  store i195 %.partset90, i195* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.2:                             ; preds = %dst.addr.1743.exit
  %482 = bitcast i195* %dst_2 to i200*
  %483 = load i200, i200* %482
  %484 = trunc i200 %483 to i195
  %485 = zext i1 %469 to i195
  %486 = shl i195 %485, 177
  %487 = and i195 %484, -191561942608236107294793378393788647952342390272950273
  %.partset53 = or i195 %487, %486
  store i195 %.partset53, i195* %dst_2, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.3:                             ; preds = %dst.addr.1743.exit
  %488 = bitcast i195* %dst_3 to i200*
  %489 = load i200, i200* %488
  %490 = trunc i200 %489 to i195
  %491 = zext i1 %469 to i195
  %492 = shl i195 %491, 177
  %493 = and i195 %490, -191561942608236107294793378393788647952342390272950273
  %.partset18 = or i195 %493, %492
  store i195 %.partset18, i195* %dst_3, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.exit:                               ; preds = %dst.addr.1845.case.3, %dst.addr.1845.case.2, %dst.addr.1845.case.1, %dst.addr.1845.case.0, %dst.addr.1743.exit
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 19
  %494 = bitcast i1* %src.addr.1946 to i8*
  %495 = load i8, i8* %494
  %496 = trunc i8 %495 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1947.exit [
    i64 0, label %dst.addr.1947.case.0
    i64 1, label %dst.addr.1947.case.1
    i64 2, label %dst.addr.1947.case.2
    i64 3, label %dst.addr.1947.case.3
  ]

dst.addr.1947.case.0:                             ; preds = %dst.addr.1845.exit
  %497 = bitcast i195* %dst_0 to i200*
  %498 = load i200, i200* %497
  %499 = trunc i200 %498 to i195
  %500 = zext i1 %496 to i195
  %501 = shl i195 %500, 178
  %502 = and i195 %499, -383123885216472214589586756787577295904684780545900545
  %.partset124 = or i195 %502, %501
  store i195 %.partset124, i195* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %503 = bitcast i195* %dst_1 to i200*
  %504 = load i200, i200* %503
  %505 = trunc i200 %504 to i195
  %506 = zext i1 %496 to i195
  %507 = shl i195 %506, 178
  %508 = and i195 %505, -383123885216472214589586756787577295904684780545900545
  %.partset91 = or i195 %508, %507
  store i195 %.partset91, i195* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.2:                             ; preds = %dst.addr.1845.exit
  %509 = bitcast i195* %dst_2 to i200*
  %510 = load i200, i200* %509
  %511 = trunc i200 %510 to i195
  %512 = zext i1 %496 to i195
  %513 = shl i195 %512, 178
  %514 = and i195 %511, -383123885216472214589586756787577295904684780545900545
  %.partset52 = or i195 %514, %513
  store i195 %.partset52, i195* %dst_2, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.3:                             ; preds = %dst.addr.1845.exit
  %515 = bitcast i195* %dst_3 to i200*
  %516 = load i200, i200* %515
  %517 = trunc i200 %516 to i195
  %518 = zext i1 %496 to i195
  %519 = shl i195 %518, 178
  %520 = and i195 %517, -383123885216472214589586756787577295904684780545900545
  %.partset19 = or i195 %520, %519
  store i195 %.partset19, i195* %dst_3, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.exit:                               ; preds = %dst.addr.1947.case.3, %dst.addr.1947.case.2, %dst.addr.1947.case.1, %dst.addr.1947.case.0, %dst.addr.1845.exit
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 20
  %521 = bitcast i1* %src.addr.2048 to i8*
  %522 = load i8, i8* %521
  %523 = trunc i8 %522 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2049.exit [
    i64 0, label %dst.addr.2049.case.0
    i64 1, label %dst.addr.2049.case.1
    i64 2, label %dst.addr.2049.case.2
    i64 3, label %dst.addr.2049.case.3
  ]

dst.addr.2049.case.0:                             ; preds = %dst.addr.1947.exit
  %524 = bitcast i195* %dst_0 to i200*
  %525 = load i200, i200* %524
  %526 = trunc i200 %525 to i195
  %527 = zext i1 %523 to i195
  %528 = shl i195 %527, 179
  %529 = and i195 %526, -766247770432944429179173513575154591809369561091801089
  %.partset123 = or i195 %529, %528
  store i195 %.partset123, i195* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %530 = bitcast i195* %dst_1 to i200*
  %531 = load i200, i200* %530
  %532 = trunc i200 %531 to i195
  %533 = zext i1 %523 to i195
  %534 = shl i195 %533, 179
  %535 = and i195 %532, -766247770432944429179173513575154591809369561091801089
  %.partset92 = or i195 %535, %534
  store i195 %.partset92, i195* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.2:                             ; preds = %dst.addr.1947.exit
  %536 = bitcast i195* %dst_2 to i200*
  %537 = load i200, i200* %536
  %538 = trunc i200 %537 to i195
  %539 = zext i1 %523 to i195
  %540 = shl i195 %539, 179
  %541 = and i195 %538, -766247770432944429179173513575154591809369561091801089
  %.partset51 = or i195 %541, %540
  store i195 %.partset51, i195* %dst_2, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.3:                             ; preds = %dst.addr.1947.exit
  %542 = bitcast i195* %dst_3 to i200*
  %543 = load i200, i200* %542
  %544 = trunc i200 %543 to i195
  %545 = zext i1 %523 to i195
  %546 = shl i195 %545, 179
  %547 = and i195 %544, -766247770432944429179173513575154591809369561091801089
  %.partset20 = or i195 %547, %546
  store i195 %.partset20, i195* %dst_3, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.exit:                               ; preds = %dst.addr.2049.case.3, %dst.addr.2049.case.2, %dst.addr.2049.case.1, %dst.addr.2049.case.0, %dst.addr.1947.exit
  %src.addr.2150 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 21
  %548 = bitcast i1* %src.addr.2150 to i8*
  %549 = load i8, i8* %548
  %550 = trunc i8 %549 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2151.exit [
    i64 0, label %dst.addr.2151.case.0
    i64 1, label %dst.addr.2151.case.1
    i64 2, label %dst.addr.2151.case.2
    i64 3, label %dst.addr.2151.case.3
  ]

dst.addr.2151.case.0:                             ; preds = %dst.addr.2049.exit
  %551 = bitcast i195* %dst_0 to i200*
  %552 = load i200, i200* %551
  %553 = trunc i200 %552 to i195
  %554 = zext i1 %550 to i195
  %555 = shl i195 %554, 180
  %556 = and i195 %553, -1532495540865888858358347027150309183618739122183602177
  %.partset122 = or i195 %556, %555
  store i195 %.partset122, i195* %dst_0, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.1:                             ; preds = %dst.addr.2049.exit
  %557 = bitcast i195* %dst_1 to i200*
  %558 = load i200, i200* %557
  %559 = trunc i200 %558 to i195
  %560 = zext i1 %550 to i195
  %561 = shl i195 %560, 180
  %562 = and i195 %559, -1532495540865888858358347027150309183618739122183602177
  %.partset93 = or i195 %562, %561
  store i195 %.partset93, i195* %dst_1, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.2:                             ; preds = %dst.addr.2049.exit
  %563 = bitcast i195* %dst_2 to i200*
  %564 = load i200, i200* %563
  %565 = trunc i200 %564 to i195
  %566 = zext i1 %550 to i195
  %567 = shl i195 %566, 180
  %568 = and i195 %565, -1532495540865888858358347027150309183618739122183602177
  %.partset50 = or i195 %568, %567
  store i195 %.partset50, i195* %dst_2, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.3:                             ; preds = %dst.addr.2049.exit
  %569 = bitcast i195* %dst_3 to i200*
  %570 = load i200, i200* %569
  %571 = trunc i200 %570 to i195
  %572 = zext i1 %550 to i195
  %573 = shl i195 %572, 180
  %574 = and i195 %571, -1532495540865888858358347027150309183618739122183602177
  %.partset21 = or i195 %574, %573
  store i195 %.partset21, i195* %dst_3, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.exit:                               ; preds = %dst.addr.2151.case.3, %dst.addr.2151.case.2, %dst.addr.2151.case.1, %dst.addr.2151.case.0, %dst.addr.2049.exit
  %src.addr.2252 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 22
  %575 = bitcast i1* %src.addr.2252 to i8*
  %576 = load i8, i8* %575
  %577 = trunc i8 %576 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2253.exit [
    i64 0, label %dst.addr.2253.case.0
    i64 1, label %dst.addr.2253.case.1
    i64 2, label %dst.addr.2253.case.2
    i64 3, label %dst.addr.2253.case.3
  ]

dst.addr.2253.case.0:                             ; preds = %dst.addr.2151.exit
  %578 = bitcast i195* %dst_0 to i200*
  %579 = load i200, i200* %578
  %580 = trunc i200 %579 to i195
  %581 = zext i1 %577 to i195
  %582 = shl i195 %581, 181
  %583 = and i195 %580, -3064991081731777716716694054300618367237478244367204353
  %.partset121 = or i195 %583, %582
  store i195 %.partset121, i195* %dst_0, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.1:                             ; preds = %dst.addr.2151.exit
  %584 = bitcast i195* %dst_1 to i200*
  %585 = load i200, i200* %584
  %586 = trunc i200 %585 to i195
  %587 = zext i1 %577 to i195
  %588 = shl i195 %587, 181
  %589 = and i195 %586, -3064991081731777716716694054300618367237478244367204353
  %.partset94 = or i195 %589, %588
  store i195 %.partset94, i195* %dst_1, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.2:                             ; preds = %dst.addr.2151.exit
  %590 = bitcast i195* %dst_2 to i200*
  %591 = load i200, i200* %590
  %592 = trunc i200 %591 to i195
  %593 = zext i1 %577 to i195
  %594 = shl i195 %593, 181
  %595 = and i195 %592, -3064991081731777716716694054300618367237478244367204353
  %.partset49 = or i195 %595, %594
  store i195 %.partset49, i195* %dst_2, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.3:                             ; preds = %dst.addr.2151.exit
  %596 = bitcast i195* %dst_3 to i200*
  %597 = load i200, i200* %596
  %598 = trunc i200 %597 to i195
  %599 = zext i1 %577 to i195
  %600 = shl i195 %599, 181
  %601 = and i195 %598, -3064991081731777716716694054300618367237478244367204353
  %.partset22 = or i195 %601, %600
  store i195 %.partset22, i195* %dst_3, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.exit:                               ; preds = %dst.addr.2253.case.3, %dst.addr.2253.case.2, %dst.addr.2253.case.1, %dst.addr.2253.case.0, %dst.addr.2151.exit
  %src.addr.2354 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 23
  %602 = bitcast i1* %src.addr.2354 to i8*
  %603 = load i8, i8* %602
  %604 = trunc i8 %603 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2355.exit [
    i64 0, label %dst.addr.2355.case.0
    i64 1, label %dst.addr.2355.case.1
    i64 2, label %dst.addr.2355.case.2
    i64 3, label %dst.addr.2355.case.3
  ]

dst.addr.2355.case.0:                             ; preds = %dst.addr.2253.exit
  %605 = bitcast i195* %dst_0 to i200*
  %606 = load i200, i200* %605
  %607 = trunc i200 %606 to i195
  %608 = zext i1 %604 to i195
  %609 = shl i195 %608, 182
  %610 = and i195 %607, -6129982163463555433433388108601236734474956488734408705
  %.partset120 = or i195 %610, %609
  store i195 %.partset120, i195* %dst_0, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.1:                             ; preds = %dst.addr.2253.exit
  %611 = bitcast i195* %dst_1 to i200*
  %612 = load i200, i200* %611
  %613 = trunc i200 %612 to i195
  %614 = zext i1 %604 to i195
  %615 = shl i195 %614, 182
  %616 = and i195 %613, -6129982163463555433433388108601236734474956488734408705
  %.partset95 = or i195 %616, %615
  store i195 %.partset95, i195* %dst_1, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.2:                             ; preds = %dst.addr.2253.exit
  %617 = bitcast i195* %dst_2 to i200*
  %618 = load i200, i200* %617
  %619 = trunc i200 %618 to i195
  %620 = zext i1 %604 to i195
  %621 = shl i195 %620, 182
  %622 = and i195 %619, -6129982163463555433433388108601236734474956488734408705
  %.partset48 = or i195 %622, %621
  store i195 %.partset48, i195* %dst_2, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.3:                             ; preds = %dst.addr.2253.exit
  %623 = bitcast i195* %dst_3 to i200*
  %624 = load i200, i200* %623
  %625 = trunc i200 %624 to i195
  %626 = zext i1 %604 to i195
  %627 = shl i195 %626, 182
  %628 = and i195 %625, -6129982163463555433433388108601236734474956488734408705
  %.partset23 = or i195 %628, %627
  store i195 %.partset23, i195* %dst_3, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.exit:                               ; preds = %dst.addr.2355.case.3, %dst.addr.2355.case.2, %dst.addr.2355.case.1, %dst.addr.2355.case.0, %dst.addr.2253.exit
  %src.addr.2456 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 24
  %629 = bitcast i1* %src.addr.2456 to i8*
  %630 = load i8, i8* %629
  %631 = trunc i8 %630 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2457.exit [
    i64 0, label %dst.addr.2457.case.0
    i64 1, label %dst.addr.2457.case.1
    i64 2, label %dst.addr.2457.case.2
    i64 3, label %dst.addr.2457.case.3
  ]

dst.addr.2457.case.0:                             ; preds = %dst.addr.2355.exit
  %632 = bitcast i195* %dst_0 to i200*
  %633 = load i200, i200* %632
  %634 = trunc i200 %633 to i195
  %635 = zext i1 %631 to i195
  %636 = shl i195 %635, 183
  %637 = and i195 %634, -12259964326927110866866776217202473468949912977468817409
  %.partset119 = or i195 %637, %636
  store i195 %.partset119, i195* %dst_0, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.1:                             ; preds = %dst.addr.2355.exit
  %638 = bitcast i195* %dst_1 to i200*
  %639 = load i200, i200* %638
  %640 = trunc i200 %639 to i195
  %641 = zext i1 %631 to i195
  %642 = shl i195 %641, 183
  %643 = and i195 %640, -12259964326927110866866776217202473468949912977468817409
  %.partset96 = or i195 %643, %642
  store i195 %.partset96, i195* %dst_1, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.2:                             ; preds = %dst.addr.2355.exit
  %644 = bitcast i195* %dst_2 to i200*
  %645 = load i200, i200* %644
  %646 = trunc i200 %645 to i195
  %647 = zext i1 %631 to i195
  %648 = shl i195 %647, 183
  %649 = and i195 %646, -12259964326927110866866776217202473468949912977468817409
  %.partset47 = or i195 %649, %648
  store i195 %.partset47, i195* %dst_2, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.3:                             ; preds = %dst.addr.2355.exit
  %650 = bitcast i195* %dst_3 to i200*
  %651 = load i200, i200* %650
  %652 = trunc i200 %651 to i195
  %653 = zext i1 %631 to i195
  %654 = shl i195 %653, 183
  %655 = and i195 %652, -12259964326927110866866776217202473468949912977468817409
  %.partset24 = or i195 %655, %654
  store i195 %.partset24, i195* %dst_3, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.exit:                               ; preds = %dst.addr.2457.case.3, %dst.addr.2457.case.2, %dst.addr.2457.case.1, %dst.addr.2457.case.0, %dst.addr.2355.exit
  %src.addr.2558 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 25
  %656 = bitcast i1* %src.addr.2558 to i8*
  %657 = load i8, i8* %656
  %658 = trunc i8 %657 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2559.exit [
    i64 0, label %dst.addr.2559.case.0
    i64 1, label %dst.addr.2559.case.1
    i64 2, label %dst.addr.2559.case.2
    i64 3, label %dst.addr.2559.case.3
  ]

dst.addr.2559.case.0:                             ; preds = %dst.addr.2457.exit
  %659 = bitcast i195* %dst_0 to i200*
  %660 = load i200, i200* %659
  %661 = trunc i200 %660 to i195
  %662 = zext i1 %658 to i195
  %663 = shl i195 %662, 184
  %664 = and i195 %661, -24519928653854221733733552434404946937899825954937634817
  %.partset118 = or i195 %664, %663
  store i195 %.partset118, i195* %dst_0, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.1:                             ; preds = %dst.addr.2457.exit
  %665 = bitcast i195* %dst_1 to i200*
  %666 = load i200, i200* %665
  %667 = trunc i200 %666 to i195
  %668 = zext i1 %658 to i195
  %669 = shl i195 %668, 184
  %670 = and i195 %667, -24519928653854221733733552434404946937899825954937634817
  %.partset97 = or i195 %670, %669
  store i195 %.partset97, i195* %dst_1, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.2:                             ; preds = %dst.addr.2457.exit
  %671 = bitcast i195* %dst_2 to i200*
  %672 = load i200, i200* %671
  %673 = trunc i200 %672 to i195
  %674 = zext i1 %658 to i195
  %675 = shl i195 %674, 184
  %676 = and i195 %673, -24519928653854221733733552434404946937899825954937634817
  %.partset46 = or i195 %676, %675
  store i195 %.partset46, i195* %dst_2, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.3:                             ; preds = %dst.addr.2457.exit
  %677 = bitcast i195* %dst_3 to i200*
  %678 = load i200, i200* %677
  %679 = trunc i200 %678 to i195
  %680 = zext i1 %658 to i195
  %681 = shl i195 %680, 184
  %682 = and i195 %679, -24519928653854221733733552434404946937899825954937634817
  %.partset25 = or i195 %682, %681
  store i195 %.partset25, i195* %dst_3, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.exit:                               ; preds = %dst.addr.2559.case.3, %dst.addr.2559.case.2, %dst.addr.2559.case.1, %dst.addr.2559.case.0, %dst.addr.2457.exit
  %src.addr.2660 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 26
  %683 = bitcast i1* %src.addr.2660 to i8*
  %684 = load i8, i8* %683
  %685 = trunc i8 %684 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2661.exit [
    i64 0, label %dst.addr.2661.case.0
    i64 1, label %dst.addr.2661.case.1
    i64 2, label %dst.addr.2661.case.2
    i64 3, label %dst.addr.2661.case.3
  ]

dst.addr.2661.case.0:                             ; preds = %dst.addr.2559.exit
  %686 = bitcast i195* %dst_0 to i200*
  %687 = load i200, i200* %686
  %688 = trunc i200 %687 to i195
  %689 = zext i1 %685 to i195
  %690 = shl i195 %689, 185
  %691 = and i195 %688, -49039857307708443467467104868809893875799651909875269633
  %.partset117 = or i195 %691, %690
  store i195 %.partset117, i195* %dst_0, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.1:                             ; preds = %dst.addr.2559.exit
  %692 = bitcast i195* %dst_1 to i200*
  %693 = load i200, i200* %692
  %694 = trunc i200 %693 to i195
  %695 = zext i1 %685 to i195
  %696 = shl i195 %695, 185
  %697 = and i195 %694, -49039857307708443467467104868809893875799651909875269633
  %.partset98 = or i195 %697, %696
  store i195 %.partset98, i195* %dst_1, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.2:                             ; preds = %dst.addr.2559.exit
  %698 = bitcast i195* %dst_2 to i200*
  %699 = load i200, i200* %698
  %700 = trunc i200 %699 to i195
  %701 = zext i1 %685 to i195
  %702 = shl i195 %701, 185
  %703 = and i195 %700, -49039857307708443467467104868809893875799651909875269633
  %.partset45 = or i195 %703, %702
  store i195 %.partset45, i195* %dst_2, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.3:                             ; preds = %dst.addr.2559.exit
  %704 = bitcast i195* %dst_3 to i200*
  %705 = load i200, i200* %704
  %706 = trunc i200 %705 to i195
  %707 = zext i1 %685 to i195
  %708 = shl i195 %707, 185
  %709 = and i195 %706, -49039857307708443467467104868809893875799651909875269633
  %.partset26 = or i195 %709, %708
  store i195 %.partset26, i195* %dst_3, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.exit:                               ; preds = %dst.addr.2661.case.3, %dst.addr.2661.case.2, %dst.addr.2661.case.1, %dst.addr.2661.case.0, %dst.addr.2559.exit
  %src.addr.2762 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 27
  %710 = bitcast i1* %src.addr.2762 to i8*
  %711 = load i8, i8* %710
  %712 = trunc i8 %711 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2763.exit [
    i64 0, label %dst.addr.2763.case.0
    i64 1, label %dst.addr.2763.case.1
    i64 2, label %dst.addr.2763.case.2
    i64 3, label %dst.addr.2763.case.3
  ]

dst.addr.2763.case.0:                             ; preds = %dst.addr.2661.exit
  %713 = bitcast i195* %dst_0 to i200*
  %714 = load i200, i200* %713
  %715 = trunc i200 %714 to i195
  %716 = zext i1 %712 to i195
  %717 = shl i195 %716, 186
  %718 = and i195 %715, -98079714615416886934934209737619787751599303819750539265
  %.partset116 = or i195 %718, %717
  store i195 %.partset116, i195* %dst_0, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.1:                             ; preds = %dst.addr.2661.exit
  %719 = bitcast i195* %dst_1 to i200*
  %720 = load i200, i200* %719
  %721 = trunc i200 %720 to i195
  %722 = zext i1 %712 to i195
  %723 = shl i195 %722, 186
  %724 = and i195 %721, -98079714615416886934934209737619787751599303819750539265
  %.partset99 = or i195 %724, %723
  store i195 %.partset99, i195* %dst_1, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.2:                             ; preds = %dst.addr.2661.exit
  %725 = bitcast i195* %dst_2 to i200*
  %726 = load i200, i200* %725
  %727 = trunc i200 %726 to i195
  %728 = zext i1 %712 to i195
  %729 = shl i195 %728, 186
  %730 = and i195 %727, -98079714615416886934934209737619787751599303819750539265
  %.partset44 = or i195 %730, %729
  store i195 %.partset44, i195* %dst_2, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.3:                             ; preds = %dst.addr.2661.exit
  %731 = bitcast i195* %dst_3 to i200*
  %732 = load i200, i200* %731
  %733 = trunc i200 %732 to i195
  %734 = zext i1 %712 to i195
  %735 = shl i195 %734, 186
  %736 = and i195 %733, -98079714615416886934934209737619787751599303819750539265
  %.partset27 = or i195 %736, %735
  store i195 %.partset27, i195* %dst_3, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.exit:                               ; preds = %dst.addr.2763.case.3, %dst.addr.2763.case.2, %dst.addr.2763.case.1, %dst.addr.2763.case.0, %dst.addr.2661.exit
  %src.addr.2864 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 28
  %737 = bitcast i1* %src.addr.2864 to i8*
  %738 = load i8, i8* %737
  %739 = trunc i8 %738 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2865.exit [
    i64 0, label %dst.addr.2865.case.0
    i64 1, label %dst.addr.2865.case.1
    i64 2, label %dst.addr.2865.case.2
    i64 3, label %dst.addr.2865.case.3
  ]

dst.addr.2865.case.0:                             ; preds = %dst.addr.2763.exit
  %740 = bitcast i195* %dst_0 to i200*
  %741 = load i200, i200* %740
  %742 = trunc i200 %741 to i195
  %743 = zext i1 %739 to i195
  %744 = shl i195 %743, 187
  %745 = and i195 %742, -196159429230833773869868419475239575503198607639501078529
  %.partset115 = or i195 %745, %744
  store i195 %.partset115, i195* %dst_0, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.1:                             ; preds = %dst.addr.2763.exit
  %746 = bitcast i195* %dst_1 to i200*
  %747 = load i200, i200* %746
  %748 = trunc i200 %747 to i195
  %749 = zext i1 %739 to i195
  %750 = shl i195 %749, 187
  %751 = and i195 %748, -196159429230833773869868419475239575503198607639501078529
  %.partset100 = or i195 %751, %750
  store i195 %.partset100, i195* %dst_1, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.2:                             ; preds = %dst.addr.2763.exit
  %752 = bitcast i195* %dst_2 to i200*
  %753 = load i200, i200* %752
  %754 = trunc i200 %753 to i195
  %755 = zext i1 %739 to i195
  %756 = shl i195 %755, 187
  %757 = and i195 %754, -196159429230833773869868419475239575503198607639501078529
  %.partset43 = or i195 %757, %756
  store i195 %.partset43, i195* %dst_2, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.3:                             ; preds = %dst.addr.2763.exit
  %758 = bitcast i195* %dst_3 to i200*
  %759 = load i200, i200* %758
  %760 = trunc i200 %759 to i195
  %761 = zext i1 %739 to i195
  %762 = shl i195 %761, 187
  %763 = and i195 %760, -196159429230833773869868419475239575503198607639501078529
  %.partset28 = or i195 %763, %762
  store i195 %.partset28, i195* %dst_3, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.exit:                               ; preds = %dst.addr.2865.case.3, %dst.addr.2865.case.2, %dst.addr.2865.case.1, %dst.addr.2865.case.0, %dst.addr.2763.exit
  %src.addr.2966 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 29
  %764 = bitcast i1* %src.addr.2966 to i8*
  %765 = load i8, i8* %764
  %766 = trunc i8 %765 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2967.exit [
    i64 0, label %dst.addr.2967.case.0
    i64 1, label %dst.addr.2967.case.1
    i64 2, label %dst.addr.2967.case.2
    i64 3, label %dst.addr.2967.case.3
  ]

dst.addr.2967.case.0:                             ; preds = %dst.addr.2865.exit
  %767 = bitcast i195* %dst_0 to i200*
  %768 = load i200, i200* %767
  %769 = trunc i200 %768 to i195
  %770 = zext i1 %766 to i195
  %771 = shl i195 %770, 188
  %772 = and i195 %769, -392318858461667547739736838950479151006397215279002157057
  %.partset114 = or i195 %772, %771
  store i195 %.partset114, i195* %dst_0, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.1:                             ; preds = %dst.addr.2865.exit
  %773 = bitcast i195* %dst_1 to i200*
  %774 = load i200, i200* %773
  %775 = trunc i200 %774 to i195
  %776 = zext i1 %766 to i195
  %777 = shl i195 %776, 188
  %778 = and i195 %775, -392318858461667547739736838950479151006397215279002157057
  %.partset101 = or i195 %778, %777
  store i195 %.partset101, i195* %dst_1, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.2:                             ; preds = %dst.addr.2865.exit
  %779 = bitcast i195* %dst_2 to i200*
  %780 = load i200, i200* %779
  %781 = trunc i200 %780 to i195
  %782 = zext i1 %766 to i195
  %783 = shl i195 %782, 188
  %784 = and i195 %781, -392318858461667547739736838950479151006397215279002157057
  %.partset42 = or i195 %784, %783
  store i195 %.partset42, i195* %dst_2, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.3:                             ; preds = %dst.addr.2865.exit
  %785 = bitcast i195* %dst_3 to i200*
  %786 = load i200, i200* %785
  %787 = trunc i200 %786 to i195
  %788 = zext i1 %766 to i195
  %789 = shl i195 %788, 188
  %790 = and i195 %787, -392318858461667547739736838950479151006397215279002157057
  %.partset29 = or i195 %790, %789
  store i195 %.partset29, i195* %dst_3, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.exit:                               ; preds = %dst.addr.2967.case.3, %dst.addr.2967.case.2, %dst.addr.2967.case.1, %dst.addr.2967.case.0, %dst.addr.2865.exit
  %src.addr.3068 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 30
  %791 = bitcast i1* %src.addr.3068 to i8*
  %792 = load i8, i8* %791
  %793 = trunc i8 %792 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3069.exit [
    i64 0, label %dst.addr.3069.case.0
    i64 1, label %dst.addr.3069.case.1
    i64 2, label %dst.addr.3069.case.2
    i64 3, label %dst.addr.3069.case.3
  ]

dst.addr.3069.case.0:                             ; preds = %dst.addr.2967.exit
  %794 = bitcast i195* %dst_0 to i200*
  %795 = load i200, i200* %794
  %796 = trunc i200 %795 to i195
  %797 = zext i1 %793 to i195
  %798 = shl i195 %797, 189
  %799 = and i195 %796, -784637716923335095479473677900958302012794430558004314113
  %.partset113 = or i195 %799, %798
  store i195 %.partset113, i195* %dst_0, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.1:                             ; preds = %dst.addr.2967.exit
  %800 = bitcast i195* %dst_1 to i200*
  %801 = load i200, i200* %800
  %802 = trunc i200 %801 to i195
  %803 = zext i1 %793 to i195
  %804 = shl i195 %803, 189
  %805 = and i195 %802, -784637716923335095479473677900958302012794430558004314113
  %.partset102 = or i195 %805, %804
  store i195 %.partset102, i195* %dst_1, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.2:                             ; preds = %dst.addr.2967.exit
  %806 = bitcast i195* %dst_2 to i200*
  %807 = load i200, i200* %806
  %808 = trunc i200 %807 to i195
  %809 = zext i1 %793 to i195
  %810 = shl i195 %809, 189
  %811 = and i195 %808, -784637716923335095479473677900958302012794430558004314113
  %.partset41 = or i195 %811, %810
  store i195 %.partset41, i195* %dst_2, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.3:                             ; preds = %dst.addr.2967.exit
  %812 = bitcast i195* %dst_3 to i200*
  %813 = load i200, i200* %812
  %814 = trunc i200 %813 to i195
  %815 = zext i1 %793 to i195
  %816 = shl i195 %815, 189
  %817 = and i195 %814, -784637716923335095479473677900958302012794430558004314113
  %.partset30 = or i195 %817, %816
  store i195 %.partset30, i195* %dst_3, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.exit:                               ; preds = %dst.addr.3069.case.3, %dst.addr.3069.case.2, %dst.addr.3069.case.1, %dst.addr.3069.case.0, %dst.addr.2967.exit
  %src.addr.3170 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 31
  %818 = bitcast i1* %src.addr.3170 to i8*
  %819 = load i8, i8* %818
  %820 = trunc i8 %819 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3171.exit [
    i64 0, label %dst.addr.3171.case.0
    i64 1, label %dst.addr.3171.case.1
    i64 2, label %dst.addr.3171.case.2
    i64 3, label %dst.addr.3171.case.3
  ]

dst.addr.3171.case.0:                             ; preds = %dst.addr.3069.exit
  %821 = bitcast i195* %dst_0 to i200*
  %822 = load i200, i200* %821
  %823 = trunc i200 %822 to i195
  %824 = zext i1 %820 to i195
  %825 = shl i195 %824, 190
  %826 = and i195 %823, -1569275433846670190958947355801916604025588861116008628225
  %.partset112 = or i195 %826, %825
  store i195 %.partset112, i195* %dst_0, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.1:                             ; preds = %dst.addr.3069.exit
  %827 = bitcast i195* %dst_1 to i200*
  %828 = load i200, i200* %827
  %829 = trunc i200 %828 to i195
  %830 = zext i1 %820 to i195
  %831 = shl i195 %830, 190
  %832 = and i195 %829, -1569275433846670190958947355801916604025588861116008628225
  %.partset103 = or i195 %832, %831
  store i195 %.partset103, i195* %dst_1, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.2:                             ; preds = %dst.addr.3069.exit
  %833 = bitcast i195* %dst_2 to i200*
  %834 = load i200, i200* %833
  %835 = trunc i200 %834 to i195
  %836 = zext i1 %820 to i195
  %837 = shl i195 %836, 190
  %838 = and i195 %835, -1569275433846670190958947355801916604025588861116008628225
  %.partset40 = or i195 %838, %837
  store i195 %.partset40, i195* %dst_2, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.3:                             ; preds = %dst.addr.3069.exit
  %839 = bitcast i195* %dst_3 to i200*
  %840 = load i200, i200* %839
  %841 = trunc i200 %840 to i195
  %842 = zext i1 %820 to i195
  %843 = shl i195 %842, 190
  %844 = and i195 %841, -1569275433846670190958947355801916604025588861116008628225
  %.partset31 = or i195 %844, %843
  store i195 %.partset31, i195* %dst_3, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.exit:                               ; preds = %dst.addr.3171.case.3, %dst.addr.3171.case.2, %dst.addr.3171.case.1, %dst.addr.3171.case.0, %dst.addr.3069.exit
  %src.addr.3272 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 32
  %845 = bitcast i1* %src.addr.3272 to i8*
  %846 = load i8, i8* %845
  %847 = trunc i8 %846 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3273.exit [
    i64 0, label %dst.addr.3273.case.0
    i64 1, label %dst.addr.3273.case.1
    i64 2, label %dst.addr.3273.case.2
    i64 3, label %dst.addr.3273.case.3
  ]

dst.addr.3273.case.0:                             ; preds = %dst.addr.3171.exit
  %848 = bitcast i195* %dst_0 to i200*
  %849 = load i200, i200* %848
  %850 = trunc i200 %849 to i195
  %851 = zext i1 %847 to i195
  %852 = shl i195 %851, 191
  %853 = and i195 %850, -3138550867693340381917894711603833208051177722232017256449
  %.partset111 = or i195 %853, %852
  store i195 %.partset111, i195* %dst_0, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.1:                             ; preds = %dst.addr.3171.exit
  %854 = bitcast i195* %dst_1 to i200*
  %855 = load i200, i200* %854
  %856 = trunc i200 %855 to i195
  %857 = zext i1 %847 to i195
  %858 = shl i195 %857, 191
  %859 = and i195 %856, -3138550867693340381917894711603833208051177722232017256449
  %.partset104 = or i195 %859, %858
  store i195 %.partset104, i195* %dst_1, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.2:                             ; preds = %dst.addr.3171.exit
  %860 = bitcast i195* %dst_2 to i200*
  %861 = load i200, i200* %860
  %862 = trunc i200 %861 to i195
  %863 = zext i1 %847 to i195
  %864 = shl i195 %863, 191
  %865 = and i195 %862, -3138550867693340381917894711603833208051177722232017256449
  %.partset39 = or i195 %865, %864
  store i195 %.partset39, i195* %dst_2, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.3:                             ; preds = %dst.addr.3171.exit
  %866 = bitcast i195* %dst_3 to i200*
  %867 = load i200, i200* %866
  %868 = trunc i200 %867 to i195
  %869 = zext i1 %847 to i195
  %870 = shl i195 %869, 191
  %871 = and i195 %868, -3138550867693340381917894711603833208051177722232017256449
  %.partset32 = or i195 %871, %870
  store i195 %.partset32, i195* %dst_3, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.exit:                               ; preds = %dst.addr.3273.case.3, %dst.addr.3273.case.2, %dst.addr.3273.case.1, %dst.addr.3273.case.0, %dst.addr.3171.exit
  %src.addr.3374 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 33
  %872 = bitcast i1* %src.addr.3374 to i8*
  %873 = load i8, i8* %872
  %874 = trunc i8 %873 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3375.exit [
    i64 0, label %dst.addr.3375.case.0
    i64 1, label %dst.addr.3375.case.1
    i64 2, label %dst.addr.3375.case.2
    i64 3, label %dst.addr.3375.case.3
  ]

dst.addr.3375.case.0:                             ; preds = %dst.addr.3273.exit
  %875 = bitcast i195* %dst_0 to i200*
  %876 = load i200, i200* %875
  %877 = trunc i200 %876 to i195
  %878 = zext i1 %874 to i195
  %879 = shl i195 %878, 192
  %880 = and i195 %877, -6277101735386680763835789423207666416102355444464034512897
  %.partset110 = or i195 %880, %879
  store i195 %.partset110, i195* %dst_0, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.1:                             ; preds = %dst.addr.3273.exit
  %881 = bitcast i195* %dst_1 to i200*
  %882 = load i200, i200* %881
  %883 = trunc i200 %882 to i195
  %884 = zext i1 %874 to i195
  %885 = shl i195 %884, 192
  %886 = and i195 %883, -6277101735386680763835789423207666416102355444464034512897
  %.partset105 = or i195 %886, %885
  store i195 %.partset105, i195* %dst_1, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.2:                             ; preds = %dst.addr.3273.exit
  %887 = bitcast i195* %dst_2 to i200*
  %888 = load i200, i200* %887
  %889 = trunc i200 %888 to i195
  %890 = zext i1 %874 to i195
  %891 = shl i195 %890, 192
  %892 = and i195 %889, -6277101735386680763835789423207666416102355444464034512897
  %.partset38 = or i195 %892, %891
  store i195 %.partset38, i195* %dst_2, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.3:                             ; preds = %dst.addr.3273.exit
  %893 = bitcast i195* %dst_3 to i200*
  %894 = load i200, i200* %893
  %895 = trunc i200 %894 to i195
  %896 = zext i1 %874 to i195
  %897 = shl i195 %896, 192
  %898 = and i195 %895, -6277101735386680763835789423207666416102355444464034512897
  %.partset33 = or i195 %898, %897
  store i195 %.partset33, i195* %dst_3, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.exit:                               ; preds = %dst.addr.3375.case.3, %dst.addr.3375.case.2, %dst.addr.3375.case.1, %dst.addr.3375.case.0, %dst.addr.3273.exit
  %src.addr.3476 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 34
  %899 = bitcast i1* %src.addr.3476 to i8*
  %900 = load i8, i8* %899
  %901 = trunc i8 %900 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3477.exit [
    i64 0, label %dst.addr.3477.case.0
    i64 1, label %dst.addr.3477.case.1
    i64 2, label %dst.addr.3477.case.2
    i64 3, label %dst.addr.3477.case.3
  ]

dst.addr.3477.case.0:                             ; preds = %dst.addr.3375.exit
  %902 = bitcast i195* %dst_0 to i200*
  %903 = load i200, i200* %902
  %904 = trunc i200 %903 to i195
  %905 = zext i1 %901 to i195
  %906 = shl i195 %905, 193
  %907 = and i195 %904, -12554203470773361527671578846415332832204710888928069025793
  %.partset109 = or i195 %907, %906
  store i195 %.partset109, i195* %dst_0, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.1:                             ; preds = %dst.addr.3375.exit
  %908 = bitcast i195* %dst_1 to i200*
  %909 = load i200, i200* %908
  %910 = trunc i200 %909 to i195
  %911 = zext i1 %901 to i195
  %912 = shl i195 %911, 193
  %913 = and i195 %910, -12554203470773361527671578846415332832204710888928069025793
  %.partset106 = or i195 %913, %912
  store i195 %.partset106, i195* %dst_1, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.2:                             ; preds = %dst.addr.3375.exit
  %914 = bitcast i195* %dst_2 to i200*
  %915 = load i200, i200* %914
  %916 = trunc i200 %915 to i195
  %917 = zext i1 %901 to i195
  %918 = shl i195 %917, 193
  %919 = and i195 %916, -12554203470773361527671578846415332832204710888928069025793
  %.partset37 = or i195 %919, %918
  store i195 %.partset37, i195* %dst_2, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.3:                             ; preds = %dst.addr.3375.exit
  %920 = bitcast i195* %dst_3 to i200*
  %921 = load i200, i200* %920
  %922 = trunc i200 %921 to i195
  %923 = zext i1 %901 to i195
  %924 = shl i195 %923, 193
  %925 = and i195 %922, -12554203470773361527671578846415332832204710888928069025793
  %.partset34 = or i195 %925, %924
  store i195 %.partset34, i195* %dst_3, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.exit:                               ; preds = %dst.addr.3477.case.3, %dst.addr.3477.case.2, %dst.addr.3477.case.1, %dst.addr.3477.case.0, %dst.addr.3375.exit
  %src.addr.3578 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 35
  %926 = bitcast i1* %src.addr.3578 to i8*
  %927 = load i8, i8* %926
  %928 = trunc i8 %927 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3579.exit [
    i64 0, label %dst.addr.3579.case.0
    i64 1, label %dst.addr.3579.case.1
    i64 2, label %dst.addr.3579.case.2
    i64 3, label %dst.addr.3579.case.3
  ]

dst.addr.3579.case.0:                             ; preds = %dst.addr.3477.exit
  %929 = bitcast i195* %dst_0 to i200*
  %930 = load i200, i200* %929
  %931 = trunc i200 %930 to i195
  %932 = zext i1 %928 to i195
  %933 = shl i195 %932, 194
  %934 = and i195 %931, 25108406941546723055343157692830665664409421777856138051583
  %.partset108 = or i195 %934, %933
  store i195 %.partset108, i195* %dst_0, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.1:                             ; preds = %dst.addr.3477.exit
  %935 = bitcast i195* %dst_1 to i200*
  %936 = load i200, i200* %935
  %937 = trunc i200 %936 to i195
  %938 = zext i1 %928 to i195
  %939 = shl i195 %938, 194
  %940 = and i195 %937, 25108406941546723055343157692830665664409421777856138051583
  %.partset107 = or i195 %940, %939
  store i195 %.partset107, i195* %dst_1, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.2:                             ; preds = %dst.addr.3477.exit
  %941 = bitcast i195* %dst_2 to i200*
  %942 = load i200, i200* %941
  %943 = trunc i200 %942 to i195
  %944 = zext i1 %928 to i195
  %945 = shl i195 %944, 194
  %946 = and i195 %943, 25108406941546723055343157692830665664409421777856138051583
  %.partset36 = or i195 %946, %945
  store i195 %.partset36, i195* %dst_2, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.3:                             ; preds = %dst.addr.3477.exit
  %947 = bitcast i195* %dst_3 to i200*
  %948 = load i200, i200* %947
  %949 = trunc i200 %948 to i195
  %950 = zext i1 %928 to i195
  %951 = shl i195 %950, 194
  %952 = and i195 %949, 25108406941546723055343157692830665664409421777856138051583
  %.partset35 = or i195 %952, %951
  store i195 %.partset35, i195* %dst_3, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.exit:                               ; preds = %dst.addr.3579.case.3, %dst.addr.3579.case.2, %dst.addr.3579.case.1, %dst.addr.3579.case.0, %dst.addr.3477.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx81, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.3579.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.9.12(i195* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i195* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i195* noalias align 512 "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i195* noalias align 512 "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #1 {
entry:
  %0 = icmp eq i195* %dst_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.10.11(i195* nonnull %dst_0, i195* %dst_1, i195* %dst_2, i195* %dst_3, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in(i32* noalias readonly "orig.arg.no"="0", i32* noalias align 512 "orig.arg.no"="1", i1* noalias readonly "orig.arg.no"="2", i1* noalias align 512 "orig.arg.no"="3", i1* noalias readonly "orig.arg.no"="4", i1* noalias align 512 "orig.arg.no"="5", i1* noalias readonly "orig.arg.no"="6", i1* noalias align 512 "orig.arg.no"="7", i1* noalias readonly "orig.arg.no"="8", i1* noalias align 512 "orig.arg.no"="9", i8* noalias readonly "orig.arg.no"="10", i8* noalias align 512 "orig.arg.no"="11", i32* noalias readonly "orig.arg.no"="12", i32* noalias align 512 "orig.arg.no"="13", i32* noalias readonly "orig.arg.no"="14", i32* noalias align 512 "orig.arg.no"="15", i32* noalias readonly "orig.arg.no"="16", i32* noalias align 512 "orig.arg.no"="17", [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="18", i195* noalias align 512 "orig.arg.no"="19" "unpacked"="19.0" %_0, i195* noalias align 512 "orig.arg.no"="19" "unpacked"="19.1" %_1, i195* noalias align 512 "orig.arg.no"="19" "unpacked"="19.2" %_2, i195* noalias align 512 "orig.arg.no"="19" "unpacked"="19.3" %_3, i1* noalias readonly "orig.arg.no"="20", i1* noalias align 512 "orig.arg.no"="21", i32* noalias readonly "orig.arg.no"="22", i32* noalias align 512 "orig.arg.no"="23", i1* noalias readonly "orig.arg.no"="24", i1* noalias align 512 "orig.arg.no"="25", i32* noalias readonly "orig.arg.no"="26", i32* noalias align 512 "orig.arg.no"="27", i1* noalias readonly "orig.arg.no"="28", i1* noalias align 512 "orig.arg.no"="29", i1* noalias readonly "orig.arg.no"="30", i1* noalias align 512 "orig.arg.no"="31", i32* noalias readonly "orig.arg.no"="32", i32* noalias align 512 "orig.arg.no"="33", i32* noalias readonly "orig.arg.no"="34", i32* noalias align 512 "orig.arg.no"="35") #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %1, i32* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %3, i1* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %5, i1* %4)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %7, i1* %6)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %9, i1* %8)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %11, i8* %10)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %13, i32* %12)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %15, i32* %14)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %17, i32* %16)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.9.12(i195* align 512 %_0, i195* align 512 %_1, i195* align 512 %_2, i195* align 512 %_3, [4 x %struct.HeadCtx]* %18)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %20, i1* %19)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %22, i32* %21)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %24, i1* %23)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %26, i32* %25)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %28, i1* %27)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %30, i1* %29)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %32, i32* %31)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %34, i32* %33)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.18.19([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i195* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i195* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i195* readonly "orig.arg.no"="1" "unpacked"="1.2" %src_2, i195* readonly "orig.arg.no"="1" "unpacked"="1.3" %src_3, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i195* %src_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond80 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond80, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.3578.exit, %for.loop.lr.ph
  %for.loop.idx81 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.3578.exit ]
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 0
  switch i64 %for.loop.idx81, label %src.addr.01.exit [
    i64 0, label %src.addr.01.case.0
    i64 1, label %src.addr.01.case.1
    i64 2, label %src.addr.01.case.2
    i64 3, label %src.addr.01.case.3
  ]

src.addr.01.case.0:                               ; preds = %for.loop
  %3 = bitcast i195* %src_0 to i200*
  %4 = load i200, i200* %3
  %5 = trunc i200 %4 to i195
  %_0.partselect = trunc i195 %5 to i32
  br label %src.addr.01.exit

src.addr.01.case.1:                               ; preds = %for.loop
  %6 = bitcast i195* %src_1 to i200*
  %7 = load i200, i200* %6
  %8 = trunc i200 %7 to i195
  %_1.partselect = trunc i195 %8 to i32
  br label %src.addr.01.exit

src.addr.01.case.2:                               ; preds = %for.loop
  %9 = bitcast i195* %src_2 to i200*
  %10 = load i200, i200* %9
  %11 = trunc i200 %10 to i195
  %_2.partselect = trunc i195 %11 to i32
  br label %src.addr.01.exit

src.addr.01.case.3:                               ; preds = %for.loop
  %12 = bitcast i195* %src_3 to i200*
  %13 = load i200, i200* %12
  %14 = trunc i200 %13 to i195
  %_3.partselect = trunc i195 %14 to i32
  br label %src.addr.01.exit

src.addr.01.exit:                                 ; preds = %src.addr.01.case.3, %src.addr.01.case.2, %src.addr.01.case.1, %src.addr.01.case.0, %for.loop
  %15 = phi i32 [ %_0.partselect, %src.addr.01.case.0 ], [ %_1.partselect, %src.addr.01.case.1 ], [ %_2.partselect, %src.addr.01.case.2 ], [ %_3.partselect, %src.addr.01.case.3 ], [ undef, %for.loop ]
  store i32 %15, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 1
  switch i64 %for.loop.idx81, label %src.addr.110.exit [
    i64 0, label %src.addr.110.case.0
    i64 1, label %src.addr.110.case.1
    i64 2, label %src.addr.110.case.2
    i64 3, label %src.addr.110.case.3
  ]

src.addr.110.case.0:                              ; preds = %src.addr.01.exit
  %16 = bitcast i195* %src_0 to i200*
  %17 = load i200, i200* %16
  %18 = trunc i200 %17 to i195
  %19 = lshr i195 %18, 32
  %_01.partselect = trunc i195 %19 to i32
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %20 = bitcast i195* %src_1 to i200*
  %21 = load i200, i200* %20
  %22 = trunc i200 %21 to i195
  %23 = lshr i195 %22, 32
  %_12.partselect = trunc i195 %23 to i32
  br label %src.addr.110.exit

src.addr.110.case.2:                              ; preds = %src.addr.01.exit
  %24 = bitcast i195* %src_2 to i200*
  %25 = load i200, i200* %24
  %26 = trunc i200 %25 to i195
  %27 = lshr i195 %26, 32
  %_23.partselect = trunc i195 %27 to i32
  br label %src.addr.110.exit

src.addr.110.case.3:                              ; preds = %src.addr.01.exit
  %28 = bitcast i195* %src_3 to i200*
  %29 = load i200, i200* %28
  %30 = trunc i200 %29 to i195
  %31 = lshr i195 %30, 32
  %_34.partselect = trunc i195 %31 to i32
  br label %src.addr.110.exit

src.addr.110.exit:                                ; preds = %src.addr.110.case.3, %src.addr.110.case.2, %src.addr.110.case.1, %src.addr.110.case.0, %src.addr.01.exit
  %32 = phi i32 [ %_01.partselect, %src.addr.110.case.0 ], [ %_12.partselect, %src.addr.110.case.1 ], [ %_23.partselect, %src.addr.110.case.2 ], [ %_34.partselect, %src.addr.110.case.3 ], [ undef, %src.addr.01.exit ]
  store i32 %32, i32* %dst.addr.111, align 4
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 2
  switch i64 %for.loop.idx81, label %src.addr.212.exit [
    i64 0, label %src.addr.212.case.0
    i64 1, label %src.addr.212.case.1
    i64 2, label %src.addr.212.case.2
    i64 3, label %src.addr.212.case.3
  ]

src.addr.212.case.0:                              ; preds = %src.addr.110.exit
  %33 = bitcast i195* %src_0 to i200*
  %34 = load i200, i200* %33
  %35 = trunc i200 %34 to i195
  %36 = lshr i195 %35, 64
  %_05.partselect = trunc i195 %36 to i8
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %37 = bitcast i195* %src_1 to i200*
  %38 = load i200, i200* %37
  %39 = trunc i200 %38 to i195
  %40 = lshr i195 %39, 64
  %_16.partselect = trunc i195 %40 to i8
  br label %src.addr.212.exit

src.addr.212.case.2:                              ; preds = %src.addr.110.exit
  %41 = bitcast i195* %src_2 to i200*
  %42 = load i200, i200* %41
  %43 = trunc i200 %42 to i195
  %44 = lshr i195 %43, 64
  %_27.partselect = trunc i195 %44 to i8
  br label %src.addr.212.exit

src.addr.212.case.3:                              ; preds = %src.addr.110.exit
  %45 = bitcast i195* %src_3 to i200*
  %46 = load i200, i200* %45
  %47 = trunc i200 %46 to i195
  %48 = lshr i195 %47, 64
  %_38.partselect = trunc i195 %48 to i8
  br label %src.addr.212.exit

src.addr.212.exit:                                ; preds = %src.addr.212.case.3, %src.addr.212.case.2, %src.addr.212.case.1, %src.addr.212.case.0, %src.addr.110.exit
  %49 = phi i8 [ %_05.partselect, %src.addr.212.case.0 ], [ %_16.partselect, %src.addr.212.case.1 ], [ %_27.partselect, %src.addr.212.case.2 ], [ %_38.partselect, %src.addr.212.case.3 ], [ undef, %src.addr.110.exit ]
  store i8 %49, i8* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 3
  switch i64 %for.loop.idx81, label %src.addr.314.exit [
    i64 0, label %src.addr.314.case.0
    i64 1, label %src.addr.314.case.1
    i64 2, label %src.addr.314.case.2
    i64 3, label %src.addr.314.case.3
  ]

src.addr.314.case.0:                              ; preds = %src.addr.212.exit
  %50 = bitcast i195* %src_0 to i200*
  %51 = load i200, i200* %50
  %52 = trunc i200 %51 to i195
  %53 = lshr i195 %52, 72
  %_09.partselect = trunc i195 %53 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %54 = bitcast i195* %src_1 to i200*
  %55 = load i200, i200* %54
  %56 = trunc i200 %55 to i195
  %57 = lshr i195 %56, 72
  %_110.partselect = trunc i195 %57 to i1
  br label %src.addr.314.exit

src.addr.314.case.2:                              ; preds = %src.addr.212.exit
  %58 = bitcast i195* %src_2 to i200*
  %59 = load i200, i200* %58
  %60 = trunc i200 %59 to i195
  %61 = lshr i195 %60, 72
  %_211.partselect = trunc i195 %61 to i1
  br label %src.addr.314.exit

src.addr.314.case.3:                              ; preds = %src.addr.212.exit
  %62 = bitcast i195* %src_3 to i200*
  %63 = load i200, i200* %62
  %64 = trunc i200 %63 to i195
  %65 = lshr i195 %64, 72
  %_312.partselect = trunc i195 %65 to i1
  br label %src.addr.314.exit

src.addr.314.exit:                                ; preds = %src.addr.314.case.3, %src.addr.314.case.2, %src.addr.314.case.1, %src.addr.314.case.0, %src.addr.212.exit
  %66 = phi i1 [ %_09.partselect, %src.addr.314.case.0 ], [ %_110.partselect, %src.addr.314.case.1 ], [ %_211.partselect, %src.addr.314.case.2 ], [ %_312.partselect, %src.addr.314.case.3 ], [ undef, %src.addr.212.exit ]
  store i1 %66, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 4
  switch i64 %for.loop.idx81, label %src.addr.416.exit [
    i64 0, label %src.addr.416.case.0
    i64 1, label %src.addr.416.case.1
    i64 2, label %src.addr.416.case.2
    i64 3, label %src.addr.416.case.3
  ]

src.addr.416.case.0:                              ; preds = %src.addr.314.exit
  %67 = bitcast i195* %src_0 to i200*
  %68 = load i200, i200* %67
  %69 = trunc i200 %68 to i195
  %70 = lshr i195 %69, 73
  %_013.partselect = trunc i195 %70 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %71 = bitcast i195* %src_1 to i200*
  %72 = load i200, i200* %71
  %73 = trunc i200 %72 to i195
  %74 = lshr i195 %73, 73
  %_114.partselect = trunc i195 %74 to i1
  br label %src.addr.416.exit

src.addr.416.case.2:                              ; preds = %src.addr.314.exit
  %75 = bitcast i195* %src_2 to i200*
  %76 = load i200, i200* %75
  %77 = trunc i200 %76 to i195
  %78 = lshr i195 %77, 73
  %_215.partselect = trunc i195 %78 to i1
  br label %src.addr.416.exit

src.addr.416.case.3:                              ; preds = %src.addr.314.exit
  %79 = bitcast i195* %src_3 to i200*
  %80 = load i200, i200* %79
  %81 = trunc i200 %80 to i195
  %82 = lshr i195 %81, 73
  %_316.partselect = trunc i195 %82 to i1
  br label %src.addr.416.exit

src.addr.416.exit:                                ; preds = %src.addr.416.case.3, %src.addr.416.case.2, %src.addr.416.case.1, %src.addr.416.case.0, %src.addr.314.exit
  %83 = phi i1 [ %_013.partselect, %src.addr.416.case.0 ], [ %_114.partselect, %src.addr.416.case.1 ], [ %_215.partselect, %src.addr.416.case.2 ], [ %_316.partselect, %src.addr.416.case.3 ], [ undef, %src.addr.314.exit ]
  store i1 %83, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 5
  switch i64 %for.loop.idx81, label %src.addr.518.exit [
    i64 0, label %src.addr.518.case.0
    i64 1, label %src.addr.518.case.1
    i64 2, label %src.addr.518.case.2
    i64 3, label %src.addr.518.case.3
  ]

src.addr.518.case.0:                              ; preds = %src.addr.416.exit
  %84 = bitcast i195* %src_0 to i200*
  %85 = load i200, i200* %84
  %86 = trunc i200 %85 to i195
  %87 = lshr i195 %86, 74
  %_017.partselect = trunc i195 %87 to i1
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %88 = bitcast i195* %src_1 to i200*
  %89 = load i200, i200* %88
  %90 = trunc i200 %89 to i195
  %91 = lshr i195 %90, 74
  %_118.partselect = trunc i195 %91 to i1
  br label %src.addr.518.exit

src.addr.518.case.2:                              ; preds = %src.addr.416.exit
  %92 = bitcast i195* %src_2 to i200*
  %93 = load i200, i200* %92
  %94 = trunc i200 %93 to i195
  %95 = lshr i195 %94, 74
  %_219.partselect = trunc i195 %95 to i1
  br label %src.addr.518.exit

src.addr.518.case.3:                              ; preds = %src.addr.416.exit
  %96 = bitcast i195* %src_3 to i200*
  %97 = load i200, i200* %96
  %98 = trunc i200 %97 to i195
  %99 = lshr i195 %98, 74
  %_320.partselect = trunc i195 %99 to i1
  br label %src.addr.518.exit

src.addr.518.exit:                                ; preds = %src.addr.518.case.3, %src.addr.518.case.2, %src.addr.518.case.1, %src.addr.518.case.0, %src.addr.416.exit
  %100 = phi i1 [ %_017.partselect, %src.addr.518.case.0 ], [ %_118.partselect, %src.addr.518.case.1 ], [ %_219.partselect, %src.addr.518.case.2 ], [ %_320.partselect, %src.addr.518.case.3 ], [ undef, %src.addr.416.exit ]
  store i1 %100, i1* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 6
  switch i64 %for.loop.idx81, label %src.addr.620.exit [
    i64 0, label %src.addr.620.case.0
    i64 1, label %src.addr.620.case.1
    i64 2, label %src.addr.620.case.2
    i64 3, label %src.addr.620.case.3
  ]

src.addr.620.case.0:                              ; preds = %src.addr.518.exit
  %101 = bitcast i195* %src_0 to i200*
  %102 = load i200, i200* %101
  %103 = trunc i200 %102 to i195
  %104 = lshr i195 %103, 75
  %_021.partselect = trunc i195 %104 to i8
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %105 = bitcast i195* %src_1 to i200*
  %106 = load i200, i200* %105
  %107 = trunc i200 %106 to i195
  %108 = lshr i195 %107, 75
  %_122.partselect = trunc i195 %108 to i8
  br label %src.addr.620.exit

src.addr.620.case.2:                              ; preds = %src.addr.518.exit
  %109 = bitcast i195* %src_2 to i200*
  %110 = load i200, i200* %109
  %111 = trunc i200 %110 to i195
  %112 = lshr i195 %111, 75
  %_223.partselect = trunc i195 %112 to i8
  br label %src.addr.620.exit

src.addr.620.case.3:                              ; preds = %src.addr.518.exit
  %113 = bitcast i195* %src_3 to i200*
  %114 = load i200, i200* %113
  %115 = trunc i200 %114 to i195
  %116 = lshr i195 %115, 75
  %_324.partselect = trunc i195 %116 to i8
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.3, %src.addr.620.case.2, %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %117 = phi i8 [ %_021.partselect, %src.addr.620.case.0 ], [ %_122.partselect, %src.addr.620.case.1 ], [ %_223.partselect, %src.addr.620.case.2 ], [ %_324.partselect, %src.addr.620.case.3 ], [ undef, %src.addr.518.exit ]
  store i8 %117, i8* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 7
  switch i64 %for.loop.idx81, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
    i64 2, label %src.addr.722.case.2
    i64 3, label %src.addr.722.case.3
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %118 = bitcast i195* %src_0 to i200*
  %119 = load i200, i200* %118
  %120 = trunc i200 %119 to i195
  %121 = lshr i195 %120, 83
  %_025.partselect = trunc i195 %121 to i8
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %122 = bitcast i195* %src_1 to i200*
  %123 = load i200, i200* %122
  %124 = trunc i200 %123 to i195
  %125 = lshr i195 %124, 83
  %_126.partselect = trunc i195 %125 to i8
  br label %src.addr.722.exit

src.addr.722.case.2:                              ; preds = %src.addr.620.exit
  %126 = bitcast i195* %src_2 to i200*
  %127 = load i200, i200* %126
  %128 = trunc i200 %127 to i195
  %129 = lshr i195 %128, 83
  %_227.partselect = trunc i195 %129 to i8
  br label %src.addr.722.exit

src.addr.722.case.3:                              ; preds = %src.addr.620.exit
  %130 = bitcast i195* %src_3 to i200*
  %131 = load i200, i200* %130
  %132 = trunc i200 %131 to i195
  %133 = lshr i195 %132, 83
  %_328.partselect = trunc i195 %133 to i8
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.3, %src.addr.722.case.2, %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %134 = phi i8 [ %_025.partselect, %src.addr.722.case.0 ], [ %_126.partselect, %src.addr.722.case.1 ], [ %_227.partselect, %src.addr.722.case.2 ], [ %_328.partselect, %src.addr.722.case.3 ], [ undef, %src.addr.620.exit ]
  store i8 %134, i8* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 8
  switch i64 %for.loop.idx81, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
    i64 2, label %src.addr.824.case.2
    i64 3, label %src.addr.824.case.3
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %135 = bitcast i195* %src_0 to i200*
  %136 = load i200, i200* %135
  %137 = trunc i200 %136 to i195
  %138 = lshr i195 %137, 91
  %_029.partselect = trunc i195 %138 to i8
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %139 = bitcast i195* %src_1 to i200*
  %140 = load i200, i200* %139
  %141 = trunc i200 %140 to i195
  %142 = lshr i195 %141, 91
  %_130.partselect = trunc i195 %142 to i8
  br label %src.addr.824.exit

src.addr.824.case.2:                              ; preds = %src.addr.722.exit
  %143 = bitcast i195* %src_2 to i200*
  %144 = load i200, i200* %143
  %145 = trunc i200 %144 to i195
  %146 = lshr i195 %145, 91
  %_231.partselect = trunc i195 %146 to i8
  br label %src.addr.824.exit

src.addr.824.case.3:                              ; preds = %src.addr.722.exit
  %147 = bitcast i195* %src_3 to i200*
  %148 = load i200, i200* %147
  %149 = trunc i200 %148 to i195
  %150 = lshr i195 %149, 91
  %_332.partselect = trunc i195 %150 to i8
  br label %src.addr.824.exit

src.addr.824.exit:                                ; preds = %src.addr.824.case.3, %src.addr.824.case.2, %src.addr.824.case.1, %src.addr.824.case.0, %src.addr.722.exit
  %151 = phi i8 [ %_029.partselect, %src.addr.824.case.0 ], [ %_130.partselect, %src.addr.824.case.1 ], [ %_231.partselect, %src.addr.824.case.2 ], [ %_332.partselect, %src.addr.824.case.3 ], [ undef, %src.addr.722.exit ]
  store i8 %151, i8* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 9
  switch i64 %for.loop.idx81, label %src.addr.926.exit [
    i64 0, label %src.addr.926.case.0
    i64 1, label %src.addr.926.case.1
    i64 2, label %src.addr.926.case.2
    i64 3, label %src.addr.926.case.3
  ]

src.addr.926.case.0:                              ; preds = %src.addr.824.exit
  %152 = bitcast i195* %src_0 to i200*
  %153 = load i200, i200* %152
  %154 = trunc i200 %153 to i195
  %155 = lshr i195 %154, 99
  %_033.partselect = trunc i195 %155 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %156 = bitcast i195* %src_1 to i200*
  %157 = load i200, i200* %156
  %158 = trunc i200 %157 to i195
  %159 = lshr i195 %158, 99
  %_134.partselect = trunc i195 %159 to i1
  br label %src.addr.926.exit

src.addr.926.case.2:                              ; preds = %src.addr.824.exit
  %160 = bitcast i195* %src_2 to i200*
  %161 = load i200, i200* %160
  %162 = trunc i200 %161 to i195
  %163 = lshr i195 %162, 99
  %_235.partselect = trunc i195 %163 to i1
  br label %src.addr.926.exit

src.addr.926.case.3:                              ; preds = %src.addr.824.exit
  %164 = bitcast i195* %src_3 to i200*
  %165 = load i200, i200* %164
  %166 = trunc i200 %165 to i195
  %167 = lshr i195 %166, 99
  %_336.partselect = trunc i195 %167 to i1
  br label %src.addr.926.exit

src.addr.926.exit:                                ; preds = %src.addr.926.case.3, %src.addr.926.case.2, %src.addr.926.case.1, %src.addr.926.case.0, %src.addr.824.exit
  %168 = phi i1 [ %_033.partselect, %src.addr.926.case.0 ], [ %_134.partselect, %src.addr.926.case.1 ], [ %_235.partselect, %src.addr.926.case.2 ], [ %_336.partselect, %src.addr.926.case.3 ], [ undef, %src.addr.824.exit ]
  store i1 %168, i1* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 10
  switch i64 %for.loop.idx81, label %src.addr.1028.exit [
    i64 0, label %src.addr.1028.case.0
    i64 1, label %src.addr.1028.case.1
    i64 2, label %src.addr.1028.case.2
    i64 3, label %src.addr.1028.case.3
  ]

src.addr.1028.case.0:                             ; preds = %src.addr.926.exit
  %169 = bitcast i195* %src_0 to i200*
  %170 = load i200, i200* %169
  %171 = trunc i200 %170 to i195
  %172 = lshr i195 %171, 100
  %_037.partselect = trunc i195 %172 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %173 = bitcast i195* %src_1 to i200*
  %174 = load i200, i200* %173
  %175 = trunc i200 %174 to i195
  %176 = lshr i195 %175, 100
  %_138.partselect = trunc i195 %176 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.2:                             ; preds = %src.addr.926.exit
  %177 = bitcast i195* %src_2 to i200*
  %178 = load i200, i200* %177
  %179 = trunc i200 %178 to i195
  %180 = lshr i195 %179, 100
  %_239.partselect = trunc i195 %180 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.3:                             ; preds = %src.addr.926.exit
  %181 = bitcast i195* %src_3 to i200*
  %182 = load i200, i200* %181
  %183 = trunc i200 %182 to i195
  %184 = lshr i195 %183, 100
  %_340.partselect = trunc i195 %184 to i1
  br label %src.addr.1028.exit

src.addr.1028.exit:                               ; preds = %src.addr.1028.case.3, %src.addr.1028.case.2, %src.addr.1028.case.1, %src.addr.1028.case.0, %src.addr.926.exit
  %185 = phi i1 [ %_037.partselect, %src.addr.1028.case.0 ], [ %_138.partselect, %src.addr.1028.case.1 ], [ %_239.partselect, %src.addr.1028.case.2 ], [ %_340.partselect, %src.addr.1028.case.3 ], [ undef, %src.addr.926.exit ]
  store i1 %185, i1* %dst.addr.1029, align 1
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 11
  switch i64 %for.loop.idx81, label %src.addr.1130.exit [
    i64 0, label %src.addr.1130.case.0
    i64 1, label %src.addr.1130.case.1
    i64 2, label %src.addr.1130.case.2
    i64 3, label %src.addr.1130.case.3
  ]

src.addr.1130.case.0:                             ; preds = %src.addr.1028.exit
  %186 = bitcast i195* %src_0 to i200*
  %187 = load i200, i200* %186
  %188 = trunc i200 %187 to i195
  %189 = lshr i195 %188, 101
  %_041.partselect = trunc i195 %189 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %190 = bitcast i195* %src_1 to i200*
  %191 = load i200, i200* %190
  %192 = trunc i200 %191 to i195
  %193 = lshr i195 %192, 101
  %_142.partselect = trunc i195 %193 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.2:                             ; preds = %src.addr.1028.exit
  %194 = bitcast i195* %src_2 to i200*
  %195 = load i200, i200* %194
  %196 = trunc i200 %195 to i195
  %197 = lshr i195 %196, 101
  %_243.partselect = trunc i195 %197 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.3:                             ; preds = %src.addr.1028.exit
  %198 = bitcast i195* %src_3 to i200*
  %199 = load i200, i200* %198
  %200 = trunc i200 %199 to i195
  %201 = lshr i195 %200, 101
  %_344.partselect = trunc i195 %201 to i8
  br label %src.addr.1130.exit

src.addr.1130.exit:                               ; preds = %src.addr.1130.case.3, %src.addr.1130.case.2, %src.addr.1130.case.1, %src.addr.1130.case.0, %src.addr.1028.exit
  %202 = phi i8 [ %_041.partselect, %src.addr.1130.case.0 ], [ %_142.partselect, %src.addr.1130.case.1 ], [ %_243.partselect, %src.addr.1130.case.2 ], [ %_344.partselect, %src.addr.1130.case.3 ], [ undef, %src.addr.1028.exit ]
  store i8 %202, i8* %dst.addr.1131, align 1
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 12
  switch i64 %for.loop.idx81, label %src.addr.1232.exit [
    i64 0, label %src.addr.1232.case.0
    i64 1, label %src.addr.1232.case.1
    i64 2, label %src.addr.1232.case.2
    i64 3, label %src.addr.1232.case.3
  ]

src.addr.1232.case.0:                             ; preds = %src.addr.1130.exit
  %203 = bitcast i195* %src_0 to i200*
  %204 = load i200, i200* %203
  %205 = trunc i200 %204 to i195
  %206 = lshr i195 %205, 109
  %_045.partselect = trunc i195 %206 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %207 = bitcast i195* %src_1 to i200*
  %208 = load i200, i200* %207
  %209 = trunc i200 %208 to i195
  %210 = lshr i195 %209, 109
  %_146.partselect = trunc i195 %210 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.2:                             ; preds = %src.addr.1130.exit
  %211 = bitcast i195* %src_2 to i200*
  %212 = load i200, i200* %211
  %213 = trunc i200 %212 to i195
  %214 = lshr i195 %213, 109
  %_247.partselect = trunc i195 %214 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.3:                             ; preds = %src.addr.1130.exit
  %215 = bitcast i195* %src_3 to i200*
  %216 = load i200, i200* %215
  %217 = trunc i200 %216 to i195
  %218 = lshr i195 %217, 109
  %_348.partselect = trunc i195 %218 to i32
  br label %src.addr.1232.exit

src.addr.1232.exit:                               ; preds = %src.addr.1232.case.3, %src.addr.1232.case.2, %src.addr.1232.case.1, %src.addr.1232.case.0, %src.addr.1130.exit
  %219 = phi i32 [ %_045.partselect, %src.addr.1232.case.0 ], [ %_146.partselect, %src.addr.1232.case.1 ], [ %_247.partselect, %src.addr.1232.case.2 ], [ %_348.partselect, %src.addr.1232.case.3 ], [ undef, %src.addr.1130.exit ]
  store i32 %219, i32* %dst.addr.1233, align 4
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 13
  switch i64 %for.loop.idx81, label %src.addr.1334.exit [
    i64 0, label %src.addr.1334.case.0
    i64 1, label %src.addr.1334.case.1
    i64 2, label %src.addr.1334.case.2
    i64 3, label %src.addr.1334.case.3
  ]

src.addr.1334.case.0:                             ; preds = %src.addr.1232.exit
  %220 = bitcast i195* %src_0 to i200*
  %221 = load i200, i200* %220
  %222 = trunc i200 %221 to i195
  %223 = lshr i195 %222, 141
  %_049.partselect = trunc i195 %223 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %224 = bitcast i195* %src_1 to i200*
  %225 = load i200, i200* %224
  %226 = trunc i200 %225 to i195
  %227 = lshr i195 %226, 141
  %_150.partselect = trunc i195 %227 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.2:                             ; preds = %src.addr.1232.exit
  %228 = bitcast i195* %src_2 to i200*
  %229 = load i200, i200* %228
  %230 = trunc i200 %229 to i195
  %231 = lshr i195 %230, 141
  %_251.partselect = trunc i195 %231 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.3:                             ; preds = %src.addr.1232.exit
  %232 = bitcast i195* %src_3 to i200*
  %233 = load i200, i200* %232
  %234 = trunc i200 %233 to i195
  %235 = lshr i195 %234, 141
  %_352.partselect = trunc i195 %235 to i32
  br label %src.addr.1334.exit

src.addr.1334.exit:                               ; preds = %src.addr.1334.case.3, %src.addr.1334.case.2, %src.addr.1334.case.1, %src.addr.1334.case.0, %src.addr.1232.exit
  %236 = phi i32 [ %_049.partselect, %src.addr.1334.case.0 ], [ %_150.partselect, %src.addr.1334.case.1 ], [ %_251.partselect, %src.addr.1334.case.2 ], [ %_352.partselect, %src.addr.1334.case.3 ], [ undef, %src.addr.1232.exit ]
  store i32 %236, i32* %dst.addr.1335, align 4
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 14
  switch i64 %for.loop.idx81, label %src.addr.1436.exit [
    i64 0, label %src.addr.1436.case.0
    i64 1, label %src.addr.1436.case.1
    i64 2, label %src.addr.1436.case.2
    i64 3, label %src.addr.1436.case.3
  ]

src.addr.1436.case.0:                             ; preds = %src.addr.1334.exit
  %237 = bitcast i195* %src_0 to i200*
  %238 = load i200, i200* %237
  %239 = trunc i200 %238 to i195
  %240 = lshr i195 %239, 173
  %_053.partselect = trunc i195 %240 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %241 = bitcast i195* %src_1 to i200*
  %242 = load i200, i200* %241
  %243 = trunc i200 %242 to i195
  %244 = lshr i195 %243, 173
  %_154.partselect = trunc i195 %244 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.2:                             ; preds = %src.addr.1334.exit
  %245 = bitcast i195* %src_2 to i200*
  %246 = load i200, i200* %245
  %247 = trunc i200 %246 to i195
  %248 = lshr i195 %247, 173
  %_255.partselect = trunc i195 %248 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.3:                             ; preds = %src.addr.1334.exit
  %249 = bitcast i195* %src_3 to i200*
  %250 = load i200, i200* %249
  %251 = trunc i200 %250 to i195
  %252 = lshr i195 %251, 173
  %_356.partselect = trunc i195 %252 to i1
  br label %src.addr.1436.exit

src.addr.1436.exit:                               ; preds = %src.addr.1436.case.3, %src.addr.1436.case.2, %src.addr.1436.case.1, %src.addr.1436.case.0, %src.addr.1334.exit
  %253 = phi i1 [ %_053.partselect, %src.addr.1436.case.0 ], [ %_154.partselect, %src.addr.1436.case.1 ], [ %_255.partselect, %src.addr.1436.case.2 ], [ %_356.partselect, %src.addr.1436.case.3 ], [ undef, %src.addr.1334.exit ]
  store i1 %253, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 15
  switch i64 %for.loop.idx81, label %src.addr.1538.exit [
    i64 0, label %src.addr.1538.case.0
    i64 1, label %src.addr.1538.case.1
    i64 2, label %src.addr.1538.case.2
    i64 3, label %src.addr.1538.case.3
  ]

src.addr.1538.case.0:                             ; preds = %src.addr.1436.exit
  %254 = bitcast i195* %src_0 to i200*
  %255 = load i200, i200* %254
  %256 = trunc i200 %255 to i195
  %257 = lshr i195 %256, 174
  %_057.partselect = trunc i195 %257 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %258 = bitcast i195* %src_1 to i200*
  %259 = load i200, i200* %258
  %260 = trunc i200 %259 to i195
  %261 = lshr i195 %260, 174
  %_158.partselect = trunc i195 %261 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.2:                             ; preds = %src.addr.1436.exit
  %262 = bitcast i195* %src_2 to i200*
  %263 = load i200, i200* %262
  %264 = trunc i200 %263 to i195
  %265 = lshr i195 %264, 174
  %_259.partselect = trunc i195 %265 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.3:                             ; preds = %src.addr.1436.exit
  %266 = bitcast i195* %src_3 to i200*
  %267 = load i200, i200* %266
  %268 = trunc i200 %267 to i195
  %269 = lshr i195 %268, 174
  %_360.partselect = trunc i195 %269 to i1
  br label %src.addr.1538.exit

src.addr.1538.exit:                               ; preds = %src.addr.1538.case.3, %src.addr.1538.case.2, %src.addr.1538.case.1, %src.addr.1538.case.0, %src.addr.1436.exit
  %270 = phi i1 [ %_057.partselect, %src.addr.1538.case.0 ], [ %_158.partselect, %src.addr.1538.case.1 ], [ %_259.partselect, %src.addr.1538.case.2 ], [ %_360.partselect, %src.addr.1538.case.3 ], [ undef, %src.addr.1436.exit ]
  store i1 %270, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 16
  switch i64 %for.loop.idx81, label %src.addr.1640.exit [
    i64 0, label %src.addr.1640.case.0
    i64 1, label %src.addr.1640.case.1
    i64 2, label %src.addr.1640.case.2
    i64 3, label %src.addr.1640.case.3
  ]

src.addr.1640.case.0:                             ; preds = %src.addr.1538.exit
  %271 = bitcast i195* %src_0 to i200*
  %272 = load i200, i200* %271
  %273 = trunc i200 %272 to i195
  %274 = lshr i195 %273, 175
  %_061.partselect = trunc i195 %274 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %275 = bitcast i195* %src_1 to i200*
  %276 = load i200, i200* %275
  %277 = trunc i200 %276 to i195
  %278 = lshr i195 %277, 175
  %_162.partselect = trunc i195 %278 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.2:                             ; preds = %src.addr.1538.exit
  %279 = bitcast i195* %src_2 to i200*
  %280 = load i200, i200* %279
  %281 = trunc i200 %280 to i195
  %282 = lshr i195 %281, 175
  %_263.partselect = trunc i195 %282 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.3:                             ; preds = %src.addr.1538.exit
  %283 = bitcast i195* %src_3 to i200*
  %284 = load i200, i200* %283
  %285 = trunc i200 %284 to i195
  %286 = lshr i195 %285, 175
  %_364.partselect = trunc i195 %286 to i1
  br label %src.addr.1640.exit

src.addr.1640.exit:                               ; preds = %src.addr.1640.case.3, %src.addr.1640.case.2, %src.addr.1640.case.1, %src.addr.1640.case.0, %src.addr.1538.exit
  %287 = phi i1 [ %_061.partselect, %src.addr.1640.case.0 ], [ %_162.partselect, %src.addr.1640.case.1 ], [ %_263.partselect, %src.addr.1640.case.2 ], [ %_364.partselect, %src.addr.1640.case.3 ], [ undef, %src.addr.1538.exit ]
  store i1 %287, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 17
  switch i64 %for.loop.idx81, label %src.addr.1742.exit [
    i64 0, label %src.addr.1742.case.0
    i64 1, label %src.addr.1742.case.1
    i64 2, label %src.addr.1742.case.2
    i64 3, label %src.addr.1742.case.3
  ]

src.addr.1742.case.0:                             ; preds = %src.addr.1640.exit
  %288 = bitcast i195* %src_0 to i200*
  %289 = load i200, i200* %288
  %290 = trunc i200 %289 to i195
  %291 = lshr i195 %290, 176
  %_065.partselect = trunc i195 %291 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %292 = bitcast i195* %src_1 to i200*
  %293 = load i200, i200* %292
  %294 = trunc i200 %293 to i195
  %295 = lshr i195 %294, 176
  %_166.partselect = trunc i195 %295 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.2:                             ; preds = %src.addr.1640.exit
  %296 = bitcast i195* %src_2 to i200*
  %297 = load i200, i200* %296
  %298 = trunc i200 %297 to i195
  %299 = lshr i195 %298, 176
  %_267.partselect = trunc i195 %299 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.3:                             ; preds = %src.addr.1640.exit
  %300 = bitcast i195* %src_3 to i200*
  %301 = load i200, i200* %300
  %302 = trunc i200 %301 to i195
  %303 = lshr i195 %302, 176
  %_368.partselect = trunc i195 %303 to i1
  br label %src.addr.1742.exit

src.addr.1742.exit:                               ; preds = %src.addr.1742.case.3, %src.addr.1742.case.2, %src.addr.1742.case.1, %src.addr.1742.case.0, %src.addr.1640.exit
  %304 = phi i1 [ %_065.partselect, %src.addr.1742.case.0 ], [ %_166.partselect, %src.addr.1742.case.1 ], [ %_267.partselect, %src.addr.1742.case.2 ], [ %_368.partselect, %src.addr.1742.case.3 ], [ undef, %src.addr.1640.exit ]
  store i1 %304, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 18
  switch i64 %for.loop.idx81, label %src.addr.1844.exit [
    i64 0, label %src.addr.1844.case.0
    i64 1, label %src.addr.1844.case.1
    i64 2, label %src.addr.1844.case.2
    i64 3, label %src.addr.1844.case.3
  ]

src.addr.1844.case.0:                             ; preds = %src.addr.1742.exit
  %305 = bitcast i195* %src_0 to i200*
  %306 = load i200, i200* %305
  %307 = trunc i200 %306 to i195
  %308 = lshr i195 %307, 177
  %_069.partselect = trunc i195 %308 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %309 = bitcast i195* %src_1 to i200*
  %310 = load i200, i200* %309
  %311 = trunc i200 %310 to i195
  %312 = lshr i195 %311, 177
  %_170.partselect = trunc i195 %312 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.2:                             ; preds = %src.addr.1742.exit
  %313 = bitcast i195* %src_2 to i200*
  %314 = load i200, i200* %313
  %315 = trunc i200 %314 to i195
  %316 = lshr i195 %315, 177
  %_271.partselect = trunc i195 %316 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.3:                             ; preds = %src.addr.1742.exit
  %317 = bitcast i195* %src_3 to i200*
  %318 = load i200, i200* %317
  %319 = trunc i200 %318 to i195
  %320 = lshr i195 %319, 177
  %_372.partselect = trunc i195 %320 to i1
  br label %src.addr.1844.exit

src.addr.1844.exit:                               ; preds = %src.addr.1844.case.3, %src.addr.1844.case.2, %src.addr.1844.case.1, %src.addr.1844.case.0, %src.addr.1742.exit
  %321 = phi i1 [ %_069.partselect, %src.addr.1844.case.0 ], [ %_170.partselect, %src.addr.1844.case.1 ], [ %_271.partselect, %src.addr.1844.case.2 ], [ %_372.partselect, %src.addr.1844.case.3 ], [ undef, %src.addr.1742.exit ]
  store i1 %321, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 19
  switch i64 %for.loop.idx81, label %src.addr.1946.exit [
    i64 0, label %src.addr.1946.case.0
    i64 1, label %src.addr.1946.case.1
    i64 2, label %src.addr.1946.case.2
    i64 3, label %src.addr.1946.case.3
  ]

src.addr.1946.case.0:                             ; preds = %src.addr.1844.exit
  %322 = bitcast i195* %src_0 to i200*
  %323 = load i200, i200* %322
  %324 = trunc i200 %323 to i195
  %325 = lshr i195 %324, 178
  %_073.partselect = trunc i195 %325 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %326 = bitcast i195* %src_1 to i200*
  %327 = load i200, i200* %326
  %328 = trunc i200 %327 to i195
  %329 = lshr i195 %328, 178
  %_174.partselect = trunc i195 %329 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.2:                             ; preds = %src.addr.1844.exit
  %330 = bitcast i195* %src_2 to i200*
  %331 = load i200, i200* %330
  %332 = trunc i200 %331 to i195
  %333 = lshr i195 %332, 178
  %_275.partselect = trunc i195 %333 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.3:                             ; preds = %src.addr.1844.exit
  %334 = bitcast i195* %src_3 to i200*
  %335 = load i200, i200* %334
  %336 = trunc i200 %335 to i195
  %337 = lshr i195 %336, 178
  %_376.partselect = trunc i195 %337 to i1
  br label %src.addr.1946.exit

src.addr.1946.exit:                               ; preds = %src.addr.1946.case.3, %src.addr.1946.case.2, %src.addr.1946.case.1, %src.addr.1946.case.0, %src.addr.1844.exit
  %338 = phi i1 [ %_073.partselect, %src.addr.1946.case.0 ], [ %_174.partselect, %src.addr.1946.case.1 ], [ %_275.partselect, %src.addr.1946.case.2 ], [ %_376.partselect, %src.addr.1946.case.3 ], [ undef, %src.addr.1844.exit ]
  store i1 %338, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 20
  switch i64 %for.loop.idx81, label %src.addr.2048.exit [
    i64 0, label %src.addr.2048.case.0
    i64 1, label %src.addr.2048.case.1
    i64 2, label %src.addr.2048.case.2
    i64 3, label %src.addr.2048.case.3
  ]

src.addr.2048.case.0:                             ; preds = %src.addr.1946.exit
  %339 = bitcast i195* %src_0 to i200*
  %340 = load i200, i200* %339
  %341 = trunc i200 %340 to i195
  %342 = lshr i195 %341, 179
  %_077.partselect = trunc i195 %342 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %343 = bitcast i195* %src_1 to i200*
  %344 = load i200, i200* %343
  %345 = trunc i200 %344 to i195
  %346 = lshr i195 %345, 179
  %_178.partselect = trunc i195 %346 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.2:                             ; preds = %src.addr.1946.exit
  %347 = bitcast i195* %src_2 to i200*
  %348 = load i200, i200* %347
  %349 = trunc i200 %348 to i195
  %350 = lshr i195 %349, 179
  %_279.partselect = trunc i195 %350 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.3:                             ; preds = %src.addr.1946.exit
  %351 = bitcast i195* %src_3 to i200*
  %352 = load i200, i200* %351
  %353 = trunc i200 %352 to i195
  %354 = lshr i195 %353, 179
  %_380.partselect = trunc i195 %354 to i1
  br label %src.addr.2048.exit

src.addr.2048.exit:                               ; preds = %src.addr.2048.case.3, %src.addr.2048.case.2, %src.addr.2048.case.1, %src.addr.2048.case.0, %src.addr.1946.exit
  %355 = phi i1 [ %_077.partselect, %src.addr.2048.case.0 ], [ %_178.partselect, %src.addr.2048.case.1 ], [ %_279.partselect, %src.addr.2048.case.2 ], [ %_380.partselect, %src.addr.2048.case.3 ], [ undef, %src.addr.1946.exit ]
  store i1 %355, i1* %dst.addr.2049, align 1
  %dst.addr.2151 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 21
  switch i64 %for.loop.idx81, label %src.addr.2150.exit [
    i64 0, label %src.addr.2150.case.0
    i64 1, label %src.addr.2150.case.1
    i64 2, label %src.addr.2150.case.2
    i64 3, label %src.addr.2150.case.3
  ]

src.addr.2150.case.0:                             ; preds = %src.addr.2048.exit
  %356 = bitcast i195* %src_0 to i200*
  %357 = load i200, i200* %356
  %358 = trunc i200 %357 to i195
  %359 = lshr i195 %358, 180
  %_081.partselect = trunc i195 %359 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.1:                             ; preds = %src.addr.2048.exit
  %360 = bitcast i195* %src_1 to i200*
  %361 = load i200, i200* %360
  %362 = trunc i200 %361 to i195
  %363 = lshr i195 %362, 180
  %_182.partselect = trunc i195 %363 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.2:                             ; preds = %src.addr.2048.exit
  %364 = bitcast i195* %src_2 to i200*
  %365 = load i200, i200* %364
  %366 = trunc i200 %365 to i195
  %367 = lshr i195 %366, 180
  %_283.partselect = trunc i195 %367 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.3:                             ; preds = %src.addr.2048.exit
  %368 = bitcast i195* %src_3 to i200*
  %369 = load i200, i200* %368
  %370 = trunc i200 %369 to i195
  %371 = lshr i195 %370, 180
  %_384.partselect = trunc i195 %371 to i1
  br label %src.addr.2150.exit

src.addr.2150.exit:                               ; preds = %src.addr.2150.case.3, %src.addr.2150.case.2, %src.addr.2150.case.1, %src.addr.2150.case.0, %src.addr.2048.exit
  %372 = phi i1 [ %_081.partselect, %src.addr.2150.case.0 ], [ %_182.partselect, %src.addr.2150.case.1 ], [ %_283.partselect, %src.addr.2150.case.2 ], [ %_384.partselect, %src.addr.2150.case.3 ], [ undef, %src.addr.2048.exit ]
  store i1 %372, i1* %dst.addr.2151, align 1
  %dst.addr.2253 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 22
  switch i64 %for.loop.idx81, label %src.addr.2252.exit [
    i64 0, label %src.addr.2252.case.0
    i64 1, label %src.addr.2252.case.1
    i64 2, label %src.addr.2252.case.2
    i64 3, label %src.addr.2252.case.3
  ]

src.addr.2252.case.0:                             ; preds = %src.addr.2150.exit
  %373 = bitcast i195* %src_0 to i200*
  %374 = load i200, i200* %373
  %375 = trunc i200 %374 to i195
  %376 = lshr i195 %375, 181
  %_085.partselect = trunc i195 %376 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.1:                             ; preds = %src.addr.2150.exit
  %377 = bitcast i195* %src_1 to i200*
  %378 = load i200, i200* %377
  %379 = trunc i200 %378 to i195
  %380 = lshr i195 %379, 181
  %_186.partselect = trunc i195 %380 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.2:                             ; preds = %src.addr.2150.exit
  %381 = bitcast i195* %src_2 to i200*
  %382 = load i200, i200* %381
  %383 = trunc i200 %382 to i195
  %384 = lshr i195 %383, 181
  %_287.partselect = trunc i195 %384 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.3:                             ; preds = %src.addr.2150.exit
  %385 = bitcast i195* %src_3 to i200*
  %386 = load i200, i200* %385
  %387 = trunc i200 %386 to i195
  %388 = lshr i195 %387, 181
  %_388.partselect = trunc i195 %388 to i1
  br label %src.addr.2252.exit

src.addr.2252.exit:                               ; preds = %src.addr.2252.case.3, %src.addr.2252.case.2, %src.addr.2252.case.1, %src.addr.2252.case.0, %src.addr.2150.exit
  %389 = phi i1 [ %_085.partselect, %src.addr.2252.case.0 ], [ %_186.partselect, %src.addr.2252.case.1 ], [ %_287.partselect, %src.addr.2252.case.2 ], [ %_388.partselect, %src.addr.2252.case.3 ], [ undef, %src.addr.2150.exit ]
  store i1 %389, i1* %dst.addr.2253, align 1
  %dst.addr.2355 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 23
  switch i64 %for.loop.idx81, label %src.addr.2354.exit [
    i64 0, label %src.addr.2354.case.0
    i64 1, label %src.addr.2354.case.1
    i64 2, label %src.addr.2354.case.2
    i64 3, label %src.addr.2354.case.3
  ]

src.addr.2354.case.0:                             ; preds = %src.addr.2252.exit
  %390 = bitcast i195* %src_0 to i200*
  %391 = load i200, i200* %390
  %392 = trunc i200 %391 to i195
  %393 = lshr i195 %392, 182
  %_089.partselect = trunc i195 %393 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.1:                             ; preds = %src.addr.2252.exit
  %394 = bitcast i195* %src_1 to i200*
  %395 = load i200, i200* %394
  %396 = trunc i200 %395 to i195
  %397 = lshr i195 %396, 182
  %_190.partselect = trunc i195 %397 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.2:                             ; preds = %src.addr.2252.exit
  %398 = bitcast i195* %src_2 to i200*
  %399 = load i200, i200* %398
  %400 = trunc i200 %399 to i195
  %401 = lshr i195 %400, 182
  %_291.partselect = trunc i195 %401 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.3:                             ; preds = %src.addr.2252.exit
  %402 = bitcast i195* %src_3 to i200*
  %403 = load i200, i200* %402
  %404 = trunc i200 %403 to i195
  %405 = lshr i195 %404, 182
  %_392.partselect = trunc i195 %405 to i1
  br label %src.addr.2354.exit

src.addr.2354.exit:                               ; preds = %src.addr.2354.case.3, %src.addr.2354.case.2, %src.addr.2354.case.1, %src.addr.2354.case.0, %src.addr.2252.exit
  %406 = phi i1 [ %_089.partselect, %src.addr.2354.case.0 ], [ %_190.partselect, %src.addr.2354.case.1 ], [ %_291.partselect, %src.addr.2354.case.2 ], [ %_392.partselect, %src.addr.2354.case.3 ], [ undef, %src.addr.2252.exit ]
  store i1 %406, i1* %dst.addr.2355, align 1
  %dst.addr.2457 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 24
  switch i64 %for.loop.idx81, label %src.addr.2456.exit [
    i64 0, label %src.addr.2456.case.0
    i64 1, label %src.addr.2456.case.1
    i64 2, label %src.addr.2456.case.2
    i64 3, label %src.addr.2456.case.3
  ]

src.addr.2456.case.0:                             ; preds = %src.addr.2354.exit
  %407 = bitcast i195* %src_0 to i200*
  %408 = load i200, i200* %407
  %409 = trunc i200 %408 to i195
  %410 = lshr i195 %409, 183
  %_093.partselect = trunc i195 %410 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.1:                             ; preds = %src.addr.2354.exit
  %411 = bitcast i195* %src_1 to i200*
  %412 = load i200, i200* %411
  %413 = trunc i200 %412 to i195
  %414 = lshr i195 %413, 183
  %_194.partselect = trunc i195 %414 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.2:                             ; preds = %src.addr.2354.exit
  %415 = bitcast i195* %src_2 to i200*
  %416 = load i200, i200* %415
  %417 = trunc i200 %416 to i195
  %418 = lshr i195 %417, 183
  %_295.partselect = trunc i195 %418 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.3:                             ; preds = %src.addr.2354.exit
  %419 = bitcast i195* %src_3 to i200*
  %420 = load i200, i200* %419
  %421 = trunc i200 %420 to i195
  %422 = lshr i195 %421, 183
  %_396.partselect = trunc i195 %422 to i1
  br label %src.addr.2456.exit

src.addr.2456.exit:                               ; preds = %src.addr.2456.case.3, %src.addr.2456.case.2, %src.addr.2456.case.1, %src.addr.2456.case.0, %src.addr.2354.exit
  %423 = phi i1 [ %_093.partselect, %src.addr.2456.case.0 ], [ %_194.partselect, %src.addr.2456.case.1 ], [ %_295.partselect, %src.addr.2456.case.2 ], [ %_396.partselect, %src.addr.2456.case.3 ], [ undef, %src.addr.2354.exit ]
  store i1 %423, i1* %dst.addr.2457, align 1
  %dst.addr.2559 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 25
  switch i64 %for.loop.idx81, label %src.addr.2558.exit [
    i64 0, label %src.addr.2558.case.0
    i64 1, label %src.addr.2558.case.1
    i64 2, label %src.addr.2558.case.2
    i64 3, label %src.addr.2558.case.3
  ]

src.addr.2558.case.0:                             ; preds = %src.addr.2456.exit
  %424 = bitcast i195* %src_0 to i200*
  %425 = load i200, i200* %424
  %426 = trunc i200 %425 to i195
  %427 = lshr i195 %426, 184
  %_097.partselect = trunc i195 %427 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.1:                             ; preds = %src.addr.2456.exit
  %428 = bitcast i195* %src_1 to i200*
  %429 = load i200, i200* %428
  %430 = trunc i200 %429 to i195
  %431 = lshr i195 %430, 184
  %_198.partselect = trunc i195 %431 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.2:                             ; preds = %src.addr.2456.exit
  %432 = bitcast i195* %src_2 to i200*
  %433 = load i200, i200* %432
  %434 = trunc i200 %433 to i195
  %435 = lshr i195 %434, 184
  %_299.partselect = trunc i195 %435 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.3:                             ; preds = %src.addr.2456.exit
  %436 = bitcast i195* %src_3 to i200*
  %437 = load i200, i200* %436
  %438 = trunc i200 %437 to i195
  %439 = lshr i195 %438, 184
  %_3100.partselect = trunc i195 %439 to i1
  br label %src.addr.2558.exit

src.addr.2558.exit:                               ; preds = %src.addr.2558.case.3, %src.addr.2558.case.2, %src.addr.2558.case.1, %src.addr.2558.case.0, %src.addr.2456.exit
  %440 = phi i1 [ %_097.partselect, %src.addr.2558.case.0 ], [ %_198.partselect, %src.addr.2558.case.1 ], [ %_299.partselect, %src.addr.2558.case.2 ], [ %_3100.partselect, %src.addr.2558.case.3 ], [ undef, %src.addr.2456.exit ]
  store i1 %440, i1* %dst.addr.2559, align 1
  %dst.addr.2661 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 26
  switch i64 %for.loop.idx81, label %src.addr.2660.exit [
    i64 0, label %src.addr.2660.case.0
    i64 1, label %src.addr.2660.case.1
    i64 2, label %src.addr.2660.case.2
    i64 3, label %src.addr.2660.case.3
  ]

src.addr.2660.case.0:                             ; preds = %src.addr.2558.exit
  %441 = bitcast i195* %src_0 to i200*
  %442 = load i200, i200* %441
  %443 = trunc i200 %442 to i195
  %444 = lshr i195 %443, 185
  %_0101.partselect = trunc i195 %444 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.1:                             ; preds = %src.addr.2558.exit
  %445 = bitcast i195* %src_1 to i200*
  %446 = load i200, i200* %445
  %447 = trunc i200 %446 to i195
  %448 = lshr i195 %447, 185
  %_1102.partselect = trunc i195 %448 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.2:                             ; preds = %src.addr.2558.exit
  %449 = bitcast i195* %src_2 to i200*
  %450 = load i200, i200* %449
  %451 = trunc i200 %450 to i195
  %452 = lshr i195 %451, 185
  %_2103.partselect = trunc i195 %452 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.3:                             ; preds = %src.addr.2558.exit
  %453 = bitcast i195* %src_3 to i200*
  %454 = load i200, i200* %453
  %455 = trunc i200 %454 to i195
  %456 = lshr i195 %455, 185
  %_3104.partselect = trunc i195 %456 to i1
  br label %src.addr.2660.exit

src.addr.2660.exit:                               ; preds = %src.addr.2660.case.3, %src.addr.2660.case.2, %src.addr.2660.case.1, %src.addr.2660.case.0, %src.addr.2558.exit
  %457 = phi i1 [ %_0101.partselect, %src.addr.2660.case.0 ], [ %_1102.partselect, %src.addr.2660.case.1 ], [ %_2103.partselect, %src.addr.2660.case.2 ], [ %_3104.partselect, %src.addr.2660.case.3 ], [ undef, %src.addr.2558.exit ]
  store i1 %457, i1* %dst.addr.2661, align 1
  %dst.addr.2763 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 27
  switch i64 %for.loop.idx81, label %src.addr.2762.exit [
    i64 0, label %src.addr.2762.case.0
    i64 1, label %src.addr.2762.case.1
    i64 2, label %src.addr.2762.case.2
    i64 3, label %src.addr.2762.case.3
  ]

src.addr.2762.case.0:                             ; preds = %src.addr.2660.exit
  %458 = bitcast i195* %src_0 to i200*
  %459 = load i200, i200* %458
  %460 = trunc i200 %459 to i195
  %461 = lshr i195 %460, 186
  %_0105.partselect = trunc i195 %461 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.1:                             ; preds = %src.addr.2660.exit
  %462 = bitcast i195* %src_1 to i200*
  %463 = load i200, i200* %462
  %464 = trunc i200 %463 to i195
  %465 = lshr i195 %464, 186
  %_1106.partselect = trunc i195 %465 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.2:                             ; preds = %src.addr.2660.exit
  %466 = bitcast i195* %src_2 to i200*
  %467 = load i200, i200* %466
  %468 = trunc i200 %467 to i195
  %469 = lshr i195 %468, 186
  %_2107.partselect = trunc i195 %469 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.3:                             ; preds = %src.addr.2660.exit
  %470 = bitcast i195* %src_3 to i200*
  %471 = load i200, i200* %470
  %472 = trunc i200 %471 to i195
  %473 = lshr i195 %472, 186
  %_3108.partselect = trunc i195 %473 to i1
  br label %src.addr.2762.exit

src.addr.2762.exit:                               ; preds = %src.addr.2762.case.3, %src.addr.2762.case.2, %src.addr.2762.case.1, %src.addr.2762.case.0, %src.addr.2660.exit
  %474 = phi i1 [ %_0105.partselect, %src.addr.2762.case.0 ], [ %_1106.partselect, %src.addr.2762.case.1 ], [ %_2107.partselect, %src.addr.2762.case.2 ], [ %_3108.partselect, %src.addr.2762.case.3 ], [ undef, %src.addr.2660.exit ]
  store i1 %474, i1* %dst.addr.2763, align 1
  %dst.addr.2865 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 28
  switch i64 %for.loop.idx81, label %src.addr.2864.exit [
    i64 0, label %src.addr.2864.case.0
    i64 1, label %src.addr.2864.case.1
    i64 2, label %src.addr.2864.case.2
    i64 3, label %src.addr.2864.case.3
  ]

src.addr.2864.case.0:                             ; preds = %src.addr.2762.exit
  %475 = bitcast i195* %src_0 to i200*
  %476 = load i200, i200* %475
  %477 = trunc i200 %476 to i195
  %478 = lshr i195 %477, 187
  %_0109.partselect = trunc i195 %478 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.1:                             ; preds = %src.addr.2762.exit
  %479 = bitcast i195* %src_1 to i200*
  %480 = load i200, i200* %479
  %481 = trunc i200 %480 to i195
  %482 = lshr i195 %481, 187
  %_1110.partselect = trunc i195 %482 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.2:                             ; preds = %src.addr.2762.exit
  %483 = bitcast i195* %src_2 to i200*
  %484 = load i200, i200* %483
  %485 = trunc i200 %484 to i195
  %486 = lshr i195 %485, 187
  %_2111.partselect = trunc i195 %486 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.3:                             ; preds = %src.addr.2762.exit
  %487 = bitcast i195* %src_3 to i200*
  %488 = load i200, i200* %487
  %489 = trunc i200 %488 to i195
  %490 = lshr i195 %489, 187
  %_3112.partselect = trunc i195 %490 to i1
  br label %src.addr.2864.exit

src.addr.2864.exit:                               ; preds = %src.addr.2864.case.3, %src.addr.2864.case.2, %src.addr.2864.case.1, %src.addr.2864.case.0, %src.addr.2762.exit
  %491 = phi i1 [ %_0109.partselect, %src.addr.2864.case.0 ], [ %_1110.partselect, %src.addr.2864.case.1 ], [ %_2111.partselect, %src.addr.2864.case.2 ], [ %_3112.partselect, %src.addr.2864.case.3 ], [ undef, %src.addr.2762.exit ]
  store i1 %491, i1* %dst.addr.2865, align 1
  %dst.addr.2967 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 29
  switch i64 %for.loop.idx81, label %src.addr.2966.exit [
    i64 0, label %src.addr.2966.case.0
    i64 1, label %src.addr.2966.case.1
    i64 2, label %src.addr.2966.case.2
    i64 3, label %src.addr.2966.case.3
  ]

src.addr.2966.case.0:                             ; preds = %src.addr.2864.exit
  %492 = bitcast i195* %src_0 to i200*
  %493 = load i200, i200* %492
  %494 = trunc i200 %493 to i195
  %495 = lshr i195 %494, 188
  %_0113.partselect = trunc i195 %495 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.1:                             ; preds = %src.addr.2864.exit
  %496 = bitcast i195* %src_1 to i200*
  %497 = load i200, i200* %496
  %498 = trunc i200 %497 to i195
  %499 = lshr i195 %498, 188
  %_1114.partselect = trunc i195 %499 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.2:                             ; preds = %src.addr.2864.exit
  %500 = bitcast i195* %src_2 to i200*
  %501 = load i200, i200* %500
  %502 = trunc i200 %501 to i195
  %503 = lshr i195 %502, 188
  %_2115.partselect = trunc i195 %503 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.3:                             ; preds = %src.addr.2864.exit
  %504 = bitcast i195* %src_3 to i200*
  %505 = load i200, i200* %504
  %506 = trunc i200 %505 to i195
  %507 = lshr i195 %506, 188
  %_3116.partselect = trunc i195 %507 to i1
  br label %src.addr.2966.exit

src.addr.2966.exit:                               ; preds = %src.addr.2966.case.3, %src.addr.2966.case.2, %src.addr.2966.case.1, %src.addr.2966.case.0, %src.addr.2864.exit
  %508 = phi i1 [ %_0113.partselect, %src.addr.2966.case.0 ], [ %_1114.partselect, %src.addr.2966.case.1 ], [ %_2115.partselect, %src.addr.2966.case.2 ], [ %_3116.partselect, %src.addr.2966.case.3 ], [ undef, %src.addr.2864.exit ]
  store i1 %508, i1* %dst.addr.2967, align 1
  %dst.addr.3069 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 30
  switch i64 %for.loop.idx81, label %src.addr.3068.exit [
    i64 0, label %src.addr.3068.case.0
    i64 1, label %src.addr.3068.case.1
    i64 2, label %src.addr.3068.case.2
    i64 3, label %src.addr.3068.case.3
  ]

src.addr.3068.case.0:                             ; preds = %src.addr.2966.exit
  %509 = bitcast i195* %src_0 to i200*
  %510 = load i200, i200* %509
  %511 = trunc i200 %510 to i195
  %512 = lshr i195 %511, 189
  %_0117.partselect = trunc i195 %512 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.1:                             ; preds = %src.addr.2966.exit
  %513 = bitcast i195* %src_1 to i200*
  %514 = load i200, i200* %513
  %515 = trunc i200 %514 to i195
  %516 = lshr i195 %515, 189
  %_1118.partselect = trunc i195 %516 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.2:                             ; preds = %src.addr.2966.exit
  %517 = bitcast i195* %src_2 to i200*
  %518 = load i200, i200* %517
  %519 = trunc i200 %518 to i195
  %520 = lshr i195 %519, 189
  %_2119.partselect = trunc i195 %520 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.3:                             ; preds = %src.addr.2966.exit
  %521 = bitcast i195* %src_3 to i200*
  %522 = load i200, i200* %521
  %523 = trunc i200 %522 to i195
  %524 = lshr i195 %523, 189
  %_3120.partselect = trunc i195 %524 to i1
  br label %src.addr.3068.exit

src.addr.3068.exit:                               ; preds = %src.addr.3068.case.3, %src.addr.3068.case.2, %src.addr.3068.case.1, %src.addr.3068.case.0, %src.addr.2966.exit
  %525 = phi i1 [ %_0117.partselect, %src.addr.3068.case.0 ], [ %_1118.partselect, %src.addr.3068.case.1 ], [ %_2119.partselect, %src.addr.3068.case.2 ], [ %_3120.partselect, %src.addr.3068.case.3 ], [ undef, %src.addr.2966.exit ]
  store i1 %525, i1* %dst.addr.3069, align 1
  %dst.addr.3171 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 31
  switch i64 %for.loop.idx81, label %src.addr.3170.exit [
    i64 0, label %src.addr.3170.case.0
    i64 1, label %src.addr.3170.case.1
    i64 2, label %src.addr.3170.case.2
    i64 3, label %src.addr.3170.case.3
  ]

src.addr.3170.case.0:                             ; preds = %src.addr.3068.exit
  %526 = bitcast i195* %src_0 to i200*
  %527 = load i200, i200* %526
  %528 = trunc i200 %527 to i195
  %529 = lshr i195 %528, 190
  %_0121.partselect = trunc i195 %529 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.1:                             ; preds = %src.addr.3068.exit
  %530 = bitcast i195* %src_1 to i200*
  %531 = load i200, i200* %530
  %532 = trunc i200 %531 to i195
  %533 = lshr i195 %532, 190
  %_1122.partselect = trunc i195 %533 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.2:                             ; preds = %src.addr.3068.exit
  %534 = bitcast i195* %src_2 to i200*
  %535 = load i200, i200* %534
  %536 = trunc i200 %535 to i195
  %537 = lshr i195 %536, 190
  %_2123.partselect = trunc i195 %537 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.3:                             ; preds = %src.addr.3068.exit
  %538 = bitcast i195* %src_3 to i200*
  %539 = load i200, i200* %538
  %540 = trunc i200 %539 to i195
  %541 = lshr i195 %540, 190
  %_3124.partselect = trunc i195 %541 to i1
  br label %src.addr.3170.exit

src.addr.3170.exit:                               ; preds = %src.addr.3170.case.3, %src.addr.3170.case.2, %src.addr.3170.case.1, %src.addr.3170.case.0, %src.addr.3068.exit
  %542 = phi i1 [ %_0121.partselect, %src.addr.3170.case.0 ], [ %_1122.partselect, %src.addr.3170.case.1 ], [ %_2123.partselect, %src.addr.3170.case.2 ], [ %_3124.partselect, %src.addr.3170.case.3 ], [ undef, %src.addr.3068.exit ]
  store i1 %542, i1* %dst.addr.3171, align 1
  %dst.addr.3273 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 32
  switch i64 %for.loop.idx81, label %src.addr.3272.exit [
    i64 0, label %src.addr.3272.case.0
    i64 1, label %src.addr.3272.case.1
    i64 2, label %src.addr.3272.case.2
    i64 3, label %src.addr.3272.case.3
  ]

src.addr.3272.case.0:                             ; preds = %src.addr.3170.exit
  %543 = bitcast i195* %src_0 to i200*
  %544 = load i200, i200* %543
  %545 = trunc i200 %544 to i195
  %546 = lshr i195 %545, 191
  %_0125.partselect = trunc i195 %546 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.1:                             ; preds = %src.addr.3170.exit
  %547 = bitcast i195* %src_1 to i200*
  %548 = load i200, i200* %547
  %549 = trunc i200 %548 to i195
  %550 = lshr i195 %549, 191
  %_1126.partselect = trunc i195 %550 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.2:                             ; preds = %src.addr.3170.exit
  %551 = bitcast i195* %src_2 to i200*
  %552 = load i200, i200* %551
  %553 = trunc i200 %552 to i195
  %554 = lshr i195 %553, 191
  %_2127.partselect = trunc i195 %554 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.3:                             ; preds = %src.addr.3170.exit
  %555 = bitcast i195* %src_3 to i200*
  %556 = load i200, i200* %555
  %557 = trunc i200 %556 to i195
  %558 = lshr i195 %557, 191
  %_3128.partselect = trunc i195 %558 to i1
  br label %src.addr.3272.exit

src.addr.3272.exit:                               ; preds = %src.addr.3272.case.3, %src.addr.3272.case.2, %src.addr.3272.case.1, %src.addr.3272.case.0, %src.addr.3170.exit
  %559 = phi i1 [ %_0125.partselect, %src.addr.3272.case.0 ], [ %_1126.partselect, %src.addr.3272.case.1 ], [ %_2127.partselect, %src.addr.3272.case.2 ], [ %_3128.partselect, %src.addr.3272.case.3 ], [ undef, %src.addr.3170.exit ]
  store i1 %559, i1* %dst.addr.3273, align 1
  %dst.addr.3375 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 33
  switch i64 %for.loop.idx81, label %src.addr.3374.exit [
    i64 0, label %src.addr.3374.case.0
    i64 1, label %src.addr.3374.case.1
    i64 2, label %src.addr.3374.case.2
    i64 3, label %src.addr.3374.case.3
  ]

src.addr.3374.case.0:                             ; preds = %src.addr.3272.exit
  %560 = bitcast i195* %src_0 to i200*
  %561 = load i200, i200* %560
  %562 = trunc i200 %561 to i195
  %563 = lshr i195 %562, 192
  %_0129.partselect = trunc i195 %563 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.1:                             ; preds = %src.addr.3272.exit
  %564 = bitcast i195* %src_1 to i200*
  %565 = load i200, i200* %564
  %566 = trunc i200 %565 to i195
  %567 = lshr i195 %566, 192
  %_1130.partselect = trunc i195 %567 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.2:                             ; preds = %src.addr.3272.exit
  %568 = bitcast i195* %src_2 to i200*
  %569 = load i200, i200* %568
  %570 = trunc i200 %569 to i195
  %571 = lshr i195 %570, 192
  %_2131.partselect = trunc i195 %571 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.3:                             ; preds = %src.addr.3272.exit
  %572 = bitcast i195* %src_3 to i200*
  %573 = load i200, i200* %572
  %574 = trunc i200 %573 to i195
  %575 = lshr i195 %574, 192
  %_3132.partselect = trunc i195 %575 to i1
  br label %src.addr.3374.exit

src.addr.3374.exit:                               ; preds = %src.addr.3374.case.3, %src.addr.3374.case.2, %src.addr.3374.case.1, %src.addr.3374.case.0, %src.addr.3272.exit
  %576 = phi i1 [ %_0129.partselect, %src.addr.3374.case.0 ], [ %_1130.partselect, %src.addr.3374.case.1 ], [ %_2131.partselect, %src.addr.3374.case.2 ], [ %_3132.partselect, %src.addr.3374.case.3 ], [ undef, %src.addr.3272.exit ]
  store i1 %576, i1* %dst.addr.3375, align 1
  %dst.addr.3477 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 34
  switch i64 %for.loop.idx81, label %src.addr.3476.exit [
    i64 0, label %src.addr.3476.case.0
    i64 1, label %src.addr.3476.case.1
    i64 2, label %src.addr.3476.case.2
    i64 3, label %src.addr.3476.case.3
  ]

src.addr.3476.case.0:                             ; preds = %src.addr.3374.exit
  %577 = bitcast i195* %src_0 to i200*
  %578 = load i200, i200* %577
  %579 = trunc i200 %578 to i195
  %580 = lshr i195 %579, 193
  %_0133.partselect = trunc i195 %580 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.1:                             ; preds = %src.addr.3374.exit
  %581 = bitcast i195* %src_1 to i200*
  %582 = load i200, i200* %581
  %583 = trunc i200 %582 to i195
  %584 = lshr i195 %583, 193
  %_1134.partselect = trunc i195 %584 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.2:                             ; preds = %src.addr.3374.exit
  %585 = bitcast i195* %src_2 to i200*
  %586 = load i200, i200* %585
  %587 = trunc i200 %586 to i195
  %588 = lshr i195 %587, 193
  %_2135.partselect = trunc i195 %588 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.3:                             ; preds = %src.addr.3374.exit
  %589 = bitcast i195* %src_3 to i200*
  %590 = load i200, i200* %589
  %591 = trunc i200 %590 to i195
  %592 = lshr i195 %591, 193
  %_3136.partselect = trunc i195 %592 to i1
  br label %src.addr.3476.exit

src.addr.3476.exit:                               ; preds = %src.addr.3476.case.3, %src.addr.3476.case.2, %src.addr.3476.case.1, %src.addr.3476.case.0, %src.addr.3374.exit
  %593 = phi i1 [ %_0133.partselect, %src.addr.3476.case.0 ], [ %_1134.partselect, %src.addr.3476.case.1 ], [ %_2135.partselect, %src.addr.3476.case.2 ], [ %_3136.partselect, %src.addr.3476.case.3 ], [ undef, %src.addr.3374.exit ]
  store i1 %593, i1* %dst.addr.3477, align 1
  %dst.addr.3579 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 35
  switch i64 %for.loop.idx81, label %src.addr.3578.exit [
    i64 0, label %src.addr.3578.case.0
    i64 1, label %src.addr.3578.case.1
    i64 2, label %src.addr.3578.case.2
    i64 3, label %src.addr.3578.case.3
  ]

src.addr.3578.case.0:                             ; preds = %src.addr.3476.exit
  %594 = bitcast i195* %src_0 to i200*
  %595 = load i200, i200* %594
  %596 = trunc i200 %595 to i195
  %597 = lshr i195 %596, 194
  %_0137.partselect = trunc i195 %597 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.1:                             ; preds = %src.addr.3476.exit
  %598 = bitcast i195* %src_1 to i200*
  %599 = load i200, i200* %598
  %600 = trunc i200 %599 to i195
  %601 = lshr i195 %600, 194
  %_1138.partselect = trunc i195 %601 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.2:                             ; preds = %src.addr.3476.exit
  %602 = bitcast i195* %src_2 to i200*
  %603 = load i200, i200* %602
  %604 = trunc i200 %603 to i195
  %605 = lshr i195 %604, 194
  %_2139.partselect = trunc i195 %605 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.3:                             ; preds = %src.addr.3476.exit
  %606 = bitcast i195* %src_3 to i200*
  %607 = load i200, i200* %606
  %608 = trunc i200 %607 to i195
  %609 = lshr i195 %608, 194
  %_3140.partselect = trunc i195 %609 to i1
  br label %src.addr.3578.exit

src.addr.3578.exit:                               ; preds = %src.addr.3578.case.3, %src.addr.3578.case.2, %src.addr.3578.case.1, %src.addr.3578.case.0, %src.addr.3476.exit
  %610 = phi i1 [ %_0137.partselect, %src.addr.3578.case.0 ], [ %_1138.partselect, %src.addr.3578.case.1 ], [ %_2139.partselect, %src.addr.3578.case.2 ], [ %_3140.partselect, %src.addr.3578.case.3 ], [ undef, %src.addr.3476.exit ]
  store i1 %610, i1* %dst.addr.3579, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx81, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.3578.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.17.20([4 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i195* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i195* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1, i195* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.2" %src_2, i195* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.3" %src_3) #1 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i195* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.18.19([4 x %struct.HeadCtx]* nonnull %dst, i195* nonnull %src_0, i195* %src_1, i195* %src_2, i195* %src_3, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out(i32* noalias "orig.arg.no"="0", i32* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i8* noalias "orig.arg.no"="10", i8* noalias readonly align 512 "orig.arg.no"="11", i32* noalias "orig.arg.no"="12", i32* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i32* noalias "orig.arg.no"="16", i32* noalias readonly align 512 "orig.arg.no"="17", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="18", i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.0" %_0, i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.1" %_1, i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.2" %_2, i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.3" %_3, i1* noalias "orig.arg.no"="20", i1* noalias readonly align 512 "orig.arg.no"="21", i32* noalias "orig.arg.no"="22", i32* noalias readonly align 512 "orig.arg.no"="23", i1* noalias "orig.arg.no"="24", i1* noalias readonly align 512 "orig.arg.no"="25", i32* noalias "orig.arg.no"="26", i32* noalias readonly align 512 "orig.arg.no"="27", i1* noalias "orig.arg.no"="28", i1* noalias readonly align 512 "orig.arg.no"="29", i1* noalias "orig.arg.no"="30", i1* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i32(i32* %0, i32* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %8, i1* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %10, i8* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %12, i32* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %16, i32* align 512 %17)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.17.20([4 x %struct.HeadCtx]* %18, i195* align 512 %_0, i195* align 512 %_1, i195* align 512 %_2, i195* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %19, i1* align 512 %20)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %21, i32* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %23, i1* align 512 %24)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %25, i32* align 512 %26)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %27, i1* align 512 %28)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %29, i1* align 512 %30)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %31, i32* align 512 %32)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %33, i32* align 512 %34)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare void @apatb_scheduler_hls_hw(i1, i1, i32*, i1*, i1*, i1, i1, i1*, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1, i1, i1, i195*, i195*, i195*, i195*, i1*, i32*, i1*, i32*, i1, i1*, i1, i1*, i32*, i32*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back(i32* noalias "orig.arg.no"="0", i32* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i8* noalias "orig.arg.no"="10", i8* noalias readonly align 512 "orig.arg.no"="11", i32* noalias "orig.arg.no"="12", i32* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i32* noalias "orig.arg.no"="16", i32* noalias readonly align 512 "orig.arg.no"="17", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="18", i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.0" %_0, i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.1" %_1, i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.2" %_2, i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.3" %_3, i1* noalias "orig.arg.no"="20", i1* noalias readonly align 512 "orig.arg.no"="21", i32* noalias "orig.arg.no"="22", i32* noalias readonly align 512 "orig.arg.no"="23", i1* noalias "orig.arg.no"="24", i1* noalias readonly align 512 "orig.arg.no"="25", i32* noalias "orig.arg.no"="26", i32* noalias readonly align 512 "orig.arg.no"="27", i1* noalias "orig.arg.no"="28", i1* noalias readonly align 512 "orig.arg.no"="29", i1* noalias "orig.arg.no"="30", i1* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i32(i32* %0, i32* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %8, i1* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %10, i8* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %12, i32* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %16, i32* align 512 %17)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.17.20([4 x %struct.HeadCtx]* %18, i195* align 512 %_0, i195* align 512 %_1, i195* align 512 %_2, i195* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %19, i1* align 512 %20)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %21, i32* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %23, i1* align 512 %24)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %25, i32* align 512 %26)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %27, i1* align 512 %28)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %29, i1* align 512 %30)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %31, i32* align 512 %32)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %33, i32* align 512 %34)
  ret void
}

declare void @scheduler_hls_hw_stub(i1 zeroext, i1 zeroext, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i8* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, [4 x %struct.HeadCtx]* noalias nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull)

define void @scheduler_hls_hw_stub_wrapper(i1, i1, i32*, i1*, i1*, i1, i1, i1*, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1, i1, i1, i195*, i195*, i195*, i195*, i1*, i32*, i1*, i32*, i1, i1*, i1, i1*, i32*, i32*) #5 {
entry:
  %33 = call i8* @malloc(i64 208)
  %34 = bitcast i8* %33 to [4 x %struct.HeadCtx]*
  call void @copy_out(i32* null, i32* %2, i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %7, i1* null, i1* %9, i8* null, i8* %10, i32* null, i32* %11, i32* null, i32* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %34, i195* %19, i195* %20, i195* %21, i195* %22, i1* null, i1* %23, i32* null, i32* %24, i1* null, i1* %25, i32* null, i32* %26, i1* null, i1* %28, i1* null, i1* %30, i32* null, i32* %31, i32* null, i32* %32)
  call void @scheduler_hls_hw_stub(i1 %0, i1 %1, i32* %2, i1* %3, i1* %4, i1 %5, i1 %6, i1* %7, i1 %8, i1* %9, i8* %10, i32* %11, i32* %12, i32* %13, i1 %14, i1 %15, i1 %16, i1 %17, i1 %18, [4 x %struct.HeadCtx]* %34, i1* %23, i32* %24, i1* %25, i32* %26, i1 %27, i1* %28, i1 %29, i1* %30, i32* %31, i32* %32)
  call void @copy_in(i32* null, i32* %2, i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %7, i1* null, i1* %9, i8* null, i8* %10, i32* null, i32* %11, i32* null, i32* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %34, i195* %19, i195* %20, i195* %21, i195* %22, i1* null, i1* %23, i32* null, i32* %24, i1* null, i1* %25, i32* null, i32* %26, i1* null, i1* %28, i1* null, i1* %30, i32* null, i32* %31, i32* null, i32* %32)
  call void @free(i8* %33)
  ret void
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
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
!7 = !{!"19", [4 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12, !13, !14}
!11 = !{!"19.0", %struct.HeadCtx* null}
!12 = !{!"19.1", %struct.HeadCtx* null}
!13 = !{!"19.2", %struct.HeadCtx* null}
!14 = !{!"19.3", %struct.HeadCtx* null}
