# 2026-01-06T11:42:33.062903
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

comp = client.get_component(name="compute_block")
comp.run(operation="C_SIMULATION")

comp = client.get_component(name="FSM_and_Control_FSM_top_module")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

