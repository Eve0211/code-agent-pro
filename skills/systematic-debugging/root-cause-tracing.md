# Root Cause Tracing

A systematic method to find the true origin of a bug, not just its symptoms.

---

## The 5 Whys Method

Ask "Why?" five times to drill down to the root cause.

### Example

```
Problem: User can't log in

Why? → Login returns 401
Why? → Password verification fails
Why? → Hash doesn't match stored hash
Why? → Stored hash was truncated
Why? → Database column was too short (VARCHAR(32) instead of VARCHAR(255))

Root cause: Database schema incorrect
Fix: ALTER TABLE users MODIFY password_hash VARCHAR(255)
```

---

## Symptom vs Root Cause

| Symptom | What it looks like | How to find root cause |
|---------|-------------------|------------------------|
| App crashes | Process terminates | Check stack trace, error logs |
| Wrong output | Result is incorrect | Trace data flow, check calculations |
| Slow performance | Takes too long | Profile, check queries, check network |
| Memory leak | Memory grows over time | Heap dump, object retention analysis |
| Race condition | Inconsistent results | Log sequence, check synchronization |

---

## Tracing Techniques

### Technique 1: Stack Trace Reading

```javascript
Error: Cannot read property 'id' of undefined
    at User.getName (app.js:25)
    at AuthController.login (app.js:102)
    at Router.handle (app.js:45)
```

Read from bottom to top:
1. Router received request
2. AuthController.login was called
3. User.getName tried to access `id`
4. **Root cause**: User object is undefined in getName

### Technique 2: Data Flow Tracing

Follow the data from input to output:

```
Input → Validation → Processing → Storage → Output
                     ↑
                  Check here for corruption
```

```javascript
// Add checkpoints
console.log('1. Input:', input);
const validated = validate(input);
console.log('2. Validated:', validated);
const processed = process(validated);
console.log('3. Processed:', processed);
const stored = store(processed);
console.log('4. Stored:', stored);
```

### Technique 3: State Inspection

Check state at each step:

```javascript
// React DevTools
// Redux DevTools
// Vue DevTools

// Or manual logging
useEffect(() => {
  console.log('State changed:', state);
}, [state]);
```

### Technique 4: Binary Search in Time

If you know when the bug was introduced:

```bash
# Find the commit that introduced the bug
git bisect start
git bisect bad HEAD           # Current version has bug
git bisect good v1.0.0        # This version was fine

# Git will guide you through commits
# Test each one and mark good/bad
git bisect good  # or git bisect bad
```

---

## Common Root Causes

### Category 1: Data Issues

| Symptom | Likely Root Cause |
|---------|-------------------|
| Null/undefined errors | Missing initialization, failed API call |
| Wrong type | API contract change, missing validation |
| Stale data | Cache not invalidated, missing refresh |

### Category 2: Logic Issues

| Symptom | Likely Root Cause |
|---------|-------------------|
| Off-by-one | Loop bounds, array indexing |
| Infinite loop | Wrong exit condition |
| Wrong branch | Condition inverted, missing case |

### Category 3: Timing Issues

| Symptom | Likely Root Cause |
|---------|-------------------|
| Race condition | Missing synchronization |
| Memory leak | Event listener not removed |
| Callback hell | Async flow not controlled |

### Category 4: Integration Issues

| Symptom | Likely Root Cause |
|---------|-------------------|
| API errors | Wrong endpoint, auth issue |
| CORS errors | Missing headers |
| Version mismatch | Dependency incompatibility |

---

## Documentation Template

When you find a root cause, document it:

```markdown
## Bug: [Brief Description]

**Symptom:** [What the user sees]
**Root Cause:** [The actual underlying issue]
**How Found:** [What technique revealed it]
**Fix:** [What was changed]
**Prevention:** [How to prevent in future]

### Timeline
1. [Step in the process]
2. [Step in the process]
3. [Where it went wrong] ← ROOT CAUSE
4. [Resulting symptom]
```

---

## Anti-Patterns

❌ **Fixing symptoms, not causes**
```
Symptom: API returns 500
Wrong fix: Add try-catch to ignore error
Right fix: Find why API throws and fix that
```

❌ **Assuming without verifying**
```
Assumption: "It's probably a network issue"
Reality: It was a malformed request
```

❌ **Stopping at first explanation**
```
First answer: "The variable is null"
Why is it null? → [Keep asking]
```

---

## Summary

1. **Start with the symptom** — What's wrong?
2. **Ask "Why?" repeatedly** — Until you reach something fundamental
3. **Verify the root cause** — Confirm your theory
4. **Fix the root cause** — Not the symptom
5. **Document** — Help future debuggers
