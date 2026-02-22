param(
  [ValidateSet("minimal", "full")]
  [string]$Profile = "full",
  [string]$TargetRoot = (Join-Path $env:USERPROFILE ".codex"),
  [switch]$InstallExternal
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Copy-DirContent {
  param(
    [string]$Source,
    [string]$Destination
  )
  if (-not (Test-Path -LiteralPath $Source)) { return }
  New-Item -ItemType Directory -Force -Path $Destination | Out-Null
  Copy-Item -Path (Join-Path $Source '*') -Destination $Destination -Recurse -Force
}

Write-Host "=== VCO Codex Installer ===" -ForegroundColor Cyan
Write-Host "Profile: $Profile"
Write-Host "Target : $TargetRoot"

$paths = @(
  "skills",
  "rules",
  "hooks",
  "agents\templates",
  "mcp\profiles",
  "config",
  "commands"
)
foreach ($p in $paths) {
  New-Item -ItemType Directory -Force -Path (Join-Path $TargetRoot $p) | Out-Null
}

Copy-DirContent -Source (Join-Path $RepoRoot 'bundled\skills') -Destination (Join-Path $TargetRoot 'skills')

$requiredSp = @('brainstorming', 'writing-plans', 'subagent-driven-development', 'systematic-debugging')
$optionalSp = @('requesting-code-review', 'receiving-code-review', 'verification-before-completion')

$spSrcRoot = Join-Path $RepoRoot 'bundled\superpowers-skills'
foreach ($name in $requiredSp) {
  Copy-DirContent -Source (Join-Path $spSrcRoot $name) -Destination (Join-Path $TargetRoot "skills\$name")
}
if ($Profile -eq 'full') {
  foreach ($name in $optionalSp) {
    Copy-DirContent -Source (Join-Path $spSrcRoot $name) -Destination (Join-Path $TargetRoot "skills\$name")
  }
}

Copy-DirContent -Source (Join-Path $RepoRoot 'rules') -Destination (Join-Path $TargetRoot 'rules')
Copy-DirContent -Source (Join-Path $RepoRoot 'hooks') -Destination (Join-Path $TargetRoot 'hooks')
Copy-DirContent -Source (Join-Path $RepoRoot 'agents\templates') -Destination (Join-Path $TargetRoot 'agents\templates')
Copy-DirContent -Source (Join-Path $RepoRoot 'mcp') -Destination (Join-Path $TargetRoot 'mcp')

Copy-Item -LiteralPath (Join-Path $RepoRoot 'config\plugins-manifest.codex.json') -Destination (Join-Path $TargetRoot 'config\plugins-manifest.codex.json') -Force
Copy-Item -LiteralPath (Join-Path $RepoRoot 'config\upstream-lock.json') -Destination (Join-Path $TargetRoot 'config\upstream-lock.json') -Force

$settingsTarget = Join-Path $TargetRoot 'settings.json'
if (-not (Test-Path -LiteralPath $settingsTarget)) {
  Copy-Item -LiteralPath (Join-Path $RepoRoot 'config\settings.template.codex.json') -Destination $settingsTarget -Force
  Write-Host "Created settings.json from template" -ForegroundColor Yellow
} else {
  Write-Host "settings.json already exists (kept as-is)"
}

if ($InstallExternal) {
  Write-Host "Installing optional external dependencies..."

  if (Get-Command git -ErrorAction SilentlyContinue) {
    $temp = Join-Path $env:TEMP ("superclaude-" + [guid]::NewGuid().ToString("N"))
    try {
      git clone --depth 1 https://github.com/SuperClaude-Org/SuperClaude_Framework.git $temp | Out-Null
      $dest = Join-Path $TargetRoot 'commands\sc'
      if (Test-Path -LiteralPath $dest) { Remove-Item -LiteralPath $dest -Recurse -Force }
      if (Test-Path -LiteralPath (Join-Path $temp 'commands\sc')) {
        Copy-Item -LiteralPath (Join-Path $temp 'commands\sc') -Destination $dest -Recurse -Force
      } elseif (Test-Path -LiteralPath (Join-Path $temp 'sc')) {
        Copy-Item -LiteralPath (Join-Path $temp 'sc') -Destination $dest -Recurse -Force
      }
      Write-Host "Installed SuperClaude commands"
    } catch {
      Write-Warning "Failed to install SuperClaude commands: $($_.Exception.Message)"
    } finally {
      if (Test-Path -LiteralPath $temp) { Remove-Item -LiteralPath $temp -Recurse -Force }
    }
  }

  if (Get-Command npm -ErrorAction SilentlyContinue) {
    try {
      npm install -g claude-flow | Out-Null
      Write-Host "Installed claude-flow"
    } catch {
      Write-Warning "Failed to install claude-flow"
    }
  }

  if (Get-Command claude -ErrorAction SilentlyContinue) {
    try {
      $manifest = Get-Content -LiteralPath (Join-Path $RepoRoot 'config\plugins-manifest.codex.json') -Raw | ConvertFrom-Json
      foreach ($plugin in $manifest.core) {
        try {
          Invoke-Expression $plugin.install | Out-Null
          Write-Host "Installed plugin: $($plugin.name)"
        } catch {
          Write-Warning "Failed plugin install: $($plugin.name)"
        }
      }
    } catch {
      Write-Warning "Failed to process plugin manifest"
    }
  }
}

Write-Host ""
Write-Host "Installation complete." -ForegroundColor Green
Write-Host "Run: powershell -ExecutionPolicy Bypass -File .\check.ps1 -Profile $Profile -TargetRoot `"$TargetRoot`""
