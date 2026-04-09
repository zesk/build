#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="searchString - String. Thing to search for."$'\n'"replaceString - String. Thing to replace search string with."$'\n'""
base="text.sh"
description="Replaces the first and only the first occurrence of a pattern in a line with a replacement string."$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
fn="textReplaceFirst"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="216"
lowerFn="textreplacefirst"
rawComment="Replaces the first and only the first occurrence of a pattern in a line with a replacement string."$'\n'"Without arguments, displays help."$'\n'"Argument: searchString - String. Thing to search for."$'\n'"Argument: replaceString - String. Thing to replace search string with."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs modified lines"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="7f4afd0db4aa281d91724f7bdc480865ea6088e9"
sourceLine="216"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines"$'\n'""
summary="Replaces the first and only the first occurrence of a"
summaryComputed="true"
usage="textReplaceFirst [ searchString ] [ replaceString ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextReplaceFirst'$'\e''[0m '$'\e''[[(blue)]m[ searchString ]'$'\e''[0m '$'\e''[[(blue)]m[ replaceString ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]msearchString   '$'\e''[[(value)]mString. Thing to search for.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mreplaceString  '$'\e''[[(value)]mString. Thing to replace search string with.'$'\e''[[(reset)]m'$'\n'''$'\n''Replaces the first and only the first occurrence of a pattern in a line with a replacement string.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Outputs modified lines'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: textReplaceFirst [ searchString ] [ replaceString ]'$'\n'''$'\n''    searchString   String. Thing to search for.'$'\n''    replaceString  String. Thing to replace search string with.'$'\n'''$'\n''Replaces the first and only the first occurrence of a pattern in a line with a replacement string.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to stdout:'$'\n''Outputs modified lines'$'\n'''
documentationPath="documentation/source/tools/text.md"
