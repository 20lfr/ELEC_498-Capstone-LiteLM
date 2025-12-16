; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Top_Module/FSM_and_Control_FSM_top_module/transformer_top/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i8, i8, i8, i1, i1, i8, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }

; Function Attrs: noinline willreturn
define void @apatb_transformer_top_ir(i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %dma_done, i1 zeroext %compute_ready, i1 zeroext %compute_done, [4 x %struct.HeadCtx]* noalias nonnull dereferenceable(240) %head_ctx_ref, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i8* noalias nocapture nonnull dereferenceable(1) %compute_op, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i1 zeroext %wl_ready, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i8* noalias nocapture nonnull dereferenceable(1) %wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %wl_head, i32* noalias nocapture nonnull dereferenceable(4) %wl_tile, i32 %ctrl_addr, i32 %ctrl_data_in, i32 %ctrl_data_out, i1 zeroext %ctrl_read_en, i1 zeroext %ctrl_write_en, i1 zeroext %ctrl_chip_en, i1 zeroext %ctrl_resetn_in, i32* noalias nocapture nonnull dereferenceable(4) %dbg_state, i1 zeroext %done) local_unnamed_addr #0 {
entry:
  %axis_in_ready_copy = alloca i1, align 512
  %head_ctx_ref_copy_0 = alloca i202, align 512
  %head_ctx_ref_copy_1 = alloca i202, align 512
  %head_ctx_ref_copy_2 = alloca i202, align 512
  %head_ctx_ref_copy_3 = alloca i202, align 512
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i8, align 512
  %stream_start_copy = alloca i1, align 512
  %wl_start_copy = alloca i1, align 512
  %wl_addr_sel_copy = alloca i8, align 512
  %wl_layer_copy = alloca i32, align 512
  %wl_head_copy = alloca i32, align 512
  %wl_tile_copy = alloca i32, align 512
  %dbg_state_copy = alloca i32, align 512
  call void @copy_in(i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, [4 x %struct.HeadCtx]* nonnull %head_ctx_ref, i202* nonnull align 512 %head_ctx_ref_copy_0, i202* nonnull align 512 %head_ctx_ref_copy_1, i202* nonnull align 512 %head_ctx_ref_copy_2, i202* nonnull align 512 %head_ctx_ref_copy_3, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i8* nonnull %compute_op, i8* nonnull align 512 %compute_op_copy, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i8* nonnull %wl_addr_sel, i8* nonnull align 512 %wl_addr_sel_copy, i32* nonnull %wl_layer, i32* nonnull align 512 %wl_layer_copy, i32* nonnull %wl_head, i32* nonnull align 512 %wl_head_copy, i32* nonnull %wl_tile, i32* nonnull align 512 %wl_tile_copy, i32* nonnull %dbg_state, i32* nonnull align 512 %dbg_state_copy)
  call void @apatb_transformer_top_hw(i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %dma_done, i1 %compute_ready, i1 %compute_done, i202* %head_ctx_ref_copy_0, i202* %head_ctx_ref_copy_1, i202* %head_ctx_ref_copy_2, i202* %head_ctx_ref_copy_3, i1* %compute_start_copy, i8* %compute_op_copy, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i1 %wl_ready, i1* %wl_start_copy, i8* %wl_addr_sel_copy, i32* %wl_layer_copy, i32* %wl_head_copy, i32* %wl_tile_copy, i32 %ctrl_addr, i32 %ctrl_data_in, i32 %ctrl_data_out, i1 %ctrl_read_en, i1 %ctrl_write_en, i1 %ctrl_chip_en, i1 %ctrl_resetn_in, i32* %dbg_state_copy, i1 %done)
  call void @copy_back(i1* %axis_in_ready, i1* %axis_in_ready_copy, [4 x %struct.HeadCtx]* %head_ctx_ref, i202* %head_ctx_ref_copy_0, i202* %head_ctx_ref_copy_1, i202* %head_ctx_ref_copy_2, i202* %head_ctx_ref_copy_3, i1* %compute_start, i1* %compute_start_copy, i8* %compute_op, i8* %compute_op_copy, i1* %stream_start, i1* %stream_start_copy, i1* %wl_start, i1* %wl_start_copy, i8* %wl_addr_sel, i8* %wl_addr_sel_copy, i32* %wl_layer, i32* %wl_layer_copy, i32* %wl_head, i32* %wl_head_copy, i32* %wl_tile, i32* %wl_tile_copy, i32* %dbg_state, i32* %dbg_state_copy)
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
  %15 = load i8, i8* %src.addr.620, align 1
  store i8 %15, i8* %dst.addr.621, align 1
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 7
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 7
  %16 = load i8, i8* %src.addr.722, align 1
  store i8 %16, i8* %dst.addr.723, align 1
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
define void @arraycpy_hls.p0a4struct.HeadCtx.15.16(i202* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i202* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i202* "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i202* "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i202* %dst_0, null
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
  %4 = bitcast i202* %dst_0 to i208*
  %5 = load i208, i208* %4
  %6 = trunc i208 %5 to i202
  %7 = zext i32 %3 to i202
  %8 = and i202 %6, -4294967296
  %.partset171 = or i202 %8, %7
  store i202 %.partset171, i202* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i202* %dst_1 to i208*
  %10 = load i208, i208* %9
  %11 = trunc i208 %10 to i202
  %12 = zext i32 %3 to i202
  %13 = and i202 %11, -4294967296
  %.partset86 = or i202 %13, %12
  store i202 %.partset86, i202* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.2:                               ; preds = %for.loop
  %14 = bitcast i202* %dst_2 to i208*
  %15 = load i208, i208* %14
  %16 = trunc i208 %15 to i202
  %17 = zext i32 %3 to i202
  %18 = and i202 %16, -4294967296
  %.partset85 = or i202 %18, %17
  store i202 %.partset85, i202* %dst_2, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.3:                               ; preds = %for.loop
  %19 = bitcast i202* %dst_3 to i208*
  %20 = load i208, i208* %19
  %21 = trunc i208 %20 to i202
  %22 = zext i32 %3 to i202
  %23 = and i202 %21, -4294967296
  %.partset = or i202 %23, %22
  store i202 %.partset, i202* %dst_3, align 4
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
  %25 = bitcast i202* %dst_0 to i208*
  %26 = load i208, i208* %25
  %27 = trunc i208 %26 to i202
  %28 = zext i32 %24 to i202
  %29 = shl i202 %28, 32
  %30 = and i202 %27, -18446744069414584321
  %.partset170 = or i202 %30, %29
  store i202 %.partset170, i202* %dst_0, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %31 = bitcast i202* %dst_1 to i208*
  %32 = load i208, i208* %31
  %33 = trunc i208 %32 to i202
  %34 = zext i32 %24 to i202
  %35 = shl i202 %34, 32
  %36 = and i202 %33, -18446744069414584321
  %.partset87 = or i202 %36, %35
  store i202 %.partset87, i202* %dst_1, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.2:                              ; preds = %dst.addr.02.exit
  %37 = bitcast i202* %dst_2 to i208*
  %38 = load i208, i208* %37
  %39 = trunc i208 %38 to i202
  %40 = zext i32 %24 to i202
  %41 = shl i202 %40, 32
  %42 = and i202 %39, -18446744069414584321
  %.partset84 = or i202 %42, %41
  store i202 %.partset84, i202* %dst_2, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.3:                              ; preds = %dst.addr.02.exit
  %43 = bitcast i202* %dst_3 to i208*
  %44 = load i208, i208* %43
  %45 = trunc i208 %44 to i202
  %46 = zext i32 %24 to i202
  %47 = shl i202 %46, 32
  %48 = and i202 %45, -18446744069414584321
  %.partset1 = or i202 %48, %47
  store i202 %.partset1, i202* %dst_3, align 4
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
  %50 = bitcast i202* %dst_0 to i208*
  %51 = load i208, i208* %50
  %52 = trunc i208 %51 to i202
  %53 = zext i8 %49 to i202
  %54 = shl i202 %53, 64
  %55 = and i202 %52, -4703919738795935662081
  %.partset169 = or i202 %55, %54
  store i202 %.partset169, i202* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %56 = bitcast i202* %dst_1 to i208*
  %57 = load i208, i208* %56
  %58 = trunc i208 %57 to i202
  %59 = zext i8 %49 to i202
  %60 = shl i202 %59, 64
  %61 = and i202 %58, -4703919738795935662081
  %.partset88 = or i202 %61, %60
  store i202 %.partset88, i202* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.2:                              ; preds = %dst.addr.111.exit
  %62 = bitcast i202* %dst_2 to i208*
  %63 = load i208, i208* %62
  %64 = trunc i208 %63 to i202
  %65 = zext i8 %49 to i202
  %66 = shl i202 %65, 64
  %67 = and i202 %64, -4703919738795935662081
  %.partset83 = or i202 %67, %66
  store i202 %.partset83, i202* %dst_2, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.3:                              ; preds = %dst.addr.111.exit
  %68 = bitcast i202* %dst_3 to i208*
  %69 = load i208, i208* %68
  %70 = trunc i208 %69 to i202
  %71 = zext i8 %49 to i202
  %72 = shl i202 %71, 64
  %73 = and i202 %70, -4703919738795935662081
  %.partset2 = or i202 %73, %72
  store i202 %.partset2, i202* %dst_3, align 1
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
  %77 = bitcast i202* %dst_0 to i208*
  %78 = load i208, i208* %77
  %79 = trunc i208 %78 to i202
  %80 = zext i1 %76 to i202
  %81 = shl i202 %80, 72
  %82 = and i202 %79, -4722366482869645213697
  %.partset168 = or i202 %82, %81
  store i202 %.partset168, i202* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %83 = bitcast i202* %dst_1 to i208*
  %84 = load i208, i208* %83
  %85 = trunc i208 %84 to i202
  %86 = zext i1 %76 to i202
  %87 = shl i202 %86, 72
  %88 = and i202 %85, -4722366482869645213697
  %.partset89 = or i202 %88, %87
  store i202 %.partset89, i202* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.2:                              ; preds = %dst.addr.213.exit
  %89 = bitcast i202* %dst_2 to i208*
  %90 = load i208, i208* %89
  %91 = trunc i208 %90 to i202
  %92 = zext i1 %76 to i202
  %93 = shl i202 %92, 72
  %94 = and i202 %91, -4722366482869645213697
  %.partset82 = or i202 %94, %93
  store i202 %.partset82, i202* %dst_2, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.3:                              ; preds = %dst.addr.213.exit
  %95 = bitcast i202* %dst_3 to i208*
  %96 = load i208, i208* %95
  %97 = trunc i208 %96 to i202
  %98 = zext i1 %76 to i202
  %99 = shl i202 %98, 72
  %100 = and i202 %97, -4722366482869645213697
  %.partset3 = or i202 %100, %99
  store i202 %.partset3, i202* %dst_3, align 1
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
  %104 = bitcast i202* %dst_0 to i208*
  %105 = load i208, i208* %104
  %106 = trunc i208 %105 to i202
  %107 = zext i1 %103 to i202
  %108 = shl i202 %107, 73
  %109 = and i202 %106, -9444732965739290427393
  %.partset167 = or i202 %109, %108
  store i202 %.partset167, i202* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %110 = bitcast i202* %dst_1 to i208*
  %111 = load i208, i208* %110
  %112 = trunc i208 %111 to i202
  %113 = zext i1 %103 to i202
  %114 = shl i202 %113, 73
  %115 = and i202 %112, -9444732965739290427393
  %.partset90 = or i202 %115, %114
  store i202 %.partset90, i202* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.2:                              ; preds = %dst.addr.315.exit
  %116 = bitcast i202* %dst_2 to i208*
  %117 = load i208, i208* %116
  %118 = trunc i208 %117 to i202
  %119 = zext i1 %103 to i202
  %120 = shl i202 %119, 73
  %121 = and i202 %118, -9444732965739290427393
  %.partset81 = or i202 %121, %120
  store i202 %.partset81, i202* %dst_2, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.3:                              ; preds = %dst.addr.315.exit
  %122 = bitcast i202* %dst_3 to i208*
  %123 = load i208, i208* %122
  %124 = trunc i208 %123 to i202
  %125 = zext i1 %103 to i202
  %126 = shl i202 %125, 73
  %127 = and i202 %124, -9444732965739290427393
  %.partset4 = or i202 %127, %126
  store i202 %.partset4, i202* %dst_3, align 1
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
  %131 = bitcast i202* %dst_0 to i208*
  %132 = load i208, i208* %131
  %133 = trunc i208 %132 to i202
  %134 = zext i1 %130 to i202
  %135 = shl i202 %134, 74
  %136 = and i202 %133, -18889465931478580854785
  %.partset166 = or i202 %136, %135
  store i202 %.partset166, i202* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %137 = bitcast i202* %dst_1 to i208*
  %138 = load i208, i208* %137
  %139 = trunc i208 %138 to i202
  %140 = zext i1 %130 to i202
  %141 = shl i202 %140, 74
  %142 = and i202 %139, -18889465931478580854785
  %.partset91 = or i202 %142, %141
  store i202 %.partset91, i202* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.2:                              ; preds = %dst.addr.417.exit
  %143 = bitcast i202* %dst_2 to i208*
  %144 = load i208, i208* %143
  %145 = trunc i208 %144 to i202
  %146 = zext i1 %130 to i202
  %147 = shl i202 %146, 74
  %148 = and i202 %145, -18889465931478580854785
  %.partset80 = or i202 %148, %147
  store i202 %.partset80, i202* %dst_2, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.3:                              ; preds = %dst.addr.417.exit
  %149 = bitcast i202* %dst_3 to i208*
  %150 = load i208, i208* %149
  %151 = trunc i208 %150 to i202
  %152 = zext i1 %130 to i202
  %153 = shl i202 %152, 74
  %154 = and i202 %151, -18889465931478580854785
  %.partset5 = or i202 %154, %153
  store i202 %.partset5, i202* %dst_3, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.3, %dst.addr.519.case.2, %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 6
  %155 = load i8, i8* %src.addr.620, align 1
  switch i64 %for.loop.idx95, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
    i64 2, label %dst.addr.621.case.2
    i64 3, label %dst.addr.621.case.3
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %156 = bitcast i202* %dst_0 to i208*
  %157 = load i208, i208* %156
  %158 = trunc i208 %157 to i202
  %159 = zext i8 %155 to i202
  %160 = shl i202 %159, 75
  %161 = and i202 %158, -9633627625054076235939841
  %.partset165 = or i202 %161, %160
  store i202 %.partset165, i202* %dst_0, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %162 = bitcast i202* %dst_1 to i208*
  %163 = load i208, i208* %162
  %164 = trunc i208 %163 to i202
  %165 = zext i8 %155 to i202
  %166 = shl i202 %165, 75
  %167 = and i202 %164, -9633627625054076235939841
  %.partset92 = or i202 %167, %166
  store i202 %.partset92, i202* %dst_1, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.2:                              ; preds = %dst.addr.519.exit
  %168 = bitcast i202* %dst_2 to i208*
  %169 = load i208, i208* %168
  %170 = trunc i208 %169 to i202
  %171 = zext i8 %155 to i202
  %172 = shl i202 %171, 75
  %173 = and i202 %170, -9633627625054076235939841
  %.partset79 = or i202 %173, %172
  store i202 %.partset79, i202* %dst_2, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.3:                              ; preds = %dst.addr.519.exit
  %174 = bitcast i202* %dst_3 to i208*
  %175 = load i208, i208* %174
  %176 = trunc i208 %175 to i202
  %177 = zext i8 %155 to i202
  %178 = shl i202 %177, 75
  %179 = and i202 %176, -9633627625054076235939841
  %.partset6 = or i202 %179, %178
  store i202 %.partset6, i202* %dst_3, align 1
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.3, %dst.addr.621.case.2, %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx95, i32 7
  %180 = load i8, i8* %src.addr.722, align 1
  switch i64 %for.loop.idx95, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
    i64 2, label %dst.addr.723.case.2
    i64 3, label %dst.addr.723.case.3
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %181 = bitcast i202* %dst_0 to i208*
  %182 = load i208, i208* %181
  %183 = trunc i208 %182 to i202
  %184 = zext i8 %180 to i202
  %185 = shl i202 %184, 83
  %186 = and i202 %183, -2466208672013843516400599041
  %.partset164 = or i202 %186, %185
  store i202 %.partset164, i202* %dst_0, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %187 = bitcast i202* %dst_1 to i208*
  %188 = load i208, i208* %187
  %189 = trunc i208 %188 to i202
  %190 = zext i8 %180 to i202
  %191 = shl i202 %190, 83
  %192 = and i202 %189, -2466208672013843516400599041
  %.partset93 = or i202 %192, %191
  store i202 %.partset93, i202* %dst_1, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.2:                              ; preds = %dst.addr.621.exit
  %193 = bitcast i202* %dst_2 to i208*
  %194 = load i208, i208* %193
  %195 = trunc i208 %194 to i202
  %196 = zext i8 %180 to i202
  %197 = shl i202 %196, 83
  %198 = and i202 %195, -2466208672013843516400599041
  %.partset78 = or i202 %198, %197
  store i202 %.partset78, i202* %dst_2, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.3:                              ; preds = %dst.addr.621.exit
  %199 = bitcast i202* %dst_3 to i208*
  %200 = load i208, i208* %199
  %201 = trunc i208 %200 to i202
  %202 = zext i8 %180 to i202
  %203 = shl i202 %202, 83
  %204 = and i202 %201, -2466208672013843516400599041
  %.partset7 = or i202 %204, %203
  store i202 %.partset7, i202* %dst_3, align 1
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
  %206 = bitcast i202* %dst_0 to i208*
  %207 = load i208, i208* %206
  %208 = trunc i208 %207 to i202
  %209 = zext i8 %205 to i202
  %210 = shl i202 %209, 91
  %211 = and i202 %208, -631349420035543940198553354241
  %.partset163 = or i202 %211, %210
  store i202 %.partset163, i202* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %212 = bitcast i202* %dst_1 to i208*
  %213 = load i208, i208* %212
  %214 = trunc i208 %213 to i202
  %215 = zext i8 %205 to i202
  %216 = shl i202 %215, 91
  %217 = and i202 %214, -631349420035543940198553354241
  %.partset94 = or i202 %217, %216
  store i202 %.partset94, i202* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.2:                              ; preds = %dst.addr.723.exit
  %218 = bitcast i202* %dst_2 to i208*
  %219 = load i208, i208* %218
  %220 = trunc i208 %219 to i202
  %221 = zext i8 %205 to i202
  %222 = shl i202 %221, 91
  %223 = and i202 %220, -631349420035543940198553354241
  %.partset77 = or i202 %223, %222
  store i202 %.partset77, i202* %dst_2, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.3:                              ; preds = %dst.addr.723.exit
  %224 = bitcast i202* %dst_3 to i208*
  %225 = load i208, i208* %224
  %226 = trunc i208 %225 to i202
  %227 = zext i8 %205 to i202
  %228 = shl i202 %227, 91
  %229 = and i202 %226, -631349420035543940198553354241
  %.partset8 = or i202 %229, %228
  store i202 %.partset8, i202* %dst_3, align 1
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
  %233 = bitcast i202* %dst_0 to i208*
  %234 = load i208, i208* %233
  %235 = trunc i208 %234 to i202
  %236 = zext i1 %232 to i202
  %237 = shl i202 %236, 99
  %238 = and i202 %235, -633825300114114700748351602689
  %.partset162 = or i202 %238, %237
  store i202 %.partset162, i202* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %239 = bitcast i202* %dst_1 to i208*
  %240 = load i208, i208* %239
  %241 = trunc i208 %240 to i202
  %242 = zext i1 %232 to i202
  %243 = shl i202 %242, 99
  %244 = and i202 %241, -633825300114114700748351602689
  %.partset95 = or i202 %244, %243
  store i202 %.partset95, i202* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.2:                              ; preds = %dst.addr.825.exit
  %245 = bitcast i202* %dst_2 to i208*
  %246 = load i208, i208* %245
  %247 = trunc i208 %246 to i202
  %248 = zext i1 %232 to i202
  %249 = shl i202 %248, 99
  %250 = and i202 %247, -633825300114114700748351602689
  %.partset76 = or i202 %250, %249
  store i202 %.partset76, i202* %dst_2, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.3:                              ; preds = %dst.addr.825.exit
  %251 = bitcast i202* %dst_3 to i208*
  %252 = load i208, i208* %251
  %253 = trunc i208 %252 to i202
  %254 = zext i1 %232 to i202
  %255 = shl i202 %254, 99
  %256 = and i202 %253, -633825300114114700748351602689
  %.partset9 = or i202 %256, %255
  store i202 %.partset9, i202* %dst_3, align 1
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
  %260 = bitcast i202* %dst_0 to i208*
  %261 = load i208, i208* %260
  %262 = trunc i208 %261 to i202
  %263 = zext i1 %259 to i202
  %264 = shl i202 %263, 100
  %265 = and i202 %262, -1267650600228229401496703205377
  %.partset161 = or i202 %265, %264
  store i202 %.partset161, i202* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %266 = bitcast i202* %dst_1 to i208*
  %267 = load i208, i208* %266
  %268 = trunc i208 %267 to i202
  %269 = zext i1 %259 to i202
  %270 = shl i202 %269, 100
  %271 = and i202 %268, -1267650600228229401496703205377
  %.partset96 = or i202 %271, %270
  store i202 %.partset96, i202* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.2:                             ; preds = %dst.addr.927.exit
  %272 = bitcast i202* %dst_2 to i208*
  %273 = load i208, i208* %272
  %274 = trunc i208 %273 to i202
  %275 = zext i1 %259 to i202
  %276 = shl i202 %275, 100
  %277 = and i202 %274, -1267650600228229401496703205377
  %.partset75 = or i202 %277, %276
  store i202 %.partset75, i202* %dst_2, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.3:                             ; preds = %dst.addr.927.exit
  %278 = bitcast i202* %dst_3 to i208*
  %279 = load i208, i208* %278
  %280 = trunc i208 %279 to i202
  %281 = zext i1 %259 to i202
  %282 = shl i202 %281, 100
  %283 = and i202 %280, -1267650600228229401496703205377
  %.partset10 = or i202 %283, %282
  store i202 %.partset10, i202* %dst_3, align 1
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
  %285 = bitcast i202* %dst_0 to i208*
  %286 = load i208, i208* %285
  %287 = trunc i208 %286 to i202
  %288 = zext i8 %284 to i202
  %289 = shl i202 %288, 101
  %290 = and i202 %287, -646501806116396994763318634741761
  %.partset160 = or i202 %290, %289
  store i202 %.partset160, i202* %dst_0, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %291 = bitcast i202* %dst_1 to i208*
  %292 = load i208, i208* %291
  %293 = trunc i208 %292 to i202
  %294 = zext i8 %284 to i202
  %295 = shl i202 %294, 101
  %296 = and i202 %293, -646501806116396994763318634741761
  %.partset97 = or i202 %296, %295
  store i202 %.partset97, i202* %dst_1, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.2:                             ; preds = %dst.addr.1029.exit
  %297 = bitcast i202* %dst_2 to i208*
  %298 = load i208, i208* %297
  %299 = trunc i208 %298 to i202
  %300 = zext i8 %284 to i202
  %301 = shl i202 %300, 101
  %302 = and i202 %299, -646501806116396994763318634741761
  %.partset74 = or i202 %302, %301
  store i202 %.partset74, i202* %dst_2, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.3:                             ; preds = %dst.addr.1029.exit
  %303 = bitcast i202* %dst_3 to i208*
  %304 = load i208, i208* %303
  %305 = trunc i208 %304 to i202
  %306 = zext i8 %284 to i202
  %307 = shl i202 %306, 101
  %308 = and i202 %305, -646501806116396994763318634741761
  %.partset11 = or i202 %308, %307
  store i202 %.partset11, i202* %dst_3, align 1
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
  %310 = bitcast i202* %dst_0 to i208*
  %311 = load i208, i208* %310
  %312 = trunc i208 %311 to i202
  %313 = zext i32 %309 to i202
  %314 = shl i202 %313, 109
  %315 = and i202 %312, -2787593149167290785375111330514733147095041
  %.partset159 = or i202 %315, %314
  store i202 %.partset159, i202* %dst_0, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %316 = bitcast i202* %dst_1 to i208*
  %317 = load i208, i208* %316
  %318 = trunc i208 %317 to i202
  %319 = zext i32 %309 to i202
  %320 = shl i202 %319, 109
  %321 = and i202 %318, -2787593149167290785375111330514733147095041
  %.partset98 = or i202 %321, %320
  store i202 %.partset98, i202* %dst_1, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.2:                             ; preds = %dst.addr.1131.exit
  %322 = bitcast i202* %dst_2 to i208*
  %323 = load i208, i208* %322
  %324 = trunc i208 %323 to i202
  %325 = zext i32 %309 to i202
  %326 = shl i202 %325, 109
  %327 = and i202 %324, -2787593149167290785375111330514733147095041
  %.partset73 = or i202 %327, %326
  store i202 %.partset73, i202* %dst_2, align 4
  br label %dst.addr.1233.exit

dst.addr.1233.case.3:                             ; preds = %dst.addr.1131.exit
  %328 = bitcast i202* %dst_3 to i208*
  %329 = load i208, i208* %328
  %330 = trunc i208 %329 to i202
  %331 = zext i32 %309 to i202
  %332 = shl i202 %331, 109
  %333 = and i202 %330, -2787593149167290785375111330514733147095041
  %.partset12 = or i202 %333, %332
  store i202 %.partset12, i202* %dst_3, align 4
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
  %335 = bitcast i202* %dst_0 to i208*
  %336 = load i208, i208* %335
  %337 = trunc i208 %336 to i202
  %338 = zext i32 %334 to i202
  %339 = shl i202 %338, 141
  %340 = and i202 %337, -11972621410227163556108258256919825712940354203811841
  %.partset158 = or i202 %340, %339
  store i202 %.partset158, i202* %dst_0, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %341 = bitcast i202* %dst_1 to i208*
  %342 = load i208, i208* %341
  %343 = trunc i208 %342 to i202
  %344 = zext i32 %334 to i202
  %345 = shl i202 %344, 141
  %346 = and i202 %343, -11972621410227163556108258256919825712940354203811841
  %.partset99 = or i202 %346, %345
  store i202 %.partset99, i202* %dst_1, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.2:                             ; preds = %dst.addr.1233.exit
  %347 = bitcast i202* %dst_2 to i208*
  %348 = load i208, i208* %347
  %349 = trunc i208 %348 to i202
  %350 = zext i32 %334 to i202
  %351 = shl i202 %350, 141
  %352 = and i202 %349, -11972621410227163556108258256919825712940354203811841
  %.partset72 = or i202 %352, %351
  store i202 %.partset72, i202* %dst_2, align 4
  br label %dst.addr.1335.exit

dst.addr.1335.case.3:                             ; preds = %dst.addr.1233.exit
  %353 = bitcast i202* %dst_3 to i208*
  %354 = load i208, i208* %353
  %355 = trunc i208 %354 to i202
  %356 = zext i32 %334 to i202
  %357 = shl i202 %356, 141
  %358 = and i202 %355, -11972621410227163556108258256919825712940354203811841
  %.partset13 = or i202 %358, %357
  store i202 %.partset13, i202* %dst_3, align 4
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
  %362 = bitcast i202* %dst_0 to i208*
  %363 = load i208, i208* %362
  %364 = trunc i208 %363 to i202
  %365 = zext i1 %361 to i202
  %366 = shl i202 %365, 173
  %367 = and i202 %364, -11972621413014756705924586149611790497021399392059393
  %.partset157 = or i202 %367, %366
  store i202 %.partset157, i202* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %368 = bitcast i202* %dst_1 to i208*
  %369 = load i208, i208* %368
  %370 = trunc i208 %369 to i202
  %371 = zext i1 %361 to i202
  %372 = shl i202 %371, 173
  %373 = and i202 %370, -11972621413014756705924586149611790497021399392059393
  %.partset100 = or i202 %373, %372
  store i202 %.partset100, i202* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.2:                             ; preds = %dst.addr.1335.exit
  %374 = bitcast i202* %dst_2 to i208*
  %375 = load i208, i208* %374
  %376 = trunc i208 %375 to i202
  %377 = zext i1 %361 to i202
  %378 = shl i202 %377, 173
  %379 = and i202 %376, -11972621413014756705924586149611790497021399392059393
  %.partset71 = or i202 %379, %378
  store i202 %.partset71, i202* %dst_2, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.3:                             ; preds = %dst.addr.1335.exit
  %380 = bitcast i202* %dst_3 to i208*
  %381 = load i208, i208* %380
  %382 = trunc i208 %381 to i202
  %383 = zext i1 %361 to i202
  %384 = shl i202 %383, 173
  %385 = and i202 %382, -11972621413014756705924586149611790497021399392059393
  %.partset14 = or i202 %385, %384
  store i202 %.partset14, i202* %dst_3, align 1
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
  %389 = bitcast i202* %dst_0 to i208*
  %390 = load i208, i208* %389
  %391 = trunc i208 %390 to i202
  %392 = zext i1 %388 to i202
  %393 = shl i202 %392, 174
  %394 = and i202 %391, -23945242826029513411849172299223580994042798784118785
  %.partset156 = or i202 %394, %393
  store i202 %.partset156, i202* %dst_0, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %395 = bitcast i202* %dst_1 to i208*
  %396 = load i208, i208* %395
  %397 = trunc i208 %396 to i202
  %398 = zext i1 %388 to i202
  %399 = shl i202 %398, 174
  %400 = and i202 %397, -23945242826029513411849172299223580994042798784118785
  %.partset101 = or i202 %400, %399
  store i202 %.partset101, i202* %dst_1, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.2:                             ; preds = %dst.addr.1437.exit
  %401 = bitcast i202* %dst_2 to i208*
  %402 = load i208, i208* %401
  %403 = trunc i208 %402 to i202
  %404 = zext i1 %388 to i202
  %405 = shl i202 %404, 174
  %406 = and i202 %403, -23945242826029513411849172299223580994042798784118785
  %.partset70 = or i202 %406, %405
  store i202 %.partset70, i202* %dst_2, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.3:                             ; preds = %dst.addr.1437.exit
  %407 = bitcast i202* %dst_3 to i208*
  %408 = load i208, i208* %407
  %409 = trunc i208 %408 to i202
  %410 = zext i1 %388 to i202
  %411 = shl i202 %410, 174
  %412 = and i202 %409, -23945242826029513411849172299223580994042798784118785
  %.partset15 = or i202 %412, %411
  store i202 %.partset15, i202* %dst_3, align 1
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
  %416 = bitcast i202* %dst_0 to i208*
  %417 = load i208, i208* %416
  %418 = trunc i208 %417 to i202
  %419 = zext i1 %415 to i202
  %420 = shl i202 %419, 175
  %421 = and i202 %418, -47890485652059026823698344598447161988085597568237569
  %.partset155 = or i202 %421, %420
  store i202 %.partset155, i202* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %422 = bitcast i202* %dst_1 to i208*
  %423 = load i208, i208* %422
  %424 = trunc i208 %423 to i202
  %425 = zext i1 %415 to i202
  %426 = shl i202 %425, 175
  %427 = and i202 %424, -47890485652059026823698344598447161988085597568237569
  %.partset102 = or i202 %427, %426
  store i202 %.partset102, i202* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.2:                             ; preds = %dst.addr.1539.exit
  %428 = bitcast i202* %dst_2 to i208*
  %429 = load i208, i208* %428
  %430 = trunc i208 %429 to i202
  %431 = zext i1 %415 to i202
  %432 = shl i202 %431, 175
  %433 = and i202 %430, -47890485652059026823698344598447161988085597568237569
  %.partset69 = or i202 %433, %432
  store i202 %.partset69, i202* %dst_2, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.3:                             ; preds = %dst.addr.1539.exit
  %434 = bitcast i202* %dst_3 to i208*
  %435 = load i208, i208* %434
  %436 = trunc i208 %435 to i202
  %437 = zext i1 %415 to i202
  %438 = shl i202 %437, 175
  %439 = and i202 %436, -47890485652059026823698344598447161988085597568237569
  %.partset16 = or i202 %439, %438
  store i202 %.partset16, i202* %dst_3, align 1
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
  %443 = bitcast i202* %dst_0 to i208*
  %444 = load i208, i208* %443
  %445 = trunc i208 %444 to i202
  %446 = zext i1 %442 to i202
  %447 = shl i202 %446, 176
  %448 = and i202 %445, -95780971304118053647396689196894323976171195136475137
  %.partset154 = or i202 %448, %447
  store i202 %.partset154, i202* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %449 = bitcast i202* %dst_1 to i208*
  %450 = load i208, i208* %449
  %451 = trunc i208 %450 to i202
  %452 = zext i1 %442 to i202
  %453 = shl i202 %452, 176
  %454 = and i202 %451, -95780971304118053647396689196894323976171195136475137
  %.partset103 = or i202 %454, %453
  store i202 %.partset103, i202* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.2:                             ; preds = %dst.addr.1641.exit
  %455 = bitcast i202* %dst_2 to i208*
  %456 = load i208, i208* %455
  %457 = trunc i208 %456 to i202
  %458 = zext i1 %442 to i202
  %459 = shl i202 %458, 176
  %460 = and i202 %457, -95780971304118053647396689196894323976171195136475137
  %.partset68 = or i202 %460, %459
  store i202 %.partset68, i202* %dst_2, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.3:                             ; preds = %dst.addr.1641.exit
  %461 = bitcast i202* %dst_3 to i208*
  %462 = load i208, i208* %461
  %463 = trunc i208 %462 to i202
  %464 = zext i1 %442 to i202
  %465 = shl i202 %464, 176
  %466 = and i202 %463, -95780971304118053647396689196894323976171195136475137
  %.partset17 = or i202 %466, %465
  store i202 %.partset17, i202* %dst_3, align 1
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
  %470 = bitcast i202* %dst_0 to i208*
  %471 = load i208, i208* %470
  %472 = trunc i208 %471 to i202
  %473 = zext i1 %469 to i202
  %474 = shl i202 %473, 177
  %475 = and i202 %472, -191561942608236107294793378393788647952342390272950273
  %.partset153 = or i202 %475, %474
  store i202 %.partset153, i202* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %476 = bitcast i202* %dst_1 to i208*
  %477 = load i208, i208* %476
  %478 = trunc i208 %477 to i202
  %479 = zext i1 %469 to i202
  %480 = shl i202 %479, 177
  %481 = and i202 %478, -191561942608236107294793378393788647952342390272950273
  %.partset104 = or i202 %481, %480
  store i202 %.partset104, i202* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.2:                             ; preds = %dst.addr.1743.exit
  %482 = bitcast i202* %dst_2 to i208*
  %483 = load i208, i208* %482
  %484 = trunc i208 %483 to i202
  %485 = zext i1 %469 to i202
  %486 = shl i202 %485, 177
  %487 = and i202 %484, -191561942608236107294793378393788647952342390272950273
  %.partset67 = or i202 %487, %486
  store i202 %.partset67, i202* %dst_2, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.3:                             ; preds = %dst.addr.1743.exit
  %488 = bitcast i202* %dst_3 to i208*
  %489 = load i208, i208* %488
  %490 = trunc i208 %489 to i202
  %491 = zext i1 %469 to i202
  %492 = shl i202 %491, 177
  %493 = and i202 %490, -191561942608236107294793378393788647952342390272950273
  %.partset18 = or i202 %493, %492
  store i202 %.partset18, i202* %dst_3, align 1
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
  %497 = bitcast i202* %dst_0 to i208*
  %498 = load i208, i208* %497
  %499 = trunc i208 %498 to i202
  %500 = zext i1 %496 to i202
  %501 = shl i202 %500, 178
  %502 = and i202 %499, -383123885216472214589586756787577295904684780545900545
  %.partset152 = or i202 %502, %501
  store i202 %.partset152, i202* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %503 = bitcast i202* %dst_1 to i208*
  %504 = load i208, i208* %503
  %505 = trunc i208 %504 to i202
  %506 = zext i1 %496 to i202
  %507 = shl i202 %506, 178
  %508 = and i202 %505, -383123885216472214589586756787577295904684780545900545
  %.partset105 = or i202 %508, %507
  store i202 %.partset105, i202* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.2:                             ; preds = %dst.addr.1845.exit
  %509 = bitcast i202* %dst_2 to i208*
  %510 = load i208, i208* %509
  %511 = trunc i208 %510 to i202
  %512 = zext i1 %496 to i202
  %513 = shl i202 %512, 178
  %514 = and i202 %511, -383123885216472214589586756787577295904684780545900545
  %.partset66 = or i202 %514, %513
  store i202 %.partset66, i202* %dst_2, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.3:                             ; preds = %dst.addr.1845.exit
  %515 = bitcast i202* %dst_3 to i208*
  %516 = load i208, i208* %515
  %517 = trunc i208 %516 to i202
  %518 = zext i1 %496 to i202
  %519 = shl i202 %518, 178
  %520 = and i202 %517, -383123885216472214589586756787577295904684780545900545
  %.partset19 = or i202 %520, %519
  store i202 %.partset19, i202* %dst_3, align 1
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
  %524 = bitcast i202* %dst_0 to i208*
  %525 = load i208, i208* %524
  %526 = trunc i208 %525 to i202
  %527 = zext i1 %523 to i202
  %528 = shl i202 %527, 179
  %529 = and i202 %526, -766247770432944429179173513575154591809369561091801089
  %.partset151 = or i202 %529, %528
  store i202 %.partset151, i202* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %530 = bitcast i202* %dst_1 to i208*
  %531 = load i208, i208* %530
  %532 = trunc i208 %531 to i202
  %533 = zext i1 %523 to i202
  %534 = shl i202 %533, 179
  %535 = and i202 %532, -766247770432944429179173513575154591809369561091801089
  %.partset106 = or i202 %535, %534
  store i202 %.partset106, i202* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.2:                             ; preds = %dst.addr.1947.exit
  %536 = bitcast i202* %dst_2 to i208*
  %537 = load i208, i208* %536
  %538 = trunc i208 %537 to i202
  %539 = zext i1 %523 to i202
  %540 = shl i202 %539, 179
  %541 = and i202 %538, -766247770432944429179173513575154591809369561091801089
  %.partset65 = or i202 %541, %540
  store i202 %.partset65, i202* %dst_2, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.3:                             ; preds = %dst.addr.1947.exit
  %542 = bitcast i202* %dst_3 to i208*
  %543 = load i208, i208* %542
  %544 = trunc i208 %543 to i202
  %545 = zext i1 %523 to i202
  %546 = shl i202 %545, 179
  %547 = and i202 %544, -766247770432944429179173513575154591809369561091801089
  %.partset20 = or i202 %547, %546
  store i202 %.partset20, i202* %dst_3, align 1
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
  %551 = bitcast i202* %dst_0 to i208*
  %552 = load i208, i208* %551
  %553 = trunc i208 %552 to i202
  %554 = zext i1 %550 to i202
  %555 = shl i202 %554, 180
  %556 = and i202 %553, -1532495540865888858358347027150309183618739122183602177
  %.partset150 = or i202 %556, %555
  store i202 %.partset150, i202* %dst_0, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.1:                             ; preds = %dst.addr.2049.exit
  %557 = bitcast i202* %dst_1 to i208*
  %558 = load i208, i208* %557
  %559 = trunc i208 %558 to i202
  %560 = zext i1 %550 to i202
  %561 = shl i202 %560, 180
  %562 = and i202 %559, -1532495540865888858358347027150309183618739122183602177
  %.partset107 = or i202 %562, %561
  store i202 %.partset107, i202* %dst_1, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.2:                             ; preds = %dst.addr.2049.exit
  %563 = bitcast i202* %dst_2 to i208*
  %564 = load i208, i208* %563
  %565 = trunc i208 %564 to i202
  %566 = zext i1 %550 to i202
  %567 = shl i202 %566, 180
  %568 = and i202 %565, -1532495540865888858358347027150309183618739122183602177
  %.partset64 = or i202 %568, %567
  store i202 %.partset64, i202* %dst_2, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.3:                             ; preds = %dst.addr.2049.exit
  %569 = bitcast i202* %dst_3 to i208*
  %570 = load i208, i208* %569
  %571 = trunc i208 %570 to i202
  %572 = zext i1 %550 to i202
  %573 = shl i202 %572, 180
  %574 = and i202 %571, -1532495540865888858358347027150309183618739122183602177
  %.partset21 = or i202 %574, %573
  store i202 %.partset21, i202* %dst_3, align 1
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
  %578 = bitcast i202* %dst_0 to i208*
  %579 = load i208, i208* %578
  %580 = trunc i208 %579 to i202
  %581 = zext i1 %577 to i202
  %582 = shl i202 %581, 181
  %583 = and i202 %580, -3064991081731777716716694054300618367237478244367204353
  %.partset149 = or i202 %583, %582
  store i202 %.partset149, i202* %dst_0, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.1:                             ; preds = %dst.addr.2151.exit
  %584 = bitcast i202* %dst_1 to i208*
  %585 = load i208, i208* %584
  %586 = trunc i208 %585 to i202
  %587 = zext i1 %577 to i202
  %588 = shl i202 %587, 181
  %589 = and i202 %586, -3064991081731777716716694054300618367237478244367204353
  %.partset108 = or i202 %589, %588
  store i202 %.partset108, i202* %dst_1, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.2:                             ; preds = %dst.addr.2151.exit
  %590 = bitcast i202* %dst_2 to i208*
  %591 = load i208, i208* %590
  %592 = trunc i208 %591 to i202
  %593 = zext i1 %577 to i202
  %594 = shl i202 %593, 181
  %595 = and i202 %592, -3064991081731777716716694054300618367237478244367204353
  %.partset63 = or i202 %595, %594
  store i202 %.partset63, i202* %dst_2, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.3:                             ; preds = %dst.addr.2151.exit
  %596 = bitcast i202* %dst_3 to i208*
  %597 = load i208, i208* %596
  %598 = trunc i208 %597 to i202
  %599 = zext i1 %577 to i202
  %600 = shl i202 %599, 181
  %601 = and i202 %598, -3064991081731777716716694054300618367237478244367204353
  %.partset22 = or i202 %601, %600
  store i202 %.partset22, i202* %dst_3, align 1
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
  %605 = bitcast i202* %dst_0 to i208*
  %606 = load i208, i208* %605
  %607 = trunc i208 %606 to i202
  %608 = zext i1 %604 to i202
  %609 = shl i202 %608, 182
  %610 = and i202 %607, -6129982163463555433433388108601236734474956488734408705
  %.partset148 = or i202 %610, %609
  store i202 %.partset148, i202* %dst_0, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.1:                             ; preds = %dst.addr.2253.exit
  %611 = bitcast i202* %dst_1 to i208*
  %612 = load i208, i208* %611
  %613 = trunc i208 %612 to i202
  %614 = zext i1 %604 to i202
  %615 = shl i202 %614, 182
  %616 = and i202 %613, -6129982163463555433433388108601236734474956488734408705
  %.partset109 = or i202 %616, %615
  store i202 %.partset109, i202* %dst_1, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.2:                             ; preds = %dst.addr.2253.exit
  %617 = bitcast i202* %dst_2 to i208*
  %618 = load i208, i208* %617
  %619 = trunc i208 %618 to i202
  %620 = zext i1 %604 to i202
  %621 = shl i202 %620, 182
  %622 = and i202 %619, -6129982163463555433433388108601236734474956488734408705
  %.partset62 = or i202 %622, %621
  store i202 %.partset62, i202* %dst_2, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.3:                             ; preds = %dst.addr.2253.exit
  %623 = bitcast i202* %dst_3 to i208*
  %624 = load i208, i208* %623
  %625 = trunc i208 %624 to i202
  %626 = zext i1 %604 to i202
  %627 = shl i202 %626, 182
  %628 = and i202 %625, -6129982163463555433433388108601236734474956488734408705
  %.partset23 = or i202 %628, %627
  store i202 %.partset23, i202* %dst_3, align 1
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
  %632 = bitcast i202* %dst_0 to i208*
  %633 = load i208, i208* %632
  %634 = trunc i208 %633 to i202
  %635 = zext i1 %631 to i202
  %636 = shl i202 %635, 183
  %637 = and i202 %634, -12259964326927110866866776217202473468949912977468817409
  %.partset147 = or i202 %637, %636
  store i202 %.partset147, i202* %dst_0, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.1:                             ; preds = %dst.addr.2355.exit
  %638 = bitcast i202* %dst_1 to i208*
  %639 = load i208, i208* %638
  %640 = trunc i208 %639 to i202
  %641 = zext i1 %631 to i202
  %642 = shl i202 %641, 183
  %643 = and i202 %640, -12259964326927110866866776217202473468949912977468817409
  %.partset110 = or i202 %643, %642
  store i202 %.partset110, i202* %dst_1, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.2:                             ; preds = %dst.addr.2355.exit
  %644 = bitcast i202* %dst_2 to i208*
  %645 = load i208, i208* %644
  %646 = trunc i208 %645 to i202
  %647 = zext i1 %631 to i202
  %648 = shl i202 %647, 183
  %649 = and i202 %646, -12259964326927110866866776217202473468949912977468817409
  %.partset61 = or i202 %649, %648
  store i202 %.partset61, i202* %dst_2, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.3:                             ; preds = %dst.addr.2355.exit
  %650 = bitcast i202* %dst_3 to i208*
  %651 = load i208, i208* %650
  %652 = trunc i208 %651 to i202
  %653 = zext i1 %631 to i202
  %654 = shl i202 %653, 183
  %655 = and i202 %652, -12259964326927110866866776217202473468949912977468817409
  %.partset24 = or i202 %655, %654
  store i202 %.partset24, i202* %dst_3, align 1
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
  %659 = bitcast i202* %dst_0 to i208*
  %660 = load i208, i208* %659
  %661 = trunc i208 %660 to i202
  %662 = zext i1 %658 to i202
  %663 = shl i202 %662, 184
  %664 = and i202 %661, -24519928653854221733733552434404946937899825954937634817
  %.partset146 = or i202 %664, %663
  store i202 %.partset146, i202* %dst_0, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.1:                             ; preds = %dst.addr.2457.exit
  %665 = bitcast i202* %dst_1 to i208*
  %666 = load i208, i208* %665
  %667 = trunc i208 %666 to i202
  %668 = zext i1 %658 to i202
  %669 = shl i202 %668, 184
  %670 = and i202 %667, -24519928653854221733733552434404946937899825954937634817
  %.partset111 = or i202 %670, %669
  store i202 %.partset111, i202* %dst_1, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.2:                             ; preds = %dst.addr.2457.exit
  %671 = bitcast i202* %dst_2 to i208*
  %672 = load i208, i208* %671
  %673 = trunc i208 %672 to i202
  %674 = zext i1 %658 to i202
  %675 = shl i202 %674, 184
  %676 = and i202 %673, -24519928653854221733733552434404946937899825954937634817
  %.partset60 = or i202 %676, %675
  store i202 %.partset60, i202* %dst_2, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.3:                             ; preds = %dst.addr.2457.exit
  %677 = bitcast i202* %dst_3 to i208*
  %678 = load i208, i208* %677
  %679 = trunc i208 %678 to i202
  %680 = zext i1 %658 to i202
  %681 = shl i202 %680, 184
  %682 = and i202 %679, -24519928653854221733733552434404946937899825954937634817
  %.partset25 = or i202 %682, %681
  store i202 %.partset25, i202* %dst_3, align 1
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
  %686 = bitcast i202* %dst_0 to i208*
  %687 = load i208, i208* %686
  %688 = trunc i208 %687 to i202
  %689 = zext i1 %685 to i202
  %690 = shl i202 %689, 185
  %691 = and i202 %688, -49039857307708443467467104868809893875799651909875269633
  %.partset145 = or i202 %691, %690
  store i202 %.partset145, i202* %dst_0, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.1:                             ; preds = %dst.addr.2559.exit
  %692 = bitcast i202* %dst_1 to i208*
  %693 = load i208, i208* %692
  %694 = trunc i208 %693 to i202
  %695 = zext i1 %685 to i202
  %696 = shl i202 %695, 185
  %697 = and i202 %694, -49039857307708443467467104868809893875799651909875269633
  %.partset112 = or i202 %697, %696
  store i202 %.partset112, i202* %dst_1, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.2:                             ; preds = %dst.addr.2559.exit
  %698 = bitcast i202* %dst_2 to i208*
  %699 = load i208, i208* %698
  %700 = trunc i208 %699 to i202
  %701 = zext i1 %685 to i202
  %702 = shl i202 %701, 185
  %703 = and i202 %700, -49039857307708443467467104868809893875799651909875269633
  %.partset59 = or i202 %703, %702
  store i202 %.partset59, i202* %dst_2, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.3:                             ; preds = %dst.addr.2559.exit
  %704 = bitcast i202* %dst_3 to i208*
  %705 = load i208, i208* %704
  %706 = trunc i208 %705 to i202
  %707 = zext i1 %685 to i202
  %708 = shl i202 %707, 185
  %709 = and i202 %706, -49039857307708443467467104868809893875799651909875269633
  %.partset26 = or i202 %709, %708
  store i202 %.partset26, i202* %dst_3, align 1
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
  %713 = bitcast i202* %dst_0 to i208*
  %714 = load i208, i208* %713
  %715 = trunc i208 %714 to i202
  %716 = zext i1 %712 to i202
  %717 = shl i202 %716, 186
  %718 = and i202 %715, -98079714615416886934934209737619787751599303819750539265
  %.partset144 = or i202 %718, %717
  store i202 %.partset144, i202* %dst_0, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.1:                             ; preds = %dst.addr.2661.exit
  %719 = bitcast i202* %dst_1 to i208*
  %720 = load i208, i208* %719
  %721 = trunc i208 %720 to i202
  %722 = zext i1 %712 to i202
  %723 = shl i202 %722, 186
  %724 = and i202 %721, -98079714615416886934934209737619787751599303819750539265
  %.partset113 = or i202 %724, %723
  store i202 %.partset113, i202* %dst_1, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.2:                             ; preds = %dst.addr.2661.exit
  %725 = bitcast i202* %dst_2 to i208*
  %726 = load i208, i208* %725
  %727 = trunc i208 %726 to i202
  %728 = zext i1 %712 to i202
  %729 = shl i202 %728, 186
  %730 = and i202 %727, -98079714615416886934934209737619787751599303819750539265
  %.partset58 = or i202 %730, %729
  store i202 %.partset58, i202* %dst_2, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.3:                             ; preds = %dst.addr.2661.exit
  %731 = bitcast i202* %dst_3 to i208*
  %732 = load i208, i208* %731
  %733 = trunc i208 %732 to i202
  %734 = zext i1 %712 to i202
  %735 = shl i202 %734, 186
  %736 = and i202 %733, -98079714615416886934934209737619787751599303819750539265
  %.partset27 = or i202 %736, %735
  store i202 %.partset27, i202* %dst_3, align 1
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
  %740 = bitcast i202* %dst_0 to i208*
  %741 = load i208, i208* %740
  %742 = trunc i208 %741 to i202
  %743 = zext i1 %739 to i202
  %744 = shl i202 %743, 187
  %745 = and i202 %742, -196159429230833773869868419475239575503198607639501078529
  %.partset143 = or i202 %745, %744
  store i202 %.partset143, i202* %dst_0, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.1:                             ; preds = %dst.addr.2763.exit
  %746 = bitcast i202* %dst_1 to i208*
  %747 = load i208, i208* %746
  %748 = trunc i208 %747 to i202
  %749 = zext i1 %739 to i202
  %750 = shl i202 %749, 187
  %751 = and i202 %748, -196159429230833773869868419475239575503198607639501078529
  %.partset114 = or i202 %751, %750
  store i202 %.partset114, i202* %dst_1, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.2:                             ; preds = %dst.addr.2763.exit
  %752 = bitcast i202* %dst_2 to i208*
  %753 = load i208, i208* %752
  %754 = trunc i208 %753 to i202
  %755 = zext i1 %739 to i202
  %756 = shl i202 %755, 187
  %757 = and i202 %754, -196159429230833773869868419475239575503198607639501078529
  %.partset57 = or i202 %757, %756
  store i202 %.partset57, i202* %dst_2, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.3:                             ; preds = %dst.addr.2763.exit
  %758 = bitcast i202* %dst_3 to i208*
  %759 = load i208, i208* %758
  %760 = trunc i208 %759 to i202
  %761 = zext i1 %739 to i202
  %762 = shl i202 %761, 187
  %763 = and i202 %760, -196159429230833773869868419475239575503198607639501078529
  %.partset28 = or i202 %763, %762
  store i202 %.partset28, i202* %dst_3, align 1
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
  %767 = bitcast i202* %dst_0 to i208*
  %768 = load i208, i208* %767
  %769 = trunc i208 %768 to i202
  %770 = zext i1 %766 to i202
  %771 = shl i202 %770, 188
  %772 = and i202 %769, -392318858461667547739736838950479151006397215279002157057
  %.partset142 = or i202 %772, %771
  store i202 %.partset142, i202* %dst_0, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.1:                             ; preds = %dst.addr.2865.exit
  %773 = bitcast i202* %dst_1 to i208*
  %774 = load i208, i208* %773
  %775 = trunc i208 %774 to i202
  %776 = zext i1 %766 to i202
  %777 = shl i202 %776, 188
  %778 = and i202 %775, -392318858461667547739736838950479151006397215279002157057
  %.partset115 = or i202 %778, %777
  store i202 %.partset115, i202* %dst_1, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.2:                             ; preds = %dst.addr.2865.exit
  %779 = bitcast i202* %dst_2 to i208*
  %780 = load i208, i208* %779
  %781 = trunc i208 %780 to i202
  %782 = zext i1 %766 to i202
  %783 = shl i202 %782, 188
  %784 = and i202 %781, -392318858461667547739736838950479151006397215279002157057
  %.partset56 = or i202 %784, %783
  store i202 %.partset56, i202* %dst_2, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.3:                             ; preds = %dst.addr.2865.exit
  %785 = bitcast i202* %dst_3 to i208*
  %786 = load i208, i208* %785
  %787 = trunc i208 %786 to i202
  %788 = zext i1 %766 to i202
  %789 = shl i202 %788, 188
  %790 = and i202 %787, -392318858461667547739736838950479151006397215279002157057
  %.partset29 = or i202 %790, %789
  store i202 %.partset29, i202* %dst_3, align 1
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
  %794 = bitcast i202* %dst_0 to i208*
  %795 = load i208, i208* %794
  %796 = trunc i208 %795 to i202
  %797 = zext i1 %793 to i202
  %798 = shl i202 %797, 189
  %799 = and i202 %796, -784637716923335095479473677900958302012794430558004314113
  %.partset141 = or i202 %799, %798
  store i202 %.partset141, i202* %dst_0, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.1:                             ; preds = %dst.addr.2967.exit
  %800 = bitcast i202* %dst_1 to i208*
  %801 = load i208, i208* %800
  %802 = trunc i208 %801 to i202
  %803 = zext i1 %793 to i202
  %804 = shl i202 %803, 189
  %805 = and i202 %802, -784637716923335095479473677900958302012794430558004314113
  %.partset116 = or i202 %805, %804
  store i202 %.partset116, i202* %dst_1, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.2:                             ; preds = %dst.addr.2967.exit
  %806 = bitcast i202* %dst_2 to i208*
  %807 = load i208, i208* %806
  %808 = trunc i208 %807 to i202
  %809 = zext i1 %793 to i202
  %810 = shl i202 %809, 189
  %811 = and i202 %808, -784637716923335095479473677900958302012794430558004314113
  %.partset55 = or i202 %811, %810
  store i202 %.partset55, i202* %dst_2, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.3:                             ; preds = %dst.addr.2967.exit
  %812 = bitcast i202* %dst_3 to i208*
  %813 = load i208, i208* %812
  %814 = trunc i208 %813 to i202
  %815 = zext i1 %793 to i202
  %816 = shl i202 %815, 189
  %817 = and i202 %814, -784637716923335095479473677900958302012794430558004314113
  %.partset30 = or i202 %817, %816
  store i202 %.partset30, i202* %dst_3, align 1
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
  %821 = bitcast i202* %dst_0 to i208*
  %822 = load i208, i208* %821
  %823 = trunc i208 %822 to i202
  %824 = zext i1 %820 to i202
  %825 = shl i202 %824, 190
  %826 = and i202 %823, -1569275433846670190958947355801916604025588861116008628225
  %.partset140 = or i202 %826, %825
  store i202 %.partset140, i202* %dst_0, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.1:                             ; preds = %dst.addr.3069.exit
  %827 = bitcast i202* %dst_1 to i208*
  %828 = load i208, i208* %827
  %829 = trunc i208 %828 to i202
  %830 = zext i1 %820 to i202
  %831 = shl i202 %830, 190
  %832 = and i202 %829, -1569275433846670190958947355801916604025588861116008628225
  %.partset117 = or i202 %832, %831
  store i202 %.partset117, i202* %dst_1, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.2:                             ; preds = %dst.addr.3069.exit
  %833 = bitcast i202* %dst_2 to i208*
  %834 = load i208, i208* %833
  %835 = trunc i208 %834 to i202
  %836 = zext i1 %820 to i202
  %837 = shl i202 %836, 190
  %838 = and i202 %835, -1569275433846670190958947355801916604025588861116008628225
  %.partset54 = or i202 %838, %837
  store i202 %.partset54, i202* %dst_2, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.3:                             ; preds = %dst.addr.3069.exit
  %839 = bitcast i202* %dst_3 to i208*
  %840 = load i208, i208* %839
  %841 = trunc i208 %840 to i202
  %842 = zext i1 %820 to i202
  %843 = shl i202 %842, 190
  %844 = and i202 %841, -1569275433846670190958947355801916604025588861116008628225
  %.partset31 = or i202 %844, %843
  store i202 %.partset31, i202* %dst_3, align 1
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
  %848 = bitcast i202* %dst_0 to i208*
  %849 = load i208, i208* %848
  %850 = trunc i208 %849 to i202
  %851 = zext i1 %847 to i202
  %852 = shl i202 %851, 191
  %853 = and i202 %850, -3138550867693340381917894711603833208051177722232017256449
  %.partset139 = or i202 %853, %852
  store i202 %.partset139, i202* %dst_0, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.1:                             ; preds = %dst.addr.3171.exit
  %854 = bitcast i202* %dst_1 to i208*
  %855 = load i208, i208* %854
  %856 = trunc i208 %855 to i202
  %857 = zext i1 %847 to i202
  %858 = shl i202 %857, 191
  %859 = and i202 %856, -3138550867693340381917894711603833208051177722232017256449
  %.partset118 = or i202 %859, %858
  store i202 %.partset118, i202* %dst_1, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.2:                             ; preds = %dst.addr.3171.exit
  %860 = bitcast i202* %dst_2 to i208*
  %861 = load i208, i208* %860
  %862 = trunc i208 %861 to i202
  %863 = zext i1 %847 to i202
  %864 = shl i202 %863, 191
  %865 = and i202 %862, -3138550867693340381917894711603833208051177722232017256449
  %.partset53 = or i202 %865, %864
  store i202 %.partset53, i202* %dst_2, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.3:                             ; preds = %dst.addr.3171.exit
  %866 = bitcast i202* %dst_3 to i208*
  %867 = load i208, i208* %866
  %868 = trunc i208 %867 to i202
  %869 = zext i1 %847 to i202
  %870 = shl i202 %869, 191
  %871 = and i202 %868, -3138550867693340381917894711603833208051177722232017256449
  %.partset32 = or i202 %871, %870
  store i202 %.partset32, i202* %dst_3, align 1
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
  %875 = bitcast i202* %dst_0 to i208*
  %876 = load i208, i208* %875
  %877 = trunc i208 %876 to i202
  %878 = zext i1 %874 to i202
  %879 = shl i202 %878, 192
  %880 = and i202 %877, -6277101735386680763835789423207666416102355444464034512897
  %.partset138 = or i202 %880, %879
  store i202 %.partset138, i202* %dst_0, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.1:                             ; preds = %dst.addr.3273.exit
  %881 = bitcast i202* %dst_1 to i208*
  %882 = load i208, i208* %881
  %883 = trunc i208 %882 to i202
  %884 = zext i1 %874 to i202
  %885 = shl i202 %884, 192
  %886 = and i202 %883, -6277101735386680763835789423207666416102355444464034512897
  %.partset119 = or i202 %886, %885
  store i202 %.partset119, i202* %dst_1, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.2:                             ; preds = %dst.addr.3273.exit
  %887 = bitcast i202* %dst_2 to i208*
  %888 = load i208, i208* %887
  %889 = trunc i208 %888 to i202
  %890 = zext i1 %874 to i202
  %891 = shl i202 %890, 192
  %892 = and i202 %889, -6277101735386680763835789423207666416102355444464034512897
  %.partset52 = or i202 %892, %891
  store i202 %.partset52, i202* %dst_2, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.3:                             ; preds = %dst.addr.3273.exit
  %893 = bitcast i202* %dst_3 to i208*
  %894 = load i208, i208* %893
  %895 = trunc i208 %894 to i202
  %896 = zext i1 %874 to i202
  %897 = shl i202 %896, 192
  %898 = and i202 %895, -6277101735386680763835789423207666416102355444464034512897
  %.partset33 = or i202 %898, %897
  store i202 %.partset33, i202* %dst_3, align 1
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
  %902 = bitcast i202* %dst_0 to i208*
  %903 = load i208, i208* %902
  %904 = trunc i208 %903 to i202
  %905 = zext i1 %901 to i202
  %906 = shl i202 %905, 193
  %907 = and i202 %904, -12554203470773361527671578846415332832204710888928069025793
  %.partset137 = or i202 %907, %906
  store i202 %.partset137, i202* %dst_0, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.1:                             ; preds = %dst.addr.3375.exit
  %908 = bitcast i202* %dst_1 to i208*
  %909 = load i208, i208* %908
  %910 = trunc i208 %909 to i202
  %911 = zext i1 %901 to i202
  %912 = shl i202 %911, 193
  %913 = and i202 %910, -12554203470773361527671578846415332832204710888928069025793
  %.partset120 = or i202 %913, %912
  store i202 %.partset120, i202* %dst_1, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.2:                             ; preds = %dst.addr.3375.exit
  %914 = bitcast i202* %dst_2 to i208*
  %915 = load i208, i208* %914
  %916 = trunc i208 %915 to i202
  %917 = zext i1 %901 to i202
  %918 = shl i202 %917, 193
  %919 = and i202 %916, -12554203470773361527671578846415332832204710888928069025793
  %.partset51 = or i202 %919, %918
  store i202 %.partset51, i202* %dst_2, align 1
  br label %dst.addr.3477.exit

dst.addr.3477.case.3:                             ; preds = %dst.addr.3375.exit
  %920 = bitcast i202* %dst_3 to i208*
  %921 = load i208, i208* %920
  %922 = trunc i208 %921 to i202
  %923 = zext i1 %901 to i202
  %924 = shl i202 %923, 193
  %925 = and i202 %922, -12554203470773361527671578846415332832204710888928069025793
  %.partset34 = or i202 %925, %924
  store i202 %.partset34, i202* %dst_3, align 1
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
  %929 = bitcast i202* %dst_0 to i208*
  %930 = load i208, i208* %929
  %931 = trunc i208 %930 to i202
  %932 = zext i1 %928 to i202
  %933 = shl i202 %932, 194
  %934 = and i202 %931, -25108406941546723055343157692830665664409421777856138051585
  %.partset136 = or i202 %934, %933
  store i202 %.partset136, i202* %dst_0, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.1:                             ; preds = %dst.addr.3477.exit
  %935 = bitcast i202* %dst_1 to i208*
  %936 = load i208, i208* %935
  %937 = trunc i208 %936 to i202
  %938 = zext i1 %928 to i202
  %939 = shl i202 %938, 194
  %940 = and i202 %937, -25108406941546723055343157692830665664409421777856138051585
  %.partset121 = or i202 %940, %939
  store i202 %.partset121, i202* %dst_1, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.2:                             ; preds = %dst.addr.3477.exit
  %941 = bitcast i202* %dst_2 to i208*
  %942 = load i208, i208* %941
  %943 = trunc i208 %942 to i202
  %944 = zext i1 %928 to i202
  %945 = shl i202 %944, 194
  %946 = and i202 %943, -25108406941546723055343157692830665664409421777856138051585
  %.partset50 = or i202 %946, %945
  store i202 %.partset50, i202* %dst_2, align 1
  br label %dst.addr.3579.exit

dst.addr.3579.case.3:                             ; preds = %dst.addr.3477.exit
  %947 = bitcast i202* %dst_3 to i208*
  %948 = load i208, i208* %947
  %949 = trunc i208 %948 to i202
  %950 = zext i1 %928 to i202
  %951 = shl i202 %950, 194
  %952 = and i202 %949, -25108406941546723055343157692830665664409421777856138051585
  %.partset35 = or i202 %952, %951
  store i202 %.partset35, i202* %dst_3, align 1
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
  %956 = bitcast i202* %dst_0 to i208*
  %957 = load i208, i208* %956
  %958 = trunc i208 %957 to i202
  %959 = zext i1 %955 to i202
  %960 = shl i202 %959, 195
  %961 = and i202 %958, -50216813883093446110686315385661331328818843555712276103169
  %.partset135 = or i202 %961, %960
  store i202 %.partset135, i202* %dst_0, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.1:                             ; preds = %dst.addr.3579.exit
  %962 = bitcast i202* %dst_1 to i208*
  %963 = load i208, i208* %962
  %964 = trunc i208 %963 to i202
  %965 = zext i1 %955 to i202
  %966 = shl i202 %965, 195
  %967 = and i202 %964, -50216813883093446110686315385661331328818843555712276103169
  %.partset122 = or i202 %967, %966
  store i202 %.partset122, i202* %dst_1, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.2:                             ; preds = %dst.addr.3579.exit
  %968 = bitcast i202* %dst_2 to i208*
  %969 = load i208, i208* %968
  %970 = trunc i208 %969 to i202
  %971 = zext i1 %955 to i202
  %972 = shl i202 %971, 195
  %973 = and i202 %970, -50216813883093446110686315385661331328818843555712276103169
  %.partset49 = or i202 %973, %972
  store i202 %.partset49, i202* %dst_2, align 1
  br label %dst.addr.3681.exit

dst.addr.3681.case.3:                             ; preds = %dst.addr.3579.exit
  %974 = bitcast i202* %dst_3 to i208*
  %975 = load i208, i208* %974
  %976 = trunc i208 %975 to i202
  %977 = zext i1 %955 to i202
  %978 = shl i202 %977, 195
  %979 = and i202 %976, -50216813883093446110686315385661331328818843555712276103169
  %.partset36 = or i202 %979, %978
  store i202 %.partset36, i202* %dst_3, align 1
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
  %983 = bitcast i202* %dst_0 to i208*
  %984 = load i208, i208* %983
  %985 = trunc i208 %984 to i202
  %986 = zext i1 %982 to i202
  %987 = shl i202 %986, 196
  %988 = and i202 %985, -100433627766186892221372630771322662657637687111424552206337
  %.partset134 = or i202 %988, %987
  store i202 %.partset134, i202* %dst_0, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.1:                             ; preds = %dst.addr.3681.exit
  %989 = bitcast i202* %dst_1 to i208*
  %990 = load i208, i208* %989
  %991 = trunc i208 %990 to i202
  %992 = zext i1 %982 to i202
  %993 = shl i202 %992, 196
  %994 = and i202 %991, -100433627766186892221372630771322662657637687111424552206337
  %.partset123 = or i202 %994, %993
  store i202 %.partset123, i202* %dst_1, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.2:                             ; preds = %dst.addr.3681.exit
  %995 = bitcast i202* %dst_2 to i208*
  %996 = load i208, i208* %995
  %997 = trunc i208 %996 to i202
  %998 = zext i1 %982 to i202
  %999 = shl i202 %998, 196
  %1000 = and i202 %997, -100433627766186892221372630771322662657637687111424552206337
  %.partset48 = or i202 %1000, %999
  store i202 %.partset48, i202* %dst_2, align 1
  br label %dst.addr.3783.exit

dst.addr.3783.case.3:                             ; preds = %dst.addr.3681.exit
  %1001 = bitcast i202* %dst_3 to i208*
  %1002 = load i208, i208* %1001
  %1003 = trunc i208 %1002 to i202
  %1004 = zext i1 %982 to i202
  %1005 = shl i202 %1004, 196
  %1006 = and i202 %1003, -100433627766186892221372630771322662657637687111424552206337
  %.partset37 = or i202 %1006, %1005
  store i202 %.partset37, i202* %dst_3, align 1
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
  %1010 = bitcast i202* %dst_0 to i208*
  %1011 = load i208, i208* %1010
  %1012 = trunc i208 %1011 to i202
  %1013 = zext i1 %1009 to i202
  %1014 = shl i202 %1013, 197
  %1015 = and i202 %1012, -200867255532373784442745261542645325315275374222849104412673
  %.partset133 = or i202 %1015, %1014
  store i202 %.partset133, i202* %dst_0, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.1:                             ; preds = %dst.addr.3783.exit
  %1016 = bitcast i202* %dst_1 to i208*
  %1017 = load i208, i208* %1016
  %1018 = trunc i208 %1017 to i202
  %1019 = zext i1 %1009 to i202
  %1020 = shl i202 %1019, 197
  %1021 = and i202 %1018, -200867255532373784442745261542645325315275374222849104412673
  %.partset124 = or i202 %1021, %1020
  store i202 %.partset124, i202* %dst_1, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.2:                             ; preds = %dst.addr.3783.exit
  %1022 = bitcast i202* %dst_2 to i208*
  %1023 = load i208, i208* %1022
  %1024 = trunc i208 %1023 to i202
  %1025 = zext i1 %1009 to i202
  %1026 = shl i202 %1025, 197
  %1027 = and i202 %1024, -200867255532373784442745261542645325315275374222849104412673
  %.partset47 = or i202 %1027, %1026
  store i202 %.partset47, i202* %dst_2, align 1
  br label %dst.addr.3885.exit

dst.addr.3885.case.3:                             ; preds = %dst.addr.3783.exit
  %1028 = bitcast i202* %dst_3 to i208*
  %1029 = load i208, i208* %1028
  %1030 = trunc i208 %1029 to i202
  %1031 = zext i1 %1009 to i202
  %1032 = shl i202 %1031, 197
  %1033 = and i202 %1030, -200867255532373784442745261542645325315275374222849104412673
  %.partset38 = or i202 %1033, %1032
  store i202 %.partset38, i202* %dst_3, align 1
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
  %1037 = bitcast i202* %dst_0 to i208*
  %1038 = load i208, i208* %1037
  %1039 = trunc i208 %1038 to i202
  %1040 = zext i1 %1036 to i202
  %1041 = shl i202 %1040, 198
  %1042 = and i202 %1039, -401734511064747568885490523085290650630550748445698208825345
  %.partset132 = or i202 %1042, %1041
  store i202 %.partset132, i202* %dst_0, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.1:                             ; preds = %dst.addr.3885.exit
  %1043 = bitcast i202* %dst_1 to i208*
  %1044 = load i208, i208* %1043
  %1045 = trunc i208 %1044 to i202
  %1046 = zext i1 %1036 to i202
  %1047 = shl i202 %1046, 198
  %1048 = and i202 %1045, -401734511064747568885490523085290650630550748445698208825345
  %.partset125 = or i202 %1048, %1047
  store i202 %.partset125, i202* %dst_1, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.2:                             ; preds = %dst.addr.3885.exit
  %1049 = bitcast i202* %dst_2 to i208*
  %1050 = load i208, i208* %1049
  %1051 = trunc i208 %1050 to i202
  %1052 = zext i1 %1036 to i202
  %1053 = shl i202 %1052, 198
  %1054 = and i202 %1051, -401734511064747568885490523085290650630550748445698208825345
  %.partset46 = or i202 %1054, %1053
  store i202 %.partset46, i202* %dst_2, align 1
  br label %dst.addr.3987.exit

dst.addr.3987.case.3:                             ; preds = %dst.addr.3885.exit
  %1055 = bitcast i202* %dst_3 to i208*
  %1056 = load i208, i208* %1055
  %1057 = trunc i208 %1056 to i202
  %1058 = zext i1 %1036 to i202
  %1059 = shl i202 %1058, 198
  %1060 = and i202 %1057, -401734511064747568885490523085290650630550748445698208825345
  %.partset39 = or i202 %1060, %1059
  store i202 %.partset39, i202* %dst_3, align 1
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
  %1064 = bitcast i202* %dst_0 to i208*
  %1065 = load i208, i208* %1064
  %1066 = trunc i208 %1065 to i202
  %1067 = zext i1 %1063 to i202
  %1068 = shl i202 %1067, 199
  %1069 = and i202 %1066, -803469022129495137770981046170581301261101496891396417650689
  %.partset131 = or i202 %1069, %1068
  store i202 %.partset131, i202* %dst_0, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.1:                             ; preds = %dst.addr.3987.exit
  %1070 = bitcast i202* %dst_1 to i208*
  %1071 = load i208, i208* %1070
  %1072 = trunc i208 %1071 to i202
  %1073 = zext i1 %1063 to i202
  %1074 = shl i202 %1073, 199
  %1075 = and i202 %1072, -803469022129495137770981046170581301261101496891396417650689
  %.partset126 = or i202 %1075, %1074
  store i202 %.partset126, i202* %dst_1, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.2:                             ; preds = %dst.addr.3987.exit
  %1076 = bitcast i202* %dst_2 to i208*
  %1077 = load i208, i208* %1076
  %1078 = trunc i208 %1077 to i202
  %1079 = zext i1 %1063 to i202
  %1080 = shl i202 %1079, 199
  %1081 = and i202 %1078, -803469022129495137770981046170581301261101496891396417650689
  %.partset45 = or i202 %1081, %1080
  store i202 %.partset45, i202* %dst_2, align 1
  br label %dst.addr.4089.exit

dst.addr.4089.case.3:                             ; preds = %dst.addr.3987.exit
  %1082 = bitcast i202* %dst_3 to i208*
  %1083 = load i208, i208* %1082
  %1084 = trunc i208 %1083 to i202
  %1085 = zext i1 %1063 to i202
  %1086 = shl i202 %1085, 199
  %1087 = and i202 %1084, -803469022129495137770981046170581301261101496891396417650689
  %.partset40 = or i202 %1087, %1086
  store i202 %.partset40, i202* %dst_3, align 1
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
  %1091 = bitcast i202* %dst_0 to i208*
  %1092 = load i208, i208* %1091
  %1093 = trunc i208 %1092 to i202
  %1094 = zext i1 %1090 to i202
  %1095 = shl i202 %1094, 200
  %1096 = and i202 %1093, -1606938044258990275541962092341162602522202993782792835301377
  %.partset130 = or i202 %1096, %1095
  store i202 %.partset130, i202* %dst_0, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.1:                             ; preds = %dst.addr.4089.exit
  %1097 = bitcast i202* %dst_1 to i208*
  %1098 = load i208, i208* %1097
  %1099 = trunc i208 %1098 to i202
  %1100 = zext i1 %1090 to i202
  %1101 = shl i202 %1100, 200
  %1102 = and i202 %1099, -1606938044258990275541962092341162602522202993782792835301377
  %.partset127 = or i202 %1102, %1101
  store i202 %.partset127, i202* %dst_1, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.2:                             ; preds = %dst.addr.4089.exit
  %1103 = bitcast i202* %dst_2 to i208*
  %1104 = load i208, i208* %1103
  %1105 = trunc i208 %1104 to i202
  %1106 = zext i1 %1090 to i202
  %1107 = shl i202 %1106, 200
  %1108 = and i202 %1105, -1606938044258990275541962092341162602522202993782792835301377
  %.partset44 = or i202 %1108, %1107
  store i202 %.partset44, i202* %dst_2, align 1
  br label %dst.addr.4191.exit

dst.addr.4191.case.3:                             ; preds = %dst.addr.4089.exit
  %1109 = bitcast i202* %dst_3 to i208*
  %1110 = load i208, i208* %1109
  %1111 = trunc i208 %1110 to i202
  %1112 = zext i1 %1090 to i202
  %1113 = shl i202 %1112, 200
  %1114 = and i202 %1111, -1606938044258990275541962092341162602522202993782792835301377
  %.partset41 = or i202 %1114, %1113
  store i202 %.partset41, i202* %dst_3, align 1
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
  %1118 = bitcast i202* %dst_0 to i208*
  %1119 = load i208, i208* %1118
  %1120 = trunc i208 %1119 to i202
  %1121 = zext i1 %1117 to i202
  %1122 = shl i202 %1121, 201
  %1123 = and i202 %1120, 3213876088517980551083924184682325205044405987565585670602751
  %.partset129 = or i202 %1123, %1122
  store i202 %.partset129, i202* %dst_0, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.1:                             ; preds = %dst.addr.4191.exit
  %1124 = bitcast i202* %dst_1 to i208*
  %1125 = load i208, i208* %1124
  %1126 = trunc i208 %1125 to i202
  %1127 = zext i1 %1117 to i202
  %1128 = shl i202 %1127, 201
  %1129 = and i202 %1126, 3213876088517980551083924184682325205044405987565585670602751
  %.partset128 = or i202 %1129, %1128
  store i202 %.partset128, i202* %dst_1, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.2:                             ; preds = %dst.addr.4191.exit
  %1130 = bitcast i202* %dst_2 to i208*
  %1131 = load i208, i208* %1130
  %1132 = trunc i208 %1131 to i202
  %1133 = zext i1 %1117 to i202
  %1134 = shl i202 %1133, 201
  %1135 = and i202 %1132, 3213876088517980551083924184682325205044405987565585670602751
  %.partset43 = or i202 %1135, %1134
  store i202 %.partset43, i202* %dst_2, align 1
  br label %dst.addr.4293.exit

dst.addr.4293.case.3:                             ; preds = %dst.addr.4191.exit
  %1136 = bitcast i202* %dst_3 to i208*
  %1137 = load i208, i208* %1136
  %1138 = trunc i208 %1137 to i202
  %1139 = zext i1 %1117 to i202
  %1140 = shl i202 %1139, 201
  %1141 = and i202 %1138, 3213876088517980551083924184682325205044405987565585670602751
  %.partset42 = or i202 %1141, %1140
  store i202 %.partset42, i202* %dst_3, align 1
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
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.14.17(i202* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i202* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i202* noalias align 512 "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i202* noalias align 512 "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #1 {
entry:
  %0 = icmp eq i202* %dst_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.15.16(i202* nonnull %dst_0, i202* %dst_1, i202* %dst_2, i202* %dst_3, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in(i1* noalias readonly "orig.arg.no"="0", i1* noalias align 512 "orig.arg.no"="1", [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="2", i202* noalias align 512 "orig.arg.no"="3" "unpacked"="3.0" %_0, i202* noalias align 512 "orig.arg.no"="3" "unpacked"="3.1" %_1, i202* noalias align 512 "orig.arg.no"="3" "unpacked"="3.2" %_2, i202* noalias align 512 "orig.arg.no"="3" "unpacked"="3.3" %_3, i1* noalias readonly "orig.arg.no"="4", i1* noalias align 512 "orig.arg.no"="5", i8* noalias readonly "orig.arg.no"="6", i8* noalias align 512 "orig.arg.no"="7", i1* noalias readonly "orig.arg.no"="8", i1* noalias align 512 "orig.arg.no"="9", i1* noalias readonly "orig.arg.no"="10", i1* noalias align 512 "orig.arg.no"="11", i8* noalias readonly "orig.arg.no"="12", i8* noalias align 512 "orig.arg.no"="13", i32* noalias readonly "orig.arg.no"="14", i32* noalias align 512 "orig.arg.no"="15", i32* noalias readonly "orig.arg.no"="16", i32* noalias align 512 "orig.arg.no"="17", i32* noalias readonly "orig.arg.no"="18", i32* noalias align 512 "orig.arg.no"="19", i32* noalias readonly "orig.arg.no"="20", i32* noalias align 512 "orig.arg.no"="21") #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.14.17(i202* align 512 %_0, i202* align 512 %_1, i202* align 512 %_2, i202* align 512 %_3, [4 x %struct.HeadCtx]* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %4, i1* %3)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %6, i8* %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %8, i1* %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %10, i1* %9)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %12, i8* %11)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %14, i32* %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %16, i32* %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %18, i32* %17)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %20, i32* %19)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.25.26([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i202* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i202* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i202* readonly "orig.arg.no"="1" "unpacked"="1.2" %src_2, i202* readonly "orig.arg.no"="1" "unpacked"="1.3" %src_3, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i202* %src_0, null
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
  %3 = bitcast i202* %src_0 to i208*
  %4 = load i208, i208* %3
  %5 = trunc i208 %4 to i202
  %_0.partselect = trunc i202 %5 to i32
  br label %src.addr.01.exit

src.addr.01.case.1:                               ; preds = %for.loop
  %6 = bitcast i202* %src_1 to i208*
  %7 = load i208, i208* %6
  %8 = trunc i208 %7 to i202
  %_1.partselect = trunc i202 %8 to i32
  br label %src.addr.01.exit

src.addr.01.case.2:                               ; preds = %for.loop
  %9 = bitcast i202* %src_2 to i208*
  %10 = load i208, i208* %9
  %11 = trunc i208 %10 to i202
  %_2.partselect = trunc i202 %11 to i32
  br label %src.addr.01.exit

src.addr.01.case.3:                               ; preds = %for.loop
  %12 = bitcast i202* %src_3 to i208*
  %13 = load i208, i208* %12
  %14 = trunc i208 %13 to i202
  %_3.partselect = trunc i202 %14 to i32
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
  %16 = bitcast i202* %src_0 to i208*
  %17 = load i208, i208* %16
  %18 = trunc i208 %17 to i202
  %19 = lshr i202 %18, 32
  %_01.partselect = trunc i202 %19 to i32
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %20 = bitcast i202* %src_1 to i208*
  %21 = load i208, i208* %20
  %22 = trunc i208 %21 to i202
  %23 = lshr i202 %22, 32
  %_12.partselect = trunc i202 %23 to i32
  br label %src.addr.110.exit

src.addr.110.case.2:                              ; preds = %src.addr.01.exit
  %24 = bitcast i202* %src_2 to i208*
  %25 = load i208, i208* %24
  %26 = trunc i208 %25 to i202
  %27 = lshr i202 %26, 32
  %_23.partselect = trunc i202 %27 to i32
  br label %src.addr.110.exit

src.addr.110.case.3:                              ; preds = %src.addr.01.exit
  %28 = bitcast i202* %src_3 to i208*
  %29 = load i208, i208* %28
  %30 = trunc i208 %29 to i202
  %31 = lshr i202 %30, 32
  %_34.partselect = trunc i202 %31 to i32
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
  %33 = bitcast i202* %src_0 to i208*
  %34 = load i208, i208* %33
  %35 = trunc i208 %34 to i202
  %36 = lshr i202 %35, 64
  %_05.partselect = trunc i202 %36 to i8
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %37 = bitcast i202* %src_1 to i208*
  %38 = load i208, i208* %37
  %39 = trunc i208 %38 to i202
  %40 = lshr i202 %39, 64
  %_16.partselect = trunc i202 %40 to i8
  br label %src.addr.212.exit

src.addr.212.case.2:                              ; preds = %src.addr.110.exit
  %41 = bitcast i202* %src_2 to i208*
  %42 = load i208, i208* %41
  %43 = trunc i208 %42 to i202
  %44 = lshr i202 %43, 64
  %_27.partselect = trunc i202 %44 to i8
  br label %src.addr.212.exit

src.addr.212.case.3:                              ; preds = %src.addr.110.exit
  %45 = bitcast i202* %src_3 to i208*
  %46 = load i208, i208* %45
  %47 = trunc i208 %46 to i202
  %48 = lshr i202 %47, 64
  %_38.partselect = trunc i202 %48 to i8
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
  %50 = bitcast i202* %src_0 to i208*
  %51 = load i208, i208* %50
  %52 = trunc i208 %51 to i202
  %53 = lshr i202 %52, 72
  %_09.partselect = trunc i202 %53 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %54 = bitcast i202* %src_1 to i208*
  %55 = load i208, i208* %54
  %56 = trunc i208 %55 to i202
  %57 = lshr i202 %56, 72
  %_110.partselect = trunc i202 %57 to i1
  br label %src.addr.314.exit

src.addr.314.case.2:                              ; preds = %src.addr.212.exit
  %58 = bitcast i202* %src_2 to i208*
  %59 = load i208, i208* %58
  %60 = trunc i208 %59 to i202
  %61 = lshr i202 %60, 72
  %_211.partselect = trunc i202 %61 to i1
  br label %src.addr.314.exit

src.addr.314.case.3:                              ; preds = %src.addr.212.exit
  %62 = bitcast i202* %src_3 to i208*
  %63 = load i208, i208* %62
  %64 = trunc i208 %63 to i202
  %65 = lshr i202 %64, 72
  %_312.partselect = trunc i202 %65 to i1
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
  %67 = bitcast i202* %src_0 to i208*
  %68 = load i208, i208* %67
  %69 = trunc i208 %68 to i202
  %70 = lshr i202 %69, 73
  %_013.partselect = trunc i202 %70 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %71 = bitcast i202* %src_1 to i208*
  %72 = load i208, i208* %71
  %73 = trunc i208 %72 to i202
  %74 = lshr i202 %73, 73
  %_114.partselect = trunc i202 %74 to i1
  br label %src.addr.416.exit

src.addr.416.case.2:                              ; preds = %src.addr.314.exit
  %75 = bitcast i202* %src_2 to i208*
  %76 = load i208, i208* %75
  %77 = trunc i208 %76 to i202
  %78 = lshr i202 %77, 73
  %_215.partselect = trunc i202 %78 to i1
  br label %src.addr.416.exit

src.addr.416.case.3:                              ; preds = %src.addr.314.exit
  %79 = bitcast i202* %src_3 to i208*
  %80 = load i208, i208* %79
  %81 = trunc i208 %80 to i202
  %82 = lshr i202 %81, 73
  %_316.partselect = trunc i202 %82 to i1
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
  %84 = bitcast i202* %src_0 to i208*
  %85 = load i208, i208* %84
  %86 = trunc i208 %85 to i202
  %87 = lshr i202 %86, 74
  %_017.partselect = trunc i202 %87 to i1
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %88 = bitcast i202* %src_1 to i208*
  %89 = load i208, i208* %88
  %90 = trunc i208 %89 to i202
  %91 = lshr i202 %90, 74
  %_118.partselect = trunc i202 %91 to i1
  br label %src.addr.518.exit

src.addr.518.case.2:                              ; preds = %src.addr.416.exit
  %92 = bitcast i202* %src_2 to i208*
  %93 = load i208, i208* %92
  %94 = trunc i208 %93 to i202
  %95 = lshr i202 %94, 74
  %_219.partselect = trunc i202 %95 to i1
  br label %src.addr.518.exit

src.addr.518.case.3:                              ; preds = %src.addr.416.exit
  %96 = bitcast i202* %src_3 to i208*
  %97 = load i208, i208* %96
  %98 = trunc i208 %97 to i202
  %99 = lshr i202 %98, 74
  %_320.partselect = trunc i202 %99 to i1
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
  %101 = bitcast i202* %src_0 to i208*
  %102 = load i208, i208* %101
  %103 = trunc i208 %102 to i202
  %104 = lshr i202 %103, 75
  %_021.partselect = trunc i202 %104 to i8
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %105 = bitcast i202* %src_1 to i208*
  %106 = load i208, i208* %105
  %107 = trunc i208 %106 to i202
  %108 = lshr i202 %107, 75
  %_122.partselect = trunc i202 %108 to i8
  br label %src.addr.620.exit

src.addr.620.case.2:                              ; preds = %src.addr.518.exit
  %109 = bitcast i202* %src_2 to i208*
  %110 = load i208, i208* %109
  %111 = trunc i208 %110 to i202
  %112 = lshr i202 %111, 75
  %_223.partselect = trunc i202 %112 to i8
  br label %src.addr.620.exit

src.addr.620.case.3:                              ; preds = %src.addr.518.exit
  %113 = bitcast i202* %src_3 to i208*
  %114 = load i208, i208* %113
  %115 = trunc i208 %114 to i202
  %116 = lshr i202 %115, 75
  %_324.partselect = trunc i202 %116 to i8
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.3, %src.addr.620.case.2, %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %117 = phi i8 [ %_021.partselect, %src.addr.620.case.0 ], [ %_122.partselect, %src.addr.620.case.1 ], [ %_223.partselect, %src.addr.620.case.2 ], [ %_324.partselect, %src.addr.620.case.3 ], [ undef, %src.addr.518.exit ]
  store i8 %117, i8* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 7
  switch i64 %for.loop.idx95, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
    i64 2, label %src.addr.722.case.2
    i64 3, label %src.addr.722.case.3
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %118 = bitcast i202* %src_0 to i208*
  %119 = load i208, i208* %118
  %120 = trunc i208 %119 to i202
  %121 = lshr i202 %120, 83
  %_025.partselect = trunc i202 %121 to i8
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %122 = bitcast i202* %src_1 to i208*
  %123 = load i208, i208* %122
  %124 = trunc i208 %123 to i202
  %125 = lshr i202 %124, 83
  %_126.partselect = trunc i202 %125 to i8
  br label %src.addr.722.exit

src.addr.722.case.2:                              ; preds = %src.addr.620.exit
  %126 = bitcast i202* %src_2 to i208*
  %127 = load i208, i208* %126
  %128 = trunc i208 %127 to i202
  %129 = lshr i202 %128, 83
  %_227.partselect = trunc i202 %129 to i8
  br label %src.addr.722.exit

src.addr.722.case.3:                              ; preds = %src.addr.620.exit
  %130 = bitcast i202* %src_3 to i208*
  %131 = load i208, i208* %130
  %132 = trunc i208 %131 to i202
  %133 = lshr i202 %132, 83
  %_328.partselect = trunc i202 %133 to i8
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.3, %src.addr.722.case.2, %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %134 = phi i8 [ %_025.partselect, %src.addr.722.case.0 ], [ %_126.partselect, %src.addr.722.case.1 ], [ %_227.partselect, %src.addr.722.case.2 ], [ %_328.partselect, %src.addr.722.case.3 ], [ undef, %src.addr.620.exit ]
  store i8 %134, i8* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx95, i32 8
  switch i64 %for.loop.idx95, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
    i64 2, label %src.addr.824.case.2
    i64 3, label %src.addr.824.case.3
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %135 = bitcast i202* %src_0 to i208*
  %136 = load i208, i208* %135
  %137 = trunc i208 %136 to i202
  %138 = lshr i202 %137, 91
  %_029.partselect = trunc i202 %138 to i8
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %139 = bitcast i202* %src_1 to i208*
  %140 = load i208, i208* %139
  %141 = trunc i208 %140 to i202
  %142 = lshr i202 %141, 91
  %_130.partselect = trunc i202 %142 to i8
  br label %src.addr.824.exit

src.addr.824.case.2:                              ; preds = %src.addr.722.exit
  %143 = bitcast i202* %src_2 to i208*
  %144 = load i208, i208* %143
  %145 = trunc i208 %144 to i202
  %146 = lshr i202 %145, 91
  %_231.partselect = trunc i202 %146 to i8
  br label %src.addr.824.exit

src.addr.824.case.3:                              ; preds = %src.addr.722.exit
  %147 = bitcast i202* %src_3 to i208*
  %148 = load i208, i208* %147
  %149 = trunc i208 %148 to i202
  %150 = lshr i202 %149, 91
  %_332.partselect = trunc i202 %150 to i8
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
  %152 = bitcast i202* %src_0 to i208*
  %153 = load i208, i208* %152
  %154 = trunc i208 %153 to i202
  %155 = lshr i202 %154, 99
  %_033.partselect = trunc i202 %155 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %156 = bitcast i202* %src_1 to i208*
  %157 = load i208, i208* %156
  %158 = trunc i208 %157 to i202
  %159 = lshr i202 %158, 99
  %_134.partselect = trunc i202 %159 to i1
  br label %src.addr.926.exit

src.addr.926.case.2:                              ; preds = %src.addr.824.exit
  %160 = bitcast i202* %src_2 to i208*
  %161 = load i208, i208* %160
  %162 = trunc i208 %161 to i202
  %163 = lshr i202 %162, 99
  %_235.partselect = trunc i202 %163 to i1
  br label %src.addr.926.exit

src.addr.926.case.3:                              ; preds = %src.addr.824.exit
  %164 = bitcast i202* %src_3 to i208*
  %165 = load i208, i208* %164
  %166 = trunc i208 %165 to i202
  %167 = lshr i202 %166, 99
  %_336.partselect = trunc i202 %167 to i1
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
  %169 = bitcast i202* %src_0 to i208*
  %170 = load i208, i208* %169
  %171 = trunc i208 %170 to i202
  %172 = lshr i202 %171, 100
  %_037.partselect = trunc i202 %172 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %173 = bitcast i202* %src_1 to i208*
  %174 = load i208, i208* %173
  %175 = trunc i208 %174 to i202
  %176 = lshr i202 %175, 100
  %_138.partselect = trunc i202 %176 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.2:                             ; preds = %src.addr.926.exit
  %177 = bitcast i202* %src_2 to i208*
  %178 = load i208, i208* %177
  %179 = trunc i208 %178 to i202
  %180 = lshr i202 %179, 100
  %_239.partselect = trunc i202 %180 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.3:                             ; preds = %src.addr.926.exit
  %181 = bitcast i202* %src_3 to i208*
  %182 = load i208, i208* %181
  %183 = trunc i208 %182 to i202
  %184 = lshr i202 %183, 100
  %_340.partselect = trunc i202 %184 to i1
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
  %186 = bitcast i202* %src_0 to i208*
  %187 = load i208, i208* %186
  %188 = trunc i208 %187 to i202
  %189 = lshr i202 %188, 101
  %_041.partselect = trunc i202 %189 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %190 = bitcast i202* %src_1 to i208*
  %191 = load i208, i208* %190
  %192 = trunc i208 %191 to i202
  %193 = lshr i202 %192, 101
  %_142.partselect = trunc i202 %193 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.2:                             ; preds = %src.addr.1028.exit
  %194 = bitcast i202* %src_2 to i208*
  %195 = load i208, i208* %194
  %196 = trunc i208 %195 to i202
  %197 = lshr i202 %196, 101
  %_243.partselect = trunc i202 %197 to i8
  br label %src.addr.1130.exit

src.addr.1130.case.3:                             ; preds = %src.addr.1028.exit
  %198 = bitcast i202* %src_3 to i208*
  %199 = load i208, i208* %198
  %200 = trunc i208 %199 to i202
  %201 = lshr i202 %200, 101
  %_344.partselect = trunc i202 %201 to i8
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
  %203 = bitcast i202* %src_0 to i208*
  %204 = load i208, i208* %203
  %205 = trunc i208 %204 to i202
  %206 = lshr i202 %205, 109
  %_045.partselect = trunc i202 %206 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %207 = bitcast i202* %src_1 to i208*
  %208 = load i208, i208* %207
  %209 = trunc i208 %208 to i202
  %210 = lshr i202 %209, 109
  %_146.partselect = trunc i202 %210 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.2:                             ; preds = %src.addr.1130.exit
  %211 = bitcast i202* %src_2 to i208*
  %212 = load i208, i208* %211
  %213 = trunc i208 %212 to i202
  %214 = lshr i202 %213, 109
  %_247.partselect = trunc i202 %214 to i32
  br label %src.addr.1232.exit

src.addr.1232.case.3:                             ; preds = %src.addr.1130.exit
  %215 = bitcast i202* %src_3 to i208*
  %216 = load i208, i208* %215
  %217 = trunc i208 %216 to i202
  %218 = lshr i202 %217, 109
  %_348.partselect = trunc i202 %218 to i32
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
  %220 = bitcast i202* %src_0 to i208*
  %221 = load i208, i208* %220
  %222 = trunc i208 %221 to i202
  %223 = lshr i202 %222, 141
  %_049.partselect = trunc i202 %223 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %224 = bitcast i202* %src_1 to i208*
  %225 = load i208, i208* %224
  %226 = trunc i208 %225 to i202
  %227 = lshr i202 %226, 141
  %_150.partselect = trunc i202 %227 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.2:                             ; preds = %src.addr.1232.exit
  %228 = bitcast i202* %src_2 to i208*
  %229 = load i208, i208* %228
  %230 = trunc i208 %229 to i202
  %231 = lshr i202 %230, 141
  %_251.partselect = trunc i202 %231 to i32
  br label %src.addr.1334.exit

src.addr.1334.case.3:                             ; preds = %src.addr.1232.exit
  %232 = bitcast i202* %src_3 to i208*
  %233 = load i208, i208* %232
  %234 = trunc i208 %233 to i202
  %235 = lshr i202 %234, 141
  %_352.partselect = trunc i202 %235 to i32
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
  %237 = bitcast i202* %src_0 to i208*
  %238 = load i208, i208* %237
  %239 = trunc i208 %238 to i202
  %240 = lshr i202 %239, 173
  %_053.partselect = trunc i202 %240 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %241 = bitcast i202* %src_1 to i208*
  %242 = load i208, i208* %241
  %243 = trunc i208 %242 to i202
  %244 = lshr i202 %243, 173
  %_154.partselect = trunc i202 %244 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.2:                             ; preds = %src.addr.1334.exit
  %245 = bitcast i202* %src_2 to i208*
  %246 = load i208, i208* %245
  %247 = trunc i208 %246 to i202
  %248 = lshr i202 %247, 173
  %_255.partselect = trunc i202 %248 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.3:                             ; preds = %src.addr.1334.exit
  %249 = bitcast i202* %src_3 to i208*
  %250 = load i208, i208* %249
  %251 = trunc i208 %250 to i202
  %252 = lshr i202 %251, 173
  %_356.partselect = trunc i202 %252 to i1
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
  %254 = bitcast i202* %src_0 to i208*
  %255 = load i208, i208* %254
  %256 = trunc i208 %255 to i202
  %257 = lshr i202 %256, 174
  %_057.partselect = trunc i202 %257 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %258 = bitcast i202* %src_1 to i208*
  %259 = load i208, i208* %258
  %260 = trunc i208 %259 to i202
  %261 = lshr i202 %260, 174
  %_158.partselect = trunc i202 %261 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.2:                             ; preds = %src.addr.1436.exit
  %262 = bitcast i202* %src_2 to i208*
  %263 = load i208, i208* %262
  %264 = trunc i208 %263 to i202
  %265 = lshr i202 %264, 174
  %_259.partselect = trunc i202 %265 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.3:                             ; preds = %src.addr.1436.exit
  %266 = bitcast i202* %src_3 to i208*
  %267 = load i208, i208* %266
  %268 = trunc i208 %267 to i202
  %269 = lshr i202 %268, 174
  %_360.partselect = trunc i202 %269 to i1
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
  %271 = bitcast i202* %src_0 to i208*
  %272 = load i208, i208* %271
  %273 = trunc i208 %272 to i202
  %274 = lshr i202 %273, 175
  %_061.partselect = trunc i202 %274 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %275 = bitcast i202* %src_1 to i208*
  %276 = load i208, i208* %275
  %277 = trunc i208 %276 to i202
  %278 = lshr i202 %277, 175
  %_162.partselect = trunc i202 %278 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.2:                             ; preds = %src.addr.1538.exit
  %279 = bitcast i202* %src_2 to i208*
  %280 = load i208, i208* %279
  %281 = trunc i208 %280 to i202
  %282 = lshr i202 %281, 175
  %_263.partselect = trunc i202 %282 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.3:                             ; preds = %src.addr.1538.exit
  %283 = bitcast i202* %src_3 to i208*
  %284 = load i208, i208* %283
  %285 = trunc i208 %284 to i202
  %286 = lshr i202 %285, 175
  %_364.partselect = trunc i202 %286 to i1
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
  %288 = bitcast i202* %src_0 to i208*
  %289 = load i208, i208* %288
  %290 = trunc i208 %289 to i202
  %291 = lshr i202 %290, 176
  %_065.partselect = trunc i202 %291 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %292 = bitcast i202* %src_1 to i208*
  %293 = load i208, i208* %292
  %294 = trunc i208 %293 to i202
  %295 = lshr i202 %294, 176
  %_166.partselect = trunc i202 %295 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.2:                             ; preds = %src.addr.1640.exit
  %296 = bitcast i202* %src_2 to i208*
  %297 = load i208, i208* %296
  %298 = trunc i208 %297 to i202
  %299 = lshr i202 %298, 176
  %_267.partselect = trunc i202 %299 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.3:                             ; preds = %src.addr.1640.exit
  %300 = bitcast i202* %src_3 to i208*
  %301 = load i208, i208* %300
  %302 = trunc i208 %301 to i202
  %303 = lshr i202 %302, 176
  %_368.partselect = trunc i202 %303 to i1
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
  %305 = bitcast i202* %src_0 to i208*
  %306 = load i208, i208* %305
  %307 = trunc i208 %306 to i202
  %308 = lshr i202 %307, 177
  %_069.partselect = trunc i202 %308 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %309 = bitcast i202* %src_1 to i208*
  %310 = load i208, i208* %309
  %311 = trunc i208 %310 to i202
  %312 = lshr i202 %311, 177
  %_170.partselect = trunc i202 %312 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.2:                             ; preds = %src.addr.1742.exit
  %313 = bitcast i202* %src_2 to i208*
  %314 = load i208, i208* %313
  %315 = trunc i208 %314 to i202
  %316 = lshr i202 %315, 177
  %_271.partselect = trunc i202 %316 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.3:                             ; preds = %src.addr.1742.exit
  %317 = bitcast i202* %src_3 to i208*
  %318 = load i208, i208* %317
  %319 = trunc i208 %318 to i202
  %320 = lshr i202 %319, 177
  %_372.partselect = trunc i202 %320 to i1
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
  %322 = bitcast i202* %src_0 to i208*
  %323 = load i208, i208* %322
  %324 = trunc i208 %323 to i202
  %325 = lshr i202 %324, 178
  %_073.partselect = trunc i202 %325 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %326 = bitcast i202* %src_1 to i208*
  %327 = load i208, i208* %326
  %328 = trunc i208 %327 to i202
  %329 = lshr i202 %328, 178
  %_174.partselect = trunc i202 %329 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.2:                             ; preds = %src.addr.1844.exit
  %330 = bitcast i202* %src_2 to i208*
  %331 = load i208, i208* %330
  %332 = trunc i208 %331 to i202
  %333 = lshr i202 %332, 178
  %_275.partselect = trunc i202 %333 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.3:                             ; preds = %src.addr.1844.exit
  %334 = bitcast i202* %src_3 to i208*
  %335 = load i208, i208* %334
  %336 = trunc i208 %335 to i202
  %337 = lshr i202 %336, 178
  %_376.partselect = trunc i202 %337 to i1
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
  %339 = bitcast i202* %src_0 to i208*
  %340 = load i208, i208* %339
  %341 = trunc i208 %340 to i202
  %342 = lshr i202 %341, 179
  %_077.partselect = trunc i202 %342 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %343 = bitcast i202* %src_1 to i208*
  %344 = load i208, i208* %343
  %345 = trunc i208 %344 to i202
  %346 = lshr i202 %345, 179
  %_178.partselect = trunc i202 %346 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.2:                             ; preds = %src.addr.1946.exit
  %347 = bitcast i202* %src_2 to i208*
  %348 = load i208, i208* %347
  %349 = trunc i208 %348 to i202
  %350 = lshr i202 %349, 179
  %_279.partselect = trunc i202 %350 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.3:                             ; preds = %src.addr.1946.exit
  %351 = bitcast i202* %src_3 to i208*
  %352 = load i208, i208* %351
  %353 = trunc i208 %352 to i202
  %354 = lshr i202 %353, 179
  %_380.partselect = trunc i202 %354 to i1
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
  %356 = bitcast i202* %src_0 to i208*
  %357 = load i208, i208* %356
  %358 = trunc i208 %357 to i202
  %359 = lshr i202 %358, 180
  %_081.partselect = trunc i202 %359 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.1:                             ; preds = %src.addr.2048.exit
  %360 = bitcast i202* %src_1 to i208*
  %361 = load i208, i208* %360
  %362 = trunc i208 %361 to i202
  %363 = lshr i202 %362, 180
  %_182.partselect = trunc i202 %363 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.2:                             ; preds = %src.addr.2048.exit
  %364 = bitcast i202* %src_2 to i208*
  %365 = load i208, i208* %364
  %366 = trunc i208 %365 to i202
  %367 = lshr i202 %366, 180
  %_283.partselect = trunc i202 %367 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.3:                             ; preds = %src.addr.2048.exit
  %368 = bitcast i202* %src_3 to i208*
  %369 = load i208, i208* %368
  %370 = trunc i208 %369 to i202
  %371 = lshr i202 %370, 180
  %_384.partselect = trunc i202 %371 to i1
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
  %373 = bitcast i202* %src_0 to i208*
  %374 = load i208, i208* %373
  %375 = trunc i208 %374 to i202
  %376 = lshr i202 %375, 181
  %_085.partselect = trunc i202 %376 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.1:                             ; preds = %src.addr.2150.exit
  %377 = bitcast i202* %src_1 to i208*
  %378 = load i208, i208* %377
  %379 = trunc i208 %378 to i202
  %380 = lshr i202 %379, 181
  %_186.partselect = trunc i202 %380 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.2:                             ; preds = %src.addr.2150.exit
  %381 = bitcast i202* %src_2 to i208*
  %382 = load i208, i208* %381
  %383 = trunc i208 %382 to i202
  %384 = lshr i202 %383, 181
  %_287.partselect = trunc i202 %384 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.3:                             ; preds = %src.addr.2150.exit
  %385 = bitcast i202* %src_3 to i208*
  %386 = load i208, i208* %385
  %387 = trunc i208 %386 to i202
  %388 = lshr i202 %387, 181
  %_388.partselect = trunc i202 %388 to i1
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
  %390 = bitcast i202* %src_0 to i208*
  %391 = load i208, i208* %390
  %392 = trunc i208 %391 to i202
  %393 = lshr i202 %392, 182
  %_089.partselect = trunc i202 %393 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.1:                             ; preds = %src.addr.2252.exit
  %394 = bitcast i202* %src_1 to i208*
  %395 = load i208, i208* %394
  %396 = trunc i208 %395 to i202
  %397 = lshr i202 %396, 182
  %_190.partselect = trunc i202 %397 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.2:                             ; preds = %src.addr.2252.exit
  %398 = bitcast i202* %src_2 to i208*
  %399 = load i208, i208* %398
  %400 = trunc i208 %399 to i202
  %401 = lshr i202 %400, 182
  %_291.partselect = trunc i202 %401 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.3:                             ; preds = %src.addr.2252.exit
  %402 = bitcast i202* %src_3 to i208*
  %403 = load i208, i208* %402
  %404 = trunc i208 %403 to i202
  %405 = lshr i202 %404, 182
  %_392.partselect = trunc i202 %405 to i1
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
  %407 = bitcast i202* %src_0 to i208*
  %408 = load i208, i208* %407
  %409 = trunc i208 %408 to i202
  %410 = lshr i202 %409, 183
  %_093.partselect = trunc i202 %410 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.1:                             ; preds = %src.addr.2354.exit
  %411 = bitcast i202* %src_1 to i208*
  %412 = load i208, i208* %411
  %413 = trunc i208 %412 to i202
  %414 = lshr i202 %413, 183
  %_194.partselect = trunc i202 %414 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.2:                             ; preds = %src.addr.2354.exit
  %415 = bitcast i202* %src_2 to i208*
  %416 = load i208, i208* %415
  %417 = trunc i208 %416 to i202
  %418 = lshr i202 %417, 183
  %_295.partselect = trunc i202 %418 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.3:                             ; preds = %src.addr.2354.exit
  %419 = bitcast i202* %src_3 to i208*
  %420 = load i208, i208* %419
  %421 = trunc i208 %420 to i202
  %422 = lshr i202 %421, 183
  %_396.partselect = trunc i202 %422 to i1
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
  %424 = bitcast i202* %src_0 to i208*
  %425 = load i208, i208* %424
  %426 = trunc i208 %425 to i202
  %427 = lshr i202 %426, 184
  %_097.partselect = trunc i202 %427 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.1:                             ; preds = %src.addr.2456.exit
  %428 = bitcast i202* %src_1 to i208*
  %429 = load i208, i208* %428
  %430 = trunc i208 %429 to i202
  %431 = lshr i202 %430, 184
  %_198.partselect = trunc i202 %431 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.2:                             ; preds = %src.addr.2456.exit
  %432 = bitcast i202* %src_2 to i208*
  %433 = load i208, i208* %432
  %434 = trunc i208 %433 to i202
  %435 = lshr i202 %434, 184
  %_299.partselect = trunc i202 %435 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.3:                             ; preds = %src.addr.2456.exit
  %436 = bitcast i202* %src_3 to i208*
  %437 = load i208, i208* %436
  %438 = trunc i208 %437 to i202
  %439 = lshr i202 %438, 184
  %_3100.partselect = trunc i202 %439 to i1
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
  %441 = bitcast i202* %src_0 to i208*
  %442 = load i208, i208* %441
  %443 = trunc i208 %442 to i202
  %444 = lshr i202 %443, 185
  %_0101.partselect = trunc i202 %444 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.1:                             ; preds = %src.addr.2558.exit
  %445 = bitcast i202* %src_1 to i208*
  %446 = load i208, i208* %445
  %447 = trunc i208 %446 to i202
  %448 = lshr i202 %447, 185
  %_1102.partselect = trunc i202 %448 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.2:                             ; preds = %src.addr.2558.exit
  %449 = bitcast i202* %src_2 to i208*
  %450 = load i208, i208* %449
  %451 = trunc i208 %450 to i202
  %452 = lshr i202 %451, 185
  %_2103.partselect = trunc i202 %452 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.3:                             ; preds = %src.addr.2558.exit
  %453 = bitcast i202* %src_3 to i208*
  %454 = load i208, i208* %453
  %455 = trunc i208 %454 to i202
  %456 = lshr i202 %455, 185
  %_3104.partselect = trunc i202 %456 to i1
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
  %458 = bitcast i202* %src_0 to i208*
  %459 = load i208, i208* %458
  %460 = trunc i208 %459 to i202
  %461 = lshr i202 %460, 186
  %_0105.partselect = trunc i202 %461 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.1:                             ; preds = %src.addr.2660.exit
  %462 = bitcast i202* %src_1 to i208*
  %463 = load i208, i208* %462
  %464 = trunc i208 %463 to i202
  %465 = lshr i202 %464, 186
  %_1106.partselect = trunc i202 %465 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.2:                             ; preds = %src.addr.2660.exit
  %466 = bitcast i202* %src_2 to i208*
  %467 = load i208, i208* %466
  %468 = trunc i208 %467 to i202
  %469 = lshr i202 %468, 186
  %_2107.partselect = trunc i202 %469 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.3:                             ; preds = %src.addr.2660.exit
  %470 = bitcast i202* %src_3 to i208*
  %471 = load i208, i208* %470
  %472 = trunc i208 %471 to i202
  %473 = lshr i202 %472, 186
  %_3108.partselect = trunc i202 %473 to i1
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
  %475 = bitcast i202* %src_0 to i208*
  %476 = load i208, i208* %475
  %477 = trunc i208 %476 to i202
  %478 = lshr i202 %477, 187
  %_0109.partselect = trunc i202 %478 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.1:                             ; preds = %src.addr.2762.exit
  %479 = bitcast i202* %src_1 to i208*
  %480 = load i208, i208* %479
  %481 = trunc i208 %480 to i202
  %482 = lshr i202 %481, 187
  %_1110.partselect = trunc i202 %482 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.2:                             ; preds = %src.addr.2762.exit
  %483 = bitcast i202* %src_2 to i208*
  %484 = load i208, i208* %483
  %485 = trunc i208 %484 to i202
  %486 = lshr i202 %485, 187
  %_2111.partselect = trunc i202 %486 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.3:                             ; preds = %src.addr.2762.exit
  %487 = bitcast i202* %src_3 to i208*
  %488 = load i208, i208* %487
  %489 = trunc i208 %488 to i202
  %490 = lshr i202 %489, 187
  %_3112.partselect = trunc i202 %490 to i1
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
  %492 = bitcast i202* %src_0 to i208*
  %493 = load i208, i208* %492
  %494 = trunc i208 %493 to i202
  %495 = lshr i202 %494, 188
  %_0113.partselect = trunc i202 %495 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.1:                             ; preds = %src.addr.2864.exit
  %496 = bitcast i202* %src_1 to i208*
  %497 = load i208, i208* %496
  %498 = trunc i208 %497 to i202
  %499 = lshr i202 %498, 188
  %_1114.partselect = trunc i202 %499 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.2:                             ; preds = %src.addr.2864.exit
  %500 = bitcast i202* %src_2 to i208*
  %501 = load i208, i208* %500
  %502 = trunc i208 %501 to i202
  %503 = lshr i202 %502, 188
  %_2115.partselect = trunc i202 %503 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.3:                             ; preds = %src.addr.2864.exit
  %504 = bitcast i202* %src_3 to i208*
  %505 = load i208, i208* %504
  %506 = trunc i208 %505 to i202
  %507 = lshr i202 %506, 188
  %_3116.partselect = trunc i202 %507 to i1
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
  %509 = bitcast i202* %src_0 to i208*
  %510 = load i208, i208* %509
  %511 = trunc i208 %510 to i202
  %512 = lshr i202 %511, 189
  %_0117.partselect = trunc i202 %512 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.1:                             ; preds = %src.addr.2966.exit
  %513 = bitcast i202* %src_1 to i208*
  %514 = load i208, i208* %513
  %515 = trunc i208 %514 to i202
  %516 = lshr i202 %515, 189
  %_1118.partselect = trunc i202 %516 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.2:                             ; preds = %src.addr.2966.exit
  %517 = bitcast i202* %src_2 to i208*
  %518 = load i208, i208* %517
  %519 = trunc i208 %518 to i202
  %520 = lshr i202 %519, 189
  %_2119.partselect = trunc i202 %520 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.3:                             ; preds = %src.addr.2966.exit
  %521 = bitcast i202* %src_3 to i208*
  %522 = load i208, i208* %521
  %523 = trunc i208 %522 to i202
  %524 = lshr i202 %523, 189
  %_3120.partselect = trunc i202 %524 to i1
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
  %526 = bitcast i202* %src_0 to i208*
  %527 = load i208, i208* %526
  %528 = trunc i208 %527 to i202
  %529 = lshr i202 %528, 190
  %_0121.partselect = trunc i202 %529 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.1:                             ; preds = %src.addr.3068.exit
  %530 = bitcast i202* %src_1 to i208*
  %531 = load i208, i208* %530
  %532 = trunc i208 %531 to i202
  %533 = lshr i202 %532, 190
  %_1122.partselect = trunc i202 %533 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.2:                             ; preds = %src.addr.3068.exit
  %534 = bitcast i202* %src_2 to i208*
  %535 = load i208, i208* %534
  %536 = trunc i208 %535 to i202
  %537 = lshr i202 %536, 190
  %_2123.partselect = trunc i202 %537 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.3:                             ; preds = %src.addr.3068.exit
  %538 = bitcast i202* %src_3 to i208*
  %539 = load i208, i208* %538
  %540 = trunc i208 %539 to i202
  %541 = lshr i202 %540, 190
  %_3124.partselect = trunc i202 %541 to i1
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
  %543 = bitcast i202* %src_0 to i208*
  %544 = load i208, i208* %543
  %545 = trunc i208 %544 to i202
  %546 = lshr i202 %545, 191
  %_0125.partselect = trunc i202 %546 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.1:                             ; preds = %src.addr.3170.exit
  %547 = bitcast i202* %src_1 to i208*
  %548 = load i208, i208* %547
  %549 = trunc i208 %548 to i202
  %550 = lshr i202 %549, 191
  %_1126.partselect = trunc i202 %550 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.2:                             ; preds = %src.addr.3170.exit
  %551 = bitcast i202* %src_2 to i208*
  %552 = load i208, i208* %551
  %553 = trunc i208 %552 to i202
  %554 = lshr i202 %553, 191
  %_2127.partselect = trunc i202 %554 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.3:                             ; preds = %src.addr.3170.exit
  %555 = bitcast i202* %src_3 to i208*
  %556 = load i208, i208* %555
  %557 = trunc i208 %556 to i202
  %558 = lshr i202 %557, 191
  %_3128.partselect = trunc i202 %558 to i1
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
  %560 = bitcast i202* %src_0 to i208*
  %561 = load i208, i208* %560
  %562 = trunc i208 %561 to i202
  %563 = lshr i202 %562, 192
  %_0129.partselect = trunc i202 %563 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.1:                             ; preds = %src.addr.3272.exit
  %564 = bitcast i202* %src_1 to i208*
  %565 = load i208, i208* %564
  %566 = trunc i208 %565 to i202
  %567 = lshr i202 %566, 192
  %_1130.partselect = trunc i202 %567 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.2:                             ; preds = %src.addr.3272.exit
  %568 = bitcast i202* %src_2 to i208*
  %569 = load i208, i208* %568
  %570 = trunc i208 %569 to i202
  %571 = lshr i202 %570, 192
  %_2131.partselect = trunc i202 %571 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.3:                             ; preds = %src.addr.3272.exit
  %572 = bitcast i202* %src_3 to i208*
  %573 = load i208, i208* %572
  %574 = trunc i208 %573 to i202
  %575 = lshr i202 %574, 192
  %_3132.partselect = trunc i202 %575 to i1
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
  %577 = bitcast i202* %src_0 to i208*
  %578 = load i208, i208* %577
  %579 = trunc i208 %578 to i202
  %580 = lshr i202 %579, 193
  %_0133.partselect = trunc i202 %580 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.1:                             ; preds = %src.addr.3374.exit
  %581 = bitcast i202* %src_1 to i208*
  %582 = load i208, i208* %581
  %583 = trunc i208 %582 to i202
  %584 = lshr i202 %583, 193
  %_1134.partselect = trunc i202 %584 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.2:                             ; preds = %src.addr.3374.exit
  %585 = bitcast i202* %src_2 to i208*
  %586 = load i208, i208* %585
  %587 = trunc i208 %586 to i202
  %588 = lshr i202 %587, 193
  %_2135.partselect = trunc i202 %588 to i1
  br label %src.addr.3476.exit

src.addr.3476.case.3:                             ; preds = %src.addr.3374.exit
  %589 = bitcast i202* %src_3 to i208*
  %590 = load i208, i208* %589
  %591 = trunc i208 %590 to i202
  %592 = lshr i202 %591, 193
  %_3136.partselect = trunc i202 %592 to i1
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
  %594 = bitcast i202* %src_0 to i208*
  %595 = load i208, i208* %594
  %596 = trunc i208 %595 to i202
  %597 = lshr i202 %596, 194
  %_0137.partselect = trunc i202 %597 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.1:                             ; preds = %src.addr.3476.exit
  %598 = bitcast i202* %src_1 to i208*
  %599 = load i208, i208* %598
  %600 = trunc i208 %599 to i202
  %601 = lshr i202 %600, 194
  %_1138.partselect = trunc i202 %601 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.2:                             ; preds = %src.addr.3476.exit
  %602 = bitcast i202* %src_2 to i208*
  %603 = load i208, i208* %602
  %604 = trunc i208 %603 to i202
  %605 = lshr i202 %604, 194
  %_2139.partselect = trunc i202 %605 to i1
  br label %src.addr.3578.exit

src.addr.3578.case.3:                             ; preds = %src.addr.3476.exit
  %606 = bitcast i202* %src_3 to i208*
  %607 = load i208, i208* %606
  %608 = trunc i208 %607 to i202
  %609 = lshr i202 %608, 194
  %_3140.partselect = trunc i202 %609 to i1
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
  %611 = bitcast i202* %src_0 to i208*
  %612 = load i208, i208* %611
  %613 = trunc i208 %612 to i202
  %614 = lshr i202 %613, 195
  %_0141.partselect = trunc i202 %614 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.1:                             ; preds = %src.addr.3578.exit
  %615 = bitcast i202* %src_1 to i208*
  %616 = load i208, i208* %615
  %617 = trunc i208 %616 to i202
  %618 = lshr i202 %617, 195
  %_1142.partselect = trunc i202 %618 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.2:                             ; preds = %src.addr.3578.exit
  %619 = bitcast i202* %src_2 to i208*
  %620 = load i208, i208* %619
  %621 = trunc i208 %620 to i202
  %622 = lshr i202 %621, 195
  %_2143.partselect = trunc i202 %622 to i1
  br label %src.addr.3680.exit

src.addr.3680.case.3:                             ; preds = %src.addr.3578.exit
  %623 = bitcast i202* %src_3 to i208*
  %624 = load i208, i208* %623
  %625 = trunc i208 %624 to i202
  %626 = lshr i202 %625, 195
  %_3144.partselect = trunc i202 %626 to i1
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
  %628 = bitcast i202* %src_0 to i208*
  %629 = load i208, i208* %628
  %630 = trunc i208 %629 to i202
  %631 = lshr i202 %630, 196
  %_0145.partselect = trunc i202 %631 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.1:                             ; preds = %src.addr.3680.exit
  %632 = bitcast i202* %src_1 to i208*
  %633 = load i208, i208* %632
  %634 = trunc i208 %633 to i202
  %635 = lshr i202 %634, 196
  %_1146.partselect = trunc i202 %635 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.2:                             ; preds = %src.addr.3680.exit
  %636 = bitcast i202* %src_2 to i208*
  %637 = load i208, i208* %636
  %638 = trunc i208 %637 to i202
  %639 = lshr i202 %638, 196
  %_2147.partselect = trunc i202 %639 to i1
  br label %src.addr.3782.exit

src.addr.3782.case.3:                             ; preds = %src.addr.3680.exit
  %640 = bitcast i202* %src_3 to i208*
  %641 = load i208, i208* %640
  %642 = trunc i208 %641 to i202
  %643 = lshr i202 %642, 196
  %_3148.partselect = trunc i202 %643 to i1
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
  %645 = bitcast i202* %src_0 to i208*
  %646 = load i208, i208* %645
  %647 = trunc i208 %646 to i202
  %648 = lshr i202 %647, 197
  %_0149.partselect = trunc i202 %648 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.1:                             ; preds = %src.addr.3782.exit
  %649 = bitcast i202* %src_1 to i208*
  %650 = load i208, i208* %649
  %651 = trunc i208 %650 to i202
  %652 = lshr i202 %651, 197
  %_1150.partselect = trunc i202 %652 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.2:                             ; preds = %src.addr.3782.exit
  %653 = bitcast i202* %src_2 to i208*
  %654 = load i208, i208* %653
  %655 = trunc i208 %654 to i202
  %656 = lshr i202 %655, 197
  %_2151.partselect = trunc i202 %656 to i1
  br label %src.addr.3884.exit

src.addr.3884.case.3:                             ; preds = %src.addr.3782.exit
  %657 = bitcast i202* %src_3 to i208*
  %658 = load i208, i208* %657
  %659 = trunc i208 %658 to i202
  %660 = lshr i202 %659, 197
  %_3152.partselect = trunc i202 %660 to i1
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
  %662 = bitcast i202* %src_0 to i208*
  %663 = load i208, i208* %662
  %664 = trunc i208 %663 to i202
  %665 = lshr i202 %664, 198
  %_0153.partselect = trunc i202 %665 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.1:                             ; preds = %src.addr.3884.exit
  %666 = bitcast i202* %src_1 to i208*
  %667 = load i208, i208* %666
  %668 = trunc i208 %667 to i202
  %669 = lshr i202 %668, 198
  %_1154.partselect = trunc i202 %669 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.2:                             ; preds = %src.addr.3884.exit
  %670 = bitcast i202* %src_2 to i208*
  %671 = load i208, i208* %670
  %672 = trunc i208 %671 to i202
  %673 = lshr i202 %672, 198
  %_2155.partselect = trunc i202 %673 to i1
  br label %src.addr.3986.exit

src.addr.3986.case.3:                             ; preds = %src.addr.3884.exit
  %674 = bitcast i202* %src_3 to i208*
  %675 = load i208, i208* %674
  %676 = trunc i208 %675 to i202
  %677 = lshr i202 %676, 198
  %_3156.partselect = trunc i202 %677 to i1
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
  %679 = bitcast i202* %src_0 to i208*
  %680 = load i208, i208* %679
  %681 = trunc i208 %680 to i202
  %682 = lshr i202 %681, 199
  %_0157.partselect = trunc i202 %682 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.1:                             ; preds = %src.addr.3986.exit
  %683 = bitcast i202* %src_1 to i208*
  %684 = load i208, i208* %683
  %685 = trunc i208 %684 to i202
  %686 = lshr i202 %685, 199
  %_1158.partselect = trunc i202 %686 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.2:                             ; preds = %src.addr.3986.exit
  %687 = bitcast i202* %src_2 to i208*
  %688 = load i208, i208* %687
  %689 = trunc i208 %688 to i202
  %690 = lshr i202 %689, 199
  %_2159.partselect = trunc i202 %690 to i1
  br label %src.addr.4088.exit

src.addr.4088.case.3:                             ; preds = %src.addr.3986.exit
  %691 = bitcast i202* %src_3 to i208*
  %692 = load i208, i208* %691
  %693 = trunc i208 %692 to i202
  %694 = lshr i202 %693, 199
  %_3160.partselect = trunc i202 %694 to i1
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
  %696 = bitcast i202* %src_0 to i208*
  %697 = load i208, i208* %696
  %698 = trunc i208 %697 to i202
  %699 = lshr i202 %698, 200
  %_0161.partselect = trunc i202 %699 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.1:                             ; preds = %src.addr.4088.exit
  %700 = bitcast i202* %src_1 to i208*
  %701 = load i208, i208* %700
  %702 = trunc i208 %701 to i202
  %703 = lshr i202 %702, 200
  %_1162.partselect = trunc i202 %703 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.2:                             ; preds = %src.addr.4088.exit
  %704 = bitcast i202* %src_2 to i208*
  %705 = load i208, i208* %704
  %706 = trunc i208 %705 to i202
  %707 = lshr i202 %706, 200
  %_2163.partselect = trunc i202 %707 to i1
  br label %src.addr.4190.exit

src.addr.4190.case.3:                             ; preds = %src.addr.4088.exit
  %708 = bitcast i202* %src_3 to i208*
  %709 = load i208, i208* %708
  %710 = trunc i208 %709 to i202
  %711 = lshr i202 %710, 200
  %_3164.partselect = trunc i202 %711 to i1
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
  %713 = bitcast i202* %src_0 to i208*
  %714 = load i208, i208* %713
  %715 = trunc i208 %714 to i202
  %716 = lshr i202 %715, 201
  %_0165.partselect = trunc i202 %716 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.1:                             ; preds = %src.addr.4190.exit
  %717 = bitcast i202* %src_1 to i208*
  %718 = load i208, i208* %717
  %719 = trunc i208 %718 to i202
  %720 = lshr i202 %719, 201
  %_1166.partselect = trunc i202 %720 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.2:                             ; preds = %src.addr.4190.exit
  %721 = bitcast i202* %src_2 to i208*
  %722 = load i208, i208* %721
  %723 = trunc i208 %722 to i202
  %724 = lshr i202 %723, 201
  %_2167.partselect = trunc i202 %724 to i1
  br label %src.addr.4292.exit

src.addr.4292.case.3:                             ; preds = %src.addr.4190.exit
  %725 = bitcast i202* %src_3 to i208*
  %726 = load i208, i208* %725
  %727 = trunc i208 %726 to i202
  %728 = lshr i202 %727, 201
  %_3168.partselect = trunc i202 %728 to i1
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
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.24.27([4 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i202* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i202* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1, i202* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.2" %src_2, i202* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.3" %src_3) #1 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i202* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.25.26([4 x %struct.HeadCtx]* nonnull %dst, i202* nonnull %src_0, i202* %src_1, i202* %src_2, i202* %src_3, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="2", i202* noalias readonly align 512 "orig.arg.no"="3" "unpacked"="3.0" %_0, i202* noalias readonly align 512 "orig.arg.no"="3" "unpacked"="3.1" %_1, i202* noalias readonly align 512 "orig.arg.no"="3" "unpacked"="3.2" %_2, i202* noalias readonly align 512 "orig.arg.no"="3" "unpacked"="3.3" %_3, i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i8* noalias "orig.arg.no"="6", i8* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i1* noalias "orig.arg.no"="10", i1* noalias readonly align 512 "orig.arg.no"="11", i8* noalias "orig.arg.no"="12", i8* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i32* noalias "orig.arg.no"="16", i32* noalias readonly align 512 "orig.arg.no"="17", i32* noalias "orig.arg.no"="18", i32* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.24.27([4 x %struct.HeadCtx]* %2, i202* align 512 %_0, i202* align 512 %_1, i202* align 512 %_2, i202* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %3, i1* align 512 %4)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %5, i8* align 512 %6)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %7, i1* align 512 %8)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %9, i1* align 512 %10)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %11, i8* align 512 %12)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %13, i32* align 512 %14)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %15, i32* align 512 %16)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %17, i32* align 512 %18)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %19, i32* align 512 %20)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare void @apatb_transformer_top_hw(i1, i1, i1*, i1, i1, i1, i202*, i202*, i202*, i202*, i1*, i8*, i1, i1*, i1, i1, i1*, i8*, i32*, i32*, i32*, i32, i32, i32, i1, i1, i1, i1, i32*, i1)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back(i1* noalias "orig.arg.no"="0", i1* noalias readonly align 512 "orig.arg.no"="1", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="2", i202* noalias readonly align 512 "orig.arg.no"="3" "unpacked"="3.0" %_0, i202* noalias readonly align 512 "orig.arg.no"="3" "unpacked"="3.1" %_1, i202* noalias readonly align 512 "orig.arg.no"="3" "unpacked"="3.2" %_2, i202* noalias readonly align 512 "orig.arg.no"="3" "unpacked"="3.3" %_3, i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i8* noalias "orig.arg.no"="6", i8* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i1* noalias "orig.arg.no"="10", i1* noalias readonly align 512 "orig.arg.no"="11", i8* noalias "orig.arg.no"="12", i8* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i32* noalias "orig.arg.no"="16", i32* noalias readonly align 512 "orig.arg.no"="17", i32* noalias "orig.arg.no"="18", i32* noalias readonly align 512 "orig.arg.no"="19", i32* noalias "orig.arg.no"="20", i32* noalias readonly align 512 "orig.arg.no"="21") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.24.27([4 x %struct.HeadCtx]* %2, i202* align 512 %_0, i202* align 512 %_1, i202* align 512 %_2, i202* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %3, i1* align 512 %4)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %5, i8* align 512 %6)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %7, i1* align 512 %8)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %9, i1* align 512 %10)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %11, i8* align 512 %12)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %13, i32* align 512 %14)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %15, i32* align 512 %16)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %17, i32* align 512 %18)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %19, i32* align 512 %20)
  ret void
}

declare void @transformer_top_hw_stub(i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1 zeroext, [4 x %struct.HeadCtx]* noalias nonnull, i1* noalias nocapture nonnull, i8* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i8* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32, i32, i32, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i32* noalias nocapture nonnull, i1 zeroext)

define void @transformer_top_hw_stub_wrapper(i1, i1, i1*, i1, i1, i1, i202*, i202*, i202*, i202*, i1*, i8*, i1, i1*, i1, i1, i1*, i8*, i32*, i32*, i32*, i32, i32, i32, i1, i1, i1, i1, i32*, i1) #5 {
entry:
  %30 = call i8* @malloc(i64 240)
  %31 = bitcast i8* %30 to [4 x %struct.HeadCtx]*
  call void @copy_out(i1* null, i1* %2, [4 x %struct.HeadCtx]* %31, i202* %6, i202* %7, i202* %8, i202* %9, i1* null, i1* %10, i8* null, i8* %11, i1* null, i1* %13, i1* null, i1* %16, i8* null, i8* %17, i32* null, i32* %18, i32* null, i32* %19, i32* null, i32* %20, i32* null, i32* %28)
  call void @transformer_top_hw_stub(i1 %0, i1 %1, i1* %2, i1 %3, i1 %4, i1 %5, [4 x %struct.HeadCtx]* %31, i1* %10, i8* %11, i1 %12, i1* %13, i1 %14, i1 %15, i1* %16, i8* %17, i32* %18, i32* %19, i32* %20, i32 %21, i32 %22, i32 %23, i1 %24, i1 %25, i1 %26, i1 %27, i32* %28, i1 %29)
  call void @copy_in(i1* null, i1* %2, [4 x %struct.HeadCtx]* %31, i202* %6, i202* %7, i202* %8, i202* %9, i1* null, i1* %10, i8* null, i8* %11, i1* null, i1* %13, i1* null, i1* %16, i8* null, i8* %17, i32* null, i32* %18, i32* null, i32* %19, i32* null, i32* %20, i32* null, i32* %28)
  call void @free(i8* %30)
  ret void
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
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
!7 = !{!"6", [4 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12, !13, !14}
!11 = !{!"6.0", %struct.HeadCtx* null}
!12 = !{!"6.1", %struct.HeadCtx* null}
!13 = !{!"6.2", %struct.HeadCtx* null}
!14 = !{!"6.3", %struct.HeadCtx* null}
