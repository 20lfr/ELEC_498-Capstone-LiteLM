; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Top_Module/Compute_Controller/compute_controller/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: noinline willreturn
define void @apatb_compute_controller_ir(i1 zeroext %reset, i1 zeroext %compute_start, i32 %compute_instruction, i1* noalias nocapture nonnull dereferenceable(1) %compute_ready, i1* noalias nocapture nonnull dereferenceable(1) %compute_done, i1 zeroext %mem_transfer_done, i1* noalias nocapture nonnull dereferenceable(1) %mem_read_request, i1* noalias nocapture nonnull dereferenceable(1) %mem_write_request, i32* noalias nocapture nonnull dereferenceable(4) %mem_op, i8* noalias nonnull readonly "fpga.decayed.dim.hint"="129" %in_buf, i8* noalias nocapture nonnull "fpga.decayed.dim.hint"="64" %out_buf, i8* noalias nocapture nonnull dereferenceable(1) %dbg_state, i32* noalias nocapture nonnull dereferenceable(4) %dbg_req_instruction, i8* noalias nocapture nonnull dereferenceable(1) %dbg_req_op, i8* noalias nocapture nonnull dereferenceable(1) %dbg_req_layer, i8* noalias nocapture nonnull dereferenceable(1) %dbg_req_head, i8* noalias nocapture nonnull dereferenceable(1) %dbg_req_tile, i1* noalias nocapture nonnull dereferenceable(1) %dbg_mac_start, i1* noalias nocapture nonnull dereferenceable(1) %dbg_mac_ready, i1* noalias nocapture nonnull dereferenceable(1) %dbg_mac_complete, i1* noalias nocapture nonnull dereferenceable(1) %error) local_unnamed_addr #0 {
entry:
  %compute_ready_copy = alloca i1, align 512
  %compute_done_copy = alloca i1, align 512
  %mem_read_request_copy = alloca i1, align 512
  %mem_write_request_copy = alloca i1, align 512
  %mem_op_copy = alloca i32, align 512
  %0 = bitcast i8* %in_buf to [129 x i8]*
  %in_buf_copy = alloca [129 x i8], align 512
  %1 = bitcast i8* %out_buf to [64 x i8]*
  %out_buf_copy = alloca [64 x i8], align 512
  %dbg_state_copy = alloca i8, align 512
  %dbg_req_instruction_copy = alloca i32, align 512
  %dbg_req_op_copy = alloca i8, align 512
  %dbg_req_layer_copy = alloca i8, align 512
  %dbg_req_head_copy = alloca i8, align 512
  %dbg_req_tile_copy = alloca i8, align 512
  %dbg_mac_start_copy = alloca i1, align 512
  %dbg_mac_ready_copy = alloca i1, align 512
  %dbg_mac_complete_copy = alloca i1, align 512
  %error_copy = alloca i1, align 512
  call fastcc void @copy_in(i1* nonnull %compute_ready, i1* nonnull align 512 %compute_ready_copy, i1* nonnull %compute_done, i1* nonnull align 512 %compute_done_copy, i1* nonnull %mem_read_request, i1* nonnull align 512 %mem_read_request_copy, i1* nonnull %mem_write_request, i1* nonnull align 512 %mem_write_request_copy, i32* nonnull %mem_op, i32* nonnull align 512 %mem_op_copy, [129 x i8]* nonnull %0, [129 x i8]* nonnull align 512 %in_buf_copy, [64 x i8]* nonnull %1, [64 x i8]* nonnull align 512 %out_buf_copy, i8* nonnull %dbg_state, i8* nonnull align 512 %dbg_state_copy, i32* nonnull %dbg_req_instruction, i32* nonnull align 512 %dbg_req_instruction_copy, i8* nonnull %dbg_req_op, i8* nonnull align 512 %dbg_req_op_copy, i8* nonnull %dbg_req_layer, i8* nonnull align 512 %dbg_req_layer_copy, i8* nonnull %dbg_req_head, i8* nonnull align 512 %dbg_req_head_copy, i8* nonnull %dbg_req_tile, i8* nonnull align 512 %dbg_req_tile_copy, i1* nonnull %dbg_mac_start, i1* nonnull align 512 %dbg_mac_start_copy, i1* nonnull %dbg_mac_ready, i1* nonnull align 512 %dbg_mac_ready_copy, i1* nonnull %dbg_mac_complete, i1* nonnull align 512 %dbg_mac_complete_copy, i1* nonnull %error, i1* nonnull align 512 %error_copy)
  call void @apatb_compute_controller_hw(i1 %reset, i1 %compute_start, i32 %compute_instruction, i1* %compute_ready_copy, i1* %compute_done_copy, i1 %mem_transfer_done, i1* %mem_read_request_copy, i1* %mem_write_request_copy, i32* %mem_op_copy, [129 x i8]* %in_buf_copy, [64 x i8]* %out_buf_copy, i8* %dbg_state_copy, i32* %dbg_req_instruction_copy, i8* %dbg_req_op_copy, i8* %dbg_req_layer_copy, i8* %dbg_req_head_copy, i8* %dbg_req_tile_copy, i1* %dbg_mac_start_copy, i1* %dbg_mac_ready_copy, i1* %dbg_mac_complete_copy, i1* %error_copy)
  call void @copy_back(i1* %compute_ready, i1* %compute_ready_copy, i1* %compute_done, i1* %compute_done_copy, i1* %mem_read_request, i1* %mem_read_request_copy, i1* %mem_write_request, i1* %mem_write_request_copy, i32* %mem_op, i32* %mem_op_copy, [129 x i8]* %0, [129 x i8]* %in_buf_copy, [64 x i8]* %1, [64 x i8]* %out_buf_copy, i8* %dbg_state, i8* %dbg_state_copy, i32* %dbg_req_instruction, i32* %dbg_req_instruction_copy, i8* %dbg_req_op, i8* %dbg_req_op_copy, i8* %dbg_req_layer, i8* %dbg_req_layer_copy, i8* %dbg_req_head, i8* %dbg_req_head_copy, i8* %dbg_req_tile, i8* %dbg_req_tile_copy, i1* %dbg_mac_start, i1* %dbg_mac_start_copy, i1* %dbg_mac_ready, i1* %dbg_mac_ready_copy, i1* %dbg_mac_complete, i1* %dbg_mac_complete_copy, i1* %error, i1* %error_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in(i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i32* noalias readonly, i32* noalias align 512, [129 x i8]* noalias readonly, [129 x i8]* noalias align 512, [64 x i8]* noalias readonly, [64 x i8]* noalias align 512, i8* noalias readonly, i8* noalias align 512, i32* noalias readonly, i32* noalias align 512, i8* noalias readonly, i8* noalias align 512, i8* noalias readonly, i8* noalias align 512, i8* noalias readonly, i8* noalias align 512, i8* noalias readonly, i8* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %3, i1* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %5, i1* %4)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %7, i1* %6)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %9, i32* %8)
  call fastcc void @onebyonecpy_hls.p0a129i8([129 x i8]* align 512 %11, [129 x i8]* %10)
  call fastcc void @onebyonecpy_hls.p0a64i8([64 x i8]* align 512 %13, [64 x i8]* %12)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %15, i8* %14)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %17, i32* %16)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %19, i8* %18)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %21, i8* %20)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %23, i8* %22)
  call fastcc void @onebyonecpy_hls.p0i8(i8* align 512 %25, i8* %24)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %27, i1* %26)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %29, i1* %28)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %31, i1* %30)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %33, i1* %32)
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
define internal fastcc void @onebyonecpy_hls.p0a129i8([129 x i8]* noalias align 512 %dst, [129 x i8]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [129 x i8]* %dst, null
  %1 = icmp eq [129 x i8]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a129i8([129 x i8]* nonnull %dst, [129 x i8]* nonnull %src, i64 129)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a129i8([129 x i8]* %dst, [129 x i8]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [129 x i8]* %src, null
  %1 = icmp eq [129 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [129 x i8], [129 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [129 x i8], [129 x i8]* %src, i64 0, i64 %for.loop.idx2
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
define internal fastcc void @onebyonecpy_hls.p0a64i8([64 x i8]* noalias align 512 %dst, [64 x i8]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [64 x i8]* %dst, null
  %1 = icmp eq [64 x i8]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a64i8([64 x i8]* nonnull %dst, [64 x i8]* nonnull %src, i64 64)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a64i8([64 x i8]* %dst, [64 x i8]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [64 x i8]* %src, null
  %1 = icmp eq [64 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [64 x i8], [64 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [64 x i8], [64 x i8]* %src, i64 0, i64 %for.loop.idx2
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
define internal fastcc void @onebyonecpy_hls.p0i8(i8* noalias align 512 %dst, i8* noalias readonly %src) unnamed_addr #2 {
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
define internal fastcc void @copy_out(i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, [129 x i8]* noalias, [129 x i8]* noalias readonly align 512, [64 x i8]* noalias, [64 x i8]* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0a129i8([129 x i8]* %10, [129 x i8]* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0a64i8([64 x i8]* %12, [64 x i8]* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %14, i8* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %16, i32* align 512 %17)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %18, i8* align 512 %19)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %20, i8* align 512 %21)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %22, i8* align 512 %23)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %24, i8* align 512 %25)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %26, i1* align 512 %27)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %28, i1* align 512 %29)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %30, i1* align 512 %31)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %32, i1* align 512 %33)
  ret void
}

declare void @apatb_compute_controller_hw(i1, i1, i32, i1*, i1*, i1, i1*, i1*, i32*, [129 x i8]*, [64 x i8]*, i8*, i32*, i8*, i8*, i8*, i8*, i1*, i1*, i1*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back(i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, [129 x i8]* noalias, [129 x i8]* noalias readonly align 512, [64 x i8]* noalias, [64 x i8]* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i8* noalias, i8* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0a64i8([64 x i8]* %12, [64 x i8]* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %14, i8* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %16, i32* align 512 %17)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %18, i8* align 512 %19)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %20, i8* align 512 %21)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %22, i8* align 512 %23)
  call fastcc void @onebyonecpy_hls.p0i8(i8* %24, i8* align 512 %25)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %26, i1* align 512 %27)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %28, i1* align 512 %29)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %30, i1* align 512 %31)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %32, i1* align 512 %33)
  ret void
}

declare void @compute_controller_hw_stub(i1 zeroext, i1 zeroext, i32, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i8* noalias nonnull readonly, i8* noalias nocapture nonnull, i8* noalias nocapture nonnull, i32* noalias nocapture nonnull, i8* noalias nocapture nonnull, i8* noalias nocapture nonnull, i8* noalias nocapture nonnull, i8* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull)

define void @compute_controller_hw_stub_wrapper(i1, i1, i32, i1*, i1*, i1, i1*, i1*, i32*, [129 x i8]*, [64 x i8]*, i8*, i32*, i8*, i8*, i8*, i8*, i1*, i1*, i1*, i1*) #5 {
entry:
  call void @copy_out(i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %6, i1* null, i1* %7, i32* null, i32* %8, [129 x i8]* null, [129 x i8]* %9, [64 x i8]* null, [64 x i8]* %10, i8* null, i8* %11, i32* null, i32* %12, i8* null, i8* %13, i8* null, i8* %14, i8* null, i8* %15, i8* null, i8* %16, i1* null, i1* %17, i1* null, i1* %18, i1* null, i1* %19, i1* null, i1* %20)
  %21 = bitcast [129 x i8]* %9 to i8*
  %22 = bitcast [64 x i8]* %10 to i8*
  call void @compute_controller_hw_stub(i1 %0, i1 %1, i32 %2, i1* %3, i1* %4, i1 %5, i1* %6, i1* %7, i32* %8, i8* %21, i8* %22, i8* %11, i32* %12, i8* %13, i8* %14, i8* %15, i8* %16, i1* %17, i1* %18, i1* %19, i1* %20)
  call void @copy_in(i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %6, i1* null, i1* %7, i32* null, i32* %8, [129 x i8]* null, [129 x i8]* %9, [64 x i8]* null, [64 x i8]* %10, i8* null, i8* %11, i32* null, i32* %12, i8* null, i8* %13, i8* null, i8* %14, i8* null, i8* %15, i8* null, i8* %16, i1* null, i1* %17, i1* null, i1* %18, i1* null, i1* %19, i1* null, i1* %20)
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
