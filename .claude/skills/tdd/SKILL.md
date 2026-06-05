# Test-Driven Development Skill (/tdd)

This skill implements the strict Superpowers Test-Driven Development (TDD) workflow in the workspace.

## 🎯 Purpose
Ensure all code changes are verified by writing unit/integration tests before writing the implementation code.

## 🛠️ Step-by-Step Execution Protocol

### 🟩 Step 1: Write a Failing Test (Red Phase)
1. Read target requirements or user instructions.
2. Write one or more unit tests in the test suite that cover the new feature or fix.
3. Run the test suite.
4. **Exit Condition**: Ensure the new tests fail with a clear assertion error (verifying that the tests are active).

### 🟦 Step 2: Minimal Code Implementation (Green Phase)
1. Write the minimal amount of code in the source files to make the tests pass.
2. Follow Karpathy's "Simplicity First" guideline—do not add extra logic, helper functions, or extensions.
3. Run the test suite.
4. **Exit Condition**: Verify that all tests, including the new tests, pass successfully.

### 🟨 Step 3: Refactor (Refactor Phase)
1. Clean up code styling, extract magic variables, and improve readability of the implemented code.
2. Run the test suite after every minor change to ensure no regressions.
3. Call `openclaw-memory` to save the successful test outcomes and implementation footprint.
