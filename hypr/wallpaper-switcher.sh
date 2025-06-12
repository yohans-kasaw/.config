#!/bin/bash

# Path to your wallpapers directory
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Path to hyprpaper config file
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Get a random wallpaper from the directory
RANDOM_WALLPAPER=$(ls "$WALLPAPER_DIR" | shuf -n 1)
FULL_PATH="$WALLPAPER_DIR/$RANDOM_WALLPAPER"

# Create a temporary file
temp_file=$(mktemp)

# Read the config file and replace the wallpaper paths
while IFS= read -r line; do
    if [[ $line =~ ^preload ]]; then
        echo "preload = $FULL_PATH"
    elif [[ $line =~ ^wallpaper ]]; then
        # Extract the monitor name from the line
        monitor=$(echo "$line" | cut -d',' -f1 | cut -d' ' -f3)
        echo "wallpaper = $monitor,$FULL_PATH"
    else
        echo "$line"
    fi
done < "$CONFIG_FILE" > "$temp_file"

# Replace the original config with the new one
mv "$temp_file" "$CONFIG_FILE"

# Kill existing hyprpaper instance and start a new one
killall hyprpaper
hyprpaper & disown

echo "Wallpaper changed to: $RANDOM_WALLPAPER"
