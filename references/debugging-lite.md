# Debugging Lite

## Philosophy
Two things make debugging painful: fixing one thing and breaking another, and fixing the wrong root cause. Solution: **don't touch code until you find the root cause, and don't move on until you've verified**.

---

## Three Steps: Observe → Hypothesize → Verify

### Step 1: Observe

Gather information and reconstruct the scene.

Checklist:
- [ ] Read the full error message (not just the last line)
- [ ] Record what the user was doing before the error occurred
- [ ] Check for recent code changes (git diff or file timestamps)
- [ ] Confirm whether the issue is reproducible

Output format:
```
🔍 Observation Log

Error message: [full paste]
Steps to reproduce: [what user did]
Recent changes: [if any]
Reproducibility: [100% / 50% / intermittent]
```

### Step 2: Hypothesize

Formulate a root cause hypothesis based on observations.

Principles:
- One hypothesis at a time (never several at once)
- Guess the most likely cause, not the most exotic one
- If information is insufficient, gather more observations first

Output format:
```
💡 Root Cause Hypothesis

Hypothesis: [one sentence describing the root cause]
Evidence: [why you think this]
Risk: [worst case if you're wrong]
```

### Step 3: Verify

Design the smallest possible test to prove or disprove the hypothesis.

Verification approaches (pick one):
1. **Minimal test**: Write a test that only checks this one point
2. **Isolation**: Create a minimal reproducible example
3. **Compare**: Find a similar working piece of code and compare

Result:
- ✅ Hypothesis confirmed → Fix the code → Re-verify
- ❌ Hypothesis rejected → Document the lesson → Back to Step 1

---

## Fixing Rules

1. **Fix the root cause, not the symptom**
   - ❌ "Make the error message disappear" → treats symptom
   - ✅ "Make sure the error never comes back" → fixes root cause

2. **Minimum change principle**
   - Smaller changes = lower risk of introducing new problems
   - Priority: data/config > logic > structural refactoring

3. **Verify after every fix**
   - Repeat Step 3 to confirm the bug is resolved
   - Document the fix to prevent the same issue in the future

---

## When Stuck

1. **Re-observe**: Reread the error — it's easy to miss a key detail
2. **Rubber duck**: Explain the bug out loud — solutions often appear mid-explanation
3. **Narrow the scope**: Binary search which module or line is responsible
4. **Switch direction**: When multiple suspects exist, test the most likely one first

---

## Relationship to superpowers Debugging
superpowers defines four steps: Root Cause → Pattern Analysis → Hypothesis → Fix + Verify.
This reference simplifies it to: Observe → Hypothesize → Verify, folding Pattern Analysis into both observation and hypothesis formation.
