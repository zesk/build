#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'""
base="build.sh"
description="Load and print one or more environment settings"$'\n'""$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'""$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'""$'\n'""$'\n'""
environment="\$envName"$'\n'"BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentGet"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1768843054"
summary="Load and print one or more environment settings"
usage="buildEnvironmentGet [ envName ] [ --application applicationHome ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildEnvironmentGet[0m [94m[ envName ][0m [94m[ --application applicationHome ][0m

    [94menvName                        [1;97mString. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and [38;2;0;255;0;48;2;0;0;0mexport[0med.[0m
    [94m--application applicationHome  [1;97mPath. Optional. Directory of alternate application home. Can be specified more than once to change state.[0m

Load and print one or more environment settings

If BOTH files exist, both are sourced, so application environments should anticipate values
created by build'\''s default.

Modifies local environment. Not usually run within a subshell.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- $envName
- BUILD_ENVIRONMENT_DIRS - [38;2;0;255;0;48;2;0;0;0m:[0m separated list of paths to load env files
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentGet [ envName ] [ --application applicationHome ]

    envName                        String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and exported.
    --application applicationHome  Path. Optional. Directory of alternate application home. Can be specified more than once to change state.

Load and print one or more environment settings

If BOTH files exist, both are sourced, so application environments should anticipate values
created by build'\''s default.

Modifies local environment. Not usually run within a subshell.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- $envName
- BUILD_ENVIRONMENT_DIRS - : separated list of paths to load env files
- 
'
