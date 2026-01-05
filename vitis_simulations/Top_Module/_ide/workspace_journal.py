# 2026-01-05T17:14:16.479192
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

comp = client.get_component(name="FSM_and_Control_FSM_top_module")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

