#!/bin/bash
# Query GPU usage: utilization (%), memory used (MiB), memory total (MiB)
gpu_info=$(nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits)

# Parse the comma-separated output
util=$(echo "$gpu_info" | awk -F', ' '{print $1}')
mem_used=$(echo "$gpu_info" | awk -F', ' '{print $2}')
mem_total=$(echo "$gpu_info" | awk -F', ' '{print $3}')

# Convert to GB
mem_used_gb=$(awk "BEGIN {printf \"%.1f\", $mem_used/1024}")
mem_total_gb=$(awk "BEGIN {printf \"%.1f\", $mem_total/1024}")

# Define formatting (optional: minimal logic for classes)
# You could add logic here to change "class" to "critical" if util > 90

# Output JSON for Waybar
# Text: Icon + Utilization
# Tooltip: Detailed VRAM usage
echo "{\"text\": \" $util%\", \"tooltip\": \"GPU Usage: $util%\nVRAM: $mem_used_gb / $mem_total_gb GB\", \"class\": \"custom-gpu\"}"
