#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Optional. Identical arguments to \`read\` (but includes \`-r\`)"$'\n'""
base="prompt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Prompt the user properly honoring any attached console."$'\n'""$'\n'"Arguments are the same as \`read\`, except:"$'\n'""$'\n'"\`-r\` is implied and does not need to be specified"$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/prompt.sh"
fn="bashUserInput"
fnMarker="bashuserinput"
foundNames=([0]="see" [1]="argument")
line="100"
rawComment="Prompt the user properly honoring any attached console."$'\n'"Arguments are the same as \`read\`, except:"$'\n'"\`-r\` is implied and does not need to be specified"$'\n'"See: read"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: ... - Arguments. Optional. Identical arguments to \`read\` (but includes \`-r\`)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="read"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="b61c792ae723865297730f9775c4f0b5fcba937d"
sourceLine="100"
summary="Prompt the user properly honoring any attached console."
summaryComputed="true"
usage="bashUserInput [ --help ] [ ... ]"
