#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="filename ... - File. Optional. Docker environment file to convert."$'\n'""
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"May take a list of files to convert or stdin piped in"$'\n'"Outputs bash-compatible entries to stdout"$'\n'"Any output to stdout is considered valid output"$'\n'"Any output to stderr is errors in the file but is written to be compatible with a bash"$'\n'""
file="bin/build/tools/environment/convert.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="return_code")
rawComment="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"May take a list of files to convert or stdin piped in"$'\n'"Outputs bash-compatible entries to stdout"$'\n'"Any output to stdout is considered valid output"$'\n'"Any output to stderr is errors in the file but is written to be compatible with a bash"$'\n'"Argument: filename ... - File. Optional. Docker environment file to convert."$'\n'"stdin: An environment file of any format"$'\n'"stdout: Environment file in Bash-compatible format"$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
return_code="1 - if errors occur"$'\n'"0 - if file is valid"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="0af760fb116b765ae72552e07e1d167314941918"
stdin="An environment file of any format"$'\n'""
stdout="Environment file in Bash-compatible format"$'\n'""
summary="Ensure an environment file is compatible with non-quoted docker environment"
summaryComputed="true"
usage="environmentFileDockerToBashCompatible [ filename ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileDockerToBashCompatible'$'\e''[0m '$'\e''[[(blue)]m[ filename ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfilename ...  '$'\e''[[(value)]mFile. Optional. Docker environment file to convert.'$'\e''[[(reset)]m'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n''May take a list of files to convert or stdin piped in'$'\n''Outputs bash-compatible entries to stdout'$'\n''Any output to stdout is considered valid output'$'\n''Any output to stderr is errors in the file but is written to be compatible with a bash'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if errors occur'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if file is valid'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''An environment file of any format'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Environment file in Bash-compatible format'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]menvironmentFileDockerToBashCompatible [[(blue)]m[ filename ... ]'$'\n'''$'\n''    [[(blue)]mfilename ...  File. Optional. Docker environment file to convert.'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n''May take a list of files to convert or stdin piped in'$'\n''Outputs bash-compatible entries to stdout'$'\n''Any output to stdout is considered valid output'$'\n''Any output to stderr is errors in the file but is written to be compatible with a bash'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m1 - if errors occur'$'\n''- [[(code)]m0 - if file is valid'$'\n'''$'\n''Reads from [[(code)]mstdin:'$'\n''An environment file of any format'$'\n'''$'\n''Writes to [[(code)]mstdout:'$'\n''Environment file in Bash-compatible format'$'\n'''
