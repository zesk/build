#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="build.sh"
description="Output the list of environment variable names which can be loaded via \`buildEnvironmentLoad\` or \`buildEnvironmentGet\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: convertValue _buildEnvironmentPath find sort read __help catchEnvironment"$'\n'""
file="bin/build/tools/build.sh"
foundNames=()
rawComment="Output the list of environment variable names which can be loaded via \`buildEnvironmentLoad\` or \`buildEnvironmentGet\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: convertValue _buildEnvironmentPath find sort read __help catchEnvironment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Output the list of environment variable names which can be"
usage="buildEnvironmentNames"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentNames'$'\e''[0m'$'\n'''$'\n''Output the list of environment variable names which can be loaded via '$'\e''[[(code)]mbuildEnvironmentLoad'$'\e''[[(reset)]m or '$'\e''[[(code)]mbuildEnvironmentGet'$'\e''[[(reset)]m'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Requires: convertValue _buildEnvironmentPath find sort read __help catchEnvironment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentNames'$'\n'''$'\n''Output the list of environment variable names which can be loaded via buildEnvironmentLoad or buildEnvironmentGet'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Requires: convertValue _buildEnvironmentPath find sort read __help catchEnvironment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.496
