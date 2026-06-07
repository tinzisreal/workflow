---
name: "read-doc"
description: "Convert binary and formatted documents (PDF, DOCX, XLSX, PPTX, HTML, ZIP, etc.) to Markdown using MarkItDown and extract requirements."
---

# Read Document Skill (/read-doc)

This skill utilizes Microsoft's **MarkItDown** tool to convert binary and formatted documents into clean Markdown, allowing the agent to parse business requirements, database schemas, or API specs into its active context.

---

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Environment & Dependency Validation
1. Verify if Python is installed and check for the `markitdown` CLI tool.
2. If `markitdown` is missing:
   - Request permission to install it:
     ```bash
     python -m pip install --upgrade markitdown
     ```
   - If Python itself is missing, halt execution and ask the user to install Python (v3.9+).

### 🟦 Step 2: Convert Document to Markdown
1. Ask the user for the absolute path to the target document.
2. Execute the conversion command in the shell, redirecting the output to a temporary Markdown file inside the workspace:
   ```bash
   markitdown "path/to/source.pdf" > "path/to/output.md"
   ```
3. **Verify Output**: Check that the generated `.md` file is not empty and contains readable text. If the conversion fails or returns garbage:
   - Identify if the file is password-protected or scanned image-only (requires OCR).
   - Report the limitation factually to the user.

### 🟨 Step 3: Extract & Synthesize Context
1. Read the converted markdown file.
2. **Surgical Extraction**: Extract only the information relevant to the current coding task:
   - For database files: Extract table schemas, indexes, and constraints.
   - For SRS docs: Extract feature definitions, user flows, and business invariants.
   - For API specs: Extract endpoints, payloads, headers, and response codes.
3. Present the synthesized facts in clean markdown tables.

### 🟧 Step 4: Cache to Memory & Clean Up
1. Call `agentmemory`/`openclaw-memory` to save the synthesized requirements, tables, and constraints. This ensures the facts survive session resets.
2. **Clean Workspace**: Delete the temporary `output.md` file using command execution tools to keep the git history pristine.

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
