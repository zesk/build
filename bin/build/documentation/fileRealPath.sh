#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-16
# shellcheck disable=SC2034
argument="file ... - File. Required. One or more files to \`realpath\`."$'\n'""
base="file.sh"
description="Find the full, actual path of a file avoiding symlinks or redirection."$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/file.sh"
fn="fileRealPath"
foundNames=([0]="see" [1]="argument" [2]="requires")
rawComment="Find the full, actual path of a file avoiding symlinks or redirection."$'\n'"See: readlink realpath"$'\n'"Without arguments, displays help."$'\n'"Argument: file ... - File. Required. One or more files to \`realpath\`."$'\n'"Requires: executableExists realpath __help usageDocument returnArgument"$'\n'""$'\n'""
requires="executableExists realpath __help usageDocument returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="readlink realpath"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="4c703f3426449dd0f9b510eb709d61a9f87e17cb"
summary="Find the full, actual path of a file avoiding symlinks"
summaryComputed="true"
usage="fileRealPath file ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileRealPath'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. One or more files to '$'\e''[[(code)]mrealpath'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Find the full, actual path of a file avoiding symlinks or redirection.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileRealPath file ...'$'\n'''$'\n''    file ...  File. Required. One or more files to realpath.'$'\n'''$'\n''Find the full, actual path of a file avoiding symlinks or redirection.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
