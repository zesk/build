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
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashUserInput'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mArguments. Optional. Identical arguments to '$'\e''[[(code)]mread'$'\e''[[(reset)]m (but includes '$'\e''[[(code)]m-r'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n'''$'\n''Prompt the user properly honoring any attached console.'$'\n'''$'\n''Arguments are the same as '$'\e''[[(code)]mread'$'\e''[[(reset)]m, except:'$'\n'''$'\n'''$'\e''[[(code)]m-r'$'\e''[[(reset)]m is implied and does not need to be specified'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashUserInput [ --help ] [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    ...     Arguments. Optional. Identical arguments to read (but includes -r)'$'\n'''$'\n''Prompt the user properly honoring any attached console.'$'\n'''$'\n''Arguments are the same as read, except:'$'\n'''$'\n''-r is implied and does not need to be specified'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
