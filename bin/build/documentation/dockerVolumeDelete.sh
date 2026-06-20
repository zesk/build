#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'name - String. Required. Volume name to delete.\n'
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Delete a docker volume\n\n'
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerVolumeDelete"
fnMarker="dockervolumedelete"
foundNames=([0]="argument")
line="315"
original="dockerVolumeDelete"
rawComment=$'Delete a docker volume\nArgument: name - String. Required. Volume name to delete.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/docker.sh"
sourceHash="48da6da066f0b1087f8801167ef93f762671a923"
sourceLine="315"
summary="Delete a docker volume"
summaryComputed="true"
usage="dockerVolumeDelete name"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerVolumeDelete'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mname  '$'\e''[[(value)]mString. Required. Volume name to delete.'$'\e''[[(reset)]m'$'\n'''$'\n''Delete a docker volume'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: dockerVolumeDelete name'$'\n'''$'\n''    name  String. Required. Volume name to delete.'$'\n'''$'\n''Delete a docker volume'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/docker.md"
