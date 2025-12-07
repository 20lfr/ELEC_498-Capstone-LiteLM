; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_head_helpers/Head_Helpers_and_dma/drive_group_head_phase/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i8, i1, i1, i8, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }

; Function Attrs: inaccessiblemem_or_argmemonly noinline willreturn
define i1 @apatb_drive_group_head_phase_ir([2 x %struct.HeadCtx]* noalias nonnull dereferenceable(96) "partition" %head_ctx_ref, i32 %base_head_idx, i32 %layer_idx, i1 zeroext %start) local_unnamed_addr #0 {
entry:
  %head_ctx_ref_copy_0 = alloca i179, align 512
  %head_ctx_ref_copy_1 = alloca i179, align 512
  call void @copy_in([2 x %struct.HeadCtx]* nonnull %head_ctx_ref, i179* nonnull align 512 %head_ctx_ref_copy_0, i179* nonnull align 512 %head_ctx_ref_copy_1)
  %0 = call i1 @apatb_drive_group_head_phase_hw(i179* %head_ctx_ref_copy_0, i179* %head_ctx_ref_copy_1, i32 %base_head_idx, i32 %layer_idx, i1 %start)
  call void @copy_back([2 x %struct.HeadCtx]* %head_ctx_ref, i179* %head_ctx_ref_copy_0, i179* %head_ctx_ref_copy_1)
  ret i1 %0
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2struct.HeadCtx([2 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, [2 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #1 {
entry:
  %0 = icmp eq [2 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [2 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond76 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond76, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx77 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 0
  %dst.addr.02 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 1
  %dst.addr.111 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 1
  %4 = load i32, i32* %src.addr.110, align 4
  store i32 %4, i32* %dst.addr.111, align 4
  %src.addr.212 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 2
  %dst.addr.213 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 2
  %5 = load i8, i8* %src.addr.212, align 1
  store i8 %5, i8* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 3
  %dst.addr.315 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 3
  %6 = bitcast i1* %src.addr.314 to i8*
  %7 = load i8, i8* %6
  %8 = trunc i8 %7 to i1
  store i1 %8, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 4
  %dst.addr.417 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 4
  %9 = bitcast i1* %src.addr.416 to i8*
  %10 = load i8, i8* %9
  %11 = trunc i8 %10 to i1
  store i1 %11, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 5
  %dst.addr.519 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 5
  %12 = bitcast i1* %src.addr.518 to i8*
  %13 = load i8, i8* %12
  %14 = trunc i8 %13 to i1
  store i1 %14, i1* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 6
  %dst.addr.621 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 6
  %15 = load i8, i8* %src.addr.620, align 1
  store i8 %15, i8* %dst.addr.621, align 1
  %src.addr.722 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 7
  %dst.addr.723 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 7
  %16 = bitcast i1* %src.addr.722 to i8*
  %17 = load i8, i8* %16
  %18 = trunc i8 %17 to i1
  store i1 %18, i1* %dst.addr.723, align 1
  %src.addr.824 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 8
  %dst.addr.825 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 8
  %19 = bitcast i1* %src.addr.824 to i8*
  %20 = load i8, i8* %19
  %21 = trunc i8 %20 to i1
  store i1 %21, i1* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 9
  %dst.addr.927 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 9
  %22 = load i8, i8* %src.addr.926, align 1
  store i8 %22, i8* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 10
  %dst.addr.1029 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 10
  %23 = load i32, i32* %src.addr.1028, align 4
  store i32 %23, i32* %dst.addr.1029, align 4
  %src.addr.1130 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 11
  %dst.addr.1131 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 11
  %24 = load i32, i32* %src.addr.1130, align 4
  store i32 %24, i32* %dst.addr.1131, align 4
  %src.addr.1232 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 12
  %dst.addr.1233 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 12
  %25 = bitcast i1* %src.addr.1232 to i8*
  %26 = load i8, i8* %25
  %27 = trunc i8 %26 to i1
  store i1 %27, i1* %dst.addr.1233, align 1
  %src.addr.1334 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 13
  %dst.addr.1335 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 13
  %28 = bitcast i1* %src.addr.1334 to i8*
  %29 = load i8, i8* %28
  %30 = trunc i8 %29 to i1
  store i1 %30, i1* %dst.addr.1335, align 1
  %src.addr.1436 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 14
  %dst.addr.1437 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 14
  %31 = bitcast i1* %src.addr.1436 to i8*
  %32 = load i8, i8* %31
  %33 = trunc i8 %32 to i1
  store i1 %33, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 15
  %dst.addr.1539 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 15
  %34 = bitcast i1* %src.addr.1538 to i8*
  %35 = load i8, i8* %34
  %36 = trunc i8 %35 to i1
  store i1 %36, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 16
  %dst.addr.1641 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 16
  %37 = bitcast i1* %src.addr.1640 to i8*
  %38 = load i8, i8* %37
  %39 = trunc i8 %38 to i1
  store i1 %39, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 17
  %dst.addr.1743 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 17
  %40 = bitcast i1* %src.addr.1742 to i8*
  %41 = load i8, i8* %40
  %42 = trunc i8 %41 to i1
  store i1 %42, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 18
  %dst.addr.1845 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 18
  %43 = bitcast i1* %src.addr.1844 to i8*
  %44 = load i8, i8* %43
  %45 = trunc i8 %44 to i1
  store i1 %45, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 19
  %dst.addr.1947 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 19
  %46 = bitcast i1* %src.addr.1946 to i8*
  %47 = load i8, i8* %46
  %48 = trunc i8 %47 to i1
  store i1 %48, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 20
  %dst.addr.2049 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 20
  %49 = bitcast i1* %src.addr.2048 to i8*
  %50 = load i8, i8* %49
  %51 = trunc i8 %50 to i1
  store i1 %51, i1* %dst.addr.2049, align 1
  %src.addr.2150 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 21
  %dst.addr.2151 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 21
  %52 = bitcast i1* %src.addr.2150 to i8*
  %53 = load i8, i8* %52
  %54 = trunc i8 %53 to i1
  store i1 %54, i1* %dst.addr.2151, align 1
  %src.addr.2252 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 22
  %dst.addr.2253 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 22
  %55 = bitcast i1* %src.addr.2252 to i8*
  %56 = load i8, i8* %55
  %57 = trunc i8 %56 to i1
  store i1 %57, i1* %dst.addr.2253, align 1
  %src.addr.2354 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 23
  %dst.addr.2355 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 23
  %58 = bitcast i1* %src.addr.2354 to i8*
  %59 = load i8, i8* %58
  %60 = trunc i8 %59 to i1
  store i1 %60, i1* %dst.addr.2355, align 1
  %src.addr.2456 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 24
  %dst.addr.2457 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 24
  %61 = bitcast i1* %src.addr.2456 to i8*
  %62 = load i8, i8* %61
  %63 = trunc i8 %62 to i1
  store i1 %63, i1* %dst.addr.2457, align 1
  %src.addr.2558 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 25
  %dst.addr.2559 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 25
  %64 = bitcast i1* %src.addr.2558 to i8*
  %65 = load i8, i8* %64
  %66 = trunc i8 %65 to i1
  store i1 %66, i1* %dst.addr.2559, align 1
  %src.addr.2660 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 26
  %dst.addr.2661 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 26
  %67 = bitcast i1* %src.addr.2660 to i8*
  %68 = load i8, i8* %67
  %69 = trunc i8 %68 to i1
  store i1 %69, i1* %dst.addr.2661, align 1
  %src.addr.2762 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 27
  %dst.addr.2763 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 27
  %70 = bitcast i1* %src.addr.2762 to i8*
  %71 = load i8, i8* %70
  %72 = trunc i8 %71 to i1
  store i1 %72, i1* %dst.addr.2763, align 1
  %src.addr.2864 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 28
  %dst.addr.2865 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 28
  %73 = bitcast i1* %src.addr.2864 to i8*
  %74 = load i8, i8* %73
  %75 = trunc i8 %74 to i1
  store i1 %75, i1* %dst.addr.2865, align 1
  %src.addr.2966 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 29
  %dst.addr.2967 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 29
  %76 = bitcast i1* %src.addr.2966 to i8*
  %77 = load i8, i8* %76
  %78 = trunc i8 %77 to i1
  store i1 %78, i1* %dst.addr.2967, align 1
  %src.addr.3068 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 30
  %dst.addr.3069 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 30
  %79 = bitcast i1* %src.addr.3068 to i8*
  %80 = load i8, i8* %79
  %81 = trunc i8 %80 to i1
  store i1 %81, i1* %dst.addr.3069, align 1
  %src.addr.3170 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 31
  %dst.addr.3171 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 31
  %82 = bitcast i1* %src.addr.3170 to i8*
  %83 = load i8, i8* %82
  %84 = trunc i8 %83 to i1
  store i1 %84, i1* %dst.addr.3171, align 1
  %src.addr.3272 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 32
  %dst.addr.3273 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 32
  %85 = bitcast i1* %src.addr.3272 to i8*
  %86 = load i8, i8* %85
  %87 = trunc i8 %86 to i1
  store i1 %87, i1* %dst.addr.3273, align 1
  %src.addr.3374 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 33
  %dst.addr.3375 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 33
  %88 = bitcast i1* %src.addr.3374 to i8*
  %89 = load i8, i8* %88
  %90 = trunc i8 %89 to i1
  store i1 %90, i1* %dst.addr.3375, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx77, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2struct.HeadCtx.3.4(i179* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i179* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, [2 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #1 {
entry:
  %0 = icmp eq [2 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i179* %dst_0, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond76 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond76, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %dst.addr.3375.exit, %for.loop.lr.ph
  %for.loop.idx77 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %dst.addr.3375.exit ]
  %src.addr.01 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  switch i64 %for.loop.idx77, label %dst.addr.02.exit [
    i64 0, label %dst.addr.02.case.0
    i64 1, label %dst.addr.02.case.1
  ]

dst.addr.02.case.0:                               ; preds = %for.loop
  %4 = bitcast i179* %dst_0 to i184*
  %5 = load i184, i184* %4
  %6 = trunc i184 %5 to i179
  %7 = zext i32 %3 to i179
  %8 = and i179 %6, -4294967296
  %.partset67 = or i179 %8, %7
  store i179 %.partset67, i179* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i179* %dst_1 to i184*
  %10 = load i184, i184* %9
  %11 = trunc i184 %10 to i179
  %12 = zext i32 %3 to i179
  %13 = and i179 %11, -4294967296
  %.partset = or i179 %13, %12
  store i179 %.partset, i179* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.exit:                                 ; preds = %dst.addr.02.case.1, %dst.addr.02.case.0, %for.loop
  %src.addr.110 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 1
  %14 = load i32, i32* %src.addr.110, align 4
  switch i64 %for.loop.idx77, label %dst.addr.111.exit [
    i64 0, label %dst.addr.111.case.0
    i64 1, label %dst.addr.111.case.1
  ]

dst.addr.111.case.0:                              ; preds = %dst.addr.02.exit
  %15 = bitcast i179* %dst_0 to i184*
  %16 = load i184, i184* %15
  %17 = trunc i184 %16 to i179
  %18 = zext i32 %14 to i179
  %19 = shl i179 %18, 32
  %20 = and i179 %17, -18446744069414584321
  %.partset66 = or i179 %20, %19
  store i179 %.partset66, i179* %dst_0, align 4
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %21 = bitcast i179* %dst_1 to i184*
  %22 = load i184, i184* %21
  %23 = trunc i184 %22 to i179
  %24 = zext i32 %14 to i179
  %25 = shl i179 %24, 32
  %26 = and i179 %23, -18446744069414584321
  %.partset1 = or i179 %26, %25
  store i179 %.partset1, i179* %dst_1, align 4
  br label %dst.addr.111.exit

dst.addr.111.exit:                                ; preds = %dst.addr.111.case.1, %dst.addr.111.case.0, %dst.addr.02.exit
  %src.addr.212 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 2
  %27 = load i8, i8* %src.addr.212, align 1
  switch i64 %for.loop.idx77, label %dst.addr.213.exit [
    i64 0, label %dst.addr.213.case.0
    i64 1, label %dst.addr.213.case.1
  ]

dst.addr.213.case.0:                              ; preds = %dst.addr.111.exit
  %28 = bitcast i179* %dst_0 to i184*
  %29 = load i184, i184* %28
  %30 = trunc i184 %29 to i179
  %31 = zext i8 %27 to i179
  %32 = shl i179 %31, 64
  %33 = and i179 %30, -4703919738795935662081
  %.partset65 = or i179 %33, %32
  store i179 %.partset65, i179* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %34 = bitcast i179* %dst_1 to i184*
  %35 = load i184, i184* %34
  %36 = trunc i184 %35 to i179
  %37 = zext i8 %27 to i179
  %38 = shl i179 %37, 64
  %39 = and i179 %36, -4703919738795935662081
  %.partset2 = or i179 %39, %38
  store i179 %.partset2, i179* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.exit:                                ; preds = %dst.addr.213.case.1, %dst.addr.213.case.0, %dst.addr.111.exit
  %src.addr.314 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 3
  %40 = bitcast i1* %src.addr.314 to i8*
  %41 = load i8, i8* %40
  %42 = trunc i8 %41 to i1
  switch i64 %for.loop.idx77, label %dst.addr.315.exit [
    i64 0, label %dst.addr.315.case.0
    i64 1, label %dst.addr.315.case.1
  ]

dst.addr.315.case.0:                              ; preds = %dst.addr.213.exit
  %43 = bitcast i179* %dst_0 to i184*
  %44 = load i184, i184* %43
  %45 = trunc i184 %44 to i179
  %46 = zext i1 %42 to i179
  %47 = shl i179 %46, 72
  %48 = and i179 %45, -4722366482869645213697
  %.partset64 = or i179 %48, %47
  store i179 %.partset64, i179* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %49 = bitcast i179* %dst_1 to i184*
  %50 = load i184, i184* %49
  %51 = trunc i184 %50 to i179
  %52 = zext i1 %42 to i179
  %53 = shl i179 %52, 72
  %54 = and i179 %51, -4722366482869645213697
  %.partset3 = or i179 %54, %53
  store i179 %.partset3, i179* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.exit:                                ; preds = %dst.addr.315.case.1, %dst.addr.315.case.0, %dst.addr.213.exit
  %src.addr.416 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 4
  %55 = bitcast i1* %src.addr.416 to i8*
  %56 = load i8, i8* %55
  %57 = trunc i8 %56 to i1
  switch i64 %for.loop.idx77, label %dst.addr.417.exit [
    i64 0, label %dst.addr.417.case.0
    i64 1, label %dst.addr.417.case.1
  ]

dst.addr.417.case.0:                              ; preds = %dst.addr.315.exit
  %58 = bitcast i179* %dst_0 to i184*
  %59 = load i184, i184* %58
  %60 = trunc i184 %59 to i179
  %61 = zext i1 %57 to i179
  %62 = shl i179 %61, 73
  %63 = and i179 %60, -9444732965739290427393
  %.partset63 = or i179 %63, %62
  store i179 %.partset63, i179* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %64 = bitcast i179* %dst_1 to i184*
  %65 = load i184, i184* %64
  %66 = trunc i184 %65 to i179
  %67 = zext i1 %57 to i179
  %68 = shl i179 %67, 73
  %69 = and i179 %66, -9444732965739290427393
  %.partset4 = or i179 %69, %68
  store i179 %.partset4, i179* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.exit:                                ; preds = %dst.addr.417.case.1, %dst.addr.417.case.0, %dst.addr.315.exit
  %src.addr.518 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 5
  %70 = bitcast i1* %src.addr.518 to i8*
  %71 = load i8, i8* %70
  %72 = trunc i8 %71 to i1
  switch i64 %for.loop.idx77, label %dst.addr.519.exit [
    i64 0, label %dst.addr.519.case.0
    i64 1, label %dst.addr.519.case.1
  ]

dst.addr.519.case.0:                              ; preds = %dst.addr.417.exit
  %73 = bitcast i179* %dst_0 to i184*
  %74 = load i184, i184* %73
  %75 = trunc i184 %74 to i179
  %76 = zext i1 %72 to i179
  %77 = shl i179 %76, 74
  %78 = and i179 %75, -18889465931478580854785
  %.partset62 = or i179 %78, %77
  store i179 %.partset62, i179* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %79 = bitcast i179* %dst_1 to i184*
  %80 = load i184, i184* %79
  %81 = trunc i184 %80 to i179
  %82 = zext i1 %72 to i179
  %83 = shl i179 %82, 74
  %84 = and i179 %81, -18889465931478580854785
  %.partset5 = or i179 %84, %83
  store i179 %.partset5, i179* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 6
  %85 = load i8, i8* %src.addr.620, align 1
  switch i64 %for.loop.idx77, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %86 = bitcast i179* %dst_0 to i184*
  %87 = load i184, i184* %86
  %88 = trunc i184 %87 to i179
  %89 = zext i8 %85 to i179
  %90 = shl i179 %89, 75
  %91 = and i179 %88, -9633627625054076235939841
  %.partset61 = or i179 %91, %90
  store i179 %.partset61, i179* %dst_0, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %92 = bitcast i179* %dst_1 to i184*
  %93 = load i184, i184* %92
  %94 = trunc i184 %93 to i179
  %95 = zext i8 %85 to i179
  %96 = shl i179 %95, 75
  %97 = and i179 %94, -9633627625054076235939841
  %.partset6 = or i179 %97, %96
  store i179 %.partset6, i179* %dst_1, align 1
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 7
  %98 = bitcast i1* %src.addr.722 to i8*
  %99 = load i8, i8* %98
  %100 = trunc i8 %99 to i1
  switch i64 %for.loop.idx77, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %101 = bitcast i179* %dst_0 to i184*
  %102 = load i184, i184* %101
  %103 = trunc i184 %102 to i179
  %104 = zext i1 %100 to i179
  %105 = shl i179 %104, 83
  %106 = and i179 %103, -9671406556917033397649409
  %.partset60 = or i179 %106, %105
  store i179 %.partset60, i179* %dst_0, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %107 = bitcast i179* %dst_1 to i184*
  %108 = load i184, i184* %107
  %109 = trunc i184 %108 to i179
  %110 = zext i1 %100 to i179
  %111 = shl i179 %110, 83
  %112 = and i179 %109, -9671406556917033397649409
  %.partset7 = or i179 %112, %111
  store i179 %.partset7, i179* %dst_1, align 1
  br label %dst.addr.723.exit

dst.addr.723.exit:                                ; preds = %dst.addr.723.case.1, %dst.addr.723.case.0, %dst.addr.621.exit
  %src.addr.824 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 8
  %113 = bitcast i1* %src.addr.824 to i8*
  %114 = load i8, i8* %113
  %115 = trunc i8 %114 to i1
  switch i64 %for.loop.idx77, label %dst.addr.825.exit [
    i64 0, label %dst.addr.825.case.0
    i64 1, label %dst.addr.825.case.1
  ]

dst.addr.825.case.0:                              ; preds = %dst.addr.723.exit
  %116 = bitcast i179* %dst_0 to i184*
  %117 = load i184, i184* %116
  %118 = trunc i184 %117 to i179
  %119 = zext i1 %115 to i179
  %120 = shl i179 %119, 84
  %121 = and i179 %118, -19342813113834066795298817
  %.partset59 = or i179 %121, %120
  store i179 %.partset59, i179* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %122 = bitcast i179* %dst_1 to i184*
  %123 = load i184, i184* %122
  %124 = trunc i184 %123 to i179
  %125 = zext i1 %115 to i179
  %126 = shl i179 %125, 84
  %127 = and i179 %124, -19342813113834066795298817
  %.partset8 = or i179 %127, %126
  store i179 %.partset8, i179* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.exit:                                ; preds = %dst.addr.825.case.1, %dst.addr.825.case.0, %dst.addr.723.exit
  %src.addr.926 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 9
  %128 = load i8, i8* %src.addr.926, align 1
  switch i64 %for.loop.idx77, label %dst.addr.927.exit [
    i64 0, label %dst.addr.927.case.0
    i64 1, label %dst.addr.927.case.1
  ]

dst.addr.927.case.0:                              ; preds = %dst.addr.825.exit
  %129 = bitcast i179* %dst_0 to i184*
  %130 = load i184, i184* %129
  %131 = trunc i184 %130 to i179
  %132 = zext i8 %128 to i179
  %133 = shl i179 %132, 85
  %134 = and i179 %131, -9864834688055374065602396161
  %.partset58 = or i179 %134, %133
  store i179 %.partset58, i179* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %135 = bitcast i179* %dst_1 to i184*
  %136 = load i184, i184* %135
  %137 = trunc i184 %136 to i179
  %138 = zext i8 %128 to i179
  %139 = shl i179 %138, 85
  %140 = and i179 %137, -9864834688055374065602396161
  %.partset9 = or i179 %140, %139
  store i179 %.partset9, i179* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.exit:                                ; preds = %dst.addr.927.case.1, %dst.addr.927.case.0, %dst.addr.825.exit
  %src.addr.1028 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 10
  %141 = load i32, i32* %src.addr.1028, align 4
  switch i64 %for.loop.idx77, label %dst.addr.1029.exit [
    i64 0, label %dst.addr.1029.case.0
    i64 1, label %dst.addr.1029.case.1
  ]

dst.addr.1029.case.0:                             ; preds = %dst.addr.927.exit
  %142 = bitcast i179* %dst_0 to i184*
  %143 = load i184, i184* %142
  %144 = trunc i184 %143 to i179
  %145 = zext i32 %141 to i179
  %146 = shl i179 %145, 93
  %147 = and i179 %144, -42535295855213787618638783729778032641
  %.partset57 = or i179 %147, %146
  store i179 %.partset57, i179* %dst_0, align 4
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %148 = bitcast i179* %dst_1 to i184*
  %149 = load i184, i184* %148
  %150 = trunc i184 %149 to i179
  %151 = zext i32 %141 to i179
  %152 = shl i179 %151, 93
  %153 = and i179 %150, -42535295855213787618638783729778032641
  %.partset10 = or i179 %153, %152
  store i179 %.partset10, i179* %dst_1, align 4
  br label %dst.addr.1029.exit

dst.addr.1029.exit:                               ; preds = %dst.addr.1029.case.1, %dst.addr.1029.case.0, %dst.addr.927.exit
  %src.addr.1130 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 11
  %154 = load i32, i32* %src.addr.1130, align 4
  switch i64 %for.loop.idx77, label %dst.addr.1131.exit [
    i64 0, label %dst.addr.1131.case.0
    i64 1, label %dst.addr.1131.case.1
  ]

dst.addr.1131.case.0:                             ; preds = %dst.addr.1029.exit
  %155 = bitcast i179* %dst_0 to i184*
  %156 = load i184, i184* %155
  %157 = trunc i184 %156 to i179
  %158 = zext i32 %154 to i179
  %159 = shl i179 %158, 125
  %160 = and i179 %157, -182687704623827568910343296156613551528020541441
  %.partset56 = or i179 %160, %159
  store i179 %.partset56, i179* %dst_0, align 4
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %161 = bitcast i179* %dst_1 to i184*
  %162 = load i184, i184* %161
  %163 = trunc i184 %162 to i179
  %164 = zext i32 %154 to i179
  %165 = shl i179 %164, 125
  %166 = and i179 %163, -182687704623827568910343296156613551528020541441
  %.partset11 = or i179 %166, %165
  store i179 %.partset11, i179* %dst_1, align 4
  br label %dst.addr.1131.exit

dst.addr.1131.exit:                               ; preds = %dst.addr.1131.case.1, %dst.addr.1131.case.0, %dst.addr.1029.exit
  %src.addr.1232 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 12
  %167 = bitcast i1* %src.addr.1232 to i8*
  %168 = load i8, i8* %167
  %169 = trunc i8 %168 to i1
  switch i64 %for.loop.idx77, label %dst.addr.1233.exit [
    i64 0, label %dst.addr.1233.case.0
    i64 1, label %dst.addr.1233.case.1
  ]

dst.addr.1233.case.0:                             ; preds = %dst.addr.1131.exit
  %170 = bitcast i179* %dst_0 to i184*
  %171 = load i184, i184* %170
  %172 = trunc i184 %171 to i179
  %173 = zext i1 %169 to i179
  %174 = shl i179 %173, 157
  %175 = and i179 %172, -182687704666362864775460604089535377456991567873
  %.partset55 = or i179 %175, %174
  store i179 %.partset55, i179* %dst_0, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %176 = bitcast i179* %dst_1 to i184*
  %177 = load i184, i184* %176
  %178 = trunc i184 %177 to i179
  %179 = zext i1 %169 to i179
  %180 = shl i179 %179, 157
  %181 = and i179 %178, -182687704666362864775460604089535377456991567873
  %.partset12 = or i179 %181, %180
  store i179 %.partset12, i179* %dst_1, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.exit:                               ; preds = %dst.addr.1233.case.1, %dst.addr.1233.case.0, %dst.addr.1131.exit
  %src.addr.1334 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 13
  %182 = bitcast i1* %src.addr.1334 to i8*
  %183 = load i8, i8* %182
  %184 = trunc i8 %183 to i1
  switch i64 %for.loop.idx77, label %dst.addr.1335.exit [
    i64 0, label %dst.addr.1335.case.0
    i64 1, label %dst.addr.1335.case.1
  ]

dst.addr.1335.case.0:                             ; preds = %dst.addr.1233.exit
  %185 = bitcast i179* %dst_0 to i184*
  %186 = load i184, i184* %185
  %187 = trunc i184 %186 to i179
  %188 = zext i1 %184 to i179
  %189 = shl i179 %188, 158
  %190 = and i179 %187, -365375409332725729550921208179070754913983135745
  %.partset54 = or i179 %190, %189
  store i179 %.partset54, i179* %dst_0, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %191 = bitcast i179* %dst_1 to i184*
  %192 = load i184, i184* %191
  %193 = trunc i184 %192 to i179
  %194 = zext i1 %184 to i179
  %195 = shl i179 %194, 158
  %196 = and i179 %193, -365375409332725729550921208179070754913983135745
  %.partset13 = or i179 %196, %195
  store i179 %.partset13, i179* %dst_1, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.exit:                               ; preds = %dst.addr.1335.case.1, %dst.addr.1335.case.0, %dst.addr.1233.exit
  %src.addr.1436 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 14
  %197 = bitcast i1* %src.addr.1436 to i8*
  %198 = load i8, i8* %197
  %199 = trunc i8 %198 to i1
  switch i64 %for.loop.idx77, label %dst.addr.1437.exit [
    i64 0, label %dst.addr.1437.case.0
    i64 1, label %dst.addr.1437.case.1
  ]

dst.addr.1437.case.0:                             ; preds = %dst.addr.1335.exit
  %200 = bitcast i179* %dst_0 to i184*
  %201 = load i184, i184* %200
  %202 = trunc i184 %201 to i179
  %203 = zext i1 %199 to i179
  %204 = shl i179 %203, 159
  %205 = and i179 %202, -730750818665451459101842416358141509827966271489
  %.partset53 = or i179 %205, %204
  store i179 %.partset53, i179* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %206 = bitcast i179* %dst_1 to i184*
  %207 = load i184, i184* %206
  %208 = trunc i184 %207 to i179
  %209 = zext i1 %199 to i179
  %210 = shl i179 %209, 159
  %211 = and i179 %208, -730750818665451459101842416358141509827966271489
  %.partset14 = or i179 %211, %210
  store i179 %.partset14, i179* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.exit:                               ; preds = %dst.addr.1437.case.1, %dst.addr.1437.case.0, %dst.addr.1335.exit
  %src.addr.1538 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 15
  %212 = bitcast i1* %src.addr.1538 to i8*
  %213 = load i8, i8* %212
  %214 = trunc i8 %213 to i1
  switch i64 %for.loop.idx77, label %dst.addr.1539.exit [
    i64 0, label %dst.addr.1539.case.0
    i64 1, label %dst.addr.1539.case.1
  ]

dst.addr.1539.case.0:                             ; preds = %dst.addr.1437.exit
  %215 = bitcast i179* %dst_0 to i184*
  %216 = load i184, i184* %215
  %217 = trunc i184 %216 to i179
  %218 = zext i1 %214 to i179
  %219 = shl i179 %218, 160
  %220 = and i179 %217, -1461501637330902918203684832716283019655932542977
  %.partset52 = or i179 %220, %219
  store i179 %.partset52, i179* %dst_0, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %221 = bitcast i179* %dst_1 to i184*
  %222 = load i184, i184* %221
  %223 = trunc i184 %222 to i179
  %224 = zext i1 %214 to i179
  %225 = shl i179 %224, 160
  %226 = and i179 %223, -1461501637330902918203684832716283019655932542977
  %.partset15 = or i179 %226, %225
  store i179 %.partset15, i179* %dst_1, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.exit:                               ; preds = %dst.addr.1539.case.1, %dst.addr.1539.case.0, %dst.addr.1437.exit
  %src.addr.1640 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 16
  %227 = bitcast i1* %src.addr.1640 to i8*
  %228 = load i8, i8* %227
  %229 = trunc i8 %228 to i1
  switch i64 %for.loop.idx77, label %dst.addr.1641.exit [
    i64 0, label %dst.addr.1641.case.0
    i64 1, label %dst.addr.1641.case.1
  ]

dst.addr.1641.case.0:                             ; preds = %dst.addr.1539.exit
  %230 = bitcast i179* %dst_0 to i184*
  %231 = load i184, i184* %230
  %232 = trunc i184 %231 to i179
  %233 = zext i1 %229 to i179
  %234 = shl i179 %233, 161
  %235 = and i179 %232, -2923003274661805836407369665432566039311865085953
  %.partset51 = or i179 %235, %234
  store i179 %.partset51, i179* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %236 = bitcast i179* %dst_1 to i184*
  %237 = load i184, i184* %236
  %238 = trunc i184 %237 to i179
  %239 = zext i1 %229 to i179
  %240 = shl i179 %239, 161
  %241 = and i179 %238, -2923003274661805836407369665432566039311865085953
  %.partset16 = or i179 %241, %240
  store i179 %.partset16, i179* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.exit:                               ; preds = %dst.addr.1641.case.1, %dst.addr.1641.case.0, %dst.addr.1539.exit
  %src.addr.1742 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 17
  %242 = bitcast i1* %src.addr.1742 to i8*
  %243 = load i8, i8* %242
  %244 = trunc i8 %243 to i1
  switch i64 %for.loop.idx77, label %dst.addr.1743.exit [
    i64 0, label %dst.addr.1743.case.0
    i64 1, label %dst.addr.1743.case.1
  ]

dst.addr.1743.case.0:                             ; preds = %dst.addr.1641.exit
  %245 = bitcast i179* %dst_0 to i184*
  %246 = load i184, i184* %245
  %247 = trunc i184 %246 to i179
  %248 = zext i1 %244 to i179
  %249 = shl i179 %248, 162
  %250 = and i179 %247, -5846006549323611672814739330865132078623730171905
  %.partset50 = or i179 %250, %249
  store i179 %.partset50, i179* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %251 = bitcast i179* %dst_1 to i184*
  %252 = load i184, i184* %251
  %253 = trunc i184 %252 to i179
  %254 = zext i1 %244 to i179
  %255 = shl i179 %254, 162
  %256 = and i179 %253, -5846006549323611672814739330865132078623730171905
  %.partset17 = or i179 %256, %255
  store i179 %.partset17, i179* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.exit:                               ; preds = %dst.addr.1743.case.1, %dst.addr.1743.case.0, %dst.addr.1641.exit
  %src.addr.1844 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 18
  %257 = bitcast i1* %src.addr.1844 to i8*
  %258 = load i8, i8* %257
  %259 = trunc i8 %258 to i1
  switch i64 %for.loop.idx77, label %dst.addr.1845.exit [
    i64 0, label %dst.addr.1845.case.0
    i64 1, label %dst.addr.1845.case.1
  ]

dst.addr.1845.case.0:                             ; preds = %dst.addr.1743.exit
  %260 = bitcast i179* %dst_0 to i184*
  %261 = load i184, i184* %260
  %262 = trunc i184 %261 to i179
  %263 = zext i1 %259 to i179
  %264 = shl i179 %263, 163
  %265 = and i179 %262, -11692013098647223345629478661730264157247460343809
  %.partset49 = or i179 %265, %264
  store i179 %.partset49, i179* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %266 = bitcast i179* %dst_1 to i184*
  %267 = load i184, i184* %266
  %268 = trunc i184 %267 to i179
  %269 = zext i1 %259 to i179
  %270 = shl i179 %269, 163
  %271 = and i179 %268, -11692013098647223345629478661730264157247460343809
  %.partset18 = or i179 %271, %270
  store i179 %.partset18, i179* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.exit:                               ; preds = %dst.addr.1845.case.1, %dst.addr.1845.case.0, %dst.addr.1743.exit
  %src.addr.1946 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 19
  %272 = bitcast i1* %src.addr.1946 to i8*
  %273 = load i8, i8* %272
  %274 = trunc i8 %273 to i1
  switch i64 %for.loop.idx77, label %dst.addr.1947.exit [
    i64 0, label %dst.addr.1947.case.0
    i64 1, label %dst.addr.1947.case.1
  ]

dst.addr.1947.case.0:                             ; preds = %dst.addr.1845.exit
  %275 = bitcast i179* %dst_0 to i184*
  %276 = load i184, i184* %275
  %277 = trunc i184 %276 to i179
  %278 = zext i1 %274 to i179
  %279 = shl i179 %278, 164
  %280 = and i179 %277, -23384026197294446691258957323460528314494920687617
  %.partset48 = or i179 %280, %279
  store i179 %.partset48, i179* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %281 = bitcast i179* %dst_1 to i184*
  %282 = load i184, i184* %281
  %283 = trunc i184 %282 to i179
  %284 = zext i1 %274 to i179
  %285 = shl i179 %284, 164
  %286 = and i179 %283, -23384026197294446691258957323460528314494920687617
  %.partset19 = or i179 %286, %285
  store i179 %.partset19, i179* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.exit:                               ; preds = %dst.addr.1947.case.1, %dst.addr.1947.case.0, %dst.addr.1845.exit
  %src.addr.2048 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 20
  %287 = bitcast i1* %src.addr.2048 to i8*
  %288 = load i8, i8* %287
  %289 = trunc i8 %288 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2049.exit [
    i64 0, label %dst.addr.2049.case.0
    i64 1, label %dst.addr.2049.case.1
  ]

dst.addr.2049.case.0:                             ; preds = %dst.addr.1947.exit
  %290 = bitcast i179* %dst_0 to i184*
  %291 = load i184, i184* %290
  %292 = trunc i184 %291 to i179
  %293 = zext i1 %289 to i179
  %294 = shl i179 %293, 165
  %295 = and i179 %292, -46768052394588893382517914646921056628989841375233
  %.partset47 = or i179 %295, %294
  store i179 %.partset47, i179* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %296 = bitcast i179* %dst_1 to i184*
  %297 = load i184, i184* %296
  %298 = trunc i184 %297 to i179
  %299 = zext i1 %289 to i179
  %300 = shl i179 %299, 165
  %301 = and i179 %298, -46768052394588893382517914646921056628989841375233
  %.partset20 = or i179 %301, %300
  store i179 %.partset20, i179* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.exit:                               ; preds = %dst.addr.2049.case.1, %dst.addr.2049.case.0, %dst.addr.1947.exit
  %src.addr.2150 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 21
  %302 = bitcast i1* %src.addr.2150 to i8*
  %303 = load i8, i8* %302
  %304 = trunc i8 %303 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2151.exit [
    i64 0, label %dst.addr.2151.case.0
    i64 1, label %dst.addr.2151.case.1
  ]

dst.addr.2151.case.0:                             ; preds = %dst.addr.2049.exit
  %305 = bitcast i179* %dst_0 to i184*
  %306 = load i184, i184* %305
  %307 = trunc i184 %306 to i179
  %308 = zext i1 %304 to i179
  %309 = shl i179 %308, 166
  %310 = and i179 %307, -93536104789177786765035829293842113257979682750465
  %.partset46 = or i179 %310, %309
  store i179 %.partset46, i179* %dst_0, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.case.1:                             ; preds = %dst.addr.2049.exit
  %311 = bitcast i179* %dst_1 to i184*
  %312 = load i184, i184* %311
  %313 = trunc i184 %312 to i179
  %314 = zext i1 %304 to i179
  %315 = shl i179 %314, 166
  %316 = and i179 %313, -93536104789177786765035829293842113257979682750465
  %.partset21 = or i179 %316, %315
  store i179 %.partset21, i179* %dst_1, align 1
  br label %dst.addr.2151.exit

dst.addr.2151.exit:                               ; preds = %dst.addr.2151.case.1, %dst.addr.2151.case.0, %dst.addr.2049.exit
  %src.addr.2252 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 22
  %317 = bitcast i1* %src.addr.2252 to i8*
  %318 = load i8, i8* %317
  %319 = trunc i8 %318 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2253.exit [
    i64 0, label %dst.addr.2253.case.0
    i64 1, label %dst.addr.2253.case.1
  ]

dst.addr.2253.case.0:                             ; preds = %dst.addr.2151.exit
  %320 = bitcast i179* %dst_0 to i184*
  %321 = load i184, i184* %320
  %322 = trunc i184 %321 to i179
  %323 = zext i1 %319 to i179
  %324 = shl i179 %323, 167
  %325 = and i179 %322, -187072209578355573530071658587684226515959365500929
  %.partset45 = or i179 %325, %324
  store i179 %.partset45, i179* %dst_0, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.case.1:                             ; preds = %dst.addr.2151.exit
  %326 = bitcast i179* %dst_1 to i184*
  %327 = load i184, i184* %326
  %328 = trunc i184 %327 to i179
  %329 = zext i1 %319 to i179
  %330 = shl i179 %329, 167
  %331 = and i179 %328, -187072209578355573530071658587684226515959365500929
  %.partset22 = or i179 %331, %330
  store i179 %.partset22, i179* %dst_1, align 1
  br label %dst.addr.2253.exit

dst.addr.2253.exit:                               ; preds = %dst.addr.2253.case.1, %dst.addr.2253.case.0, %dst.addr.2151.exit
  %src.addr.2354 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 23
  %332 = bitcast i1* %src.addr.2354 to i8*
  %333 = load i8, i8* %332
  %334 = trunc i8 %333 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2355.exit [
    i64 0, label %dst.addr.2355.case.0
    i64 1, label %dst.addr.2355.case.1
  ]

dst.addr.2355.case.0:                             ; preds = %dst.addr.2253.exit
  %335 = bitcast i179* %dst_0 to i184*
  %336 = load i184, i184* %335
  %337 = trunc i184 %336 to i179
  %338 = zext i1 %334 to i179
  %339 = shl i179 %338, 168
  %340 = and i179 %337, -374144419156711147060143317175368453031918731001857
  %.partset44 = or i179 %340, %339
  store i179 %.partset44, i179* %dst_0, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.case.1:                             ; preds = %dst.addr.2253.exit
  %341 = bitcast i179* %dst_1 to i184*
  %342 = load i184, i184* %341
  %343 = trunc i184 %342 to i179
  %344 = zext i1 %334 to i179
  %345 = shl i179 %344, 168
  %346 = and i179 %343, -374144419156711147060143317175368453031918731001857
  %.partset23 = or i179 %346, %345
  store i179 %.partset23, i179* %dst_1, align 1
  br label %dst.addr.2355.exit

dst.addr.2355.exit:                               ; preds = %dst.addr.2355.case.1, %dst.addr.2355.case.0, %dst.addr.2253.exit
  %src.addr.2456 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 24
  %347 = bitcast i1* %src.addr.2456 to i8*
  %348 = load i8, i8* %347
  %349 = trunc i8 %348 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2457.exit [
    i64 0, label %dst.addr.2457.case.0
    i64 1, label %dst.addr.2457.case.1
  ]

dst.addr.2457.case.0:                             ; preds = %dst.addr.2355.exit
  %350 = bitcast i179* %dst_0 to i184*
  %351 = load i184, i184* %350
  %352 = trunc i184 %351 to i179
  %353 = zext i1 %349 to i179
  %354 = shl i179 %353, 169
  %355 = and i179 %352, -748288838313422294120286634350736906063837462003713
  %.partset43 = or i179 %355, %354
  store i179 %.partset43, i179* %dst_0, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.case.1:                             ; preds = %dst.addr.2355.exit
  %356 = bitcast i179* %dst_1 to i184*
  %357 = load i184, i184* %356
  %358 = trunc i184 %357 to i179
  %359 = zext i1 %349 to i179
  %360 = shl i179 %359, 169
  %361 = and i179 %358, -748288838313422294120286634350736906063837462003713
  %.partset24 = or i179 %361, %360
  store i179 %.partset24, i179* %dst_1, align 1
  br label %dst.addr.2457.exit

dst.addr.2457.exit:                               ; preds = %dst.addr.2457.case.1, %dst.addr.2457.case.0, %dst.addr.2355.exit
  %src.addr.2558 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 25
  %362 = bitcast i1* %src.addr.2558 to i8*
  %363 = load i8, i8* %362
  %364 = trunc i8 %363 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2559.exit [
    i64 0, label %dst.addr.2559.case.0
    i64 1, label %dst.addr.2559.case.1
  ]

dst.addr.2559.case.0:                             ; preds = %dst.addr.2457.exit
  %365 = bitcast i179* %dst_0 to i184*
  %366 = load i184, i184* %365
  %367 = trunc i184 %366 to i179
  %368 = zext i1 %364 to i179
  %369 = shl i179 %368, 170
  %370 = and i179 %367, -1496577676626844588240573268701473812127674924007425
  %.partset42 = or i179 %370, %369
  store i179 %.partset42, i179* %dst_0, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.case.1:                             ; preds = %dst.addr.2457.exit
  %371 = bitcast i179* %dst_1 to i184*
  %372 = load i184, i184* %371
  %373 = trunc i184 %372 to i179
  %374 = zext i1 %364 to i179
  %375 = shl i179 %374, 170
  %376 = and i179 %373, -1496577676626844588240573268701473812127674924007425
  %.partset25 = or i179 %376, %375
  store i179 %.partset25, i179* %dst_1, align 1
  br label %dst.addr.2559.exit

dst.addr.2559.exit:                               ; preds = %dst.addr.2559.case.1, %dst.addr.2559.case.0, %dst.addr.2457.exit
  %src.addr.2660 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 26
  %377 = bitcast i1* %src.addr.2660 to i8*
  %378 = load i8, i8* %377
  %379 = trunc i8 %378 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2661.exit [
    i64 0, label %dst.addr.2661.case.0
    i64 1, label %dst.addr.2661.case.1
  ]

dst.addr.2661.case.0:                             ; preds = %dst.addr.2559.exit
  %380 = bitcast i179* %dst_0 to i184*
  %381 = load i184, i184* %380
  %382 = trunc i184 %381 to i179
  %383 = zext i1 %379 to i179
  %384 = shl i179 %383, 171
  %385 = and i179 %382, -2993155353253689176481146537402947624255349848014849
  %.partset41 = or i179 %385, %384
  store i179 %.partset41, i179* %dst_0, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.case.1:                             ; preds = %dst.addr.2559.exit
  %386 = bitcast i179* %dst_1 to i184*
  %387 = load i184, i184* %386
  %388 = trunc i184 %387 to i179
  %389 = zext i1 %379 to i179
  %390 = shl i179 %389, 171
  %391 = and i179 %388, -2993155353253689176481146537402947624255349848014849
  %.partset26 = or i179 %391, %390
  store i179 %.partset26, i179* %dst_1, align 1
  br label %dst.addr.2661.exit

dst.addr.2661.exit:                               ; preds = %dst.addr.2661.case.1, %dst.addr.2661.case.0, %dst.addr.2559.exit
  %src.addr.2762 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 27
  %392 = bitcast i1* %src.addr.2762 to i8*
  %393 = load i8, i8* %392
  %394 = trunc i8 %393 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2763.exit [
    i64 0, label %dst.addr.2763.case.0
    i64 1, label %dst.addr.2763.case.1
  ]

dst.addr.2763.case.0:                             ; preds = %dst.addr.2661.exit
  %395 = bitcast i179* %dst_0 to i184*
  %396 = load i184, i184* %395
  %397 = trunc i184 %396 to i179
  %398 = zext i1 %394 to i179
  %399 = shl i179 %398, 172
  %400 = and i179 %397, -5986310706507378352962293074805895248510699696029697
  %.partset40 = or i179 %400, %399
  store i179 %.partset40, i179* %dst_0, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.case.1:                             ; preds = %dst.addr.2661.exit
  %401 = bitcast i179* %dst_1 to i184*
  %402 = load i184, i184* %401
  %403 = trunc i184 %402 to i179
  %404 = zext i1 %394 to i179
  %405 = shl i179 %404, 172
  %406 = and i179 %403, -5986310706507378352962293074805895248510699696029697
  %.partset27 = or i179 %406, %405
  store i179 %.partset27, i179* %dst_1, align 1
  br label %dst.addr.2763.exit

dst.addr.2763.exit:                               ; preds = %dst.addr.2763.case.1, %dst.addr.2763.case.0, %dst.addr.2661.exit
  %src.addr.2864 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 28
  %407 = bitcast i1* %src.addr.2864 to i8*
  %408 = load i8, i8* %407
  %409 = trunc i8 %408 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2865.exit [
    i64 0, label %dst.addr.2865.case.0
    i64 1, label %dst.addr.2865.case.1
  ]

dst.addr.2865.case.0:                             ; preds = %dst.addr.2763.exit
  %410 = bitcast i179* %dst_0 to i184*
  %411 = load i184, i184* %410
  %412 = trunc i184 %411 to i179
  %413 = zext i1 %409 to i179
  %414 = shl i179 %413, 173
  %415 = and i179 %412, -11972621413014756705924586149611790497021399392059393
  %.partset39 = or i179 %415, %414
  store i179 %.partset39, i179* %dst_0, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.case.1:                             ; preds = %dst.addr.2763.exit
  %416 = bitcast i179* %dst_1 to i184*
  %417 = load i184, i184* %416
  %418 = trunc i184 %417 to i179
  %419 = zext i1 %409 to i179
  %420 = shl i179 %419, 173
  %421 = and i179 %418, -11972621413014756705924586149611790497021399392059393
  %.partset28 = or i179 %421, %420
  store i179 %.partset28, i179* %dst_1, align 1
  br label %dst.addr.2865.exit

dst.addr.2865.exit:                               ; preds = %dst.addr.2865.case.1, %dst.addr.2865.case.0, %dst.addr.2763.exit
  %src.addr.2966 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 29
  %422 = bitcast i1* %src.addr.2966 to i8*
  %423 = load i8, i8* %422
  %424 = trunc i8 %423 to i1
  switch i64 %for.loop.idx77, label %dst.addr.2967.exit [
    i64 0, label %dst.addr.2967.case.0
    i64 1, label %dst.addr.2967.case.1
  ]

dst.addr.2967.case.0:                             ; preds = %dst.addr.2865.exit
  %425 = bitcast i179* %dst_0 to i184*
  %426 = load i184, i184* %425
  %427 = trunc i184 %426 to i179
  %428 = zext i1 %424 to i179
  %429 = shl i179 %428, 174
  %430 = and i179 %427, -23945242826029513411849172299223580994042798784118785
  %.partset38 = or i179 %430, %429
  store i179 %.partset38, i179* %dst_0, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.case.1:                             ; preds = %dst.addr.2865.exit
  %431 = bitcast i179* %dst_1 to i184*
  %432 = load i184, i184* %431
  %433 = trunc i184 %432 to i179
  %434 = zext i1 %424 to i179
  %435 = shl i179 %434, 174
  %436 = and i179 %433, -23945242826029513411849172299223580994042798784118785
  %.partset29 = or i179 %436, %435
  store i179 %.partset29, i179* %dst_1, align 1
  br label %dst.addr.2967.exit

dst.addr.2967.exit:                               ; preds = %dst.addr.2967.case.1, %dst.addr.2967.case.0, %dst.addr.2865.exit
  %src.addr.3068 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 30
  %437 = bitcast i1* %src.addr.3068 to i8*
  %438 = load i8, i8* %437
  %439 = trunc i8 %438 to i1
  switch i64 %for.loop.idx77, label %dst.addr.3069.exit [
    i64 0, label %dst.addr.3069.case.0
    i64 1, label %dst.addr.3069.case.1
  ]

dst.addr.3069.case.0:                             ; preds = %dst.addr.2967.exit
  %440 = bitcast i179* %dst_0 to i184*
  %441 = load i184, i184* %440
  %442 = trunc i184 %441 to i179
  %443 = zext i1 %439 to i179
  %444 = shl i179 %443, 175
  %445 = and i179 %442, -47890485652059026823698344598447161988085597568237569
  %.partset37 = or i179 %445, %444
  store i179 %.partset37, i179* %dst_0, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.case.1:                             ; preds = %dst.addr.2967.exit
  %446 = bitcast i179* %dst_1 to i184*
  %447 = load i184, i184* %446
  %448 = trunc i184 %447 to i179
  %449 = zext i1 %439 to i179
  %450 = shl i179 %449, 175
  %451 = and i179 %448, -47890485652059026823698344598447161988085597568237569
  %.partset30 = or i179 %451, %450
  store i179 %.partset30, i179* %dst_1, align 1
  br label %dst.addr.3069.exit

dst.addr.3069.exit:                               ; preds = %dst.addr.3069.case.1, %dst.addr.3069.case.0, %dst.addr.2967.exit
  %src.addr.3170 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 31
  %452 = bitcast i1* %src.addr.3170 to i8*
  %453 = load i8, i8* %452
  %454 = trunc i8 %453 to i1
  switch i64 %for.loop.idx77, label %dst.addr.3171.exit [
    i64 0, label %dst.addr.3171.case.0
    i64 1, label %dst.addr.3171.case.1
  ]

dst.addr.3171.case.0:                             ; preds = %dst.addr.3069.exit
  %455 = bitcast i179* %dst_0 to i184*
  %456 = load i184, i184* %455
  %457 = trunc i184 %456 to i179
  %458 = zext i1 %454 to i179
  %459 = shl i179 %458, 176
  %460 = and i179 %457, -95780971304118053647396689196894323976171195136475137
  %.partset36 = or i179 %460, %459
  store i179 %.partset36, i179* %dst_0, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.case.1:                             ; preds = %dst.addr.3069.exit
  %461 = bitcast i179* %dst_1 to i184*
  %462 = load i184, i184* %461
  %463 = trunc i184 %462 to i179
  %464 = zext i1 %454 to i179
  %465 = shl i179 %464, 176
  %466 = and i179 %463, -95780971304118053647396689196894323976171195136475137
  %.partset31 = or i179 %466, %465
  store i179 %.partset31, i179* %dst_1, align 1
  br label %dst.addr.3171.exit

dst.addr.3171.exit:                               ; preds = %dst.addr.3171.case.1, %dst.addr.3171.case.0, %dst.addr.3069.exit
  %src.addr.3272 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 32
  %467 = bitcast i1* %src.addr.3272 to i8*
  %468 = load i8, i8* %467
  %469 = trunc i8 %468 to i1
  switch i64 %for.loop.idx77, label %dst.addr.3273.exit [
    i64 0, label %dst.addr.3273.case.0
    i64 1, label %dst.addr.3273.case.1
  ]

dst.addr.3273.case.0:                             ; preds = %dst.addr.3171.exit
  %470 = bitcast i179* %dst_0 to i184*
  %471 = load i184, i184* %470
  %472 = trunc i184 %471 to i179
  %473 = zext i1 %469 to i179
  %474 = shl i179 %473, 177
  %475 = and i179 %472, -191561942608236107294793378393788647952342390272950273
  %.partset35 = or i179 %475, %474
  store i179 %.partset35, i179* %dst_0, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.case.1:                             ; preds = %dst.addr.3171.exit
  %476 = bitcast i179* %dst_1 to i184*
  %477 = load i184, i184* %476
  %478 = trunc i184 %477 to i179
  %479 = zext i1 %469 to i179
  %480 = shl i179 %479, 177
  %481 = and i179 %478, -191561942608236107294793378393788647952342390272950273
  %.partset32 = or i179 %481, %480
  store i179 %.partset32, i179* %dst_1, align 1
  br label %dst.addr.3273.exit

dst.addr.3273.exit:                               ; preds = %dst.addr.3273.case.1, %dst.addr.3273.case.0, %dst.addr.3171.exit
  %src.addr.3374 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 33
  %482 = bitcast i1* %src.addr.3374 to i8*
  %483 = load i8, i8* %482
  %484 = trunc i8 %483 to i1
  switch i64 %for.loop.idx77, label %dst.addr.3375.exit [
    i64 0, label %dst.addr.3375.case.0
    i64 1, label %dst.addr.3375.case.1
  ]

dst.addr.3375.case.0:                             ; preds = %dst.addr.3273.exit
  %485 = bitcast i179* %dst_0 to i184*
  %486 = load i184, i184* %485
  %487 = trunc i184 %486 to i179
  %488 = zext i1 %484 to i179
  %489 = shl i179 %488, 178
  %490 = and i179 %487, 383123885216472214589586756787577295904684780545900543
  %.partset34 = or i179 %490, %489
  store i179 %.partset34, i179* %dst_0, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.case.1:                             ; preds = %dst.addr.3273.exit
  %491 = bitcast i179* %dst_1 to i184*
  %492 = load i184, i184* %491
  %493 = trunc i184 %492 to i179
  %494 = zext i1 %484 to i179
  %495 = shl i179 %494, 178
  %496 = and i179 %493, 383123885216472214589586756787577295904684780545900543
  %.partset33 = or i179 %496, %495
  store i179 %.partset33, i179* %dst_1, align 1
  br label %dst.addr.3375.exit

dst.addr.3375.exit:                               ; preds = %dst.addr.3375.case.1, %dst.addr.3375.case.0, %dst.addr.3273.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx77, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.3375.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a2struct.HeadCtx.2.5(i179* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i179* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, [2 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #2 {
entry:
  %0 = icmp eq i179* %dst_0, null
  %1 = icmp eq [2 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a2struct.HeadCtx.3.4(i179* nonnull %dst_0, i179* %dst_1, [2 x %struct.HeadCtx]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in([2 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="0", i179* noalias align 512 "orig.arg.no"="1" "unpacked"="1.0" %_0, i179* noalias align 512 "orig.arg.no"="1" "unpacked"="1.1" %_1) #3 {
entry:
  call void @onebyonecpy_hls.p0a2struct.HeadCtx.2.5(i179* align 512 %_0, i179* align 512 %_1, [2 x %struct.HeadCtx]* %0)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2struct.HeadCtx.11.12([2 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i179* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i179* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i64 "orig.arg.no"="2" %num) #1 {
entry:
  %0 = icmp eq i179* %src_0, null
  %1 = icmp eq [2 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond76 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond76, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.3374.exit, %for.loop.lr.ph
  %for.loop.idx77 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.3374.exit ]
  %dst.addr.02 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 0
  switch i64 %for.loop.idx77, label %src.addr.01.exit [
    i64 0, label %src.addr.01.case.0
    i64 1, label %src.addr.01.case.1
  ]

src.addr.01.case.0:                               ; preds = %for.loop
  %3 = bitcast i179* %src_0 to i184*
  %4 = load i184, i184* %3
  %5 = trunc i184 %4 to i179
  %_0.partselect = trunc i179 %5 to i32
  br label %src.addr.01.exit

src.addr.01.case.1:                               ; preds = %for.loop
  %6 = bitcast i179* %src_1 to i184*
  %7 = load i184, i184* %6
  %8 = trunc i184 %7 to i179
  %_1.partselect = trunc i179 %8 to i32
  br label %src.addr.01.exit

src.addr.01.exit:                                 ; preds = %src.addr.01.case.1, %src.addr.01.case.0, %for.loop
  %9 = phi i32 [ %_0.partselect, %src.addr.01.case.0 ], [ %_1.partselect, %src.addr.01.case.1 ], [ undef, %for.loop ]
  store i32 %9, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 1
  switch i64 %for.loop.idx77, label %src.addr.110.exit [
    i64 0, label %src.addr.110.case.0
    i64 1, label %src.addr.110.case.1
  ]

src.addr.110.case.0:                              ; preds = %src.addr.01.exit
  %10 = bitcast i179* %src_0 to i184*
  %11 = load i184, i184* %10
  %12 = trunc i184 %11 to i179
  %13 = lshr i179 %12, 32
  %_01.partselect = trunc i179 %13 to i32
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %14 = bitcast i179* %src_1 to i184*
  %15 = load i184, i184* %14
  %16 = trunc i184 %15 to i179
  %17 = lshr i179 %16, 32
  %_12.partselect = trunc i179 %17 to i32
  br label %src.addr.110.exit

src.addr.110.exit:                                ; preds = %src.addr.110.case.1, %src.addr.110.case.0, %src.addr.01.exit
  %18 = phi i32 [ %_01.partselect, %src.addr.110.case.0 ], [ %_12.partselect, %src.addr.110.case.1 ], [ undef, %src.addr.01.exit ]
  store i32 %18, i32* %dst.addr.111, align 4
  %dst.addr.213 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 2
  switch i64 %for.loop.idx77, label %src.addr.212.exit [
    i64 0, label %src.addr.212.case.0
    i64 1, label %src.addr.212.case.1
  ]

src.addr.212.case.0:                              ; preds = %src.addr.110.exit
  %19 = bitcast i179* %src_0 to i184*
  %20 = load i184, i184* %19
  %21 = trunc i184 %20 to i179
  %22 = lshr i179 %21, 64
  %_03.partselect = trunc i179 %22 to i8
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %23 = bitcast i179* %src_1 to i184*
  %24 = load i184, i184* %23
  %25 = trunc i184 %24 to i179
  %26 = lshr i179 %25, 64
  %_14.partselect = trunc i179 %26 to i8
  br label %src.addr.212.exit

src.addr.212.exit:                                ; preds = %src.addr.212.case.1, %src.addr.212.case.0, %src.addr.110.exit
  %27 = phi i8 [ %_03.partselect, %src.addr.212.case.0 ], [ %_14.partselect, %src.addr.212.case.1 ], [ undef, %src.addr.110.exit ]
  store i8 %27, i8* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 3
  switch i64 %for.loop.idx77, label %src.addr.314.exit [
    i64 0, label %src.addr.314.case.0
    i64 1, label %src.addr.314.case.1
  ]

src.addr.314.case.0:                              ; preds = %src.addr.212.exit
  %28 = bitcast i179* %src_0 to i184*
  %29 = load i184, i184* %28
  %30 = trunc i184 %29 to i179
  %31 = lshr i179 %30, 72
  %_05.partselect = trunc i179 %31 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %32 = bitcast i179* %src_1 to i184*
  %33 = load i184, i184* %32
  %34 = trunc i184 %33 to i179
  %35 = lshr i179 %34, 72
  %_16.partselect = trunc i179 %35 to i1
  br label %src.addr.314.exit

src.addr.314.exit:                                ; preds = %src.addr.314.case.1, %src.addr.314.case.0, %src.addr.212.exit
  %36 = phi i1 [ %_05.partselect, %src.addr.314.case.0 ], [ %_16.partselect, %src.addr.314.case.1 ], [ undef, %src.addr.212.exit ]
  store i1 %36, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 4
  switch i64 %for.loop.idx77, label %src.addr.416.exit [
    i64 0, label %src.addr.416.case.0
    i64 1, label %src.addr.416.case.1
  ]

src.addr.416.case.0:                              ; preds = %src.addr.314.exit
  %37 = bitcast i179* %src_0 to i184*
  %38 = load i184, i184* %37
  %39 = trunc i184 %38 to i179
  %40 = lshr i179 %39, 73
  %_07.partselect = trunc i179 %40 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %41 = bitcast i179* %src_1 to i184*
  %42 = load i184, i184* %41
  %43 = trunc i184 %42 to i179
  %44 = lshr i179 %43, 73
  %_18.partselect = trunc i179 %44 to i1
  br label %src.addr.416.exit

src.addr.416.exit:                                ; preds = %src.addr.416.case.1, %src.addr.416.case.0, %src.addr.314.exit
  %45 = phi i1 [ %_07.partselect, %src.addr.416.case.0 ], [ %_18.partselect, %src.addr.416.case.1 ], [ undef, %src.addr.314.exit ]
  store i1 %45, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 5
  switch i64 %for.loop.idx77, label %src.addr.518.exit [
    i64 0, label %src.addr.518.case.0
    i64 1, label %src.addr.518.case.1
  ]

src.addr.518.case.0:                              ; preds = %src.addr.416.exit
  %46 = bitcast i179* %src_0 to i184*
  %47 = load i184, i184* %46
  %48 = trunc i184 %47 to i179
  %49 = lshr i179 %48, 74
  %_09.partselect = trunc i179 %49 to i1
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %50 = bitcast i179* %src_1 to i184*
  %51 = load i184, i184* %50
  %52 = trunc i184 %51 to i179
  %53 = lshr i179 %52, 74
  %_110.partselect = trunc i179 %53 to i1
  br label %src.addr.518.exit

src.addr.518.exit:                                ; preds = %src.addr.518.case.1, %src.addr.518.case.0, %src.addr.416.exit
  %54 = phi i1 [ %_09.partselect, %src.addr.518.case.0 ], [ %_110.partselect, %src.addr.518.case.1 ], [ undef, %src.addr.416.exit ]
  store i1 %54, i1* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 6
  switch i64 %for.loop.idx77, label %src.addr.620.exit [
    i64 0, label %src.addr.620.case.0
    i64 1, label %src.addr.620.case.1
  ]

src.addr.620.case.0:                              ; preds = %src.addr.518.exit
  %55 = bitcast i179* %src_0 to i184*
  %56 = load i184, i184* %55
  %57 = trunc i184 %56 to i179
  %58 = lshr i179 %57, 75
  %_011.partselect = trunc i179 %58 to i8
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %59 = bitcast i179* %src_1 to i184*
  %60 = load i184, i184* %59
  %61 = trunc i184 %60 to i179
  %62 = lshr i179 %61, 75
  %_112.partselect = trunc i179 %62 to i8
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %63 = phi i8 [ %_011.partselect, %src.addr.620.case.0 ], [ %_112.partselect, %src.addr.620.case.1 ], [ undef, %src.addr.518.exit ]
  store i8 %63, i8* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 7
  switch i64 %for.loop.idx77, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %64 = bitcast i179* %src_0 to i184*
  %65 = load i184, i184* %64
  %66 = trunc i184 %65 to i179
  %67 = lshr i179 %66, 83
  %_013.partselect = trunc i179 %67 to i1
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %68 = bitcast i179* %src_1 to i184*
  %69 = load i184, i184* %68
  %70 = trunc i184 %69 to i179
  %71 = lshr i179 %70, 83
  %_114.partselect = trunc i179 %71 to i1
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %72 = phi i1 [ %_013.partselect, %src.addr.722.case.0 ], [ %_114.partselect, %src.addr.722.case.1 ], [ undef, %src.addr.620.exit ]
  store i1 %72, i1* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 8
  switch i64 %for.loop.idx77, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %73 = bitcast i179* %src_0 to i184*
  %74 = load i184, i184* %73
  %75 = trunc i184 %74 to i179
  %76 = lshr i179 %75, 84
  %_015.partselect = trunc i179 %76 to i1
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %77 = bitcast i179* %src_1 to i184*
  %78 = load i184, i184* %77
  %79 = trunc i184 %78 to i179
  %80 = lshr i179 %79, 84
  %_116.partselect = trunc i179 %80 to i1
  br label %src.addr.824.exit

src.addr.824.exit:                                ; preds = %src.addr.824.case.1, %src.addr.824.case.0, %src.addr.722.exit
  %81 = phi i1 [ %_015.partselect, %src.addr.824.case.0 ], [ %_116.partselect, %src.addr.824.case.1 ], [ undef, %src.addr.722.exit ]
  store i1 %81, i1* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 9
  switch i64 %for.loop.idx77, label %src.addr.926.exit [
    i64 0, label %src.addr.926.case.0
    i64 1, label %src.addr.926.case.1
  ]

src.addr.926.case.0:                              ; preds = %src.addr.824.exit
  %82 = bitcast i179* %src_0 to i184*
  %83 = load i184, i184* %82
  %84 = trunc i184 %83 to i179
  %85 = lshr i179 %84, 85
  %_017.partselect = trunc i179 %85 to i8
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %86 = bitcast i179* %src_1 to i184*
  %87 = load i184, i184* %86
  %88 = trunc i184 %87 to i179
  %89 = lshr i179 %88, 85
  %_118.partselect = trunc i179 %89 to i8
  br label %src.addr.926.exit

src.addr.926.exit:                                ; preds = %src.addr.926.case.1, %src.addr.926.case.0, %src.addr.824.exit
  %90 = phi i8 [ %_017.partselect, %src.addr.926.case.0 ], [ %_118.partselect, %src.addr.926.case.1 ], [ undef, %src.addr.824.exit ]
  store i8 %90, i8* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 10
  switch i64 %for.loop.idx77, label %src.addr.1028.exit [
    i64 0, label %src.addr.1028.case.0
    i64 1, label %src.addr.1028.case.1
  ]

src.addr.1028.case.0:                             ; preds = %src.addr.926.exit
  %91 = bitcast i179* %src_0 to i184*
  %92 = load i184, i184* %91
  %93 = trunc i184 %92 to i179
  %94 = lshr i179 %93, 93
  %_019.partselect = trunc i179 %94 to i32
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %95 = bitcast i179* %src_1 to i184*
  %96 = load i184, i184* %95
  %97 = trunc i184 %96 to i179
  %98 = lshr i179 %97, 93
  %_120.partselect = trunc i179 %98 to i32
  br label %src.addr.1028.exit

src.addr.1028.exit:                               ; preds = %src.addr.1028.case.1, %src.addr.1028.case.0, %src.addr.926.exit
  %99 = phi i32 [ %_019.partselect, %src.addr.1028.case.0 ], [ %_120.partselect, %src.addr.1028.case.1 ], [ undef, %src.addr.926.exit ]
  store i32 %99, i32* %dst.addr.1029, align 4
  %dst.addr.1131 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 11
  switch i64 %for.loop.idx77, label %src.addr.1130.exit [
    i64 0, label %src.addr.1130.case.0
    i64 1, label %src.addr.1130.case.1
  ]

src.addr.1130.case.0:                             ; preds = %src.addr.1028.exit
  %100 = bitcast i179* %src_0 to i184*
  %101 = load i184, i184* %100
  %102 = trunc i184 %101 to i179
  %103 = lshr i179 %102, 125
  %_021.partselect = trunc i179 %103 to i32
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %104 = bitcast i179* %src_1 to i184*
  %105 = load i184, i184* %104
  %106 = trunc i184 %105 to i179
  %107 = lshr i179 %106, 125
  %_122.partselect = trunc i179 %107 to i32
  br label %src.addr.1130.exit

src.addr.1130.exit:                               ; preds = %src.addr.1130.case.1, %src.addr.1130.case.0, %src.addr.1028.exit
  %108 = phi i32 [ %_021.partselect, %src.addr.1130.case.0 ], [ %_122.partselect, %src.addr.1130.case.1 ], [ undef, %src.addr.1028.exit ]
  store i32 %108, i32* %dst.addr.1131, align 4
  %dst.addr.1233 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 12
  switch i64 %for.loop.idx77, label %src.addr.1232.exit [
    i64 0, label %src.addr.1232.case.0
    i64 1, label %src.addr.1232.case.1
  ]

src.addr.1232.case.0:                             ; preds = %src.addr.1130.exit
  %109 = bitcast i179* %src_0 to i184*
  %110 = load i184, i184* %109
  %111 = trunc i184 %110 to i179
  %112 = lshr i179 %111, 157
  %_023.partselect = trunc i179 %112 to i1
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %113 = bitcast i179* %src_1 to i184*
  %114 = load i184, i184* %113
  %115 = trunc i184 %114 to i179
  %116 = lshr i179 %115, 157
  %_124.partselect = trunc i179 %116 to i1
  br label %src.addr.1232.exit

src.addr.1232.exit:                               ; preds = %src.addr.1232.case.1, %src.addr.1232.case.0, %src.addr.1130.exit
  %117 = phi i1 [ %_023.partselect, %src.addr.1232.case.0 ], [ %_124.partselect, %src.addr.1232.case.1 ], [ undef, %src.addr.1130.exit ]
  store i1 %117, i1* %dst.addr.1233, align 1
  %dst.addr.1335 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 13
  switch i64 %for.loop.idx77, label %src.addr.1334.exit [
    i64 0, label %src.addr.1334.case.0
    i64 1, label %src.addr.1334.case.1
  ]

src.addr.1334.case.0:                             ; preds = %src.addr.1232.exit
  %118 = bitcast i179* %src_0 to i184*
  %119 = load i184, i184* %118
  %120 = trunc i184 %119 to i179
  %121 = lshr i179 %120, 158
  %_025.partselect = trunc i179 %121 to i1
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %122 = bitcast i179* %src_1 to i184*
  %123 = load i184, i184* %122
  %124 = trunc i184 %123 to i179
  %125 = lshr i179 %124, 158
  %_126.partselect = trunc i179 %125 to i1
  br label %src.addr.1334.exit

src.addr.1334.exit:                               ; preds = %src.addr.1334.case.1, %src.addr.1334.case.0, %src.addr.1232.exit
  %126 = phi i1 [ %_025.partselect, %src.addr.1334.case.0 ], [ %_126.partselect, %src.addr.1334.case.1 ], [ undef, %src.addr.1232.exit ]
  store i1 %126, i1* %dst.addr.1335, align 1
  %dst.addr.1437 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 14
  switch i64 %for.loop.idx77, label %src.addr.1436.exit [
    i64 0, label %src.addr.1436.case.0
    i64 1, label %src.addr.1436.case.1
  ]

src.addr.1436.case.0:                             ; preds = %src.addr.1334.exit
  %127 = bitcast i179* %src_0 to i184*
  %128 = load i184, i184* %127
  %129 = trunc i184 %128 to i179
  %130 = lshr i179 %129, 159
  %_027.partselect = trunc i179 %130 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %131 = bitcast i179* %src_1 to i184*
  %132 = load i184, i184* %131
  %133 = trunc i184 %132 to i179
  %134 = lshr i179 %133, 159
  %_128.partselect = trunc i179 %134 to i1
  br label %src.addr.1436.exit

src.addr.1436.exit:                               ; preds = %src.addr.1436.case.1, %src.addr.1436.case.0, %src.addr.1334.exit
  %135 = phi i1 [ %_027.partselect, %src.addr.1436.case.0 ], [ %_128.partselect, %src.addr.1436.case.1 ], [ undef, %src.addr.1334.exit ]
  store i1 %135, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 15
  switch i64 %for.loop.idx77, label %src.addr.1538.exit [
    i64 0, label %src.addr.1538.case.0
    i64 1, label %src.addr.1538.case.1
  ]

src.addr.1538.case.0:                             ; preds = %src.addr.1436.exit
  %136 = bitcast i179* %src_0 to i184*
  %137 = load i184, i184* %136
  %138 = trunc i184 %137 to i179
  %139 = lshr i179 %138, 160
  %_029.partselect = trunc i179 %139 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %140 = bitcast i179* %src_1 to i184*
  %141 = load i184, i184* %140
  %142 = trunc i184 %141 to i179
  %143 = lshr i179 %142, 160
  %_130.partselect = trunc i179 %143 to i1
  br label %src.addr.1538.exit

src.addr.1538.exit:                               ; preds = %src.addr.1538.case.1, %src.addr.1538.case.0, %src.addr.1436.exit
  %144 = phi i1 [ %_029.partselect, %src.addr.1538.case.0 ], [ %_130.partselect, %src.addr.1538.case.1 ], [ undef, %src.addr.1436.exit ]
  store i1 %144, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 16
  switch i64 %for.loop.idx77, label %src.addr.1640.exit [
    i64 0, label %src.addr.1640.case.0
    i64 1, label %src.addr.1640.case.1
  ]

src.addr.1640.case.0:                             ; preds = %src.addr.1538.exit
  %145 = bitcast i179* %src_0 to i184*
  %146 = load i184, i184* %145
  %147 = trunc i184 %146 to i179
  %148 = lshr i179 %147, 161
  %_031.partselect = trunc i179 %148 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %149 = bitcast i179* %src_1 to i184*
  %150 = load i184, i184* %149
  %151 = trunc i184 %150 to i179
  %152 = lshr i179 %151, 161
  %_132.partselect = trunc i179 %152 to i1
  br label %src.addr.1640.exit

src.addr.1640.exit:                               ; preds = %src.addr.1640.case.1, %src.addr.1640.case.0, %src.addr.1538.exit
  %153 = phi i1 [ %_031.partselect, %src.addr.1640.case.0 ], [ %_132.partselect, %src.addr.1640.case.1 ], [ undef, %src.addr.1538.exit ]
  store i1 %153, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 17
  switch i64 %for.loop.idx77, label %src.addr.1742.exit [
    i64 0, label %src.addr.1742.case.0
    i64 1, label %src.addr.1742.case.1
  ]

src.addr.1742.case.0:                             ; preds = %src.addr.1640.exit
  %154 = bitcast i179* %src_0 to i184*
  %155 = load i184, i184* %154
  %156 = trunc i184 %155 to i179
  %157 = lshr i179 %156, 162
  %_033.partselect = trunc i179 %157 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %158 = bitcast i179* %src_1 to i184*
  %159 = load i184, i184* %158
  %160 = trunc i184 %159 to i179
  %161 = lshr i179 %160, 162
  %_134.partselect = trunc i179 %161 to i1
  br label %src.addr.1742.exit

src.addr.1742.exit:                               ; preds = %src.addr.1742.case.1, %src.addr.1742.case.0, %src.addr.1640.exit
  %162 = phi i1 [ %_033.partselect, %src.addr.1742.case.0 ], [ %_134.partselect, %src.addr.1742.case.1 ], [ undef, %src.addr.1640.exit ]
  store i1 %162, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 18
  switch i64 %for.loop.idx77, label %src.addr.1844.exit [
    i64 0, label %src.addr.1844.case.0
    i64 1, label %src.addr.1844.case.1
  ]

src.addr.1844.case.0:                             ; preds = %src.addr.1742.exit
  %163 = bitcast i179* %src_0 to i184*
  %164 = load i184, i184* %163
  %165 = trunc i184 %164 to i179
  %166 = lshr i179 %165, 163
  %_035.partselect = trunc i179 %166 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %167 = bitcast i179* %src_1 to i184*
  %168 = load i184, i184* %167
  %169 = trunc i184 %168 to i179
  %170 = lshr i179 %169, 163
  %_136.partselect = trunc i179 %170 to i1
  br label %src.addr.1844.exit

src.addr.1844.exit:                               ; preds = %src.addr.1844.case.1, %src.addr.1844.case.0, %src.addr.1742.exit
  %171 = phi i1 [ %_035.partselect, %src.addr.1844.case.0 ], [ %_136.partselect, %src.addr.1844.case.1 ], [ undef, %src.addr.1742.exit ]
  store i1 %171, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 19
  switch i64 %for.loop.idx77, label %src.addr.1946.exit [
    i64 0, label %src.addr.1946.case.0
    i64 1, label %src.addr.1946.case.1
  ]

src.addr.1946.case.0:                             ; preds = %src.addr.1844.exit
  %172 = bitcast i179* %src_0 to i184*
  %173 = load i184, i184* %172
  %174 = trunc i184 %173 to i179
  %175 = lshr i179 %174, 164
  %_037.partselect = trunc i179 %175 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %176 = bitcast i179* %src_1 to i184*
  %177 = load i184, i184* %176
  %178 = trunc i184 %177 to i179
  %179 = lshr i179 %178, 164
  %_138.partselect = trunc i179 %179 to i1
  br label %src.addr.1946.exit

src.addr.1946.exit:                               ; preds = %src.addr.1946.case.1, %src.addr.1946.case.0, %src.addr.1844.exit
  %180 = phi i1 [ %_037.partselect, %src.addr.1946.case.0 ], [ %_138.partselect, %src.addr.1946.case.1 ], [ undef, %src.addr.1844.exit ]
  store i1 %180, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 20
  switch i64 %for.loop.idx77, label %src.addr.2048.exit [
    i64 0, label %src.addr.2048.case.0
    i64 1, label %src.addr.2048.case.1
  ]

src.addr.2048.case.0:                             ; preds = %src.addr.1946.exit
  %181 = bitcast i179* %src_0 to i184*
  %182 = load i184, i184* %181
  %183 = trunc i184 %182 to i179
  %184 = lshr i179 %183, 165
  %_039.partselect = trunc i179 %184 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %185 = bitcast i179* %src_1 to i184*
  %186 = load i184, i184* %185
  %187 = trunc i184 %186 to i179
  %188 = lshr i179 %187, 165
  %_140.partselect = trunc i179 %188 to i1
  br label %src.addr.2048.exit

src.addr.2048.exit:                               ; preds = %src.addr.2048.case.1, %src.addr.2048.case.0, %src.addr.1946.exit
  %189 = phi i1 [ %_039.partselect, %src.addr.2048.case.0 ], [ %_140.partselect, %src.addr.2048.case.1 ], [ undef, %src.addr.1946.exit ]
  store i1 %189, i1* %dst.addr.2049, align 1
  %dst.addr.2151 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 21
  switch i64 %for.loop.idx77, label %src.addr.2150.exit [
    i64 0, label %src.addr.2150.case.0
    i64 1, label %src.addr.2150.case.1
  ]

src.addr.2150.case.0:                             ; preds = %src.addr.2048.exit
  %190 = bitcast i179* %src_0 to i184*
  %191 = load i184, i184* %190
  %192 = trunc i184 %191 to i179
  %193 = lshr i179 %192, 166
  %_041.partselect = trunc i179 %193 to i1
  br label %src.addr.2150.exit

src.addr.2150.case.1:                             ; preds = %src.addr.2048.exit
  %194 = bitcast i179* %src_1 to i184*
  %195 = load i184, i184* %194
  %196 = trunc i184 %195 to i179
  %197 = lshr i179 %196, 166
  %_142.partselect = trunc i179 %197 to i1
  br label %src.addr.2150.exit

src.addr.2150.exit:                               ; preds = %src.addr.2150.case.1, %src.addr.2150.case.0, %src.addr.2048.exit
  %198 = phi i1 [ %_041.partselect, %src.addr.2150.case.0 ], [ %_142.partselect, %src.addr.2150.case.1 ], [ undef, %src.addr.2048.exit ]
  store i1 %198, i1* %dst.addr.2151, align 1
  %dst.addr.2253 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 22
  switch i64 %for.loop.idx77, label %src.addr.2252.exit [
    i64 0, label %src.addr.2252.case.0
    i64 1, label %src.addr.2252.case.1
  ]

src.addr.2252.case.0:                             ; preds = %src.addr.2150.exit
  %199 = bitcast i179* %src_0 to i184*
  %200 = load i184, i184* %199
  %201 = trunc i184 %200 to i179
  %202 = lshr i179 %201, 167
  %_043.partselect = trunc i179 %202 to i1
  br label %src.addr.2252.exit

src.addr.2252.case.1:                             ; preds = %src.addr.2150.exit
  %203 = bitcast i179* %src_1 to i184*
  %204 = load i184, i184* %203
  %205 = trunc i184 %204 to i179
  %206 = lshr i179 %205, 167
  %_144.partselect = trunc i179 %206 to i1
  br label %src.addr.2252.exit

src.addr.2252.exit:                               ; preds = %src.addr.2252.case.1, %src.addr.2252.case.0, %src.addr.2150.exit
  %207 = phi i1 [ %_043.partselect, %src.addr.2252.case.0 ], [ %_144.partselect, %src.addr.2252.case.1 ], [ undef, %src.addr.2150.exit ]
  store i1 %207, i1* %dst.addr.2253, align 1
  %dst.addr.2355 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 23
  switch i64 %for.loop.idx77, label %src.addr.2354.exit [
    i64 0, label %src.addr.2354.case.0
    i64 1, label %src.addr.2354.case.1
  ]

src.addr.2354.case.0:                             ; preds = %src.addr.2252.exit
  %208 = bitcast i179* %src_0 to i184*
  %209 = load i184, i184* %208
  %210 = trunc i184 %209 to i179
  %211 = lshr i179 %210, 168
  %_045.partselect = trunc i179 %211 to i1
  br label %src.addr.2354.exit

src.addr.2354.case.1:                             ; preds = %src.addr.2252.exit
  %212 = bitcast i179* %src_1 to i184*
  %213 = load i184, i184* %212
  %214 = trunc i184 %213 to i179
  %215 = lshr i179 %214, 168
  %_146.partselect = trunc i179 %215 to i1
  br label %src.addr.2354.exit

src.addr.2354.exit:                               ; preds = %src.addr.2354.case.1, %src.addr.2354.case.0, %src.addr.2252.exit
  %216 = phi i1 [ %_045.partselect, %src.addr.2354.case.0 ], [ %_146.partselect, %src.addr.2354.case.1 ], [ undef, %src.addr.2252.exit ]
  store i1 %216, i1* %dst.addr.2355, align 1
  %dst.addr.2457 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 24
  switch i64 %for.loop.idx77, label %src.addr.2456.exit [
    i64 0, label %src.addr.2456.case.0
    i64 1, label %src.addr.2456.case.1
  ]

src.addr.2456.case.0:                             ; preds = %src.addr.2354.exit
  %217 = bitcast i179* %src_0 to i184*
  %218 = load i184, i184* %217
  %219 = trunc i184 %218 to i179
  %220 = lshr i179 %219, 169
  %_047.partselect = trunc i179 %220 to i1
  br label %src.addr.2456.exit

src.addr.2456.case.1:                             ; preds = %src.addr.2354.exit
  %221 = bitcast i179* %src_1 to i184*
  %222 = load i184, i184* %221
  %223 = trunc i184 %222 to i179
  %224 = lshr i179 %223, 169
  %_148.partselect = trunc i179 %224 to i1
  br label %src.addr.2456.exit

src.addr.2456.exit:                               ; preds = %src.addr.2456.case.1, %src.addr.2456.case.0, %src.addr.2354.exit
  %225 = phi i1 [ %_047.partselect, %src.addr.2456.case.0 ], [ %_148.partselect, %src.addr.2456.case.1 ], [ undef, %src.addr.2354.exit ]
  store i1 %225, i1* %dst.addr.2457, align 1
  %dst.addr.2559 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 25
  switch i64 %for.loop.idx77, label %src.addr.2558.exit [
    i64 0, label %src.addr.2558.case.0
    i64 1, label %src.addr.2558.case.1
  ]

src.addr.2558.case.0:                             ; preds = %src.addr.2456.exit
  %226 = bitcast i179* %src_0 to i184*
  %227 = load i184, i184* %226
  %228 = trunc i184 %227 to i179
  %229 = lshr i179 %228, 170
  %_049.partselect = trunc i179 %229 to i1
  br label %src.addr.2558.exit

src.addr.2558.case.1:                             ; preds = %src.addr.2456.exit
  %230 = bitcast i179* %src_1 to i184*
  %231 = load i184, i184* %230
  %232 = trunc i184 %231 to i179
  %233 = lshr i179 %232, 170
  %_150.partselect = trunc i179 %233 to i1
  br label %src.addr.2558.exit

src.addr.2558.exit:                               ; preds = %src.addr.2558.case.1, %src.addr.2558.case.0, %src.addr.2456.exit
  %234 = phi i1 [ %_049.partselect, %src.addr.2558.case.0 ], [ %_150.partselect, %src.addr.2558.case.1 ], [ undef, %src.addr.2456.exit ]
  store i1 %234, i1* %dst.addr.2559, align 1
  %dst.addr.2661 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 26
  switch i64 %for.loop.idx77, label %src.addr.2660.exit [
    i64 0, label %src.addr.2660.case.0
    i64 1, label %src.addr.2660.case.1
  ]

src.addr.2660.case.0:                             ; preds = %src.addr.2558.exit
  %235 = bitcast i179* %src_0 to i184*
  %236 = load i184, i184* %235
  %237 = trunc i184 %236 to i179
  %238 = lshr i179 %237, 171
  %_051.partselect = trunc i179 %238 to i1
  br label %src.addr.2660.exit

src.addr.2660.case.1:                             ; preds = %src.addr.2558.exit
  %239 = bitcast i179* %src_1 to i184*
  %240 = load i184, i184* %239
  %241 = trunc i184 %240 to i179
  %242 = lshr i179 %241, 171
  %_152.partselect = trunc i179 %242 to i1
  br label %src.addr.2660.exit

src.addr.2660.exit:                               ; preds = %src.addr.2660.case.1, %src.addr.2660.case.0, %src.addr.2558.exit
  %243 = phi i1 [ %_051.partselect, %src.addr.2660.case.0 ], [ %_152.partselect, %src.addr.2660.case.1 ], [ undef, %src.addr.2558.exit ]
  store i1 %243, i1* %dst.addr.2661, align 1
  %dst.addr.2763 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 27
  switch i64 %for.loop.idx77, label %src.addr.2762.exit [
    i64 0, label %src.addr.2762.case.0
    i64 1, label %src.addr.2762.case.1
  ]

src.addr.2762.case.0:                             ; preds = %src.addr.2660.exit
  %244 = bitcast i179* %src_0 to i184*
  %245 = load i184, i184* %244
  %246 = trunc i184 %245 to i179
  %247 = lshr i179 %246, 172
  %_053.partselect = trunc i179 %247 to i1
  br label %src.addr.2762.exit

src.addr.2762.case.1:                             ; preds = %src.addr.2660.exit
  %248 = bitcast i179* %src_1 to i184*
  %249 = load i184, i184* %248
  %250 = trunc i184 %249 to i179
  %251 = lshr i179 %250, 172
  %_154.partselect = trunc i179 %251 to i1
  br label %src.addr.2762.exit

src.addr.2762.exit:                               ; preds = %src.addr.2762.case.1, %src.addr.2762.case.0, %src.addr.2660.exit
  %252 = phi i1 [ %_053.partselect, %src.addr.2762.case.0 ], [ %_154.partselect, %src.addr.2762.case.1 ], [ undef, %src.addr.2660.exit ]
  store i1 %252, i1* %dst.addr.2763, align 1
  %dst.addr.2865 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 28
  switch i64 %for.loop.idx77, label %src.addr.2864.exit [
    i64 0, label %src.addr.2864.case.0
    i64 1, label %src.addr.2864.case.1
  ]

src.addr.2864.case.0:                             ; preds = %src.addr.2762.exit
  %253 = bitcast i179* %src_0 to i184*
  %254 = load i184, i184* %253
  %255 = trunc i184 %254 to i179
  %256 = lshr i179 %255, 173
  %_055.partselect = trunc i179 %256 to i1
  br label %src.addr.2864.exit

src.addr.2864.case.1:                             ; preds = %src.addr.2762.exit
  %257 = bitcast i179* %src_1 to i184*
  %258 = load i184, i184* %257
  %259 = trunc i184 %258 to i179
  %260 = lshr i179 %259, 173
  %_156.partselect = trunc i179 %260 to i1
  br label %src.addr.2864.exit

src.addr.2864.exit:                               ; preds = %src.addr.2864.case.1, %src.addr.2864.case.0, %src.addr.2762.exit
  %261 = phi i1 [ %_055.partselect, %src.addr.2864.case.0 ], [ %_156.partselect, %src.addr.2864.case.1 ], [ undef, %src.addr.2762.exit ]
  store i1 %261, i1* %dst.addr.2865, align 1
  %dst.addr.2967 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 29
  switch i64 %for.loop.idx77, label %src.addr.2966.exit [
    i64 0, label %src.addr.2966.case.0
    i64 1, label %src.addr.2966.case.1
  ]

src.addr.2966.case.0:                             ; preds = %src.addr.2864.exit
  %262 = bitcast i179* %src_0 to i184*
  %263 = load i184, i184* %262
  %264 = trunc i184 %263 to i179
  %265 = lshr i179 %264, 174
  %_057.partselect = trunc i179 %265 to i1
  br label %src.addr.2966.exit

src.addr.2966.case.1:                             ; preds = %src.addr.2864.exit
  %266 = bitcast i179* %src_1 to i184*
  %267 = load i184, i184* %266
  %268 = trunc i184 %267 to i179
  %269 = lshr i179 %268, 174
  %_158.partselect = trunc i179 %269 to i1
  br label %src.addr.2966.exit

src.addr.2966.exit:                               ; preds = %src.addr.2966.case.1, %src.addr.2966.case.0, %src.addr.2864.exit
  %270 = phi i1 [ %_057.partselect, %src.addr.2966.case.0 ], [ %_158.partselect, %src.addr.2966.case.1 ], [ undef, %src.addr.2864.exit ]
  store i1 %270, i1* %dst.addr.2967, align 1
  %dst.addr.3069 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 30
  switch i64 %for.loop.idx77, label %src.addr.3068.exit [
    i64 0, label %src.addr.3068.case.0
    i64 1, label %src.addr.3068.case.1
  ]

src.addr.3068.case.0:                             ; preds = %src.addr.2966.exit
  %271 = bitcast i179* %src_0 to i184*
  %272 = load i184, i184* %271
  %273 = trunc i184 %272 to i179
  %274 = lshr i179 %273, 175
  %_059.partselect = trunc i179 %274 to i1
  br label %src.addr.3068.exit

src.addr.3068.case.1:                             ; preds = %src.addr.2966.exit
  %275 = bitcast i179* %src_1 to i184*
  %276 = load i184, i184* %275
  %277 = trunc i184 %276 to i179
  %278 = lshr i179 %277, 175
  %_160.partselect = trunc i179 %278 to i1
  br label %src.addr.3068.exit

src.addr.3068.exit:                               ; preds = %src.addr.3068.case.1, %src.addr.3068.case.0, %src.addr.2966.exit
  %279 = phi i1 [ %_059.partselect, %src.addr.3068.case.0 ], [ %_160.partselect, %src.addr.3068.case.1 ], [ undef, %src.addr.2966.exit ]
  store i1 %279, i1* %dst.addr.3069, align 1
  %dst.addr.3171 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 31
  switch i64 %for.loop.idx77, label %src.addr.3170.exit [
    i64 0, label %src.addr.3170.case.0
    i64 1, label %src.addr.3170.case.1
  ]

src.addr.3170.case.0:                             ; preds = %src.addr.3068.exit
  %280 = bitcast i179* %src_0 to i184*
  %281 = load i184, i184* %280
  %282 = trunc i184 %281 to i179
  %283 = lshr i179 %282, 176
  %_061.partselect = trunc i179 %283 to i1
  br label %src.addr.3170.exit

src.addr.3170.case.1:                             ; preds = %src.addr.3068.exit
  %284 = bitcast i179* %src_1 to i184*
  %285 = load i184, i184* %284
  %286 = trunc i184 %285 to i179
  %287 = lshr i179 %286, 176
  %_162.partselect = trunc i179 %287 to i1
  br label %src.addr.3170.exit

src.addr.3170.exit:                               ; preds = %src.addr.3170.case.1, %src.addr.3170.case.0, %src.addr.3068.exit
  %288 = phi i1 [ %_061.partselect, %src.addr.3170.case.0 ], [ %_162.partselect, %src.addr.3170.case.1 ], [ undef, %src.addr.3068.exit ]
  store i1 %288, i1* %dst.addr.3171, align 1
  %dst.addr.3273 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 32
  switch i64 %for.loop.idx77, label %src.addr.3272.exit [
    i64 0, label %src.addr.3272.case.0
    i64 1, label %src.addr.3272.case.1
  ]

src.addr.3272.case.0:                             ; preds = %src.addr.3170.exit
  %289 = bitcast i179* %src_0 to i184*
  %290 = load i184, i184* %289
  %291 = trunc i184 %290 to i179
  %292 = lshr i179 %291, 177
  %_063.partselect = trunc i179 %292 to i1
  br label %src.addr.3272.exit

src.addr.3272.case.1:                             ; preds = %src.addr.3170.exit
  %293 = bitcast i179* %src_1 to i184*
  %294 = load i184, i184* %293
  %295 = trunc i184 %294 to i179
  %296 = lshr i179 %295, 177
  %_164.partselect = trunc i179 %296 to i1
  br label %src.addr.3272.exit

src.addr.3272.exit:                               ; preds = %src.addr.3272.case.1, %src.addr.3272.case.0, %src.addr.3170.exit
  %297 = phi i1 [ %_063.partselect, %src.addr.3272.case.0 ], [ %_164.partselect, %src.addr.3272.case.1 ], [ undef, %src.addr.3170.exit ]
  store i1 %297, i1* %dst.addr.3273, align 1
  %dst.addr.3375 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 33
  switch i64 %for.loop.idx77, label %src.addr.3374.exit [
    i64 0, label %src.addr.3374.case.0
    i64 1, label %src.addr.3374.case.1
  ]

src.addr.3374.case.0:                             ; preds = %src.addr.3272.exit
  %298 = bitcast i179* %src_0 to i184*
  %299 = load i184, i184* %298
  %300 = trunc i184 %299 to i179
  %301 = lshr i179 %300, 178
  %_065.partselect = trunc i179 %301 to i1
  br label %src.addr.3374.exit

src.addr.3374.case.1:                             ; preds = %src.addr.3272.exit
  %302 = bitcast i179* %src_1 to i184*
  %303 = load i184, i184* %302
  %304 = trunc i184 %303 to i179
  %305 = lshr i179 %304, 178
  %_166.partselect = trunc i179 %305 to i1
  br label %src.addr.3374.exit

src.addr.3374.exit:                               ; preds = %src.addr.3374.case.1, %src.addr.3374.case.0, %src.addr.3272.exit
  %306 = phi i1 [ %_065.partselect, %src.addr.3374.case.0 ], [ %_166.partselect, %src.addr.3374.case.1 ], [ undef, %src.addr.3272.exit ]
  store i1 %306, i1* %dst.addr.3375, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx77, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.3374.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a2struct.HeadCtx.10.13([2 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i179* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i179* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1) #2 {
entry:
  %0 = icmp eq [2 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i179* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a2struct.HeadCtx.11.12([2 x %struct.HeadCtx]* nonnull %dst, i179* nonnull %src_0, i179* %src_1, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out([2 x %struct.HeadCtx]* noalias "orig.arg.no"="0", i179* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %_0, i179* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %_1) #4 {
entry:
  call void @onebyonecpy_hls.p0a2struct.HeadCtx.10.13([2 x %struct.HeadCtx]* %0, i179* align 512 %_0, i179* align 512 %_1)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare i1 @apatb_drive_group_head_phase_hw(i179*, i179*, i32, i32, i1)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back([2 x %struct.HeadCtx]* noalias "orig.arg.no"="0", i179* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %_0, i179* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %_1) #4 {
entry:
  call void @onebyonecpy_hls.p0a2struct.HeadCtx.10.13([2 x %struct.HeadCtx]* %0, i179* align 512 %_0, i179* align 512 %_1)
  ret void
}

declare i1 @drive_group_head_phase_hw_stub([2 x %struct.HeadCtx]* noalias nonnull, i32, i32, i1 zeroext)

define i1 @drive_group_head_phase_hw_stub_wrapper(i179*, i179*, i32, i32, i1) #5 {
entry:
  %5 = call i8* @malloc(i64 96)
  %6 = bitcast i8* %5 to [2 x %struct.HeadCtx]*
  call void @copy_out([2 x %struct.HeadCtx]* %6, i179* %0, i179* %1)
  %7 = call i1 @drive_group_head_phase_hw_stub([2 x %struct.HeadCtx]* %6, i32 %2, i32 %3, i1 %4)
  call void @copy_in([2 x %struct.HeadCtx]* %6, i179* %0, i179* %1)
  call void @free(i8* %5)
  ret i1 %7
}

attributes #0 = { inaccessiblemem_or_argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
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
!7 = !{!"0", [2 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12}
!11 = !{!"0.0", %struct.HeadCtx* null}
!12 = !{!"0.1", %struct.HeadCtx* null}
