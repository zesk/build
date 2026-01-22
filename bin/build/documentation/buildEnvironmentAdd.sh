#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project."$'\n'""
base="environment.sh"
description="Adds an environment variable file to a project"$'\n'""
file="bin/build/tools/environment.sh"
fn="buildEnvironmentAdd"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769063211"
summary="Adds an environment variable file to a project"
usage="buildEnvironmentAdd [ --help ] environmentName ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildEnvironmentAdd[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0menvironmentName ...[0m[0m

    [94m--help               [1;97mFlag. Optional. Display this help.[0m
    [31menvironmentName ...  [1;97mEnvironmentName. Required. One or more environment variable names to add to this project.[0m

Adds an environment variable file to a project

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentAdd [ --help ] environmentName ...

    --help               Flag. Optional. Display this help.
    environmentName ...  EnvironmentName. Required. One or more environment variable names to add to this project.

Adds an environment variable file to a project

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
