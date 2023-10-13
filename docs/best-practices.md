# Best practices

## General

- Don't create reusable workflows containing a single step.
  This adds unnecessary complexity to the workflow chain.

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
