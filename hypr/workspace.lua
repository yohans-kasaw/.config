local env = require("env")

hl.workspace_rule({ workspace = "1", monitor = env.monitor_laptop })
hl.workspace_rule({ workspace = tostring(env.craft_ws), monitor = env.monitor_external})
hl.workspace_rule({ workspace = tostring(env.brow_ws), monitor = env.monitor_external})
hl.workspace_rule({ workspace = tostring(env.testing_ws), monitor = env.monitor_external})
hl.workspace_rule({ workspace = tostring(env.reading_ws), monitor = env.monitor_external})

hl.workspace_rule({
  workspace = "special:planning",
  on_created_empty = 'bash -c "cd ~/planning && neovide"',
})

hl.workspace_rule({
  workspace = "special:note",
  on_created_empty = 'bash -c "cd ~/note && neovide"',
})

hl.workspace_rule({
  workspace = "special:focus_read",
  on_created_empty = 'bash -c "cd ~/projects/focus_read && ghostty -e ./focus_read --paste"',
})
