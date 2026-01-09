# `python-package.yml`

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

### Manual release

Add a GitHub Actions workflow file `.github/workflows/release.yml` in your repository, and add the following recommended configuration:

```yaml
name: Release

on:
  release:
    types:
      - published

permissions: {}

jobs:
  build:
    name: Build
    uses: equinor/ops-actions/.github/workflows/python-package.yml@main
    permissions:
      contents: read

  # Reusable workflows are currently not supported for PyPI Trusted Publishing.
  # Ref: https://docs.pypi.org/trusted-publishers/troubleshooting/#reusable-workflows-on-github
  pypi-publish:
    name: PyPI Publish
    needs: build
    runs-on: ubuntu-latest
    environment: pypi
    permissions:
      id-token: write # Required for PyPI Trusted Publishing.
    steps:
      - name: Download artifact
        uses: actions/download-artifact@634f93cb2916e3fdff6788551b99b062d0335ce0
        with:
          name: ${{ needs.build.outputs.artifact_name }}
          path: dist

      - name: Publish to PyPI
        uses: pypa/gh-action-pypi-publish@ed0c53931b1dc9bd32cbe73a98c7f6766f8a527e
```

When a GitHub release is published in your repository, this workflow will automatically build and publish your package.

### Automated release

To automate the creation of GitHub releases, add the `release-please.yml` reusable workflow to your workflow file:

```yaml
name: Release

on:
  push:
    branches:
      - main

permissions: {}

jobs:
  release:
    name: Release
    uses: equinor/ops-actions/.github/workflows/release-please.yml@main
    with:
      release_type: python
    permissions:
      contents: write
      issues: write
      pull-requests: write

  build:
    name: Build
    needs: release
    if: needs.release.outputs.release_created == 'true'
    uses: equinor/ops-actions/.github/workflows/python-package.yml@main
    permissions:
      contents: read

  # Reusable workflows are currently not supported for PyPI Trusted Publishing.
  # Ref: https://docs.pypi.org/trusted-publishers/troubleshooting/#reusable-workflows-on-github
  pypi-publish:
    name: PyPI Publish
    needs: build
    runs-on: ubuntu-latest
    environment: pypi
    permissions:
      id-token: write # Required for PyPI Trusted Publishing.
    steps:
      - name: Download artifact
        uses: actions/download-artifact@634f93cb2916e3fdff6788551b99b062d0335ce0
        with:
          name: ${{ needs.build.outputs.artifact_name }}
          path: dist

      - name: Publish to PyPI
        uses: pypa/gh-action-pypi-publish@ed0c53931b1dc9bd32cbe73a98c7f6766f8a527e
```

On push to branch `main`, this workflow will automatically release, build and publish your package.

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `working_directory`

The path of the directory containing the Python project to build. Defaults to `.`.

### (*Optional*) `uv_version`

The version of uv to install. Defaults to the version in `pyproject.toml` or `latest`.

### (*Optional*) `artifact_name`

The name of the build artifact. Defaults to `python-package-dist`.

### (*Optional*) `upload_artifact`

Should the build artifact be uploaded? Defaults to `true`.

## Outputs

### `artifact_name`

The name of the build artifact.

### `artifact_uploaded`

Was the build artifact uploaded? Value is `"true"` if the build artifact was uploaded, else `"false"`.

## References

- <https://packaging.python.org/en/latest/tutorials/packaging-projects/>
- <https://packaging.python.org/en/latest/guides/publishing-package-distribution-releases-using-github-actions-ci-cd-workflows/>
- <https://docs.astral.sh/uv/guides/integration/github/>
