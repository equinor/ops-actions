# ♻ terraform

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/terraform.yml@v10.0.0
    with:
      environment: <string>
      client_id: <string>
      subscription_id: <string>
      tenant_id: <string>
    secrets:
      ENCRYPTION_PASSWORD: ${{ secrets.ENCRYPTION_PASSWORD }}

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
runs_on | string | False | ubuntu-latest | The label of the runner (GitHub- or self-hosted) to run this workflow on.
environment | string | True | N/A | The environment that the job references.
working_directory | string | False | . | The working directory to run the Terraform commands in.
terraform_version | string | False | latest | The version of Terraform to install.
client_id | string | True | N/A | The client ID of the Azure AD service principal to use for authenticating to Azure.
subscription_id | string | True | N/A | The ID of the Azure subscription to create the resources in.
tenant_id | string | True | N/A | The ID of the Azure tenant to create the resources in.
backend_config | string | False |  | The path, relative to the working directory, of a configuration file containing the remaining arguments for a partial backend configuration.
artifact_name | string | False |  | The name of the artifact to upload. If not specified, an artifact name will be generated based on the environment name.

## Secrets

key | required | description
--- | --- | ---
ENCRYPTION_PASSWORD | True | A password used to encrypt the archive containing the Terraform configuration and plan file.

## Outputs

key | description
--- | ---
