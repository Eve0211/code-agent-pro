# Implementation Phase

> Phase 7: Write Code

## Purpose

Write code to implement features.

## Input

- Task list
- Architecture design

## Output

- Runnable code

---

## Implementation Principles

### TDD Flow

```
1. Write test (Red)
    ↓
2. Run test (Fail)
    ↓
3. Write implementation (Green)
    ↓
4. Run test (Pass)
    ↓
5. Refactor
    ↓
6. Commit
    ↓
7. Next task
```

---

### Task Granularity

- Each task 2-5 minutes
- Each task independently testable
- Each task independently committable

---

## Implementation Steps

### Step 1: Check Task

- Understand task goal
- Confirm input/output
- Identify dependencies

---

### Step 2: Write Test

```typescript
describe('UserService', () => {
  it('should create user', async () => {
    const user = await service.createUser({
      email: 'test@example.com',
      name: 'Test'
    });
    expect(user.id).toBeDefined();
  });
});
```

---

### Step 3: Run Test

```bash
npm test -- --watch
```

**Expected**: Test fails (feature not implemented)

---

### Step 4: Write Implementation

```typescript
async createUser(data: CreateUserDTO): Promise<User> {
  const user = this.repository.create(data);
  return this.repository.save(user);
}
```

---

### Step 5: Run Test

**Expected**: Test passes

---

### Step 6: Refactor

- Check code quality
- Eliminate duplication
- Optimize structure

---

### Step 7: Commit

```bash
git add .
git commit -m "feat: add user creation"
```

---

## Code Standards

### Naming

| Type | Convention | Example |
|------|------------|---------|
| Variable | camelCase | userName |
| Constant | UPPER_CASE | MAX_RETRY |
| Function | camelCase | getUserById |
| Class | PascalCase | UserService |
| File | kebab-case | user-service.ts |

---

### Comments

```typescript
/**
 * Create new user
 * @param data User data
 * @returns Created user object
 */
async createUser(data: CreateUserDTO): Promise<User> {
  // implementation...
}
```

---

### Error Handling

```typescript
try {
  const user = await service.createUser(data);
  return user;
} catch (error) {
  logger.error('Failed to create user', error);
  throw new UserCreationError(error.message);
}
```

---

## Checklist

- [ ] Test written
- [ ] Test passes
- [ ] Code style consistent
- [ ] No TypeScript errors
- [ ] No lint warnings
- [ ] Committed

---

## Notes

1. **Small steps** - Only one task at a time
2. **Frequent commits** - Easy rollback
3. **Keep tests green** - Always ready to release
4. **Follow existing patterns** - Maintain consistency
