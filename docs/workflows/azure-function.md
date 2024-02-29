# ♻ azure-function

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/azure-function.yml@v10.0.0
    with:
      artifact_name: <string>
      app_name: <string>
      client_id: <string>
      subscription_id: <string>
      tenant_id: <string>

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
environment | string | False | N/A | The name of the GitHub environment that this job references.
artifact_name | string | True | N/A | The name of the artifact containing the package to deploy.
app_name | string | True | N/A | The name of the Azure Function App to deploy the package to.
app_settings | string | False | N/A | App settings to configure for the Azure Function App. Inline JSON.
client_id | string | True | N/A | The client ID of the Azure AD service principal to use for authenticating to Azure.
subscription_id | string | True | N/A | The ID of the Azure subscription to deploy the package to.
tenant_id | string | True | N/A | The ID of the Azure tenant to deploy the package to.

## Secrets

key | required | description
--- | --- | ---

## Outputs

key | description
--- | ---
