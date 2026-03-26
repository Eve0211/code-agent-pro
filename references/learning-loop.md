# Learning Loop

## Overview

Code Agent Pro learns from every session. The learning loop captures failures, tracks preferences, accumulates performance insights, and enables principled decision-making through A/B evaluation.

## Failure Mode Library

### What Goes In

Record failures that are:
- Architectural mistakes (wrong approach chosen)
- Incorrect assumptions about the codebase
- Bug introductions (not caught by tests)
- Communication failures (user wanted something different)
- Quality issues that slipped through gates

### Do NOT Record

- Normal debugging attempts
- Exploration that didn't pan out but taught something useful (→ memory file instead)
- Obvious mistakes that were caught and fixed immediately

### Failure Record Format

```markdown
## Failure: [Brief, descriptive title]

**Date:** YYYY-MM-DD
**Task:** [what was being attempted]
**What happened:** [concise description of the failure]
**Root cause:** [why it happened — be honest]
**Impact:** [how the user was affected]
**Lesson:** [specific action to take next time]

## Prevention

When [similar situation], always:
- [specific check or step to add]
```

### Example Failure Records

```markdown
## Failure: Wrong abstraction level for error handling

**Date:** 2026-03-20
**Task:** Adding retry logic to API calls
**What happened:** Built retry into each API function individually instead of a middleware
**Root cause:** Didn't step back to look at the broader pattern
**Impact:** Code duplication, inconsistent retry behavior
**Lesson:** Before adding logic to multiple places, ask "is this a cross-cutting concern?"

**Prevention:**
When adding the same logic to 3+ functions, stop and check:
- Should this be a decorator/middleware?
- Should this be in a shared utility?
- Is there an existing abstraction I'm not using?
```

### Accessing the Failure Library

Before starting a new task, check if a similar task has failed before:

```
Read memory/failures.md (or equivalent)
If similar failure found: review the lesson before proceeding
```

## Preference Learning

### What to Track

**Code Style Preferences:**
- Indentation: spaces or tabs? (usually 2 or 4)
- Quote style: single or double?
- Import ordering conventions
- Naming patterns (camelCase vs snake_case vs kebab-case)
- Documentation requirements (JSDoc vs docstrings vs comments)

**Architecture Preferences:**
- Monolith vs modular
- Class-based vs functional
- Dependency injection vs global state
- Thick models vs anemic models

**Process Preferences:**
- How much explanation before starting?
- Preferred communication style (terse vs detailed)
- When to ask vs when to decide independently
- How to present changes (diff first? Demo? Summary?)

**Personal Notes:**
- Things that make them happy
- Pet peeves to avoid
- Context (projects they work on, team they collaborate with)

### Preference Storage

Store in `MEMORY.md` under a `## Preferences` section:

```markdown
## Preferences

### Code Style
- 2 spaces for indentation
- Single quotes for strings
- TypeScript: strict mode always
- Python: type hints on all public functions

### Architecture
- Prefer small, focused functions over classes
- Keep business logic out of handlers
- Use dependency injection for external services

### Process
- Always explain the approach before coding
- Show the diff, not just "done"
- Ask before introducing new dependencies
```

### Preference Elicitation

When working with a new user or new project, proactively ask:

- "Are there existing conventions I should follow?"
- "Do you have a preference on how I present changes?"
- "What's the most important quality for this code — speed of delivery, maintainability, or something else?"

## Performance Accumulation

### What to Track

For each completed task:
- Time taken (rough estimate: S/M/L/XL)
- Complexity encountered vs expected
- Unexpected obstacles
- Build/test infrastructure quality

### Performance Log

```markdown
## Performance Log: YYYY-MM-DD

| Task | Est. | Actual | Notes |
|------|------|--------|-------|
| Add OAuth to auth service | M | L | Had to understand existing session system first |
| Fix rate limit bug | S | S | Clear reproduction, easy fix |
| API refactor | L | XL | Underestimated dependency count |
```

### When Performance Data Becomes Useful

- **Estimates**: "This task is similar to X which took L, so expect L"
- **Obstacle patterns**: "X type of task always has obstacle Y — budget extra time"
- **Quality indicators**: If a task always takes longer than expected due to quality issues, flag for improving test coverage or build tooling.

## A/B Decision Framework

### When to Generate Multiple Options

Generate multiple approaches (A vs B) for:
- Architecture decisions (how to structure a new module)
- Technology choices (which library to use)
- Implementation strategies (how to approach a complex feature)
- API design decisions (interface shape, naming)

Do NOT generate multiple options for:
- Trivial changes (the answer is obvious)
- Tasks where time matters most (choose the pragmatic path)
- Cases where user has explicitly stated a preference

### A/B Evaluation Criteria

For each option, evaluate:

```markdown
### Option A: [Name]

**Correctness**: Does it solve the actual problem?
**Maintainability**: Will future developers understand it?
**Performance**: Does it meet performance requirements?
**Risk**: What could go wrong?
**Reversibility**: Can we change our mind later?
**Alignment**: Does it match our codebase patterns?

**Score**: [X/Y]
```

### Making a Recommendation

State your recommendation clearly:
- "I recommend Option A because..."
- Be explicit about the trade-offs
- If there's no clear winner, present both with their trade-offs and ask the user to decide

### When Not to Choose

Escalate to the user when:
- The trade-offs are genuinely equal
- The decision has significant downstream implications
- You're uncertain about domain-specific requirements
- The user explicitly wants to make this call

## Continuous Improvement Cycle

```
Every significant task:
  1. Do it → apply the current skill
  2. Review it → did it go well? Any friction?
  3. Update the skill → fix gaps found
  4. Remember it → document lessons in failure library

Weekly:
  1. Review failure library entries
  2. Identify recurring patterns
  3. Update MEMORY.md with insights
  4. Simplify or consolidate skill references
```

## Review Schedule

| Frequency | Action |
|-----------|--------|
| After every task | Record notable outcomes |
| Daily | Update daily memory |
| Weekly | Review failures, update MEMORY.md |
| Per-project | Update project-specific memory |
| On-demand | When user says "remember this" |