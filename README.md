# Ops Actions

![GitHub License](https://img.shields.io/github/license/equinor/ops-actions)
![GitHub Release](https://img.shields.io/github/v/release/equinor/ops-actions)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)

[Reusable GitHub Actions workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for common operational tasks.

Examples:

- 🌲 `terraform.yml`: provision cloud environment using Terraform.
- 📦 `docker.yml`: build Docker image and push to container registry.
- 🚀 `azure-webapp.yml`: deploy to Azure Web App.

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

`{filename}` is the name of a workflow file in the [workflows directory](.github/workflows), and `{ref}` is (in order of preference) a commit SHA, release tag or branch name.

To pass inputs and secrets to the reusable workflow, use the `with` and `secrets` keywords respectively.

For specific usage examples, see [this document](docs/usage-examples.md).

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

## Contributing

See [contributing guidelines](CONTRIBUTING.md).

## License

This project is licensed under the terms of the [MIT license](LICENSE).
