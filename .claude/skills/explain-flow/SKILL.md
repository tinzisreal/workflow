---
name: "explain-flow"
description: "Tool for explain-flow workflow"
---

# Explain Flow Skill (/explain-flow)

This skill traces the call graph and execution flow of a specific code target.

## 🎯 Purpose
Map call chains, dependencies, and execution flow of a specific function, class, or module using GitNexus.

## 🛠️ Step-by-Step Execution Protocol
1. **Locate Target**:
   - Ask the user for the target class or function name.
2. **Retrieve Code Map**:
   - Call `gitnexus` graph/dependency tools to locate where the target is defined.
   - Trace all files and functions that *call* this target (incoming connections).
   - Trace all files and functions that *are called by* this target (outgoing connections).
3. **Draft Architecture Explanation**:
   - Explain the lifecycle of the target in simple terms.
   - Present a Mermaid diagram showing the call graph.
4. **Enforce Karpathy principle**:
   - Keep the explanation brief and simple. Avoid over-explaining unrelated structures.



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
