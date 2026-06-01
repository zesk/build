#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument="--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Return integer count of CPUs on this system"
descriptionLineCount=""
file="bin/build/tools/platform.sh"
fn="cpuCount"
fnMarker="cpucount"
foundNames=([0]="summary" [1]="stdout" [2]="argument")
line="14"
rawComment="Summary: Return integer count of CPUs on this system"$'\n'"stdout: PositiveInteger"$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="1d635d1bdc5db7d6b439cb90eb034f236822dd22"
sourceLine="14"
stdout="PositiveInteger"$'\n'""
summary="Return integer count of CPUs on this system"
summaryComputed=""
usage="cpuCount [ --handler handler ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcpuCount'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Return integer count of CPUs on this system'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''PositiveInteger'
# shellcheck disable=SC2016
helpPlain='Usage: cpuCount [ --handler handler ] [ --help ]'$'\n'''$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --help             Flag. Optional. Display this help.'$'\n'''$'\n''Return integer count of CPUs on this system'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''PositiveInteger'
documentationPath="documentation/source/tools/cpu.md"
