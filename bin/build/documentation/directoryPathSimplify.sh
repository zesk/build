#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="path ... - File. Required. One or more paths to simplify"$'\n'""
base="file.sh"
description="Normalizes segments of \`/./\` and \`/../\` in a path without using \`realPath\`"$'\n'"Removes dot and dot-dot paths from a path correctly"$'\n'""
file="bin/build/tools/file.sh"
fn="directoryPathSimplify"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1769063211"
summary="Normalizes segments of \`/./\` and \`/../\` in a path without"
usage="directoryPathSimplify path ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdirectoryPathSimplify[0m [38;2;255;255;0m[35;48;2;0;0;0mpath ...[0m[0m

    [31mpath ...  [1;97mFile. Required. One or more paths to simplify[0m

Normalizes segments of [38;2;0;255;0;48;2;0;0;0m/./[0m and [38;2;0;255;0;48;2;0;0;0m/../[0m in a path without using [38;2;0;255;0;48;2;0;0;0mrealPath[0m
Removes dot and dot-dot paths from a path correctly

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: directoryPathSimplify path ...

    path ...  File. Required. One or more paths to simplify

Normalizes segments of /./ and /../ in a path without using realPath
Removes dot and dot-dot paths from a path correctly

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
