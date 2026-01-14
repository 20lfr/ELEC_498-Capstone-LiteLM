; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Top_Module/Compute_Controller/compute_controller/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_int<4>" = type { %"struct.ap_int_base<4, true>" }
%"struct.ap_int_base<4, true>" = type { %"struct.ssdm_int<4, true>" }
%"struct.ssdm_int<4, true>" = type { i4 }

; Function Attrs: noinline willreturn
define void @apatb_compute_controller_ir(i1 zeroext %reset, i1 zeroext %compute_start, i32 %compute_instruction, i1* noalias nocapture nonnull dereferenceable(1) %compute_ready, i1* noalias nocapture nonnull dereferenceable(1) %compute_done, i1 zeroext %mem_transfer_done, i1* noalias nocapture nonnull dereferenceable(1) %mem_read_request, i1* noalias nocapture nonnull dereferenceable(1) %mem_write_request, i32* noalias nocapture nonnull dereferenceable(4) %mem_op, i8* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="8" %OUT_PROJ_valueA, %"struct.ap_int<4>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="16" %OUT_PROJ_valueB, i32* noalias nocapture nonnull "fpga.decayed.dim.hint"="2" %OUT_PROJ_accum, i1* noalias nocapture nonnull dereferenceable(1) %error) local_unnamed_addr #0 {
entry:
  %compute_ready_copy = alloca i1, align 512
  %compute_done_copy = alloca i1, align 512
  %mem_read_request_copy = alloca i1, align 512
  %mem_write_request_copy = alloca i1, align 512
  %mem_op_copy = alloca i32, align 512
  %0 = bitcast i8* %OUT_PROJ_valueA to [8 x i8]*
  %OUT_PROJ_valueA_copy = alloca [8 x i8], align 512
  %1 = bitcast %"struct.ap_int<4>"* %OUT_PROJ_valueB to [16 x %"struct.ap_int<4>"]*
  %OUT_PROJ_valueB_copy = alloca [16 x i4], align 512
  %2 = bitcast i32* %OUT_PROJ_accum to [2 x i32]*
  %OUT_PROJ_accum_copy = alloca [2 x i32], align 512
  %error_copy = alloca i1, align 512
  call fastcc void @copy_in(i1* nonnull %compute_ready, i1* nonnull align 512 %compute_ready_copy, i1* nonnull %compute_done, i1* nonnull align 512 %compute_done_copy, i1* nonnull %mem_read_request, i1* nonnull align 512 %mem_read_request_copy, i1* nonnull %mem_write_request, i1* nonnull align 512 %mem_write_request_copy, i32* nonnull %mem_op, i32* nonnull align 512 %mem_op_copy, [8 x i8]* nonnull %0, [8 x i8]* nonnull align 512 %OUT_PROJ_valueA_copy, [16 x %"struct.ap_int<4>"]* nonnull %1, [16 x i4]* nonnull align 512 %OUT_PROJ_valueB_copy, [2 x i32]* nonnull %2, [2 x i32]* nonnull align 512 %OUT_PROJ_accum_copy, i1* nonnull %error, i1* nonnull align 512 %error_copy)
  call void @apatb_compute_controller_hw(i1 %reset, i1 %compute_start, i32 %compute_instruction, i1* %compute_ready_copy, i1* %compute_done_copy, i1 %mem_transfer_done, i1* %mem_read_request_copy, i1* %mem_write_request_copy, i32* %mem_op_copy, [8 x i8]* %OUT_PROJ_valueA_copy, [16 x i4]* %OUT_PROJ_valueB_copy, [2 x i32]* %OUT_PROJ_accum_copy, i1* %error_copy)
  call void @copy_back(i1* %compute_ready, i1* %compute_ready_copy, i1* %compute_done, i1* %compute_done_copy, i1* %mem_read_request, i1* %mem_read_request_copy, i1* %mem_write_request, i1* %mem_write_request_copy, i32* %mem_op, i32* %mem_op_copy, [8 x i8]* %0, [8 x i8]* %OUT_PROJ_valueA_copy, [16 x %"struct.ap_int<4>"]* %1, [16 x i4]* %OUT_PROJ_valueB_copy, [2 x i32]* %2, [2 x i32]* %OUT_PROJ_accum_copy, i1* %error, i1* %error_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in(i1* noalias readonly "unpacked"="0", i1* noalias align 512 "unpacked"="1", i1* noalias readonly "unpacked"="2", i1* noalias align 512 "unpacked"="3", i1* noalias readonly "unpacked"="4", i1* noalias align 512 "unpacked"="5", i1* noalias readonly "unpacked"="6", i1* noalias align 512 "unpacked"="7", i32* noalias readonly "unpacked"="8", i32* noalias align 512 "unpacked"="9", [8 x i8]* noalias readonly "unpacked"="10", [8 x i8]* noalias align 512 "unpacked"="11", [16 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="12", [16 x i4]* noalias nocapture align 512 "unpacked"="13.0", [2 x i32]* noalias readonly "unpacked"="14", [2 x i32]* noalias align 512 "unpacked"="15", i1* noalias readonly "unpacked"="16", i1* noalias align 512 "unpacked"="17") unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %3, i1* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %5, i1* %4)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %7, i1* %6)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %9, i32* %8)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* align 512 %11, [8 x i8]* %10)
  call fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>"([16 x i4]* align 512 %13, [16 x %"struct.ap_int<4>"]* %12)
  call fastcc void @onebyonecpy_hls.p0a2i32([2 x i32]* align 512 %15, [2 x i32]* %14)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %17, i1* %16)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i1(i1* noalias align 512 %dst, i1* noalias readonly %src) unnamed_addr #2 {
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
define internal fastcc void @onebyonecpy_hls.p0i32(i32* noalias align 512 %dst, i32* noalias readonly %src) unnamed_addr #2 {
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
define internal fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* noalias align 512 %dst, [8 x i8]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [8 x i8]* %dst, null
  %1 = icmp eq [8 x i8]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a8i8([8 x i8]* nonnull %dst, [8 x i8]* nonnull %src, i64 8)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a8i8([8 x i8]* %dst, [8 x i8]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [8 x i8]* %src, null
  %1 = icmp eq [8 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [8 x i8], [8 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [8 x i8], [8 x i8]* %src, i64 0, i64 %for.loop.idx2
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
define internal fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>"([16 x i4]* noalias nocapture align 512 "unpacked"="0.0" %dst, [16 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x %"struct.ap_int<4>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16struct.ap_int<4>"([16 x i4]* %dst, [16 x %"struct.ap_int<4>"]* nonnull %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16struct.ap_int<4>"([16 x i4]* nocapture "unpacked"="0.0" %dst, [16 x %"struct.ap_int<4>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x %"struct.ap_int<4>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [16 x %"struct.ap_int<4>"], [16 x %"struct.ap_int<4>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [16 x i4], [16 x i4]* %dst, i64 0, i64 %for.loop.idx2
  %1 = bitcast i4* %src.addr.0.0.05 to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i4
  store i4 %3, i4* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a2i32([2 x i32]* noalias align 512 %dst, [2 x i32]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x i32]* %dst, null
  %1 = icmp eq [2 x i32]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a2i32([2 x i32]* nonnull %dst, [2 x i32]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2i32([2 x i32]* %dst, [2 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x i32]* %src, null
  %1 = icmp eq [2 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [2 x i32], [2 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [2 x i32], [2 x i32]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i32, i32* %src.addr, align 4
  store i32 %3, i32* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out(i1* noalias "unpacked"="0", i1* noalias readonly align 512 "unpacked"="1", i1* noalias "unpacked"="2", i1* noalias readonly align 512 "unpacked"="3", i1* noalias "unpacked"="4", i1* noalias readonly align 512 "unpacked"="5", i1* noalias "unpacked"="6", i1* noalias readonly align 512 "unpacked"="7", i32* noalias "unpacked"="8", i32* noalias readonly align 512 "unpacked"="9", [8 x i8]* noalias "unpacked"="10", [8 x i8]* noalias readonly align 512 "unpacked"="11", [16 x %"struct.ap_int<4>"]* noalias "unpacked"="12", [16 x i4]* noalias nocapture readonly align 512 "unpacked"="13.0", [2 x i32]* noalias "unpacked"="14", [2 x i32]* noalias readonly align 512 "unpacked"="15", i1* noalias "unpacked"="16", i1* noalias readonly align 512 "unpacked"="17") unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* %10, [8 x i8]* align 512 %11)
  call fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>.6"([16 x %"struct.ap_int<4>"]* %12, [16 x i4]* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0a2i32([2 x i32]* %14, [2 x i32]* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %16, i1* align 512 %17)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>.6"([16 x %"struct.ap_int<4>"]* noalias "unpacked"="0" %dst, [16 x i4]* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x %"struct.ap_int<4>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16struct.ap_int<4>.9"([16 x %"struct.ap_int<4>"]* nonnull %dst, [16 x i4]* %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16struct.ap_int<4>.9"([16 x %"struct.ap_int<4>"]* "unpacked"="0" %dst, [16 x i4]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x %"struct.ap_int<4>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [16 x i4], [16 x i4]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [16 x %"struct.ap_int<4>"], [16 x %"struct.ap_int<4>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = bitcast i4* %src.addr.0.0.05 to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i4
  store i4 %3, i4* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare void @apatb_compute_controller_hw(i1, i1, i32, i1*, i1*, i1, i1*, i1*, i32*, [8 x i8]*, [16 x i4]*, [2 x i32]*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back(i1* noalias "unpacked"="0", i1* noalias readonly align 512 "unpacked"="1", i1* noalias "unpacked"="2", i1* noalias readonly align 512 "unpacked"="3", i1* noalias "unpacked"="4", i1* noalias readonly align 512 "unpacked"="5", i1* noalias "unpacked"="6", i1* noalias readonly align 512 "unpacked"="7", i32* noalias "unpacked"="8", i32* noalias readonly align 512 "unpacked"="9", [8 x i8]* noalias "unpacked"="10", [8 x i8]* noalias readonly align 512 "unpacked"="11", [16 x %"struct.ap_int<4>"]* noalias "unpacked"="12", [16 x i4]* noalias nocapture readonly align 512 "unpacked"="13.0", [2 x i32]* noalias "unpacked"="14", [2 x i32]* noalias readonly align 512 "unpacked"="15", i1* noalias "unpacked"="16", i1* noalias readonly align 512 "unpacked"="17") unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0a2i32([2 x i32]* %14, [2 x i32]* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %16, i1* align 512 %17)
  ret void
}

declare void @compute_controller_hw_stub(i1 zeroext, i1 zeroext, i32, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i8* noalias nocapture nonnull readonly, %"struct.ap_int<4>"* noalias nocapture nonnull readonly, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull)

define void @compute_controller_hw_stub_wrapper(i1, i1, i32, i1*, i1*, i1, i1*, i1*, i32*, [8 x i8]*, [16 x i4]*, [2 x i32]*, i1*) #5 {
entry:
  %13 = call i8* @malloc(i64 16)
  %14 = bitcast i8* %13 to [16 x %"struct.ap_int<4>"]*
  call void @copy_out(i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %6, i1* null, i1* %7, i32* null, i32* %8, [8 x i8]* null, [8 x i8]* %9, [16 x %"struct.ap_int<4>"]* %14, [16 x i4]* %10, [2 x i32]* null, [2 x i32]* %11, i1* null, i1* %12)
  %15 = bitcast [8 x i8]* %9 to i8*
  %16 = bitcast [16 x %"struct.ap_int<4>"]* %14 to %"struct.ap_int<4>"*
  %17 = bitcast [2 x i32]* %11 to i32*
  call void @compute_controller_hw_stub(i1 %0, i1 %1, i32 %2, i1* %3, i1* %4, i1 %5, i1* %6, i1* %7, i32* %8, i8* %15, %"struct.ap_int<4>"* %16, i32* %17, i1* %12)
  call void @copy_in(i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %6, i1* null, i1* %7, i32* null, i32* %8, [8 x i8]* null, [8 x i8]* %9, [16 x %"struct.ap_int<4>"]* %14, [16 x i4]* %10, [2 x i32]* null, [2 x i32]* %11, i1* null, i1* %12)
  call void @free(i8* %13)
  ret void
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
