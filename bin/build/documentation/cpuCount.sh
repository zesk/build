#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
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
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="14"
stdout="PositiveInteger"$'\n'""
summary="Return integer count of CPUs on this system"
summaryComputed=""
usage="cpuCount [ --handler handler ] [ --help ]"
