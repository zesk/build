#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="filename - Docker environment file to check for common issues"$'\n'""
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileIsDocker"
foundNames=([0]="argument" [1]="return_code")
rawComment="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Argument: filename - Docker environment file to check for common issues"$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
return_code="1 - if errors occur"$'\n'"0 - if file is valid"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="44d3bdc0a06188c7f01c1f2158c260a9f896c151"
summary="Ensure an environment file is compatible with non-quoted docker environment"
summaryComputed="true"
usage="environmentFileIsDocker [ filename ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileIsDocker'$'\e''[0m '$'\e''[[(blue)]m[ filename ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfilename  '$'\e''[[(value)]mDocker environment file to check for common issues'$'\e''[[(reset)]m'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if errors occur'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if file is valid'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileIsDocker [ filename ]'$'\n'''$'\n''    filename  Docker environment file to check for common issues'$'\n'''$'\n''Ensure an environment file is compatible with non-quoted docker environment files'$'\n'''$'\n''Return codes:'$'\n''- 1 - if errors occur'$'\n''- 0 - if file is valid'$'\n'''
