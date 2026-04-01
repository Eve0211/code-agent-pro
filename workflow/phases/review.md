# Review Phase

> Phase 10: Code Review

## Purpose

Review code quality, ensure best practices.

## Input

- Implementation code
- Test results

## Output

- Review report

---

## Review Dimensions

### 1. Code Review

**Checks**:
- Code style
- Readability
- Complexity
- Naming conventions

**Score**: 1-10

---

### 2. Architecture Review

**Checks**:
- Design patterns
- Module division
- Dependencies
- Extensibility

**Score**: 1-10

---

### 3. UX Review

**Checks**:
- User flows
- Response speed
- Error messages
- Accessibility

**Score**: 1-10

---

### 4. Security Review

**Checks**:
- Input validation
- Permission control
- Sensitive data handling
- XSS/CSRF protection

**Score**: 1-10

---

## Review Methods

### Automated Checks

```bash
# Lint
npm run lint

# Type check
npm run type-check

# Security audit
npm audit
```

---

### Manual Review

1. **Read code** - Understand implementation
2. **Check logic** - Verify correctness
3. **Assess quality** - Code quality
4. **Provide suggestions** - Improvement suggestions

---

## Output Format

```markdown
## Review Report

**Reviewer**: AI
**Review Date**: [date]
**Scope**: [changes scope]

### Overall Score: 8.5/10 ✅

### Code Review

**Score**: 8/10

**Positives**:
- ✅ Consistent code style
- ✅ Clear naming
- ✅ Single responsibility functions

**Suggestions**:
- ⚠️ Consider extracting constants
- ⚠️ Add error boundaries

### Architecture Review

**Score**: 9/10

**Positives**:
- ✅ Clear module division
- ✅ Reasonable dependencies

**Suggestions**:
- ⚠️ Consider adding service layer

### UX Review

**Score**: 8/10

**Positives**:
- ✅ Smooth flow
- ✅ Clear error messages

**Suggestions**:
- ⚠️ Add loading states
- ⚠️ Add keyboard shortcuts

### Security Review

**Score**: 9/10

**Positives**:
- ✅ Complete input validation
- ✅ No obvious vulnerabilities

**Suggestions**:
- ⚠️ Add CSP headers

### Action Items

| Priority | Item | Status |
|----------|------|--------|
| High | [ ] | Pending |
| Medium | [ ] | Pending |
| Low | [ ] | Pending |

### Conclusion

✅ Passed review, ready to merge
```

---

## Review Standards

### Pass Conditions

- Overall score ≥ 7
- No High issues
- Security score ≥ 7

---

### Failure Handling

1. Record issues
2. Fix issues
3. Re-review

---

## Notes

1. **Objective** - No bias
2. **Specific suggestions** - Not generic
3. **Prioritize** - Indicate importance
4. **Constructive** - Provide solutions
