# ♻ terraform

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| environment | string | True | N/A | The environment that the job references. |
| working_directory | string | False | . | The working directory to run the Terraform commands in. |
| terraform_version | string | False | ~1.5.0 | The version of Terraform to install. |
| backend_config | string | False |  | The path, relative to the working directory, of a configuration file containing the remaining arguments for a partial backend configuration. |
| artifact_name | string | False | terraform | The name of the artifact to upload. |
