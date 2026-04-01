# Spec-Driven Workflow

**Trigger:** Feature development, complex refactoring, unclear requirements, or any task that needs planning.

---

## Core Flow

```
Phase 1: Clarify → Phase 2: Decompose → Phase 3: Announce → Phase 4: Execute → Phase 5: Quality Gates
```

---

## ⭐ Phase 1: Clarify

### A. Detect Project Type (Mandatory)
Read the project manifest (package.json / pyproject.toml / go.mod / pom.xml) to confirm framework and version.

Announce:
```
📋 Project Context

Framework: [detected result]
Key dependencies: [versions]
I will follow [X] conventions.
```

### B. Confirm Requirements
- **Scope**: What is included and excluded
- **Acceptance criteria**: How do we know it's "done"?
- **UI tasks**: Fill in `references/preflight-check.md` pre-flight checklist

---

## ⭐ Phase 2: Decompose

Break the task into atomic, verifiable units:

```
🔧 Task Breakdown

T1: [description] → Verify: [how to confirm]
T2: [description] → Verify: [how to confirm]
...

Total: N tasks
```

Rules:
- Each task has a clear deliverable and verification method
- Uncertain tasks go last
- For UI tasks, T1 is always "confirm visual expectation"

---

## ⭐ Phase 3: Announce (Core Mechanism)

Announce before every task:

```
▶ T1: [task description]
Plan: [which file to change, how]
Verify: [how to confirm completion]

Does this look right? Please confirm before I start.
```

**Rules:**
- Wait for confirmation before touching any code
- User says "not right" → back to Phase 1 to re-clarify
- User says "good enough" → execute immediately
- User says "skip" → skip this task

---

## ⭐ Phase 4: Execute

Execute as announced, tracking:
- Files changed
- Deliverables produced
- Issues encountered

When hitting unexpected situations:
- If you can work around it, document the workaround and announce the new approach
- If you can't work around it, stop and announce the issue — wait for a decision

---

## ⭐ Phase 5: Quality Gates

Run quality gates after every workflow:

| Gate | Command | Requirement |
|------|---------|-------------|
| Lint | `eslint .` / `ruff check .` / `go vet ./...` | 0 errors |
| Type Check | `tsc --noEmit` / `mypy` | 0 errors |
| Tests | `npm test` / `pytest` | 100% pass |
| Security | Scan for secrets / injection | 0 vulnerabilities |

Fix errors immediately and re-run gates until all pass.

---

## 📖 Related References

- [Pre-flight Check](../references/preflight-check.md) — UI task pre-flight checklist
- [TDD Lightweight](../references/tdd-lightweight.md) — Lightweight TDD with verification points
- [Spec Workflow Reference](../references/spec-workflow.md) — Full spec workflow guide
