; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_total/Scheduler_FSM_DMA_heads/scheduler_hls/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i8, i8, i8, i1, i1, i8, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }

; Function Attrs: noinline willreturn
define void @apatb_scheduler_hls_ir(i1 zeroext %cntrl_start, i1 zeroext %cntrl_reset_n, i32* noalias nocapture nonnull dereferenceable(4) %cntrl_layer_idx, i1* noalias nocapture nonnull dereferenceable(1) %cntrl_busy, i1* noalias nocapture nonnull dereferenceable(1) %cntrl_start_out, i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %wl_ready, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i8* noalias nocapture nonnull dereferenceable(1) %wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %wl_head, i32* noalias nocapture nonnull dereferenceable(4) %wl_tile, i1 zeroext %dma_done, i1 zeroext %compute_ready, i1 zeroext %compute_done, i1 zeroext %requant_ready, i1 zeroext %requant_done, [2 x %struct.HeadCtx]* noalias nonnull dereferenceable(104) "partition" %head_ctx_ref, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i32* noalias nocapture nonnull dereferenceable(4) %compute_op, i1* noalias nocapture nonnull dereferenceable(1) %requant_start, i32* noalias nocapture nonnull dereferenceable(4) %requant_op, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i1* noalias nocapture nonnull dereferenceable(1) %done, i32* noalias nocapture nonnull dereferenceable(4) %debug_compute_done, i32* noalias nocapture nonnull dereferenceable(4) %STATE) local_unnamed_addr #0 {
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
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i32, align 512
  %requant_start_copy = alloca i1, align 512
  %requant_op_copy = alloca i32, align 512
  %stream_start_copy = alloca i1, align 512
  %done_copy = alloca i1, align 512
  %debug_compute_done_copy = alloca i32, align 512
  %STATE_copy = alloca i32, align 512
  call void @copy_in(i32* nonnull %cntrl_layer_idx, i32* nonnull align 512 %cntrl_layer_idx_copy, i1* nonnull %cntrl_busy, i1* nonnull align 512 %cntrl_busy_copy, i1* nonnull %cntrl_start_out, i1* nonnull align 512 %cntrl_start_out_copy, i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i8* nonnull %wl_addr_sel, i8* nonnull align 512 %wl_addr_sel_copy, i32* nonnull %wl_layer, i32* nonnull align 512 %wl_layer_copy, i32* nonnull %wl_head, i32* nonnull align 512 %wl_head_copy, i32* nonnull %wl_tile, i32* nonnull align 512 %wl_tile_copy, [2 x %struct.HeadCtx]* nonnull %head_ctx_ref, i195* nonnull align 512 %head_ctx_ref_copy_0, i195* nonnull align 512 %head_ctx_ref_copy_1, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i32* nonnull %compute_op, i32* nonnull align 512 %compute_op_copy, i1* nonnull %requant_start, i1* nonnull align 512 %requant_start_copy, i32* nonnull %requant_op, i32* nonnull align 512 %requant_op_copy, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i1* nonnull %done, i1* nonnull align 512 %done_copy, i32* nonnull %debug_compute_done, i32* nonnull align 512 %debug_compute_done_copy, i32* nonnull %STATE, i32* nonnull align 512 %STATE_copy)
  call void @apatb_scheduler_hls_hw(i1 %cntrl_start, i1 %cntrl_reset_n, i32* %cntrl_layer_idx_copy, i1* %cntrl_busy_copy, i1* %cntrl_start_out_copy, i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %wl_ready, i1* %wl_start_copy, i8* %wl_addr_sel_copy, i32* %wl_layer_copy, i32* %wl_head_copy, i32* %wl_tile_copy, i1 %dma_done, i1 %compute_ready, i1 %compute_done, i1 %requant_ready, i1 %requant_done, i195* %head_ctx_ref_copy_0, i195* %head_ctx_ref_copy_1, i1* %compute_start_copy, i32* %compute_op_copy, i1* %requant_start_copy, i32* %requant_op_copy, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i1* %done_copy, i32* %debug_compute_done_copy, i32* %STATE_copy)
  call void @copy_back(i32* %cntrl_layer_idx, i32* %cntrl_layer_idx_copy, i1* %cntrl_busy, i1* %cntrl_busy_copy, i1* %cntrl_start_out, i1* %cntrl_start_out_copy, i1* %axis_in_ready, i1* %axis_in_ready_copy, i1* %wl_start, i1* %wl_start_copy, i8* %wl_addr_sel, i8* %wl_addr_sel_copy, i32* %wl_layer, i32* %wl_layer_copy, i32* %wl_head, i32* %wl_head_copy, i32* %wl_tile, i32* %wl_tile_copy, [2 x %struct.HeadCtx]* %head_ctx_ref, i195* %head_ctx_ref_copy_0, i195* %head_ctx_ref_copy_1, i1* %compute_start, i1* %compute_start_copy, i32* %compute_op, i32* %compute_op_copy, i1* %requant_start, i1* %requant_start_copy, i32* %requant_op, i32* %requant_op_copy, i1* %stream_start, i1* %stream_start_copy, i1* %done, i1* %done_copy, i32* %debug_compute_done, i32* %debug_compute_done_copy, i32* %STATE, i32* %STATE_copy)
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
define void @arraycpy_hls.p0a2struct.HeadCtx([2 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, [2 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [2 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond80 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond80, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx81 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 0
  %dst.addr.02 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 1
  %dst.addr.111 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 1
  %4 = load i32, i32* %src.addr.110, align 4
  store i32 %4, i32* %dst.addr.111, align 4
  %src.addr.212 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 2
  %dst.addr.213 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 2
  %5 = load i8, i8* %src.addr.212, align 1
  store i8 %5, i8* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 3
  %dst.addr.315 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 3
  %6 = bitcast i1* %src.addr.314 to i8*
  %7 = load i8, i8* %6
  %8 = trunc i8 %7 to i1
  store i1 %8, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 4
  %dst.addr.417 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 4
  %9 = bitcast i1* %src.addr.416 to i8*
  %10 = load i8, i8* %9
  %11 = trunc i8 %10 to i1
  store i1 %11, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 5
  %dst.addr.519 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 5
  %12 = bitcast i1* %src.addr.518 to i8*
  %13 = load i8, i8* %12
  %14 = trunc i8 %13 to i1
  store i1 %14, i1* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 6
  %dst.addr.621 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 6
  %15 = load i8, i8* %src.addr.620, align 1
  store i8 %15, i8* %dst.addr.621, align 1
  %src.addr.722 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 7
  %dst.addr.723 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 7
  %16 = load i8, i8* %src.addr.722, align 1
  store i8 %16, i8* %dst.addr.723, align 1
  %src.addr.824 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 8
  %dst.addr.825 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 8
  %17 = load i8, i8* %src.addr.824, align 1
  store i8 %17, i8* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 9
  %dst.addr.927 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 9
  %18 = bitcast i1* %src.addr.926 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  store i1 %20, i1* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 10
  %dst.addr.1029 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 10
  %21 = bitcast i1* %src.addr.1028 to i8*
  %22 = load i8, i8* %21
  %23 = trunc i8 %22 to i1
  store i1 %23, i1* %dst.addr.1029, align 1
  %src.addr.1130 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 11
  %dst.addr.1131 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 11
  %24 = load i8, i8* %src.addr.1130, align 1
  store i8 %24, i8* %dst.addr.1131, align 1
  %src.addr.1232 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 12
  %dst.addr.1233 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 12
  %25 = load i32, i32* %src.addr.1232, align 4
  store i32 %25, i32* %dst.addr.1233, align 4
  %src.addr.1334 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 13
  %dst.addr.1335 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 13
  %26 = load i32, i32* %src.addr.1334, align 4
  store i32 %26, i32* %dst.addr.1335, align 4
  %src.addr.1436 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 14
  %dst.addr.1437 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 14
  %27 = bitcast i1* %src.addr.1436 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  store i1 %29, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 15
  %dst.addr.1539 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 15
  %30 = bitcast i1* %src.addr.1538 to i8*
  %31 = load i8, i8* %30
  %32 = trunc i8 %31 to i1
  store i1 %32, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 16
  %dst.addr.1641 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 16
  %33 = bitcast i1* %src.addr.1640 to i8*
  %34 = load i8, i8* %33
  %35 = trunc i8 %34 to i1
  store i1 %35, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 17
  %dst.addr.1743 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 17
  %36 = bitcast i1* %src.addr.1742 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  store i1 %38, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 18
  %dst.addr.1845 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 18
  %39 = bitcast i1* %src.addr.1844 to i8*
  %40 = load i8, i8* %39
  %41 = trunc i8 %40 to i1
  store i1 %41, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 19
  %dst.addr.1947 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 19
  %42 = bitcast i1* %src.addr.1946 to i8*
  %43 = load i8, i8* %42
  %44 = trunc i8 %43 to i1
  store i1 %44, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 20
  %dst.addr.2049 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 20
  %45 = bitcast i1* %src.addr.2048 to i8*
  %46 = load i8, i8* %45
  %47 = trunc i8 %46 to i1
  store i1 %47, i1* %dst.addr.2049, align 1
  %src.addr.2150 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 21
  %dst.addr.2151 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 21
  %48 = bitcast i1* %src.addr.2150 to i8*
  %49 = load i8, i8* %48
  %50 = trunc i8 %49 to i1
  store i1 %50, i1* %dst.addr.2151, align 1
  %src.addr.2252 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 22
  %dst.addr.2253 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 22
  %51 = bitcast i1* %src.addr.2252 to i8*
  %52 = load i8, i8* %51
  %53 = trunc i8 %52 to i1
  store i1 %53, i1* %dst.addr.2253, align 1
  %src.addr.2354 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 23
  %dst.addr.2355 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 23
  %54 = bitcast i1* %src.addr.2354 to i8*
  %55 = load i8, i8* %54
  %56 = trunc i8 %55 to i1
  store i1 %56, i1* %dst.addr.2355, align 1
  %src.addr.2456 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 24
  %dst.addr.2457 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 24
  %57 = bitcast i1* %src.addr.2456 to i8*
  %58 = load i8, i8* %57
  %59 = trunc i8 %58 to i1
  store i1 %59, i1* %dst.addr.2457, align 1
  %src.addr.2558 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 25
  %dst.addr.2559 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 25
  %60 = bitcast i1* %src.addr.2558 to i8*
  %61 = load i8, i8* %60
  %62 = trunc i8 %61 to i1
  store i1 %62, i1* %dst.addr.2559, align 1
  %src.addr.2660 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 26
  %dst.addr.2661 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 26
  %63 = bitcast i1* %src.addr.2660 to i8*
  %64 = load i8, i8* %63
  %65 = trunc i8 %64 to i1
  store i1 %65, i1* %dst.addr.2661, align 1
  %src.addr.2762 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 27
  %dst.addr.2763 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 27
  %66 = bitcast i1* %src.addr.2762 to i8*
  %67 = load i8, i8* %66
  %68 = trunc i8 %67 to i1
  store i1 %68, i1* %dst.addr.2763, align 1
  %src.addr.2864 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 28
  %dst.addr.2865 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 28
  %69 = bitcast i1* %src.addr.2864 to i8*
  %70 = load i8, i8* %69
  %71 = trunc i8 %70 to i1
  store i1 %71, i1* %dst.addr.2865, align 1
  %src.addr.2966 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 29
  %dst.addr.2967 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 29
  %72 = bitcast i1* %src.addr.2966 to i8*
  %73 = load i8, i8* %72
  %74 = trunc i8 %73 to i1
  store i1 %74, i1* %dst.addr.2967, align 1
  %src.addr.3068 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 30
  %dst.addr.3069 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 30
  %75 = bitcast i1* %src.addr.3068 to i8*
  %76 = load i8, i8* %75
  %77 = trunc i8 %76 to i1
  store i1 %77, i1* %dst.addr.3069, align 1
  %src.addr.3170 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 31
  %dst.addr.3171 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 31
  %78 = bitcast i1* %src.addr.3170 to i8*
  %79 = load i8, i8* %78
  %80 = trunc i8 %79 to i1
  store i1 %80, i1* %dst.addr.3171, align 1
  %src.addr.3272 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 32
  %dst.addr.3273 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 32
  %81 = bitcast i1* %src.addr.3272 to i8*
  %82 = load i8, i8* %81
  %83 = trunc i8 %82 to i1
  store i1 %83, i1* %dst.addr.3273, align 1
  %src.addr.3374 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 33
  %dst.addr.3375 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 33
  %84 = bitcast i1* %src.addr.3374 to i8*
  %85 = load i8, i8* %84
  %86 = trunc i8 %85 to i1
  store i1 %86, i1* %dst.addr.3375, align 1
  %src.addr.3476 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 34
  %dst.addr.3477 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 34
  %87 = bitcast i1* %src.addr.3476 to i8*
  %88 = load i8, i8* %87
  %89 = trunc i8 %88 to i1
  store i1 %89, i1* %dst.addr.3477, align 1
  %src.addr.3578 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 35
  %dst.addr.3579 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 35
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
define void @arraycpy_hls.p0a2struct.HeadCtx.10.11(i195* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i195* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, [2 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [2 x %struct.HeadCtx]* %src, null
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
  %src.addr.01 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  switch i64 %for.loop.idx81, label %dst.addr.02.exit [
    i64 0, label %dst.addr.02.case.0
    i64 1, label %dst.addr.02.case.1
  ]

dst.addr.02.case.0:                               ; preds = %for.loop
  %4 = bitcast i195* %dst_0 to i200*
  %5 = load i200, i200* %4
  %6 = trunc i200 %5 to i195
  %7 = zext i32 %3 to i195
  %8 = and i195 %6, -4294967296
  %.partset71 = or i195 %8, %7
  store i195 %.partset71, i195* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i195* %dst_1 to i200*
  %10 = load i200, i200* %9
  %11 = trunc i200 %10 to i195
  %12 = zext i32 %3 to i195
  %13 = and i195 %11, -4294967296
  %.partset = or i195 %13, %12
  store i195 %.partset, i195* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.exit:                                 ; preds = %dst.addr.02.case.1, %dst.addr.02.case.0, %for.loop
  %src.addr.110 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 1
  %14 = load i32, i32* %src.addr.110, align 4
  switch i64 %for.loop.idx81, label %dst.addr.111.exit [
    i64 0, label %dst.addr.111.case.0
    i64 1, label %dst.addr.111.case.1
  ]

dst.addr.111.case.0:                              ; preds = %dst.addr.02.exit
  %15 = bitcast i195* %dst_0 to i200*
  %16 = load i200, i200* %15
  %17 = trunc i200 %16 to i195
  %18 = zext i32 %14 to i195
  %19 = shl i195 %18, 32
  %20 = and i195 %17, -18446744069414584321
  %.partset70 = or i195 %20, %19
  store i195 %.partset70, i195* %dst_0, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %21 = bitcast i195* %dst_1 to i200*
  %22 = load i200, i200* %21
  %23 = trunc i200 %22 to i195
  %24 = zext i32 %14 to i195
  %25 = shl i195 %24, 32
  %26 = and i195 %23, -18446744069414584321
  %.partset1 = or i195 %26, %25
  store i195 %.partset1, i195* %dst_1, align 4
  br label %dst.addr.111.exit

dst.addr.111.exit:                                ; preds = %dst.addr.111.case.1, %dst.addr.111.case.0, %dst.addr.02.exit
  %src.addr.212 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 2
  %27 = load i8, i8* %src.addr.212, align 1
  switch i64 %for.loop.idx81, label %dst.addr.213.exit [
    i64 0, label %dst.addr.213.case.0
    i64 1, label %dst.addr.213.case.1
  ]

dst.addr.213.case.0:                              ; preds = %dst.addr.111.exit
  %28 = bitcast i195* %dst_0 to i200*
  %29 = load i200, i200* %28
  %30 = trunc i200 %29 to i195
  %31 = zext i8 %27 to i195
  %32 = shl i195 %31, 64
  %33 = and i195 %30, -4703919738795935662081
  %.partset69 = or i195 %33, %32
  store i195 %.partset69, i195* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %34 = bitcast i195* %dst_1 to i200*
  %35 = load i200, i200* %34
  %36 = trunc i200 %35 to i195
  %37 = zext i8 %27 to i195
  %38 = shl i195 %37, 64
  %39 = and i195 %36, -4703919738795935662081
  %.partset2 = or i195 %39, %38
  store i195 %.partset2, i195* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.exit:                                ; preds = %dst.addr.213.case.1, %dst.addr.213.case.0, %dst.addr.111.exit
  %src.addr.314 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 3
  %40 = bitcast i1* %src.addr.314 to i8*
  %41 = load i8, i8* %40
  %42 = trunc i8 %41 to i1
  switch i64 %for.loop.idx81, label %dst.addr.315.exit [
    i64 0, label %dst.addr.315.case.0
    i64 1, label %dst.addr.315.case.1
  ]

dst.addr.315.case.0:                              ; preds = %dst.addr.213.exit
  %43 = bitcast i195* %dst_0 to i200*
  %44 = load i200, i200* %43
  %45 = trunc i200 %44 to i195
  %46 = zext i1 %42 to i195
  %47 = shl i195 %46, 72
  %48 = and i195 %45, -4722366482869645213697
  %.partset68 = or i195 %48, %47
  store i195 %.partset68, i195* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %49 = bitcast i195* %dst_1 to i200*
  %50 = load i200, i200* %49
  %51 = trunc i200 %50 to i195
  %52 = zext i1 %42 to i195
  %53 = shl i195 %52, 72
  %54 = and i195 %51, -4722366482869645213697
  %.partset3 = or i195 %54, %53
  store i195 %.partset3, i195* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.exit:                                ; preds = %dst.addr.315.case.1, %dst.addr.315.case.0, %dst.addr.213.exit
  %src.addr.416 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 4
  %55 = bitcast i1* %src.addr.416 to i8*
  %56 = load i8, i8* %55
  %57 = trunc i8 %56 to i1
  switch i64 %for.loop.idx81, label %dst.addr.417.exit [
    i64 0, label %dst.addr.417.case.0
    i64 1, label %dst.addr.417.case.1
  ]

dst.addr.417.case.0:                              ; preds = %dst.addr.315.exit
  %58 = bitcast i195* %dst_0 to i200*
  %59 = load i200, i200* %58
  %60 = trunc i200 %59 to i195
  %61 = zext i1 %57 to i195
  %62 = shl i195 %61, 73
  %63 = and i195 %60, -9444732965739290427393
  %.partset67 = or i195 %63, %62
  store i195 %.partset67, i195* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %64 = bitcast i195* %dst_1 to i200*
  %65 = load i200, i200* %64
  %66 = trunc i200 %65 to i195
  %67 = zext i1 %57 to i195
  %68 = shl i195 %67, 73
  %69 = and i195 %66, -9444732965739290427393
  %.partset4 = or i195 %69, %68
  store i195 %.partset4, i195* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.exit:                                ; preds = %dst.addr.417.case.1, %dst.addr.417.case.0, %dst.addr.315.exit
  %src.addr.518 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 5
  %70 = bitcast i1* %src.addr.518 to i8*
  %71 = load i8, i8* %70
  %72 = trunc i8 %71 to i1
  switch i64 %for.loop.idx81, label %dst.addr.519.exit [
    i64 0, label %dst.addr.519.case.0
    i64 1, label %dst.addr.519.case.1
  ]

dst.addr.519.case.0:                              ; preds = %dst.addr.417.exit
  %73 = bitcast i195* %dst_0 to i200*
  %74 = load i200, i200* %73
  %75 = trunc i200 %74 to i195
  %76 = zext i1 %72 to i195
  %77 = shl i195 %76, 74
  %78 = and i195 %75, -18889465931478580854785
  %.partset66 = or i195 %78, %77
  store i195 %.partset66, i195* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %79 = bitcast i195* %dst_1 to i200*
  %80 = load i200, i200* %79
  %81 = trunc i200 %80 to i195
  %82 = zext i1 %72 to i195
  %83 = shl i195 %82, 74
  %84 = and i195 %81, -18889465931478580854785
  %.partset5 = or i195 %84, %83
  store i195 %.partset5, i195* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 6
  %85 = load i8, i8* %src.addr.620, align 1
  switch i64 %for.loop.idx81, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %86 = bitcast i195* %dst_0 to i200*
  %87 = load i200, i200* %86
  %88 = trunc i200 %87 to i195
  %89 = zext i8 %85 to i195
  %90 = shl i195 %89, 75
  %91 = and i195 %88, -9633627625054076235939841
  %.partset65 = or i195 %91, %90
  store i195 %.partset65, i195* %dst_0, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %92 = bitcast i195* %dst_1 to i200*
  %93 = load i200, i200* %92
  %94 = trunc i200 %93 to i195
  %95 = zext i8 %85 to i195
  %96 = shl i195 %95, 75
  %97 = and i195 %94, -9633627625054076235939841
  %.partset6 = or i195 %97, %96
  store i195 %.partset6, i195* %dst_1, align 1
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 7
  %98 = load i8, i8* %src.addr.722, align 1
  switch i64 %for.loop.idx81, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %99 = bitcast i195* %dst_0 to i200*
  %100 = load i200, i200* %99
  %101 = trunc i200 %100 to i195
  %102 = zext i8 %98 to i195
  %103 = shl i195 %102, 83
  %104 = and i195 %101, -2466208672013843516400599041
  %.partset64 = or i195 %104, %103
  store i195 %.partset64, i195* %dst_0, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %105 = bitcast i195* %dst_1 to i200*
  %106 = load i200, i200* %105
  %107 = trunc i200 %106 to i195
  %108 = zext i8 %98 to i195
  %109 = shl i195 %108, 83
  %110 = and i195 %107, -2466208672013843516400599041
  %.partset7 = or i195 %110, %109
  store i195 %.partset7, i195* %dst_1, align 1
  br label %dst.addr.723.exit

dst.addr.723.exit:                                ; preds = %dst.addr.723.case.1, %dst.addr.723.case.0, %dst.addr.621.exit
  %src.addr.824 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 8
  %111 = load i8, i8* %src.addr.824, align 1
  switch i64 %for.loop.idx81, label %dst.addr.825.exit [
    i64 0, label %dst.addr.825.case.0
    i64 1, label %dst.addr.825.case.1
  ]

dst.addr.825.case.0:                              ; preds = %dst.addr.723.exit
  %112 = bitcast i195* %dst_0 to i200*
  %113 = load i200, i200* %112
  %114 = trunc i200 %113 to i195
  %115 = zext i8 %111 to i195
  %116 = shl i195 %115, 91
  %117 = and i195 %114, -631349420035543940198553354241
  %.partset63 = or i195 %117, %116
  store i195 %.partset63, i195* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %118 = bitcast i195* %dst_1 to i200*
  %119 = load i200, i200* %118
  %120 = trunc i200 %119 to i195
  %121 = zext i8 %111 to i195
  %122 = shl i195 %121, 91
  %123 = and i195 %120, -631349420035543940198553354241
  %.partset8 = or i195 %123, %122
  store i195 %.partset8, i195* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.exit:                                ; preds = %dst.addr.825.case.1, %dst.addr.825.case.0, %dst.addr.723.exit
  %src.addr.926 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 9
  %124 = bitcast i1* %src.addr.926 to i8*
  %125 = load i8, i8* %124
  %126 = trunc i8 %125 to i1
  switch i64 %for.loop.idx81, label %dst.addr.927.exit [
    i64 0, label %dst.addr.927.case.0
    i64 1, label %dst.addr.927.case.1
  ]

dst.addr.927.case.0:                              ; preds = %dst.addr.825.exit
  %127 = bitcast i195* %dst_0 to i200*
  %128 = load i200, i200* %127
  %129 = trunc i200 %128 to i195
  %130 = zext i1 %126 to i195
  %131 = shl i195 %130, 99
  %132 = and i195 %129, -633825300114114700748351602689
  %.partset62 = or i195 %132, %131
  store i195 %.partset62, i195* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %133 = bitcast i195* %dst_1 to i200*
  %134 = load i200, i200* %133
  %135 = trunc i200 %134 to i195
  %136 = zext i1 %126 to i195
  %137 = shl i195 %136, 99
  %138 = and i195 %135, -633825300114114700748351602689
  %.partset9 = or i195 %138, %137
  store i195 %.partset9, i195* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.exit:                                ; preds = %dst.addr.927.case.1, %dst.addr.927.case.0, %dst.addr.825.exit
  %src.addr.1028 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 10
  %139 = bitcast i1* %src.addr.1028 to i8*
  %140 = load i8, i8* %139
  %141 = trunc i8 %140 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1029.exit [
    i64 0, label %dst.addr.1029.case.0
    i64 1, label %dst.addr.1029.case.1
  ]

dst.addr.1029.case.0:                             ; preds = %dst.addr.927.exit
  %142 = bitcast i195* %dst_0 to i200*
  %143 = load i200, i200* %142
  %144 = trunc i200 %143 to i195
  %145 = zext i1 %141 to i195
  %146 = shl i195 %145, 100
  %147 = and i195 %144, -1267650600228229401496703205377
  %.partset61 = or i195 %147, %146
  store i195 %.partset61, i195* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %148 = bitcast i195* %dst_1 to i200*
  %149 = load i200, i200* %148
  %150 = trunc i200 %149 to i195
  %151 = zext i1 %141 to i195
  %152 = shl i195 %151, 100
  %153 = and i195 %150, -1267650600228229401496703205377
  %.partset10 = or i195 %153, %152
  store i195 %.partset10, i195* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.exit:                               ; preds = %dst.addr.1029.case.1, %dst.addr.1029.case.0, %dst.addr.927.exit
  %src.addr.1130 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 11
  %154 = load i8, i8* %src.addr.1130, align 1
  switch i64 %for.loop.idx81, label %dst.addr.1131.exit [
    i64 0, label %dst.addr.1131.case.0
    i64 1, label %dst.addr.1131.case.1
  ]

dst.addr.1131.case.0:                             ; preds = %dst.addr.1029.exit
  %155 = bitcast i195* %dst_0 to i200*
  %156 = load i200, i200* %155
  %157 = trunc i200 %156 to i195
  %158 = zext i8 %154 to i195
  %159 = shl i195 %158, 101
  %160 = and i195 %157, -646501806116396994763318634741761
  %.partset60 = or i195 %160, %159
  store i195 %.partset60, i195* %dst_0, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %161 = bitcast i195* %dst_1 to i200*
  %162 = load i200, i200* %161
  %163 = trunc i200 %162 to i195
  %164 = zext i8 %154 to i195
  %165 = shl i195 %164, 101
  %166 = and i195 %163, -646501806116396994763318634741761
  %.partset11 = or i195 %166, %165
  store i195 %.partset11, i195* %dst_1, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.exit:                               ; preds = %dst.addr.1131.case.1, %dst.addr.1131.case.0, %dst.addr.1029.exit
  %src.addr.1232 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 12
  %167 = load i32, i32* %src.addr.1232, align 4
  switch i64 %for.loop.idx81, label %dst.addr.1233.exit [
    i64 0, label %dst.addr.1233.case.0
    i64 1, label %dst.addr.1233.case.1
  ]

dst.addr.1233.case.0:                             ; preds = %dst.addr.1131.exit
  %168 = bitcast i195* %dst_0 to i200*
  %169 = load i200, i200* %168
  %170 = trunc i200 %169 to i195
  %171 = zext i32 %167 to i195
  %172 = shl i195 %171, 109
  %173 = and i195 %170, -2787593149167290785375111330514733147095041
  %.partset59 = or i195 %173, %172
  store i195 %.partset59, i195* %dst_0, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %174 = bitcast i195* %dst_1 to i200*
  %175 = load i200, i200* %174
  %176 = trunc i200 %175 to i195
  %177 = zext i32 %167 to i195
  %178 = shl i195 %177, 109
  %179 = and i195 %176, -2787593149167290785375111330514733147095041
  %.partset12 = or i195 %179, %178
  store i195 %.partset12, i195* %dst_1, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.exit:                               ; preds = %dst.addr.1233.case.1, %dst.addr.1233.case.0, %dst.addr.1131.exit
  %src.addr.1334 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 13
  %180 = load i32, i32* %src.addr.1334, align 4
  switch i64 %for.loop.idx81, label %dst.addr.1335.exit [
    i64 0, label %dst.addr.1335.case.0
    i64 1, label %dst.addr.1335.case.1
  ]

dst.addr.1335.case.0:                             ; preds = %dst.addr.1233.exit
  %181 = bitcast i195* %dst_0 to i200*
  %182 = load i200, i200* %181
  %183 = trunc i200 %182 to i195
  %184 = zext i32 %180 to i195
  %185 = shl i195 %184, 141
  %186 = and i195 %183, -11972621410227163556108258256919825712940354203811841
  %.partset58 = or i195 %186, %185
  store i195 %.partset58, i195* %dst_0, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %187 = bitcast i195* %dst_1 to i200*
  %188 = load i200, i200* %187
  %189 = trunc i200 %188 to i195
  %190 = zext i32 %180 to i195
  %191 = shl i195 %190, 141
  %192 = and i195 %189, -11972621410227163556108258256919825712940354203811841
  %.partset13 = or i195 %192, %191
  store i195 %.partset13, i195* %dst_1, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.exit:                               ; preds = %dst.addr.1335.case.1, %dst.addr.1335.case.0, %dst.addr.1233.exit
  %src.addr.1436 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 14
  %193 = bitcast i1* %src.addr.1436 to i8*
  %194 = load i8, i8* %193
  %195 = trunc i8 %194 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1437.exit [
    i64 0, label %dst.addr.1437.case.0
    i64 1, label %dst.addr.1437.case.1
  ]

dst.addr.1437.case.0:                             ; preds = %dst.addr.1335.exit
  %196 = bitcast i195* %dst_0 to i200*
  %197 = load i200, i200* %196
  %198 = trunc i200 %197 to i195
  %199 = zext i1 %195 to i195
  %200 = shl i195 %199, 173
  %201 = and i195 %198, -11972621413014756705924586149611790497021399392059393
  %.partset57 = or i195 %201, %200
  store i195 %.partset57, i195* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %202 = bitcast i195* %dst_1 to i200*
  %203 = load i200, i200* %202
  %204 = trunc i200 %203 to i195
  %205 = zext i1 %195 to i195
  %206 = shl i195 %205, 173
  %207 = and i195 %204, -11972621413014756705924586149611790497021399392059393
  %.partset14 = or i195 %207, %206
  store i195 %.partset14, i195* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.exit:                               ; preds = %dst.addr.1437.case.1, %dst.addr.1437.case.0, %dst.addr.1335.exit
  %src.addr.1538 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 15
  %208 = bitcast i1* %src.addr.1538 to i8*
  %209 = load i8, i8* %208
  %210 = trunc i8 %209 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1539.exit [
    i64 0, label %dst.addr.1539.case.0
    i64 1, label %dst.addr.1539.case.1
  ]

dst.addr.1539.case.0:                             ; preds = %dst.addr.1437.exit
  %211 = bitcast i195* %dst_0 to i200*
  %212 = load i200, i200* %211
  %213 = trunc i200 %212 to i195
  %214 = zext i1 %210 to i195
  %215 = shl i195 %214, 174
  %216 = and i195 %213, -23945242826029513411849172299223580994042798784118785
  %.partset56 = or i195 %216, %215
  store i195 %.partset56, i195* %dst_0, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %217 = bitcast i195* %dst_1 to i200*
  %218 = load i200, i200* %217
  %219 = trunc i200 %218 to i195
  %220 = zext i1 %210 to i195
  %221 = shl i195 %220, 174
  %222 = and i195 %219, -23945242826029513411849172299223580994042798784118785
  %.partset15 = or i195 %222, %221
  store i195 %.partset15, i195* %dst_1, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.exit:                               ; preds = %dst.addr.1539.case.1, %dst.addr.1539.case.0, %dst.addr.1437.exit
  %src.addr.1640 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 16
  %223 = bitcast i1* %src.addr.1640 to i8*
  %224 = load i8, i8* %223
  %225 = trunc i8 %224 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1641.exit [
    i64 0, label %dst.addr.1641.case.0
    i64 1, label %dst.addr.1641.case.1
  ]

dst.addr.1641.case.0:                             ; preds = %dst.addr.1539.exit
  %226 = bitcast i195* %dst_0 to i200*
  %227 = load i200, i200* %226
  %228 = trunc i200 %227 to i195
  %229 = zext i1 %225 to i195
  %230 = shl i195 %229, 175
  %231 = and i195 %228, -47890485652059026823698344598447161988085597568237569
  %.partset55 = or i195 %231, %230
  store i195 %.partset55, i195* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %232 = bitcast i195* %dst_1 to i200*
  %233 = load i200, i200* %232
  %234 = trunc i200 %233 to i195
  %235 = zext i1 %225 to i195
  %236 = shl i195 %235, 175
  %237 = and i195 %234, -47890485652059026823698344598447161988085597568237569
  %.partset16 = or i195 %237, %236
  store i195 %.partset16, i195* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.exit:                               ; preds = %dst.addr.1641.case.1, %dst.addr.1641.case.0, %dst.addr.1539.exit
  %src.addr.1742 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 17
  %238 = bitcast i1* %src.addr.1742 to i8*
  %239 = load i8, i8* %238
  %240 = trunc i8 %239 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1743.exit [
    i64 0, label %dst.addr.1743.case.0
    i64 1, label %dst.addr.1743.case.1
  ]

dst.addr.1743.case.0:                             ; preds = %dst.addr.1641.exit
  %241 = bitcast i195* %dst_0 to i200*
  %242 = load i200, i200* %241
  %243 = trunc i200 %242 to i195
  %244 = zext i1 %240 to i195
  %245 = shl i195 %244, 176
  %246 = and i195 %243, -95780971304118053647396689196894323976171195136475137
  %.partset54 = or i195 %246, %245
  store i195 %.partset54, i195* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %247 = bitcast i195* %dst_1 to i200*
  %248 = load i200, i200* %247
  %249 = trunc i200 %248 to i195
  %250 = zext i1 %240 to i195
  %251 = shl i195 %250, 176
  %252 = and i195 %249, -95780971304118053647396689196894323976171195136475137
  %.partset17 = or i195 %252, %251
  store i195 %.partset17, i195* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.exit:                               ; preds = %dst.addr.1743.case.1, %dst.addr.1743.case.0, %dst.addr.1641.exit
  %src.addr.1844 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 18
  %253 = bitcast i1* %src.addr.1844 to i8*
  %254 = load i8, i8* %253
  %255 = trunc i8 %254 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1845.exit [
    i64 0, label %dst.addr.1845.case.0
    i64 1, label %dst.addr.1845.case.1
  ]

dst.addr.1845.case.0:                             ; preds = %dst.addr.1743.exit
  %256 = bitcast i195* %dst_0 to i200*
  %257 = load i200, i200* %256
  %258 = trunc i200 %257 to i195
  %259 = zext i1 %255 to i195
  %260 = shl i195 %259, 177
  %261 = and i195 %258, -191561942608236107294793378393788647952342390272950273
  %.partset53 = or i195 %261, %260
  store i195 %.partset53, i195* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %262 = bitcast i195* %dst_1 to i200*
  %263 = load i200, i200* %262
  %264 = trunc i200 %263 to i195
  %265 = zext i1 %255 to i195
  %266 = shl i195 %265, 177
  %267 = and i195 %264, -191561942608236107294793378393788647952342390272950273
  %.partset18 = or i195 %267, %266
  store i195 %.partset18, i195* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.exit:                               ; preds = %dst.addr.1845.case.1, %dst.addr.1845.case.0, %dst.addr.1743.exit
  %src.addr.1946 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 19
  %268 = bitcast i1* %src.addr.1946 to i8*
  %269 = load i8, i8* %268
  %270 = trunc i8 %269 to i1
  switch i64 %for.loop.idx81, label %dst.addr.1947.exit [
    i64 0, label %dst.addr.1947.case.0
    i64 1, label %dst.addr.1947.case.1
  ]

dst.addr.1947.case.0:                             ; preds = %dst.addr.1845.exit
  %271 = bitcast i195* %dst_0 to i200*
  %272 = load i200, i200* %271
  %273 = trunc i200 %272 to i195
  %274 = zext i1 %270 to i195
  %275 = shl i195 %274, 178
  %276 = and i195 %273, -383123885216472214589586756787577295904684780545900545
  %.partset52 = or i195 %276, %275
  store i195 %.partset52, i195* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %277 = bitcast i195* %dst_1 to i200*
  %278 = load i200, i200* %277
  %279 = trunc i200 %278 to i195
  %280 = zext i1 %270 to i195
  %281 = shl i195 %280, 178
  %282 = and i195 %279, -383123885216472214589586756787577295904684780545900545
  %.partset19 = or i195 %282, %281
  store i195 %.partset19, i195* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.exit:                               ; preds = %dst.addr.1947.case.1, %dst.addr.1947.case.0, %dst.addr.1845.exit
  %src.addr.2048 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 20
  %283 = bitcast i1* %src.addr.2048 to i8*
  %284 = load i8, i8* %283
  %285 = trunc i8 %284 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2049.exit [
    i64 0, label %dst.addr.2049.case.0
    i64 1, label %dst.addr.2049.case.1
  ]

dst.addr.2049.case.0:                             ; preds = %dst.addr.1947.exit
  %286 = bitcast i195* %dst_0 to i200*
  %287 = load i200, i200* %286
  %288 = trunc i200 %287 to i195
  %289 = zext i1 %285 to i195
  %290 = shl i195 %289, 179
  %291 = and i195 %288, -766247770432944429179173513575154591809369561091801089
  %.partset51 = or i195 %291, %290
  store i195 %.partset51, i195* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %292 = bitcast i195* %dst_1 to i200*
  %293 = load i200, i200* %292
  %294 = trunc i200 %293 to i195
  %295 = zext i1 %285 to i195
  %296 = shl i195 %295, 179
  %297 = and i195 %294, -766247770432944429179173513575154591809369561091801089
  %.partset20 = or i195 %297, %296
  store i195 %.partset20, i195* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.exit:                               ; preds = %dst.addr.2049.case.1, %dst.addr.2049.case.0, %dst.addr.1947.exit
  %src.addr.2150 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 21
  %298 = bitcast i1* %src.addr.2150 to i8*
  %299 = load i8, i8* %298
  %300 = trunc i8 %299 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2151.exit [
    i64 0, label %dst.addr.2151.case.0
    i64 1, label %dst.addr.2151.case.1
  ]

dst.addr.2151.case.0:                             ; preds = %dst.addr.2049.exit
  %301 = bitcast i195* %dst_0 to i200*
  %302 = load i200, i200* %301
  %303 = trunc i200 %302 to i195
  %304 = zext i1 %300 to i195
  %305 = shl i195 %304, 180
  %306 = and i195 %303, -1532495540865888858358347027150309183618739122183602177
  %.partset50 = or i195 %306, %305
  store i195 %.partset50, i195* %dst_0, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.1:                             ; preds = %dst.addr.2049.exit
  %307 = bitcast i195* %dst_1 to i200*
  %308 = load i200, i200* %307
  %309 = trunc i200 %308 to i195
  %310 = zext i1 %300 to i195
  %311 = shl i195 %310, 180
  %312 = and i195 %309, -1532495540865888858358347027150309183618739122183602177
  %.partset21 = or i195 %312, %311
  store i195 %.partset21, i195* %dst_1, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.exit:                               ; preds = %dst.addr.2151.case.1, %dst.addr.2151.case.0, %dst.addr.2049.exit
  %src.addr.2252 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 22
  %313 = bitcast i1* %src.addr.2252 to i8*
  %314 = load i8, i8* %313
  %315 = trunc i8 %314 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2253.exit [
    i64 0, label %dst.addr.2253.case.0
    i64 1, label %dst.addr.2253.case.1
  ]

dst.addr.2253.case.0:                             ; preds = %dst.addr.2151.exit
  %316 = bitcast i195* %dst_0 to i200*
  %317 = load i200, i200* %316
  %318 = trunc i200 %317 to i195
  %319 = zext i1 %315 to i195
  %320 = shl i195 %319, 181
  %321 = and i195 %318, -3064991081731777716716694054300618367237478244367204353
  %.partset49 = or i195 %321, %320
  store i195 %.partset49, i195* %dst_0, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.1:                             ; preds = %dst.addr.2151.exit
  %322 = bitcast i195* %dst_1 to i200*
  %323 = load i200, i200* %322
  %324 = trunc i200 %323 to i195
  %325 = zext i1 %315 to i195
  %326 = shl i195 %325, 181
  %327 = and i195 %324, -3064991081731777716716694054300618367237478244367204353
  %.partset22 = or i195 %327, %326
  store i195 %.partset22, i195* %dst_1, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.exit:                               ; preds = %dst.addr.2253.case.1, %dst.addr.2253.case.0, %dst.addr.2151.exit
  %src.addr.2354 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 23
  %328 = bitcast i1* %src.addr.2354 to i8*
  %329 = load i8, i8* %328
  %330 = trunc i8 %329 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2355.exit [
    i64 0, label %dst.addr.2355.case.0
    i64 1, label %dst.addr.2355.case.1
  ]

dst.addr.2355.case.0:                             ; preds = %dst.addr.2253.exit
  %331 = bitcast i195* %dst_0 to i200*
  %332 = load i200, i200* %331
  %333 = trunc i200 %332 to i195
  %334 = zext i1 %330 to i195
  %335 = shl i195 %334, 182
  %336 = and i195 %333, -6129982163463555433433388108601236734474956488734408705
  %.partset48 = or i195 %336, %335
  store i195 %.partset48, i195* %dst_0, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.1:                             ; preds = %dst.addr.2253.exit
  %337 = bitcast i195* %dst_1 to i200*
  %338 = load i200, i200* %337
  %339 = trunc i200 %338 to i195
  %340 = zext i1 %330 to i195
  %341 = shl i195 %340, 182
  %342 = and i195 %339, -6129982163463555433433388108601236734474956488734408705
  %.partset23 = or i195 %342, %341
  store i195 %.partset23, i195* %dst_1, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.exit:                               ; preds = %dst.addr.2355.case.1, %dst.addr.2355.case.0, %dst.addr.2253.exit
  %src.addr.2456 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 24
  %343 = bitcast i1* %src.addr.2456 to i8*
  %344 = load i8, i8* %343
  %345 = trunc i8 %344 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2457.exit [
    i64 0, label %dst.addr.2457.case.0
    i64 1, label %dst.addr.2457.case.1
  ]

dst.addr.2457.case.0:                             ; preds = %dst.addr.2355.exit
  %346 = bitcast i195* %dst_0 to i200*
  %347 = load i200, i200* %346
  %348 = trunc i200 %347 to i195
  %349 = zext i1 %345 to i195
  %350 = shl i195 %349, 183
  %351 = and i195 %348, -12259964326927110866866776217202473468949912977468817409
  %.partset47 = or i195 %351, %350
  store i195 %.partset47, i195* %dst_0, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.1:                             ; preds = %dst.addr.2355.exit
  %352 = bitcast i195* %dst_1 to i200*
  %353 = load i200, i200* %352
  %354 = trunc i200 %353 to i195
  %355 = zext i1 %345 to i195
  %356 = shl i195 %355, 183
  %357 = and i195 %354, -12259964326927110866866776217202473468949912977468817409
  %.partset24 = or i195 %357, %356
  store i195 %.partset24, i195* %dst_1, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.exit:                               ; preds = %dst.addr.2457.case.1, %dst.addr.2457.case.0, %dst.addr.2355.exit
  %src.addr.2558 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 25
  %358 = bitcast i1* %src.addr.2558 to i8*
  %359 = load i8, i8* %358
  %360 = trunc i8 %359 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2559.exit [
    i64 0, label %dst.addr.2559.case.0
    i64 1, label %dst.addr.2559.case.1
  ]

dst.addr.2559.case.0:                             ; preds = %dst.addr.2457.exit
  %361 = bitcast i195* %dst_0 to i200*
  %362 = load i200, i200* %361
  %363 = trunc i200 %362 to i195
  %364 = zext i1 %360 to i195
  %365 = shl i195 %364, 184
  %366 = and i195 %363, -24519928653854221733733552434404946937899825954937634817
  %.partset46 = or i195 %366, %365
  store i195 %.partset46, i195* %dst_0, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.1:                             ; preds = %dst.addr.2457.exit
  %367 = bitcast i195* %dst_1 to i200*
  %368 = load i200, i200* %367
  %369 = trunc i200 %368 to i195
  %370 = zext i1 %360 to i195
  %371 = shl i195 %370, 184
  %372 = and i195 %369, -24519928653854221733733552434404946937899825954937634817
  %.partset25 = or i195 %372, %371
  store i195 %.partset25, i195* %dst_1, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.exit:                               ; preds = %dst.addr.2559.case.1, %dst.addr.2559.case.0, %dst.addr.2457.exit
  %src.addr.2660 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 26
  %373 = bitcast i1* %src.addr.2660 to i8*
  %374 = load i8, i8* %373
  %375 = trunc i8 %374 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2661.exit [
    i64 0, label %dst.addr.2661.case.0
    i64 1, label %dst.addr.2661.case.1
  ]

dst.addr.2661.case.0:                             ; preds = %dst.addr.2559.exit
  %376 = bitcast i195* %dst_0 to i200*
  %377 = load i200, i200* %376
  %378 = trunc i200 %377 to i195
  %379 = zext i1 %375 to i195
  %380 = shl i195 %379, 185
  %381 = and i195 %378, -49039857307708443467467104868809893875799651909875269633
  %.partset45 = or i195 %381, %380
  store i195 %.partset45, i195* %dst_0, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.1:                             ; preds = %dst.addr.2559.exit
  %382 = bitcast i195* %dst_1 to i200*
  %383 = load i200, i200* %382
  %384 = trunc i200 %383 to i195
  %385 = zext i1 %375 to i195
  %386 = shl i195 %385, 185
  %387 = and i195 %384, -49039857307708443467467104868809893875799651909875269633
  %.partset26 = or i195 %387, %386
  store i195 %.partset26, i195* %dst_1, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.exit:                               ; preds = %dst.addr.2661.case.1, %dst.addr.2661.case.0, %dst.addr.2559.exit
  %src.addr.2762 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 27
  %388 = bitcast i1* %src.addr.2762 to i8*
  %389 = load i8, i8* %388
  %390 = trunc i8 %389 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2763.exit [
    i64 0, label %dst.addr.2763.case.0
    i64 1, label %dst.addr.2763.case.1
  ]

dst.addr.2763.case.0:                             ; preds = %dst.addr.2661.exit
  %391 = bitcast i195* %dst_0 to i200*
  %392 = load i200, i200* %391
  %393 = trunc i200 %392 to i195
  %394 = zext i1 %390 to i195
  %395 = shl i195 %394, 186
  %396 = and i195 %393, -98079714615416886934934209737619787751599303819750539265
  %.partset44 = or i195 %396, %395
  store i195 %.partset44, i195* %dst_0, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.1:                             ; preds = %dst.addr.2661.exit
  %397 = bitcast i195* %dst_1 to i200*
  %398 = load i200, i200* %397
  %399 = trunc i200 %398 to i195
  %400 = zext i1 %390 to i195
  %401 = shl i195 %400, 186
  %402 = and i195 %399, -98079714615416886934934209737619787751599303819750539265
  %.partset27 = or i195 %402, %401
  store i195 %.partset27, i195* %dst_1, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.exit:                               ; preds = %dst.addr.2763.case.1, %dst.addr.2763.case.0, %dst.addr.2661.exit
  %src.addr.2864 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 28
  %403 = bitcast i1* %src.addr.2864 to i8*
  %404 = load i8, i8* %403
  %405 = trunc i8 %404 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2865.exit [
    i64 0, label %dst.addr.2865.case.0
    i64 1, label %dst.addr.2865.case.1
  ]

dst.addr.2865.case.0:                             ; preds = %dst.addr.2763.exit
  %406 = bitcast i195* %dst_0 to i200*
  %407 = load i200, i200* %406
  %408 = trunc i200 %407 to i195
  %409 = zext i1 %405 to i195
  %410 = shl i195 %409, 187
  %411 = and i195 %408, -196159429230833773869868419475239575503198607639501078529
  %.partset43 = or i195 %411, %410
  store i195 %.partset43, i195* %dst_0, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.1:                             ; preds = %dst.addr.2763.exit
  %412 = bitcast i195* %dst_1 to i200*
  %413 = load i200, i200* %412
  %414 = trunc i200 %413 to i195
  %415 = zext i1 %405 to i195
  %416 = shl i195 %415, 187
  %417 = and i195 %414, -196159429230833773869868419475239575503198607639501078529
  %.partset28 = or i195 %417, %416
  store i195 %.partset28, i195* %dst_1, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.exit:                               ; preds = %dst.addr.2865.case.1, %dst.addr.2865.case.0, %dst.addr.2763.exit
  %src.addr.2966 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 29
  %418 = bitcast i1* %src.addr.2966 to i8*
  %419 = load i8, i8* %418
  %420 = trunc i8 %419 to i1
  switch i64 %for.loop.idx81, label %dst.addr.2967.exit [
    i64 0, label %dst.addr.2967.case.0
    i64 1, label %dst.addr.2967.case.1
  ]

dst.addr.2967.case.0:                             ; preds = %dst.addr.2865.exit
  %421 = bitcast i195* %dst_0 to i200*
  %422 = load i200, i200* %421
  %423 = trunc i200 %422 to i195
  %424 = zext i1 %420 to i195
  %425 = shl i195 %424, 188
  %426 = and i195 %423, -392318858461667547739736838950479151006397215279002157057
  %.partset42 = or i195 %426, %425
  store i195 %.partset42, i195* %dst_0, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.1:                             ; preds = %dst.addr.2865.exit
  %427 = bitcast i195* %dst_1 to i200*
  %428 = load i200, i200* %427
  %429 = trunc i200 %428 to i195
  %430 = zext i1 %420 to i195
  %431 = shl i195 %430, 188
  %432 = and i195 %429, -392318858461667547739736838950479151006397215279002157057
  %.partset29 = or i195 %432, %431
  store i195 %.partset29, i195* %dst_1, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.exit:                               ; preds = %dst.addr.2967.case.1, %dst.addr.2967.case.0, %dst.addr.2865.exit
  %src.addr.3068 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 30
  %433 = bitcast i1* %src.addr.3068 to i8*
  %434 = load i8, i8* %433
  %435 = trunc i8 %434 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3069.exit [
    i64 0, label %dst.addr.3069.case.0
    i64 1, label %dst.addr.3069.case.1
  ]

dst.addr.3069.case.0:                             ; preds = %dst.addr.2967.exit
  %436 = bitcast i195* %dst_0 to i200*
  %437 = load i200, i200* %436
  %438 = trunc i200 %437 to i195
  %439 = zext i1 %435 to i195
  %440 = shl i195 %439, 189
  %441 = and i195 %438, -784637716923335095479473677900958302012794430558004314113
  %.partset41 = or i195 %441, %440
  store i195 %.partset41, i195* %dst_0, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.1:                             ; preds = %dst.addr.2967.exit
  %442 = bitcast i195* %dst_1 to i200*
  %443 = load i200, i200* %442
  %444 = trunc i200 %443 to i195
  %445 = zext i1 %435 to i195
  %446 = shl i195 %445, 189
  %447 = and i195 %444, -784637716923335095479473677900958302012794430558004314113
  %.partset30 = or i195 %447, %446
  store i195 %.partset30, i195* %dst_1, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.exit:                               ; preds = %dst.addr.3069.case.1, %dst.addr.3069.case.0, %dst.addr.2967.exit
  %src.addr.3170 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 31
  %448 = bitcast i1* %src.addr.3170 to i8*
  %449 = load i8, i8* %448
  %450 = trunc i8 %449 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3171.exit [
    i64 0, label %dst.addr.3171.case.0
    i64 1, label %dst.addr.3171.case.1
  ]

dst.addr.3171.case.0:                             ; preds = %dst.addr.3069.exit
  %451 = bitcast i195* %dst_0 to i200*
  %452 = load i200, i200* %451
  %453 = trunc i200 %452 to i195
  %454 = zext i1 %450 to i195
  %455 = shl i195 %454, 190
  %456 = and i195 %453, -1569275433846670190958947355801916604025588861116008628225
  %.partset40 = or i195 %456, %455
  store i195 %.partset40, i195* %dst_0, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.1:                             ; preds = %dst.addr.3069.exit
  %457 = bitcast i195* %dst_1 to i200*
  %458 = load i200, i200* %457
  %459 = trunc i200 %458 to i195
  %460 = zext i1 %450 to i195
  %461 = shl i195 %460, 190
  %462 = and i195 %459, -1569275433846670190958947355801916604025588861116008628225
  %.partset31 = or i195 %462, %461
  store i195 %.partset31, i195* %dst_1, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.exit:                               ; preds = %dst.addr.3171.case.1, %dst.addr.3171.case.0, %dst.addr.3069.exit
  %src.addr.3272 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 32
  %463 = bitcast i1* %src.addr.3272 to i8*
  %464 = load i8, i8* %463
  %465 = trunc i8 %464 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3273.exit [
    i64 0, label %dst.addr.3273.case.0
    i64 1, label %dst.addr.3273.case.1
  ]

dst.addr.3273.case.0:                             ; preds = %dst.addr.3171.exit
  %466 = bitcast i195* %dst_0 to i200*
  %467 = load i200, i200* %466
  %468 = trunc i200 %467 to i195
  %469 = zext i1 %465 to i195
  %470 = shl i195 %469, 191
  %471 = and i195 %468, -3138550867693340381917894711603833208051177722232017256449
  %.partset39 = or i195 %471, %470
  store i195 %.partset39, i195* %dst_0, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.1:                             ; preds = %dst.addr.3171.exit
  %472 = bitcast i195* %dst_1 to i200*
  %473 = load i200, i200* %472
  %474 = trunc i200 %473 to i195
  %475 = zext i1 %465 to i195
  %476 = shl i195 %475, 191
  %477 = and i195 %474, -3138550867693340381917894711603833208051177722232017256449
  %.partset32 = or i195 %477, %476
  store i195 %.partset32, i195* %dst_1, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.exit:                               ; preds = %dst.addr.3273.case.1, %dst.addr.3273.case.0, %dst.addr.3171.exit
  %src.addr.3374 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 33
  %478 = bitcast i1* %src.addr.3374 to i8*
  %479 = load i8, i8* %478
  %480 = trunc i8 %479 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3375.exit [
    i64 0, label %dst.addr.3375.case.0
    i64 1, label %dst.addr.3375.case.1
  ]

dst.addr.3375.case.0:                             ; preds = %dst.addr.3273.exit
  %481 = bitcast i195* %dst_0 to i200*
  %482 = load i200, i200* %481
  %483 = trunc i200 %482 to i195
  %484 = zext i1 %480 to i195
  %485 = shl i195 %484, 192
  %486 = and i195 %483, -6277101735386680763835789423207666416102355444464034512897
  %.partset38 = or i195 %486, %485
  store i195 %.partset38, i195* %dst_0, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.1:                             ; preds = %dst.addr.3273.exit
  %487 = bitcast i195* %dst_1 to i200*
  %488 = load i200, i200* %487
  %489 = trunc i200 %488 to i195
  %490 = zext i1 %480 to i195
  %491 = shl i195 %490, 192
  %492 = and i195 %489, -6277101735386680763835789423207666416102355444464034512897
  %.partset33 = or i195 %492, %491
  store i195 %.partset33, i195* %dst_1, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.exit:                               ; preds = %dst.addr.3375.case.1, %dst.addr.3375.case.0, %dst.addr.3273.exit
  %src.addr.3476 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 34
  %493 = bitcast i1* %src.addr.3476 to i8*
  %494 = load i8, i8* %493
  %495 = trunc i8 %494 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3477.exit [
    i64 0, label %dst.addr.3477.case.0
    i64 1, label %dst.addr.3477.case.1
  ]

dst.addr.3477.case.0:                             ; preds = %dst.addr.3375.exit
  %496 = bitcast i195* %dst_0 to i200*
  %497 = load i200, i200* %496
  %498 = trunc i200 %497 to i195
  %499 = zext i1 %495 to i195
  %500 = shl i195 %499, 193
  %501 = and i195 %498, -12554203470773361527671578846415332832204710888928069025793
  %.partset37 = or i195 %501, %500
  store i195 %.partset37, i195* %dst_0, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.1:                             ; preds = %dst.addr.3375.exit
  %502 = bitcast i195* %dst_1 to i200*
  %503 = load i200, i200* %502
  %504 = trunc i200 %503 to i195
  %505 = zext i1 %495 to i195
  %506 = shl i195 %505, 193
  %507 = and i195 %504, -12554203470773361527671578846415332832204710888928069025793
  %.partset34 = or i195 %507, %506
  store i195 %.partset34, i195* %dst_1, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.exit:                               ; preds = %dst.addr.3477.case.1, %dst.addr.3477.case.0, %dst.addr.3375.exit
  %src.addr.3578 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx81, i32 35
  %508 = bitcast i1* %src.addr.3578 to i8*
  %509 = load i8, i8* %508
  %510 = trunc i8 %509 to i1
  switch i64 %for.loop.idx81, label %dst.addr.3579.exit [
    i64 0, label %dst.addr.3579.case.0
    i64 1, label %dst.addr.3579.case.1
  ]

dst.addr.3579.case.0:                             ; preds = %dst.addr.3477.exit
  %511 = bitcast i195* %dst_0 to i200*
  %512 = load i200, i200* %511
  %513 = trunc i200 %512 to i195
  %514 = zext i1 %510 to i195
  %515 = shl i195 %514, 194
  %516 = and i195 %513, 25108406941546723055343157692830665664409421777856138051583
  %.partset36 = or i195 %516, %515
  store i195 %.partset36, i195* %dst_0, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.1:                             ; preds = %dst.addr.3477.exit
  %517 = bitcast i195* %dst_1 to i200*
  %518 = load i200, i200* %517
  %519 = trunc i200 %518 to i195
  %520 = zext i1 %510 to i195
  %521 = shl i195 %520, 194
  %522 = and i195 %519, 25108406941546723055343157692830665664409421777856138051583
  %.partset35 = or i195 %522, %521
  store i195 %.partset35, i195* %dst_1, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.exit:                               ; preds = %dst.addr.3579.case.1, %dst.addr.3579.case.0, %dst.addr.3477.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx81, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.3579.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a2struct.HeadCtx.9.12(i195* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i195* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, [2 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #1 {
entry:
  %0 = icmp eq i195* %dst_0, null
  %1 = icmp eq [2 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a2struct.HeadCtx.10.11(i195* nonnull %dst_0, i195* %dst_1, [2 x %struct.HeadCtx]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in(i32* noalias readonly "orig.arg.no"="0", i32* noalias align 512 "orig.arg.no"="1", i1* noalias readonly "orig.arg.no"="2", i1* noalias align 512 "orig.arg.no"="3", i1* noalias readonly "orig.arg.no"="4", i1* noalias align 512 "orig.arg.no"="5", i1* noalias readonly "orig.arg.no"="6", i1* noalias align 512 "orig.arg.no"="7", i1* noalias readonly "orig.arg.no"="8", i1* noalias align 512 "orig.arg.no"="9", i8* noalias readonly "orig.arg.no"="10", i8* noalias align 512 "orig.arg.no"="11", i32* noalias readonly "orig.arg.no"="12", i32* noalias align 512 "orig.arg.no"="13", i32* noalias readonly "orig.arg.no"="14", i32* noalias align 512 "orig.arg.no"="15", i32* noalias readonly "orig.arg.no"="16", i32* noalias align 512 "orig.arg.no"="17", [2 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="18", i195* noalias align 512 "orig.arg.no"="19" "unpacked"="19.0" %_0, i195* noalias align 512 "orig.arg.no"="19" "unpacked"="19.1" %_1, i1* noalias readonly "orig.arg.no"="20", i1* noalias align 512 "orig.arg.no"="21", i32* noalias readonly "orig.arg.no"="22", i32* noalias align 512 "orig.arg.no"="23", i1* noalias readonly "orig.arg.no"="24", i1* noalias align 512 "orig.arg.no"="25", i32* noalias readonly "orig.arg.no"="26", i32* noalias align 512 "orig.arg.no"="27", i1* noalias readonly "orig.arg.no"="28", i1* noalias align 512 "orig.arg.no"="29", i1* noalias readonly "orig.arg.no"="30", i1* noalias align 512 "orig.arg.no"="31", i32* noalias readonly "orig.arg.no"="32", i32* noalias align 512 "orig.arg.no"="33", i32* noalias readonly "orig.arg.no"="34", i32* noalias align 512 "orig.arg.no"="35") #3 {
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
  call void @onebyonecpy_hls.p0a2struct.HeadCtx.9.12(i195* align 512 %_0, i195* align 512 %_1, [2 x %struct.HeadCtx]* %18)
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
define void @arraycpy_hls.p0a2struct.HeadCtx.18.19([2 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i195* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i195* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i195* %src_0, null
  %1 = icmp eq [2 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond80 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond80, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.3578.exit, %for.loop.lr.ph
  %for.loop.idx81 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.3578.exit ]
  %dst.addr.02 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 0
  switch i64 %for.loop.idx81, label %src.addr.01.exit [
    i64 0, label %src.addr.01.case.0
    i64 1, label %src.addr.01.case.1
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

src.addr.01.exit:                                 ; preds = %src.addr.01.case.1, %src.addr.01.case.0, %for.loop
  %9 = phi i32 [ %_0.partselect, %src.addr.01.case.0 ], [ %_1.partselect, %src.addr.01.case.1 ], [ undef, %for.loop ]
  store i32 %9, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 1
  switch i64 %for.loop.idx81, label %src.addr.110.exit [
    i64 0, label %src.addr.110.case.0
    i64 1, label %src.addr.110.case.1
  ]

src.addr.110.case.0:                              ; preds = %src.addr.01.exit
  %10 = bitcast i195* %src_0 to i200*
  %11 = load i200, i200* %10
  %12 = trunc i200 %11 to i195
  %13 = lshr i195 %12, 32
  %_01.partselect = trunc i195 %13 to i32
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %14 = bitcast i195* %src_1 to i200*
  %15 = load i200, i200* %14
  %16 = trunc i200 %15 to i195
  %17 = lshr i195 %16, 32
  %_12.partselect = trunc i195 %17 to i32
  br label %src.addr.110.exit

src.addr.110.exit:                                ; preds = %src.addr.110.case.1, %src.addr.110.case.0, %src.addr.01.exit
  %18 = phi i32 [ %_01.partselect, %src.addr.110.case.0 ], [ %_12.partselect, %src.addr.110.case.1 ], [ undef, %src.addr.01.exit ]
  store i32 %18, i32* %dst.addr.111, align 4
  %dst.addr.213 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 2
  switch i64 %for.loop.idx81, label %src.addr.212.exit [
    i64 0, label %src.addr.212.case.0
    i64 1, label %src.addr.212.case.1
  ]

src.addr.212.case.0:                              ; preds = %src.addr.110.exit
  %19 = bitcast i195* %src_0 to i200*
  %20 = load i200, i200* %19
  %21 = trunc i200 %20 to i195
  %22 = lshr i195 %21, 64
  %_03.partselect = trunc i195 %22 to i8
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %23 = bitcast i195* %src_1 to i200*
  %24 = load i200, i200* %23
  %25 = trunc i200 %24 to i195
  %26 = lshr i195 %25, 64
  %_14.partselect = trunc i195 %26 to i8
  br label %src.addr.212.exit

src.addr.212.exit:                                ; preds = %src.addr.212.case.1, %src.addr.212.case.0, %src.addr.110.exit
  %27 = phi i8 [ %_03.partselect, %src.addr.212.case.0 ], [ %_14.partselect, %src.addr.212.case.1 ], [ undef, %src.addr.110.exit ]
  store i8 %27, i8* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 3
  switch i64 %for.loop.idx81, label %src.addr.314.exit [
    i64 0, label %src.addr.314.case.0
    i64 1, label %src.addr.314.case.1
  ]

src.addr.314.case.0:                              ; preds = %src.addr.212.exit
  %28 = bitcast i195* %src_0 to i200*
  %29 = load i200, i200* %28
  %30 = trunc i200 %29 to i195
  %31 = lshr i195 %30, 72
  %_05.partselect = trunc i195 %31 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %32 = bitcast i195* %src_1 to i200*
  %33 = load i200, i200* %32
  %34 = trunc i200 %33 to i195
  %35 = lshr i195 %34, 72
  %_16.partselect = trunc i195 %35 to i1
  br label %src.addr.314.exit

src.addr.314.exit:                                ; preds = %src.addr.314.case.1, %src.addr.314.case.0, %src.addr.212.exit
  %36 = phi i1 [ %_05.partselect, %src.addr.314.case.0 ], [ %_16.partselect, %src.addr.314.case.1 ], [ undef, %src.addr.212.exit ]
  store i1 %36, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 4
  switch i64 %for.loop.idx81, label %src.addr.416.exit [
    i64 0, label %src.addr.416.case.0
    i64 1, label %src.addr.416.case.1
  ]

src.addr.416.case.0:                              ; preds = %src.addr.314.exit
  %37 = bitcast i195* %src_0 to i200*
  %38 = load i200, i200* %37
  %39 = trunc i200 %38 to i195
  %40 = lshr i195 %39, 73
  %_07.partselect = trunc i195 %40 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %41 = bitcast i195* %src_1 to i200*
  %42 = load i200, i200* %41
  %43 = trunc i200 %42 to i195
  %44 = lshr i195 %43, 73
  %_18.partselect = trunc i195 %44 to i1
  br label %src.addr.416.exit

src.addr.416.exit:                                ; preds = %src.addr.416.case.1, %src.addr.416.case.0, %src.addr.314.exit
  %45 = phi i1 [ %_07.partselect, %src.addr.416.case.0 ], [ %_18.partselect, %src.addr.416.case.1 ], [ undef, %src.addr.314.exit ]
  store i1 %45, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 5
  switch i64 %for.loop.idx81, label %src.addr.518.exit [
    i64 0, label %src.addr.518.case.0
    i64 1, label %src.addr.518.case.1
  ]

src.addr.518.case.0:                              ; preds = %src.addr.416.exit
  %46 = bitcast i195* %src_0 to i200*
  %47 = load i200, i200* %46
  %48 = trunc i200 %47 to i195
  %49 = lshr i195 %48, 74
  %_09.partselect = trunc i195 %49 to i1
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %50 = bitcast i195* %src_1 to i200*
  %51 = load i200, i200* %50
  %52 = trunc i200 %51 to i195
  %53 = lshr i195 %52, 74
  %_110.partselect = trunc i195 %53 to i1
  br label %src.addr.518.exit

src.addr.518.exit:                                ; preds = %src.addr.518.case.1, %src.addr.518.case.0, %src.addr.416.exit
  %54 = phi i1 [ %_09.partselect, %src.addr.518.case.0 ], [ %_110.partselect, %src.addr.518.case.1 ], [ undef, %src.addr.416.exit ]
  store i1 %54, i1* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 6
  switch i64 %for.loop.idx81, label %src.addr.620.exit [
    i64 0, label %src.addr.620.case.0
    i64 1, label %src.addr.620.case.1
  ]

src.addr.620.case.0:                              ; preds = %src.addr.518.exit
  %55 = bitcast i195* %src_0 to i200*
  %56 = load i200, i200* %55
  %57 = trunc i200 %56 to i195
  %58 = lshr i195 %57, 75
  %_011.partselect = trunc i195 %58 to i8
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %59 = bitcast i195* %src_1 to i200*
  %60 = load i200, i200* %59
  %61 = trunc i200 %60 to i195
  %62 = lshr i195 %61, 75
  %_112.partselect = trunc i195 %62 to i8
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %63 = phi i8 [ %_011.partselect, %src.addr.620.case.0 ], [ %_112.partselect, %src.addr.620.case.1 ], [ undef, %src.addr.518.exit ]
  store i8 %63, i8* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 7
  switch i64 %for.loop.idx81, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %64 = bitcast i195* %src_0 to i200*
  %65 = load i200, i200* %64
  %66 = trunc i200 %65 to i195
  %67 = lshr i195 %66, 83
  %_013.partselect = trunc i195 %67 to i8
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %68 = bitcast i195* %src_1 to i200*
  %69 = load i200, i200* %68
  %70 = trunc i200 %69 to i195
  %71 = lshr i195 %70, 83
  %_114.partselect = trunc i195 %71 to i8
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %72 = phi i8 [ %_013.partselect, %src.addr.722.case.0 ], [ %_114.partselect, %src.addr.722.case.1 ], [ undef, %src.addr.620.exit ]
  store i8 %72, i8* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 8
  switch i64 %for.loop.idx81, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %73 = bitcast i195* %src_0 to i200*
  %74 = load i200, i200* %73
  %75 = trunc i200 %74 to i195
  %76 = lshr i195 %75, 91
  %_015.partselect = trunc i195 %76 to i8
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %77 = bitcast i195* %src_1 to i200*
  %78 = load i200, i200* %77
  %79 = trunc i200 %78 to i195
  %80 = lshr i195 %79, 91
  %_116.partselect = trunc i195 %80 to i8
  br label %src.addr.824.exit

src.addr.824.exit:                                ; preds = %src.addr.824.case.1, %src.addr.824.case.0, %src.addr.722.exit
  %81 = phi i8 [ %_015.partselect, %src.addr.824.case.0 ], [ %_116.partselect, %src.addr.824.case.1 ], [ undef, %src.addr.722.exit ]
  store i8 %81, i8* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 9
  switch i64 %for.loop.idx81, label %src.addr.926.exit [
    i64 0, label %src.addr.926.case.0
    i64 1, label %src.addr.926.case.1
  ]

src.addr.926.case.0:                              ; preds = %src.addr.824.exit
  %82 = bitcast i195* %src_0 to i200*
  %83 = load i200, i200* %82
  %84 = trunc i200 %83 to i195
  %85 = lshr i195 %84, 99
  %_017.partselect = trunc i195 %85 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %86 = bitcast i195* %src_1 to i200*
  %87 = load i200, i200* %86
  %88 = trunc i200 %87 to i195
  %89 = lshr i195 %88, 99
  %_118.partselect = trunc i195 %89 to i1
  br label %src.addr.926.exit

src.addr.926.exit:                                ; preds = %src.addr.926.case.1, %src.addr.926.case.0, %src.addr.824.exit
  %90 = phi i1 [ %_017.partselect, %src.addr.926.case.0 ], [ %_118.partselect, %src.addr.926.case.1 ], [ undef, %src.addr.824.exit ]
  store i1 %90, i1* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 10
  switch i64 %for.loop.idx81, label %src.addr.1028.exit [
    i64 0, label %src.addr.1028.case.0
    i64 1, label %src.addr.1028.case.1
  ]

src.addr.1028.case.0:                             ; preds = %src.addr.926.exit
  %91 = bitcast i195* %src_0 to i200*
  %92 = load i200, i200* %91
  %93 = trunc i200 %92 to i195
  %94 = lshr i195 %93, 100
  %_019.partselect = trunc i195 %94 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %95 = bitcast i195* %src_1 to i200*
  %96 = load i200, i200* %95
  %97 = trunc i200 %96 to i195
  %98 = lshr i195 %97, 100
  %_120.partselect = trunc i195 %98 to i1
  br label %src.addr.1028.exit

src.addr.1028.exit:                               ; preds = %src.addr.1028.case.1, %src.addr.1028.case.0, %src.addr.926.exit
  %99 = phi i1 [ %_019.partselect, %src.addr.1028.case.0 ], [ %_120.partselect, %src.addr.1028.case.1 ], [ undef, %src.addr.926.exit ]
  store i1 %99, i1* %dst.addr.1029, align 1
  %dst.addr.1131 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 11
  switch i64 %for.loop.idx81, label %src.addr.1130.exit [
    i64 0, label %src.addr.1130.case.0
    i64 1, label %src.addr.1130.case.1
  ]

src.addr.1130.case.0:                             ; preds = %src.addr.1028.exit
  %100 = bitcast i195* %src_0 to i200*
  %101 = load i200, i200* %100
  %102 = trunc i200 %101 to i195
  %103 = lshr i195 %102, 101
  %_021.partselect = trunc i195 %103 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %104 = bitcast i195* %src_1 to i200*
  %105 = load i200, i200* %104
  %106 = trunc i200 %105 to i195
  %107 = lshr i195 %106, 101
  %_122.partselect = trunc i195 %107 to i8
  br label %src.addr.1130.exit

src.addr.1130.exit:                               ; preds = %src.addr.1130.case.1, %src.addr.1130.case.0, %src.addr.1028.exit
  %108 = phi i8 [ %_021.partselect, %src.addr.1130.case.0 ], [ %_122.partselect, %src.addr.1130.case.1 ], [ undef, %src.addr.1028.exit ]
  store i8 %108, i8* %dst.addr.1131, align 1
  %dst.addr.1233 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 12
  switch i64 %for.loop.idx81, label %src.addr.1232.exit [
    i64 0, label %src.addr.1232.case.0
    i64 1, label %src.addr.1232.case.1
  ]

src.addr.1232.case.0:                             ; preds = %src.addr.1130.exit
  %109 = bitcast i195* %src_0 to i200*
  %110 = load i200, i200* %109
  %111 = trunc i200 %110 to i195
  %112 = lshr i195 %111, 109
  %_023.partselect = trunc i195 %112 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %113 = bitcast i195* %src_1 to i200*
  %114 = load i200, i200* %113
  %115 = trunc i200 %114 to i195
  %116 = lshr i195 %115, 109
  %_124.partselect = trunc i195 %116 to i32
  br label %src.addr.1232.exit

src.addr.1232.exit:                               ; preds = %src.addr.1232.case.1, %src.addr.1232.case.0, %src.addr.1130.exit
  %117 = phi i32 [ %_023.partselect, %src.addr.1232.case.0 ], [ %_124.partselect, %src.addr.1232.case.1 ], [ undef, %src.addr.1130.exit ]
  store i32 %117, i32* %dst.addr.1233, align 4
  %dst.addr.1335 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 13
  switch i64 %for.loop.idx81, label %src.addr.1334.exit [
    i64 0, label %src.addr.1334.case.0
    i64 1, label %src.addr.1334.case.1
  ]

src.addr.1334.case.0:                             ; preds = %src.addr.1232.exit
  %118 = bitcast i195* %src_0 to i200*
  %119 = load i200, i200* %118
  %120 = trunc i200 %119 to i195
  %121 = lshr i195 %120, 141
  %_025.partselect = trunc i195 %121 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %122 = bitcast i195* %src_1 to i200*
  %123 = load i200, i200* %122
  %124 = trunc i200 %123 to i195
  %125 = lshr i195 %124, 141
  %_126.partselect = trunc i195 %125 to i32
  br label %src.addr.1334.exit

src.addr.1334.exit:                               ; preds = %src.addr.1334.case.1, %src.addr.1334.case.0, %src.addr.1232.exit
  %126 = phi i32 [ %_025.partselect, %src.addr.1334.case.0 ], [ %_126.partselect, %src.addr.1334.case.1 ], [ undef, %src.addr.1232.exit ]
  store i32 %126, i32* %dst.addr.1335, align 4
  %dst.addr.1437 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 14
  switch i64 %for.loop.idx81, label %src.addr.1436.exit [
    i64 0, label %src.addr.1436.case.0
    i64 1, label %src.addr.1436.case.1
  ]

src.addr.1436.case.0:                             ; preds = %src.addr.1334.exit
  %127 = bitcast i195* %src_0 to i200*
  %128 = load i200, i200* %127
  %129 = trunc i200 %128 to i195
  %130 = lshr i195 %129, 173
  %_027.partselect = trunc i195 %130 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %131 = bitcast i195* %src_1 to i200*
  %132 = load i200, i200* %131
  %133 = trunc i200 %132 to i195
  %134 = lshr i195 %133, 173
  %_128.partselect = trunc i195 %134 to i1
  br label %src.addr.1436.exit

src.addr.1436.exit:                               ; preds = %src.addr.1436.case.1, %src.addr.1436.case.0, %src.addr.1334.exit
  %135 = phi i1 [ %_027.partselect, %src.addr.1436.case.0 ], [ %_128.partselect, %src.addr.1436.case.1 ], [ undef, %src.addr.1334.exit ]
  store i1 %135, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 15
  switch i64 %for.loop.idx81, label %src.addr.1538.exit [
    i64 0, label %src.addr.1538.case.0
    i64 1, label %src.addr.1538.case.1
  ]

src.addr.1538.case.0:                             ; preds = %src.addr.1436.exit
  %136 = bitcast i195* %src_0 to i200*
  %137 = load i200, i200* %136
  %138 = trunc i200 %137 to i195
  %139 = lshr i195 %138, 174
  %_029.partselect = trunc i195 %139 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %140 = bitcast i195* %src_1 to i200*
  %141 = load i200, i200* %140
  %142 = trunc i200 %141 to i195
  %143 = lshr i195 %142, 174
  %_130.partselect = trunc i195 %143 to i1
  br label %src.addr.1538.exit

src.addr.1538.exit:                               ; preds = %src.addr.1538.case.1, %src.addr.1538.case.0, %src.addr.1436.exit
  %144 = phi i1 [ %_029.partselect, %src.addr.1538.case.0 ], [ %_130.partselect, %src.addr.1538.case.1 ], [ undef, %src.addr.1436.exit ]
  store i1 %144, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 16
  switch i64 %for.loop.idx81, label %src.addr.1640.exit [
    i64 0, label %src.addr.1640.case.0
    i64 1, label %src.addr.1640.case.1
  ]

src.addr.1640.case.0:                             ; preds = %src.addr.1538.exit
  %145 = bitcast i195* %src_0 to i200*
  %146 = load i200, i200* %145
  %147 = trunc i200 %146 to i195
  %148 = lshr i195 %147, 175
  %_031.partselect = trunc i195 %148 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %149 = bitcast i195* %src_1 to i200*
  %150 = load i200, i200* %149
  %151 = trunc i200 %150 to i195
  %152 = lshr i195 %151, 175
  %_132.partselect = trunc i195 %152 to i1
  br label %src.addr.1640.exit

src.addr.1640.exit:                               ; preds = %src.addr.1640.case.1, %src.addr.1640.case.0, %src.addr.1538.exit
  %153 = phi i1 [ %_031.partselect, %src.addr.1640.case.0 ], [ %_132.partselect, %src.addr.1640.case.1 ], [ undef, %src.addr.1538.exit ]
  store i1 %153, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 17
  switch i64 %for.loop.idx81, label %src.addr.1742.exit [
    i64 0, label %src.addr.1742.case.0
    i64 1, label %src.addr.1742.case.1
  ]

src.addr.1742.case.0:                             ; preds = %src.addr.1640.exit
  %154 = bitcast i195* %src_0 to i200*
  %155 = load i200, i200* %154
  %156 = trunc i200 %155 to i195
  %157 = lshr i195 %156, 176
  %_033.partselect = trunc i195 %157 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %158 = bitcast i195* %src_1 to i200*
  %159 = load i200, i200* %158
  %160 = trunc i200 %159 to i195
  %161 = lshr i195 %160, 176
  %_134.partselect = trunc i195 %161 to i1
  br label %src.addr.1742.exit

src.addr.1742.exit:                               ; preds = %src.addr.1742.case.1, %src.addr.1742.case.0, %src.addr.1640.exit
  %162 = phi i1 [ %_033.partselect, %src.addr.1742.case.0 ], [ %_134.partselect, %src.addr.1742.case.1 ], [ undef, %src.addr.1640.exit ]
  store i1 %162, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 18
  switch i64 %for.loop.idx81, label %src.addr.1844.exit [
    i64 0, label %src.addr.1844.case.0
    i64 1, label %src.addr.1844.case.1
  ]

src.addr.1844.case.0:                             ; preds = %src.addr.1742.exit
  %163 = bitcast i195* %src_0 to i200*
  %164 = load i200, i200* %163
  %165 = trunc i200 %164 to i195
  %166 = lshr i195 %165, 177
  %_035.partselect = trunc i195 %166 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %167 = bitcast i195* %src_1 to i200*
  %168 = load i200, i200* %167
  %169 = trunc i200 %168 to i195
  %170 = lshr i195 %169, 177
  %_136.partselect = trunc i195 %170 to i1
  br label %src.addr.1844.exit

src.addr.1844.exit:                               ; preds = %src.addr.1844.case.1, %src.addr.1844.case.0, %src.addr.1742.exit
  %171 = phi i1 [ %_035.partselect, %src.addr.1844.case.0 ], [ %_136.partselect, %src.addr.1844.case.1 ], [ undef, %src.addr.1742.exit ]
  store i1 %171, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 19
  switch i64 %for.loop.idx81, label %src.addr.1946.exit [
    i64 0, label %src.addr.1946.case.0
    i64 1, label %src.addr.1946.case.1
  ]

src.addr.1946.case.0:                             ; preds = %src.addr.1844.exit
  %172 = bitcast i195* %src_0 to i200*
  %173 = load i200, i200* %172
  %174 = trunc i200 %173 to i195
  %175 = lshr i195 %174, 178
  %_037.partselect = trunc i195 %175 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %176 = bitcast i195* %src_1 to i200*
  %177 = load i200, i200* %176
  %178 = trunc i200 %177 to i195
  %179 = lshr i195 %178, 178
  %_138.partselect = trunc i195 %179 to i1
  br label %src.addr.1946.exit

src.addr.1946.exit:                               ; preds = %src.addr.1946.case.1, %src.addr.1946.case.0, %src.addr.1844.exit
  %180 = phi i1 [ %_037.partselect, %src.addr.1946.case.0 ], [ %_138.partselect, %src.addr.1946.case.1 ], [ undef, %src.addr.1844.exit ]
  store i1 %180, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 20
  switch i64 %for.loop.idx81, label %src.addr.2048.exit [
    i64 0, label %src.addr.2048.case.0
    i64 1, label %src.addr.2048.case.1
  ]

src.addr.2048.case.0:                             ; preds = %src.addr.1946.exit
  %181 = bitcast i195* %src_0 to i200*
  %182 = load i200, i200* %181
  %183 = trunc i200 %182 to i195
  %184 = lshr i195 %183, 179
  %_039.partselect = trunc i195 %184 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %185 = bitcast i195* %src_1 to i200*
  %186 = load i200, i200* %185
  %187 = trunc i200 %186 to i195
  %188 = lshr i195 %187, 179
  %_140.partselect = trunc i195 %188 to i1
  br label %src.addr.2048.exit

src.addr.2048.exit:                               ; preds = %src.addr.2048.case.1, %src.addr.2048.case.0, %src.addr.1946.exit
  %189 = phi i1 [ %_039.partselect, %src.addr.2048.case.0 ], [ %_140.partselect, %src.addr.2048.case.1 ], [ undef, %src.addr.1946.exit ]
  store i1 %189, i1* %dst.addr.2049, align 1
  %dst.addr.2151 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 21
  switch i64 %for.loop.idx81, label %src.addr.2150.exit [
    i64 0, label %src.addr.2150.case.0
    i64 1, label %src.addr.2150.case.1
  ]

src.addr.2150.case.0:                             ; preds = %src.addr.2048.exit
  %190 = bitcast i195* %src_0 to i200*
  %191 = load i200, i200* %190
  %192 = trunc i200 %191 to i195
  %193 = lshr i195 %192, 180
  %_041.partselect = trunc i195 %193 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.1:                             ; preds = %src.addr.2048.exit
  %194 = bitcast i195* %src_1 to i200*
  %195 = load i200, i200* %194
  %196 = trunc i200 %195 to i195
  %197 = lshr i195 %196, 180
  %_142.partselect = trunc i195 %197 to i1
  br label %src.addr.2150.exit

src.addr.2150.exit:                               ; preds = %src.addr.2150.case.1, %src.addr.2150.case.0, %src.addr.2048.exit
  %198 = phi i1 [ %_041.partselect, %src.addr.2150.case.0 ], [ %_142.partselect, %src.addr.2150.case.1 ], [ undef, %src.addr.2048.exit ]
  store i1 %198, i1* %dst.addr.2151, align 1
  %dst.addr.2253 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 22
  switch i64 %for.loop.idx81, label %src.addr.2252.exit [
    i64 0, label %src.addr.2252.case.0
    i64 1, label %src.addr.2252.case.1
  ]

src.addr.2252.case.0:                             ; preds = %src.addr.2150.exit
  %199 = bitcast i195* %src_0 to i200*
  %200 = load i200, i200* %199
  %201 = trunc i200 %200 to i195
  %202 = lshr i195 %201, 181
  %_043.partselect = trunc i195 %202 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.1:                             ; preds = %src.addr.2150.exit
  %203 = bitcast i195* %src_1 to i200*
  %204 = load i200, i200* %203
  %205 = trunc i200 %204 to i195
  %206 = lshr i195 %205, 181
  %_144.partselect = trunc i195 %206 to i1
  br label %src.addr.2252.exit

src.addr.2252.exit:                               ; preds = %src.addr.2252.case.1, %src.addr.2252.case.0, %src.addr.2150.exit
  %207 = phi i1 [ %_043.partselect, %src.addr.2252.case.0 ], [ %_144.partselect, %src.addr.2252.case.1 ], [ undef, %src.addr.2150.exit ]
  store i1 %207, i1* %dst.addr.2253, align 1
  %dst.addr.2355 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 23
  switch i64 %for.loop.idx81, label %src.addr.2354.exit [
    i64 0, label %src.addr.2354.case.0
    i64 1, label %src.addr.2354.case.1
  ]

src.addr.2354.case.0:                             ; preds = %src.addr.2252.exit
  %208 = bitcast i195* %src_0 to i200*
  %209 = load i200, i200* %208
  %210 = trunc i200 %209 to i195
  %211 = lshr i195 %210, 182
  %_045.partselect = trunc i195 %211 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.1:                             ; preds = %src.addr.2252.exit
  %212 = bitcast i195* %src_1 to i200*
  %213 = load i200, i200* %212
  %214 = trunc i200 %213 to i195
  %215 = lshr i195 %214, 182
  %_146.partselect = trunc i195 %215 to i1
  br label %src.addr.2354.exit

src.addr.2354.exit:                               ; preds = %src.addr.2354.case.1, %src.addr.2354.case.0, %src.addr.2252.exit
  %216 = phi i1 [ %_045.partselect, %src.addr.2354.case.0 ], [ %_146.partselect, %src.addr.2354.case.1 ], [ undef, %src.addr.2252.exit ]
  store i1 %216, i1* %dst.addr.2355, align 1
  %dst.addr.2457 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 24
  switch i64 %for.loop.idx81, label %src.addr.2456.exit [
    i64 0, label %src.addr.2456.case.0
    i64 1, label %src.addr.2456.case.1
  ]

src.addr.2456.case.0:                             ; preds = %src.addr.2354.exit
  %217 = bitcast i195* %src_0 to i200*
  %218 = load i200, i200* %217
  %219 = trunc i200 %218 to i195
  %220 = lshr i195 %219, 183
  %_047.partselect = trunc i195 %220 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.1:                             ; preds = %src.addr.2354.exit
  %221 = bitcast i195* %src_1 to i200*
  %222 = load i200, i200* %221
  %223 = trunc i200 %222 to i195
  %224 = lshr i195 %223, 183
  %_148.partselect = trunc i195 %224 to i1
  br label %src.addr.2456.exit

src.addr.2456.exit:                               ; preds = %src.addr.2456.case.1, %src.addr.2456.case.0, %src.addr.2354.exit
  %225 = phi i1 [ %_047.partselect, %src.addr.2456.case.0 ], [ %_148.partselect, %src.addr.2456.case.1 ], [ undef, %src.addr.2354.exit ]
  store i1 %225, i1* %dst.addr.2457, align 1
  %dst.addr.2559 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 25
  switch i64 %for.loop.idx81, label %src.addr.2558.exit [
    i64 0, label %src.addr.2558.case.0
    i64 1, label %src.addr.2558.case.1
  ]

src.addr.2558.case.0:                             ; preds = %src.addr.2456.exit
  %226 = bitcast i195* %src_0 to i200*
  %227 = load i200, i200* %226
  %228 = trunc i200 %227 to i195
  %229 = lshr i195 %228, 184
  %_049.partselect = trunc i195 %229 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.1:                             ; preds = %src.addr.2456.exit
  %230 = bitcast i195* %src_1 to i200*
  %231 = load i200, i200* %230
  %232 = trunc i200 %231 to i195
  %233 = lshr i195 %232, 184
  %_150.partselect = trunc i195 %233 to i1
  br label %src.addr.2558.exit

src.addr.2558.exit:                               ; preds = %src.addr.2558.case.1, %src.addr.2558.case.0, %src.addr.2456.exit
  %234 = phi i1 [ %_049.partselect, %src.addr.2558.case.0 ], [ %_150.partselect, %src.addr.2558.case.1 ], [ undef, %src.addr.2456.exit ]
  store i1 %234, i1* %dst.addr.2559, align 1
  %dst.addr.2661 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 26
  switch i64 %for.loop.idx81, label %src.addr.2660.exit [
    i64 0, label %src.addr.2660.case.0
    i64 1, label %src.addr.2660.case.1
  ]

src.addr.2660.case.0:                             ; preds = %src.addr.2558.exit
  %235 = bitcast i195* %src_0 to i200*
  %236 = load i200, i200* %235
  %237 = trunc i200 %236 to i195
  %238 = lshr i195 %237, 185
  %_051.partselect = trunc i195 %238 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.1:                             ; preds = %src.addr.2558.exit
  %239 = bitcast i195* %src_1 to i200*
  %240 = load i200, i200* %239
  %241 = trunc i200 %240 to i195
  %242 = lshr i195 %241, 185
  %_152.partselect = trunc i195 %242 to i1
  br label %src.addr.2660.exit

src.addr.2660.exit:                               ; preds = %src.addr.2660.case.1, %src.addr.2660.case.0, %src.addr.2558.exit
  %243 = phi i1 [ %_051.partselect, %src.addr.2660.case.0 ], [ %_152.partselect, %src.addr.2660.case.1 ], [ undef, %src.addr.2558.exit ]
  store i1 %243, i1* %dst.addr.2661, align 1
  %dst.addr.2763 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 27
  switch i64 %for.loop.idx81, label %src.addr.2762.exit [
    i64 0, label %src.addr.2762.case.0
    i64 1, label %src.addr.2762.case.1
  ]

src.addr.2762.case.0:                             ; preds = %src.addr.2660.exit
  %244 = bitcast i195* %src_0 to i200*
  %245 = load i200, i200* %244
  %246 = trunc i200 %245 to i195
  %247 = lshr i195 %246, 186
  %_053.partselect = trunc i195 %247 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.1:                             ; preds = %src.addr.2660.exit
  %248 = bitcast i195* %src_1 to i200*
  %249 = load i200, i200* %248
  %250 = trunc i200 %249 to i195
  %251 = lshr i195 %250, 186
  %_154.partselect = trunc i195 %251 to i1
  br label %src.addr.2762.exit

src.addr.2762.exit:                               ; preds = %src.addr.2762.case.1, %src.addr.2762.case.0, %src.addr.2660.exit
  %252 = phi i1 [ %_053.partselect, %src.addr.2762.case.0 ], [ %_154.partselect, %src.addr.2762.case.1 ], [ undef, %src.addr.2660.exit ]
  store i1 %252, i1* %dst.addr.2763, align 1
  %dst.addr.2865 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 28
  switch i64 %for.loop.idx81, label %src.addr.2864.exit [
    i64 0, label %src.addr.2864.case.0
    i64 1, label %src.addr.2864.case.1
  ]

src.addr.2864.case.0:                             ; preds = %src.addr.2762.exit
  %253 = bitcast i195* %src_0 to i200*
  %254 = load i200, i200* %253
  %255 = trunc i200 %254 to i195
  %256 = lshr i195 %255, 187
  %_055.partselect = trunc i195 %256 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.1:                             ; preds = %src.addr.2762.exit
  %257 = bitcast i195* %src_1 to i200*
  %258 = load i200, i200* %257
  %259 = trunc i200 %258 to i195
  %260 = lshr i195 %259, 187
  %_156.partselect = trunc i195 %260 to i1
  br label %src.addr.2864.exit

src.addr.2864.exit:                               ; preds = %src.addr.2864.case.1, %src.addr.2864.case.0, %src.addr.2762.exit
  %261 = phi i1 [ %_055.partselect, %src.addr.2864.case.0 ], [ %_156.partselect, %src.addr.2864.case.1 ], [ undef, %src.addr.2762.exit ]
  store i1 %261, i1* %dst.addr.2865, align 1
  %dst.addr.2967 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 29
  switch i64 %for.loop.idx81, label %src.addr.2966.exit [
    i64 0, label %src.addr.2966.case.0
    i64 1, label %src.addr.2966.case.1
  ]

src.addr.2966.case.0:                             ; preds = %src.addr.2864.exit
  %262 = bitcast i195* %src_0 to i200*
  %263 = load i200, i200* %262
  %264 = trunc i200 %263 to i195
  %265 = lshr i195 %264, 188
  %_057.partselect = trunc i195 %265 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.1:                             ; preds = %src.addr.2864.exit
  %266 = bitcast i195* %src_1 to i200*
  %267 = load i200, i200* %266
  %268 = trunc i200 %267 to i195
  %269 = lshr i195 %268, 188
  %_158.partselect = trunc i195 %269 to i1
  br label %src.addr.2966.exit

src.addr.2966.exit:                               ; preds = %src.addr.2966.case.1, %src.addr.2966.case.0, %src.addr.2864.exit
  %270 = phi i1 [ %_057.partselect, %src.addr.2966.case.0 ], [ %_158.partselect, %src.addr.2966.case.1 ], [ undef, %src.addr.2864.exit ]
  store i1 %270, i1* %dst.addr.2967, align 1
  %dst.addr.3069 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 30
  switch i64 %for.loop.idx81, label %src.addr.3068.exit [
    i64 0, label %src.addr.3068.case.0
    i64 1, label %src.addr.3068.case.1
  ]

src.addr.3068.case.0:                             ; preds = %src.addr.2966.exit
  %271 = bitcast i195* %src_0 to i200*
  %272 = load i200, i200* %271
  %273 = trunc i200 %272 to i195
  %274 = lshr i195 %273, 189
  %_059.partselect = trunc i195 %274 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.1:                             ; preds = %src.addr.2966.exit
  %275 = bitcast i195* %src_1 to i200*
  %276 = load i200, i200* %275
  %277 = trunc i200 %276 to i195
  %278 = lshr i195 %277, 189
  %_160.partselect = trunc i195 %278 to i1
  br label %src.addr.3068.exit

src.addr.3068.exit:                               ; preds = %src.addr.3068.case.1, %src.addr.3068.case.0, %src.addr.2966.exit
  %279 = phi i1 [ %_059.partselect, %src.addr.3068.case.0 ], [ %_160.partselect, %src.addr.3068.case.1 ], [ undef, %src.addr.2966.exit ]
  store i1 %279, i1* %dst.addr.3069, align 1
  %dst.addr.3171 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 31
  switch i64 %for.loop.idx81, label %src.addr.3170.exit [
    i64 0, label %src.addr.3170.case.0
    i64 1, label %src.addr.3170.case.1
  ]

src.addr.3170.case.0:                             ; preds = %src.addr.3068.exit
  %280 = bitcast i195* %src_0 to i200*
  %281 = load i200, i200* %280
  %282 = trunc i200 %281 to i195
  %283 = lshr i195 %282, 190
  %_061.partselect = trunc i195 %283 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.1:                             ; preds = %src.addr.3068.exit
  %284 = bitcast i195* %src_1 to i200*
  %285 = load i200, i200* %284
  %286 = trunc i200 %285 to i195
  %287 = lshr i195 %286, 190
  %_162.partselect = trunc i195 %287 to i1
  br label %src.addr.3170.exit

src.addr.3170.exit:                               ; preds = %src.addr.3170.case.1, %src.addr.3170.case.0, %src.addr.3068.exit
  %288 = phi i1 [ %_061.partselect, %src.addr.3170.case.0 ], [ %_162.partselect, %src.addr.3170.case.1 ], [ undef, %src.addr.3068.exit ]
  store i1 %288, i1* %dst.addr.3171, align 1
  %dst.addr.3273 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 32
  switch i64 %for.loop.idx81, label %src.addr.3272.exit [
    i64 0, label %src.addr.3272.case.0
    i64 1, label %src.addr.3272.case.1
  ]

src.addr.3272.case.0:                             ; preds = %src.addr.3170.exit
  %289 = bitcast i195* %src_0 to i200*
  %290 = load i200, i200* %289
  %291 = trunc i200 %290 to i195
  %292 = lshr i195 %291, 191
  %_063.partselect = trunc i195 %292 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.1:                             ; preds = %src.addr.3170.exit
  %293 = bitcast i195* %src_1 to i200*
  %294 = load i200, i200* %293
  %295 = trunc i200 %294 to i195
  %296 = lshr i195 %295, 191
  %_164.partselect = trunc i195 %296 to i1
  br label %src.addr.3272.exit

src.addr.3272.exit:                               ; preds = %src.addr.3272.case.1, %src.addr.3272.case.0, %src.addr.3170.exit
  %297 = phi i1 [ %_063.partselect, %src.addr.3272.case.0 ], [ %_164.partselect, %src.addr.3272.case.1 ], [ undef, %src.addr.3170.exit ]
  store i1 %297, i1* %dst.addr.3273, align 1
  %dst.addr.3375 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 33
  switch i64 %for.loop.idx81, label %src.addr.3374.exit [
    i64 0, label %src.addr.3374.case.0
    i64 1, label %src.addr.3374.case.1
  ]

src.addr.3374.case.0:                             ; preds = %src.addr.3272.exit
  %298 = bitcast i195* %src_0 to i200*
  %299 = load i200, i200* %298
  %300 = trunc i200 %299 to i195
  %301 = lshr i195 %300, 192
  %_065.partselect = trunc i195 %301 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.1:                             ; preds = %src.addr.3272.exit
  %302 = bitcast i195* %src_1 to i200*
  %303 = load i200, i200* %302
  %304 = trunc i200 %303 to i195
  %305 = lshr i195 %304, 192
  %_166.partselect = trunc i195 %305 to i1
  br label %src.addr.3374.exit

src.addr.3374.exit:                               ; preds = %src.addr.3374.case.1, %src.addr.3374.case.0, %src.addr.3272.exit
  %306 = phi i1 [ %_065.partselect, %src.addr.3374.case.0 ], [ %_166.partselect, %src.addr.3374.case.1 ], [ undef, %src.addr.3272.exit ]
  store i1 %306, i1* %dst.addr.3375, align 1
  %dst.addr.3477 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 34
  switch i64 %for.loop.idx81, label %src.addr.3476.exit [
    i64 0, label %src.addr.3476.case.0
    i64 1, label %src.addr.3476.case.1
  ]

src.addr.3476.case.0:                             ; preds = %src.addr.3374.exit
  %307 = bitcast i195* %src_0 to i200*
  %308 = load i200, i200* %307
  %309 = trunc i200 %308 to i195
  %310 = lshr i195 %309, 193
  %_067.partselect = trunc i195 %310 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.1:                             ; preds = %src.addr.3374.exit
  %311 = bitcast i195* %src_1 to i200*
  %312 = load i200, i200* %311
  %313 = trunc i200 %312 to i195
  %314 = lshr i195 %313, 193
  %_168.partselect = trunc i195 %314 to i1
  br label %src.addr.3476.exit

src.addr.3476.exit:                               ; preds = %src.addr.3476.case.1, %src.addr.3476.case.0, %src.addr.3374.exit
  %315 = phi i1 [ %_067.partselect, %src.addr.3476.case.0 ], [ %_168.partselect, %src.addr.3476.case.1 ], [ undef, %src.addr.3374.exit ]
  store i1 %315, i1* %dst.addr.3477, align 1
  %dst.addr.3579 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx81, i32 35
  switch i64 %for.loop.idx81, label %src.addr.3578.exit [
    i64 0, label %src.addr.3578.case.0
    i64 1, label %src.addr.3578.case.1
  ]

src.addr.3578.case.0:                             ; preds = %src.addr.3476.exit
  %316 = bitcast i195* %src_0 to i200*
  %317 = load i200, i200* %316
  %318 = trunc i200 %317 to i195
  %319 = lshr i195 %318, 194
  %_069.partselect = trunc i195 %319 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.1:                             ; preds = %src.addr.3476.exit
  %320 = bitcast i195* %src_1 to i200*
  %321 = load i200, i200* %320
  %322 = trunc i200 %321 to i195
  %323 = lshr i195 %322, 194
  %_170.partselect = trunc i195 %323 to i1
  br label %src.addr.3578.exit

src.addr.3578.exit:                               ; preds = %src.addr.3578.case.1, %src.addr.3578.case.0, %src.addr.3476.exit
  %324 = phi i1 [ %_069.partselect, %src.addr.3578.case.0 ], [ %_170.partselect, %src.addr.3578.case.1 ], [ undef, %src.addr.3476.exit ]
  store i1 %324, i1* %dst.addr.3579, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx81, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.3578.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a2struct.HeadCtx.17.20([2 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i195* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i195* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1) #1 {
entry:
  %0 = icmp eq [2 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i195* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a2struct.HeadCtx.18.19([2 x %struct.HeadCtx]* nonnull %dst, i195* nonnull %src_0, i195* %src_1, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out(i32* noalias "orig.arg.no"="0", i32* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i8* noalias "orig.arg.no"="10", i8* noalias readonly align 512 "orig.arg.no"="11", i32* noalias "orig.arg.no"="12", i32* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i32* noalias "orig.arg.no"="16", i32* noalias readonly align 512 "orig.arg.no"="17", [2 x %struct.HeadCtx]* noalias "orig.arg.no"="18", i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.0" %_0, i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.1" %_1, i1* noalias "orig.arg.no"="20", i1* noalias readonly align 512 "orig.arg.no"="21", i32* noalias "orig.arg.no"="22", i32* noalias readonly align 512 "orig.arg.no"="23", i1* noalias "orig.arg.no"="24", i1* noalias readonly align 512 "orig.arg.no"="25", i32* noalias "orig.arg.no"="26", i32* noalias readonly align 512 "orig.arg.no"="27", i1* noalias "orig.arg.no"="28", i1* noalias readonly align 512 "orig.arg.no"="29", i1* noalias "orig.arg.no"="30", i1* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35") #4 {
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
  call void @onebyonecpy_hls.p0a2struct.HeadCtx.17.20([2 x %struct.HeadCtx]* %18, i195* align 512 %_0, i195* align 512 %_1)
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

declare void @apatb_scheduler_hls_hw(i1, i1, i32*, i1*, i1*, i1, i1, i1*, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1, i1, i1, i195*, i195*, i1*, i32*, i1*, i32*, i1, i1*, i1, i1*, i32*, i32*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back(i32* noalias "orig.arg.no"="0", i32* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i8* noalias "orig.arg.no"="10", i8* noalias readonly align 512 "orig.arg.no"="11", i32* noalias "orig.arg.no"="12", i32* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i32* noalias "orig.arg.no"="16", i32* noalias readonly align 512 "orig.arg.no"="17", [2 x %struct.HeadCtx]* noalias "orig.arg.no"="18", i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.0" %_0, i195* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.1" %_1, i1* noalias "orig.arg.no"="20", i1* noalias readonly align 512 "orig.arg.no"="21", i32* noalias "orig.arg.no"="22", i32* noalias readonly align 512 "orig.arg.no"="23", i1* noalias "orig.arg.no"="24", i1* noalias readonly align 512 "orig.arg.no"="25", i32* noalias "orig.arg.no"="26", i32* noalias readonly align 512 "orig.arg.no"="27", i1* noalias "orig.arg.no"="28", i1* noalias readonly align 512 "orig.arg.no"="29", i1* noalias "orig.arg.no"="30", i1* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35") #4 {
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
  call void @onebyonecpy_hls.p0a2struct.HeadCtx.17.20([2 x %struct.HeadCtx]* %18, i195* align 512 %_0, i195* align 512 %_1)
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

declare void @scheduler_hls_hw_stub(i1 zeroext, i1 zeroext, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i8* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, [2 x %struct.HeadCtx]* noalias nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull)

define void @scheduler_hls_hw_stub_wrapper(i1, i1, i32*, i1*, i1*, i1, i1, i1*, i1, i1*, i8*, i32*, i32*, i32*, i1, i1, i1, i1, i1, i195*, i195*, i1*, i32*, i1*, i32*, i1, i1*, i1, i1*, i32*, i32*) #5 {
entry:
  %31 = call i8* @malloc(i64 104)
  %32 = bitcast i8* %31 to [2 x %struct.HeadCtx]*
  call void @copy_out(i32* null, i32* %2, i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %7, i1* null, i1* %9, i8* null, i8* %10, i32* null, i32* %11, i32* null, i32* %12, i32* null, i32* %13, [2 x %struct.HeadCtx]* %32, i195* %19, i195* %20, i1* null, i1* %21, i32* null, i32* %22, i1* null, i1* %23, i32* null, i32* %24, i1* null, i1* %26, i1* null, i1* %28, i32* null, i32* %29, i32* null, i32* %30)
  call void @scheduler_hls_hw_stub(i1 %0, i1 %1, i32* %2, i1* %3, i1* %4, i1 %5, i1 %6, i1* %7, i1 %8, i1* %9, i8* %10, i32* %11, i32* %12, i32* %13, i1 %14, i1 %15, i1 %16, i1 %17, i1 %18, [2 x %struct.HeadCtx]* %32, i1* %21, i32* %22, i1* %23, i32* %24, i1 %25, i1* %26, i1 %27, i1* %28, i32* %29, i32* %30)
  call void @copy_in(i32* null, i32* %2, i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %7, i1* null, i1* %9, i8* null, i8* %10, i32* null, i32* %11, i32* null, i32* %12, i32* null, i32* %13, [2 x %struct.HeadCtx]* %32, i195* %19, i195* %20, i1* null, i1* %21, i32* null, i32* %22, i1* null, i1* %23, i32* null, i32* %24, i1* null, i1* %26, i1* null, i1* %28, i32* null, i32* %29, i32* null, i32* %30)
  call void @free(i8* %31)
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
!7 = !{!"19", [2 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12}
!11 = !{!"19.0", %struct.HeadCtx* null}
!12 = !{!"19.1", %struct.HeadCtx* null}
