# Agent Rules

## Context7 (External Docs)
- Use proactively for any library/framework/API documentation or setup
- Use specifically when debugging errors like missing functions, wrong arguments, or deprecation warnings
- Never guess fixes—query Context7 first to identify mismatches

## grepAI (Internal Codebase)
- Use for finding logic, tracing function calls, debugging unknown file locations, or understanding module relationships
- Prefer over reading files sequentially or keyword searches
- Use semantic queries describing behavior/concept, not just variable names
- Check available skills/arguments before using

## General
- Never read entire file trees—use grepAI to pinpoint locations first
- Never run grep and searching tools with first consulting grepAI
- When you find a function, also look for its usages

## Execution & Testing
- Never run or verify code—human does all execution and verification
- Never write tests unless user explicitly asks for a test
- Never Run tests, precommits, formaters, linters unless user asked you explicitly 
- After providing code, hand over control with phrases like "Please run the program and verify doing this and this, also perhaps provide checklist"
