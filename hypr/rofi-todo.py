#!/usr/bin/env python3

import json
import os
import subprocess
import uuid

TODO_FILE = os.path.expanduser("~/.todo_list.json")


def load():
    if not os.path.exists(TODO_FILE):
        return []
    try:
        with open(TODO_FILE) as f:
            return json.load(f)
    except (json.JSONDecodeError, TypeError):
        return []


def save(tasks):
    with open(TODO_FILE, "w") as f:
        json.dump(tasks, f, indent=2)


def main():
    tasks = load()

    while True:
        display_map = {}
        for id_, text in tasks:
            display = text[:42] + "..." if len(text) > 45 else text
            while display in display_map:
                display += " "
            display_map[display] = id_

        proc = subprocess.Popen(
            ["rofi", "-dmenu", "-p", "Todo", "-format", "s"],
            stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True
        )
        out, _ = proc.communicate(input="\n".join(display_map))
        text = out.strip()
        rc = proc.returncode

        if not text and rc != 0:
            break

        if rc == 0:
            matched_id = display_map.get(text)
            if matched_id:
                tasks = [(i, t) for i, t in tasks if i != matched_id]
            elif text:
                tasks.append((str(uuid.uuid4()), text))
        save(tasks)


if __name__ == "__main__":
    main()
