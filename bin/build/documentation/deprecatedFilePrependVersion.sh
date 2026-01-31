#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="deprecated-tools.sh"
description="Take a deprecated.txt file and add a comment with the current version number to the top"$'\n'"Argument: target - File. Required. File to update."$'\n'"Argument: version - String. Required. Version to place at the top of the file."$'\n'""
file="bin/build/tools/deprecated-tools.sh"
foundNames=()
rawComment="Take a deprecated.txt file and add a comment with the current version number to the top"$'\n'"Argument: target - File. Required. File to update."$'\n'"Argument: version - String. Required. Version to place at the top of the file."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="f6ff1d0254473f216c6361ebc735edfbb7a60b50"
summary="Take a deprecated.txt file and add a comment with the"
usage="deprecatedFilePrependVersion"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeprecatedFilePrependVersion'$'\e''[0m'$'\n'''$'\n''Take a deprecated.txt file and add a comment with the current version number to the top'$'\n''Argument: target - File. Required. File to update.'$'\n''Argument: version - String. Required. Version to place at the top of the file.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedFilePrependVersion'$'\n'''$'\n''Take a deprecated.txt file and add a comment with the current version number to the top'$'\n''Argument: target - File. Required. File to update.'$'\n''Argument: version - String. Required. Version to place at the top of the file.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.432
