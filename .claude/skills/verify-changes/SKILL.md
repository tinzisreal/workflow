# Verify Changes Skill (/verify-changes)

This skill automates testing, verification, and session documentation.

## 🎯 Purpose
Execute test suites, generate a summary of edits, and save the session context into TencentDB-Agent-Memory.

## 🛠️ Step-by-Step Execution Protocol
1. **Execute Tests**:
   - Locate test files and run them using the workspace test runner commands.
2. **Collect Results**:
   - Check if all tests pass. If there are failures, stop and initiate `/debug-smart`.
3. **Write Walkthrough**:
   - Generate `walkthrough.md` with:
     - Checklist of completed tasks from `task.md`.
     - Raw test runner console output.
4. **Persist Session**:
   - Save the conversation transcript, file edits, and outcomes into the `openclaw-memory` database.
