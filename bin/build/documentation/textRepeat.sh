#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="\`count\` - UnsignedInteger. Required. Count of times to repeat."$'\n'"\`text\` .. - String. Required. A sequence of characters to repeat."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Repeat a string"
descriptionLineCount=""
example="    textRepeat 80 ="$'\n'"    decorate info Hello world"$'\n'"    textRepeat 80 -"$'\n'""
file="bin/build/tools/text.sh"
fn="textRepeat"
fnMarker="textrepeat"
foundNames=([0]="argument" [1]="example" [2]="summary")
line="1302"
rawComment="Argument: \`count\` - UnsignedInteger. Required. Count of times to repeat."$'\n'"Argument: \`text\` .. - String. Required. A sequence of characters to repeat."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     textRepeat 80 ="$'\n'"Example:     decorate info Hello world"$'\n'"Example:     textRepeat 80 -"$'\n'"Summary: Repeat a string"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="1302"
summary="Repeat a string"
summaryComputed=""
usage="textRepeat \`count\` \`text\` .. [ --help ]"
