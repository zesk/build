#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
checked=$'2026-06-04\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Are we inside a docker container right now?\n\nDoes a standard test to determine if we\'re inside Docker or not.\n\n'
descriptionLineCount="4"
file="bin/build/tools/docker.sh"
fn="dockerInside"
fnMarker="dockerinside"
foundNames=([0]="summary" [1]="file" [2]="return_code" [3]="checked" [4]="todo")
line="74"
original="dockerInside"
rawComment=$'Summary: Are we inside a docker container?\nAre we inside a docker container right now?\nDoes a standard test to determine if we\'re inside Docker or not.\nFile: /proc/1/cmdline\nReturn Code: 0 - Yes\nReturn Code: 1 - No\nChecked: 2026-06-04\nTODO: Write a test to check this date every oh, say, 3 months\n\n'
return_code=$'0 - Yes\n1 - No\n'
sourceFile="bin/build/tools/docker.sh"
sourceHash="48da6da066f0b1087f8801167ef93f762671a923"
sourceLine="74"
summary="Are we inside a docker container?"
summaryComputed=""
todo=$'Write a test to check this date every oh, say, 3 months\n'
usage="dockerInside"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerInside'$'\e''[0m'$'\n'''$'\n''Are we inside a docker container right now?'$'\n'''$'\n''Does a standard test to determine if we'\''re inside Docker or not.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No'
# shellcheck disable=SC2016
helpPlain='Usage: dockerInside'$'\n'''$'\n''Are we inside a docker container right now?'$'\n'''$'\n''Does a standard test to determine if we'\''re inside Docker or not.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes'$'\n''- 1 - No'
documentationPath="documentation/source/tools/docker.md"
