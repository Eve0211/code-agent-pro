# Greenfield Workflow

> Build from scratch with full SPEC workflow

## Trigger Conditions

- No existing project - User wants to build from scratch
- New project request - "Help me build a xxx", "I want to develop a xxx"
- Fresh idea - User has a new idea that needs implementation

## Workflow Overview

```
clarify → brainstorming → prd-generation → plan-mode → architecture-design → task-decomposition → implementation → quality-gates → testing → review → self-reflection
```

**11 phases**, the most complete development process.

---

## Phase Summary

| Phase | Name | Purpose |
|-------|------|---------|
| 1 | Clarify | Understand requirements |
| 2 | Brainstorming | Explore solutions |
| 3 | PRD Generation | Write specifications |
| 4 | Plan Mode | Read-only exploration |
| 5 | Architecture Design | Design system |
| 6 | Task Decomposition | Break into tasks |
| 7 | Implementation | Write code |
| 8 | Quality Gates | Quality checks |
| 9 | Testing | Comprehensive tests |
| 10 | Review | Code review |
| 11 | Self-Reflection | Learn & improve |

---

## Key Decisions

### Phase 1: Clarify (Requirement Clarification)

**Purpose**: Understand what user really wants

**Key Questions**:
- What do you want to build?
- Who are target users?
- What are core features?
- What are success criteria?
- Any time/budget constraints?

**Deliverable**: `./docs/SPEC-YYYY-MM-DD.md`

---

### Phase 2: Brainstorming (Creative Exploration)

**Purpose**: Explore multiple solutions

**6 Steps**:
1. Research existing solutions
2. Generate 3 solution concepts
3. Explore tech stacks
4. Brainstorm creative ideas
5. Identify edge cases
6. Extract key insights

**Deliverable**: Solution comparison

---

### Phase 3: PRD Generation

**Purpose**: Transform ideas into detailed specifications

**Content**:
- Product overview
- Problem statement
- Goals & non-goals
- User stories
- Feature requirements (P0/P1/P2)
- Non-functional requirements
- Acceptance criteria

**Deliverable**: `./docs/PRD-YYYY-MM-DD.md`

---

### Phase 4: Plan Mode

> ⚠️ **READ-ONLY** - Never modify code in this phase

**Purpose**: Explore codebase and create implementation plan

**Activities**:
- Read files
- Analyze structure
- Understand dependencies
- Define file structure
- Create task list

**Deliverable**: `./docs/PLAN-YYYY-MM-DD.md`

---

### Phase 5: Architecture Design

**Purpose**: Design system architecture

**3 Paths**:
1. **Minimal** - Smallest change, max reuse
2. **Clean** - Proper abstraction, testable, maintainable
3. **Pragmatic** - Balanced speed and quality

**Deliverable**: `./docs/ARCH-YYYY-MM-DD.md`

---

### Phase 6: Task Decomposition

**Purpose**: Break into 2-5 minute tasks

**Format**:
```markdown
### Task 1: [Task Name]

**Files**:
- Create: `src/file.ts`
- Test: `tests/file.test.ts`

**Steps**:
- [ ] Write test
- [ ] Run test (fail)
- [ ] Write implementation
- [ ] Run test (pass)
- [ ] Commit
```

---

### Phase 7: Implementation

**TDD Flow**:
1. Write test (Red)
2. Run test (Fail)
3. Write implementation (Green)
4. Run test (Pass)
5. Refactor
6. Commit

---

### Phase 8: Quality Gates

**Checklist**:
- [ ] Lint: 0 errors
- [ ] Type check: 0 errors
- [ ] Tests: 100% pass
- [ ] Coverage: ≥ 80%
- [ ] Security: 0 vulnerabilities

---

### Phase 9: Testing

**Test Types**:
- Unit tests (majority)
- Integration tests (some)
- E2E tests (few)

---

### Phase 10: Review

**Dimensions**:
- Code quality (1-10)
- Architecture (1-10)
- UX (1-10)
- Security (1-10)

**Pass**: Score ≥ 7, no High issues

---

### Phase 11: Self-Reflection

**Questions**:
- What went well?
- What could be improved?
- What did we learn?

**Deliverable**: `./docs/LEARN-YYYY-MM-DD.md`

---

## Documentation Output

| Phase | Document | Location |
|-------|----------|----------|
| Clarify | SPEC | `./docs/SPEC-YYYY-MM-DD.md` |
| PRD | PRD | `./docs/PRD-YYYY-MM-DD.md` |
| Plan | PLAN | `./docs/PLAN-YYYY-MM-DD.md` |
| Architecture | ARCH | `./docs/ARCH-YYYY-MM-DD.md` |
| Reflection | LEARN | `./docs/LEARN-YYYY-MM-DD.md` |
