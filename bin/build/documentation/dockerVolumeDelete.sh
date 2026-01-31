#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
description="Delete a docker volume"$'\n'"Argument: name - String. Required. Volume name to delete."$'\n'""
file="bin/build/tools/docker.sh"
foundNames=()
rawComment="Delete a docker volume"$'\n'"Argument: name - String. Required. Volume name to delete."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="6bbede2d76586a17b4acfaba444cdd98daaaf3b2"
summary="Delete a docker volume"
usage="dockerVolumeDelete"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerVolumeDelete'$'\e''[0m'$'\n'''$'\n''Delete a docker volume'$'\n''Argument: name - String. Required. Volume name to delete.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerVolumeDelete'$'\n'''$'\n''Delete a docker volume'$'\n''Argument: name - String. Required. Volume name to delete.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.466
