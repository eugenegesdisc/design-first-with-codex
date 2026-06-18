# Project Core Profile
- Project Name: design-first-with-codex
- Primary Stack: Python 3.11, FastAPI, SQLAlchemy, Pytest

# Environment & Dependency Constraints
- Package Manager: Mamba (conda-forge channel)
- Active Environment Name: `design-first-codex`
- Environment Activation Command: `mamba activate design-first-codex`
- Runtime Test Command: `python -m pytest`

# Host Alignment & Security Rules
- The Codex CLI engine runs out of an isolated host toolchain environment (`env4js`).
- All code modifications, shell commands, and test suite invocations MUST execute exclusively within the active project environment: `design-first-codex`.
- Never bypass Mamba using standard `pip install` unless a package is completely unavailable on the `conda-forge` channel.
- Immediately after installing or updating any package via the CLI, run: 
  `mamba env export --no-builds | grep -v "^prefix:" > environment.yml`.

# Documentation & Portability Rules

## Absolute Path Prohibition
- **NEVER** include absolute paths in any documentation, README, comments, or configuration files.
- **NEVER** use paths containing:
  - `/Users/<username>/...`
  - `~/miniforge3/...` or `~/anaconda3/...`
  - `/home/<username>/...`
  - `/opt/conda/...` with full environment paths
  - Any system-specific or user-specific paths
- All commands and examples must be portable and work on any machine with the correct mamba environment activated.
- When creating examples, ALWAYS use generic placeholders like `<username>`, `<project-name>`, or `<path>`.

## Command Documentation Standards
All executable commands in documentation MUST follow the two-step activation pattern with `python -m` prefix where applicable.

### Pattern 1: Python Module Invocation (STRONGLY PREFERRED)
Always use `python -m` to invoke Python modules:

```bash
mamba activate design-first-codex
python -m pytest
```

```bash
mamba activate design-first-codex
python -m uvicorn app.main:app --reload
```

```bash
mamba activate design-first-codex
python -m pip list  # If needed (prefer 'mamba list')
```

### Pattern 2: Direct Command (Acceptable Alternative)
Only when `python -m` is not applicable:

```bash
mamba activate design-first-codex
uvicorn app.main:app --reload
```

### Pattern 3: Script Execution
For custom scripts:

```bash
mamba activate design-first-codex
python scripts/script_name.py
```

### Pattern 4: Mamba Commands
For package management:

```bash
mamba activate design-first-codex
mamba list
mamba install -c conda-forge <package-name>
```

## Command Documentation Enforcement

### ✅ CORRECT Examples:
```bash
# Testing
mamba activate design-first-codex
python -m pytest

# Running server
mamba activate design-first-codex
python -m uvicorn app.main:app --reload

# Script execution
mamba activate design-first-codex
python scripts/process_data.py

# Package management
mamba activate design-first-codex
mamba list
```

### ❌ FORBIDDEN Examples:
```bash
# Absolute paths - NEVER USE THESE PATTERNS
/Users/<username>/miniforge3/envs/design-first-codex/bin/python
/home/<username>/anaconda3/envs/design-first-codex/bin/uvicorn
~/miniforge3/envs/design-first-codex/bin/pytest
/opt/conda/envs/design-first-codex/bin/python
C:\Users\<username>\Anaconda3\envs\design-first-codex\Scripts\python.exe

# Direct commands without activation - AVOID
pytest  # Which pytest? System or environment?
uvicorn app.main:app  # Ambiguous - which uvicorn?

# Commands without python -m prefix - AVOID IN DOCS
pytest  # Use: python -m pytest
uvicorn app.main:app  # Use: python -m uvicorn app.main:app
```

## Why These Rules Exist
1. **Portability**: Documentation will be committed to GitHub and used by others on different machines
2. **Clarity**: Absolute paths break across different users, systems, and OS platforms
3. **Explicitness**: The two-step pattern (activate + command) ensures correct environment resolution
4. **Determinism**: `python -m` explicitly uses the environment's Python interpreter, avoiding PATH ambiguity
5. **Reproducibility**: Anyone can follow the documentation and get the same results
6. **Security**: No personal information exposed in public repositories

## Example Creation Guidelines
When creating documentation examples:
- ✅ Use placeholders: `<username>`, `<project-name>`, `<environment-name>`
- ✅ Use relative paths: `./scripts/`, `../data/`
- ✅ Use environment-based commands: `mamba activate <env-name>`
- ❌ Never use actual usernames, hostnames, or system-specific paths
- ❌ Never assume specific directory structures outside the project

## Validation
Before committing any documentation updates:
- Search for absolute paths: `grep -r "/Users/" .` should return nothing
- Search for home references: `grep -r "~/" .` should return nothing (except in comments explaining what NOT to do)
- Search for Windows paths: `grep -r "C:\\\\" .` should return nothing
- Verify all commands follow the approved patterns above
- Ensure all examples use generic placeholders

# Process Rules (The ExecPlan Mandate)
- Do not write feature code immediately for complex tasks.
- For any architectural modifications, new endpoints, or tasks touching 3+ files, you MUST initialize an ExecPlan under `.codex/plans/` using the instructions found in `.codex/PLANS.md`.
- Present the plan checklist to the user and await approval before modifying application source files.
- When generating ExecPlans, verify all command examples follow the Documentation & Portability Rules above.
- ExecPlans themselves must not contain absolute paths or non-portable commands.
- All examples in ExecPlans must use generic placeholders from the start.
