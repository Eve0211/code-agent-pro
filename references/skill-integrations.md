# Skill Integrations

> The routing brain of Code Agent Pro.
> Decides what runs when, what's embedded vs. external, and how to degrade gracefully.

---

## Integration Philosophy

### The Core Question: When to Add a Skill?

Not every language or framework needs its own skill. The decision rule:

```
ADD a specialist skill when:
  ✅ The framework has "silent pitfalls" — code looks correct but
     misbehaves at runtime (wrong performance, wrong rendering)
  ✅ Static analysis tools CANNOT catch the issue
  ✅ The rules are framework-specific, not general engineering

SKIP a specialist skill when:
  ❌ Standard tooling already enforces best practices
     (ruff, go vet, clippy, eslint, tsc)
  ❌ Performance issues are visible via profiling/benchmarks
  ❌ The pattern is universal across languages
     → embed it in backend-patterns.md instead
```

### Why React Gets Special Treatment

React's performance problems are **invisible at the code level**:
- Re-renders are silent — code compiles and runs, just slowly
- `useEffect` dependency bugs pass all static checks
- Bundle size issues require understanding webpack/vite internals
- Server vs. Client Component choices affect architecture silently

These issues **pass linting, type checking, and tests** — only specialist rules catch them.

### Why Python/Go/Java/Rust Don't Need Equivalent Skills

Backend performance problems are **transparent**:
- Algorithm choice → O(n²) is obvious in benchmarks
- N+1 queries → visible in query logs
- Memory leaks → profiling tools locate them
- Type errors → compiler/type checker catches them

Standard tooling (`ruff`, `go vet`, `clippy`, `mypy`) already enforces language best practices.
**Project configs** (`pyproject.toml`, `Cargo.toml`, `tsconfig.json`) define project-specific conventions.

### The Three-Layer Model

```
┌─────────────────────────────────────────────────────────┐
│  Layer 1: Universal Patterns (always embedded)           │
│  ─────────────────────────────────────────────────────  │
│  • Layered architecture (API → Service → Repo → Domain) │
│  • Error handling hierarchy                             │
│  • Structured logging                                   │
│  • Test pyramid                                         │
│  • Security patterns (injection, secrets, auth)         │
│  • Algorithm & data structure selection                 │
│  • API design (REST/GraphQL conventions)                │
│  • Concurrency patterns                                 │
│  • Caching strategy                                     │
│  → Lives in: backend-patterns.md + cross-lang-patterns.md│
├─────────────────────────────────────────────────────────┤
│  Layer 2: Framework Specialist (optional external skill) │
│  ─────────────────────────────────────────────────────  │
│  • React/Next.js → vercel-react-best-practices          │
│  • Only when framework has "silent pitfalls"            │
│  → Lives in: external skills, soft-integrated           │
├─────────────────────────────────────────────────────────┤
│  Layer 3: Project-Specific (from project files)         │
│  ─────────────────────────────────────────────────────  │
│  • CLAUDE.md / AGENTS.md                               │
│  • .editorconfig, ruff.toml, .eslintrc                  │
│  • pyproject.toml, Cargo.toml, tsconfig.json            │
│  → Agent reads these automatically — most accurate      │
└─────────────────────────────────────────────────────────┘
```

**Layer 3 beats everything.** Project config is always more accurate than any generic skill.

---

## Integration Matrix

### By Phase

| Phase | Skill | Type | Purpose |
|-------|-------|------|---------|
| Phase 2 | `write-a-prd` | External (soft) | Formal PRD generation |
| Phase 3 | `superdesign` | External (soft) | Frontend: ASCII wireframe + theme |
| Phase 3 | `backend-patterns.md` | Embedded | Backend: architecture design |
| Phase 3 | `cross-lang-patterns.md` | Embedded | API design, concurrency, caching |
| Phase 4 | `frontend-design` | External (soft) | Aesthetic differentiation |
| Phase 4 | `coding-agent` | External (soft) | Delegate large tasks to subagent |
| Phase 4 | `github` | External (soft) | Commit/PR workflow |
| Phase 5 | `ui-ux-pro-max` | External (soft) | UX quality audit (99 rules) |
| Phase 5 | `vercel-react-best-practices` | External (soft) | React/Next.js performance (65 rules) |
| Phase 5 | `webapp-testing` | External (soft) | E2E testing with Playwright |
| Phase 6 | `log-analyzer` | External (soft) | Post-run log analysis |

### By Task Type

| Task Type | Active Layers | Key Skills |
|-----------|--------------|------------|
| Frontend (React/Next.js) | L1 + L2 + L3 | superdesign → frontend-design → ui-ux-pro-max → vercel-react-best-practices |
| Frontend (Vue/Svelte/HTML) | L1 + L3 | superdesign → frontend-design → ui-ux-pro-max |
| Backend (any language) | L1 + L3 | backend-patterns.md + cross-lang-patterns.md |
| Full-stack | L1 + L2 + L3 | All of the above, split by concern |
| API design | L1 + L3 | cross-lang-patterns.md (REST/GraphQL section) |
| Data-heavy backend | L1 + L3 | cross-lang-patterns.md (DB + caching section) |

---

## Graceful Degradation

Every external skill has an embedded fallback. Code Agent Pro **never blocks** on a missing skill.

| Missing Skill | Impact | Fallback |
|--------------|--------|----------|
| `write-a-prd` | PRD less formal | Embedded template in spec-workflow.md |
| `superdesign` | Design less structured | frontend-design-fallback.md (auto-generated) |
| `frontend-design` | Less aesthetic guidance | Built-in anti-AI-slop principles |
| `ui-ux-pro-max` | UX audit less thorough | Built-in accessibility checklist |
| `vercel-react-best-practices` | React gaps | General performance principles in backend-patterns.md |
| `webapp-testing` | No automated E2E | Manual testing guidance |
| `github` | Manual git | Standard git commands |
| `coding-agent` | No subagent delegation | Direct implementation |
| `log-analyzer` | Manual log review | Built-in error handling checklist |

### Degradation Pattern

```
For each phase that uses an external skill:

  1. Check if skill is available (read SKILL.md path)
  2. If available → load and follow it
  3. If missing → use embedded fallback
  4. Inform user: "X not installed, using built-in fallback.
                   Install with: skillhub install X"
  5. Continue without interruption
```

---

## Frontend Integration Detail

### Phase 3: Design Direction

```
superdesign (preferred)          frontend-design-fallback.md (fallback)
─────────────────────────        ──────────────────────────────────────
• ASCII wireframe first          • Basic ASCII wireframe guide
• 3 theme templates              • CSS variable template
• oklch() color system           • Animation timing rules
• Animation micro-syntax         • Anti-AI-slop principles
```

### Phase 4: Implementation

```
frontend-design (preferred)      Built-in principles (fallback)
─────────────────────────        ──────────────────────────────
• Bold aesthetic direction       • Avoid generic AI aesthetics
• Typography differentiation     • Semantic HTML
• Spatial composition            • Responsive breakpoints
• "Unforgettable" element        • Accessibility basics
```

### Phase 5: Quality Audit

```
ui-ux-pro-max                    vercel-react-best-practices
─────────────────────────        ──────────────────────────────────────
• 99 UX guidelines               • 65 React/Next.js rules
• Accessibility (WCAG)           • Waterfall elimination
• Touch targets 44×44pt          • Bundle size optimization
• Performance (CLS, lazy)        • Re-render optimization
• 10 tech stacks                 • Server/client data fetching

webapp-testing (if available)
─────────────────────────────
• E2E test generation
• Playwright automation
• Screenshot comparison
```

---

## Backend Integration Detail

### Phase 3: Architecture Design

**Source**: `references/backend-patterns.md` + `references/cross-lang-patterns.md`

```
backend-patterns.md              cross-lang-patterns.md
─────────────────────────        ──────────────────────────────────────
• Layered architecture           • REST API design conventions
• Language templates             • GraphQL schema patterns
  (Python/Go/Java/Rust/Node)     • Concurrency models
• Error hierarchy                • Caching strategy
• Repository pattern             • DB schema design
                                 • Observability setup
```

### Phase 5: Self-Check

Always run the embedded self-check checklist (no external skill needed):

```
Architecture  → Layered? Dependencies point down?
Errors        → Typed? Context preserved? HTTP codes right?
Tests         → Unit + integration? Edge cases?
Logging       → Structured? Context included? No secrets?
Performance   → N+1? Indexes? Hot path clean?
Security      → Input validated? No injection? No hardcoded secrets?
```

---

## Workflow Integration Detail

### Phase 2: SPEC

```
write-a-prd (preferred)          spec-workflow.md embedded template (fallback)
─────────────────────────        ──────────────────────────────────────────────
• Full PRD structure             • Problem statement
• P0/P1/P2 priorities            • Goals / Non-goals
• Acceptance criteria            • User stories
• Stakeholder sections           • Functional requirements
                                 • Acceptance criteria
```

### Phase 4: Git

```
github skill (preferred)         Manual commands (fallback)
─────────────────────────        ──────────────────────────
gh pr create                     git add .
gh pr checks                     git commit -m "..."
gh run view --log-failed         git push
gh issue list                    git log --oneline
```

### Phase 4: Large Tasks

```
coding-agent (preferred)         Direct implementation (fallback)
─────────────────────────        ──────────────────────────────────
Spawn Codex/Claude Code          Agent implements directly
Parallel subagents               Sequential implementation
Background execution             Foreground only
```

---

## Installation

Run the setup script to check and install missing skills:

```bash
# macOS / Linux
bash scripts/setup.sh

# Windows
.\scripts\setup.ps1
```

Manual install:

```bash
# SPEC
skillhub install write-a-prd

# Frontend
skillhub install superdesign
skillhub install ui-ux-pro-max

# React/Next.js (if applicable)
# vercel-react-best-practices — install from skills.sh

# Testing
skillhub install webapp-testing

# Workflow
skillhub install github
skillhub install coding-agent
skillhub install log-analyzer
```

---

## Design Principles

1. **Self-sufficient** — works fully without any external skill
2. **Transparent** — always tells user what's enhanced vs. fallback
3. **Non-blocking** — missing skill never stops the workflow
4. **Layer-aware** — universal patterns embedded, framework-specific external
5. **Project-first** — project config (Layer 3) always overrides generic rules
6. **Balanced** — frontend and backend get equivalent depth via different mechanisms
