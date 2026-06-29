# `release-please.yml`

A reusable workflow that runs [Release Please](https://www.npmjs.com/package/release-please).

For advanced configuration and support for monorepos, use the [manifest-driven Release Please workflow](release-please-manifest.md) instead.

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
    uses: equinor/ops-actions/.github/workflows/release-please.yml@main
    permissions:
      contents: write
      issues: write
      pull-requests: write
```

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `release_type`

The type of release to create (see [supported release types](https://github.com/googleapis/release-please/blob/main/README.md#strategy-language-types-supported)). Defaults to `simple`.

## Outputs

### `pr_created`

`"true"` if a release PR was created or updated, else `"false"`.

### `pr_branch_name`

The branch name for the release PR that was created or updated, empty if a release PR was not created or updated.

### `release_created`

`"true"` if a release was created, else `"false"`.

### `tag_name`

The tag name that was created for the release, empty if a release was not created.
