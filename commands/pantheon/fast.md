# Command: /pantheon:fast

## 1. Overview
* **Description:** Initiates a dynamic fast-track execution for smaller tasks. It combines planning, implicit auditing, and execution into a single flow to reduce bureaucracy and increase dynamism, inspired by the GSD framework.
* **Responsible Agent:** Zeus (delegating to Hephaestus dynamically)
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `SPEC.md` must exist, or an explicit task description must be provided by the developer during invocation.

## 3. Inputs
* `SPEC.md` or natural language prompt for the small task.

## 4. Execution Sequence
1. **Invocation:** The developer triggers `/pantheon:fast <description>`.
2. **Analysis & Fast Plan:** Zeus quickly analyzes the request, infers the minimal required steps without writing a formal `PLAN.md` (or generates a highly simplified one), and implicitly assumes it is approved for execution.
3. **Execution Loop:** Hephaestus immediately executes the requested changes.
   - Implements or modifies specified files.
   - Runs basic linters or verifications if available.
   - Commits changes automatically.
4. **Completion:** Hermes logs a condensed entry in `PROGRESS.md` indicating a fast-tracked task was completed.

## 5. Outputs
* **Code Changes**: Implemented and committed immediately.
* **`PROGRESS.md`**: Updated with a fast-track entry.