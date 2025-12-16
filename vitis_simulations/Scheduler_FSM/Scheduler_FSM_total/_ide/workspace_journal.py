# 2025-12-15T12:29:31.776905
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

