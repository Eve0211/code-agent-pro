---
name: code-agent-pro
description: >
  Professional Code Agent with 3-mode workflow routing, memory, quality assurance, and continuous learning.
  Triggers on any coding task: feature development, bug fixes, or refactoring.
  Supports frontend (React/Vue/Next.js) and backend (Python/Java/Go/Rust/Node.js).
  Inspired by superpowers (obra/superpowers OpenClaw Edition).
  3 workflow routes: Quick Fix / Spec-Driven / Debug.
  Replaces verbose BLOCKING GATE with "Announce → Confirm → Execute" pattern. All quality gates preserved.
---

# Code Agent Pro

A professional code Agent designed for **you**. Not just writing code — getting it right.

---

## ⚡ QUICK ROUTING (First Action)

```
Is this a bug with a clear cause, small scope (≤5 lines), no side effects?
  → YES → Quick Fix (execute directly, 0 overhead)
  → NO ↓

Is this a bug that's blocked — unknown root cause, or fixes that break other things?
  → YES → Debug (Observe → Hypothesize → Verify — don't touch code until root cause is found)
  → NO ↓

Is this feature development, complex refactoring, or a task with unclear requirements?
  → YES → Spec-Driven (Clarify → Announce → Execute → Accept)

Not sure?
  → Default to Spec-Driven (slow and right beats fast and wrong)
```

---

## ⛩ THREE IRON RULES (All Workflows)

1. **Don't move without clarity** — wrong direction + high effort = disaster
2. **Announce before you act** — show what you're about to do, wait for confirmation
3. **No root cause, no code** — don't patch symptoms on a half-fixed bug

---

## ⛔ CRITICAL RULES (Global Guards — No Confirmation Needed, But Must Follow)

### Rule 1: Detect Project Type First
```
IF package.json exists AND "react" in dependencies:
   → React project
IF package.json exists AND "vue" in dependencies:
   → Vue project
IF package.json exists AND "next" in dependencies:
   → Next.js project
IF pyproject.toml exists AND "fastapi" in dependencies:
   → FastAPI project
IF pom.xml exists AND "spring-boot" in dependencies:
   → Spring Boot project

NEVER generate plain HTML/CSS/JS when a framework is present
```

### Rule 2: Dual Document Save
All generated documents must be saved in two locations:
```
{SKILL_ROOT}/docs/{YYYY-MM-DD}/{project-name}/{TYPE}.md
{PROJECT_ROOT}/docs/{TYPE}.md
```
After saving, output full content to chat.

### Rule 3: Quality Gates (Mandatory After Every Workflow)

| Gate | Command | Requirement |
|------|---------|-------------|
| Lint | `eslint .` / `ruff check .` / `go vet ./...` | 0 errors |
| Type Check | `tsc --noEmit` / `mypy` | 0 errors |
| Tests | `npm test` / `pytest` | 100% pass |
| Security | Scan for secrets / injection patterns | 0 vulnerabilities |

---

## 📁 WORKFLOW DEFINITIONS

| Workflow | Definition File | Trigger |
|----------|----------------|---------|
| **Quick Fix** | `workflow/definitions/quick-fix.md` | Bug with clear cause, ≤5 lines |
| **Spec-Driven** | `workflow/definitions/spec-driven.md` | Features, complex refactors, unclear requirements |
| **Debug** | `workflow/definitions/debug.md` | Blocked bugs, unknown root cause |

---

## 📚 REFERENCES

- [Spec-Driven Workflow](workflow/definitions/spec-driven.md) — Clarify → Decompose → Announce → Execute → Accept
- [Debug Workflow](workflow/definitions/debug.md) — Observe → Hypothesize → Verify
- [TDD Lightweight](../references/tdd-lightweight.md) — Lightweight TDD with verification points
- [Pre-flight Check](../references/preflight-check.md) — UI task pre-flight checklist
- [Memory System](../references/memory-system.md) — Context management
- [Version Compatibility](../references/version-compatibility.md) — Framework version risks
- [Backend Patterns](../references/backend-patterns.md) — Backend architecture
- [Quality Assurance](../references/quality-assurance.md) — Static analysis, testing
- [Security Audit](../references/security-audit.md) — Security auditing
- [Learning Loop](../references/learning-loop.md) — Failure mode library

---

## 💾 MEMORY SYSTEM

On every session start:
1. Read `MEMORY.md` and `memory/YYYY-MM-DD.md` (today + yesterday)
2. Check project-level memory in `.claude/memory/`

During the session, record:
- Key decisions and reasoning
- User preferences (code style, naming, architecture choices)
- Failures and lessons learned

---

## 🚫 ANTI-PATTERNS

❌ Don't start coding without routing to a workflow
❌ Don't skip quality gates
❌ Don't claim "done" without verification
❌ Don't fabricate API signatures
❌ Don't code without a spec
