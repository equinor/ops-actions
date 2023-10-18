# Usage examples

This document contains usage examples for the reusable workflows in this repository.

For all workflow calls, replace `<release>` with the latest relase, for example `v1.0.0`.
Releases are available [here](https://github.com/equinor/ops-actions/releases).

## Provision Azure resources using Terraform

Example:

```yaml
name: provision

on:
  push:
    branches: [main]

jobs:
  provision:
    uses: equinor/ops-actions/.github/workflows/terraform.yml@<release>
    with:
      environment: development
      working_directory: terraform
      terraform_version: 1.5.7
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
      ENCRYPTION_PASSWORD: ${{ secrets.ENCRYPTION_PASSWORD }}
```

Prerequisites:

- [Configure Azure credentials](../scripts/oidc/README.md)
- [Configure Terraform backend](../scripts/terraform-backend/README.md)
- Configure GitHub secret `ENCRYPTION_PASSWORD` with a randomly generated password (used to encrypt the uploaded artifact, as it may contain sensitive infrastructure configuration)

Supported Terraform providers:

| Name  | Source              | Version      |
| ----- | ------------------- | ------------ |
| Azure | `hashicorp/azurerm` | `>= v3.20.0` |
| AzAPI | `azure/azapi`       | `>= v1.3.0`  |

## Deploy Docker container to Azure Web App

Azure Container Registry example:

```yaml
name: build

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/docker-acr@<release>
    with:
      registry_name: crfoobardev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@<release>
    with:
      environment: development
      image: ${{ needs.build.outputs.image }}
      app_name: app-foobar-dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

Prerequisites:

- [Configure Azure credentials](../scripts/oidc/README.md)

Generic container registry example:

```yaml
name: build

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/docker@<release>
    with:
      registry: ghcr.io
      username: ${{ github.actor }}
    secrets:
      password: ${{ secrets.GITHUB_TOKEN }}

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@<release>
    with:
      environment: development
      image: ${{ needs.build.outputs.image }}
      app_name: app-foobar-dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Deploy Python application to Azure Function App

Example:

```yaml
name: build

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/python.yml@<release>
    with:
      working_directory: src
      python_version: 3.10
      pip_install_target: .python_packages/lib/site-packages # Required

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-function.yml@<release>
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: func-foobar-dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

Prerequisites:

- [Configure Azure credentials](../scripts/oidc/README.md)

## Deploy Python application to Azure Web App

Example:

```yaml
name: build

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/python.yml@<release>
    with:
      working_directory: src
      python_version: 3.10
      venv_path: antenv # Required
      pip_install_target: .python_packages/lib/site-packages # Required

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@<release>
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: app-foobar-dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

Prerequisites:

- [Configure Azure credentials](../scripts/oidc/README.md)

## Deploy .NET application to Azure Web App

Example:

```yaml
name: build

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/dotnet.yml@<release>
    with:
      dotnet_version: 6.0
      project: src/Example/Example.csproj
      test_project: |-
        tests/Example.UnitTests/Example.UnitTests.csproj
        tests/Example.IntegrationTests/Example.IntegrationTests.csproj

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@<release>
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: app-example-dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

Prerequisites:

- [Configure Azure credentials](../scripts/oidc/README.md)

## Deploy MkDocs to GitHub Pages

Example:

```yaml
name: deploy

on:
  push:
    branches: [main]
    paths:
      - docs/**
      - mkdocs.yml

jobs:
  deploy:
    uses: equinor/ops-actions/.github/workflows/mkdocs-gh-pages.yml@<release>
    with:
      python_version: 3.10
      mkdocs_version: 1.4
```

Prerequisites:

- [Configure GitHub Pages site to built from the `gh-pages` branch](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)
