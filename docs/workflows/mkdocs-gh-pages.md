# ♻ mkdocs-gh-pages

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/mkdocs-gh-pages.yml@v10.0.1

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
python_version | string | False | latest | The version of Python to install.
mkdocs_version | string | False | >=1.0.0 | The version of MkDocs to install using PIP.
requirements | string | False |  | The path of a file containing the Python packages to install using PIP, usually "requirements.txt".

## Secrets

key | required | description
--- | --- | ---

## Outputs

key | description
--- | ---
