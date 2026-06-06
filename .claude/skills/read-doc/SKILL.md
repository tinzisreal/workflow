---
name: "read-doc"
description: "Tool for read-doc workflow"
---

# Read Document Skill (/read-doc)

This skill converts external files (PDF, DOCX, XLSX, PPTX, HTML, ZIP, etc.) into clean Markdown using Microsoft's **MarkItDown** tool, enabling AI agents to read and analyze their content.

## 🎯 Purpose
Extract structured text, tables, and contents from binary files or formatted documents and load them into the agent's context.

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Check Environment
1. Verify if the `markitdown` CLI command is available on the system.
2. If not installed, prompt the user or install it locally:
   `pip install markitdown`

### 🟦 Step 2: Convert Document to Markdown
1. Ask the user for the absolute or relative path to the target document.
2. Run the `markitdown` conversion command in the shell:
   ```bash
   markitdown path/to/document.pdf > path/to/document.md
   ```
3. If conversion fails, capture the error logs and suggest standard formatting fixes.

### 🟨 Step 3: Analyze Document Content
1. Read the newly generated markdown file.
2. Under Karpathy's "Simplicity First" guideline (see below), summarize the document's core structure, extracting only the sections, tables, or specifications that are directly relevant to the current coding task.
3. Save the markdown content or key extracted facts into `agentmemory` so the agent can refer to it in future sessions without re-parsing.

### 🟧 Step 4: Clean Up (Optional)
1. If the generated markdown is temporary, delete it after extraction, keeping only the synthesized summary in the conversation context.



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
