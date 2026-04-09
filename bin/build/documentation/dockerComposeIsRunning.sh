#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="docker-compose.sh"
description="Is docker compose currently running?"$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeIsRunning"
foundNames=([0]="argument" [1]="return_code")
line="85"
lowerFn="dockercomposeisrunning"
rawComment="Is docker compose currently running?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - Not running"$'\n'"Return Code: 0 - Running"$'\n'""$'\n'""
return_code="1 - Not running"$'\n'"0 - Running"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="a21ed1c073769da3a59ec67f35a55a8a1d7d14ec"
sourceLine="85"
summary="Is docker compose currently running?"
summaryComputed="true"
usage="dockerComposeIsRunning [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeIsRunning'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is docker compose currently running?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Not running'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Running'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeIsRunning [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Is docker compose currently running?'$'\n'''$'\n''Return codes:'$'\n''- 1 - Not running'$'\n''- 0 - Running'$'\n'''
documentationPath="documentation/source/tools/docker-compose.md"
