# Usage examples

This document contains _minimal_ usage examples for the reusable workflows in this repository.

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
- Create a folder `/Repos/<GITHUB_ORG>` in the target Databricks workspace and add the service principal with access `Can Manage`

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
