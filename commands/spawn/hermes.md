# Command: /spawn:hermes

Spawn an isolated Claude Code session pre-loaded as Hermes (Messenger and Memory) in a new terminal window.

## Action

Write a temporary launcher script and execute it in a new terminal. Using a script file avoids nested quote escaping for paths that contain spaces.

---

**Windows (PowerShell + Windows Terminal):**
```powershell
$project = (Get-Location).Path
$escapedProject = $project -replace "'", "''"
$script = @"
Set-Location '$escapedProject'
claude 'You are Hermes. Read your skill file at $($project -replace "'", "''")\skills\hermes\SKILL.md and follow it exactly. Wait for the developer to request a status or resume.'
"@
$tmp = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "pantheon-hermes-$(Get-Random).ps1")
Set-Content -Path $tmp -Value $script -Encoding UTF8
Start-Process wt -ArgumentList "new-tab", "--title", "Hermes", "--", "pwsh", "-NoExit", "-File", $tmp
```

---

**macOS:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-hermes-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Hermes. Read your skill file at ${PROJECT}/skills/hermes/SKILL.md and follow it exactly. Wait for the developer to request a status or resume." \
  > "$TMP"
chmod +x "$TMP"
open -a Terminal "$TMP"
```

---

**Linux:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-hermes-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Hermes. Read your skill file at ${PROJECT}/skills/hermes/SKILL.md and follow it exactly. Wait for the developer to request a status or resume." \
  > "$TMP"
chmod +x "$TMP"
gnome-terminal --title="Hermes" -- bash "$TMP"
```

---

## After Spawning

Confirm to the developer:
```
Hermes is running in a new terminal. Switch to that window to check status or restore context.
```
