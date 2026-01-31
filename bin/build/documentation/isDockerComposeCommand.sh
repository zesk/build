#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="docker-compose.sh"
description="Is this a docker compose command?"$'\n'"Argument: command - String. Required. The command to test."$'\n'"See: dockerComposeCommandList"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Yes, it is."$'\n'"Return Code: 1 - No, it is not."$'\n'""
file="bin/build/tools/docker-compose.sh"
foundNames=()
rawComment="Is this a docker compose command?"$'\n'"Argument: command - String. Required. The command to test."$'\n'"See: dockerComposeCommandList"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Yes, it is."$'\n'"Return Code: 1 - No, it is not."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="d76bbd31ab881ad7554c01ea2d1740afa9a1a92d"
summary="Is this a docker compose command?"
usage="isDockerComposeCommand"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misDockerComposeCommand'$'\e''[0m'$'\n'''$'\n''Is this a docker compose command?'$'\n''Argument: command - String. Required. The command to test.'$'\n''See: dockerComposeCommandList'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - Yes, it is.'$'\n''Return Code: 1 - No, it is not.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isDockerComposeCommand'$'\n'''$'\n''Is this a docker compose command?'$'\n''Argument: command - String. Required. The command to test.'$'\n''See: dockerComposeCommandList'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - Yes, it is.'$'\n''Return Code: 1 - No, it is not.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.476
