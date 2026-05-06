#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"--help - Flag. Optional. Display this help."$'\n'"text - EmptyString. Required. text to convert to uppercase"$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Convert text to uppercase"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringUppercase"
fnMarker="stringuppercase"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
line="889"
rawComment="Convert text to uppercase"$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: text - EmptyString. Required. text to convert to uppercase"$'\n'"stdout: \`String\`. The stringUppercase version of the \`text\`."$'\n'"Requires: tr"$'\n'""$'\n'""
requires="tr"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="889"
stdout="\`String\`. The stringUppercase version of the \`text\`."$'\n'""
summary="Convert text to uppercase"
summaryComputed="true"
usage="stringUppercase [ -- ] [ --help ] text"
