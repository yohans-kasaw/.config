import json
import subprocess
import time
import sys
import os
from enum import Enum

# --- Configuration ---
WORK_DIR = os.path.dirname(os.path.abspath(__file__))
STATE_FILE = os.path.join(WORK_DIR, "focus_state.json")

MIN_FOCUS_DURATION = 90
MAX_GLANCE_DURATION = 12
PENALTY_LIMIT = 4
COOLDOWN_PERIOD = 900

ANGRY_EMOJI = "😡"


def load_state():
    try:
        with open(STATE_FILE, "r") as f:
            return json.load(f)
    except:
        return {"last_notification_time": 0.0}


def save_state(state):
    try:
        with open(STATE_FILE, "w") as f:
            json.dump(state, f)
    except Exception as e:
        print(f"Failed to save state: {e}", file=sys.stderr)


def get_active_window() -> str:
    try:
        out = subprocess.check_output(
            ["hyprctl", "activewindow", "-j"], stderr=subprocess.DEVNULL
        )
        return json.loads(out).get("address", "")
    except (subprocess.SubprocessError, json.JSONDecodeError):
        return ""


def format_time(seconds: int) -> str:
    if seconds < 60:
        return f"{seconds}s"
    m, s = divmod(seconds, 60)
    return f"{m}m {s:02d}s"


def print_waybar(text: str) -> None:
    out = {"text": text}
    print(json.dumps(out), flush=True)


def generate_and_notify() -> None:
    print_waybar(ANGRY_EMOJI)
    try:
        subprocess.run(
            ["notify-send", "Context Switching", "You are context switching too much"],
            check=False,
        )
    except Exception as e:
        print(f"Failed to send notification: {e}", file=sys.stderr)


class FocusState(Enum):
    FOCUSED = 1
    GLANCING = 2


class FocusTracker:
    def __init__(self, initial_window: str, now: float):
        self.state = FocusState.FOCUSED
        self.primary_window = initial_window
        self.focus_start_time = now
        self.current_window = initial_window
        self.current_window_start_time = now
        self.glance_start_time = 0.0
        self.bad_switches = 0
        state = load_state()
        self.last_notification_time = state.get("last_notification_time", 0.0)

    def update(self, active_window: str, now: float) -> bool:
        if active_window != self.current_window:
            self.current_window = active_window
            self.current_window_start_time = now

            if (
                self.state == FocusState.FOCUSED
                and active_window != self.primary_window
            ):
                self.state = FocusState.GLANCING
                self.glance_start_time = now
            elif (
                self.state == FocusState.GLANCING
                and active_window == self.primary_window
            ):
                self.state = FocusState.FOCUSED

        if self.state == FocusState.GLANCING:
            time_away = now - self.glance_start_time

            if time_away >= MAX_GLANCE_DURATION:
                focus_duration = self.glance_start_time - self.focus_start_time

                if focus_duration < MIN_FOCUS_DURATION:
                    self.bad_switches += 1
                else:
                    self.bad_switches = 0

                self.state = FocusState.FOCUSED
                self.primary_window = self.current_window
                self.focus_start_time = self.current_window_start_time

                if self.bad_switches >= PENALTY_LIMIT:
                    state = load_state()
                    self.last_notification_time = state.get(
                        "last_notification_time", 0.0
                    )

                    if now - self.last_notification_time > COOLDOWN_PERIOD:
                        self.bad_switches = 0
                        state["last_notification_time"] = now
                        save_state(state)
                        self.last_notification_time = now
                        return True
                    else:
                        self.bad_switches = 0
                        return False

        return False

    def get_elapsed_time(self, now: float) -> int:
        if self.state == FocusState.GLANCING:
            return int(self.glance_start_time - self.focus_start_time)
        return int(now - self.focus_start_time)


def main() -> None:
    if len(sys.argv) > 1 and sys.argv[1] == "--click":
        state = load_state()
        is_running = state.get("is_running", True)
        state["is_running"] = not is_running
        save_state(state)
        return

    tracker = FocusTracker(get_active_window(), time.time())
    last_run_state = True

    while True:
        state = load_state()
        is_running = state.get("is_running", True)

        if not is_running:
            print_waybar("Paused")
            last_run_state = False
            time.sleep(1)
            continue

        if not last_run_state:
            tracker = FocusTracker(get_active_window(), time.time())
            last_run_state = True

        now = time.time()
        current_window = get_active_window()

        should_warn = tracker.update(current_window, now)

        if should_warn:
            generate_and_notify()
            continue

        elapsed = tracker.get_elapsed_time(now)
        time_str = format_time(elapsed)
        prefix = f"{tracker.bad_switches} 💢 " if tracker.bad_switches > 1 else ""

        print_waybar(f"  {prefix}{ANGRY_EMOJI} {time_str}")
        time.sleep(1)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(0)
