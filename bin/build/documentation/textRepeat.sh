#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="\`count\` - UnsignedInteger. Required. Count of times to repeat."$'\n'"\`text\` .. - String. Required. A sequence of characters to repeat."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
description="Repeat a string"$'\n'""
example="    textRepeat 80 ="$'\n'"    decorate info Hello world"$'\n'"    textRepeat 80 -"$'\n'""
file="bin/build/tools/text.sh"
fn="textRepeat"
foundNames=([0]="argument" [1]="example" [2]="summary")
line="1262"
lowerFn="textrepeat"
rawComment="Argument: \`count\` - UnsignedInteger. Required. Count of times to repeat."$'\n'"Argument: \`text\` .. - String. Required. A sequence of characters to repeat."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     textRepeat 80 ="$'\n'"Example:     decorate info Hello world"$'\n'"Example:     textRepeat 80 -"$'\n'"Summary: Repeat a string"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="7f4afd0db4aa281d91724f7bdc480865ea6088e9"
sourceLine="1262"
summary="Repeat a string"$'\n'""
usage="textRepeat \`count\` \`text\` .. [ --help ]"
documentationPath="documentation/source/tools/decoration.md"
