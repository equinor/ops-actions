#!/usr/bin/env python3


import os
import subprocess
from argparse import ArgumentParser
from pathlib import Path
from typing import Any, Dict

import yaml


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

md_template = """# {workflow_name}

```yaml
{usage_example_yaml}
```

## Inputs

{workflow_inputs}

## Secrets

{workflow_secrets}

## Outputs

{workflow_outputs}
"""

###############################################################################
# PARSE OPTIONAL SCRIPT ARGUMENTS
###############################################################################

parser = ArgumentParser()
parser.add_argument("-p", "--path", type=str, default=".github/workflows")
parser.add_argument("-o", "--output", type=str, default="docs/workflows")
args = parser.parse_args()
workflows_path = args.path
output_path = args.output

###############################################################################
# CREATE OUTPUT DIRECTORY
###############################################################################

os.makedirs(output_path, exist_ok=True)

###############################################################################
# GET GITHUB REPO NAME
###############################################################################

repo = subprocess.run(
    ["gh", "repo", "view", "--json", "nameWithOwner", "--jq", ".nameWithOwner"],
    capture_output=True,
    text=True,
).stdout.strip("\n")

###############################################################################
# GET LATEST GITHUB RELEASE
###############################################################################

latest_tag = subprocess.run(
    ["gh", "release", "view", "--json", "tagName", "--jq", ".tagName"],
    capture_output=True,
    text=True,
).stdout.strip("\n")

###############################################################################
# GET ALL REUSABLE WORKFLOW FILES AT GIVEN PATH
###############################################################################

workflow_files = os.listdir(workflows_path)

for workflow_file in workflow_files:
    ############################################################################
    # READ REUSABLE WORKFLOW
    ############################################################################

    workflow_path = os.path.join(workflows_path, workflow_file)

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

    workflow_file = Path(workflow_path).name

    usage_example: Dict[str, Any] = {
        "on": {"push": {"branches": ["main"]}},
        "jobs": {
            "main": {
                "uses": "{0}/.github/workflows/{1}@{2}".format(
                    repo, workflow_file, latest_tag
                )
            }
        },
    }

    example_inputs = {}

    for name, properties in workflow_inputs.items():
        required = properties.get("required")

        if required:
            type = properties.get("type")
            example_inputs[name] = "<{0}>".format(type)

    if len(example_inputs) > 0:
        usage_example["jobs"]["main"]["with"] = example_inputs

    example_secrets = {}

    for name, properties in workflow_secrets.items():
        required = properties.get("required")

        if required:
            example_secrets[name] = "${{{{ secrets.{0} }}}}".format(name)

    if len(example_secrets) > 0:
        usage_example["jobs"]["main"]["secrets"] = example_secrets

    usage_example_yaml = yaml.dump(usage_example, sort_keys=False)

    ############################################################################
    # CREATE OUTPUT MARKDOWN FILE
    ############################################################################

    base_name = os.path.basename(workflow_path)
    base_name_without_extension = os.path.splitext(base_name)[0]
    output_file = os.path.join(output_path, base_name_without_extension + ".md")

    with open(output_file, "w") as f:
        f.write(
            md_template.format(
                workflow_name=workflow_name,
                usage_example_yaml=usage_example_yaml,
                workflow_inputs=workflow_inputs_md,
                workflow_secrets=workflow_secrets_md,
                workflow_outputs=workflow_outputs_md,
            )
        )
        f.close()
