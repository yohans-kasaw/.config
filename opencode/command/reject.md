---
description: Tell the agent why you rejected its last request. Usage: /reject <reason> — common reasons: irrelevant, too big, wrong file, don't need it, try a different way
---

The user rejected a recent tool request. Reason given: `$ARGUMENTS`

Handle this exactly:

1. **Stop the denied action.** Do not retry it this turn. If the reason is `irrelevant` or `too big` or `don't need it`, remove the target entirely from your plan — never re-request, re-read, or re-run it.
2. **If the reason is `wrong file` or `try a different way`**, adjust course: pick the obvious alternative if there is one, and continue. If the right alternative is not clear, ask.
3. **Continue the rest of the task** as normal. This rejection only removes one step.
4. Reply in one short line acknowledging what you dropped or changed — no apology essay.
