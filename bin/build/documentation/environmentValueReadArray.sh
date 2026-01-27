#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/io.sh"
argument="stateFile - File. Required. File to access, must exist."$'\n'"name - EnvironmentVariable. Required. Name to read."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
description="Read an array value from a state file"$'\n'"Outputs array elements, one per line."$'\n'""
file="bin/build/tools/environment/io.sh"
foundNames=([0]="argument")
rawComment="Read an array value from a state file"$'\n'"Argument: stateFile - File. Required. File to access, must exist."$'\n'"Argument: name - EnvironmentVariable. Required. Name to read."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs array elements, one per line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceModified="1769451204"
summary="Read an array value from a state file"
usage="environmentValueReadArray stateFile name [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueReadArray'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstateFile'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstateFile  '$'\e''[[(value)]mFile. Required. File to access, must exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mname       '$'\e''[[(value)]mEnvironmentVariable. Required. Name to read.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Read an array value from a state file'$'\n''Outputs array elements, one per line.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueReadArray stateFile name [ --help ]'$'\n'''$'\n''    stateFile  File. Required. File to access, must exist.'$'\n''    name       EnvironmentVariable. Required. Name to read.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Read an array value from a state file'$'\n''Outputs array elements, one per line.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.46
