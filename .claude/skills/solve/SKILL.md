---
name: "solve"
description: "Tool for solve workflow"
---

# Master Orchestrator Skill (/solve)

This is the ultimate, all-in-one skill for managing any request. It dynamically evaluates task complexity to decide whether to perform a full planning phase or execute a direct surgical fix, while ensuring all toolsets (GitNexus, TencentDB-Agent-Memory, Superpowers TDD) are utilized.

## 🎯 Purpose
Solve any coding task with the optimal balance of safety and speed by dynamically routing the execution flow.

---

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Pre-requisite Context Loading (Every Session)
1. **Query Memory**: Call `agentmemory` to fetch context, past decisions, or historic bugs related to the prompt.
2. **Query Codebase Structure**: Call `gitnexus.context` to inspect symbols or files referenced in the prompt.

### 🟦 Step 2: Triage & Complexity Assessment (Decision Point)
Analyze the request and classify it as **LARGE** or **SMALL** based on the following criteria:

*   **LARGE (Complex, Architectural, or High Risk)**:
    *   *Criteria*: Touches > 2 files, modifies database schemas, introduces new libraries, refactors core logic, or changes API signatures.
    *   *Action*: Route to **Phase A: Brainstorm & Plan**.
*   **SMALL (Trivial, Bug Fix, or Single-file Edit)**:
    *   *Criteria*: Simple syntax edits, single-file bug fixes, adding localized unit tests, or minor style tweaks.
    *   *Action*: Route to **Phase B: Direct Surgical Edit**.

---

## 🚦 ROUTE A: FULL ARCHITECTURAL WORKFLOW (For LARGE tasks)

1. **Brainstorm Approaches**: Run the `/brainstorm` protocol (propose 3 options, check `gitnexus.impact` and `agentmemory` constraints).
2. **Draft Plan**: Write a detailed `implementation_plan.md` using the Superpowers planning template.
3. **Await User Approval**: Do not modify source code until the user approves.
4. **TDD Cycle**: Write failing tests (`/tdd`), execute, and implement minimal code.
5. **Verify & document**: Run `gitnexus.detect_changes`, execute all tests, write `walkthrough.md`, and save session to `agentmemory`.

---

## ⚡ ROUTE B: DIRECT SURGICAL WORKFLOW (For SMALL tasks)

1. **Trace Dependency**: Run a fast check using `gitnexus.context` to ensure the target function has no dangerous downstream side-effects.
2. **Surgical Patch**: Make the minimal required modification (Karpathy's Simplicity First principle). Keep adjacent code untouched.
3. **Targeted Test**: Run the specific test file using `/test-smart` to verify the patch.
4. **Log & Save**: Record the change in `walkthrough.md` and save the session context to `agentmemory`.



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
