#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Replace all occurrences of a string within another string"$'\n'"Argument: needle - String. Required. String to replace."$'\n'"Argument: replacement - EmptyString.  String to replace needle with."$'\n'"Argument: haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input."$'\n'"stdin: If no haystack supplied reads from standard input and replaces the string on each line read."$'\n'"stdout: New string with needle replaced"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Replace all occurrences of a string within another string"$'\n'"Argument: needle - String. Required. String to replace."$'\n'"Argument: replacement - EmptyString.  String to replace needle with."$'\n'"Argument: haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input."$'\n'"stdin: If no haystack supplied reads from standard input and replaces the string on each line read."$'\n'"stdout: New string with needle replaced"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Replace all occurrences of a string within another string"
usage="stringReplace"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringReplace'$'\e''[0m'$'\n'''$'\n''Replace all occurrences of a string within another string'$'\n''Argument: needle - String. Required. String to replace.'$'\n''Argument: replacement - EmptyString.  String to replace needle with.'$'\n''Argument: haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input.'$'\n''stdin: If no haystack supplied reads from standard input and replaces the string on each line read.'$'\n''stdout: New string with needle replaced'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: stringReplace'$'\n'''$'\n''Replace all occurrences of a string within another string'$'\n''Argument: needle - String. Required. String to replace.'$'\n''Argument: replacement - EmptyString.  String to replace needle with.'$'\n''Argument: haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input.'$'\n''stdin: If no haystack supplied reads from standard input and replaces the string on each line read.'$'\n''stdout: New string with needle replaced'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 1.003
