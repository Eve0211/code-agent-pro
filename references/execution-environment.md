# Execution Environment

## Before Writing Code

### 1. Identify the Runtime

```python
# Detection heuristics (in priority order)
1. Check .nvmrc / .node-version / .tool-versions  →  Node.js version
2. Check pyproject.toml / requirements.txt / .python-version  →  Python version
3. Check go.mod / go.sum  →  Go version
4. Check Cargo.toml  →  Rust toolchain
5. Check pom.xml / build.gradle  →  Java/JVM
6. Check composer.json  →  PHP version
```

If the project has a version manager config file (`.nvmrc`, `.python-version`), use that version. Never assume system default.

### 2. Verify Build Works

Before making any changes, verify the project builds successfully:

```bash
# Common build commands (pick what's right for the project)
npm run build        # Node.js/TypeScript
python -m py_compile .  # Python
go build ./...       # Go
cargo build          # Rust
mvn compile          # Java

# If no build command exists, at least run:
npm install  # Node
pip install -e .  # Python
```

If the project doesn't build before your changes, report this as a pre-existing issue before proceeding.

### 3. Understand the Project Structure

Map the key directories:

```markdown
## Project Structure
src/          — source code
tests/        — test files
dist/         — build output (gitignore)
node_modules/ — dependencies (gitignore)
.env          — environment variables (never commit)
.env.example  — template for .env
```

## After Writing Code

### 1. Build Verification

Run the same build command used before. If it fails:

```
Error: Cannot find module './auth/TokenStore'
→ Did I rename or move a file?
→ Is there a TypeScript path alias misconfigured?
→ Is the import path correct?
```

Fix build errors immediately. Do not proceed past build failures.

### 2. Test Execution

```bash
# Run tests related to changed files
npm test -- --testPathPattern="auth"     # Jest
pytest tests/auth/                      # pytest
go test ./...                           # Go

# Run full suite for regression check
npm test
```

If tests fail:
1. Check if the failure is caused by your changes or pre-existing
2. If caused by your changes → fix the code
3. If pre-existing → document and proceed (with explicit user approval)

### 3. Staging and Preview

Show the diff before committing:

```bash
git diff --stat          # Summary of changes
git diff                 # Full diff
git diff --name-only     # List of changed files
```

Group changes logically. If multiple unrelated changes are mixed, offer to split them.

## Incremental Change Tracking

### Change Log Format

```markdown
## Changes Made

### src/auth/OAuthProvider.ts (new)
- Created OAuthProvider abstract class
- Implemented Google and GitHub providers
- Added token refresh logic

### src/auth/AuthService.ts (modified)
- Added OAuthProvider injection
- Extended login() to support OAuth flow
- Preserved backward compatibility

### src/routes/auth.ts (modified)
- Added OAuth callback routes
- Integrated OAuthProvider with existing middleware

### src/__tests__/auth/OAuthProvider.test.ts (new)
- Unit tests for OAuthProvider
- Integration tests for token refresh
```

### File Change Categories

| Category | Description | Committed together? |
|----------|-------------|---------------------|
| Feature | New functionality | Yes, atomically |
| Test | Tests for feature | Yes, with feature |
| Refactor | Renaming, reorganization | Separately if large |
| Fix | Bug fix | Yes, atomically |
| Chore | Dependencies, config | Separately |

## Sandbox & Rollback

### When to Use Sandbox Mode

Activate sandbox (dry-run, no actual writes) when:
- The task involves bulk changes (>10 files)
- The task involves file deletion
- The task involves potentially destructive operations
- You are uncertain about the correct approach
- The user asks to preview before applying

### How to Sandbox

```bash
# Show what would change without changing it
git diff --no-commit --no-color  # preview changes
npm run build --dry-run          # check build without artifacts

# For risky operations, work in a copy
cp -r project project.backup
# make changes to project/
# if satisfied, rm project.backup
# if not, rm project && mv project.backup project
```

### Rollback Procedure

If a change needs to be reverted:

```bash
# Single file
git checkout HEAD -- path/to/file

# Multiple files
git checkout HEAD -- src/ auth/ routes/

# Full reset (DESTRUCTIVE — ask first)
git reset --hard HEAD

# Uncommitted changes
git stash  # save for later
git stash drop  # or discard
```

## Environment Consistency

### Dependency Drift Prevention

Before starting work on a multi-session task:

```bash
# Pin the lock file version
npm ci        # exact versions from package-lock.json
pip install -r requirements.txt  # exact versions
go mod download  # cache dependencies
```

Never run `npm update` or `pip upgrade` as part of a feature implementation unless explicitly requested.

### Cross-Platform Considerations

If working on a project that runs on multiple platforms:
- Use path operations from the standard library, not string concatenation
- Test on the primary target platform before reporting success
- Document platform-specific quirks in the memory file
