#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Return code is `leak`\n\n'
descriptionLineCount="2"
file="bin/build/tools/test.sh"
fn="returnLeak"
fnMarker="returnleak"
foundNames=([0]="summary" [1]="return_code")
line="1519"
original="returnLeak"
rawComment=$'Summary: Leak return code\nReturn code is `leak`\nReturn Code: 108 - A leak was detected in the command\n\n'
return_code=$'108 - A leak was detected in the command\n'
sourceFile="bin/build/tools/test.sh"
sourceHash="1643b40c1684bb3bbf723c7097d1aba261079515"
sourceLine="1519"
summary="Leak return code"
summaryComputed=""
usage="returnLeak"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnLeak'$'\e''[0m'$'\n'''$'\n''Return code is '$'\e''[[(code)]mleak'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m108'$'\e''[[(reset)]m - A leak was detected in the command'
# shellcheck disable=SC2016
helpPlain='Usage: returnLeak'$'\n'''$'\n''Return code is leak'$'\n'''$'\n''Return codes:'$'\n''- 108 - A leak was detected in the command'
documentationPath="documentation/source/tools/assert.md"
