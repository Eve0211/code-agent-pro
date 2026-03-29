# Mature Project Workflow

> Add feature or fix bug in existing codebase

## Trigger Conditions

- Existing project - User provided project path
- Need code analysis - Uncertain about code structure
- Default selection - When other workflows don't match

## Workflow Overview

```
clarify → codebase-analysis → prd-generation → architecture-design → task-decomposition → implementation → quality-gates → self-reflection
```

**8 phases**

---

## Phase Details

### Phase 1: Clarify

Understand what user wants.

**Questions**:
- What do you want to do? (Feature/fix/optimization)
- What is the goal?
- Any constraints?

---

### Phase 2: Codebase Analysis

Deep understanding of existing project.

**Analysis Content**:

| Dimension | Items |
|-----------|-------|
| Architecture | Project structure, patterns |
| Tech Stack | Language, framework, deps |
| Entry Points | Main entry, core flows |
| Testing | Framework, coverage |
| Documentation | README, API docs |
| Recent Changes | Git history, active modules |

---

### Phase 3: PRD Generation

Write detailed requirements.

**Content**:
- Feature description
- User stories
- Technical approach
- Impact scope assessment

---

### Phase 4: Architecture Design

Design implementation approach.

**Content**:
- Module design
- Interface design
- Integration with existing system
- Migration plan (if needed)

---

### Phase 5-8

Task Decomposition → Implementation → Quality Gates → Self-Reflection

(Same as Feature Enhancement)

---

## Difference from Feature Enhancement

| Aspect | Mature Project | Feature Enhancement |
|--------|----------------|---------------------|
| Trigger | Default selection | Clear feature request |
| Code Analysis | More comprehensive | Targeted analysis |
| Flexibility | High | Medium |
