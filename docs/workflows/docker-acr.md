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
      registry_name: <string>
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
environment | string | False | N/A | The name of the GitHub environment that this job references.
working_directory | string | False | . | The path of the working directory containing the Dockerfile to build an image from.
registry_name | string | True | N/A | The name of the Azure Container Registry to push the Docker image to.
repository | string | False | ${{ github.repository }} | The repository in the Azure Container Registry to push the Docker image to.
tag | string | False | ${{ github.run_number }} | A tag for the image.

## Secrets

key | required | description
--- | --- | ---
AZURE_CLIENT_ID | True | The client ID of the Azure AD service principal to use for authenticating to Azure.
AZURE_SUBSCRIPTION_ID | True | The ID of the Azure subscription containing the Container Registry.
AZURE_TENANT_ID | True | The ID of the Azure tenant containing the Container Registry.

## Outputs

key | description
--- | ---
image | The Docker image that was built.
