# Usage examples

This document contains usage examples for the reusable workflows in this repository.

## Provision Azure resources using Terraform

```yaml
name: provision

on:
  push:
    branches: [main]

  pull_request:
    branches: [main]

jobs:
  provision:
    uses: equinor/ops-actions/.github/workflows/terraform.yml@main
    with:
      environment: development
      working_directory: terraform
      terraform_version: ~1.0.0
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Build Docker image and deploy to Azure Web App

```yaml
name: build

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/docker-acr@main
    with:
      working_directory: src
      registry_name: example-cr
      repository: example-app
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@main
    with:
      environment: development
      image: ${{ needs.build.outputs.image }}
      app_name: example-app
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Build Python application and deploy to Azure Function App

```yaml
name: build

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/python.yml@main
    with:
      working_directory: src
      python_version: "3.x"
      pip_install_target: .python_packages/lib/site-packages # Required

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-function.yml@main
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: example-func
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Build Python application and deploy to Azure Web App

```yaml
name: build

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/python.yml@main
    with:
      working_directory: src
      python_version: "3.10"
      venv_path: antenv # Required
      pip_install_target: .python_packages/lib/site-packages # Required

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@main
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: example-app
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Build .NET application and deploy to Azure Web App

```yaml
name: build

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/dotnet.yml@main
    with:
      dotnet_version: "6.x"
      project: src/Example/Example.csproj
      test_project: |-
        tests/Example.UnitTests/Example.UnitTests.csproj
        tests/Example.IntegrationTests/Example.IntegrationTests.csproj
      test_collect: XPlat Code Coverage

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@main
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: example-app
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Deploy MkDocs to GitHub Pages

```yaml
name: deploy

on:
  push:
    branches:
      - main

jobs:
  deploy:
    uses: equinor/ops-actions/.github/workflows/mkdocs-gh-pages.yml@main
    with:
      mkdocs_version: ">=1.0.0"
      python_version: "3.x"
```

> **Note**
> Make sure your GitHub Pages site is currently being built from the `gh-pages` branch.
> See [GitHub docs](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site) for instructions on how to set this up.
