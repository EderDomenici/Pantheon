# Command: /pantheon:discuss

## 1. Overview
* **Description:** Initiates an interactive conversation between the developer and Zeus (the Orchestrator) to detail the system requirements, stack, linting sensors, and specific business rules. Supports brownfield mode when `.pantheon/SCAN.md` exists.
* **Responsible Agent:** Zeus
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `.pantheon/config.json` must exist (workspace initialized via `/pantheon:init`).

## 3. Inputs
* Developer prompts and instructions.
* References to any initial designs or documents.
* `.pantheon/SCAN.md` (optional — triggers brownfield mode if present).

## 4. Execution Sequence

### Brownfield detection (runs before interview)
Zeus checks if `.pantheon/SCAN.md` exists.
- **If yes:** Enter brownfield mode (see Section 4B).
- **If no:** Enter greenfield mode (see Section 4A).

---

### 4A — Greenfield mode (no SCAN.md)
1. **Zeus Interview:** Zeus asks structured questions about:
   - Target stack and architectures.
   - Quality gates (compilation, linter, test runner).
   - Core functional requirements and files.
2. **Spec Drafting:** Zeus aggregates the inputs and writes them into a unified specification file.
3. **Validation:** Zeus ensures all fields required by the spec template are populated.

---

### 4B — Brownfield mode (SCAN.md present)
1. **SCAN.md review gate:** Before loading context, Zeus asks the developer:

   ```
   SCAN.md found. Have you reviewed and corrected it before proceeding? (y/n)
   ```

   - If **no**: Zeus instructs the developer to open `.pantheon/SCAN.md`, review all `[INFERRED]` items for accuracy, correct any misidentified modules or stack details, and re-run `/pantheon:discuss` after validation. Zeus halts.
   - If **yes**: proceed to step 2.

2. **Context load:** Zeus reads `.pantheon/SCAN.md` and opens the session with a summary:

   ```
   SCAN.md found. Brownfield context loaded.

   Auto-mapped:
     stack       → <Block 1: runtime>
     lint        → <Block 1: lint command or "none detected">
     test        → <Block 1: test command or "none detected">
     modules     → <Block 2: module list> (<N> total)
     signals     → <N> [RISK], <N> [GAP], <N> [INCONSISTENCY]

   I'll confirm critical points and fill in what the scan couldn't answer.
   ```

3. **Targeted interview:** Zeus asks **only** the questions the scan could not answer with confidence:
   - Phase objective (what is being built or changed in this phase).
   - Specific business rules not derivable from code.
   - Non-negotiable principles (e.g., zero external dependencies, idempotency requirements).
   - Explicit out-of-scope boundaries.
   - Confirmation or correction of any `[INFERRED]` items Zeus is unsure about.

   Zeus does **not** re-ask about stack, dependencies, or sensor commands — these are already answered by SCAN.md.

4. **Spec Drafting:** Zeus merges SCAN.md context with developer answers and writes `SPEC.md`.
5. **Validation:** Zeus ensures all fields required by the spec template are populated.

## 5. Outputs
* **`SPEC.md`**: The official, complete specification document for the phase.
