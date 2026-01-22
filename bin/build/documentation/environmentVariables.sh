#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="none"
base="environment.sh"
description="Output a list of environment variables and ignore function definitions"$'\n'""$'\n'"both \`set\` and \`env\` output functions and this is an easy way to just output"$'\n'"exported variables"$'\n'""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentVariables"
foundNames=""
requires="declare grep cut usageDocument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769063211"
summary="Output a list of environment variables and ignore function definitions"
usage="environmentVariables"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentVariables[0m

Output a list of environment variables and ignore function definitions

both [38;2;0;255;0;48;2;0;0;0mset[0m and [38;2;0;255;0;48;2;0;0;0menv[0m output functions and this is an easy way to just output
exported variables

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentVariables

Output a list of environment variables and ignore function definitions

both set and env output functions and this is an easy way to just output
exported variables

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
