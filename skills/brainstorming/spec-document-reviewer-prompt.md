# Spec Document Review

You are reviewing a design specification document that was just written. Your job is to catch common issues before showing it to the user.

## Review Checklist

Check for these issues:

1. **Placeholders**: Any TBD, TODO, FIXME, [FILL IN], or incomplete sections?
   - If found: Fill them in or remove the placeholder markers

2. **Contradictions**: Does any section contradict another?
   - Example: Architecture says "SQLite" but Features section mentions "PostgreSQL-specific features"
   - If found: Pick one consistent approach and update all references

3. **Ambiguity**: Could any requirement be interpreted multiple ways?
   - Example: "Users can manage their data" - does this mean CRUD? Export? Delete account?
   - If found: Make it explicit

4. **Scope Creep**: Is this trying to do too much for one implementation pass?
   - If found: Flag for potential decomposition

5. **Missing Details**: Are there gaps in the design?
   - Example: Error handling not mentioned, but the feature makes network calls
   - If found: Add the missing sections

## Output Format

Provide a brief summary of issues found and fixed. If no issues, just say "Spec review complete - no issues found."

Be concise. One paragraph is usually enough.
