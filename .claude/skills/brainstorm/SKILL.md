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
1. Query `openclaw-memory` for past design discussions, performance pitfalls, or constraints related to the modules targetted by each approach.
2. Exclude any approaches that repeat past failures or run counter to established system invariants.

### 🟧 Step 4: Compare Pros, Cons & Trade-offs
1. Present a clear comparison table to the user detailing:
   - Complexity (Karpathy's Simplicity First principle).
   - Downstream impact (GitNexus blast radius).
   - Time to implement and verify.
2. Highlight the recommended approach first.
3. **WAIT** for the user to select the final approach before starting implementation.
