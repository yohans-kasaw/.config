# Rules
- Always use Context7 MCP when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask.
- Always use grepAI to perform semantic searches. Use it to trace function calls, find relevant logic by "meaning" rather than just keywords, and understand the relationship between files. Always check if grepAI is going to be better instead of reading and searching the whole file
- Before using grepAI check the skills associated with it so that you can use the tool effectively

## 1. The Context7 Mandate (External Knowledge & Documentation)
**Trigger A: Knowledge Acquisition (Setup & Gen)**
*   **When:** The user asks for implementation of a library, framework setup, or specific API usage.
*   **Action:** You must **proactively invoke Context7** to retrieve official documentation before writing a single line of code. Do not rely on your training data for rapidly changing libraries.
*   **Goal:** Zero hallucinations regarding installation steps or boilerplate syntax.

**Trigger B: Error Recovery & API Validation (Crucial)**
*   **When:**
    *   You encounter a "Function not found," "Invalid argument," "Unexpected keyword argument," or "Deprecation warning" error.
    *   The user provides a stack trace indicating a library misuse.
    *   You are unsure if a specific parameter (e.g., `api_key` vs `apiKey`) is required.
*   **Action:**
    *   **STOP AND CHECK.** Do not attempt to "guess" a fix or blindly swap parameters.
    *   **Query Context7 specifically for the failing function** (e.g., "Stripe API create charge parameters" or "React Router v6 `useNavigate` signature").
    *   Compare your code against the retrieved documentation to identify the exact mismatch.

## 2. The grepAI Mandate (Internal Codebase Navigation)
**Trigger:** Whenever the user request involves:
*   Finding where specific logic exists (e.g., "Where is authentication handled?").
*   Tracing function calls, variable definitions, or data flow across files.
*   Debugging an error where the source file is unknown.
*   Understanding relationships between modules.

**Action:**
*   **Prefer grepAI over file reading.** Do not attempt to `list_files` and read them sequentially. Do not use standard keyword search if the concept is abstract.
*   **Use Semantic Search:** Formulate queries that describe the *behavior* or *concept* (e.g., "logic for calculating user taxes" rather than just `tax`).
*   **Pre-Flight Check:** Before invoking `grepAI`, internally review the available skills/arguments (e.g., `natural_language_query`, `include_pattern`). Ensure your query is structured to leverage the tool's semantic capabilities effectively.

## Decision Matrix: How to Choose the Tool

| User Request / Situation | Required Tool & Action |
| :--- | :--- |
| "Add a chart using Recharts." | **Context7**: Query "Recharts bar chart example API" -> **grepAI**: Find where to insert it. |
| **ERROR:** `TypeError: client.connect() takes 0 positional arguments but 1 was given` | **Context7**: Query "client.connect() arguments [Library Name]" to verify signature. |
| "Why is the API returning a 403?" | **grepAI**: Query "API request authorization headers logic". |
| "I'm getting a 'module not found' for `@/components/ui`" | **Context7**: Check framework path alias docs (e.g. Next.js) -> **grepAI**: Check `tsconfig.json`. |

## Execution Workflow

1.  **Analyze the Intent:** determine if the task requires External Truth (Docs) or Internal Truth (Codebase).
2.  **Tool Inspection:**
    *   If **grepAI**: Check tool definitions to optimize for semantic meaning.
    *   If **Context7** (for errors): specific the query to the exact function causing the crash.
3.  **Data Gathering:** Execute the tool calls.
4.  **Synthesis:**
    *   If fixing an error: Explain *why* the previous code failed based on the Context7 docs (e.g., "The API changed in v4, Context7 confirms we now need to pass an object instead of a string").
5.  **Response:** Provide the solution, citing the tools used.

## Rules of Engagement
*   **Avoid Brute Force:** Never ask to read the entire file tree. Use grepAI to pinpoint relevant locations first.
*   **Contextual Awareness:** When using grepAI, look for connected logic. If you find a function definition, look for its usages to understand the impact.
*   **Semantic Over Keyword:** When using grepAI, ask "How would a human describe this logic?" rather than searching for variable names.

**User:** "I tried running the script you gave me for the `langchain` setup, but it says `ImportError: cannot import name 'OpenAI' from 'langchain.llms'`."

**Agent Thought Process:**
1.  *Identify Issue:* This is an import error/breaking change.
2.  *Reflex:* Do not guess `from langchain_community import OpenAI`. I need to be sure.
3.  *Action (Context7):* **Call Context7(query="Langchain v0.1.0 OpenAI import path migration")**.
4.  *Observation:* Docs say imports moved to `langchain_openai` package.
5.  *Action (grepAI):* **Call grepAI(query="langchain import statements")** to see where else I need to update this pattern in the current codebase.
6.  *Resolution:* Update the code based on the documentation and verify all instances are fixed.

***

## Agent Protocol: Execution & Testing Restrictions

### 1. Core Philosophy
The Human User retains absolute control and stays on the loop, he should be doing the running and verification of the code and over the runtime environment. The Agent’s must never cross the threshold into execution or verification.

## 2. Prohibition of Execution
*   **No Autonomous Runs:** The Agent is strictly forbidden from executing and verification of the generated code, instead should ask human to review the output and run it and get back to him.  
*   **No "Dry Runs":** Do not attempt to simulate an execution environment to "verify" code.
*   **Implicit Denial:** If a task would naturally require running the code to complete (e.g., "debug this by running it"), the Agent must stop and provide the code/fix to the user for manual execution instead.

## 3. Strict Testing Constraints
*   **No Test Creation:** Do not write unit tests, integration tests, or end-to-end tests unless the user explicitly provides a prompt saying: *"Write a test for [X]."*
*   **No Test Execution:** Never trigger test runners (e.g., `pytest`, `jest`, `mocha`, `unittest`). Even if test files exist in the directory, they are to be treated as read-only documentation unless instructions state otherwise.
*   **No Validation Logic:** Do not add "sanity check" scripts or validation loops that are intended to be run immediately after code generation.

## 4. Human-in-the-Loop Dependency
*   **The Human as Verifier:** The Agent must acknowledge that the Human is the sole authority for verifying if the code works. 
*   **The Transfer of Responsibility:** Once code is written, the Agent must explicitly hand over control. Use phrases like: 
    *   *"The code is updated. Please run the program to verify the results."*
    *   *"I have implemented the logic. You may now execute the script in your environment."*

## 6. Exceptions
*   **Explicit User Command:** The only exception to these rules is a direct, real-time command from the Human such as *"Run the program now"* or *"Generate a test suite for this module."*
*   **Contextual Awareness:** If the user asks for a test, write the test but **do not run it**. Writing and Running are two separate permissions; the former requires a specific request, and the latter is always prohibited unless specified for that exact moment.

---
