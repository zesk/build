#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--bin binary - Executable. Optional. Binary for \`pip\`."$'\n'""
base="python.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Utility to upgrade pip correctly"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/python.sh"
fn="pipUpgrade"
fnMarker="pipupgrade"
foundNames=([0]="argument")
line="48"
rawComment="Utility to upgrade pip correctly"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --bin binary - Executable. Optional. Binary for \`pip\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="c5956e3d32ee75e52908b4d36d8cfde5928066e8"
sourceLine="48"
summary="Utility to upgrade pip correctly"
summaryComputed="true"
usage="pipUpgrade [ --help ] [ --bin binary ]"
