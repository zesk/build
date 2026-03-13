#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
description="Fetch the default platform for docker"$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerPlatformDefault"
foundNames=([0]="outputs_one_of")
outputs_one_of="\`linux/arm64\`, \`linux/mips64\`, \`linux/amd64\`"$'\n'""
rawComment="Fetch the default platform for docker"$'\n'"Outputs one of: \`linux/arm64\`, \`linux/mips64\`, \`linux/amd64\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="51657edc2c4ddde3087728a205decf35b61fd7b4"
summary="Fetch the default platform for docker"
summaryComputed="true"
usage="dockerPlatformDefault"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerPlatformDefault'$'\e''[0m'$'\n'''$'\n''Fetch the default platform for docker'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerPlatformDefault'$'\n'''$'\n''Fetch the default platform for docker'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
