# `python.yml`

A reusable workflow that tests and prepares a Python application for deployment.

## Usage

### Deploy to Azure Function App

Add a GitHub Actions workflow file `.github/workflows/deploy.yml` in your repository, and add the following recommended configuration:

```yaml
name: Deploy

on:
  push:
    branches: [main]

permissions: {}

jobs:
  build:
    name: Build
    uses: equinor/ops-actions/.github/workflows/python.yml@main
    permissions:
      contents: read
    with:
      python_version: latest
      working_directory: "."
      requirements: requirements.txt
      pip_target_dir: .python_packages/lib/site-packages # Required

  deploy:
    name: Deploy
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-function.yml@main
    permissions:
      contents: read
      id-token: write
    with:
      environment: development
      app_name: func-example-dev
      artifact_name: ${{ needs.build.outputs.artifact_name }}
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

### Deploy to Azure Web App

Add a GitHub Actions workflow file `.github/workflows/deploy.yml` in your repository, and add the following recommended configuration:

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  build:
    name: Build
    uses: equinor/ops-actions/.github/workflows/python.yml@main
    permissions:
      contents: read
    with:
      python_version: latest
      working_directory: "."
      venv_path: antenv # Required
      requirements: requirements.txt
      pip_target_dir: .python_packages/lib/site-packages # Required

  deploy:
    name: Deploy
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@main
    permissions:
      contents: read
      id-token: write
    with:
      environment: development
      app_name: app-example-dev
      artifact_name: ${{ needs.build.outputs.artifact_name }}
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `working_directory`

The path of the directory containing the Python application. Defaults to `.`.

### (*Optional*) `python_version`

The version of Python to install. Defaults to `latest`.

### (*Optional*) `venv_path`

The path, relative to the working directory, to create a virtual Python environment at.

### (*Optional*) `requirements`

A [requirement specifier](https://pip.pypa.io/en/stable/reference/requirement-specifiers/) or the path, relative to the working directory, of a requirements file (usually `requirements.txt`) that specifies Python dependencies to install.

For example, set the value to `"."` to install dependencies from a `pyproject.toml` file in the working directory.

### (*Optional*) `pip_target_dir`

The path, relative to the working directory, of a target directory that pip should install packages into.

### (*Optional*) `artifact_name`

The name of the build artifact. Defaults to `python-app`.

## Outputs

### `artifact_name`

The name of the build artifact.
