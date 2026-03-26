# Code Agent Pro

> Opinionated, production-grade Code Agent skill for [OpenClaw](https://openclaw.ai). Treats specification discipline, code quality, and continuous learning as first-class concerns.

Inspired by the [Claude Code `/feature-dev` plugin](https://github.com/anthropics/claude-code/tree/main/plugins/feature-dev) philosophy: **never code without a spec**.

## Features

### 🏗️ SPEC Workflow (6 Phases)

| Phase | What Happens |
|-------|-------------|
| Phase 1 | **Requirement Clarification** — Eliminate ambiguity before writing |
| Phase 2 | **PRD Generation** — Formal spec via `write-a-prd` skill integration |
| Phase 3 | **Architecture Design** — 3 paths: minimal / clean / pragmatic |
| Phase 4 | **Implementation** — Only after user confirmation |
| Phase 5 | **Quality Gates** — Lint → Type check → Tests → Build → Security |
| Phase 6 | **Self-Reflection** — "Is this the best approach?" |

### 🗺️ `/learn` Command — Project Onboarding

Run `/learn [path]` to quickly understand any project in ~30 minutes:

| Step | Duration | Output |
|------|----------|--------|
| Surface Scan | 3 min | Project type, tech stack, size |
| Entry Point Trace | 5 min | Startup sequence, API surface |
| Core Flow Deep Dive | 10 min | Main workflows traced end-to-end |
| Pattern Extraction | 5 min | Code style, testing, logging conventions |
| Mental Model | 5 min | `memory/project-map.md` cheat sheet |
| Gap Report | 2 min | Targeted questions for unclear areas |

### 🧠 Memory System

- 4-layer architecture: session → working → long-term → codebase
- Context window optimization with prioritization and compression
- Knowledge graph construction for codebase relationships

### 🔧 Backend Support (Python / Java / Go / Rust / Node.js)

- **Layered architecture** templates per language
- **Error handling** hierarchies with typed errors
- **Testing strategy** (unit / integration / E2E)
- **Structured logging** setup per language
- **Agent self-check** checklist

### 🌐 Cross-Language Patterns

- API design (REST / GraphQL)
- Concurrency patterns (Fan-Out, Worker Pool, Circuit Breaker, Pipeline)
- Caching strategy with decision tree
- Database schema design and query optimization
- Observability (logs, metrics, traces)

### 🎨 Frontend Integration

| Phase | Skill | Purpose |
|-------|-------|---------|
| Design | `superdesign` | ASCII wireframes, theme templates, animation planning |
| Implementation | `frontend-design` | Aesthetic differentiation, anti-AI-slop |
| Audit | `ui-ux-pro-max` | 99 UX guidelines, accessibility, performance |
| React | `vercel-react-best-practices` | 65 rules across 8 priority categories |

### 🔒 Quality Assurance

- Static analysis tool matrix (Ruff / ESLint / go vet / Clippy)
- Automatic test generation alongside code
- Security audit (secrets, injection, path traversal, license compliance)
- Complexity control (cyclomatic complexity ≤ 10)

### 📚 Learning Loop

- Failure mode library with root cause analysis
- User preference learning across sessions
- Performance accumulation and estimation
- A/B decision framework for architecture choices

## Architecture

```
code-agent-pro/
├── SKILL.md                              # Main entry point
├── skill.json                            # Metadata
├── scripts/
│   ├── setup.sh                          # Dependency check (macOS / Linux)
│   └── setup.ps1                         # Dependency check (Windows)
└── references/
    ├── spec-workflow.md                  # SPEC 6-phase guide + PRD integration
    ├── project-onboarding.md             # /learn command guide
    ├── backend-patterns.md               # Per-language architecture & code templates
    ├── cross-lang-patterns.md            # API, concurrency, caching, DB, observability
    ├── memory-system.md                  # Context management & window optimization
    ├── quality-assurance.md              # Static analysis, testing, self-inspection
    ├── execution-environment.md          # Build verification, sandbox, rollback
    ├── security-audit.md                 # Threat patterns, compliance, license review
    ├── learning-loop.md                  # Failure modes, preferences, A/B decisions
    ├── skill-integrations.md             # Integration router & degradation strategy
    └── frontend-design-fallback.md       # Fallback when superdesign not installed
```

## Installation

### As an OpenClaw Skill

1. Clone this repo into your skills directory:
```bash
# macOS / Linux
git clone https://github.com/Eve0211/code-agent-pro.git ~/.qclaw/workspace/skills/code-agent-pro

# Windows
git clone https://github.com/Eve0211/code-agent-pro.git %USERPROFILE%\.qclaw\workspace\skills\code-agent-pro
```

2. Run the dependency check:
```bash
bash skills/code-agent-pro/scripts/setup.sh        # macOS / Linux
.\skills\code-agent-pro\scripts\setup.ps1           # Windows
```

### Optional: Install Integration Skills

The skill works fully without any external dependencies. Install these for enhanced capabilities:

```bash
# SPEC generation
skillhub install write-a-prd

# Frontend design
skillhub install superdesign
skillhub install ui-ux-pro-max

# Git workflow
skillhub install github

# Testing
skillhub install webapp-testing
```

## Usage

### Quick Start

Just start describing what you want to build. The SPEC workflow activates automatically for non-trivial tasks:

```
You: "Add user authentication with OAuth to this FastAPI project"

Agent:
  Phase 1 → Asks clarifying questions (scope, constraints, providers)
  Phase 2 → Generates PRD with write-a-prd skill
  Phase 3 → Presents 3 architecture paths with trade-offs
  You:    → Choose "Pragmatic Balance" approach
  Phase 4 → Implements with tests alongside code
  Phase 5 → Runs lint, type check, tests, build, security scan
  Phase 6 → Self-reflects and presents results
```

### Project Onboarding

```
You: "/learn ./my-project"

Agent: Scans the project in 30 minutes, generates memory/project-map.md,
       and is ready to work with full understanding of the codebase.
```

### Skip SPEC for Small Tasks

The skill automatically skips the full SPEC workflow for:
- Single-line bug fixes
- Trivial refactors
- Well-understood, small tasks
- Emergency hotfixes (document after the fact)

Quality gates and security checks always run regardless of task size.

## Design Philosophy

### Three-Layer Capability Model

```
Layer 1: Universal Patterns (always embedded, zero dependencies)
  → Architecture, error handling, testing, security, performance

Layer 2: Framework Specialist (optional external skills)
  → React/Next.js performance rules (silent pitfalls only)

Layer 3: Project-Specific (from project files)
  → CLAUDE.md, .editorconfig, ruff.toml, tsconfig.json
  → Always the most accurate source of truth
```

### Graceful Degradation

Every external skill has an embedded fallback. Missing skills never block the workflow — they only reduce capability depth. The setup script reports exactly what's enhanced vs. fallback.

### Why React Gets Special Treatment

React's performance problems (silent re-renders, useEffect dependency bugs, bundle bloat) pass all static checks — only specialist rules catch them. Backend languages don't have equivalent "invisible" pitfalls; their issues are caught by standard tooling.

## License

MIT
