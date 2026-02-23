#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-23
# shellcheck disable=SC2034
argument="--end - Flag. Optional. Stop testing for recursion."$'\n'""
base="debug.sh"
description="Place this in code where you suspect an infinite loop occurs"$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'""
environment="__BUILD_RECURSION"$'\n'""
file="bin/build/tools/debug.sh"
fn="bashRecursionDebug"
foundNames=([0]="argument" [1]="requires" [2]="environment")
rawComment="Place this in code where you suspect an infinite loop occurs"$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"Argument: --end - Flag. Optional. Stop testing for recursion."$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'"Requires: printf unset  export debuggingStack exit"$'\n'"Environment: __BUILD_RECURSION"$'\n'""$'\n'""
requires="printf unset  export debuggingStack exit"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="e63fcc99dec04cd39a71d72e430b7e22a07145ab"
summary="Place this in code where you suspect an infinite loop"
summaryComputed="true"
usage="bashRecursionDebug [ --end ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashRecursionDebug'$'\e''[0m '$'\e''[[(blue)]m[ --end ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--end  '$'\e''[[(value)]mFlag. Optional. Stop testing for recursion.'$'\e''[[(reset)]m'$'\n'''$'\n''Place this in code where you suspect an infinite loop occurs'$'\n''It will fail upon a second call; to reset call with '$'\e''[[(code)]m--end'$'\e''[[(reset)]m'$'\n''When called twice, fails on the second invocation and dumps a call stack to stderr.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_RECURSION'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashRecursionDebug [ --end ]'$'\n'''$'\n''    --end  Flag. Optional. Stop testing for recursion.'$'\n'''$'\n''Place this in code where you suspect an infinite loop occurs'$'\n''It will fail upon a second call; to reset call with --end'$'\n''When called twice, fails on the second invocation and dumps a call stack to stderr.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_RECURSION'$'\n'''
