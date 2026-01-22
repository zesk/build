#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="name - String. Required. The log file name to create. Trims leading \`_\` if present."$'\n'"--no-create - Flag. Optional. Do not require creation of the directory where the log file will appear."$'\n'""
base="build.sh"
description="Generate the path for a quiet log in the build cache directory, creating it if necessary."$'\n'""$'\n'""
file="bin/build/tools/build.sh"
fn="buildQuietLog"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1768843054"
summary="Generate the path for a quiet log in the build"
usage="buildQuietLog name [ --no-create ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildQuietLog[0m [38;2;255;255;0m[35;48;2;0;0;0mname[0m[0m [94m[ --no-create ][0m

    [31mname         [1;97mString. Required. The log file name to create. Trims leading [38;2;0;255;0;48;2;0;0;0m_[0m if present.[0m
    [94m--no-create  [1;97mFlag. Optional. Do not require creation of the directory where the log file will appear.[0m

Generate the path for a quiet log in the build cache directory, creating it if necessary.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: buildQuietLog name [ --no-create ]

    name         String. Required. The log file name to create. Trims leading _ if present.
    --no-create  Flag. Optional. Do not require creation of the directory where the log file will appear.

Generate the path for a quiet log in the build cache directory, creating it if necessary.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
