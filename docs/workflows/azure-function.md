# ♻ azure-function

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/azure-function.yml@v8.8.0
    inputs:
      artifact_name: <string>
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
artifact_name | string | True | N/A | The name of the artifact containing the package to deploy.
app_name | string | True | N/A | The name of the Azure Function App to deploy the package to.
app_settings | string | False | N/A | App settings to configure for the Azure Function App. Inline JSON.

## Secrets

key | required | description
--- | --- | ---
AZURE_CLIENT_ID | True | The client ID of the Azure AD service principal to use for authenticating to Azure.
AZURE_SUBSCRIPTION_ID | True | The ID of the Azure subscription to deploy the package to.
AZURE_TENANT_ID | True | The ID of the Azure tenant to deploy the package to.

## Outputs

key | description
--- | ---
