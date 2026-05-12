#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'`count` - UnsignedInteger. Required. Count of times to repeat.\n`text` .. - String. Required. A sequence of characters to repeat.\n--help - Flag. Optional. Display this help.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Repeat a string"
descriptionLineCount=""
example=$'    textRepeat 80 =\n    decorate info Hello world\n    textRepeat 80 -\n'
file="bin/build/tools/text.sh"
fn="textRepeat"
fnMarker="textrepeat"
foundNames=([0]="argument" [1]="example" [2]="summary")
line="1309"
rawComment=$'Argument: `count` - UnsignedInteger. Required. Count of times to repeat.\nArgument: `text` .. - String. Required. A sequence of characters to repeat.\nArgument: --help - Flag. Optional. Display this help.\nExample:     textRepeat 80 =\nExample:     decorate info Hello world\nExample:     textRepeat 80 -\nSummary: Repeat a string\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1309"
summary="Repeat a string"
summaryComputed=""
usage="textRepeat \`count\` \`text\` .. [ --help ]"
