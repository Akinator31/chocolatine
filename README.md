# Chocolatine

A reusable GitHub Actions workflow, developed as part of the Epitech curriculum, that enforces coding style, compilation, and testing rules on a repository, then mirrors it to another Git remote.

## Description

This project delivers a single, self-contained workflow file, `.github/workflows/chocolatine.yml`, meant to be dropped into any Epitech project regardless of its technology stack. It runs on every push and pull request, checks the repository against Epitech's coding style, compiles the project, verifies the expected executables are present, runs the test suite, and mirrors the repository to a second remote on every push.

The rest of this repository (`Makefile`, `main.c`, `tests/test.c`) is a minimal sample C project, used only as a sandbox to exercise and validate the workflow itself. It is not the actual deliverable.

## Trigger conditions

The workflow runs on `push` and `pull_request` events, except for branches whose name matches `ga-ignore-*`, which are excluded via `branches-ignore`.

## Repository variables

The workflow expects the following repository variables (Settings > Secrets and variables > Actions > Variables) to be configured:

| Variable | Description |
|---|---|
| `MIRROR_URL` | The URL of the repository the project will be mirrored to |
| `EXECUTABLES` | A comma-separated list of the executable paths expected after compilation |

## Secrets

| Secret | Description |
|---|---|
| `GIT_SSH_PRIVATE_KEY` | SSH private key used to authenticate when pushing to the mirror repository |

## Jobs

The jobs run sequentially, each depending on the success of the previous one:

1. **check_workflow_conditions** – verifies that `MIRROR_URL` and `EXECUTABLES` are set, and stops the workflow if the current repository is the mirror repository itself.
2. **check_coding_style** – runs the Epitech coding style checker (`ghcr.io/epitech/coding-style-checker`) and reports every error as a GitHub error annotation. The job fails if any coding style error is found.
3. **check_program_compilation** – builds the project with `make` (2 minute timeout), cleans it with `make clean`, then checks that every file listed in `EXECUTABLES` exists and is executable.
4. **run_tests** – runs `make tests_run` (2 minute timeout) inside the `epitechcontent/epitest-docker` container.
5. **push_to_mirror** – mirrors the repository to `MIRROR_URL` using `pixta-dev/repository-mirroring-action`, authenticated with the `GIT_SSH_PRIVATE_KEY` secret. This job only runs on `push` events.

## Usage

To use this workflow in another project:

1. Copy `.github/workflows/chocolatine.yml` to the target repository, at the same path.
2. Define the `MIRROR_URL` and `EXECUTABLES` repository variables.
3. Add the `GIT_SSH_PRIVATE_KEY` secret with the SSH private key matching the mirror repository's deploy key.

## Note on commit history

This repository was used to learn and iterate on GitHub Actions, so its commit history does not follow my usual commit conventions. It reflects a lot of trial and error rather than a clean, linear history, and should not be taken as a reference for commit practices.
