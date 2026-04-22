#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
description="List the files which would be included in the docker image"$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerListContext"
foundNames=()
line="89"
lowerFn="dockerlistcontext"
rawComment="List the files which would be included in the docker image"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="7ff1d9ef9d41486d9537ae6db40de4176c5794ab"
sourceLine="89"
summary="List the files which would be included in the docker"
summaryComputed="true"
usage="dockerListContext"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerListContext'$'\e''[0m'$'\n'''$'\n''List the files which would be included in the docker image'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerListContext'$'\n'''$'\n''List the files which would be included in the docker image'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/docker.md"
