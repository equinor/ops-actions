# `trivy-config-codeql.yml`

A reusable GitHub Actions workflow for running Trivy in IaC mode, container mode, or both.

## Key Features

- **Integration with GitHub Advanced Security (GHAS)**: Outputs to SERIF files which are uploaded to GitHub Advanced Security.

## Prerequisites

### Configure GitHub repository

- [Allowing select actions and reusable workflows to run](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#allowing-select-actions-and-reusable-workflows-to-run)
- Whitelisted actions:
  - `actions/Checkout`
  - `aquasecurity/trivy-action`
  - `github/codeql-action/*`
- Required permissions for `GITHUB_TOKEN`:

  ```yaml
    permissions:
      security-events: write
      actions: read
      contents: read
  ```

## Usage

Add a GitHub Actions workflow file `.github/workflows/trivy.yml` in your repository, and add the following recommended configuration:

```yaml
name: trivy

on:
  push:
    branches: ["main"]
  pull_request:
    # The branches below must be a subset of the branches above
    branches: ["main"]
  schedule:
    - cron: "23 3 * * 6"

permissions: {}

jobs:
  trivy:
    name: Run Trivy IaC Scan and upload results to GitHub Security
    permissions:
      security-events: write
      actions: read
      contents: read
    uses: equinor/ops-actions/.github/workflows/trivy-config-codeql.yml@main
    with:
      scan_iac: true


```

## Inputs

### (*Optional*) `severity`

A comma-separated string listing the alert severities you want to return. (Defaults to `CRITICAL,HIGH`)

## Secrets

None
