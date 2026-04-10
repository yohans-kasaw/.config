#!/usr/bin/env python3
import json
import subprocess
import time
import os
import sys
import urllib.request
import re

# --- Configuration ---
WORK_DIR = os.path.dirname(os.path.abspath(__file__))
STATE_FILE = os.path.join(WORK_DIR, "timer_state.json")

PROGRESS_EMOJIS = ["🧘", "🌊", "🔥", "🥇", "🎯", "💎", "🏆", "👑"]

# --- Prompt 1 ---
REST_PROMPT = """
Write this as a casual text message from a friend to me (Jo).

You are a Nietzschean cognitive scientist observing the completion of a will-to-power cycle. Jo just finished 60 minutes of deep work and hovers at possible edge of dopamine depletion, adenosine accumulation, cortisol saturation or other many possible cases.

TASK: Generate a 2-sentence intervention aphorism.
1.compliment and remind him his achievements for example cathedral of silence, neural fortress, spire of silence or other stuff and general path they are heading for. Or  the specific cognitive_mastery , attentional sovereignty, flow-state, inhibitory control or other possible stuffs, they demonstrated.

2. Divine command to rest citing specific metabolic_debt, glycogen depletion in prefrontal cortex, accumulated glutamate, cortisol clearance requirement, or  and somatic_compromise, compressed cervical spine, hyperaccommodated ciliary muscles, many more ideas. No questions. Biological emergency framed as sacred necessity.


CONSTRAINTS:
- EXACTLY 2 sentences message. On other output.
- MAX 80 characters per sentence (SMS violence).
- Vary the specific fear type and physiological cue each generation
- Witty, Creative, Nietzchean writting, every word deserves its place
"""

# --- Prompt 2 ---
GRASS_PROMPT = """
Write this as a casual text message from a friend to me (Jo).

You are a furious Nietzschean neuroscientist whose advice was ignored. Client added 30 minutes after your warning Indicting willful self-sabotage. Currently possibly exhibiting possible exibiting characteristic of defense_mechanism, rationalization, repetition compulsion, sublimation of mortality, denial of finitude, and similar things to continue working.

TASK: Generate a 2-sentence intervention aphorism.
1. Expose the "just five more minutes" as existential_fraud, fear of mediocre output, fear of stillness, fear of completion, fear of bordem or others. 
2. Possibly trigger by ask questions, or trigger amegdila by opporutinty coast or give hope what could be possible if he can take rest.

CONSTRAINTS:
- ONLY THE MESSAGE, NO OTHER OUTPUT, EXACTLY 2 sentence message. On other output. ON options for example
- MAX 80 characters per sentence (SMS violence).
- Vary the specific fear type and physiological cue each generation
- Witty, Creative, Nietzchean writting, every word deserves its place
"""


def load_state():
    try:
        with open(STATE_FILE, "r") as f:
            return json.load(f)
    except:
        return {
            "running": False,
            "start_time": None,
            "milestone_60": False,
            "milestone_90": False,
        }


def save_state(state):
    with open(STATE_FILE, "w") as f:
        json.dump(state, f)


def format_time(seconds: int) -> str:
    h, rem = divmod(seconds, 3600)
    m, s = divmod(rem, 60)
    if h > 0:
        return f"{h}h {m:02d}m"
    return f"{m:02d}:{s:02d}"


def get_progress_emoji(elapsed: int) -> str:
    milestones = [0, 900, 1800, 2700, 3600, 4500, 5400, 6300]
    for i, m in reversed(list(enumerate(milestones))):
        if elapsed >= m:
            return PROGRESS_EMOJIS[i]
    return PROGRESS_EMOJIS[-1]


def print_waybar(text: str, tooltip: str, css_class: str = "running") -> None:
    """Outputs a JSON string formatted for Waybar."""
    print(
        json.dumps({"text": text, "class": css_class, "tooltip": tooltip}), flush=True
    )


def generate_message(prompt: str) -> str:
    """Generates a message via Ollama based on the provided prompt."""
    url = "http://localhost:11434/api/generate"
    data = json.dumps(
        {"model": "gemma4:e4b", "prompt": prompt, "stream": False}
    ).encode("utf-8")
    req = urllib.request.Request(
        url, data=data, headers={"Content-Type": "application/json"}
    )

    try:
        with urllib.request.urlopen(req) as response:
            result = json.loads(response.read().decode("utf-8"))
            message = result.get("response", "")
            message = re.sub(r"<think>.*?</think>\n?", "", message, flags=re.DOTALL)
            message = re.sub(
                r"Thinking\.\.\..*?\.\.\.done thinking\.\n*",
                "",
                message,
                flags=re.DOTALL,
            )
            return message.strip()
    except Exception:
        return ""


def generate_and_notify(
    title: str, prompt: str, fallback: str, urgency: str = "normal"
) -> None:
    """Generates a message via Ollama and sends a desktop notification."""
    message = generate_message(prompt) or fallback
    subprocess.run(["notify-send", "-u", urgency, title, message])


def handle_click():
    state = load_state()
    if not state.get("running"):
        # Start the timer
        state = {
            "running": True,
            "start_time": time.time(),
            "milestone_60": False,
            "milestone_90": False,
        }
    else:
        # Reset to zero
        state["start_time"] = time.time()
        state["milestone_60"] = False
        state["milestone_90"] = False
    save_state(state)


def handle_stop():
    state = load_state()
    state["running"] = False
    state["start_time"] = None
    save_state(state)


def check_milestones(elapsed: int, state: dict):
    changed = False

    if elapsed >= 3600 and not state.get("milestone_60"):
        state["milestone_60"] = True
        changed = True
        generate_and_notify(
            "🫠 Time to Rest!",
            REST_PROMPT,
            "Rest is the basis of movement. Take a break.",
            "normal",
        )

    elif elapsed >= 5400 and not state.get("milestone_90"):
        state["milestone_90"] = True
        changed = True
        generate_and_notify(
            "🌳 TOUCH GRASS!!!",
            GRASS_PROMPT,
            "You've been at it for 90 minutes. Go outside and touch some grass!",
            "critical",
        )

    if changed:
        save_state(state)


def main():
    if len(sys.argv) > 1:
        if sys.argv[1] in ["--click", "--reset"]:
            handle_click()
            return
        elif sys.argv[1] == "--stop":
            handle_stop()
            return

    state = load_state()

    # If not running, display stopped state
    if not state.get("running") or state.get("start_time") is None:
        print_waybar(
            "⏱️ Stopped",
            "Productivity Timer\nLeft-click: Start\nRight-click: Stop",
            css_class="stopped",
        )
        return

    elapsed = int(time.time() - state["start_time"])

    check_milestones(elapsed, state)

    emoji = get_progress_emoji(elapsed)
    time_str = format_time(elapsed)
    tooltip = f"Productivity Timer\nElapsed: {time_str}\nLeft-click: Reset to Zero\nRight-click: Stop"

    print_waybar(f"  {emoji} {time_str}", tooltip)


if __name__ == "__main__":
    main()
