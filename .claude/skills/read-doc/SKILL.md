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
2. Under Karpathy's "Simplicity First" guideline, summarize the document's core structure, extracting only the sections, tables, or specifications that are directly relevant to the current coding task.
3. Save the markdown content or key extracted facts into `openclaw-memory` so the agent can refer to it in future sessions without re-parsing.

### 🟧 Step 4: Clean Up (Optional)
1. If the generated markdown is temporary, delete it after extraction, keeping only the synthesized summary in the conversation context.
