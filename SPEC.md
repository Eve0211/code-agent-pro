# SPEC Workflow - English Version

> Professional code agent workflow with specification-first approach

## Philosophy

**Never code without a spec.** Inspired by Claude Code's `/feature-dev` plugin.

## Workflow Types

| Workflow | Trigger | Phases |
|----------|---------|--------|
| **Greenfield** | New project from scratch | 11 phases |
| **Feature Enhancement** | Add features to existing project | 8 phases |
| **Mature Project** | Complex changes in existing codebase | 8 phases |
| **Bug Fix** | Fix specific bugs | 5 phases |
| **Refactoring** | Code quality improvements | 7 phases |
| **Quick Fix** | Simple, obvious changes | 3 phases |

## Critical Rules

### 1. Blocking Gates
Every phase ends with a **BLOCKING GATE**. You **MUST STOP** and wait for user confirmation before proceeding.

### 2. File Location
- Write all docs to `{PROJECT_ROOT}/docs/`
- `{PROJECT_ROOT}` = directory with manifest file (package.json, pyproject.toml, etc.)

### 3. Output Document Content
After writing any document, **OUTPUT THE FULL CONTENT** to chat.

### 4. Detect Project Type
- React project → MUST use React (never plain HTML)
- Vue project → MUST use Vue
- Next.js project → MUST use Next.js

### 5. UI/UX is Mandatory
- Phase 1 **MUST** ask visual style and layout
- Phase 2 **MUST** show ASCII layout diagram

### 6. Present Options Before Writing
- Phase 3: Present 2-3 architecture options first
- User selects → THEN write SPEC.md

## Index

- [Workflow Definitions](./definitions/)
  - [Greenfield](./definitions/greenfield.md)
  - [Feature Enhancement](./definitions/feature-enhancement.md)
  - [Mature Project](./definitions/mature-project.md)
  - [Bug Fix](./definitions/bug-fix.md)
  - [Refactoring](./definitions/refactoring.md)
  - [Quick Fix](./definitions/quick-fix.md)
- [Phases](./phases/)
  - [Clarify](./phases/clarify.md)
  - [Brainstorming](./phases/brainstorming.md)
  - [Codebase Analysis](./phases/codebase-analysis.md)
  - [PRD Generation](./phases/prd-generation.md)
  - [Plan Mode](./phases/plan-mode.md)
  - [Architecture Design](./phases/architecture-design.md)
  - [Task Decomposition](./phases/task-decomposition.md)
  - [Implementation](./phases/implementation.md)
  - [Quality Gates](./phases/quality-gates.md)
  - [Testing](./phases/testing.md)
  - [Review](./phases/review.md)
  - [Self-Reflection](./phases/self-reflection.md)
