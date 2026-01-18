#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="alternateChar - String. Optional. Use an alternate character or string output"$'\n'"offset - Integer. Optional.an integer offset to increase or decrease the size of the bar (default is \`0\`)"$'\n'""
base="decoration.sh"
description="Output a bar as wide as the console using the \`=\` symbol."$'\n'""
example="    decorate success \$(echoBar =-)"$'\n'"    decorate success \$(echoBar \"- Success \")"$'\n'"    decorate magenta \$(echoBar +-)"$'\n'""
file="bin/build/tools/decoration.sh"
fn="echoBar"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="consoleColumns"$'\n'""
source="bin/build/tools/decoration.sh"
sourceModified="1768695708"
summary="Output a bar as wide as the console"$'\n'""
usage="echoBar [ alternateChar ] [ offset ]"
