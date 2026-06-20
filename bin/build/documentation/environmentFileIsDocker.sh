#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'filename - Docker environment file to check for common issues\n'
base="convert.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Ensure an environment file is compatible with non-quoted docker environment files\n\n'
descriptionLineCount="2"
file="bin/build/tools/environment/convert.sh"
fn="environmentFileIsDocker"
fnMarker="environmentfileisdocker"
foundNames=([0]="argument" [1]="return_code")
line="16"
original="environmentFileIsDocker"
rawComment=$'Ensure an environment file is compatible with non-quoted docker environment files\nArgument: filename - Docker environment file to check for common issues\nReturn Code: 1 - if errors occur\nReturn Code: 0 - if file is valid\n\n'
return_code=$'1 - if errors occur\n0 - if file is valid\n'
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="3b313a15b9ef0e13f864358aebfe683d919e1efc"
sourceLine="16"
summary="Ensure an environment file is compatible with non-quoted docker environment"
summaryComputed="true"
usage="environmentFileIsDocker [ filename ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileIsDocker'$'\e''[0m '$'\e''[[(blue)]m[ filename ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfilename  '$'\e''[[(value)]mDocker environment file to check for common issues'$'\e''[[(reset)]m'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if errors occur'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if file is valid'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileIsDocker [ filename ]'$'\n'''$'\n''    filename  Docker environment file to check for common issues'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n'''$'\n''Return codes:'$'\n''- 1 - if errors occur'$'\n''- 0 - if file is valid'
documentationPath="documentation/source/tools/environment.md"
