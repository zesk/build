#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="pcregrep.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="The name of the \`pcregrep\` binary on this operating system"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/pcregrep.sh"
fn="pcregrepBinary"
fnMarker="pcregrepbinary"
foundNames=([0]="argument" [1]="stdout")
line="26"
rawComment="The name of the \`pcregrep\` binary on this operating system"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: String. Name of binary for pcregrep."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/pcregrep.sh"
sourceHash="89d29dfac3e56dd9bcac2772d6772fae8cfbb0d9"
sourceLine="26"
stdout="String. Name of binary for pcregrep."$'\n'""
summary="The name of the \`pcregrep\` binary on this operating system"
summaryComputed="true"
usage="pcregrepBinary [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpcregrepBinary'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''The name of the '$'\e''[[(code)]mpcregrep'$'\e''[[(reset)]m binary on this operating system'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''String. Name of binary for pcregrep.'
# shellcheck disable=SC2016
helpPlain='Usage: pcregrepBinary [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''The name of the pcregrep binary on this operating system'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String. Name of binary for pcregrep.'
documentationPath="documentation/source/tools/pcregrep.md"
