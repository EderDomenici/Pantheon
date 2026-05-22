# Command: /pantheon:fast

## 1. Overview
- **Description:** Initiates a fast-track execution for small, well-scoped tasks. Generates a simplified `PLAN.md` (1-3 tasks) with status `AUTO-APPROVED`, skipping the formal `/pantheon:audit` step, but still delegating to Hephaestus with the full circuit breaker active. Inspired by the GSD framework.
- **Responsible Agent:** Zeus (delegating to Hephaestus)
- **Runtimes Target:** Claude Code, Codex

---

## 2. Pre-conditions
- `.pantheon/config.json` must exist (workspace initialized).
- The task description must be 1-3 discrete, non-breaking changes. If the request implies 4+ tasks or touches core architecture, Zeus must reject `/pantheon:fast` and suggest `/pantheon:plan` instead.

---

## 3. Inputs
- Natural language task description provided inline: `/pantheon:fast <description>`
- OR: existing `SPEC.md` if already written.

---

## 4. Execution Sequence
1. **Invocation:** Developer triggers `/pantheon:fast <description>`.
2. **Scope check:** Zeus evaluates if the request fits fast-track criteria (≤3 tasks, no architectural change). If it does not fit, Zeus blocks and responds:
   ```
   [ZEUS-BLOCKED] Command: `/pantheon:fast`
   Reason: Task scope exceeds fast-track limit (>3 tasks or architectural change detected).
   Action: Use `/pantheon:plan` for structured execution.
   ```
3. **Simplified Plan:** Zeus generates a `PLAN.md` with:
   - Status: `AUTO-APPROVED`
   - Tasks: 1-3 items with clear descriptions and verification commands.
   - Header note: `<!-- fast-track: formal audit skipped -->`
4. **Execution:** Hephaestus executes tasks sequentially, with the full circuit breaker protocol active (3-attempt limit, escalation on breach — same as `/pantheon:execute`).
5. **State log:** Hermes logs a condensed entry in `PROGRESS.md` marking tasks as `DONE` with commit hashes, and sets STATUS to `FAST-TRACK-COMPLETE`.
6. **Completion:** Zeus confirms to developer:
   ```
   [ZEUS] Phase: FAST-TRACK → COMPLETE
   Status: ✅ N tasks executed.
   Next command: `/pantheon:verify` (recommended) or `/pantheon:status`
   ```

---

## 5. Outputs
- **`PLAN.md`**: Simplified, AUTO-APPROVED, 1-3 tasks.
- **Code changes**: Implemented and committed by Hephaestus.
- **`PROGRESS.md`**: Updated with fast-track entry and commit hashes.
