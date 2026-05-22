# GLOBAL RULES (Regras Globais - Pantheon Framework)

This document establishes the global rules, permissions, security controls, and operational protocols for all agents operating within the Pantheon framework. All agent skills MUST reference this document.

---

## 1. Agent Permission Matrix

| Agent | Read Scope | Write Scope | Execute Commands | Spawns Subagents | Allowed External Actions |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Zeus** | `.pantheon/**`, workspace root | `task.md`, progress/state files | None | Athena, Themis, Hephaestus, Hermes | Read-only analysis, coordinate orchestration, fast-track planning |
| **Athena** | `PLAN.md`, `VERIFY-REPORT.md`, workspace root | `AUDIT.md`, `VERIFY-REPORT.md` (judgment section) | None | None | Reject/approve plans, audit results |
| **Themis** | `SPEC.md`, `PLAN.md`, workspace root | `CONTRACT.md` | None | None | Signing scope, verifying agreements |
| **Hephaestus**| `SPEC.md`, `PLAN.md` (APPROVED), `CONTRACT.md` (SIGNED) | Phase directories, code-files, `EXECUTION-SUMMARY.md` | Yes (defined in PLAN.md) | None | Code generation, editing, local builds, dynamic execution |
| **Hermes** | `PROGRESS.md`, `HANDOFF.md`, execution reports, `.pantheon/memory/*` | `PROGRESS.md`, `HANDOFF.md`, checkpoints, `.pantheon/memory/*` | None | None | State compression, context restoration, memory management |
| **Apollo** | `config.json`, source files | `VERIFY-REPORT.md` (sensor section) | Yes (defined in config.json sensors) | None | Execute lint, test, typecheck, build |

---

## 2. Global Security Prohibitions

1. **No External Libraries/Packages:** Zero `npm`, `pip`, `gem`, `cargo`, or third-party dependencies are allowed. The framework is strictly self-contained.
2. **Secrets Management:** NEVER write passwords, API keys, credentials, or personal identifying information (PII) into the repository.
3. **No Inline Prompts:** All instructions, specifications, and workflows must be retrieved from written Markdown files (`.md`).
4. **Command Execution Restriction:** Only Hephaestus and Apollo are permitted to run commands on the host machine, and only those explicitly specified in the approved plans or configuration files.
5. **No File Modification Outside Scope:** Hephaestus must never edit or create files that are not listed in the approved `PLAN.md` without registering an explicit plan deviation.
6. **No Permissive Licensing:** The framework is local/private by default. No license file should be added unless explicitly required.

---

## 3. Failure Taxonomy

All errors and verification failures must be categorized under one of the following classes:

* **SENS-FAIL (Sensor Failure):** A configured sensor (linter, compiler, tests) failed to execute or reported errors.
* **SPEC-MISMATCH (Specification Mismatch):** The generated code does not match the specifications defined in `SPEC.md` or the target criteria.
* **INTEG-FAIL (Integration Failure):** Separate files or modules fail to work together or violate architectural rules.
* **INFRA-FAIL (Infrastructure Failure):** Installation script failures, file permission issues, or environmental errors.
* **PROCESS-VIOLATION (Process Violation):** Attempting to execute tasks without approved plan/contract, or violating the flow.

---

## 4. Circuit Breaker (3-Retry Rule)

1. If a task or verification fails, the responsible agent must attempt to fix the error.
2. An agent is allowed a maximum of **3 consecutive correction attempts** for the same failure.
3. If the failure persists after the 3rd attempt, execution must be halted immediately.
4. The system state must be escalated to **ESCALATED** status, and the agent must yield control to the developer or parent orchestrator with a full diagnostic log.

---

## 5. Git and Rollback Protocol

* **One Commit Per Task:** Every successfully implemented task in the plan must be committed individually.
* **Commit Messages:** Must follow the template specified in `config.json` (or standard `[TaskID] Brief description`).
* **Rollback Action:** If a task fails verification and hits the circuit breaker, the agent must rollback the working tree using `git checkout -- <files>` or `git reset --hard HEAD` to the last clean commit before yielding.

---

## 6. Communication and Handoff

* Agents must communicate using structured Markdown files (`PROGRESS.md`, `HANDOFF.md`, `AUDIT.md`, `CONTRACT.md`).
* Oral or chat communications between agents should be limited to coordination, and the source of truth must always reside in files.
