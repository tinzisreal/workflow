---
name: "brainstorm"
description: "Tool for brainstorm workflow"
---

# Brainstorm Skill (/brainstorm)

This skill implements the Superpowers brainstorming workflow to evaluate multiple technical paths before selecting one.

## 🎯 Purpose
Collaboratively brainstorm alternative approaches for a complex task, analyze feasibility using the codebase graph, and check memory databases to avoid past mistakes.

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Generate Multiple Approaches (Superpowers Brainstorming)
1. Read the user's feature request or issue.
2. Outline **at least 3 different approaches** to solve the problem (e.g., Approach A: Simple inline fix, Approach B: Refactor module, Approach C: Add helper utility).
3. Do not choose one immediately.

### 🟦 Step 2: Feasibility & Dependency Mapping (GitNexus)
1. For each proposed approach, call `gitnexus` to map out the required files, call chains, or library dependencies.
2. Evaluate:
   - What components will be affected?
   - How does the "blast radius" compare between the approaches?

### 🟨 Step 3: Historical Constraint Verification (TencentDB-Agent-Memory)
1. Query `agentmemory` for past design discussions, performance pitfalls, or constraints related to the modules targetted by each approach.
2. Exclude any approaches that repeat past failures or run counter to established system invariants.

### 🟧 Step 4: Compare Pros, Cons & Trade-offs
1. Present a clear comparison table to the user detailing:
   - Complexity (Karpathy's Simplicity First principle).
   - Downstream impact (GitNexus blast radius).
   - Time to implement and verify.
2. Highlight the recommended approach first.
3. **WAIT** for the user to select the final approach before starting implementation.



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
