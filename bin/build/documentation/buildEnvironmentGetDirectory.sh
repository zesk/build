#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"--subdirectory subdirectory - String. Optional. Name of a subdirectory to return \"beneath\" the value of environment variable. Created if the flag is set."$'\n'"--mode fileMode - String. Optional. Enforce the mode for \`mkdir --mode\` and \`chmod\`. Use special mode \`-\` to mean no mode enforcement."$'\n'"--owner ownerName - String. Optional. Enforce the owner of the directory. Use special ownerName \`-\` to mean no owner enforcement."$'\n'"--no-create - Flag. Optional. Do not create the subdirectory if it does not exist."$'\n'""
base="build.sh"
description="Load and print one or more environment settings which represents a directory which should be created."$'\n'""$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'""$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'""$'\n'""$'\n'""
environment="\$envName"$'\n'"BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentGetDirectory"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1769063211"
summary="Load and print one or more environment settings which represents"
usage="buildEnvironmentGetDirectory [ envName ] [ --subdirectory subdirectory ] [ --mode fileMode ] [ --owner ownerName ] [ --no-create ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildEnvironmentGetDirectory[0m [94m[ envName ][0m [94m[ --subdirectory subdirectory ][0m [94m[ --mode fileMode ][0m [94m[ --owner ownerName ][0m [94m[ --no-create ][0m

    [94menvName                      [1;97mString. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and [38;2;0;255;0;48;2;0;0;0mexport[0med.[0m
    [94m--subdirectory subdirectory  [1;97mString. Optional. Name of a subdirectory to return "beneath" the value of environment variable. Created if the flag is set.[0m
    [94m--mode fileMode              [1;97mString. Optional. Enforce the mode for [38;2;0;255;0;48;2;0;0;0mmkdir --mode[0m and [38;2;0;255;0;48;2;0;0;0mchmod[0m. Use special mode [38;2;0;255;0;48;2;0;0;0m-[0m to mean no mode enforcement.[0m
    [94m--owner ownerName            [1;97mString. Optional. Enforce the owner of the directory. Use special ownerName [38;2;0;255;0;48;2;0;0;0m-[0m to mean no owner enforcement.[0m
    [94m--no-create                  [1;97mFlag. Optional. Do not create the subdirectory if it does not exist.[0m

Load and print one or more environment settings which represents a directory which should be created.

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
helpPlain='Usage: buildEnvironmentGetDirectory [ envName ] [ --subdirectory subdirectory ] [ --mode fileMode ] [ --owner ownerName ] [ --no-create ]

    envName                      String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and exported.
    --subdirectory subdirectory  String. Optional. Name of a subdirectory to return "beneath" the value of environment variable. Created if the flag is set.
    --mode fileMode              String. Optional. Enforce the mode for mkdir --mode and chmod. Use special mode - to mean no mode enforcement.
    --owner ownerName            String. Optional. Enforce the owner of the directory. Use special ownerName - to mean no owner enforcement.
    --no-create                  Flag. Optional. Do not create the subdirectory if it does not exist.

Load and print one or more environment settings which represents a directory which should be created.

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
