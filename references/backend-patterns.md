# Backend Patterns

> Application-layer backend patterns for Python, Java, Go, Rust, Node.js/TypeScript.
> Focus: architecture, error handling, testing, logging, and agent self-checking.

## Architecture Patterns

### Layered Architecture (Recommended for Most Projects)

```
┌─────────────────────────────────────┐
│  API Layer (Handlers/Controllers)   │  ← HTTP, validation, routing
├─────────────────────────────────────┤
│  Service Layer (Business Logic)     │  ← orchestration, transactions
├─────────────────────────────────────┤
│  Repository Layer (Data Access)     │  ← DB queries, caching
├─────────────────────────────────────┤
│  Domain Layer (Models/Entities)     │  ← pure business rules
└─────────────────────────────────────┘
```

**Rules:**
- Dependencies point DOWN only (API → Service → Repository → Domain)
- Domain layer has ZERO external dependencies (no HTTP, no DB)
- Service layer handles transactions and cross-cutting concerns
- API layer is thin — only HTTP concerns

### Language-Specific Implementations

#### Python (FastAPI/Flask)

```python
# Domain
class User:
    id: UUID
    email: str
    
    def can_access(self, resource) -> bool:
        return resource.owner_id == self.id

# Repository
class UserRepository:
    def __init__(self, db: Session):
        self.db = db
    
    def get_by_id(self, user_id: UUID) -> User | None:
        return self.db.query(UserModel).filter_by(id=user_id).first()

# Service
class UserService:
    def __init__(self, repo: UserRepository):
        self.repo = repo
    
    def get_user(self, user_id: UUID) -> User:
        user = self.repo.get_by_id(user_id)
        if not user:
            raise UserNotFoundError(user_id)
        return user

# API
@app.get("/users/{user_id}")
def get_user(user_id: UUID, service: UserService = Depends()):
    return service.get_user(user_id)
```

#### Go

```go
// Domain
type User struct {
    ID    uuid.UUID
    Email string
}

func (u User) CanAccess(r Resource) bool {
    return r.OwnerID == u.ID
}

// Repository
type UserRepository struct {
    db *sql.DB
}

func (r *UserRepository) GetByID(ctx context.Context, id uuid.UUID) (*User, error) {
    // implementation
}

// Service
type UserService struct {
    repo *UserRepository
}

func (s *UserService) GetUser(ctx context.Context, id uuid.UUID) (*User, error) {
    user, err := s.repo.GetByID(ctx, id)
    if err != nil {
        return nil, fmt.Errorf("get user: %w", err)
    }
    if user == nil {
        return nil, ErrUserNotFound
    }
    return user, nil
}

// API
func (h *Handler) GetUser(w http.ResponseWriter, r *http.Request) {
    // thin layer, delegates to service
}
```

#### Java (Spring)

```java
// Domain
public record User(UUID id, String email) {
    public boolean canAccess(Resource resource) {
        return resource.ownerId().equals(this.id);
    }
}

// Repository
@Repository
public interface UserRepository extends JpaRepository<UserEntity, UUID> {
    Optional<UserEntity> findByEmail(String email);
}

// Service
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository repo;
    
    public User getUser(UUID id) {
        return repo.findById(id)
            .map(this::toDomain)
            .orElseThrow(() -> new UserNotFoundException(id));
    }
}

// API
@RestController
@RequiredArgsConstructor
public class UserController {
    private final UserService service;
    
    @GetMapping("/users/{id}")
    public User getUser(@PathVariable UUID id) {
        return service.getUser(id);
    }
}
```

#### Rust (Actix/Axum)

```rust
// Domain
pub struct User {
    pub id: Uuid,
    pub email: String,
}

impl User {
    pub fn can_access(&self, resource: &Resource) -> bool {
        resource.owner_id == self.id
    }
}

// Repository
pub struct UserRepository<'a> {
    db: &'a PgPool,
}

impl<'a> UserRepository<'a> {
    pub async fn get_by_id(&self, id: Uuid) -> Result<Option<User>, sqlx::Error> {
        // implementation
    }
}

// Service
pub struct UserService<'a> {
    repo: UserRepository<'a>,
}

impl<'a> UserService<'a> {
    pub async fn get_user(&self, id: Uuid) -> Result<User, AppError> {
        self.repo.get_by_id(id).await?
            .ok_or(AppError::UserNotFound(id))
    }
}
```

#### Node.js/TypeScript (Express/Fastify/Nest)

```typescript
// Domain
class User {
    constructor(
        public readonly id: string,
        public readonly email: string
    ) {}
    
    canAccess(resource: Resource): boolean {
        return resource.ownerId === this.id;
    }
}

// Repository
class UserRepository {
    constructor(private db: PrismaClient) {}
    
    async findById(id: string): Promise<User | null> {
        const user = await this.db.user.findUnique({ where: { id } });
        return user ? new User(user.id, user.email) : null;
    }
}

// Service
class UserService {
    constructor(private repo: UserRepository) {}
    
    async getUser(id: string): Promise<User> {
        const user = await this.repo.findById(id);
        if (!user) throw new UserNotFoundError(id);
        return user;
    }
}

// API (NestJS example)
@Controller('users')
export class UserController {
    constructor(private service: UserService) {}
    
    @Get(':id')
    async getUser(@Param('id') id: string): Promise<User> {
        return this.service.getUser(id);
    }
}
```

## Error Handling

### Principles

1. **Domain errors are explicit** — use typed errors, not generic exceptions
2. **Service layer translates** — repository errors → domain errors
3. **API layer formats** — domain errors → HTTP responses
4. **Always wrap with context** — `fmt.Errorf("doing X: %w", err)`

### Error Hierarchy

```
AppError (base)
├── DomainError
│   ├── ValidationError
│   ├── NotFoundError
│   └── UnauthorizedError
├── InfrastructureError
│   ├── DatabaseError
│   ├── NetworkError
│   └── ExternalServiceError
└── SystemError
    └── InternalError
```

### Language Patterns

#### Python

```python
from dataclasses import dataclass
from typing import Optional

@dataclass
class AppError(Exception):
    message: str
    code: str
    status_code: int = 500

class NotFoundError(AppError):
    def __init__(self, resource: str, id: str):
        super().__init__(
            message=f"{resource} with id {id} not found",
            code="NOT_FOUND",
            status_code=404
        )

# Usage
raise NotFoundError("User", user_id)

# Handler
def handle_error(e: AppError) -> Response:
    return JSONResponse(
        status_code=e.status_code,
        content={"error": e.code, "message": e.message}
    )
```

#### Go

```go
type AppError struct {
    Code       string
    Message    string
    StatusCode int
    Cause      error
}

func (e *AppError) Error() string {
    if e.Cause != nil {
        return fmt.Sprintf("%s: %v", e.Message, e.Cause)
    }
    return e.Message
}

func (e *AppError) Unwrap() error {
    return e.Cause
}

var ErrNotFound = &AppError{
    Code:       "NOT_FOUND",
    StatusCode: 404,
}

func NewNotFoundError(resource string, id string) error {
    return &AppError{
        Code:       "NOT_FOUND",
        Message:    fmt.Sprintf("%s with id %s not found", resource, id),
        StatusCode: 404,
    }
}

// Usage
return nil, NewNotFoundError("User", userID)

// Handler checks
if errors.Is(err, ErrNotFound) {
    // handle 404
}
```

#### Rust

```rust
use thiserror::Error;

#[derive(Error, Debug)]
pub enum AppError {
    #[error("{0} with id {1} not found")]
    NotFound(&'static str, Uuid),
    
    #[error("validation failed: {0}")]
    Validation(String),
    
    #[error("internal error")]
    Internal(#[from] anyhow::Error),
}

impl AppError {
    pub fn status_code(&self) -> StatusCode {
        match self {
            Self::NotFound(_, _) => StatusCode::NOT_FOUND,
            Self::Validation(_) => StatusCode::BAD_REQUEST,
            Self::Internal(_) => StatusCode::INTERNAL_SERVER_ERROR,
        }
    }
}
```

## Testing Strategy

### Test Pyramid

```
    /\
   /  \  E2E Tests (few, slow)
  /____\
 /      \ Integration Tests (some, medium)
/________\
Unit Tests (many, fast)
```

### Unit Test Rules

1. **Test behavior, not implementation** — refactor safe
2. **One assertion per test** — clear failure messages
3. **Use test doubles** — mock external dependencies
4. **Name tests descriptively** — `test_user_can_access_own_resource`

### Language Examples

#### Python (pytest)

```python
def test_user_can_access_own_resource():
    user = User(id=uuid4(), email="test@example.com")
    resource = Resource(owner_id=user.id)
    assert user.can_access(resource) is True

def test_user_cannot_access_others_resource():
    user = User(id=uuid4(), email="test@example.com")
    resource = Resource(owner_id=uuid4())  # different owner
    assert user.can_access(resource) is False

# With mocks
@pytest.fixture
def mock_repo():
    return Mock(spec=UserRepository)

def test_service_returns_user(mock_repo):
    user_id = uuid4()
    mock_repo.get_by_id.return_value = User(id=user_id, email="test@example.com")
    
    service = UserService(mock_repo)
    user = service.get_user(user_id)
    
    assert user.id == user_id
    mock_repo.get_by_id.assert_called_once_with(user_id)
```

#### Go

```go
func TestUserCanAccessOwnResource(t *testing.T) {
    user := User{ID: uuid.New(), Email: "test@example.com"}
    resource := Resource{OwnerID: user.ID}
    
    if !user.CanAccess(resource) {
        t.Error("expected user to access own resource")
    }
}

func TestServiceReturnsUser(t *testing.T) {
    mockRepo := &mockUserRepository{
        users: map[uuid.UUID]User{
            testID: {ID: testID, Email: "test@example.com"},
        },
    }
    
    service := NewUserService(mockRepo)
    user, err := service.GetUser(context.Background(), testID)
    
    if err != nil {
        t.Fatalf("unexpected error: %v", err)
    }
    if user.ID != testID {
        t.Errorf("expected %v, got %v", testID, user.ID)
    }
}
```

## Logging

### Structured Logging Principles

1. **Always structured** — JSON or key=value pairs
2. **Include context** — request_id, user_id, trace_id
3. **Log at appropriate levels**:
   - DEBUG: detailed flow, variable values
   - INFO: business events, state changes
   - WARN: recoverable issues, degraded performance
   - ERROR: failures requiring attention
4. **Never log secrets** — passwords, tokens, API keys

### Language Patterns

#### Python

```python
import structlog

logger = structlog.get_logger()

# With context
logger = logger.bind(request_id=request_id, user_id=user_id)
logger.info("user_login", user_email=user.email)

# Error with context
try:
    process_payment(order)
except PaymentError as e:
    logger.error("payment_failed", order_id=order.id, error=str(e))
    raise
```

#### Go

```go
import "log/slog"

logger := slog.With(
    "request_id", requestID,
    "user_id", userID,
)

logger.Info("user_login", "email", user.Email)

if err != nil {
    logger.Error("payment_failed", 
        "order_id", order.ID,
        "error", err,
    )
}
```

#### Rust

```rust
use tracing::{info, error, instrument};

#[instrument(skip(db), fields(user_id = %user_id))]
pub async fn get_user(db: &PgPool, user_id: Uuid) -> Result<User, AppError> {
    info!("fetching_user");
    
    match sqlx::query_as::<_, User>("SELECT * FROM users WHERE id = $1")
        .bind(user_id)
        .fetch_optional(db)
        .await
    {
        Ok(Some(user)) => {
            info!("user_found");
            Ok(user)
        }
        Ok(None) => {
            error!("user_not_found");
            Err(AppError::NotFound("User", user_id))
        }
        Err(e) => {
            error!(error = %e, "database_error");
            Err(e.into())
        }
    }
}
```

## Agent Self-Checking

The most important feature for junior/mid-level developers: **the agent must check its own work**.

### Self-Check Checklist

Before presenting any backend code:

```markdown
## Agent Self-Check

### Architecture
- [ ] Layered architecture followed (API → Service → Repository → Domain)
- [ ] Domain layer has no external dependencies
- [ ] Dependencies point DOWN only
- [ ] No business logic in API layer

### Error Handling
- [ ] Typed errors used (not generic exceptions)
- [ ] Error context preserved (wrap with message)
- [ ] HTTP status codes appropriate
- [ ] Error responses don't leak internal details

### Testing
- [ ] Unit tests for domain logic
- [ ] Service tests with mocked dependencies
- [ ] Edge cases covered (null, empty, invalid)
- [ ] Test names describe behavior

### Logging
- [ ] Structured logging used
- [ ] Context included (request_id, user_id)
- [ ] No secrets logged
- [ ] Appropriate log levels

### Performance
- [ ] No N+1 queries
- [ ] Database queries use indexes
- [ ] Expensive operations not in hot paths
- [ ] Caching considered for read-heavy data

### Security
- [ ] Input validated
- [ ] SQL injection prevented (parameterized queries)
- [ ] No hardcoded secrets
- [ ] Authorization checked before action
```

### Common Mistakes to Catch

**Mistake: Business logic in API layer**
```python
# ❌ Bad
@app.post("/orders")
def create_order(data: OrderCreate):
    if data.quantity <= 0:
        raise HTTPException(400, "Invalid quantity")
    # ... more business logic

# ✅ Good
@app.post("/orders")
def create_order(data: OrderCreate, service: OrderService = Depends()):
    return service.create_order(data)  # validation in service/domain
```

**Mistake: Leaking internal errors**
```python
# ❌ Bad
try:
    db.execute(query)
except Exception as e:
    raise HTTPException(500, str(e))  # leaks DB details

# ✅ Good
try:
    db.execute(query)
except DatabaseError:
    logger.error("database_error", exc_info=True)
    raise HTTPException(500, "Internal server error")
```

**Mistake: N+1 queries**
```python
# ❌ Bad (N+1)
users = db.query(User).all()
for user in users:
    print(user.orders)  # queries orders for each user

# ✅ Good (eager load)
users = db.query(User).options(joinedload(User.orders)).all()
```

## Algorithm & Performance

### Optimal Data Structures by Use Case

| Use Case | Python | Go | Java | Rust |
|----------|--------|-----|------|------|
| Fast lookup | dict/{} | map | HashMap | HashMap |
| Ordered data | list | slice | ArrayList | Vec |
| Unique items | set | map[struct{}] | HashSet | HashSet |
| FIFO queue | deque | channel | LinkedList | VecDeque |
| Sorted data | sorted list | sort.Slice | TreeMap | BTreeMap |

### Performance Checklist

- [ ] Use appropriate data structures (O(1) lookup vs O(n) scan)
- [ ] Batch operations instead of loops
- [ ] Cache expensive computations
- [ ] Use connection pooling for DB/external services
- [ ] Profile before optimizing (don't guess)

## Quick Reference: Language-Specific Best Practices

### Python
- Use `pydantic` for validation
- Use `structlog` for structured logging
- Use `pytest` with fixtures
- Use `sqlalchemy` 2.0 style (type hints)
- Use `ruff` for linting/formatting

### Go
- Use `context.Context` for cancellation
- Return errors, don't panic
- Use `slog` for structured logging
- Use interfaces for testability
- Use `go vet` and `staticcheck`

### Java
- Use records for DTOs
- Use constructor injection
- Use `Optional` for nullable returns
- Use `SLF4J` with logback/log4j2
- Use `JUnit 5` with AssertJ

### Rust
- Use `thiserror` for errors
- Use `tracing` for logging
- Use `tokio` for async
- Use `sqlx` for type-safe SQL
- Use `clippy` for linting

### Node.js/TypeScript
- Use strict TypeScript
- Use `zod` for validation
- Use `pino` for structured logging
- Use `vitest` or `jest` for testing
- Use `eslint` with @typescript-eslint
