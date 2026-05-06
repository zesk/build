#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="text - EmptyString. Required. Text to quote."$'\n'""
base="quote.sh"
depends="sed"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Quote bash strings for inclusion as single-quoted for eval"$'\n'""$'\n'""
descriptionLineCount="2"
example="    name=\"\$(quoteBashString \"\$name\")\""$'\n'""
file="bin/build/tools/quote.sh"
fn="quoteBashString"
fnMarker="quotebashstring"
foundNames=([0]="argument" [1]="output" [2]="depends" [3]="example")
line="21"
name=""
output="string quoted and appropriate to assign to a value in the shell"$'\n'""
rawComment="Quote bash strings for inclusion as single-quoted for eval"$'\n'"Argument: text - EmptyString. Required. Text to quote."$'\n'"Output: string quoted and appropriate to assign to a value in the shell"$'\n'"Depends: sed"$'\n'"Example:     name=\"\$(quoteBashString \"\$name\")\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceHash="3c095cfee529b43ebd935ef3549c279a5af1427c"
sourceLine="21"
summary="Quote bash strings for inclusion as single-quoted for eval"
summaryComputed="true"
usage="quoteBashString text"
