#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="filename - File. Optional. Docker environment file to check for common issues"$'\n'""
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileBashCompatibleToDocker"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceModified="1769063211"
stdin="text - Environment file to convert. (Optional)"$'\n'""
stdout="text - Only if stdin is supplied and no \`filename\` arguments."$'\n'""
summary="Ensure an environment file is compatible with non-quoted docker environment"
usage="environmentFileBashCompatibleToDocker [ filename ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentFileBashCompatibleToDocker[0m [94m[ filename ][0m

    [94mfilename  [1;97mFile. Optional. Docker environment file to check for common issues[0m

Ensure an environment file is compatible with non-quoted docker environment files
Return Code: 1 - if errors occur
Return Code: 0 - if file is valid

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
text - Environment file to convert. (Optional)

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
text - Only if stdin is supplied and no [38;2;0;255;0;48;2;0;0;0mfilename[0m arguments.
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileBashCompatibleToDocker [ filename ]

    filename  File. Optional. Docker environment file to check for common issues

Ensure an environment file is compatible with non-quoted docker environment files
Return Code: 1 - if errors occur
Return Code: 0 - if file is valid

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
text - Environment file to convert. (Optional)

Writes to stdout:
text - Only if stdin is supplied and no filename arguments.
'
