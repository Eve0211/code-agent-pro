---
name: prompt-optimizer
description: Multi-agent team collaboration for prompt engineering. Optimizes prompts through a 4-stage pipeline: Analyst → Optimizer → Reviewer → Refiner, with iterative improvement guided by evaluation scores. Triggers when user asks to optimize, improve, refine, polish, or fix a prompt; wants a better prompt; or needs a prompt reviewed/evaluated.
---

# Prompt Team Optimizer

A multi-agent prompt optimization workflow using a structured 4-stage pipeline. Four specialized agents collaborate sequentially: **Analyst** diagnoses problems, **Optimizer** rewrites, **Reviewer** scores, and **Refiner** iteratively polishes. Output quality improves each round until the Reviewer scores ≥ 8/10 or max rounds reached.

## When to Use

- User says "optimize this prompt", "improve my prompt", "fix this prompt"
- User wants a prompt reviewed or evaluated
- User has a rough prompt idea and needs it polished into a production-ready version
- User asks "make this prompt better"

## 4-Stage Pipeline

### Stage 1 — Analyst (Diagnosis)

**Role:** Examine the raw prompt and diagnose structural weaknesses.

**Task:** Analyze the input prompt from these 5 dimensions:

| Dimension | What to check |
|-----------|--------------|
| **Clarity** | Is the goal unambiguous? Can two people interpret it differently? |
| **Completeness** | Are role, task, constraints, and output format all specified? |
| **Safety** | Any instructions that could cause harmful, biased, or jailbroken output? |
| **Exploitability** | Could the prompt be easily manipulated or circumvented? |
| **Output Control** | Is the desired format, tone, and length clearly specified? |

**Output format (write as structured markdown):**

```
## Diagnosis

### Scores (1-10)
- Clarity: X/10 — [reason]
- Completeness: X/10 — [reason]
- Safety: X/10 — [reason]
- Exploitability: X/10 — [reason]
- Output Control: X/10 — [reason]

### Key Issues Found
1. [Issue] → [Why it matters]
2. ...

### Strengths
- [What's already good]

### Priority Fixes
1. [Most impactful fix]
2. ...
```

---

### Stage 2 — Optimizer (Rewrite)

**Role:** Based on the Analyst's diagnosis, rewrite the prompt into a production-quality version.

**Core rewrite principles:**
- Add a clear **role definition** if missing
- Break complex tasks into **numbered steps**
- Add explicit **output format** constraints (e.g., "respond in JSON", "start with a 1-line summary")
- Inject **safety rails** naturally, not as an afterthought
- Make variable placeholders explicit: `{{variable_name}}`
- Replace vague verbs with precise ones ("analyze" vs "critically examine")
- Add **negative constraints**: what the model should NOT do

**Output:** A complete rewritten prompt, clearly marked.

---

### Stage 3 — Reviewer (Evaluation)

**Role:** Score the Optimizer's output honestly. Do NOT go easy on it.

**Evaluation rubric — rate each dimension 1-10:**

| Dimension | What constitutes a 9-10 score |
|-----------|------------------------------|
| **Clarity** | No ambiguous wording. One reading only. |
| **Completeness** | All necessary context, constraints, and examples are present. |
| **Alignment** | The prompt will reliably produce the intended output for the intended task. |
| **Safety** | No harmful instructions; guardrails are natural, not bolted-on. |
| **Robustness** | Resistant to prompt injection, edge-case confusion, and role confusion. |
| **Output Spec** | Desired format is explicit; model has clear stopping conditions. |

**Calculate overall score:** Average of 6 dimensions, round to 1 decimal.

**Output format:**

```
## Review

### Scores
- Clarity: X/10
- Completeness: X/10
- Alignment: X/10
- Safety: X/10
- Robustness: X/10
- Output Spec: X/10
- **Overall: X.X/10**

### Verdict
[PASS (≥8.0) / NEEDS_WORK (<8.0)]

### Specific Critique
[Be precise: quote the exact prompt text that is problematic and explain why]

### Improvement Suggestions
1. [Actionable, specific fix — not vague]
2. ...
```

---

### Stage 4 — Refiner (Iteration)

**Role:** Apply the Reviewer's specific critiques to produce an improved version.

**If overall score ≥ 8.0:** Output the final prompt marked `## Final Optimized Prompt` and stop. Do not iterate further.

**If overall score < 8.0:** Produce an improved version addressing the top 2-3 critique points. Then **loop back to Stage 3** (Reviewer) with the refined version.

**Max rounds: 3.** After 3 rounds with no score ≥ 8.0, output the best version with a note explaining the remaining limitations.

---

## Iteration Flow

```
Round 1:
  [Analyst] → [Optimizer] → [Reviewer: score < 8]
       ↑                             ↓
       ←←←←← [Refiner] ←←←←←←←←←←←←←
       │
Round 2:
  [Reviewer: score < 8]
       │                             ↓
       ←←←←← [Refiner] ←←←←←←←←←←←←←←
       │
Round 3 (final):
  [Reviewer: score ≥ 8] → [Done]
  or
  [Reviewer: score < 8 after 3 rounds] → [Done with limitations]
```

---

## Usage: Complete Workflow

When the skill triggers, execute the full 4-stage pipeline in sequence. Show the output of each stage so the user can follow the reasoning.

**Prompt to user at start:**
> "Running the 4-stage optimization pipeline: Analyst → Optimizer → Reviewer → Refiner. I'll share each stage's output and iterate until we reach quality threshold or max rounds."

**After Stage 1:** Show diagnosis. Brief confirmation that it's moving to optimization.

**After Stage 2:** Show rewritten prompt. Move to review immediately.

**After Stage 3:** Show scores and critique. If score ≥ 8, deliver final prompt. If < 8, trigger Refiner.

**After Stage 4 (Refiner):** If looping, say "Round N complete. Re-running Reviewer." If final, present the prompt clearly.

---

## Reference Files

- **System prompts for each agent role:** See `references/agent-prompts.md`
- **Score interpretation guide:** See `references/scoring-guide.md`
- **Common prompt anti-patterns:** See `references/anti-patterns.md`

---

## Key Principles

1. **No vague critiques** — quote exact text and explain why it's problematic
2. **Be honest in scoring** — a 6/10 is a 6/10, don't inflate
3. **Focus iteration** — each round must address the top 2-3 specific issues, not everything
4. **Safety first** — if the prompt has harmful intent, refuse and explain why
5. **Variable placeholders** — always use `{{variable}}` syntax for user-provided values
