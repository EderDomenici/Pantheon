# Command: /pantheon:status

## 1. Overview
* **Description:** Reads the central tracking log and presents the developer with the current progress of the project phase.
* **Responsible Agent:** Hermes
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `PROGRESS.md` must exist in the workspace root.

## 3. Inputs
* `PROGRESS.md`

## 4. Execution Sequence
1. **Invocation:** The developer triggers `/pantheon:status`.
2. **State Analysis:** Hermes reads the central tracking logs inside `PROGRESS.md`.
3. **Report Presentation:** Hermes compiles a terminal-friendly layout displaying:
   - Active Phase and ID.
   - Overall Phase Status (e.g. IN_PROGRESS, APPROVED, SIGNED, COMPLETED).
   - Task completion rate (completed/total).
   - Last committed task and Git hash.
   - Pending tasks remaining.
   - Next logical command (e.g. `/pantheon:execute`).

## 5. Outputs
* Text summary directly inside the runtime terminal. (Does not generate new files).
