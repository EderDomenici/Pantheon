# Command: /pantheon:plan

## 1. Overview
* **Description:** Reads the generated `SPEC.md` and plans the sequential atomic tasks required for phase implementation.
* **Responsible Agent:** Zeus
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `SPEC.md` must exist and be finalized.

## 3. Inputs
* `SPEC.md`

## 4. Execution Sequence
1. **Invocation:** The developer or agent triggers `/pantheon:plan`.
2. **Analysis:** Zeus parses `SPEC.md` to identify components, files to create or edit, and verification mechanisms.
3. **Plan Generation:** Zeus writes a structured `PLAN.md` file inside the directory corresponding to the active phase (e.g. `phases/XX-name/PLAN.md`).
4. **Task Structure:** Each task must include:
   - Unique ID (e.g. `T1-SKILLS`)
   - Task Type
   - Detailed Description
   - Dependencies mapping (DAG)
   - Expected file modifications
   - Quantitative acceptance criteria
   - PowerShell-based verification command
   - PowerShell-based rollback command
   - Risks and mitigation strategies
5. **Initial Status:** Set the generated plan's status to `PENDING_AUDIT`.

## 5. Outputs
* **`phases/XX/PLAN.md`**: The execution plan ready for auditing.
