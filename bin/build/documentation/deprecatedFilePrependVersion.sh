#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="target - File. Required. File to update."$'\n'"version - String. Required. Version to place at the top of the file."$'\n'""
base="deprecated-tools.sh"
description="Take a deprecated.txt file and add a comment with the current version number to the top"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedFilePrependVersion"
foundNames=([0]="argument")
rawComment="Take a deprecated.txt file and add a comment with the current version number to the top"$'\n'"Argument: target - File. Required. File to update."$'\n'"Argument: version - String. Required. Version to place at the top of the file."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="77bf8f3ce9a60d43463b21338a93db64ec181cd4"
summary="Take a deprecated.txt file and add a comment with the"
summaryComputed="true"
usage="deprecatedFilePrependVersion target version"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeprecatedFilePrependVersion'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtarget'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mversion'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtarget   '$'\e''[[(value)]mFile. Required. File to update.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mversion  '$'\e''[[(value)]mString. Required. Version to place at the top of the file.'$'\e''[[(reset)]m'$'\n'''$'\n''Take a deprecated.txt file and add a comment with the current version number to the top'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedFilePrependVersion target version'$'\n'''$'\n''    target   File. Required. File to update.'$'\n''    version  String. Required. Version to place at the top of the file.'$'\n'''$'\n''Take a deprecated.txt file and add a comment with the current version number to the top'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
