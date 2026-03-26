# Memory System

## Session Startup Checklist

Every new session, in order:

1. Read `MEMORY.md` — curated long-term memory
2. Read `memory/YYYY-MM-DD.md` for today and yesterday
3. Check for project-specific memory (`.claude/memory/`, `memory/`)
4. Load codebase conventions from `CLAUDE.md` or equivalent

## Memory Layer Architecture

```
┌─────────────────────────────────────────────────────────┐
│  Session Memory (in context window)                      │
│  - Current conversation history                          │
│  - Active task context                                  │
│  - Immediate code references                             │
├─────────────────────────────────────────────────────────┤
│  Working Memory (read/write during session)              │
│  - memory/YYYY-MM-DD.md (daily logs)                    │
│  - Project .claude/memory/ (if present)                 │
├─────────────────────────────────────────────────────────┤
│  Long-term Memory (curated, less-frequently updated)    │
│  - MEMORY.md                                            │
│  - User preferences (from MEMORY.md or user profile)     │
├─────────────────────────────────────────────────────────┤
│  Codebase Memory (from files)                            │
│  - CLAUDE.md (project conventions)                      │
│  - .claude/rules/ (contextual rules)                    │
│  - Package manifests (package.json, pyproject.toml)       │
└─────────────────────────────────────────────────────────┘
```

## Project Context Memory

Store in project memory directory (`.claude/memory/` or `memory/`):

### Architecture Notes
- System design decisions and rationale
- Key abstractions and their responsibilities
- Dependency graph (what depends on what)
- Integration points with external services

### Pattern Library
- Idiomatic patterns used in this codebase
- Standard approaches for common tasks
- Anti-patterns to avoid
- Naming conventions specific to this project

### Build & Dev Workflow
- How to build the project
- How to run tests
- Common gotchas or quirks
- Environment setup requirements

## Session State Management

### What to Record During Session

**Every session:**
```markdown
## Session: YYYY-MM-DD

### Tasks Completed
- [task]: [outcome]
- [task]: [outcome]

### Key Decisions
- [decision]: [rationale]
- [decision]: [rationale]

### Lessons Learned
- [insight]
- [insight]

### Follow-up
- [ ] [pending task]
```

**After significant work (>30 min on a task):**
- Record the final state of modified files
- Note any trade-offs made during implementation
- Update architecture notes if new patterns emerged

## Knowledge Graph Construction

### When to Build a Graph

Build a knowledge graph when working on a new or unfamiliar codebase area. The graph helps with:
- Understanding dependencies before making changes
- Finding the right place to add new code
- Identifying ripple effects of changes

### Graph Format

```markdown
## Knowledge Graph: [Area]

### Entities
- UserService — manages user lifecycle, depends on DB, AuthService
- AuthService — handles authentication, depends on TokenStore
- TokenStore — stores/retrieves tokens, depends on Redis

### Relationships
- UserService → uses → AuthService
- AuthService → uses → TokenStore
- API Handler → uses → UserService

### Entry Points
- POST /auth/login → AuthService.login()
- GET /users/:id → UserService.getById()

### Key Files
- src/services/UserService.ts:45 — UserService implementation
- src/services/AuthService.ts:12 — AuthService implementation
```

## Context Window Optimization

### Prioritization Strategy

When context window is filling up, prioritize keeping:
1. Current task's relevant code files
2. Recent decisions and their rationale
3. User preferences and constraints
4. Test results and quality gate outputs

Drop or compress:
1. Old exploration trails that didn't lead anywhere
2. Repeated similar code snippets
3. Verbose explanations of obvious things
4. Very old conversation turns unrelated to current task

### Compression Techniques

**File summarization**: Instead of full file content, keep:
- A brief description of what the file does
- Key functions and their signatures
- Where the file fits in the architecture

**Decision compression**: Instead of full discussion, keep:
- Decision made
- Rationale (1 sentence)
- Files affected

**Test result compression**: Instead of full test output, keep:
- Pass/fail summary
- Key failures (stack traces → one-line descriptions)

### Trigger Points for Context Cleanup

- After Phase 3 (architecture design): compress exploration notes
- After Phase 5 (quality gates): compress test output
- When the conversation reaches ~30 turns: proactively summarize

## What NOT to Remember

- Temporary debugging code or experiments
- Failed approaches that are obviously wrong
- Information that can be easily re-discovered
- Secrets, credentials, or sensitive data

## Memory Update Triggers

Update memory when:
- A significant decision is made (new architecture, library choice)
- A non-obvious pattern is discovered
- User expresses a preference
- A failure occurs and the lesson is clear
- Working on a codebase for the first time
- Completing a multi-session task
