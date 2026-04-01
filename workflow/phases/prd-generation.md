# PRD Generation Phase

> Phase 3: Product Requirements Document

## Purpose

Transform requirements into detailed product requirements document.

## Input

- Clear requirements (from Clarify/Brainstorming)

## Output

- PRD document

---

## PRD Structure

### 1. Product Overview

- Product name
- Product positioning
- Target users

---

### 2. Problem Statement

- User pain points
- Solution value

---

### 3. Goals & Non-Goals

**Goals**:
- [ ] Goal 1
- [ ] Goal 2

**Non-Goals**:
- Things NOT included

---

### 4. User Stories

```
As a [role]
I want [feature]
So that [value]
```

---

### 5. Feature Requirements

| Feature | Priority | Description |
|---------|----------|-------------|
| Feature 1 | P0 | Description |
| Feature 2 | P1 | Description |
| Feature 3 | P2 | Description |

---

### 6. Non-Functional Requirements

| Type | Requirement |
|------|-------------|
| Performance | Response time < 200ms |
| Security | Data encrypted at rest |
| Availability | 99.9% uptime |

---

### 7. Acceptance Criteria

- [ ] Criteria 1
- [ ] Criteria 2
- [ ] Criteria 3

---

## Output Format

```markdown
# Product Requirements Document: [Product Name]

## 1. Product Overview

**Product Name**: [name]
**Positioning**: [one-line positioning]
**Target Users**: [user persona]

## 2. Problem Statement

**Pain Points**: [user pain points]
**Solution**: [solution description]

## 3. Goals & Non-Goals

### Goals
- [ ] [Goal 1]
- [ ] [Goal 2]

### Non-Goals
- [Non-goal 1]

## 4. User Stories

### Story 1
**As a** user
**I want** to create a task
**So that** I can track todos

**Acceptance Criteria**:
- [ ] Can enter task title
- [ ] Task auto-saves
- [ ] Shows in task list

## 5. Feature Requirements

| ID | Feature | Priority | Description |
|----|---------|----------|-------------|
| F1 | Create task | P0 | User can create new task |
| F2 | Complete task | P0 | User can mark task complete |
| F3 | Delete task | P1 | User can delete task |
| F4 | Edit task | P1 | User can modify task |

## 6. Non-Functional Requirements

| Type | Requirement |
|------|-------------|
| Performance | First screen < 2s |
| Security | XSS protection |
| Compatibility | Chrome, Firefox, Safari |

## 7. Acceptance Criteria

- [ ] All P0 features implemented
- [ ] Test coverage ≥ 80%
- [ ] No high priority bugs
- [ ] Documentation complete

## 8. Appendix

### Technical Approach
[technology choices]

### Timeline
[milestones]
```

---

## Deliverables

- **Location**: `./docs/PRD-YYYY-MM-DD.md`
