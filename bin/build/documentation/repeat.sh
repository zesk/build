#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="\`count\` - Required, integer count of times to repeat"$'\n'"\`string\` - A sequence of characters to repeat"$'\n'"... - Additional arguments are output using shell expansion of \`\$*\`"$'\n'""
base="decoration.sh"
description="Repeat a string"$'\n'""
example="    repeat 80 ="$'\n'"    decorate info Hello world"$'\n'"    repeat 80 -"$'\n'""
file="bin/build/tools/decoration.sh"
fn="repeat"
foundNames=([0]="argument" [1]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/decoration.sh"
sourceModified="1768683999"
summary="Repeat a string"
usage="repeat [ \`count\` ] [ \`string\` ] [ ... ]"
