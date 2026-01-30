#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="name - String. Required. Volume name to delete."$'\n'""
base="docker.sh"
description="Delete a docker volume"$'\n'""
file="bin/build/tools/docker.sh"
rawComment="Delete a docker volume"$'\n'"Argument: name - String. Required. Volume name to delete."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="6bbede2d76586a17b4acfaba444cdd98daaaf3b2"
summary="Delete a docker volume"
usage="dockerVolumeDelete name"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerVolumeDelete'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mname  '$'\e''[[(value)]mString. Required. Volume name to delete.'$'\e''[[(reset)]m'$'\n'''$'\n''Delete a docker volume'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mdockerVolumeDelete [[(bold)]m[[(magenta)]mname'$'\n'''$'\n''    [[(red)]mname  [[(value)]mString. Required. Volume name to delete.'$'\n'''$'\n''Delete a docker volume'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
# elapsed 2.041
