#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"--until exitCode - Integer. Optional. Check until exit code matches this."$'\n'"--title title - String. Optional. Display this title instead of the command."$'\n'"arguments ... - Optional. Arguments. Arguments to \`loopCallable\`"$'\n'""
base="interactive.sh"
description="Run checks interactively until errors are all fixed."$'\n'""
file="bin/build/tools/interactive.sh"
fn="executeLoop"
foundNames=([0]="argument")
line="197"
lowerFn="executeloop"
rawComment="Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: --until exitCode - Integer. Optional. Check until exit code matches this."$'\n'"Argument: --title title - String. Optional. Display this title instead of the command."$'\n'"Argument: arguments ... - Optional. Arguments. Arguments to \`loopCallable\`"$'\n'"Run checks interactively until errors are all fixed."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="94de87862bd88558374367c517da7467bcaf93f9"
sourceLine="197"
summary="Run checks interactively until errors are all fixed."
summaryComputed="true"
usage="executeLoop loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecuteLoop'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mloopCallable'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --delay delaySeconds ]'$'\e''[0m '$'\e''[[(blue)]m[ --until exitCode ]'$'\e''[0m '$'\e''[[(blue)]m[ --title title ]'$'\e''[0m '$'\e''[[(blue)]m[ arguments ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mloopCallable          '$'\e''[[(value)]mCallable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--delay delaySeconds  '$'\e''[[(value)]mInteger. Optional. Delay in seconds between checks in interactive mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--until exitCode      '$'\e''[[(value)]mInteger. Optional. Check until exit code matches this.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--title title         '$'\e''[[(value)]mString. Optional. Display this title instead of the command.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]marguments ...         '$'\e''[[(value)]mOptional. Arguments. Arguments to '$'\e''[[(code)]mloopCallable'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: executeLoop loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]'$'\n'''$'\n''    loopCallable          Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\n''    --delay delaySeconds  Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''    --until exitCode      Integer. Optional. Check until exit code matches this.'$'\n''    --title title         String. Optional. Display this title instead of the command.'$'\n''    arguments ...         Optional. Arguments. Arguments to loopCallable'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/interactive.md"
