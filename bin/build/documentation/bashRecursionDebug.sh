#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="--end - Flag. Optional. Stop testing for recursion."$'\n'""
base="debug.sh"
description="Place this in code where you suspect an infinite loop occurs"$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'""
environment="__BUILD_RECURSION"$'\n'""
file="bin/build/tools/debug.sh"
fn="bashRecursionDebug"
requires="printf unset  export debuggingStack exit"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769054493"
summary="Place this in code where you suspect an infinite loop"
usage="bashRecursionDebug [ --end ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashRecursionDebug[0m [94m[ --end ][0m

    [94m--end  [1;97mFlag. Optional. Stop testing for recursion.[0m

Place this in code where you suspect an infinite loop occurs
It will fail upon a second call; to reset call with [38;2;0;255;0;48;2;0;0;0m--end[0m
When called twice, fails on the second invocation and dumps a call stack to stderr.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- __BUILD_RECURSION
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashRecursionDebug [ --end ]

    --end  Flag. Optional. Stop testing for recursion.

Place this in code where you suspect an infinite loop occurs
It will fail upon a second call; to reset call with --end
When called twice, fails on the second invocation and dumps a call stack to stderr.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- __BUILD_RECURSION
- 
'
