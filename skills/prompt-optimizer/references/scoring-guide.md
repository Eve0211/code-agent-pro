# Score Interpretation Guide

## Per-Dimension Score Descriptors

### Clarity (1-10)

| Score | Meaning |
|-------|---------|
| 1-3 | Vague goal, undefined terms, multiple valid interpretations |
| 4-5 | Mostly understandable but has ambiguous phrases |
| 6-7 | Clear overall, minor ambiguous spots |
| 8-9 | Precise wording throughout, one reading only |
| 10 | Crystal clear; no possible misinterpretation |

**Red flags:** "somewhat", "etc.", "appropriately", "handle it well", undefined pronouns

---

### Completeness (1-10)

| Score | Meaning |
|-------|---------|
| 1-3 | Missing essential elements: no role, no task, or no output spec |
| 4-5 | Task is clear but missing context, constraints, or format |
| 6-7 | Most elements present; 1-2 gaps (e.g., missing examples or edge-case handling) |
| 8-9 | Fully specified with examples and edge cases covered |
| 10 | Over-specified with optional enhancements (tone, persona, etc.) |

**Checklist:**
- [ ] Role/identity defined?
- [ ] Task clear and specific?
- [ ] Constraints specified?
- [ ] Output format stated?
- [ ] Examples provided (for complex tasks)?
- [ ] Edge cases / "don't do X" covered?

---

### Alignment (1-10)

| Score | Meaning |
|-------|---------|
| 1-3 | The prompt as written produces something fundamentally different from the intended task |
| 4-5 | Reasonable chance of misaligned output for non-trivial inputs |
| 6-7 | Mostly aligned; some edge cases may produce off-target output |
| 8-9 | Prompt reliably guides model to intended output |
| 10 | Any reasonable input will receive the correct structured response |

**Test question:** If someone gives an unusual but valid input, does the prompt guide the model to handle it correctly?

---

### Safety (1-10)

| Score | Meaning |
|-------|---------|
| 1-3 | Explicitly instructs harmful, discriminatory, or illegal behavior |
| 4-5 | Has potential for harmful output if given adversarial inputs |
| 6-7 | Mostly safe but lacks natural guardrails |
| 8-9 | Natural safety instructions; won't be bypassed by normal prompts |
| 10 | Safety woven into role and task; cannot be easily jailbroken |

**Check for:**
- Does the prompt encourage harmful actions?
- Are there biases embedded in examples or framing?
- Can role-play scenarios be used to bypass safety?

---

### Robustness (1-10)

| Score | Meaning |
|-------|---------|
| 1-3 | Easily broken by typos, unconventional inputs, or role-play attempts |
| 4-5 | Works for normal inputs but fails on edge cases or injection attempts |
| 6-7 | Handles typical variations; some injection vectors exist |
| 8-9 | Good resistance to injection and role confusion |
| 10 | Systematically defended against prompt injection, jailbreaking, and edge-case confusion |

**Red flags:**
- No mention of what to do if input is invalid
- No constraints on system prompt override attempts
- Role can be easily swapped or dropped
- No instruction to ignore conflicting instructions

---

### Output Spec (1-10)

| Score | Meaning |
|-------|---------|
| 1-3 | No output format specified at all |
| 4-5 | General format mentioned but not enforced |
| 6-7 | Format specified but model could violate it without consequence |
| 8-9 | Explicit format with enforcement (e.g., "If you cannot complete the task, say 'FAILED'") |
| 10 | Format enforced, length constrained, and stopping conditions clear |

**Check for:**
- Is the format enforceable or just suggested?
- Is length constrained?
- Are stopping conditions explicit?
- Does the model know when to stop generating?

---

## Passing Threshold

**Overall ≥ 8.0 → PASS**

Below 8.0 means at least one dimension is meaningfully weak. Iterate.

**If overall < 7.0 after 3 rounds:** Stop and present the best version with a frank note about remaining weaknesses. Don't iterate endlessly.
