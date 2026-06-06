---
name: "tdd"
description: "Tool for tdd workflow"
---

# Test-Driven Development Skill (/tdd)

This skill implements the strict Superpowers Test-Driven Development (TDD) workflow in the workspace.

## 🎯 Purpose
Ensure all code changes are verified by writing unit/integration tests before writing the implementation code.

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Write a Failing Test (Red Phase)
1. Read target requirements or user instructions.
2. Write one or more unit tests in the test suite that cover the new feature or fix.
3. Run the test suite.
4. **Exit Condition**: Ensure the new tests fail with a clear assertion error (verifying that the tests are active).

### 🟦 Step 2: Minimal Code Implementation (Green Phase)
1. Write the minimal amount of code in the source files to make the tests pass.
2. Follow Karpathy's "Simplicity First" guideline (see below)—do not add extra logic, helper functions, or extensions.
3. Run the test suite.
4. **Exit Condition**: Verify that all tests, including the new tests, pass successfully.

### 🟨 Step 3: Refactor (Refactor Phase)
1. Clean up code styling, extract magic variables, and improve readability of the implemented code.
2. Run the test suite after every minor change to ensure no regressions.
3. Call `agentmemory` to save the successful test outcomes and implementation footprint.



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
