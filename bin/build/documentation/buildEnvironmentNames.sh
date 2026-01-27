#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Output the list of environment variable names which can be loaded via \`buildEnvironmentLoad\` or \`buildEnvironmentGet\`"$'\n'""
file="bin/build/tools/build.sh"
foundNames=([0]="argument" [1]="requires")
rawComment="Output the list of environment variable names which can be loaded via \`buildEnvironmentLoad\` or \`buildEnvironmentGet\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: convertValue _buildEnvironmentPath find sort read __help catchEnvironment"$'\n'""$'\n'""
requires="convertValue _buildEnvironmentPath find sort read __help catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1769549039"
summary="Output the list of environment variable names which can be"
usage="buildEnvironmentNames [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentNames'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the list of environment variable names which can be loaded via '$'\e''[[(code)]mbuildEnvironmentLoad'$'\e''[[(reset)]m or '$'\e''[[(code)]mbuildEnvironmentGet'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentNames [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Output the list of environment variable names which can be loaded via buildEnvironmentLoad or buildEnvironmentGet'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.604
