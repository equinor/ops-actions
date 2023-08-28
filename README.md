# Ops Actions

[Reusable GitHub Actions workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for operational tasks.

## Goal

Create reusable and composable workflows for common operational tasks.

Examples:

- 🌲 `terraform.yml`: provision infrastructure using Terraform.
- 📦 `docker.yml`: build Docker image and push to container registry.
- 🚀 `azure-webapp.yml`: deploy to Azure Web App.

## Prerequisites

### OpenID Connect

For reusable workflows that login to Azure, run [this script](./scripts/oidc/) to configure OpenID Connect for the repository containing the caller workflow.

### Terraform backend

For the `terraform.yml` workflow, run [this script](./scripts/terraform-backend/) to configure a Terraform backend.

Supported Terraform providers:

| Name  | Source              | Version      |
| ----- | ------------------- | ------------ |
| Azure | `hashicorp/azurerm` | `>= v3.20.0` |
| AzAPI | `azure/azapi`       | `>= v1.3.0`  |

## Usage

See [usage examples](docs/usage-examples.md).

## Contributing

See [contributing guidelines](CONTRIBUTING.md).
