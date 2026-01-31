#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="pcregrep.sh"
description="The name of the \`pcregrep\` binary on this operating system"$'\n'""
file="bin/build/tools/pcregrep.sh"
foundNames=([0]="argument" [1]="stdout")
rawComment="The name of the \`pcregrep\` binary on this operating system"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: String. Name of binary for pcregrep."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/pcregrep.sh"
sourceHash="aad9430c1fb4f4670a2370a1c3a891b5ece7e6fb"
stdout="String. Name of binary for pcregrep."$'\n'""
summary="The name of the \`pcregrep\` binary on this operating system"
summaryComputed="true"
usage="pcregrepBinary [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpcregrepBinary'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''The name of the '$'\e''[[(code)]mpcregrep'$'\e''[[(reset)]m binary on this operating system'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''String. Name of binary for pcregrep.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mpcregrepBinary [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  Flag. Optional. Display this help.'$'\n'''$'\n''The name of the pcregrep binary on this operating system'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String. Name of binary for pcregrep.'$'\n'''
