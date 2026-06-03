#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-03
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Launch the daemontools daemon\nDo not use this for production\nRun the daemontools root daemon\n\n'
descriptionLineCount="4"
file="bin/build/tools/daemontools.sh"
fn="daemontoolsExecute"
fnMarker="daemontoolsexecute"
foundNames=([0]="argument")
line="290"
rawComment=$'Launch the daemontools daemon\nDo not use this for production\nRun the daemontools root daemon\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="e7272ea2b43766f6539702f962a0e5b92c54b968"
sourceLine="290"
summary="Launch the daemontools daemon"
summaryComputed="true"
usage="daemontoolsExecute [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsExecute'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Launch the daemontools daemon'$'\n''Do not use this for production'$'\n''Run the daemontools root daemon'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsExecute [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Launch the daemontools daemon'$'\n''Do not use this for production'$'\n''Run the daemontools root daemon'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/daemontools.md"
