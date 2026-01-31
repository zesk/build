#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="io.sh"
description="Argument: stateFile - EnvironmentFile. Required. File to read a value from."$'\n'"Argument: name - EnvironmentVariable. Required. Variable to read."$'\n'"Argument: default - EmptyString. Optional. Default value of the environment variable if it does not exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)"$'\n'"Return Code: 0 - If value"$'\n'""
file="bin/build/tools/environment/io.sh"
foundNames=()
rawComment="Argument: stateFile - EnvironmentFile. Required. File to read a value from."$'\n'"Argument: name - EnvironmentVariable. Required. Variable to read."$'\n'"Argument: default - EmptyString. Optional. Default value of the environment variable if it does not exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)"$'\n'"Return Code: 0 - If value"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="ab40396c0bbaf04b90ac18495770691379efbd1a"
summary="Argument: stateFile - EnvironmentFile. Required. File to read a value"
usage="environmentValueRead"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueRead'$'\e''[0m'$'\n'''$'\n''Argument: stateFile - EnvironmentFile. Required. File to read a value from.'$'\n''Argument: name - EnvironmentVariable. Required. Variable to read.'$'\n''Argument: default - EmptyString. Optional. Default value of the environment variable if it does not exist.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)'$'\n''Return Code: 0 - If value'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueRead'$'\n'''$'\n''Argument: stateFile - EnvironmentFile. Required. File to read a value from.'$'\n''Argument: name - EnvironmentVariable. Required. Variable to read.'$'\n''Argument: default - EmptyString. Optional. Default value of the environment variable if it does not exist.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)'$'\n''Return Code: 0 - If value'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.424
