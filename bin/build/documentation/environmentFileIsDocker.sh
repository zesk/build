#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="filename - Docker environment file to check for common issues"$'\n'""
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileIsDocker"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceModified="1769063211"
summary="Ensure an environment file is compatible with non-quoted docker environment"
usage="environmentFileIsDocker [ filename ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentFileIsDocker[0m [94m[ filename ][0m

    [94mfilename  [1;97mDocker environment file to check for common issues[0m

Ensure an environment file is compatible with non-quoted docker environment files
Return Code: 1 - if errors occur
Return Code: 0 - if file is valid

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileIsDocker [ filename ]

    filename  Docker environment file to check for common issues

Ensure an environment file is compatible with non-quoted docker environment files
Return Code: 1 - if errors occur
Return Code: 0 - if file is valid

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
