# `mkdocs.yml`

A reusable workflow that builds an MkDocs site and prepares it for deployment.

## Prerequisites

- [Configure GitHub Actions as the publishing source for your GitHub Pages site](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#publishing-with-a-custom-github-actions-workflow)

## Usage

### Publish to GitHub Pages

Add a GitHub Actions workflow file `.github/workflows/publish-docs.yml` in your repository, and add the following recommended configuration:

```yaml
name: Publish Docs

on:
  push:
    branches: [main]

permissions: {}

jobs:
  build:
    name: Build
    permissions:
      contents: read
    uses: equinor/ops-actions/.github/workflows/mkdocs.yml@main
    with:
      python_version: 3.13
      mkdocs_version: 1.6.1
      requirements: requirements-docs.txt

  deploy:
    name: Deploy
    needs: build
    permissions:
      pages: write
      id-token: write
    uses: equinor/ops-actions/.github/workflows/github-pages.yml@main
    with:
      artifact_name: ${{ needs.build.outputs.artifact_name }}
```

On push to branch `main`, this workflow will automatically build your MkDocs site and publish it to GitHub Pages.

## Inputs

### (*Optional*) `runs_on`

The label of the runner (GitHub- or self-hosted) to run this workflow on. Defaults to `ubuntu-24.04`.

### (*Optional*) `git_fetch_depth`

The number of commits that Git should fetch. Defaults to `1` (to decrease build time). Fetch depth `0` required by some MkDocs plugins.

### (*Optional*) `python_version`

The version of Python to install. Defaults to the version specified in a `.python-version` file.

### (*Optional*) `mkdocs_version`

The version of MkDocs to install using pip. Defaults to `>=1.0.0`.

### (*Optional*) `requirements`

The path of a pip requirements file (usually `requirements.txt`) that specifies dependencies to install.

### (*Optional*) `strict_mode`

Should strict mode be enabled? This will cause MkDocs to abort the build on any warnings. Defaults to `false`.

### (*Optional*) `upload_artifact`

Should the build artifact be uploaded? Defaults to `true`.

### (*Optional*) `artifact_name`

The name of the build artifact. Defaults to `mkdocs`.

## Outputs

### `artifact_uploaded`

Was the build artifact uploaded?

### `artifact_name`

The name of the uploaded build artifact. Value is `"true"` if the build artifact was uploaded, else `"false"`.
