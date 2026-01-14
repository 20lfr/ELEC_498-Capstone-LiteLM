set lang "C"
set moduleName "compute_controller"
set moduleIsExternC "1"
set rawDecl ""
set globalVariable ""
set PortList ""
set PortName "reset"
set BitWidth "1"
set ArrayOpt ""
set Const "0"
set Volatile "0"
set Pointer "0"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "char"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "compute_start"
set BitWidth "1"
set ArrayOpt ""
set Const "0"
set Volatile "0"
set Pointer "0"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "char"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "compute_instruction"
set BitWidth "32"
set ArrayOpt ""
set Const "0"
set Volatile "0"
set Pointer "0"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "int"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "compute_ready"
set BitWidth "1"
set ArrayOpt ""
set Const "0"
set Volatile "1"
set Pointer "1"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "void"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "compute_done"
set BitWidth "1"
set ArrayOpt ""
set Const "0"
set Volatile "1"
set Pointer "1"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "void"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "mem_transfer_done"
set BitWidth "1"
set ArrayOpt ""
set Const "0"
set Volatile "0"
set Pointer "0"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "char"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "mem_read_request"
set BitWidth "1"
set ArrayOpt ""
set Const "0"
set Volatile "1"
set Pointer "1"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "void"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "mem_write_request"
set BitWidth "1"
set ArrayOpt ""
set Const "0"
set Volatile "1"
set Pointer "1"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "void"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "mem_op"
set BitWidth "32"
set ArrayOpt ""
set Const "0"
set Volatile "1"
set Pointer "1"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "void"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "OUT_PROJ_valueA"
set BitWidth "8"
set ArrayOpt ""
set Const "0"
set Volatile "1"
set Pointer "1"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "void"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "OUT_PROJ_valueB"
set BitWidth "4"
set ArrayOpt ""
set Const "0"
set Volatile "1"
set Pointer "1"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "void"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "OUT_PROJ_accum"
set BitWidth "32"
set ArrayOpt ""
set Const "0"
set Volatile "1"
set Pointer "1"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "void"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set PortName "error"
set BitWidth "1"
set ArrayOpt ""
set Const "0"
set Volatile "1"
set Pointer "1"
set Reference "0"
set Dims [list 0]
set Interface "wire"
set DataType "void"
set Port [list $PortName $Interface $DataType $Pointer $Dims $Const    $Volatile $ArrayOpt]
lappend PortList $Port
set globalAPint "" 
set returnAPInt "" 
set hasCPPAPInt 0 
set argAPInt "" 
set hasCPPAPFix 0 
set hasSCFix 0 
set hasCBool 0 
set hasCPPComplex 0 
set isTemplateTop 0
set hasHalf 0 
set dataPackList ""
set module [list $moduleName $PortList $rawDecl $argAPInt $returnAPInt $dataPackList]
