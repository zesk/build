#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Return code is \`assert\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/test.sh"
fn="returnAssert"
fnMarker="returnassert"
foundNames=([0]="summary" [1]="return_code")
line="1488"
rawComment="Return code is \`assert\`"$'\n'"Summary: Assertion return code"$'\n'"Return Code: 97"$'\n'""$'\n'""
return_code="97"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="78c7da5cbc1777fd8206d96854e19720ad1957a9"
sourceLine="1488"
summary="Assertion return code"
summaryComputed=""
usage="returnAssert"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnAssert'$'\e''[0m'$'\n'''$'\n''Return code is '$'\e''[[(code)]massert'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- 97'
# shellcheck disable=SC2016
helpPlain='Usage: returnAssert'$'\n'''$'\n''Return code is assert'$'\n'''$'\n''Return codes:'$'\n''- 97'
documentationPath="documentation/source/tools/assert.md"
