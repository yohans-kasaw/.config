#!/bin/bash
if pgrep -x "scrcpy" > /dev/null
then
    pkill -x "scrcpy"
    pactl set-source-volume @DEFAULT_SOURCE@ 5%
else
    pactl set-source-volume @DEFAULT_SOURCE@ 0%
    scrcpy --otg --shortcut-mod=lalt &
fi
