# VERIFY REPORT - [Phase Name]

- **Phase ID:** [e.g. 01-setup]
- **Verify Status:** [PASS | FAIL]
- **Verifier:** Apollo & Athena
- **Created At:** [Timestamp]
- **Updated At:** [Timestamp]

---

## 1. Sensor Report (Apollo)

Apollo has executed the configured sensor commands:

| Sensor | Target Command | Status | Details |
| :--- | :--- | :--- | :--- |
| [Lint] | `[e.g. npm run lint]` | [SUCCESS | FAIL | SKIP] | [Summary of errors or OK] |
| [Test] | `[e.g. npm test]` | [SUCCESS | FAIL | SKIP] | [Test execution details] |
| [Typecheck] | `[e.g. npm run typecheck]` | [SUCCESS | FAIL | SKIP] | [Compilation details] |
| [Build] | `[e.g. npm run build]` | [SUCCESS | FAIL | SKIP] | [Build status] |

---

## 2. Judgment (Athena)

Athena has reviewed the sensor results and issued the following verdict:

* **Final Verdict:** [PASS | FAIL]
* **Failure Classification:** [e.g. SENS-FAIL | SPEC-MISMATCH | INTEG-FAIL | INFRA-FAIL | None]
* **Severity of Violations:** [BLOCKER | MAJOR | MINOR | INFO | None]
* **Athena Remarks:** [Auditor remarks on verification status, detailing why it passed or failed]
* **Recommended Action:** [e.g. Return to execute command to fix bugs | Proceed to next phase]
