# Common Prompt Anti-Patterns

## 1. Vague Role Definitions

❌ "You are a helpful assistant"
❌ "Act as an expert"
❌ "You are smart"

✅ "You are a senior software architect with 15 years specializing in distributed systems and event-driven microservices."

**Why:** Generic roles give the model nothing to work with. Specific backgrounds shape reasoning style and domain knowledge.

---

## 2. Missing Output Format

❌ "Write a summary of this article"
❌ "Give me feedback on my code"

✅ "Summarize the article in exactly 3 sentences: (1) the main claim, (2) the key evidence, (3) one remaining open question. If the article doesn't support a clear claim, say 'UNCLEAR'."

**Why:** Without format constraints, output length and structure vary wildly. Format specs also force the model to think structured.

---

## 3. No Negative Constraints

❌ "Help me write a product description"

✅ "Write a product description for {{product_name}}. Focus on benefits, not features. Do NOT mention price, competitor names, or use superlatives (best, greatest, amazing)."

**Why:** Models don't know what you don't want unless you tell them explicitly. Negative constraints dramatically reduce off-target output.

---

## 4. Compound Tasks Without Steps

❌ "Review this code and fix bugs and improve performance and add tests"

✅ "Analyze the code in 3 phases: (1) Identify bugs — list each bug with file:line reference. (2) Fix critical bugs first (crash-causing, data loss), then minor ones. (3) Add unit tests for each fixed bug."

**Why:** Models perform better with explicit sequencing. Compound tasks without steps often result in superficial coverage of all items.

---

## 5. Missing Edge Case Handling

❌ "Extract the email addresses from this text"

✅ "Extract all email addresses from the text. If no emails are found, respond with exactly: `NONE`. If the text contains invalid email-like strings (missing @ or domain), ignore them and list only valid ones. Format: one email per line."

**Why:** Without edge case handling, models make assumptions. Proactively handling edge cases is the difference between a production prompt and a demo.

---

## 6. Weak Variable Placeholders

❌ "Write an email to customer about their order"
❌ "Summarize the document"
❌ "Review this code"

✅ "Write a customer service reply email. Customer name: {{customer_name}}. Order number: {{order_id}}. Issue: {{issue_description}}. Tone: professional but empathetic."

**Why:** `{{variable}}` syntax makes placeholders explicit and scannable. Natural language references ("their order") are easy to miss during editing.

---

## 7. "Do Your Best" Syndrome

❌ "Analyze this dataset and tell me what's interesting about it"
❌ "Give me your thoughts on this"

✅ "From this dataset, identify: (1) the top 3 outliers by z-score, (2) any correlations above 0.7, (3) a notable trend over time. Present as a structured markdown table."

**Why:** "Do your best" gives the model permission to be shallow. Specific deliverables force depth.

---

## 8. Unenforceable Safety Instructions

❌ "Don't say anything harmful"
❌ "Only provide safe information"

✅ "If the user requests information that could cause harm (self-harm, illegal acts, medical emergencies), respond with: 'I can't help with that. Please contact a professional: [relevant resource].' Do not elaborate further."

**Why:** Vague safety instructions are easily bypassed. Concrete refusal scripts with external resources are more robust.

---

## 9. No Stopping Conditions

❌ "Explain quantum computing" (model could write a book)

✅ "Explain quantum computing to a technical but non-specialist audience in 200-300 words. Start with a real-world analogy. End with one open research question. Do not exceed 300 words."

**Why:** LLMs will fill whatever space is available. Explicit stopping conditions control output length and focus.

---

## 10. Conflicting Instructions

❌ "Be concise but also comprehensive"
❌ "Give a brief overview but include all details"

✅ "Give a 3-sentence overview first. Then, if the user asks for more detail, expand into full analysis."

**Why:** Conflicting instructions produce confused output. If two goals genuinely trade off, prioritize one and defer the other to a second step.
