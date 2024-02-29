# ♻ super-linter

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/super-linter.yml@v10.0.0

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
filter_regex_exclude | string | False |  | Exclude files from linting using a regex pattern.

## Secrets

key | required | description
--- | --- | ---

## Outputs

key | description
--- | ---
