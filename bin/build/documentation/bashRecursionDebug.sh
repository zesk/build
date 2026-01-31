#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
description="Place this in code where you suspect an infinite loop occurs"$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"Argument: --end - Flag. Optional. Stop testing for recursion."$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'"Requires: printf unset  export debuggingStack exit"$'\n'"Environment: __BUILD_RECURSION"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=()
rawComment="Place this in code where you suspect an infinite loop occurs"$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"Argument: --end - Flag. Optional. Stop testing for recursion."$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'"Requires: printf unset  export debuggingStack exit"$'\n'"Environment: __BUILD_RECURSION"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="3e4ac7234593313eddb63a76e2aa170841269b82"
summary="Place this in code where you suspect an infinite loop"
usage="bashRecursionDebug"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashRecursionDebug'$'\e''[0m'$'\n'''$'\n''Place this in code where you suspect an infinite loop occurs'$'\n''It will fail upon a second call; to reset call with '$'\e''[[(code)]m--end'$'\e''[[(reset)]m'$'\n''Argument: --end - Flag. Optional. Stop testing for recursion.'$'\n''When called twice, fails on the second invocation and dumps a call stack to stderr.'$'\n''Requires: printf unset  export debuggingStack exit'$'\n''Environment: __BUILD_RECURSION'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashRecursionDebug'$'\n'''$'\n''Place this in code where you suspect an infinite loop occurs'$'\n''It will fail upon a second call; to reset call with --end'$'\n''Argument: --end - Flag. Optional. Stop testing for recursion.'$'\n''When called twice, fails on the second invocation and dumps a call stack to stderr.'$'\n''Requires: printf unset  export debuggingStack exit'$'\n''Environment: __BUILD_RECURSION'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.459
