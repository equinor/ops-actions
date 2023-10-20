# ♻ azure-webapp

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/azure-webapp.yml@v8.8.0
    inputs:
      app_name: <app_name>
    secrets:
      AZURE_CLIENT_ID: <AZURE_CLIENT_ID>
      AZURE_SUBSCRIPTION_ID: <AZURE_SUBSCRIPTION_ID>
      AZURE_TENANT_ID: <AZURE_TENANT_ID>

```

## Inputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| environment | string | False |  | The name of the GitHub environment that this job references. |
| image | string | False |  | The Docker image to deploy. Required if "artifact_name" is not set. |
| artifact_name | string | False |  | The name of the artifact containing the package to deploy. Required if "image" is not set. |
| app_name | string | True |  | The name of the Azure Web App to deploy the Docker image to. |
| app_settings | string | False |  | App settings to configure for the Azure Web App. Inline JSON. |


## Secrets

## Outputs
