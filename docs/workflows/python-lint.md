# `python-lint.yml`

Lint your Python project...

## Key Features

- **High performance**: Lint your Python project using the [Ruff Linter](https://docs.astral.sh/ruff/linter/), an extremely fast Python linter and a drop-in replacement for Flake8, isort and Black.

## Usage

Add a GitHub Actions workflow file `.github/workflows/lint.yml` in your repository, and add the following recommended configuration:

```yaml
name: Lint

on:
  pull_request:
    branches:
      - main

jobs:
  lint:
    name: Lint
    uses: equinor/ops-actions/.github/workflows/python-lint.yml@main
    permissions:
      contents: read

```

## Inputs

### `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.
