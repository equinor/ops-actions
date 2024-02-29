# ♻ docker-acr

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/docker-acr.yml@v10.0.0
    with:
      registry_name: <string>
      client_id: <string>
      subscription_id: <string>
      tenant_id: <string>

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
environment | string | False | N/A | The name of the GitHub environment that this job references.
working_directory | string | False | . | The path of the working directory containing the Dockerfile to build an image from.
registry_name | string | True | N/A | The name of the Azure Container Registry to push the Docker image to.
repository | string | False | ${{ github.repository }} | The repository in the Azure Container Registry to push the Docker image to.
tag | string | False | ${{ github.run_number }} | A tag for the image.
client_id | string | True | N/A | The client ID of the Azure AD service principal to use for authenticating to Azure.
subscription_id | string | True | N/A | The ID of the Azure subscription containing the Container Registry.
tenant_id | string | True | N/A | The ID of the Azure tenant containing the Container Registry.

## Secrets

key | required | description
--- | --- | ---

## Outputs

key | description
--- | ---
image | The Docker image that was built.
