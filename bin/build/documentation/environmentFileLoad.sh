#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--prefix - EnvironmentVariable|Blank. Optional. All subsequent environment variables are prefixed with this prefix."$'\n'"--require - Flag. Optional. All subsequent environment files on the command line will be required."$'\n'"--optional - Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)"$'\n'"--verbose - Flag. Optional. Output errors with variables in files."$'\n'"environmentFile - Required. Environment file to load. For \`--optional\` files the directory must exist."$'\n'"--ignore environmentName - String. Optional. Environment value to ignore on load."$'\n'"--secure environmentName - String. Optional. If found in a loaded file, entire file fails."$'\n'"--secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the \`--ignore\` list."$'\n'"--execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment files."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Safely load an environment file (no code execution)"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/environment/io.sh"
fn="environmentFileLoad"
fnMarker="environmentfileload"
foundNames=([0]="argument" [1]="return_code")
line="333"
rawComment="Safely load an environment file (no code execution)"$'\n'"Argument: --prefix - EnvironmentVariable|Blank. Optional. All subsequent environment variables are prefixed with this prefix."$'\n'"Argument: --require - Flag. Optional. All subsequent environment files on the command line will be required."$'\n'"Argument: --optional - Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)"$'\n'"Argument: --verbose - Flag. Optional. Output errors with variables in files."$'\n'"Argument: environmentFile - Required. Environment file to load. For \`--optional\` files the directory must exist."$'\n'"Argument: --ignore environmentName - String. Optional. Environment value to ignore on load."$'\n'"Argument: --secure environmentName - String. Optional. If found in a loaded file, entire file fails."$'\n'"Argument: --secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the \`--ignore\` list."$'\n'"Argument: --execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment files."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 2 - if file does not exist; outputs an error"$'\n'"Return Code: 0 - if files are loaded successfully"$'\n'""$'\n'""
return_code="2 - if file does not exist; outputs an error"$'\n'"0 - if files are loaded successfully"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="9d970c9247c918e4438d4046d4dcca32d13b665b"
sourceLine="333"
summary="Safely load an environment file (no code execution)"
summaryComputed="true"
usage="environmentFileLoad [ --prefix ] --require [ --optional ] [ --verbose ] environmentFile [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]"
