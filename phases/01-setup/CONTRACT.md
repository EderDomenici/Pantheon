# CONTRACT - Phase 01 Setup

- **Project Name:** Pantheon
- **Phase:** 01-setup
- **Status:** SIGNED
- **Signed At:** 2026-05-20T14:45:00-03:00

---

## Deliverables Committed To

This contract binds the agents of the Pantheon framework to deliver the following artifacts for Phase 01 (Setup):

### 1. Agent Skills
The implementation of the foundational agent skill definitions ensuring strict alignment with `GLOBAL_RULES.md` and zero duplication of core rules.
* **`skills/zeus/SKILL.md`**: Orchestrator skill defining capabilities, limitations, and phase transition logic.
* **`skills/athena/SKILL.md`**: Auditor/Judge skill defining the 11 auto-rejection criteria and verification report judgments.
* **`skills/themis/SKILL.md`**: Contract Signer skill detailing spec-to-plan validation and signature conditions.
* **`skills/hephaestus/SKILL.md`**: Builder skill outlining step-by-step task execution, commits, and rollback protocol.
* **`skills/hermes/SKILL.md`**: Messenger/Memory skill handling progress logging and context reconstruction.
* **`skills/apollo/SKILL.md`**: Sensor skill managing linter/tester tools and compiling execution reports.

### 2. Commands
The complete command suite allowing developers or the system orchestrator to trigger specific workflow steps:
* **`/pantheon:discuss`** (`commands/pantheon/discuss.md`)
* **`/pantheon:plan`** (`commands/pantheon/plan.md`)
* **`/pantheon:audit`** (`commands/pantheon/audit.md`)
* **`/pantheon:sign`** (`commands/pantheon/sign.md`)
* **`/pantheon:execute`** (`commands/pantheon/execute.md`)
* **`/pantheon:verify`** (`commands/pantheon/verify.md`)
* **`/pantheon:status`** (`commands/pantheon/status.md`)
* **`/pantheon:resume`** (`commands/pantheon/resume.md`)

### 3. Lifecycle Templates (Schemas)
The structured schemas serving as output templates for the agents' execution:
* **`schemas/SPEC.template.md`**
* **`schemas/PLAN.template.md`**
* **`schemas/AUDIT.template.md`**
* **`schemas/CONTRACT.template.md`**
* **`schemas/EXECUTION-SUMMARY.template.md`**
* **`schemas/VERIFY-REPORT.template.md`**
* **`schemas/PROGRESS.template.md`**

### 4. Scripts & Documentation
The setup resources ensuring seamless installation and operation guidance:
* **`install.sh`**: Setup automation script for POSIX environments.
* **`install.ps1`**: Setup automation script for Windows/PowerShell environments.
* **`README.md`**: Project overview, architectural role descriptions, and quickstart in Portuguese.
* **`docs/GUIDE.md`**: Detailed execution workflow guide in Portuguese.
* **`docs/SECURITY.md`**: Core security guidelines and restrictions in Portuguese.

---

## Verification Protocols
Every task has defined acceptance criteria and PowerShell-based verification commands that will be executed by Apollo and verified by Athena prior to marking any deliverable as complete.

---

## Signatures

By signing below, the agents commit to the scope, limits, and rules defined in the Specification (`SPEC.md`) and the Plan (`PLAN.md`).

```
+--------------------------------------------------------+
|                                                        |
|  [SIGNED] Zeus (Orchestrator Agent)                     |
|                                                        |
|  [SIGNED] Athena (Auditor and Judge Agent)              |
|                                                        |
|  [SIGNED] Themis (Contract Signer Agent)               |
|                                                        |
+--------------------------------------------------------+
```
