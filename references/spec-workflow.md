# SPEC Workflow — Phase-by-Phase Guide

## Overview

The SPEC workflow is the backbone of this skill. Inspired by the Claude Code `/feature-dev` plugin, it enforces a discipline: **凝固需求 → 设计确认 → 任务分解 → 实施 → 评审**。

```
Phase 1: Clarify     Phase 2: SPEC Doc    Phase 3: Architecture    Phase 3.5: Tasks
  ↓                    ↓                      ↓                         ↓
Ask questions   →   Invoke write-a-prd  →   Design 3 paths         →  Decompose into
                                                           (wait for confirmation)    atomic tasks
                                                                                     ↓
Phase 4: Build   →   Phase 5: Quality Gates   →   Phase 6: Self-Reflection
```

## Plan Mode

Plan Mode is a **READ-ONLY** planning state that can be activated at any point during the SPEC workflow. In Plan Mode, you can explore the codebase and design implementation plans, but you **CANNOT modify any files**.

### When to Activate Plan Mode

- After Phase 2 (PRD) when you need to explore the codebase before architecture design
- After Phase 3 (Architecture) when you need deeper codebase exploration
- When the task involves complex refactoring and you need to understand dependencies first
- When user explicitly asks to "plan only" or "don't modify anything yet"

### Plan Mode Rules (CRITICAL)

```
=== READ-ONLY MODE - NO FILE MODIFICATIONS ===

You are STRICTLY PROHIBITED from:
- Creating new files (no Write, touch, or file creation of any kind)
- Modifying existing files (no Edit operations)
- Deleting files (no rm or deletion)
- Moving or copying files (no mv or cp)
- Creating temporary files anywhere, including /tmp
- Using redirect operators (>, >>, |) or heredocs to write to files
- Running ANY commands that change system state (no git add/commit/push, npm install, etc.)

Your role is EXCLUSIVELY to explore and plan. You do NOT have access to file editing tools.
```

### Plan Mode Process

```
1. Explore Codebase
   - Find existing patterns and conventions
   - Understand current architecture
   - Identify similar features as reference
   - Trace through relevant code paths

2. Design Solution
   - Create implementation approach
   - Consider trade-offs and architectural decisions
   - Follow existing patterns where appropriate

3. Output Plan
   - Step-by-step implementation strategy
   - Critical files list (3-5 files most important)
   - Dependencies and sequencing
   - Potential challenges
```

### Plan Mode Output Template

```markdown
## Implementation Plan

### Overview
[Brief summary of the implementation approach]

### Architecture Approach
[High-level design decisions]

### Step-by-Step Plan
1. [Step 1 with file references]
2. [Step 2 with file references]
3. ...

### Critical Files for Implementation
- path/to/file1.ts — [why critical]
- path/to/file2.ts — [why critical]
- path/to/file3.ts — [why critical]

### Dependencies & Risks
- **Dependencies**: [what needs to happen first]
- **Risks**: [potential challenges]
- **Alternatives considered**: [other approaches and why not chosen]

---

⚠️ **Plan Mode Active** — No files have been modified. 
Reply "proceed" or "exit plan mode" to continue with implementation.
```

### Exiting Plan Mode

After presenting the plan:
1. State clearly: "Plan Mode is active. No files have been modified."
2. Ask for explicit confirmation: "Should I proceed with implementation?"
3. Only after user confirms, exit Plan Mode and continue to Phase 4

**If user wants modifications to the plan**: Stay in Plan Mode, update the plan, ask for confirmation again.

## Phase 1 — Requirement Clarification

### ⚠️ CRITICAL: This Phase Has TWO Mandatory Parts

---

### Part A: Context Analysis (FIRST - Before Questions)

**You MUST do this before asking any questions:**

1. **Read project manifest** (package.json, pyproject.toml, go.mod, pom.xml, Cargo.toml)
   - What framework and version is used?
   - What are the main dependencies?

2. **Check existing patterns** (read 3-5 relevant source files)
   - What's the code style? (imports, naming, formatting)
   - What's the error handling pattern?
   - What's the testing pattern?
   - What directory structure is used?

3. **THEN ask contextual questions** based on what you learned

---

### Part B: Standard Clarifying Questions (ALWAYS)

Ask these basics first:

**Scope:**
- What is explicitly in scope? What is NOT in scope?
- Should this replace existing implementation or add to it?
- Minimum viable scope for first iteration?

**Success:**
- How will you know it's done correctly?
- What does "done" look like?
- Any specific acceptance tests?

**Constraints:**
- Any deadline or time pressure?
- Tech stack restrictions?
- Team conventions to follow?

---

### Part C: Contextual Questions (Based on Project Analysis)

**After analyzing the project, ask specific questions like:**

#### For Web Frontend Projects
- "I see you're using React 19. Should I use Server Components or Client Components for this?"
- "Your project uses Tailwind. Should I follow the existing utility patterns?"
- "Is this page for authenticated users or public?"

#### For Backend/API Projects
- "Your project uses FastAPI. Should I follow the existing dependency injection pattern?"
- "I see you use SQLAlchemy. Should I follow the repository pattern?"
- "Should this be a new endpoint or extend an existing one?"

#### For Python Projects
- "Your project uses Pydantic v2. Should I use the new validator syntax?"
- "Should I use async (FastAPI) or sync (Flask) for this?"

#### For Java/Spring Projects
- "Should this be a @Service or @Component?"
- "Your project uses Spring Boot 3. Should I use jakarta.* namespaces?"

#### For Mobile Projects
- "Should this be in a new screen or added to an existing one?"
- "Does this need offline support?"

#### For Data/ML Projects
- "What's the expected data volume?"
- "Should this run synchronously or as a background job?"

---

### Part D: Divergent Thinking (Go Beyond Obvious)

Ask to uncover hidden requirements:

| Category | Questions |
|----------|-----------|
| **Edge Cases** | What happens when input is empty / network fails / user is unauthorized? |
| **Error Handling** | What should happen when something goes wrong? |
| **Scale** | How many users/data items? Expected response time? |
| **Security** | What data is sensitive? Any compliance (GDPR, HIPAA)? |
| **Future** | Will this need extension? Planned features that should influence design? |

---

### Part E: UI/UX Discovery (MANDATORY for UI Tasks)

⚠️ **THIS IS NOT OPTIONAL. You MUST do this for ANY task with a user interface.**

#### Step 1: Ask Visual Style (MUST)

Send this EXACTLY:

```
🎨 Visual Style Selection

Before I generate the PRD, please confirm the visual style:

**Option A: Glassmorphism (玻璃拟态)**
Translucent panels, frosted glass effect, blurred backgrounds
Best for: Modern dashboards, premium UIs

**Option B: Flat (扁平化)**
Clean, minimal, solid colors, no gradients
Best for: Content-heavy sites, apps

**Option C: Neumorphism (新拟态)**
Soft shadows, subtle 3D, raised/pressed effects
Best for: Widgets, interactive elements

**Option D: Minimal (极简)**
Maximum whitespace, essential elements only
Best for: Landing pages, portfolios

**Option E: Brutalist**
Raw, bold, high contrast, stark typography
Best for: Creative sites, strong statements

**[Your style]: _______________**
(Describe if you have a specific vision)

Reply with A, B, C, D, E or describe your style.
```

#### Step 2: Ask Layout (MANDATORY)

After style is confirmed, send:

```
📐 Layout Structure

**Option A: Sidebar + Main**
┌──────────┬──────────────────────┐
│          │                      │
│ Sidebar  │     Main Content     │
│          │                      │
└──────────┴──────────────────────┘
Best for: Dashboards, admin panels, apps

**Option B: Header + Content + Footer**
┌────────────────────────────────────┐
│              Header                │
├────────────────────────────────────┤
│                                    │
│           Main Content             │
│                                    │
├────────────────────────────────────┤
│              Footer                │
└────────────────────────────────────┘
Best for: Marketing pages, documentation

**Option C: Two-Column**
┌─────────────┬──────────────────────┐
│  Panel 1    │      Panel 2         │
└─────────────┴──────────────────────┘
Best for: Settings, comparisons

**Option D: Full-Screen**
┌────────────────────────────────────┐
│                                     │
│         Full Content               │
│                                     │
└────────────────────────────────────┘
Best for: Single-purpose tools

**[Your layout]: _______________**

Reply with A, B, C, D or describe your layout.
```

#### Step 3: Confirm Before Proceeding

⚠️ **DO NOT PROCEED to Phase 2 until user confirms BOTH:**
- [ ] Visual Style selected
- [ ] Layout Structure selected

If user doesn't respond to either, remind them:
> "I need both visual style and layout to proceed with the PRD. Which option works for you?"

---

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

### Divergent Thinking Questions (Extended)

**Go beyond the obvious — ask these to uncover hidden requirements:**

#### Edge Cases & Error Handling
- What happens when [input is empty / network fails / user is unauthorized]?
- What's the worst case scenario this should handle?
- Are there any data limits (max file size, max items, max length)?
- What should happen when something goes wrong?

#### User Experience
- Who are the end users? (technical vs non-technical)
- What's their primary workflow? (daily use vs occasional)
- What would frustrate them?
- What would delight them?

#### Performance & Scale
- How many users/data items will this handle?
- What's the expected response time?
- Is this a hot path or a rare operation?

#### Security & Privacy
- What data is sensitive?
- Who should have access?
- Any compliance requirements? (GDPR, HIPAA, etc.)

#### Maintenance & Evolution
- Will this need to be extended later?
- Are there planned future features that should influence design?
- Who will maintain this code?

#### Integration & Dependencies
- What external services does this depend on?
- What happens if those services are down?
- Are there version constraints?

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
5. **UI/UX Design Direction** — For any UI-related task, this section is MANDATORY
6. **Acceptance Criteria** — Specific, testable conditions
7. **Open Questions** — Things we don't know yet

### UI/UX Design Direction (Section 5)

**This section is MANDATORY for any task that creates or modifies a user interface.**

Fill in ALL applicable items:

```markdown
## UI/UX Design Direction

### Visual Style
- **Design Language**: [玻璃拟态 / 新拟态 / 扁平化 / 极简主义 / Material Design / ...]
- **Color Palette**:
  - Primary: [color code or reference]
  - Secondary: [color code or reference]
  - Accent: [color code or reference]
  - Background: [color code or reference]
- **Typography**:
  - Heading font: [font name]
  - Body font: [font name]
  - Font sizes: [h1, h2, body, small]

### Layout & Structure
- **Window/Page Layout**: [single window / multi-panel / dashboard / ...]
- **Navigation**: [sidebar / tabs / breadcrumb / ...]
- **Responsive**: [desktop-only / adaptive / ...]

### Key UI Components
List the main UI elements this feature needs:
- [ ] [Component 1]: [description]
- [ ] [Component 2]: [description]
- [ ] ...

### Interaction & Animation
- **Hover states**: [subtle glow / color shift / scale / ...]
- **Transitions**: [fade / slide / scale / ...]
- **Animation timing**: [fast 150ms / medium 300ms / slow 500ms]

### Design Reference
- **Reference links/screenshots**: [paste URLs or describe]
- **Do NOT use**: [styles to avoid]

### Accessibility (if applicable)
- [ ] High contrast support
- [ ] Keyboard navigation
- [ ] Screen reader friendly
- [ ] [Other requirements]
```

**Important**: If user mentioned a specific design style (e.g., "玻璃拟态", "glassmorphism"), it MUST be recorded here and traced through to implementation. Do NOT lose this information.

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

**UI/UX Implementation** (if applicable):
How this path implements the UI/UX Design Direction from Phase 2:
- Visual style: [how to achieve the specified design language]
- Key components: [which files/components implement each UI element]
- Design reference trace: [confirms/updates the design reference from PRD]
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

### Task Decomposition (MANDATORY)

After user confirms the architecture path, decompose the implementation into **granular, verifiable tasks**.

#### Task Decomposition Rules

1. **Each task must be atomic** — one clear deliverable
2. **Each task must have a verification method** — how to confirm it's done
3. **Tasks must be ordered by dependency** — what needs to happen first
4. **Tasks must be time-boxed** — realistic time estimate
5. **No task should exceed 30 minutes** — if larger, split it

#### Task Decomposition Template

```markdown
## Task Breakdown

### Phase 1: Foundation
| Task | Description | Time | Verification |
|------|-------------|------|--------------|
| T1 | [What to do] | 5m | [How to verify] |
| T2 | [What to do] | 10m | [How to verify] |

### Phase 2: Core Implementation
| Task | Description | Time | Verification |
|------|-------------|------|--------------|
| T3 | [What to do] | 15m | [How to verify] |
| T4 | [What to do] | 10m | [How to verify] |

### Phase 3: Polish & Testing
| Task | Description | Time | Verification |
|------|-------------|------|--------------|
| T5 | [What to do] | 5m | [How to verify] |
| T6 | [What to do] | 10m | [How to verify] |

**Total Estimated Time:** [sum]

**Critical Path:** T1 → T2 → T3 → T4 → T5 → T6
```

#### Verification Methods (choose appropriate)

| Method | When to Use | Example |
|--------|-------------|---------|
| **Test passes** | Logic/API code | `pytest test_auth.py -v` passes |
| **Build succeeds** | Configuration/structure | `npm run build` exits 0 |
| **File exists** | File creation | `test -f src/main.py` |
| **Visual check** | UI implementation | Screenshot matches design reference |
| **Manual test** | End-to-end flow | Run app, complete user journey |
| **Lint clean** | Code quality | `ruff check .` returns no errors |
| **Type check** | Type safety | `mypy .` returns no errors |
| **Feature works** | Functional requirement | User can log in successfully |

#### Example: Desktop Translation App

```markdown
## Task Breakdown

### Phase 1: Foundation
| Task | Description | Time | Verification |
|------|-------------|------|--------------|
| T1 | Create project structure (main.py, requirements.txt) | 3m | `python main.py` runs without error |
| T2 | Setup UI framework (PyQt/CustomTkinter) | 5m | Empty window opens |
| T3 | Implement window layout (input/output panels) | 10m | Screenshot matches wireframe |

### Phase 2: Core Implementation
| Task | Description | Time | Verification |
|------|-------------|------|--------------|
| T4 | Integrate translation API | 10m | Manual test: "hello" → "你好" |
| T5 | Add language selection (source/target) | 5m | Dropdown shows language list |
| T6 | Connect UI to translation logic | 10m | Click translate → result appears |

### Phase 3: UI Polish (玻璃拟态)
| Task | Description | Time | Verification |
|------|-------------|------|--------------|
| T7 | Apply glassmorphism background | 10m | Visual check: blur + transparency |
| T8 | Style input/output areas | 5m | Visual check: glass effect |
| T9 | Add hover/transition animations | 5m | Visual check: smooth transitions |

### Phase 4: Testing & Polish
| Task | Description | Time | Verification |
|------|-------------|------|--------------|
| T10 | Build to .exe | 5m | `.exe` file runs on Windows |
| T11 | End-to-end test | 5m | Full translation workflow works |
| T12 | Final visual review | 3m | Matches design reference |

**Total Estimated Time:** 76 minutes

**Critical Path:** T1 → T2 → T3 → T4 → T5 → T6 → T7 → T8 → T9 → T10 → T11 → T12
```

#### Task Execution Protocol

For each task:

1. **Announce**: "Starting T1: [description]"
2. **Execute**: Implement the task
3. **Verify**: Run the verification method
4. **Report**: 
   - ✅ "T1 complete: [verification result]"
   - ❌ "T1 blocked: [issue], need [help/decision]"
5. **Proceed**: Only move to next task after verification passes

**If verification fails**: Stop, fix, re-verify. Do not proceed to next task.

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

### UI Implementation Tracking (if applicable)

For tasks with UI/UX Design Direction, maintain a parallel TODO list:

```markdown
## UI Implementation TODO
- [ ] UI-1: Main window layout (玻璃拟态 style)
- [ ] UI-2: Color palette applied (Primary: #xxx, Secondary: #xxx)
- [ ] UI-3: Typography setup (Heading: FontA, Body: FontB)
- [ ] UI-4: Hover animations (150ms ease-out)
- [ ] UI-5: Accessibility features
- [ ] UI-6: Final visual review against design reference
```

**Before marking UI task complete**: Verify all UI/UX Design Direction items from Phase 2 are implemented.

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
