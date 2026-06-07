---
name: "review-code"
description: "Use when requesting or receiving code review, before merging or implementing suggestions, combined with GitNexus and AgentMemory."
---

# Code Review Skill (/review-code)

This skill automates and structures the code review process, divided into **Requesting Code Review** (dispatching reviewers) and **Receiving Code Review** (evaluating feedback factually and technically, avoiding performative agreement).

---

## Part 1: Requesting Code Review

Dispatch a code reviewer subagent to catch issues before they compound. The reviewer gets precisely crafted context for evaluation — never your session's history. This keeps the reviewer focused on the work product, not your thought process.

### When to Request Review
* **Mandatory**:
  - After each task in subagent-driven development.
  - After completing major features.
  - Before merging changes into `main`.
* **Optional but valuable**:
  - When stuck (fresh perspective).
  - Before refactoring (baseline check).
  - After fixing complex bugs.

### How to Request
1. **Identify Git SHAs**:
   ```bash
   BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
   HEAD_SHA=$(git rev-parse HEAD)
   ```
2. **Scan Codebase & Map Changes**:
   - Ask `gitnexus` to identify the modified files and check incoming/outgoing dependency blast radius.
   - Query `agentmemory` for historical errors or design decisions recorded in this project.
3. **Dispatch Code Reviewer Subagent**:
   Provide the reviewer with:
   - **Description**: Summary of what was built.
   - **Plan / Requirements**: What the code is expected to do.
   - **SHAs**: The starting (`BASE_SHA`) and ending (`HEAD_SHA`) commits.
4. **Act on feedback**:
   - Fix **Critical** issues immediately.
   - Fix **Important** issues before proceeding.
   - Note **Minor** issues for later.

---

## Part 2: Receiving Code Review

Code review requires technical evaluation and verification, not emotional performance.

### The Response Pattern
1. **READ**: Complete feedback without reacting.
2. **UNDERSTAND**: Restate the technical requirements in your own words. Ask for clarification if needed.
3. **VERIFY**: Check the reviewer's feedback against codebase reality.
4. **EVALUATE**: Confirm if suggestions are technically sound for this codebase.
5. **RESPOND**: Give a technical acknowledgment or a reasoned pushback.
6. **IMPLEMENT**: Implement changes one item at a time, testing each.

### Forbidden Responses (DO NOT USE)
* "You're absolutely right!"
* "Great point!" / "Excellent feedback!"
* "Let me implement that now" (before verifying).

**Instead**:
- Restate the technical requirement factually.
- Just start working (actions speak louder than words).
- If pushing back, provide technical reasoning.

### Strict "No Thanks" Rule
When feedback is correct, state the fix factually.
* **Good**: *"Fixed. [Brief description of what changed]"* or *"Good catch - [specific issue]. Fixed in [location]."*
* **Bad**: *"Thanks for catching that!"* / *"Thanks for [anything]"* / **ANY expression of gratitude**. State the fix factually and move on.

### Skepticism & Pushback
Push back when the suggestion:
- Breaks existing functionality.
- Lacks full context.
- Violates YAGNI (e.g., adding "professional" features that aren't used).
- Conflicts with prior architectural decisions.
- If suggestions are unclear, **STOP** and ask for clarification before implementing.

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
