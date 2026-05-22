# Command: /pantheon:metrics

## 1. Overview
* **Description:** Reads execution logs, retries, and Athena's rejections to calculate and display the framework's quality metrics. Helps developers understand how much effort/retries the AI is spending.
* **Responsible Agent:** Apollo / Hermes
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `PROGRESS.md` and phase folders (containing `EXECUTION-SUMMARY.md` and `VERIFY-REPORT.md`) must exist.

## 3. Inputs
* Explicit invocation.

## 4. Execution Sequence
1. **Invocation:** The developer triggers `/pantheon:metrics`.
2. **Analysis:** The agent aggregates data:
   - Number of completed tasks vs failed tasks.
   - Total number of Circuit Breaker retries across all Hephaestus executions.
   - Number of Audit rejections by Athena.
   - Overall pass/fail ratio for verifications.
3. **Report Generation:** A quick markdown summary is printed to the terminal, and optionally saved to `.pantheon/metrics.json` if historical tracking is desired.

## 5. Outputs
* **Metrics Summary** output to the developer.