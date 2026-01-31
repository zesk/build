#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Argument: filename - File. Optional. Docker environment file to check for common issues"$'\n'"stdin: text - Environment file to convert. (Optional)"$'\n'"stdout: text - Only if stdin is supplied and no \`filename\` arguments."$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""
file="bin/build/tools/environment/convert.sh"
foundNames=()
rawComment="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Argument: filename - File. Optional. Docker environment file to check for common issues"$'\n'"stdin: text - Environment file to convert. (Optional)"$'\n'"stdout: text - Only if stdin is supplied and no \`filename\` arguments."$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="0af760fb116b765ae72552e07e1d167314941918"
summary="Ensure an environment file is compatible with non-quoted docker environment"
usage="environmentFileBashCompatibleToDocker"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileBashCompatibleToDocker'$'\e''[0m'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n''Argument: filename - File. Optional. Docker environment file to check for common issues'$'\n''stdin: text - Environment file to convert. (Optional)'$'\n''stdout: text - Only if stdin is supplied and no '$'\e''[[(code)]mfilename'$'\e''[[(reset)]m arguments.'$'\n''Return Code: 1 - if errors occur'$'\n''Return Code: 0 - if file is valid'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileBashCompatibleToDocker'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n''Argument: filename - File. Optional. Docker environment file to check for common issues'$'\n''stdin: text - Environment file to convert. (Optional)'$'\n''stdout: text - Only if stdin is supplied and no filename arguments.'$'\n''Return Code: 1 - if errors occur'$'\n''Return Code: 0 - if file is valid'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.566
