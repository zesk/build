#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="_sugar.sh"
description="Output the exit code as a string"$'\n'"Argument: code ... - UnsignedInteger. String. Exit code value to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: exitCodeToken, one per line"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=()
rawComment="Output the exit code as a string"$'\n'"Argument: code ... - UnsignedInteger. String. Exit code value to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: exitCodeToken, one per line"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="Output the exit code as a string"
usage="returnCodeString"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnCodeString'$'\e''[0m'$'\n'''$'\n''Output the exit code as a string'$'\n''Argument: code ... - UnsignedInteger. String. Exit code value to output.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''stdout: exitCodeToken, one per line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnCodeString'$'\n'''$'\n''Output the exit code as a string'$'\n''Argument: code ... - UnsignedInteger. String. Exit code value to output.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''stdout: exitCodeToken, one per line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
