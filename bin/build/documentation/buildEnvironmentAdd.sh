#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project."$'\n'""
base="environment.sh"
description="Adds an environment variable file to a project"$'\n'""
exitCode="0"
file="bin/build/tools/environment.sh"
rawComment="Adds an environment variable file to a project"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769320208"
summary="Adds an environment variable file to a project"
usage="buildEnvironmentAdd [ --help ] environmentName ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mbuildEnvironmentAdd'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]menvironmentName ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help               '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]menvironmentName ...  '$'\e''[[value]mEnvironmentName. Required. One or more environment variable names to add to this project.'$'\e''[[reset]m'$'\n'''$'\n''Adds an environment variable file to a project'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentAdd [ --help ] environmentName ...'$'\n'''$'\n''    --help               Flag. Optional. Display this help.'$'\n''    environmentName ...  EnvironmentName. Required. One or more environment variable names to add to this project.'$'\n'''$'\n''Adds an environment variable file to a project'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
