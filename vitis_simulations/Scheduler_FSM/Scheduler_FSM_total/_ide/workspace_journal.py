# 2025-12-17T11:36:51.434937
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_total")

client.delete_component(name="Scheduler_FSM")

comp = client.get_component(name="Scheduler_FSM_DMA_heads")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

