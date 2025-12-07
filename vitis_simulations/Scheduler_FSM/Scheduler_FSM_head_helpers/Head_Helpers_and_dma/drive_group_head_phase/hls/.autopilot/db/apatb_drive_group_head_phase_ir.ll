; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_head_helpers/Head_Helpers_and_dma/drive_group_head_phase/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i32, i8, i1, i1, i1, i8, i1, i1, i8, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }

; Function Attrs: inaccessiblemem_or_argmemonly noinline willreturn
define i1 @apatb_drive_group_head_phase_ir([1 x %struct.HeadCtx]* noalias nonnull dereferenceable(48) "partition" %head_ctx_ref, i32 %base_head_idx, i32 %layer_idx, i1 zeroext %start) local_unnamed_addr #0 {
entry:
  %head_ctx_ref_copy1 = alloca i179, align 512
  call void @copy_in([1 x %struct.HeadCtx]* nonnull %head_ctx_ref, i179* nonnull align 512 %head_ctx_ref_copy1)
  %0 = call i1 @apatb_drive_group_head_phase_hw(i179* %head_ctx_ref_copy1, i32 %base_head_idx, i32 %layer_idx, i1 %start)
  call void @copy_back([1 x %struct.HeadCtx]* %head_ctx_ref, i179* %head_ctx_ref_copy1)
  ret i1 %0
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a1struct.HeadCtx([1 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, [1 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #1 {
entry:
  %0 = icmp eq [1 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [1 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond76 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond76, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx77 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 0
  %dst.addr.02 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 1
  %dst.addr.111 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 1
  %4 = load i32, i32* %src.addr.110, align 4
  store i32 %4, i32* %dst.addr.111, align 4
  %src.addr.212 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 2
  %dst.addr.213 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 2
  %5 = load i8, i8* %src.addr.212, align 1
  store i8 %5, i8* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 3
  %dst.addr.315 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 3
  %6 = bitcast i1* %src.addr.314 to i8*
  %7 = load i8, i8* %6
  %8 = trunc i8 %7 to i1
  store i1 %8, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 4
  %dst.addr.417 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 4
  %9 = bitcast i1* %src.addr.416 to i8*
  %10 = load i8, i8* %9
  %11 = trunc i8 %10 to i1
  store i1 %11, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 5
  %dst.addr.519 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 5
  %12 = bitcast i1* %src.addr.518 to i8*
  %13 = load i8, i8* %12
  %14 = trunc i8 %13 to i1
  store i1 %14, i1* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 6
  %dst.addr.621 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 6
  %15 = load i8, i8* %src.addr.620, align 1
  store i8 %15, i8* %dst.addr.621, align 1
  %src.addr.722 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 7
  %dst.addr.723 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 7
  %16 = bitcast i1* %src.addr.722 to i8*
  %17 = load i8, i8* %16
  %18 = trunc i8 %17 to i1
  store i1 %18, i1* %dst.addr.723, align 1
  %src.addr.824 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 8
  %dst.addr.825 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 8
  %19 = bitcast i1* %src.addr.824 to i8*
  %20 = load i8, i8* %19
  %21 = trunc i8 %20 to i1
  store i1 %21, i1* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 9
  %dst.addr.927 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 9
  %22 = load i8, i8* %src.addr.926, align 1
  store i8 %22, i8* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 10
  %dst.addr.1029 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 10
  %23 = load i32, i32* %src.addr.1028, align 4
  store i32 %23, i32* %dst.addr.1029, align 4
  %src.addr.1130 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 11
  %dst.addr.1131 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 11
  %24 = load i32, i32* %src.addr.1130, align 4
  store i32 %24, i32* %dst.addr.1131, align 4
  %src.addr.1232 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 12
  %dst.addr.1233 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 12
  %25 = bitcast i1* %src.addr.1232 to i8*
  %26 = load i8, i8* %25
  %27 = trunc i8 %26 to i1
  store i1 %27, i1* %dst.addr.1233, align 1
  %src.addr.1334 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 13
  %dst.addr.1335 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 13
  %28 = bitcast i1* %src.addr.1334 to i8*
  %29 = load i8, i8* %28
  %30 = trunc i8 %29 to i1
  store i1 %30, i1* %dst.addr.1335, align 1
  %src.addr.1436 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 14
  %dst.addr.1437 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 14
  %31 = bitcast i1* %src.addr.1436 to i8*
  %32 = load i8, i8* %31
  %33 = trunc i8 %32 to i1
  store i1 %33, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 15
  %dst.addr.1539 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 15
  %34 = bitcast i1* %src.addr.1538 to i8*
  %35 = load i8, i8* %34
  %36 = trunc i8 %35 to i1
  store i1 %36, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 16
  %dst.addr.1641 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 16
  %37 = bitcast i1* %src.addr.1640 to i8*
  %38 = load i8, i8* %37
  %39 = trunc i8 %38 to i1
  store i1 %39, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 17
  %dst.addr.1743 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 17
  %40 = bitcast i1* %src.addr.1742 to i8*
  %41 = load i8, i8* %40
  %42 = trunc i8 %41 to i1
  store i1 %42, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 18
  %dst.addr.1845 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 18
  %43 = bitcast i1* %src.addr.1844 to i8*
  %44 = load i8, i8* %43
  %45 = trunc i8 %44 to i1
  store i1 %45, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 19
  %dst.addr.1947 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 19
  %46 = bitcast i1* %src.addr.1946 to i8*
  %47 = load i8, i8* %46
  %48 = trunc i8 %47 to i1
  store i1 %48, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 20
  %dst.addr.2049 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 20
  %49 = bitcast i1* %src.addr.2048 to i8*
  %50 = load i8, i8* %49
  %51 = trunc i8 %50 to i1
  store i1 %51, i1* %dst.addr.2049, align 1
  %src.addr.2150 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 21
  %dst.addr.2151 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 21
  %52 = bitcast i1* %src.addr.2150 to i8*
  %53 = load i8, i8* %52
  %54 = trunc i8 %53 to i1
  store i1 %54, i1* %dst.addr.2151, align 1
  %src.addr.2252 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 22
  %dst.addr.2253 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 22
  %55 = bitcast i1* %src.addr.2252 to i8*
  %56 = load i8, i8* %55
  %57 = trunc i8 %56 to i1
  store i1 %57, i1* %dst.addr.2253, align 1
  %src.addr.2354 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 23
  %dst.addr.2355 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 23
  %58 = bitcast i1* %src.addr.2354 to i8*
  %59 = load i8, i8* %58
  %60 = trunc i8 %59 to i1
  store i1 %60, i1* %dst.addr.2355, align 1
  %src.addr.2456 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 24
  %dst.addr.2457 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 24
  %61 = bitcast i1* %src.addr.2456 to i8*
  %62 = load i8, i8* %61
  %63 = trunc i8 %62 to i1
  store i1 %63, i1* %dst.addr.2457, align 1
  %src.addr.2558 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 25
  %dst.addr.2559 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 25
  %64 = bitcast i1* %src.addr.2558 to i8*
  %65 = load i8, i8* %64
  %66 = trunc i8 %65 to i1
  store i1 %66, i1* %dst.addr.2559, align 1
  %src.addr.2660 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 26
  %dst.addr.2661 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 26
  %67 = bitcast i1* %src.addr.2660 to i8*
  %68 = load i8, i8* %67
  %69 = trunc i8 %68 to i1
  store i1 %69, i1* %dst.addr.2661, align 1
  %src.addr.2762 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 27
  %dst.addr.2763 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 27
  %70 = bitcast i1* %src.addr.2762 to i8*
  %71 = load i8, i8* %70
  %72 = trunc i8 %71 to i1
  store i1 %72, i1* %dst.addr.2763, align 1
  %src.addr.2864 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 28
  %dst.addr.2865 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 28
  %73 = bitcast i1* %src.addr.2864 to i8*
  %74 = load i8, i8* %73
  %75 = trunc i8 %74 to i1
  store i1 %75, i1* %dst.addr.2865, align 1
  %src.addr.2966 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 29
  %dst.addr.2967 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 29
  %76 = bitcast i1* %src.addr.2966 to i8*
  %77 = load i8, i8* %76
  %78 = trunc i8 %77 to i1
  store i1 %78, i1* %dst.addr.2967, align 1
  %src.addr.3068 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 30
  %dst.addr.3069 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 30
  %79 = bitcast i1* %src.addr.3068 to i8*
  %80 = load i8, i8* %79
  %81 = trunc i8 %80 to i1
  store i1 %81, i1* %dst.addr.3069, align 1
  %src.addr.3170 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 31
  %dst.addr.3171 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 31
  %82 = bitcast i1* %src.addr.3170 to i8*
  %83 = load i8, i8* %82
  %84 = trunc i8 %83 to i1
  store i1 %84, i1* %dst.addr.3171, align 1
  %src.addr.3272 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 32
  %dst.addr.3273 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 32
  %85 = bitcast i1* %src.addr.3272 to i8*
  %86 = load i8, i8* %85
  %87 = trunc i8 %86 to i1
  store i1 %87, i1* %dst.addr.3273, align 1
  %src.addr.3374 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 33
  %dst.addr.3375 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 33
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
define void @arraycpy_hls.p0a1struct.HeadCtx.3.4(i179* "orig.arg.no"="0" "unpacked"="0" %dst, [1 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #1 {
entry:
  %0 = icmp eq [1 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i179* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond76 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond76, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx77 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  %4 = bitcast i179* %dst to i184*
  %5 = load i184, i184* %4
  %6 = trunc i184 %5 to i179
  %7 = zext i32 %3 to i179
  %8 = and i179 %6, -4294967296
  %.partset = or i179 %8, %7
  store i179 %.partset, i179* %dst, align 4
  %src.addr.110 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 1
  %9 = load i32, i32* %src.addr.110, align 4
  %10 = zext i32 %9 to i179
  %11 = shl i179 %10, 32
  %12 = and i179 %.partset, -18446744069414584321
  %.partset1 = or i179 %12, %11
  store i179 %.partset1, i179* %dst, align 4
  %src.addr.212 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 2
  %13 = load i8, i8* %src.addr.212, align 1
  %14 = zext i8 %13 to i179
  %15 = shl i179 %14, 64
  %16 = and i179 %.partset1, -4703919738795935662081
  %.partset2 = or i179 %16, %15
  store i179 %.partset2, i179* %dst, align 1
  %src.addr.314 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 3
  %17 = bitcast i1* %src.addr.314 to i8*
  %18 = load i8, i8* %17
  %19 = trunc i8 %18 to i1
  %20 = zext i1 %19 to i179
  %21 = shl i179 %20, 72
  %22 = and i179 %.partset2, -4722366482869645213697
  %.partset3 = or i179 %22, %21
  store i179 %.partset3, i179* %dst, align 1
  %src.addr.416 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 4
  %23 = bitcast i1* %src.addr.416 to i8*
  %24 = load i8, i8* %23
  %25 = trunc i8 %24 to i1
  %26 = zext i1 %25 to i179
  %27 = shl i179 %26, 73
  %28 = and i179 %.partset3, -9444732965739290427393
  %.partset4 = or i179 %28, %27
  store i179 %.partset4, i179* %dst, align 1
  %src.addr.518 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 5
  %29 = bitcast i1* %src.addr.518 to i8*
  %30 = load i8, i8* %29
  %31 = trunc i8 %30 to i1
  %32 = zext i1 %31 to i179
  %33 = shl i179 %32, 74
  %34 = and i179 %.partset4, -18889465931478580854785
  %.partset5 = or i179 %34, %33
  store i179 %.partset5, i179* %dst, align 1
  %src.addr.620 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 6
  %35 = load i8, i8* %src.addr.620, align 1
  %36 = zext i8 %35 to i179
  %37 = shl i179 %36, 75
  %38 = and i179 %.partset5, -9633627625054076235939841
  %.partset6 = or i179 %38, %37
  store i179 %.partset6, i179* %dst, align 1
  %src.addr.722 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 7
  %39 = bitcast i1* %src.addr.722 to i8*
  %40 = load i8, i8* %39
  %41 = trunc i8 %40 to i1
  %42 = zext i1 %41 to i179
  %43 = shl i179 %42, 83
  %44 = and i179 %.partset6, -9671406556917033397649409
  %.partset7 = or i179 %44, %43
  store i179 %.partset7, i179* %dst, align 1
  %src.addr.824 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 8
  %45 = bitcast i1* %src.addr.824 to i8*
  %46 = load i8, i8* %45
  %47 = trunc i8 %46 to i1
  %48 = zext i1 %47 to i179
  %49 = shl i179 %48, 84
  %50 = and i179 %.partset7, -19342813113834066795298817
  %.partset8 = or i179 %50, %49
  store i179 %.partset8, i179* %dst, align 1
  %src.addr.926 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 9
  %51 = load i8, i8* %src.addr.926, align 1
  %52 = zext i8 %51 to i179
  %53 = shl i179 %52, 85
  %54 = and i179 %.partset8, -9864834688055374065602396161
  %.partset9 = or i179 %54, %53
  store i179 %.partset9, i179* %dst, align 1
  %src.addr.1028 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 10
  %55 = load i32, i32* %src.addr.1028, align 4
  %56 = zext i32 %55 to i179
  %57 = shl i179 %56, 93
  %58 = and i179 %.partset9, -42535295855213787618638783729778032641
  %.partset10 = or i179 %58, %57
  store i179 %.partset10, i179* %dst, align 4
  %src.addr.1130 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 11
  %59 = load i32, i32* %src.addr.1130, align 4
  %60 = zext i32 %59 to i179
  %61 = shl i179 %60, 125
  %62 = and i179 %.partset10, -182687704623827568910343296156613551528020541441
  %.partset11 = or i179 %62, %61
  store i179 %.partset11, i179* %dst, align 4
  %src.addr.1232 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 12
  %63 = bitcast i1* %src.addr.1232 to i8*
  %64 = load i8, i8* %63
  %65 = trunc i8 %64 to i1
  %66 = zext i1 %65 to i179
  %67 = shl i179 %66, 157
  %68 = and i179 %.partset11, -182687704666362864775460604089535377456991567873
  %.partset12 = or i179 %68, %67
  store i179 %.partset12, i179* %dst, align 1
  %src.addr.1334 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 13
  %69 = bitcast i1* %src.addr.1334 to i8*
  %70 = load i8, i8* %69
  %71 = trunc i8 %70 to i1
  %72 = zext i1 %71 to i179
  %73 = shl i179 %72, 158
  %74 = and i179 %.partset12, -365375409332725729550921208179070754913983135745
  %.partset13 = or i179 %74, %73
  store i179 %.partset13, i179* %dst, align 1
  %src.addr.1436 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 14
  %75 = bitcast i1* %src.addr.1436 to i8*
  %76 = load i8, i8* %75
  %77 = trunc i8 %76 to i1
  %78 = zext i1 %77 to i179
  %79 = shl i179 %78, 159
  %80 = and i179 %.partset13, -730750818665451459101842416358141509827966271489
  %.partset14 = or i179 %80, %79
  store i179 %.partset14, i179* %dst, align 1
  %src.addr.1538 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 15
  %81 = bitcast i1* %src.addr.1538 to i8*
  %82 = load i8, i8* %81
  %83 = trunc i8 %82 to i1
  %84 = zext i1 %83 to i179
  %85 = shl i179 %84, 160
  %86 = and i179 %.partset14, -1461501637330902918203684832716283019655932542977
  %.partset15 = or i179 %86, %85
  store i179 %.partset15, i179* %dst, align 1
  %src.addr.1640 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 16
  %87 = bitcast i1* %src.addr.1640 to i8*
  %88 = load i8, i8* %87
  %89 = trunc i8 %88 to i1
  %90 = zext i1 %89 to i179
  %91 = shl i179 %90, 161
  %92 = and i179 %.partset15, -2923003274661805836407369665432566039311865085953
  %.partset16 = or i179 %92, %91
  store i179 %.partset16, i179* %dst, align 1
  %src.addr.1742 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 17
  %93 = bitcast i1* %src.addr.1742 to i8*
  %94 = load i8, i8* %93
  %95 = trunc i8 %94 to i1
  %96 = zext i1 %95 to i179
  %97 = shl i179 %96, 162
  %98 = and i179 %.partset16, -5846006549323611672814739330865132078623730171905
  %.partset17 = or i179 %98, %97
  store i179 %.partset17, i179* %dst, align 1
  %src.addr.1844 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 18
  %99 = bitcast i1* %src.addr.1844 to i8*
  %100 = load i8, i8* %99
  %101 = trunc i8 %100 to i1
  %102 = zext i1 %101 to i179
  %103 = shl i179 %102, 163
  %104 = and i179 %.partset17, -11692013098647223345629478661730264157247460343809
  %.partset18 = or i179 %104, %103
  store i179 %.partset18, i179* %dst, align 1
  %src.addr.1946 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 19
  %105 = bitcast i1* %src.addr.1946 to i8*
  %106 = load i8, i8* %105
  %107 = trunc i8 %106 to i1
  %108 = zext i1 %107 to i179
  %109 = shl i179 %108, 164
  %110 = and i179 %.partset18, -23384026197294446691258957323460528314494920687617
  %.partset19 = or i179 %110, %109
  store i179 %.partset19, i179* %dst, align 1
  %src.addr.2048 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 20
  %111 = bitcast i1* %src.addr.2048 to i8*
  %112 = load i8, i8* %111
  %113 = trunc i8 %112 to i1
  %114 = zext i1 %113 to i179
  %115 = shl i179 %114, 165
  %116 = and i179 %.partset19, -46768052394588893382517914646921056628989841375233
  %.partset20 = or i179 %116, %115
  store i179 %.partset20, i179* %dst, align 1
  %src.addr.2150 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 21
  %117 = bitcast i1* %src.addr.2150 to i8*
  %118 = load i8, i8* %117
  %119 = trunc i8 %118 to i1
  %120 = zext i1 %119 to i179
  %121 = shl i179 %120, 166
  %122 = and i179 %.partset20, -93536104789177786765035829293842113257979682750465
  %.partset21 = or i179 %122, %121
  store i179 %.partset21, i179* %dst, align 1
  %src.addr.2252 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 22
  %123 = bitcast i1* %src.addr.2252 to i8*
  %124 = load i8, i8* %123
  %125 = trunc i8 %124 to i1
  %126 = zext i1 %125 to i179
  %127 = shl i179 %126, 167
  %128 = and i179 %.partset21, -187072209578355573530071658587684226515959365500929
  %.partset22 = or i179 %128, %127
  store i179 %.partset22, i179* %dst, align 1
  %src.addr.2354 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 23
  %129 = bitcast i1* %src.addr.2354 to i8*
  %130 = load i8, i8* %129
  %131 = trunc i8 %130 to i1
  %132 = zext i1 %131 to i179
  %133 = shl i179 %132, 168
  %134 = and i179 %.partset22, -374144419156711147060143317175368453031918731001857
  %.partset23 = or i179 %134, %133
  store i179 %.partset23, i179* %dst, align 1
  %src.addr.2456 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 24
  %135 = bitcast i1* %src.addr.2456 to i8*
  %136 = load i8, i8* %135
  %137 = trunc i8 %136 to i1
  %138 = zext i1 %137 to i179
  %139 = shl i179 %138, 169
  %140 = and i179 %.partset23, -748288838313422294120286634350736906063837462003713
  %.partset24 = or i179 %140, %139
  store i179 %.partset24, i179* %dst, align 1
  %src.addr.2558 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 25
  %141 = bitcast i1* %src.addr.2558 to i8*
  %142 = load i8, i8* %141
  %143 = trunc i8 %142 to i1
  %144 = zext i1 %143 to i179
  %145 = shl i179 %144, 170
  %146 = and i179 %.partset24, -1496577676626844588240573268701473812127674924007425
  %.partset25 = or i179 %146, %145
  store i179 %.partset25, i179* %dst, align 1
  %src.addr.2660 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 26
  %147 = bitcast i1* %src.addr.2660 to i8*
  %148 = load i8, i8* %147
  %149 = trunc i8 %148 to i1
  %150 = zext i1 %149 to i179
  %151 = shl i179 %150, 171
  %152 = and i179 %.partset25, -2993155353253689176481146537402947624255349848014849
  %.partset26 = or i179 %152, %151
  store i179 %.partset26, i179* %dst, align 1
  %src.addr.2762 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 27
  %153 = bitcast i1* %src.addr.2762 to i8*
  %154 = load i8, i8* %153
  %155 = trunc i8 %154 to i1
  %156 = zext i1 %155 to i179
  %157 = shl i179 %156, 172
  %158 = and i179 %.partset26, -5986310706507378352962293074805895248510699696029697
  %.partset27 = or i179 %158, %157
  store i179 %.partset27, i179* %dst, align 1
  %src.addr.2864 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 28
  %159 = bitcast i1* %src.addr.2864 to i8*
  %160 = load i8, i8* %159
  %161 = trunc i8 %160 to i1
  %162 = zext i1 %161 to i179
  %163 = shl i179 %162, 173
  %164 = and i179 %.partset27, -11972621413014756705924586149611790497021399392059393
  %.partset28 = or i179 %164, %163
  store i179 %.partset28, i179* %dst, align 1
  %src.addr.2966 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 29
  %165 = bitcast i1* %src.addr.2966 to i8*
  %166 = load i8, i8* %165
  %167 = trunc i8 %166 to i1
  %168 = zext i1 %167 to i179
  %169 = shl i179 %168, 174
  %170 = and i179 %.partset28, -23945242826029513411849172299223580994042798784118785
  %.partset29 = or i179 %170, %169
  store i179 %.partset29, i179* %dst, align 1
  %src.addr.3068 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 30
  %171 = bitcast i1* %src.addr.3068 to i8*
  %172 = load i8, i8* %171
  %173 = trunc i8 %172 to i1
  %174 = zext i1 %173 to i179
  %175 = shl i179 %174, 175
  %176 = and i179 %.partset29, -47890485652059026823698344598447161988085597568237569
  %.partset30 = or i179 %176, %175
  store i179 %.partset30, i179* %dst, align 1
  %src.addr.3170 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 31
  %177 = bitcast i1* %src.addr.3170 to i8*
  %178 = load i8, i8* %177
  %179 = trunc i8 %178 to i1
  %180 = zext i1 %179 to i179
  %181 = shl i179 %180, 176
  %182 = and i179 %.partset30, -95780971304118053647396689196894323976171195136475137
  %.partset31 = or i179 %182, %181
  store i179 %.partset31, i179* %dst, align 1
  %src.addr.3272 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 32
  %183 = bitcast i1* %src.addr.3272 to i8*
  %184 = load i8, i8* %183
  %185 = trunc i8 %184 to i1
  %186 = zext i1 %185 to i179
  %187 = shl i179 %186, 177
  %188 = and i179 %.partset31, -191561942608236107294793378393788647952342390272950273
  %.partset32 = or i179 %188, %187
  store i179 %.partset32, i179* %dst, align 1
  %src.addr.3374 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx77, i32 33
  %189 = bitcast i1* %src.addr.3374 to i8*
  %190 = load i8, i8* %189
  %191 = trunc i8 %190 to i1
  %192 = zext i1 %191 to i179
  %193 = shl i179 %192, 178
  %194 = and i179 %.partset32, 383123885216472214589586756787577295904684780545900543
  %.partset33 = or i179 %194, %193
  store i179 %.partset33, i179* %dst, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx77, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a1struct.HeadCtx.2.5(i179* noalias align 512 "orig.arg.no"="0" "unpacked"="0" %dst, [1 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #2 {
entry:
  %0 = icmp eq i179* %dst, null
  %1 = icmp eq [1 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a1struct.HeadCtx.3.4(i179* nonnull %dst, [1 x %struct.HeadCtx]* nonnull %src, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in([1 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="0", i179* noalias align 512 "orig.arg.no"="1" "unpacked"="1") #3 {
entry:
  call void @onebyonecpy_hls.p0a1struct.HeadCtx.2.5(i179* align 512 %1, [1 x %struct.HeadCtx]* %0)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a1struct.HeadCtx.11.12([1 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i179* readonly "orig.arg.no"="1" "unpacked"="1" %src, i64 "orig.arg.no"="2" %num) #1 {
entry:
  %0 = icmp eq i179* %src, null
  %1 = icmp eq [1 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond76 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond76, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx77 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr.02 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 0
  %3 = bitcast i179* %src to i184*
  %4 = load i184, i184* %3
  %5 = trunc i184 %4 to i179
  %.partselect = trunc i179 %5 to i32
  store i32 %.partselect, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 1
  %6 = bitcast i179* %src to i184*
  %7 = load i184, i184* %6
  %8 = trunc i184 %7 to i179
  %9 = lshr i179 %8, 32
  %.partselect1 = trunc i179 %9 to i32
  store i32 %.partselect1, i32* %dst.addr.111, align 4
  %dst.addr.213 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 2
  %10 = bitcast i179* %src to i184*
  %11 = load i184, i184* %10
  %12 = trunc i184 %11 to i179
  %13 = lshr i179 %12, 64
  %.partselect2 = trunc i179 %13 to i8
  store i8 %.partselect2, i8* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 3
  %14 = bitcast i179* %src to i184*
  %15 = load i184, i184* %14
  %16 = trunc i184 %15 to i179
  %17 = lshr i179 %16, 72
  %.partselect3 = trunc i179 %17 to i1
  store i1 %.partselect3, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 4
  %18 = bitcast i179* %src to i184*
  %19 = load i184, i184* %18
  %20 = trunc i184 %19 to i179
  %21 = lshr i179 %20, 73
  %.partselect4 = trunc i179 %21 to i1
  store i1 %.partselect4, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 5
  %22 = bitcast i179* %src to i184*
  %23 = load i184, i184* %22
  %24 = trunc i184 %23 to i179
  %25 = lshr i179 %24, 74
  %.partselect5 = trunc i179 %25 to i1
  store i1 %.partselect5, i1* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 6
  %26 = bitcast i179* %src to i184*
  %27 = load i184, i184* %26
  %28 = trunc i184 %27 to i179
  %29 = lshr i179 %28, 75
  %.partselect6 = trunc i179 %29 to i8
  store i8 %.partselect6, i8* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 7
  %30 = bitcast i179* %src to i184*
  %31 = load i184, i184* %30
  %32 = trunc i184 %31 to i179
  %33 = lshr i179 %32, 83
  %.partselect7 = trunc i179 %33 to i1
  store i1 %.partselect7, i1* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 8
  %34 = bitcast i179* %src to i184*
  %35 = load i184, i184* %34
  %36 = trunc i184 %35 to i179
  %37 = lshr i179 %36, 84
  %.partselect8 = trunc i179 %37 to i1
  store i1 %.partselect8, i1* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 9
  %38 = bitcast i179* %src to i184*
  %39 = load i184, i184* %38
  %40 = trunc i184 %39 to i179
  %41 = lshr i179 %40, 85
  %.partselect9 = trunc i179 %41 to i8
  store i8 %.partselect9, i8* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 10
  %42 = bitcast i179* %src to i184*
  %43 = load i184, i184* %42
  %44 = trunc i184 %43 to i179
  %45 = lshr i179 %44, 93
  %.partselect10 = trunc i179 %45 to i32
  store i32 %.partselect10, i32* %dst.addr.1029, align 4
  %dst.addr.1131 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 11
  %46 = bitcast i179* %src to i184*
  %47 = load i184, i184* %46
  %48 = trunc i184 %47 to i179
  %49 = lshr i179 %48, 125
  %.partselect11 = trunc i179 %49 to i32
  store i32 %.partselect11, i32* %dst.addr.1131, align 4
  %dst.addr.1233 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 12
  %50 = bitcast i179* %src to i184*
  %51 = load i184, i184* %50
  %52 = trunc i184 %51 to i179
  %53 = lshr i179 %52, 157
  %.partselect12 = trunc i179 %53 to i1
  store i1 %.partselect12, i1* %dst.addr.1233, align 1
  %dst.addr.1335 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 13
  %54 = bitcast i179* %src to i184*
  %55 = load i184, i184* %54
  %56 = trunc i184 %55 to i179
  %57 = lshr i179 %56, 158
  %.partselect13 = trunc i179 %57 to i1
  store i1 %.partselect13, i1* %dst.addr.1335, align 1
  %dst.addr.1437 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 14
  %58 = bitcast i179* %src to i184*
  %59 = load i184, i184* %58
  %60 = trunc i184 %59 to i179
  %61 = lshr i179 %60, 159
  %.partselect14 = trunc i179 %61 to i1
  store i1 %.partselect14, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 15
  %62 = bitcast i179* %src to i184*
  %63 = load i184, i184* %62
  %64 = trunc i184 %63 to i179
  %65 = lshr i179 %64, 160
  %.partselect15 = trunc i179 %65 to i1
  store i1 %.partselect15, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 16
  %66 = bitcast i179* %src to i184*
  %67 = load i184, i184* %66
  %68 = trunc i184 %67 to i179
  %69 = lshr i179 %68, 161
  %.partselect16 = trunc i179 %69 to i1
  store i1 %.partselect16, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 17
  %70 = bitcast i179* %src to i184*
  %71 = load i184, i184* %70
  %72 = trunc i184 %71 to i179
  %73 = lshr i179 %72, 162
  %.partselect17 = trunc i179 %73 to i1
  store i1 %.partselect17, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 18
  %74 = bitcast i179* %src to i184*
  %75 = load i184, i184* %74
  %76 = trunc i184 %75 to i179
  %77 = lshr i179 %76, 163
  %.partselect18 = trunc i179 %77 to i1
  store i1 %.partselect18, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 19
  %78 = bitcast i179* %src to i184*
  %79 = load i184, i184* %78
  %80 = trunc i184 %79 to i179
  %81 = lshr i179 %80, 164
  %.partselect19 = trunc i179 %81 to i1
  store i1 %.partselect19, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 20
  %82 = bitcast i179* %src to i184*
  %83 = load i184, i184* %82
  %84 = trunc i184 %83 to i179
  %85 = lshr i179 %84, 165
  %.partselect20 = trunc i179 %85 to i1
  store i1 %.partselect20, i1* %dst.addr.2049, align 1
  %dst.addr.2151 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 21
  %86 = bitcast i179* %src to i184*
  %87 = load i184, i184* %86
  %88 = trunc i184 %87 to i179
  %89 = lshr i179 %88, 166
  %.partselect21 = trunc i179 %89 to i1
  store i1 %.partselect21, i1* %dst.addr.2151, align 1
  %dst.addr.2253 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 22
  %90 = bitcast i179* %src to i184*
  %91 = load i184, i184* %90
  %92 = trunc i184 %91 to i179
  %93 = lshr i179 %92, 167
  %.partselect22 = trunc i179 %93 to i1
  store i1 %.partselect22, i1* %dst.addr.2253, align 1
  %dst.addr.2355 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 23
  %94 = bitcast i179* %src to i184*
  %95 = load i184, i184* %94
  %96 = trunc i184 %95 to i179
  %97 = lshr i179 %96, 168
  %.partselect23 = trunc i179 %97 to i1
  store i1 %.partselect23, i1* %dst.addr.2355, align 1
  %dst.addr.2457 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 24
  %98 = bitcast i179* %src to i184*
  %99 = load i184, i184* %98
  %100 = trunc i184 %99 to i179
  %101 = lshr i179 %100, 169
  %.partselect24 = trunc i179 %101 to i1
  store i1 %.partselect24, i1* %dst.addr.2457, align 1
  %dst.addr.2559 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 25
  %102 = bitcast i179* %src to i184*
  %103 = load i184, i184* %102
  %104 = trunc i184 %103 to i179
  %105 = lshr i179 %104, 170
  %.partselect25 = trunc i179 %105 to i1
  store i1 %.partselect25, i1* %dst.addr.2559, align 1
  %dst.addr.2661 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 26
  %106 = bitcast i179* %src to i184*
  %107 = load i184, i184* %106
  %108 = trunc i184 %107 to i179
  %109 = lshr i179 %108, 171
  %.partselect26 = trunc i179 %109 to i1
  store i1 %.partselect26, i1* %dst.addr.2661, align 1
  %dst.addr.2763 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 27
  %110 = bitcast i179* %src to i184*
  %111 = load i184, i184* %110
  %112 = trunc i184 %111 to i179
  %113 = lshr i179 %112, 172
  %.partselect27 = trunc i179 %113 to i1
  store i1 %.partselect27, i1* %dst.addr.2763, align 1
  %dst.addr.2865 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 28
  %114 = bitcast i179* %src to i184*
  %115 = load i184, i184* %114
  %116 = trunc i184 %115 to i179
  %117 = lshr i179 %116, 173
  %.partselect28 = trunc i179 %117 to i1
  store i1 %.partselect28, i1* %dst.addr.2865, align 1
  %dst.addr.2967 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 29
  %118 = bitcast i179* %src to i184*
  %119 = load i184, i184* %118
  %120 = trunc i184 %119 to i179
  %121 = lshr i179 %120, 174
  %.partselect29 = trunc i179 %121 to i1
  store i1 %.partselect29, i1* %dst.addr.2967, align 1
  %dst.addr.3069 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 30
  %122 = bitcast i179* %src to i184*
  %123 = load i184, i184* %122
  %124 = trunc i184 %123 to i179
  %125 = lshr i179 %124, 175
  %.partselect30 = trunc i179 %125 to i1
  store i1 %.partselect30, i1* %dst.addr.3069, align 1
  %dst.addr.3171 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 31
  %126 = bitcast i179* %src to i184*
  %127 = load i184, i184* %126
  %128 = trunc i184 %127 to i179
  %129 = lshr i179 %128, 176
  %.partselect31 = trunc i179 %129 to i1
  store i1 %.partselect31, i1* %dst.addr.3171, align 1
  %dst.addr.3273 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 32
  %130 = bitcast i179* %src to i184*
  %131 = load i184, i184* %130
  %132 = trunc i184 %131 to i179
  %133 = lshr i179 %132, 177
  %.partselect32 = trunc i179 %133 to i1
  store i1 %.partselect32, i1* %dst.addr.3273, align 1
  %dst.addr.3375 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx77, i32 33
  %134 = bitcast i179* %src to i184*
  %135 = load i184, i184* %134
  %136 = trunc i184 %135 to i179
  %137 = lshr i179 %136, 178
  %.partselect33 = trunc i179 %137 to i1
  store i1 %.partselect33, i1* %dst.addr.3375, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx77, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a1struct.HeadCtx.10.13([1 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i179* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1" %src) #2 {
entry:
  %0 = icmp eq [1 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i179* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a1struct.HeadCtx.11.12([1 x %struct.HeadCtx]* nonnull %dst, i179* nonnull %src, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out([1 x %struct.HeadCtx]* noalias "orig.arg.no"="0", i179* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1") #4 {
entry:
  call void @onebyonecpy_hls.p0a1struct.HeadCtx.10.13([1 x %struct.HeadCtx]* %0, i179* align 512 %1)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare i1 @apatb_drive_group_head_phase_hw(i179*, i32, i32, i1)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back([1 x %struct.HeadCtx]* noalias "orig.arg.no"="0", i179* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1") #4 {
entry:
  call void @onebyonecpy_hls.p0a1struct.HeadCtx.10.13([1 x %struct.HeadCtx]* %0, i179* align 512 %1)
  ret void
}

declare i1 @drive_group_head_phase_hw_stub([1 x %struct.HeadCtx]* noalias nonnull, i32, i32, i1 zeroext)

define i1 @drive_group_head_phase_hw_stub_wrapper(i179*, i32, i32, i1) #5 {
entry:
  %4 = call i8* @malloc(i64 48)
  %5 = bitcast i8* %4 to [1 x %struct.HeadCtx]*
  call void @copy_out([1 x %struct.HeadCtx]* %5, i179* %0)
  %6 = call i1 @drive_group_head_phase_hw_stub([1 x %struct.HeadCtx]* %5, i32 %1, i32 %2, i1 %3)
  call void @copy_in([1 x %struct.HeadCtx]* %5, i179* %0)
  call void @free(i8* %4)
  ret i1 %6
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
!7 = !{!"0", [1 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11}
!11 = !{!"0", %struct.HeadCtx* null}
