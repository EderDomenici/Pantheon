# Command: /pantheon:audit

## 1. Overview
* **Description:** Triggers Athena (the Auditor) to evaluate the generated `PLAN.md` against the 11 auto-rejection rules.
* **Responsible Agent:** Athena (Auditor mode)
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `PLAN.md` must exist in the phase folder with status `PENDING_AUDIT`.

## 3. Inputs
* `phases/XX/PLAN.md`

## 4. Execution Sequence
1. **Invocation:** The developer or agent triggers `/pantheon:audit`.
2. **Preconditions Check:** Zeus verifies `PLAN.md` exists and is pending audit.
3. **Audit Execution:** Athena evaluates `PLAN.md` against the 11 auto-rejection rules (e.g. metadata, mandatory fields, naming conventions, external dependencies, rollback safety, etc.).
4. **Severity Mapping:** Athena classifies findings as `BLOCKER`, `MAJOR`, `MINOR`, or `INFO`.
5. **Verdict Generation:** Athena writes `AUDIT.md` containing the checklist, findings, and final verdict:
   - If any `BLOCKER` or `MAJOR` exists: verdict is **REJECTED**, and the plan remains unexecutable.
   - If only `MINOR` or `INFO` exists: verdict is **APPROVED**, and the status of `PLAN.md` is updated to `APPROVED`.

## 5. Outputs
* **`phases/XX/AUDIT.md`**: Detailed audit report containing the verdict and checklist results.
* **`phases/XX/PLAN.md`**: Updated status (if approved, status is changed to `APPROVED`).
