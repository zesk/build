#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'stateFile - File. Required. File to access, must exist.\nname - EnvironmentVariable. Required. Name to read.\n--help - Flag. Optional. Display this help.\n'
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Read an array value from a state file\nOutputs array elements, one per line.\n\n'
descriptionLineCount="3"
file="bin/build/tools/environment/io.sh"
fn="environmentValueReadArray"
fnMarker="environmentvaluereadarray"
foundNames=([0]="argument")
line="147"
original="environmentValueReadArray"
rawComment=$'Read an array value from a state file\nArgument: stateFile - File. Required. File to access, must exist.\nArgument: name - EnvironmentVariable. Required. Name to read.\nArgument: --help - Flag. Optional. Display this help.\nOutputs array elements, one per line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="565ea7df1e58c04e83b459faee071a3b938bd9d4"
sourceLine="147"
summary="Read an array value from a state file"
summaryComputed="true"
usage="environmentValueReadArray stateFile name [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueReadArray'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstateFile'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstateFile  '$'\e''[[(value)]mFile. Required. File to access, must exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mname       '$'\e''[[(value)]mEnvironmentVariable. Required. Name to read.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Read an array value from a state file'$'\n''Outputs array elements, one per line.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueReadArray stateFile name [ --help ]'$'\n'''$'\n''    stateFile  File. Required. File to access, must exist.'$'\n''    name       EnvironmentVariable. Required. Name to read.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Read an array value from a state file'$'\n''Outputs array elements, one per line.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/environment.md"
