# Usage examples

This document contains usage examples for the reusable workflows in this repository.

## Build Python application and deploy to Azure Function App

```yaml
name: deploy-azure-function

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/build-python.yml@v6.5.0
    with:
      working_directory: src
      python_version: "3.10"
      pip_install_target: .python_packages/lib/site-packages # Required

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/deploy-azure-function.yml@v6.5.0
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: example-func
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Build Python application and deploy to Azure Web App

```yaml
name: deploy-azure-webapp

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/build-python.yml@v6.5.0
    with:
      working_directory: src
      python_version: "3.10"
      venv_path: antenv # Required
      pip_install_target: .python_packages/lib/site-packages # Required

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/deploy-azure-webapp.yml@v6.5.0
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: example-app
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

## Build .NET application and deploy to Azure Web App

```yaml
name: deploy-azure-webapp

on:
  push:
    branches: [main]

jobs:
  build:
    uses: equinor/ops-actions/.github/workflows/build-dotnet.yml@main
    with:
      dotnet_version: "6.0.x"
      project: src/Example/Example.csproj
      test_project: |-
        tests/Example.UnitTests/Example.UnitTests.csproj
        tests/Example.IntegrationTests/Example.IntegrationTests.csproj
      test_collect: XPlat Code Coverage

  deploy:
    needs: build
    uses: equinor/ops-actions/.github/workflows/deploy-azure-webapp.yml@main
    with:
      environment: development
      artifact_name: ${{ needs.build.outputs.artifact_name }}
      app_name: example-app
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```
