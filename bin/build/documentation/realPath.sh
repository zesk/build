#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Find the full, actual path of a file avoiding symlinks or redirection."$'\n'"See: readlink realpath"$'\n'"Without arguments, displays help."$'\n'"Argument: file ... - File. Required. One or more files to \`realpath\`."$'\n'"Requires: executableExists realpath __help usageDocument returnArgument"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Find the full, actual path of a file avoiding symlinks or redirection."$'\n'"See: readlink realpath"$'\n'"Without arguments, displays help."$'\n'"Argument: file ... - File. Required. One or more files to \`realpath\`."$'\n'"Requires: executableExists realpath __help usageDocument returnArgument"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Find the full, actual path of a file avoiding symlinks"
usage="realPath"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mrealPath'$'\e''[0m'$'\n'''$'\n''Find the full, actual path of a file avoiding symlinks or redirection.'$'\n''See: readlink realpath'$'\n''Without arguments, displays help.'$'\n''Argument: file ... - File. Required. One or more files to '$'\e''[[(code)]mrealpath'$'\e''[[(reset)]m.'$'\n''Requires: executableExists realpath __help usageDocument returnArgument'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: realPath'$'\n'''$'\n''Find the full, actual path of a file avoiding symlinks or redirection.'$'\n''See: readlink realpath'$'\n''Without arguments, displays help.'$'\n''Argument: file ... - File. Required. One or more files to realpath.'$'\n''Requires: executableExists realpath __help usageDocument returnArgument'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.496
