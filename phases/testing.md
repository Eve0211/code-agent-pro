# Testing Phase

> Phase 9: Comprehensive Testing

## Purpose

Comprehensive testing to verify correctness.

## Input

- Implementation code

## Output

- Test report

---

## Test Types

### 1. Unit Tests

**Purpose**: Test smallest units

```typescript
describe('sum', () => {
  it('should add two numbers', () => {
    expect(sum(1, 2)).toBe(3);
  });
});
```

**Coverage Target**: ≥ 80%

---

### 2. Integration Tests

**Purpose**: Test module interactions

```typescript
describe('UserService', () => {
  it('should create and retrieve user', async () => {
    const created = await service.createUser({ name: 'Test' });
    const found = await service.getUser(created.id);
    expect(found.name).toBe('Test');
  });
});
```

---

### 3. E2E Tests

**Purpose**: Test complete flows

```typescript
describe('User Flow', () => {
  it('should complete registration', async () => {
    await page.goto('/register');
    await page.fill('#email', 'test@example.com');
    await page.click('#submit');
    await expect(page.locator('.success')).toBeVisible();
  });
});
```

---

### 4. Manual Testing

**Checklist**:
- [ ] Basic functionality works
- [ ] Edge cases handled
- [ ] Error handling correct
- [ ] UI responsive
- [ ] Performance acceptable

---

## Test Strategy

### Pyramid Model

```
        ▲
       ▲ ▲       E2E (few)
      ▲   ▲
     ▲     ▲     Integration (some)
    ▲       ▲
   ▲         ▲   Unit (many)
  ▲           ▲
```

---

### Coverage Targets

| Type | Target |
|------|--------|
| Statements | ≥ 80% |
| Branches | ≥ 70% |
| Functions | ≥ 80% |
| Lines | ≥ 80% |

---

## Test Commands

```bash
# Run all tests
npm test

# Run specific test
npm test -- user.test.ts

# Watch mode
npm test -- --watch

# Generate coverage
npm test -- --coverage
```

---

## Output Format

```markdown
## Test Report

**Date**: [date]
**Commit**: [commit hash]

### Test Results

| Type | Pass | Fail | Skip | Total |
|------|------|------|------|-------|
| Unit | 38 | 0 | 2 | 40 |
| Integration | 8 | 0 | 0 | 8 |
| E2E | 3 | 0 | 0 | 3 |
| **Total** | **49** | **0** | **2** | **51** |

### Coverage

| Type | Coverage | Status |
|------|----------|--------|
| Statements | 85% | ✅ |
| Branches | 78% | ✅ |
| Functions | 90% | ✅ |
| Lines | 85% | ✅ |

### Manual Testing Checklist

- [x] Basic functionality works
- [x] Edge cases handled
- [x] Error handling correct
- [x] UI responsive
- [x] Performance acceptable

### Issue Log

| Issue | Severity | Status |
|-------|----------|--------|
| - | - | - |

### Conclusion

✅ All tests passed
```

---

## Notes

1. **Test first** - TDD
2. **Keep independent** - Tests don't depend on each other
3. **Fast execution** - Tests should be fast
4. **Repeatable** - Results are stable
