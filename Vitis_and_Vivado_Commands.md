# Vitis Commands
To Run C Simulation (Example, from repo root):
MODEL_ARCH=phi3-mini-int4-HARDWARE
WORK_DIR=Model-architectures/$MODEL_ARCH/vitis_simulations/Top_module_Non_Debug_Multiple_Token
vitis-run --mode hls --csim --config $WORK_DIR/hls_config.cfg --work_dir $WORK_DIR

To Run Synthesis (Example):
v++ -c --mode hls --config $WORK_DIR/hls_config.cfg --work_dir $WORK_DIR

To Run Package (Example):
vitis-run --mode hls --package --config $WORK_DIR/hls_config.cfg --work_dir $WORK_DIR

# Vivado Commands
