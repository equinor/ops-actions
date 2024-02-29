# ♻ azure-webapp

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@v10.0.0
    with:
      app_name: <string>
      client_id: <string>
      subscription_id: <string>
      tenant_id: <string>

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
environment | string | False | N/A | The name of the GitHub environment that this job references.
image | string | False | N/A | The Docker image to deploy. Required if "artifact_name" is not set.
artifact_name | string | False | N/A | The name of the artifact containing the package to deploy. Required if "image" is not set.
app_name | string | True | N/A | The name of the Azure Web App to deploy the Docker image to.
app_settings | string | False | N/A | App settings to configure for the Azure Web App. Inline JSON.
client_id | string | True | N/A | The client ID of the Azure AD service principal to use for authenticating to Azure.
subscription_id | string | True | N/A | The ID of the Azure subscription containing the Azure Web App.
tenant_id | string | True | N/A | The ID of the Azure tenant containing the Azure Web App.

## Secrets

key | required | description
--- | --- | ---

## Outputs

key | description
--- | ---
