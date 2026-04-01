# Clarify Phase

> Phase 1: Requirement Clarification

## Purpose

Understand what user really wants, clarify requirements scope.

## Input

- User's original request
- Context information

## Output

- Clear requirements document

---

## Execution Steps

### Step 1: Analyze Request

- Identify core request
- Extract key information
- Find ambiguities

### Step 2: Ask Questions

**Required Questions**:

| Question | Purpose |
|----------|---------|
| What do you want to build? | Understand core functionality |
| Who are target users? | Define user persona |
| What are core features? | Define MVP scope |
| What are success criteria? | Define acceptance conditions |
| Any time/budget constraints? | Understand limitations |

**Optional Questions**:
- Any reference products?
- Technology preferences?
- Non-functional requirements?

### Step 3: Confirm Understanding

- Restate requirements
- Get user confirmation
- Record clarification results

---

## Output Format

```markdown
## Requirements Confirmation

**Original Request**: [user's original words]

**Core Features**:
1. [Feature 1]
2. [Feature 2]
3. [Feature 3]

**Target Users**: [user persona]

**Success Criteria**:
- [ ] Criteria 1
- [ ] Criteria 2
- [ ] Criteria 3

**Constraints**:
- Time: [constraints]
- Technology: [constraints]
- Other: [constraints]

**Pending**:
- [ ] Question 1
- [ ] Question 2
```

---

## Deliverables

- **Location**: `./docs/SPEC-YYYY-MM-DD.md`
- **Naming**: `SPEC-YYYY-MM-DD.md`

---

## Notes

1. **Don't assume** - Ask if unsure
2. **Iterate gradually** - Breadth first, then depth
3. **Record process** - Keep conversation history
4. **Confirm early** - Avoid misunderstanding

---

## Relationship with Brainstorming

- Clarify is Brainstorming's Step 0
- Clarify requirements first, then brainstorm
- If requirements are too vague, invoke prompt-optimizer
