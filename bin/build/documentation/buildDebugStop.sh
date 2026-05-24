#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Stop build debugging if it is enabled\n\n'
descriptionLineCount="2"
file="bin/build/tools/debug.sh"
fn="buildDebugStop"
fnMarker="builddebugstop"
foundNames=([0]="see" [1]="requires" [2]="argument")
line="106"
rawComment=$'Stop build debugging if it is enabled\nSee: buildDebugStart\nRequires: buildDebugEnabled\nArgument: --help - Flag. Optional. Display this help.\n\n'
requires=$'buildDebugEnabled\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'buildDebugStart\n'
sourceFile="bin/build/tools/debug.sh"
sourceHash="20094ded2fe440d8caa5368a60b92d19047e793c"
sourceLine="106"
summary="Stop build debugging if it is enabled"
summaryComputed="true"
usage="buildDebugStop [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDebugStop'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Stop build debugging if it is enabled'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: buildDebugStop [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Stop build debugging if it is enabled'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/debug.md"
