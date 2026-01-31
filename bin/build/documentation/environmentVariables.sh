#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="environment.sh"
description="Output a list of environment variables and ignore function definitions"$'\n'"both \`set\` and \`env\` output functions and this is an easy way to just output"$'\n'"exported variables"$'\n'""
file="bin/build/tools/environment.sh"
foundNames=([0]="requires")
rawComment="Output a list of environment variables and ignore function definitions"$'\n'"both \`set\` and \`env\` output functions and this is an easy way to just output"$'\n'"exported variables"$'\n'"Requires: declare grep cut usageDocument __help"$'\n'""$'\n'""
requires="declare grep cut usageDocument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="4226efba8a29858c837cfce31f7416e4226eaa32"
summary="Output a list of environment variables and ignore function definitions"
summaryComputed="true"
usage="environmentVariables"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentVariables'$'\e''[0m'$'\n'''$'\n''Output a list of environment variables and ignore function definitions'$'\n''both '$'\e''[[(code)]mset'$'\e''[[(reset)]m and '$'\e''[[(code)]menv'$'\e''[[(reset)]m output functions and this is an easy way to just output'$'\n''exported variables'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentVariables'$'\n'''$'\n''Output a list of environment variables and ignore function definitions'$'\n''both set and env output functions and this is an easy way to just output'$'\n''exported variables'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
