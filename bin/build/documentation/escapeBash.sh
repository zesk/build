#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="string - String. Optional. String to convert to a bash-compatible string."$'\n'""
base="quote.sh"
description="Converts strings to shell escaped strings"$'\n'""
file="bin/build/tools/quote.sh"
fn="escapeBash"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Converts strings to shell escaped strings"$'\n'"Argument: string - String. Optional. String to convert to a bash-compatible string."$'\n'"stdin: text - Optional."$'\n'"stdout: bash-compatible string"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceHash="4a4dd20eec875783f639ec3aa86d72a8482d5ab0"
stdin="text - Optional."$'\n'""
stdout="bash-compatible string"$'\n'""
summary="Converts strings to shell escaped strings"
summaryComputed="true"
usage="escapeBash [ string ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mescapeBash'$'\e''[0m '$'\e''[[(blue)]m[ string ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mstring  '$'\e''[[(value)]mString. Optional. String to convert to a bash-compatible string.'$'\e''[[(reset)]m'$'\n'''$'\n''Converts strings to shell escaped strings'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text - Optional.'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''bash-compatible string'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: escapeBash [ string ]'$'\n'''$'\n''    string  String. Optional. String to convert to a bash-compatible string.'$'\n'''$'\n''Converts strings to shell escaped strings'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text - Optional.'$'\n'''$'\n''Writes to stdout:'$'\n''bash-compatible string'$'\n'''
