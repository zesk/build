#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="filename - File. Optional. Docker environment file to check for common issues"$'\n'""
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileBashCompatibleToDocker"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="return_code")
line="178"
lowerFn="environmentfilebashcompatibletodocker"
rawComment="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Argument: filename - File. Optional. Docker environment file to check for common issues"$'\n'"stdin: text - Environment file to convert. (Optional)"$'\n'"stdout: text - Only if stdin is supplied and no \`filename\` arguments."$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
return_code="1 - if errors occur"$'\n'"0 - if file is valid"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="44d3bdc0a06188c7f01c1f2158c260a9f896c151"
sourceLine="178"
stdin="text - Environment file to convert. (Optional)"$'\n'""
stdout="text - Only if stdin is supplied and no \`filename\` arguments."$'\n'""
summary="Ensure an environment file is compatible with non-quoted docker environment"
summaryComputed="true"
usage="environmentFileBashCompatibleToDocker [ filename ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileBashCompatibleToDocker'$'\e''[0m '$'\e''[[(blue)]m[ filename ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfilename  '$'\e''[[(value)]mFile. Optional. Docker environment file to check for common issues'$'\e''[[(reset)]m'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if errors occur'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if file is valid'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text - Environment file to convert. (Optional)'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''text - Only if stdin is supplied and no '$'\e''[[(code)]mfilename'$'\e''[[(reset)]m arguments.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileBashCompatibleToDocker [ filename ]'$'\n'''$'\n''    filename  File. Optional. Docker environment file to check for common issues'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n'''$'\n''Return codes:'$'\n''- 1 - if errors occur'$'\n''- 0 - if file is valid'$'\n'''$'\n''Reads from stdin:'$'\n''text - Environment file to convert. (Optional)'$'\n'''$'\n''Writes to stdout:'$'\n''text - Only if stdin is supplied and no filename arguments.'$'\n'''
documentationPath="documentation/source/tools/environment.md"
