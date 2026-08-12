local env = require("env")

hl.bind(env.mainMod .. " + Return", hl.dsp.exec_cmd(env.term))
hl.bind(env.mainMod .. " + Space", hl.dsp.window.cycle_next())
hl.bind(env.mainMod .. " + C", hl.dsp.window.close())
hl.bind(env.mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(env.mainMod .. " + W", hl.dsp.exec_cmd("makoctl dismiss"))

hl.bind(env.mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("/home/yohansh/.config/hypr/scripts/rofi-wifi.sh"))
hl.bind(env.mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(env.mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(env.mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("/home/yohansh/.config/hypr/scripts/rofi-prompt.py"))
hl.bind(env.mainMod .. " + SHIFT + Space", hl.dsp.exec_cmd("voxtype record toggle"))

hl.bind(env.mainMod .. " + Q", hl.dsp.focus({ workspace = "1" }))
hl.bind(env.mainMod .. " + A", hl.dsp.focus({ workspace = tostring(env.craft_ws) }))
hl.bind(env.mainMod .. " + O", hl.dsp.focus({ workspace = tostring(env.brow_ws) }))
hl.bind(env.mainMod .. " + E", hl.dsp.focus({ workspace = tostring(env.test_ws) }))
hl.bind(env.mainMod .. " + L", hl.dsp.workspace.toggle_special("read"))
hl.bind(env.mainMod .. " + S", hl.dsp.workspace.toggle_special("notes"))

hl.bind(env.mainMod .. " + SHIFT + Q", hl.dsp.window.move({ workspace = "1" }))
hl.bind(env.mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = tostring(env.craft_ws) }))
hl.bind(env.mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = tostring(env.brow_ws) }))
hl.bind(env.mainMod .. " + SHIFT + E", hl.dsp.window.move({ workspace = tostring(env.test_ws) }))

hl.bind(env.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(env.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 1%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1%-"), { repeating = true })
