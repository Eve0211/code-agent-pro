# Bug Fix Workflow

> Fast path for fixing specific bugs

## Trigger Conditions

- Bug keywords: "bug", "error", "crash", "not working", "broken"
- Problem location provided
- Error information with logs/screenshots
- Short request pointing to specific problem

## Workflow Overview

```
clarify → codebase-analysis → implementation → quality-gates → self-reflection
```

**5 phases**

---

## Phase Details

### Phase 1: Clarify

Understand bug manifestation.

**Questions**:
- Expected behavior?
- Actual behavior?
- How to reproduce?
- Error message/log?
- When did it start?

---

### Phase 2: Codebase Analysis

Locate problematic code.

**Steps**:
1. Search related code
2. Analyze call chain
3. Identify root cause
4. Assess impact scope

> ⚠️ Do not modify code, only analyze

---

### Phase 3: Implementation

Fix the bug.

**Principles**:
- **Minimal change** - Only change necessary code
- **Preserve compatibility** - Don't break existing functionality
- **Add tests** - Prevent regression

**Flow**:
1. Write reproduction test (confirm bug exists)
2. Fix code
3. Run tests (confirm fix)
4. Regression testing

---

### Phase 4: Quality Gates

Ensure no new problems.

**Checklist**:
- [ ] Bug is fixed
- [ ] No regression
- [ ] Test coverage
- [ ] Documentation updated (if needed)

---

### Phase 5: Self-Reflection

Summarize lessons learned.

**Questions**:
- What was the root cause?
- Why did it happen?
- How to prevent similar issues?

---

## Best Practices

1. **Reproduce first** - Confirm you can reproduce the bug
2. **Write tests** - Write failing tests first
3. **Minimal changes** - Only change necessary code
4. **Verify impact** - Ensure other functionality isn't broken
