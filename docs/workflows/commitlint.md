# ♻ commitlint

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/commitlint.yml@v8.10.1
    with:
      message: <string>

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
node_version | string | False | lts/* | The version of Node.js to install.
commitlint_version | string | False | latest | The version of commitlint to install.
extends | string | False | @commitlint/config-conventional | Newline-separated string of shareable configurations to extend.
message | string | True | N/A | Commit message to lint.
help_url | string | False | N/A | Custom help URL for error messages.

## Secrets

key | required | description
--- | --- | ---

## Outputs

key | description
--- | ---
