---
name: "solve"
description: "Master orchestrator skill for triaging, planning, and executing tasks, combined with GitNexus, AgentMemory, and superpowers subagent handoffs."
---

# Master Orchestrator Skill (/solve)

This is the master orchestrator skill for managing any request. It triages task complexity to route the execution flow, prevents context rot by maintaining specifications in `docs/superpowers/`, and manages subagent-driven execution handoffs.

---

## The Threat of Context Rot
AI agents lose focus and degrade in code quality as their context window fills with discussion history. To combat this, this skill:
1. **Spec-Driven State Management**: Always saves finalized specs to `docs/superpowers/specs/` and plans to `docs/superpowers/plans/` as the project's source of truth.
2. **Subagent Execution (Recommended)**: Encourages executing the plan task-by-task using fresh, isolated subagents, protecting the main session's context.

---

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Pre-requisite Context Loading
1. **Query Memory**: Call `agentmemory`/`openclaw-memory` to fetch context, past decisions, or historic bugs related to the prompt.
2. **Query Codebase Structure**: Call `gitnexus.context` to inspect symbols or files referenced in the prompt.

### 🟦 Step 2: Triage & Complexity Assessment
Analyze the request and classify it as **LARGE** or **SMALL**:

*   **LARGE (Complex, Architectural, or High Risk)**:
    *   *Criteria*: Touches > 2 files, modifies database schemas, introduces new libraries, refactors core logic, or changes API signatures.
    *   *Action*: Route to **ROUTE A: FULL ARCHITECTURAL WORKFLOW**.
*   **SMALL (Trivial, Bug Fix, or Single-file Edit)**:
    *   *Criteria*: Simple syntax edits, single-file bug fixes, adding localized unit tests, or minor style tweaks.
    *   *Action*: Route to **ROUTE B: DIRECT SURGICAL WORKFLOW**.

---

## 🚦 ROUTE A: FULL ARCHITECTURAL WORKFLOW (For LARGE tasks)

### 1. Brainstorm & Design
Run the `/brainstorm` protocol:
- Generate 3 alternative approaches.
- Use `gitnexus.impact` to compare blast radius and `agentmemory` to check historical constraints.
- Present a comparison table, get user design approval, and write the spec to `docs/superpowers/specs/YYYY-MM-DD-<feature-name>-design.md`.

### 2. Draft Implementation Plan
Write a comprehensive implementation plan to `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md` assuming the engineer executing it has zero context.
*   **Plan Header Format**:
    ```markdown
    # [Feature Name] Implementation Plan
    Goal: [One sentence describing what this builds]
    Architecture: [2-3 sentences about approach]
    Tech Stack: [Key technologies/libraries]
    ---
    ```
*   **Bite-Sized Task Structure**: Break down the implementation into task units. Each task must contain:
    - **Step 1: Write failing test** (with exact code snippets showing the test and assertions).
    - **Step 2: Run to verify it fails** (with exact test runner commands and expected error outputs).
    - **Step 3: Write minimal code** (with exact code blocks to pass the test).
    - **Step 4: Run to verify it passes** (with command and expected pass output).
    - **Step 5: Commit** (with exact `git add` and `git commit` commands).
*   **No Placeholders Rule (Strict)**: Do NOT write "TODO", "TBD", "add validation later", or "write tests for the above" without showing the actual test code.

### 3. Await User Approval
Do not write production code or scaffold files until the user has approved the plan. Run a self-review check for type consistency and placeholders before presenting.

### 4. Handoff to Execution
Once the plan is approved, present the user with the execution handoff prompt:
> *"Plan complete and saved to `docs/superpowers/plans/<filename>.md`. Choose your execution route:*
>
> * **1. Subagent-Driven (Recommended to prevent context rot)**: We spawn a fresh, isolated subagent for each task, review output between tasks, and commit.
> * **2. Inline Execution**: We execute tasks sequentially in the current session using checkpoints.*

*   If **Subagent-Driven** is chosen: Dispatch a subagent for the task, review feedback, apply, and repeat.
*   If **Inline Execution** is chosen: Sequential TDD implementation, git commits after each task, and verification.

### 5. Final Verification & Documentation
Run `gitnexus.detect_changes` to verify the blast radius matches the plan, run all tests, write the `walkthrough.md`, and save the session context to `agentmemory`.

---

## ⚡ ROUTE B: DIRECT SURGICAL WORKFLOW (For SMALL tasks)

1. **Trace Dependency**: Run a fast check using `gitnexus.context` or `gitnexus.impact` to ensure the target function has no dangerous downstream side-effects.
2. **Surgical Patch**: Make the minimal required modification (Karpathy's Simplicity First principle). Keep adjacent code untouched.
3. **Targeted Test**: Run the specific test file using `/test-smart` to verify the patch.
4. **Log & Save**: Record the change in `walkthrough.md` and save the session context to `agentmemory`.

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
