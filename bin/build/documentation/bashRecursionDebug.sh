#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'--end - Flag. Optional. Stop testing for recursion.\n'
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Place this in code where you suspect an infinite loop occurs.\nIt will fail upon a second call; to reset call with `--end`\nWhen called twice, fails on the second invocation and dumps a call stack to stderr.\n\n'
descriptionLineCount="4"
environment=$'__BUILD_RECURSION\n'
file="bin/build/tools/debug.sh"
fn="bashRecursionDebug"
fnMarker="bashrecursiondebug"
foundNames=([0]="summary" [1]="argument" [2]="requires" [3]="environment")
line="140"
rawComment=$'Summary: Recursion detection\nPlace this in code where you suspect an infinite loop occurs.\nIt will fail upon a second call; to reset call with `--end`\nArgument: --end - Flag. Optional. Stop testing for recursion.\nWhen called twice, fails on the second invocation and dumps a call stack to stderr.\nRequires: printf unset  export debuggingStack exit\nEnvironment: __BUILD_RECURSION\n\n'
requires=$'printf unset  export debuggingStack exit\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/debug.sh"
sourceHash="f8901f960335e712ac2680d77a17c49c8edcae50"
sourceLine="140"
summary="Recursion detection"
summaryComputed=""
usage="bashRecursionDebug [ --end ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashRecursionDebug'$'\e''[0m '$'\e''[[(blue)]m[ --end ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--end  '$'\e''[[(value)]mFlag. Optional. Stop testing for recursion.'$'\e''[[(reset)]m'$'\n'''$'\n''Place this in code where you suspect an infinite loop occurs.'$'\n''It will fail upon a second call; to reset call with '$'\e''[[(code)]m--end'$'\e''[[(reset)]m'$'\n''When called twice, fails on the second invocation and dumps a call stack to stderr.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_RECURSION'
# shellcheck disable=SC2016
helpPlain='Usage: bashRecursionDebug [ --end ]'$'\n'''$'\n''    --end  Flag. Optional. Stop testing for recursion.'$'\n'''$'\n''Place this in code where you suspect an infinite loop occurs.'$'\n''It will fail upon a second call; to reset call with --end'$'\n''When called twice, fails on the second invocation and dumps a call stack to stderr.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_RECURSION'
documentationPath="documentation/source/tools/debug.md"
