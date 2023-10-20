# ♻ docker-acr

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/docker-acr.yml@v8.8.0
    inputs:
      registry_name: <registry_name>
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}

```

## Inputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| environment | string | False |  | The name of the GitHub environment that this job references. |
| working_directory | string | False | . | The path of the working directory containing the Dockerfile to build an image from. |
| registry_name | string | True |  | The name of the Azure Container Registry to push the Docker image to. |
| repository | string | False | ${{ github.repository }} | The repository in the Azure Container Registry to push the Docker image to. |
| tag | string | False | ${{ github.run_number }} | A tag for the image. |


## Secrets


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| AZURE_CLIENT_ID | None | True |  | The client ID of the Azure AD service principal to use for authenticating to Azure. |
| AZURE_SUBSCRIPTION_ID | None | True |  | The ID of the Azure subscription containing the Container Registry. |
| AZURE_TENANT_ID | None | True |  | The ID of the Azure tenant containing the Container Registry. |


## Outputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| image | None |  |  | The Docker image that was built. |


