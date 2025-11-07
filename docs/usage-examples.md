# Usage examples

This document contains _minimal_ usage examples for the reusable workflows in this repository.

## Provision Azure resources using Terraform

Prerequisites:

- [Configure OIDC authentication from GitHub Actions to Azure](https://github.com/equinor/azure-github-oidc-template)
- [Configure Terraform backend](https://github.com/equinor/azure-terraform-backend-template)
- Configure GitHub secret `ENCRYPTION_PASSWORD` with a randomly generated password (used to encrypt the uploaded artifact, as it may contain sensitive infrastructure configuration)

```yaml
on:
  push:
    branches: [main]

jobs:
  provision:
    uses: equinor/ops-actions/.github/workflows/terraform.yml@main
    with:
      terraform_version: latest
      working_directory: "."
      environment: development
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
      ENCRYPTION_PASSWORD: ${{ secrets.ENCRYPTION_PASSWORD }}
```

Supported Terraform providers:

| Name  | Source              | Version      |
| ----- | ------------------- | ------------ |
| Azure | `hashicorp/azurerm` | `>= v3.20.0` |
| AzAPI | `azure/azapi`       | `>= v1.3.0`  |

## Deploy Docker image to Azure Web App

Prerequisites:

- [Configure OIDC authentication from GitHub Actions to Azure](https://github.com/equinor/azure-github-oidc-template)

```yaml
on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/docker-acr@main
    with:
      working_directory: "."
      registry_name: crexampledev
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
      app_name: app-example-dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Deploy .NET application to Azure Web App

Prerequisites:

- [Configure OIDC authentication from GitHub Actions to Azure](https://github.com/equinor/azure-github-oidc-template)

```yaml
on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/dotnet.yml@main
    with:
      dotnet_version: "9.x"
      project: Source/ExampleApp/ExampleApp.csproj

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@main
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: app-example-dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Update Databricks Git folder

Prerequisites:

- [Configure OIDC authentication from GitHub Actions to Azure](https://github.com/equinor/azure-github-oidc-template)
- Create Git folder `/Repos/<GITHUB_REPOSITORY>` in the target Databricks workspace and add the service principal with access `Can Manage`

```yaml
on:
  push:
    branches: [main]

jobs:
  update:
    uses: equinor/ops-actions/.github/workflows/databricks-repos.yml@main
    with:
      environment: development
      cli_version: "" # empty == latest
      databricks_host: https://adb-709200391298940.4.azuredatabricks.net
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```
