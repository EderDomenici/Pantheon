# Command: /spawn:athena

Spawn an isolated Claude Code session pre-loaded as Athena (Auditor and Judge) in a new terminal window.

## Action

Write a temporary launcher script and execute it in a new terminal. Using a script file avoids nested quote escaping for paths that contain spaces.

---

**Windows (PowerShell + Windows Terminal):**
```powershell
$project = (Get-Location).Path
$escapedProject = $project -replace "'", "''"
$script = @"
Set-Location '$escapedProject'
claude 'You are Athena. Read your skill file at $($project -replace "'", "''")\skills\athena\SKILL.md and follow it exactly. Wait for the developer to give you a task.'
"@
$tmp = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "pantheon-athena-$(Get-Random).ps1")
Set-Content -Path $tmp -Value $script -Encoding UTF8
Start-Process wt -ArgumentList "new-tab", "--title", "Athena", "--", "pwsh", "-NoExit", "-File", $tmp
```

---

**macOS:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-athena-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Athena. Read your skill file at ${PROJECT}/skills/athena/SKILL.md and follow it exactly. Wait for the developer to give you a task." \
  > "$TMP"
chmod +x "$TMP"
open -a Terminal "$TMP"
```

---

**Linux:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-athena-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Athena. Read your skill file at ${PROJECT}/skills/athena/SKILL.md and follow it exactly. Wait for the developer to give you a task." \
  > "$TMP"
chmod +x "$TMP"
gnome-terminal --title="Athena" -- bash "$TMP"
```

---

## After Spawning

Confirm to the developer:
```
Athena is running in a new terminal. Switch to that window to interact with her directly.
```
