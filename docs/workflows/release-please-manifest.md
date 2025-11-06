# `release-please-manifest.yml`

A reusable workflow that runs manifest-driven [Release Please](https://www.npmjs.com/package/release-please). Requires more initial setup than the [basic Release Please workflow](release-please.md), but supports advanced configuration and monorepos.

## Key Features

- **Advanced configuration** using a `release-please-config.json` configuration file.
- **Monorepo support**: package version tracking using a `.release-please-manifest.json` manifest file.

## Prerequisites

### Configure Release Please

1. Add a `release-please-config.json` configuration file at the root of your repository, and define your packages. Optionally, define a root package `"."` that combines all packages in your repository. For example:

    ```json
    {
      "$schema": "https://raw.githubusercontent.com/googleapis/release-please/main/schemas/config.json",
      "release-type": "python",
      "packages": {
        "packages/example-package": {
          "package-name": "example-package"
        },
        ".": {
          "package-name": "root-package",
          "include-component-in-tag": false
        }
      }
    }
    ```

1. Add a `.release-please-manifest.json` manifest file at the root of your repository, and add an initial empty JSON object:

    ```json
    {}
    ```

For detailed instructions on configuring Release Please, please refer to the [official documentation](https://github.com/googleapis/release-please/blob/main/docs/manifest-releaser.md).

### Configure GitHub repository

1. [Enforce commit squashing for pull requests](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/configuring-commit-squashing-for-pull-requests)
1. [Allow GitHub Actions to create pull requests](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#preventing-github-actions-from-creating-or-approving-pull-requests)

### (*Optional*) Configure commitlint

Use the [commitlint workflow](commitlint.md) to lint PR titles, ensuring that they follow the Conventional Commits specification.

## Usage

Add a GitHub Actions workflow file `.github/workflows/release.yml` in your repository, and add the following recommended configuration:

```yaml
name: Release

on:
  push:
    branches: [main]

permissions: {}

jobs:
  release:
    name: Release
    uses: equinor/ops-actions/.github/workflows/release-please-manifest.yml@main
    permissions:
      contents: write
      pull-requests: write
```

On push to branch `main`, this workflow will automatically create release PRs based on your commit messages.

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

## Outputs

### `release_created`

`true` if any release was created, else `false`.

### `paths_released`

A JSON array of paths that had releases created, `[]` if nothing was released. Use the `fromJSON` function to convert this value to an array that can be used to define a matrix strategy job
