# Code Review Skill (/review-code)

This skill automates a smart codebase review by combining **GitNexus** graph mapping and **TencentDB-Agent-Memory** history.

## 🎯 Purpose
Analyze recent changes in the workspace, check them against known historic bugs from the memory database, and suggest improvements based on Karpathy's guidelines.

## 🛠️ Step-by-Step Execution Protocol
1. **Query Memory**:
   - Ask the `openclaw-memory` service for the most common errors or design decisions recorded in this project.
2. **Scan Codebase**:
   - Ask `gitnexus` to identify the most heavily modified files or files with the highest incoming dependency connections.
3. **Analyze**:
   - Compare the current modified files against the historical bug list to see if any old bugs are being reintroduced.
   - Verify if any modifications violate the "Simplicity First" or "Surgical Edits" principles.
4. **Report**:
   - Present a clean markdown table summarizing potential risks, and suggest simple fixes.
