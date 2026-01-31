#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="io.sh"
description="Read an array value from a state file"$'\n'"Argument: stateFile - File. Required. File to access, must exist."$'\n'"Argument: name - EnvironmentVariable. Required. Name to read."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs array elements, one per line."$'\n'""
file="bin/build/tools/environment/io.sh"
foundNames=()
rawComment="Read an array value from a state file"$'\n'"Argument: stateFile - File. Required. File to access, must exist."$'\n'"Argument: name - EnvironmentVariable. Required. Name to read."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs array elements, one per line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="ab40396c0bbaf04b90ac18495770691379efbd1a"
summary="Read an array value from a state file"
usage="environmentValueReadArray"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueReadArray'$'\e''[0m'$'\n'''$'\n''Read an array value from a state file'$'\n''Argument: stateFile - File. Required. File to access, must exist.'$'\n''Argument: name - EnvironmentVariable. Required. Name to read.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Outputs array elements, one per line.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueReadArray'$'\n'''$'\n''Read an array value from a state file'$'\n''Argument: stateFile - File. Required. File to access, must exist.'$'\n''Argument: name - EnvironmentVariable. Required. Name to read.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Outputs array elements, one per line.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.458
