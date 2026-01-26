#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"--exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"fileToCheck ... - File. Optional. Shell file to validate. May also supply file names via stdin."$'\n'""
base="interactive.sh"
description="Run checks interactively until errors are all fixed."$'\n'"Not ready for prime time yet - written not tested."$'\n'""
file="bin/build/tools/interactive.sh"
foundNames=([0]="argument")
rawComment="Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"Argument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: fileToCheck ... - File. Optional. Shell file to validate. May also supply file names via stdin."$'\n'"Run checks interactively until errors are all fixed."$'\n'"Not ready for prime time yet - written not tested."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1769063211"
summary="Run checks interactively until errors are all fixed."
usage="interactiveManager loopCallable [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]minteractiveManager'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mloopCallable'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --exec binary ]'$'\e''[0m '$'\e''[[(blue)]m[ --delay delaySeconds ]'$'\e''[0m '$'\e''[[(blue)]m[ fileToCheck ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mloopCallable          '$'\e''[[(value)]mCallable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--exec binary         '$'\e''[[(value)]mCallable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--delay delaySeconds  '$'\e''[[(value)]mInteger. Optional. Delay in seconds between checks in interactive mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfileToCheck ...       '$'\e''[[(value)]mFile. Optional. Shell file to validate. May also supply file names via stdin.'$'\e''[[(reset)]m'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n''Not ready for prime time yet - written not tested.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: interactiveManager loopCallable [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]'$'\n'''$'\n''    loopCallable          Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.'$'\n''    --exec binary         Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.'$'\n''    --delay delaySeconds  Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''    fileToCheck ...       File. Optional. Shell file to validate. May also supply file names via stdin.'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n''Not ready for prime time yet - written not tested.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.661
