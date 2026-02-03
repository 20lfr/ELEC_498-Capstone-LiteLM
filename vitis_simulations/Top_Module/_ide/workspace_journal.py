# 2026-01-31T11:42:46.432089
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

comp = client.get_component(name="Compute_Controller")
comp.run(operation="C_SIMULATION")

comp = client.get_component(name="Headed_Compute_Controller")
comp.run(operation="C_SIMULATION")

