# 2025-12-11T17:31:05.983227
import vitis

client = vitis.create_client()
client.set_workspace(path="Scheduler_FSM_total")

comp = client.get_component(name="Scheduler_FSM_DMA_heads")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

vitis.dispose()

