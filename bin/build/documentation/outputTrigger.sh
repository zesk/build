#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Help"$'\n'"--verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"--name name - String. Optional. Name for verbose mode."$'\n'"message ... - Optional. Optional. Message for verbose mode."$'\n'""
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check output for content and trigger environment error if found"$'\n'""$'\n'""
descriptionLineCount="2"
example="    source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""
file="bin/build/tools/debug.sh"
fn="outputTrigger"
fnMarker="outputtrigger"
foundNames=([0]="argument" [1]="return_code" [2]="stdin" [3]="stdout" [4]="example")
line="506"
rawComment="Check output for content and trigger environment error if found"$'\n'"Argument: --help - Help"$'\n'"Argument: --verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"Argument: --name name - String. Optional. Name for verbose mode."$'\n'"Argument: message ... - Optional. Optional. Message for verbose mode."$'\n'"Return Code: 0 - If no content is read from \`stdin\`"$'\n'"Return Code: 1 - If any content is read from \`stdin\` (and output to \`stdout\`)"$'\n'"Return Code: 2 - Argument error"$'\n'"stdin: Any content"$'\n'"stdout: Same content"$'\n'"Example:     source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""$'\n'""
return_code="0 - If no content is read from \`stdin\`"$'\n'"1 - If any content is read from \`stdin\` (and output to \`stdout\`)"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="20094ded2fe440d8caa5368a60b92d19047e793c"
sourceLine="506"
stdin="Any content"$'\n'""
stdout="Same content"$'\n'""
summary="Check output for content and trigger environment error if found"
summaryComputed="true"
usage="outputTrigger [ --help ] [ --verbose ] [ --name name ] [ message ... ]"
