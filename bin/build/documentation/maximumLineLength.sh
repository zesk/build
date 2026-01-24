#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="none"
base="text.sh"
description="Outputs the maximum line length passed into stdin"$'\n'""
exitCode="0"
file="bin/build/tools/text.sh"
foundNames=([0]="stdin" [1]="stdout")
rawComment="Outputs the maximum line length passed into stdin"$'\n'"stdin: Lines are read from standard in and line length is computed for each line"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769201188"
stdin="Lines are read from standard in and line length is computed for each line"$'\n'""
stdout="\`UnsignedInteger\`"$'\n'""
summary="Outputs the maximum line length passed into stdin"
usage="maximumLineLength"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mmaximumLineLength'$'\e''[0m'$'\n'''$'\n''Outputs the maximum line length passed into stdin'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''Lines are read from standard in and line length is computed for each line'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n'''$'\e''[[code]mUnsignedInteger'$'\e''[[reset]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: maximumLineLength'$'\n'''$'\n''Outputs the maximum line length passed into stdin'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Lines are read from standard in and line length is computed for each line'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger'$'\n'''
