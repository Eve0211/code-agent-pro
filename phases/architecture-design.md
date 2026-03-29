# Architecture Design Phase

> Phase 5: Design System Architecture

## Purpose

Design system architecture, determine technical approach.

## Input

- PRD / Requirements document
- Code analysis report (if available)

## Output

- Architecture design document
- 3 architecture options

---

## Design Methods

### Three Architecture Paths

| Path | Characteristics | Use Cases |
|------|---------------|-----------|
| **Minimal** | Minimal changes, max reuse | Fast iteration, POC |
| **Clean** | Proper abstraction, testable, maintainable | Long-term projects, team collaboration |
| **Pragmatic** | Balance speed and quality | Most scenarios |

---

### Design Principles

1. **SOLID Principles**
   - Single Responsibility
   - Open/Closed
   - Liskov Substitution
   - Interface Segregation
   - Dependency Inversion

2. **DRY** - Don't Repeat Yourself
3. **KISS** - Keep It Simple
4. **YAGNI** - You Aren't Gonna Need It

---

## Design Content

### 1. System Architecture Diagram

```
┌─────────────┐     ┌─────────────┐
│   Frontend  │────▶│   Backend   │
└─────────────┘     └─────────────┘
                           │
                           ▼
                    ┌─────────────┐
                    │  Database   │
                    └─────────────┘
```

---

### 2. Module Breakdown

| Module | Responsibility | Dependencies |
|--------|---------------|--------------|
| Auth | Authentication | User, Session |
| User | User management | - |
| ... | ... | ... |

---

### 3. Interface Design

```typescript
interface UserService {
  getUser(id: string): Promise<User>;
  createUser(data: CreateUserDTO): Promise<User>;
  updateUser(id: string, data: UpdateUserDTO): Promise<User>;
  deleteUser(id: string): Promise<void>;
}
```

---

### 4. Data Model

```typescript
interface User {
  id: string;
  email: string;
  name: string;
  createdAt: Date;
  updatedAt: Date;
}
```

---

### 5. Technology Selection

| Layer | Selection | Reason |
|-------|-----------|--------|
| Frontend | React | Mature ecosystem |
| Backend | Node.js | Team familiarity |
| Database | PostgreSQL | Relational needs |

---

## Output Format

```markdown
## Architecture Design Document

### Architecture Options

#### Option 1: Minimal
- Description: [minimal solution]
- Complexity: Low
- Trade-offs: Fast implementation, may need refactoring later

#### Option 2: Clean
- Description: [complete solution]
- Complexity: Medium
- Trade-offs: Longer time, but extensible

#### Option 3: Pragmatic ✅ Recommended
- Description: [balanced solution]
- Complexity: Medium
- Trade-offs: Balance speed and quality

### System Architecture
[architecture diagram]

### Module Design
[module list]

### Interface Definition
[interface documentation]

### Data Model
[data model]

### Technology Selection
[technology selection table]
```

---

## Deliverables

- **Location**: `./docs/ARCH-YYYY-MM-DD.md`

---

## Notes

1. **Don't over-design** - YAGNI
2. **Consider existing code** - Follow existing patterns
3. **Testability** - Architecture must support testing
4. **Incremental** - Can evolve gradually
