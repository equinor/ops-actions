# Best practices

## General

- Don't create reusable workflows containing a single step.
  This adds unnecessary complexity to the workflow chain.

- Workflows should depend on source code, e.g. using the `actions/checkout` or `actions/download-artifact` actions.

  For workflows that don't depend on source code, consider using another automation system instead,
  e.g. [Azure Automation](https://learn.microsoft.com/en-us/azure/automation/overview) for automating tasks in Azure.

- Don't create conditionals based on the event that triggered the workflow, for example:

  ```yaml
  jobs:
    example-job:
      if: github.event_type == 'pull_request'
  ```

  This reduces the flexibility of the reusable workflow.

## Security

- Disable top level GitHub token permissions, then enable required permissions at the job level instead:

    ```yaml
    permissions: {}

    jobs:
      example-job:
        runs-on: ubuntu-latest
        permissions:
          contents: read # Required to checkout the repository
        steps:
          - name: Checkout
            uses: actions/checkout@v4
    ```

    This ensures that workflows follow the principle of least privilege.

- Jobs that access secrets that grant privileged access (for example `Write` access in a GitHub repository, or `Contributor` access in an Azure subscription) should be skipped if the workflow was triggered by Dependabot:

    ```yaml
    jobs:
      example-job:
        runs-on: ubuntu-latest
        if: github.actor != 'dependabot[bot]'
      steps:
        - name: Login to Azure
          uses: azure/login@v2
          with:
            client-id: ${{ secrets.AZURE_CLIENT_ID }}
            subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
            tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    ```

    This is to prevent Dependabot from updating a dependency to a version containing malicious code, then automatically running that code in our workflow, allowing it to steal your secrets.

    Jobs that access secrets that grant non-privileged access (for example `Read` access in a GitHub repository, or `Reader` access in an Azure subscription) should **not** be skipped if the workflow was triggered by Dependabot. In this scenario, separate Dependabot secrets must be created in the repository containing the caller workflow (see [official documentation](https://docs.github.com/en/code-security/dependabot/working-with-dependabot/automating-dependabot-with-github-actions#accessing-secrets)).

## Naming conventions

- Use [kebab case](https://en.wiktionary.org/wiki/kebab_case) for workflow file names, job identifiers and step identifiers.

- Use [snake case](https://en.wiktionary.org/wiki/snake_case) for input and output identifiers.

- A reusable workflow and its main job should be named after the main tool/service that is used, for example:

  - `terraform.yml`
  - `docker.yml`
  - `azure-webapp.yml`

  This is to ensure descriptive job names, for example:

  - If a caller workflow has a job `provision` that calls the reusable workflow `terraform`, the final job will be named `provision / terraform`.
  - If a caller workflow has a job `build` that calls the reusable workflow `docker`, the final job will be named `build / docker`.
  - If a caller workflow has a job `deploy` that calls the reusable workflow `azure-webapp`, the final job will be named `deploy / azure-webapp`.

- An input that is passed to a workflow property should inherit the name of that property.

  An input that is passed to an action input should follow the common naming convention `[<action>]_<input>`, where `<action>` can be omitted if the name of the action is similar to the name of the workflow.

  An input that is passed to a CLI command option should follow the common naming convention `[<command>]_<option>`.

  For example:

  ```yaml
  # python.yml

  on:
    workflow_call:
      inputs:
        runs_on:
          description: The type of machine to run the job on.
          type: string
          required: false
          default: ubuntu-latest

        python_version:
          description: The version of Python to use.
          type: string
          required: false
          default: latest

        pip_install_target:
          description: The target directory that pip should install packages into.
          type: string
          required: false
          default: ""

  jobs:
    python:
      runs-on: ${{ inputs.runs_on }}
      steps:
        - name: Checkout
          uses: actions/checkout@v4

        - name: Setup Python
          uses: actions/setup-python@v5
          with:
            python-version: ${{ inputs.python_version }}

        - name: Install requirements
          env:
            PIP_INSTALL_TARGET: ${{ inputs.pip_install_target }}
          run: pip install -r requirements.txt --target "$PIP_INSTALL_TARGET"
  ```

## Actions

- When using an action from a trusted GitHub organization (for example `actions`, `hashicorp`, `docker` or `Azure`), pin it to a specific release tag, for example:

  ```yaml
  - uses: actions/checkout@v3
  ```

  When using an action from an untrusted GitHub organization or a user, pin it to a specific commit SHA, for example:

  ```yaml
  - uses: GeekyEggo/delete-artifact@54ab544f12cdb7b71613a16a2b5a37a9ade990af
    with:
      name: my-artifact
  ```

## Artifacts

- Workflows that upload or download an artifact must have an input `artifact_name` that specifies the name of the artifact to be uploaded or downloaded.

- Don't upload multiple files to an artifact. Collect the files in a tarball and upload that instead:

  ```yaml
  - name: Create tarball
    id: tar
    env:
      ARTIFACT_NAME: ${{ inputs.artifact_name }}
    run: |
      tarball="$RUNNER_TEMP/$ARTIFACT_NAME.tar"
      tar -cvf "$tarball" .
      echo "tarball=$tarball" >> "$GITHUB_OUTPUT"

  - name: Upload artifact
    uses: actions/upload-artifact@v4
    with:
      name: ${{ inputs.artifact_name }}
      path: ${{ steps.tar.outputs.tarball }}
  ```

  This will drastically improve upload performance, as the `actions/upload-artifact` action will only need to make a single request to the GitHub API to upload the tarball, instead of multiple requests to upload each individual file.

- Workflows that download an artifact must extract the tarball:

  ```yaml
  - name: Download artifact
    uses: actions/download-artifact@v4
    with:
      name: ${{ inputs.artifact_name }}

  - name: Extract tarball
    env:
      ARTIFACT_NAME: ${{ inputs.artifact_name }}
    run: |
      tarball="$ARTIFACT_NAME.tar"
      tar -xvf "$tarball"
      rm "$tarball"
  ```
