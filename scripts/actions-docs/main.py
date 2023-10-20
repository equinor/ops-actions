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

def createMarkdownTable(items, properties):
  """
  Create a Markdown table from given items based on given properties.
  """

  table = "\n| Name | "
  for p in properties:
    table += " {0} |".format(p)

  table += "\n| --- | --- | --- | --- | --- |\n" # TODO: dynamically create number of columns

  for key, value in items:
    row = "| {0} | ".format(key)

    for p in properties:
      v = value.get(p.lower(), "N/A")
      row += "{0} | ".format(v)

    table += "{0}\n".format(row)

  return table

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

  inputsTable = createMarkdownTable(inputs.items(), ["Type", "Required", "Default", "Description"])
  secretsTable = createMarkdownTable(secrets.items(), ["Type", "Required", "Default", "Description"]) # TODO
  outputsTable = createMarkdownTable(outputs.items(), ["Type", "Required", "Default", "Description"]) # TODO

  outputFile = "{0}/{1}.md".format(outputDir, Path(yamlFile).stem)
  with open(outputFile, "w") as file:
    file.write(markdownTemplate.format(workflow_name, exampleYamlString, inputsTable, secretsTable, outputsTable))
    file.close()

if __name__ == "__main__":
  parser = ArgumentParser()
  parser.add_argument("-f", "--file", type=str)
  parser.add_argument("-o", "--output", type=str, default=".")
  args = parser.parse_args()
  yamlFile = args.file
  outputDir = args.output
  main(yamlFile, outputDir)
