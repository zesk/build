#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="envFile ... - File. Required. One or more files to convert."$'\n'""
base="convert.sh"
description="Takes any environment file and makes it docker-compatible"$'\n'"Outputs the compatible env to stdout"$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileToDocker"
foundNames=([0]="argument")
line="78"
lowerFn="environmentfiletodocker"
rawComment="Takes any environment file and makes it docker-compatible"$'\n'"Outputs the compatible env to stdout"$'\n'"Argument: envFile ... - File. Required. One or more files to convert."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="44d3bdc0a06188c7f01c1f2158c260a9f896c151"
sourceLine="78"
summary="Takes any environment file and makes it docker-compatible"
summaryComputed="true"
usage="environmentFileToDocker envFile ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileToDocker'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]menvFile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]menvFile ...  '$'\e''[[(value)]mFile. Required. One or more files to convert.'$'\e''[[(reset)]m'$'\n'''$'\n''Takes any environment file and makes it docker-compatible'$'\n''Outputs the compatible env to stdout'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileToDocker envFile ...'$'\n'''$'\n''    envFile ...  File. Required. One or more files to convert.'$'\n'''$'\n''Takes any environment file and makes it docker-compatible'$'\n''Outputs the compatible env to stdout'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/environment.md"
