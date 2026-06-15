#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument="none"
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Return code is \`identical\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/test.sh"
fn="returnIdentical"
fnMarker="returnidentical"
foundNames=([0]="summary" [1]="return_code")
line="1503"
rawComment="Summary: Identical return code"$'\n'"Return code is \`identical\`"$'\n'"Return Code: 105 - The identical check found discrepancies."$'\n'""$'\n'""
return_code="105 - The identical check found discrepancies."$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="1643b40c1684bb3bbf723c7097d1aba261079515"
sourceLine="1503"
summary="Identical return code"
summaryComputed=""
usage="returnIdentical"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnIdentical'$'\e''[0m'$'\n'''$'\n''Return code is '$'\e''[[(code)]midentical'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m105'$'\e''[[(reset)]m - The identical check found discrepancies.'
# shellcheck disable=SC2016
helpPlain='Usage: returnIdentical'$'\n'''$'\n''Return code is identical'$'\n'''$'\n''Return codes:'$'\n''- 105 - The identical check found discrepancies.'
documentationPath="documentation/source/tools/assert.md"
