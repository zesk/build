#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="alternateChar - String. Optional. Use an alternate character or string output"$'\n'"offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is \`0\`)"$'\n'""
base="line.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output a bar as wide as the console using the \`=\` symbol."$'\n'""$'\n'""
descriptionLineCount="2"
example="    decorate success \$(consoleLine =-)"$'\n'"    decorate success \$(consoleLine \"- Success \")"$'\n'"    decorate magenta \$(consoleLine +-)"$'\n'""
file="bin/build/tools/decorate/line.sh"
fn="consoleLine"
fnMarker="consoleline"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="example")
line="14"
rawComment="Summary: Output a bar as wide as the console"$'\n'"Output a bar as wide as the console using the \`=\` symbol."$'\n'"Argument: alternateChar - String. Optional. Use an alternate character or string output"$'\n'"Argument: offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is \`0\`)"$'\n'"See: consoleColumns"$'\n'"Example:     decorate success \$(consoleLine =-)"$'\n'"Example:     decorate success \$(consoleLine \"- Success \")"$'\n'"Example:     decorate magenta \$(consoleLine +-)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="consoleColumns"$'\n'""
sourceFile="bin/build/tools/decorate/line.sh"
sourceHash="0f11ed0e19d9ca6840a81fdf07b6a1e8ab19a4c1"
sourceLine="14"
summary="Output a bar as wide as the console"
summaryComputed=""
usage="consoleLine [ alternateChar ] [ offset ]"
