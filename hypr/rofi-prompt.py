#!/usr/bin/env python3
import os
import subprocess
import yaml
import json
from pathlib import Path

# Configuration
CONFIG_PATH = Path("~/.config/hypr/rofi-prompt-storage.yml").expanduser()
STATE_PATH = Path("~/.cache/rofi-prompt-state.json").expanduser()
DECAY_FACTOR = 0.9  # Lower = forgets faster
BOOST_VALUE = 10.0


def run(cmd, input_str=None):
    proc = subprocess.run(
        cmd, input=input_str, capture_output=True, text=True, check=True, shell=True
    )
    return proc.stdout.strip()


def load_state():
    if STATE_PATH.exists():
        with open(STATE_PATH, "r") as f:
            return json.load(f)
    return {}


def save_state(state):
    # Apply global decay to all scores to keep them from growing infinitely
    decayed_state = {name: score * DECAY_FACTOR for name, score in state.items()}
    with open(STATE_PATH, "w") as f:
        json.dump(decayed_state, f)


def main():
    if not CONFIG_PATH.exists():
        print(f"Config not found at {CONFIG_PATH}")
        return

    # 1. Load Prompts
    with open(CONFIG_PATH, "r") as f:
        data = yaml.safe_load(f)
        raw_prompts = [
            p for p in data.get("prompts", []) if "name" in p and "prompt" in p
        ]

    # 2. Load and Apply Frecency State
    state = load_state()

    # Attach scores to prompts (default 0 if never used)
    for p in raw_prompts:
        p["score"] = state.get(p["name"], 0.0)

    # 3. Sort by Score (Highest first)
    sorted_prompts = sorted(raw_prompts, key=lambda x: x["score"], reverse=True)

    # 4. Build Rofi Menu
    display_map = {}
    menu_lines = []
    for p in sorted_prompts:
        name = p["name"]
        snippet = p["prompt"].replace("\n", " ").strip()[:60]  # Limit snippet length
        display_str = f"{name} | {snippet}..."
        display_map[display_str] = p
        menu_lines.append(display_str)

    menu_cmd = "rofi -dmenu -i -p 'Smart Prompt:'"
    try:
        selected_str = run(menu_cmd, "\n".join(menu_lines))
    except subprocess.CalledProcessError:
        return  # User escaped rofi

    if not selected_str or selected_str not in display_map:
        return

    selected_data = display_map[selected_str]

    # 5. Update State (Boost the winner)
    state[selected_data["name"]] = selected_data["score"] + BOOST_VALUE
    save_state(state)

    # 6. Process Clipboard and Copy
    clipboard = run("wl-paste -n")
    final_text = selected_data["prompt"].replace("{{clipboard}}", clipboard)

    subprocess.run(["wl-copy", "-n"], input=final_text, text=True)


if __name__ == "__main__":
    main()
