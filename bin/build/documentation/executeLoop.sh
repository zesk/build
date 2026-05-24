#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.\n--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode.\n--until exitCode - Integer. Optional. Check until exit code matches this.\n--title title - String. Optional. Display this title instead of the command.\narguments ... - Optional. Arguments. Arguments to `loopCallable`\n'
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run checks interactively until errors are all fixed.\n\n'
descriptionLineCount="2"
file="bin/build/tools/interactive.sh"
fn="executeLoop"
fnMarker="executeloop"
foundNames=([0]="argument")
line="197"
rawComment=$'Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.\nArgument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode.\nArgument: --until exitCode - Integer. Optional. Check until exit code matches this.\nArgument: --title title - String. Optional. Display this title instead of the command.\nArgument: arguments ... - Optional. Arguments. Arguments to `loopCallable`\nRun checks interactively until errors are all fixed.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="197"
summary="Run checks interactively until errors are all fixed."
summaryComputed="true"
usage="executeLoop loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecuteLoop'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mloopCallable'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --delay delaySeconds ]'$'\e''[0m '$'\e''[[(blue)]m[ --until exitCode ]'$'\e''[0m '$'\e''[[(blue)]m[ --title title ]'$'\e''[0m '$'\e''[[(blue)]m[ arguments ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mloopCallable          '$'\e''[[(value)]mCallable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--delay delaySeconds  '$'\e''[[(value)]mInteger. Optional. Delay in seconds between checks in interactive mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--until exitCode      '$'\e''[[(value)]mInteger. Optional. Check until exit code matches this.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--title title         '$'\e''[[(value)]mString. Optional. Display this title instead of the command.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]marguments ...         '$'\e''[[(value)]mOptional. Arguments. Arguments to '$'\e''[[(code)]mloopCallable'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: executeLoop loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]'$'\n'''$'\n''    loopCallable          Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\n''    --delay delaySeconds  Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''    --until exitCode      Integer. Optional. Check until exit code matches this.'$'\n''    --title title         String. Optional. Display this title instead of the command.'$'\n''    arguments ...         Optional. Arguments. Arguments to loopCallable'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/interactive.md"
