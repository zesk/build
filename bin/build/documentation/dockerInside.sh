#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker.sh"
argument="none"
base="docker.sh"
checked="2025-07-09"$'\n'""
description="Are we inside a docker container right now?"$'\n'""
exitCode="0"
file="bin/build/tools/docker.sh"
foundNames=([0]="return_code" [1]="todo" [2]="checked")
rawComment="Are we inside a docker container right now?"$'\n'"Return Code: 0 - Yes"$'\n'"Return Code: 1 - No"$'\n'"TODO: This changed 2023 ..."$'\n'"Checked: 2025-07-09"$'\n'"TODO: Write a test to check this date every oh, say, 3 months"$'\n'""$'\n'""
return_code="0 - Yes"$'\n'"1 - No"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceModified="1769184734"
summary="Are we inside a docker container right now?"
todo="This changed 2023 ..."$'\n'"Write a test to check this date every oh, say, 3 months"$'\n'""
usage="dockerInside"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdockerInside'$'\e''[0m'$'\n'''$'\n''Are we inside a docker container right now?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Yes'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - No'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerInside'$'\n'''$'\n''Are we inside a docker container right now?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes'$'\n''- 1 - No'$'\n'''
