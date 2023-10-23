# Reusable workflows docs

Python script for automatically generating documentation for reusable GitHub Actions workflows.

## Prereqs

- Git
- Environment variable `GITHUB_REPO` in format `owner/repo`.

## Arguments

- `-p`, `--path`: the path containing the workflows to generate docs for. Default is `.github/workflows`.
- `-o`, `--output`: the output path to store the generated Markdown files in. Default is `docs/workflows`.

## Usage

> **Note** If using default values for arguments, must be run from the root of the repo.

```console
python3 actions-docs.py
```

Specify path and output:

```console
python3 actions-docs.py -p .github/workflows -o docs/workflows
```
