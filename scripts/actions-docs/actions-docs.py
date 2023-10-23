#!/usr/bin/python3


import subprocess
import yaml

from argparse import ArgumentParser
from pathlib import Path


########################################################################
# MARKDOWN TEMPLATE
########################################################################
markdownTemplate = """# {0}

```yaml
{1}
```

## Inputs

{2}

## Secrets

{3}

## Outputs

{4}"""
########################################################################


def createMarkdownTable(items: dict, columns: list):
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
      row.append(str(value))

    table.append(column_separator.join(row))

  # Return table in Markdown format
  return "\n".join(table)


def readReusableWorkflow():
  """
  Reads a reusable GitHub Actions workflow, and returns its inputs, secrets and outputs.
  """
  pass


def main(yamlFile, outputDir):
  with open(yamlFile, "r") as file:
    workflow = yaml.safe_load(file)

  workflow_name = workflow["name"]
  trigger = workflow[True]["workflow_call"]
  inputs = trigger.get("inputs", {})
  secrets = trigger.get("secrets", {})
  outputs = trigger.get("outputs", {})

  latestTag = subprocess.run(["git", "describe", "--tags", "--abbrev=0"], capture_output=True, text=True).stdout
  exampleYaml = {
    "on": {
      "push": {
        "branches": [
          "main"
        ]
      }
    },
    "jobs": {
      "main": {
        "uses": "equinor/ops-actions/.github/workflows/{0}.yml@{1}".format(Path(yamlFile).stem, latestTag.strip("\n"))
      }
    }
  }

  exampleInputs = {}
  for name, properties in inputs.items():
    required = properties["required"]
    type = properties["type"]
    if required:
      exampleInputs[name] = "<{0}>".format(type)

  exampleSecrets = {}
  for name, properties in secrets.items():
    required = properties["required"]
    if required:
      exampleSecrets[name] = "${{{{ secrets.{0} }}}}".format(name)

  exampleYaml["jobs"]["main"]["inputs"] = exampleInputs
  exampleYaml["jobs"]["main"]["secrets"] = exampleSecrets
  exampleYamlString=yaml.dump(exampleYaml, sort_keys=False)

  inputsTable = createMarkdownTable(inputs, ["type", "required", "default", "description"])
  secretsTable = createMarkdownTable(secrets, ["required", "description"])
  outputsTable = createMarkdownTable(outputs, ["description"])

  outputFile = "{0}/{1}.md".format(outputDir, Path(yamlFile).stem)
  with open(outputFile, "w") as file:
    file.write(markdownTemplate.format(workflow_name, exampleYamlString, inputsTable, secretsTable, outputsTable))
    file.close()


parser = ArgumentParser()
parser.add_argument("-p", "--path", type=str, default=".github/workflows")
parser.add_argument("-o", "--output", type=str, default="docs/workflows")
args = parser.parse_args()
yamlFile = args.file
outputDir = args.output
main(yamlFile, outputDir)
