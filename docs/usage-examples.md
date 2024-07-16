# Usage examples

This document contains *minimal* usage examples for the reusable workflows in this repository.

## Provision Azure resources using Terraform

Example workflow:

```yaml
on:
  push:
    branches: [main]

jobs:
  provision:
    uses: equinor/ops-actions/.github/workflows/terraform.yml@v9.5.0
    with:
      environment: development
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

## Deploy Docker image to Azure Web App

Example workflow:

```yaml
on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/docker-acr@v9.5.0
    with:
      registry_name: crexampledev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@v9.5.0
    with:
      environment: development
      image: ${{ needs.build.outputs.image }}
      app_name: app-example-dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

Prerequisites:

- [Configure Azure credentials](../scripts/oidc/README.md)

## Deploy Python application to Azure Function App

Example workflow:

```yaml
on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/python.yml@v9.5.0
    with:
      pip_install_target: .python_packages/lib/site-packages # Required

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-function.yml@v9.5.0
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: func-example-dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

Prerequisites:

- [Configure Azure credentials](../scripts/oidc/README.md)

## Deploy Python application to Azure Web App

Example workflow:

```yaml
on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/python.yml@v9.5.0
    with:
      venv_path: antenv # Required
      pip_install_target: .python_packages/lib/site-packages # Required

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@v9.5.0
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

## Deploy .NET application to Azure Web App

Example workflow:

```yaml
on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/dotnet.yml@v9.5.0
    with:
      project: .

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@v9.5.0
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

## Deploy MkDocs site to GitHub Pages

Example workflow:

```yaml
on:
  push:
    branches: [main]
    paths:
      - docs/**
      - mkdocs.yml

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/mkdocs.yml@v9.5.0

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/github-pages.yml@v9.5.0
    with:
      artifact_name: ${{ needs.build.outputs.artifact_name }}
```
