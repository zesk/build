#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="name - String. Required."$'\n'""
base="docker.sh"
description="Does a docker volume exist with name?"$'\n'""
file="bin/build/tools/docker.sh"
rawComment="Does a docker volume exist with name?"$'\n'"Argument: name - String. Required."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="40691740f89ab0014548483a77411acc673dbe12"
summary="Does a docker volume exist with name?"
summaryComputed="true"
usage="dockerVolumeExists name"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerVolumeExists'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mname  '$'\e''[[(value)]mString. Required.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a docker volume exist with name?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mdockerVolumeExists [[(magenta)]mname'$'\n'''$'\n''    [[(red)]mname  String. Required.'$'\n'''$'\n''Does a docker volume exist with name?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
