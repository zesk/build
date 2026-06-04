#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="string - String. Optional. String to convert to a bash-compatible string."$'\n'""
base="quote.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Converts strings to shell escaped strings. Newlines become another string line."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/quote.sh"
fn="escapeBash"
fnMarker="escapebash"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout")
line="84"
rawComment="Summary: Bash-string escape"$'\n'"Converts strings to shell escaped strings. Newlines become another string line."$'\n'"Argument: string - String. Optional. String to convert to a bash-compatible string."$'\n'"stdin: text - Optional."$'\n'"stdout: bash-compatible string"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceHash="41b7d7acdf58cdf28d010236a6cc47c39bb9d935"
sourceLine="84"
stdin="text - Optional."$'\n'""
stdout="bash-compatible string"$'\n'""
summary="Bash-string escape"
summaryComputed=""
usage="escapeBash [ string ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mescapeBash'$'\e''[0m '$'\e''[[(blue)]m[ string ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mstring  '$'\e''[[(value)]mString. Optional. String to convert to a bash-compatible string.'$'\e''[[(reset)]m'$'\n'''$'\n''Converts strings to shell escaped strings. Newlines become another string line.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text - Optional.'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''bash-compatible string'
# shellcheck disable=SC2016
helpPlain='Usage: escapeBash [ string ]'$'\n'''$'\n''    string  String. Optional. String to convert to a bash-compatible string.'$'\n'''$'\n''Converts strings to shell escaped strings. Newlines become another string line.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text - Optional.'$'\n'''$'\n''Writes to stdout:'$'\n''bash-compatible string'
documentationPath="documentation/source/tools/quote.md"
