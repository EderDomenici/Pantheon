# PLAN - [Phase Name]

- **Phase ID:** [e.g. 01-setup]
- **Status:** [PENDING_AUDIT | APPROVED | ESCALATED]
- **Created At:** [Timestamp]
- **Updated At:** [Timestamp]

---

## Global References and Rules
* **Reference Document:** [GLOBAL_RULES.md]
* **Circuit Breaker Rule:** In the event of a verification failure during task execution, the builder will attempt correction up to a maximum of **3 consecutive times**. If the verification continues to fail after the 3rd attempt, execution is halted, the status is set to `ESCALATED`, and control is yielded with diagnostic logs.

---

## Executive Summary
[Brief overview of what this plan aims to achieve and its strategy]

---

## Tasks

### Task [N]: [Task Name]
- **ID:** [e.g. T1-SKILLS]
- **Type:** [e.g. documentation | code | refactor | migration]
- **Description:** [Details of what the task involves]
- **Dependencies:** [List of dependency task IDs or None]
- **Files Expected:**
  - `[Expected file path 1]`
  - `[Expected file path 2]`
- **Acceptance Criteria:**
  - [Measurable and quantitative criterion 1]
  - [Measurable and quantitative criterion 2]
- **Verification Command:** `[Shell command to verify this specific task]`
- **Rollback Command:** `[Shell command to revert changes if task fails]`
- **Risks:** [Potential risk, e.g. Name collisions or compilation issues]
- **Mitigation:** [Concrete mitigation strategy]
