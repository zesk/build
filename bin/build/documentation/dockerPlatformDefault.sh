#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
description="Fetch the default platform for docker"$'\n'""
file="bin/build/tools/docker.sh"
foundNames=([0]="outputs_one_of")
outputs_one_of="\`linux/arm64\`, \`linux/mips64\`, \`linux/amd64\`"$'\n'""
rawComment="Fetch the default platform for docker"$'\n'"Outputs one of: \`linux/arm64\`, \`linux/mips64\`, \`linux/amd64\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="40691740f89ab0014548483a77411acc673dbe12"
summary="Fetch the default platform for docker"
summaryComputed="true"
usage="dockerPlatformDefault"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerPlatformDefault'$'\e''[0m'$'\n'''$'\n''Fetch the default platform for docker'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mdockerPlatformDefault'$'\n'''$'\n''Fetch the default platform for docker'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
