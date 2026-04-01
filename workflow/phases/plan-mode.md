# Plan Mode Phase

> Phase 4: Read-Only Exploration & Implementation Planning

## Purpose

Read-only codebase exploration, create detailed implementation plan.

## Input

- PRD document

## Output

- Implementation plan

---

## Core Principles

### Read-Only Exploration

> ⚠️ **HARD GATE**: Plan Mode is **READ-ONLY**. Never modify any code during Plan Mode!

**Allowed**:
- Read files
- Analyze code structure
- Understand dependencies
- Create plan

**Not Allowed**:
- Modify code
- Create files
- Delete files
- Run operations that modify files

---

## Execution Steps

### Step 1: Understand PRD

- Read requirements document
- Understand feature goals
- Identify key requirements

---

### Step 2: Explore Codebase

**Explore**:

| Dimension | Purpose |
|-----------|---------|
| Directory structure | Understand project organization |
| Entry files | Find extension points |
| Core modules | Understand business logic |
| Dependencies | Identify impact scope |
| Testing situation | Assess test coverage |

---

### Step 3: Define File Structure

- Which files need creation?
- Which files need modification?
- Which files need reference?

---

### Step 4: Create Task Plan

- List tasks in order
- Each task specifies files
- Each task has verification method

---

## Output Format

```markdown
## Implementation Plan

**Project**: [project name]
**PRD**: [PRD file link]
**Plan Date**: [date]

### File Structure

#### Files to Create
| File | Purpose |
|------|--------|
| src/user/user.service.ts | User service |
| src/user/user.test.ts | User tests |

#### Files to Modify
| File | Changes |
|------|---------|
| src/app.ts | Add routes |

#### Files to Reference
| File | Reference Content |
|------|-------------------|
| src/auth/auth.service.ts | Similar implementation pattern |

### Task Breakdown

#### Task 1: Create UserService
**Estimated Time**: 10 minutes

- [ ] Write test
- [ ] Run test (fail)
- [ ] Write implementation
- [ ] Run test (pass)
- [ ] Commit

#### Task 2: Add user routes
...

### Dependencies

```
Task 1 (UserService)
    ↓
Task 2 (UserRoutes)
    ↓
Task 3 (Integration tests)
```

### Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Dependency conflict | Low | High | Check versions |
| Performance issues | Medium | Medium | Benchmark |

### Acceptance Checklist

- [ ] All tasks completed
- [ ] Tests pass
- [ ] Code reviewed
- [ ] Documentation updated
```

---

## Deliverables

- **Location**: `./docs/PLAN-YYYY-MM-DD.md`

---

## Notes

1. **Read-only principle** - Never modify code
2. **Full exploration** - Don't miss key files
3. **Detailed plan** - Tasks must be specific and actionable
4. **Risk assessment** - Identify problems early
