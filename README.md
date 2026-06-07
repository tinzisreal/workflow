# 🚀 Unified Agent Workflow

An advanced, cross-platform agentic workflow system that integrates the best of **GSD (Get Shit Done)** and **Superpowers** to elevate AI agents (Cursor Composer, Claude Code, Codex, Gemini) into highly reliable, structured, and visual coding partners.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Platform: Cross-Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS%20%7C%20Linux-orange.svg)](#)
[![Workflows: Cursor & Claude](https://img.shields.io/badge/Workflows-Cursor%20%7C%20Claude%20%7C%20Codex-success.svg)](#)

---

## 🗺️ System Overview

This repository provides a set of highly detailed, strict, and portable **Skills** and **Workspace Rules** that force AI models to plan meticulously, analyze code impact, run targeted tests, perform Socratic reviews, and even spin up a local **Visual Companion Server** for visual decision-making (UI mockup selection, diagrams, and design comparison).

```mermaid
graph TD
    User([User Request]) --> Triage{/solve: Master Triage}
    Triage -->|Research & Visual Choices| Brainstorm[/brainstorm: Visual Companion Server]
    Triage -->|Design / Logic| Refactor[/refactor: Safe Restructuring]
    Triage -->|Feature Development| TDD[/tdd: Test-Driven Development]
    Triage -->|Bugs / Failures| Debug[/debug-smart: History-Aware Debug]
    
    Brainstorm -->|A/B Mockups / Choices| Browser([Local Browser Web Companion])
    Refactor -->|Blast Radius Check| GitNexus[GitNexus API & Route Maps]
    
    Refactor --> Verify
    TDD --> Verify
    Debug --> Verify
    
    Verify{/verify-changes} -->|Regression Checks| TestSmart[/test-smart: Targeted Testing]
    TestSmart -->|Pass / Fail Logs| Memory[(Agent Memory Persistence)]
```

---

## 🛠️ Slash Commands Map (`.cursorrules`)

When working with Cursor Composer, Claude CLI, or Codex, you can invoke these custom commands. The agent will read the corresponding skill file and execute the defined protocol step-by-step:

| Command | Skill Path | Description |
| :--- | :--- | :--- |
| **`/solve`** | [solve/SKILL.md](.claude/skills/solve/SKILL.md) | Automatically triages tasks, plans routes, and coordinates other skills. |
| **`/brainstorm`** | [brainstorm/SKILL.md](.claude/skills/brainstorm/SKILL.md) | Generates side-by-side UI/architectural comparisons using the Visual Companion. |
| **`/refactor`** | [refactor/SKILL.md](.claude/skills/refactor/SKILL.md) | Conducts safe codebase refactoring with rollback plans and regression testing. |
| **`/tdd`** | [tdd/SKILL.md](.claude/skills/tdd/SKILL.md) | Enforces a strict Test-Driven Development (Red-Green-Refactor) flow. |
| **`/debug-smart`**| [debug-smart/SKILL.md](.claude/skills/debug-smart/SKILL.md) | Performs history-aware debugging, tracing root causes instead of patching symptoms. |
| **`/explain-flow`**| [explain-flow/SKILL.md](.claude/skills/explain-flow/SKILL.md) | Traces execution graphs, call hierarchies, and outputs Mermaid flows. |
| **`/read-doc`** | [read-doc/SKILL.md](.claude/skills/read-doc/SKILL.md) | Parses PDFs, Word, Excel, and PPTX files into Markdown via Microsoft MarkItDown. |
| **`/test-smart`** | [test-smart/SKILL.md](.claude/skills/test-smart/SKILL.md) | Executes targeted test runs and logs coverage, avoiding long full-suite wait times. |
| **`/verify-changes`**| [verify-changes/SKILL.md](.claude/skills/verify-changes/SKILL.md)| Validates modified scope, creates walkthroughs, and persists memory state. |
| **`/review-code`** | [review-code/SKILL.md](.claude/skills/review-code/SKILL.md) | Performs a Socratic review of proposed code changes for security, performance, and clean code. |

---

## 🎨 `/brainstorm` Visual Companion Server

The **Visual Companion Server** watches a folder and serves live HTML fragments to a local web page. This lets the AI agent present UI mockups, visual A/B choices, and flowchart diagrams. 

To ensure compatibility across operating systems, the server runner has been implemented with **native dual-scripting**:

*   **Linux / macOS**: Runs on Bash via `scripts/start-server.sh` and `scripts/stop-server.sh`.
*   **Windows**: Runs natively on PowerShell via `scripts/start-server.ps1` and `scripts/stop-server.ps1` (with automatic PID monitoring, stderr redirection fallback, and ephemeral temp directory auto-cleanup).

### 🚀 Starting a Session

#### PowerShell (Windows):
```powershell
powershell -ExecutionPolicy Bypass -File .claude/skills/brainstorm/scripts/start-server.ps1 --project-dir .
```

#### Bash (Unix):
```bash
.claude/skills/brainstorm/scripts/start-server.sh --project-dir .
```

### 🛑 Stopping a Session

#### PowerShell (Windows):
```powershell
powershell -ExecutionPolicy Bypass -File .claude/skills/brainstorm/scripts/stop-server.ps1 <session_dir>
```

#### Bash (Unix):
```bash
.claude/skills/brainstorm/scripts/stop-server.sh <session_dir>
```

---

## ⚙️ Installation & Usage

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/tinzisreal/workflow.git
    ```
2.  **For Cursor Users**:
    *   The [.cursorrules](.cursorrules) file in this repository is already configured to point to relative workspace paths.
    *   Whenever you open this directory in Cursor, it will load these custom commands.
3.  **For Global CLI Sync (Multi-Project)**:
    To apply these skills globally across your machine (so that Claude Code, Codex, and Gemini use these standards everywhere), run the synchronization script:
    ```powershell
    # On Windows
    python setup-and-run.ps1
    ```

## 📝 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
