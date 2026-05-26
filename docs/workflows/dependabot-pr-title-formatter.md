# `dependabot-pr-title-formatter.yml`

A reusable GitHub Actions workflow for formatting Dependabot pull request titles.
It wraps the package name in backticks for titles matching `deps: bump <package> from <old> to <new>`, and skips updates when the title is already formatted or does not match the expected pattern.

Example:

Before: deps: bump actions/checkout from 5.0.0 to 6.0.2 \
After:  deps: bump `actions/checkout` from 5.0.0 to 6.0.2

## Usage

Add a GitHub Actions workflow file `.github/workflows/format-dependabot-pr-title.yml` in your repository, and add the following recommended configuration:

```yaml
name: Format Dependabot PR Title

on:
  pull_request:
    types:
      - opened
      - edited
      - synchronize
      - reopened

permissions: {}

jobs:
  format-dependabot-pr-title:
    name: Format Dependabot PR Title
    if: github.actor == 'dependabot[bot]'
    permissions:
      pull-requests: write # Required to edit pull request titles
    uses: equinor/ops-actions/.github/workflows/dependabot-pr-title-formatter.yml@main
```
