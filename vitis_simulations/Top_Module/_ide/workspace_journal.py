# 2026-01-24T18:40:15.214763
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

comp = client.get_component(name="Top_Module")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

