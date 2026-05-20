# Command: /spawn:hephaestus

Spawn an isolated Claude Code session pre-loaded as Hephaestus (Builder) in a new terminal window.

## Action

Write a temporary launcher script and execute it in a new terminal. Using a script file avoids nested quote escaping for paths that contain spaces.

---

**Windows (PowerShell + Windows Terminal):**
```powershell
$project = (Get-Location).Path
$escapedProject = $project -replace "'", "''"
$script = @"
Set-Location '$escapedProject'
claude 'You are Hephaestus. Read your skill file at $($project -replace "'", "''")\skills\hephaestus\SKILL.md and follow it exactly. Wait for the developer to trigger task execution.'
"@
$tmp = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "pantheon-hephaestus-$(Get-Random).ps1")
Set-Content -Path $tmp -Value $script -Encoding UTF8
Start-Process wt -ArgumentList "new-tab", "--title", "Hephaestus", "--", "pwsh", "-NoExit", "-File", $tmp
```

---

**macOS:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-hephaestus-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Hephaestus. Read your skill file at ${PROJECT}/skills/hephaestus/SKILL.md and follow it exactly. Wait for the developer to trigger task execution." \
  > "$TMP"
chmod +x "$TMP"
open -a Terminal "$TMP"
```

---

**Linux:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-hephaestus-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Hephaestus. Read your skill file at ${PROJECT}/skills/hephaestus/SKILL.md and follow it exactly. Wait for the developer to trigger task execution." \
  > "$TMP"
chmod +x "$TMP"
gnome-terminal --title="Hephaestus" -- bash "$TMP"
```

---

## After Spawning

Confirm to the developer:
```
Hephaestus is running in a new terminal. Switch to that window to trigger task execution.
```
