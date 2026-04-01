# Learn Project Workflow

**When to use:** Just cloned, inherited, or need to understand an unfamiliar project.

**Duration:** ~30 minutes

**Goal:** Build a mental model of the project quickly, generating a permanent reference document.

---

## Quick Routing Check

Before starting, confirm:
- [ ] This is an unfamiliar project (not one you've worked on extensively)
- [ ] User wants to understand the codebase, not implement a specific feature

If user has a specific task in mind, route to the appropriate workflow instead.

---

## Phase 1: Surface Scan (3 min)

### Actions

1. **Detect project type** from manifest:
   - `package.json` → Node.js/React/Vue/Next.js
   - `pyproject.toml` / `requirements.txt` → Python
   - `go.mod` → Go
   - `Cargo.toml` → Rust
   - `pom.xml` / `build.gradle` → Java/Kotlin

2. **List directory structure:**
   ```
   Find top-level directories
   Identify: src/, tests/, docs/, config/
   Note any unusual structure
   ```

3. **Check framework versions:**
   - Read manifest for dependency versions
   - Note any deprecated or outdated dependencies

### Output

```markdown
## Project Overview

- **Type:** [Web API / Frontend / CLI / Library / etc.]
- **Tech Stack:** [Framework + version, language + version]
- **Size:** [Number of files, approximate lines of code]
- **Structure:** [Brief description of directory layout]
```

---

## Phase 2: Entry Point Trace (5 min)

### Actions

1. **Find entry points:**
   - Web: `main()`, `app.js`, `index.tsx`, routes
   - CLI: argument parser, command handlers
   - Library: public exports

2. **Trace startup sequence:**
   - What runs first?
   - What gets initialized?
   - What configuration is loaded?

3. **Identify API surface:**
   - REST endpoints
   - GraphQL resolvers
   - Public functions/classes

### Output

```markdown
## Entry Points

| Entry | Location | Purpose |
|-------|----------|---------|
| [name] | path/to/file | [what it does] |

## Startup Sequence
1. [Step 1]
2. [Step 2]
3. [Step 3]
```

---

## Phase 3: Core Flow Deep Dive (10 min)

### Actions

1. **Pick 1-2 main workflows** (user registration, data processing, etc.)

2. **Trace end-to-end:**
   - From entry point to database/external service
   - Note all layers crossed
   - Identify key abstractions

3. **Document the happy path:**
   - What happens on success?
   - What are the main transformations?

### Output

```markdown
## Core Workflows

### [Workflow Name]

```
Request → Handler → Service → Repository → Database
    ↓
Validation → Business Logic → Response
```

**Key files:**
- `path/to/handler.ts` — receives request
- `path/to/service.ts` — business logic
- `path/to/repository.ts` — data access
```

---

## Phase 4: Pattern Extraction (5 min)

### Actions

1. **Code style:**
   - Indentation, naming conventions
   - Import organization
   - File structure patterns

2. **Testing patterns:**
   - Test framework used
   - Test file location
   - Mocking approach

3. **Error handling:**
   - How errors are caught
   - How errors are reported
   - Custom error classes

4. **Logging:**
   - Logger used
   - Log format
   - Log levels

### Output

```markdown
## Conventions

| Aspect | Pattern |
|--------|---------|
| Naming | [camelCase/Pascal_case/etc.] |
| Imports | [absolute/relative, grouped by type] |
| Testing | [framework, location pattern] |
| Error Handling | [try-catch/Result type/etc.] |
| Logging | [winston/pino/console, format] |
```

---

## Phase 5: Generate Project Map (5 min)

### Actions

Write a permanent reference document:

```
{SKILL_ROOT}/docs/{YYYY-MM-DD}/{project-name}/LEARN.md
{PROJECT_ROOT}/docs/LEARN.md
```

### Template

```markdown
# Project Map: {Project Name}

> Quick reference for AI and humans. Generated {YYYY-MM-DD}.

## Quick Facts

- **Type:** [Web API / Frontend / CLI / Library]
- **Tech Stack:** [Framework, language, database]
- **Repo:** [GitHub URL if applicable]

## Architecture

```
[Brief ASCII diagram or description]
```

## Key Directories

| Directory | Purpose |
|-----------|---------|
| `src/` | [description] |
| `tests/` | [description] |

## Entry Points

| Entry | File | Trigger |
|-------|------|---------|
| API | `src/index.ts` | HTTP request |
| CLI | `src/cli.ts` | Command line |

## Core Workflows

### [Workflow 1]
- **Trigger:** [what starts it]
- **Path:** `file1 → file2 → file3`
- **Output:** [what it produces]

## Conventions

- **Naming:** [pattern]
- **Testing:** [framework + location]
- **Error Handling:** [pattern]

## Common Tasks

| Task | Files to Modify |
|------|-----------------|
| Add API endpoint | `src/routes/`, `src/services/` |
| Add database table | `src/models/`, `src/migrations/` |
| Add test | `tests/unit/` |

## Gotchas

- [Any non-obvious behavior]
- [Known issues or workarounds]

## External Dependencies

| Dependency | Version | Purpose |
|------------|---------|---------|
| [name] | [version] | [what it does] |
```

---

## Phase 6: Gap Report (2 min)

### Actions

1. **Identify unclear areas:**
   - Code that was hard to trace
   - Patterns that don't make sense
   - Missing documentation

2. **Ask targeted questions:**

```markdown
## Questions for Clarification

1. [Specific question about unclear area]
2. [Specific question about pattern]
3. [Specific question about business logic]
```

**⚠️ DO NOT ask generic questions. Ask specific, contextual questions based on what you observed.**

---

## Blocking Gate

After generating the project map:

```
📚 Project map generated!

Saved to:
- {PROJECT_ROOT}/docs/LEARN.md
- {SKILL_ROOT}/docs/{YYYY-MM-DD}/{project-name}/LEARN.md

⛔ BLOCKING: Reply "confirm" to proceed, or ask questions about unclear areas.
```

---

## Output Document

After user confirms, output the FULL project map to chat so user can review inline.
