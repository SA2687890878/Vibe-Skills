---
name: ralph-loop
description: Codex-compatible Ralph loop runner that keeps the original name and state format while using manual iteration steps.
---

# ralph-loop

This is a compatibility version of the Claude `ralph-loop` command for Codex.

## Compatibility model

- Keeps the same command name: `ralph-loop`.
- Keeps the same default state file format: `.claude/ralph-loop.local.md`.
- Codex has no Claude Stop hook, so iteration is manual via `--next`.

## Script

- Script path: `scripts/ralph-loop.ps1`

## Usage

```powershell
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
$script = Join-Path $codexHome 'skills/ralph-loop/scripts/ralph-loop.ps1'

# Start a loop
powershell -ExecutionPolicy Bypass -File $script Build a todo API --max-iterations 20 --completion-promise DONE

# Move to the next iteration manually
powershell -ExecutionPolicy Bypass -File $script --next

# Show current loop state
powershell -ExecutionPolicy Bypass -File $script --status

# Force restart with a new prompt
powershell -ExecutionPolicy Bypass -File $script New prompt --max-iterations 10 --force
```

## Vibe compatibility

- Safe in `/vibe` routed sessions as a direct execution tool.
- Does not force multi-agent orchestration.
- Keeps command names stable for unified memory and invocation.

## Notes

- If `max_iterations` is reached, the state file is removed automatically.
- Completion promises are tracked in state for compatibility, but completion is still decided by the operator/agent in Codex mode.

