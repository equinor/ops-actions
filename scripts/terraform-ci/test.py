#!/usr/bin/env python3

import argparse
import os
import glob


def getTerraformDirs(path):
    terraformPath = os.path.join(path, "terraform")
    dirs = []

    if os.path.isfile(terraformPath):
        return dirs

    files = glob.glob(terraformPath + "/**/*.tf", recursive=True)
    modulesPath = os.path.join(terraformPath, "modules")
    for file in files:
        # Ignore module files
        if not file.startswith(modulesPath):
            dir = os.path.dirname(file)
            if dir not in dirs:
                dirs.append(dir)

    return dirs


parser = argparse.ArgumentParser()
parser.add_argument("-p", "--path", type=str, default=".")
args = parser.parse_args()
path = args.path

terraformDirs = getTerraformDirs(path)
print(terraformDirs)
