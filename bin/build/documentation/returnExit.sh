#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Return code is `exit`\n\n'
descriptionLineCount="2"
file="bin/build/tools/test.sh"
fn="returnExit"
fnMarker="returnexit"
foundNames=([0]="summary" [1]="return_code")
line="1535"
original="returnExit"
rawComment=$'Summary: Exit return code\nReturn code is `exit`\nReturn Code: 120 - Calling function should exit\n\n'
return_code=$'120 - Calling function should exit\n'
sourceFile="bin/build/tools/test.sh"
sourceHash="1643b40c1684bb3bbf723c7097d1aba261079515"
sourceLine="1535"
summary="Exit return code"
summaryComputed=""
usage="returnExit"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnExit'$'\e''[0m'$'\n'''$'\n''Return code is '$'\e''[[(code)]mexit'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m120'$'\e''[[(reset)]m - Calling function should exit'
# shellcheck disable=SC2016
helpPlain='Usage: returnExit'$'\n'''$'\n''Return code is exit'$'\n'''$'\n''Return codes:'$'\n''- 120 - Calling function should exit'
documentationPath="documentation/source/tools/assert.md"
