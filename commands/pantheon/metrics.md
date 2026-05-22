# Command: /pantheon:metrics

## 1. Overview
- **Description:** Reads execution logs, circuit breaker retries, and Athena's verdicts to calculate and display quality metrics for the current project. Helps developers understand how much effort the AI pipeline is spending and where bottlenecks are.
- **Responsible Agent:** Hermes (Apollo provides `VERIFY-REPORT.md` data as input only)
- **Runtimes Target:** Claude Code, Codex

---

## 2. Pre-conditions
- `PROGRESS.md` must exist.
- At least one phase must have been completed (at least one task with status `DONE`).

---

## 3. Inputs
- `PROGRESS.md` — task counts, retries, STATUS history.
- `EXECUTION-SUMMARY.md` (if exists) — circuit breaker attempt data from Hephaestus.
- `VERIFY-REPORT.md` (if exists) — sensor pass/fail data produced by Apollo.
- `AUDIT.md` (if exists) — Athena rejection history.

---

## 4. Execution Sequence
1. **Invocation:** Developer triggers `/pantheon:metrics`.
2. **Data aggregation (Hermes):** Reads all input files and computes:
   - Total tasks completed vs. failed vs. escalated.
   - Total circuit breaker retries across all Hephaestus executions.
   - Number of Athena audit rejections.
   - Verification pass/fail ratio (from `VERIFY-REPORT.md`).
   - Fast-track vs. full-pipeline task ratio (if `/pantheon:fast` was used).
3. **Report generation:** Hermes prints a Markdown summary to the terminal and saves to `.pantheon/metrics.json` for historical tracking.
4. **Completion:** Zeus confirms:
   ```
   [ZEUS] Metrics report generated.
   Status: ✅ Saved to .pantheon/metrics.json
   ```

---

## 5. Outputs

### Terminal summary (Markdown)
```markdown
# Pantheon Metrics — <project name>
- **Date:** <ISO timestamp>
- **Phase:** <current phase>

## Execution
| Metric | Value |
|--------|-------|
| Tasks completed | N |
| Tasks failed / escalated | N |
| Circuit breaker retries (total) | N |
| Fast-track tasks | N |

## Quality
| Metric | Value |
|--------|-------|
| Athena audit rejections | N |
| Verification pass rate | N% |
| Sensor failures (SENS-FAIL) | N |
```

### `.pantheon/metrics.json`
Machine-readable version of the above, appended per run for historical comparison.
