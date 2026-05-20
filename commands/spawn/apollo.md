# Command: /spawn:apollo

Spawn an isolated Claude Code session pre-loaded as Apollo (Sensor) in a new terminal window.

## Action

Write a temporary launcher script and execute it in a new terminal. Using a script file avoids nested quote escaping for paths that contain spaces.

---

**Windows (PowerShell + Windows Terminal):**
```powershell
$project = (Get-Location).Path
$escapedProject = $project -replace "'", "''"
$script = @"
Set-Location '$escapedProject'
claude 'You are Apollo. Read your skill file at $($project -replace "'", "''")\skills\apollo\SKILL.md and follow it exactly. Wait for the developer to trigger sensor execution.'
"@
$tmp = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "pantheon-apollo-$(Get-Random).ps1")
Set-Content -Path $tmp -Value $script -Encoding UTF8
Start-Process wt -ArgumentList "new-tab", "--title", "Apollo", "--", "pwsh", "-NoExit", "-File", $tmp
```

---

**macOS:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-apollo-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Apollo. Read your skill file at ${PROJECT}/skills/apollo/SKILL.md and follow it exactly. Wait for the developer to trigger sensor execution." \
  > "$TMP"
chmod +x "$TMP"
open -a Terminal "$TMP"
```

---

**Linux:**
```bash
PROJECT="$(pwd)"
TMP=$(mktemp /tmp/pantheon-apollo-XXXXXX.sh)
printf '#!/usr/bin/env bash\ncd %q\nclaude %q\n' \
  "$PROJECT" \
  "You are Apollo. Read your skill file at ${PROJECT}/skills/apollo/SKILL.md and follow it exactly. Wait for the developer to trigger sensor execution." \
  > "$TMP"
chmod +x "$TMP"
gnome-terminal --title="Apollo" -- bash "$TMP"
```

---

## After Spawning

Confirm to the developer:
```
Apollo is running in a new terminal. Switch to that window to trigger sensor runs.
```
