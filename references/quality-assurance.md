# Quality Assurance

## Overview

Quality assurance is not a final step — it's woven into every phase. This document covers static analysis, test generation, code self-inspection, and the quality gate policy.

## Static Analysis

### Tool Matrix

| Language | Primary Tool | Secondary | Command |
|----------|-------------|-----------|---------|
| Python | Ruff | Mypy, Pyright | `ruff check .` + `mypy .` |
| TypeScript/JS | ESLint | TypeScript | `eslint .` + `tsc --noEmit` |
| Go | `go vet` | staticcheck | `go vet ./...` |
| Rust | Clippy | rustfmt | `cargo clippy` |
| Java | Error Prone | SpotBugs | `mvn compile` |
| Ruby | RuboCop | — | `rubocop` |

### Ruff Configuration (Python)

For Python projects, Ruff is fast and comprehensive:

```toml
[tool.ruff]
line-length = 100
target-version = "py39"

[tool.ruff.lint]
select = [
    "E",     # pycodestyle errors
    "W",     # pycodestyle warnings
    "F",     # Pyflakes
    "I",     # isort
    "B",     # flake8-bugbear
    "C4",    # flake8-comprehensions
    "UP",    # pyupgrade
    "RUF",   # Ruff-specific rules
]
ignore = ["E501"]  # line length handled by formatter
```

### TypeScript ESLint Config

```json
{
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended-type-checked"
  ],
  "parserOptions": {
    "project": "./tsconfig.json"
  }
}
```

## Test Generation

### Test File Conventions

Follow the project's existing test conventions. Common patterns:

| Framework | Test Location | Naming |
|-----------|-------------|--------|
| Jest | `*.test.ts` alongside source | `sum.test.ts` |
| pytest | `tests/` directory | `test_sum.py` |
| Go | `*_test.go` alongside source | `sum_test.go` |
| RSpec | `spec/` directory | `sum_spec.rb` |

### Test Coverage Targets

| Requirement Level | Coverage Target |
|------------------|----------------|
| P0 | 90%+ line coverage |
| P1 | 70%+ line coverage |
| P2 | Best effort |

### Test Types

**Unit Tests** — for pure functions and isolated classes:
```python
def test_add_numbers():
    assert add(2, 3) == 5

def test_add_negative():
    assert add(-1, 1) == 0
```

**Edge Case Tests** — derived from PRD acceptance criteria:
```python
def test_rate_limit_exceeded():
    client = RateLimitedClient(limit=3)
    for _ in range(3):
        assert client.request() == "ok"
    assert client.request() == "rate_limited"
```

**Integration Tests** — for API handlers and service layers:
```typescript
async function test_auth_flow() {
  const token = await authService.login("user", "pass");
  expect(token).toBeValidJWT();
}
```

### Test Generation Prompts

When generating tests, always include:
1. The function/method being tested
2. All edge cases from the acceptance criteria
3. Error conditions that should be handled
4. The project's testing framework and conventions

## Code Self-Inspection

### Pre-Submission Checklist

```markdown
## Pre-Submission Checklist
- [ ] Function does exactly one thing
- [ ] No hidden state mutations
- [ ] Errors caught and handled meaningfully
- [ ] Names are self-documenting
- [ ] Comments explain WHY, not WHAT
- [ ] No obvious duplication
- [ ] Cyclomatic complexity ≤ 10
- [ ] No hardcoded values that should be config
- [ ] Tests cover the happy path AND edge cases
- [ ] Version compatibility verified (framework API matches detected version)
- [ ] README updated if public API or project structure changed
```

### Complexity Threshold

If a function exceeds cyclomatic complexity of 10, it must be refactored before submission. Common refactoring patterns:

- **Extract conditionals**: `if (isValid && hasPermission && notExpired)` → `canProceed()`
- **Extract methods**: Long switch/case → map of handlers
- **Extract classes**: Functions sharing state → class with methods

### Naming Quality

Good names are the best documentation:

| ❌ Bad | ✅ Good |
|--------|--------|
| `processData()` | `normalizeUserInput()` |
| `temp` | `pendingDeletionTimestamp` |
| `handle()` | `handleExpiredSession()` |
| `x` | `retryCount` |

## Quality Gate Policy

### Gate Execution Order

```
1. Format code
2. Run linter
3. Run type checker
4. Run unit tests
5. Run build
6. Security scan
```

Stop at first failure. Fix then re-run from the beginning.

### Failure Response

**Build failure**: Stop, fix build errors, re-run all gates.
**Test failure**: Stop, fix or skip (with justification), re-run.
**Lint failure**: Stop, auto-fix if possible (`ruff --fix`), otherwise fix manually.
**Type failure**: Stop, fix type errors.
**Security failure**: Stop immediately. Security issues are P0 regardless of project stage.

### What Gets Flagged, Not Blocked

These are reported but don't stop the gate:
- Cyclomatic complexity 10-15 (flag; >15 block)
- Missing function documentation (flag)
- TODO comments in code (flag)
- Low test coverage on P2 requirements (flag)

## Regression Prevention

### Before Submitting

1. Run the full test suite, not just related tests
2. Check if any existing tests broke
3. Verify no new warnings were introduced
4. Ensure the change is minimal and focused

### Change Boundary Discipline

**Rule**: One PR = one logical change.

If you need to fix formatting, refactor naming, AND add a feature:
- Submit these as separate changes
- Or combine them only if they are truly inseparable

### Baseline Comparison

When working in an existing codebase:
1. Run tests before making changes → establish baseline
2. Make changes
3. Run tests after → ensure no regressions
4. If regressions found → fix before presenting
