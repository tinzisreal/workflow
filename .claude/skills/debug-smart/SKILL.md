---
name: "debug-smart"
description: "Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes, combined with GitNexus and AgentMemory."
---

# Smart Debug Skill (/debug-smart)

This skill performs a systematic, history-aware debugging analysis, combining GitNexus graph mapping, AgentMemory validations, and strict root cause investigation protocols.

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you have not completed Phase 1 (Root Cause Investigation), you cannot propose or implement fixes. Symptom fixes are a failure.

---

## The Four Phases

You MUST complete each phase in order before proceeding to the next.

### Phase 1: Root Cause Investigation
**BEFORE attempting ANY fix:**
1. **Read Error Messages & Stack Traces:** Complete reading of stack traces, line numbers, file paths, and error codes.
2. **Reproduce Consistently:** Establish the exact steps to trigger the bug reliably. If not reproducible, gather more data.
3. **Check Recent Changes:** Use git diff, review recent commits, dependency changes, or config changes.
4. **Gather Evidence in Multi-Component Systems:**
   If the issue spans multiple layers or components, add diagnostic instrumentation before proposing fixes:
   - Log what data enters each component boundary.
   - Log what data exits each component boundary.
   - Verify environment/config propagation and layer state.
5. **Trace Data Flow:**
   - Locate the source files mentioned in the trace using `gitnexus`.
   - Trace callers and callers of caller to pinpoint the bad value origin. Trace backward through the call stack to find the original trigger. Fix at the source, not the symptom.

### Phase 2: Pattern Analysis
**Find the pattern before fixing:**
1. **Find Working Examples:** Search `agentmemory` and the codebase for similar working code or historical bug solutions.
2. **Compare Against References:** Compare the broken implementation with the working reference line-by-line.
3. **Identify Differences:** List every difference, however small, and verify settings, configuration, and environment assumptions.

### Phase 3: Hypothesis and Testing
**Apply the scientific method:**
1. **Form a Single Hypothesis:** Clearly state: *"I think X is the root cause because Y."*
2. **Test Minimally:** Make the smallest possible change (one variable at a time) to test the hypothesis.
3. **Verify:** Check if it works. If not, revert and form a new hypothesis. Do not stack fixes.

### Phase 4: Implementation & Verification
**Fix the root cause, not the symptom:**
1. **Create Failing Test Case:** Write the simplest automated unit test reproducing the bug. Follow `/tdd` rules.
2. **Surgical Patch:** Address the identified root cause with minimal, clean code. Do not refactor adjacent files.
3. **Verify:** Run the test suite. If they pass, update `walkthrough.md`.
4. **Save to Memory:** Save the debugging session details (why it failed, what was fixed) into `agentmemory` to help future debug sessions.
5. **Question the Architecture (3+ Fixes Fail):**
   If 3+ fixes have failed, STOP. This indicates an architectural problem (e.g., wrong shared state, tight coupling, cascading issues). Discuss with your partner before attempting Fix #4.

---

## Red Flags - STOP and Return to Phase 1
* "Quick fix for now, investigate later".
* "Just try changing X and see if it works".
* "I don't fully understand but this might work".
* Proposing solutions before tracing data flow.
* Attempting a 4th fix after 3 failures without architectural discussion.

---

## Quick Reference

| Phase | Key Activities | Success Criteria |
|-------|---------------|------------------|
| **1. Root Cause** | Read errors, reproduce, check changes, trace data flow | Understand WHAT and WHY |
| **2. Pattern** | Find working examples, compare | Identify differences |
| **3. Hypothesis** | Form theory, test minimally | Confirmed or new hypothesis |
| **4. Implementation** | Create test, fix, verify, save to memory | Bug resolved, tests pass |

---

## 🧠 Karpathy-Inspired Coding Guidelines

To ensure robust and maintainable code, always follow these four core principles inspired by Andrej Karpathy:

### 1. Think Before Coding
**Don't assume. Don't hide confusion. Surface tradeoffs.**
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First
**Minimum code that solves the problem. Nothing speculative.**
- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.
- Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes
**Touch only what you must. Clean up only your own mess.**
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.
- Remove imports/variables/functions that YOUR changes made unused. Don't remove pre-existing dead code unless asked.
- Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution
**Define success criteria. Loop until verified.**
- Transform tasks into verifiable goals (e.g., "Add validation" -> "Write tests for invalid inputs, then make them pass").
- For multi-step tasks, state a brief plan and verify each step.
- Strong success criteria let you loop independently. Weak criteria require constant clarification.
