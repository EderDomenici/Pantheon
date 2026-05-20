# Command: /pantheon:init

## 1. Overview
* **Description:** Bootstraps the Pantheon workspace for this project. Creates the `.pantheon/` folder, generates `config.json` with sensor defaults, and initializes `PROGRESS.md`.
* **Responsible Agent:** Zeus
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* None. This is always the first command to run in a new project.
* If `.pantheon/` already exists, Zeus must warn the developer and abort — never overwrite an existing workspace.

## 3. Inputs
* Developer answers to Zeus's bootstrap questions (interactive).

## 4. Execution Sequence

1. **Existence Check:** Zeus checks if `.pantheon/` already exists in the project root.
   - If yes: abort with message `".pantheon/ already exists. Use /pantheon:status to check current state."`
   - If no: proceed.

2. **Bootstrap Interview:** Zeus asks the developer the following questions:
   - `Project name?`
   - `Primary language / runtime?` (e.g. Node.js + TypeScript, Python, Go)
   - `Lint command?` (e.g. `npm run lint`) — accepts `none` to skip
   - `Typecheck command?` (e.g. `npx tsc --noEmit`) — accepts `none` to skip
   - `Test command?` (e.g. `npm test`) — accepts `none` to skip
   - `Build command?` (e.g. `npm run build`) — accepts `none` to skip

3. **Folder Creation:** Zeus creates the `.pantheon/` directory.

4. **Config Generation:** Zeus writes `.pantheon/config.json` using the answers:

```json
{
  "project": "<project name>",
  "runtime": "<language / runtime>",
  "commit_template": "[{task_id}] {description}",
  "sensors": {
    "lint":      { "command": "<lint command or null>",      "enabled": true },
    "typecheck": { "command": "<typecheck command or null>",  "enabled": true },
    "test":      { "command": "<test command or null>",       "enabled": true },
    "build":     { "command": "<build command or null>",      "enabled": false }
  }
}
```
   - If the developer answered `none` for a sensor, set `"enabled": false` and `"command": null`.

5. **Progress Initialization:** Zeus creates `.pantheon/PROGRESS.md` from the `PROGRESS.template.md` schema with:
   - Status: `INITIALIZED`
   - Phase: none
   - Last completed task: none
   - Next command: `/pantheon:discuss`

6. **Confirmation Output:** Zeus prints a summary:

```
Pantheon workspace initialized.

Created:
  .pantheon/config.json
  .pantheon/PROGRESS.md

Sensors configured:
  lint      → <command or disabled>
  typecheck → <command or disabled>
  test      → <command or disabled>
  build     → <command or disabled>

Next step: /pantheon:discuss
```

## 5. Outputs
* **`.pantheon/config.json`**: Project configuration and sensor definitions.
* **`.pantheon/PROGRESS.md`**: Initial progress state file.
