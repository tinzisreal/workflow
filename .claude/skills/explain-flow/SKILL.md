---
name: "explain-flow"
description: "Trace call graphs, dependencies, and execution flow of target code using GitNexus."
---

# Explain Flow Skill (/explain-flow)

This skill traces the call graph, execution sequence, and module dependencies of a specific code target, creating a visual map to help agents and human developers understand the codebase architecture before modifying files.

---

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Identify the Target Symbol
* Ask the user for the class, method, function, or module name they want to analyze.
* Confirm its general purpose or location in the project if known.

### 🟦 Step 2: Extract Definitions & Context (GitNexus)
* Call `gitnexus.context` to inspect the target symbol's:
  - Definition line numbers and file location.
  - Method signatures, parameters, and return types.
  - Imports and docstrings.
* Read the file section around the target definition using file reading tools.

### 🟨 Step 3: Trace Call Chains (Incoming & Outgoing Connections)
* **Trace Callers (Incoming)**: Run `gitnexus.query` to find all files and functions that *call* this target. This defines the blast radius of changes to this symbol.
* **Trace Callees (Outgoing)**: Run `gitnexus.query` to identify what this target *calls* internally. This defines the dependencies of the target.
* **Trace Module Coupling**: Identify the files involved and how tightly coupled they are to the target.

### 🟧 Step 4: Draft Structured Explanation
Analyze the gathered data and output a concise report containing:
1. **Lifecycle & Control Flow**: Detail exactly what happens when the target is invoked, parameter values, data transformations, and return states.
2. **Side-effects & State Changes**: List any database writes, file operations, or state modifications triggered.
3. **Mermaid Flow Diagram**: Render a clear Mermaid call graph or sequence diagram showing the dependencies and callers.
4. **Key Risks & Constraints**: Highlight potential pitfalls (e.g., race conditions, lock blocks, or legacy dependencies).

---

## Call Graph Visualization Template

Use this Mermaid diagram format when explaining flows:

```mermaid
graph TD
    subgraph Callers (Incoming)
        C1[Caller Module A] --> Target
        C2[Caller Module B] --> Target
    end

    Target[Target Function/Class]

    subgraph Dependencies (Outgoing)
        Target --> D1[Dependency Module X]
        Target --> D2[Dependency Module Y]
    end
```

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
