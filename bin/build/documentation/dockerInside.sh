#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
checked="2025-07-09"$'\n'""
description="Are we inside a docker container right now?"$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerInside"
foundNames=([0]="return_code" [1]="todo" [2]="checked")
rawComment="Are we inside a docker container right now?"$'\n'"Return Code: 0 - Yes"$'\n'"Return Code: 1 - No"$'\n'"TODO: This changed 2023 ..."$'\n'"Checked: 2025-07-09"$'\n'"TODO: Write a test to check this date every oh, say, 3 months"$'\n'""$'\n'""
return_code="0 - Yes"$'\n'"1 - No"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="3c99deb85dc2d26f1fb9b74fdec2057025f22e92"
summary="Are we inside a docker container right now?"
summaryComputed="true"
todo="This changed 2023 ..."$'\n'"Write a test to check this date every oh, say, 3 months"$'\n'""
usage="dockerInside"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerInside'$'\e''[0m'$'\n'''$'\n''Are we inside a docker container right now?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerInside'$'\n'''$'\n''Are we inside a docker container right now?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes'$'\n''- 1 - No'$'\n'''
