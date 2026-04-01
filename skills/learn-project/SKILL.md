---
name: learn-project
description: Use when needing to understand an existing codebase - cloned repos, inherited projects, or any code you didn't write
---

# Learn Project

Understand existing codebases efficiently. For reading, not modifying.

## When to Use

- Just cloned a GitHub repository
- Inherited a project from another team
- Coming back to old code you forgot
- Need to understand before modifying
- Code review preparation

## When NOT to Use

- Ready to implement changes → Use appropriate workflow (Bug Fix, Feature, etc.)
- New project from scratch → Greenfield workflow
- Quick fix → Quick Fix workflow

## Output

`LEARN.md` documenting:
- Project overview
- Architecture
- Key files and their purposes
- Data flow
- Dependencies
- Gotchas and quirks

Saved to both `{SKILL_ROOT}/docs/{date}/{project}/LEARN.md` and `{PROJECT_ROOT}/docs/LEARN.md`.

## Flow

```
Surface Scan → Deep Dive → Map Architecture → Document
```

## Steps

### 1. Surface Scan (5 min)

Get the big picture:

**Read first:**
- `README.md` - Project description
- `package.json` / `pyproject.toml` / etc. - Dependencies, scripts
- Top-level directory structure
- `.gitignore` - What's excluded (reveals tech stack)

**Answer:**
- What does this project do?
- What tech stack?
- How to run it?
- How to test it?

### 2. Deep Dive (15-30 min)

Understand the code:

**Entry points:**
- `main()` / `index.js` / `app.py`
- API routes / Controllers
- CLI commands

**Core modules:**
- Follow imports from entry points
- Identify key business logic files
- Find data models / schemas

**Patterns:**
- How is code organized? (MVC, layered, etc.)
- Naming conventions
- Error handling patterns
- Testing patterns

**Questions to answer:**
- Where does data come in?
- How does it flow through?
- Where does it go out?
- What are the side effects?

### 3. Map Architecture (10 min)

Create mental model:

**Draw/Write:**
```
[Input] → [Parser] → [Business Logic] → [Storage]
         ↓
    [Side Effects]
```

**Identify:**
- Layers and their responsibilities
- Key abstractions
- Integration points
- Configuration sources

### 4. Document

Write `LEARN.md`:

```markdown
# Project: {name}

## Overview
One-paragraph description of what this does.

## Tech Stack
- Language:
- Framework:
- Database:
- Key libraries:

## Architecture
[ASCII diagram or description]

## Key Files
| File | Purpose |
|------|---------|
| `src/main.js` | Entry point |
| `src/api/` | API routes |
| `src/models/` | Data models |

## Data Flow
1. Request comes in via...
2. Routed to...
3. Processed by...
4. Stored in...

## Dependencies
- External services:
- Internal modules:

## Gotchas
- [ ] Thing that surprised you
- [ ] Non-obvious behavior
- [ ] Setup requirements

## How to Run
```bash
npm install
npm run dev
```

## How to Test
```bash
npm test
```
```

## Depth Levels

Choose based on need:

| Level | Time | When |
|-------|------|------|
| **Quick** (30 min) | Surface scan + key files | Need basic understanding |
| **Standard** (1-2 hr) | Full flow above | Before making changes |
| **Deep** (half day) | Everything + tests | Critical system, high stakes |

## Tips

- **Don't run code yet** - understand first
- **Follow the data** - easiest path to understanding
- **Skip details** - focus on structure, not every line
- **Ask questions** - document what you don't understand
- **Check tests** - they show intended behavior

## After Learning

Once you understand the project:
- Ready for Bug Fix? → Use Bug Fix workflow
- Ready for Feature? → Use Feature Enhancement workflow
- Just documenting? → Done
