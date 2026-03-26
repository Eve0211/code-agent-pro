# Code Agent Pro — Dependency Setup Script (PowerShell)
# Checks optional integration skills and creates fallback files if missing.
# Usage: .\setup.ps1 [-InstallDir <path>] [-Verbose]

param(
    [string]$InstallDir = (Split-Path $PSScriptRoot -Parent),
    [switch]$Verbose
)

$ErrorActionPreference = "Continue"

$RefsDir = Join-Path -Path $InstallDir -ChildPath "references"
$FallbackMarker = "# AUTO-GENERATED FALLBACK"

function Write-Info($msg)  { Write-Host "[INFO] $msg" -ForegroundColor Blue }
function Write-Ok($msg)    { Write-Host "[OK]   $msg" -ForegroundColor Green }
function Write-Warn($msg)  { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Miss($msg)  { Write-Host "[MISS] $msg" -ForegroundColor Red }
function Write-Sep()       { Write-Host ([string][char]0x2500 * 47) }

# Skill search paths
$SkillSearchPaths = @(
    "$env:USERPROFILE\.qclaw\workspace\skills",
    "$env:USERPROFILE\.claude\skills",
    (Split-Path $InstallDir -Parent)
)

function Find-Skill {
    param([string]$Name)
    foreach ($dir in $SkillSearchPaths) {
        if ($dir -and (Test-Path $dir)) {
            $skillPath = Join-Path -Path $dir -ChildPath "$Name\SKILL.md"
            if (Test-Path $skillPath) {
                return (Join-Path -Path $dir -ChildPath $Name)
            }
        }
    }
    return $null
}

function Test-Skill {
    param([string]$Name, [string]$DisplayName)
    $found = Find-Skill -Name $Name
    if ($found) {
        Write-Ok "$DisplayName found at $found"
        return $true
    } else {
        Write-Miss "$DisplayName not installed - will use built-in fallback"
        return $false
    }
}

# ── Header ──────────────────────────────────────────────────
Write-Host ""
Write-Host "========================================"
Write-Host "  Code Agent Pro - Dependency Check   "
Write-Host "========================================"
Write-Host ""

# ── Check Integration Skills ────────────────────────────────
Write-Sep
Write-Info "Checking optional integration skills..."
Write-Sep
Write-Host ""

$HasWriteAPrd = Test-Skill "write-a-prd" "write-a-prd (PRD generation)"
$HasSuperdesign = Test-Skill "superdesign" "superdesign (frontend design)"
$HasUiUxProMax = Test-Skill "ui-ux-pro-max" "ui-ux-pro-max (UX audit)"
$HasGithub = Test-Skill "github" "github (commit/PR)"
$HasWebappTesting = Test-Skill "webapp-testing" "webapp-testing (E2E tests)"

# ── Check Core Files ────────────────────────────────────────
Write-Host ""
Write-Sep
Write-Info "Checking core skill integrity..."
Write-Sep
Write-Host ""

$CoreFiles = @(
    "SKILL.md",
    "references\spec-workflow.md",
    "references\memory-system.md",
    "references\quality-assurance.md",
    "references\execution-environment.md",
    "references\security-audit.md",
    "references\learning-loop.md",
    "references\backend-patterns.md",
    "references\cross-lang-patterns.md",
    "references\skill-integrations.md",
    "references\project-onboarding.md"
)

$AllCoreOk = $true
foreach ($f in $CoreFiles) {
    $fullPath = Join-Path $InstallDir $f
    if (Test-Path $fullPath) {
        Write-Ok $f
    } else {
        Write-Miss "$f is missing!"
        $AllCoreOk = $false
    }
}

# ── Generate Fallbacks ──────────────────────────────────────
Write-Host ""
Write-Sep
Write-Info "Generating fallback files for missing skills..."
Write-Sep
Write-Host ""

if (-not $HasSuperdesign) {
    $fallbackFile = Join-Path $RefsDir "frontend-design-fallback.md"
    if (-not (Test-Path $fallbackFile)) {
        $fallbackContent = @"
# Frontend Design Fallback

> Auto-generated fallback for when superdesign skill is not installed.
> Install superdesign for enhanced design: skillhub install superdesign

## Design Workflow (Minimal)

1. Layout - Sketch ASCII wireframe before coding
2. Theme - Define CSS variables with oklch()
3. Animation - Plan micro-interactions (150-400ms, ease-out)
4. Implement - Generate code

## Quick Reference

Color: Use oklch(), semantic variables, avoid generic bootstrap blue (#007bff)
Font: Distinctive choices (avoid Inter/Roboto as primary identity font)
Spacing: 0.25rem base unit
Animation: entry 300-500ms, hover 150-200ms, press 100-150ms
Responsive: Mobile-first, breakpoints at 768px / 1024px / 1440px
Accessibility: Semantic HTML, heading hierarchy, 4.5:1 contrast, keyboard nav

## Anti-Patterns

- No purple-gradient-on-white (AI cliche)
- No Space Grotesk as creative choice
- No emoji as icons
- No heavy drop shadows

# AUTO-GENERATED FALLBACK - do not edit manually
"@
        Set-Content -Path $fallbackFile -Value $fallbackContent -Encoding UTF8
        Write-Ok "Created frontend-design-fallback.md"
    } else {
        Write-Ok "frontend-design-fallback.md already exists"
    }
}

if (-not $HasWriteAPrd) {
    Write-Warn "write-a-prd not installed - SPEC workflow uses embedded PRD template"
}

# ── Summary ─────────────────────────────────────────────────
Write-Host ""
Write-Sep
Write-Host ""
Write-Host "  Summary"
Write-Host ""

$Installed = 0
$Missing = 0
if ($HasWriteAPrd)     { $Installed++ } else { $Missing++ }
if ($HasSuperdesign)   { $Installed++ } else { $Missing++ }
if ($HasUiUxProMax)    { $Installed++ } else { $Missing++ }
if ($HasGithub)        { $Installed++ } else { $Missing++ }
if ($HasWebappTesting) { $Installed++ } else { $Missing++ }

Write-Host "  Integration skills: $Installed installed, $Missing using fallback"
if ($AllCoreOk) {
    Write-Host "  Core skill files:   all present" -ForegroundColor Green
} else {
    Write-Host "  Core skill files:   some MISSING" -ForegroundColor Red
}
Write-Host ""

if ($Missing -gt 0) {
    Write-Host "  To install missing skills:"
    if (-not $HasWriteAPrd)     { Write-Host "    skillhub install write-a-prd" }
    if (-not $HasSuperdesign)   { Write-Host "    skillhub install superdesign" }
    if (-not $HasUiUxProMax)    { Write-Host "    skillhub install ui-ux-pro-max" }
    if (-not $HasGithub)        { Write-Host "    skillhub install github" }
    if (-not $HasWebappTesting) { Write-Host "    skillhub install webapp-testing" }
    Write-Host ""
}

if ($AllCoreOk) {
    Write-Host "  Done - Code Agent Pro is ready to use!" -ForegroundColor Green
} else {
    Write-Host "  Warning - Some core files are missing." -ForegroundColor Red
}
Write-Host ""
