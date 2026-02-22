# VCO Skills (Codex Ecosystem)

Codex-first VCO repository with **bundled compatibility rewrites**.

This repo is intentionally different from Claude-only distributions:
- It stores local Codex-compatible skill dependencies directly.
- It does not rely only on upstream repos at runtime.
- It supports reproducible installs through lock manifests and local sync scripts.

## Why This Exists

Many VCO dependencies require compatibility rewrites for Codex. Pulling raw upstream content can break behavior. This repo treats Codex compatibility as the source of truth.

## What Is Included

- `bundled/skills/`: codex-compatible orchestrator and wrappers
- `bundled/superpowers-skills/`: required superpowers workflow skills
- `rules/`: execution, security, testing, workflow rules
- `hooks/`: guard hooks and hookify configs
- `agents/templates/`: planner/reviewer/security/debugger role templates
- `mcp/`: MCP server templates and profiles
- `config/`: lockfiles, dependency map, plugins manifest, settings templates
- `install.ps1` / `install.sh`: setup to local codex home
- `check.ps1` / `check.sh`: post-install health checks

## Quick Start

### Windows (recommended)

```powershell
pwsh -File .\install.ps1 -Profile full -InstallExternal
pwsh -File .\check.ps1 -Profile full
```

### macOS/Linux

```bash
bash install.sh --profile full --install-external
bash check.sh --profile full
```

## Dependency Policy

Dependencies are split into three modes:
- `bundled-local`: stored in repo from local Codex-compatible rewrites (default)
- `upstream-locked`: tracked by commit/tag in `config/upstream-lock.json`
- `reference-only`: documented only, not auto-installed

To refresh bundled local rewrites from your machine:

```powershell
pwsh -File .\scripts\bootstrap\sync-local-compat.ps1
```

## Repository Layout

```text
vco-skills-codex/
  bundled/
    skills/
    superpowers-skills/
  rules/
  hooks/
  agents/templates/
  mcp/profiles/
  config/
  docs/
  scripts/bootstrap/
  scripts/verify/
```

## Current Scope

This repository is now the canonical Codex VCO ecosystem base. The old skill-only form is preserved for backward compatibility (`SKILL.md`, `protocols/`, `references/`).
