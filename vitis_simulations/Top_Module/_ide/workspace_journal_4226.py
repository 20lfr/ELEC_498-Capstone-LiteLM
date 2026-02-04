# 2026-01-30T14:26:37.706285
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

comp = client.get_component(name="Headed_Compute_Controller")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

