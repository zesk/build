#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List of docker compose commands\n\n'
descriptionLineCount="2"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeCommandList"
fnMarker="dockercomposecommandlist"
foundNames=([0]="updated" [1]="require_update" [2]="argument")
line="107"
rawComment=$'List of docker compose commands\nUpdated: 2025-04-07\nRequire-Update: 90\nArgument: --help - Flag. Optional. Display this help.\n\n'
require_update=$'90\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="b92e02315c04b81650c815dca874d1ee5d96f43d"
sourceLine="107"
summary="List of docker compose commands"
summaryComputed="true"
updated=$'2025-04-07\n'
usage="dockerComposeCommandList [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeCommandList'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List of docker compose commands'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeCommandList [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List of docker compose commands'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/docker-compose.md"
