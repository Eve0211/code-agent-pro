# Codebase Analysis Phase

> Phase 2 (for mature projects): Deep Code Analysis

## Purpose

Deeply understand existing code, provide foundation for subsequent development.

## Input

- Project path
- Requirements/problem

## Output

- Code analysis report

---

## Analysis Dimensions

### 1. Project Structure

```
project/
├── src/           # Source code
├── tests/         # Tests
├── docs/          # Documentation
├── config/        # Configuration
└── package.json   # Dependencies
```

**Analysis Items**:
- Directory organization
- Module division
- File naming conventions

---

### 2. Tech Stack

| Type | Items |
|------|-------|
| Language | TypeScript / JavaScript / Python / ... |
| Framework | React / Vue / Next.js / ... |
| Build | Webpack / Vite / ... |
| Testing | Jest / Vitest / ... |
| CI/CD | GitHub Actions / ... |

---

### 3. Core Flows

- Where is the entry point?
- What are main business flows?
- How does data flow?

---

### 4. Testing Situation

- What test framework?
- What is coverage?
- Which modules are well tested?
- Which modules lack tests?

---

### 5. Dependencies

- What are main dependencies?
- Any outdated versions?
- Any security vulnerabilities?

---

### 6. Code Style

- What linter is used?
- Code conventions (Prettier?)
- Naming conventions

---

### 7. Documentation

- Is README complete?
- Any API docs?
- Are comments sufficient?

---

### 8. Git History

- What changed recently?
- Who are main contributors?
- Any WIP branches?

---

## Analysis Methods

### Automatic Analysis

```bash
# View project structure
tree -L 2

# View dependencies
cat package.json

# View test coverage
npm run test:coverage

# View git history
git log --oneline -20
```

### Manual Analysis

1. Read README
2. Browse main source files
3. Understand core modules
4. Run project to see behavior

---

## Output Format

```markdown
## Code Analysis Report

**Project**: [name]
**Tech Stack**: [language/framework]
**Analysis Date**: [date]

### Project Structure
[structure description]

### Core Modules
| Module | Responsibility | File Count |
|--------|---------------|------------|
| ... | ... | ... |

### Testing Situation
- Coverage: X%
- Test file count: X
- Modules lacking tests: [...]

### Dependency Risks
- [ ] Outdated dependencies
- [ ] Security vulnerabilities
- [ ] Unused dependencies

### Code Style
- Linter: [tool]
- Formatter: [tool]
- Naming conventions: [description]

### Key Findings
1. [Finding 1]
2. [Finding 2]
3. [Finding 3]

### Recommendations
1. [Recommendation 1]
2. [Recommendation 2]
```

---

## Notes

1. **Read-only analysis** - Don't modify code
2. **Full coverage** - Don't miss key modules
3. **Record findings** - Easy reference later
4. **Identify risks** - Find problems early
