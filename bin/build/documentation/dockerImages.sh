#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="--filter reference - String. Optional. Filter list by reference provided."$'\n'""
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List docker images which are currently pulled"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerImages"
fnMarker="dockerimages"
foundNames=([0]="argument")
line="220"
rawComment="List docker images which are currently pulled"$'\n'"Argument: --filter reference - String. Optional. Filter list by reference provided."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="6f3f8fa6c2950e3fd4788b26a2e9aabdf728b5a8"
sourceLine="220"
summary="List docker images which are currently pulled"
summaryComputed="true"
usage="dockerImages [ --filter reference ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerImages'$'\e''[0m '$'\e''[[(blue)]m[ --filter reference ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--filter reference  '$'\e''[[(value)]mString. Optional. Filter list by reference provided.'$'\e''[[(reset)]m'$'\n'''$'\n''List docker images which are currently pulled'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: dockerImages [ --filter reference ]'$'\n'''$'\n''    --filter reference  String. Optional. Filter list by reference provided.'$'\n'''$'\n''List docker images which are currently pulled'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/docker.md"
