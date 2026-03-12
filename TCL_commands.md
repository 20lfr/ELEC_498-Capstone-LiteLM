# Vivado
remove_files [get_files -filter {FILE_TYPE == "Verilog"}]
remove_files [get_files -filter {FILE_TYPE == "SystemVerilog"}]
remove_files [get_files -filter {FILE_TYPE == "Verilog" || FILE_TYPE == "SystemVerilog"}]