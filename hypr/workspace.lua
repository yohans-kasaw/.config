local env = require("env")

hl.workspace_rule({ workspace = "1", monitor = env.monitor_laptop })
hl.workspace_rule({ workspace = tostring(env.craft_ws), monitor = env.monitor_external })
hl.workspace_rule({ workspace = tostring(env.brow_ws), monitor = env.monitor_external })
hl.workspace_rule({ workspace = tostring(env.test_ws), monitor = env.monitor_external })
