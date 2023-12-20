#!/usr/bin/env python3


import argparse
import os
import glob
import json

import yaml

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--path", type=str, default=".")
args = parser.parse_args()
path = args.path

terraformPath = os.path.join(path, "terraform")
modules = os.listdir(terraformPath)

# This script only cares about root modules.
# Exclude directory containing reusable modules.
if "modules" in modules:
    modules.remove("modules")

for mod in modules:
    servicePath = os.path.join(terraformPath, mod)
    environments = os.listdir(servicePath)
    pullRequestPaths = []

    for environment in environments:
        environmentPath = os.path.join(servicePath, environment)

        modulesCachePath = os.path.join(
            environmentPath, ".terraform/modules/modules.json"
        )

        with open(modulesCachePath, "r") as f:
            modulesCacheJson = f.read()
            f.close()

        modulesCache = json.loads(modulesCacheJson)
        modulesDependencies = modulesCache.get("Modules")

        for dep in modulesDependencies:
            moduleSource = os.path.join(environmentPath, dep.get("Source"))
            prPath = (os.path.relpath(moduleSource) + "/**").replace(path + "/", "")

            if os.path.exists(moduleSource) and prPath not in pullRequestPaths:
                pullRequestPaths.append(prPath)

    workflow = {
        "name": "Deploy " + mod,
        "on": {
            "pull_request": {"branches": ["main"], "paths": pullRequestPaths},
            "workflow_dispatch": {},
        },
        "jobs": {},
    }

    workflowYaml = yaml.safe_dump(workflow, sort_keys=False)

    print(workflowYaml)
