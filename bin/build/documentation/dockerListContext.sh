#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List the files which would be included in the docker image\n\n'
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerListContext"
fnMarker="dockerlistcontext"
foundNames=()
line="94"
original="dockerListContext"
rawComment=$'List the files which would be included in the docker image\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/docker.sh"
sourceHash="48da6da066f0b1087f8801167ef93f762671a923"
sourceLine="94"
summary="List the files which would be included in the docker"
summaryComputed="true"
usage="dockerListContext"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerListContext'$'\e''[0m'$'\n'''$'\n''List the files which would be included in the docker image'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: dockerListContext'$'\n'''$'\n''List the files which would be included in the docker image'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/docker.md"
