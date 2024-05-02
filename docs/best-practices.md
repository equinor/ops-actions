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

## Naming conventions

- Use [kebab case](https://en.wiktionary.org/wiki/kebab_case) for workflow and job names.

- A reusable workflow and its main job should be named after the main tool/service that is used, for example:

  - `terraform.yml`
  - `docker.yml`
  - `azure-webapp.yml`

  This is to ensure descriptive job names, for example:

  - If a caller workflow has a job `provision` that calls the reusable workflow `terraform`, the final job will be named `provision / terraform`.
  - If a caller workflow has a job `build` that calls the reusable workflow `docker`, the final job will be named `build / docker`.
  - If a caller workflow has a job `deploy` that calls the reusable workflow `azure-webapp`, the final job will be named `deploy / azure-webapp`.

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

  Workflows that download an artifact must extract the tarball:

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
