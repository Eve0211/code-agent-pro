# Version Compatibility Guide

**Rule: Never fabricate API signatures, annotations, or method names.**

When generating code, always verify compatibility with the project's actual framework/library versions.

---

## How to Verify

### Step 1: Read the Manifest File

Detect exact versions before writing code:

```javascript
// package.json
{
  "dependencies": {
    "react": "^18.2.0",
    "next": "14.0.0"
  }
}

// pyproject.toml
[project]
dependencies = [
  "fastapi>=0.100.0",
  "pydantic>=2.0.0"
]

// go.mod
module myapp
go 1.21
require github.com/gin-gonic/gin v1.9.0

// pom.xml
<parent>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-parent</artifactId>
  <version>3.2.0</version>
</parent>
```

### Step 2: Decision Tree

```
Is the API stable across versions?
  YES → Proceed normally
  NO → Are there known breaking changes?
         YES → Search official docs
         NO → If uncertain, search docs anyway
```

### Step 3: If Uncertain

**Search official documentation** before writing code:

```
"Spring Boot 3 @Service annotation migration"
"Next.js 14 App Router metadata export"
"React 19 use hook documentation"
"FastAPI 1.0 dependency injection changes"
```

---

## Breaking Changes by Language/Framework

### Java / Spring Boot

| Area | Breaking Change | Versions |
|------|-----------------|----------|
| `javax.*` → `jakarta.*` | Spring Boot 3.x requires Jakarta EE 9+ | Spring Boot 2.x → 3.x |
| Spring Security | `WebSecurityConfigurerAdapter` removed | Spring Security 5.x → 6.x |
| JPA/Hibernate | `@GenericGenerator` → `@UuidGenerator` | Hibernate 5.x → 6.x |
| Spring Cloud | Version locked to Spring Boot | Check compatibility matrix |
| Java features | Records (17+), Sealed classes (17+), Pattern matching (21+) | JDK 11 → 17 → 21 |

**Example migration:**

```java
// Spring Boot 2.x
import javax.servlet.http.HttpServletRequest;

// Spring Boot 3.x
import jakarta.servlet.http.HttpServletRequest;
```

```java
// Spring Security 5.x
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()...
    }
}

// Spring Security 6.x
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests(auth -> auth...);
        return http.build();
    }
}
```

---

### Python

| Area | Breaking Change | Versions |
|------|-----------------|----------|
| FastAPI | Import paths, dependency injection | 0.x → 1.x |
| Django | `URLPattern`, middleware, `USE_TZ` defaults | 3.x → 4.x → 5.x |
| SQLAlchemy | `Query` removed, 2.0 style queries required | 1.x → 2.x |
| Pydantic | `BaseModel` changes, validator syntax | v1 → v2 |
| Python features | Walrus operator (3.8+), match/case (3.10+), type params (3.12+) | 3.7 → 3.8 → 3.10 → 3.12 |

**Example: SQLAlchemy 1.x → 2.x**

```python
# SQLAlchemy 1.x
users = session.query(User).filter(User.name == 'John').all()

# SQLAlchemy 2.x
from sqlalchemy import select
stmt = select(User).where(User.name == 'John')
users = session.execute(stmt).scalars().all()
```

**Example: Pydantic v1 → v2**

```python
# Pydantic v1
from pydantic import BaseModel, validator

class User(BaseModel):
    name: str
    
    @validator('name')
    def name_must_not_be_empty(cls, v):
        if not v:
            raise ValueError('name cannot be empty')
        return v

# Pydantic v2
from pydantic import BaseModel, field_validator

class User(BaseModel):
    name: str
    
    @field_validator('name')
    @classmethod
    def name_must_not_be_empty(cls, v):
        if not v:
            raise ValueError('name cannot be empty')
        return v
```

---

### Node.js / TypeScript

| Area | Breaking Change | Versions |
|------|-----------------|----------|
| Next.js | App Router changes, Server Components, `metadata` export | 12 → 13 → 14 → 15 |
| React | Strict mode, Suspense, `use` hook, Server Components | 16 → 17 → 18 → 19 |
| Express | Middleware changes, async handler handling | 4 → 5 |
| NestJS | Decorator changes, module system | Major versions |
| TypeScript | Decorator changes, `const` type parameters | 4.x → 5.x |
| Prisma | `prisma.$extends()` | 4.x+ |

**Example: Next.js metadata**

```typescript
// Next.js 13 (Pages Router)
import Head from 'next/head'

export default function Page() {
  return (
    <>
      <Head>
        <title>My Page</title>
      </Head>
      <main>Content</main>
    </>
  )
}

// Next.js 14+ (App Router)
import { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'My Page',
}

export default function Page() {
  return <main>Content</main>
}
```

**Example: React 18 → 19**

```typescript
// React 18
import { useEffect, useState } from 'react'

// React 19 adds 'use' hook for promises
import { use } from 'react'

function DataComponent({ promise }) {
  const data = use(promise) // New in React 19
  return <div>{data}</div>
}
```

---

### Go

| Area | Breaking Change | Versions |
|------|-----------------|----------|
| Go features | Generics (1.18+), range-over-int (1.22+), loop variable scope (1.22+) | 1.17 → 1.18 → 1.22 |
| Popular libs | `chi` v5, `gorm` v2, `gin` v1.x | Check each library |

**Example: Go 1.22 loop variable scope**

```go
// Go < 1.22 - bug: all goroutines capture same variable
for i, v := range items {
  go func() {
    fmt.Println(i, v) // BUG: uses final values
  }()
}

// Go < 1.22 - fix: capture locally
for i, v := range items {
  i, v := i, v // capture
  go func() {
    fmt.Println(i, v)
  }()
}

// Go 1.22+ - automatically fixed
for i, v := range items {
  go func() {
    fmt.Println(i, v) // OK: each iteration has own variables
  }()
}
```

---

### Rust

| Area | Breaking Change | Versions |
|------|-----------------|----------|
| Edition | Lifetime capture changes, unsafe extern | 2021 → 2024 |
| tokio | Runtime signatures, feature flags | Major versions |
| axum | Router API, extractor changes | 0.6 → 0.7 |
| serde | `#[serde(skip_serializing_if)]` behavior | Check version |

---

## What NOT to Do

```
❌ "I think the annotation is @XyzAnnotation" (fabricated)
❌ "In Spring Boot 3, use @DeprecatedAnnotation" (wrong)
❌ "This should work in Python 3.8" (unverified assumption)
❌ "Next.js 14 supports this pattern" (might be 15-only)

✅ Search official docs: "Spring Boot 3 @Service annotation migration"
✅ Read changelog/migration guide for specific version
✅ Check actual project dependencies for exact version
✅ If still uncertain after searching, tell user and ask
```

---

## Quick Reference URLs

| Framework | Documentation |
|-----------|---------------|
| React | https://react.dev/blog |
| Next.js | https://nextjs.org/docs/migration |
| Spring Boot | https://github.com/spring-projects/spring-boot/wiki |
| Django | https://docs.djangoproject.com/en/stable/releases/ |
| FastAPI | https://fastapi.tiangolo.com/release-notes/ |
| Go | https://go.dev/doc/go1.22 (replace version) |
| Rust | https://blog.rust-lang.org/ |

---

## Verification Checklist

Before using any API that might be version-specific:

- [ ] Checked manifest file for exact version
- [ ] Verified API exists in that version's docs
- [ ] Checked for deprecation warnings or migration guides
- [ ] If uncertain, searched official docs or asked user
