# Command: /pantheon:jump

## 1. Overview
* **Description:** Restores a previously saved framework state checkpoint or jumps to a specific phase, overriding the current rigid flow. It enables extreme dynamism for the developer.
* **Responsible Agent:** Zeus / Hermes
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* A valid checkpoint must exist in `.pantheon/checkpoints/` OR a valid phase ID must be provided.

## 3. Inputs
* `<checkpoint_name>` or `<phase_id>` provided by the developer.

## 4. Execution Sequence
1. **Invocation:** The developer triggers `/pantheon:jump <target>`.
2. **State Restoration:** Hermes copies the files from the requested checkpoint back into the active workspace (or Zeus resets the pipeline stage).
3. **Context Update:** Zeus resets its internal state validation to match the newly restored files.
4. **Completion:** Zeus confirms the new current phase and suggests the next valid command.

## 5. Outputs
* Overwritten `PROGRESS.md` and/or phase files, rolling back or skipping stages dynamically.