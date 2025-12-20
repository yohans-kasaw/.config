#!/bin/bash
if pgrep -x "scrcpy" > /dev/null
then
    pkill -x "scrcpy"
else
    scrcpy --otg --shortcut-mod=lalt &
fi
