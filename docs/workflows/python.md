# ♻ python

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/python.yml@v10.0.1

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
working_directory | string | False | . | The path of the directory containing the Python application.
python_version | string | False | latest | The version of Python to install.
venv_path | string | False | N/A | The path to create a virtual Python environment at (relative to working directory).
pip_install_target | string | False | N/A | The target directory that PIP should install packages into (relative to working directory).
artifact_name | string | False | python-app | The name of the build artifact to upload.

## Secrets

key | required | description
--- | --- | ---

## Outputs

key | description
--- | ---
artifact_name | The name of the uploaded artifact containing the application.
