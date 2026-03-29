# Quick Fix Workflow

> Minimal path for simple, obvious fixes

## Trigger Conditions

- Short request - Brief description, clear goal
- Obvious change - Know how to fix at a glance
- No complexity - No architecture analysis needed

**Examples**:
- "Fix a typo"
- "Update version number"
- "Add a console.log"

## Workflow Overview

```
clarify → implementation → quality-gates
```

**3 phases**

---

## Phase Details

### Phase 1: Clarify

Quickly confirm what to change.

**Questions**:
- What to change?
- Which file?
- What should it look like?

---

### Phase 2: Implementation

Direct execution.

**Flow**:
1. Locate file
2. Implement change
3. Confirm result

---

### Phase 3: Quality Gates

Quick check.

**Checklist**:
- [ ] Change matches expectation
- [ ] No syntax errors
- [ ] Didn't break other code

---

## Applicable Scenarios

| Scenario | Example |
|----------|---------|
| Documentation | Update README, modify comments |
| Configuration | Change config values, version numbers |
| Minor changes | Fix typos, adjust styles |
| Debugging | Add logs, temporarily disable code |

---

## Not Applicable

- Need to understand code logic
- Involves multiple files
- Risk of side effects
- Need test verification

→ **Use other workflows**

---

## Decision Criteria

**Use Quick Fix when**:
1. Change ≤ 5 lines
2. No logic involved
3. Very low risk
4. User confirms intent

**Otherwise use other workflows**
