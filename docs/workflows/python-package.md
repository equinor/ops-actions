# `python-package.yml`

> [!IMPORTANT]
> This workflow uses [PyPI Trusted Publishing](https://docs.pypi.org/trusted-publishers/). This feature currently does not support publishing from a reusable workflow. Until this feature is officially supported (see [pypi/warehouse#11096](https://github.com/pypi/warehouse/issues/11096) for status), this reusable workflow serves as a working reference.

A reusable workflow that automatically releases, builds and publishes your Python packages.

## Key Features

- **Automatic version managment:** automated version bumps, CHANGELOG generation and creation of GitHub releases using [Release Please](https://github.com/googleapis/release-please).
- **Automatic package distribution**: Python source (`.tar.gz`) and built (`.whl`) distributions are automatically published to PyPI.
- **Secretless publishing** to PyPI using OpenID Connect (OIDC).

## Prerequisites

### Create Python projects

1. Create a packages directory:

    ```console
    mkdir packages && cd packages
    ```

1. Create a new project:

    ```console
    uv init --package <project-name>
    ```

    For example, create a new project `example-package`:

    ```console
    uv init --package example-package
    ```

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
        ".": {
          "package-name": "root-package"
        }
      }
    }
    ```

1. Add a `.release-please-manifest.json` manifest file at the root of your repository, and add an initial empty JSON object:

    ```json
    {}
    ```

For detailed instructions on configuring Release Please, please refer to the [official documentation](https://github.com/googleapis/release-please/blob/main/docs/manifest-releaser.md).

> [!IMPORTANT]
> The package name specified in `release-please-config.json` should match the name of the project you created in the previous step.

### Configure GitHub repository

1. [Enforce commit squashing for pull requests](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/configuring-commit-squashing-for-pull-requests)
1. [Allow GitHub Actions to create pull requests](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#preventing-github-actions-from-creating-or-approving-pull-requests)

### Configure PyPI Trusted Publishing

[Create a PyPI project with a Trusted Publisher](https://docs.pypi.org/trusted-publishers/creating-a-project-through-oidc/#github-actions).

## Usage

Add a GitHub Actions workflow file `.github/workflows/release.yml` in your repository, and add the following recommended configuration:

```yaml
name: Release

on:
  push:
    branches:
      - main

jobs:
  Release:
    name: Release
    uses: equinor/ops-actions/.github/workflows/python-package.yml@main
    permissions:
      contents: write
      issues: write
      pull-requests: write
      id-token: write

```

On push to branch `main`, this workflow will automatically build and release your Python packages 🚀

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `environment`

The name of the GitHub environment that this workflow should use for publishing. Defaults to `pypi`.
