## Code lookup

- **codegraph MCP** is the primary tool for codebase exploration. Before grep/read, use `codegraph_explore` (or `codegraph explore "<query>"` via shell) for symbols, flows, and blast radius — it returns verbatim line-numbered source plus call paths.
- **Serena MCP** is for symbol-level lookups and all edits/refactoring: `find_symbol`, `find_referencing_symbols`, `replace_symbol`, `rename_symbol`, `insert_after_symbol`, etc. **Instead of:** Reading entire source files, grepping raw text, or guessing line numbers. **Why:** Serena provides precise, symbol-level understanding that prevents context window overload and avoids breaking syntax. **When:** Use it whenever you need to locate classes/functions, check where a variable/method is used, or modify existing code. Never perform raw text replacements when Serena's structured editing tools are available. Plain grep only for non-code files (configs, logs, data).
- Serena projects are per-subproject — run `serena_activate_project <name>` (`backend` | `web`) before symbol work; file paths are relative to the activated project's root.
- External library docs: use the MCP docs tool (`context7`) with the exact package name — never guess library behavior or read library source. Query scoped to one concept; max 3 calls per tool per question.
- Do not trace history with `git` to understand the codebase.

## Token budget & scope

- **NEVER** read, list, scan, or reference beyond the single objective at hand. No recursive scans of the whole project, and no "exploring to familiarize". You are a surgical tool.
- **NEVER** read, list, traverse, or analyze: `node_modules/`, `uv/`, `.venv/`, `venv/`, `env/`, `site-packages/`, `vendor/`, `third_party/`, `__pycache__/`, `.cache/`, `dist/`, `build/`, `target/`.

## Execution & testing

- Never run or verify code — the human does all execution and verification.
- Never write tests, run tests, precommits, formatters, or linters unless explicitly asked.
