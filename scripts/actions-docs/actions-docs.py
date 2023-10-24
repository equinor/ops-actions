#!/usr/bin/python3


import os
import subprocess
import yaml

from argparse import ArgumentParser
from pathlib import Path


def dict_to_md_table(items: dict, columns: list):
    """
    Convert a given dictionary "items" to a string in Markdown table format.

    The given list "columns" defines which values to extract from the dictionary.

    A column "key" will always be created based on each key in the dictionary.
    """

    table = []

    # Create column headers
    column_separator = " | "
    table.append(column_separator.join(["key"] + columns))
    table.append(column_separator.join(["---"] * (len(columns) + 1)))

    # Create rows
    for key, item in items.items():
        row = [key]

        for column in columns:
            value = item.get(column, "N/A")
            row.append(
                str(value).replace("\n", "<br>")
            )  # Markdown tables do not support newlines in cells

        table.append(column_separator.join(row))

    # Return table in Markdown format
    return "\n".join(table)


########################################################################
# DEFINE MARKDOWN TEMPLATE
########################################################################

md_template = """# {0}

```yaml
{1}
```

## Inputs

{2}

## Secrets

{3}

## Outputs

{4}"""

###############################################################################
# PARSE OPTIONAL SCRIPT ARGUMENTS
###############################################################################

parser = ArgumentParser()
parser.add_argument("-p", "--path", type=str, default=".github/workflows")
parser.add_argument("-o", "--output", type=str, default="docs/workflows")
args = parser.parse_args()
path = args.path
output = args.output

###############################################################################
# GET REQUIRED ENVIRONMENT VARIABLES
###############################################################################

repo = os.getenv("GITHUB_REPO", "org/repo")

###############################################################################
# GET LATEST RELEASE FROM GIT TAGS
###############################################################################

latestTag = subprocess.run(
    ["git", "describe", "--tags", "--abbrev=0"], capture_output=True, text=True
).stdout.strip("\n")

###############################################################################
# GET ALL REUSABLE WORKFLOW FILES AT GIVEN PATH
###############################################################################

workflow_files = os.listdir(path)

for workflow_file in workflow_files:
    ############################################################################
    # READ REUSABLE WORKFLOW
    ############################################################################

    workflow_path = os.path.join(path, workflow_file)

    with open(workflow_path, "r") as f:
        workflow = yaml.safe_load(f)

    workflow_name = workflow.get("name", Path(workflow_path).stem)

    ############################################################################
    # GET WORKFLOW TRIGGERS
    ############################################################################

    # NOTE: YAML property "on" interpreted as True by PyYAML
    workflow_triggers = workflow.get(True, None)

    if workflow_triggers is None:
        print("{0} is not a reusable workflow".format(workflow_file))
        continue

    workflow_call = workflow_triggers.get("workflow_call", None)

    if workflow_call is None:
        print("{0} is not a reusable workflow".format(workflow_file))
        continue

    ############################################################################
    # GET WORKFLOW INPUTS, SECRETS AND OUTPUTS
    ############################################################################

    workflow_inputs = workflow_call.get("inputs", {})
    workflow_secrets = workflow_call.get("secrets", {})
    workflow_outputs = workflow_call.get("outputs", {})

    workflow_inputs_md = dict_to_md_table(
        workflow_inputs, ["type", "required", "default", "description"]
    )

    workflow_secrets_md = dict_to_md_table(
        workflow_secrets, ["required", "description"]
    )

    workflow_outputs_md = dict_to_md_table(workflow_outputs, ["description"])

    ############################################################################
    # CREATE USAGE EXAMPLE
    ############################################################################

    usage_example = {
        "on": {"push": {"branches": ["main"]}},
        "jobs": {
            "main": {"uses": "{0}/{1}@{2}".format(repo, workflow_path, latestTag)}
        },
    }

    example_inputs = {}

    for name, properties in workflow_inputs.items():
        required = properties.get("required")

        if required:
            type = properties.get("type")
            example_inputs[name] = "<{0}>".format(type)

    if len(example_inputs) > 0:
        usage_example["jobs"]["main"]["inputs"] = example_inputs

    example_secrets = {}

    for name, properties in workflow_secrets.items():
        required = properties.get("required")

        if required:
            example_secrets[name] = "${{{{ secrets.{0} }}}}".format(name)

    if len(example_secrets) > 0:
        usage_example["jobs"]["main"]["secrets"] = example_secrets

    usage_example_yaml = yaml.dump(usage_example, sort_keys=False)

    output_file = os.path.join(output, Path(workflow_path).stem + ".md")

    with open(output_file, "w") as f:
        f.write(
            md_template.format(
                workflow_name,
                usage_example_yaml,
                workflow_inputs_md,
                workflow_secrets_md,
                workflow_outputs_md,
            )
        )
        f.close()
