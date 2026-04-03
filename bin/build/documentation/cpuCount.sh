#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Return integer count of CPUs on this system"$'\n'""
file="bin/build/tools/platform.sh"
fn="cpuCount"
foundNames=([0]="summary" [1]="stdout" [2]="argument")
rawComment="Summary: Return integer count of CPUs on this system"$'\n'"stdout: PositiveInteger"$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="6c7ce0643697f47fbac426fa33cc605998d45e4b"
stdout="PositiveInteger"$'\n'""
summary="Return integer count of CPUs on this system"$'\n'""
usage="cpuCount [ --handler handler ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcpuCount'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Return integer count of CPUs on this system'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''PositiveInteger'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: cpuCount [ --handler handler ] [ --help ]'$'\n'''$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --help             Flag. Optional. Display this help.'$'\n'''$'\n''Return integer count of CPUs on this system'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''PositiveInteger'$'\n'''
