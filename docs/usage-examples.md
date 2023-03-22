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

## Create GitHub Issue

```yaml
name: rotate-secrets

on:
  schedule: "0 9 1 * *" # "At 09:00 on day-of-month 1."

jobs:
  create-issue:
    uses: equinor/ops-actions/.github/workflows/create-github-issue.yml@main
    with:
      title: Rotate secrets
      body: |
        - [ ] Delete expired client secrets
        - [ ] Create new client secret and set expiration to 3 months
        - [ ] Update key vault secret and set expiration to 3 months
      assignee: sneezy,sleepy,dopey,docs,happy,bashful,grumpy
```

## Create GitHub Issue from template

```yaml
name: rotate-secrets

on:
  schedule: "0 9 1 * *" # "At 09:00 on day-of-month 1."

jobs:
  create-issue:
    uses: equinor/ops-actions/.github/workflows/create-github-issue.yml@main
    with:
      title: Rotate secrets
      body_file: .github/ISSUE_TEMPLATE/secret-rotation.md
      assignee: sneezy,sleepy,dopey,docs,happy,bashful,grumpy
```

where contents of `.github/ISSUE_TEMPLATE/secret-rotation.md` is:

```markdown
- [ ] Delete expired client secrets
- [ ] Create new client secret and set expiration to 3 months
- [ ] Update key vault secret and set expiration to 3 months
```
