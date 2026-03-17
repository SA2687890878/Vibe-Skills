Set-StrictMode -Version Latest

function Get-VgoAntiProxyGoalDriftPolicy {
    param(
        [Parameter(Mandatory)] [string]$RepoRoot
    )

    $path = Join-Path $RepoRoot 'config\anti-proxy-goal-drift-policy.json'
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Anti-proxy-goal-drift policy missing: $path"
    }

    return (Get-Content -LiteralPath $path -Raw -Encoding UTF8 | ConvertFrom-Json)
}

function Get-VgoTierRank {
    param([AllowNull()] [string]$Tier)

    switch ($Tier) {
        'Tier A' { return 3 }
        'Tier B' { return 2 }
        'Tier C' { return 1 }
        default { return 0 }
    }
}

function Test-VgoValuePresent {
    param([AllowNull()] [object]$Value)

    if ($null -eq $Value) { return $false }
    if ($Value -is [string]) { return (-not [string]::IsNullOrWhiteSpace($Value)) }
    if ($Value -is [System.Collections.IEnumerable] -and -not ($Value -is [string])) {
        return (@($Value).Count -gt 0)
    }
    return $true
}

function Get-VgoMinimumTierForSurface {
    param(
        [Parameter(Mandatory)] [psobject]$Policy,
        [AllowNull()] [string]$SurfaceClass
    )

    if ([string]::IsNullOrWhiteSpace($SurfaceClass)) {
        return $null
    }

    $prop = $Policy.surface_minimum_tiers.PSObject.Properties[$SurfaceClass]
    if ($null -eq $prop) {
        return $null
    }

    return [string]$prop.Value
}

function Get-VgoProofCaseCount {
    param([AllowNull()] [object]$Bundle)

    if ($null -eq $Bundle) { return 0 }
    if ($Bundle.PSObject.Properties.Name -contains 'cases') {
        return @($Bundle.cases).Count
    }
    return 0
}

function Get-VgoRequiredProofCaseCount {
    param(
        [Parameter(Mandatory)] [psobject]$Policy,
        [AllowNull()] [string]$Tier,
        [AllowNull()] [string]$CompletionState
    )

    if ([string]::IsNullOrWhiteSpace($Tier) -or [string]::IsNullOrWhiteSpace($CompletionState)) {
        return 0
    }

    $tierPolicy = $Policy.proof_bundle_minimums.PSObject.Properties[$Tier]
    if ($null -eq $tierPolicy) { return 0 }
    $statePolicy = $tierPolicy.Value.PSObject.Properties[$CompletionState]
    if ($null -eq $statePolicy) { return 0 }
    return [int]$statePolicy.Value
}

function Test-VgoGeneralizedScope {
    param([AllowNull()] [string]$IntendedScope)

    if ([string]::IsNullOrWhiteSpace($IntendedScope)) { return $false }
    $normalized = $IntendedScope.Trim().ToLowerInvariant()
    return @('generalized', 'class_level', 'reusable', 'shared', 'systemic') -contains $normalized
}

function Test-VgoScenarioSpecificScope {
    param([AllowNull()] [string]$IntendedScope)

    if ([string]::IsNullOrWhiteSpace($IntendedScope)) { return $false }
    $normalized = $IntendedScope.Trim().ToLowerInvariant()
    return @('scenario_specific', 'scenario-local', 'scenario_local', 'bounded_local') -contains $normalized
}

function Get-VgoProxySignalTokens {
    param([AllowNull()] [object]$Signals)

    $tokens = @()
    foreach ($signal in @($Signals)) {
        if ([string]::IsNullOrWhiteSpace([string]$signal)) { continue }
        $tokens += ([string]$signal).Trim().ToLowerInvariant()
    }
    return $tokens
}

function Get-VgoAntiProxyGoalDriftAssessment {
    param(
        [Parameter(Mandatory)] [psobject]$Policy,
        [Parameter(Mandatory)] [psobject]$Packet
    )

    $requiredFields = @(
        'surface_class',
        'primary_objective',
        'non_objective_proxy_signals',
        'validation_material_role',
        'anti_proxy_goal_drift_tier',
        'intended_scope',
        'abstraction_layer_target',
        'completion_state',
        'generalization_evidence_bundle'
    )

    $missingFields = New-Object System.Collections.Generic.List[string]
    foreach ($field in $requiredFields) {
        $value = if ($Packet.PSObject.Properties.Name -contains $field) { $Packet.$field } else { $null }
        if (-not (Test-VgoValuePresent -Value $value)) {
            [void]$missingFields.Add($field)
        }
    }

    $declaredTier = if ($Packet.PSObject.Properties.Name -contains 'anti_proxy_goal_drift_tier') { [string]$Packet.anti_proxy_goal_drift_tier } else { $null }
    $surfaceClass = if ($Packet.PSObject.Properties.Name -contains 'surface_class') { [string]$Packet.surface_class } else { $null }
    $completionState = if ($Packet.PSObject.Properties.Name -contains 'completion_state') { [string]$Packet.completion_state } else { $null }
    $intendedScope = if ($Packet.PSObject.Properties.Name -contains 'intended_scope') { [string]$Packet.intended_scope } else { $null }
    $validationMaterialRole = if ($Packet.PSObject.Properties.Name -contains 'validation_material_role') { [string]$Packet.validation_material_role } else { $null }
    $signals = if ($Packet.PSObject.Properties.Name -contains 'non_objective_proxy_signals') { @($Packet.non_objective_proxy_signals) } else { @() }
    $bundle = if ($Packet.PSObject.Properties.Name -contains 'generalization_evidence_bundle') { $Packet.generalization_evidence_bundle } else { $null }

    $minimumTier = Get-VgoMinimumTierForSurface -Policy $Policy -SurfaceClass $surfaceClass
    $declaredTierRank = Get-VgoTierRank -Tier $declaredTier
    $minimumTierRank = Get-VgoTierRank -Tier $minimumTier
    $actualCaseCount = Get-VgoProofCaseCount -Bundle $bundle
    $requiredCaseCount = Get-VgoRequiredProofCaseCount -Policy $Policy -Tier $declaredTier -CompletionState $completionState
    $warningCodes = New-Object System.Collections.Generic.List[string]

    if ($missingFields.Count -gt 0) {
        [void]$warningCodes.Add('missing_required_field')
    }

    if ($minimumTierRank -gt 0 -and $declaredTierRank -gt 0) {
        if ($declaredTierRank -lt $minimumTierRank) {
            [void]$warningCodes.Add('tier_underclassified')
        } elseif ($declaredTierRank -gt $minimumTierRank) {
            [void]$warningCodes.Add('tier_overclassified')
        }
    }

    if ($requiredCaseCount -gt 0 -and $actualCaseCount -lt $requiredCaseCount) {
        [void]$warningCodes.Add('completion_proof_mismatch')
    }

    $isGeneralized = Test-VgoGeneralizedScope -IntendedScope $intendedScope
    if ($isGeneralized -and $completionState -eq 'complete' -and $actualCaseCount -le 1) {
        [void]$warningCodes.Add('generalization_overclaim')
    }

    $signalTokens = @(Get-VgoProxySignalTokens -Signals $signals)
    $containsProxyTemptation = $false
    foreach ($token in $signalTokens) {
        if ($token.Contains('sample') -or $token.Contains('demo') -or $token.Contains('test green') -or $token.Contains('current test') -or $token.Contains('single case')) {
            $containsProxyTemptation = $true
            break
        }
    }

    if ($containsProxyTemptation -and $completionState -eq 'complete' -and ($actualCaseCount -le 1 -or $validationMaterialRole -ne 'validation_only')) {
        [void]$warningCodes.Add('proxy_signal_overclaim')
    }

    $uniqueWarnings = @($warningCodes | Select-Object -Unique)

    return [pscustomobject]@{
        fixture_id = if ($Packet.PSObject.Properties.Name -contains 'fixture_id') { [string]$Packet.fixture_id } else { '' }
        surface_class = $surfaceClass
        declared_tier = $declaredTier
        minimum_tier = $minimumTier
        completion_state = $completionState
        intended_scope = $intendedScope
        validation_material_role = $validationMaterialRole
        missing_fields = @($missingFields)
        proof_case_count = $actualCaseCount
        required_proof_case_count = $requiredCaseCount
        warning_codes = @($uniqueWarnings)
        warning_count = @($uniqueWarnings).Count
        report_only = $true
        generalized_scope = [bool]$isGeneralized
        scenario_specific_scope = [bool](Test-VgoScenarioSpecificScope -IntendedScope $intendedScope)
    }
}
