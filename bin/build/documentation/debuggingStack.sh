#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="-x - Flag. Optional. Show exported variables. (verbose)"$'\n'"--me - Flag. Optional. Show calling function call stack frame."$'\n'"--exit - Flag. Optional. Exit with code 0 after output."$'\n'""
base="dump.sh"
build_debug="debuggingStack - \`debuggingStack\` shows arguments passed (extra) and exports (optional flag) ALWAYS"$'\n'""
description="Dump the function and include stacks and the current environment"$'\n'""
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/dump.sh"
fn="debuggingStack"
foundNames=""
requires="printf usageDocument"$'\n'"throwArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceModified="1768721469"
summary="Dump the function and include stacks and the current environment"
usage="debuggingStack [ -x ] [ --me ] [ --exit ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdebuggingStack[0m [94m[ -x ][0m [94m[ --me ][0m [94m[ --exit ][0m

    [94m-x      [1;97mFlag. Optional. Show exported variables. (verbose)[0m
    [94m--me    [1;97mFlag. Optional. Show calling function call stack frame.[0m
    [94m--exit  [1;97mFlag. Optional. Exit with code 0 after output.[0m

Dump the function and include stacks and the current environment

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- debuggingStack - [38;2;0;255;0;48;2;0;0;0mdebuggingStack[0m shows arguments passed (extra) and exports (optional flag) ALWAYS
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: debuggingStack [ -x ] [ --me ] [ --exit ]

    -x      Flag. Optional. Show exported variables. (verbose)
    --me    Flag. Optional. Show calling function call stack frame.
    --exit  Flag. Optional. Exit with code 0 after output.

Dump the function and include stacks and the current environment

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

BUILD_DEBUG settings:
- debuggingStack - debuggingStack shows arguments passed (extra) and exports (optional flag) ALWAYS
- 
'
