#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="docker-compose.sh"
description="Is docker compose currently running?"$'\n'""
file="bin/build/tools/docker-compose.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Is docker compose currently running?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - Not running"$'\n'"Return Code: 0 - Running"$'\n'""$'\n'""
return_code="1 - Not running"$'\n'"0 - Running"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="68e26c48a5110cd5108db43059198d2e1339a31b"
summary="Is docker compose currently running?"
usage="dockerComposeIsRunning [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeIsRunning'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is docker compose currently running?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Not running'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Running'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mdockerComposeIsRunning [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Is docker compose currently running?'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m1 - Not running'$'\n''- [[(code)]m0 - Running'$'\n'''
# elapsed 2.137
