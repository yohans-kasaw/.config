#!/bin/bash

STATUS=$(nmcli radio wifi)

if [ "$STATUS" = "enabled" ]; then
    TOGGLE="󰖪  Disable Wi-Fi"

    nmcli dev wifi rescan &>/dev/null &
else
    TOGGLE="󰖩  Enable Wi-Fi"
fi

WIRED_CON=$(nmcli -t -f TYPE,NAME,DEVICE connection show --active | grep "ethernet" | head -n 1 | cut -d: -f2)

WIRED_LINE="󰈂   Wired: No Device"
if [ -n "$WIRED_CON" ]; then
    WIRED_LINE="󰈀  $WIRED_CON (Connected)"
fi

CHOSEN_NETWORK=$(printf "$WIRED_LINE\n$TOGGLE\n$(nmcli --t -f SSID dev wifi list)" | rofi -dmenu -p 'wifi')

if [ -z "$CHOSEN_NETWORK" ]; then
    exit
fi

if [ "$CHOSEN_NETWORK" = "$TOGGLE" ]; then
    if [ "$STATUS" = "enabled" ]; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
    fi
elif [[ "$CHOSEN" == *"Wired:"* ]]; then
    notify-send "Network Info" "Current Wired Status: $WIRED_LINE"
else
    nmcli dev wifi connect "$CHOSEN_NETWORK"
fi
