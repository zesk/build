#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="exitCode - Integer. Required. Exit code to return."$'\n'"item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr."$'\n'""
base="_sugar.sh"
description="Delete files or directories and return the same exit code passed in."$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnClean"
foundNames=([0]="argument" [1]="requires" [2]="group")
group="Sugar"$'\n'""
rawComment="Delete files or directories and return the same exit code passed in."$'\n'"Argument: exitCode - Integer. Required. Exit code to return."$'\n'"Argument: item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr."$'\n'"Requires: isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument __help"$'\n'"Group: Sugar"$'\n'""$'\n'""
requires="isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="ffd716b7922cb0074e135ce841a832b800ed594b"
summary="Delete files or directories and return the same exit code"
summaryComputed="true"
usage="returnClean exitCode [ item ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnClean'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mexitCode'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ item ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mexitCode  '$'\e''[[(value)]mInteger. Required. Exit code to return.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mitem      '$'\e''[[(value)]mExists. Optional. One or more files or folders to delete, failures are logged to stderr.'$'\e''[[(reset)]m'$'\n'''$'\n''Delete files or directories and return the same exit code passed in.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnClean exitCode [ item ]'$'\n'''$'\n''    exitCode  Integer. Required. Exit code to return.'$'\n''    item      Exists. Optional. One or more files or folders to delete, failures are logged to stderr.'$'\n'''$'\n''Delete files or directories and return the same exit code passed in.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
