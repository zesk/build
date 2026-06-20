#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Fetch the default platform for docker\n\n'
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerPlatformDefault"
fnMarker="dockerplatformdefault"
foundNames=([0]="outputs_one_of")
line="25"
original="dockerPlatformDefault"
outputs_one_of=$'`linux/arm64`, `linux/mips64`, `linux/amd64`\n'
rawComment=$'Fetch the default platform for docker\nOutputs one of: `linux/arm64`, `linux/mips64`, `linux/amd64`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/docker.sh"
sourceHash="48da6da066f0b1087f8801167ef93f762671a923"
sourceLine="25"
summary="Fetch the default platform for docker"
summaryComputed="true"
usage="dockerPlatformDefault"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerPlatformDefault'$'\e''[0m'$'\n'''$'\n''Fetch the default platform for docker'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: dockerPlatformDefault'$'\n'''$'\n''Fetch the default platform for docker'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/docker.md"
