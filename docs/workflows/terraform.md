# ♻ terraform

```yaml
TODO: put usage example here.
```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
environment | string | True | N/A | The environment that the job references.
working_directory | string | False | . | The working directory to run the Terraform commands in.
terraform_version | string | False | ~1.5.0 | The version of Terraform to install.
backend_config | string | False |  | The path, relative to the working directory, of a configuration file containing the remaining arguments for a partial backend configuration.
artifact_name | string | False | terraform | The name of the artifact to upload.

## Secrets

key | required | description
--- | --- | ---
AZURE_CLIENT_ID | True | The client ID of the Azure AD service principal to use for authenticating to Azure.
AZURE_SUBSCRIPTION_ID | True | The ID of the Azure subscription to create the resources in.
AZURE_TENANT_ID | True | The ID of the Azure tenant to create the resources in.
ENCRYPTION_PASSWORD | True | A password used to encrypt the archive containing the Terraform configuration and plan file.

## Outputs

key | description
--- | ---