#!/bin/bash
# Usage: ./delayed_switch.sh [workspace_number] [delay_in_seconds]

TARGET=$1
DELAY=${2:-2} 
canberra-gtk-play -i message
sleep $DELAY
hyprctl dispatch workspace "$TARGET"
