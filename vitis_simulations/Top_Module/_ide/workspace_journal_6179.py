<<<<<<<< HEAD:vitis_simulations/Top_Module/_ide/workspace_journal_6179.py
# 2026-01-05T17:14:16.479192
========
# 2026-01-31T11:42:46.432089
>>>>>>>> main:vitis_simulations/Top_Module/_ide/workspace_journal.py
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

comp = client.get_component(name="Compute_Controller")
comp.run(operation="C_SIMULATION")

comp = client.get_component(name="Headed_Compute_Controller")
comp.run(operation="C_SIMULATION")

client.delete_component(name="compute_block")

client.delete_component(name="componentName")

comp = client.get_component(name="Headed_Compute_Controller")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

<<<<<<<< HEAD:vitis_simulations/Top_Module/_ide/workspace_journal_6179.py
========
comp = client.get_component(name="Top_Module")
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

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

>>>>>>>> main:vitis_simulations/Top_Module/_ide/workspace_journal.py
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

<<<<<<<< HEAD:vitis_simulations/Top_Module/_ide/workspace_journal_6179.py
comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

========
>>>>>>>> main:vitis_simulations/Top_Module/_ide/workspace_journal.py
comp.run(operation="SYNTHESIS")

vitis.dispose()

