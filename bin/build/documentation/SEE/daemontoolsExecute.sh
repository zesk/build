#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Launch the daemontools daemon"$'\n'"Do not use this for production"$'\n'"Run the daemontools root daemon"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/daemontools.sh"
fn="daemontoolsExecute"
fnMarker="daemontoolsexecute"
foundNames=([0]="argument")
line="288"
rawComment="Launch the daemontools daemon"$'\n'"Do not use this for production"$'\n'"Run the daemontools root daemon"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="f448dbffaa1f7e767bd20c8f8728f0f9e0597de0"
sourceLine="288"
summary="Launch the daemontools daemon"
summaryComputed="true"
usage="daemontoolsExecute [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsExecute'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Launch the daemontools daemon'$'\n''Do not use this for production'$'\n''Run the daemontools root daemon'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsExecute [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Launch the daemontools daemon'$'\n''Do not use this for production'$'\n''Run the daemontools root daemon'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/daemontools.md"
