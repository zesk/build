#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"binary - Executable. Optional. Display where this executable appears in the path."$'\n'""
base="path.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Show the path and where binaries are found"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/path.sh"
fn="pathShow"
fnMarker="pathshow"
foundNames=([0]="argument")
line="113"
rawComment="Show the path and where binaries are found"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: binary - Executable. Optional. Display where this executable appears in the path."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/path.sh"
sourceHash="21f0a5cf2e762f067606fe4d4a3c0e6f7a52a264"
sourceLine="113"
summary="Show the path and where binaries are found"
summaryComputed="true"
usage="pathShow [ --help ] [ binary ]"
