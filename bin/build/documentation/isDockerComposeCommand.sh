#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="command - String. Required. The command to test."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="docker-compose.sh"
description="Is this a docker compose command?"$'\n'""
file="bin/build/tools/docker-compose.sh"
foundNames=([0]="argument" [1]="see" [2]="return_code")
rawComment="Is this a docker compose command?"$'\n'"Argument: command - String. Required. The command to test."$'\n'"See: dockerComposeCommandList"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Yes, it is."$'\n'"Return Code: 1 - No, it is not."$'\n'""$'\n'""
return_code="0 - Yes, it is."$'\n'"1 - No, it is not."$'\n'""
see="dockerComposeCommandList"$'\n'""
sourceHash="d76bbd31ab881ad7554c01ea2d1740afa9a1a92d"
summary="Is this a docker compose command?"
usage="isDockerComposeCommand command [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misDockerComposeCommand'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcommand  '$'\e''[[(value)]mString. Required. The command to test.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is this a docker compose command?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes, it is.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No, it is not.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isDockerComposeCommand command [ --help ]'$'\n'''$'\n''    command  String. Required. The command to test.'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Is this a docker compose command?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes, it is.'$'\n''- 1 - No, it is not.'$'\n'''
# elapsed 0.583
