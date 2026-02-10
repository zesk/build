#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="text - EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input."$'\n'""
base="text.sh"
description="Length of an unformatted string"$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Length of an unformatted string"$'\n'"Argument: text - EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input."$'\n'"stdin: A file to determine the plain-text length"$'\n'"stdout: \`UnsignedInteger\`. Length of the plain characters in the input arguments."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="fe3f136d59f335809673a5a3a78c67c1bf585bf4"
stdin="A file to determine the plain-text length"$'\n'""
stdout="\`UnsignedInteger\`. Length of the plain characters in the input arguments."$'\n'""
summary="Length of an unformatted string"
summaryComputed="true"
usage="consolePlainLength [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsolePlainLength'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtext  '$'\e''[[(value)]mEmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input.'$'\e''[[(reset)]m'$'\n'''$'\n''Length of an unformatted string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''A file to determine the plain-text length'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n'''$'\e''[[(code)]mUnsignedInteger'$'\e''[[(reset)]m. Length of the plain characters in the input arguments.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consolePlainLength [ text ]'$'\n'''$'\n''    text  EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input.'$'\n'''$'\n''Length of an unformatted string'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''A file to determine the plain-text length'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger. Length of the plain characters in the input arguments.'$'\n'''
