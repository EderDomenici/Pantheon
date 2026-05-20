# Command: /spawn:themis

Spawn an isolated Claude Code session pre-loaded as Themis (Contract Signer) in a new terminal window.

## Action

Write a temporary launcher script and execute it in a new terminal. Using a script file avoids nested quote escaping for paths that contain spaces.

---

**Windows (PowerShell + Windows Terminal):**
```powershell
$project = (Get-Location).Path
$escapedProject = $project -replace "'", "''"
$script = @"
Set-Location '$escapedProject'
claude 'You are Themis. Read your skill file at $($project -replace "'", "''")\skills\themis\SKILL.md and follow it exactly. Wait for the developer to request contract validation.'
"@
$tmp = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "pantheon-themis-$(Get-Random).ps1")
Set-Content -Path $tmp -Value $script -Encoding UTF8
Start-Process wt -ArgumentList "new-tab", "--title", "Themis", "--", "pwsh", "-NoExit", "-File", $tmp
```

---

**macOS:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-themis-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Themis. Read your skill file at ${PROJECT}/skills/themis/SKILL.md and follow it exactly. Wait for the developer to request contract validation." \
  > "$TMP"
chmod +x "$TMP"
open -a Terminal "$TMP"
```

---

**Linux:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-themis-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Themis. Read your skill file at ${PROJECT}/skills/themis/SKILL.md and follow it exactly. Wait for the developer to request contract validation." \
  > "$TMP"
chmod +x "$TMP"
gnome-terminal --title="Themis" -- bash "$TMP"
```

---

## After Spawning

Confirm to the developer:
```
Themis is running in a new terminal. Switch to that window to request contract signing.
```
