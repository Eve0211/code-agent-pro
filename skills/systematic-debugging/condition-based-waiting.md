# Condition-Based Waiting

A pattern for handling asynchronous operations and timing-dependent bugs.

---

## The Problem

Async bugs are hard to debug because:
- They don't reproduce consistently
- The timing varies between environments
- Adding logging can change the timing

---

## Anti-Pattern: Fixed Sleep

❌ **Don't do this:**

```javascript
// This is flaky - may fail on slow machines
await sleep(1000); // "Wait a second"
expect(element).toBeVisible();
```

Problems:
- Too short on slow machines → test fails
- Too long on fast machines → wasted time
- Can never predict the right value

---

## Solution: Condition-Based Waiting

✅ **Do this instead:**

```javascript
// Wait for condition to be true
await waitFor(() => {
  expect(element).toBeVisible();
}, { timeout: 5000 });
```

This:
- Checks immediately (fast on fast machines)
- Retries until timeout (works on slow machines)
- Fails with clear message if never satisfied

---

## Pattern Examples

### Waiting for Element

```javascript
// Playwright
await page.waitForSelector('.loaded');

// Cypress
cy.get('.loaded').should('be.visible');

// Testing Library
await waitFor(() => {
  expect(screen.getByText('Loaded')).toBeInTheDocument();
});
```

### Waiting for State

```javascript
// React Testing Library
await waitFor(() => {
  expect(store.isLoading).toBe(false);
});

// With custom condition
await waitFor(() => {
  return myAsyncOperation.isComplete();
});
```

### Waiting for API Response

```javascript
// Wait for specific network request
await page.waitForResponse(response => 
  response.url().includes('/api/data') && 
  response.status() === 200
);
```

### Waiting for No More Changes

```javascript
// Wait for DOM to stabilize
await waitForElementToBeRemoved(() => 
  screen.queryByTestId('loading')
);
```

---

## Implementing Your Own

If your testing framework doesn't have built-in waiting:

```javascript
async function waitFor(condition, options = {}) {
  const { timeout = 5000, interval = 50 } = options;
  const startTime = Date.now();

  while (Date.now() - startTime < timeout) {
    try {
      await condition();
      return; // Success!
    } catch (error) {
      // Condition not met yet, continue waiting
    }
    await sleep(interval);
  }

  throw new Error(`Timeout after ${timeout}ms waiting for condition`);
}
```

---

## Common Pitfalls

### Pitfall 1: Checking Too Early

```javascript
// ❌ Wrong - element doesn't exist yet
const element = screen.getByText('Loaded');
await waitFor(() => expect(element).toBeVisible());

// ✅ Right - query inside waitFor
await waitFor(() => {
  expect(screen.getByText('Loaded')).toBeVisible();
});
```

### Pitfall 2: Not Handling Rejection

```javascript
// ❌ Wrong - unhandled promise rejection
waitFor(() => someCheck());

// ✅ Right - await the result
await waitFor(() => someCheck());
```

### Pitfall 3: Too Narrow Timeout

```javascript
// ❌ Wrong - may timeout on CI
await waitFor(condition, { timeout: 100 });

// ✅ Right - generous timeout
await waitFor(condition, { timeout: 5000 });
```

---

## Debugging Timeout Failures

If a waitFor times out:

1. **Add logging inside condition:**
   ```javascript
   await waitFor(() => {
     console.log('Current state:', someElement);
     expect(someElement).toBeVisible();
   });
   ```

2. **Check what's actually happening:**
   - Is the condition ever true?
   - Is there an error preventing success?

3. **Increase timeout temporarily:**
   ```javascript
   await waitFor(condition, { timeout: 30000 }); // 30 seconds
   ```

---

## Summary

| Approach | Reliability | Speed |
|----------|-------------|-------|
| Fixed sleep | ❌ Low | ❌ Slow (over-waits) |
| Condition-based | ✅ High | ✅ Fast (checks immediately) |

**Always prefer condition-based waiting over fixed sleep.**
