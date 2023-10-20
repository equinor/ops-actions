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

## Outputs
"""
########################################################################

def createMarkdownTable(items):
  table = "\n| Name | Type | Required | Default | Description |\n| --- | --- | --- | --- | --- |\n"
  for name, properties in items:
    type = properties.get("type") # Required
    required = properties.get("required", "")
    default = properties.get("default", "")
    description = properties.get("description", "")
    row = "| {0} | {1} | {2} | {3} | {4} |\n".format(name, type, required, default, description)
    table += row
  return table

def main(yamlFile, outputDir):
  with open(yamlFile, "r") as file:
    workflow = yaml.safe_load(file)

  workflow_name = workflow["name"]
  trigger = workflow[True]["workflow_call"]
  inputs = trigger["inputs"]
  # secrets = trigger["secrets"]
  # outputs = trigger["outputs"]

  inputsTable = createMarkdownTable(inputs.items())

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
  print(exampleYaml)
  exampleYamlString=yaml.dump(exampleYaml, sort_keys=False)

  outputFile = "{0}/{1}.md".format(outputDir, Path(yamlFile).stem)
  with open(outputFile, "w") as file:
    file.write(markdownTemplate.format(workflow_name, exampleYamlString, inputsTable))
    file.close()

if __name__ == "__main__":
  parser = ArgumentParser()
  parser.add_argument("-f", "--file", type=str)
  parser.add_argument("-o", "--output", type=str, default=".")
  args = parser.parse_args()
  yamlFile = args.file
  outputDir = args.output
  main(yamlFile, outputDir)

# TODO: create simple usage example:
