# Smart Debug Skill (/debug-smart)

This skill performs a history-aware debugging analysis.

## 🎯 Purpose
Analyze a runtime error or bug report, cross-referencing past fixes in TencentDB-Agent-Memory and the codebase graph in GitNexus.

## 🛠️ Step-by-Step Execution Protocol
1. **Analyze Error Trace**:
   - Parse the error message or stack trace provided by the user.
2. **Query Memory**:
   - Search `openclaw-memory` for similar error logs, stack traces, or keywords from previous debug sessions.
3. **Map codebase error path**:
   - Use `gitnexus` to locate the source files mentioned in the stack trace.
   - Trace callers and callers of caller to pinpoint potential side-effects.
4. **Formulate Solution**:
   - Offer the most minimal, surgical fix that addresses the root cause without introducing speculative abstractions.
   - List the historical similar occurrences (if any) and how they were solved.
