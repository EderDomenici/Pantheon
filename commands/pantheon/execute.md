# Command: /pantheon:execute

## 1. Overview
* **Description:** Initiates task execution by Hephaestus (the Builder) following the approved plan and signed contract.
* **Responsible Agent:** Hephaestus
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `PLAN.md` status must be `APPROVED`.
* `CONTRACT.md` status must be `SIGNED`.

## 3. Inputs
* `phases/XX/PLAN.md`
* `phases/XX/CONTRACT.md`

## 4. Execution Sequence
1. **Invocation:** The developer or agent triggers `/pantheon:execute`.
2. **Precondition Validation:** Zeus checks plan and contract status.
3. **Execution Loop:** Hephaestus executes tasks sequentially:
   - Implement or modify specified files.
   - Run task verification commands.
   - **On verification success:** Stage files, write summary to `EXECUTION-SUMMARY.md`, and commit the changes. Commit message: `[TaskID] Description`.
   - **On verification failure (Circuit Breaker):** Hephaestus has up to 3 consecutive retries to fix the issue. If it fails on the 3rd attempt, execution stops immediately, files are rolled back, and the phase status transitions to `ESCALATED`.

## 5. Outputs
* **Code Changes**: Staged and committed files in Git.
* **`phases/XX/EXECUTION-SUMMARY.md`**: Updated task execution summary logs.
