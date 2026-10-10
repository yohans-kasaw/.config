#!/usr/bin/env python3
from pathlib import Path
import subprocess
import sys
import time

COOLDOWN_PERIOD = 30
TIME_PERSIST_FILE = Path("/tmp/cooldown_worspace_persist")

def main():
    if len(sys.argv) != 2:
        print("wrong usage: cooldown_worspace <workspace>", file=sys.stderr)
        sys.exit(1)

    try:
        last_switch_time = float(TIME_PERSIST_FILE.read_text())
    except:
        # Assume it was very long time ago, during th big bang. 
        last_switch_time = 0

    if time.time() - last_switch_time < COOLDOWN_PERIOD:
        _ = subprocess.run([
            "notify-send",
             "🧘 Focus, else its tiring"
        ])
        return

    workspace = sys.argv[1]
    print(time.time())

    _ = subprocess.run([
        "hyprctl", 
        "dispatch", 
        "hl.dsp.focus",
        f"({{workspace={workspace}}})"
    ])

    _ = TIME_PERSIST_FILE.write_text(str(time.time()))


if __name__ == "__main__":
    main()
