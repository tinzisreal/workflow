# Smart Refactor Skill (/refactor)

This skill performs a safe, structured refactoring of target code using **GitNexus** graph mapping, **TencentDB-Agent-Memory** validation, and **Superpowers** TDD workflows.

## 🎯 Purpose
Refactor code to improve readability, performance, or extensibility while ensuring zero regressions and keeping changes strictly surgical.

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Codebase Impact Analysis (GitNexus Graph RAG)
1. **Query Symbol Context**: Call the `gitnexus` tool `context` on the target function, class, or module to map its callers, callees, and imports.
2. **Analyze Blast Radius**: Call the `gitnexus` tool `impact` on the target files to assess the impact and dependency risks of the refactoring.
3. **Handle Renames Coordinatedly**: If the refactor involves renaming symbols, call the `gitnexus` tool `rename` to automatically propogate modifications across the codebase.
4. List all affected downstream files in a "Downstream Dependency Map".

### 🟦 Step 2: Memory & Design Check (TencentDB-Agent-Memory)
1. Query `openclaw-memory` for past design discussions, performance trade-offs, or constraints related to the target code.
2. Ensure the proposed refactoring does not violate historical engineering requirements or repeat past architectural errors.

### 🟨 Step 3: Write the Refactor Plan (Superpowers Phase 1)
1. Write a structured refactor design to `implementation_plan.md`.
2. Define:
   - What needs to change (Surgical target).
   - What must NOT change (Invariants).
   - Success criteria.
3. **WAIT** for explicit user approval before modifying code.

### 🟧 Step 4: Write Regression Tests First (Superpowers TDD Workflow)
1. Before refactoring the source code, write unit/integration tests that cover the current functionality of the target code.
2. Run these tests to establish a baseline of 100% success.

### 🟥 Step 5: Surgical Implementation & Verification (Karpathy Skills & Superpowers Phase 2)
1. Apply the refactoring using minimal, clean code. Do not introduce speculative abstractions or generic wrappers unless explicitly requested.
2. **Verify Change Scope**: Call the `gitnexus` tool `detect_changes` on the git workspace to verify that only the planned files were altered.
3. Run the tests. If they fail, immediately trigger `/debug-smart`.
4. If they pass, update `walkthrough.md` with:
   - Git diff of the refactored code.
   - Output logs of the test suite.
5. Call `openclaw-memory` to save the refactoring session details (why it was refactored and what was modified).

