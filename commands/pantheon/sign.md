# Command: /pantheon:sign

## 1. Overview
* **Description:** Invokes Themis (the Contract Signer) to validate the alignment between the requirements spec and the execution plan, and sign off the formal phase contract.
* **Responsible Agent:** Themis
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* `SPEC.md` must be finalized.
* `PLAN.md` must be `APPROVED` by Athena.

## 3. Inputs
* `SPEC.md`
* `phases/XX/PLAN.md` (APPROVED)

## 4. Execution Sequence
1. **Invocation:** The developer or agent triggers `/pantheon:sign`.
2. **Alignment Review:** Themis evaluates if all requirements in `SPEC.md` have corresponding execution tasks in `PLAN.md` and checks for out-of-scope files.
3. **Contract Compilation:** Themis creates `CONTRACT.md` listing the deliverables, verification parameters, and signature block.
4. **Signature:** If alignment is successful, Themis signs the contract, setting the status of `CONTRACT.md` to `SIGNED`. Otherwise, status is set to `REJECTED` with a list of discrepancies.

## 5. Outputs
* **`phases/XX/CONTRACT.md`**: Formal signed contract authorizing code execution.
