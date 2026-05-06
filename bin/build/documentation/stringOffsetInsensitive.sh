#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="needle - String. Required."$'\n'"haystack - String. Required."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs the integer offset of \`needle\` if found as substring in \`haystack\` (case-insensitive)"$'\n'"If \`haystack\` is not found, -1 is output"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="stringOffsetInsensitive"
fnMarker="stringoffsetinsensitive"
foundNames=([0]="argument" [1]="stdout")
line="1085"
rawComment="Outputs the integer offset of \`needle\` if found as substring in \`haystack\` (case-insensitive)"$'\n'"If \`haystack\` is not found, -1 is output"$'\n'"Argument: needle - String. Required."$'\n'"Argument: haystack - String. Required."$'\n'"stdout: \`Integer\`. The offset at which the \`needle\` was found in \`haystack\`. Outputs -1 if not found."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="1085"
stdout="\`Integer\`. The offset at which the \`needle\` was found in \`haystack\`. Outputs -1 if not found."$'\n'""
summary="Outputs the integer offset of \`needle\` if found as substring"
summaryComputed="true"
usage="stringOffsetInsensitive needle haystack"
