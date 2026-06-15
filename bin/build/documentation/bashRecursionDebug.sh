#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument="--end - Flag. Optional. Stop testing for recursion."$'\n'""
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Place this in code where you suspect an infinite loop occurs."$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'""$'\n'""
descriptionLineCount="4"
environment="__BUILD_RECURSION"$'\n'""
file="bin/build/tools/debug.sh"
fn="bashRecursionDebug"
fnMarker="bashrecursiondebug"
foundNames=([0]="summary" [1]="argument" [2]="requires" [3]="return_code" [4]="environment")
line="151"
rawComment="Summary: Recursion detection"$'\n'"Place this in code where you suspect an infinite loop occurs."$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"Argument: --end - Flag. Optional. Stop testing for recursion."$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'"Requires: printf unset  export debuggingStack exit"$'\n'"Return Code: 91 - Recursion failure. Exits, actually after sleeping for 99 seconds."$'\n'"Environment: __BUILD_RECURSION"$'\n'""$'\n'""
requires="printf unset  export debuggingStack exit"$'\n'""
return_code="91 - Recursion failure. Exits, actually after sleeping for 99 seconds."$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="a63c90aa53321caabf6938f3b520f7e90fa9bc48"
sourceLine="151"
summary="Recursion detection"
summaryComputed=""
usage="bashRecursionDebug [ --end ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashRecursionDebug'$'\e''[0m '$'\e''[[(blue)]m[ --end ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--end  '$'\e''[[(value)]mFlag. Optional. Stop testing for recursion.'$'\e''[[(reset)]m'$'\n'''$'\n''Place this in code where you suspect an infinite loop occurs.'$'\n''It will fail upon a second call; to reset call with '$'\e''[[(code)]m--end'$'\e''[[(reset)]m'$'\n''When called twice, fails on the second invocation and dumps a call stack to stderr.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m91'$'\e''[[(reset)]m - Recursion failure. Exits, actually after sleeping for 99 seconds.'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_RECURSION'
# shellcheck disable=SC2016
helpPlain='Usage: bashRecursionDebug [ --end ]'$'\n'''$'\n''    --end  Flag. Optional. Stop testing for recursion.'$'\n'''$'\n''Place this in code where you suspect an infinite loop occurs.'$'\n''It will fail upon a second call; to reset call with --end'$'\n''When called twice, fails on the second invocation and dumps a call stack to stderr.'$'\n'''$'\n''Return codes:'$'\n''- 91 - Recursion failure. Exits, actually after sleeping for 99 seconds.'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_RECURSION'
documentationPath="documentation/source/tools/debug.md"
