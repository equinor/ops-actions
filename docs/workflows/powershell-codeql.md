# `powershell-codeql.yml`

A reusable GitHub Actions workflow for running PowerShell SAST with `py-psscriptanalyzer` and uploading the results to GitHub Advanced Security.

## Key Features

- **PowerShell security analysis**: Scans `.ps1`, `.psm1`, and `.psd1` files with `py-psscriptanalyzer`.
- **Integration with GitHub Advanced Security (GHAS)**: Outputs SARIF results which are uploaded to GitHub Advanced Security.
- **Clean skip behavior**: Exits cleanly when no PowerShell files are present in the repository.

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
      security-events: write
      actions: read
      contents: read
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
    # Run every Thursday at midnight
    - cron: "0 0 * * 4"

permissions: {}

jobs:
  analyze-powershell:
    name: Analyze PowerShell
    permissions:
      security-events: write
      actions: read
      contents: read
    uses: equinor/ops-actions/.github/workflows/powershell-codeql.yml@main
```

## Inputs

None

## Secrets

None
