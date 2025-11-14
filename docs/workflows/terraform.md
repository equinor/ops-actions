# `terraform.yml`

A reusable GitHub Actions workflow for automatically running Terraform.

## Key Features

- **Plan and apply queueing**: Queue concurrent jobs that target the same Terraform state file.
- **Plugin chaching**: Cache Terraform provider plugins.
- **Private modules support**: Download Terraform modules from a private GitHub repository.
- **Job summary**: Create job summary containing Terraform command outcomes and plan.
- **Secretless authentication to Azure**: Authenticate to Azure using a service principal with OpenID Connect (OIDC).

## Prerequisites

- [Configure OIDC authentication from GitHub Actions to Azure](https://github.com/equinor/azure-github-oidc-template)
- [Configure Terraform backend](https://github.com/equinor/azure-terraform-backend-template)
- Create GitHub secret `ENCRYPTION_PASSWORD` and set the value to a randomly generated password (used to encrypt the uploaded artifact, as it may contain sensitive infrastructure configuration)

### (*Optional*) Add deploy key to private GitHub repository

Terraform requires a deploy key to download modules from private GitHub repositories:

1. [Add a deploy key to the private GitHub repository](https://github.com/equinor/ops-actions/blob/main/scripts/add_deploy_key.sh)
1. [Configure Terraform to clone module sources from GitHub over SSH](https://developer.hashicorp.com/terraform/language/block/module#github-repository)

## Usage

Add a GitHub Actions workflow file `.github/workflows/terraform.yml` in your repository, and add the following recommended configuration:

```yaml
name: Terraform

on:
  pull_request:
    branches: [main]
    paths: [terraform/**]

permissions: {}

jobs:
  deploy:
    name: Deploy
    permissions:
      contents: read
      id-token: write
    uses: equinor/ops-actions/.github/workflows/terraform.yml@main
    with:
      environment: development
      terraform_version: 1.13.2
      working_directory: terraform
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
      ENCRYPTION_PASSWORD: ${{ secrets.ENCRYPTION_PASSWORD }}

```

## Inputs

### `environment`

The name of the GitHub environment that this workflow should use for deployments.

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `terraform_version`

The version of `terraform` to install. Defaults to `latest`.

### (*Optional*) `working_directory`

The working directory to run the `terraform` commands in. Defaults to `.`.

### (*Optional*) `backend_config`

The path, relative to the working directory, of a configuration file (`.tfbackend`) containing the remaining arguments for a partial backend configuration.

### (*Optional*) `var_file`

The path, relative to the working directory, of a variable definitions file (`.tfvars`) containing values for variables declared in the root module.

### (*Optional*) `artifact_name`

The name of the artifact to upload. If not specified, a unique artifact name will be generated.

### (*Optional*) `run_terraform_apply`

Run `terraform apply` for the saved plan file? Defaults to `true`.

## Secrets

### `ENCRYPTION_PASSWORD`

A password used to encrypt the archive containing the Terraform configuration and plan file.

### (*Optional*) `SSH_PRIVATE_KEY`

An SSH private key used to download Terraform modules from a private GitHub repository (see [prerequisites](#optional-add-deploy-key-to-private-github-repository)).

### (*Optional*) `AZURE_CLIENT_ID`

The client ID of the service principal to use for authenticating to Azure.

### (*Optional*) `AZURE_SUBSCRIPTION_ID`

The ID of the Azure subscription to authenticate to.

### (*Optional*) `AZURE_TENANT_ID`

The ID of the Microsoft Entra tenant to authenticate to.

### (*Optional*) `GRAFANA_AUTH`

The service account token to use for authenticating to Grafana.
