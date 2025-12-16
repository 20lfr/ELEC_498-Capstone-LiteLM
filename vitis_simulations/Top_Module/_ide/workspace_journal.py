# 2025-12-15T16:25:07.640619
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

comp = client.create_hls_component(name = "top_module",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.create_hls_component(name = "Scheduler_FSM_Control_Mem_Interface",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Scheduler_FSM_Control_Mem_Interface")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp = client.create_hls_component(name = "FSM_and_Control_FSM_top_module",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="FSM_and_Control_FSM_top_module")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

