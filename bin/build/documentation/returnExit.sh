#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
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
line="1532"
rawComment=$'Summary: Exit return code\nReturn code is `exit`\nReturn Code: 120\n\n'
return_code=$'120\n'
sourceFile="bin/build/tools/test.sh"
sourceHash="74049261be4311898ae206f18f3c43621dd42ffa"
sourceLine="1532"
summary="Exit return code"
summaryComputed=""
usage="returnExit"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnExit'$'\e''[0m'$'\n'''$'\n''Return code is '$'\e''[[(code)]mexit'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- 120'
# shellcheck disable=SC2016
helpPlain='Usage: returnExit'$'\n'''$'\n''Return code is exit'$'\n'''$'\n''Return codes:'$'\n''- 120'
documentationPath="documentation/source/tools/assert.md"
