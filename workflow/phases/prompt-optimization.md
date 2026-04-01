# Prompt Optimization Phase

> Phase: Optimize prompts before critical generation tasks

## Purpose

Use the prompt-optimizer skill to refine and improve prompts before generating critical documents (PRD, Architecture, Implementation plans). This ensures high-quality, precise, and effective outputs.

## When to Use

- Before generating PRD documents
- Before architecture design
- Before task decomposition
- Before complex implementation tasks
- When user provides vague or incomplete requirements

## Input

- Raw user requirements or initial prompt
- Context from previous phases (Clarify, Brainstorming)
- Target document type (PRD, ARCH, PLAN, etc.)

## Output

- Optimized, production-ready prompt
- Diagnosis report (optional)
- Review scores (optional)

---

## 4-Stage Optimization Pipeline

### Stage 1 — Analyst (Diagnosis)

**Examine the raw prompt and diagnose structural weaknesses.**

Analyze from 5 dimensions:

| Dimension | What to check |
|-----------|--------------|
| **Clarity** | Is the goal unambiguous? Can two people interpret it differently? |
| **Completeness** | Are role, task, constraints, and output format all specified? |
| **Safety** | Any instructions that could cause harmful or biased output? |
| **Exploitability** | Could the prompt be easily manipulated or circumvented? |
| **Output Control** | Is the desired format, tone, and length clearly specified? |

**Output:**
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

### Priority Fixes
1. [Most impactful fix]
```

---

### Stage 2 — Optimizer (Rewrite)

**Rewrite the prompt into a production-quality version.**

**Core principles:**
- Add clear **role definition** if missing
- Break complex tasks into **numbered steps**
- Add explicit **output format** constraints
- Inject **safety rails** naturally
- Make variable placeholders explicit: `{{variable_name}}`
- Replace vague verbs with precise ones
- Add **negative constraints**: what NOT to do

---

### Stage 3 — Reviewer (Evaluation)

**Score the optimized prompt honestly.**

| Dimension | What constitutes a 9-10 score |
|-----------|------------------------------|
| **Clarity** | No ambiguous wording. One reading only. |
| **Completeness** | All necessary context, constraints, and examples are present. |
| **Alignment** | The prompt will reliably produce the intended output. |
| **Safety** | No harmful instructions; guardrails are natural. |
| **Robustness** | Resistant to prompt injection and edge-case confusion. |
| **Output Spec** | Desired format is explicit; clear stopping conditions. |

**Verdict:**
- **PASS (≥8.0)**: Proceed to generation
- **NEEDS_WORK (<8.0)**: Go to Refiner

---

### Stage 4 — Refiner (Iteration)

**Apply the Reviewer's critiques to produce an improved version.**

- If score ≥ 8.0: Output final prompt and proceed
- If score < 8.0: Address top 2-3 issues and loop back to Reviewer
- **Max rounds: 3**

---

## Integration Points

### Before PRD Generation

**Trigger:** After Clarify/Brainstorming phases

**Input:** Clarified requirements + user context

**Output:** Optimized PRD generation prompt

**Template:**
```
You are a senior product manager. Create a comprehensive PRD for:

Product: {{product_name}}
Target Users: {{target_users}}
Core Features: {{features}}
Constraints: {{constraints}}

Requirements:
1. Follow the PRD structure in code-agent-pro workflow
2. Include user stories with acceptance criteria
3. Define clear P0/P1/P2 priorities
4. Add non-functional requirements
5. Output in markdown format

Do NOT:
- Include implementation details
- Make assumptions about technology
- Skip acceptance criteria
```

---

### Before Architecture Design

**Trigger:** After PRD is complete

**Input:** PRD document + codebase analysis (if exists)

**Output:** Optimized architecture design prompt

**Template:**
```
You are a senior architect. Design the system architecture based on:

PRD: {{prd_summary}}
Tech Stack: {{detected_stack}}
Constraints: {{constraints}}

Requirements:
1. Present 3 architecture options (Minimal, Clean, Pragmatic)
2. Include system diagram (ASCII or description)
3. Define module boundaries and interfaces
4. Specify data models
5. Justify technology choices

Do NOT:
- Skip the trade-off analysis
- Ignore existing codebase patterns
- Over-engineer (follow YAGNI)
```

---

### Before Task Decomposition

**Trigger:** After Architecture is approved

**Input:** Architecture document + PRD

**Output:** Optimized task breakdown prompt

**Template:**
```
You are a technical lead. Decompose the implementation into tasks:

Architecture: {{arch_summary}}
Features: {{feature_list}}
Dependencies: {{dependency_graph}}

Requirements:
1. Break into atomic, actionable tasks
2. Identify dependencies between tasks
3. Estimate complexity (S/M/L)
4. Assign priority order
5. Include acceptance criteria per task

Do NOT:
- Create tasks larger than 1 day of work
- Skip dependency mapping
- Forget test tasks
```

---

## Workflow Integration

### Greenfield Workflow

```
Clarify → Brainstorming → [PROMPT OPTIMIZATION] → PRD → [PROMPT OPTIMIZATION] → Architecture → [PROMPT OPTIMIZATION] → Task Decomposition → Implementation
```

### Mature Project Workflow

```
Codebase Analysis → Clarify → [PROMPT OPTIMIZATION] → Architecture → Task Decomposition → Implementation
```

### Quick Fix Workflow

**Skip prompt optimization** for speed.

---

## Blocking Gate

After prompt optimization:

> "Prompt optimized (Score: X.X/10). Ready to proceed with {{document_type}} generation?"

Wait for user confirmation before proceeding.

---

## Quality Threshold

- **Score ≥ 8.0**: Proceed with generation
- **Score 6.0-7.9**: Show optimized prompt, ask user if they want to proceed or refine further
- **Score < 6.0**: Must iterate at least once

---

## Output Location

Optimization reports saved to:
- `{PROJECT_ROOT}/docs/prompt-optimization-{document-type}.md`
- Include: Original prompt, diagnosis, optimized prompt, final score
