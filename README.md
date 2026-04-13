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

### Security scanning

We recommend the use of [zizmor](https://zizmor.sh), which scans your workflows for [many](https://docs.zizmor.sh/audits/) security issues, both common and less common. Use the `Remediation` section under each rule in the previous link as guidance to fix, or create workarounds for, found issues.

We've created a [reusable workflow](.github/workflows/zizmor-codeql.yml) for use with GitHub Security Scanning.
Usage:

```yaml
name: Lint Codebase

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

permissions: {}

jobs:
  lint-actions:
    name: Lint Actions
    permissions:
      contents: read                          # Only needed for private repos. Used to clone repo.
      security-events: write                  # Required for `upload-sarif` (used by `zizmor-action`) to upload SARIF files.
      actions: read                           # Only needed for private repos. Required for `upload-sarif` (used by `zizmor-action`) to upload SARIF files.
    uses: equinor/ops-actions/.github/workflows/zizmor-codeql.yml@{ref}
    with:
      config_file: ./.github/zizmor.yml         # Optional, but recommended to tailor to your needs
```

You can also use zizmor standalone:

```yaml
name: Lint Codebase

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

permissions: {}

jobs:
  lint-actions:
    name: Lint Actions
    runs-on: ubuntu-latest
    permissions:
      contents: read
      security-events: write
      actions: read
    steps:
      - name: Checkout repository
        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
        with:
          persist-credentials: false

      - name: Run zizmor
        uses: zizmorcore/zizmor-action@71321a20a9ded102f6e9ce5718a2fcec2c4f70d8 # v0.5.2
```

## Development

Clone this repository:

```console
git clone https://github.com/equinor/ops-actions.git && cd ops-actions
```

Install dependencies:

```console
python -m pip install --upgrade pip
pip install -r requirements-docs.txt
```

Run a development server:

```console
mkdocs serve
```

Alternatively, a [Visual Studio Code debug configuration](https://code.visualstudio.com/docs/debugtest/debugging-configuration) is provided (see [debug code with Visual Studio Code](https://code.visualstudio.com/docs/debugtest/debugging)).

The [GitHub Actions extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-github-actions) is highly recommended for syntax highlighting, validation and code completion for GitHub Actions workflows.

## Versioning

This project follows the [Semantic Versioning specification](https://semver.org/) for release tags.

We have enabled [immutable releases](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/immutable-releases) to prevent release tags from being changed after a release has been published.

## Testing

We perform [user acceptance tests](https://en.wikipedia.org/wiki/Acceptance_testing#User_acceptance_testing) for reusable workflows.

## Contributing

See [contributing guidelines](https://github.com/equinor/ops-actions/blob/main/CONTRIBUTING.md).

## License

This project is licensed under the terms of the [MIT license](https://github.com/equinor/ops-actions/blob/main/LICENSE).
