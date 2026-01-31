#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="convert.sh"
description="Takes any environment file and makes it docker-compatible"$'\n'"Outputs the compatible env to stdout"$'\n'"Argument: envFile ... - File. Required. One or more files to convert."$'\n'""
file="bin/build/tools/environment/convert.sh"
foundNames=()
rawComment="Takes any environment file and makes it docker-compatible"$'\n'"Outputs the compatible env to stdout"$'\n'"Argument: envFile ... - File. Required. One or more files to convert."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="0af760fb116b765ae72552e07e1d167314941918"
summary="Takes any environment file and makes it docker-compatible"
usage="environmentFileToDocker"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileToDocker'$'\e''[0m'$'\n'''$'\n''Takes any environment file and makes it docker-compatible'$'\n''Outputs the compatible env to stdout'$'\n''Argument: envFile ... - File. Required. One or more files to convert.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileToDocker'$'\n'''$'\n''Takes any environment file and makes it docker-compatible'$'\n''Outputs the compatible env to stdout'$'\n''Argument: envFile ... - File. Required. One or more files to convert.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.453
