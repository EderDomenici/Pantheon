# Command: /pantheon:learn

## 1. Overview
* **Description:** Triggers the system to update the persistent memory/wiki based on the latest phase, registering learnings, mistakes, conflicts, and architectural decisions. Inspired by the Karpathy methodology of persistent context.
* **Responsible Agent:** Hermes
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* The project must have a `.pantheon/memory/` directory (created during init or retroactively).

## 3. Inputs
* `PROGRESS.md`
* Logs of recent failures (e.g., `AUDIT.md`, `VERIFY-REPORT.md`)
* User input indicating what should be learned.

## 4. Execution Sequence
1. **Invocation:** The developer triggers `/pantheon:learn` (optionally with a specific learning point).
2. **Analysis:** Hermes analyzes recent verification failures, Athena's judgments, and Hephaestus' retries.
3. **Memory Update:** Hermes updates `.pantheon/memory/LESSONS.md` (the Agent Diary & Counsel), categorizing the new knowledge under the respective agent's section.
4. **Completion:** Hermes confirms that the long-term memory has been updated.

## 5. Outputs
* **`.pantheon/memory/LESSONS.md`**: Updated with the new context.