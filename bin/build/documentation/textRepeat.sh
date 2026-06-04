#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
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
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextRepeat'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m`count`'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m`text` ..'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]m'$'\e''[[(code)]mcount'$'\e''[[(reset)]m    '$'\e''[[(value)]mUnsignedInteger. Required. Count of times to repeat.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m'$'\e''[[(code)]mtext'$'\e''[[(reset)]m ..  '$'\e''[[(value)]mString. Required. A sequence of characters to repeat.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Repeat a string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    textRepeat 80 ='$'\n''    decorate info Hello world'$'\n''    textRepeat 80 -'
# shellcheck disable=SC2016
helpPlain='Usage: textRepeat `count` `text` .. [ --help ]'$'\n'''$'\n''    count    UnsignedInteger. Required. Count of times to repeat.'$'\n''    text ..  String. Required. A sequence of characters to repeat.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Repeat a string'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    textRepeat 80 ='$'\n''    decorate info Hello world'$'\n''    textRepeat 80 -'
documentationPath="documentation/source/tools/decoration.md"
