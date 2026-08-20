# `ruff.yml`

A reusable workflow that lints and format-checks a Python project using [Ruff](https://docs.astral.sh/ruff/).

## Usage

Add a GitHub Actions workflow file `.github/workflows/lint.yml` in your repository, and add the following recommended configuration:

```yaml
name: Lint Codebase

on: [push, pull_request]

permissions: {}

jobs:
  lint:
    name: Lint
    permissions:
      contents: read
    uses: equinor/ops-actions/.github/workflows/ruff.yml@main
```

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `working_directory`

The path of the directory containing the Python project to lint. Defaults to `.`.

### (*Optional*) `ruff_version`

The version of Ruff to run. Defaults to `latest`.

### (*Optional*) `config_file`

The path, relative to the working directory, of a [Ruff configuration file](https://docs.astral.sh/ruff/configuration/).

## References

- <https://docs.astral.sh/ruff/>
