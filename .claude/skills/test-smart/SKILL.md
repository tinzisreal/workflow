---
name: "test-smart"
description: "Run targeted unit/integration tests on changed components, run full regression suites, and log outcomes in memory."
---

# Smart Test Skill (/test-smart)

This skill executes scoped tests on recently modified files and runs full regression checks on the workspace codebase, saving execution logs to both the walkthrough and memory.

---

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Detect Changed Files (GitNexus)
* Call the `gitnexus` tool `detect_changes` on the workspace directory to locate modified files.
* Map each modified source file to its corresponding test file:
  - E.g., `src/features/operation/OperationConsole.tsx` -> `src/features/operation/__tests__/OperationConsole.test.tsx`
  - E.g., `src/main/java/.../MetaFlowService.java` -> `src/test/java/.../MetaFlowServiceTest.java`

### 🟦 Step 2: Run Scoped Target Tests
* Execute the test runner targeting **only** the mapped test files to get fast feedback.
  - Command example: `npm test path/to/changed.test.tsx -- -t "specific test description"`
* **Assess Scoped Outcomes**:
  - **Pass**: Proceed to Step 3.
  - **Fail**: Capture the assertion error, halt execution, and run `/debug-smart` to fix the bugs.

### 🟨 Step 3: Run Full Regression Suite
* Run the entire project test suite to verify that no adjacent modules or APIs were broken.
  - Frontend: `npm test` or `npm run test`
  - Backend: `./mvnw test` or `./gradlew test`
* Check code coverage reports if generated, ensuring the new code meets coverage requirements.

### 🟧 Step 4: Document & Save
* Write the test execution stats to `walkthrough.md`:
  - Run command.
  - Total tests run, passed count, failed count.
  - Coverage percentage.
* Call `agentmemory`/`openclaw-memory` to save the verification footprint.

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
