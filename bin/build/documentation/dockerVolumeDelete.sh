#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker.sh"
argument="name - String. Required. Volume name to delete."$'\n'""
base="docker.sh"
description="Delete a docker volume"$'\n'""
exitCode="0"
file="bin/build/tools/docker.sh"
foundNames=([0]="argument")
rawComment="Delete a docker volume"$'\n'"Argument: name - String. Required. Volume name to delete."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184734"
summary="Delete a docker volume"
usage="dockerVolumeDelete name"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdockerVolumeDelete'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mname'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mname  '$'\e''[[value]mString. Required. Volume name to delete.'$'\e''[[reset]m'$'\n'''$'\n''Delete a docker volume'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerVolumeDelete name'$'\n'''$'\n''    name  String. Required. Volume name to delete.'$'\n'''$'\n''Delete a docker volume'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
