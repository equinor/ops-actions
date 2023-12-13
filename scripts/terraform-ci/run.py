#!/usr/bin/env python3

import json
import os

import yaml

from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("-c", "--config", type=str, default=".")
args = parser.parse_args()
configPath = args.config

with open(configPath, "r") as f:
    config = yaml.safe_load(f)
    f.close()

modules = config["modules"]

jobYaml = """
name: Deploy {environment}
uses: equinor/ops-actions/.github/workflows/terraform.yml@v8.12.0
with:
  environment: {environment}
  working_directory: {workingDirectory}
  backend_config: {backendConfig}
  artifact_name: terraform-{environment}
secrets: inherit
"""

for module in modules:
    pullRequestPaths = []
    jobs = {}

    environments = modules["core"]["environments"]
    for env in environments:
        workingDir = "terraform/{module}/{environment}".format(
            module=module, environment=env
        )
        backendConfig = environments[env]["backend_config"]
        job = jobYaml.format(
            environment=env, workingDirectory=workingDir, backendConfig=backendConfig
        )
        jobs["deploy-" + env] = yaml.safe_load(job)

        modulesCachePath = os.path.join(workingDir, ".terraform/modules/modules.json")
        with open(modulesCachePath, "r") as f:
            modulesCacheJson = f.read()
            f.close()

        modulesCache = json.loads(modulesCacheJson)
        modulesDependencies = modulesCache.get("Modules")

        for dep in modulesDependencies:
            moduleSource = os.path.join(workingDir, dep.get("Source"))
            prPath = os.path.relpath(moduleSource) + "/**"
            if os.path.exists(moduleSource) and prPath not in pullRequestPaths:
                pullRequestPaths.append(prPath)

    workflow = {
        "name": "Deploy " + module,
        "on": {
            "pull_request": {"branches": ["main"], "paths": pullRequestPaths},
            "workflow_dispatch": {},
        },
        "jobs": jobs,
    }

    workflowFile = "terraform-{module}.yml".format(module=module)

    with open(workflowFile, "w") as f:
        f.write(yaml.dump(workflow, sort_keys=False))
        f.close()
