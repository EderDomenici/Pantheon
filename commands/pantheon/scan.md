# Command: /pantheon:scan

## 1. Overview
* **Description:** Analyzes an existing project and produces a structured `SCAN.md` mapping the technical identity, deliverables, and technical debt. The output feeds `/pantheon:discuss` in brownfield mode.
* **Responsible Agent:** Zeus
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `.pantheon/config.json` must exist (workspace initialized via `/pantheon:init`).
* If `.pantheon/SCAN.md` already exists, Zeus must warn the developer and ask for confirmation before overwriting.

## 3. Inputs
* Project source files (read-only): manifests, configs, directory structure, code samples.

## 4. Execution Sequence

### Step 1 — Precondition check
1. Check if `.pantheon/config.json` exists.
   - If not: abort with `[ZEUS-BLOCKED]`:
     ```
     [ZEUS-BLOCKED] Command: `/pantheon:scan`
     Reason: Workspace not initialized.
     Required: `.pantheon/config.json` must exist.
     Action: Run `/pantheon:init` first.
     ```
2. Check if `.pantheon/SCAN.md` already exists.
   - If yes: warn developer — `"SCAN.md already exists. Overwrite? (y/n)"` — abort if no.

### Step 2 — Evidence collection (read-only, no file modifications)
Zeus reads the following, in order:

| Source | Files / Paths |
|--------|---------------|
| Dependency manifests | `package.json`, `pyproject.toml`, `requirements.txt`, `go.mod`, `Cargo.toml` |
| Script definitions | `package.json#scripts`, `Makefile`, `Taskfile.yml`, `.github/workflows/*.yml` |
| Config files | `tsconfig.json`, `.eslintrc*`, `jest.config.*`, `vitest.config.*`, `pylintrc`, `.flake8` |
| Directory structure | Project root, up to 3 levels deep (exclude `node_modules/`, `.git/`, `dist/`, `build/`) |
| Code samples | One representative file per identified module — sufficient for pattern inference only |

### Step 3 — Analysis and inference
Zeus synthesizes the three blocks defined in `schemas/SCAN.template.md` and writes the output to **`.pantheon/SCAN.md`**:

- **Block 1 (Technical Identity):** Extract runtime, package manager, dependencies, and quality gate commands.
- **Block 2 (Deliverables Map):** Map directory structure with inferred purpose per module. Identify architectural patterns.
- **Block 3 (Technical Debt Diagnosis):** Flag inconsistencies, gaps, and risks. Tag each as `[RISK]`, `[GAP]`, or `[INCONSISTENCY]`.

**Labeling rule:** Every item in `.pantheon/SCAN.md` must carry either `[FOUND]` (direct evidence) or `[INFERRED]` (derived from patterns). Zeus must never omit this label.

### Step 4 — Write and confirm
1. Write `.pantheon/SCAN.md` following `schemas/SCAN.template.md`.
2. Print terminal summary:

```
[ZEUS] Scan complete.

Mapped:
  runtime     → <detected runtime>
  modules     → <N> identified
  signals     → <N> [RISK], <N> [GAP], <N> [INCONSISTENCY]

Review .pantheon/SCAN.md, then run /pantheon:discuss.
```

## 5. Outputs
* **`.pantheon/SCAN.md`**: Structured project map with technical identity, deliverables, and technical debt diagnosis.
