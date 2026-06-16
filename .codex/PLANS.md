# ExecPlan Protocol

All compound code modifications require a dedicated blueprint markdown file placed under `.codex/plans/<feature_name>_plan.md`.

## Protocol Loop for Codex

1. **Scaffold**: Generate the blueprint file under `.codex/plans/` with empty `[ ]` checklist tasks.
2. **Review**: Present the plan to the user in the workspace. Pause and wait for approval.
3. **Linear Execution**: Check off completed steps sequentially (`[x]`). Run `pytest` or environment validations after every step.
4. **State Printing**: Output the updated checklist status to the user interface after completing each micro-phase.

## Blueprint Layout

Every generated plan file under `.codex/plans/` must strictly include these four sections:

### 1. Core Objective
- Clear success metrics and business goals for design-first-with-codex.

### 2. Affected System Files
- A precise target tracking list of files to be created, modified, or deleted.

### 3. Checklist Steps
- Phased, atomic, sequential tasks with markdown checkboxes (`[ ]`).

### 4. Mamba Verification
- Explicit commands and confirmation to verify package sync and pass all environment test suites (`pytest`).
