# ops-actions

[Reusable GitHub Actions workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for common operational tasks.

## Features

- ♻ **Reusable workflows** for common operational tasks, simplifying CI/CD pipeline setup.
- 📦 **Build support for multiple languages and frameworks** including Docker, .NET and Python.
- 🚀 **Deploy to multiple cloud platforms and services** including Azure Web App, Azure Functions and GitHub Pages.
- 🔑 **Secretless authentication** where supported.
- 🛡️ **Security scanning** using static analysis tools, including CodeQL, Trivy and zizmor.
- 📝 **Comprehensive documentation** for each workflow, with usage examples.
- 🤖 **Easy workflow updates** using [Dependabot version updates](#version-updates).

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

`{filename}` is the name of a workflow file in the [workflows directory](https://github.com/equinor/ops-actions/tree/main/.github/workflows), and `{ref}` is (in order of preference) a commit SHA, release tag or branch name.

To pass inputs and secrets to the reusable workflow, use the `with` and `secrets` keywords respectively.

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

## Versioning

This project follows [Semantic Versioning](https://semver.org/).

## Contributing

See [contributing guidelines](https://github.com/equinor/ops-actions/blob/main/CONTRIBUTING.md).

## License

This project is licensed under the terms of the [MIT license](https://github.com/equinor/ops-actions/blob/main/LICENSE).
