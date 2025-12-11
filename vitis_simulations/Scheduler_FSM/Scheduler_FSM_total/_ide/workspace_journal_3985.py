# 2025-12-08T16:28:41.799902
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_total")

comp = client.create_hls_component(name = "Scheduler_FSM_DMA_heads",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Scheduler_FSM_DMA_heads")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

vitis.dispose()

