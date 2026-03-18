#!/usr/bin/env bash

session=$(sesh list | rofi -dmenu -p "⚡ Sesh" -i)

if [ -n "$session" ]; then
    kitty --detach --title "sesh: $session" sesh connect "$session"
fi
