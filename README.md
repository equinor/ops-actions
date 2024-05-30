# Equinor Ops Actions

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/ops-actions/badge)](https://scm-compliance-api.radix.equinor.com/repos/equinor/ops-actions/badge)

[Reusable GitHub Actions workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for common operational tasks.

Examples:

- 🌲 `terraform.yml`: provision cloud environment using Terraform.
- 📦 `docker.yml`: build Docker image and push to container registry.
- 🚀 `azure-webapp.yml`: deploy to Azure Web App.

## Usage

See [Usage examples](docs/usage-examples.md).

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
