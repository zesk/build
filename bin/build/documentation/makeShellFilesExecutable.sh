#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'""
base="platform.sh"
description="Makes all \`*.sh\` files executable"$'\n'""$'\n'""
environment="Works from the current directory"$'\n'""
file="bin/build/tools/platform.sh"
fn="makeShellFilesExecutable"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="makeShellFilesExecutable"$'\n'"chmod-sh.sh"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceModified="1768873865"
summary="Makes all \`*.sh\` files executable"
todo="- findArguments is different here than other places"$'\n'""
usage="makeShellFilesExecutable [ --find findArguments ] [ path ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmakeShellFilesExecutable[0m [94m[ --find findArguments ][0m [94m[ path ... ][0m

    [94m--find findArguments  [1;97mString. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options.[0m
    [94mpath ...              [1;97mDirectory. Optional. One or more paths to scan for shell files. Uses PWD if not specified.[0m

Makes all [38;2;0;255;0;48;2;0;0;0m[36m.sh[0m files executable[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Works from the current directory
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: makeShellFilesExecutable [ --find findArguments ] [ path ... ]

    --find findArguments  String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options.
    path ...              Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified.

Makes all .sh files executable

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Works from the current directory
- 
'
