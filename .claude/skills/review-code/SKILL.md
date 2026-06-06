---
name: "review-code"
description: "Tool for review-code workflow"
---

# Code Review Skill (/review-code)

This skill automates a smart codebase review by combining **GitNexus** graph mapping and **TencentDB-Agent-Memory** history.

## 🎯 Purpose
Analyze recent changes in the workspace, check them against known historic bugs from the memory database, and suggest improvements based on Karpathy's guidelines.

## 🛠️ Step-by-Step Execution Protocol
1. **Query Memory**:
   - Ask the `agentmemory` service for the most common errors or design decisions recorded in this project.
2. **Scan Codebase**:
   - Ask `gitnexus` to identify the most heavily modified files or files with the highest incoming dependency connections.
3. **Analyze**:
   - Compare the current modified files against the historical bug list to see if any old bugs are being reintroduced.
   - Verify if any modifications violate the "Simplicity First" or "Surgical Edits" principles.
4. **Report**:
   - Present a clean markdown table summarizing potential risks, and suggest simple fixes.



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
