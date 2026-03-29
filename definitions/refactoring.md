# Refactoring Workflow

> Careful path for refactoring existing code

## Trigger Conditions

- Refactoring keywords: "refactor", "optimize code", "improve structure"
- Code quality issues: "code is messy", "hard to maintain"
- Performance optimization: "optimize performance"
- Structure adjustment: "reorganize", "clean up code"

## Workflow Overview

```
clarify → codebase-analysis → architecture-design → task-decomposition → implementation → quality-gates → self-reflection
```

**7 phases**

---

## Phase Details

### Phase 1: Clarify

Define refactoring scope and objectives.

**Questions**:
- Why refactor? (Pain points)
- Scope? (Module/file/function)
- Expected results? (Performance/maintainability)
- Is there test coverage?
- Time constraints?

---

### Phase 2: Codebase Analysis

Deep understanding of existing code.

**Analysis Dimensions**:
- Dependencies - What depends on this?
- Call chains - Entry points, flows
- Test coverage - Existing tests
- Risk points - Potential problems

---

### Phase 3: Architecture Design

Design post-refactoring architecture.

**Content**:
- New architecture diagram
- Change scope
- Migration steps
- Risk assessment

**Principles**:
- Incremental refactoring
- Maintain compatibility
- Rollback capability

---

### Phase 4: Task Decomposition

Break into small steps.

**Principles**:
- Each step independently testable
- Each step independently rollbackable
- Frequent commits
- Easy first, hard later

---

### Phase 5: Implementation

Execute refactoring.

**Flow**:
1. Ensure tests pass
2. Small step changes
3. Run tests after each step
4. Confirm no regression
5. Commit

---

### Phase 6: Quality Gates

Verify refactoring quality.

**Checklist**:
- [ ] All tests pass
- [ ] No functional regression
- [ ] Performance not degraded
- [ ] Code is clearer
- [ ] Documentation updated

---

### Phase 7: Self-Reflection

Summarize experience.

---

## Refactoring Principles

1. **Small steps** - Change a little at a time
2. **Test coverage** - Don't refactor without tests
3. **Frequent commits** - Can rollback anytime
4. **Maintain compatibility** - Don't break external interfaces
5. **Sync documentation** - Update docs when updating code

---

## Risk Control

| Risk | Mitigation |
|------|------------|
| Breaking functionality | Ensure test coverage |
| Scope creep | Strictly follow plan |
| Introducing new bugs | Verify tests at each step |
| Performance degradation | Benchmark comparison |
