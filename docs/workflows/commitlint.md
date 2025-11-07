# `commitlint.yml`

A reusable workflow that lints commit messages using [commitlint](https://commitlint.js.org/), ensuring that they follow the [Conventional Commits specification](https://www.conventionalcommits.org/en/v1.0.0/).

## Prerequisites

### (*Optional*) Configure commitlint

At the root of your repository, add a configuration file `.commitlintrc` and add your configuration.

For detailed instructions on configuring commitlint, please refer to the [official documentation](https://commitlint.js.org/reference/configuration.html).

## Usage

### Lint commit messages

Add a GitHub Actions workflow file `.github/workflows/lint.yml` in your repository, and add the following recommended configuration:

```yaml
name: Lint Codebase

on: [push, pull_request]

permissions: {}

jobs:
  lint-commits:
    name: Lint commits
    permissions:
      contents: read
    uses: equinor/ops-actions/.github/workflows/commitlint.yml@main
```

On push events, this workflow will automatically lint the last commit message. On pull request events, it will lint all commit messages in the pull request.

### Lint pull request title

Add a GitHub Actions workflow file `.github/workflows/lint-pr.yml` in your repository, and add the following recommended configuration:

```yaml
name: Lint Pull Request

on:
  pull_request:
    types:
      - opened
      - edited
      - synchronize
      - reopened

permissions: {}

jobs:
  lint-title:
    name: Lint PR title
    permissions:
      contents: read
    uses: equinor/ops-actions/.github/workflows/commitlint.yml@main
    with:
      message: ${{ github.event.pull_request.title }}
```

On pull request events, this workflow will automatically lint the pull request title.

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `node_version`

The version of Node.js to install. Defaults to `latest`.

### (*Optional*) `commitlint_version`

The version of commitlint to install. Defaults to `latest`.

### (*Optional*) `extends`

A JSON array of [shareable configurations](https://commitlint.js.org/concepts/shareable-config.html) to install. Defaults to `'["@commitlint/config-conventional"]'`.

### (*Optional*) `message`

A commit message to lint. Defaults to last commit message.

### (*Optional*) `help_url`

A custom help URL for error messages.

## References

- <https://commitlint.js.org/guides/ci-setup.html>
- <https://commitlint.js.org/reference/cli.html>
