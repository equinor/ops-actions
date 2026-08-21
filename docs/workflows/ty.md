# `ty.yml`

A reusable workflow that type-checks a Python project using [ty](https://docs.astral.sh/ty/).

`ty` is installed globally via `uv tool install`, decoupled from the project's own dependencies. Unlike Ruff, `ty` needs the project's real environment to resolve imports and types accurately, so this workflow installs the project's dependencies with `uv sync` before running `ty check`. Projects without a `pyproject.toml` should set `requirements` to install dependencies via pip instead, so `ty` can resolve third-party imports.

If the project already declares its own `ty` dependency (e.g. via `uv add --dev ty`, [Astral's recommended approach](https://docs.astral.sh/ty/installation/#adding-ty-to-your-project)), this workflow detects it and runs `uv run ty check` instead, so the project's pinned version is used rather than the `ty_version` input.

## Usage

Add a GitHub Actions workflow file `.github/workflows/lint.yml` in your repository, and add the following recommended configuration:

```yaml
name: Lint Codebase

on: [push, pull_request]

permissions: {}

jobs:
  type-check:
    name: Type check
    permissions:
      contents: read
    uses: equinor/ops-actions/.github/workflows/ty.yml@main
```

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `working_directory`

The path of the directory containing the Python project to type-check. Defaults to `.`.

### (*Optional*) `python_version`

The version of Python to install. Defaults to the version specified in the `.python-version` file.

### (*Optional*) `config_file`

The path, relative to the working directory, of a [ty configuration file](https://docs.astral.sh/ty/configuration/).

### (*Optional*) `ty_version`

The version of ty to install. Defaults to `latest`.

### (*Optional*) `requirements`

A [requirement specifier](https://pip.pypa.io/en/stable/reference/requirement-specifiers/) or the path, relative to the working directory, of a [requirements file](https://pip.pypa.io/en/stable/reference/requirements-file-format/) (usually `requirements.txt`) that specifies Python dependencies to install. Only used if the project does not have a `pyproject.toml` file.

## References

- <https://docs.astral.sh/ty/>
