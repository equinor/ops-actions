# `python-package.yml`

> [!IMPORTANT]
> This workflow uses [PyPI Trusted Publishing](https://docs.pypi.org/trusted-publishers/). This feature currently does not support publishing from a reusable workflow. Until this feature is officially supported (see [pypi/warehouse#11096](https://github.com/pypi/warehouse/issues/11096) for status), this reusable workflow serves as a working reference.

A reusable workflow that automatically builds and publishes your Python packages.

## Key Features

- **Automatic package distribution**: Python source (`.tar.gz`) and built (`.whl`) distributions automatically published to PyPI.
- **Secretless publishing** to PyPI using OpenID Connect (OIDC).

## Prerequisites

### Create Python project

At the root of your repository, create a new Python project:

```console
uv init --name <project-name> --package .
```

For example, create a new project `example-package`:

```console
uv init --name example-package --package .
```

### Configure PyPI Trusted Publishing

[Create a PyPI project with a Trusted Publisher](https://docs.pypi.org/trusted-publishers/creating-a-project-through-oidc/#github-actions).

## Usage

Add a GitHub Actions workflow file `.github/workflows/publish.yml` in your repository, and add the following recommended configuration:

```yaml
name: Publish to PyPI

on:
  push:
    branches:
      - main

permissions: {}

jobs:
  build:
    name: Build
    uses: equinor/ops-actions/.github/workflows/python-package.yml@main
    permissions:
      contents: write
      id-token: write

```

On push to branch `main`, this workflow will automatically build and publish your Python package to PyPI.

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `environment`

The name of the GitHub environment that this workflow should use for publishing. Defaults to `pypi`.

### (*Optional*) `working_directory`

The path of the directory containing the Python project to build. Defaults to `.`.

### (*Optional*) `artifact_name`

The name of the build artifact to upload. Defaults to `python-package-dist`.

## References

- <https://packaging.python.org/en/latest/tutorials/packaging-projects/>
- <https://packaging.python.org/en/latest/guides/publishing-package-distribution-releases-using-github-actions-ci-cd-workflows/>
