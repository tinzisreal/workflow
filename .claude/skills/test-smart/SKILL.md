---
name: "test-smart"
description: "Tool for test-smart workflow"
---

# Smart Test Skill (/test-smart)

This skill executes test suites and documents results locally and in the memory database.

## 🎯 Purpose
Run verification checks on the workspace code and log status for future debug sessions.

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Detect Changed Files (GitNexus)
1. Call `gitnexus` tool `detect_changes` to identify files with unsaved or unstaged changes.
2. Locate the corresponding test files for those modified components.

### 🟦 Step 2: Run Target Tests
1. Execute the test runner (e.g., npm test, pytest, cargo test) targeting ONLY the test files related to the modified components to save time.
2. If tests fail:
   - Capture console output.
   - Automatically trigger `/debug-smart` to fix the bugs.

### 🟨 Step 3: Run Full Regression Suite
1. Run the entire project test suite to verify that no adjacent components are broken.
2. Collect code coverage metrics if available.

### 🟧 Step 4: Save Verification & Memory
1. Log test results, test command, and coverage percentage to `walkthrough.md`.
2. Call `agentmemory` to save the verification footprint.



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
