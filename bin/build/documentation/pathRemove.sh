#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"path - Requires. String. The path to be removed from the \`PATH\` environment."$'\n'""
base="path.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove a path from the PATH environment variable"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/path.sh"
fn="pathRemove"
fnMarker="pathremove"
foundNames=([0]="argument")
line="12"
rawComment="Remove a path from the PATH environment variable"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: path - Requires. String. The path to be removed from the \`PATH\` environment."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/path.sh"
sourceHash="21f0a5cf2e762f067606fe4d4a3c0e6f7a52a264"
sourceLine="12"
summary="Remove a path from the PATH environment variable"
summaryComputed="true"
usage="pathRemove [ --help ] [ path ]"
