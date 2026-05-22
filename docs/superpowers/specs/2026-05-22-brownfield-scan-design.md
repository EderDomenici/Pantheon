# Design: Brownfield Spec-Driven (`/pantheon:scan`)

## Overview

Add brownfield support to the Pantheon spec-driven pipeline. A new `/pantheon:scan`
command analyzes an existing project and produces a structured `SCAN.md` artifact.
The existing `/pantheon:discuss` is minimally modified to detect `SCAN.md` and adapt
its behavior — skipping questions already answered by the scan.

The rest of the pipeline (plan → audit → sign → execute → verify) is unchanged.

---

## Architecture

```
/pantheon:scan
      │
      ▼
 .pantheon/SCAN.md     ← new artifact (full project map)
      │
      ▼ (developer reviews)
/pantheon:discuss      ← detects SCAN.md → brownfield mode
      │
      ▼
 .pantheon/SPEC.md     ← same artifact as always
      │
      ▼
[plan → audit → sign → execute → verify]
```

**Files changed:**
- **New:** `commands/pantheon/scan.md`
- **Modified:** `commands/pantheon/discuss.md` (add SCAN.md detection)
- **New schema:** `schemas/SCAN.template.md`

No other pipeline steps are touched.

---

## SCAN.md Structure

Three blocks, written to `.pantheon/SCAN.md`.

### Block 1 — Technical Identity
Feeds `config.json` and the Stack section of SPEC.

- Detected language/runtime
- Key dependencies (from `package.json`, `requirements.txt`, `go.mod`, etc.)
- Lint, typecheck, test, build commands found in project scripts

### Block 2 — Deliverables Map
Feeds the Entregáveis section of SPEC.

- Directory structure with inferred purpose per module (up to 3 levels deep)
- Identified features/domains (e.g., auth, billing, workers)
- Detected architectural patterns (e.g., layered, MVC, event-driven)

### Block 3 — Technical Debt Diagnosis
Pre-audit signal; feeds discuss and informs future audit.

- Inconsistencies: modules without tests, missing `.env.example`, circular imports
- Broken patterns: controller with business logic, untyped `any` in TypeScript
- Items tagged as `[RISK]`, `[GAP]`, or `[INCONSISTENCY]`

**Key distinction:** Zeus must explicitly mark each finding as **inferred** vs
**found directly**. The developer must know where to pay attention when reviewing.

---

## `/pantheon:scan` Execution Sequence

**Agent:** Zeus

### Step 1 — Precondition check
- If `.pantheon/` does not exist → abort: `"Workspace not initialized. Run /pantheon:init first."`
- If `.pantheon/SCAN.md` already exists → warn and ask developer to confirm overwrite

### Step 2 — Evidence collection (read-only, no file modifications)
- Dependency manifests: `package.json`, `pyproject.toml`, `go.mod`, etc.
- CI/CD scripts: `.github/workflows/`, `Makefile`, `Taskfile`
- Directory structure (up to 3 levels deep)
- Config files: `tsconfig.json`, `.eslintrc`, `jest.config.*`, etc.
- Code sampling: one representative file per identified module (pattern inference only)

### Step 3 — Analysis and inference
- Zeus synthesizes the three SCAN.md blocks from collected evidence
- Every item must be explicitly labeled: `[FOUND]` (direct evidence) or `[INFERRED]` (derived)

### Step 4 — Write and confirm
- Writes `.pantheon/SCAN.md`
- Prints terminal summary:
  ```
  Scan complete.

  Mapped:
    modules     → <N> identified
    risks       → <N> [RISK], <N> [GAP], <N> [INCONSISTENCY]

  Review .pantheon/SCAN.md, then run /pantheon:discuss.
  ```

---

## `/pantheon:discuss` Brownfield Adaptation

### Detection
At startup, Zeus checks if `.pantheon/SCAN.md` exists.
If yes: enter brownfield mode silently — no confirmation prompt.

### Changed behavior
Instead of a full blank-slate interview, Zeus opens with a loaded context summary:

```
SCAN.md found. Brownfield context loaded.

Auto-mapped:
  stack       → <detected stack>
  lint        → <command or none>
  test        → <command or none>
  modules     → <list> (<N> total)
  signals     → <N> [RISK], <N> [GAP], <N> [INCONSISTENCY]

I'll confirm critical points and fill in what the scan couldn't answer.
```

Zeus then asks **only the questions the scan could not answer with confidence:**
- Phase objective
- Specific business rules
- Non-negotiable principles
- Out-of-scope boundaries

Stack, structure, and sensor questions are already answered.

### What does not change
- Output: same `SPEC.md` with the same template
- Greenfield behavior: unchanged when `SCAN.md` is absent

---

## Out of Scope

- Scan does not replace `/pantheon:init` — workspace must exist before scanning
- Scan does not produce a SPEC draft — `SCAN.md` is raw structured evidence, not a specification
- No changes to plan, audit, sign, execute, or verify commands
- No automatic transition from scan to discuss — developer reviews `SCAN.md` first
