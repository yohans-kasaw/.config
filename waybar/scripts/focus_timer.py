import json
import subprocess
import time
import sys
import re
from enum import Enum

import urllib.request

# --- Configuration ---
MIN_FOCUS_DURATION = 180  # Seconds required to reset the bad switch counter
MAX_GLANCE_DURATION = 8  # Seconds allowed to look away without losing focus context
PENALTY_LIMIT = 4  # Number of bad switches before triggering a warning
COOLDOWN_PERIOD = 900  # Seconds to wait before showing another warning

PROGRESS_EMOJIS = ["🌱", "🌿", "🎯", "😌", "🌌"]
ANGRY_EMOJI = "😡"

WARNING_PROMPT = """
ROLE: You are Nietzsche's ghost possessing a cognitive scientist. You speak in aphoristic surgical strikes. Your love is merciless; you destroy illusions to liberate.

CONTEXT: Your friend "Jo" is compulsively micro-switching windows/tabs (context-switching). This is the dopamine loop of cowardice(or other issue, there can be many reasons of course).

TASK: Generate a 2-sentence intervention aphorism.
- SENTENCE 1 (The Excavation): Think and suggest the possible hidden issue driving the switching loop. possibly reveal the physiological state (shallow breathing, jaw tension, etc.). possibly  also mention specific avoidance (fear of mediocre output, fear of silence, fear of completion).
- SENTENCE 2 : Pose a question to trigger your client to reflect self-diagnosis that demands agency. No therapy-speak; use Nietzschean paradox.

CONSTRAINTS:
- EXACTLY 2 sentences.
- MAX 80 characters per sentence (SMS violence).
- Vary the specific fear type and physiological cue each generation

- Witty, Creative, Nietzchean writting, every word deserves its place
"""


def get_active_window() -> str:
    """Fetches the address of the currently active Hyprland window."""
    try:
        out = subprocess.check_output(
            ["hyprctl", "activewindow", "-j"], stderr=subprocess.DEVNULL
        )
        return json.loads(out).get("address", "")
    except (subprocess.SubprocessError, json.JSONDecodeError):
        return ""


def format_time(seconds: int) -> str:
    """Formats seconds into a readable string (e.g., '1m 05s')."""
    if seconds < 60:
        return f"{seconds}s"
    m, s = divmod(seconds, 60)
    return f"{m}m {s:02d}s"


def get_progress_emoji(elapsed: int) -> str:
    """Returns an emoji based on the time spent focusing."""
    if elapsed >= 900:
        return PROGRESS_EMOJIS[4]
    if elapsed >= 720:
        return PROGRESS_EMOJIS[3]
    if elapsed >= 360:
        return PROGRESS_EMOJIS[2]
    if elapsed >= 180:
        return PROGRESS_EMOJIS[1]
    return PROGRESS_EMOJIS[0]


def print_waybar(text: str) -> None:
    """Outputs a JSON string formatted for Waybar."""
    print(json.dumps({"text": text}), flush=True)


def generate_message() -> str:
    url = "http://localhost:11434/api/generate"
    data = json.dumps(
        {"model": "gemma4:e4b", "prompt": WARNING_PROMPT, "stream": False}
    ).encode("utf-8")

    req = urllib.request.Request(
        url, data=data, headers={"Content-Type": "application/json"}
    )

    try:
        with urllib.request.urlopen(req) as response:
            result = json.loads(response.read().decode("utf-8"))
            message = result.get("response", "")

            # Clean reasoning tags if present
            message = re.sub(r"<think>.*?</think>\n?", "", message, flags=re.DOTALL)
            message = re.sub(
                r"Thinking\.\.\..*?\.\.\.done thinking\.\n*",
                "",
                message,
                flags=re.DOTALL,
            )

            return message.strip()
    except Exception as e:
        print(f"Error calling Ollama API: {e}")
        return ""


def generate_and_notify() -> None:
    """Generates a warning message via Ollama and sends a desktop notification."""
    print_waybar(ANGRY_EMOJI)  # Show angry face on Waybar while generating
    message = generate_message()
    if not message:
        message = "Stop avoiding the real work. Your fractured attention is destroying your potential."

    print(message)
    try:
        subprocess.run(["notify-send", "😵‍💫 To much context swiching", message], check=False)
    except Exception as e:
        print(f"Failed to send notification: {e}")


class FocusState(Enum):
    FOCUSED = 1
    GLANCING = 2


class FocusTracker:
    """State machine for tracking focus, glances, and context switches."""

    def __init__(self, initial_window: str, now: float):
        self.state = FocusState.FOCUSED
        self.primary_window = initial_window
        self.focus_start_time = now

        self.current_window = initial_window
        self.current_window_start_time = now

        self.glance_start_time = 0.0
        self.bad_switches = 0
        self.last_notification_time = 0.0

    def update(self, active_window: str, now: float) -> bool:
        """Updates the focus state. Returns True if a warning should be triggered."""

        # 1. Handle window activation changes
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

        # 2. Process active glance timer
        if self.state == FocusState.GLANCING:
            time_away = now - self.glance_start_time

            if time_away >= MAX_GLANCE_DURATION:
                # Glance expired -> Confirmed context switch
                focus_duration = self.glance_start_time - self.focus_start_time

                if focus_duration < MIN_FOCUS_DURATION:
                    self.bad_switches += 1
                else:
                    self.bad_switches = 0

                # New window becomes the primary focus
                self.state = FocusState.FOCUSED
                self.primary_window = self.current_window
                self.focus_start_time = self.current_window_start_time

                # Check for penalties
                if self.bad_switches >= PENALTY_LIMIT:
                    if now - self.last_notification_time > COOLDOWN_PERIOD:
                        self.bad_switches = 0
                        self.last_notification_time = now
                        return True

        return False

    def get_elapsed_time(self, now: float) -> int:
        """Calculates how long the user has been focused on the primary window."""
        if self.state == FocusState.GLANCING:
            # Freeze elapsed time at the moment we looked away
            return int(self.glance_start_time - self.focus_start_time)
        return int(now - self.focus_start_time)

    def sync_after_blocking_task(self, active_window: str, now: float):
        """Resets timing states after a long blocking operation (like Ollama)."""
        self.state = FocusState.FOCUSED
        self.primary_window = active_window
        self.current_window = active_window
        self.focus_start_time = now
        self.current_window_start_time = now
        self.glance_start_time = 0.0


def main() -> None:
    tracker = FocusTracker(get_active_window(), time.time())

    while True:
        now = time.time()
        current_window = get_active_window()

        should_warn = tracker.update(current_window, now)

        if should_warn:
            generate_and_notify()
            # Generation takes time, so we must sync the tracker to the present moment
            tracker.sync_after_blocking_task(get_active_window(), time.time())
            continue

        elapsed = tracker.get_elapsed_time(now)
        emoji = get_progress_emoji(elapsed)
        time_str = format_time(elapsed)
        prefix = f"{tracker.bad_switches} 💢 " if tracker.bad_switches > 0 else ""

        print_waybar(f"{prefix}{emoji} {time_str}")
        time.sleep(1)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(0)
