# Reusable workflows docs

Python script for automatically generating documentation for reusable GitHub Actions workflows.

## Prereqs:

- Git

## Arguments

- `-f`, `--file`: the input workflow YAML file.
- `-o`, `--output`: the output path to store the Markdown file in.

## Usage

```console
python3 main.py -f <file_path>
```

For example:

```console
python3 main.py -f ../../.github/workflows/terraform.yml
```
