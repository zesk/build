#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="--bin binary - Executable. Optional. Binary for \`pip\`."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Optional. Arguments passed to \`pip\`"$'\n'""
base="python.sh"
description="Run pip whether it is installed as a module or as a binary"$'\n'""
file="bin/build/tools/python.sh"
fn="pipWrapper"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceModified="1768721469"
summary="Run pip whether it is installed as a module or"
usage="pipWrapper [ --bin binary ] [ --handler handler ] [ --help ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpipWrapper[0m [94m[ --bin binary ][0m [94m[ --handler handler ][0m [94m[ --help ][0m [94m[ ... ][0m

    [94m--bin binary       [1;97mExecutable. Optional. Binary for [38;2;0;255;0;48;2;0;0;0mpip[0m.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m...                [1;97mArguments. Optional. Arguments passed to [38;2;0;255;0;48;2;0;0;0mpip[0m[0m

Run pip whether it is installed as a module or as a binary

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: pipWrapper [ --bin binary ] [ --handler handler ] [ --help ] [ ... ]

    --bin binary       Executable. Optional. Binary for pip.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    --help             Flag. Optional. Display this help.
    ...                Arguments. Optional. Arguments passed to pip

Run pip whether it is installed as a module or as a binary

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
