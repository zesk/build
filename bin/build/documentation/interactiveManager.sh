#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.\n--exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.\n--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode.\nfileToCheck ... - File. Optional. Shell file to validate. May also supply file names via stdin.\n'
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run checks interactively until errors are all fixed.\nNot ready for prime time yet - written not tested.\n\n'
descriptionLineCount="3"
file="bin/build/tools/interactive.sh"
fn="interactiveManager"
fnMarker="interactivemanager"
foundNames=([0]="argument")
line="209"
original="interactiveManager"
rawComment=$'Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.\nArgument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.\nArgument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode.\nArgument: fileToCheck ... - File. Optional. Shell file to validate. May also supply file names via stdin.\nRun checks interactively until errors are all fixed.\nNot ready for prime time yet - written not tested.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/interactive.sh"
sourceHash="6e0d41188cc236cd7170c65cbacacbb7f30b9788"
sourceLine="209"
summary="Run checks interactively until errors are all fixed."
summaryComputed="true"
usage="interactiveManager loopCallable [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]minteractiveManager'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mloopCallable'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --exec binary ]'$'\e''[0m '$'\e''[[(blue)]m[ --delay delaySeconds ]'$'\e''[0m '$'\e''[[(blue)]m[ fileToCheck ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mloopCallable          '$'\e''[[(value)]mCallable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--exec binary         '$'\e''[[(value)]mCallable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--delay delaySeconds  '$'\e''[[(value)]mInteger. Optional. Delay in seconds between checks in interactive mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfileToCheck ...       '$'\e''[[(value)]mFile. Optional. Shell file to validate. May also supply file names via stdin.'$'\e''[[(reset)]m'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n''Not ready for prime time yet - written not tested.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: interactiveManager loopCallable [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]'$'\n'''$'\n''    loopCallable          Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\n''    --exec binary         Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.'$'\n''    --delay delaySeconds  Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''    fileToCheck ...       File. Optional. Shell file to validate. May also supply file names via stdin.'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n''Not ready for prime time yet - written not tested.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/interactive.md"
