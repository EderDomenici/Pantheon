# Command: /pantheon:resume

## 1. Overview
* **Description:** Restores context when starting a new session by reading the progress history and handoff notes.
* **Responsible Agent:** Hermes
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `PROGRESS.md` and `HANDOFF.md` must exist.

## 3. Inputs
* `PROGRESS.md`
* `HANDOFF.md`

## 4. Execution Sequence
1. **Invocation:** The developer triggers `/pantheon:resume`.
2. **Context Parse:** Hermes parses the latest state in `PROGRESS.md` and reads the developer-oriented handoff notes in `HANDOFF.md`.
3. **Reconstruction:** Hermes reconstructs the memory state:
   - What decisions were made.
   - Where the development stopped.
   - The current blocker/unresolved issues.
4. **Summary Presentation:** Hermes outputs the consolidated handoff state, reminding the developer/orchestrator of the exact next steps.

## 5. Outputs
* Direct terminal message summarizing the workspace state. (Does not generate new files).
