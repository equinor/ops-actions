# Python Package Releaser

Python Package Releaser is a reusable GitHub Actions workflow that automatically builds and releases your Python packages using modern tooling:

- [uv](https://docs.astral.sh/uv/) for Python package management
- [Release Please](https://github.com/googleapis/release-please) for GitHub release automation

## Key Features

- **Monorepo support**: Manage multiple Python packages in a single GitHub repository.
- **Automatic package distribution**: Python source (`.tar.gz`) and built (`.whl`) distributions are automatically uploaded to the corresponding GitHub releases.

## Prerequisites

1. **Create your Python projects**: Add a `pyproject.toml` configuration file for each Python project in your repository. For example: `packages/example_package/pyproject.toml`.

    For instructions on writing your `pyproject.toml` files, please refer to the [official guide](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/).

1. **Configure Release Please**: Add a `release-please-config.json` configuration file at the root of your repository, and define your Python packages. For example:

    ```json
    {
      "$schema": "https://raw.githubusercontent.com/googleapis/release-please/main/schemas/config.json",
      "release-type": "python",
      "packages": {
        "packages/example_package": {
          "package-name": "example-package",
        }
      }
    }
    ```

    Add a `.release-please-manifest.json` manifest file at the root of your repository, and add an initial empty JSON object:

    ```json
    {}
    ```

    For detailed instructions on configuring Release Please, please refer to the [official documentation](https://github.com/googleapis/release-please/blob/main/docs/manifest-releaser.md).

## Inputs

### `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### `uv_version`

The version of `uv` to install. Defaults to `latest`.

## Usage

Add a GitHub Actions workflow file `.github/workflows/ci.yml` in your repository, and add the following configuration:

```yaml
name: CI

on:
  push:
    branches:
      - main

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/uv-release-please.yml@main
    with:
      uv_version: 0.8.15
    permissions:
      contents: write
      pull-requests: write

```

On push to branch `main`, this workflow will automatically build and release your Python packages 🚀
