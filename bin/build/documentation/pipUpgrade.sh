#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--bin binary - Executable. Optional. Binary for \`pip\`."$'\n'""
base="python.sh"
description="Utility to upgrade pip correctly"$'\n'""
file="bin/build/tools/python.sh"
fn="pipUpgrade"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceModified="1768721469"
summary="Utility to upgrade pip correctly"
usage="pipUpgrade [ --help ] [ --bin binary ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpipUpgrade[0m [94m[ --help ][0m [94m[ --bin binary ][0m

    [94m--help        [1;97mFlag. Optional. Display this help.[0m
    [94m--bin binary  [1;97mExecutable. Optional. Binary for [38;2;0;255;0;48;2;0;0;0mpip[0m.[0m

Utility to upgrade pip correctly

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: pipUpgrade [ --help ] [ --bin binary ]

    --help        Flag. Optional. Display this help.
    --bin binary  Executable. Optional. Binary for pip.

Utility to upgrade pip correctly

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
