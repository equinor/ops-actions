#!/usr/bin/python3


import os
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


def readReusableWorkflow(path: str):
  """
  Reads a reusable GitHub Actions workflow, and returns its name, inputs, secrets and outputs.
  """

  with open(path, "r") as file:
    workflow = yaml.safe_load(file)

  name = workflow.get("name", Path(path).stem)

  triggers = workflow.get(True, None) # YAML property "on" interpreted as True
  if triggers is None:
    print("{0} is not a reusable workflow".format(path))
    return None

  call_trigger = triggers.get("workflow_call", None)
  if call_trigger is None:
    print("{0} is not a reusable workflow".format(path))
    return None

  inputs = call_trigger.get("inputs", {})
  secrets = call_trigger.get("secrets", {})
  outputs = call_trigger.get("outputs", {})

  return name, inputs, secrets, outputs


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


# Get arguments
parser = ArgumentParser()
parser.add_argument("-p", "--path", type=str, default=".github/workflows")
parser.add_argument("-o", "--output", type=str, default="docs/workflows")
args = parser.parse_args()
path = args.path
output = args.output

# Get repo from envvar
repo=os.getenv("GITHUB_REPO", "org/repo")

# Get latest Git tag
latestTag = subprocess.run(["git", "describe", "--tags", "--abbrev=0"], capture_output=True, text=True).stdout.strip("\n")

workflows = os.listdir(path)

for wf in workflows:
  wfPath = os.path.join(path, wf)
  # name, inputs, secrets, outputs = readReusableWorkflow(wfPath)
  wfOut = readReusableWorkflow(wfPath)
  if wfOut is None:
    continue

  name = wfOut[0]
  inputs = wfOut[1]
  secrets = wfOut[2]
  outputs = wfOut[3]

  inputsTable = createMarkdownTable(inputs, ["type", "required", "default", "description"])
  secretsTable = createMarkdownTable(secrets, ["required", "description"])
  outputsTable = createMarkdownTable(outputs, ["description"])

  # CREATE USAGE EXAMPLE

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
        "uses": "{0}/{1}@{2}".format(repo, wfPath, latestTag)
      }
    }
  }

  exampleInputs = {}
  for name, properties in inputs.items():
    required = properties["required"]
    if required:
      type = properties["type"]
      exampleInputs[name] = "<{0}>".format(type)

  exampleSecrets = {}
  for name, properties in secrets.items():
    required = properties["required"]
    if required:
      exampleSecrets[name] = "${{{{ secrets.{0} }}}}".format(name)

  exampleYaml["jobs"]["main"]["inputs"] = exampleInputs
  exampleYaml["jobs"]["main"]["secrets"] = exampleSecrets
  exampleYamlString=yaml.dump(exampleYaml, sort_keys=False)

  outPath = os.path.join(output, Path(wf).stem + ".md")
  with open(outPath, "w") as file:
    file.write(markdownTemplate.format(name, exampleYamlString, inputsTable, secretsTable, outputsTable))
    file.close()
