# Command: /pantheon:jump

## 1. Overview
- **Description:** Restores a previously saved checkpoint or jumps to a specific phase, overriding the current pipeline flow. Enables dynamic recovery and phase navigation for the developer.
- **Responsible Agent:** Zeus / Hermes
- **Runtimes Target:** Claude Code, Codex

---

## 2. Pre-conditions
- A valid checkpoint must exist in `.pantheon/checkpoints/` OR a valid phase ID must be provided.
- `.pantheon/config.json` must exist.

---

## 3. Inputs
- `<checkpoint_name>` or `<phase_id>` provided by the developer.

---

## 4. Execution Sequence
1. **Invocation:** Developer triggers `/pantheon:jump <target>`.
2. **Target resolution:** Hermes locates the checkpoint directory (`.pantheon/checkpoints/<target>/`) or resolves the phase ID. If not found:
   ```
   [ZEUS-BLOCKED] Command: `/pantheon:jump`
   Reason: Checkpoint or phase "<target>" not found in .pantheon/checkpoints/.
   Action: Run `/pantheon:checkpoint` to save current state first, or check available checkpoints.
   ```
3. **Git divergence check (mandatory):** Before restoring, Hermes compares the Git `HEAD` at the time the checkpoint was saved (stored as `git_sha` in the checkpoint manifest) against the current `HEAD`.
   - If they **match**: proceed to restore.
   - If they **diverge**: Zeus warns the developer:
     ```
     [ZEUS-WARNING] Checkpoint "<target>" was saved at commit <short_sha>.
     Current HEAD is <current_short_sha> (<N> commits ahead).
     Restoring framework state without matching Git state may cause inconsistencies.
     Confirm: `/pantheon:jump <target> --force` to proceed anyway.
     ```
   - If `--force` is not passed, execution halts.
4. **State restoration:** Hermes copies checkpoint files (`PROGRESS.md`, `PLAN.md`, and other captured state files) back into `.pantheon/`.
5. **Context reset:** Zeus resets its internal phase validation to match the restored files.
6. **Completion:** Zeus confirms:
   ```
   [ZEUS] Phase restored: <restored_phase>
   Status: ✅ Jump complete.
   Next command: `<next_valid_command>`
   ```

---

## 5. Outputs
- Restored `.pantheon/` state files (`PROGRESS.md`, `PLAN.md`, etc.).
- Zeus context reset to the restored phase.
- Warning report if Git state diverged (even if `--force` was used).

---

## 6. Checkpoint Manifest Format
Every checkpoint saved by `/pantheon:checkpoint` must include a `manifest.json`:
```json
{
  "name": "<checkpoint_name>",
  "created_at": "<ISO timestamp>",
  "git_sha": "<full commit SHA at checkpoint time>",
  "phase": "<phase ID>",
  "status": "<STATUS value>"
}
```
This manifest is what Hermes uses for the divergence check in Step 3.
