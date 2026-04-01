# Lightweight TDD

## Core Philosophy
TDD is great, but over-engineering it for small tasks is not. Core principle: **confirm "what is correct" first, then write code**.

- **UI tasks:** Use "expected effect" descriptions instead of tests
- **Logic tasks:** Use "verification points" instead of full test suites

---

## Rules

### 1. UI Tasks: Effect First
- Before writing code, describe the expected effect (screenshot, text description, or reference)
- Write code only after user confirms the effect
- After code is written, verify against the description one by one
- If effect is unclear, ask proactively

### 2. Logic Tasks: Verification Point Driven
When breaking down a task, list explicit verification points:

```
Verification point V1: [expected behavior]
Verification point V2: [expected behavior]
```

After writing code, verify each point:
- ✅ Pass → mark as passed
- ❌ Fail → mark as failed and record the issue
- Only complete the task when all points pass

### 3. Bug Fixes: Reproduce First
- If the bug trigger is unclear, write a verification point that reproduces the bug first
- Run the verification point and confirm the bug reproduces
- Then fix the code
- Run the verification point again to confirm the bug is gone

### 4. Edge Cases: Selective Coverage
Priorities for lightweight scenarios:
- **P0**: Normal path must pass
- **P1**: Common edge values (null, 0, max value)
- **P2**: Extreme cases covered as needed

---

## Verification Point Template

```markdown
## Verification Points

| Point | Description | Expected | Actual | Status |
|-------|-------------|----------|--------|--------|
| V1 | [description] | [expected] | [TBD] | ⬜ |
| V2 | [description] | [expected] | [TBD] | ⬜ |

Completion: V1 ✅, V2 ✅
```

---

## Relationship to superpowers TDD
This is a lightweight adaptation of the superpowers TDD process. superpowers requires: "write test → watch fail → write code → watch pass → commit". In lightweight scenarios, this simplifies to: "verification points → execute → verify". You can always fall back to full TDD when needed.
