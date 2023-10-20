import argparse
import yaml

from pathlib import Path

def main(yamlFile, outputDir):
  with open(yamlFile, "r") as file:
    workflow = yaml.safe_load(file)

  workflow_name = workflow["name"]
  trigger = workflow[True]["workflow_call"]
  inputs = trigger["inputs"]
  # secrets = trigger["secrets"]

  table = "| Name | Type | Required | Default | Description |\n| --- | --- | --- | --- | --- |\n"

  for name, properties in inputs.items():
    type = properties.get("type")
    required = properties.get("required", "N/A")
    default = properties.get("default", "N/A")
    description = properties.get("description", "N/A")
    row = "| {0} | {1} | {2} | {3} | {4} |\n".format(name, type, required, default, description)
    table += row

  markdown = """# {0}

## Inputs

{1}""".format(workflow_name, table)

  outputFile = "{0}/{1}.md".format(outputDir, Path(yamlFile).stem)
  with open(outputFile, "w") as file:
    file.write(markdown)
    file.close()

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("-f", "--file", type=str)
  parser.add_argument("-o", "--output", type=str, default=".")
  args = parser.parse_args()
  yamlFile = args.file
  outputDir = args.output
  main(yamlFile, outputDir)
