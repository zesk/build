#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="filename - File. Optional. Docker environment file to check for common issues"$'\n'""
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'""
exitCode="0"
file="bin/build/tools/environment/convert.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="return_code")
rawComment="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Argument: filename - File. Optional. Docker environment file to check for common issues"$'\n'"stdin: text - Environment file to convert. (Optional)"$'\n'"stdout: text - Only if stdin is supplied and no \`filename\` arguments."$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
return_code="1 - if errors occur"$'\n'"0 - if file is valid"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceModified="1769063211"
stdin="text - Environment file to convert. (Optional)"$'\n'""
stdout="text - Only if stdin is supplied and no \`filename\` arguments."$'\n'""
summary="Ensure an environment file is compatible with non-quoted docker environment"
usage="environmentFileBashCompatibleToDocker [ filename ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]menvironmentFileBashCompatibleToDocker'$'\e''[0m '$'\e''[[blue]m[ filename ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mfilename  '$'\e''[[value]mFile. Optional. Docker environment file to check for common issues'$'\e''[[reset]m'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - if errors occur'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - if file is valid'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''text - Environment file to convert. (Optional)'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''text - Only if stdin is supplied and no '$'\e''[[code]mfilename'$'\e''[[reset]m arguments.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileBashCompatibleToDocker [ filename ]'$'\n'''$'\n''    filename  File. Optional. Docker environment file to check for common issues'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n'''$'\n''Return codes:'$'\n''- 1 - if errors occur'$'\n''- 0 - if file is valid'$'\n'''$'\n''Reads from stdin:'$'\n''text - Environment file to convert. (Optional)'$'\n'''$'\n''Writes to stdout:'$'\n''text - Only if stdin is supplied and no filename arguments.'$'\n'''
