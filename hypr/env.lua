local env = {
  mainMod = "SUPER",
  term = "ghostty",
  brow = "zen",
  test_brow = "firefox",
  craft_ws = 2,
  brow_ws = 3,
  test_ws = 4,
  monitor_laptop = "eDP-1",
  monitor_external = "HDMI-A-1",
  laptop_keyboard_name = "ite-tech.-inc.-ite-device(8258)-keyboard",
}

hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

return env
