#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="envName - String. Optional. Name of the environment value to find"$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="build.sh"
description="Determine the environment file names for environment variables"$'\n'""$'\n'""
environment="BUILD_ENVIRONMENT_DIRS"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentFiles"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1768843054"
summary="Determine the environment file names for environment variables"
usage="buildEnvironmentFiles [ envName ] [ --application applicationHome ] [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildEnvironmentFiles[0m [94m[ envName ][0m [94m[ --application applicationHome ][0m [94m[ --help ][0m [94m[ --handler handler ][0m

    [94menvName                        [1;97mString. Optional. Name of the environment value to find[0m
    [94m--application applicationHome  [1;97mPath. Optional. Directory of alternate application home. Can be specified more than once to change state.[0m
    [94m--help                         [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler              [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m

Determine the environment file names for environment variables

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_ENVIRONMENT_DIRS
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentFiles [ envName ] [ --application applicationHome ] [ --help ] [ --handler handler ]

    envName                        String. Optional. Name of the environment value to find
    --application applicationHome  Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
    --help                         Flag. Optional. Display this help.
    --handler handler              Function. Optional. Use this error handler instead of the default error handler.

Determine the environment file names for environment variables

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_ENVIRONMENT_DIRS
- 
'
