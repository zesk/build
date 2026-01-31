#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="build.sh"
description="Adds an environment variable file to a project"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --force - Flag. Optional. Replace the existing file if it exists or create it if it does not."$'\n'"Argument: --quiet - Flag. Optional. No status messages."$'\n'"Argument: --verbose - Flag. Optional. Display status messages."$'\n'"Argument: --value value - String. Optional. Set the value to this fixed string in the file. Only valid when a single \`environmentName\` is used."$'\n'"Argument: environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project."$'\n'""
file="bin/build/tools/build.sh"
foundNames=()
rawComment="Adds an environment variable file to a project"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --force - Flag. Optional. Replace the existing file if it exists or create it if it does not."$'\n'"Argument: --quiet - Flag. Optional. No status messages."$'\n'"Argument: --verbose - Flag. Optional. Display status messages."$'\n'"Argument: --value value - String. Optional. Set the value to this fixed string in the file. Only valid when a single \`environmentName\` is used."$'\n'"Argument: environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Adds an environment variable file to a project"
usage="buildEnvironmentAdd"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentAdd'$'\e''[0m'$'\n'''$'\n''Adds an environment variable file to a project'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --force - Flag. Optional. Replace the existing file if it exists or create it if it does not.'$'\n''Argument: --quiet - Flag. Optional. No status messages.'$'\n''Argument: --verbose - Flag. Optional. Display status messages.'$'\n''Argument: --value value - String. Optional. Set the value to this fixed string in the file. Only valid when a single '$'\e''[[(code)]menvironmentName'$'\e''[[(reset)]m is used.'$'\n''Argument: environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentAdd'$'\n'''$'\n''Adds an environment variable file to a project'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --force - Flag. Optional. Replace the existing file if it exists or create it if it does not.'$'\n''Argument: --quiet - Flag. Optional. No status messages.'$'\n''Argument: --verbose - Flag. Optional. Display status messages.'$'\n''Argument: --value value - String. Optional. Set the value to this fixed string in the file. Only valid when a single environmentName is used.'$'\n''Argument: environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.501
