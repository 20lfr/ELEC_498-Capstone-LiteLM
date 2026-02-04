# 2026-01-25T13:50:10.958516
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

comp = client.get_component(name="Compute_Controller_Layer_Norm")
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

