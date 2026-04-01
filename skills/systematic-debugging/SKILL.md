# Systematic Debugging Skill

A structured approach to debugging that goes beyond trial-and-error. Root cause analysis, hypothesis testing, and verification.

---

## When to Use

- Bug fix is not obvious
- Multiple symptoms point to different causes
- Previous fixes didn't work
- Need to understand why the bug exists

---

## The Debugging Process

```
1. Reproduce → 2. Isolate → 3. Hypothesize → 4. Test → 5. Fix → 6. Verify
```

---

## Phase 1: Reproduce

### Goal
Get the bug to happen consistently.

### Actions

1. **Document the symptom:**
   - What exactly happens?
   - When does it happen?
   - What are the exact error messages?

2. **Find reproduction steps:**
   - Minimal steps to trigger the bug
   - Environment conditions (browser, OS, data state)
   - Frequency (always, intermittent, rare)

3. **Check logs:**
   - Application logs
   - Browser console
   - Network requests
   - Server logs

### Output

```markdown
## Bug Report

**Symptom:** [What happens]
**Error:** [Exact error message]
**Reproduction:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Environment:**
- Browser: [version]
- OS: [version]
- App version: [commit/version]

**Frequency:** [Always / Sometimes / Rare]
```

---

## Phase 2: Isolate

### Goal
Narrow down where the bug originates.

### Actions

1. **Binary search:**
   - Comment out half the code → does bug still happen?
   - Repeat until isolated to a specific function/line

2. **Check boundaries:**
   - Input validation
   - API boundaries
   - State transitions

3. **Compare working vs broken:**
   - What changed between working and broken states?
   - Git diff can help

### Output

```markdown
## Isolation Results

**Suspected location:** `file.ts:line 42`
**Suspected function:** `functionName()`
**Last known working:** [commit/version]
**First known broken:** [commit/version]
```

---

## Phase 3: Hypothesize

### Goal
Form testable theories about the cause.

### Actions

1. **List possible causes:**
   - Race condition?
   - Null/undefined value?
   - Type mismatch?
   - State mutation?
   - API change?

2. **Rank by likelihood:**
   - Most likely first
   - Easiest to test first

### Output

```markdown
## Hypotheses

| # | Hypothesis | Likelihood | Test Approach |
|---|------------|------------|---------------|
| 1 | [Theory 1] | High | [How to test] |
| 2 | [Theory 2] | Medium | [How to test] |
| 3 | [Theory 3] | Low | [How to test] |
```

---

## Phase 4: Test

### Goal
Verify or disprove each hypothesis.

### Actions

1. **Add logging:**
   ```javascript
   console.log('Variable state:', variable);
   console.log('Function called with:', args);
   ```

2. **Add breakpoints:**
   - Set at suspected location
   - Inspect variable values
   - Step through execution

3. **Write a minimal test case:**
   - Reproduces the bug
   - Can be run repeatedly

### Output

```markdown
## Test Results

**Hypothesis 1:** [Confirmed / Disproved]
- Evidence: [what you observed]

**Hypothesis 2:** [Confirmed / Disproved]
- Evidence: [what you observed]
```

---

## Phase 5: Fix

### Goal
Implement the fix based on confirmed hypothesis.

### Actions

1. **Make the minimal fix:**
   - Fix only what's broken
   - Don't refactor while fixing

2. **Document the fix:**
   - Why this fixes it
   - What the root cause was

### Output

```markdown
## Fix Applied

**Root cause:** [what was actually wrong]
**Fix location:** `file.ts:line 42`
**Fix description:** [what changed]
**Why this works:** [explanation]
```

---

## Phase 6: Verify

### Goal
Confirm the fix works and doesn't break anything else.

### Actions

1. **Reproduce the original bug:**
   - Should no longer happen

2. **Run existing tests:**
   - All should pass

3. **Check edge cases:**
   - What if input is null?
   - What if input is empty?
   - What if input is very large?

4. **Check related functionality:**
   - Did the fix affect anything else?

### Output

```markdown
## Verification

- [ ] Original bug no longer reproducible
- [ ] All existing tests pass
- [ ] Edge cases handled
- [ ] No regressions detected
```

---

## Common Debugging Patterns

### Pattern 1: Print Debugging

When you can't use a debugger:

```javascript
// Add at entry points
console.log('→ Entering function:', functionName, 'with args:', args);

// Add at exit points
console.log('← Exiting function:', functionName, 'returning:', result);

// Add at decision points
console.log('  Condition check:', condition, 'result:', result);
```

### Pattern 2: Rubber Duck Debugging

Explain the code line by line to:
- A rubber duck
- An imaginary person
- This conversation

Often you'll spot the issue while explaining.

### Pattern 3: Divide and Conquer

```
If bug exists in range A-B:
  Check midpoint M
  If bug at M: range is A-M
  Else: range is M-B
  Repeat
```

### Pattern 4: Change One Thing

Only change ONE variable at a time:
- Don't change code AND data
- Don't change multiple lines
- Test after each change

---

## Anti-Patterns

❌ **Shotgun debugging** — Change random things hoping it fixes
❌ **Premature optimization** — Refactor while debugging
❌ **Ignoring the error message** — Read the error carefully first
❌ **Not reproducing first** — Fix without understanding the bug
❌ **Fixing symptoms** — Not addressing root cause
❌ **No verification** — Assuming it's fixed without testing

---

## Advanced Techniques

- [Condition-Based Waiting](condition-based-waiting.md) — For async/timing issues
- [Root Cause Tracing](root-cause-tracing.md) — 5 Whys method
- [Defense in Depth](defense-in-depth.md) — Prevent bugs from recurring

---

## Quick Reference

| Symptom | Likely Cause | First Check |
|---------|--------------|-------------|
| `undefined is not a function` | Missing import, typo in method name | Import statements, spelling |
| `Cannot read property of null` | Null/undefined value | Variable initialization |
| `404 Not Found` | Wrong URL, missing route | Network tab, route definitions |
| `500 Internal Server Error` | Server exception | Server logs |
| Works locally, fails in prod | Environment difference | Config, env vars, dependencies |
| Intermittent failure | Race condition, timing | Async code, state management |
| Slow performance | N+1 queries, large data | Database queries, bundle size |
