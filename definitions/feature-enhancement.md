# Feature Enhancement Workflow

> Incremental path for adding features to existing projects

## Trigger Conditions

- Feature keywords: "add feature", "new feature", "extend", "enhance"
- Enhancement request: "I want to add a xxx feature"
- Iterative development: Adding new capabilities to existing project

## Workflow Overview

```
clarify → codebase-analysis → prd-generation → architecture-design → task-decomposition → implementation → quality-gates → self-reflection
```

**8 phases**

---

## Phase Details

### Phase 1: Clarify

Understand what feature to add.

**Key Questions**:
- What is the feature description?
- What is the user scenario?
- Relationship with existing features?
- Priority?
- Technical constraints?

---

### Phase 2: Codebase Analysis

Understand existing code structure.

**Analysis Dimensions**:
- Architecture - Existing patterns
- Entry points - Where to extend
- Dependencies - Module relationships
- Style - Code conventions

---

### Phase 3: PRD Generation

Write feature requirements.

**Content**:
- Feature description
- User stories
- Acceptance criteria
- Technical approach
- Impact scope

---

### Phase 4: Architecture Design

Design implementation approach.

**Content**:
- Module design
- Interface design
- Database changes (if needed)
- Integration with existing system

---

### Phase 5: Task Decomposition

Break into executable tasks.

**Principles**:
- Follow existing code style
- Reuse existing components
- Minimal change scope

---

### Phase 6: Implementation

Write feature code.

**Flow**:
1. Write tests
2. Implement feature
3. Integration testing
4. Commit

---

### Phase 7: Quality Gates

Verify feature quality.

**Checklist**:
- [ ] Feature works correctly
- [ ] No regression
- [ ] Test coverage
- [ ] Matches existing style

---

### Phase 8: Self-Reflection

Summarize development experience.

---

## Comparison with Other Workflows

| Aspect | Feature | Greenfield | Bug Fix |
|--------|---------|------------|---------|
| Phases | 8 | 11 | 5 |
| Code Analysis | Required | Not needed | Required |
| PRD | Required | Required | Skip |
| Architecture | Required | Required | Skip |
