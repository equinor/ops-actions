# `python-release.yml`

A reusable GitHub Actions workflow that automatically builds and releases your Python packages.

## Key Features

- **Monorepo support**: Manage multiple Python packages in a single GitHub repository.
- **Automatic package distribution**: Python source (`.tar.gz`) and built (`.whl`) distributions are automatically published to PyPI.
- **Secretless publishing** to PyPI using OpenID Connect (OIDC).

## Prerequisites

### Create Python projects

1. Add a `.python-version` file at the root of your repository, and set your preferred Python version. For example:

    ```plaintext
    3.12.10
    ```

1. Add a `packages/<PROJECT_NAME>/pyproject.toml` configuration file for each Python project in your repository. For example, `packages/example-package/pyproject.toml`:

    ```toml
    [build-system]
    requires = ["hatchling"]
    build-backend = "hatchling.build"

    [project]
    name = "example-package"
    version = "0.0.0"
    ```

    For instructions on writing your `pyproject.toml` files, please refer to the [official guide](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/).

1. Add a `packages/<PROJECT_NAME>/src/<MODULE_NAME>/__init__.py` package initialization file for each Python module in your repository. For example, `packages/example-package/src/example_package/__init__.py`.

    ```python
    __version__ = "0.0.0"
    ```

> [!IMPORTANT]
> Python project names should use hyphens, while Python module names must use underscores ([ref.](https://packaging.python.org/en/latest/discussions/distribution-package-vs-import-package/#how-do-distribution-package-names-and-import-package-names-compare)).

### Configure Release Please

1. Add a `release-please-config.json` configuration file at the root of your repository, and define your Python packages. Optionally, define a root package `"."` that combines all packages in your repository. For example:

    ```json
    {
      "$schema": "https://raw.githubusercontent.com/googleapis/release-please/main/schemas/config.json",
      "release-type": "python",
      "packages": {
        "packages/example-package": {
          "package-name": "example-package"
        },
        ".": {}
      }
    }
    ```

1. Add a `.release-please-manifest.json` manifest file at the root of your repository, and add an initial empty JSON object:

    ```json
    {}
    ```

For detailed instructions on configuring Release Please, please refer to the [official documentation](https://github.com/googleapis/release-please/blob/main/docs/manifest-releaser.md).

> [!IMPORTANT]
> The package name specified in `release-please-config.json` should match the project name specified in `pyproject.toml`.

### Configure GitHub repository

1. [Enforce commit squashing for pull requests](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/configuring-commit-squashing-for-pull-requests)
1. [Allow GitHub Actions to create pull requests](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#preventing-github-actions-from-creating-or-approving-pull-requests)

### Configure PyPI Trusted Publishing

[Create a PyPI project with a Trusted Publisher](https://docs.pypi.org/trusted-publishers/creating-a-project-through-oidc/#github-actions).

## Usage

Add a GitHub Actions workflow file `.github/workflows/python-release.yml` in your repository, and add the following recommended configuration:

```yaml
name: Python Release

on:
  push:
    branches:
      - main

jobs:
  build:
    name: Build
    uses: equinor/ops-actions/.github/workflows/python-release.yml@main
    permissions:
      contents: write
      issues: write
      pull-requests: write

```

On push to branch `main`, this workflow will automatically build and release your Python packages 🚀

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `environment`

The name of the GitHub environment that this workflow should use for publishing.
