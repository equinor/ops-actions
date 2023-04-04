# Best practices

## General

- Don't create reusable workflows containing a single step.
  This adds unnecessary complexity to the workflow chain.

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
