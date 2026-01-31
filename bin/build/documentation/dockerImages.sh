#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--filter reference - String. Optional. Filter list by reference provided."$'\n'""
base="docker.sh"
description="List docker images which are currently pulled"$'\n'""
file="bin/build/tools/docker.sh"
foundNames=([0]="argument")
rawComment="List docker images which are currently pulled"$'\n'"Argument: --filter reference - String. Optional. Filter list by reference provided."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="40691740f89ab0014548483a77411acc673dbe12"
summary="List docker images which are currently pulled"
summaryComputed="true"
usage="dockerImages [ --filter reference ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerImages'$'\e''[0m '$'\e''[[(blue)]m[ --filter reference ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--filter reference  '$'\e''[[(value)]mString. Optional. Filter list by reference provided.'$'\e''[[(reset)]m'$'\n'''$'\n''List docker images which are currently pulled'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerImages [ --filter reference ]'$'\n'''$'\n''    --filter reference  String. Optional. Filter list by reference provided.'$'\n'''$'\n''List docker images which are currently pulled'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
