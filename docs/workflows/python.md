# ♻ python

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/python.yml@v8.8.0
    inputs: {}
    secrets: {}

```

## Inputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| working_directory | string | False | . | The path of the directory containing the Python application. |
| python_version | string | False | latest | The version of Python to install. |
| venv_path | string | False |  | The path to create a virtual Python environment at (relative to working directory). |
| pip_install_target | string | False |  | The target directory that PIP should install packages into (relative to working directory). |
| artifact_name | string | False | python-app | The name of the build artifact to upload. |


## Secrets


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |


## Outputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| artifact_name | None |  |  | The name of the uploaded artifact containing the application. |


