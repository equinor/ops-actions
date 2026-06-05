# Copilot Instructions

## What this repository is

A collection of [reusable GitHub Actions workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for common operational tasks. All reusable workflows live in `.github/workflows/`. Documentation is built with MkDocs and lives in `docs/`.

## Documentation development

```sh
pip install -r requirements-docs.txt
mkdocs serve        # local dev server at http://localhost:8000
```

## Architecture

Each `.github/workflows/*.yml` file is a standalone reusable workflow (`on: workflow_call`). Caller workflows reference them as:

```yaml
uses: equinor/ops-actions/.github/workflows/{filename}@{ref}
```

There are no shared libraries or cross-workflow dependencies — each workflow is self-contained. Workflows are tested through user acceptance tests in external repositories, not automated test suites.

## Conventions

### Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/). Scope must match the workflow filename without `.yml`:

```
feat(docker): add support for multi-platform builds
fix(terraform): handle empty plan output
```

Allowed types: `feat`, `fix`, `deps`, `revert`, `docs`, `style`, `chore`, `refactor`, `ci`. If no workflow file was changed, use `chore` with no scope.

### Naming

- Workflow filenames, job IDs, step IDs: `kebab-case`
- Inputs and outputs: `snake_case`
- Environment variables: `SCREAMING_SNAKE_CASE`
- Steps follow the pattern `<Verb> <Noun>`: e.g., `Download artifact`, `Deploy Azure Web App`
- Input names mirror the property/option they configure: `python_version` → `python-version`, `pip_target_dir` → `pip install --target`

### Security

- Always set `permissions: {}` at the top level; grant only required permissions per-job
- Pin third-party actions to a full commit SHA with the release tag in a comment:
  ```yaml
  uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
  ```
- Always set `persist-credentials: false` on `actions/checkout` unless explicitly required
- Use a specific runner version like `ubuntu-24.04`, not `ubuntu-latest`
- Jobs that access privileged secrets must skip Dependabot: `if: github.actor != 'dependabot[bot]'`
- Workflows that run Azure CLI commands must set this top-level env var to suppress secret leakage:
  ```yaml
  env:
    AZURE_CORE_OUTPUT: none
  ```

### Inputs and outputs

- Use JSON strings for array/object inputs (type: `string`), parsed in steps with `jq` or `fromJSON`
- Add inputs only when the value meaningfully varies across callers — don't expose every knob
- Never add inputs that would override a security default

### Artifacts

- Workflows that upload artifacts must expose an `artifact_name` input
- Collect all files into a tarball before uploading (single API call, much faster)
- Workflows that download artifacts must extract the tarball and delete it afterward

### Workflow design

- Don't create a reusable workflow that contains only a single step
- Don't add `if:` conditionals based on `github.event_type` — this reduces caller flexibility
- Use GitHub Actions (e.g., `actions/setup-python`) for runner setup and OIDC auth; use CLI tools for building/testing
