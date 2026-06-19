#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Stop bash debugging if it is enabled."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/debug.sh"
fn="buildDebugStop"
fnMarker="builddebugstop"
foundNames=([0]="summary" [1]="see" [2]="requires" [3]="argument" [4]="return_code")
line="116"
rawComment="Summary: Stop bash debugging"$'\n'"Stop bash debugging if it is enabled."$'\n'"See: buildDebugStart"$'\n'"Requires: buildDebugEnabled"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - bash debugging was stopped"$'\n'"Return Code: 1 - bash debugging was not stopped because token did not match."$'\n'""$'\n'""
requires="buildDebugEnabled"$'\n'""
return_code="0 - bash debugging was stopped"$'\n'"1 - bash debugging was not stopped because token did not match."$'\n'""
see="buildDebugStart"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="6a81e40ae02c7a2796eae34880ff8f69d143fa24"
sourceLine="116"
summary="Stop bash debugging"
summaryComputed=""
usage="buildDebugStop [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDebugStop'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Stop bash debugging if it is enabled.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - bash debugging was stopped'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - bash debugging was not stopped because token did not match.'
# shellcheck disable=SC2016
helpPlain='Usage: buildDebugStop [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Stop bash debugging if it is enabled.'$'\n'''$'\n''Return codes:'$'\n''- 0 - bash debugging was stopped'$'\n''- 1 - bash debugging was not stopped because token did not match.'
documentationPath="documentation/source/tools/debug.md"
