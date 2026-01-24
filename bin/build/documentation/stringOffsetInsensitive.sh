#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="needle - String. Required."$'\n'"haystack - String. Required."$'\n'""
base="text.sh"
description="Outputs the integer offset of \`needle\` if found as substring in \`haystack\` (case-insensitive)"$'\n'"If \`haystack\` is not found, -1 is output"$'\n'""
exitCode="0"
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="stdout")
rawComment="Outputs the integer offset of \`needle\` if found as substring in \`haystack\` (case-insensitive)"$'\n'"If \`haystack\` is not found, -1 is output"$'\n'"Argument: needle - String. Required."$'\n'"Argument: haystack - String. Required."$'\n'"stdout: \`Integer\`. The offset at which the \`needle\` was found in \`haystack\`. Outputs -1 if not found."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769226342"
stdout="\`Integer\`. The offset at which the \`needle\` was found in \`haystack\`. Outputs -1 if not found."$'\n'""
summary="Outputs the integer offset of \`needle\` if found as substring"
usage="stringOffsetInsensitive needle haystack"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mstringOffsetInsensitive'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mneedle'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mhaystack'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mneedle    '$'\e''[[value]mString. Required.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mhaystack  '$'\e''[[value]mString. Required.'$'\e''[[reset]m'$'\n'''$'\n''Outputs the integer offset of '$'\e''[[code]mneedle'$'\e''[[reset]m if found as substring in '$'\e''[[code]mhaystack'$'\e''[[reset]m (case-insensitive)'$'\n''If '$'\e''[[code]mhaystack'$'\e''[[reset]m is not found, -1 is output'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n'''$'\e''[[code]mInteger'$'\e''[[reset]m. The offset at which the '$'\e''[[code]mneedle'$'\e''[[reset]m was found in '$'\e''[[code]mhaystack'$'\e''[[reset]m. Outputs -1 if not found.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: stringOffsetInsensitive needle haystack'$'\n'''$'\n''    needle    String. Required.'$'\n''    haystack  String. Required.'$'\n'''$'\n''Outputs the integer offset of needle if found as substring in haystack (case-insensitive)'$'\n''If haystack is not found, -1 is output'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Integer. The offset at which the needle was found in haystack. Outputs -1 if not found.'$'\n'''
