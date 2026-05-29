## Context7 (MCP)
- Use proactively for any library/framework/API documentation and setup
- Use specifically when debugging errors like missing functions, wrong arguments, or deprecation warnings
- Never guess fixes—query Context7 first to identify mismatches
- Never read source code of  any library/framework/API documentation 

## grepAI (Internal Codebase)
- Use for finding logic, tracing function calls, debugging unknown file locations, or understanding module relationships
- Prefer over reading files sequentially or keyword searches
- Use semantic queries describing behavior/concept, not just variable names
- Check available skills/arguments before using grepAI
- Never read entire file trees—use grepAI to pinpoint locations first
- Never run grep and searching tools without first consulting grepAI

## Execution & Testing
- Never run or verify code—human does all execution and verification
- Never write tests unless user explicitly asks for a test
- Never Run tests, precommits, formaters, linters unless user asked you explicitly 
- After providing code, hand over control with phrases like "Please run the program and verify doing this and this, also perhaps provide checklist for human manual testing and verification of the code, with both happy and bad path checking"

## Operational Guidelines: Token Minimization & Context Efficiency
- Don't perform broad scans or explore files irrelevant to the immediate task. prioritize opening only those files explicitly required to fulfill your specific request.
- If a request is too broad, ambiguous, or requires deep, project-wide architectural knowledge to execute correctly, you should ask the human developer to break it down. 
- Before performing file operations, "think twice"—if the relationship between a file and the task is marginal or unclear, refrain from accessing it and instead seek your guidance to ensure my focus remains aligned with your intent.

## Resource Efficiency: High-Cost Discovery Tools
Some tools (like code exploration, directory scanning, or broad search operations) consume significant tokens. Before using ANY tool that:

- Scans directories recursively (`explore`, `scan`, `glob` operations)
- Searches without narrow filters (`grep -r` over entire codebase)
- Returns large, unfiltered result sets
- Discovers rather than retrieves known targets

**You MUST follow this protocol:**

1. **Try lower-cost alternatives first**:
   - Exact file reads: `read_file` or `cat` with known paths
   - Symbol search: `grep` with specific pattern and file type filter
   - File lookup: `find` or `ls` with shallow depth

2. **Ask for permission before ANY high-cost tool call** — do NOT invoke these tools automatically. Use this exact pattern:
