# `zizmor-codeql.yml`

A reusable GitHub Actions workflow for running the Zizmor linter, and uploading the results to Github Actions.

## Key Features

- **Config file**: Optionally takes a Zizmor config file as argument. See [Zizmor docs](https://docs.zizmor.sh/audits/) for more information.
- **Integration with GitHub Advanced Security (GHAS)**: Outputs to SERIF files which are uploaded to GitHub Advanced Security.

## Prerequisites

### Configure GitHub repository

- [Allowing select actions and reusable workflows to run](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#allowing-select-actions-and-reusable-workflows-to-run)
- Whitelisted actions:
  - `actions/Checkout`
  - `astral-sh/setup-uv`
  - `github/codeql-action/*`
- Required permissions for `GITHUB_TOKEN`:

  ```yaml
    permissions:
      contents: read
      security-events: write
      actions: read
  ```

## Usage

Add a GitHub Actions workflow file `.github/workflows/code-scanning.yml` in your repository, and add the following recommended configuration:

```yaml
name: Code scanning

on:
  push:
    branches: [main]
  pull_request:
    # The branches below must be a subset of the branches above
    branches: [main]
  schedule:
    - cron: "0 0 * * 4" # Weekly scan every Thursday at midnight

permissions: {}

jobs:
  github-actions:
    name: GitHub Actions
    permissions:
      actions: read
      contents: read
      security-events: write
    uses: equinor/ops-actions/.github/workflows/zizmor-codeql.yml@main
    with:
      config_file: .github/zizmor.yml
```

## Inputs

### (*Optional*) `config_file`

Path to an optional config file as defined in the [Zizmor docs](https://docs.zizmor.sh/configuration/). Defaults to `null`

## Example config file

This example allows the mentioned actions groups to be pinned to reference (i.e. tag or release), while all other actions must be pinned to a full SHA hash:

```yaml
rules:
  unpinned-uses:
    config:
      policies:
        actions/*: ref-pin
        github/codeql-action/*: ref-pin
        azure/*: ref-pin
        "*": hash-pin

```

## Secrets

None
