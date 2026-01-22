#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="path - String. Optional. Path to check."$'\n'""
base="directory.sh"
description="Is a path an absolute path?"$'\n'"Return Code: 0 - if all paths passed in are absolute paths (begin with \`/\`)."$'\n'"Return Code: 1 - one ore more paths are not absolute paths"$'\n'""
file="bin/build/tools/directory.sh"
fn="pathIsAbsolute"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1768756695"
summary="Is a path an absolute path?"
usage="pathIsAbsolute [ path ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpathIsAbsolute[0m [94m[ path ][0m

    [94mpath  [1;97mString. Optional. Path to check.[0m

Is a path an absolute path?
Return Code: 0 - if all paths passed in are absolute paths (begin with [38;2;0;255;0;48;2;0;0;0m/[0m).
Return Code: 1 - one ore more paths are not absolute paths

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: pathIsAbsolute [ path ]

    path  String. Optional. Path to check.

Is a path an absolute path?
Return Code: 0 - if all paths passed in are absolute paths (begin with /).
Return Code: 1 - one ore more paths are not absolute paths

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
