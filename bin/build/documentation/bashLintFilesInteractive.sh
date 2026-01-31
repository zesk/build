#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="lint.sh"
description="Argument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: fileToCheck ... - File. Optional. Shell file to validate."$'\n'"Run checks interactively until errors are all fixed."$'\n'""
file="bin/build/tools/lint.sh"
foundNames=()
rawComment="Argument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: fileToCheck ... - File. Optional. Shell file to validate."$'\n'"Run checks interactively until errors are all fixed."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="1117fb23c3a75ca6a646bab1404a8f455c97fb49"
summary="Argument: --exec binary - Callable. Optional. Run binary with files"
usage="bashLintFilesInteractive"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashLintFilesInteractive'$'\e''[0m'$'\n'''$'\n''Argument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.'$'\n''Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''Argument: fileToCheck ... - File. Optional. Shell file to validate.'$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashLintFilesInteractive'$'\n'''$'\n''Argument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.'$'\n''Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode.'$'\n''Argument: fileToCheck ... - File. Optional. Shell file to validate.'$'\n''Run checks interactively until errors are all fixed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.448
