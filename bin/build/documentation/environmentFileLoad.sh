#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--prefix - EnvironmentVariable|Blank. Optional. All subsequent environment variables are prefixed with this prefix."$'\n'"--require - Flag. Optional. All subsequent environment files on the command line will be required."$'\n'"--optional - Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)"$'\n'"--verbose - Flag. Optional. Output errors with variables in files."$'\n'"environmentFile - Required. Environment file to load. For \`--optional\` files the directory must exist."$'\n'"--ignore environmentName - String. Optional. Environment value to ignore on load."$'\n'"--secure environmentName - String. Optional. If found in a loaded file, entire file fails."$'\n'"--secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the \`--ignore\` list."$'\n'"--execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment files."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Safely load an environment file (no code execution)"$'\n'"Return Code: 2 - if file does not exist; outputs an error"$'\n'"Return Code: 0 - if files are loaded successfully"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentFileLoad"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768759812"
summary="Safely load an environment file (no code execution)"
usage="environmentFileLoad [ --prefix ] --require [ --optional ] [ --verbose ] environmentFile [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]"
