#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="interactive.sh"
description="Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: --until exitCode - Integer. Optional. Check until exit code matches this."$'\n'"Argument: --title title - String. Optional. Display this title instead of the command."$'\n'"Argument: arguments ... - Optional. Arguments. Arguments to \`loopCallable\`"$'\n'"Run checks interactively until errors are all fixed."$'\n'""
file="bin/build/tools/interactive.sh"
foundNames=()
rawComment="Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: --until exitCode - Integer. Optional. Check until exit code matches this."$'\n'"Argument: --title title - String. Optional. Display this title instead of the command."$'\n'"Argument: arguments ... - Optional. Arguments. Arguments to \`loopCallable\`"$'\n'"Run checks interactively until errors are all fixed."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="e17f0ea69f1c6cf5eceec027dffd3be9d099fb75"
summary="Argument: loopCallable - Callable. Required. Call this on each file"
usage="loopExecute"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mloopExecute'$'\e''[0m'$'\n'''$'\n''Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\n''Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''Argument: --until exitCode - Integer. Optional. Check until exit code matches this.'$'\n''Argument: --title title - String. Optional. Display this title instead of the command.'$'\n''Argument: arguments ... - Optional. Arguments. Arguments to '$'\e''[[(code)]mloopCallable'$'\e''[[(reset)]m'$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: loopExecute'$'\n'''$'\n''Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\n''Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''Argument: --until exitCode - Integer. Optional. Check until exit code matches this.'$'\n''Argument: --title title - String. Optional. Display this title instead of the command.'$'\n''Argument: arguments ... - Optional. Arguments. Arguments to loopCallable'$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.493
