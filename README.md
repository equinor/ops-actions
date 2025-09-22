# ops-actions

[![CI](https://github.com/equinor/ops-actions/actions/workflows/ci.yml/badge.svg?branch=main&event=push)](https://github.com/equinor/ops-actions/actions/workflows/ci.yml)
[![GitHub Release](https://img.shields.io/github/v/release/equinor/ops-actions)](https://github.com/equinor/ops-actions/releases/latest)
[![GitHub contributors](https://img.shields.io/github/contributors/equinor/ops-actions)](https://github.com/equinor/ops-actions/graphs/contributors)
[![GitHub Issues](https://img.shields.io/github/issues/equinor/ops-actions)](https://github.com/equinor/ops-actions/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/equinor/ops-actions)](https://github.com/equinor/ops-actions/pulls)
[![GitHub License](https://img.shields.io/github/license/equinor/ops-actions)](LICENSE)

[Reusable GitHub Actions workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for common operational tasks.

## Usage

Call a reusable workflow by using the following syntax:

```yaml
on: [push]
jobs:
  example:
    uses: equinor/ops-actions/.github/workflows/{filename}@{ref}
    with: {}
    secrets: {}
```

`{filename}` is the name of a [workflow file](#workflows), and `{ref}` is (in order of preference) a commit SHA, release tag or branch name.

To pass inputs and secrets to the reusable workflow, use the `with` and `secrets` keywords respectively.

### Workflows

This repository contains the following workflow files - clicking on a workflow file name will redirect you to the usage documentation for that workflow:

- `azure-function.yml`: deploy an artifact to Azure Functions.
- `azure-webapp.yml`: deploy an artifact to an Azure Web App.
- `databricks-bundle.yml`: deploy a Databricks Asset Bundle.
- `databricks-repos.yml`: update a Databricks Git folder (repo).
- `docker.yml`: build a Docker image and push to a container registry.
- `docker-acr.yml`: build a Docker image and push to an Azure Container Registry (ACR) using secretless authentication.
- `dotnet.yml`: build a .NET application.
- `github-pages.yml`: publish a static site to GitHub Pages.
- [`python-release.yml`](docs/workflows/python-release.md): Python package build and release automation.
- `release-please.yml`: automate GitHub releases using Release Please.
- `super-linter.yml`: run a collection of ready-to-go linters and formatters using Super-linter.
- [`terraform.yml`](docs/workflows/terraform.md): run Terraform in automation.

### Version updates

Use [Dependabot](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/about-dependabot-version-updates) to keep workflows you use updated to the latest versions.

Create a Dependabot configuration file `.github/dependabot.yml` in your repository containing the following configuration:

```yaml
version: 2
updates:
  - package-ecosystem: github-actions
    directory: /
    schedule:
      interval: weekly
```

## Development

The [GitHub Actions extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-github-actions) is highly recommended for syntax highlighting, validation and code completion for GitHub Actions workflows.

## Testing

We perform [user acceptance tests](https://en.wikipedia.org/wiki/Acceptance_testing#User_acceptance_testing) for reusable workflows.

## Contributing

See [contributing guidelines](CONTRIBUTING.md).

## License

This project is licensed under the terms of the [MIT license](LICENSE).
