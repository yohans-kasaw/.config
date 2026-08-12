local env = require("env")

hl.workspace_rule({
  workspace = "special:notes",
  on_created_empty = 'bash -c "cd ~/obsidian && ghostty -e nvim"',
})

hl.workspace_rule({
  workspace = "special:read",
  on_created_empty = 'bash -c "cd ~/projects/focus_read && ghostty -e ./focus_read --paste"',
})

hl.window_rule({
  name = "suppress-maximize",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "ignore-phantom-windows",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.window_rule({
  name = "test-browser",
  match = { class = "^" .. env.test_brow .. "$" },
  workspace = tostring(env.test_ws),
})

hl.window_rule({
  name = "browser",
  match = { class = "^" .. env.brow .. "$" },
  workspace = tostring(env.brow_ws),
})

hl.window_rule({
  name = "norrow-windows",
  match = { class = "^.*" .. env.term .. ".*" },
  size = { "monitor_w*0.8", "monitor_h" },
  center = true,
  pseudo = true,
})

hl.window_rule({
  name = "read-popups-notes",
  match = { workspace = "name:special:notes" },
  size = { "monitor_w", "monitor_h" },
})

hl.window_rule({
  name = "read-popups-read",
  match = { workspace = "name:special:read" },
  size = { "monitor_w", "monitor_h" },
})
