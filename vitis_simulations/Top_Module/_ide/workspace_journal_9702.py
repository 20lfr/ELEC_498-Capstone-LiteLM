# 2026-02-04T13:18:17.983308
import vitis

client = vitis.create_client()
client.set_workspace(path="Top_Module")

vitis.dispose()

