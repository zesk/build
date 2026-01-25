#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"--until exitCode - Integer. Optional. Check until exit code matches this."$'\n'"--title title - String. Optional. Display this title instead of the command."$'\n'"arguments ... - Optional. Arguments. Arguments to \`loopCallable\`"$'\n'""
base="interactive.sh"
description="Run checks interactively until errors are all fixed."$'\n'""
exitCode="0"
file="bin/build/tools/interactive.sh"
foundNames=([0]="argument")
rawComment="Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: --until exitCode - Integer. Optional. Check until exit code matches this."$'\n'"Argument: --title title - String. Optional. Display this title instead of the command."$'\n'"Argument: arguments ... - Optional. Arguments. Arguments to \`loopCallable\`"$'\n'"Run checks interactively until errors are all fixed."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Run checks interactively until errors are all fixed."
usage="loopExecute loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mloopExecute'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mloopCallable'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ --delay delaySeconds ]'$'\e''[0m '$'\e''[[blue]m[ --until exitCode ]'$'\e''[0m '$'\e''[[blue]m[ --title title ]'$'\e''[0m '$'\e''[[blue]m[ arguments ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mloopCallable          '$'\e''[[value]mCallable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--delay delaySeconds  '$'\e''[[value]mInteger. Optional. Delay in seconds between checks in interactive mode.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--until exitCode      '$'\e''[[value]mInteger. Optional. Check until exit code matches this.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--title title         '$'\e''[[value]mString. Optional. Display this title instead of the command.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]marguments ...         '$'\e''[[value]mOptional. Arguments. Arguments to '$'\e''[[code]mloopCallable'$'\e''[[reset]m'$'\e''[[reset]m'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: loopExecute loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]'$'\n'''$'\n''    loopCallable          Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\n''    --delay delaySeconds  Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''    --until exitCode      Integer. Optional. Check until exit code matches this.'$'\n''    --title title         String. Optional. Display this title instead of the command.'$'\n''    arguments ...         Optional. Arguments. Arguments to loopCallable'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
