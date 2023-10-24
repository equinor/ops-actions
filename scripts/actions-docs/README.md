# Actions Docs

This directory contains a Python script `actions-docs.sh` that will automatically generate documentation for reusable GitHub Actions workflows.

## Prerequisites

- [Install Python](https://www.python.org/downloads/) (latest version as of writing: `3.10.12`) - to run Python script.
- [Install pip](https://pip.pypa.io/en/stable/installation/) (latest version as of writing: `22.0.2`) - to install required Python packages.
- [Install GitHub CLI](https://cli.github.com) (latest version as of writing: `2.37.0`) - to get the name and latest release of the GitHub repository containing the reusable workflows.

## Arguments

- `-o`, `--output`: the output path to store the generated Markdown files in. Default is `docs/workflows`.

## Usage

> **Note**
>
> Must be run from the root of the repository.

1. Install requirements:

    ```console
    python -m pip install --upgrade pip
    pip install -r scripts/actions-docs/requirements.txt
    ```

1. Run the script:

    ```console
    ./scripts/actions-docs/actions-docs.py
    ```

    Specify output path:

    ```console
    ./scripts/actions-docs/actions-docs.py -o docs/workflows
    ```
