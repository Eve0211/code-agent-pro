#!/usr/bin/env bash
# Code Agent Pro — Dependency Setup Script
# Checks optional integration skills and creates fallback files if missing.
# Usage: bash setup.sh [--install-dir <path>] [--verbose]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="${SCRIPT_DIR}/.."
VERBOSE=false

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC}   $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_fail()  { echo -e "${RED}[MISS]${NC} $1"; }
log_sep()   { echo -e "───────────────────────────────────────"; }

# Parse args
while [[ $# -gt 0 ]]; do
  case $1 in
    --install-dir) INSTALL_DIR="$2"; shift 2 ;;
    --verbose) VERBOSE=true; shift ;;
    -h|--help)
      echo "Usage: bash setup.sh [--install-dir <path>] [--verbose]"
      echo ""
      echo "Checks optional integration skills and creates fallback files."
      echo ""
      echo "Options:"
      echo "  --install-dir  Path to code-agent-pro skill directory (default: parent of scripts/)"
      echo "  --verbose      Show detailed output"
      echo "  --help         Show this help"
      exit 0 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

REFS_DIR="${INSTALL_DIR}/references"
FALLBACK_MARKER="# AUTO-GENERATED FALLBACK — do not edit manually"

# Skill search paths (most common locations)
SKILL_SEARCH_PATHS=(
  "$HOME/.qclaw/workspace/skills"
  "$HOME/.claude/skills"
  "${INSTALL_DIR}/../.."   # sibling skills in config/skills/
)

find_skill() {
  local name="$1"
  for dir in "${SKILL_SEARCH_PATHS[@]}"; do
    if [[ -f "${dir}/${name}/SKILL.md" ]]; then
      echo "${dir}/${name}"
      return 0
    fi
  done
  return 1
}

check_skill() {
  local name="$1"
  local display_name="${2:-$name}"
  if found=$(find_skill "$name"); then
    log_ok "${display_name} found at ${found}"
    return 0
  else
    log_fail "${display_name} not installed — will use built-in fallback"
    return 1
  fi
}

# ── Check Dependencies ──────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║     Code Agent Pro — Dependency Check        ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

log_sep
log_info "Checking optional integration skills..."
log_sep
echo ""

HAS_WRITE_A_PRD=false
HAS_SUPERDESIGN=false
HAS_UI_UX_PRO_MAX=false
HAS_GITHUB=false
HAS_WEBAPP_TESTING=false

check_skill "write-a-prd" "write-a-prd (PRD generation)" && HAS_WRITE_A_PRD=true || true
check_skill "superdesign" "superdesign (frontend design)" && HAS_SUPERDESIGN=true || true
check_skill "ui-ux-pro-max" "ui-ux-pro-max (UX audit)" && HAS_UI_UX_PRO_MAX=true || true
check_skill "github" "github (commit/PR)" && HAS_GITHUB=true || true
check_skill "webapp-testing" "webapp-testing (E2E tests)" && HAS_WEBAPP_TESTING=true || true

echo ""
log_sep
log_info "Checking core skill integrity..."
log_sep
echo ""

CORE_FILES=(
  "SKILL.md"
  "references/spec-workflow.md"
  "references/memory-system.md"
  "references/quality-assurance.md"
  "references/execution-environment.md"
  "references/security-audit.md"
  "references/learning-loop.md"
  "references/backend-patterns.md"
  "references/cross-lang-patterns.md"
  "references/skill-integrations.md"
  "references/project-onboarding.md"
)

ALL_CORE_OK=true
for f in "${CORE_FILES[@]}"; do
  if [[ -f "${INSTALL_DIR}/${f}" ]]; then
    log_ok "${f}"
  else
    log_fail "${f} is missing!"
    ALL_CORE_OK=false
  fi
done

# ── Generate Fallback Files ────────────────────────────────
echo ""
log_sep
log_info "Generating fallback files for missing skills..."
log_sep
echo ""

if [[ "$HAS_SUPERDESIGN" == "false" ]]; then
  FALLBACK_FILE="${REFS_DIR}/frontend-design-fallback.md"
  if [[ ! -f "$FALLBACK_FILE" ]] || [[ "$(head -1 "$FALLBACK_FILE")" == "$FALLBACK_MARKER" ]]; then
    cat > "$FALLBACK_FILE" << 'FALLBACK_EOF'
# Frontend Design Fallback

> Auto-generated fallback for when `superdesign` skill is not installed.
> Install superdesign for enhanced frontend design: `skillhub install superdesign`

## Design Workflow (Minimal)

1. **Layout** — Sketch ASCII wireframe before coding
2. **Theme** — Define CSS variables (--primary, --secondary, --muted, etc.) with oklch()
3. **Animation** — Plan micro-interactions (150-400ms, ease-out)
4. **Implement** — Generate code

## Quick Reference

**Color**: Use oklch(), semantic variables, avoid generic bootstrap blue (#007bff)
**Font**: Distinctive choices (avoid Inter/Roboto as primary identity font)
**Spacing**: 0.25rem base unit
**Animation**: entry 300-500ms, hover 150-200ms, press 100-150ms
**Responsive**: Mobile-first, breakpoints at 768px / 1024px / 1440px
**Accessibility**: Semantic HTML, heading hierarchy, 4.5:1 contrast, keyboard nav

## Anti-Patterns

- No purple-gradient-on-white (AI cliché)
- No Space Grotesk as "creative" choice
- No emoji as icons
- No heavy drop shadows
FALLBACK_EOF
    echo "${FALLBACK_MARKER}" >> "$FALLBACK_FILE"
    log_ok "Created frontend-design-fallback.md"
  else
    log_ok "frontend-design-fallback.md already exists (not overwritten)"
  fi
fi

if [[ "$HAS_WRITE_A_PRD" == "false" ]]; then
  log_warn "write-a-prd not installed — SPEC workflow will use embedded PRD template"
  log_info "Install with: skillhub install write-a-prd"
fi

# ── Summary ─────────────────────────────────────────────────
echo ""
log_sep
echo ""
echo "  Summary"
echo ""
INSTALLED=0; MISSING=0
$HAS_WRITE_A_PRD && ((INSTALLED++)) || ((MISSING++))
$HAS_SUPERDESIGN && ((INSTALLED++)) || ((MISSING++))
$HAS_UI_UX_PRO_MAX && ((INSTALLED++)) || ((MISSING++))
$HAS_GITHUB && ((INSTALLED++)) || ((MISSING++))
$HAS_WEBAPP_TESTING && ((INSTALLED++)) || ((MISSING++))

echo "  Integration skills: ${GREEN}${INSTALLED} installed${NC}, ${YELLOW}${MISSING} using fallback${NC}"
echo "  Core skill files:   $(if $ALL_CORE_OK; then echo "${GREEN}all present${NC}"; else echo "${RED}some missing${NC}"; fi)"
echo ""

if [[ "$MISSING" -gt 0 ]]; then
  echo "  To install missing skills:"
  $HAS_WRITE_A_PRD || echo "    skillhub install write-a-prd"
  $HAS_SUPERDESIGN || echo "    skillhub install superdesign"
  $HAS_UI_UX_PRO_MAX || echo "    skillhub install ui-ux-pro-max"
  $HAS_GITHUB || echo "    skillhub install github"
  $HAS_WEBAPP_TESTING || echo "    skillhub install webapp-testing"
  echo ""
fi

if $ALL_CORE_OK; then
  echo -e "  ${GREEN}✓ Code Agent Pro is ready to use!${NC}"
else
  echo -e "  ${RED}✗ Some core files are missing. Please reinstall the skill.${NC}"
fi
echo ""
