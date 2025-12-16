# 1 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.cpp"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 376 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "/tools/Xilinx/2025.1/Vitis/common/technology/autopilot/etc/autopilot_ssdm_op.h" 1
# 105 "/tools/Xilinx/2025.1/Vitis/common/technology/autopilot/etc/autopilot_ssdm_op.h"
extern "C" {






    void _ssdm_op_IfRead(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_IfWrite(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_IfNbRead(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_IfNbWrite(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_IfCanRead(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_IfCanWrite(...) __attribute__ ((nothrow)) __attribute__((overloadable));


    void _ssdm_StreamRead(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_StreamWrite(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_StreamNbRead(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_StreamNbWrite(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_StreamCanRead(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_StreamCanWrite(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned _ssdm_StreamSize(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_ReadReq(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_Read(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_WriteReq(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_Write(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_NbReadReq(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_CanReadReq(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_NbWriteReq(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    unsigned int __attribute__ ((bitwidth(1))) _ssdm_op_CanWriteReq(...) __attribute__ ((nothrow)) __attribute__((overloadable));




    void _ssdm_op_MemShiftRead(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_PrintNone(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_PrintInt(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_PrintDouble(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_Wait(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_Poll(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_Return(...) __attribute__ ((nothrow)) __attribute__((overloadable));


    void _ssdm_op_SpecSynModule(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecTopModule(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecProcessDecl(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecProcessDef(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecPort(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecConnection(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecChannel(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecSensitive(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecModuleInst(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecPortMap(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecReset(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecPlatform(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecClockDomain(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecPowerDomain(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    int _ssdm_op_SpecRegionBegin(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    int _ssdm_op_SpecRegionEnd(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecLoopName(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecLoopTripCount(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    int _ssdm_op_SpecStateBegin(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    int _ssdm_op_SpecStateEnd(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecInterface(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecPipeline(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecDataflowPipeline(...) __attribute__ ((nothrow)) __attribute__((overloadable));


    void _ssdm_op_SpecLatency(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecParallel(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecProtocol(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecOccurrence(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecResource(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecResourceLimit(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecCHCore(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecFUCore(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecIFCore(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecIPCore(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecMemCore(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecExt(...) __attribute__ ((nothrow)) __attribute__((overloadable));




    void _ssdm_SpecArrayDimSize(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_RegionBegin(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_RegionEnd(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_InlineAll(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_InlineLoop(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_Inline(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_InlineSelf(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_InlineRegion(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_SpecArrayMap(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_SpecArrayPartition(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_SpecArrayReshape(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_SpecStream(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecStable(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecStableContent(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecBindPort(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecPipoDepth(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_SpecExpr(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_SpecExprBalance(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_SpecDependence(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_SpecLoopMerge(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_SpecLoopFlatten(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_SpecLoopRewind(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_SpecFuncInstantiation(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_SpecFuncBuffer(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_SpecFuncExtract(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_SpecConstant(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_DataPack(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_SpecDataPack(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void _ssdm_op_SpecBitsMap(...) __attribute__ ((nothrow)) __attribute__((overloadable));
    void _ssdm_op_SpecLicense(...) __attribute__ ((nothrow)) __attribute__((overloadable));

    void __xilinx_ip_top(...) __attribute__ ((nothrow)) __attribute__((overloadable));


}
# 2 "<built-in>" 2
# 1 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.cpp" 2
# 1 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.hpp" 1

# 1 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/cstdint" 1 3
# 33 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/cstdint" 3





# 1 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/c++config.h" 1 3
# 236 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/c++config.h" 3
namespace std
{
  typedef long unsigned int size_t;
  typedef long int ptrdiff_t;


  typedef decltype(nullptr) nullptr_t;

}
# 258 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/c++config.h" 3
namespace std
{
  inline namespace __cxx11 __attribute__((__abi_tag__ ("cxx11"))) { }
}
namespace __gnu_cxx
{
  inline namespace __cxx11 __attribute__((__abi_tag__ ("cxx11"))) { }
}
# 508 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/c++config.h" 3
# 1 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/os_defines.h" 1 3
# 39 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/os_defines.h" 3
# 1 "/usr/include/features.h" 1 3 4
# 394 "/usr/include/features.h" 3 4
# 1 "/usr/include/features-time64.h" 1 3 4
# 20 "/usr/include/features-time64.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 21 "/usr/include/features-time64.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/timesize.h" 1 3 4
# 19 "/usr/include/x86_64-linux-gnu/bits/timesize.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 20 "/usr/include/x86_64-linux-gnu/bits/timesize.h" 2 3 4
# 22 "/usr/include/features-time64.h" 2 3 4
# 395 "/usr/include/features.h" 2 3 4
# 480 "/usr/include/features.h" 3 4
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 481 "/usr/include/features.h" 2 3 4
# 502 "/usr/include/features.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 1 3 4
# 576 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 577 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/long-double.h" 1 3 4
# 578 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 2 3 4
# 503 "/usr/include/features.h" 2 3 4
# 526 "/usr/include/features.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 1 3 4
# 10 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 2 3 4
# 527 "/usr/include/features.h" 2 3 4
# 40 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/os_defines.h" 2 3
# 509 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/c++config.h" 2 3


# 1 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/cpu_defines.h" 1 3
# 512 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/x86_64-pc-linux-gnu/bits/c++config.h" 2 3
# 39 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/cstdint" 2 3


# 1 "/tools/Xilinx/2025.1/lnx64/tools/clang-3.9-csynth/lib/clang/7.0.0/include/stdint.h" 1 3
# 63 "/tools/Xilinx/2025.1/lnx64/tools/clang-3.9-csynth/lib/clang/7.0.0/include/stdint.h" 3
# 1 "/usr/include/stdint.h" 1 3 4
# 26 "/usr/include/stdint.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/libc-header-start.h" 1 3 4
# 27 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/types.h" 1 3 4
# 27 "/usr/include/x86_64-linux-gnu/bits/types.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 28 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/timesize.h" 1 3 4
# 19 "/usr/include/x86_64-linux-gnu/bits/timesize.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 20 "/usr/include/x86_64-linux-gnu/bits/timesize.h" 2 3 4
# 29 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;






typedef __int8_t __int_least8_t;
typedef __uint8_t __uint_least8_t;
typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
typedef __int64_t __int_least64_t;
typedef __uint64_t __uint_least64_t;



typedef long int __quad_t;
typedef unsigned long int __u_quad_t;







typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;
# 141 "/usr/include/x86_64-linux-gnu/bits/types.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/typesizes.h" 1 3 4
# 142 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/time64.h" 1 3 4
# 143 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;
typedef long int __suseconds64_t;

typedef int __daddr_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;


typedef long int __fsword_t;

typedef long int __ssize_t;


typedef long int __syscall_slong_t;

typedef unsigned long int __syscall_ulong_t;



typedef __off64_t __loff_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;




typedef int __sig_atomic_t;
# 28 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wchar.h" 1 3 4
# 29 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 30 "/usr/include/stdint.h" 2 3 4




# 1 "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h" 1 3 4
# 24 "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h" 3 4
typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
# 35 "/usr/include/stdint.h" 2 3 4


# 1 "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h" 1 3 4
# 24 "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h" 3 4
typedef __uint8_t uint8_t;
typedef __uint16_t uint16_t;
typedef __uint32_t uint32_t;
typedef __uint64_t uint64_t;
# 38 "/usr/include/stdint.h" 2 3 4



# 1 "/usr/include/x86_64-linux-gnu/bits/stdint-least.h" 1 3 4
# 25 "/usr/include/x86_64-linux-gnu/bits/stdint-least.h" 3 4
typedef __int_least8_t int_least8_t;
typedef __int_least16_t int_least16_t;
typedef __int_least32_t int_least32_t;
typedef __int_least64_t int_least64_t;


typedef __uint_least8_t uint_least8_t;
typedef __uint_least16_t uint_least16_t;
typedef __uint_least32_t uint_least32_t;
typedef __uint_least64_t uint_least64_t;
# 42 "/usr/include/stdint.h" 2 3 4





typedef signed char int_fast8_t;

typedef long int int_fast16_t;
typedef long int int_fast32_t;
typedef long int int_fast64_t;
# 60 "/usr/include/stdint.h" 3 4
typedef unsigned char uint_fast8_t;

typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long int uint_fast64_t;
# 76 "/usr/include/stdint.h" 3 4
typedef long int intptr_t;


typedef unsigned long int uintptr_t;
# 90 "/usr/include/stdint.h" 3 4
typedef __intmax_t intmax_t;
typedef __uintmax_t uintmax_t;
# 64 "/tools/Xilinx/2025.1/lnx64/tools/clang-3.9-csynth/lib/clang/7.0.0/include/stdint.h" 2 3
# 42 "/tools/Xilinx/2025.1/Vitis/tps/lnx64/gcc-8.3.0/lib/gcc/x86_64-pc-linux-gnu/8.3.0/../../../../include/c++/8.3.0/cstdint" 2 3




namespace std
{
  using ::int8_t;
  using ::int16_t;
  using ::int32_t;
  using ::int64_t;

  using ::int_fast8_t;
  using ::int_fast16_t;
  using ::int_fast32_t;
  using ::int_fast64_t;

  using ::int_least8_t;
  using ::int_least16_t;
  using ::int_least32_t;
  using ::int_least64_t;

  using ::intmax_t;
  using ::intptr_t;

  using ::uint8_t;
  using ::uint16_t;
  using ::uint32_t;
  using ::uint64_t;

  using ::uint_fast8_t;
  using ::uint_fast16_t;
  using ::uint_fast32_t;
  using ::uint_fast64_t;

  using ::uint_least8_t;
  using ::uint_least16_t;
  using ::uint_least32_t;
  using ::uint_least64_t;

  using ::uintmax_t;
  using ::uintptr_t;
}
# 3 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.hpp" 2
# 1 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top_params.hpp" 1
# 123 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top_params.hpp"
constexpr int NUM_HEADS = 4;
constexpr int NUM_LAYERS = 2;
constexpr int NUM_WO_TILES = 4;
constexpr int NUM_W1_TILES = 4;
constexpr int NUM_W2_TILES = 4;
constexpr int NUM_LOGIT_TILES = 2;




enum SchedState {
    S_IDLE,
    S_STREAM_IN,
    S_LAYER_COUNT,
    S_ATTENTION_HEADS,
    S_HEAD_CONCAT,
    S_OUT_PROJECTION,
    S_REQUANT1,
    S_RES_ADD_1,
    S_LAYER_NORM_1,
    S_REQUANT2,
    S_FFN,
    S_REQUANT3,
    S_RES_ADD_2,
    S_LAYER_NORM_2,
    S_REQUANT4,
    S_LOOP_CHECK,
    S_STREAM_OUT
};


enum class LnPhase : uint8_t {
    SUM = 0,
    SUMSQ,
    MEAN,
    EYY,
    VAR,
    VAR_EPS,
    INV_STD,
    NORM,
    SCALE,
    SHIFT,
    DONE
};





enum class HeadPhase : uint8_t {
    IDLE = 0,
    Q,
    K,
    K_REQUANT,
    K_WRITEBACK,
    V,
    V_REQUANT,
    V_WRITEBACK,
    REQUANT_Q,
    ATT_SCORES,
    VALUE_SCALE_CLAMP,
    ATT_SOFTMAX,
    ATT_VALUE,
    REQUANT2,
    DONE
};

enum ComputeOp : uint8_t {
    CMP_NONE = 0,
    CMP_Q,
    CMP_K,
    CMP_K_REQUANT,
    CMP_V,
    CMP_V_REQUANT,
    CMP_REQUANT_Q,
    CMP_ATT_SCORES,
    CMP_VALUE_SCALE,
    CMP_SOFTMAX,
    CMP_ATT_VALUE,
    CMP_REQUANT2,

    CMP_HEAD_REQUANT,
    CMP_CONCAT,
    CMP_OUT_PROJ,
    CMP_REQUANT1,
    CMP_RESID0,
    CMP_LN0,
    CMP_REQUANT3,
    CMP_FFN_W1,
    CMP_FFN_ACT,
    CMP_FFN_W2,
    CMP_REQUANT4,
    CMP_RESID1,
    CMP_LN1,
    CMP_DEQUANT,
    CMP_LOGITS,


    CMP_LN0_SUM,
    CMP_LN0_SUMSQ,
    CMP_LN0_MEAN,
    CMP_LN0_EYY,
    CMP_LN0_VAR,
    CMP_LN0_VAR_EPS,
    CMP_LN0_INV_STD,
    CMP_LN0_NORM,
    CMP_LN0_SCALE,
    CMP_LN0_SHIFT,
    CMP_LN1_SUM,
    CMP_LN1_SUMSQ,
    CMP_LN1_MEAN,
    CMP_LN1_EYY,
    CMP_LN1_VAR,
    CMP_LN1_VAR_EPS,
    CMP_LN1_INV_STD,
    CMP_LN1_NORM,
    CMP_LN1_SCALE,
    CMP_LN1_SHIFT
};

enum DmaSel : uint8_t {
    DMASEL_NONE = 0,
    DMASEL_WQ,
    DMASEL_WK,
    DMASEL_WV,
    DMASEL_CTX_K,
    DMASEL_CTX_V,
    DMASEL_K_WRITE,
    DMASEL_V_WRITE,
    DMASEL_WO,
    DMASEL_W1,
    DMASEL_W2,
    DMASEL_WLOGIT
};

struct HeadCtx {
    int layer_stamp = -1;
    int head_idx = -1;
    HeadPhase phase = HeadPhase::IDLE;
    bool compute_ready = false;
    bool compute_done = false;
    bool compute_start = false;
    ComputeOp compute_op = ComputeOp::CMP_NONE;
    ComputeOp last_compute_op = ComputeOp::CMP_NONE;
    DmaSel last_wl_addr = DmaSel::DMASEL_NONE;

    bool wl_ready = false;
    bool wl_start = false;
    DmaSel wl_addr_sel = DmaSel::DMASEL_NONE;
    int wl_layer = -1;
    int wl_head = -1;
    bool dma_done = false;


    bool start_head = false;


    bool q_started = false;
    bool k_started = false;
    bool k_requant_started = false;
    bool v_started = false;
    bool v_requant_started = false;
    bool requant_q_started = false;
    bool att_scores_started = false;
    bool val_scale_started = false;
    bool softmax_started = false;
    bool att_value_started = false;
    bool requant2_started = false;

    bool q_compute_done = false;
    bool k_compute_done = false;
    bool k_requant_compute_done = false;
    bool v_compute_done = false;
    bool v_requant_compute_done = false;
    bool requant_q_compute_done = false;
    bool att_scores_compute_done = false;
    bool val_scale_compute_done = false;
    bool softmax_compute_done = false;
    bool att_value_compute_done = false;
    bool requant2_compute_done = false;

    bool q_dma_done = false;
    bool k_dma_done = false;
    bool v_dma_done = false;
    bool att_scores_dma_done = false;
    bool att_value_dma_done = false;
};






constexpr uint32_t CTRL_RESETN_BIT = 1u << 0;
constexpr uint32_t CTRL_START_BIT = 1u << 1;

constexpr uint32_t IRQ_CLEAR_BIT = 1u << 0;
constexpr uint32_t IRQ_ERROR_BIT = 1u << 1;
constexpr uint32_t IRQ_INFER_DONE_BIT = 1u << 2;
constexpr uint32_t IRQ_DMA_DONE_BIT = 1u << 3;


constexpr uint32_t STATUS_INVALID_ADDR = 1u << 0;
constexpr uint32_t STATUS_INVALID_OP = 1u << 1;
constexpr uint32_t STATUS_BUSY_BIT = 1u << 2;





enum class ControlReg : uint32_t {
    CONTROL = 0x00,
    LAYER_INDEX = 0x04,
    STATUS = 0x08,
    IRQ_STATUS = 0x0C,
    IRQ_ENABLE = 0x10,

    DMA_LAYER_LEN = 0x14,
    DMA_HEAD_LEN = 0x18,
    DMA_TILE_LEN = 0x1C,

    LAYER_STRIDE = 0x20,
    HEAD_STRIDE = 0x24,
    TILE_STRIDE = 0x28,

    WQ_BASE_ADDR = 0x2C,
    WK_BASE_ADDR = 0x30,
    WV_BASE_ADDR = 0x34,
    WO_BASE_ADDR = 0x38,
    W1_BASE_ADDR = 0x3C,
    W2_BASE_ADDR = 0x40,

    K_CACHE_ADDR = 0x44,
    V_CACHE_ADDR = 0x48,

    LOGIT_SCALE_QV = 0x4C,
    SCALE_Q = 0x50,
    ZERO_POINT_Q = 0x54,
    SCALE_K = 0x58,
    ZERO_POINT_K = 0x5C,
    SCALE_V = 0x60,
    ZERO_POINT_V = 0x64,

    RESERVED_DEBUG = 0x68
};


struct ControlMemSpace {
    uint32_t control = CTRL_RESETN_BIT;
    uint32_t layer_index = 0;
    uint32_t status = 0;
    uint32_t irq_status = 0;
    uint32_t irq_enable = IRQ_CLEAR_BIT | IRQ_ERROR_BIT | IRQ_INFER_DONE_BIT | IRQ_DMA_DONE_BIT;

    uint32_t dma_layer_len = 0;
    uint32_t dma_head_len = 0;
    uint32_t dma_tile_len = 0;

    uint32_t layer_stride = 0;
    uint32_t head_stride = 0;
    uint32_t tile_stride = 0;

    uint32_t wq_base_addr = 0;
    uint32_t wk_base_addr = 0;
    uint32_t wv_base_addr = 0;
    uint32_t wo_base_addr = 0;
    uint32_t w1_base_addr = 0;
    uint32_t w2_base_addr = 0;

    uint32_t k_cache_addr = 0;
    uint32_t v_cache_addr = 0;

    uint32_t logit_scale_qv = 0;
    uint32_t scale_q = 0;
    uint32_t zero_point_q = 0;
    uint32_t scale_k = 0;
    uint32_t zero_point_k = 0;
    uint32_t scale_v = 0;
    uint32_t zero_point_v = 0;

    uint32_t reserved_debug = 0;
};
# 4 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.hpp" 2
# 1 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/Scheduler_FSM/src-hls/Scheduler_FSM.hpp" 1



# 1 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/Scheduler_FSM/src-hls/Head_Helpers/head_helpers.hpp" 1







constexpr int HEADS_PARALLEL = 2;

void init_head_ctx(HeadCtx &ctx, int layer_idx, int head_idx);



bool run_single_head(
    HeadCtx &ctx,
    int layer_idx,
    bool start
);

bool drive_group_head_phase(
    HeadCtx (&head_ctx_ref)[HEADS_PARALLEL],
    int group_idx,
    int layer_idx,
    bool start
);
# 5 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/Scheduler_FSM/src-hls/Scheduler_FSM.hpp" 2


constexpr int NUM_HEAD_GROUPS = (NUM_HEADS + HEADS_PARALLEL - 1) / HEADS_PARALLEL;




bool LayerNorm(
    LnPhase &phase,
    bool &ln_started,
    bool &ln_compute_done,
    bool compute_ready,
    bool &compute_start,
    ComputeOp &compute_op,
    const ComputeOp ops[10]
);





void scheduler_hls(
    ControlMemSpace ctrl_mem,
    bool axis_in_valid,
    bool axis_in_last,
    bool &axis_in_ready,
    bool wl_ready,
    bool &wl_start,
    DmaSel &wl_addr_sel,
    int &wl_layer,
    int &wl_head,
    int &wl_tile,
    bool dma_done,
    bool compute_ready,
    bool compute_done,
    HeadCtx (&head_ctx_ref)[NUM_HEADS],
    bool &compute_start,
    ComputeOp &compute_op,
    bool stream_ready,
    bool &stream_start,
    bool stream_done,
    bool &done,
    SchedState &STATE
);
# 5 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.hpp" 2
# 1 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/ControlMemInterface/ControlMemInterface.hpp" 1








uint32_t ctrl_read(const ControlMemSpace &mem, ControlReg reg);
void ctrl_write(ControlMemSpace &mem, ControlReg reg, uint32_t value);


inline bool ctrl_start(const ControlMemSpace &mem) { return (mem.control & CTRL_START_BIT) != 0; }
inline bool ctrl_reset_n(const ControlMemSpace &mem) { return (mem.control & CTRL_RESETN_BIT) != 0; }

void init_mem_space(ControlMemSpace& mem);
void ControlMemInterface(
    ControlMemSpace &mem,
    ControlReg address,
    uint32_t data_in,
    uint32_t &data_out,

    bool read_control,
    bool write_control,

    bool chip_enable,
    bool reset_n

);
# 6 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.hpp" 2


__attribute__((sdx_kernel("transformer_top", 0))) void transformer_top(
    bool axis_in_valid,
    bool axis_in_last,
    bool &axis_in_ready,
    bool dma_done,
    bool compute_ready,
    bool compute_done,
    HeadCtx (&head_ctx_ref)[NUM_HEADS],
    bool &compute_start,
    ComputeOp &compute_op,
    bool stream_ready,
    bool &stream_start,
    bool stream_done,
    bool wl_ready,
    bool &wl_start,
    DmaSel &wl_addr_sel,
    int &wl_layer,
    int &wl_head,
    int &wl_tile,
    ControlReg ctrl_addr,
    uint32_t ctrl_data_in,
    uint32_t ctrl_data_out,
    bool ctrl_read_en,
    bool ctrl_write_en,
    bool ctrl_chip_en,
    bool ctrl_resetn_in,
    SchedState &dbg_state,
    bool done
);
# 2 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.cpp" 2


__attribute__((sdx_kernel("transformer_top", 0))) void transformer_top(



    bool axis_in_valid,
    bool axis_in_last,
    bool &axis_in_ready,




    bool dma_done,




    bool compute_ready,
    bool compute_done,
    HeadCtx (&head_ctx_ref)[NUM_HEADS],
    bool &compute_start,
    ComputeOp &compute_op,




    bool stream_ready,
    bool &stream_start,
    bool stream_done,
# 40 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.cpp"
    bool wl_ready,
    bool &wl_start,
    DmaSel &wl_addr_sel,

    int &wl_layer,
    int &wl_head,
    int &wl_tile,


    ControlReg ctrl_addr,
    uint32_t ctrl_data_in,
    uint32_t ctrl_data_out,
    bool ctrl_read_en,
    bool ctrl_write_en,
    bool ctrl_chip_en,
    bool ctrl_resetn_in,

    SchedState &dbg_state,
    bool done


) {
#line 1 "directive"
#pragma HLSDIRECTIVE TOP name=transformer_top
# 61 "/home/luka/Scripting/ELEC_498-Capstone-LiteLM/HLS-Verilog/top.cpp"

#pragma HLS INLINE off


 static ControlMemSpace ctrl_mem;


    ControlMemInterface(
        ctrl_mem,
        ctrl_addr,
        ctrl_data_in,
        ctrl_data_out,
        ctrl_read_en,
        ctrl_write_en,
        ctrl_chip_en,
        ctrl_resetn_in
    );





    bool error = false;






    scheduler_hls(
        ctrl_mem,
        axis_in_valid,
        axis_in_last,
        axis_in_ready,
        wl_ready,
        wl_start,
        wl_addr_sel,
        wl_layer,
        wl_head,
        wl_tile,
        dma_done,
        compute_ready,
        compute_done,
        head_ctx_ref,
        compute_start,
        compute_op,
        stream_ready,
        stream_start,
        stream_done,
        done,
        dbg_state
    );





}
