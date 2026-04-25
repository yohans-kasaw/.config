#!/usr/bin/env python3

import json
import os
import subprocess
import uuid
from dataclasses import asdict, dataclass
from datetime import datetime
from enum import IntEnum
from typing import List, Optional

TODO_FILE = os.path.expanduser("~/.todo_list.json")
ARCHIVE_FILE = os.path.expanduser("~/.todo_archive")
TRUNCATE_LEN = 45
STATUS_EMOJI = "🚀"


class RofiAction(IntEnum):
    ENTER = 0
    ESCAPE = 1
    INCREASE_PRIORITY = 10
    REMOVE_TASK = 11


@dataclass
class Task:
    id: str
    text: str
    wip: bool
    timestamp: str

    @property
    def priority(self) -> int:
        return len(self.text) - len(self.text.rstrip("!"))


class TaskManager:
    def __init__(self, todo_file: str, archive_file: str):
        self.todo_file = todo_file
        self.archive_file = archive_file
        self.tasks: List[Task] = self.load_tasks()

    def load_tasks(self) -> List[Task]:
        if not os.path.exists(self.todo_file):
            return []
        try:
            with open(self.todo_file, "r") as f:
                data = json.load(f)
                tasks = []
                for task_data in data:
                    tasks.append(Task(
                        id=task_data.get('id', str(uuid.uuid4())),
                        text=task_data.get('text', ''),
                        wip=task_data.get('wip', False),
                        timestamp=task_data.get('timestamp', datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
                    ))
                return tasks
        except (json.JSONDecodeError, TypeError):
            return []

    def save_tasks(self) -> None:
        with open(self.todo_file, "w") as f:
            json.dump([asdict(t) for t in self.tasks], f, indent=2)

    def archive_task(self, task: Task) -> None:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M")
        with open(self.archive_file, "a") as f:
            f.write(f"{task.text} (Done: {timestamp})\n")
        self.remove_task(task.id)

    def add_task(self, text: str) -> None:
        new_task = Task(
            id=str(uuid.uuid4()),
            text=text,
            wip=False,
            timestamp=datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        )
        self.tasks.append(new_task)
        self.save_tasks()

    def remove_task(self, task_id: str) -> None:
        self.tasks = [t for t in self.tasks if t.id != task_id]
        self.save_tasks()

    def toggle_wip(self, task: Task) -> None:
        if task.wip:
            self.archive_task(task)
        else:
            task.wip = True
            task.timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            self.save_tasks()

    def increase_priority(self, task: Task) -> None:
        task.text += "!"
        self.save_tasks()


class TodoUI:
    def __init__(self, manager: TaskManager):
        self.manager = manager

    def _get_sorted_tasks(self) -> List[Task]:
        return sorted(
            self.manager.tasks,
            key=lambda t: (t.wip, t.priority, t.timestamp),
            reverse=True
        )

    def _format_task_display(self, task: Task) -> str:
        prefix = f"{STATUS_EMOJI} " if task.wip else ""
        display_t = f"{prefix}{task.text}"
        
        if len(display_t) > TRUNCATE_LEN:
            return f"{display_t[:TRUNCATE_LEN - 3]}..."
        return display_t

    def show(self) -> bool:
        """Shows the rofi menu and processes user action. Returns True if we should continue running."""
        sorted_tasks = self._get_sorted_tasks()
        display_map = {}
        
        for task in sorted_tasks:
            display = self._format_task_display(task)
            
            # Ensure unique keys for rofi menu
            while display in display_map:
                display += " "
            display_map[display] = task

        rofi_input = "\n".join(display_map.keys())
        
        process = subprocess.Popen(
            [
                "rofi", "-dmenu", "-p", "Todo", "-format", "s",
                "-kb-custom-1", "Alt+a", "-kb-custom-2", "Alt+r", 
                "-mesg", f"Enter: {STATUS_EMOJI}/Done | Alt+a: Prio+ | Alt+r: Delete"
            ],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            text=True
        )
        
        stdout, _ = process.communicate(input=rofi_input)
        user_input = stdout.strip()
        ret_code = process.returncode

        if not user_input and ret_code == RofiAction.ESCAPE:
            return False

        matched_task = display_map.get(user_input)

        match ret_code:
            case RofiAction.ENTER:
                if matched_task:
                    self.manager.toggle_wip(matched_task)
                elif user_input:
                    self.manager.add_task(user_input)
            case RofiAction.INCREASE_PRIORITY:
                if matched_task:
                    self.manager.increase_priority(matched_task)
            case RofiAction.REMOVE_TASK:
                if matched_task:
                    self.manager.remove_task(matched_task.id)
            case _:
                return False

        return True


def main():
    manager = TaskManager(TODO_FILE, ARCHIVE_FILE)
    ui = TodoUI(manager)
    
    while ui.show():
        pass


if __name__ == "__main__":
    main()
