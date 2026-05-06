#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
checked="2025-07-09"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Are we inside a docker container right now?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerInside"
fnMarker="dockerinside"
foundNames=([0]="return_code" [1]="todo" [2]="checked")
line="69"
rawComment="Are we inside a docker container right now?"$'\n'"Return Code: 0 - Yes"$'\n'"Return Code: 1 - No"$'\n'"TODO: This changed 2023 ..."$'\n'"Checked: 2025-07-09"$'\n'"TODO: Write a test to check this date every oh, say, 3 months"$'\n'""$'\n'""
return_code="0 - Yes"$'\n'"1 - No"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="7ff1d9ef9d41486d9537ae6db40de4176c5794ab"
sourceLine="69"
summary="Are we inside a docker container right now?"
summaryComputed="true"
todo="This changed 2023 ..."$'\n'"Write a test to check this date every oh, say, 3 months"$'\n'""
usage="dockerInside"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerInside'$'\e''[0m'$'\n'''$'\n''Are we inside a docker container right now?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No'
# shellcheck disable=SC2016
helpPlain='Usage: dockerInside'$'\n'''$'\n''Are we inside a docker container right now?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes'$'\n''- 1 - No'
documentationPath="documentation/source/tools/docker.md"
