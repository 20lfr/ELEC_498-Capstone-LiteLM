# 2026-02-03T23:53:48.274479
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

comp = client.get_component(name="Compute_Controller")
comp.run(operation="C_SIMULATION")

comp = client.get_component(name="Top_Module")
comp.run(operation="C_SIMULATION")

