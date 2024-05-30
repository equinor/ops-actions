# Equinor Ops Actions

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/ops-actions/badge)](https://scm-compliance-api.radix.equinor.com/repos/equinor/ops-actions/badge)

[Reusable GitHub Actions workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for common operational tasks.

Examples:

- 🌲 `terraform.yml`: provision cloud environment using Terraform.
- 📦 `docker.yml`: build Docker image and push to container registry.
- 🚀 `azure-webapp.yml`: deploy to Azure Web App.

## Usage

Call a reusable workflow by using the following syntax:

```yaml
jobs:
  example:
    uses: equinor/ops-actions/.github/workflows/{filename}@{ref}
    with: {} # inputs
    secrets: {} # secrets
```

`{filename}` is the name of a workflow file in the [workflows directory](.github/workflows), and `{ref}` is (in order of preference) a commit SHA, release tag or branch name.

For specific usage examples, see [this document](docs/usage-examples.md).

## Contributing

See [contributing guidelines](CONTRIBUTING.md).

## License

This project is licensed under the terms of the [MIT license](LICENSE).
