#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'name - String. Required.\n'
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Does a docker volume exist with name?\n\n'
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerVolumeExists"
fnMarker="dockervolumeexists"
foundNames=([0]="argument")
line="302"
rawComment=$'Does a docker volume exist with name?\nArgument: name - String. Required.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/docker.sh"
sourceHash="48da6da066f0b1087f8801167ef93f762671a923"
sourceLine="302"
summary="Does a docker volume exist with name?"
summaryComputed="true"
usage="dockerVolumeExists name"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerVolumeExists'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mname  '$'\e''[[(value)]mString. Required.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a docker volume exist with name?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: dockerVolumeExists name'$'\n'''$'\n''    name  String. Required.'$'\n'''$'\n''Does a docker volume exist with name?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/docker.md"
