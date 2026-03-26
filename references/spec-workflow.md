# SPEC Workflow — Phase-by-Phase Guide

## Overview

The SPEC workflow is the backbone of this skill. Inspired by the Claude Code `/feature-dev` plugin, it enforces a discipline: **凝固需求 → 设计确认 → 实施 → 评审**.

```
Phase 1: Clarify        Phase 2: SPEC Doc    Phase 3: Architecture    Phase 4: Build
  ↓                    ↓                      ↓                         ↓
Ask questions   →   Invoke write-a-prd  →   Design 3 paths         →  User approves
                                                           (wait for confirmation before coding)
  ↓
Phase 5: Quality Gates  →  Phase 6: Self-Reflection
```

## Phase 1 — Requirement Clarification

### When to Stop and Ask

Stop and ask clarifying questions when:
- The request uses vague language ("fast", "good", "modern")
- Multiple valid interpretations exist
- No clear success criteria are mentioned
- Dependencies or constraints are unclear

### Standard Clarifying Questions

**Scope questions:**
- What is explicitly in scope? What is explicitly NOT in scope?
- Should this replace an existing implementation or add to it?
- What's the minimum viable scope for the first iteration?

**Context questions:**
- What does the existing codebase look like for this area?
- Are there existing patterns I should follow?
- What team conventions should I respect?

**Success questions:**
- How will you know this is done correctly?
- Are there specific metrics or acceptance tests?
- What does "done" look like?

**Constraints:**
- Any deadline or time pressure?
- Tech stack restrictions I should work within?
- Any systems this must integrate with?

### When NOT to Ask

If the request is already specific and self-contained (e.g., "fix the null pointer at line 42 of auth.py"), just fix it. Don't force a conversation when not needed.

## Phase 2 — Generate SPEC Document

### How to Use write-a-prd

Invoke the skill with a structured request:

```
Use write-a-prd to generate a formal PRD for this feature.
Feature name: [extracted from user's request]
Problem: [what problem does this solve]
Users: [who benefits]
Key requirements:
  - [P0: must have]
  - [P1: should have]
  - [P2: nice to have]
Success criteria: [how to measure success]
```

### PRD Output to Code Traceability

After the PRD is generated, establish a trace matrix:

```
PRD Section          →  Code Artifact
─────────────────────────────────────────────
FR-1.1 (P0)         →  src/auth/OAuthProvider.ts
FR-1.2 (P1)         →  src/auth/TokenRefresh.ts
FR-2.1 (P0)         →  src/middleware/rateLimit.ts
```

This trace matrix ensures every requirement has a code owner and every code change traces back to a requirement.

### PRD Sections to Fill

At minimum, the SPEC document must include:

1. **Problem Statement** — Why are we doing this? (1-3 sentences)
2. **Goals / Non-Goals** — What yes, what no
3. **User Stories** — Who benefits and how
4. **Functional Requirements** — Numbered with P0/P1/P2 priority
5. **Acceptance Criteria** — Specific, testable conditions
6. **Open Questions** — Things we don't know yet

## Phase 3 — Architecture Design

### Three-Path Design Approach

Design 3 approaches simultaneously, then present:

**Path A — Minimal Changes**
- Goal: Smallest diff, fastest to implement
- Strategy: Extend existing code with minimal additions
- Trade-off: May introduce technical debt

**Path B — Clean Architecture**
- Goal: Best long-term structure
- Strategy: New abstractions, proper interfaces
- Trade-off: More files, more time

**Path C — Pragmatic Balance**
- Goal: Practical compromise
- Strategy: Reasonable abstractions, limited scope
- Trade-off: Some coupling remains

### Architecture Output Format

For each path, provide:

```markdown
### Path [X]: [Name]

**Files to create:** [list]
**Files to modify:** [list]
**Lines of code (est.):** [number]
**Risk:** [Low/Medium/High]
**Time estimate:** [S/M/L]

**Pros:**
- ...

**Cons:**
- ...

**Recommended for:** [use case fit]
```

### Making a Recommendation

After presenting all paths:
1. State which path fits this specific task best
2. Explain why (based on constraints, timeline, codebase state)
3. Ask for explicit user confirmation
4. **Do not write code until the user confirms**

### When Architecture Vetoes the Request

If analysis shows the request is not feasible:
- Explain the technical blockers clearly
- Propose alternatives
- Ask the user to decide

## Phase 4 — Implementation

### Rules During Implementation

1. **Read first, then write.** Read all relevant files before touching them.
2. **One logical unit at a time.** Group related changes together.
3. **Test as you go.** Write tests immediately after the code, not after.
4. **Keep a change log.** Note what you've changed and why.

### Progress Tracking

Use a simple TODO list and update it:

```markdown
## Implementation TODO
- [x] FR-1.1: OAuth provider abstraction
- [x] FR-1.2: Token refresh logic
- [ ] FR-2.1: Rate limiting middleware  ← currently working
- [ ] FR-2.2: Request validation
- [ ] Tests for all FR-1.x
- [ ] Security audit
```

### Convention Enforcement

Follow existing codebase conventions strictly:
- Import ordering
- Naming conventions
- Error handling patterns
- Documentation style

If conventions are absent from the codebase, establish them and document in the SPEC.

## Phase 5 — Quality Gates

### Automatic Checks (Every Change)

```bash
# Format
npm run format / ruff format . / gofmt -w .

# Lint
npm run lint / ruff check . / eslint . / go vet ./...

# Type check
npm run typecheck / mypy . / tsc --noEmit

# Tests
npm test / pytest . / go test ./...

# Build
npm run build / go build ./...
```

### Gate Policy

| Check | P0 | P1 | P2 |
|-------|----|----|-----|
| Build passes | ✅ Must pass | - | - |
| Tests pass | ✅ Must pass | - | - |
| Lint clean | ✅ Must pass | - | - |
| Type check | ✅ Must pass | - | - |
| Security scan | ✅ Must pass | - | - |
| Complexity ≤ 10 | - | Report | Ignore |
| DRY violations | - | Report | Ignore |
| Missing docs | - | Report | Ignore |

### Manual Review Triggers

After quality gates pass, do a manual review pass for:
- Does the code match the SPEC requirements?
- Are there obvious improvements not caught by static analysis?
- Is the code readable by someone unfamiliar with it?

## Phase 6 — Self-Reflection

### Reflection Questions

Before finishing any task:

1. **Clarity**: If I explained this code to a colleague, would they understand it immediately?
2. **Simplicity**: Could any part be simpler without losing functionality?
3. **Completeness**: Are edge cases handled? Error states covered?
4. **Testability**: Can every function be tested in isolation?
5. **Future-proofing**: If requirements change, what breaks?

### Reflection Output

If issues are found during reflection, fix them immediately. If a fix is too large, document it as a follow-up:

```markdown
## Follow-up Issues
- [ ] Refactor UserService to reduce complexity (currently 14, target ≤10)
- [ ] Add integration tests for OAuth flow
- [ ] Document the rate limit configuration options
```

## Emergency Mode

When the user explicitly says "fast", "emergency", "hotfix", or "just do it":
1. Skip Phase 1-3 (spec + architecture design)
2. Go directly to Phase 4 (implementation)
3. Still run Phase 5 (quality gates) — never skip security
4. Document the hotfix rationale
5. Propose a proper spec as a follow-up
