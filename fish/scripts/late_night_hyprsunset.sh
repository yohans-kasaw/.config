#!/bin/bash
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export WAYLAND_DISPLAY=wayland-1

# Get current hour in 24-hour format
CURRENT_HOUR=$(date +%H)
echo "_--_----------_-----" >> /tmp/hyprsunset.log
echo $(date) >> /tmp/hyprsunset.log
echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" >> /tmp/hyprsunset.log
echo "WAYLAND_DISPLAY=$WAYLAND_DISPLAY" >> /tmp/hyprsunset.log

output=$(pidof hyprsunset)
if [ -n "$output" ]; then
    echo "hyprsunset aleady running" >> /tmp/hyprsunset.log
else
    hyprsunset -t 3700 >> /tmp/hyprsunset.log 2>&1 &
    echo "Started Hyprsunset at $(date)" >> /tmp/hyprsunset.log
    notify-send "Evening mode activated" "Hypridle and Hyprsunset started"
fi
