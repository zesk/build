#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debug.sh"
description="Stop build debugging if it is enabled"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="see" [1]="requires" [2]="argument")
rawComment="Stop build debugging if it is enabled"$'\n'"See: buildDebugStart"$'\n'"Requires: buildDebugEnabled"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
requires="buildDebugEnabled"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildDebugStart"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="f288b9b3b91991d05bd6676a6b9ef73b9e0296b8"
summary="Stop build debugging if it is enabled"
usage="buildDebugStop [ --help ]"
