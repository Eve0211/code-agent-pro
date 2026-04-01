# Pre-flight Check

## Philosophy
The worst outcome in a UI task is writing code only to find out it's not what you wanted. Solution: **define the expected effect clearly, get confirmation, then write code**.

---

## Pre-flight Checklist (Fill Before Writing UI Code)

### Color & Visual
- [ ] What is the primary color? (color code or reference)
- [ ] Is there a distinct accent color or warning color?
- [ ] Light or dark background?

### Layout & Structure
- [ ] Overall layout: sidebar / top-bottom / single column / grid?
- [ ] Spacing preference: loose / compact / standard?
- [ ] Clear hierarchy? (primary / secondary / tertiary)

### Interaction & Animation
- [ ] Any hover / click / focus interactions?
- [ ] Animation needed? (fade / slide / scale / none)
- [ ] Responsive requirements? (desktop / tablet / mobile / all)

### Functionality
- [ ] Component states? (default / hover / disabled / loading / error)
- [ ] Where does data come from? (static / API / local state)
- [ ] Loading / empty / error states displayed?

---

## Announce-Confirm Mechanism

Before writing any UI code, output:

```
🎯 Pre-flight Checklist

Color: [your answer]
Layout: [your answer]
Animation: [your answer]
Functionality: [your answer]

Does this match your expectation? Please confirm before I start coding.
```

**Rules:**
- Do not write code without confirmation
- After confirmation, execute and actively verify against the checklist
- When descriptions are vague, offer 2-3 concrete options for the user to choose

---

## Common Misunderstandings

| What you say | What it might mean to different people |
|---|---|
| "Clean" = no styles | "Clean" could mean lots of whitespace + restrained colors |
| "Modern" = rounded corners + shadows | "Modern" varies wildly across projects |
| "Same as X" = pixel-perfect copy | Need to clarify: which platform/context of X? |
