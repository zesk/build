#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"--help - Flag. Optional. Display this help."$'\n'"text - EmptyString. Required. Text to convert to stringLowercase"$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Convert text to stringLowercase"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringLowercase"
fnMarker="stringlowercase"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
line="865"
rawComment="Convert text to stringLowercase"$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: text - EmptyString. Required. Text to convert to stringLowercase"$'\n'"stdout: \`String\`. The stringLowercase version of the \`text\`."$'\n'"Requires: tr"$'\n'""$'\n'""
requires="tr"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="865"
stdout="\`String\`. The stringLowercase version of the \`text\`."$'\n'""
summary="Convert text to stringLowercase"
summaryComputed="true"
usage="stringLowercase [ -- ] [ --help ] text"
