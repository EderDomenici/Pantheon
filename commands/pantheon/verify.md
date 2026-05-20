# Command: /pantheon:verify

## 1. Overview
* **Description:** Executes post-execution verification using Apollo's sensors and Athena's judgment to evaluate the final phase quality.
* **Responsible Agent:** Apollo (Sensor mode) & Athena (Judge mode)
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* Task execution must be completed (or in a verifiable state) with an updated `EXECUTION-SUMMARY.md`.

## 3. Inputs
* `config.json` (for sensor command lists)
* `phases/XX/EXECUTION-SUMMARY.md`

## 4. Execution Sequence
1. **Invocation:** The developer or agent triggers `/pantheon:verify`.
2. **Sensor Execution (Apollo):** Apollo runs the lint, typecheck, build, and test sensors configured in `config.json`.
3. **Sensor Section Logging:** Apollo compiles the results, truncating verbose output, and writes the sensor section of `VERIFY-REPORT.md`.
4. **Judgment (Athena):** Athena evaluates Apollo's report:
   - Check if any tests, lints, or builds failed.
   - If all tests and sensors pass: verdict is **PASS**.
   - If any sensor fails: verdict is **FAIL** and Athena classifies the issue under the Failure Taxonomy (e.g. SENS-FAIL, SPEC-MISMATCH).
5. **State Update:** If PASS, Hermes updates the phase status in `PROGRESS.md` to `COMPLETED`. If FAIL, status is set to `FAILED_VERIFICATION` (and returns to execution cycle).

## 5. Outputs
* **`phases/XX/VERIFY-REPORT.md`**: Sensor outputs and Athena's final PASS/FAIL verdict.
* **`PROGRESS.md`**: Phase status updated.
