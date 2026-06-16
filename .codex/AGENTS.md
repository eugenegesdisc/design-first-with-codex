# Project Core Profile
- Project Name: design-first-with-codex
- Primary Stack: Python 3.11, FastAPI, SQLAlchemy, Pytest

# Environment & Dependency Constraints
- Package Manager: Mamba (conda-forge channel)
- Active Environment Name: `design-first-codex`
- Environment Activation Command: `mamba activate design-first-codex`
- Runtime Test Command: `pytest`

# Host Alignment & Security Rules
- The Codex CLI engine runs out of an isolated host toolchain environment (`env4js`).
- All code modifications, shell commands, and test suite invocations MUST execute exclusively within the active project environment: `design-first-codex`.
- Never bypass Mamba using standard `pip install` unless a package is completely unavailable on the `conda-forge` channel.
- Immediately after installing or updating any package via the CLI, run: `mamba env export --no-builds > environment.yml`.

# Process Rules (The ExecPlan Mandate)
- Do not write feature code immediately for complex tasks.
- For any architectural modifications, new endpoints, or tasks touching 3+ files, you MUST initialize an ExecPlan under `.codex/plans/` using the instructions found in `.codex/PLANS.md`.
- Present the plan checklist to the user and await approval before modifying application source files.
