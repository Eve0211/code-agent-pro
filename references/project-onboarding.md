# Project Onboarding — `/learn` Command

> Run `/learn [project-path]` to quickly understand any project.
> Designed for halfway-onboarded projects. Builds a mental model in ~30 minutes.

## When to Trigger

- User says `/learn` or `/learn <path>`
- User says "帮我了解这个项目" / "看一下这个项目"
- Agent encounters an unfamiliar codebase for the first time
- Before starting any significant work on a new project

## How It Works

```
/learn
  ↓
┌─ Step 1: Surface Scan (3 min) ──────────────────────┐
│  Manifest files, README, directory tree              │
│  → What is this? What stack? How big?               │
├─ Step 2: Entry Point Trace (5 min) ─────────────────┤
│  Main files, API routes, startup sequence           │
│  → Where does it start? What does it do first?      │
├─ Step 3: Core Flow Deep Dive (10 min) ─────────────┤
│  Pick 1-2 main workflows, trace end-to-end          │
│  → Handler → Service → Repository → Database        │
│  → External APIs, message queues, caches            │
├─ Step 4: Pattern Extraction (5 min) ────────────────┤
│  Code style, error handling, testing, logging       │
│  → How do they write code here?                     │
├─ Step 5: Mental Model Document (5 min) ────────────┤
│  Write memory/project-map.md                        │
│  → The "cheat sheet" for this project               │
├─ Step 6: Gap Report (2 min) ───────────────────────┤
│  Ask user targeted questions about unclear areas    │
│  → What don't I know yet?                           │
└─────────────────────────────────────────────────────┘
  ↓
Project understood. Ready for SPEC workflow.
```

---

## Step 1: Surface Scan (3 min)

**Goal**: Answer "what is this thing?" in one minute.

### Read in this order

1. `README.md` — project description, setup instructions, architecture overview
2. `ARCHITECTURE.md` or `docs/` — if they exist
3. `CLAUDE.md` or `AGENTS.md` — existing AI instructions (goldmine)
4. `CHANGELOG.md` — recent activity, version maturity
5. `.gitignore` — reveals deployment target, build artifacts

### Manifest detection

| File | Tells you |
|------|-----------|
| `package.json` | Node.js/TS, framework, scripts, dependencies |
| `pyproject.toml` / `setup.py` | Python, build system, dependencies |
| `go.mod` | Go, module path, Go version |
| `Cargo.toml` | Rust, edition, dependencies |
| `pom.xml` / `build.gradle` | Java/JVM, build system |
| `docker-compose.yml` | Services, infrastructure |
| `Makefile` / `Justfile` | Build/run/test commands |
| `.github/workflows/` | CI/CD pipeline |
| `vercel.json` / `netlify.toml` | Deployment target |

### Size assessment

```bash
# Quick metrics
cloc . --quiet              # lines of code
find . -name "*.py" | wc   # file count by language
du -sh .                    # total size
git log --oneline | wc -l   # commit count (activity level)
```

**Output: One-paragraph project summary**

```
[Project] is a [type: web app / API / library / CLI / microservice]
built with [language] and [framework], using [database] for storage.
It has ~[N] files, ~[N] KLOC, [N] commits.
Primary purpose: [one sentence].
Deployment: [where/how].
```

---

## Step 2: Entry Point Trace (5 min)

**Goal**: Find where the application starts and what it does first.

### Find the entry point

| Project Type | Entry Point |
|-------------|-------------|
| Web app (Node) | `src/index.ts` or `server.ts` |
| Web app (Python) | `app.py`, `main.py`, or `manage.py` |
| Web app (Go) | `cmd/*/main.go` or `main.go` |
| Web app (Java) | `src/main/java/.../Application.java` |
| Web app (Rust) | `src/main.rs` |
| CLI tool | Binary entry in `cmd/` or `src/bin/` |
| Library | `src/lib.rs`, `index.ts`, `__init__.py` |

### Trace the startup sequence

```
Entry point
  → Config loading (env vars, config files)
  → Database connection
  → External service connections (Redis, S3, etc.)
  → Middleware setup (auth, logging, CORS)
  → Route registration
  → Server start
```

### Map the API surface

```
# Web apps
List all routes/endpoints with their HTTP methods:
  GET    /api/v1/users
  POST   /api/v1/users
  GET    /api/v1/users/:id
  ...

# CLI tools
List all subcommands:
  app init      — initialize project
  app build     — build artifacts
  app deploy    — deploy to cloud
  ...

# Libraries
List all public exports:
  export function createUser()
  export class Database
  export type User
```

**Output: Startup sequence + API surface summary**

---

## Step 3: Core Flow Deep Dive (10 min)

**Goal**: Understand the main business logic end-to-end.

### Pick 1-2 representative workflows

For a web app, pick the most important user flow:
- E-commerce: "User places an order"
- SaaS: "User signs up and creates first project"
- API: "Client authenticates and fetches data"
- CLI: "User runs the main command"

### Trace the flow

```
Request arrives
  ↓
[API Layer]     → Validation, auth check
  ↓
[Service Layer] → Business logic, orchestration
  ↓
[Repository]    → Database query
  ↓
[Database]      → Data read/write
  ↓
[Response]      → Format and return
```

For each layer, note:
- **What it does**: Key responsibility
- **What it depends on**: Other services, external APIs
- **What can go wrong**: Error handling approach
- **Key files**: File paths for future reference

### Identify integration points

```
External APIs:    [Stripe, SendGrid, Twilio, ...]
Message queues:   [RabbitMQ, Kafka, SQS, ...]
Caches:           [Redis, Memcached, in-memory]
File storage:     [S3, GCS, local disk]
Search:           [Elasticsearch, Meilisearch]
Background jobs:  [Celery, Sidekiq, Bull]
```

**Output: 1-2 flow diagrams with file references**

---

## Step 4: Pattern Extraction (5 min)

**Goal**: How do people write code in this project?

### Code style

| Aspect | Look for | Example |
|--------|----------|---------|
| Naming | snake_case / camelCase / kebab-case? | `get_user()` vs `getUser()` |
| File organization | By feature? By layer? Flat? | `users/service.ts` vs `services/user.py` |
| Import style | Absolute? Relative? Aliases? | `@/services/user` vs `../../services/user` |
| Error handling | Exceptions? Result types? Error codes? | `try/catch` vs `Result<T, E>` |
| Async model | Callbacks? Promises? async/await? Channels? | `async def` vs `go func()` |

### Testing patterns

| Check | Where to look |
|-------|--------------|
| Test framework? | `jest.config`, `pytest.ini`, `go test`, `Cargo test` |
| Test location? | `__tests__/`, `tests/`, `*_test.go`, `*_test.rs` |
| Mocking approach? | Hand-rolled? Mockito? pytest-mock? |
| Test style? | Unit only? Integration? E2E? |
| Coverage tools? | `.nycrc`, `pytest-cov`, `go test -cover` |

### Logging & observability

| Check | Where to look |
|-------|--------------|
| Logger used? | `winston`, `logrus`, `slog`, `log4j` |
| Structured? | JSON output? Key-value pairs? |
| Log levels? | DEBUG/INFO/WARN/ERROR used correctly? |
| Monitoring? | Prometheus metrics? Health endpoints? |
| Tracing? | OpenTelemetry? Custom trace IDs? |

**Output: Pattern summary table**

---

## Step 5: Mental Model Document (5 min)

**Goal**: Write `memory/project-map.md` — the permanent cheat sheet.

### Template

```markdown
# Project Map: [Project Name]

> Generated: YYYY-MM-DD by /learn command
> Confidence: High / Medium / Low

## One-Liner
[What this project does, in one sentence]

## Type
[Web App / API / CLI / Library / Microservice]

## Tech Stack
- **Language**: [Python 3.11 / Go 1.22 / ...]
- **Framework**: [FastAPI / Spring Boot / Express / ...]
- **Database**: [PostgreSQL / MySQL / MongoDB / ...]
- **Cache**: [Redis / none]
- **Queue**: [Celery / Bull / none]
- **Storage**: [S3 / local / none]
- **Deploy**: [Docker / Vercel / AWS / bare metal]

## Architecture
[Layered monolith / Microservices / Event-driven / ...]
[1-2 sentence description + rough component diagram]

## Entry Points
- **Main**: `src/main.py`
- **API**: `src/api/routes.py`
- **CLI**: `src/cli.py`
- **Tests**: `tests/`
- **Scripts**: `scripts/`

## Key Workflows
### [Workflow 1: e.g., "User places order"]
1. `POST /api/v1/orders` → `src/api/routes.py:45`
2. `OrderService.create()` → `src/services/order.py:23`
3. `OrderRepo.save()` → `src/repositories/order.py:12`
4. Payment gateway call → `src/services/payment.py:67`
5. Response: `{ "order_id": "...", "status": "created" }`

### [Workflow 2: ...]
...

## Code Conventions
- Naming: [camelCase / snake_case]
- Errors: [typed exceptions / Result<T,E> / error codes]
- Tests: [pytest / jest / go test]
- Logging: [structlog / logrus / slog]
- Async: [asyncio / goroutines / tokio]

## Dependencies of Note
- **Internal**: [shared libs, internal APIs]
- **External**: [Stripe, SendGrid, etc.]
- **Infrastructure**: [PostgreSQL, Redis, S3]

## Known Issues / Tech Debt
- [ ] [Issue description] (confidence: high/medium/low)
- [ ] [Issue description]

## Questions for User
- [ ] [Question about something unclear]
- [ ] [Question about business logic]
```

### Confidence levels

- **High**: Directly observed in code or documentation
- **Medium**: Inferred from patterns, not confirmed
- **Low**: Guessed from project type, needs validation

---

## Step 6: Gap Report (2 min)

**Goal**: Tell the user what you couldn't figure out.

### Ask targeted questions

Only ask about things that matter for the immediate task:

```
I've built a mental model of [Project]. Here's what I learned:
[brief summary]

A few things I couldn't determine from code alone:
1. [Question about business logic / priority]
2. [Question about integration / external dependency]
3. [Question about deployment / environment]

Want me to proceed with [next task], or should we clarify these first?
```

### What NOT to ask

- Things you can figure out by reading more code
- Questions answerable from README or docs
- Stylistic preferences (save for when you're actually writing code)

---

## Integration with SPEC Workflow

`/learn` feeds directly into the SPEC workflow:

```
/learn (Phase 0)
  ↓  → memory/project-map.md created
  ↓  → Project understood
Phase 1: Requirement Clarification
  ↓  → Context from project-map.md
Phase 2: SPEC Generation
  ↓  → PRD grounded in actual codebase
...
```

The `project-map.md` file becomes persistent context. In subsequent sessions,
read it at startup to avoid re-learning the project.

---

## Anti-Patterns

❌ **Reading every file** — scan headers, don't read bodies
❌ **Asking 20 questions** — read more code first, ask only genuine gaps
❌ **Ignoring tests** — tests often have the best documentation
❌ **Skipping .gitignore** — it reveals the build/deploy story
❌ **Assuming architecture from directory names** — verify by reading code
