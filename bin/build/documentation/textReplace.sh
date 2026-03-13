#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-13
# shellcheck disable=SC2034
argument="needle - String. Required. String to replace."$'\n'"replacement - EmptyString.  String to replace needle with."$'\n'"haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input."$'\n'""
base="text.sh"
description="Replace all occurrences of a string within another string"$'\n'""
file="bin/build/tools/text.sh"
fn="textReplace"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Replace all occurrences of a string within another string"$'\n'"Argument: needle - String. Required. String to replace."$'\n'"Argument: replacement - EmptyString.  String to replace needle with."$'\n'"Argument: haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input."$'\n'"stdin: If no haystack supplied reads from standard input and replaces the string on each line read."$'\n'"stdout: New string with needle replaced"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="f0c5212f3e402f51e272ac32015e5e0be9f2581c"
stdin="If no haystack supplied reads from standard input and replaces the string on each line read."$'\n'""
stdout="New string with needle replaced"$'\n'""
summary="Replace all occurrences of a string within another string"
summaryComputed="true"
usage="textReplace needle [ replacement ] [ haystack ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextReplace'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mneedle'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ replacement ]'$'\e''[0m '$'\e''[[(blue)]m[ haystack ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mneedle       '$'\e''[[(value)]mString. Required. String to replace.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mreplacement  '$'\e''[[(value)]mEmptyString.  String to replace needle with.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mhaystack     '$'\e''[[(value)]mEmptyString. Optional. String to modify. If not supplied, reads from standard input.'$'\e''[[(reset)]m'$'\n'''$'\n''Replace all occurrences of a string within another string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''If no haystack supplied reads from standard input and replaces the string on each line read.'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''New string with needle replaced'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: textReplace needle [ replacement ] [ haystack ]'$'\n'''$'\n''    needle       String. Required. String to replace.'$'\n''    replacement  EmptyString.  String to replace needle with.'$'\n''    haystack     EmptyString. Optional. String to modify. If not supplied, reads from standard input.'$'\n'''$'\n''Replace all occurrences of a string within another string'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''If no haystack supplied reads from standard input and replaces the string on each line read.'$'\n'''$'\n''Writes to stdout:'$'\n''New string with needle replaced'$'\n'''
