# Security Audit

## Overview

Security is P0 — it never gets skipped, regardless of task size or time pressure. This document covers threat detection, compliance checking, and safe coding practices.

## Secret Detection

### Patterns to Flag Immediately

```regex
# API keys and tokens
api[_-]?key
api[_-]?secret
access[_-]?token
auth[_-]?token
bearer[_-]?token
refresh[_-]?token
secret[_-]?key

# Credentials
password
passwd
pwd
credentials
client[_-]?secret

# Private keys
private[_-]?key
rsa[_-]?key
ssh[_-]?key

# Infrastructure
database[_-]?url
db[_-]?url
connection[_-]?string
redis[_-]?url
s3[_-]?bucket

# Environment variables (check values, not just names)
AWS_ACCESS_KEY
STRIPE_SECRET
SENDGRID_API_KEY
```

### Secret Detection in Code

Run before every commit:

```bash
# Ruff (Python)
ruff check . --select=CPY001

# GitLeaks (multi-language)
git diff | gitleaks detect

# TruffleHog (scans git history)
trufflehog filesystem .
```

### Safe Secret Handling

✅ **Correct:**
```python
api_key = os.environ["API_KEY"]  # loaded at runtime
```

❌ **Wrong:**
```python
api_key = "sk-abc123def456"  # hardcoded — NEVER do this
```

## Injection Vulnerabilities

### SQL Injection

❌ **Dangerous:**
```python
query = f"SELECT * FROM users WHERE id = {user_id}"  # SQL injection
cursor.execute(query, (user_id,))  # safe: parameterized
```

✅ **Safe — Parameterized queries:**
```python
cursor.execute("SELECT * FROM users WHERE id = ?", (user_id,))
# OR with SQLAlchemy
session.query(User).filter_by(id=user_id)
```

### Command Injection

❌ **Dangerous:**
```bash
os.system(f"rm -rf {user_input}")  # command injection
subprocess.run(f"git commit -m '{msg}'", shell=True)  # shell=true is risky
```

✅ **Safe:**
```python
subprocess.run(["git", "commit", "-m", msg])  # list form, no shell
os.remove(file_path)  # use language built-ins, not shell commands
```

### Code Injection (eval/exec)

❌ **Dangerous:**
```python
eval(user_input)      # NEVER on user data
exec(user_code)        # NEVER on untrusted input
```

✅ **Safe:**
```python
# Use AST parsing for safe code analysis
import ast
ast.parse(user_code)  # validates syntax without execution
```

### Template Injection (XSS)

❌ **Dangerous (in HTML contexts):**
```javascript
element.innerHTML = userInput  // XSS injection
```

✅ **Safe:**
```javascript
element.textContent = userInput  // safe, escapes HTML
// or use a sanitizer
import DOMPurify from 'dompurify'
element.innerHTML = DOMPurify.sanitize(userInput)
```

## Path Traversal

❌ **Dangerous:**
```python
file_path = f"uploads/{filename}"  # path traversal: "../../etc/passwd"
```

✅ **Safe:**
```python
from pathlib import Path
import os

base = Path("/app/uploads").resolve()
file_path = (base / filename).resolve()
if not file_path.is_relative_to(base):
    raise ValueError("Invalid filename")
```

## License Compliance

### New Dependency Checklist

Before adding any new library:

1. Check the license: `npm ls <package>` / `pip show <package>`
2. Flag these immediately for review:
   - GPL (any version) — may force disclosure of proprietary code
   - AGPL — even stricter than GPL
   - LGPL — safer, but flag for legal review
   - Commons Clause — restricts commercial use
   - SSPL — restricts cloud service use
3. Preferred licenses: MIT, Apache 2.0, BSD, ISC

### License Compatibility Matrix

| Your Project | Permitted | Flag for Review | Prohibited |
|-------------|-----------|----------------|------------|
| MIT | MIT, Apache, BSD, ISC, GPL | LGPL, MPL | GPL-3.0, AGPL, SSPL |
| Apache 2.0 | MIT, Apache, BSD | LGPL, MPL | GPL, AGPL, SSPL |
| Proprietary | All | — | — |

## Input Validation

### Rule: Validate Early, Fail Fast

```python
def process_payment(amount: float, currency: str):
    # Type validation
    if not isinstance(amount, (int, float)):
        raise TypeError("amount must be numeric")
    
    # Range validation
    if amount <= 0:
        raise ValueError("amount must be positive")
    if amount > 1_000_000:
        raise ValueError("amount exceeds maximum")
    
    # Enum validation
    valid_currencies = {"USD", "EUR", "GBP"}
    if currency not in valid_currencies:
        raise ValueError(f"currency must be one of {valid_currencies}")
    
    # Proceed with validated input
    ...
```

### Never Trust Client Input

All user input is untrusted until validated:
- Request bodies and query parameters
- File uploads (name, content, size, type)
- Environment variables (even in trusted environments)
- Configuration files
- Database data (if from untrusted sources)

## Authentication & Authorization

### Auth Checklist

- [ ] Is this endpoint protected? (authentication required?)
- [ ] Does the user have permission for this action? (authorization)
- [ ] Can users access other users' data? (access control)
- [ ] Are session tokens validated and not expired?
- [ ] Is sensitive data logged or exposed in errors?

## Security Audit Workflow

### Per-Change Audit

```
Before every non-trivial change:
1. Run secret detection on changed files
2. Check for injection patterns in new code
3. Validate input handling
4. Check for path traversal risks
5. Flag any new dependencies for license review

If any P0 issue found: STOP, fix immediately, re-audit.
If any P1 issue found: STOP, fix immediately, document.
If any P2 issue found: Document and track.
```

### Audit Report Format

```markdown
## Security Audit: [Task Name]

**Date:** YYYY-MM-DD
**Auditor:** code-agent-pro

### P0 Issues Found: 0 ✅
### P1 Issues Found: 0 ✅
### P2 Issues Found: 1 ⚠️

#### ⚠️ [ID]: [Issue Title]
**Severity:** P1
**File:** [path]
**Line:** [number]
**Description:** [what the risk is]
**Recommendation:** [how to fix]
```
