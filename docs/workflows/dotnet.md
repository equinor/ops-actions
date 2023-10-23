# ♻ dotnet

```yaml
'on':
  push:
    branches:
    - main
jobs:
  main:
    uses: org/repo/.github/workflows/dotnet.yml@v8.8.0
    inputs:
      dotnet_version: <string>
    secrets: {}

```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
dotnet_version | string | True | N/A | The version of .NET to install.
ci | boolean | False | True | Configure workflow to run in CI mode.
project | string | False | . | Specify the path of the project or solution file, or the path of the directory containing the project or solution file.
runtime | string | False |  | Which runtime to publish the application for.
self_contained | boolean | False | False | Publish the .NET runtime with your application so the runtime doesn't need to be installed on the target machine?
test_project | string | False |  | Specify the path of a test project or solution file, or the path of a directory containing a test project or solution file. Pass a newline-separated string to specify multiple test projects.
test_collect | string | False |  | Enables data collector for the test run.
npm_version | string | False | N/A | A specific version of npm to install. Use to override pre-installed version on GitHub-hosted runners.
artifact_name | string | False | dotnet-app | The name of the build artifact to upload.

## Secrets

key | required | description
--- | --- | ---

## Outputs

key | description
--- | ---
artifact_name | The name of the uploaded artifact containing the application.