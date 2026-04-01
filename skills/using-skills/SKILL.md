---
name: using-skills
description: Use when starting any conversation - establishes how to find and use skills, requiring Skill tool invocation before ANY response including clarifying questions
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill.
</SUBAGENT-STOP>

<EXTREMELY-IMPORTANT>
If you think there is even a 1% chance a skill might apply to what you are doing, you ABSOLUTELY MUST invoke the skill.

IF A SKILL APPLIES TO YOUR TASK, YOU DO NOT HAVE A CHOICE. YOU MUST USE IT.

This is not negotiable. This is not optional. You cannot rationalize your way out of this.
</EXTREMELY-IMPORTANT>

## Instruction Priority

User instructions always take precedence over skill defaults:

1. **User's explicit instructions** (CLAUDE.md, AGENTS.md, direct requests) — highest priority
2. **Skills** — override default system behavior where they conflict
3. **Default system prompt** — lowest priority

## How to Access Skills

Use the `Skill` tool to invoke a skill. When you invoke a skill, its content is loaded — follow it directly.

## Skill Activation Flow

Before any response or action, check if skills apply:

```
User message received
    ↓
Might any skill apply? (even 1% chance)
    ↓
YES → Invoke Skill tool → Announce "Using [skill] to [purpose]"
    ↓
    Has checklist? → Create todo per item
    ↓
    Follow skill exactly
    ↓
    Respond / Execute

NO (definitely not) → Respond normally
```

## Red Flags — STOP and Check Skills

These thoughts mean you MUST check for skills:

| Thought | Reality |
|---------|---------|
| "This is just a simple question" | Questions are tasks. Check for skills. |
| "I need more context first" | Skill check comes BEFORE clarifying questions. |
| "Let me explore the codebase first" | Skills tell you HOW to explore. Check first. |
| "I can check git/files quickly" | Files lack conversation context. Check for skills. |
| "Let me gather information first" | Skills tell you HOW to gather information. |
| "This doesn't need a formal skill" | If a skill exists, use it. |
| "I remember this skill" | Skills evolve. Read current version. |
| "This doesn't count as a task" | Action = task. Check for skills. |
| "The skill is overkill" | Simple things become complex. Use it. |
| "I'll just do this one thing first" | Check BEFORE doing anything. |
| "I know what that means" | Knowing the concept ≠ using the skill. Invoke it. |

## Skill Priority

When multiple skills could apply, use this order:

1. **Process skills first** (brainstorming, systematic-debugging) — these determine HOW to approach the task
2. **Implementation skills second** — these guide execution

- "Let's build X" → brainstorming first, then implementation skills
- "Fix this bug" → systematic-debugging first, then domain-specific skills

## Skill Types

- **Rigid** (brainstorming, systematic-debugging): Follow exactly. Don't adapt away discipline.
- **Flexible** (patterns): Adapt principles to context.

The skill itself tells you which.

## Red Flags — Rationalizing Out of Skills

These mean STOP — you're rationalizing:

- "This is too simple to need a skill"
- "I'll check the skill in a moment"
- "The skill doesn't quite fit this case"
- "Let me just do the obvious part first"

If you catch yourself: invoke the skill first, then decide if it applies.
