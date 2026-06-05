# Explain Flow Skill (/explain-flow)

This skill traces the call graph and execution flow of a specific code target.

## 🎯 Purpose
Map call chains, dependencies, and execution flow of a specific function, class, or module using GitNexus.

## 🛠️ Step-by-Step Execution Protocol
1. **Locate Target**:
   - Ask the user for the target class or function name.
2. **Retrieve Code Map**:
   - Call `gitnexus` graph/dependency tools to locate where the target is defined.
   - Trace all files and functions that *call* this target (incoming connections).
   - Trace all files and functions that *are called by* this target (outgoing connections).
3. **Draft Architecture Explanation**:
   - Explain the lifecycle of the target in simple terms.
   - Present a Mermaid diagram showing the call graph.
4. **Enforce Karpathy principle**:
   - Keep the explanation brief and simple. Avoid over-explaining unrelated structures.
