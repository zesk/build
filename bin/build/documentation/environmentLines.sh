#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List lines of environment values set in a bash state file\n\n'
descriptionLineCount="2"
example=$'    environmentLines < "$stateFile"\n'
file="bin/build/tools/environment/io.sh"
fn="environmentLines"
fnMarker="environmentlines"
foundNames=([0]="example" [1]="argument")
line="179"
rawComment=$'Example:     {fn} < "$stateFile"\nArgument: --help - Flag. Optional. Display this help.\nList lines of environment values set in a bash state file\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="9d970c9247c918e4438d4046d4dcca32d13b665b"
sourceLine="179"
summary="List lines of environment values set in a bash state"
summaryComputed="true"
usage="environmentLines [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentLines'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List lines of environment values set in a bash state file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    environmentLines < "$stateFile"'
# shellcheck disable=SC2016
helpPlain='Usage: environmentLines [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List lines of environment values set in a bash state file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    environmentLines < "$stateFile"'
documentationPath="documentation/source/tools/environment.md"
