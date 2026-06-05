# Smart Test Skill (/test-smart)

This skill executes test suites and documents results locally and in the memory database.

## 🎯 Purpose
Run verification checks on the workspace code and log status for future debug sessions.

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Detect Changed Files (GitNexus)
1. Call `gitnexus` tool `detect_changes` to identify files with unsaved or unstaged changes.
2. Locate the corresponding test files for those modified components.

### 🟦 Step 2: Run Target Tests
1. Execute the test runner (e.g., npm test, pytest, cargo test) targeting ONLY the test files related to the modified components to save time.
2. If tests fail:
   - Capture console output.
   - Automatically trigger `/debug-smart` to fix the bugs.

### 🟨 Step 3: Run Full Regression Suite
1. Run the entire project test suite to verify that no adjacent components are broken.
2. Collect code coverage metrics if available.

### 🟧 Step 4: Save Verification & Memory
1. Log test results, test command, and coverage percentage to `walkthrough.md`.
2. Call `openclaw-memory` to save the verification footprint.
