# AZURE_TENANT_ID

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: org/repo/.github/workflows/azure-webapp.yml@v8.8.0
    inputs:
      app_name: <string>
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
environment | string | False | N/A | The name of the GitHub environment that this job references.
image | string | False | N/A | The Docker image to deploy. Required if "artifact_name" is not set.
artifact_name | string | False | N/A | The name of the artifact containing the package to deploy. Required if "image" is not set.
app_name | string | True | N/A | The name of the Azure Web App to deploy the Docker image to.
app_settings | string | False | N/A | App settings to configure for the Azure Web App. Inline JSON.

## Secrets

key | required | description
--- | --- | ---
AZURE_CLIENT_ID | True | The client ID of the Azure AD service principal to use for authenticating to Azure.
AZURE_SUBSCRIPTION_ID | True | The ID of the Azure subscription containing the Azure Web App.
AZURE_TENANT_ID | True | The ID of the Azure tenant containing the Azure Web App.

## Outputs

key | description
--- | ---