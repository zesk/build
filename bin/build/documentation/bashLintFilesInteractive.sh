#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-16
# shellcheck disable=SC2034
argument="--exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"fileToCheck ... - File. Optional. Shell file to validate."$'\n'""
base="lint.sh"
description="Run checks interactively until errors are all fixed."$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLintFilesInteractive"
foundNames=([0]="argument")
rawComment="Argument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: fileToCheck ... - File. Optional. Shell file to validate."$'\n'"Run checks interactively until errors are all fixed."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="2f1b8f2260afa319a8fdf5b39b33c58df87fda00"
summary="Run checks interactively until errors are all fixed."
summaryComputed="true"
usage="bashLintFilesInteractive [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashLintFilesInteractive'$'\e''[0m '$'\e''[[(blue)]m[ --exec binary ]'$'\e''[0m '$'\e''[[(blue)]m[ --delay delaySeconds ]'$'\e''[0m '$'\e''[[(blue)]m[ fileToCheck ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--exec binary         '$'\e''[[(value)]mCallable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--delay delaySeconds  '$'\e''[[(value)]mInteger. Optional. Delay in seconds between checks in interactive mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfileToCheck ...       '$'\e''[[(value)]mFile. Optional. Shell file to validate.'$'\e''[[(reset)]m'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashLintFilesInteractive [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]'$'\n'''$'\n''    --exec binary         Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.'$'\n''    --delay delaySeconds  Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''    fileToCheck ...       File. Optional. Shell file to validate.'$'\n'''$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
