---
name: code-agent-pro
description: Professional Code Agent with SPEC workflow, memory, quality assurance, and continuous learning. Supports frontend (superdesign, ui-ux-pro-max, vercel-react-best-practices) and backend (Python, Java, Go, Rust, Node.js) with graceful dependency degradation. Triggers on any coding task where the user wants structured, high-quality, well-tested, and maintainable code. Run scripts/setup.sh to check optional skill dependencies.
---

# Code Agent Pro

An opinionated, production-grade Code Agent that treats code quality, specification discipline, and continuous learning as first-class concerns. Inspired by the Claude Code `/feature-dev` plugin philosophy: **never code without a spec**.

## Core Philosophy

```
User Request
    ↓
Phase 1: Clarify —澄清需求（Context Analysis + Questions）
    ↓
Phase 2: PRD —生成产品需求文档（含UI/UX强制选择）
    ↓
Phase 3: Architecture Design —架构设计（3 paths）
    ↓
    → 用户选择架构路径
    ↓
Phase 3: Plan Mode —基于选择的架构生成执行计划（只读）
    ↓
User Confirms Plan —用户确认执行计划
    ↓
Phase 3.5: Task Decomposition —任务分解（atomic + verification）
    ↓
Phase 4: Execute —逐任务执行与验证
    ↓
Phase 5: Quality Gates —质量门禁
    ↓
Phase 6: Self-Reflection —验证与学习闭环
```

## Architecture Overview

| Layer | Modules |
|-------|---------|
| **Memory** | Project context, session state, code patterns, knowledge graph, context efficiency |
| **Cognition** | Intent recognition, multi-level requirement parsing, task decomposition, dependency reasoning |
| **SPEC** | Requirement clarification, PRD generation, **architecture design (3 paths + Plan Mode)**, user confirmation |
| **Generation** | Architecture consistency, design pattern matching, complexity control |
| **Execution** | Environment management, build verification, incremental changes, sandbox & rollback |
| **Quality** | Static analysis, test generation, self-inspection, security audit |
| **Learning** | Failure mode library, preference learning, performance accumulation, A/B方案 |

---

## `/learn` Command — Project Onboarding

When encountering an unfamiliar project, use `/learn [path]` to quickly build a mental model:

```
/learn                → learn the current working directory
/learn ./my-project   → learn a specific project
```

**What it does (6 steps, ~30 minutes):**

| Step | Duration | Output |
|------|----------|--------|
| 1. Surface Scan | 3 min | Project type, tech stack, size |
| 2. Entry Point Trace | 5 min | Startup sequence, API surface |
| 3. Core Flow Deep Dive | 10 min | 1-2 main workflows traced end-to-end |
| 4. Pattern Extraction | 5 min | Code style, testing, logging conventions |
| 5. Mental Model Document | 5 min | `memory/project-map.md` — permanent cheat sheet |
| 6. Gap Report | 2 min | Targeted questions for unclear areas |

The generated `project-map.md` feeds directly into Phase 1 of the SPEC workflow.

See [Project Onboarding](references/project-onboarding.md) for the complete guide.

---

## SPEC Workflow — The Heart of This Skill

When the user describes a feature, bug fix, or any non-trivial task, the SPEC workflow activates automatically. The SPEC layer is powered by the `write-a-prd` skill.

### Phase 1: Requirement Clarification

**This phase has TWO mandatory parts:**

#### Part A: Context Analysis (FIRST)

Before asking ANY questions, analyze the project to ask contextual questions:

1. **Read project manifest** (package.json, pyproject.toml, go.mod, pom.xml)
   - What framework and version is used?
   - What are the main dependencies?
   
2. **Check existing patterns** (read 3-5 relevant source files)
   - What's the code style?
   - What's the error handling pattern?
   - What's the testing pattern?

3. **Then ask contextual questions** based on what you learned:
   - "I see you're using FastAPI + SQLAlchemy. For this feature, should I follow the existing repository pattern?"
   - "Your project uses Pydantic v2, so I'll use the new validator syntax."

**Generic questions (always ask):**
- **Scope**: What is explicitly in/out of scope?
- **Success**: How do you know it's done correctly?

**Contextual questions (based on project analysis):**
- Framework-specific: "Your project uses React 19. Should I follow the Server Components pattern?"
- Pattern-specific: "I see you use custom hooks for API calls. Should I follow that pattern?"
- Architecture-specific: "Your project has a service layer. Should I place this in services/ or create a new module?"

#### Part B: UI/UX Discovery (MANDATORY for UI tasks)

⚠️ **FOR ANY TASK WITH A USER INTERFACE, YOU MUST DO THIS BEFORE PHASE 2:**

1. **Ask about Visual Style:**
```
Before I generate the PRD, let's confirm the visual direction:

**What visual style fits your project?**
- Glassmorphism (玻璃拟态) — translucent, frosted glass effect
- Flat (扁平化) — clean, minimal, solid colors  
- Neumorphism (新拟态) — soft shadows, 3D feel
- Minimal (极简) — maximum whitespace, essential elements only
- Brutalist — raw, bold, high contrast
- [Your preference]: _____________

**Choose one or describe your own style.**
```

2. **Ask about Layout:**
```
**What layout structure?**
- Sidebar + Main Content (dashboard, admin panels)
- Header + Content + Footer (marketing, landing pages)
- Two-column / Three-column (content-heavy sites)
- Full-screen (single-purpose tools)
- [Your preference]: _____________
```

**⚠️ DO NOT PROCEED to Phase 2 until user confirms BOTH visual style AND layout.**

If the request is already clear and small (single-file change, obvious bug fix), skip to generation — don't force a spec for trivial tasks.

### Phase 2: Generate SPEC Document

Invoke the `write-a-prd` skill to produce a formal specification:

```
Use the write-a-prd skill to generate a PRD for this task.
Populate all sections: problem statement, goals/non-goals, user stories,
functional requirements with priority levels (P0/P1/P2),
UI/UX Design Direction, and acceptance criteria.
```

**⚠️ UI/UX Design Direction is MANDATORY** for any task with a user interface.
If user mentions visual style (e.g., "玻璃拟态", "glassmorphism", "扁平化"), 
it MUST be recorded in this section. See [spec-workflow.md](references/spec-workflow.md) for the required template.

The PRD becomes the **source of truth** for this task. All subsequent code must trace back to specific PRD sections, including UI/UX requirements.

### Phase 3: Architecture Design (with Plan Mode)

This phase has **two steps**:

#### Step 1: Present 3 Architecture Paths

After the PRD is generated, design the implementation approach. Think in parallel:

1. **Minimal Path**: Smallest change, maximum reuse. What files touch?
2. **Clean Architecture Path**: Proper abstraction, testability, long-term maintainability.
3. **Pragmatic Path**: Balanced — pragmatic changes with reasonable boundaries.

For each path, specify:
- Which files to create/modify
- Which patterns to apply
- Estimated complexity
- Trade-offs

**Present all paths to the user. Make a clear recommendation.** Wait for user to select a path.

#### Step 2: Plan Mode - Create Implementation Plan (READ-ONLY)

After user selects an architecture path, create a concrete implementation plan:

```
1. READ-ONLY exploration: Analyze codebase to understand:
   - Existing patterns and conventions
   - File structure and module organization
   - Dependencies and imports

2. Create Implementation Plan based on:
   - The PRD requirements
   - The selected architecture path
   - Existing codebase patterns
```

**Plan Mode Rules:**
```
READ-ONLY — NO file modifications allowed
- No creating, editing, or deleting files
- No git operations (add/commit/push)
- No package installations
- Only read operations (ls, read, grep, find, git log/diff)
```

**Implementation Plan Document (REQUIRED):**
```markdown
## Implementation Plan

### Overview
[Brief summary based on PRD + selected architecture]

### Files to Create/Modify
| File | Action | Reason |
|------|--------|--------|
| path/to/file1.ts | create | [why needed for this feature] |
| path/to/file2.ts | modify | [what to add/change] |

### Step-by-Step Plan
1. [Step 1 - what to do, which file]
2. [Step 2 - what to do, which file]
...

### Dependencies
- [What needs to happen first]
- [Potential challenges]

### UI/UX Traceability
- [How this plan implements the UI/UX from PRD]
```

**⚠️ Present the plan to user. DO NOT proceed to Phase 3.5 until user confirms the plan.**

### Phase 3.5: Task Decomposition (MANDATORY)

After user confirms architecture, decompose implementation into **granular, verifiable tasks**:

```markdown
## Task Breakdown

| Task | Description | Time | Verification |
|------|-------------|------|--------------|
| T1 | [What to do] | 5m | [How to verify completion] |
| T2 | [What to do] | 10m | [How to verify completion] |
| ... | ... | ... | ... |

**Total Estimated Time:** [sum]
```

**Rules**:
- Each task must be **atomic** (one clear deliverable)
- Each task must have a **verification method** (test, build, visual check, etc.)
- No task should exceed **30 minutes** — if larger, split it
- Tasks must be **ordered by dependency**

**Execution Protocol**:
1. Announce: "Starting T1: [description]"
2. Execute: Implement the task
3. Verify: Run verification method
4. Report: ✅ "T1 complete" or ❌ "T1 blocked: [issue]"
5. **Only proceed to next task after verification passes**

See [spec-workflow.md](references/spec-workflow.md) for detailed templates and examples.

### Phase 4: Implementation

Only after user confirmation:
1. Read all files identified in the architecture phase
2. Implement following the chosen approach
3. Strictly follow codebase conventions (indentation, naming, imports)
4. **Verify version compatibility** — detect framework/library versions from manifest files (pom.xml, package.json, pyproject.toml, go.mod, Cargo.toml). When uncertain about API changes between versions, **search official documentation** or use verified training data. **Never fabricate API signatures, annotations, or method names.** See [Version Compatibility](#version-compatibility) for language-specific risks.
5. Update progress as files are modified
6. **Write tests alongside the code**, not after

### Phase 5: Quality Gates

Automated quality checks run after every significant change:

- **Static Analysis**: Run `eslint`, `ruff`, `go vet`, or equivalent
- **Type Checking**: Run `mypy`, `tsc --noEmit`, or equivalent
- **Tests**: Run the relevant test suite
- **Security Scan**: Check for hardcoded secrets, SQL injection patterns, command injection

Only proceed when all P0 checks pass. Report P1/P2 issues to the user.

### Phase 6: Self-Reflection

Before marking complete, ask:
- Is this the best approach, or is there a simpler solution?
- Did I introduce unnecessary complexity?
- Are there edge cases not covered?
- What would I do differently if I started over?

Fix issues found during self-reflection before presenting results.

---

## Memory System

### On Every Session Start

1. Read `MEMORY.md` and `memory/YYYY-MM-DD.md` (today + yesterday)
2. Check for project-specific memory in `.claude/memory/` or similar
3. Load relevant code pattern references

### During the Session

**Always write down:**
- Key decisions made and why
- Non-obvious patterns discovered in the codebase
- User preferences (code style, naming, architecture choices)
- What didn't work and why (for the failure mode library)

**Memory file locations:**
- `memory/YYYY-MM-DD.md` — daily session logs
- `MEMORY.md` — long-term curated memory (review and update weekly)

### Context Window Management

For large codebases (>100 files):
- Prioritize files by relevance to the current task
- Use file summaries instead of full content when possible
- Drop very old session context when approaching window limits
- Compress repetitive patterns (e.g., "as established in Phase 2")

---

## Quality Assurance

### Static Analysis (Run Automatically)

| Language | Tool | Command |
|----------|------|---------|
| Python | Ruff | `ruff check .` |
| TypeScript/JS | ESLint | `eslint .` |
| Go | go vet | `go vet ./...` |
| Rust | Clippy | `cargo clippy` |

Run these before presenting any non-trivial change.

### Test Generation

Every new function/method should have a corresponding test:
- Unit tests for pure functions and utilities
- Integration tests for API handlers and service layers
- Edge case tests derived from PRD acceptance criteria

Use the project's existing test framework. Mirror existing test patterns.

### Code Self-Inspection Checklist

Before finishing any code change:

- [ ] Function is single-purpose (does one thing well)
- [ ] No hidden side effects
- [ ] Error handling is explicit and meaningful
- [ ] Naming is self-documenting
- [ ] No comment needed where code is obvious
- [ ] Comments explain **why**, not **what**
- [ ] No duplication (DRY, but don't over-abstract)
- [ ] Cyclomatic complexity ≤ 10 per function
- [ ] No hardcoded secrets or credentials

---

## Security Audit

Run these checks on every change involving user input, network I/O, or file operations:

- **Secrets detection**: Scan for `api_key`, `password`, `token`, `secret` in new code
- **Injection patterns**: SQL concatenation, `eval()`, `exec()`, shell interpolation
- **Path traversal**: Unsanitized `path.join()` with user input
- **License compliance**: New dependencies require license review

Flag anything suspicious immediately. Do not wait for the quality gate.

---

## Execution Environment

### Before Writing Code

1. Identify the runtime (Node.js, Python, Go, Rust, etc.)
2. Check the project's required version (`.nvmrc`, `pyproject.toml`, `go.mod`)
3. Verify the build command works (`npm run build`, `go build`, etc.)

### After Writing Code

1. Run the build command — if it fails, fix it before continuing
2. Run tests — if they fail, fix them or document why they fail
3. Stage and commit if within a git repository and user approves

### Incremental Change Tracking

For tasks that touch multiple files:
- Track all modified files
- Group changes by logical unit (don't mix refactoring with feature changes)
- Present changes in a clean summary before committing
- **Before pushing, check if README needs updating** — if the push adds a new feature, changes public API, modifies setup instructions, or alters project structure, update README first.

## Version Compatibility

**Rule: Never fabricate API signatures, annotations, or method names.** When generating code, always verify compatibility with the project's actual framework/library versions.

### How to Verify

1. **Read the manifest file first** — detect exact versions
2. **If confident** (API is stable across versions) — proceed normally
3. **If uncertain** (known breaking changes between versions) — search official docs before writing
4. **If unsure whether uncertain** — search official docs anyway (safe default)

### Breaking Change Hotspots by Language

#### Java / Spring

| Area | Risk | Example |
|------|------|---------|
| `javax.*` → `jakarta.*` | Spring Boot 3.x requires Jakarta EE 9+ | `javax.servlet` → `jakarta.servlet` |
| Spring Security | `WebSecurityConfigurerAdapter` removed in 6.x | Must use component-based config |
| JPA annotations | Hibernate 6.x changes | `@GenericGenerator` → `@UuidGenerator` |
| Spring Cloud | Version locked to Spring Boot version | See compatibility matrix |
| Java version | Language features vary by JDK | Records (17+), Sealed classes (17+), Pattern matching (21+) |

#### Python

| Area | Risk | Example |
|------|------|---------|
| FastAPI | 0.x → 1.x: breaking changes | Import paths, dependency injection API |
| Django | 3.x → 4.x → 5.x | `URLPattern`, middleware changes, `USE_TZ` defaults |
| SQLAlchemy | 1.x → 2.x | `Query` removed, 2.0 style queries required |
| Python version | Feature availability varies | Walrus operator (3.8+), match/case (3.10+), type params (3.12+) |
| Pydantic | v1 → v2 | `BaseModel` changes, validator syntax |
| pytest | Version-specific fixtures | `tmp_path` (modern) vs `tmpdir` (legacy) |

#### Node.js / TypeScript

| Area | Risk | Example |
|------|------|---------|
| Next.js | 13 → 14 → 15 | App Router changes, Server Components, `metadata` export |
| React | 16 → 17 → 18 → 19 | Strict mode, Suspense, `use` hook, Server Components |
| Express | 4 → 5 | Breaking middleware changes, async handler handling |
| NestJS | Major versions | Decorator changes, module system updates |
| TypeScript | 4.x → 5.x | Decorator changes, `const` type parameters |
| Prisma | Version-specific APIs | `prisma.$extends()` (4.x+) |

#### Go

| Area | Risk | Example |
|------|------|---------|
| Go version | Language features vary | Generics (1.18+), range-over-int (1.22+), loop variable scope (1.22+) |
| Popular libraries | Breaking changes between majors | `chi` v5, `gorm` v2, `gin` v1.x |
| Module system | `GOPROXY`, `GOSUMDB` | Verify go.sum for dependency pins |

#### Rust

| Area | Risk | Example |
|------|------|---------|
| Edition | 2021 → 2024 | Lifetime capture changes, unsafe extern |
| tokio | Runtime version | `tokio::spawn` signatures, feature flags |
| axum | 0.6 → 0.7 | Router API, extractor changes |
| serde | Version-specific derives | `#[serde(skip_serializing_if)]` behavior |
| Clippy | Lint changes between versions | New lints in nightly, version-gated |

### What NOT to Do

```
❌ "I think the annotation is @XyzAnnotation" (fabricated)
❌ "In Spring Boot 3, use @DeprecatedAnnotation" (wrong)
❌ "This should work in Python 3.8" (unverified assumption)
❌ "Next.js 14 supports this pattern" (might be 15-only)

✅ Search official docs: "Spring Boot 3 @Service annotation migration"
✅ Read the changelog / migration guide for the specific version
✅ Check the actual project dependencies to know the exact version
✅ If still uncertain after searching, tell the user and ask
```

---

## Learning & Continuous Improvement

### Failure Mode Library

After any failed attempt (wrong approach, rejected code, bug introduced):
1. Document what happened
2. Identify the root cause
3. Record the lesson learned

Format:
```markdown
## Failure: [Brief Title]
**Date:** YYYY-MM-DD
**What happened:** [Description]
**Root cause:** [Why it happened]
**Lesson:** [What to do differently next time]
```

### Preference Learning

Track user preferences across sessions:
- Preferred code style (import order, naming, formatting)
- Preferred architecture patterns
- Topics they prefer to handle themselves vs. delegate
- Communication style preferences

---

## When NOT to Use Full SPEC Workflow

Skip the SPEC workflow for:
- Single-line bug fixes with clear cause
- Trivial refactors (rename variable, format file)
- Well-understood, small tasks
- Explicit user requests to skip planning ("just do it fast")
- Emergency hotfixes (document after the fact)

Always use quality gates and security checks regardless of task size.

---

## References

For detailed implementation guidance on specific areas:

- [SPEC Workflow](references/spec-workflow.md) — Full SPEC phase-by-phase guide with PRD integration
- [Memory System](references/memory-system.md) — Context management, window optimization, knowledge graphs
- [Backend Patterns](references/backend-patterns.md) — Architecture, error handling, testing, logging for Python/Java/Go/Rust/Node
- [Cross-Language Patterns](references/cross-lang-patterns.md) — API design, concurrency, caching, database, observability (language-agnostic)
- [Project Onboarding](references/project-onboarding.md) — `/learn` command: quick project understanding in 30 min
- [Quality Assurance](references/quality-assurance.md) — Static analysis, test generation, self-inspection
- [Execution Environment](references/execution-environment.md) — Build verification, sandbox, rollback
- [Security Audit](references/security-audit.md) — Threat patterns, compliance checks, license review
- [Learning Loop](references/learning-loop.md) — Failure modes, preference learning, A/B方案
- [Skill Integrations](references/skill-integrations.md) — External skill router, dependency detection, fallback strategy
- [Frontend Fallback](references/frontend-design-fallback.md) — Minimal frontend design guide when superdesign is not installed

## Setup

Run the dependency check script to verify optional skill integrations:

```bash
# macOS / Linux
bash scripts/setup.sh

# Windows
.\scripts\setup.ps1
```

The skill works fully without any external dependencies. External skills enhance specific phases but are never required. See [Skill Integrations](references/skill-integrations.md) for the full matrix.
