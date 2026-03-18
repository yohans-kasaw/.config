#!/usr/bin/env python3
import os
import subprocess
import yaml
from pathlib import Path

# Configuration
CONFIG_PATH = Path("~/.config/hypr/rofi-prompt-storage.yml").expanduser()


def run(cmd, input_str=None):
    """Helper to run shell commands and return output."""
    proc = subprocess.run(
        cmd, input=input_str, capture_output=True, text=True, check=True, shell=True
    )
    return proc.stdout.strip()


def main():
    if not os.path.exists(CONFIG_PATH):
        return

    with open(CONFIG_PATH, "r") as f:
        data = yaml.safe_load(f)
        raw_prompts = [
            p for p in data.get("prompts", []) if "name" in p and "prompt" in p
        ]

    display_map = {}
    for p in raw_prompts:
        name = p["name"]
        # Clean up the prompt snippet (remove newlines for single-line display)
        snippet = p["prompt"].replace("\n", " ").strip()

        display_str = f"{name} -> {snippet}"
        display_map[display_str] = p["prompt"]

    menu_cmd = "rofi -dmenu -i -p 'Prompt:'"

    selected = run(menu_cmd, "\n".join(display_map.keys()))

    if not selected or selected not in display_map:
        return

    clipboard = run("wl-paste -n")

    final_text = display_map[selected].replace("{{clipboard}}", clipboard)

    subprocess.run(["wl-copy", "-n"], input=final_text, text=True)

    print("Copied to clipboard!")


if __name__ == "__main__":
    main()
