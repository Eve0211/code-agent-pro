# Defense in Depth

Prevent bugs from recurring through multiple layers of protection.

---

## The Principle

One defense is never enough. Layer multiple protections so if one fails, another catches the issue.

```
Input → [Validation] → [Sanitization] → [Business Logic] → [Database] → [Output]
           ↑               ↑                  ↑                ↑           ↑
        Layer 1         Layer 2           Layer 3          Layer 4     Layer 5
```

---

## Layer 1: Input Validation

**First line of defense — reject bad data early.**

### Type Validation

```javascript
// TypeScript
function processUser(user: { id: string; name: string }) {
  // TypeScript enforces at compile time
}

// Runtime validation (Zod, Joi, etc.)
const UserSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(1).max(100),
  email: z.string().email(),
  age: z.number().int().min(0).max(150).optional(),
});

const user = UserSchema.parse(input); // Throws on invalid
```

### Boundary Checks

```javascript
// Check array bounds
function getItem(array, index) {
  if (index < 0 || index >= array.length) {
    throw new RangeError(`Index ${index} out of bounds`);
  }
  return array[index];
}

// Check numeric ranges
function setPercentage(value) {
  if (value < 0 || value > 100) {
    throw new RangeError('Percentage must be 0-100');
  }
  this.percentage = value;
}
```

### Null/Undefined Checks

```javascript
// Early return pattern
function process(data) {
  if (!data) {
    return null; // or throw, or default value
  }
  // Continue with valid data
}

// Optional chaining
const name = user?.profile?.name ?? 'Unknown';
```

---

## Layer 2: Sanitization

**Clean data before use.**

### String Sanitization

```javascript
// Trim whitespace
const name = input.trim();

// Remove HTML tags (XSS prevention)
import DOMPurify from 'dompurify';
const clean = DOMPurify.sanitize(userInput);

// Escape for SQL (use parameterized queries instead!)
// NEVER do this: `SELECT * FROM users WHERE name = '${name}'`
// ALWAYS do this:
db.query('SELECT * FROM users WHERE name = $1', [name]);
```

### Type Coercion

```javascript
// Explicit coercion with validation
function parseId(input) {
  const id = parseInt(input, 10);
  if (isNaN(id) || id <= 0) {
    throw new Error('Invalid ID');
  }
  return id;
}
```

---

## Layer 3: Business Logic Guards

**Protect business rules.**

### Preconditions

```javascript
function withdraw(account, amount) {
  // Precondition: amount must be positive
  if (amount <= 0) {
    throw new Error('Amount must be positive');
  }
  
  // Precondition: sufficient balance
  if (account.balance < amount) {
    throw new Error('Insufficient funds');
  }
  
  // Business rule: daily limit
  if (account.dailyWithdrawn + amount > account.dailyLimit) {
    throw new Error('Daily limit exceeded');
  }
  
  // Safe to proceed
  account.balance -= amount;
  account.dailyWithdrawn += amount;
}
```

### Postconditions

```javascript
function createUser(data) {
  const user = new User(data);
  
  // ... create logic ...
  
  // Postcondition: user must have ID
  if (!user.id) {
    throw new Error('User creation failed: no ID assigned');
  }
  
  // Postcondition: user must be persisted
  const saved = await db.users.find(user.id);
  if (!saved) {
    throw new Error('User creation failed: not persisted');
  }
  
  return user;
}
```

### Invariants

```javascript
class BankAccount {
  #balance = 0;
  
  get balance() { return this.#balance; }
  
  deposit(amount) {
    if (amount <= 0) throw new Error('Invalid deposit');
    this.#balance += amount;
    this.#checkInvariant();
  }
  
  withdraw(amount) {
    if (amount <= 0) throw new Error('Invalid withdraw');
    if (this.#balance < amount) throw new Error('Insufficient funds');
    this.#balance -= amount;
    this.#checkInvariant();
  }
  
  #checkInvariant() {
    // Invariant: balance must never be negative
    if (this.#balance < 0) {
      throw new Error('Invariant violated: negative balance');
    }
  }
}
```

---

## Layer 4: Database Constraints

**Let the database catch what code misses.**

### Schema Constraints

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL,
  age INTEGER CHECK (age >= 0 AND age <= 150),
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE orders (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  total DECIMAL(10,2) NOT NULL CHECK (total >= 0),
  status VARCHAR(20) NOT NULL DEFAULT 'pending'
);
```

### Transaction Safety

```javascript
async function transfer(fromId, toId, amount) {
  await db.transaction(async (tx) => {
    // Lock rows for update
    const from = await tx.query(
      'SELECT * FROM accounts WHERE id = $1 FOR UPDATE', [fromId]
    );
    const to = await tx.query(
      'SELECT * FROM accounts WHERE id = $1 FOR UPDATE', [toId]
    );
    
    if (from.balance < amount) {
      throw new Error('Insufficient funds'); // Auto-rollback
    }
    
    await tx.query(
      'UPDATE accounts SET balance = balance - $1 WHERE id = $2',
      [amount, fromId]
    );
    await tx.query(
      'UPDATE accounts SET balance = balance + $1 WHERE id = $2',
      [amount, toId]
    );
  }); // Commit on success, rollback on error
}
```

---

## Layer 5: Error Handling & Logging

**When defenses fail, know what happened.**

### Structured Error Handling

```javascript
class AppError extends Error {
  constructor(message, code, details = {}) {
    super(message);
    this.code = code;
    this.details = details;
    this.timestamp = new Date().toISOString();
  }
}

// Usage
if (!user) {
  throw new AppError('User not found', 'USER_NOT_FOUND', { userId });
}
```

### Logging

```javascript
// Log at appropriate levels
logger.debug('Processing request', { requestId, params });
logger.info('User created', { userId, email });
logger.warn('Rate limit approaching', { userId, requestsRemaining });
logger.error('Database connection failed', { error: err.message, stack: err.stack });

// Include context for debugging
logger.error('Order creation failed', {
  orderId,
  userId,
  error: err.message,
  stack: err.stack,
  input: sanitizedInput,
});
```

### Monitoring & Alerts

```javascript
// Track errors in production
try {
  await processOrder(order);
} catch (error) {
  // Log locally
  logger.error('Order processing failed', { orderId, error });
  
  // Send to monitoring service
  Sentry.captureException(error, { extra: { orderId } });
  
  // Alert on critical errors
  if (error.code === 'PAYMENT_FAILED') {
    await alertTeam(`Payment failed for order ${orderId}`);
  }
  
  throw error; // Re-throw for handling
}
```

---

## Defense Checklist

After fixing a bug, add defenses:

- [ ] **Input validation** — Can bad input be rejected earlier?
- [ ] **Sanitization** — Is data cleaned before use?
- [ ] **Business logic** — Are preconditions/postconditions enforced?
- [ ] **Database** — Can constraints catch this?
- [ ] **Logging** — Will we know if this happens again?
- [ ] **Tests** — Is there a test that would have caught this?

---

## Summary

| Layer | Purpose | Example |
|-------|---------|---------|
| Validation | Reject bad input early | Type checks, bounds checks |
| Sanitization | Clean data | Trim, escape, decode |
| Business Logic | Enforce rules | Preconditions, invariants |
| Database | Final safety net | Constraints, transactions |
| Error Handling | Know what failed | Logging, monitoring |

**Multiple layers = Robust software.**
