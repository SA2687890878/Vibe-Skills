param(
  [ValidateSet("minimal", "full")]
  [string]$Profile = "full",
  [ValidateSet("codex", "claude-code", "cursor", "windsurf", "openclaw", "opencode")]
  [string]$HostId = "codex",
  [string]$TargetRoot = '',
  [switch]$Preview,
  [switch]$PurgeEmptyDirs,
  [switch]$StrictOwnedOnly
)
$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $RepoRoot 'scripts\common\vibe-governance-helpers.ps1')

$HostId = Resolve-VgoHostId -HostId $HostId
$TargetRoot = Resolve-VgoTargetRoot -TargetRoot $TargetRoot -HostId $HostId
Assert-VgoTargetRootMatchesHostIntent -TargetRoot $TargetRoot -HostId $HostId

$wrapperPath = Join-Path $RepoRoot 'scripts\uninstall\Uninstall-VgoAdapter.ps1'
$invokeArgs = @{
  RepoRoot = $RepoRoot
  TargetRoot = $TargetRoot
  HostId = $HostId
  Profile = $Profile
}
if ($Preview) { $invokeArgs.Preview = $true }
if ($PurgeEmptyDirs) { $invokeArgs.PurgeEmptyDirs = $true }
if ($StrictOwnedOnly) { $invokeArgs.StrictOwnedOnly = $true }

& $wrapperPath @invokeArgs
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}
