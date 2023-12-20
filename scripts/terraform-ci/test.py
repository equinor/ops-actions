#!/usr/bin/env python3


import argparse
import os
import glob


parser = argparse.ArgumentParser()
parser.add_argument("-p", "--path", type=str, default=".")
args = parser.parse_args()
path = args.path

terraformPath = os.path.join(path, "terraform")
dirs = []

files = glob.glob(terraformPath + "/**/*.tf", recursive=True)
modulesPath = os.path.join(terraformPath, "modules")
for file in files:
    # Ignore module files
    if not file.startswith(modulesPath):
        dir = os.path.dirname(file)
        if dir not in dirs:
            dirs.append(dir)

print(dirs)
