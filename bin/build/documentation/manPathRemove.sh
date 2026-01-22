#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/manpath.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"path - Directory. Required. The path to be removed from the \`MANPATH\` environment"$'\n'""
base="manpath.sh"
description="Remove a path from the MANPATH environment variable"$'\n'""
file="bin/build/tools/manpath.sh"
fn="manPathRemove"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceModified="1769063211"
summary="Remove a path from the MANPATH environment variable"
usage="manPathRemove [ --help ] path"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmanPathRemove[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mpath[0m[0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [31mpath    [1;97mDirectory. Required. The path to be removed from the [38;2;0;255;0;48;2;0;0;0mMANPATH[0m environment[0m

Remove a path from the MANPATH environment variable

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: manPathRemove [ --help ] path

    --help  Flag. Optional. Display this help.
    path    Directory. Required. The path to be removed from the MANPATH environment

Remove a path from the MANPATH environment variable

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
