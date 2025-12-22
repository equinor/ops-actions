# Best practices

This document contains best practices for creating secure, reusable workflows.

Written as an extension of [Security hardening for GitHub Actions](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions). You should know the contents of that document.

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

- Consistency within a workflow > consistency across workflows.
- Add comments to clarify _why_ something is needed, not what it does.

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
          uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8
          with:
            persist-credentials: false
  ```

  This ensures that workflows follow the principle of least privilege.

- When using a third-party action, pin it to a specific commit SHA, for example:

  ```yaml
  - uses: actions/checkout@f43a0e5ff2bd294095638e18286ca9a3d1956744
  ```

- Jobs that access secrets that grant privileged access (for example `Contributor` access in an Azure subscription) should be skipped if the workflow was triggered by Dependabot:

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

  Jobs that access secrets that grant non-privileged access (for example `Reader` access in an Azure subscription) should **not** be skipped if the workflow was triggered by Dependabot. In this scenario, separate Dependabot secrets must be created in the repository containing the caller workflow (see [official documentation](https://docs.github.com/en/code-security/dependabot/working-with-dependabot/automating-dependabot-with-github-actions#accessing-secrets)).

- Set a specific runner OS version for all jobs (see [supported GitHub-hosted runners](https://docs.github.com/en/actions/using-github-hosted-runners/using-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources)):

  ```yaml
  jobs:
    example-job:
      runs-on: ubuntu-24.04
  ```

  This ensures that all jobs are executed on a runner that includes the required software by default.  
  **Please note: While a specific runner version ensures a consistent environment, some pre-installed packages may still be updated over time to address bugs or other issues. As a result, the exact package versions may vary.**

- Steps that use the [actions/checkout](https://github.com/actions/checkout) action should disable credential persistence unless explicitly required:

  ```yaml
  steps:
    - name: Checkout
      uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8
      with:
        persist-credentials: false
  ```

- Workflows that run [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/) commands should declare the following top level environment variable to disable output from Azure CLI commands by default:

  ```yaml
  env:
    AZURE_CORE_OUTPUT: none
  ```

  This is to prevent Azure CLI commands from outputting secrets. Output can be explicitly enabled for commands that require it by using the [`--output` global parameter](https://learn.microsoft.com/en-us/cli/azure/azure-cli-global-parameters?tabs=tabid-1#--output-global-parameter).

## Naming conventions

- Use [kebab-case](https://en.wiktionary.org/wiki/kebab_case) for workflow filenames, job identifiers and step identifiers.

- Use [snake_case](https://en.wiktionary.org/wiki/snake_case) for input and output identifiers.

- Use [SCREAMING_SNAKE_CASE](https://en.wiktionary.org/wiki/snake_case) for environment variable names.

- A reusable workflow and its main job should be named after the main tool/service that is used, for example:
  - `terraform.yml`
  - `docker.yml`
  - `azure-webapp.yml`

  This is to ensure descriptive job names, for example:
  - If a caller workflow has a job `provision` that calls the reusable workflow `terraform`, the final job will be named `provision / terraform`.
  - If a caller workflow has a job `build` that calls the reusable workflow `docker`, the final job will be named `build / docker`.
  - If a caller workflow has a job `deploy` that calls the reusable workflow `azure-webapp`, the final job will be named `deploy / azure-webapp`.

- A step should follow the naming convention `<verb> <noun>` (i.e., "do something"), for example:
    - `Download artifact`
    - `Deploy Azure Web App`
    - `Configure app settings`

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

        pip_target_dir:
          description: The target directory that pip should install packages into.
          type: string
          required: false

  jobs:
    python:
      runs-on: ${{ inputs.runs_on }}
      steps:
        - name: Checkout
          uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8
          with:
            persist-credentials: false

        - name: Setup Python
          uses: actions/setup-python@v5
          with:
            python-version: ${{ inputs.python_version }}

        - name: Install requirements
          env:
            PIP_TARGET_DIR: ${{ inputs.pip_target_dir }}
          run: pip install -r requirements.txt --target "$PIP_TARGET_DIR"
  ```

## Input and outputs

- For complex type inputs and outputs (i.e., objects and arrays), use JSON strings. For example:

    ```yaml
    # greetings.yml

    on:
      workflow_call:
        inputs:
          names:
            description: A JSON array of names to greet.
            type: string
            default: "[]"
    ```

    Use `jq` to parse the JSON string:

    ```yaml
    jobs:
      hello:
        runs-on: ubuntu-24.04
        steps:
          - name: Print greetings
            if: inputs.names != '[]'
            env:
              NAMES_JSON: ${{ inputs.names }}
            run: |
              readarray -t names <<< "$(echo "$NAMES_JSON" | jq -cr '.[]')"
              for name in "${names[@]}"; do
                echo "Hello $name!"
              done
    ```

    Alternatively, use the `fromJSON` function to parse the JSON string at the job level, for example to configure a matrix strategy:

    ```yaml
    jobs:
      hello:
        if: inputs.names != '[]'
        strategy:
          matrix:
            name: ${{ fromJSON(inputs.names) }}
        runs-on: ubuntu-24.04
        steps:
          - name: Print greetings
            env:
              NAME: ${{ matrix.name }}
            run: echo "Hello $NAME!"
    ```

    Example caller workflow:

    ```yaml
    # hello.yml
    
    on:
      push:
        branches: [main]

    jobs:
      main:
        uses: ./.github/workflows/greetings.yml
        with:
          names: '["Kari Nordmann", "Ola Nordmann"]'
    ```

### When you should add an input to a reusable workflow

It can be tempting to add inputs for every conceivable customisation, however this only contributes to diffusing the workflow and making it more, maybe unnecessarily, complex.

Generally, you should add new inputs only when:

- A value can vary from repo to repo and the variance makes sense.
- It adds something of value to the workflow.
- The input allows the workflow to be reused across different contexts without duplicating the workflow file.
- The customization is required by multiple caller workflows, not just a single use case.

You should NOT add new inputs when:

- The value is only used internally in the workflow, for example when a file is generated from a job step and is only used internally in the workflow.
- The input would override a security best practice or default that should be enforced consistently.
- A sensible default can be provided that works in most cases, and there's no clear benefit to making it configurable.
- The input would create breaking changes for existing caller workflows without significant value.

## Actions vs. command-line programs

A step can run an [action](https://docs.github.com/en/actions/concepts/workflows-and-actions/custom-actions) (a reusable unit of code) or command-line program:

- Actions are generally fine-tuned for GitHub Actions, and are better for setting up the runner and authenticating to cloud providers with OpenID Connect (OIDC).
- Command-line programs are generally better for building and testing your code.

For example:

1. The `actions/checkout` action checks out the repository on the runner.
1. The `actions/setup-python` action sets up Python on the runner.
1. The `python -m build` command-line program generates the Python package distributions.
1. The `pypa/gh-action-pypi-publish` action publishes the Python package distributions to PyPI with OIDC.

## Artifacts

- Workflows that upload or download an artifact must have an input `artifact_name` that specifies the name of the artifact to be uploaded or downloaded.
