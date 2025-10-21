# `trivy.yml`

A reusable GitHub Actions workflow for running Trivy in IaC mode, container mode, or both.

## Key Features

- **Optional mode**: Runs Trivy with optional flags to enable or disable container mode or IaC mode.
- **Integration with GitHub Advanced Security (GHAS)**: Outputs to SERIF files which are uploaded to GitHub Advanced Security.

## Prerequisites

- Whitelisted actions:
  - `actions/Checkout`
  - `aquasecurity/trivy-action`
  - `github/codeql-action/*`
- Required permissions for `GITHUB_TOKEN`:

  ```yaml
    permissions:
      contents: read
      security-events: write
      actions: read
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
      contents: read
      actions: read
    uses: equinor/ops-actions/.github/workflows/trivy.yml@main
    with:
      scan_iac: true


```

## Inputs

### (*Optional*) `scan_iac`

Whether to run Trivy in Infrastructure as Code (IaC) scanning mode. Defaults to `true`

### (*Optional*) `scan_containers`

Whether to run Trivy in container image scanning mode. Defaults to `false`
Note! If `scan_containers` is enabled, `image_name` and `context_path` is also required!

### (*Optional*) `image_name`

The name of the container image to scan (required if `scan_containers` is `true`).

### (*Optional*) `context_path`

The build context path for the Docker image (required if `scan_containers` is `true`).

## Secrets

None
