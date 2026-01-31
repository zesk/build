#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="_sugar.sh"
description="Delete files or directories and return the same exit code passed in."$'\n'"Argument: exitCode - Integer. Required. Exit code to return."$'\n'"Argument: item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr."$'\n'"Requires: isUnsignedInteger returnArgument throwEnvironment usageDocument throwArgument __help"$'\n'"Group: Sugar"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=()
rawComment="Delete files or directories and return the same exit code passed in."$'\n'"Argument: exitCode - Integer. Required. Exit code to return."$'\n'"Argument: item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr."$'\n'"Requires: isUnsignedInteger returnArgument throwEnvironment usageDocument throwArgument __help"$'\n'"Group: Sugar"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="Delete files or directories and return the same exit code"
usage="returnClean"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnClean'$'\e''[0m'$'\n'''$'\n''Delete files or directories and return the same exit code passed in.'$'\n''Argument: exitCode - Integer. Required. Exit code to return.'$'\n''Argument: item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr.'$'\n''Requires: isUnsignedInteger returnArgument throwEnvironment usageDocument throwArgument __help'$'\n''Group: Sugar'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnClean'$'\n'''$'\n''Delete files or directories and return the same exit code passed in.'$'\n''Argument: exitCode - Integer. Required. Exit code to return.'$'\n''Argument: item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr.'$'\n''Requires: isUnsignedInteger returnArgument throwEnvironment usageDocument throwArgument __help'$'\n''Group: Sugar'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.546
