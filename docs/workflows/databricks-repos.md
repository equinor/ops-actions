# `databricks-repos.yml`

A reusable workflow for deploying an [Azure Databricks Git folder](https://learn.microsoft.com/en-us/azure/databricks/repos/).

## Key Features

- **Secretless authentication**: authenticate to Azure Databricks using a service principal with OpenID Connect (OIDC).

## Prerequisites

1. Create a Microsoft Entra service principal and configure OIDC authentication from GitHub Actions to Azure, for example, using the [Azure GitHub OIDC template](https://github.com/equinor/azure-github-oidc-template).
1. Add the service principal to the target Azure Databricks workspace. Refer to [official documentation](https://learn.microsoft.com/en-us/azure/databricks/admin/users-groups/manage-service-principals) for instructions.
1. Create a folder `/Repos/<GITHUB_ORG>` in the target Azure Databricks workspace and add the service principal with access `Can Manage`

## Usage

Add a GitHub Actions workflow file `.github/workflows/databricks-repos.yml` in your repository, and add the following recommended configuration:

```yaml
name: Databricks Repos

on:
  push:
    branches: [main]

permissions: {}

jobs:
  deploy-dev:
    name: Deploy dev
    permissions:
      contents: read
      id-token: write
    uses: equinor/ops-actions/.github/workflows/databricks-repos.yml@main
    with:
      environment: dev
      databricks_host: https://adb-709200391298940.4.azuredatabricks.net
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Inputs

### `enviroment`

The name of the GitHub environment that this workflow should use for deployments.

### `databricks_host`

The URL of the target Databricks workspace.

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `cli_version`

A version of the Databricks CLI to install. Defaults to latest.

### (*Optional*) `repo_path`

The path of the Git folder (repo) object in the Databricks workspace. Defaults to `/Repos/<GITHUB_REPOSITORY>`.

### (*Optional*) `branch`

The branch that the local version of the repo is checked out to. Defaults to `main`.

## Secrets

### `AZURE_CLIENT_ID`

The client ID of the service principal to use for authenticating to Azure Databricks.

### `AZURE_SUBSCRIPTION_ID`

The ID of the Azure subscription to authenticate to.

### `AZURE_TENANT_ID`

The ID of the Microsoft Entra tenant to authenticate to.
