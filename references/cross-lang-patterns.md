# Cross-Language Patterns

> Universal backend patterns that apply regardless of language.
> Covers API design, concurrency, caching, database, and observability.

## API Design

### REST API Conventions

**URL Structure:**
```
GET    /api/v1/users           — list (with pagination)
GET    /api/v1/users/:id       — get by ID
POST   /api/v1/users           — create
PUT    /api/v1/users/:id       — full update
PATCH  /api/v1/users/:id       — partial update
DELETE /api/v1/users/:id       — delete
```

**Response Format (always consistent):**
```json
{
  "data": { ... },
  "meta": {
    "page": 1,
    "per_page": 20,
    "total": 150
  },
  "errors": null
}
```

**Error Response (never leak internals):**
```json
{
  "data": null,
  "meta": null,
  "errors": [
    {
      "code": "VALIDATION_ERROR",
      "message": "Email is required",
      "field": "email"
    }
  ]
}
```

**Rules:**
- Use nouns, not verbs: `/users` not `/getUsers`
- Use plural nouns: `/users` not `/user`
- Version with URL prefix: `/api/v1/`
- Use query params for filtering: `/users?role=admin&active=true`
- Paginate always: never return unbounded lists
- Use standard HTTP status codes

### GraphQL Conventions

**Schema organization:**
```graphql
type Query {
  user(id: ID!): User
  users(filter: UserFilter, page: Int): UserConnection!
}

type Mutation {
  createUser(input: CreateUserInput!): User!
  updateUser(id: ID!, input: UpdateUserInput!): User!
}

type User {
  id: ID!
  email: String!
  name: String!
  createdAt: ISO8601DateTime!
}
```

**Rules:**
- Use `ID!` for required identifiers
- Use input types for mutations
- Always return `createdAt`/`updatedAt`
- Use connections for list queries (cursor-based pagination)
- Validate inputs in resolvers, not just schema

---

## Concurrency Patterns

### Pattern 1: Fan-Out, Gather

Multiple independent operations → run in parallel → gather results.

```
Python:  asyncio.gather(task1(), task2(), task3())
Go:      var wg sync.WaitGroup  + goroutines
Java:    CompletableFuture.allOf(f1, f2, f3)
Rust:    join!(task1, task2, task3)
Node:    Promise.all([p1, p2, p3])
```

### Pattern 2: Pipeline

Stages where output of one feeds into the next → use channels/streams.

```
Python:  async generator chains
Go:      goroutine + channel pipeline
Java:    reactive streams (Project Reactor)
Rust:    Iterator adapter chains / tokio channels
Node:    async iterable + for await...of
```

### Pattern 3: Worker Pool

Bounded parallelism — limit concurrent work to N workers.

```
Python:  asyncio.Semaphore(N)
Go:      channel with N buffer + workers
Java:    ThreadPoolExecutor(N)
Rust:    futures::stream::buffer_unordered(N)
Node:    p-limit or custom semaphore
```

### Pattern 4: Circuit Breaker

Prevent cascading failures when a downstream service is unhealthy.

```
States: CLOSED → (failures > threshold) → OPEN → (timeout) → HALF_OPEN

CLOSED:    requests pass through normally
OPEN:      requests fail fast (no call to downstream)
HALF_OPEN: allow N probe requests to test recovery
```

Implementation:
- Track failure count in a sliding window
- Open after N consecutive failures
- Half-open after a timeout period
- Close again if probe requests succeed

### When to Use What

| Scenario | Pattern |
|----------|---------|
| Fetch from 3 independent APIs | Fan-Out, Gather |
| Process CSV row by row | Pipeline |
| Upload 100 images (max 5 at a time) | Worker Pool |
| Call external payment API | Circuit Breaker |
| Long polling / real-time updates | Streams/WebSocket |
| Rate-limited API calls | Worker Pool + backoff |

---

## Caching Strategy

### Cache Decision Tree

```
Is the data read-heavy? (reads >> writes)
  └─ YES → Cache it
       Is the data expensive to compute/query?
         └─ YES → Cache with longer TTL
       Does the data change frequently?
         └─ YES → Cache with short TTL or event-driven invalidation

Is the data write-heavy? (writes >> reads)
  └─ Don't cache, or cache only reads with very short TTL
```

### Cache Layers (pick the right one)

| Layer | Use Case | TTL | Invalidation |
|-------|----------|-----|-------------|
| In-memory | Per-request dedup, session data | Seconds | TTL / LRU eviction |
| Redis | Shared across instances | Minutes-Hours | Write-through / event |
| CDN | Static assets, public API responses | Hours-Days | Cache headers |
| Database query cache | Repeated identical queries | Seconds | Write invalidation |

### Cache Invalidation Rules

1. **Never invalidate by TTL alone for critical data** — use event-driven invalidation
2. **Cache key must include all query parameters** — `/users?page=1` ≠ `/users?page=2`
3. **Set a max TTL** — even "forever" caches should expire eventually
4. **Cache the serialized response, not raw objects** — avoid computation on cache hit
5. **Handle cache stampede** — use singleflight / request coalescing

### Common Anti-Patterns

```
❌ Caching everything → memory pressure, stale data everywhere
❌ No TTL → data never updates
❌ Cache key collision → wrong data served
❌ Forgetting to invalidate on write → stale reads
✅ Cache selectively with clear invalidation strategy
```

---

## Database Patterns

### Schema Design Rules

1. **Every table needs**: `id` (UUID or auto-increment), `created_at`, `updated_at`
2. **Use UUIDs for public IDs** — auto-increment leaks business metrics
3. **Soft delete with `deleted_at`** — for auditable data
4. **Foreign keys with ON DELETE behavior** — always explicit
5. **Indexes on**: foreign keys, frequently queried columns, composite query patterns
6. **Avoid**: `SELECT *`, N+1 queries, unbounded `OFFSET`

### Query Optimization Checklist

```markdown
- [ ] All queries use WHERE clause (no full table scans)
- [ ] N+1 eliminated (eager loading or batch queries)
- [ ] Pagination uses cursor-based, not OFFSET (for large datasets)
- [ ] Indexes exist for all WHERE, JOIN, ORDER BY columns
- [ ] EXPLAIN ANALYZE run on slow queries
- [ ] Connection pooling configured (not opening new connections per query)
```

### Migration Safety

```markdown
- [ ] Additive only (add columns, don't remove)
- [ ] New columns have defaults or are nullable
- [ ] Backward compatible (old code works during deploy)
- [ ] Tested against production-scale data size
- [ ] Rollback migration exists
```

---

## Observability

### The Three Pillars

```
Logs        → What happened? (events, errors, state changes)
Metrics     → How much? (counters, gauges, histograms)
Traces      → Where did time go? (request flow, latency)
```

### Structured Log Format

Every log entry should include:

```json
{
  "timestamp": "2026-03-26T14:00:00Z",
  "level": "INFO",
  "message": "user_login",
  "request_id": "abc-123",
  "user_id": "usr-456",
  "duration_ms": 45,
  "service": "auth-service"
}
```

**Fields:**
- `timestamp` — ISO 8601, UTC
- `level` — DEBUG, INFO, WARN, ERROR
- `message` — event description (snake_case)
- `request_id` — trace correlation
- `user_id` — actor (if applicable)
- `duration_ms` — operation latency (if applicable)

### Log Level Guidelines

| Level | When to Use | Examples |
|-------|------------|----------|
| DEBUG | Detailed flow, variable values | `user_data: {email: "..."}` |
| INFO | Business events, state changes | `order_created`, `payment_completed` |
| WARN | Recoverable issues, degraded state | `cache_miss`, `retry_attempt_2` |
| ERROR | Failures requiring attention | `payment_failed`, `db_connection_lost` |

### Metrics to Track

**Essential (always):**
- Request latency (p50, p95, p99)
- Error rate (by HTTP status code)
- Request count (by endpoint)
- Active connections
- Queue depth (if async)

**Nice to have:**
- Business metrics (orders/minute, signups/day)
- Cache hit rate
- Database query duration
- External service latency

### Health Check Endpoint

```json
GET /health
{
  "status": "healthy",
  "version": "1.2.3",
  "checks": {
    "database": "ok",
    "redis": "ok",
    "external_api": "degraded"
  },
  "uptime_seconds": 86400
}
```

Rules:
- Separate `/health` (quick, no deps) from `/ready` (checks all deps)
- Return 503 if any critical dependency is down
- Include version for deployment tracking

---

## Language Quick Reference

### Error Handling

| Language | Pattern | Example |
|----------|---------|---------|
| Python | Typed exceptions + `from` | `raise AppError(f"doing X: {e}") from e` |
| Go | Sentinel errors + `fmt.Errorf("%w")` | `return fmt.Errorf("get user: %w", err)` |
| Java | Custom exceptions + cause | `throw new AppException("msg", cause)` |
| Rust | `thiserror` enum | `#[error("{0} with id {1} not found")]` |
| Node | Custom Error classes | `class AppError extends Error { code }` |

### Dependency Injection

| Language | Approach |
|----------|---------|
| Python | Constructor params / `Depends()` (FastAPI) |
| Go | Constructor functions / interfaces |
| Java | `@RequiredArgsConstructor` (Spring) |
| Rust | Trait objects / generic parameters |
| Node | Constructor injection (NestJS) |

### Configuration

| Language | Source | Priority |
|----------|--------|----------|
| All | Environment variables | 1 (override all) |
| All | `.env` file | 2 (dev only) |
| Python | `pyproject.toml` / `settings.py` | 3 |
| Go | `config.yaml` + env override | 3 |
| Java | `application.yml` (Spring) | 3 |
| Rust | `config.toml` + env | 3 |
| Node | `.env` + `config.ts` | 3 |

**Rule**: Secrets NEVER in config files. Always environment variables.
