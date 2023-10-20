# ♻ commitlint

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/commitlint.yml@v8.8.0
    inputs:
      message: <string>
    secrets: {}

```

## Inputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| node_version | string | False | lts/* | The version of Node.js to install. |
| commitlint_version | string | False | latest | The version of commitlint to install. |
| extends | string | False | @commitlint/config-conventional | Newline-separated string of shareable configurations to extend. |
| message | string | True |  | Commit message to lint. |
| help_url | string | False |  | Custom help URL for error messages. |


## Secrets


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |


## Outputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |


