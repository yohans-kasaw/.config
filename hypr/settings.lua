local env = require("env")

hl.monitor({ output = env.monitor_laptop, mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = env.monitor_external, mode = "preferred", position = "auto", scale = 1 })

hl.config({
  input = {
    kb_layout = "us",
    resolve_binds_by_sym = true,
    follow_mouse = 1,
    sensitivity = 0,
    repeat_rate = 100,
    repeat_delay = 200,
    touchpad = {
      natural_scroll = false,
      disable_while_typing = true,
      clickfinger_behavior = true,
    },
  },
})

hl.device({
  name = env.laptop_keyboard_name,
  kb_variant = "dvorak",
  kb_options = "caps:swapescape",
})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

hl.config({
  cursor = {
    inactive_timeout = 100,
    default_monitor = env.monitor_external,
    hide_on_key_press = true,
    warp_back_after_non_mouse_input = false,
  },
})

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 1,
    allow_tearing = false,
    col = {
      active_border = {
        colors = { "rgba(33ccff4a)", "rgba(00ff994a)" },
        angle = 45,
      },
      inactive_border = "rgba(5959591a)",
    },
  },
})

hl.config({
  decoration = {
    rounding = 10,
    shadow = { enabled = false },
    blur = { enabled = false },
  },
})

hl.config({
  misc = {
    vrr = 1,
    focus_on_activate = true,
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    allow_session_lock_restore = true,
  },
})

hl.config({
  animations = { enabled = false },
})

hl.config({
    binds = {
        hide_special_on_workspace_change = true,
    },
})
