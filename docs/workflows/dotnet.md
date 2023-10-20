# ♻ dotnet

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: equinor/ops-actions/.github/workflows/dotnet.yml@v8.8.0
    inputs:
      dotnet_version: <string>
    secrets: {}

```

## Inputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| dotnet_version | string | True |  | The version of .NET to install. |
| ci | boolean | False | True | Configure workflow to run in CI mode. |
| project | string | False | . | Specify the path of the project or solution file, or the path of the directory containing the project or solution file. |
| runtime | string | False |  | Which runtime to publish the application for. |
| self_contained | boolean | False | False | Publish the .NET runtime with your application so the runtime doesn't need to be installed on the target machine? |
| test_project | string | False |  | Specify the path of a test project or solution file, or the path of a directory containing a test project or solution file. Pass a newline-separated string to specify multiple test projects. |
| test_collect | string | False |  | Enables data collector for the test run. |
| npm_version | string | False |  | A specific version of npm to install. Use to override pre-installed version on GitHub-hosted runners. |
| artifact_name | string | False | dotnet-app | The name of the build artifact to upload. |


## Secrets


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |


## Outputs


| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| artifact_name | None |  |  | The name of the uploaded artifact containing the application. |


