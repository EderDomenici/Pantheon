# PLAN - Phase 01 Setup

- **Phase ID:** 01-setup
- **Status:** APPROVED
- **Created At:** 2026-05-20T17:40:00Z
- **Updated At:** 2026-05-20T17:44:00Z

---

## Global References and Rules
* **Reference Document:** [GLOBAL_RULES.md](../../skills/GLOBAL_RULES.md)
* **Circuit Breaker Rule:** In the event of a verification failure during task execution, the builder (Hephaestus) will attempt correction up to a maximum of **3 consecutive times**. If the verification continues to fail after the 3rd attempt, execution is halted, the status is set to `ESCALATED`, and control is yielded with diagnostic logs.

---

## Executive Summary
This plan details the implementation of the Pantheon framework (v0.1 MVP) including agent skills, commands, schemas, installation scripts, and documentation.

---

## Tasks

### Task 1: Create Agent Skills
- **ID:** T1-SKILLS
- **Type:** documentation
- **Description:** Implement individual `SKILL.md` files for Zeus, Athena, Themis, Hephaestus, Hermes, and Apollo.
- **Dependencies:** None
- **Files Expected:**
  - `skills/zeus/SKILL.md`
  - `skills/athena/SKILL.md`
  - `skills/themis/SKILL.md`
  - `skills/hephaestus/SKILL.md`
  - `skills/hermes/SKILL.md`
  - `skills/apollo/SKILL.md`
- **Acceptance Criteria:**
  - Every skill file MUST explicitly reference `GLOBAL_RULES.md`.
  - Every skill file must detail the identity, capabilities (Pode), limitations (Não pode), and output formats.
- **Verification Command:** `powershell -Command "if (-not (Get-ChildItem -Path skills/*/SKILL.md | Measure-Object).Count -eq 6) { throw 'Missing skills' }"`
- **Rollback Command:** `powershell -Command "Remove-Item -Recurse -Force skills/zeus, skills/athena, skills/themis, skills/hephaestus, skills/hermes, skills/apollo"`
- **Risks:** Overlapping agent scopes or inadequate definition of limitations.
- **Mitigation:** Carefully delineate Zeus (orchestrator), Athena (auditor/judge), Themis (signer), Hephaestus (builder), Hermes (memory), and Apollo (sensor) in accordance with the Spec.

### Task 2: Create Pantheon Commands
- **ID:** T2-COMMANDS
- **Type:** documentation / command
- **Description:** Implement markdown-based commands that describe dev/agent interaction workflows.
- **Dependencies:** T1-SKILLS
- **Files Expected:**
  - `commands/pantheon/discuss.md`
  - `commands/pantheon/plan.md`
  - `commands/pantheon/audit.md`
  - `commands/pantheon/sign.md`
  - `commands/pantheon/execute.md`
  - `commands/pantheon/verify.md`
  - `commands/pantheon/status.md`
  - `commands/pantheon/resume.md`
- **Acceptance Criteria:**
  - All 8 files must exist and detail the execution sequence, inputs, outputs, and agent assignments.
- **Verification Command:** `powershell -Command "if (-not (Get-ChildItem -Path commands/pantheon/*.md | Measure-Object).Count -eq 8) { throw 'Missing commands' }"`
- **Rollback Command:** `powershell -Command "Remove-Item -Recurse -Force commands/pantheon"`
- **Risks:** Ambiguous step execution sequence.
- **Mitigation:** Use numbered steps and explicit pre-conditions (e.g., `/pantheon:execute` requires APPROVED plan and SIGNED contract).

### Task 3: Create Schemas and Templates
- **ID:** T3-SCHEMAS
- **Type:** schema
- **Description:** Implement templates defining the standard layout for all lifecycle artifacts.
- **Dependencies:** T2-COMMANDS
- **Files Expected:**
  - `schemas/SPEC.template.md`
  - `schemas/PLAN.template.md`
  - `schemas/AUDIT.template.md`
  - `schemas/CONTRACT.template.md`
  - `schemas/EXECUTION-SUMMARY.template.md`
  - `schemas/VERIFY-REPORT.template.md`
  - `schemas/PROGRESS.template.md`
- **Acceptance Criteria:**
  - All 7 template files exist.
  - Formats must match the architecture specification, using placeholder `[...]` notation.
- **Verification Command:** `powershell -Command "if (-not (Get-ChildItem -Path schemas/*.template.md | Measure-Object).Count -eq 7) { throw 'Missing schemas' }"`
- **Rollback Command:** `powershell -Command "Remove-Item -Recurse -Force schemas"`
- **Risks:** Template structure mismatch with agent parsers.
- **Mitigation:** Ensure templates strictly contain structure and placeholders matching ARCHITECTURE.md and the Spec.

### Task 4: Create Installation Scripts and Documentation
- **ID:** T4-INSTALL-DOCS
- **Type:** scripting / documentation
- **Description:** Create install scripts (`install.sh`, `install.ps1`), project README.md, and docs directory (`GUIDE.md`, `SECURITY.md`).
- **Dependencies:** T3-SCHEMAS
- **Files Expected:**
  - `install.ps1`
  - `install.sh`
  - `README.md`
  - `docs/GUIDE.md`
  - `docs/SECURITY.md`
- **Acceptance Criteria:**
  - `install.sh` is syntax-valid in bash, and `install.ps1` is syntax-valid in powershell.
  - Docs (`README.md`, `GUIDE.md`, `SECURITY.md`) are written in Portuguese.
- **Verification Command:** `powershell -Command "powershell -Command 'Get-Command -ErrorAction SilentlyContinue install.ps1'; if (-not (Test-Path install.sh, README.md, docs/GUIDE.md, docs/SECURITY.md)) { throw 'Missing docs/scripts' }"`
- **Rollback Command:** `powershell -Command "Remove-Item -Force install.ps1, install.sh, README.md; Remove-Item -Recurse -Force docs"`
- **Risks:** Command syntax issues on target platforms (Linux vs Windows).
- **Mitigation:** Keep installation logic minimal: detect Claude/Codex directories, copy commands/skills, and verify file existence.
