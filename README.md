# ops-actions

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

[Reusable GitHub Actions workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for operational tasks.

## Workflow library

See [`.github/workflows`](.github/workflows/) directory.

## Goal

Create **reusable** and **composable** workflows for common operational tasks.

Examples:

- `terraform.yml`: provision infrastructure using Terraform.
- `docker.yml`: build Docker image and push to container registry.
- `azure-webapp.yml`: deploy to Azure Web App.

## Non-goal

Don't create reusable workflows for very specific scenarios.

Examples:

- `provision-azure-webapp-using-terraform-then-build-a-docker-image-and-push-it-to-a-container-registry-then-deploy-that-image-to-the-azure-webapp.yml`: you get the point...

## Usage

See [usage examples](docs/usage-examples.md).

## Contributing

See [contributing guidelines](CONTRIBUTING.md).
