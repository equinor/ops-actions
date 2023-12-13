# Terraform CI

This directory contains a script that will automatically generate GitHub Actions workflows for your Terraform configurations.

## Prerequisites

- [Install Python](https://www.python.org/downloads/) (latest version as of writing: `3.10.12`) - to run Python script.
- [Install pip](https://pip.pypa.io/en/stable/installation/) (latest version as of writing: `23.3.1`) - to install required Python packages.

## Arguments

- `-c`, `--config`: the path of the config file. See [config spec](#config-spec).

## Usage

> **Note**
>
> Must be run from the root of the repository.

1. Install requirements:

    ```console
    python -m pip install --upgrade pip
    pip install -r scripts/terraform-ci/requirements.txt
    ```

1. Create a config file `config.yml` (see [config spec](#config-spec)).

1. Run script:

    ```console
    ./scripts/terraform-ci/run.py --config config.yml
    ```

## Config spec

Consider the following file structure:

```plaintext
terraform/
  shared/
    dev/
      main.tf
    test/
      main.tf
    qa/
      main.tf
    prod/
      main.tf
  core/
    dev/
      main.tf
    test/
      main.tf
    qa/
      main.tf
    prod/
      main.tf
  non-prod.azurerm.tfbackend.json
  prod.azurerm.tfbackend.json
```

Example config file:

```yaml
modules:
  shared:
    environments:
      dev:
        backend_config: non-prod.azurerm.tfbackend.json
      test:
        backend_config: non-prod.azurerm.tfbackend.json
      qa:
        backend_config: non-prod.azurerm.tfbackend.json
      prod:
        backend_config: prod.azurerm.tfbackend.json

  core:
    environments:
      dev:
        backend_config: non-prod.azurerm.tfbackend.json
      test:
        backend_config: non-prod.azurerm.tfbackend.json
      qa:
        backend_config: non-prod.azurerm.tfbackend.json
      prod:
        backend_config: prod.azurerm.tfbackend.json
```
