# ops-actions

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

[Reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for GitHub Actions, maintained by the [Ops team](https://github.com/orgs/equinor/teams/ops).

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

## Usage examples

See [usage examples document](docs/usage-examples.md).
