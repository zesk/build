#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument="none"
base="environment.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output a list of environment variables and ignore function definitions\n\nboth `set` and `env` output functions and this is an easy way to just output\nexported variables\n\n'
descriptionLineCount="5"
file="bin/build/tools/environment.sh"
fn="environmentVariables"
fnMarker="environmentvariables"
foundNames=([0]="requires")
line="130"
rawComment=$'Output a list of environment variables and ignore function definitions\nboth `set` and `env` output functions and this is an easy way to just output\nexported variables\nRequires: declare grep cut bashDocumentation helpArgument\n\n'
requires=$'declare grep cut bashDocumentation helpArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/environment.sh"
sourceHash="fd4da5f1d9a2c52100a1a281185a474bae9aba02"
sourceLine="130"
summary="Output a list of environment variables and ignore function definitions"
summaryComputed="true"
usage="environmentVariables"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentVariables'$'\e''[0m'$'\n'''$'\n''Output a list of environment variables and ignore function definitions'$'\n'''$'\n''both '$'\e''[[(code)]mset'$'\e''[[(reset)]m and '$'\e''[[(code)]menv'$'\e''[[(reset)]m output functions and this is an easy way to just output'$'\n''exported variables'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: environmentVariables'$'\n'''$'\n''Output a list of environment variables and ignore function definitions'$'\n'''$'\n''both set and env output functions and this is an easy way to just output'$'\n''exported variables'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/environment.md"
