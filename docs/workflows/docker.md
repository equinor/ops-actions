# ♻ docker

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/docker.yml@v8.8.0
    inputs:
      registry: <registry>
      username: <username>
    secrets:
      password: ${{ secrets.password }}

```

## Inputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| environment | string | False |  | The name of the GitHub environment that this job references. |
| working_directory | string | False | . | The path of the working directory containing the Dockerfile to build an image from. |
| registry | string | True |  | The URL of the Docker registry to push the image to. |
| username | string | True |  | The username used to login to the Docker registry. |
| repository | string | False | ${{ github.repository }} | The repository in the Docker registry to push the image to. |
| tag | string | False | ${{ github.run_number }} | A tag for the image. |


## Secrets


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| password | None | True |  | The password used to login to the Docker registry. |


## Outputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| image | None |  |  | The Docker image that was built. |


