#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Output the list of environment variable names which can be loaded via \`buildEnvironmentLoad\` or \`buildEnvironmentGet\`"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentNames"
foundNames=""
requires="convertValue _buildEnvironmentPath find sort read __help catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1769063211"
summary="Output the list of environment variable names which can be"
usage="buildEnvironmentNames [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildEnvironmentNames[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Output the list of environment variable names which can be loaded via [38;2;0;255;0;48;2;0;0;0mbuildEnvironmentLoad[0m or [38;2;0;255;0;48;2;0;0;0mbuildEnvironmentGet[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentNames [ --help ]

    --help  Flag. Optional. Display this help.

Output the list of environment variable names which can be loaded via buildEnvironmentLoad or buildEnvironmentGet

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
