#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'command - String. Required. The command to test.\n--help - Flag. Optional. Display this help.\n'
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is this a docker compose command?\n\n'
descriptionLineCount="2"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeCommandIsValid"
fnMarker="dockercomposecommandisvalid"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="return_code")
line="126"
rawComment=$'Summary: Validate docker compose subcommands\nIs this a docker compose command?\nArgument: command - String. Required. The command to test.\nSee: dockerComposeCommandList\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - Yes, it is.\nReturn Code: 1 - No, it is not.\n\n'
return_code=$'0 - Yes, it is.\n1 - No, it is not.\n'
see=$'dockerComposeCommandList\n'
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="0e7630785e46a17c77dad4f7fd6017843dcfbc7c"
sourceLine="126"
summary="Validate docker compose subcommands"
summaryComputed=""
usage="dockerComposeCommandIsValid command [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeCommandIsValid'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcommand  '$'\e''[[(value)]mString. Required. The command to test.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is this a docker compose command?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes, it is.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No, it is not.'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeCommandIsValid command [ --help ]'$'\n'''$'\n''    command  String. Required. The command to test.'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Is this a docker compose command?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes, it is.'$'\n''- 1 - No, it is not.'
documentationPath="documentation/source/tools/docker-compose.md"
