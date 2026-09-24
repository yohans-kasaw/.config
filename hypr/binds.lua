local env = require("env")

hl.bind(env.mainMod .. " + Return", hl.dsp.exec_cmd(env.term))
hl.bind(env.mainMod .. " + Space", hl.dsp.window.cycle_next())
hl.bind(env.mainMod .. " + period", hl.dsp.window.close())
hl.bind(env.mainMod .. " + comma", hl.dsp.exec_cmd("makoctl dismiss"))

hl.bind(env.mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("/home/yohansh/.config/hypr/scripts/rofi-wifi.sh"))
hl.bind(env.mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(env.mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(env.mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("/home/yohansh/.config/hypr/scripts/rofi-prompt.py"))
hl.bind(env.mainMod .. " + SHIFT + Space", hl.dsp.exec_cmd("voxtype record toggle"))
hl.bind(env.mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))

hl.bind(env.mainMod .. " + Q", hl.dsp.focus({ workspace = "1" }))
hl.bind(env.mainMod .. " + A", hl.dsp.focus({ workspace = tostring(env.craft_ws) }))
hl.bind(env.mainMod .. " + O", hl.dsp.focus({ workspace = tostring(env.brow_ws) }))
hl.bind(env.mainMod .. " + E", hl.dsp.focus({ workspace = tostring(env.testing_ws) }))
hl.bind(env.mainMod .. " + U", hl.dsp.focus({ workspace = tostring(env.reading_ws) }))

hl.bind(env.mainMod .. " + semicolon", hl.dsp.workspace.toggle_special("focus_read"))
hl.bind(env.mainMod .. " + P", hl.dsp.workspace.toggle_special("planning"))
hl.bind(env.mainMod .. " + N", hl.dsp.workspace.toggle_special("note"))

hl.bind(env.mainMod .. " + SHIFT + Q", hl.dsp.window.move({ workspace = "1" }))
hl.bind(env.mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = tostring(env.craft_ws) }))
hl.bind(env.mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = tostring(env.brow_ws) }))
hl.bind(env.mainMod .. " + SHIFT + E", hl.dsp.window.move({ workspace = tostring(env.testing_ws) }))
hl.bind(env.mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = tostring(env.reading_ws) }))

hl.bind(env.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(env.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 4%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true })


local function set_brightness(internal_val, external_command)
    local monitor = hl.get_active_monitor()

    if monitor.name == "eDP-1" then
        hl.dispatch(hl.dsp.exec_cmd("brightnessctl set " .. internal_val .. "%"))
    else
        hl.dispatch(hl.dsp.exec_cmd(external_command))
    end
end

hl.bind(env.mainMod .. " + 1", function()
    set_brightness(0, "ddcutil setvcp 10 8; ddcutil setvcp 12 25")
end)

hl.bind(env.mainMod .. " + 2", function()
    set_brightness(8, "ddcutil setvcp 10 10; ddcutil setvcp 12 45")
end)

hl.bind(env.mainMod .. " + 3", function()
    set_brightness(70, "ddcutil setvcp 10 35; ddcutil setvcp 12 70")
end)
