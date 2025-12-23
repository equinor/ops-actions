# `databricks-bundle.yml`

A reusable workflow for validating and deploying a [Databricks Asset Bundle](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/bundles/) to Azure Databricks.

## Key Features

- **Secretless authentication**: authenticate to Azure Databricks using a service principal with OpenID Connect (OIDC).

## Prerequisites

1. Create a Microsoft Entra service principal and configure OIDC authentication from GitHub Actions to Azure, for example, using the [Azure GitHub OIDC template](https://github.com/equinor/azure-github-oidc-template).
1. Add the service principal to the target Azure Databricks workspace. Refer to [official documentation](https://learn.microsoft.com/en-us/azure/databricks/admin/users-groups/manage-service-principals) for instructions.

## Usage

Add a GitHub Actions workflow file `.github/workflows/databricks-bundle.yml` in your repository, and add the following recommended configuration:

```yaml
name: Databricks Asset Bundle

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
    uses: equinor/ops-actions/.github/workflows/databricks-bundle.yml@main
    with:
      environment: dev
      working_directory: bundles/example-bundle
      target: dev
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Inputs

### `enviroment`

The name of the GitHub environment that this workflow should use for deployments.

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `cli_version`

A version of the Databricks CLI to install. Defaults to latest.

### (*Optional*) `working_directory`

The working directory to run the Databricks commands in. Must contain a [Databricks Asset Bundle configuration](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/bundles/settings) file `databricks.yml`.

### (*Optional*) `target`

The Databricks bundle target to use. Must be a deployment target defined in the `databricks.yml` file.

## Secrets

### `AZURE_CLIENT_ID`

The client ID of the service principal to use for authenticating to Azure Databricks.

### `AZURE_TENANT_ID`

The ID of the Microsoft Entra tenant to authenticate to.

## References

- <https://learn.microsoft.com/en-us/azure/databricks/dev-tools/bundles/>
- <https://learn.microsoft.com/nb-no/azure/databricks/dev-tools/bundles/ci-cd-bundles>
