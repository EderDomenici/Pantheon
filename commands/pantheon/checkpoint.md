# Command: /pantheon:checkpoint

## 1. Overview
* **Description:** Manually saves a checkpoint of the current framework state (PROGRESS.md, HANDOFF.md, and optionally Git state) so it can be restored later using `/pantheon:jump`.
* **Responsible Agent:** Hermes
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* The project must have a `.pantheon/` configuration directory.

## 3. Inputs
* Explicit request from the developer.
* Optional comment/description for the checkpoint.

## 4. Execution Sequence
1. **Invocation:** The developer triggers `/pantheon:checkpoint <optional_name>`.
2. **State Capture:** Hermes reads current `PROGRESS.md`, `PLAN.md`, and other active state files.
3. **Commit/Save:** Hermes saves these files into `.pantheon/checkpoints/<timestamp_or_name>/`.
4. **Git Snapshot (Optional):** Hermes may ask Hephaestus to ensure there is a clean git commit.
5. **Completion:** Hermes confirms the checkpoint was saved.

## 5. Outputs
* **`.pantheon/checkpoints/`**: A new directory containing the backed-up state files.