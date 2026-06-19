#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'count - The number of times to run the binary\nbinary - The binary to run\nargs ... - Any arguments to pass to the binary each run\n'
base="platform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run a binary count times"
descriptionLineCount=""
file="bin/build/tools/platform.sh"
fn="executeCount"
fnMarker="executecount"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
line="59"
rawComment=$'Argument: count - The number of times to run the binary\nArgument: binary - The binary to run\nArgument: args ... - Any arguments to pass to the binary each run\nReturn Code: 0 - success\nReturn Code: 2 - `count` is not an unsigned number\nReturn Code: Any - If `binary` fails, the exit code is returned\nSummary: Run a binary count times\n\n'
return_code=$'0 - success\n2 - `count` is not an unsigned number\nAny - If `binary` fails, the exit code is returned\n'
sourceFile="bin/build/tools/platform.sh"
sourceHash="9eca1abb18f09a5ac7ffdbb78f76016096d40900"
sourceLine="59"
summary="Run a binary count times"
summaryComputed=""
usage="executeCount [ count ] [ binary ] [ args ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecuteCount'$'\e''[0m '$'\e''[[(blue)]m[ count ]'$'\e''[0m '$'\e''[[(blue)]m[ binary ]'$'\e''[0m '$'\e''[[(blue)]m[ args ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcount     '$'\e''[[(value)]mThe number of times to run the binary'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mbinary    '$'\e''[[(value)]mThe binary to run'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]margs ...  '$'\e''[[(value)]mAny arguments to pass to the binary each run'$'\e''[[(reset)]m'$'\n'''$'\n''Run a binary count times'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - '$'\e''[[(code)]mcount'$'\e''[[(reset)]m is not an unsigned number'$'\n''- '$'\e''[[(code)]mAny'$'\e''[[(reset)]m - If '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m fails, the exit code is returned'
# shellcheck disable=SC2016
helpPlain='Usage: executeCount [ count ] [ binary ] [ args ... ]'$'\n'''$'\n''    count     The number of times to run the binary'$'\n''    binary    The binary to run'$'\n''    args ...  Any arguments to pass to the binary each run'$'\n'''$'\n''Run a binary count times'$'\n'''$'\n''Return codes:'$'\n''- 0 - success'$'\n''- 2 - count is not an unsigned number'$'\n''- Any - If binary fails, the exit code is returned'
documentationPath="documentation/source/tools/bash.md"
