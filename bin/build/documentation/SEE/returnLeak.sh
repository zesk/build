#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Return code is \`leak\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/test.sh"
fn="returnLeak"
fnMarker="returnleak"
foundNames=([0]="summary" [1]="return_code")
line="1518"
rawComment="Summary: Leak return code"$'\n'"Return code is \`leak\`"$'\n'"Return Code: 108"$'\n'""$'\n'""
return_code="108"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="78c7da5cbc1777fd8206d96854e19720ad1957a9"
sourceLine="1518"
summary="Leak return code"
summaryComputed=""
usage="returnLeak"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnLeak'$'\e''[0m'$'\n'''$'\n''Return code is '$'\e''[[(code)]mleak'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- 108'
# shellcheck disable=SC2016
helpPlain='Usage: returnLeak'$'\n'''$'\n''Return code is leak'$'\n'''$'\n''Return codes:'$'\n''- 108'
documentationPath="documentation/source/tools/assert.md"
