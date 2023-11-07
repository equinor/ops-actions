# ♻ docker

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/docker.yml@v8.10.1
    with:
      registry: <string>
      username: <string>
    secrets:
      password: ${{ secrets.password }}

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
environment | string | False | N/A | The name of the GitHub environment that this job references.
working_directory | string | False | . | The path of the working directory containing the Dockerfile to build an image from.
registry | string | True | N/A | The URL of the Docker registry to push the image to.
username | string | True | N/A | The username used to login to the Docker registry.
repository | string | False | ${{ github.repository }} | The repository in the Docker registry to push the image to.
tag | string | False | ${{ github.run_number }} | A tag for the image.

## Secrets

key | required | description
--- | --- | ---
password | True | The password used to login to the Docker registry.

## Outputs

key | description
--- | ---
image | The Docker image that was built.
