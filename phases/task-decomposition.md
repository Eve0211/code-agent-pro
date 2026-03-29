# Task Decomposition Phase

> Phase 6: Break Down Tasks

## Purpose

Break architecture design into executable micro-tasks.

## Input

- Architecture design
- PRD

## Output

- Task list

---

## Decomposition Principles

### Task Granularity

- Each task 2-5 minutes
- Each task independently testable
- Each task independently committable

---

### TDD Principles

Each task includes:
1. Write test
2. Run test (fail)
3. Write implementation
4. Run test (pass)
5. Commit

---

## Decomposition Steps

### Step 1: Identify Modules

Identify main modules from architecture design.

---

### Step 2: List Features

Features within each module.

---

### Step 3: Break Into Tasks

Break each feature into specific tasks.

---

### Step 4: Order

Order by dependencies.

---

## Task Format

```markdown
### Task 1: [Task Name]

**Files**:
- Create: `src/user/user.service.ts`
- Test: `src/user/user.service.test.ts`

**Estimated Time**: 5 minutes

- [ ] Step 1: Write test
```typescript
describe('UserService', () => {
  it('should create user', async () => {
    // test code
  });
});
```

- [ ] Step 2: Run test (fail)
```bash
npm test -- user.service.test.ts
```

- [ ] Step 3: Write implementation
```typescript
async createUser(data: CreateUserDTO): Promise<User> {
  // implementation
}
```

- [ ] Step 4: Run test (pass)

- [ ] Step 5: Commit
```bash
git add . && git commit -m "feat(user): add create user"
```
```

---

## Output Format

```markdown
## Task List

**Project**: [project name]
**Total Tasks**: X
**Estimated Total Time**: X hours

### Module 1: User

#### Task 1.1: Create UserService
- Estimated: 5 minutes
- Files: src/user/user.service.ts

#### Task 1.2: Add user validation
- Estimated: 10 minutes
- Files: src/user/user.validation.ts

### Module 2: Auth

#### Task 2.1: Create AuthService
- Estimated: 10 minutes
- Files: src/auth/auth.service.ts

...

### Execution Order

1. Task 1.1 → Task 1.2
2. Task 2.1
3. ...

### Dependencies

```
Task 1.1 (UserService)
    ↓
Task 1.2 (Validation)
    ↓
Task 2.1 (AuthService) → Requires Task 1.1
```
```

---

## Notes

1. **Appropriate granularity** - Not too big or too small
2. **Independently testable** - Each task verifiable independently
3. **Clear dependencies** - Explicit about inter-task dependencies
4. **Accurate estimation** - Time estimates should be reasonable
