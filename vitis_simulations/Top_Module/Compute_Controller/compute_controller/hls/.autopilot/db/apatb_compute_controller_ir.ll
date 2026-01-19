; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Top_Module/Compute_Controller/compute_controller/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_int<4>" = type { %"struct.ap_int_base<4, true>" }
%"struct.ap_int_base<4, true>" = type { %"struct.ssdm_int<4, true>" }
%"struct.ssdm_int<4, true>" = type { i4 }

; Function Attrs: noinline willreturn
define void @apatb_compute_controller_ir(i1 zeroext %reset, i1 zeroext %compute_start, i32 %compute_instruction, i1* noalias nocapture nonnull dereferenceable(1) %compute_ready, i1* noalias nocapture nonnull dereferenceable(1) %compute_done, i1 zeroext %mem_transfer_done, i1* noalias nocapture nonnull dereferenceable(1) %mem_read_request, i1* noalias nocapture nonnull dereferenceable(1) %mem_write_request, i32* noalias nocapture nonnull dereferenceable(4) %mem_op, i8* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="8" %int8_activation, %"struct.ap_int<4>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="16" %OUT_PROJ_valueB, i32* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="2" %OUT_PROJ_bias, i32* noalias nocapture nonnull "fpga.decayed.dim.hint"="2" %OUT_PROJ_accum, %"struct.ap_int<4>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="16" %FFN1_weights1, %"struct.ap_int<4>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="2" %FFN1_biases, i16* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="2" %FFN1_scale, i16* noalias nocapture nonnull "fpga.decayed.dim.hint"="2" %FFN1_output, i16* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="22" %RELU_input, i16* noalias nocapture nonnull "fpga.decayed.dim.hint"="22" %RELU_output, i16* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="22" %FFN2_input, %"struct.ap_int<4>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="110" %FFN2_weights2, %"struct.ap_int<4>"* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="5" %FFN2_biases, i16* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="5" %FFN2_scale, i32* noalias nocapture nonnull "fpga.decayed.dim.hint"="8" %FFN2_output, i32* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="8" %requant_activation, i32 %requant_scale, i32 %requant_shift, i32 %requant_zero_point, i8* noalias nocapture nonnull "fpga.decayed.dim.hint"="8" %requant_output, i32* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="8" %layerNorm_gamma, i32* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="8" %layerNorm_beta, i32 %layerNorm_epsilon, i32* noalias nocapture nonnull "fpga.decayed.dim.hint"="8" %layerNorm_out, i8* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="8" %residualAdd_residual, i8* noalias nocapture nonnull "fpga.decayed.dim.hint"="8" %residualAdd_output, i1* noalias nocapture nonnull dereferenceable(1) %error) local_unnamed_addr #0 {
entry:
  %compute_ready_copy = alloca i1, align 512
  %compute_done_copy = alloca i1, align 512
  %mem_read_request_copy = alloca i1, align 512
  %mem_write_request_copy = alloca i1, align 512
  %mem_op_copy = alloca i32, align 512
  %0 = bitcast i8* %int8_activation to [8 x i8]*
  %int8_activation_copy = alloca [8 x i8], align 512
  %1 = bitcast %"struct.ap_int<4>"* %OUT_PROJ_valueB to [16 x %"struct.ap_int<4>"]*
  %OUT_PROJ_valueB_copy = alloca [16 x i4], align 512
  %2 = bitcast i32* %OUT_PROJ_bias to [2 x i32]*
  %OUT_PROJ_bias_copy = alloca [2 x i32], align 512
  %3 = bitcast i32* %OUT_PROJ_accum to [2 x i32]*
  %OUT_PROJ_accum_copy = alloca [2 x i32], align 512
  %4 = bitcast %"struct.ap_int<4>"* %FFN1_weights1 to [16 x %"struct.ap_int<4>"]*
  %FFN1_weights1_copy = alloca [16 x i4], align 512
  %5 = bitcast %"struct.ap_int<4>"* %FFN1_biases to [2 x %"struct.ap_int<4>"]*
  %FFN1_biases_copy = alloca [2 x i4], align 512
  %6 = bitcast i16* %FFN1_scale to [2 x i16]*
  %FFN1_scale_copy = alloca [2 x i16], align 512
  %7 = bitcast i16* %FFN1_output to [2 x i16]*
  %FFN1_output_copy = alloca [2 x i16], align 512
  %8 = bitcast i16* %RELU_input to [22 x i16]*
  %RELU_input_copy = alloca [22 x i16], align 512
  %9 = bitcast i16* %RELU_output to [22 x i16]*
  %RELU_output_copy = alloca [22 x i16], align 512
  %10 = bitcast i16* %FFN2_input to [22 x i16]*
  %FFN2_input_copy = alloca [22 x i16], align 512
  %11 = bitcast %"struct.ap_int<4>"* %FFN2_weights2 to [110 x %"struct.ap_int<4>"]*
  %FFN2_weights2_copy = alloca [110 x i4], align 512
  %12 = bitcast %"struct.ap_int<4>"* %FFN2_biases to [5 x %"struct.ap_int<4>"]*
  %FFN2_biases_copy = alloca [5 x i4], align 512
  %13 = bitcast i16* %FFN2_scale to [5 x i16]*
  %FFN2_scale_copy = alloca [5 x i16], align 512
  %14 = bitcast i32* %FFN2_output to [8 x i32]*
  %FFN2_output_copy = alloca [8 x i32], align 512
  %15 = bitcast i32* %requant_activation to [8 x i32]*
  %requant_activation_copy = alloca [8 x i32], align 512
  %16 = bitcast i8* %requant_output to [8 x i8]*
  %requant_output_copy = alloca [8 x i8], align 512
  %17 = bitcast i32* %layerNorm_gamma to [8 x i32]*
  %layerNorm_gamma_copy = alloca [8 x i32], align 512
  %18 = bitcast i32* %layerNorm_beta to [8 x i32]*
  %layerNorm_beta_copy = alloca [8 x i32], align 512
  %19 = bitcast i32* %layerNorm_out to [8 x i32]*
  %layerNorm_out_copy = alloca [8 x i32], align 512
  %20 = bitcast i8* %residualAdd_residual to [8 x i8]*
  %residualAdd_residual_copy = alloca [8 x i8], align 512
  %21 = bitcast i8* %residualAdd_output to [8 x i8]*
  %residualAdd_output_copy = alloca [8 x i8], align 512
  %error_copy = alloca i1, align 512
  call fastcc void @copy_in(i1* nonnull %compute_ready, i1* nonnull align 512 %compute_ready_copy, i1* nonnull %compute_done, i1* nonnull align 512 %compute_done_copy, i1* nonnull %mem_read_request, i1* nonnull align 512 %mem_read_request_copy, i1* nonnull %mem_write_request, i1* nonnull align 512 %mem_write_request_copy, i32* nonnull %mem_op, i32* nonnull align 512 %mem_op_copy, [8 x i8]* nonnull %0, [8 x i8]* nonnull align 512 %int8_activation_copy, [16 x %"struct.ap_int<4>"]* nonnull %1, [16 x i4]* nonnull align 512 %OUT_PROJ_valueB_copy, [2 x i32]* nonnull %2, [2 x i32]* nonnull align 512 %OUT_PROJ_bias_copy, [2 x i32]* nonnull %3, [2 x i32]* nonnull align 512 %OUT_PROJ_accum_copy, [16 x %"struct.ap_int<4>"]* nonnull %4, [16 x i4]* nonnull align 512 %FFN1_weights1_copy, [2 x %"struct.ap_int<4>"]* nonnull %5, [2 x i4]* nonnull align 512 %FFN1_biases_copy, [2 x i16]* nonnull %6, [2 x i16]* nonnull align 512 %FFN1_scale_copy, [2 x i16]* nonnull %7, [2 x i16]* nonnull align 512 %FFN1_output_copy, [22 x i16]* nonnull %8, [22 x i16]* nonnull align 512 %RELU_input_copy, [22 x i16]* nonnull %9, [22 x i16]* nonnull align 512 %RELU_output_copy, [22 x i16]* nonnull %10, [22 x i16]* nonnull align 512 %FFN2_input_copy, [110 x %"struct.ap_int<4>"]* nonnull %11, [110 x i4]* nonnull align 512 %FFN2_weights2_copy, [5 x %"struct.ap_int<4>"]* nonnull %12, [5 x i4]* nonnull align 512 %FFN2_biases_copy, [5 x i16]* nonnull %13, [5 x i16]* nonnull align 512 %FFN2_scale_copy, [8 x i32]* nonnull %14, [8 x i32]* nonnull align 512 %FFN2_output_copy, [8 x i32]* nonnull %15, [8 x i32]* nonnull align 512 %requant_activation_copy, [8 x i8]* nonnull %16, [8 x i8]* nonnull align 512 %requant_output_copy, [8 x i32]* nonnull %17, [8 x i32]* nonnull align 512 %layerNorm_gamma_copy, [8 x i32]* nonnull %18, [8 x i32]* nonnull align 512 %layerNorm_beta_copy, [8 x i32]* nonnull %19, [8 x i32]* nonnull align 512 %layerNorm_out_copy, [8 x i8]* nonnull %20, [8 x i8]* nonnull align 512 %residualAdd_residual_copy, [8 x i8]* nonnull %21, [8 x i8]* nonnull align 512 %residualAdd_output_copy, i1* nonnull %error, i1* nonnull align 512 %error_copy)
  call void @apatb_compute_controller_hw(i1 %reset, i1 %compute_start, i32 %compute_instruction, i1* %compute_ready_copy, i1* %compute_done_copy, i1 %mem_transfer_done, i1* %mem_read_request_copy, i1* %mem_write_request_copy, i32* %mem_op_copy, [8 x i8]* %int8_activation_copy, [16 x i4]* %OUT_PROJ_valueB_copy, [2 x i32]* %OUT_PROJ_bias_copy, [2 x i32]* %OUT_PROJ_accum_copy, [16 x i4]* %FFN1_weights1_copy, [2 x i4]* %FFN1_biases_copy, [2 x i16]* %FFN1_scale_copy, [2 x i16]* %FFN1_output_copy, [22 x i16]* %RELU_input_copy, [22 x i16]* %RELU_output_copy, [22 x i16]* %FFN2_input_copy, [110 x i4]* %FFN2_weights2_copy, [5 x i4]* %FFN2_biases_copy, [5 x i16]* %FFN2_scale_copy, [8 x i32]* %FFN2_output_copy, [8 x i32]* %requant_activation_copy, i32 %requant_scale, i32 %requant_shift, i32 %requant_zero_point, [8 x i8]* %requant_output_copy, [8 x i32]* %layerNorm_gamma_copy, [8 x i32]* %layerNorm_beta_copy, i32 %layerNorm_epsilon, [8 x i32]* %layerNorm_out_copy, [8 x i8]* %residualAdd_residual_copy, [8 x i8]* %residualAdd_output_copy, i1* %error_copy)
  call void @copy_back(i1* %compute_ready, i1* %compute_ready_copy, i1* %compute_done, i1* %compute_done_copy, i1* %mem_read_request, i1* %mem_read_request_copy, i1* %mem_write_request, i1* %mem_write_request_copy, i32* %mem_op, i32* %mem_op_copy, [8 x i8]* %0, [8 x i8]* %int8_activation_copy, [16 x %"struct.ap_int<4>"]* %1, [16 x i4]* %OUT_PROJ_valueB_copy, [2 x i32]* %2, [2 x i32]* %OUT_PROJ_bias_copy, [2 x i32]* %3, [2 x i32]* %OUT_PROJ_accum_copy, [16 x %"struct.ap_int<4>"]* %4, [16 x i4]* %FFN1_weights1_copy, [2 x %"struct.ap_int<4>"]* %5, [2 x i4]* %FFN1_biases_copy, [2 x i16]* %6, [2 x i16]* %FFN1_scale_copy, [2 x i16]* %7, [2 x i16]* %FFN1_output_copy, [22 x i16]* %8, [22 x i16]* %RELU_input_copy, [22 x i16]* %9, [22 x i16]* %RELU_output_copy, [22 x i16]* %10, [22 x i16]* %FFN2_input_copy, [110 x %"struct.ap_int<4>"]* %11, [110 x i4]* %FFN2_weights2_copy, [5 x %"struct.ap_int<4>"]* %12, [5 x i4]* %FFN2_biases_copy, [5 x i16]* %13, [5 x i16]* %FFN2_scale_copy, [8 x i32]* %14, [8 x i32]* %FFN2_output_copy, [8 x i32]* %15, [8 x i32]* %requant_activation_copy, [8 x i8]* %16, [8 x i8]* %requant_output_copy, [8 x i32]* %17, [8 x i32]* %layerNorm_gamma_copy, [8 x i32]* %18, [8 x i32]* %layerNorm_beta_copy, [8 x i32]* %19, [8 x i32]* %layerNorm_out_copy, [8 x i8]* %20, [8 x i8]* %residualAdd_residual_copy, [8 x i8]* %21, [8 x i8]* %residualAdd_output_copy, i1* %error, i1* %error_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in(i1* noalias readonly "unpacked"="0", i1* noalias align 512 "unpacked"="1", i1* noalias readonly "unpacked"="2", i1* noalias align 512 "unpacked"="3", i1* noalias readonly "unpacked"="4", i1* noalias align 512 "unpacked"="5", i1* noalias readonly "unpacked"="6", i1* noalias align 512 "unpacked"="7", i32* noalias readonly "unpacked"="8", i32* noalias align 512 "unpacked"="9", [8 x i8]* noalias readonly "unpacked"="10", [8 x i8]* noalias align 512 "unpacked"="11", [16 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="12", [16 x i4]* noalias nocapture align 512 "unpacked"="13.0", [2 x i32]* noalias readonly "unpacked"="14", [2 x i32]* noalias align 512 "unpacked"="15", [2 x i32]* noalias readonly "unpacked"="16", [2 x i32]* noalias align 512 "unpacked"="17", [16 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="18", [16 x i4]* noalias nocapture align 512 "unpacked"="19.0", [2 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="20", [2 x i4]* noalias nocapture align 512 "unpacked"="21.0", [2 x i16]* noalias readonly "unpacked"="22", [2 x i16]* noalias align 512 "unpacked"="23", [2 x i16]* noalias readonly "unpacked"="24", [2 x i16]* noalias align 512 "unpacked"="25", [22 x i16]* noalias readonly "unpacked"="26", [22 x i16]* noalias align 512 "unpacked"="27", [22 x i16]* noalias readonly "unpacked"="28", [22 x i16]* noalias align 512 "unpacked"="29", [22 x i16]* noalias readonly "unpacked"="30", [22 x i16]* noalias align 512 "unpacked"="31", [110 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="32", [110 x i4]* noalias nocapture align 512 "unpacked"="33.0", [5 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="34", [5 x i4]* noalias nocapture align 512 "unpacked"="35.0", [5 x i16]* noalias readonly "unpacked"="36", [5 x i16]* noalias align 512 "unpacked"="37", [8 x i32]* noalias readonly "unpacked"="38", [8 x i32]* noalias align 512 "unpacked"="39", [8 x i32]* noalias readonly "unpacked"="40", [8 x i32]* noalias align 512 "unpacked"="41", [8 x i8]* noalias readonly "unpacked"="42", [8 x i8]* noalias align 512 "unpacked"="43", [8 x i32]* noalias readonly "unpacked"="44", [8 x i32]* noalias align 512 "unpacked"="45", [8 x i32]* noalias readonly "unpacked"="46", [8 x i32]* noalias align 512 "unpacked"="47", [8 x i32]* noalias readonly "unpacked"="48", [8 x i32]* noalias align 512 "unpacked"="49", [8 x i8]* noalias readonly "unpacked"="50", [8 x i8]* noalias align 512 "unpacked"="51", [8 x i8]* noalias readonly "unpacked"="52", [8 x i8]* noalias align 512 "unpacked"="53", i1* noalias readonly "unpacked"="54", i1* noalias align 512 "unpacked"="55") unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %3, i1* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %5, i1* %4)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %7, i1* %6)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %9, i32* %8)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* align 512 %11, [8 x i8]* %10)
  call fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>"([16 x i4]* align 512 %13, [16 x %"struct.ap_int<4>"]* %12)
  call fastcc void @onebyonecpy_hls.p0a2i32([2 x i32]* align 512 %15, [2 x i32]* %14)
  call fastcc void @onebyonecpy_hls.p0a2i32([2 x i32]* align 512 %17, [2 x i32]* %16)
  call fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>"([16 x i4]* align 512 %19, [16 x %"struct.ap_int<4>"]* %18)
  call fastcc void @"onebyonecpy_hls.p0a2struct.ap_int<4>"([2 x i4]* align 512 %21, [2 x %"struct.ap_int<4>"]* %20)
  call fastcc void @onebyonecpy_hls.p0a2i16([2 x i16]* align 512 %23, [2 x i16]* %22)
  call fastcc void @onebyonecpy_hls.p0a2i16([2 x i16]* align 512 %25, [2 x i16]* %24)
  call fastcc void @onebyonecpy_hls.p0a22i16([22 x i16]* align 512 %27, [22 x i16]* %26)
  call fastcc void @onebyonecpy_hls.p0a22i16([22 x i16]* align 512 %29, [22 x i16]* %28)
  call fastcc void @onebyonecpy_hls.p0a22i16([22 x i16]* align 512 %31, [22 x i16]* %30)
  call fastcc void @"onebyonecpy_hls.p0a110struct.ap_int<4>.20"([110 x i4]* align 512 %33, [110 x %"struct.ap_int<4>"]* %32)
  call fastcc void @"onebyonecpy_hls.p0a5struct.ap_int<4>"([5 x i4]* align 512 %35, [5 x %"struct.ap_int<4>"]* %34)
  call fastcc void @onebyonecpy_hls.p0a5i16([5 x i16]* align 512 %37, [5 x i16]* %36)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* align 512 %39, [8 x i32]* %38)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* align 512 %41, [8 x i32]* %40)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* align 512 %43, [8 x i8]* %42)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* align 512 %45, [8 x i32]* %44)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* align 512 %47, [8 x i32]* %46)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* align 512 %49, [8 x i32]* %48)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* align 512 %51, [8 x i8]* %50)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* align 512 %53, [8 x i8]* %52)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %55, i1* %54)
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
define internal fastcc void @"onebyonecpy_hls.p0a2struct.ap_int<4>"([2 x i4]* noalias nocapture align 512 "unpacked"="0.0" %dst, [2 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x %"struct.ap_int<4>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2struct.ap_int<4>"([2 x i4]* %dst, [2 x %"struct.ap_int<4>"]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2struct.ap_int<4>"([2 x i4]* nocapture "unpacked"="0.0" %dst, [2 x %"struct.ap_int<4>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x %"struct.ap_int<4>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2 x %"struct.ap_int<4>"], [2 x %"struct.ap_int<4>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [2 x i4], [2 x i4]* %dst, i64 0, i64 %for.loop.idx2
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
define internal fastcc void @onebyonecpy_hls.p0a2i16([2 x i16]* noalias align 512 %dst, [2 x i16]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x i16]* %dst, null
  %1 = icmp eq [2 x i16]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a2i16([2 x i16]* nonnull %dst, [2 x i16]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2i16([2 x i16]* %dst, [2 x i16]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x i16]* %src, null
  %1 = icmp eq [2 x i16]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [2 x i16], [2 x i16]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [2 x i16], [2 x i16]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i16, i16* %src.addr, align 2
  store i16 %3, i16* %dst.addr, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a22i16([22 x i16]* noalias align 512 %dst, [22 x i16]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [22 x i16]* %dst, null
  %1 = icmp eq [22 x i16]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a22i16([22 x i16]* nonnull %dst, [22 x i16]* nonnull %src, i64 22)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a22i16([22 x i16]* %dst, [22 x i16]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [22 x i16]* %src, null
  %1 = icmp eq [22 x i16]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [22 x i16], [22 x i16]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [22 x i16], [22 x i16]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i16, i16* %src.addr, align 2
  store i16 %3, i16* %dst.addr, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a110struct.ap_int<4>"([110 x %"struct.ap_int<4>"]* noalias "unpacked"="0" %dst, [110 x i4]* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [110 x %"struct.ap_int<4>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a110struct.ap_int<4>"([110 x %"struct.ap_int<4>"]* nonnull %dst, [110 x i4]* %src, i64 110)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a110struct.ap_int<4>"([110 x %"struct.ap_int<4>"]* "unpacked"="0" %dst, [110 x i4]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [110 x %"struct.ap_int<4>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [110 x i4], [110 x i4]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [110 x %"struct.ap_int<4>"], [110 x %"struct.ap_int<4>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
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
define internal fastcc void @"onebyonecpy_hls.p0a5struct.ap_int<4>"([5 x i4]* noalias nocapture align 512 "unpacked"="0.0" %dst, [5 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x %"struct.ap_int<4>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a5struct.ap_int<4>"([5 x i4]* %dst, [5 x %"struct.ap_int<4>"]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a5struct.ap_int<4>"([5 x i4]* nocapture "unpacked"="0.0" %dst, [5 x %"struct.ap_int<4>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x %"struct.ap_int<4>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [5 x %"struct.ap_int<4>"], [5 x %"struct.ap_int<4>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [5 x i4], [5 x i4]* %dst, i64 0, i64 %for.loop.idx2
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
define internal fastcc void @onebyonecpy_hls.p0a5i16([5 x i16]* noalias align 512 %dst, [5 x i16]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x i16]* %dst, null
  %1 = icmp eq [5 x i16]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5i16([5 x i16]* nonnull %dst, [5 x i16]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i16([5 x i16]* %dst, [5 x i16]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x i16]* %src, null
  %1 = icmp eq [5 x i16]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x i16], [5 x i16]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x i16], [5 x i16]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i16, i16* %src.addr, align 2
  store i16 %3, i16* %dst.addr, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* noalias align 512 %dst, [8 x i32]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [8 x i32]* %dst, null
  %1 = icmp eq [8 x i32]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a8i32([8 x i32]* nonnull %dst, [8 x i32]* nonnull %src, i64 8)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a8i32([8 x i32]* %dst, [8 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [8 x i32]* %src, null
  %1 = icmp eq [8 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [8 x i32], [8 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [8 x i32], [8 x i32]* %src, i64 0, i64 %for.loop.idx2
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
define internal fastcc void @copy_out(i1* noalias "unpacked"="0", i1* noalias readonly align 512 "unpacked"="1", i1* noalias "unpacked"="2", i1* noalias readonly align 512 "unpacked"="3", i1* noalias "unpacked"="4", i1* noalias readonly align 512 "unpacked"="5", i1* noalias "unpacked"="6", i1* noalias readonly align 512 "unpacked"="7", i32* noalias "unpacked"="8", i32* noalias readonly align 512 "unpacked"="9", [8 x i8]* noalias "unpacked"="10", [8 x i8]* noalias readonly align 512 "unpacked"="11", [16 x %"struct.ap_int<4>"]* noalias "unpacked"="12", [16 x i4]* noalias nocapture readonly align 512 "unpacked"="13.0", [2 x i32]* noalias "unpacked"="14", [2 x i32]* noalias readonly align 512 "unpacked"="15", [2 x i32]* noalias "unpacked"="16", [2 x i32]* noalias readonly align 512 "unpacked"="17", [16 x %"struct.ap_int<4>"]* noalias "unpacked"="18", [16 x i4]* noalias nocapture readonly align 512 "unpacked"="19.0", [2 x %"struct.ap_int<4>"]* noalias "unpacked"="20", [2 x i4]* noalias nocapture readonly align 512 "unpacked"="21.0", [2 x i16]* noalias "unpacked"="22", [2 x i16]* noalias readonly align 512 "unpacked"="23", [2 x i16]* noalias "unpacked"="24", [2 x i16]* noalias readonly align 512 "unpacked"="25", [22 x i16]* noalias "unpacked"="26", [22 x i16]* noalias readonly align 512 "unpacked"="27", [22 x i16]* noalias "unpacked"="28", [22 x i16]* noalias readonly align 512 "unpacked"="29", [22 x i16]* noalias "unpacked"="30", [22 x i16]* noalias readonly align 512 "unpacked"="31", [110 x %"struct.ap_int<4>"]* noalias "unpacked"="32", [110 x i4]* noalias nocapture readonly align 512 "unpacked"="33.0", [5 x %"struct.ap_int<4>"]* noalias "unpacked"="34", [5 x i4]* noalias nocapture readonly align 512 "unpacked"="35.0", [5 x i16]* noalias "unpacked"="36", [5 x i16]* noalias readonly align 512 "unpacked"="37", [8 x i32]* noalias "unpacked"="38", [8 x i32]* noalias readonly align 512 "unpacked"="39", [8 x i32]* noalias "unpacked"="40", [8 x i32]* noalias readonly align 512 "unpacked"="41", [8 x i8]* noalias "unpacked"="42", [8 x i8]* noalias readonly align 512 "unpacked"="43", [8 x i32]* noalias "unpacked"="44", [8 x i32]* noalias readonly align 512 "unpacked"="45", [8 x i32]* noalias "unpacked"="46", [8 x i32]* noalias readonly align 512 "unpacked"="47", [8 x i32]* noalias "unpacked"="48", [8 x i32]* noalias readonly align 512 "unpacked"="49", [8 x i8]* noalias "unpacked"="50", [8 x i8]* noalias readonly align 512 "unpacked"="51", [8 x i8]* noalias "unpacked"="52", [8 x i8]* noalias readonly align 512 "unpacked"="53", i1* noalias "unpacked"="54", i1* noalias readonly align 512 "unpacked"="55") unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* %10, [8 x i8]* align 512 %11)
  call fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>.51"([16 x %"struct.ap_int<4>"]* %12, [16 x i4]* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0a2i32([2 x i32]* %14, [2 x i32]* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0a2i32([2 x i32]* %16, [2 x i32]* align 512 %17)
  call fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>.51"([16 x %"struct.ap_int<4>"]* %18, [16 x i4]* align 512 %19)
  call fastcc void @"onebyonecpy_hls.p0a2struct.ap_int<4>.32"([2 x %"struct.ap_int<4>"]* %20, [2 x i4]* align 512 %21)
  call fastcc void @onebyonecpy_hls.p0a2i16([2 x i16]* %22, [2 x i16]* align 512 %23)
  call fastcc void @onebyonecpy_hls.p0a2i16([2 x i16]* %24, [2 x i16]* align 512 %25)
  call fastcc void @onebyonecpy_hls.p0a22i16([22 x i16]* %26, [22 x i16]* align 512 %27)
  call fastcc void @onebyonecpy_hls.p0a22i16([22 x i16]* %28, [22 x i16]* align 512 %29)
  call fastcc void @onebyonecpy_hls.p0a22i16([22 x i16]* %30, [22 x i16]* align 512 %31)
  call fastcc void @"onebyonecpy_hls.p0a110struct.ap_int<4>"([110 x %"struct.ap_int<4>"]* %32, [110 x i4]* align 512 %33)
  call fastcc void @"onebyonecpy_hls.p0a5struct.ap_int<4>.10"([5 x %"struct.ap_int<4>"]* %34, [5 x i4]* align 512 %35)
  call fastcc void @onebyonecpy_hls.p0a5i16([5 x i16]* %36, [5 x i16]* align 512 %37)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* %38, [8 x i32]* align 512 %39)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* %40, [8 x i32]* align 512 %41)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* %42, [8 x i8]* align 512 %43)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* %44, [8 x i32]* align 512 %45)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* %46, [8 x i32]* align 512 %47)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* %48, [8 x i32]* align 512 %49)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* %50, [8 x i8]* align 512 %51)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* %52, [8 x i8]* align 512 %53)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %54, i1* align 512 %55)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a5struct.ap_int<4>.10"([5 x %"struct.ap_int<4>"]* noalias "unpacked"="0" %dst, [5 x i4]* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x %"struct.ap_int<4>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a5struct.ap_int<4>.13"([5 x %"struct.ap_int<4>"]* nonnull %dst, [5 x i4]* %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a5struct.ap_int<4>.13"([5 x %"struct.ap_int<4>"]* "unpacked"="0" %dst, [5 x i4]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x %"struct.ap_int<4>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [5 x i4], [5 x i4]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [5 x %"struct.ap_int<4>"], [5 x %"struct.ap_int<4>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
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
define internal fastcc void @"onebyonecpy_hls.p0a110struct.ap_int<4>.20"([110 x i4]* noalias nocapture align 512 "unpacked"="0.0" %dst, [110 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [110 x %"struct.ap_int<4>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a110struct.ap_int<4>.23"([110 x i4]* %dst, [110 x %"struct.ap_int<4>"]* nonnull %src, i64 110)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a110struct.ap_int<4>.23"([110 x i4]* nocapture "unpacked"="0.0" %dst, [110 x %"struct.ap_int<4>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [110 x %"struct.ap_int<4>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [110 x %"struct.ap_int<4>"], [110 x %"struct.ap_int<4>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [110 x i4], [110 x i4]* %dst, i64 0, i64 %for.loop.idx2
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
define internal fastcc void @"onebyonecpy_hls.p0a2struct.ap_int<4>.32"([2 x %"struct.ap_int<4>"]* noalias "unpacked"="0" %dst, [2 x i4]* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x %"struct.ap_int<4>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2struct.ap_int<4>.35"([2 x %"struct.ap_int<4>"]* nonnull %dst, [2 x i4]* %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2struct.ap_int<4>.35"([2 x %"struct.ap_int<4>"]* "unpacked"="0" %dst, [2 x i4]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x %"struct.ap_int<4>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2 x i4], [2 x i4]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [2 x %"struct.ap_int<4>"], [2 x %"struct.ap_int<4>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
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
define internal fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>"([16 x i4]* noalias nocapture align 512 "unpacked"="0.0" %dst, [16 x %"struct.ap_int<4>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x %"struct.ap_int<4>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16struct.ap_int<4>.47"([16 x i4]* %dst, [16 x %"struct.ap_int<4>"]* nonnull %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16struct.ap_int<4>.47"([16 x i4]* nocapture "unpacked"="0.0" %dst, [16 x %"struct.ap_int<4>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
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
define internal fastcc void @"onebyonecpy_hls.p0a16struct.ap_int<4>.51"([16 x %"struct.ap_int<4>"]* noalias "unpacked"="0" %dst, [16 x i4]* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x %"struct.ap_int<4>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16struct.ap_int<4>.54"([16 x %"struct.ap_int<4>"]* nonnull %dst, [16 x i4]* %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16struct.ap_int<4>.54"([16 x %"struct.ap_int<4>"]* "unpacked"="0" %dst, [16 x i4]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
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

declare void @apatb_compute_controller_hw(i1, i1, i32, i1*, i1*, i1, i1*, i1*, i32*, [8 x i8]*, [16 x i4]*, [2 x i32]*, [2 x i32]*, [16 x i4]*, [2 x i4]*, [2 x i16]*, [2 x i16]*, [22 x i16]*, [22 x i16]*, [22 x i16]*, [110 x i4]*, [5 x i4]*, [5 x i16]*, [8 x i32]*, [8 x i32]*, i32, i32, i32, [8 x i8]*, [8 x i32]*, [8 x i32]*, i32, [8 x i32]*, [8 x i8]*, [8 x i8]*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back(i1* noalias "unpacked"="0", i1* noalias readonly align 512 "unpacked"="1", i1* noalias "unpacked"="2", i1* noalias readonly align 512 "unpacked"="3", i1* noalias "unpacked"="4", i1* noalias readonly align 512 "unpacked"="5", i1* noalias "unpacked"="6", i1* noalias readonly align 512 "unpacked"="7", i32* noalias "unpacked"="8", i32* noalias readonly align 512 "unpacked"="9", [8 x i8]* noalias "unpacked"="10", [8 x i8]* noalias readonly align 512 "unpacked"="11", [16 x %"struct.ap_int<4>"]* noalias "unpacked"="12", [16 x i4]* noalias nocapture readonly align 512 "unpacked"="13.0", [2 x i32]* noalias "unpacked"="14", [2 x i32]* noalias readonly align 512 "unpacked"="15", [2 x i32]* noalias "unpacked"="16", [2 x i32]* noalias readonly align 512 "unpacked"="17", [16 x %"struct.ap_int<4>"]* noalias "unpacked"="18", [16 x i4]* noalias nocapture readonly align 512 "unpacked"="19.0", [2 x %"struct.ap_int<4>"]* noalias "unpacked"="20", [2 x i4]* noalias nocapture readonly align 512 "unpacked"="21.0", [2 x i16]* noalias "unpacked"="22", [2 x i16]* noalias readonly align 512 "unpacked"="23", [2 x i16]* noalias "unpacked"="24", [2 x i16]* noalias readonly align 512 "unpacked"="25", [22 x i16]* noalias "unpacked"="26", [22 x i16]* noalias readonly align 512 "unpacked"="27", [22 x i16]* noalias "unpacked"="28", [22 x i16]* noalias readonly align 512 "unpacked"="29", [22 x i16]* noalias "unpacked"="30", [22 x i16]* noalias readonly align 512 "unpacked"="31", [110 x %"struct.ap_int<4>"]* noalias "unpacked"="32", [110 x i4]* noalias nocapture readonly align 512 "unpacked"="33.0", [5 x %"struct.ap_int<4>"]* noalias "unpacked"="34", [5 x i4]* noalias nocapture readonly align 512 "unpacked"="35.0", [5 x i16]* noalias "unpacked"="36", [5 x i16]* noalias readonly align 512 "unpacked"="37", [8 x i32]* noalias "unpacked"="38", [8 x i32]* noalias readonly align 512 "unpacked"="39", [8 x i32]* noalias "unpacked"="40", [8 x i32]* noalias readonly align 512 "unpacked"="41", [8 x i8]* noalias "unpacked"="42", [8 x i8]* noalias readonly align 512 "unpacked"="43", [8 x i32]* noalias "unpacked"="44", [8 x i32]* noalias readonly align 512 "unpacked"="45", [8 x i32]* noalias "unpacked"="46", [8 x i32]* noalias readonly align 512 "unpacked"="47", [8 x i32]* noalias "unpacked"="48", [8 x i32]* noalias readonly align 512 "unpacked"="49", [8 x i8]* noalias "unpacked"="50", [8 x i8]* noalias readonly align 512 "unpacked"="51", [8 x i8]* noalias "unpacked"="52", [8 x i8]* noalias readonly align 512 "unpacked"="53", i1* noalias "unpacked"="54", i1* noalias readonly align 512 "unpacked"="55") unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0a2i32([2 x i32]* %16, [2 x i32]* align 512 %17)
  call fastcc void @onebyonecpy_hls.p0a2i16([2 x i16]* %24, [2 x i16]* align 512 %25)
  call fastcc void @onebyonecpy_hls.p0a22i16([22 x i16]* %28, [22 x i16]* align 512 %29)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* %38, [8 x i32]* align 512 %39)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* %42, [8 x i8]* align 512 %43)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* %48, [8 x i32]* align 512 %49)
  call fastcc void @onebyonecpy_hls.p0a8i8([8 x i8]* %52, [8 x i8]* align 512 %53)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %54, i1* align 512 %55)
  ret void
}

declare void @compute_controller_hw_stub(i1 zeroext, i1 zeroext, i32, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i8* noalias nocapture nonnull readonly, %"struct.ap_int<4>"* noalias nocapture nonnull readonly, i32* noalias nocapture nonnull readonly, i32* noalias nocapture nonnull, %"struct.ap_int<4>"* noalias nocapture nonnull readonly, %"struct.ap_int<4>"* noalias nocapture nonnull readonly, i16* noalias nocapture nonnull readonly, i16* noalias nocapture nonnull, i16* noalias nocapture nonnull readonly, i16* noalias nocapture nonnull, i16* noalias nocapture nonnull readonly, %"struct.ap_int<4>"* noalias nocapture nonnull readonly, %"struct.ap_int<4>"* noalias nocapture nonnull readonly, i16* noalias nocapture nonnull readonly, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull readonly, i32, i32, i32, i8* noalias nocapture nonnull, i32* noalias nocapture nonnull readonly, i32* noalias nocapture nonnull readonly, i32, i32* noalias nocapture nonnull, i8* noalias nocapture nonnull readonly, i8* noalias nocapture nonnull, i1* noalias nocapture nonnull)

define void @compute_controller_hw_stub_wrapper(i1, i1, i32, i1*, i1*, i1, i1*, i1*, i32*, [8 x i8]*, [16 x i4]*, [2 x i32]*, [2 x i32]*, [16 x i4]*, [2 x i4]*, [2 x i16]*, [2 x i16]*, [22 x i16]*, [22 x i16]*, [22 x i16]*, [110 x i4]*, [5 x i4]*, [5 x i16]*, [8 x i32]*, [8 x i32]*, i32, i32, i32, [8 x i8]*, [8 x i32]*, [8 x i32]*, i32, [8 x i32]*, [8 x i8]*, [8 x i8]*, i1*) #5 {
entry:
  %36 = call i8* @malloc(i64 16)
  %37 = bitcast i8* %36 to [16 x %"struct.ap_int<4>"]*
  %38 = call i8* @malloc(i64 16)
  %39 = bitcast i8* %38 to [16 x %"struct.ap_int<4>"]*
  %40 = call i8* @malloc(i64 2)
  %41 = bitcast i8* %40 to [2 x %"struct.ap_int<4>"]*
  %42 = call i8* @malloc(i64 110)
  %43 = bitcast i8* %42 to [110 x %"struct.ap_int<4>"]*
  %44 = call i8* @malloc(i64 5)
  %45 = bitcast i8* %44 to [5 x %"struct.ap_int<4>"]*
  call void @copy_out(i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %6, i1* null, i1* %7, i32* null, i32* %8, [8 x i8]* null, [8 x i8]* %9, [16 x %"struct.ap_int<4>"]* %37, [16 x i4]* %10, [2 x i32]* null, [2 x i32]* %11, [2 x i32]* null, [2 x i32]* %12, [16 x %"struct.ap_int<4>"]* %39, [16 x i4]* %13, [2 x %"struct.ap_int<4>"]* %41, [2 x i4]* %14, [2 x i16]* null, [2 x i16]* %15, [2 x i16]* null, [2 x i16]* %16, [22 x i16]* null, [22 x i16]* %17, [22 x i16]* null, [22 x i16]* %18, [22 x i16]* null, [22 x i16]* %19, [110 x %"struct.ap_int<4>"]* %43, [110 x i4]* %20, [5 x %"struct.ap_int<4>"]* %45, [5 x i4]* %21, [5 x i16]* null, [5 x i16]* %22, [8 x i32]* null, [8 x i32]* %23, [8 x i32]* null, [8 x i32]* %24, [8 x i8]* null, [8 x i8]* %28, [8 x i32]* null, [8 x i32]* %29, [8 x i32]* null, [8 x i32]* %30, [8 x i32]* null, [8 x i32]* %32, [8 x i8]* null, [8 x i8]* %33, [8 x i8]* null, [8 x i8]* %34, i1* null, i1* %35)
  %46 = bitcast [8 x i8]* %9 to i8*
  %47 = bitcast [16 x %"struct.ap_int<4>"]* %37 to %"struct.ap_int<4>"*
  %48 = bitcast [2 x i32]* %11 to i32*
  %49 = bitcast [2 x i32]* %12 to i32*
  %50 = bitcast [16 x %"struct.ap_int<4>"]* %39 to %"struct.ap_int<4>"*
  %51 = bitcast [2 x %"struct.ap_int<4>"]* %41 to %"struct.ap_int<4>"*
  %52 = bitcast [2 x i16]* %15 to i16*
  %53 = bitcast [2 x i16]* %16 to i16*
  %54 = bitcast [22 x i16]* %17 to i16*
  %55 = bitcast [22 x i16]* %18 to i16*
  %56 = bitcast [22 x i16]* %19 to i16*
  %57 = bitcast [110 x %"struct.ap_int<4>"]* %43 to %"struct.ap_int<4>"*
  %58 = bitcast [5 x %"struct.ap_int<4>"]* %45 to %"struct.ap_int<4>"*
  %59 = bitcast [5 x i16]* %22 to i16*
  %60 = bitcast [8 x i32]* %23 to i32*
  %61 = bitcast [8 x i32]* %24 to i32*
  %62 = bitcast [8 x i8]* %28 to i8*
  %63 = bitcast [8 x i32]* %29 to i32*
  %64 = bitcast [8 x i32]* %30 to i32*
  %65 = bitcast [8 x i32]* %32 to i32*
  %66 = bitcast [8 x i8]* %33 to i8*
  %67 = bitcast [8 x i8]* %34 to i8*
  call void @compute_controller_hw_stub(i1 %0, i1 %1, i32 %2, i1* %3, i1* %4, i1 %5, i1* %6, i1* %7, i32* %8, i8* %46, %"struct.ap_int<4>"* %47, i32* %48, i32* %49, %"struct.ap_int<4>"* %50, %"struct.ap_int<4>"* %51, i16* %52, i16* %53, i16* %54, i16* %55, i16* %56, %"struct.ap_int<4>"* %57, %"struct.ap_int<4>"* %58, i16* %59, i32* %60, i32* %61, i32 %25, i32 %26, i32 %27, i8* %62, i32* %63, i32* %64, i32 %31, i32* %65, i8* %66, i8* %67, i1* %35)
  call void @copy_in(i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %6, i1* null, i1* %7, i32* null, i32* %8, [8 x i8]* null, [8 x i8]* %9, [16 x %"struct.ap_int<4>"]* %37, [16 x i4]* %10, [2 x i32]* null, [2 x i32]* %11, [2 x i32]* null, [2 x i32]* %12, [16 x %"struct.ap_int<4>"]* %39, [16 x i4]* %13, [2 x %"struct.ap_int<4>"]* %41, [2 x i4]* %14, [2 x i16]* null, [2 x i16]* %15, [2 x i16]* null, [2 x i16]* %16, [22 x i16]* null, [22 x i16]* %17, [22 x i16]* null, [22 x i16]* %18, [22 x i16]* null, [22 x i16]* %19, [110 x %"struct.ap_int<4>"]* %43, [110 x i4]* %20, [5 x %"struct.ap_int<4>"]* %45, [5 x i4]* %21, [5 x i16]* null, [5 x i16]* %22, [8 x i32]* null, [8 x i32]* %23, [8 x i32]* null, [8 x i32]* %24, [8 x i8]* null, [8 x i8]* %28, [8 x i32]* null, [8 x i32]* %29, [8 x i32]* null, [8 x i32]* %30, [8 x i32]* null, [8 x i32]* %32, [8 x i8]* null, [8 x i8]* %33, [8 x i8]* null, [8 x i8]* %34, i1* null, i1* %35)
  call void @free(i8* %36)
  call void @free(i8* %38)
  call void @free(i8* %40)
  call void @free(i8* %42)
  call void @free(i8* %44)
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
