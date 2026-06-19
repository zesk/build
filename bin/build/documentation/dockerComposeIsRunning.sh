#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is docker compose currently running?\n\n'
descriptionLineCount="2"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeIsRunning"
fnMarker="dockercomposeisrunning"
foundNames=([0]="argument" [1]="return_code")
line="85"
rawComment=$'Is docker compose currently running?\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 1 - Not running\nReturn Code: 0 - Running\n\n'
return_code=$'1 - Not running\n0 - Running\n'
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="b92e02315c04b81650c815dca874d1ee5d96f43d"
sourceLine="85"
summary="Is docker compose currently running?"
summaryComputed="true"
usage="dockerComposeIsRunning [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeIsRunning'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is docker compose currently running?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Not running'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Running'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeIsRunning [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Is docker compose currently running?'$'\n'''$'\n''Return codes:'$'\n''- 1 - Not running'$'\n''- 0 - Running'
documentationPath="documentation/source/tools/docker-compose.md"
